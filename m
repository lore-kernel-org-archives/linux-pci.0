Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:48748 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841AbbJGQK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 12:10:28 -0400
Date: Wed, 7 Oct 2015 18:10:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	iommu@lists.linux-foundation.org, Leo Duran <leo.duran@amd.com>,
	Christoph Hellwig <hch@lst.de>,
	device-mapper development <dm-devel@redhat.com>,
	Milan Broz <mbroz@redhat.com>, Jens Axboe <axboe@fb.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [dm-devel] AMD-Vi IO_PAGE_FAULTs and ata3.00: failed command:
 READ FPDMA QUEUED errors since Linux 4.0
Message-ID: <20151007161022.GI28811@8bytes.org>
References: <55BE1D5E.6020709@maya.org>
 <alpine.LRH.2.02.1508021347480.17729@file01.intranet.prod.int.rdu2.redhat.com>
 <55FE5740.2060701@maya.org>
 <20150929152100.GL3036@8bytes.org>
 <alpine.LRH.2.02.1509291143170.24174@file01.intranet.prod.int.rdu2.redhat.com>
 <20150929162042.GR3036@8bytes.org>
 <560BF73F.8000008@maya.org>
 <20151006101356.GE12506@8bytes.org>
 <56141507.7040103@maya.org>
 <56148A1B.5060506@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56148A1B.5060506@maya.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 07, 2015 at 04:57:31AM +0200, Andreas Hartmann wrote:
> Got it during a single mount (I booted with massively reduced mounts and
> did the mount afterwards manually. During the second manually mount, the
> problem can be seen).
> 
> I attached the requested files. The mount starts at 80 seconds.
> Hope this helps.

Okay, the lowest dma-addr the AMD IOMMU driver returns is 0x1000 and
the highest is 0x7ff4000. All fault addresses are outside of this range,
so the AMD IOMMU driver never returned these addresses.

This doesn't mean that it is not at fault, but it looks still unlikely.
Maybe I can reproduce the problem here. Can you please tell me some
details about the partitions you mounted to trigger this?

I remember something about a xfs->lvm->dm_crypt->md_raid->sata setup, but
having more details may help me to reproduce.



	Joerg

