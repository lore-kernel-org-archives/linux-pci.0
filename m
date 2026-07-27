Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243323D47DE
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167473; cv=none; b=Ebg64yc+IQF/NWAddUOW6AV6W0a5JCJS3j2HVZcjPo93I9nso+48ZfnUg9gxZa9aoILLs3IeyFK0PPHp29A06DwLYrV7TfGonJzJ39TYwtXbGzXyQxXKR2esu/M30yA3ecpLxSqMH7ZoGuPL8Y80ZPCP1MK1TMOzFnqKMiK3g2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167473; c=relaxed/simple;
	bh=8FReKsloO4j2GMu1oct+f7M+V27RnE02qrmiayYd/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uhpra+oWfXXeT5FecZjmbLt11/KNqrAAfoxnib3PbRStvEypqYFGot7w5SNaMBfjFN9qpUvfY0zROj4VJVR1HCaOGHYg1Oas9AODUO7ULssP1s78Ge5nHG6uemYFppnHMvdRWqk8ZLyvsFj2VB/v57PrsutDFsKjbmmANBoYe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX4jLuJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX4jLuJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44EF1F000E9;
	Mon, 27 Jul 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167472;
	bh=L0Y+MjztMze6dzvUP1kkwe6PSrgocCQE9UXUfP8KTyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BX4jLuJ7qp1/B3HwbUb+4GRdr0DV9mClD+XdY68oxxyj3WwZrdtKzoQtYj+13wbaD
	 kxdOq/ezFgLb/9lV6E6mucTY/9ganVYPb/pxioG4QUY8ORjvJeK0OUud0SwlqqM++u
	 0Rb21x+oT1fQE1nLa75+rAkYrTMtUhhyoWOpuqEtx64LXzvI/R77GFM/XGDrUy8wcy
	 GDm0Bnn9JpwOUPyxrhQAQohqY8k2t2QfnLJ46M/wpEaRXQR+ZGM6zJpHNgh5AtTnPF
	 eLlA6g74sVhLKeUUjUMrBL2MsGsdbLIao6ASu9rPVvuc8n1iUPUIVb6R8kk2fQ6Px2
	 JL1T6AS/UB67w==
Date: Mon, 27 Jul 2026 10:51:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20260727155110.GA1218153@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdnMg_J6T3Sys45@wunner.de>

On Mon, Jul 27, 2026 at 04:12:02PM +0200, Lukas Wunner wrote:
> On Fri, Jul 24, 2026 at 05:39:03PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jul 24, 2026 at 05:24:00PM +0200, Lukas Wunner wrote:
> > >   PCI/AER: Fix mapping of errors to agent & layer
> > >   PCI/AER: Log agent & layer for each individual error
> > >   PCI/AER: Deduplicate logging of Error Source Identification
> > >   PCI/AER: Emit TLP Log only for unmasked errors
> > >   PCI/AER: Move retrieval of FEP and TLP Log into helper
> > >   PCI/AER: Support Advisory Non-Fatal Errors
> > > 
> > >  drivers/pci/pci.h      |   4 +
> > >  drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
> > >  2 files changed, 200 insertions(+), 54 deletions(-)
> > 
> > Applied to pci/aer with the intention of v7.3, thank you!
> > 
> > I noticed a sashiko comment on 6/6 but haven't had time to look at it
> > yet.  I left the series on pci/aer for build testing in the meantime.
> 
> Below is a fixup for the first valid finding reported by sashiko.
> If you could fold that into the top-most commit on pci/aer,
> I'd be grateful!

Fixup folded into "PCI/AER: Support Advisory Non-Fatal Errors",
thanks!

> -- >8 --
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ff6ff7abc286..2a380bb9bfcb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -428,7 +428,7 @@ void pci_aer_init(struct pci_dev *dev)
>  	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
>  	 * 7.8.4.6).
>  	 */
> -	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
> +	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
>  		pci_clear_and_set_config_dword(dev,
>  					       dev->aer_cap + PCI_ERR_COR_MASK,
>  					       PCI_ERR_COR_ADV_NFAT, 0);
