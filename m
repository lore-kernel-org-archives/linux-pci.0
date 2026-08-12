Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF729BDB5;
	Wed, 12 Aug 2026 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539827; cv=none; b=Va86qk9ZKWwec+BS/DwKrY9lJcryeKAuOs/Yp0U9X6LdDLYgE3lMfD5GOUJeOm/p7tQGU5ylXmNO0sBI/jkEfuVZFdwv6vm7fYfuwY8Fcnw40uLAOzsAaFyL5MEIPiC+HIh3lqmb4hWuYgOAId1UqO35MkyacwVpMcWA6nIMRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539827; c=relaxed/simple;
	bh=ulLrNBOUgIfbb8Py8s/m9oRQ14fvvVD0aIAIFPol6n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL3FM5YHCV958SJFT5op0HlCz4i792UCa7DbGHLI7vh3+mV3YbNmtA8YqDDriGQOzCFyjPe3zeVDoP8p/ng7iy78XTn6qNZd1X83v+yqJCAb9GOI3EDqPKgnkW7Mp0Rz/AgI0tgj639WtPTTLnO+zd2lKLBfq8KEmKbB+XFZY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0pT2/LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0pT2/LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F8E1F00ACF;
	Wed, 12 Aug 2026 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786539825;
	bh=bytXpQgpZnzKEOXost0E8oAB4XFlFhdZruCl5tty8JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O0pT2/LOw05vWQSgqCTFVdqD/3AqwaHcn8ihBa0+WafMqARXwj2Elajlrpraxb5km
	 CIQaAOftqPpldZAdimWEMqftMDt4LzZmsWdH8q7Tq4tfgBAbaV6RIqB/g6NKqw+4UE
	 0xAEj1zQxlpJi9iGVBT73poiicjs9btSpbCAOrE5/sOezQl/QN/VrECREL1b+KJZUT
	 AwfBK0Sy8TKAYMj0Olvp7ukhrOdozWS7irxJJ2WT8tXDimnMgQmRDPsybH9dHCIMtd
	 Ulsth0jPqf5lf224LrdBPhqlCDVjNLmDdMRGn5LRa787aorGTdhCl6WBwUatwjA1wc
	 DteuX27jkGYvA==
Date: Wed, 12 Aug 2026 15:03:34 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: PCI: qcom: Document the Shikra PCIe
 Controller
Message-ID: <xxoyame76suxnhzglpccdxmvrpal3n5bgxhvcjeqyznepe2cyr@bud6ob4ecw7q>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-2-e1a721eb8943@oss.qualcomm.com>
 <hf6szamduxopeuvkjkxxteqauirsgfq36pih7go2wf25o4zmv4@vhmhe3gyzgo5>
 <7a17da3d-c838-4877-8a62-5551dbdaa9e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a17da3d-c838-4877-8a62-5551dbdaa9e5@oss.qualcomm.com>

On Wed, Aug 12, 2026 at 11:25:12AM +0530, Sushrut Shree Trivedi wrote:

[...]

> > > +    #include <dt-bindings/clock/qcom,rpmcc.h>
> > > +
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > Get rid of 'soc' node.
> If we remove soc node, dt-schema uses address-cells = <1>,
> size-cells  = <1> for dt-binding check and throws errors.
> 
> Do you suggest ignoring those errors ?

No, you need to make the 'reg' entries 1 cell.

> > 
> > > +        pcie@45e8000 {
> > > +          device_type = "pci";
> > > +          compatible = "qcom,shikra-pcie";
> > > +          reg = <0x0 0x045e8000 0x0 0x3000>,
> > > +                <0x0 0x60000000 0x0 0xf1d>,
> > > +                <0x0 0x60000f20 0x0 0xa8>,
> > > +                <0x0 0x60001000 0x0 0x1000>,
> > > +                <0x0 0x60100000 0x0 0x100000>,
> > > +                <0x0 0x045eb000 0x0 0x1000>;
> > > +          reg-names = "parf",
> > > +                      "dbi",
> > > +                      "elbi",
> > > +                      "atu",
> > > +                      "config",
> > > +                      "mhi";
> > > +          #address-cells = <3>;
> > > +          #size-cells = <2>;
> > > +          ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
> > > +                   <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>,
> > > +                   <0x03000000 0x4 0x00000000 0x4 0x00000000 0x3 0x0000000>;
> > > +          bus-range = <0x00 0xff>;
> > > +
> > > +          linux,pci-domain = <0>;
> > > +          num-lanes = <1>;
> > > +
> > > +          interrupts = <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 493 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +                       <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +          interrupt-names = "msi0",
> > > +                            "msi1",
> > > +                            "msi2",
> > > +                            "msi3",
> > > +                            "msi4",
> > > +                            "msi5",
> > > +                            "msi6",
> > > +                            "msi7",
> > > +                            "global";
> > > +
> > > +          interrupt-map = <0 0 0 1 &intc 0 0 0 499 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <0 0 0 2 &intc 0 0 0 500 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <0 0 0 3 &intc 0 0 0 501 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <0 0 0 4 &intc 0 0 0 502 IRQ_TYPE_LEVEL_HIGH>;
> > > +          interrupt-map-mask = <0 0 0 0x7>;
> > > +          #interrupt-cells = <1>;
> > > +
> > > +          clocks = <&gcc GCC_PCIE_AUX_CLK>,
> > > +                   <&gcc GCC_PCIE_CFG_AHB_CLK>,
> > > +                   <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> > > +                   <&gcc GCC_PCIE_SLV_AXI_CLK>,
> > > +                   <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> > > +                   <&gcc GCC_DDRSS_MEMNOC_PCIE_SF_CLK>,
> > > +                   <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>,
> > > +                   <&gcc GCC_QMIP_PCIE_CFG_AHB_CLK>;
> > > +          clock-names = "aux",
> > > +                        "cfg",
> > > +                        "bus_master",
> > > +                        "bus_slave",
> > > +                        "slave_q2a",
> > > +                        "ddrss_memnoc_pcie",
> > > +                        "tile",
> > > +                        "qmip_pcie_ahb";
> > > +
> > > +          assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>;
> > > +          assigned-clock-rates = <19200000>;
> > > +
> > > +          interconnects = <&system_noc MASTER_PCIE2_0 RPM_ALWAYS_TAG
> > > +                          &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
> > > +                          <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
> > > +                          &config_noc SLAVE_PCIE2_0 RPM_ACTIVE_TAG>;
> > > +
> > > +          interconnect-names = "pcie-mem",
> > > +                               "cpu-pcie";
> > > +
> > > +          iommu-map = <0x0 &apps_smmu 0x800 0x1>,
> > > +                      <0x100 &apps_smmu 0x801 0x1>;
> > > +
> > > +          resets = <&gcc GCC_PCIE_BCR>;
> > > +          reset-names = "pci";
> > > +
> > > +          power-domains = <&gcc GCC_PCIE_GDSC>;
> > > +
> > > +          max-link-speed = <2>;
> > You don't need 'max-link-speed' unless you want to limit the link speed.
> This is needed since Shikra controller supports Gen3 but the PHY
> is only capable of Gen2. Without limiting the speed, link-up fails.

This is a critical limitation that should've been mentioned in the commit
message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
