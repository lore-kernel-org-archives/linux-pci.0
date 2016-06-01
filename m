Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757621AbcFAIEe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Jun 2016 04:04:34 -0400
Date: Wed, 1 Jun 2016 10:04:31 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Smart <james.smart@avagotech.com>,
	Dick Kennedy <dick.kennedy@avagotech.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/5] scsi: Use pci_(request|release)_mem_regions
Message-ID: <20160601080431.3sgbeapns2sh6zmh@c203.arch.suse.de>
References: <cover.1464694724.git.jthumshirn@suse.de>
 <1123377cf09b08091957c7d1f58be1601dbfb50c.1464694724.git.jthumshirn@suse.de>
 <20160601075929.GC11923@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160601075929.GC11923@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 01, 2016 at 12:59:29AM -0700, Christoph Hellwig wrote:
> On Tue, May 31, 2016 at 02:05:11PM +0200, Johannes Thumshirn wrote:
> > Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
> > hand, use it in the lpfc driver.
> 
> This should read lpfc instead of scsi in the subject line.
> 
> Also the request side of the patch seems to be missing.

You're right. I'll be checking why the coccinelle spatch didn't catch it up.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
