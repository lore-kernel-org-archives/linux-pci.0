Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6931EB9E1;
	Thu, 19 Feb 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512028; cv=none; b=NFPPw3w+7Xxd5GBfPcw8Ez0PID/uTR0E6tbTcJbEniM53qR0mP6DnHIkXzczwrKw2pfgGukyc8aG/EvPEd/JpC5cXiPOkFvJYZZeJ7fSZxRROplDGp17K8KAsSq1yOolFF94ueWwKplgA7jkvUlrQrMs6OJJM6qAV7tEyxuveoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512028; c=relaxed/simple;
	bh=OPHHr3yx9B9GJpe9JF2InVCGHbzzW/H0JaXbZAaUPhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf2b/zYeylqTMsPm8KDfLuwXefS5lori4u9Z3tnZ4HcS3cERzRNqDMVaTn+vuN+c0l+l/N7CjoYTvQJjSolpqFgCvBLNpWzS01EI5eJVIx/5oKnehqwjdzJo1FFUnw5KIRFPdyG5gZEjOSPsRK2hxGHX2oTv/J/2XaX0t4GSZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IU/s+go8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IU/s+go8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7670C116D0;
	Thu, 19 Feb 2026 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771512028;
	bh=OPHHr3yx9B9GJpe9JF2InVCGHbzzW/H0JaXbZAaUPhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IU/s+go8GuvUjzTrJNg1E25yPSossDIdGq0aavjBTp3xkty2MDXeCxyg7W+mzJYFe
	 npy1j0rQveiiHCQwVWCsQpGis5aoobefhG/uvYKzN1lxz1B1GrVI0UpBO/j57kI03B
	 eFs5eFgI2AaI4S4cXzt/S1fwnSTU0HQlD6AL9Ais=
Date: Thu, 19 Feb 2026 15:40:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, dan.j.williams@intel.com,
	Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com,
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <2026021944-material-hardhat-c508@gregkh>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcbBt7OmNeH3oA0@wunner.de>

On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> On Thu, Feb 19, 2026 at 08:41:19AM -0400, Jason Gunthorpe wrote:
> > > It has turned out to be super convenient to expose the 8 slots with
> > > certificate chains in sysfs for direct examination with openssl and
> > > similar tools, without having to go through netlink.
> > 
> > Honestly, I'm reluctant to add permanent sysfs uAPI just for temporary
> > debugging. Put it in debugfs.
> 
> Exposure of the certificates in the SPDM slots is not for debugging,
> it's just super convenient for day-to-day use.
> 
> > Having to find/remember some baroque openssl command line with a
> > million options is not reasonable for a production kind of
> > environment.
> 
> Personally I find something like the following neither baroque nor
> unreasonable:
> 
>   # What's the certificate chain in slot0?
>   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
>   # Fingerprint of root cert in slot0, does it match what vendor claims?
>   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> 
>   # Looks good, let's trust it:
>   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0

As much fun as it is to abuse sysfs, please, let's not do this there.
You just did something that could have changed the device between
storing, checking and then trusting it as the device is never guaranteed
to remain the same across multiple calls to sysfs (i.e. yanked out and
another added.)

So let's not design in a security issue from the start please :)

thanks,

greg k-h
