
#pragma once

#include <AzCore/Component/Component.h>

#include <CowboyKao/CowboyKaoBus.h>

namespace CowboyKao
{
    class CowboyKaoSystemComponent
        : public AZ::Component
        , protected CowboyKaoRequestBus::Handler
    {
    public:
        AZ_COMPONENT(CowboyKaoSystemComponent, "{93b915a9-481e-4462-bc4b-06118978a241}");

        static void Reflect(AZ::ReflectContext* context);

        static void GetProvidedServices(AZ::ComponentDescriptor::DependencyArrayType& provided);
        static void GetIncompatibleServices(AZ::ComponentDescriptor::DependencyArrayType& incompatible);
        static void GetRequiredServices(AZ::ComponentDescriptor::DependencyArrayType& required);
        static void GetDependentServices(AZ::ComponentDescriptor::DependencyArrayType& dependent);

        CowboyKaoSystemComponent();
        ~CowboyKaoSystemComponent();

    protected:
        ////////////////////////////////////////////////////////////////////////
        // CowboyKaoRequestBus interface implementation

        ////////////////////////////////////////////////////////////////////////

        ////////////////////////////////////////////////////////////////////////
        // AZ::Component interface implementation
        void Init() override;
        void Activate() override;
        void Deactivate() override;
        ////////////////////////////////////////////////////////////////////////
    };
}
