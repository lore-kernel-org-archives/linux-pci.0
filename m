Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392ED3E2741
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757306; cv=none; b=nhhqe4gA57TGk8GbuVSsypceZwA89hhrmfh36we6RNASo+yRDkCl6GeSa9ODlsdJMJDWx6v7GHlCaYXhR049RUx3e4VMVSmtX553baXmIq6xbLGsrqjWUR07SaVMOTKUpwp6UHi56IQCZ9UnOnIex9YrFqzT7KPziDRTPLZfF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757306; c=relaxed/simple;
	bh=UT2Vm0q/z2JCshk1kuXaNGNAgH5qu8C7r3kvHOBPxWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQIaCL0HZdRs4RqOpBUZlSXB5W78mpuRfb7joSvlNuUuwSTMTzyKW/inJkuJIQSdyS+7RefGKhCpRowf7Zh2cPeXi1XkbvEsIFNlz2tH42yzRHVhl4T9vWlRkiRuv1QO0GhQEYZIB+vGDjtdCxFRHKDf6u5Im6tIGx1ugFvEGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id B95AA389;
	Tue, 17 Mar 2026 15:13:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A10DA60297F9; Tue, 17 Mar 2026 15:13:16 +0100 (CET)
Date: Tue, 17 Mar 2026 15:13:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <ablhfHEIsz5IPW14@wunner.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <abWq1oiE-YkksxNu@wunner.de>
 <69b8646c8aeb1_452b100aa@dwillia2-mobl4.notmuch>
 <69b88bfe2662f_40c01002c@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b88bfe2662f_40c01002c@dwillia2-mobl4.notmuch>

On Mon, Mar 16, 2026 at 04:02:22PM -0700, Dan Williams wrote:
> Dan Williams wrote:
> > Lukas Wunner wrote:
> > > This doesn't look like it's ever been tested, so at the very least
> > > it should be marked RFC in the subject to convey that it's not yet
> > > in a cut-and-dried state.
> > 
> > The 16MB limit has indeed not been tested, the test script in this set
> > was using smaller than 64K payloads to check out the interface.
> 
> So 16MB works ok, slow, but works. A given attribute in this
> implementation never exceeds the limit

Famous last words.

If you look at netlink_dump(), it sizes the skb based on
nlk->max_recvmsg_len.  If that's larger than 64k, you'll
try to fill as much as possible of that space with a single
netlink attribute.  The computation of "available" in your
patch doesn't take the 65531 bytes limit for a netlink attribute
into account so it looks like you'll end up overflowing the length
of the netlink attribute.

Unfortunately nla_put() doesn't prevent such overflows, it does
all the size calculations with an int, not a u16.

Thanks,

Lukas
