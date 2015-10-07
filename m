Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:52338 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbbJGQ7k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 12:59:40 -0400
Subject: Re: [dm-devel] AMD-Vi IO_PAGE_FAULTs and ata3.00: failed command:
 READ FPDMA QUEUED errors since Linux 4.0
To: Joerg Roedel <joro@8bytes.org>,
	Andreas Hartmann <andihartmann@freenet.de>
References: <55BE1D5E.6020709@maya.org>
 <alpine.LRH.2.02.1508021347480.17729@file01.intranet.prod.int.rdu2.redhat.com>
 <55FE5740.2060701@maya.org> <20150929152100.GL3036@8bytes.org>
 <alpine.LRH.2.02.1509291143170.24174@file01.intranet.prod.int.rdu2.redhat.com>
 <20150929162042.GR3036@8bytes.org> <560BF73F.8000008@maya.org>
 <20151006101356.GE12506@8bytes.org> <56141507.7040103@maya.org>
 <56148A1B.5060506@maya.org> <20151007161022.GI28811@8bytes.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	iommu@lists.linux-foundation.org, Leo Duran <leo.duran@amd.com>,
	Christoph Hellwig <hch@lst.de>,
	device-mapper development <dm-devel@redhat.com>,
	Milan Broz <mbroz@redhat.com>, Jens Axboe <axboe@fb.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <56154DEA.5050901@maya.org>
Date: Wed, 7 Oct 2015 18:52:58 +0200
MIME-Version: 1.0
In-Reply-To: <20151007161022.GI28811@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/07/2015 at 06:10 PM, Joerg Roedel wrote:
> On Wed, Oct 07, 2015 at 04:57:31AM +0200, Andreas Hartmann wrote:
>> Got it during a single mount (I booted with massively reduced mounts and
>> did the mount afterwards manually. During the second manually mount, the
>> problem can be seen).
>>
>> I attached the requested files. The mount starts at 80 seconds.
>> Hope this helps.
> 
> Okay, the lowest dma-addr the AMD IOMMU driver returns is 0x1000 and
> the highest is 0x7ff4000. All fault addresses are outside of this range,
> so the AMD IOMMU driver never returned these addresses.
> 
> This doesn't mean that it is not at fault, but it looks still unlikely.
> Maybe I can reproduce the problem here. Can you please tell me some
> details about the partitions you mounted to trigger this?
> 
> I remember something about a xfs->lvm->dm_crypt->md_raid->sata setup, but
> having more details may help me to reproduce.

See attachments in http://article.gmane.org/gmane.linux.kernel.pci/43975


To reproduce the error:
First I mounted /daten2, afterwards /raid/mt, which produces the errors.
The ssd mounts have been already active (during boot by fstab).

If I mount all of them already during boot, the system mostly starts to
emergency mode which unfortunately is broken here.


Regards,
Andreas
