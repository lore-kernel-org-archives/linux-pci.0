Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54707 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761367Ab3DCXh6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 19:37:58 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so1978395obc.38
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2013 16:37:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Apr 2013 17:37:37 -0600
Message-ID: <CAErSpo4UNTKbH4ZORcArJF9GO627yMtYiTy8Q0wg_b0Vs3-QPQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Retrieve MSI/MSIX cap struct for once on setup
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 27, 2013 at 2:56 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> While we setup MSI or MSI-X for specific PCI device, the address of
> MSI or MSI-X capability structure is figured out from the config
> space for multiple times. That's unnecessary and the patchset addresses
> that. With the patchset applied, the latency for MSI or MSI-X setup
> would be decreased hopefully.
>
> drivers/pci/msi.c               |   51 ++++++++++++++++++++------------------
> drivers/pci/pcie/portdrv_core.c |    2 +-
> include/linux/pci.h             |    4 +-
> 3 files changed, 30 insertions(+), 27 deletions(-)

It seems a bit complicated to be passing around "pos" or "&pos" all
the time.  Wouldn't it be simpler to cache the MSI and MSI-X
capability addresses directly in the pci_dev, like we do for the PCIe
and PM capabilities?

Bjorn
