Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43753 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab2B1DwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Feb 2012 22:52:19 -0500
Message-ID: <1330401133.11728.24.camel@pasglop>
Subject: Re: [PATCH] powerpc/PCI: compute I/O space bus-to-resource offset
 consistently
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 28 Feb 2012 14:52:13 +1100
In-Reply-To: <20120228025002.3990.7392.stgit@bhelgaas.mtv.corp.google.com>
References: <20120228025002.3990.7392.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2012-02-27 at 19:50 -0700, Bjorn Helgaas wrote:
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -219,9 +219,9 @@ void __devinit pcibios_setup_phb_io_space(struct
> pci_controller *hose)
>         struct resource *res = &hose->io_resource;
>  
>         /* Fixup IO space offset */
> -       io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
> -       res->start = (res->start + io_offset) & 0xffffffffu;
> -       res->end = (res->end + io_offset) & 0xffffffffu;
> +       io_offset = pcibios_io_space_offset(hose);
> +       res->start += io_offset;
> +       res->end += io_offset;
>  } 

Well, you are losing the 0xffffffff mask... so basically, what happens
is that your offset, if negative, will be 0 extended by
pcibios_io_space_offset() instead of sign-extended, and thus the
resource will have crap stuff in the top 32-bit.

As I said on irc, it might be a non-issue because the inX/outX accessors
are going to take an unsigned int port number anyway, but anything that
tries to print out that resource (or expose it to userspace) will look
bad.

One way to fix that is to ensure that pcibios_io_space_offset() does a
full sign extension to 64-bit.

Cheers,
Ben.


