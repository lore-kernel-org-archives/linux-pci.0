Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:54577 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbbHCPs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Aug 2015 11:48:58 -0400
Date: Mon, 3 Aug 2015 17:48:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC PATCH 0/1] iommu: Detach device from domain when removed
 from group
Message-ID: <20150803154855.GI14980@8bytes.org>
References: <1438106156-51847-1-git-send-email-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438106156-51847-1-git-send-email-gerald.schaefer@de.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 07:55:55PM +0200, Gerald Schaefer wrote:
> On s390, this eventually leads to a kernel panic when binding the device
> again to its non-vfio PCI driver, because of the missing arch-specific
> cleanup in detach_dev. On x86, the detach_dev callback will also not be
> called directly, but there is a notifier that will catch
> BUS_NOTIFY_REMOVED_DEVICE and eventually do the cleanup. Other
> architectures w/o the notifier probably have at least some kind of memory
> leak in this scenario, so a general fix would be nice.

This notifier is not arch-specific, but registered against the bus the
iommu-ops are set for. Why does it not run on s390?


	Joerg

