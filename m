Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2D38F940
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094842; cv=none; b=Hm2TuFbIKXqoHyENQBa//+BCoT2uqgCFf+iAAuzBScJ/hNZg/KJ3RkttxFwpX2qteP+ergdP/JI6X7i+GuTTiXl6NT2XycURgZoNZN74N7v+Qu9W6KE0Ry9Ovq2vGUdB62tGc4E0LjEk1QXWzfUkvcR2oS+58V2NmDmb99LrbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094842; c=relaxed/simple;
	bh=NlP9xCBGAa9xOu0QWJvkx3e4v8XRqwAHu0qR6A3EW04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sTAWLrfodmKQInqRDgQo9g4+o0uBk9oAaLx570JjNg2mPi+N02lwMgXAFBvoHYzG+a6eZCvVteRgNe6d6C72lEX5M9ZVvK4+Q8RM8awcQnF9+GJX8Uky7wtlz+0espAk4nzU2pvv8m9UN0n0p2iQP8tdlpxrNJmDREasEckBLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1oMsNnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1oMsNnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7716C4CEF7;
	Mon,  9 Mar 2026 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773094841;
	bh=NlP9xCBGAa9xOu0QWJvkx3e4v8XRqwAHu0qR6A3EW04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E1oMsNnbdt1Lbh5ZtUjI/Rb+TUAWbQt9bfoy6ky0JUAMheaRQOdHi8TMzQ+VpScoS
	 WXjpNfCU+/yrBmGXWN4tAtXO70VVJaUAMOgZFQjkQdstduulOWExnB5scAeE9FUyC5
	 v05tcI/flH4iqIUoXCq16zSADJ3RuOHaZsXPnm5P3heN1AvG5qzXBauXQSJFK3WgSv
	 Oqax6NtVgFz3k6dUMxkNiEjQ4KngW1BrWJI2VTi8QQ6GZ+zsopOaOAWbb1PWudGEPQ
	 8w0eU+wL2ATyQZNknDaRIsCV7Xk9Hi+Os8SOsgKnOE1ec1QNbSPXvOIp4EV+Tf+NQj
	 M8YO7sZp41sEQ==
Date: Mon, 9 Mar 2026 17:20:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] PCI: Fix incorrect retval type in remove_id_store()
Message-ID: <20260309222040.GA624676@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224181434.1368066-1-alok.a.tiwari@oracle.com>

On Tue, Feb 24, 2026 at 10:14:29AM -0800, Alok Tiwari wrote:
> remove_id_store() initializes retval with -ENODEV, but retval was
> declared as size_t. Since size_t is unsigned, the negative value is
> converted to a large positive number, breaking error handling.

Does this actually cause a problem?  size_t and ssize_t are the same
size, so I would think the conversions would end up with the same
bits:

  (gdb) p (long)((unsigned long) -19)
  $1 = -19
  (gdb) p (int)((unsigned int) -19)
  $2 = -19

We have lots of sysfs show/store functions in pci-sysfs.c that return
size_t values.

> Use ssize_t to match the sysfs store() return type.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index dd9075403987..b2d3dffcc4f3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -261,7 +261,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
>  	u32 vendor, device, subvendor = PCI_ANY_ID,
>  		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
>  	int fields;
> -	size_t retval = -ENODEV;
> +	ssize_t retval = -ENODEV;
>  
>  	fields = sscanf(buf, "%x %x %x %x %x %x",
>  			&vendor, &device, &subvendor, &subdevice,
> -- 
> 2.50.1
> 
