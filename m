Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998371;
	b=FKn7cq4p5ij5mlzC9TX7Eq+bopp+I1JQEn7AfvzMNQqwjE3mIkZfsEawmkBVc/qm+N7+
	 ohT9dmkynk2M7s7Om6TFbZ4uw/FLl0iPxIrcXRg2lgZ1eADMf7E9XRE2QQ8X1+vkahhdu
	 RXs0rfElH87uoLcn3bFwH/cMTzk5R5+6p6tALv+9jS9iK+HaFJKkDh0cABr7Uyiz5pubA
	 0Ri3rl8zb83eaHZFIgG6nIlnATlopu/KpLvLBK86j8HqjtJk8ghqWadqoKcBYIwACbOgP
	 ukKPKtnVEd6QNtLVtUk6pg0Eavif9AwfnPNEi6wx0/QWpBrvUIlALYDYs4wn5lUchXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998371;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DI68O0X3RB/jvXr8h6qOIGncG3G3gqaeml4OgW4iOEE=;
	b=DH9K46CRkU/GXIwwoOq9lsq62HDsXbG2RG9Lzqr6/20rhJX+w1hdGeEfHYiKEXo4GojM
	 FoYF0Jnb5JAI7CL19516Cpc5HYgL8TSUOk5aXubkt2EfoxPjGUzIlZmAdZAgZ8Gmz4XVC
	 14jEvKHoJyq4OxWTtpiFUPZZypSDGDHNPc0fX1OQ4XWZWUq8VLtw2SECckw14ltY9uiCs
	 2dR/Xc71xh7sQWG2rXlP3ysUj30V2S/j1dA4O+qVZsPzwdChU84l98gLRtjslRpIp9FQh
	 klo7Qn1iBlDsURn1RfVFqryqo1yJvaKtMPsUMFCfUmDxILKc4Ea29k0LzPQCinsdBHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=PcvY35YW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZKmMOCmM;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6D606A329
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF6D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=PcvY35YW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZKmMOCmM
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 327B7EC0191
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:52:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 15:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793998370;
	 x=1794084770; bh=DI68O0X3RB/jvXr8h6qOIGncG3G3gqaeml4OgW4iOEE=; b=
	PcvY35YWH6Du/gCafTao8iOZjmTLwWOVKzghULOCwxRJDepwHq5SEXZgDjhp2YmN
	Mczq8tEtam7bb6F11NAjdemUzEg7WBYWDdz7b9e9eVbl3gJy/4icG1CbYZZ4IvJW
	EzT0n15ww8oTyyl1kb/PIVTYOevzJfWyYFuXWFuTiu0N+vTEosrH8eXrcyblP4BW
	r6U71LrA83YcsF8DNZ8mLXSEX+XM87JLo1WrflYjh5ULnf+fr19CnoqSiLWx/SDt
	m1TCMCcgDTGQZziQuXeJvel0Mu53eeZiKOtoN7tQ8iC5Ie6lfLTcpIuMAv1cH+aj
	L2FsoGkSiDwfpDaFRhjD0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793998370; x=
	1794084770; bh=DI68O0X3RB/jvXr8h6qOIGncG3G3gqaeml4OgW4iOEE=; b=Z
	KmMOCmML5eN4wvqkIgXX8D7nNZgEuIUCuFe7kzARN8GKe99ZFIIl207mXcKbSEv/
	BnToq5+sgvh/FWRxLQLwqqxlBIeqFO+5qA1QPzFNQ3e6UGUhSHn8fb3rj30/TcC+
	WJsyeQoNOdTDpzNVdCQ7CKtrsXCa2mvycmqQKFJ+jEjLoiA47kb+dyCMtq0vSN85
	1vMbwveDH+YpK14phRJr/zVjmyr933EGuZLtnzUJf/roWOFFzlLA+fOQ0EkwQ7EE
	o5UM+63iBsfUrQlFLSNfe4tNarSMxfCjoNMRT7s2Y2DgorDF2P7fxoWicJAMXYuG
	QtivnVCwzT5/+JWPhEOTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793998370; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EOdzctnKQ5S9e2ZIcQH0q+fzJ+CWC/bUpAHy6NnMrBbBYA+
	ERasqSAC/coiKM8oyQPiKSPSb55QhVEdcSvZ5U/vtPrBDIlTp56nB/HEEBoPJC1u
	UtWwxPN2o2Ii+jSPdIMx5XVmADR2K4PuIGVO1PlSltPWfEdb9nbatgIRroIx5XMN
	NaiqZqLE5P63VFY7sYMlOMmFnb8egVvdhaUM9AGyGaRoMpcInIS8dOnJpYDfjyix
	NL7JkMBIwSYOKTJVqqeOVQ9OMe8d5/NUq2kvKQSw3CEtIWx/fJpI0DSnvpPn6NXA
	Sz8T0k2H1timzJq6UZUmBCdxJVT5ox6MmO5kfqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JlV29eQ9Ey6xSHV8ni9oTZHE4eweDtFxopLH4TWcwP4=:va0vdCyusufdfSq+B2ZmcLdvPoQ4pqTqrJNg8au0qYY=;
