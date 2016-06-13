Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46867 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424288AbcFMQCu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 12:02:50 -0400
Date: Mon, 13 Jun 2016 10:02:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Noa Osherovich" <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	"Or Gerlitz" <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: Re: [PATCH 1/4] VFIO: Probe new devices in a live VFIO group with
 the VFIO driver
Message-ID: <20160613100248.354e4e7f@ul30vt.home>
In-Reply-To: <VI1PR0501MB1968DDC0D3A32A946B72C7D7D4530@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
	<1465474173-53960-2-git-send-email-ilyal@mellanox.com>
	<20160609162139.13eb22b4@ul30vt.home>
	<VI1PR0501MB1968DDC0D3A32A946B72C7D7D4530@VI1PR0501MB1968.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Jun 2016 06:33:53 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Friday, June 10, 2016 1:22 AM
> > To: Ilya Lesokhin <ilyal@mellanox.com>
> > Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; bhelgaas@google.com;
> > Noa Osherovich <noaos@mellanox.com>; Haggai Eran
> > <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss
> > <liranl@mellanox.com>
> > Subject: Re: [PATCH 1/4] VFIO: Probe new devices in a live VFIO group with
> > the VFIO driver  
> ...
> > > +		pdev = to_pci_dev(dev);
> > > +		if (pdev->driver_override)
> > > +			kfree(pdev->driver_override);
> > > +		pdev->driver_override = kstrdup("vfio-pci", GFP_KERNEL);  
> > 
> > kstrdup can fail.  Probably want to issue a about capturing
> > the device as well.  Thanks,
> >   
> 
> Any recommendation as to what I should do in case kstrdup fails?
> Fallback to the existing warning ("device added to a live group") ? 

Probably so.  Thanks,

Alex
