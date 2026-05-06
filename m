Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D213B52EA;
	Wed,  6 May 2026 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105204; cv=none; b=n4nYOPHjySCII9a12cfOWS41zOibUP1WVQtF2wv4GCPQk9Lpz9aUXiVof9oY4wds8CQm3a+7hCNJR4YfFi8/7vktejXm4ghiE/vQXK5H7TdGuoEMPynUz9vw3ccP/1b2jd1rlNju/oxHGi3mp+kz8+NU3dYhh2Ws723dS+xCFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105204; c=relaxed/simple;
	bh=JTusYyNLA22gY11bCtDchSj/wTcpsrskdCGVYwigaZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOi2krMw655RKmbJbnnTvlflsJ/lsrcnkF2dy1KkiGWTFfS7B/nRfE1rKjeplbNcyYqAxryDN6pieSmAZP+pUB6a8HDSYj45R4PlJY8CS7VB14z1KTBFaon0cLjMLR0gJ2wBICpOPHSQaYRBdnFGo7ynPa04RFu0EHiwyjy1Xrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HljAvGz4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HljAvGz4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vTlOLeIdQpCjv7UhS84C4IGjj5+hiOQHx/OYcjnThOU=; b=HljAvGz4gMMAvypsS14xsOBZga
	dAW6uoihhLT7Lc58XydWuRc8nOcmhOKbzgw7/NjneYqQaoD40XPQ0NN8KcTnpIt2Ok45ah8reXArd
	+yTOflZbLHWmg64Dy9Gi+aDkapCp8jxAtgSpvlmtyz07tysZDWhl92zc8oO+EGwfj/lZU0fEEiEYS
	rXOdMztrrURxyyXAtLsC5LkbAvoDcN4Gsi8OqWMwuQDPyGEpWc3l6MM8ArlQ8YCs32Zau9fZzPyU+
	0g80BLx/nnAwGqO352bwqYebD/1RZnzKHioJlfK5xr5nwwNj9vCTh/fL5fNz/I1Tw1n8rpIQx+xsC
	xuUWtSAQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKkNj-00000002A0U-3R8g;
	Wed, 06 May 2026 22:06:15 +0000
Message-ID: <649c67bb-be03-4843-ac2f-19f4eeabef54@infradead.org>
Date: Wed, 6 May 2026 15:06:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] Documentation/kernel-parameters: Add multi-device
 config_acs example
To: Wei Wang <wei.w.wang@hotmail.com>, bhelgaas@google.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, dan.carpenter@linaro.org,
 akpm@linux-foundation.org, bp@alien8.de, alex@shazbot.org,
 kevin.tian@intel.com, manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439372F20062A8C25599FE43DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SI2PR01MB439372F20062A8C25599FE43DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/6/26 7:10 AM, Wei Wang wrote:
> The config_acs parameter allows configuring ACS settings for multiple PCI
> devices by separating entries with semicolons. The current documentation
> only illustrates applying one configuration pattern to all devices, but
> does not show how to specify multiple devices with different ACS settings
> in a single parameter. Add an example demonstrating multi-device usage
> with distinct ACS configurations.
> 
> Some bootloaders interpret ';' as a command separator, which can cause
> the parameter to be split as multiple commands. Document that the entire
> parameter may need to be quoted to avoid bootloader parsing issues. This
> avoids confusing bootloader errors such as ‘can't find command <BDF>’
> when passing multiple device entries.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 170aae226e2e..0c159ab59e14 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5277,15 +5277,20 @@ Kernel parameters
>  				  '1' – force enabled
>  				  'x' – unchanged
>  				For example,
> -				  pci=config_acs=10x@pci:0:0
> +				- pci=config_acs=10x@pci:0:0

Are these added hyphens/dashes helpful?
Are they needed for some reason?
I don't see any problem here without the leading '-'.
They (here and below) seem like they could add some confusion IMO.

>  				would configure all devices that support
>  				ACS to enable P2P Request Redirect, disable
>  				Translation Blocking, and leave Source
>  				Validation unchanged from whatever power-up
>  				or firmware set it to.
> -
>  				Note: this may remove isolation between devices
>  				and may put more devices in an IOMMU group.
> +				- 'pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0'
> +				configures two devices with different ACS settings.
> +				Note: Some bootloaders interpret ';' as a command
> +				separator. If so, quote the entire parameter to
> +				ensure it is passed to the kernel unchanged.
> +
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of

-- 
~Randy

