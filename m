Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56252 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbbLDSBq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 13:01:46 -0500
Message-ID: <5661D506.6000509@arm.com>
Date: Fri, 04 Dec 2015 18:01:42 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/5] PCI: iproc: Add iProc PCIe MSI support
References: <1449250502-10679-1-git-send-email-rjui@broadcom.com> <1449250502-10679-5-git-send-email-rjui@broadcom.com>
In-Reply-To: <1449250502-10679-5-git-send-email-rjui@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/15 17:35, Ray Jui wrote:
> This patch adds PCIe MSI support for both PAXB and PAXC interfaces on
> all iProc based platforms
> 
> The iProc PCIe MSI support deploys an event queue based implementation.
> Each event queue is serviced by a GIC interrupt and can support up to 64
> MSI vectors. Host memory is allocated for the event queues, and each event
> queue consists of 64 word-sized entries. MSI data is written to the
> lower 16-bit of each entry, whereas the upper 16-bit of the entry is
> reserved for the controller for internal processing
> 
> Each event queue is tracked by a head pointer and tail pointer. Head
> pointer indicates the next entry in the event queue to be processed by
> the driver and is updated by the driver after processing is done.
> The controller uses the tail pointer as the next MSI data insertion
> point. The controller ensures MSI data is flushed to host memory before
> updating the tail pointer and then triggering the interrupt
> 
> MSI IRQ affinity is supported by evenly distributing the interrupts to
> each CPU core. MSI vector is moved from one GIC interrupt to another in
> order to steer to the target CPU
> 
> Therefore, the actual number of supported MSI vectors is:
> 
> M * 64 / N
> 
> where M denotes the number of GIC interrupts (event queues), and N
> denotes the number of CPU cores
> 
> This iProc event queue based MSI support should not be used with newer
> platforms with integrated MSI support in the GIC (e.g., giv2m or
> gicv3-its)
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Good thing I didn't reply on v4!

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
