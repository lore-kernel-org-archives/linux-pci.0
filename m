Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5661343D91
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691492; cv=none; b=g1Nwr8V+jnZCYx6g/O3ma3lF4L1jQSv6gTvib+qETm6JxqvMH+hXvsVHzzsUTGEYvR7lUD0c/0jBClPKVdeGQx1QYr4pYd09XnA8rxE0O501dp0CqLliFZa2MP77oGlEJ8f8enym/VSX9gNvvMtUobNAtjJ138uid90RfMf4vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691492; c=relaxed/simple;
	bh=t+rDZvEy/tPEmak3jjiurBHG0tRvnH2dVpGDefeig7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bCR505OwUlUREdnt8eBOjk3MueHxXONkrIOfPr5QJBtt8XwH0fPti8w2rfYneXWqjKqJhZkCfdHdShA8i+HKvL0EINa5og/2JK+Z9vgAFo+gfGNQaxytgb7g4Ga716yA48jDPYxYwrIHPYWNAbWdZpBydjSseCkBBLEZZHLPHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpvKhFs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpvKhFs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94F81F000E9;
	Mon, 25 May 2026 06:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691488;
	bh=8eZTmIOM8zsDUJxJ+VXhMWqTd2Yffxvec9+wpnBzu9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpvKhFs+mD2jVj18aEN/KOr9IfqU7xkxO6y1xk5BV0y8dCA4mSDVETEW01nxbP9Os
	 X9GCFmHmX28u5hXFEYI/dWEfsFdKi483Un7D19FIHOp6038vSbPqDm7BhDp/dp6nMi
	 mqbMYLjvmDq/k/SHZYmbv8OxQpkl515MnlLYcBakiAvuK6QsJ7rdKTjaL4Qtl8Kemo
	 xFDazM1jJPzEoiGQgcKXLybEEanZn8LfvR/vCzyvXIE4XNpuQQriIDUzvbJ6n12EH3
	 kumG99LgTCTjs6Y6Z0r9tiw/Fv8UC/WOZvpkSaBTTrw3Im+1Bq0nIySRUSCyJGex4j
	 qr6QtjYF/BmTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260525063129.3316894-3-den@valinux.co.jp>
References: <20260525063129.3316894-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:44:48 +0000
Message-Id: <20260525064448.B94F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] DMA channel claiming metadata is tightly coupled with physical des=
criptor memory resources, forcing a broken 1:1 mapping between logical chan=
nels and physical memory.
- [Medium] The `pci_epc_aux_dma_reg_layout` enum defaults to a vendor-speci=
fic layout (DesignWare eDMA) when zero-initialized.
--

commit f984d5b6e28f758274509e2d7c1e001a4dfe35b9
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Add DMA auxiliary resource metadata

Extend EPC auxiliary resource metadata to allow endpoint functions to
discover controller-owned DMA registers and descriptor memory. This adds
structs for DMA MMIO layout and descriptor configurations.

> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f247cf9bcf1ac..cdad8cd648209 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h

[ ... ]

> +/**
> + * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
> + * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA la=
yout
> + */
> +enum pci_epc_aux_dma_reg_layout {
> +	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
> +};

[Severity: Medium]
Will zero-initialized structures silently default to the DesignWare eDMA
layout?

If a non-DesignWare EPC backend exposes a DMA controller MMIO resource and
leaves the layout uninitialized, consumers might incorrectly identify the
DMA controller as a DesignWare IP. Would it be safer to define an unknown
or generic layout as the zero value to prevent silent failures?

[ ... ]

> +		/* PCI_EPC_AUX_DMA_DESC_MEM */
> +		struct {
> +			enum pci_epc_aux_dma_dir dir;
> +			u16 hw_ch;
> +			struct device *dma_dev;
> +			/*
> +			 * Consumers pass this resource as the filter
> +			 * parameter.
> +			 */
> +			bool (*filter_fn)(struct dma_chan *chan, void *param);
> +		} dma_desc;
>  	} u;
>  };

[Severity: High]
Does embedding logical DMA channel metadata inside the descriptor memory
resource force a 1:1 mapping between logical channels and physical memory?

If a DMA controller does not have dedicated descriptor memory (e.g., it
fetches descriptors directly from system RAM), it might not expose a
descriptor memory resource at all. This would leave it no way to pass the
filter_fn and dma_dev required for consumers to claim channels.

Conversely, if multiple channels share a single descriptor memory region,
the backend might have to duplicate the memory resource for each channel.
Could the logical channel metadata be decoupled from the physical descriptor
memory resource?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525063129.3316=
894-1-den@valinux.co.jp?part=3D2
