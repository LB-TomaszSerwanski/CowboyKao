
#include <AzCore/Memory/SystemAllocator.h>
#include <AzCore/Module/Module.h>

#include "CowboyKaoSystemComponent.h"

namespace CowboyKao
{
    class CowboyKaoModule
        : public AZ::Module
    {
    public:
        AZ_RTTI(CowboyKaoModule, "{d76204a1-0e07-45a8-bc65-495987b87c6c}", AZ::Module);
        AZ_CLASS_ALLOCATOR(CowboyKaoModule, AZ::SystemAllocator, 0);

        CowboyKaoModule()
            : AZ::Module()
        {
            // Push results of [MyComponent]::CreateDescriptor() into m_descriptors here.
            m_descriptors.insert(m_descriptors.end(), {
                CowboyKaoSystemComponent::CreateDescriptor(),
            });
        }

        /**
         * Add required SystemComponents to the SystemEntity.
         */
        AZ::ComponentTypeList GetRequiredSystemComponents() const override
        {
            return AZ::ComponentTypeList{
                azrtti_typeid<CowboyKaoSystemComponent>(),
            };
        }
    };
}// namespace CowboyKao

AZ_DECLARE_MODULE_CLASS(Gem_CowboyKao, CowboyKao::CowboyKaoModule)
