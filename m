Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:27178
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836Ab3LJU3d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 15:29:33 -0500
Message-ID: <1386707357.10013.114.camel@snotra.buserror.net>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
From: Scott Wood <scottwood@freescale.com>
To: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
CC: 'Wood Scott-B07421' <scottwood@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"agraf@suse.de" <agraf@suse.de>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 10 Dec 2013 14:29:17 -0600
In-Reply-To: <34c6142137194b1cbd2336013ed3b10d@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1384973243.2879.361.camel@ul30vt.home>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
	 <1385066603.2879.414.camel@ul30vt.home>
	 <1385066835.1403.489.camel@snotra.buserror.net>
	 <1385067648.2879.421.camel@ul30vt.home>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
	 <1386288052.7375.100.camel@snotra.buserror.net>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D07251EFF@039-SN2MPN1-012.039d.mgd.msft.net>
	 <1386357907.7375.127.camel@snotra.buserror.net>
	 <34c6142137194b1cbd2336013ed3b10d@BN1PR03MB266.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

My e-mail address is <scottwood@freescale.com>, not
<IMCEAEX-_O=MMS_OU=EXTERNAL+20+28FYDIBOHF25SPDLT
+29_CN=RECIPIENTS_CN=F0FAAC8D7E74473A9EE1C45B068D838A@namprd03.prod.outlook.com>

On Tue, 2013-12-10 at 05:37 +0000, Bharat.Bhushan@freescale.com wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, December 07, 2013 12:55 AM
> > To: Bhushan Bharat-R65777
> > Cc: Alex Williamson; linux-pci@vger.kernel.org; agraf@suse.de; Yoder Stuart-
> > B08248; iommu@lists.linux-foundation.org; bhelgaas@google.com; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> > 
> > If the administrator does not opt into this partial loss of isolation, then once
> > you run out of MSI groups, new users should not be able to set up MSIs.
> 
> So mean vfio should use Legacy when out of MSI banks?

Yes, if the administrator hasn't granted permission to share.

-Scott



