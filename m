Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930913;
	b=mEZVLzxQJ8Nvua3fblcXwLjeAXK/wOosgy98+IAcFwwNGGGZISJkWEH1msy3uH9Suz4F
	 a0AGVhKRtWP5tXQ3Qsn22Gcf32z6PBBzFChwWASh1cZbmG4fRYvnGNMfYLHtIoXvPfYU3
	 D36ZukvwpzCIyM1ix+WmwTkW4K0FtDXhruHT6Tr9r2k/yRbYvXeTOR5MtWvWc3T7tLElv
	 GrA12f4jL0gSyabGQDq8w1xfb/xe7RlqhpcNMbVJOveKoz+tSkLM6cY7MWIzaP89mboNt
	 o0MQp+nHvR27WV6I+794BoDQCb6NzalteR7plO48ZL9aA9rZuruxAYcv+wdMD3Sy0uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930913;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6bCvhPLnnm+x36XG0GpxIEo0rb/nMiCAcSqBb2qIBKg=;
	b=o9NGXZ5jMe52rntldgxem26iPWPXWEltziZRB148qyRwgCWapt5+BGiRx3uVFT/W8fxn
	 aSRqlPrmxQxRNcRmQk5YvDO6vN4UTiaeQuAcPLMwRXydUL6+ziO3N0Hm1Ir66CFsj1fPn
	 ecGmpkZ0SBUE59kvv6PUF4PNMJPxp3a4lCofdhV6fYkPfaw3+rzbG1U4+Rb4rNzTl14K7
	 zMCHUThL5/Snj5pU3RGhNRMrlLbIjZUe3RKVm14Px01UsjvtbqMgBzXY1mTC+N6C5mJmc
	 CGI4Mu52ixotwDR0M8CPp3Aw3rTW9BNqtV+n9n8YRszkVyqboiosLxvPQzwCB7G0uew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExCPJJqS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CA606A88F;
	Tue, 17 Nov 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExCPJJqS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F061F000D2;
	Tue, 17 Nov 2026 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930913;
	bh=6bCvhPLnnm+x36XG0GpxIEo0rb/nMiCAcSqBb2qIBKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ExCPJJqSVFYbGRCRoeGHdRPjcp7c5XR5sXvaHEfBIvbTpE874gwVT2xa0uS9EYwHz
	 R1+5zuyP0bgGuEuVXPxTwDhLkHIg9wBnY1eKpgFG+1kxDzvWvXfxHcXn7d9rtG5XNf
	 CV+3z519/znfxZPhXBp8oHX6kTsi7/UHbYP/lDS/XQznxy73wU/cNqx3EoHc5hbLF3
	 lguwZhTHyjer3GL8pNyRc7C0bBbDLHzR0naF+fNhfTq9nKkJtef1bsXvpMn4eK7kMM
	 aOcgyNWVKp6saEfhxT7bN56IgMSX1OpDwj+uC3zjfSE24K6DfJmuidqvEq0cJUiXni
	 Nk0veVvzsWWkA==
Subject: Re: [PATCH net-next v4 6/6] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 17 Nov 2026 15:55:12 +0000
Message-ID: <179493091275.3136.9482657927785539194@kernel.org>
In-Reply-To: <e256f380f2f1bc88752ee261101cc83ad84ebedd.1794581338.git.claudiu.manoil@nxp.com>
References: <e256f380f2f1bc88752ee261101cc83ad84ebedd.1794581338.git.claudiu.manoil@nxp.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The two new fixups for 0xe101 and 0xe110 in
  drivers/pci/quirks.c only do something when…
- [Low] The comment above the of_pci_make_dev_node() fixup block in
  drivers/pci/quirks.c (lines 6553-6560) gives one reason for the…

--

PCI: Create OF node for NXP ENETC pseudo-MAC functions

This commit registers of_pci_make_dev_node() as a final fixup for the NXP
ENETC4 PCI device IDs 0xe101 and 0xe110. The new per-function OF node lets
the ENETC4 driver attach a fixed-link child to pseudo-MAC ports that have
no static DT node. The fixup only does anything when
CONFIG_PCI_DYNAMIC_OF_NODES is enabled.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee41..71f272d8a2965 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6563,6 +6563,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110, of_pci_make_dev_node);

[Severity: Medium]
With the default arm64 config, will these fixups do anything on the
S32N79 platform this series targets?

If CONFIG_PCI_DYNAMIC_OF_NODES is not set, of_pci_make_dev_node() is an
empty stub:

drivers/pci/pci.h:
#else
static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }

PCI_DYNAMIC_OF_NODES is a user-visible bool, and nothing in the tree
selects it. NXP_ENETC4 selects OF_DYNAMIC, so there is no build problem.
However, it does not select or imply PCI_DYNAMIC_OF_NODES.

arch/arm64/configs/defconfig sets CONFIG_ARCH_S32=y and
CONFIG_NXP_ENETC4=m, but it does not set PCI_DYNAMIC_OF_NODES.

The s32n79.dtsi change in this series adds netc_iep18 without child nodes
for the PCI functions. So dev->of_node stays NULL for the pseudo-MAC PF,
and enetc4_link_init() fails the probe:

drivers/net/ethernet/freescale/enetc/enetc4_pf.c:enetc4_link_init() {
    ...
		if (!node) {
			dev_err(dev, "Missing of_node for Pseudo-MAC port\n");
			return -ENODEV;
		}
    ...
}

This error message does not mention the missing config option.

So with the default arm64 config, "arm64: dts: s32n79-rdb: enable NETC
IEP18" does not get the PPM PF/VF instances probed, which is what it sets
out to do.

The commit messages say this dependency is intentional, because the
driver also handles ports described by static DT. That is a reason not to
add a hard "depends on". Would an "imply PCI_DYNAMIC_OF_NODES" on
NXP_ENETC4, or a defconfig update, work instead? The Kconfig help text
notes that turning the option on also creates OF nodes for all PCI
bridges.

[Severity: Low]
This isn't a bug, but the comment above this block of fixups no longer
covers every entry:

/*
 * For a PCI device with multiple downstream devices, its driver may use
 * a flattened device tree to describe the downstream devices.
 * To overlay the flattened device tree, the PCI device and all its ancestor
 * devices need to have device tree nodes on system base device tree. Thus,
 * before driver probing, it might need to add a device tree node as the final
 * fixup.
 */

An ENETC4 pseudo-MAC function has no downstream devices and loads no FDT
overlay. enetc4_add_ppm_fixed_link() only applies an of_changeset that
adds a fixed-link child to the function's own node.

The PCI_DYNAMIC_OF_NODES help text in drivers/pci/Kconfig also describes
only the overlay use case.

Could the comment, and perhaps the help text, be updated to cover this
use?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794581338.git.claudiu.manoil%40nxp.com
