Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7E13B7AE;
	Wed, 29 Apr 2026 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495773; cv=none; b=nSOb5wt3IBmUNRgbQMVGeH2DKFxXLNXQHmtPQ3BZH8wvk+6nYrdcgWyigfFxBeOZCva6YSxL4SwXQcYxK2+c5iL1eM6gv7eCKT7N0lvFiGjww1/0QHSagS6o7pmqt4DQhPauXChO7iWyp1m5hqj207N6ttXZhO+7AdaQ9zlK9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495773; c=relaxed/simple;
	bh=hhWce80xtkHe1p6XGUP4jloFGHxw1eJP7unPLtQxBLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iJeqbfQvbKTzy5mgAsBPuSlFX4PioAd/pl44Ttpxm9fRFWgKcK+nd1TL2fY1qLuw/aRAL7VVfkwgPDsPu8P8AKEHs+o8uYpiLXBBBJjr9WubNsbzbrsRxBH8pp9m+6zKGlsZ12YDAIEDbfPYOsGh96XP+y7sQZlBE4R306Cw7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttxcvPt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttxcvPt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47799C19425;
	Wed, 29 Apr 2026 20:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777495773;
	bh=hhWce80xtkHe1p6XGUP4jloFGHxw1eJP7unPLtQxBLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ttxcvPt7HKlxoKj403eCf5tce8r3HsoFRNryWFmrlcsSscvbNHulMxO56IvyZfAPp
	 F6h6h/FLoE43FcJYCBVgPdkZHXZ7GrmpB4AxkPXMUnmZ5BNxMC9vBNvOdQWxdsUtyq
	 GoUP3yuxup6mW4bzGir/gbkaRyWhGIxIbwoDrlP5TPQPuvCio/k9tvSkKwxUyxwGhz
	 Nc3+JmQLjgQ54OK6iQGpFlav0GRDTal7uBh+EEP0LCMTbQAKTB35si5hVSv8uvIjMY
	 8Hf2NXDzcs0JB4o8Idxb2f5Fpr+Q1JSYM9ipPNerga22zTFLvrVEfxgGMUnq4YudZz
	 R/QHbikzguxiQ==
Date: Wed, 29 Apr 2026 15:49:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260429204932.GA318462@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422161407.118748-25-kwilczynski@kernel.org>

On Wed, Apr 22, 2026 at 04:14:07PM +0000, Krzysztof Wilczyński wrote:
> The resourceN_resize sysfs attributes allow users to resize
> Resizable BARs (ReBAR).  After a successful resize, the resource
> attribute groups are removed and recreated so that the updated
> BAR sizes are reflected in the sysfs files.

Out of curiosity, where does this removal/recreation happen?  I don't
see it in pci_resize_resource() or
pci_do_resource_release_and_resize().

> Resizable BARs are a PCI Express extended capability
> (PCI_EXT_CAP_ID_REBAR), which requires PCIe extended config
> space.

It sounds like the fact that ReBAR requires extended config space is
important somehow (beyond just the fact that we can't discover ReBAR
without it)?  Is there some connection between extended config space
and mmap?

> Every PCIe-capable architecture defines either HAVE_PCI_MMAP or
> ARCH_GENERIC_PCI_MMAP_RESOURCE (via the relevant arch headers
> or the generic asm-generic/pci.h fallback).  On platforms that
> define neither, the resource files are not created and the sysfs
> group remove and create calls in __resource_resize_store() are
> no-ops.

What's the connection between ReBAR and mmap?

> Thus, move the resize show and store helpers, the per-BAR attribute
> definitions, and the attribute group behind the existing #ifdef
> HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE guard, and fold
> the group reference in pci_dev_groups[] into the existing #if block.
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b167e32d55ac..37c1990124d0 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1690,6 +1690,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
>  	.is_visible = pci_dev_reset_attr_is_visible,
>  };
>  
> +#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
>  static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -1804,6 +1805,7 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
>  	.attrs = resource_resize_attrs,
>  	.is_visible = resource_resize_attr_is_visible,
>  };
> +#endif
>  
>  static struct attribute *pci_dev_dev_attrs[] = {
>  	&dev_attr_boot_vga.attr,
> @@ -1878,8 +1880,8 @@ const struct attribute_group *pci_dev_groups[] = {
>  	&pci_dev_resource_io_attr_group,
>  	&pci_dev_resource_uc_attr_group,
>  	&pci_dev_resource_wc_attr_group,
> -#endif
>  	&pci_dev_resource_resize_attr_group,
> +#endif
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> -- 
> 2.54.0
> 
