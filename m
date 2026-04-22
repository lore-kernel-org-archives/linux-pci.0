Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07120267B05;
	Wed, 22 Apr 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870113; cv=none; b=CvAzh6vrosi8aAg6qQrLUwrDbQO2FTJ4+KQtjgiI3jY7JTvUhhpbOnPozG6Rx7NEhBDkBmtz2fJXApQCuxtkd+tzTLuIwbgSja7Dqe2bHGf8IM6To8BzSCxCrZi5NCmYc8aiYtixhnaGCvk71CwG8gDI7i1Bi+GVCX8JG79MxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870113; c=relaxed/simple;
	bh=5za1Qa2r3jGUXiI+aKKQzUgVUw2yj3ACqVZ6IfmbBkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfjSgjo7vk/DT/mzNG1qmypX+BPzlsV286eEmOiaYibSIQmGM20uZ2kLaNVIdqmTrEufywZCFVimukeOSgKffQjs4y1QAMAma19eHbCp9+mgyVgPGKJwKQ0FbEb2hZllfe1OHFFLHFsUN9CrsWQ4/Xb8yuxmS4EM5wu2hvjawxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Wa+WHRfs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCbT5UeV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Wa+WHRfs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCbT5UeV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BEFF140001E;
	Wed, 22 Apr 2026 11:01:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Apr 2026 11:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776870109;
	 x=1776956509; bh=3zmVi2LhrzJd3wF1gCVRc/TZgEZBXHF1e7RvIlWo09w=; b=
	Wa+WHRfsNFZdj6lNH0gxcILd9/7+/hrMG3/H2LZzqc+6KeQJ33f7vo9+9xcUuGpF
	eGJpfFWUTmP7i0CZ4YBb4BhaHyw/CcATwlDotYDn4GJJ+uDkcbP4dg0m8jPO981t
	s440bzzAdN+YwFnFQEOC0MGQIf+vUJH+KLOMwa2rrAybvUuUlPp/qR2bQ8cmtOMR
	jq7JLjTW58N97xBRHiyqiI7s6th45iD6THuvL4RadoYN91w9XmavNYVMmeHk6wSD
	gr4KhvxSbCz6Co205CdHWyKSOGaOxyG3V/iNH+LnndFOb1u++VvAVli6rl9yEdO+
	ssupEG3zvmmMYwAJ5w1e0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776870109; x=
	1776956509; bh=3zmVi2LhrzJd3wF1gCVRc/TZgEZBXHF1e7RvIlWo09w=; b=e
	CbT5UeV9LourinI0GRMDRrdVHpks3rt93BBeC7j/vpMk/0kG+5GWMoSAihA1/cSo
	mHERi18RuEaqlpzmSamVNf20oQcVaNLCzY3H8H1zVdH51Q780I+k5/HuCwKSbNPg
	Luw+636rZdQR9T4HGgCyc6B6uAtsqRP2U0vi4wZqVwQdRu+dq/3YNNw+Xy95ui3T
	EGiMLGTTx0Pfbgi8AMzX/KLlxP3S+weuadSbvhpsOOzrqi3mTm1epmeKjgk2Cx58
	xXo90yM68E0PG9mb4HWazmuShbm2m2h4zvYIzQ48Oz3v3VbyrjvSX6SmS5pJazWU
	tURcVPt5g/Gicxg/XtgXA==
X-ME-Sender: <xms:3OLoafN8sN6tJy5KK90N4M0oxvF2EjhyVwlcszLJCASl1rwvx_C09g>
    <xme:3OLoaaY7DV0_zwRdliSLG0iB2nrc32R-_r9dydEOm0w4epFQ5Fg8E3vloN6vKo6Rc
    kgv-0_ESnziUNlOeOBIUQRvmN4rumeUsT-uR4PaekLjTLzF5sIbqw>
X-ME-Received: <xmr:3OLoae-FSDwqmxMSB7f2Kt_NR7zJkWNzPIziERyEJZKyqQamRhDI-t19gTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepkeehjeeitefffeeuieetjedtjeffvdelledvuedvffdvfeetgefhveekuedv
    fedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrth
    htvghvsehmvghtrgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheplhhoghgrnhhgseguvghlthgrthgvvgdrtghomhdprhgtph
    htthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidrihgsmh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:3OLoabSnVQX1xE5g-QuqofVMW3G2BG9BWTCl1GYdKgn7FeEABgaHOQ>
    <xmx:3OLoaYdYul9tNQKGUIt9y8w00KGeL_MsvPS0drQYjcDetkqQb6b9AA>
    <xmx:3OLoadT8yQxaVIaPVv5DkW9UVroe7WDBKIv2ECR0ZvipI40LIOl9dg>
    <xmx:3OLoaUL2tDJWHF5EhcEnnlvaAynEdtO5tU0Tp6e7mU4o40X2gnLyVA>
    <xmx:3eLoabCaC6891GpUJnudtg3YMAICpPfMsNPFdyKLv653l-OFXD3iXV4l>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 11:01:47 -0400 (EDT)
Date: Wed, 22 Apr 2026 09:01:46 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
 <logang@deltatee.com>, Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Message-ID: <20260422090146.6faf00f8@shazbot.org>
In-Reply-To: <20260421174351.3897842-1-mattev@meta.com>
References: <20260421174351.3897842-1-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 10:43:51 -0700
Matt Evans <mattev@meta.com> wrote:

> Extend pcim_p2pdma_provider()'s checks to exclude functions that have
> pdev->non_mappable_bars set.
> 
> Consumers such as VFIO were previously able to map these for access by
> the CPU or P2P.  Update the comment on non_mappable_bars to show it
> refers to any access, not just userspace CPU access.
> 
> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
> 
> This arises from Alex Williamson's suggestion to test
> non_mappable_bars when getting the provider, with discussion here:
> 
>  https://lore.kernel.org/kvm/20260415181623.1021090-1-mattev@meta.com/
> 
> The goal was to prevent a hole where VFIO could export DMABUFs for
> BARs marked non-mappable, and to fix for all users of the provider
> rather than just VFIO.  Alex observed that non_mappable_bars should be
> taken to mean BARs weren't usable by the CPU _or_ peers and,
> considering that, its comment about userspace access wasn't quite
> right.
> 
> 
>  drivers/pci/p2pdma.c | 3 ++-
>  include/linux/pci.h  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c898542af8d..4a783413f466 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -318,7 +318,8 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
>  {
>  	struct pci_p2pdma *p2p;
>  
> -	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> +	    pdev->non_mappable_bars)
>  		return NULL;
>  
>  	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..1e6802017d6b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -508,7 +508,7 @@ struct pci_dev {
>  	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
>  	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>  	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
> -	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
> +	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  

Should pcim_p2pdma_init() separately test pdev->non_mappable_bars
before the rcu-deref/kzalloc of the pci_p2pdma object and return
-EOPNOTSUPP?

That then invokes the same error paths we'd see if we simply don't have
p2pdma in the kernel and handles the pci_p2pdma_add_resource() path
automatically as well.

This pcim_p2pdma_provider() test is really then just suppressing the
WARN_ON that we'd otherwise see by not finding the p2p object on the
device.  Thanks,

Alex
