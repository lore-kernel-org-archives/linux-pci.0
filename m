Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F88259CB2;
	Fri, 22 May 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423049; cv=none; b=KnNoYQ4S5iQawzyQmC4lS8V+XJ6XprLluzbJXSZu44scc4O4p8z9cdbMUeU+C8dOFofxir3B+1y+YtcICUxh/tF/2h//4LoJpHpp7bjBR/sbHejIZbdmNdDbP5g+1UTglSJiEja0GJcgu7NRX98/xBY0YG3muliBsCmGyPAgzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423049; c=relaxed/simple;
	bh=t3zReY/itlmvmkkAArGHFtlTECuSzMScJSFJShWVODA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5cMVSHtxAWGPOaStg0UZeP3XJH6ziLZDLSnMpxxey/JRIzjh+4X4g2o/IU4mzOm6Wsf+qs8bhZbdKrkjytJqTVTrqk74i8yGciSTFvjvSEBuj+/GhjJi7s/aQQDayIfffEEBtYFjPhvHCKlG83KfUtAqwbNfw5mQdyZt/VyWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=wpy8qxUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bsZbon5g; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="wpy8qxUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bsZbon5g"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B2631400109;
	Fri, 22 May 2026 00:10:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 00:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779423046;
	 x=1779509446; bh=bSPuAhV1qNgQANKsj6arLigZ2MFpysyIX8Y2BGex1Dw=; b=
	wpy8qxUgiVwBdxR/F51EOwRjU81I//ylUlfIIlpQDoegQjH1NgtBR2bBc07pZQwK
	zeIhqyGSnlrpO0kG5w75p7YUuFaGq/eWwBBIDQGqthE6Z6U1oF2GYWHsxE0o1BB8
	jtWTNHtl3Qtrae0/Xvu+2plQp3LwbCm9Djb2CZsVHOYTZZ7fcVw5OHmInTHGQIDm
	Urnsc53EPYa4IOr6wLkEeR3B3S0Gr5xN5/Lj5OxSt7PNEGdGI36cb25SeQjNK/Hf
	+gnfcTwNHyMyO1Km+91fZ05MuLNyqLNOTmcCC1DVqr4KQpwmadCykqbaOTmI+jgb
	MDtAxz2XKiE3/8DbMhEUgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779423046; x=
	1779509446; bh=bSPuAhV1qNgQANKsj6arLigZ2MFpysyIX8Y2BGex1Dw=; b=b
	sZbon5gEbwX4V9J+acsfAY5tF6sJm3615sQbz3f9F1ohXrr4qUAuCp5RbMfMxT8l
	rPvHzseVqeJT/ETVVCqvRa2076sKVni47Kn11nifujhzbtcIDUDRKUPUtK4VbGqd
	ELODUjgO6myMfUXf2S3FFUCZgXe2vhv5DiEgzSs6hKBfhbA14nSg9lAFHqGtfNLp
	xrfMekP3WWMnm/+x4D95PHFs0XHmql/X/jNg1bo7zlffUs24W2IhBZwFi9dVnZ80
	pA/wERKoWlusCtA14WWZ/HkfXXFpk7G+KPs9ioT38ne+8sNa5Z/afMyMKhscUDdk
	liE5qSa1YNRZrjenB2F1g==
X-ME-Sender: <xms:RtcPalf8FYi5iPmu2MK34jiM32IZO5ydUoDCShBAuF_uwqNhkbrp9g>
    <xme:RtcPahchvyYZds7On7Lo7KRdcvdbRKFKMWsmjufWMkNUeG8XsOhTYhQYfXkvAhr2A
    bQzQVlPqsgBeh9aNFcMaA_hNX_Dk4Q1is2wwD4If7l9aecMbTmz>
X-ME-Received: <xmr:RtcPan0EnqF9Bn89HLWf0aCFJ6g26j5okd39RTcf0hoTty26XXWewuuu7KM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghird
    gtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepfigrthhh
    shgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrg
    grsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvihdrhhhurghnghdvsegrmhgu
    rdgtohhmpdhrtghpthhtohepfigrnhhgiihhohhuudeshhhishhilhhitghonhdrtghomh
    dprhgtphhtthhopeifrghnghihuhhshhgrnhduvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtoheplhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RtcPah8KcUg_62GkDjehRmq0CyqWDoQbTehgL5kQM9QnxymGdbMdWg>
    <xmx:RtcPak5EmG2Q41MLUDleWv54jQPeuNJ30qRjADrxGBLGmhn_oJyViw>
    <xmx:RtcPahuUTNCzrp4TSoX76cBUU0vTJVsW10ywJh9ZDRAZfa1F-sL8fw>
    <xmx:RtcPau2K4DjSoSAehxOQmtXS1eVolDej3arleqShc8NkMd_WCU92bQ>
    <xmx:RtcPaiKElQI0Q8x0xkeRsUBQY7367B61weZz0w-CAcOlDoI0afe3AVSV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 00:10:45 -0400 (EDT)
Date: Thu, 21 May 2026 22:10:22 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 3/5] PCI/TPH: Add pcie_tph_enabled_mode() helper
Message-ID: <20260521221022.322c2af9@shazbot.org>
In-Reply-To: <20260518071701.25177-4-fengchengwen@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-4-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:16:59 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add a helper to query enabled TPH mode on a PCI device. This is useful for
> drivers like VFIO-PCI that need to validate TPH state before allowing
> access to steering tag tables.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/pci/tph.c       | 12 ++++++++++++
>  include/linux/pci-tph.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ba31b010f67a..91c1e83410a3 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -451,6 +451,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  }
>  EXPORT_SYMBOL(pcie_enable_tph);
>  
> +/**
> + * pcie_tph_enabled_mode - Get current enabled TPH mode
> + * @pdev: PCI device
> + *
> + * Return the enabled TPH mode (IV/DS) or 0 if disabled.
> + */
> +int pcie_tph_enabled_mode(struct pci_dev *pdev)
> +{
> +	return pdev->tph_enabled ? pdev->tph_mode : 0;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_mode);

Doesn't this create ambiguity with PCI_TPH_ST_NS_MODE?  Maybe return an
-errno if not enabled.  Duplicate same for stub below.  Thanks,

Alex

> +
>  void pci_restore_tph_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 5772d48ea444..28d0fa762146 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -28,6 +28,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  			unsigned int cpu, u16 *tag);
>  void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> +int pcie_tph_enabled_mode(struct pci_dev *pdev);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>  u8 pcie_tph_get_st_modes(struct pci_dev *pdev);
> @@ -42,6 +43,8 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline int pcie_tph_enabled_mode(struct pci_dev *pdev)
> +{ return 0; }
>  static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  { return 0; }
>  static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)

