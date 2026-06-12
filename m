Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EC3803DF
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299377; cv=none; b=Hk7G1mdTxBv8muek0U8q49IVTr8aEgnpOga2g6AKC1vhiR7f2DLN/NZHWA0O/EMHbds1bjloXlzv6MlAH3XB/k0uTbDX1HkwE8aUXVLkrH3UDOJ+tgeoSXSsiwMa1ZIyzws54vrZjbsJmhrYGDO+ebunZRIrGlVo6v2AMj1Innw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299377; c=relaxed/simple;
	bh=iQ2oQDd2CEmSBVLp4KyDIoCjIcaSbRwF9M3FexENSDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VpBTgzFMVp/zvvvwK9UOHB6S9uTUvNjtUQXfWjOSFnq/i1/6plGC8eSEYeaLgaBSLXTCe+farOpy6f/c2nwfsxU6xtvXEAkqjIF7r1YGFHAThc6cWjS8Pv4NkeqeycD6IWLm4Cn28v21+wKFMsIvDPhSBvOaaWQi/Yto08+P9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5CTGniD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5CTGniD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D741F000E9;
	Fri, 12 Jun 2026 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781299375;
	bh=NmSN5YjVOiGhKhptKKJ8ykB5UUwfrS9fJ/YjQMJKoYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=b5CTGniDjCdEKQBaJydWCudA+RmlggnL8G7uBVuuVOnhzphsmgzF2rXUtjpeYGoQq
	 JnTTktbYjpwL/TeHTOO1HmsgzPRfprigM/O+7EjorBdcB6VGO5n30oMPdIWbixFMB7
	 p6FORJJ3B3D60v7DY9ITRxLjk8z7iOIHQ4Q2bUiRNtl1BQE357l7WJUmun9y66nn71
	 LoO5C52DTn2r21sPAA48qY9RUEheX+y2ZkVKdipCPlTqfmLxu2q+BMlhbr9pCGqLp+
	 7lWJgJKZ4/SE0F5pAkvU6+xH8p7hp+1HECKpHhQK4/JQBzy2BmY4NpuUp/U3G5SY9F
	 H+xkAaOCht9KQ==
Date: Fri, 12 Jun 2026 16:22:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Use kstrtobool() to parse the ROM attribute
 input
Message-ID: <20260612212254.GA659826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612182448.552406-1-kwilczynski@kernel.org>

On Fri, Jun 12, 2026 at 06:24:48PM +0000, Krzysztof Wilczyński wrote:
> pci_write_rom() controls access to the ROM content through the
> corresponding sysfs attribute, and treats the input as a request to
> disable only when it matches the string "0\n" exactly:
> 
>   if ((off ==  0) && (*buf == '0') && (count == 2))
> 
> The count == 2 condition encodes the trailing newline that echo(1)
> appends.  This was found when software in userspace wrote "0" without
> a trailing newline aiming to disable access, which failed to match the
> condition above and enabled access instead.  For example:
> 
>   $ echo 0 > rom     <- "0\n", count 2, access disabled
>   $ echo -n 0 > rom  <- "0", count 1, access enabled
>   $ echo > rom       <- "", count 1, access enabled (likely not be desirable)
> 
> Thus, parse the input with kstrtobool(), which handles common boolean
> inputs such as "0", "1", "n", "y" or "off", "on", with or without a
> trailing newline, so both of the above disable access, and update the
> now stale comment.
> 
> As a side effect, input that does not parse as a boolean is rejected
> with -EINVAL rather than enabling access.  The documented "0" and "1"
> continue to work as before, and rejecting malformed input brings the
> attribute in line with how sysfs attributes typically handle it.
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Applied to pci/sysfs for v7.2, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260..1ddd6be25d95 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1309,18 +1309,19 @@ void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
>   * @off: file offset
>   * @count: number of byte in input
>   *
> - * writing anything except 0 enables it
> + * Writing a boolean value enables or disables the ROM display.
>   */
>  static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
>  			     const struct bin_attribute *bin_attr, char *buf,
>  			     loff_t off, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	bool enable;
>  
> -	if ((off ==  0) && (*buf == '0') && (count == 2))
> -		pdev->rom_attr_enabled = 0;
> -	else
> -		pdev->rom_attr_enabled = 1;
> +	if (kstrtobool(buf, &enable))
> +		return -EINVAL;
> +
> +	pdev->rom_attr_enabled = enable;
>  
>  	return count;
>  }
> -- 
> 2.54.0
> 
