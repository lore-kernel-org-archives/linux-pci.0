Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178C444708;
	Fri, 16 Oct 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138509; cv=none; b=W4CZJ042BoeOiqMpkqpx/CsyeH9yXp931ZTxUJftNYt13foq1bubcq6sdQonPEETkIh2ODsLWysn80cu6RrBfT7Qiyo3kNsirZn6B/8LUjfSpmpjehzZ7vW1mpopKgZZ7CjNOT2S5Vy8UspGSx3mkKYPw7mM7jeyvDqZdsa9olo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138509; c=relaxed/simple;
	bh=O7hWe6fg7vTikfbZVnbMJUO6SE9XHdyfMpuQAujaGnU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phYKbsZih2Zf1xZI0pjWuMaZgPmywT1Ej1qhZ62g7lxoUkXBon/H/T4IISF2oYdvblkDVujXnF6F1xnpCPgIc2qG0fEOINp3P++SfJ2acbZ045RFMwUPX53cn86LtCLwnHsNBHqcqJNkEQdbFuao76GIF/g0fhaFVCqhYB9Fogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuBLejRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuBLejRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3721F000C6;
	Fri, 16 Oct 2026 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138507;
	bh=ZpRDLXzpuxbbBw8Z69CfaBJuasLgrozdV+0ySGl4QLE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GuBLejRZRJCPjcMFtg4FDK/DFg0vtzocFU7C+faOWqsYhUfdACMxz2+t3zZMOGJUn
	 8Mq2xnFuHik77o9xEPPKJNzjVbAbQLEIGXfENZ0wOoTD0IMCOUTgoeZeo54tfF8J7e
	 YToH902RRs7LRbnhz3dXKdWD2DfiOeFGBS0FTH8O9sfdYFknF1t7pYBjfaBlku9mFC
	 OYSbV0e9eAUUDW1f/iriWhVqqWrDihtiYo/bXZQ3UUDWU1NXoxgje4517X4pnDh6G1
	 qHhi99ue7WBaFrKoVJS+Pu2Hwxl4dRrCjvUJasZZUQMuSJwlMlq76WuszRLvLYonUS
	 EC0SqilUchMZQ==
Subject: Re: [PATCH net-next v2 4/5] arm64: dts: s32n79-rdb: enable NETC IEP18
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, kuba@kernel.org
Date: Fri, 16 Oct 2026 08:15:06 +0000
Message-ID: <179213850647.434549.7104910739428265199@kernel.org>
In-Reply-To: =?utf-8?q?=3C7c22b051b08887aad6b6a73462028298902ff3e7=2E1791908?=
 =?utf-8?q?694=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C7c22b051b08887aad6b6a73462028298902ff3e7=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] s32n79-rdb.dts enables &netc_iep18 but leaves &smmu disabled,
  even though the bus node says `iommu-map = <0x0 &smmu 0xc0000 0x100>`.
- [Low] At this commit, enabling &netc_iep18 in s32n79-rdb.dts does not
  get the PPM PF to probe.
- [Low] The &netc_iep18 override is appended after &usdhc0 in
  s32n79-rdb.dts.

--

arm64: dts: s32n79-rdb: enable NETC IEP18

This patch enables the NETC v4 ECAM bus #18 (netc_iep18) on the S32N79-RDB
board. The goal is to get the ENETC v4 Pseudo-MAC port (PPM) PF and VF
instances probed.

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
> +	status = "okay";
> +};

[Severity: Medium]
Should &smmu also be enabled for this board? The netc_iep18 node in
s32n79.dtsi has:

	iommu-map = <0x0 &smmu 0xc0000 0x100>;

The SMMU node is disabled at SoC level, and s32n79-rdb.dts does not
override it:

	smmu: iommu@4fc00000 {
		...
		#iommu-cells = <1>;
		dma-coherent;
		status = "disabled";
	};

DMA setup for the ENETC PF/VFs on this bus goes through
of_dma_configure_id()->of_iommu_configure()->of_map_iommu_id()->
of_iommu_xlate(). of_iommu_xlate() rejects the disabled node:

	if (!of_device_is_available(iommu_spec->np))
		return -ENODEV;

of_dma_configure_id() then falls back to direct DMA and only logs a
dev_dbg() message:

	/* Take all other IOMMU errors to mean we'll just carry on without it */
	dev_dbg(dev, "device is%sbehind an iommu\n",
		!ret ? " " : " not ");

	arch_setup_dma_ops(dev, coherent);

Does this leave every NETC function, including the SR-IOV VFs, doing
untranslated DMA with no iommu_group? If so, the VFs cannot be assigned
through VFIO. Whether DMA works at all would then depend on whether firmware
left the SMMU in bypass or abort mode.

This also seems to contradict the earlier dtsi commit "arm64: dts: s32n79:
add NETC IEP18 ECAM node for ENETC PPM ports", which says:

  DMA is translated by the SMMUv3 (iommu-map)

The last commit in the series does not change this.

[Severity: Low]
Will the PPM PF actually probe at this point in the series? The commit
message says:

  so that the ENETC v4 Pseudo-MAC port (PPM) PF and VF instances are probed.

The ENETC PFs are endpoints on root bus 0 of a pci-host-ecam-generic node
that has no child nodes, so pci_set_of_node() gives them no of_node.

At this commit, pci_bus_add_device() only creates dynamic nodes for
bridges:

	pci_fixup_device(pci_fixup_final, dev);
	if (pci_is_bridge(dev))
		of_pci_make_dev_node(dev);

drivers/pci/quirks.c has no NXP ENETC fixup yet, so
enetc4_link_init()->enetc4_add_ppm_fixed_link() would fail here:

	if (!np)
		return dev_err_probe(priv->dev, -ENODEV,
				     "Missing of_node for Pseudo-MAC port\n");

The last patch in the series, "PCI: Create OF node for NXP ENETC
pseudo-MAC functions", fixes this by adding:

	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);
	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110, of_pci_make_dev_node);

Without that patch applied first, there is a bisection window where the PF
fails to probe.

One gap remains at the end of the series. CONFIG_PCI_DYNAMIC_OF_NODES
(bool, default n) is not set in arch/arm64/configs/defconfig, which has:

	CONFIG_NXP_ENETC4=m
	CONFIG_FSL_ENETC_VF=m

With defconfig, the PF would still fail with -ENODEV. The commit "net:
enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link node"
documents this as an intended runtime dependency rather than a Kconfig
dependency.

[Severity: Low]
This isn't a bug, but should this override go between &irqsteer_coss and
&uart0? Documentation/devicetree/bindings/dts-coding-style.rst says:

  3. When extending nodes in the board DTS via &label, the entries shall be
     ordered either alpha-numerically or by keeping the order from DTSI, where
     the choice depends on the subarchitecture.

The existing overrides in s32n79-rdb.dts are in alphabetical order:
irqsteer_coss, uart0, uart5, uart6, uart7, usdhc0.

Placing &netc_iep18 after &usdhc0 matches neither alphabetical order nor
DTSI order, since netc_iep18 also comes before usdhc0 in s32n79.dtsi.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791908694.git.claudiu.manoil%40nxp.com
