Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0103.outbound.protection.outlook.com ([157.56.110.103]:23245
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964972AbcDLURt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 16:17:49 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Hannes Reinecke <hare@suse.com>,
	Hariprasad S <hariprasad@chelsio.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	SWise OGC <swise@opengridcomputing.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Ariel Elior <ariel.elior@qlogic.com>
Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access
 offset against length
Date: Tue, 12 Apr 2016 20:17:44 +0000
Message-ID: <BY2PR12MB0648C7C38FB3FF16D0721C1DC8950@BY2PR12MB0648.namprd12.prod.outlook.com>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
 <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
 <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
 <20160412053700.GF11361@localhost> <570C93BD.2030102@suse.com>
 <20160412082304.GB2771@hari-Latitude-E5550>,<570CB5FA.7010507@suse.com>,<BY2PR12MB0648C2EDB334862B48C81043C8950@BY2PR12MB0648.namprd12.prod.outlook.com>
In-Reply-To: <BY2PR12MB0648C2EDB334862B48C81043C8950@BY2PR12MB0648.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  By the way, I should note that I don't think that cxgb4 is the only
regression associated with kernel.org commit 104daa71b396
which added a check for accesses beyond the computed end of
the VPD data structures starting at offset 0x0 in the VPD Space.
Looking at other callers to pci_read_vpd() I see at least one other
driver which pass in a non-zero offset which seems to be the
same kind of thing:

drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:bnx2x_read_fwinfo():

                cnt = pci_read_vpd(bp->pdev, BNX2X_VPD_LEN,
                                   block_end - BNX2X_VPD_LEN,
                                   vpd_extended_data + BNX2X_VPD_LEN);

Looking more in depth, if you really want to keep the new pci_read_vpd()
logic where it can return partial reads, then we need to go through all of
the callers and look for cases like cxgb4 where the only check is for
return values less than zero and enhance them to deal with return
values less than the requested VPD read request.

Casey
________________________________________
From: linux-pci-owner@vger.kernel.org <linux-pci-owner@vger.kernel.org> on behalf of Casey Leedom <leedom@chelsio.com>
Sent: Tuesday, April 12, 2016 10:35 AM
To: Hannes Reinecke; Hariprasad S
Cc: Bjorn Helgaas; SWise OGC; linux-pci@vger.kernel.org; bhelgaas@google.com
Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access offset against length

| From: Hannes Reinecke <hare@suse.com>
| Sent: Tuesday, April 12, 2016 1:46 AM
| To: Hariprasad S
| Cc: Bjorn Helgaas; SWise OGC; Casey Leedom; linux-pci@vger.kernel.org; bhelgaas@google.com
| Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access offset against length
|
| On 04/12/2016 10:23 AM, Hariprasad Shenai wrote:
| [ .. ]
| >
| > Hi,
| >
| > How about adding a PCI helper function to set the actual VPD_SIZE.
| >
| > Some thing like below. We have tested this and works. The bnx2x and the tg3
| > drive may also need this, because I see them calling pci_read_vpd()
| > with non-zero offsets. The bnx2x in particular looks like it's doing something
| > similar to cxgb4 so it would also probably benefit from this change (once it's
| > fixed to call the new pci_set_size_vpd() API).
|
| That indeed looks reasonable.
| Please find some comments inline.
|
| ...
|
| > --- a/drivers/pci/access.c
| > +++ a/drivers/pci/access.c
| > @@ -275,6 +275,19 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
| >  }
| >  EXPORT_SYMBOL(pci_write_vpd);
| >
| > +/**
| > + * pci_set_size_vpd - Set size of Vital Product Data space
| > + * @dev:     pci device struct
| > + * @len:     size of vpd space
| > + */
| > +ssize_t pci_set_size_vpd(struct pci_dev *dev, size_t len)
| > +{
| > +     if (!dev->vpd || !dev->vpd->ops)
| > +             return -ENODEV;
| > +     return dev->vpd->ops->set_size(dev, len);
| > +}
| > +EXPORT_SYMBOL(pci_set_size_vpd);
| > +
| >  #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
| >
| >  /**
| > @@ -392,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
| >       if (vpd->len == 0)
| >               return -EIO;
| >
| > -     if (pos > vpd->len)
| > -             return 0;
| > -
| > -     if (end > vpd->len) {
| > -             end = vpd->len;
| > -             count = end - pos;
| > -     }
| > +     if (end > vpd->len)
| > +             return -EINVAL;
| >
| >       if (mutex_lock_killable(&vpd->lock))
| >               return -EINTR;
|
| Why do you need this change?
| We still would be needing to validate 'pos', don't we?
| I'd prefer not to have this bit in.

Two reasons:

 1. It makes pci_vpd_read() with pci_vpd_write() which has exactly this
    logic.

 2. More importantly, the new implementation of pci_read_vpd() silently
    fails to perform a VPD read and allows the caller to use random stack
    garbage in the read buffer without knowing that it's not really VPD
    contents.  If any portion of the VPD read isn't going to be performed,
    we should signal that back to the caller.  We could either return an
    error or we could return the number of bytes actually read.  The problem
    with the latter is that it would require changing every single caller to
    check for Requested Read Length == Actual Read Length.  Returning an
    error is the more conservative fix and allows for rapid diagnosis of
    problems.

    And that last point is important because I spent quite a bit of time
    digging around trying to figure out why cxgb4 suddenly wasn't working.

Casey

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
