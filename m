Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:60104 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbbGURwc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jul 2015 13:52:32 -0400
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
To: Joerg Roedel <joro@8bytes.org>,
	Andreas Hartmann <andihartmann@freenet.de>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com> <20150721155635.GE10969@8bytes.org>
 <55AE7147.7070902@maya.org> <20150721163517.GG10969@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <55AE85B2.2000004@maya.org>
Date: Tue, 21 Jul 2015 19:47:30 +0200
MIME-Version: 1.0
In-Reply-To: <20150721163517.GG10969@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 21.07.2015 um 18:35 schrieb Joerg Roedel:
> On Tue, Jul 21, 2015 at 06:20:23PM +0200, Andreas Hartmann wrote:
>> [   48.193901] <6>[fglrx] Firegl kernel thread PID: 1840
>> [   48.193985] <6>[fglrx] Firegl kernel thread PID: 1841
>> [   48.194063] <6>[fglrx] Firegl kernel thread PID: 1842
>> [   48.194172] <6>[fglrx] IRQ 28 Enabled
>> [   48.261580] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000 
>> [   48.261586] <6>[fglrx] Reserved FB block: Unshared offset:f7b4000, size:4000 
>> [   48.261587] <6>[fglrx] Reserved FB block: Unshared offset:f7b8000, size:548000 
>> [   48.261588] <6>[fglrx] Reserved FB block: Unshared offset:3fff3000, size:d000
> 
> From a first glance it doesn't look like an IOMMU driver issue, because
> the addresses where the faults happen are not from the AMD IOMMU driver.
> 
> And you have proprietary closed-source drivers loaded, can you reproduce
> the issue without fglrx?

The problem is, that the errors can't be seen always - only sometimes. I
could see them before w/ or w/o fglrx. There have been situations where
the machine didn't boot at all because of ata errors. But I never had
any problem w/ Linux 3.18.x or less.

Most probably you're right and it is not an IOMMU driver issue but maybe
a problem w/ the ahci driver. I have to keep track of it.


Thanks for your estimation.


Regards,
Andreas
