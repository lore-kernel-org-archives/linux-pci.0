Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:42379 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162697Ab3DEULW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2013 16:11:22 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so4345919oag.20
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2013 13:11:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Apr 2013 14:11:01 -0600
Message-ID: <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics
 adapters on Power
To: Brian King <brking@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	klebers@linux.vnet.ibm.com, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 4, 2013 at 3:58 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
>
> Initialize dev->dev.type such that the PCI group attributes for boot_vga
> and SR-IOV can be displayed if appropriate. This fixes an issue seen on
> Power preventing X from auto initializing a graphics adapter when using KMS.
>
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>
>  arch/powerpc/kernel/pci_of_scan.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -puN arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type arch/powerpc/kernel/pci_of_scan.c
> --- linux/arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type    2013-04-03 09:43:19.000000000 -0500
> +++ linux-bjking1/arch/powerpc/kernel/pci_of_scan.c     2013-04-03 09:43:19.000000000 -0500
> @@ -141,6 +141,7 @@ struct pci_dev *of_create_pci_dev(struct
>         dev->dev.of_node = of_node_get(node);
>         dev->dev.parent = bus->bridge;
>         dev->dev.bus = &pci_bus_type;
> +       dev->dev.type = &pci_dev_type;
>         dev->devfn = devfn;
>         dev->multifunction = 0;         /* maybe a lie? */
>         dev->needs_freset = 0;          /* pcie fundamental reset required */

I think sparc has the same issue in its own copy of of_create_pci_dev().

Of course, both of_create_pci_dev() implementations are basically
copies of the generic pci_setup_device() that most arches use.  That's
the reason why I wish sparc and powerpc had used config space
accessors that hid the OF mangling internally so they could use the
generic pci_setup_device() instead of cloning it.

Of course, they don't, and that's too much work for fixing this issue,
but if anybody wanted to work on that, I think it would be an
interesting project.

But what if you set dev->dev.type in alloc_pci_dev()?  I think if you
did that, you wouldn't need to export "pci_dev_type," and  it should
fix this for both powerpc and sparc.

Bjorn
