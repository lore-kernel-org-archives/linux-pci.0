Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CC32B9BB
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161526; cv=none; b=ieJF2BgAqkVW2vN3lCGYChShK25IIseK+e8cwvoHG9Ug361oAheT1srdCHjFjeiMI9tq6JjPRHE2jJKhP1gaVsa3JFhhazK9nQYyI1QFM4ybZ7KX1cuGs6juDHOIJu8uO4iLgC1KzZv9N0hwWWbXjPgp68AyXKDYx5Dued3jojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161526; c=relaxed/simple;
	bh=a0lnhCfWIcGxzMuzt8kRcDRklA16qi3DH3QAldOj4H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8q5yPModJn113IDlwAYaBB48Sjy+XZkFJKJ0J5erhniMy/+9FSt/Jbonv/2YYGw05nI+lyrgFvxhsDbuKVxiA45+GZW/AUEKsQm+8YzAu8GNlktjowuqEZr8HJtFD6/bx5aVG9kDtMLwtUzj4O03GsglYPVYWNu53ac03Tl094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 65E7B36F;
	Mon, 27 Jul 2026 16:12:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 617B760CDD36; Mon, 27 Jul 2026 16:12:02 +0200 (CEST)
Date: Mon, 27 Jul 2026 16:12:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	". Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <amdnMg_J6T3Sys45@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <20260724223903.GA1073029@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724223903.GA1073029@bhelgaas>

On Fri, Jul 24, 2026 at 05:39:03PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 24, 2026 at 05:24:00PM +0200, Lukas Wunner wrote:
> >   PCI/AER: Fix mapping of errors to agent & layer
> >   PCI/AER: Log agent & layer for each individual error
> >   PCI/AER: Deduplicate logging of Error Source Identification
> >   PCI/AER: Emit TLP Log only for unmasked errors
> >   PCI/AER: Move retrieval of FEP and TLP Log into helper
> >   PCI/AER: Support Advisory Non-Fatal Errors
> > 
> >  drivers/pci/pci.h      |   4 +
> >  drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
> >  2 files changed, 200 insertions(+), 54 deletions(-)
> 
> Applied to pci/aer with the intention of v7.3, thank you!
> 
> I noticed a sashiko comment on 6/6 but haven't had time to look at it
> yet.  I left the series on pci/aer for build testing in the meantime.

Below is a fixup for the first valid finding reported by sashiko.
If you could fold that into the top-most commit on pci/aer,
I'd be grateful!

There is one other sashiko finding I need to address:

It complained that in the native case, Advisory Non-Fatal Errors are
reported with the same loglevel and ratelimiting as the accompanying
Correctable Error.  But that's intentional.  However in the Firmware
First case, I got that wrong in that the loglevel and ratelimiting of
non-Advisory Non-Fatal Errors is used.  I'll come back with another
fixup for that!

My rebuttal of sashiko's findings:

https://lore.kernel.org/r/amdjR8LqIY0YmiG4@wunner.de

-- >8 --

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ff6ff7abc286..2a380bb9bfcb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -428,7 +428,7 @@ void pci_aer_init(struct pci_dev *dev)
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
 	 * 7.8.4.6).
 	 */
-	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
+	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
 		pci_clear_and_set_config_dword(dev,
 					       dev->aer_cap + PCI_ERR_COR_MASK,
 					       PCI_ERR_COR_ADV_NFAT, 0);
