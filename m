Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44215 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099Ab2HXV0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Aug 2012 17:26:35 -0400
Received: by lbbgj3 with SMTP id gj3so1426646lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 24 Aug 2012 14:26:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
References: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 Aug 2012 15:26:13 -0600
Message-ID: <CAErSpo5KZZkoc=GfWUPmVQJAx8uA8v-v2YPp_8Y=LU5PU9Ga6g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Infrastructure for Vendor-Specific extended capabilities
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 13, 2012 at 3:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This adds pci_find_next_ext_capability(), analogous to
> pci_find_next_capability(), which allows drivers to iterate through
> multiple capabilities of the same type.

I applied these patches to my "next" branch.

> Many devices include multiple Vendor-Specific extended capabilities, for
> example:
>
> 00:00.0 Host bridge: Intel Corporation Sandy Bridge DMI2 (rev 06)
>   Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>   Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
>   Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>   Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>
>
>
> ---
>
> Bjorn Helgaas (2):
>       PCI: add pci_find_next_ext_capability()
>       PCI: add Vendor-Specific Extended Capability header info
>
>
>  drivers/pci/pci.c        |   40 ++++++++++++++++++++++++++++++----------
>  include/linux/pci.h      |    3 +--
>  include/linux/pci_regs.h |    6 ++++++
>  3 files changed, 37 insertions(+), 12 deletions(-)
>
> --
> Bjorn
