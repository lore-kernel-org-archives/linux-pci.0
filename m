Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930912;
	b=H4GkQd8ajP9ZIHzAGFS0TtJlaxpy6UGPDl9lYHFEP13Pzh5i83gvpTBHt++iBndVB6wn
	 WfUt7Y1DJbd2J6qmOxwvO3kzbkzHcg+Fm+n36fKfeeet+j9lvmrR8zrnCHYz21QHpEfkq
	 ihabdICc7BhVMf8TVBtQFM9zR14gKQ8StWcmrBgSmZ5iIbMr3oWnsjaiHodlq7Z/TKwt/
	 fidY/71A93E7tbRmk6RFaNEDc0j8XB32cfJLzYphZjiJMt98Y/ZZV1NmIiZPRSkNF52gY
	 htgNO4YRaPrpk73RSys36xOOk/Nfm1Q/tdh6CajmRVgigVg+Su+yQPxOlRG4DTuZvcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930912;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XgxlZZNQSDhCeE3vldSU17DsBsAk8DRist2NVpPCFhI=;
	b=aMvh50t0dl/RHyyqvxwbkJKJKe//M3YXuKJbolOtiX/uPS8P65pw+LYFNfMwUlXZ0Bmm
	 W61dneFIP4m5MfrhXJ+xHBWdDRQXKv53tOjhA66XzrATOOS9M0QYWSQp7BIuLXdbLJoJi
	 kgPXxKF0UfHX57EPy6LxZRL2G7EkFSdRqmJSDXhSLXZ8Fw1alN42eDTezCG2RNrZtd1WJ
	 e/KwIbqiQHGNuuZl0ptOQNS5GH+fWgqr3oh9+NttS569Ratr3NYus30arLqvd01bpQuUw
	 PVUp8BJt8uynQuvUkczsnGeI849QDSxwKPd63na7b69XkE9ndyCdpcoH/dClELt8Ong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJVbuSX0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CE606A885;
	Tue, 17 Nov 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJVbuSX0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C6E1F000CA;
	Tue, 17 Nov 2026 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930912;
	bh=XgxlZZNQSDhCeE3vldSU17DsBsAk8DRist2NVpPCFhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oJVbuSX0KcGKZbYsciDFVrqFxcf2xwHherbHdjA31t/XqIwGeTwvavTzoeYd4Ctz8
	 JaLz5GzMyZfmOlGW/yiCHU6TdClzdJo4w2XSLu7iF1YP7iWuJHD7f0aLytJwERjsh9
	 YsyJUHON8R/ha0y6u2j9AW6pKrEpkZwVsqdKWN0yfem1thFfd1V2e1b/3Te+x0FKoH
	 R3MTHRWJjXXwrzQ996H+Ttk1vVHzDGqUZmyrD3gbgHIgxeldf7qCPrLIuDsMDB0Srv
	 KvfpjrAP7P/i/Q3gCyL+Tn99fZ9b9kIggvaL/lhlhs9L7hYxq1FisRFCPsd+pa5sVX
	 cUZtasDRfqhGw==
Subject: Re: [PATCH net-next v4 5/6] arm64: dts: s32n79-rdb: enable NETC IEP18
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 17 Nov 2026 15:55:11 +0000
Message-ID: <179493091171.3136.308017869378286942@kernel.org>
In-Reply-To: <6f1ea6caef6ca01c9a6384cd1024384d31848c53.1794581338.git.claudiu.manoil@nxp.com>
References: <6f1ea6caef6ca01c9a6384cd1024384d31848c53.1794581338.git.claudiu.manoil@nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch turns on `&netc_iep18` in
  arch/arm64/boot/dts/freescale/s32n79-rdb.dts so that, per the commit…
- [Medium] Setting `&netc_iep18` to okay makes the ENETC v4 PPM PF and
  VFs live DMA masters.
- [Low] The new `&netc_iep18` override in
  arch/arm64/boot/dts/freescale/s32n79-rdb.dts is added after `&usdhc0`.

--

arm64: dts: s32n79-rdb: enable NETC IEP18

This commit enables the NETC v4 ECAM bus #18 on the S32N79-RDB board. The
goal is for the ENETC v4 Pseudo-MAC port (PPM) PF and VF instances to be
probed.

> diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> index 1feccd61258ef..897ba24ac03ae 100644
> --- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> @@ -68,3 +68,7 @@ &usdhc0 {
>  	no-sdio;
>  	status = "okay";
>  };
> +
> +&netc_iep18 {

[Severity: Low]
This isn't a bug, but Documentation/devicetree/bindings/dts-coding-style.rst
says:

  When extending nodes in the board DTS via &label, the entries shall be
  ordered either alpha-numerically or by keeping the order from DTSI,

The existing overrides in this file are in alphabetical order (irqsteer_coss,
uart0, uart5, uart6, uart7, usdhc0). Should &netc_iep18 go between
&irqsteer_coss and &uart0? Keeping the DTSI order would also put it before
&usdhc0.

> +	status = "okay";
> +};

[Severity: Medium]
The commit message says the bus is enabled "so that the ENETC v4 Pseudo-MAC
port (PPM) PF and VF instances are probed". Does the PF actually probe when
the kernel is built from the in-tree arm64 defconfig?

The netc_iep18 host bridge node in s32n79.dtsi has no child nodes, so the
ENETC PF function does not get a static of_node. For a pseudo-MAC port,
enetc4_link_init() in drivers/net/ethernet/freescale/enetc/enetc4_pf.c then
fails here:

	if (!node) {
		dev_err(dev, "Missing of_node for Pseudo-MAC port\n");
		return -ENODEV;
	}

The only other way to get an of_node is of_pci_make_dev_node(). The last
patch in the series, "PCI: Create OF node for NXP ENETC pseudo-MAC
functions", adds it as a final fixup for 0xe101/0xe110:

	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);

However, of_pci_make_dev_node() is only built with
CONFIG_PCI_DYNAMIC_OF_NODES. Without it, drivers/pci/pci.h provides an empty
inline stub.

PCI_DYNAMIC_OF_NODES is a plain bool with no default, and NXP_ENETC4 only
selects OF_DYNAMIC. arch/arm64/configs/defconfig sets
CONFIG_PCI_HOST_GENERIC=y, CONFIG_NXP_ENETC4=m and CONFIG_FSL_ENETC_VF=m, but
it does not set CONFIG_PCI_DYNAMIC_OF_NODES.

So on a default arm64 build, won't the only device behind the newly enabled
bus fail with -ENODEV? The PF creates the VFs through SR-IOV, so the VFs
would not appear either. This is still the case at the end of the series.

Would one of these work: giving the PF a static child node in DT, adding
CONFIG_PCI_DYNAMIC_OF_NODES=y to the arm64 defconfig, or having NXP_ENETC4
imply or select it?

[Severity: Medium]
With this bus enabled, the PPM PF and VFs become live DMA masters. The
netc_iep18 node in s32n79.dtsi has:

	iommu-map = <0x0 &smmu 0xc0000 0x100>;
	msi-map = <0x0 &its 0xc0000 0x100>;
	dma-coherent;

The smmu node it points to is disabled at the SoC level:

	smmu: iommu@4fc00000 {
		compatible = "arm,smmu-v3";
		...
		status = "disabled";

No board DTS under arch/arm64/boot/dts/freescale/ enables it.
of_iommu_xlate() in drivers/iommu/of_iommu.c then ignores the mapping without
any message:

	if (!of_device_is_available(iommu_spec->np))
		return -ENODEV;

As a result, the PF and VFs fall back to dma-direct and use raw physical
addresses for the BD rings and buffers.

The SoC dtsi commit in this series says "DMA is translated by the SMMUv3
(iommu-map)". That does not seem to hold on this board.

Doesn't DMA now depend entirely on the SMMU state left by boot firmware?
Suppose firmware left the SMMU enabled with its own stream table, or set it
to abort unmatched streams. NETC DMA would then fault or be blocked, even
though the netdev probes.

The dma-coherent property makes Linux skip cache maintenance. That too relies
on stream attributes configured outside of Linux.

Should &smmu be enabled along with this bus? Alternatively, could the
firmware requirement be documented (SMMU in bypass with coherent attributes
for StreamIDs 0xc0000 and up) and the dtsi commit message corrected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794581338.git.claudiu.manoil%40nxp.com
