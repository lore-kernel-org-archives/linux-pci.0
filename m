Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1513126B2;
	Thu, 23 Apr 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973257; cv=none; b=ZzDDYbUAA2RoN1WwEkMp6DFF6hmmZZyfpNpO6qJgLMXUxEimIG9jJ7H8/6zTKu7OrGo5TGyzONx1qUMM15jkLQaQxiFFv7jSvHVgrTnvySxUcsuf+Ekr30RQLhBG+g0QI9VMmUboMPLP6cnhXUUDXbaDrXnT4Y7gQMB7ogjD06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973257; c=relaxed/simple;
	bh=nJqu9gsYfYmWAZCaOClg4DaYAEsN+5fB4HjCMJirMPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNYMYKLevyZqAB6QgxRtkd51kgLw13R9fHySce+m0oCsEb5YMKUC3H9K5JzGjiJwvrTZpg6ysUZaToGV4Bu6pqr3V516LcKvCeCWnYg5AmEkoB/572CsQysOQjuPUXlEJFidn2mT9kzCL1xhYuZQ+U6R8iWEOYzSRwMY+9VO8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=bMhsBi1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tf9/upFY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="bMhsBi1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tf9/upFY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A6BE1400129;
	Thu, 23 Apr 2026 15:40:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 23 Apr 2026 15:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776973254;
	 x=1777059654; bh=zCMKY/sFtkVHt3K1ICDRla4xyL9PgUE/tI3XoOzsjn0=; b=
	bMhsBi1GN3q8l5XGbogOetqMo+BRjAzz6IacIhj2YVmZSEieNGdwoRGcOGQGSG/i
	Bv00lurSNJpMGG/ZuVjn/g9sJeWjOQi4MynhupmN4hLhH/GPjmZ+IcLM48MMDVaj
	CBzxJKgK1ExEHdOoP1147Ik+G217lJTWpd3ZbhI8vDJ6rhDRrWPieItDQ2QEN68b
	dHae2r18qMVXtcpGViOegIFuqD91gzZ4S7Wzqc7BV4USNtmq2IqjDM5ZkDjMra+W
	AjCbMBmIVfkSkRtMYBDVJUlJWD3/lbb1Wb4HCRqqy1VeBVyoG+5fe8vO5Mdj37y0
	WoJ0kCv5RJLHdzhZ4U5stA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776973254; x=
	1777059654; bh=zCMKY/sFtkVHt3K1ICDRla4xyL9PgUE/tI3XoOzsjn0=; b=t
	f9/upFYtKwbmyq+uqH0URbBKSoHWyUoRxe3X0qiwPREwo1JBqLlY9EZbfiZRhn2/
	+YvlrZ2qCpYq1lpN85TtoJa9Fk7n+dxGCqjK7F0059VK9LyXehhqEdovd65094CT
	UUztqogRgUNvWAg4XYG5XX+r/HL3fXCsh7kixrbkRQw8X8A+ZyL8AHjVZgY+cl4Q
	O0VFv8DZsCev8mPxTbSe0CtOwUnRgIyLcQ3sAnAIIsSk+hTRQL+BPdbwNvtfh1w+
	VdKyDc2y6Y/S/mzTiIT8lZGIbj5GS6KseDoDr2nGlSC4bc6q99OhKuekQZJYlLHf
	amINU9pXdTFH+X23yZGYg==
X-ME-Sender: <xms:xXXqaYtoVo2jQWEhVg0-yOE-RPB6vSIgJBbkiMrjzJKjK63sYCM1Bw>
    <xme:xXXqaV4bfcuEy4cz38ZdFGxgZrQRX7uWvgBltup1LWnmBJrk9W1awdl7-dSvwXZvd
    Z9usdty4iTuMS2v_kiYnNNhNN8LmhQJPby3EnAO2rKZsJ1yVV7AmA>
X-ME-Received: <xmr:xXXqaUcXipK7mk-kF36CDBRlp4A6e42HlvVpfQQvj4pRRBjRIXu4DUKvNGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikedtvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:xXXqaSya9fSwqrh-kHVS8u6HIlFlJY93bJ6sdEwGnusUPqMSQShrJw>
    <xmx:xXXqaZ9lTLHnpcF0ey3EI6jsG11W-5Ym1q-ME6JZc0tYQdLE67v5wg>
    <xmx:xXXqaQwg3eE6kC0JHAPWp00G-LVsHyov87zJQAxNlo9XxBlVO0eVIw>
    <xmx:xXXqaRpFHyW_cIIVSQ8YpKZLOBuF0WkNWgjxUkybYCNHUOVbuN4mNA>
    <xmx:xnXqaQjWGeyZAycgGqfhdRsm5W14wge_nUifTWWjz07oXGcoHQbq5vrs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 15:40:53 -0400 (EDT)
Date: Thu, 23 Apr 2026 13:40:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
 <logang@deltatee.com>, Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v2] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Message-ID: <20260423134052.292e92cf@shazbot.org>
In-Reply-To: <20260423173051.1999679-1-mattev@meta.com>
References: <20260423173051.1999679-1-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 10:30:51 -0700
Matt Evans <mattev@meta.com> wrote:

> Extend the checks in pcim_p2pdma_init() and pcim_p2pdma_provider() to
> exclude functions that have pdev->non_mappable_bars set.
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
> == Changes ==
> 
> v2:
>  - Also test non_mappable_bars in pcim_p2pdma_init(), as
>    otherwise pci_p2pdma_add_resource() will WARN_ON
>    pcim_p2pdma_provider() failing.
> 
> Niklas and Logan, I didn't re-add your R-B from v1 as (splitting
> hairs...) the code's changed.
> 
> v1:
>  https://lore.kernel.org/linux-pci/20260421174351.3897842-1-mattev@meta.com/
> 
> 
>  drivers/pci/p2pdma.c | 6 +++++-
>  include/linux/pci.h  | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c898542af8d..adb17a4f6939 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -262,6 +262,9 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
>  	struct pci_p2pdma *p2p;
>  	int i, ret;
>  
> +	if (pdev->non_mappable_bars)
> +		return -EOPNOTSUPP;
> +
>  	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
>  	if (p2p)
>  		return 0;
> @@ -318,7 +321,8 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
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

Reviewed-by: Alex Williamson <alex@shazbot.org>
Suggested-by: Alex Williamson <alex@shazbot.org>

Thanks,
Alex
