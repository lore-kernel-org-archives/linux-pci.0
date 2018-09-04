Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 18:44:41 -0400
Date: Tue, 4 Sep 2018 13:18:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 0/1] PCI: Handle conflict between hotplug and error
 handling
Message-ID: <20180904181824.GH107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180805225136.5800-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180805225136.5800-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 05, 2018 at 03:51:35PM -0700, Sinan Kaya wrote:
> Lukas:
> 'Your patch "[PATCH v6 1/1] PCI: pciehp: Ignore link events when there
> is a fatal error pending" only checks once for a pending fatal error,
> it should poll until either the fatal error is gone or a timeout is
> hit.  If the fatal error is gone and the link is up, you can just return
> from pciehp_handle_presence_or_link_change().  Else (in the timeout case)
> fall back to the normal handling of a Link Down, i.e. let it bring down
> the slot.'
> 
> 
> Sinan Kaya (1):
>   PCI: pciehp: Ignore link events when there is a fatal error pending
> 
>  drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++
>  drivers/pci/pci.h                 |  2 ++
>  drivers/pci/pcie/err.c            | 60 +++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)

Dropping for now because it sounds like you intend to mask out the
error for hotplug ports.
