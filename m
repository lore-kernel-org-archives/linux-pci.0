Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605E2E8E16
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771295; cv=none; b=VklQvXRBKFguK+CyTvEWD7inz00EE5g4H3A0pMbHfN6MO8oTM4CeAto87nzC0+zpCR5SIEMaz7ynSHr9n3jtxudHT6s5TdYT+3NIaaEXxIR53B0+NbKGWqih2uH+SVQwCDiGFk9a7FGq+lQkPJWVdGvln9w1k1TblVCXqjpq5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771295; c=relaxed/simple;
	bh=62XAlLzn/worNpsUDtQi5xluWaVCMAM9iak7242sBNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LauTIS9zDFs58IbB83kmiGrr6PVDaXVN5FYb1leGjrx18uhSBKJi4nCgzWYGE205kTwR2fStMZ26c+4EsPVmP34AYrs8YNdavtlGgVg46hIZligj3d32ToIEJHayf48GqtZe2tIMxX90G+D+iPyA639RvLd5rGIIX4/thZe0MMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C16D610585;
	Tue, 17 Mar 2026 19:14:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A95E66029AFD; Tue, 17 Mar 2026 19:14:51 +0100 (CET)
Date: Tue, 17 Mar 2026 19:14:51 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, aik@amd.com,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, jgg@nvidia.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <abmaG0jC7b05Lytz@wunner.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <20260314111245.76d18d73@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314111245.76d18d73@kernel.org>

On Sat, Mar 14, 2026 at 11:12:45AM -0700, Jakub Kicinski wrote:
> On Mon,  2 Mar 2026 16:01:56 -0800 Dan Williams wrote:
> > The implementation adheres to the guideline from:
> > Documentation/userspace-api/netlink/genetlink-legacy.rst
> > 
> >     New Netlink families should never respond to a DO operation with
> >     multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
> >     instead.
> 
> My understanding of F_MULTI is that deserializer is supposed to
> continue deserializing into current object.

So is the "should" above meant to be understood in the RFC 2119 way,
i.e. as a mere recommendation?

The problem we're facing is that nlattr::nla_len is u16, so the maximum
size is 65531 bytes (65535 minus header).  That's insufficient for
transmitting blobs that are several megabytes in size.

The obvious solution is to split the blobs into smaller chunks and
transmit each chunk in an attribute of the same type.  The application
then concatenates them together to reconstruct the blob.  For particularly
large blobs, it may even be necessary to split across multiple messages
by way of NLM_F_MULTI.

Apart from the attribute size limitation, there's the problem that copying
large blobs in memory is inefficient.  Ideally we'd want zero-copy.
The solution I came up with is to attach the blob's pages as fragments
to the skb.  Conceptually the fragments succeed the linear buffer of the
skb, so by putting the nlattr header into the linear buffer and attaching
the blob as fragments, the receiver consumes the netlink message in a
natural way.  This patch introduces an nla_put_blob() helper which was
pretty straightforward:

https://github.com/l1k/linux/commit/af9b939fc30b

This patch is taking advantage of the helper:

https://github.com/l1k/linux/commit/009663bd172e

The only change I had to make is amending nlmsg_end() to take the
fragments into account when calculating the nlmsg_len.

The patch does achieve zero-copy on the sender's end.  It may also
achieve zero-copy on the receiver's end if the receiver is in the
kernel.  However it does *not* achieve zero-copy if the receiver is
in user space.  That's because:

simple_copy_to_iter()
  copy_to_iter()
    _copy_to_iter()
      copy_to_user_iter()
        raw_copy_to_user()

... will just stupidly copy the data into the user space buffer.
It might be possible to achieve zero-copy in user space via io_uring.

At this point perhaps your conclusion is that netlink isn't the right
protocol for this job.  It's great for transmitting sets of small items,
some of which may be optional, but it's obviously not well-suited for
large items.

Jason Gunthorpe was quite insistent that we use netlink and you know
how consensus-oriented kernel development is.  Indeed sysfs has turned
out not to be ideal because the protocol that we're dealing with
(SPDM - DMTF DSP0274) allows many degrees of freedom and making
them available through sysfs quickly becomes unwieldy.

E.g. when installing a certificate onto a device, the protocol allows
specifying additional parameters (a keypair ID and a certificate model)
together with the certificate chain that shall be installed.  That doesn't
square well with the "one value per file" sysfs model.  User space would
have to write the keypair ID and certificate model to separate attributes,
then write the certificate chain to a third attribute.  So the kernel would
need some kind of state machine to keep track of which sysfs attributes
have been written.  It gets quite ugly.

As another example, the SPDM protocol allows retrieving measurements
from the device.  The measurements are indexed by an 8-bit number.
To expose them via sysfs, the kernel would have to retrieve all of them
on device enumeration so that it knows which indices are populated
and need to be exposed in sysfs.  That would incur a delay on device
enumeration and thus lead to slower boot times.

If netlink is at all the right protocol for the job, I'm wondering if an
extension for larger attributes would be entertained.  Basically a
variation of struct nlattr, but with a 24-bit or 32-bit size and
maybe a list of fragment numbers.  The latter would be useful to have
*multiple* zero-copy attributes because the patches linked above only
allow for a single zero-copy attribute per nlmsg.

Thanks,

Lukas
