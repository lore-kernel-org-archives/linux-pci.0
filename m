Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933323AbeFKN0y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jun 2018 09:26:54 -0400
Date: Mon, 11 Jun 2018 08:26:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/13] PCI/AER: Squash into one file
Message-ID: <20180611132653.GB75679@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 08, 2018 at 03:04:45PM -0500, Bjorn Helgaas wrote:
> The AER code is scattered across several files and buried a little too deep
> in the hierarchy, which makes it a bit of a hassle to browse.  Consolidate
> it all in a single file (plus the optional aer_inject module) and move it
> up one level to drivers/pci/pcie/aer.c.
> 
> This is all pure code moves; no functional changes intended.
> 
> ---
> 
> Bjorn Helgaas (13):
>       PCI/AER: Remove forward declarations
>       PCI/AER: Reorder code to group probe/remove stuff together
>       PCI/AER: Squash aerdrv_core.c into aerdrv.c
>       PCI/AER: Squash aerdrv_errprint.c into aerdrv.c
>       PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
>       PCI/AER: Squash ecrc.c into aerdrv.c
>       PCI/AER: Remove duplicate pcie_port_bus_type declaration
>       PCI/AER: Move pcie_aer_get_firmware_first() to portdrv.h
>       PCI/AER: Move aer_irq() declaration to portdrv.h
>       PCI/AER: Move private AER things to aerdrv.c
>       PCI/AER: Squash Kconfig.debug into Kconfig
>       PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/
>       PCI/AER: Use "PCI Express" consistently in Kconfig text

Applied to pci/aer-squash with Keith's reviewed-by for v4.18.