X-ME-Sender: <xms:IT7uanLeayqQ7DVrELXhyBB_TM1Ef_4FS0UgXLkqbDxXz7w976GkhQ>
    <xme:IT7ual-0GLZ2AsTD9KXSm22KZeDOqZ1fOpfeZOIIaVX183tOrZ1tPrjF7Qc6FZ3kW
    gqgiHF2ylIXJqJH-PmvNDzNyfYWkE0mUPI7Y4bfaQfW3OE28Dl3JA>
X-ME-Received: <xmr:IT7uat_yTTYLhkcdeim5Lod4HPghLTf3SAw-l8LtY9DA_rf_Tvjnl650qqfr3w>
X-ME-Proxy-Cause: dmFkZTG3ELfz1HMYilg74EaAvzptHMUfC/ybskUvnsHdFUyYtIj+CatcaN0RoFw5cE4Jq4
    uqqKuKvggY98V7NPM7fyvdzk/WptIGtF5ANhhp9eW4RXRlON7oA8CjAY/ER6Ga9ZH71/UQ
    7BGmSdDbBP8fblvnU6n2d7GOhvDWCTh3bZU6nz8YF1Iw7QrXH/X9o2DBzDXNlhRoEHf1Ro
    9BZ8n4AYFcbR4OWj/Rtay3IZmP9AzvX2yNWgjVkET5nZ9J7wt/Wbnpuc96R7069p31O6hZ
    QrNAOg6cqZdm50VCeIVbFAKGMLAOpGIaHOWVtBCWEdYbqtvAMuWIQQEWIylhgHdLRhKyNG
    kSnpXXqZPWWuDmamcEXDih2jKI6JeTV5ycsRHBoVCSC72WKEyrJXvi/EXLR4MDH4nZ+W3G
    9oHGtpg7/4oKhoL7xXS0JdYhK7IAwllR9xk7MdVRB80nZTMZ6rURco+l//r9/jfkn6O3R3
    3NLb6VOoDL0CbwIhn+WuvFdiebw4WDWazKGaaFH7pbIyCk76YRereTpLI4t2eKdxaug0EE
    WXWO/2gKZWxNAIdjghMz7jilGQ+bU7Gf/UM5uiie6UJ1HZuc+V9Ad7Jq0XsLOVmoQzG2a3
    YlHURpwYLcsHnoZbtnue9Aik407XqcM/K9471PhTwt1gA3gjt60NVK1JPxJA
