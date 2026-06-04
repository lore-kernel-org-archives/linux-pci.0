Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD93672B5
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587772; cv=none; b=mv6pEGBRjJ8TtvE+LHrXo4gttv9V+rxQqdBcHOQPLrSsZN+5V03QA6O04ixx9RrpTt7YQkcZp2FIU/sdXztmgG3NO2IAFgqZono0cHq+STZaxGYwBDtozj5Vv2obelez4zdB+g789LNzMvCfAuO9r+De71lrAHGJaRrDkheQgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587772; c=relaxed/simple;
	bh=h8Aq560y7Zgujkutv+/fq4BcEWxR/b7Z5M0TfJvE18Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isLGycDwfZ1I+tfSLOADhR6FP+NW5iLHf9+t0EeSByxvRhWufdbxLpTgYl1dE5ABhaSZGtskc2rsIxgYf9pXUyTkMl7rZfsRMuxUSiEo4acOJGsqdW0OC4YiJfg4LwETv9E8G5FaChNczkt3rX/iXzCO0NoDgkSl8Ln/pSZ9Byc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id C01F938B;
	Thu, 04 Jun 2026 17:42:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AD039600CAF1; Thu,  4 Jun 2026 17:42:48 +0200 (CEST)
Date: Thu, 4 Jun 2026 17:42:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	linux-pci@vger.kernel.org, qat-linux@intel.com,
	Damir Chanyshev <conflict342@gmail.com>,
	Simon Richter <sjr@debian.org>,
	Tomasz Ossowski <tomasz.ossowski@intel.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to whitelist
Message-ID: <aiGc-CCSdIeEYTLb@wunner.de>
References: <4ea5265495876beb5fb5e6d479b2782f882bcbb3.1780570508.git.lukas@wunner.de>
 <a830ffd4-14a1-4739-b862-25e664394a96@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a830ffd4-14a1-4739-b862-25e664394a96@deltatee.com>

On Thu, Jun 04, 2026 at 09:21:50AM -0600, Logan Gunthorpe wrote:
> On 2026-06-04 5:50 a.m., Lukas Wunner wrote:
> > The first device on a PCI root bus determines whether the host bridge is
> > whitelisted for P2PDMA.  All Intel Xeon chips since Ice Lake (ICX, 2021)
> > expose a device with ID 0x09a2 as first device.  It is loosely associated
> > with the IOMMU.  All these Xeon chips support P2PDMA, so since the
> > addition of the device with commit feaea1fe8b36 ("PCI/P2PDMA: Add Intel
> > 3rd Gen Intel Xeon Scalable Processors to whitelist"), P2PDMA has been
> > allowed on all new Xeons without the need to amend the whitelist:
[...]
> > However these Xeons also expose accelerators as first device on a root bus
> > of its own:
> > 
> >   QuickAssist Technology (QAT, crypto & compression accelerator)
> >   Data Streaming Accelerator (DSA, dma engine)
> >   In-Memory Analytics Accelerator (IAA, dma engine)
> > 
> > Whitelist them for P2PDMA as well.  Move their Device ID macros from the
> > accelerator drivers to <linux/pci_ids.h> for reuse by P2PDMA code.
> 
> I'm sorry, I don't fully understand this. Are QAT devices functioning as
> root ports? Are there devices in the tree that are doing P2P
> transactions through theme? That surprises me.

These accelerators are RCiEPs, each located on a Host Bridge by itself.
The idea is that users should be able to set up P2PDMA between these
accelerators and other devices.

Thanks,

Lukas
