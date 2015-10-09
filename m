Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:50677 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741AbbJIRyW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 13:54:22 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [dm-devel] AMD-Vi IO_PAGE_FAULTs and ata3.00: failed command:
 READ FPDMA QUEUED errors since Linux 4.0
To: Joerg Roedel <joro@8bytes.org>,
	Andreas Hartmann <andihartmann@freenet.de>
References: <20151006101356.GE12506@8bytes.org> <56141507.7040103@maya.org>
 <56148A1B.5060506@maya.org> <20151007161022.GI28811@8bytes.org>
 <56154DEA.5050901@maya.org> <20151008163957.GK28811@8bytes.org>
 <5616B436.1000802@maya.org> <5616C998.1010309@maya.org>
 <56174EA6.7000106@maya.org> <56178599.6010807@maya.org>
 <20151009145951.GC27420@8bytes.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	iommu@lists.linux-foundation.org, Leo Duran <leo.duran@amd.com>,
	Christoph Hellwig <hch@lst.de>,
	device-mapper development <dm-devel@redhat.com>,
	Milan Broz <mbroz@redhat.com>, Jens Axboe <axboe@fb.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <5617FD6E.70802@maya.org>
Date: Fri, 9 Oct 2015 19:46:22 +0200
MIME-Version: 1.0
In-Reply-To: <20151009145951.GC27420@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jörg,

On 10/09/2015 at 04:59 PM, Joerg Roedel wrote:
> On Fri, Oct 09, 2015 at 11:15:05AM +0200, Andreas Hartmann wrote:
>> v4.3-rc4 isn't usable at all for me as long as is hangs the machine on
>> the necessary PCI passthrough for VMs (I need them).
> 
> If the fix I just sent you works, could you please test this again with
> a (patched) v4.3-rc4 kernel?

Your IOMMU-patch works fine - but the ata-problem can be seen here, too.
Same behavior as with 4.1.10.


Thanks,
regards,
Andreas
