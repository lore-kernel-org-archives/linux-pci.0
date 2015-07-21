Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:43390 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421AbbGUQfT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jul 2015 12:35:19 -0400
Date: Tue, 21 Jul 2015 18:35:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
Message-ID: <20150721163517.GG10969@8bytes.org>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com>
 <20150721155635.GE10969@8bytes.org>
 <55AE7147.7070902@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AE7147.7070902@maya.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 06:20:23PM +0200, Andreas Hartmann wrote:
> [   48.193901] <6>[fglrx] Firegl kernel thread PID: 1840
> [   48.193985] <6>[fglrx] Firegl kernel thread PID: 1841
> [   48.194063] <6>[fglrx] Firegl kernel thread PID: 1842
> [   48.194172] <6>[fglrx] IRQ 28 Enabled
> [   48.261580] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000 
> [   48.261586] <6>[fglrx] Reserved FB block: Unshared offset:f7b4000, size:4000 
> [   48.261587] <6>[fglrx] Reserved FB block: Unshared offset:f7b8000, size:548000 
> [   48.261588] <6>[fglrx] Reserved FB block: Unshared offset:3fff3000, size:d000

>From a first glance it doesn't look like an IOMMU driver issue, because
the addresses where the faults happen are not from the AMD IOMMU driver.

And you have proprietary closed-source drivers loaded, can you reproduce
the issue without fglrx?


	Joerg

