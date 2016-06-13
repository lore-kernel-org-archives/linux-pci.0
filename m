Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-am1on0057.outbound.protection.outlook.com ([157.56.112.57]:48928
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030202AbcFMHTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 03:19:15 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: RE: [PATCH 1/4] VFIO: Probe new devices in a live VFIO group with the
 VFIO driver
Date: Mon, 13 Jun 2016 06:33:53 +0000
Message-ID: <VI1PR0501MB1968DDC0D3A32A946B72C7D7D4530@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
	<1465474173-53960-2-git-send-email-ilyal@mellanox.com>
 <20160609162139.13eb22b4@ul30vt.home>
In-Reply-To: <20160609162139.13eb22b4@ul30vt.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, June 10, 2016 1:22 AM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; bhelgaas@google.com;
> Noa Osherovich <noaos@mellanox.com>; Haggai Eran
> <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss
> <liranl@mellanox.com>
> Subject: Re: [PATCH 1/4] VFIO: Probe new devices in a live VFIO group with
> the VFIO driver
...
> > +		pdev = to_pci_dev(dev);
> > +		if (pdev->driver_override)
> > +			kfree(pdev->driver_override);
> > +		pdev->driver_override = kstrdup("vfio-pci", GFP_KERNEL);
> 
> kstrdup can fail.  Probably want to issue a about capturing
> the device as well.  Thanks,
> 

Any recommendation as to what I should do in case kstrdup fails?
Fallback to the existing warning ("device added to a live group") ? 

Thanks,
Ilya.

