Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755C494A03;
	Tue, 12 May 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577977; cv=none; b=NlKdktsZ9X2DANMYjvzGmZ1hgNXDHj1rfqFrF8c74Ns/emuN/6xA1nHau7PNSjeN/icYE3+SbXqLFRT33HeK6tpN+xr6hzNVxRZko7z/UzT3g2py+mJ5HSyef/srKQYi2sWimUArfaPvWPdJCcOLUVfbwy4Q7j/VLLDHkigMIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577977; c=relaxed/simple;
	bh=vfKSrpcubdpY8lQ31QLYySVIS7Rpbu70wGxhFqz4KiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3Ua7nNrbEZVBEy8uYvym+bdWsJGuxTmQ8Oaj3/PQNliwgjv+Iw00P4+PWSFpzYbhqsJGBKOdzlBUZEn/NOQiR3SqPSDPT/Iq3vrHE0rVRgAA2U20aWA3R0sQHZIGw4lVUVOYzCk5OG6VK/T2CCQpAMpmwgxy7UZ+QaNg7CDNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ4ty45y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ4ty45y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36151C2BCF5;
	Tue, 12 May 2026 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778577976;
	bh=vfKSrpcubdpY8lQ31QLYySVIS7Rpbu70wGxhFqz4KiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZ4ty45y57aDvb4grB6QBCvEh0PrRO3lH0YnPRxGLKw9WjiAoyO+jNsLTQcicHsNJ
	 Ue/Co6OzgRMGzdYo6/ZyKCibx1wpNy7duy+W+02OP27pgp4cDbaktLChDFNuHYfs57
	 x15LQRL5eU4z3/Y9MoqGy4AYOaQ3DgUT6yCvNk+i586WpK2Uo+b9PNF4TEAA5nbXiH
	 /xO1t/LDY+X+GCTwgHv8a1tQHqZWv8BtOJJ+OyYGYa2lX7uyqOGYYgjFBU0ZFVXx6F
	 9CGfGd5l6p84fLyfbpiJCy7UjksiZYiQoRQmEDSRYzKO26WRSwTDK2VHWuv2mMZoJm
	 gMvhWtTrkFb2w==
Date: Tue, 12 May 2026 18:26:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ravi Kumar Bandi <ravib@amazon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap
 handler
Message-ID: <20260512091848.GA1539393@rocinante>
References: <20260512084315.32564-1-ravib@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512084315.32564-1-ravib@amazon.com>

Hello,

> pci_mmap_resource() does not check IORESOURCE_DISABLED before mapping
> a PCI BAR resource into userspace. This allows new mmaps to succeed
> even after a device has been marked disabled or soft-unplugged by the
> driver to prevent further access.

Which driver disables resources?  Would this be some Amazon-specific thing
you are trying to fix?  Or are you just manually disabling a given device
using sysfs, or something like this?

For "soft-unplugged" device we have pci_dev_set_disconnected(), but this
does not check current flags set.

What is your use case here?

> Add the check to return -ENODEV when the resource is disabled, blocking
> new userspace mmaps of BAR resources after device removal.
> 
> Tested by marking the PCI BAR resource as disabled and verifying that
> a subsequent mmap attempt fails with -ENODEV.

Can you explain how did you do this?

> @@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
>  	if (ret)
>  		return ret;
>  
> +	if (res->flags & IORESOURCE_DISABLED)
> +		return -ENODEV;
> +

This probably would be better if it checked IORESOURCE_DISABLED and
IORESOURCE_UNSET, but then probably using resource_assigned() would
be even better.

Thank you!

	Krzysztof
