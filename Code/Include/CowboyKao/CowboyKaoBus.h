
#pragma once

#include <AzCore/EBus/EBus.h>
#include <AzCore/Interface/Interface.h>

namespace CowboyKao
{
    class CowboyKaoRequests
    {
    public:
        AZ_RTTI(CowboyKaoRequests, "{4ad8c2e6-4bbf-48cb-9c3d-78d80f1c81ce}");
        virtual ~CowboyKaoRequests() = default;
        // Put your public methods here
    };
    
    class CowboyKaoBusTraits
        : public AZ::EBusTraits
    {
    public:
        //////////////////////////////////////////////////////////////////////////
        // EBusTraits overrides
        static constexpr AZ::EBusHandlerPolicy HandlerPolicy = AZ::EBusHandlerPolicy::Single;
        static constexpr AZ::EBusAddressPolicy AddressPolicy = AZ::EBusAddressPolicy::Single;
        //////////////////////////////////////////////////////////////////////////
    };

    using CowboyKaoRequestBus = AZ::EBus<CowboyKaoRequests, CowboyKaoBusTraits>;
    using CowboyKaoInterface = AZ::Interface<CowboyKaoRequests>;

} // namespace CowboyKao
