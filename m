Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0C503902;
	Mon, 28 Sep 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634415; cv=none; b=bFCID5i5LJtD02F1in5HHnhRd2ySbjrtrTN7zIDHV+wVlvqStsmOjwAZzIAqSU7aul+AHRh9B3aVbzi2/QQ+rqixNc0renm0waeh3WyUPyH3oEksJd7L+F3lsxN0W58icGSZt/AMNmnwJUGRK+UeJ18i4qz0hlY8yUWVjGHoE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634415; c=relaxed/simple;
	bh=0DBxCiH408Pe0fMFfF8zyo/f9bpP7Vr6FroWcHTkjvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KlsQgdjaPQR9Oj0CYq+ec7oPuz4hu3xFjnWx+MEYriEZ7P6w7vR3GN0+hGKQ8OYVke4mCB/lh3AMmIZVNZdo7AkSL79aZCBhHYCP5gghIdl1Rk4WuNhtbvnSvXgdo5WJhQXIjvhuncl34EFQRjiWI2qQqGUyfxUuUACO1Olp2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adtBzOQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adtBzOQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6481F000FF;
	Mon, 28 Sep 2026 22:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790634411;
	bh=U1dmN/zp44H2KfU4Iegnm1vOzdW2Hcje7Muo8x+avQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=adtBzOQD0BCFj1XagHswtxBjyOHynKVVQfNGDFWOtwJto5YmXKoIFGjqFEMMoSP53
	 MvIaiW6nJXWqqkGgZxiW7dtTv/Gz67QUVCgadGnaky0YeTi7RN0bFGEaZY1DMu0hma
	 Y8Z0UM8au2o7wz2cURz8ZUUHdnqd4aXtFZbkeyewmL7zFPlhvGgL7YGDlO4PWwZhRN
	 2elswE8P/uXy3Rb8ww9+KlIyOCvabaxUEbgz4QOLkgBbqfsueoEdNwWKFYOUiO04ll
	 N3Vk6EfDVU2mhjUhCSZaOMX4sRvom1+enlcRdQnOZAandwcy0EwkG3MeR4qsbjtYdo
	 1mjSHgZryr1Eg==
Date: Mon, 28 Sep 2026 17:26:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Odell <loganodell@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <djbw@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: fix building without CONFIG_PCI_IOV
Message-ID: <20260928222650.GA2268446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928161811.2846627-1-arnd@kernel.org>

On Mon, Sep 28, 2026 at 06:16:39PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added code dealing with virtual functions causes
> a harmless build warning:
> 
> drivers/pci/probe.c: In function 'pci_class':
> drivers/pci/probe.c:1902:12: error: unused variable 'rev' [-Werror=unused-variable]
> 
> Move the unused variable into the #ifdef block that uses it.
> 
> Fixes: 8a2a9fa37b81 ("PCI/IOV: Read VF config values that need not match PF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I fixed this similarly:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=virtualization

   #ifdef CONFIG_PCI_IOV
  -	if (dev->is_virtfn)
  -		return dev->physfn->sriov->class;
  +	if (dev->is_virtfn) {
  +		u8 rev;
  +
  +		if (pci_read_config_byte(dev, PCI_REVISION_ID, &rev))
  +			rev = 0;
  +		return (dev->physfn->class << 8) | rev;
  +	}
   #endif

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 833ce364f880..1ff07c592857 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1899,9 +1899,9 @@ int pci_cfg_space_size(struct pci_dev *dev)
>  static u32 pci_class(struct pci_dev *dev)
>  {
>  	u32 class;
> +#ifdef CONFIG_PCI_IOV
>  	u8 rev;
>  
> -#ifdef CONFIG_PCI_IOV
>  	if (dev->is_virtfn) {
>  		if (pci_read_config_byte(dev, PCI_REVISION_ID, &rev))
>  			rev = 0;
> -- 
> 2.53.0
> 
