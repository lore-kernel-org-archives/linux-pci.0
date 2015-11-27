Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63112 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbbK0VL0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2015 16:11:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] PCI: iproc: Add PAXC interface support
Date: Fri, 27 Nov 2015 22:11:15 +0100
Message-ID: <3529525.ts0Jjxrtm5@wuerfel>
In-Reply-To: <5658C365.5080209@broadcom.com>
References: <1448645868-5730-1-git-send-email-rjui@broadcom.com> <2502233.oJMLi3GpfH@wuerfel> <5658C365.5080209@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 27 November 2015 12:56:05 Ray Jui wrote:
> >
> > You seem to only need the identifiers in order to set a single
> > pointer, so just point to that array directly.
> 
> Not just a single pointer. This sets the iProc PCIe interface type, 
> which is an enum. Based on the interface type, both the iProc PCIe core 
> driver and the iProc PCIe MSI driver can 1) load the correct set of 
> register offsets; 2) skip/invoke some of the link detection, controller 
> reset related behaviors; 3) setting up the correct number of MSI event 
> queue regions and MSI address regions.

Ok, fair enough. I had missed 2) and 3) here. It could still be done
as a structure (rather than function pointers) with individual named
members for each register offset along with bool flags for 2) and
integers to describe 3).

Please that suggestion some thought, and then decide for yourself,
I won't complain if you keep the current version.

	Arnd
