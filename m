Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95C2045AD;
	Fri, 20 Feb 2026 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587930; cv=none; b=bGo82lc+vJZrkhDP4mMAvEV/rGbopbjImWVBy4YTaw8M9Z/5/iAb+6Er2g3DO+SGVuSvlBrtUeuv/t8uDGV/wZB5LSYBCIRqYRzA6OuhpRXiWh5aOm5SZYfYWu2UwEaKbuobpBXnAZxwdQNpUCh0jtKB0SV3WOEW3EOJ07zciPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587930; c=relaxed/simple;
	bh=SulkP6+PfQG4DexfHMgTizwen4Gpni8L3ImOizm4iag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHQUFt0ymo1c9aWArUrowXGqZfHEZ8ZmsKXcr8JrGB2uF1GHfUqMFKNPatTTxCeg8UNFSzkQ2w5H9jX5n2QwgXQjBvxwGvFYuegO3VOYrbXNr3BOrfp+qrild2SU53vOGHVa+jo6iVbf0D9w/bSTfaAU4L1p/F4K+GmWYRgsHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2BED3202011E;
	Fri, 20 Feb 2026 12:45:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 020F5100E1; Fri, 20 Feb 2026 12:45:19 +0100 (CET)
Date: Fri, 20 Feb 2026 12:45:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <aZhJTxQtrY3xDsRt@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <2026021944-material-hardhat-c508@gregkh>
 <aZgRTT0woruvH-AM@wunner.de>
 <2026022028-upstage-dollop-ee16@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022028-upstage-dollop-ee16@gregkh>

On Fri, Feb 20, 2026 at 10:14:56AM +0100, Greg KH wrote:
> On Fri, Feb 20, 2026 at 08:46:21AM +0100, Lukas Wunner wrote:
> > On Thu, Feb 19, 2026 at 03:40:25PM +0100, Greg KH wrote:
> > > On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> > > >   # What's the certificate chain in slot0?
> > > >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > 
> > > >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> > > >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > > 
> > > >   # Looks good, let's trust it:
> > > >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > 
> So if a device is removed and a different one added between steps 2 and
> three above, with the same pci number, all is ok?
> 
> Remember, PCI device ids are not unique, they can come and go and be
> reordered and reused at any point in time.  They are fully dynamic and
> should NEVER be used as a unique identifier except for a specific moment
> in time.
> 
> In other words, you are expecting that device id to always refer to the
> same device across all 3 operations, which is never guaranteed.

If the user chooses to replace the device between steps 2 and 3,
they get to keep the pieces.

Thanks,

Lukas
