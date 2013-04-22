Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41028 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530Ab3DVXYe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Apr 2013 19:24:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 02/22] PCI: Use u8, not int, for PM capability offset
Date: Tue, 23 Apr 2013 01:32:37 +0200
Message-ID: <3048768.cqCDjiVfL5@vostro.rjw.lan>
In-Reply-To: <20130422231026.32621.14207.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop> <20130422231026.32621.14207.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 22, 2013 05:10:26 PM Bjorn Helgaas wrote:
> The Power Management Capability (PCI_CAP_ID_PM == 0x01) is defined by PCI
> and must appear in the 256-byte PCI Configuration Space from 0-0xff.  It
> cannot be in the PCIe Extended Configuration space from 0x100-0xfff, so
> we only need a u8 to hold its offset.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/pci.h |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2461033a..9587d4d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -249,8 +249,7 @@ struct pci_dev {
>  	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
>  					   this is D0-D3, D0 being fully functional,
>  					   and D3 being off. */
> -	int		pm_cap;		/* PM capability offset in the
> -					   configuration space */
> +	u8		pm_cap;		/* PM capability offset */
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
>  	unsigned int	pme_interrupt:1;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
