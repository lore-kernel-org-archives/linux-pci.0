Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbeAJXZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 18:25:22 -0500
Date: Wed, 10 Jan 2018 17:25:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederick Lawler <fred@fredlawl.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Add and use pci_<level>: dev_<level> equivalents
Message-ID: <20180110232519.GF241460@bhelgaas-glaptop.roam.corp.google.com>
References: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 07:16:12PM -0600, Frederick Lawler wrote:
> Replace current uses of dev_<level> with pci_<level> by adding and using
> PCI specific fuctions. 
> 
> Frederick Lawler (2):
>   PCI: Create  minor pci_dev log wrapper functions
>   PCI: Replace calls from dev_<level> to pci_<level>
> 
>  drivers/pci/access.c       |   6 +-
>  drivers/pci/bus.c          |   4 +-
>  drivers/pci/iov.c          |  10 +--
>  drivers/pci/irq.c          |   6 +-
>  drivers/pci/msi.c          |   6 +-
>  drivers/pci/pci-acpi.c     |   2 +-
>  drivers/pci/pci-stub.c     |   2 +-
>  drivers/pci/pci-sysfs.c    |  10 +--
>  drivers/pci/pci.c          |  76 ++++++++---------
>  drivers/pci/probe.c        |  74 ++++++++---------
>  drivers/pci/quirks.c       | 198 ++++++++++++++++++++++-----------------------
>  drivers/pci/rom.c          |   4 +-
>  drivers/pci/setup-bus.c    |  44 +++++-----
>  drivers/pci/setup-irq.c    |   4 +-
>  drivers/pci/setup-res.c    |  38 ++++-----
>  drivers/pci/vc.c           |  16 ++--
>  drivers/pci/xen-pcifront.c |  16 ++--
>  include/linux/pci.h        |  91 +++++++++++++++++++++
>  18 files changed, 349 insertions(+), 258 deletions(-)

Applied to pci/misc for v4.16, thanks!

I also updated a few more files in hotplug, AER, ASPM, PME, and PTM,
so if it breaks, it's probably my fault.
