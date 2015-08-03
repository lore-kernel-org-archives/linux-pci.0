Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:60051 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbbHCRE2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 13:04:28 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
	Mon, 3 Aug 2015 18:04:26 +0100
Date: Mon, 3 Aug 2015 19:04:20 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC PATCH 0/1] iommu: Detach device from domain when removed
 from group
Message-ID: <20150803190420.74396481@thinkpad>
In-Reply-To: <20150803154855.GI14980@8bytes.org>
References: <1438106156-51847-1-git-send-email-gerald.schaefer@de.ibm.com>
	<20150803154855.GI14980@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 3 Aug 2015 17:48:55 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Tue, Jul 28, 2015 at 07:55:55PM +0200, Gerald Schaefer wrote:
> > On s390, this eventually leads to a kernel panic when binding the device
> > again to its non-vfio PCI driver, because of the missing arch-specific
> > cleanup in detach_dev. On x86, the detach_dev callback will also not be
> > called directly, but there is a notifier that will catch
> > BUS_NOTIFY_REMOVED_DEVICE and eventually do the cleanup. Other
> > architectures w/o the notifier probably have at least some kind of memory
> > leak in this scenario, so a general fix would be nice.
> 
> This notifier is not arch-specific, but registered against the bus the
> iommu-ops are set for. Why does it not run on s390?

Adding the notifier would of course also work on s390 (and all other affected
architectures). However, it seems that the "missing detach_dev" issue in this
scenario is not fundamentally fixed by using this notifier, it just seems to
hide the symptom by chance.

Adding the otherwise unneeded notifier just to work around this issue somehow
doesn't seem right, also given that x86 is so far the only user of it. At
least I thought it would be cleaner to fix it in common code and for all
architectures. Not sure what's wrong with fixing the asymmetry as suggested
in my patch, but I guess there are good reasons for having this asymmetry.

For now, I'll just add the notifier to my s390 implementation and post it
soon.

> 
> 
> 	Joerg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

