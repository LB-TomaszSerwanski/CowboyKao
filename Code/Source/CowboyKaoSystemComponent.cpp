
#include <AzCore/Serialization/SerializeContext.h>
#include <AzCore/Serialization/EditContext.h>
#include <AzCore/Serialization/EditContextConstants.inl>

#include "CowboyKaoSystemComponent.h"

namespace CowboyKao
{
    void CowboyKaoSystemComponent::Reflect(AZ::ReflectContext* context)
    {
        if (AZ::SerializeContext* serialize = azrtti_cast<AZ::SerializeContext*>(context))
        {
            serialize->Class<CowboyKaoSystemComponent, AZ::Component>()
                ->Version(0)
                ;

            if (AZ::EditContext* ec = serialize->GetEditContext())
            {
                ec->Class<CowboyKaoSystemComponent>("CowboyKao", "[Description of functionality provided by this System Component]")
                    ->ClassElement(AZ::Edit::ClassElements::EditorData, "")
                        ->Attribute(AZ::Edit::Attributes::AppearsInAddComponentMenu, AZ_CRC("System"))
                        ->Attribute(AZ::Edit::Attributes::AutoExpand, true)
                    ;
            }
        }
    }

    void CowboyKaoSystemComponent::GetProvidedServices(AZ::ComponentDescriptor::DependencyArrayType& provided)
    {
        provided.push_back(AZ_CRC("CowboyKaoService"));
    }

    void CowboyKaoSystemComponent::GetIncompatibleServices(AZ::ComponentDescriptor::DependencyArrayType& incompatible)
    {
        incompatible.push_back(AZ_CRC("CowboyKaoService"));
    }

    void CowboyKaoSystemComponent::GetRequiredServices([[maybe_unused]] AZ::ComponentDescriptor::DependencyArrayType& required)
    {
    }

    void CowboyKaoSystemComponent::GetDependentServices([[maybe_unused]] AZ::ComponentDescriptor::DependencyArrayType& dependent)
    {
    }
    
    CowboyKaoSystemComponent::CowboyKaoSystemComponent()
    {
        if (CowboyKaoInterface::Get() == nullptr)
        {
            CowboyKaoInterface::Register(this);
        }
    }

    CowboyKaoSystemComponent::~CowboyKaoSystemComponent()
    {
        if (CowboyKaoInterface::Get() == this)
        {
            CowboyKaoInterface::Unregister(this);
        }
    }

    void CowboyKaoSystemComponent::Init()
    {
    }

    void CowboyKaoSystemComponent::Activate()
    {
        CowboyKaoRequestBus::Handler::BusConnect();
    }

    void CowboyKaoSystemComponent::Deactivate()
    {
        CowboyKaoRequestBus::Handler::BusDisconnect();
    }
}
