Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0143.outbound.protection.outlook.com ([65.55.169.143]:52032
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752303AbcDMRGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 13:06:44 -0400
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
Date: Wed, 13 Apr 2016 16:52:09 +0000
Message-ID: <BY2PR12MB0648B1E60E0DE5BF73B37BF8C8960@BY2PR12MB0648.namprd12.prod.outlook.com>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
 <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
 <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
 <20160412053700.GF11361@localhost> <570C93BD.2030102@suse.com>
 <20160412082304.GB2771@hari-Latitude-E5550> <570CB5FA.7010507@suse.com>
 <BY2PR12MB0648C2EDB334862B48C81043C8950@BY2PR12MB0648.namprd12.prod.outlook.com>,<570DE062.5070500@suse.com>
In-Reply-To: <570DE062.5070500@suse.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| From: linux-pci-owner@vger.kernel.org <linux-pci-owner@vger.kernel.org> on behalf of Hannes Reinecke <hare@suse.com>
| Sent: Tuesday, April 12, 2016 11:00 PM
|
| On 04/12/2016 07:35 PM, Casey Leedom wrote:
| > | From: Hannes Reinecke <hare@suse.com>
| > | Sent: Tuesday, April 12, 2016 1:46 AM
| > | ...
| > | > --- a/drivers/pci/access.c
| > | > +++ a/drivers/pci/access.c
| > | > ...
| > | > @@ -392,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
| > | >       if (vpd->len == 0)
| > | >               return -EIO;
| > | >
| > | > -     if (pos > vpd->len)
| > | > -             return 0;
| > | > -
| > | > -     if (end > vpd->len) {
| > | > -             end = vpd->len;
| > | > -             count = end - pos;
| > | > -     }
| > | > +     if (end > vpd->len)
| > | > +             return -EINVAL;
| > | >
| > | >       if (mutex_lock_killable(&vpd->lock))
| > | >               return -EINTR;
| > |
| > | Why do you need this change?
| > | We still would be needing to validate 'pos', don't we?
| > | I'd prefer not to have this bit in.
| >
| > Two reasons:
| >
| >  1. It makes pci_vpd_read() with pci_vpd_write() which has exactly this
| >     logic.
| >
| >  2. More importantly, the new implementation of pci_read_vpd() silently
| >     fails to perform a VPD read and allows the caller to use random stack
| >     garbage in the read buffer without knowing that it's not really VPD
| >     contents.  If any portion of the VPD read isn't going to be performed,
| >     we should signal that back to the caller.  We could either return an
| >     error or we could return the number of bytes actually read.  The problem
| >     with the latter is that it would require changing every single caller to
| >     check for Requested Read Length == Actual Read Length.  Returning an
| >     error is the more conservative fix and allows for rapid diagnosis of
| >     problems.
| >
| >     And that last point is important because I spent quite a bit of time
| >     digging around trying to figure out why cxgb4 suddenly wasn't working.
|
| Okay. But wouldn't we need to check for 'pos' exceeding 'vpd->len', too?

Nope.  "pos", "count", and "end" are unsigned:

    loff_t end = pos + count;

If "pos" is greater than "vpd->len", "end" will be as well.  This is actually
exactly the same code that's already in pci_vpd_write().

Casey