X-ME-Proxy: <xmx:IT7uav964Hga9-J9speWrNVFSCuWOuJzoeJHoz3eyguHNPaQc-L5Cw>
    <xmx:IT7uaoL5uI5mefie3DtZ8HiN-ndSadyHOqlIFghA5fHmhUPLbn_LdA>
    <xmx:IT7uakRTo79983alZPUEfZiKbs8yIOugv2IOXEMk_t7FR5w7kDHNiA>
    <xmx:IT7uah-oXs2lCD_8by5Fcp0xGVEbLmtiYTOwmaXXMVW4-Hx89yRCGQ>
    <xmx:Ij7ualyd7aOSUnPtmOrSzM2TRz7pz5jro_A5NG05sBdjo7gnAleEQPiz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 15:52:47 -0500 (EST)
Date: Fri, 6 Nov 2026 13:52:45 -0700
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 10/31] vfio/pci: Refuse ioeventfds and dma-buf
 exports over excluded ranges
Message-ID: <20261106135245.2870aebb@shazbot.org>
In-Reply-To: <20261016161839.2765592-11-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-11-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:17 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio_pci_bar_rw() keeps the excluded ranges of a BAR off the device, but
> two other paths reach BAR MMIO without it.
> 
> An ioeventfd writes the BAR directly when it fires, through
> vfio_pci_core_iowriteN(). Refuse an ioeventfd whose range overlaps a
> write-excluded range, as one over the MSI-X table is already refused.
> 
> A dma-buf export of a BAR range lets an importer map it for DMA, which
> reaches a range that the BAR keeps off mmap. Refuse an export whose
> ranges overlap an mmap-excluded range, so the dma-buf follows the same
> rule as mmap.
> 
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |  4 ++--
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 14 ++++++++++++++
>  drivers/vfio/pci/vfio_pci_priv.h   |  3 +++
>  drivers/vfio/pci/vfio_pci_rdwr.c   |  9 +++++++++
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f099a294af34..211fff6045e2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1107,8 +1107,8 @@ static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
>  }
>  
>  /* True when [start, start + len) on @bar overlaps a range with any of @flags. */
> -static bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev,
> -					int bar, u64 start, u64 len, u32 flags)
> +bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev, int bar,
> +				 u64 start, u64 len, u32 flags)
>  {
>  	struct vfio_pci_excluded_range *range;
>  
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..8606c15ab2fe 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -260,6 +260,20 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (ret)
>  		goto err_free_ranges;
>  
> +	/*
> +	 * A DMA mapping built from the dma-buf would reach a range that the
> +	 * BAR keeps off mmap, so refuse such a range here as mmap does.
> +	 */
> +	for (u32 i = 0; i < get_dma_buf.nr_ranges; i++) {
> +		if (vfio_pci_bar_range_excluded(vdev, get_dma_buf.region_index,
> +						dma_ranges[i].offset,
> +						dma_ranges[i].length,
> +						VFIO_PCI_EXCLUDE_MMAP)) {
> +			ret = -EINVAL;
> +			goto err_free_ranges;
> +		}
> +	}

This should be rolled into validate_dmabuf_input().

> +
>  	priv = kzalloc_obj(*priv);
>  	if (!priv) {
>  		ret = -ENOMEM;
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 53544e0cbedf..09a68c99b43c 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -52,6 +52,9 @@ struct vfio_pci_excluded_range {
>  	u32			flags;
>  };
>  
> +bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev, int bar,
> +				 u64 start, u64 len, u32 flags);
> +
>  #ifdef CONFIG_VFIO_PCI_VGA
>  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 93823c6391f6..ef098f0b1401 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -476,6 +476,15 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	      pos >= vdev->msix_offset + vdev->msix_size))
>  		return -EINVAL;
>  
> +	/*
> +	 * The ioeventfd fire path writes the BAR directly, without the
> +	 * excluded-range filter of vfio_pci_bar_rw(), so refuse a write-excluded
> +	 * range here.
> +	 */
> +	if (vfio_pci_bar_range_excluded(vdev, bar, pos, count,
> +					VFIO_PCI_EXCLUDE_WRITE))
> +		return -EINVAL;
> +

The code immediately above this is still performing the open coded
exclusion based on the MSI-X range, which is now incorporated into the
generic range exclusion.  It should be removed.  Thanks,

Alex
