Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936356AbeF2VrL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 17:47:11 -0400
Date: Fri, 29 Jun 2018 16:47:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: Support to workaround bus level HW issues
Message-ID: <20180629214708.GD40928@bhelgaas-glaptop.roam.corp.google.com>
References: <4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 01:25:22PM -0400, James Puthukattukaran wrote:
> There are bugs in certain PCIe switches that cause access violations when an
> endpoint device is hotplugged. In particular, there's an issue with
> certain IDT switches that trigger a ACS violation when bringing up a newly
> plugged PCIe endpoint device. This is a major issue for platforms
> designed to issue a fatal reset in the case of this event.
> 
> The first patch provides a framework for intercepting and working around
> issues with parent devices to the endpoint being brought up.
> 
> The second patch provides the actual patch for the IDT switch issue using
> that framework. The ACS feature is disabled in the IDT switch prior to endpoint
> device detection and then re-enabled subsequent to that.
> 
> James
> 
> -v2: move workaround to pci_bus_read_dev_vendor_id() from pci_bus_check_dev()
>      and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
> -v3: add bus->self check for root bus and virtual bus for sriov vfs.
> -v4: only do workaround for IDT switches
> -v5: tweak pci_std_enable_acs_sv to deal with unimplemented SV
> -v6: Added errata verbiage verbatim and resolved patch format issues
> -v7: changed int to bool for found and idt_workaround declarations. Also
>      added bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=196979
> -v8: Rewrote the patch by adding a new acs quirk to keep the workaround
>      out of the main code path
> -v9: changed function name from pci_dev_specific_fixup_acs_quirk to
>      pci_bus_acs_quirk. Also, tested for FLR and hot reset scenarios and did
>      not see issues where workaround was required. The issue seems to be
>      related only to cold reset/power on situation.
> -v10: Moved the contents of pci_bus_read_vendor_id into an internal function
>       __pci_bus_read_vendor_id
> -v11: Split the patch into two patches. The first a general quirk framework.
> -v12: Add pci_bus_generic_read_dev_vendor_id() to carry out default behavior
>       when detecting endpoint and pci_bus_specific_read_dev_vendor_id for
>       bus quirk behavior
> -v13: Fixed build errors found for non-x86 platforms via cross compiles when
>       CONFIG_QUIRKS is not defined

This email is labeled v2, but you go up to v13 here.  Obviously this must
be at least v14.

If this post is actually v13, please label the next version v14.  If this
post is different from v13, that means *this* one is really v14 and the
next one should be v15.

> James Puthukattukaran (2):
>   PCI: Add pci_bus_specific_read_dev_vendor_id() to workaround PCI
>     switch     specific issues prior to accessing newly added endpoint
>   PCI: Implement workaround for the ACS bug in the IDT switch
> 
>  drivers/pci/pci.h    |  13 +++++
>  drivers/pci/probe.c  |  20 +++++++-
>  drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+), 1 deletion(-)
> 
> -- 
> 1.8.3.1
> 
