Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdHCW5v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 18:57:51 -0400
Date: Thu, 3 Aug 2017 17:57:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: bhelgaas@google.com, scott@spiteful.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/5] constify hotplug pci_device_id
Message-ID: <20170803225749.GP20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 10:39:11PM +0530, Arvind Yadav wrote:
> pci_device_id are not supposed to change at runtime. All functions
> working with pci_device_id provided by <linux/pci.h> work with
> const pci_device_id. So mark the non-const structs as const.
> 
> Arvind Yadav (5):
>   [PATCH 1/5] PCI: hotplug: shpchp: constify pci_device_id.
>   [PATCH 2/5] PCI: hotplug: ibmphp: constify pci_device_id.
>   [PATCH 3/5] PCI: hotplug: bmphp_ebda: constify pci_device_id.
>   [PATCH 4/5] PCI: hotplug: cpcihp_zt5550: constify pci_device_id.
>   [PATCH 5/5] PCI: hotplug: cpqphp: constify pci_device_id.
> 
>  drivers/pci/hotplug/cpcihp_zt5550.c | 2 +-
>  drivers/pci/hotplug/cpqphp_core.c   | 2 +-
>  drivers/pci/hotplug/ibmphp_core.c   | 2 +-
>  drivers/pci/hotplug/ibmphp_ebda.c   | 2 +-
>  drivers/pci/hotplug/shpchp_core.c   | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Applied to pci/hotplug for v4.14, thanks!

I squashed these all into one patch since they all do the same thing and
are so trivial.
