Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:56401 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbbG1SYq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 14:24:46 -0400
Subject: Re: AMD-Vi IO_PAGE_FAULTs and ata3.00: failed command: READ FPDMA
 QUEUED errors since Linux 4.0
To: Mike Snitzer <snitzer@redhat.com>,
	Andreas Hartmann <andihartmann@01019freenet.de>
References: <55B7BEA2.30205@01019freenet.de>
 <20150728175054.GB24782@redhat.com>
Cc: dm-devel@redhat.com, mpatocka@redhat.com,
	linux-pci <linux-pci@vger.kernel.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <55B7C800.2070702@maya.org>
Date: Tue, 28 Jul 2015 20:20:48 +0200
MIME-Version: 1.0
In-Reply-To: <20150728175054.GB24782@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/28/2015 at 07:50 PM, Mike Snitzer wrote:
[..]
> Are your SATA devcies using NCQ?

Yes. It's enabled:

dmesg| grep -i ncq
ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part
ata2.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata3.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA

As the errors already come up on boot (during mount of partitions or
even before the password for the disk has been provided): How can I
disable NCQ during boot of the kernel? Is there a kernel option?

I'm trying to apply your mentioned patches to 3.19 and report back.

> 
> Please see this dm-devl thread (and this post in particular):
> https://www.redhat.com/archives/dm-devel/2015-June/msg00005.html
> 

Thanks,
Andreas
