Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74138D6AA;
	Tue, 17 Mar 2026 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732364; cv=none; b=Y+iiaA8CChYIk19oHSJ9qnMq51Kin6mNjcyzNRF9aGGBOZmGNS/9Mpr6bxhUNPOoC4XmhtRZwnnezROSxZAataI5FVptqJ/F4/PbxucKLXKlEKH9TvFGmM7hdPNUuyDY2e0stsyQC2gERk2kxsUPtV6py4SkvYKSen0IhXRtTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732364; c=relaxed/simple;
	bh=KMKAdvpD2asi94LOZ7jH4G+VPl2+Iliqwp2bhPbfUxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9vBnkJXvsxW1q3CAzA0z73mrvNJJmZSk4vqoHCwEIGkOMksWfXgoaPN0NMAKNuA0n4pECjJwvFYEx0ndavCelqj4HVx5dAAPgdyoaSsLwwkPgfgzNDD32DtSdXj5AdmVo+BXEoO5ZsdTNFVoWa0Rjia/DcVA4isxqmON5jXLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpXz/bV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpXz/bV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39822C4CEF7;
	Tue, 17 Mar 2026 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773732363;
	bh=KMKAdvpD2asi94LOZ7jH4G+VPl2+Iliqwp2bhPbfUxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpXz/bV4SdPFXXSpUQ05WRbcGKDUCY/81Laisbg4J3SllB96Cfg7GHRiV2025+ZYZ
	 2y/yz1dgkT9xuXBNbevh1QEGyoX3C+cpFxuAhw4iNZnbDpdv6wP9bX4ldb76HMbskn
	 pL/RhwY5WdLC4ElRsjBmvbjA01o2WhxA7XyjtbBUDjUfk4QmQc8uP1iDk6u0ZJ561P
	 IVRurwb9po8NDG5e2ndDxn6DGDVpkzZCd1+xEB/p8n56YFD6vClOxDSCxiGnj31If+
	 gtYwj6XEvwFyU7wo7W34/r/veDTz84QPc65ghTuk83N7Uj6dzOzG6zBzFFjqGOnf7X
	 cBCVQ69c9GkZA==
Date: Tue, 17 Mar 2026 08:26:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	naseefkm@gmail.com, ryder.lee@mediatek.com, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: mediatek: Add support for
 EcoNet EN7528
Message-ID: <20260317-feathered-cyber-snake-eb72fa@quoll>
References: <20260316155157.679533-1-cjd@cjdns.fr>
 <20260316155157.679533-2-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316155157.679533-2-cjd@cjdns.fr>

On Mon, Mar 16, 2026 at 03:51:55PM +0000, Caleb James DeLisle wrote:
>  
>          mediatek,pbus-csr: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: econet,en7528-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          maxItems: 1
> +
> +        reset: false
> +
> +        reset-names: false
> +
> +        power-domain: false

Wrong property.

> +
> +        mediatek,pbus-csr: false
> +
> +      required:
> +        - phys
> +        - phy-names
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -436,3 +462,59 @@ examples:
>              };
>          };
>      };
> +
> +  # EN7528
> +  - |
> +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> +    #include <dt-bindings/clock/en7523-clk.h>
> +    #include <dt-bindings/reset/airoha,en7523-reset.h>
> +
> +    soc_3 {

soc

Underscores are not allowed, but honestly neither soc node is needed nor
the example. There are already 3 examples, it's enough, especially that
there are no new properties here.


> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        pcie@1fb81000 {
> +          compatible = "econet,en7528-pcie";
> +          device_type = "pci";
> +          linux,pci-domain = <0>;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +
> +          reg = <0x1fb81000 0x1000>;
> +          reg-names = "port0";
> +
> +          clocks = <&scuclk EN7523_CLK_PCIE>;
> +          clock-names = "sys_ck0";
> +
> +          phys = <&pcie_phy0>;
> +          phy-names = "pcie-phy0";
> +
> +          ranges = <0x01000000 0 0x00000000 0x1f600000 0 0x00010000>,
> +                   <0x82000000 0 0x20000000 0x20000000 0 0x08000000>;
> +
> +          interrupt-parent = <&intc>;
> +          interrupts = <23>;
> +          interrupt-names = "pcie_irq";
> +          bus-range = <0x00 0xff>;
> +          #interrupt-cells = <1>;
> +          interrupt-map-mask = <0 0 0 7>;
> +          interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +              <0 0 0 2 &pcie_intc 1>,
> +              <0 0 0 3 &pcie_intc 2>,
> +              <0 0 0 4 &pcie_intc 3>;
> +
> +          pcie_intc: interrupt-controller {
> +            interrupt-controller;
> +            #address-cells = <0>;
> +            #interrupt-cells = <1>;
> +          };
> +
> +          slot0: pcie@0,0 {
> +            device_type = "pci";
> +            reg = <0x0000 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +          };
> +        };
> +    };
> -- 
> 2.39.5
> 
