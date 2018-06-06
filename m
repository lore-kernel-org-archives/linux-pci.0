Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbeFFMu1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jun 2018 08:50:27 -0400
Date: Wed, 6 Jun 2018 07:50:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: pci_error_handlers for pci_host_bridge ?
Message-ID: <20180606125025.GA100923@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx29KrKGDJiQ8huTpuVb7tMn=wjMWAvJEZaBiV7eSXYMSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx29KrKGDJiQ8huTpuVb7tMn=wjMWAvJEZaBiV7eSXYMSQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Subrahmanya,

On Wed, Jun 06, 2018 at 05:57:17PM +0530, Subrahmanya Lingappa wrote:
> Hi,
> according to https://github.com/torvalds/linux/blob/master/Documentation/PCI/pci-error-recovery.txt
> 
> as part of AER handling, struct pci_error_handlers{} is implemented by
> endpoint drivers to handle device specific recovery steps for "struct
> pci_driver".
> 
> But we have a platform_driver which implements "struct
> pci_host_bridge" which also supports AER capability how can we support
> pci_error_handlers() for the host bridge drivers ?

I assume you're referring to Mobiveil.  Can you explain more of the
topology here?  Can you also include "sudo lspci -vv" output?

The AER capability is an optional capability of PCIe device functions.
A host bridge is not itself a PCIe function; it's a bridge between a
platform-specific host bus and the PCIe bus.

Sometimes there is a PCI function that corresponds to the host bridge,
but that's not required by the PCI specs and there is no generic
programming model for it.

If you have an PCIe function corresponding to the Mobiveil host
bridge, and it has an AER capability, what would you want the error
handlers to do?  This function would not normally be a Root Port or
other type 1 PCI-to-PCI bridge device, so it's not clear how its AER
would integrate with the PCIe hierarchy.

Bjorn
