Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21577 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbcINIpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 04:45:46 -0400
Date: Wed, 14 Sep 2016 11:41:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Rajat Jain <rajatja@google.com>,
        MikaWesterberg@linux.intel.com, linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/8] PCI: pciehp: Rework hotplug interrupt routine
Message-ID: <20160914084117.GX1811@lahna.fi.intel.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 12, 2016 at 04:08:47PM -0500, Bjorn Helgaas wrote:
> This is mostly Mayurkumar's work from [1] and [2].  I split [2] into two
> patches and reworked it to keep the enclosing loop around the pciehp ISR.
> 
> The patches I added are trivial ones to clarify variable names, make dmesg
> messages consistent, and remove useless code.
> 
> [1] 1471554479-42083-1-git-send-email-mayurkumar.patel@intel.com
> [2] 92EBB4272BF81E4089A7126EC1E7B28466598F35@IRSMSX101.ger.corp.intel.com
> 
> ---
> 
> Bjorn Helgaas (5):
>       PCI: pciehp: Rename pcie_isr() locals for clarity
>       PCI: pciehp: Return IRQ_NONE when we can't read interrupt status
>       PCI: pciehp: Remove unnecessary guard
>       PCI: pciehp: Clean up dmesg "Slot(%s)" messages
>       PCI: pciehp: Remove useless pciehp_get_latch_status() calls
> 
> Mayurkumar Patel (3):
>       PCI: pciehp: Process all hotplug events before looking for new ones
>       PCI: pciehp: Don't re-read Slot Status when queuing hotplug event
>       PCI: pciehp: Don't re-read Slot Status when handling surprise event
> 
> 
>  drivers/pci/hotplug/pciehp_ctrl.c |   83 ++++++++++++---------------------
>  drivers/pci/hotplug/pciehp_hpc.c  |   94 ++++++++++++++++++++-----------------
>  2 files changed, 82 insertions(+), 95 deletions(-)

I don't have any machines with native PCIe hotplug support enabled but
regardless the series looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
