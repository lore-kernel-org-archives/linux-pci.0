Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Unassigned resource fixes
Date: Thu, 12 Mar 2015 23:32:29 +0100
Message-ID: <12096280.cHMLsqHZdA@vostro.rjw.lan>
In-Reply-To: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, March 12, 2015 12:35:19 PM Bjorn Helgaas wrote:
> These are some minor resource fixes related to unassigned PCI BARs.  We
> should:
> 
>   - Mark BARS as unassigned when we can figure that out
>   - Not complain about "overlaps" with unassigned BARs
>   - Prevent pci_ioremap_bar() on unassigned BARs
>   - Give better error messages when pci_ioremap_bar() fails
> 
> I don't think these will actually fix any bugs, other than getting rid of
> some annoying messages and improving some others.
> 
> Comments welcome.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PNP: Don't check for overlaps with unassigned PCI BARs
>       PCI: Mark invalid BARs as unassigned
>       PCI: Show driver, BAR#, and resource on pci_ioremap_bar() failure
>       PCI: Fail pci_ioremap_bar() on unassigned resources
> 
> 
>  drivers/pci/pci.c       |    9 +++++----
>  drivers/pci/setup-res.c |    2 ++
>  drivers/pnp/quirks.c    |    9 ++++++---
>  3 files changed, 13 insertions(+), 7 deletions(-)

For the entire series:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
