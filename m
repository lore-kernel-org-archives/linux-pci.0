Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbbG1S6M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 14:58:12 -0400
Date: Tue, 28 Jul 2015 14:58:11 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: dm-devel@redhat.com, mpatocka@redhat.com,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: AMD-Vi IO_PAGE_FAULTs and ata3.00: failed command: READ FPDMA
 QUEUED errors since Linux 4.0
Message-ID: <20150728185811.GA25060@redhat.com>
References: <55B7BEA2.30205@01019freenet.de>
 <20150728175054.GB24782@redhat.com>
 <55B7C800.2070702@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B7C800.2070702@maya.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28 2015 at  2:20pm -0400,
Andreas Hartmann <andihartmann@freenet.de> wrote:

> On 07/28/2015 at 07:50 PM, Mike Snitzer wrote:
> [..]
> > Are your SATA devcies using NCQ?
> 
> Yes. It's enabled:
> 
> dmesg| grep -i ncq
> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part
> ata2.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
> ata3.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
> ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> 
> As the errors already come up on boot (during mount of partitions or
> even before the password for the disk has been provided): How can I
> disable NCQ during boot of the kernel? Is there a kernel option?

See:
https://ata.wiki.kernel.org/index.php/Libata_FAQ#Enabling.2C_disabling_and_checking_NCQ

alternatively, and likely easier, set this on the kernel commandline:
 libata.force=noncq
 
> I'm trying to apply your mentioned patches to 3.19 and report back.

OK.
