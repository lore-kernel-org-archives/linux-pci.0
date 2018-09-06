Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:23680 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbeIFUhO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 16:37:14 -0400
Date: Thu, 6 Sep 2018 19:01:00 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 03/32] PCI: pciehp: Fix deadlock on unplug
Message-ID: <20180906160100.GQ2283@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> When pciehp was conceived it apparently wasn't considered that one
> hotplug port may be the parent of another, but with Thunderbolt this is
> par for the course.
> 
> If the sysfs interface is used to initiate a simultaneous card removal
> of two hotplug ports where one is a parent of the other, or if the two
> ports simultaneously signal interrupts, e.g. because a link or presence
> change was detected on both, a deadlock may occur if:
> 
> - The parent acquires pci_lock_rescan_remove(), starts removal of the
>   child and waits for it to be unbound.
> - The child waits to acquire pci_lock_rescan_remove() in order to
>   service the pending sysfs command or interrupt before it can unbind.
> 
> Fix by using pci_dev_is_disconnected() as an indicator whether a parent
> is removing the child, and avoid acquiring the lock in the child if so.
> Should the child happen to acquire the lock first, there's no deadlock.

This patch got dropped from your pciehp series but I wonder if you have
any plans to re-send it or rework it?

I'm asking because this is pretty real issue if you have longer chains
of devices and I've been using this patch to make the issue go away. So
even if this is not solving all possible problems, I think it may be
good idea to get included.
