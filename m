Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbdC3D4n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 23:56:43 -0400
Date: Wed, 29 Mar 2017 22:56:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv6 0/5] Limiting PCI access
Message-ID: <20170330035639.GA23926@bhelgaas-glaptop.roam.corp.google.com>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 02:32:32PM -0500, Keith Busch wrote:
> The code is functionally equivalent to v5. I've fixed the style
> points mentioned in review on line warpping, adjusted the change log
> on the msi/msix skippage to not exclude mentioning msi, and added the
> accumulated Reviewed-by's.
> 
> Keith Busch (5):
>   pci: Export pci device config accessors
>   pci: Add device disconnected state
>   pci: No config access for disconnected devices
>   pci/msix: Skip disabling disconnected devices
>   pci: Quick return for pci_device_is_present
> 
>  drivers/pci/access.c             | 56 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/hotplug/pciehp_pci.c |  6 +++++
>  drivers/pci/msi.c                |  7 ++++-
>  drivers/pci/pci.c                |  2 ++
>  drivers/pci/pci.h                | 14 ++++++++++
>  drivers/pci/pcie/pcie-dpc.c      |  5 ++++
>  include/linux/pci.h              | 34 ++++++------------------
>  7 files changed, 97 insertions(+), 27 deletions(-)

Applied to pci/enumeration for v4.12 with

  Tested-by: Krishna Dhulipala <krishnad@fb.com>
  Reviewed-by: Wei Zhang <wzhang@fb.com>

Thanks!
