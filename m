Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52242 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759306AbcDMGAF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 02:00:05 -0400
Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access
 offset against length
To: Casey Leedom <leedom@chelsio.com>,
	Hariprasad S <hariprasad@chelsio.com>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
 <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
 <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
 <20160412053700.GF11361@localhost> <570C93BD.2030102@suse.com>
 <20160412082304.GB2771@hari-Latitude-E5550> <570CB5FA.7010507@suse.com>
 <BY2PR12MB0648C2EDB334862B48C81043C8950@BY2PR12MB0648.namprd12.prod.outlook.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	SWise OGC <swise@opengridcomputing.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <570DE062.5070500@suse.com>
Date: Wed, 13 Apr 2016 08:00:02 +0200
MIME-Version: 1.0
In-Reply-To: <BY2PR12MB0648C2EDB334862B48C81043C8950@BY2PR12MB0648.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/2016 07:35 PM, Casey Leedom wrote:
> | From: Hannes Reinecke <hare@suse.com>
> | Sent: Tuesday, April 12, 2016 1:46 AM
> | To: Hariprasad S
> | Cc: Bjorn Helgaas; SWise OGC; Casey Leedom; linux-pci@vger.kernel.org; bhelgaas@google.com
> | Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access offset against length
> |
> | On 04/12/2016 10:23 AM, Hariprasad Shenai wrote:
> | [ .. ]
> | >
> | > Hi,
> | >
> | > How about adding a PCI helper function to set the actual VPD_SIZE.
> | >
> | > Some thing like below. We have tested this and works. The bnx2x and the tg3
> | > drive may also need this, because I see them calling pci_read_vpd()
> | > with non-zero offsets. The bnx2x in particular looks like it's doing something
> | > similar to cxgb4 so it would also probably benefit from this change (once it's
> | > fixed to call the new pci_set_size_vpd() API).
> |
> | That indeed looks reasonable.
> | Please find some comments inline.
> |
> | ...
> |
> | > --- a/drivers/pci/access.c
> | > +++ a/drivers/pci/access.c
> | > @@ -275,6 +275,19 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
> | >  }
> | >  EXPORT_SYMBOL(pci_write_vpd);
> | >
> | > +/**
> | > + * pci_set_size_vpd - Set size of Vital Product Data space
> | > + * @dev:     pci device struct
> | > + * @len:     size of vpd space
> | > + */
> | > +ssize_t pci_set_size_vpd(struct pci_dev *dev, size_t len)
> | > +{
> | > +     if (!dev->vpd || !dev->vpd->ops)
> | > +             return -ENODEV;
> | > +     return dev->vpd->ops->set_size(dev, len);
> | > +}
> | > +EXPORT_SYMBOL(pci_set_size_vpd);
> | > +
> | >  #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
> | >
> | >  /**
> | > @@ -392,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
> | >       if (vpd->len == 0)
> | >               return -EIO;
> | >
> | > -     if (pos > vpd->len)
> | > -             return 0;
> | > -
> | > -     if (end > vpd->len) {
> | > -             end = vpd->len;
> | > -             count = end - pos;
> | > -     }
> | > +     if (end > vpd->len)
> | > +             return -EINVAL;
> | >
> | >       if (mutex_lock_killable(&vpd->lock))
> | >               return -EINTR;
> |
> | Why do you need this change?
> | We still would be needing to validate 'pos', don't we?
> | I'd prefer not to have this bit in.
> 
> Two reasons:
> 
>  1. It makes pci_vpd_read() with pci_vpd_write() which has exactly this
>     logic.
> 
>  2. More importantly, the new implementation of pci_read_vpd() silently
>     fails to perform a VPD read and allows the caller to use random stack
>     garbage in the read buffer without knowing that it's not really VPD
>     contents.  If any portion of the VPD read isn't going to be performed,
>     we should signal that back to the caller.  We could either return an
>     error or we could return the number of bytes actually read.  The problem
>     with the latter is that it would require changing every single caller to
>     check for Requested Read Length == Actual Read Length.  Returning an
>     error is the more conservative fix and allows for rapid diagnosis of
>     problems.
> 
>     And that last point is important because I spent quite a bit of time
>     digging around trying to figure out why cxgb4 suddenly wasn't working.
> 
Okay. But wouldn't we need to check for 'pos' exceeding 'vpd->len', too?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
