Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0954E66A5
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648741; cv=none; b=ffF3sOp4FBdsTgjLkW3sDSEcHcXLPaGpY9lC2ZLnOJT9s2gUY2AFZfV1AXQqtwY2zopgO/htMHzl3OeH/p8jbODt81XlnywoaF5PtfYJtiJfY70PVeZhiH64JG+0pF3TllUu1qxF0Ve2F3IyCCNbR4eJIuQ0bHY+J4IQHJnn8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648741; c=relaxed/simple;
	bh=AVUJKJFF3h0w9nqIjVWg84LGJAbjikqznLiQgNE1z+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJZrDOi8JjSYfg9hNFaSk2+vUuQVO3abVKPKV7foghedNxGlTf8oqTEBoJX0aILEkXWtHBxAPxY3sWTmr4WFeH6/R+uAEHQVdEyltOEKZBqzMebbH+RxySHaoVIwx3DhXASBgYEGfSTJ83gm8gktVMPCgFec8RAhneg37nw0PSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 8690A1203;
	Thu, 17 Sep 2026 14:38:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7261F60B5641; Thu, 17 Sep 2026 14:38:42 +0200 (CEST)
Date: Thu, 17 Sep 2026 14:38:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Riana Tauro <riana.tauro@intel.com>,
	Alex Williamson <alex@shazbot.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] PCI: Fix order of device disablement on reset
Message-ID: <aqvfUldY5mGMMYrG@wunner.de>
References: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
 <6a45ad46-efa6-47fd-9408-302ea8bb66e2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a45ad46-efa6-47fd-9408-302ea8bb66e2@linux.ibm.com>

On Tue, Sep 15, 2026 at 10:08:32AM -0700, Farhan Ali wrote:
> On 9/15/2026 6:35 AM, Lukas Wunner wrote:
> > Riana reports an AER splat when issuing a Secondary Bus Reset through the
> > "reset_subordinate" sysfs attribute:
> > 
> >    AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:01:00.0
> >    PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
> >      device [8086:e2ff] error status/mask=00100000/00400000
> >      [20] UnsupReq               (First)
> >    AER:   TLP Header: 0x40000001 0x0000000f 0x81190008 0x00000000
> > 
> > The Secondary Bus Reset is issued at the Root Port.  Underneath is a
> > Switch with two Endpoints.  Riana has identified an ordering issue in
> > pci_bus_save_and_disable_locked() as root cause of the AER splat:
[...]
> Since we are changing the order, maybe we should update comment for the
> functions to reflect that. The change does make sense to me, but I am
> curious why we didn't see this before?

We only enabled error reporting by default starting with v6.0 in 2022,
cf. commit f26e58bf6f54.

And the reset_subordinate sysfs attribute only exists since v6.13 in 2025,
cf. commit 2fa046449a82.

So it's relatively new functionality which apparently wasn't exercised
heavily so far.

It's remarkable though that universally enabling error reporting is now
alerting us to hidden bugs like this.  Commit f26e58bf6f54 cautioned
that the change is invasive but it's clearly useful.

Agreed on updating the comment, I'll have to respin the patch and
also address the sashiko findings regarding power management.

Thanks,

Lukas
