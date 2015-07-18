Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51180 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbGRDvD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 23:51:03 -0400
Date: Fri, 17 Jul 2015 20:50:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	rajatja@google.com, rjw@rjwysocki.net
Subject: Re: [PATCH v2 0/2] Fix a deadlock for aer and pciehp driver
Message-ID: <20150718035047.GA6108@roeck-us.net>
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 05:16:30PM +0800, Yijing Wang wrote:
> Yijing Wang (2):
>   PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
>   PCI: Lock pci_slot_mutex when traverse bus->slots
> 
>  arch/powerpc/kernel/pci_of_scan.c |    6 +-----
>  arch/sparc/kernel/pci.c           |    6 +-----
>  drivers/pci/probe.c               |    6 +-----
>  drivers/pci/slot.c                |   26 +++++++++++++++++++++-----
>  include/linux/pci.h               |    4 +++-
>  5 files changed, 27 insertions(+), 21 deletions(-)
> 
I'll give the series a try next week.

Guenter
