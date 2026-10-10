Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A24A68BA;
	Sat, 10 Oct 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638041; cv=none; b=kbeGXToWXm1eX5H1VP5+jp/yqrNAYdQq4L++m/5k2/KPE6EWRa9kuJQatapO6SG6yW41wTgoxxn5SPWR34Z7fRF5HwLpe4UHIQqAHeOnlYC2BowdVNsKxfPzbfRkHYjJOBEADnjaxh3EhKFUajnAxBNL0lCUtbRJEzgnQ1SH+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638041; c=relaxed/simple;
	bh=V3JInjRu038LpL9kkkoscphlXvb04pxwqT2CCzQOHeY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1zinO4oGUCY5nYh+e6asE/sPcwALXGRdBeOCDEXn0J64HNqHDIwXEmRPe+tOV8XISP54LUF7vuKu6N8+6sOWG3NOI+QrC3dD/p110vo6yh+U8fNkami9D503I9CYnTc3uHGXIxD/J+jS7IXHxWkKPZ0g7NY/Cdvxx9ddTZLucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+04zLRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+04zLRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EAD1F00898;
	Sat, 10 Oct 2026 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791638040;
	bh=xS4iFAXStp/24gOGabtVO3CFoW96wIOwRbpYEjn2frM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m+04zLRSDbuRR1ZIkcfgG2Sk72jEsciZ6T5Mj68CrS13qzwYJWvTCjRMSeuPb3Ypc
	 DBqb26cRf9a3zaVCZPdngOARDMGpY9ImykmDWnZ0pM5N3EgxRTqvjkiUaaAjwb964D
	 kox8bxP/Vqq6K8JSs5uVKQUZmw2B5iX6dgbLcfGOsOQV2FmfBT7ngSl4AEmOrkGXJs
	 6X29K6Whge/Jdvi55VF/KAgoYD8zP+ZgOHQHQ+EqJL6Q8BPqqXPMeA3vIxQRwGZedQ
	 SqMn99IsHSUFJ9ovJe33cR0c3DUZtB5KhUfUVEp1e9KtUcx/2nfwSnBrpWpLFZAAtw
	 j+kWzYp2rn+yA==
Subject: Re: [PATCH net-next v1 3/5] arm64: dts: s32n79: add NETC IEP18 ECAM
 node for ENETC PPM ports
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 10 Oct 2026 13:13:59 +0000
Message-ID: <179163803952.434549.14351078152786300124@kernel.org>
In-Reply-To: =?utf-8?q?=3C49a0450c6d906f0ba1a886d86e89f35746a7a6fc=2E1791548?=
 =?utf-8?q?316=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C49a0450c6d906f0ba1a886d86e89f35746a7a6fc=2E17915483?=
 =?utf-8?q?16=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] dt-bindings: PCI node netc_iep18 uses msi-parent instead of msi-
  map breaking MSI routing
- [Low] The new top-level `nwss-bus` node, which has no unit address, is
  placed between `coss-bus` and `cpus` in…

--

arm64: dts: s32n79: add NETC IEP18 ECAM node for ENETC PPM ports

This commit adds a disabled netc_iep18 PCIe ECAM host node to
s32n79.dtsi, inside a new nwss-bus simple-bus. The node describes the NETC
integrated endpoint bus that hosts the ENETC v4 Pseudo-MAC PF and its VFs.
MSIs go through the GIC-v3 ITS, and DMA is translated by the SMMUv3.

> diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
> index 94ab58783fdc8..671b807f1c540 100644
> --- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
> @@ -122,6 +122,30 @@ irqsteer_coss: interrupt-controller@4ed00000 {
>  		};
>  	};
>
> +	nwss-bus {

[Severity: Low]
This isn't a bug, but is nwss-bus in the right place?

Documentation/devicetree/bindings/dts-coding-style.rst says:

  "Nodes without unit addresses shall be ordered alpha-numerically by the
  node name."

The other top-level nodes in s32n79.dtsi follow that order: cis-bus,
coss-bus, cpus, firmware, fss-bus, pmu, timer. The new node is inserted
between coss-bus and cpus.

Could it go between fss-bus and pmu instead?

> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x48800000 0x0 0x48800000 0x0 0x4b0000>,
> +			 <0x2 0x40000000 0x2 0x40000000 0x0 0x20000000>;

[ ... ]

> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;

[ ... ]

> @@ -122,6 +122,30 @@ irqsteer_coss: interrupt-controller@4ed00000 {
>  		};
>  	};
>  
> +	nwss-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x48800000 0x0 0x48800000 0x0 0x4b0000>,
> +			 <0x2 0x40000000 0x2 0x40000000 0x0 0x20000000>;
> +
> +		netc_iep18: pcie@241200000 {
> +			compatible = "pci-host-ecam-generic";
> +			reg = <0x2 0x41200000 0x0 0x100000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			bus-range = <0x0 0x0>;
> +			msi-parent = <&its 0x0>;
> +			iommu-map = <0x0 &smmu 0xc0000 0x100>;
> +			dma-coherent;
> +			status = "disabled";
> +
> +			/* All NETC PCIe functions */
> +			ranges = <0x82000000 0x0 0x48800000 0x0 0x48800000 0x0 0x4b0000>;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;

[Severity: High]
Does msi-parent with a specifier work for the functions behind this
ECAM host?

For PCI devices, the ITS DeviceID and the per-device MSI domain come
from of_msi_xlate(), which walks up the parent devices trying msi-map
first and then of_check_msi_parent(). of_check_msi_parent() only
accepts an msi-parent phandle with a missing or zero #msi-cells, i.e.
the 1:1 mapping case, and returns -EINVAL when msi_spec.args_count is
non-zero, as it is for <&its 0x0>.

That leaves the MSI controller node unresolved, so
of_msi_map_get_device_domain() finds no domain for the PPM PF and its
VFs, and pci_msi_domain_get_msi_rid() passes the raw RID through
unchanged as the DeviceID that its_pci_msi_prepare() programs. The
0x0 cell is never consumed. Wouldn't MSI setup for these functions
then either fail or target a DeviceID the ITS was never configured
for?

Separately, even if the specifier were honoured, a single msi-parent
cell would collapse all 256 RIDs onto one DeviceID, which doesn't
match the iommu-map giving each RID its own StreamID from 0xc0000.

Should this be an msi-map instead, along the lines of:

  msi-map = <0x0 &its 0xc0000 0x100>;

or do the ITS DeviceIDs for IEP18 differ from the SMMU StreamIDs on
S32N79?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791548316.git.claudiu.manoil%40nxp.com
