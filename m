Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BA2E8DEC;
	Wed, 18 Feb 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432607; cv=none; b=C4KIRMYxn3jIS/BmuhSCk5M3pLtf/fFI+5hRxrwinw33mjJiX4aTvH15V5VT1/U7kb70iHNlFoltYWqW205/kQF7/qYCWY11S+Ec1G8jwaV8pbTN7pLBufvSWTfsRmjcf1aXscM8yp78CgVtRA3GvkAJyK4mnsMPICssYPaeaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432607; c=relaxed/simple;
	bh=cZtx7DmmsQtOs5cgW5qKB4n145O37dojE3He8nE95zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6YttDRF3M84XGw1HlF22tBvQTbmoeGGca7nCP9baohxSRsBRpSgFnyBr87YUA6Qc4YfUiCQHQZSRec0tD76pz8LOa7n/6v9+0ofXxFH4aQvR/+278+B8XFnhdhuezc1jbsWzr2ZECQ6CW6hl1+rHyICsjg8hRvL/L21SFx795Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fug49kQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fug49kQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FDFC19422;
	Wed, 18 Feb 2026 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771432607;
	bh=cZtx7DmmsQtOs5cgW5qKB4n145O37dojE3He8nE95zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fug49kQ0NHqozjO5RhVCrMU8ypPZA00+VlJC0RtLfwOiwTrTsRf8S9uxBEeY3Fx52
	 gZYf8UAcDQmTi33jZOluEQboWW98K2KdS4NIJFpTgSVnYadztiVP+qanW+tPy8acfn
	 XAiAWRG7WhyNaelPsMUid9SeLvFpVXfrWXLX73cTDEew/H0UG//raP72EuZchNr6p7
	 jIFBakoVL/HKfUOUmZtpj/brKU/VbuyMELHQqMim+FLABVBA6c3DoE99WU7y12vXbT
	 wuhJDV+LAsqhZh/sCiM8XG7N58VNHGgmx4IeLbxyZHz0Leb2veGbamTuWxSgLLJf9A
	 2sOLASP+7kJLg==
Date: Wed, 18 Feb 2026 22:06:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vkoul@kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	"Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
Message-ID: <rli6pqtityds6xitz5ki3fxzwd63i2hsovlopikpz6xnjf4ial@x4iiu2xzdsdg>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-2-sean.anderson@linux.dev>
 <MN0PR12MB59537BC8B60D76CCE0B1391CB798A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <89516358-7b13-43ad-b303-1731f61d72e7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89516358-7b13-43ad-b303-1731f61d72e7@linux.dev>

On Thu, Feb 05, 2026 at 10:47:21AM -0500, Sean Anderson wrote:
> On 2/4/26 03:32, Pandey, Radhey Shyam wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> > 
> >> -----Original Message-----
> >> From: Sean Anderson <sean.anderson@linux.dev>
> >> Sent: Tuesday, February 3, 2026 5:51 AM
> >> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; Vinod Koul
> >> <vkoul@kernel.org>; linux-phy@lists.infradead.org
> >> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>; Lorenzo Pieralisi
> >> <lpieralisi@kernel.org>; Pandey, Radhey Shyam
> >> <radhey.shyam.pandey@amd.com>; linux-kernel@vger.kernel.org; Simek, Michal
> >> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; linux-
> >> pci@vger.kernel.org; Neil Armstrong <neil.armstrong@linaro.org>; Rob Herring
> >> <robh@kernel.org>; Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
> >> Manivannan Sadhasivam <mani@kernel.org>; Bjorn Helgaas
> >> <bhelgaas@google.com>; Sean Anderson <sean.anderson@linux.dev>; Conor
> >> Dooley <conor+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> >> devicetree@vger.kernel.org
> >> Subject: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
> >>
> >> Add resets so we can hold the bridge in reset while we perform phy calibration.
> > 
> > Seems like this should a required property?
> 
> It's optional as it does not exist in previous versions of the
> devicetree. In the past I have received pushback against making these
> sort of properties required.
> 
> If the resets don't exist we just don't assert them and assume the
> bootloader has deasserted them.
> 

If the resets are pretty much required for the hardware functionality, we can
mark them as required in the binding and accept the ABI breakage. This scenario
keeps coming with devicetree as the initial devicetree bindings lacked full
hardware description in most of the cases.

- Mani

> --Sean
> 
> > Rest looks fine to me.
> > 
> >>
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >>
> >>  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml  | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> >> b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> >> index 9de3c09efb6e..7efb3dd9955f 100644
> >> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> >> @@ -69,6 +69,18 @@ properties:
> >>    power-domains:
> >>      maxItems: 1
> >>
> >> +  resets:
> >> +    maxItems: 3
> >> +
> >> +  reset-names:
> >> +    items:
> >> +      - description: APB register block reset
> >> +        const: cfg
> >> +      - description: AXI-PCIe bridge reset
> >> +        const: bridge
> >> +      - description: PCIe MAC reset
> >> +        const: ctrl
> >> +
> >>    iommus:
> >>      maxItems: 1
> >>
> >> @@ -117,6 +129,7 @@ examples:
> >>      #include <dt-bindings/interrupt-controller/irq.h>
> >>      #include <dt-bindings/phy/phy.h>
> >>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
> >> +    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
> >>      soc {
> >>          #address-cells = <2>;
> >>          #size-cells = <2>;
> >> @@ -146,6 +159,10 @@ examples:
> >>              msi-parent = <&nwl_pcie>;
> >>              phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
> >>              power-domains = <&zynqmp_firmware PD_PCIE>;
> >> +            resets = <&zynqmp_reset ZYNQMP_RESET_PCIE_CFG>,
> >> +                     <&zynqmp_reset ZYNQMP_RESET_PCIE_BRIDGE>,
> >> +                     <&zynqmp_reset ZYNQMP_RESET_PCIE_CTRL>;
> >> +            reset-names = "cfg", "bridge", "ctrl";
> >>              iommus = <&smmu 0x4d0>;
> >>              pcie_intc: legacy-interrupt-controller {
> >>                  interrupt-controller;
> >> --
> >> 2.35.1.1320.gc452695387.dirty
> > 

-- 
மணிவண்ணன் சதாசிவம்
