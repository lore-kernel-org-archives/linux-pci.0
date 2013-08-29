Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64303 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3H2DQR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 23:16:17 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so10679822ied.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 20:16:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
References: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Aug 2013 21:15:57 -0600
Message-ID: <CAErSpo7rxhWU0AobB3Pw8dHr0FT=vnMU1VCYLjoSnM7WvwvqrQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCIe capability #define tidyup
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 27, 2013 at 1:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> These clean up some PCIe capability #defines and comments.
>
> The first renames a few #defines that are used in drivers/mfd/rts5227.c.
>
> The rest are whitespace and comment changes that should have no effect on
> any users.
>
> I propose to put these in v3.12 unless there are issues.

I applied these to pci/misc and merged them to "next" for v3.12.

> ---
>
> Bjorn Helgaas (5):
>       PCI: Rename PCIe capability definitions to follow convention
>       PCI: Clarify PCI_EXP_TYPE_PCI_BRIDGE comment
>       PCI: Remove obsolete comment reference to pci_pcie_cap2()
>       PCI: Tidy bitmasks and spacing of PCIe capability definitions
>       PCI: Add offsets of PCIe capability registers
>
>
>  drivers/mfd/rts5227.c         |    2 -
>  drivers/pci/pci.c             |   31 ++++++-----
>  include/uapi/linux/pci_regs.h |  113 +++++++++++++++++++++--------------------
>  3 files changed, 77 insertions(+), 69 deletions(-)
