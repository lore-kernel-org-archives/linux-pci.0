Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38360 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755043Ab2BVVlw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Feb 2012 16:41:52 -0500
Message-ID: <1329946899.20389.9.camel@pasglop>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with
 pci_flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>
Date: Thu, 23 Feb 2012 08:41:39 +1100
In-Reply-To: <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
	 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>  int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
> diff --git a/arch/powerpc/platforms/pasemi/pci.c
> b/arch/powerpc/platforms/pasemi/pci.c
> index b6a0ec4..b27d886 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -231,7 +231,7 @@ void __init pas_pci_init(void)
>         pci_devs_phb_init();
>  
>         /* Use the common resource allocation mechanism */
> -       pci_probe_only = 1;
> +       pci_add_flags(PCI_PROBE_ONLY);
>  }

Olof, do you remember why you used to set that on pasemi ?

I would have expected it to be clear, so the kernel can re-assign things
if needed. We really only want it set for pseries because of the
hypervisor being a PITA :-)

Cheers,
Ben.


