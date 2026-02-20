Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A716330657;
	Fri, 20 Feb 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771588651; cv=none; b=dahQQFauEhqtsZNrBIQvRsQ3Fk/jIfAGcpEN/Wj7Mj/anTZjJqmaS88zc+WQ5VqJlpCTBRO4s1avh6DLWrOZxQfCIJ9vCgcUMnVkiqTcxm2RudkwtU3RfjUeZvAdER51Gf8T3bv7z3EQPXT+6LpZ81bxS+zcjfOebPvZ9zFrWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771588651; c=relaxed/simple;
	bh=SP2qW2lQ28/PH0jgBlbMRxu1FtYqM6Z9W2L1cfkLsvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAQM5Ibiz02oM/RH0mFY8GVFDX4Lz50on2eQbwBcqOspbslZHppYWK6RZBVz21/h52oiZCWIGb3yxKnVgNd3xShVbVgMRJBOyjJBwJ+rq27tbRYKzaQ38ZF2GRZgR5s3Unof/JLa6zUYSx5hThNpcND2jTxI0Hi4tJnTihkHzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keXlvNkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keXlvNkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F40C116C6;
	Fri, 20 Feb 2026 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771588650;
	bh=SP2qW2lQ28/PH0jgBlbMRxu1FtYqM6Z9W2L1cfkLsvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keXlvNkvRDDMs1PpK7nyuT1veAWnSWqiw7JJF93mmq9AqNqOhndkRwnZ++2T0epmk
	 bUzWoKiJwRc1O7yz7MXdcOLYrLb1xI+upB6GBMtFZ7klBLBaAqASZBNgdrHHQrMIm5
	 41eap8RNHzEVJEYaadeBAjinacGFYw5+nSI8d8wg=
Date: Fri, 20 Feb 2026 12:57:27 +0100
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
Message-ID: <2026022043-amplify-unflawed-9cd5@gregkh>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <2026021944-material-hardhat-c508@gregkh>
 <aZgRTT0woruvH-AM@wunner.de>
 <2026022028-upstage-dollop-ee16@gregkh>
 <aZhJTxQtrY3xDsRt@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhJTxQtrY3xDsRt@wunner.de>

On Fri, Feb 20, 2026 at 12:45:19PM +0100, Lukas Wunner wrote:
> On Fri, Feb 20, 2026 at 10:14:56AM +0100, Greg KH wrote:
> > On Fri, Feb 20, 2026 at 08:46:21AM +0100, Lukas Wunner wrote:
> > > On Thu, Feb 19, 2026 at 03:40:25PM +0100, Greg KH wrote:
> > > > On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> > > > >   # What's the certificate chain in slot0?
> > > > >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > > 
> > > > >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> > > > >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > > 
> > > > >   # Looks good, let's trust it:
> > > > >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > 
> > So if a device is removed and a different one added between steps 2 and
> > three above, with the same pci number, all is ok?
> > 
> > Remember, PCI device ids are not unique, they can come and go and be
> > reordered and reused at any point in time.  They are fully dynamic and
> > should NEVER be used as a unique identifier except for a specific moment
> > in time.
> > 
> > In other words, you are expecting that device id to always refer to the
> > same device across all 3 operations, which is never guaranteed.
> 
> If the user chooses to replace the device between steps 2 and 3,
> they get to keep the pieces.

So you are saying that is ok to do:
   - test if we trust the fingerprint
   - trust the device of a fingerprint we didn't check

Then why do step 1 here at all?

Perhaps sysfs just isn't the best api here :)

thanks,

greg k-h
