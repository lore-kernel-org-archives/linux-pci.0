Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29F3EBF28;
	Fri, 20 Feb 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578900; cv=none; b=jRvtWmN4foKpjZkRWjrZFu2seiHWuCyU6p6ZWsFzvZRzbyavzf2mIcQImakXcjxUJsyzhE3prjb/BN2wo/lf/B59GGgG6p15ma7dzi86Ue7fa50XHjFjT13Tm/6O9Phq7iHjJbHtWarXa+MShdwAchUJukV1Rj7x0CKQa1ypD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578900; c=relaxed/simple;
	bh=wuW/g3yRjC0OKrwp3pgODFGDF2SKgvTJiWvlt2FqPWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puSNkbakK/ZXos/gs4UvR13rnYkeWCHNoXF8yI73Ui53uCS9PCNzoQXx8tltFZU2eAdo6Jx0igykPRoQYhH3w8MZSPmPhNLXRFp9jqFXw4azUwqyhjjsbisSerhSLnV3/IT2iDB+Pb8hpUnC7ALdB/X/ipvuypDnDUtATn5IMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sR8X0HwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sR8X0HwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA00C116C6;
	Fri, 20 Feb 2026 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771578899;
	bh=wuW/g3yRjC0OKrwp3pgODFGDF2SKgvTJiWvlt2FqPWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sR8X0HwDjXIS1rk4UGFYf9dL3TQGY73pWwVA8vZmvNvqKehr1oEZ+2PCNiFux2ans
	 e5CKdhDTuXEXtKbnUgxEMBIbZj/mLJsN6gkDmA4PHQEQYOIfhjPq3qpiNp2a/xG4pf
	 Lb7jbyhvCK8YqiVybst8S+4pce1WXokyf2EhPHC0=
Date: Fri, 20 Feb 2026 10:14:56 +0100
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
Message-ID: <2026022028-upstage-dollop-ee16@gregkh>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <2026021944-material-hardhat-c508@gregkh>
 <aZgRTT0woruvH-AM@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZgRTT0woruvH-AM@wunner.de>

On Fri, Feb 20, 2026 at 08:46:21AM +0100, Lukas Wunner wrote:
> On Thu, Feb 19, 2026 at 03:40:25PM +0100, Greg KH wrote:
> > On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> > >   # What's the certificate chain in slot0?
> > >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > 
> > >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> > >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > 
> > >   # Looks good, let's trust it:
> > >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > 
> > As much fun as it is to abuse sysfs, please, let's not do this there.
> > You just did something that could have changed the device between
> > storing, checking and then trusting it as the device is never guaranteed
> > to remain the same across multiple calls to sysfs (i.e. yanked out and
> > another added.)
> 
> No, the kernel caches the certificate chains read from the SPDM slots
> and what is exposed in sysfs is that cached copy.  So all three commands
> above pertain to the same certificate chain.

So if a device is removed and a different one added between steps 2 and
three above, with the same pci number, all is ok?

Remember, PCI device ids are not unique, they can come and go and be
reordered and reused at any point in time.  They are fully dynamic and
should NEVER be used as a unique identifier except for a specific moment
in time.

In other words, you are expecting that device id to always refer to the
same device across all 3 operations, which is never guaranteed.

> > So let's not design in a security issue from the start please :)
> 
> The alleged security issue does not exist.

How is this not the classic definition of a TOCTOU (time-of-check to
time-of-use) problem?

thanks,

greg k-h
