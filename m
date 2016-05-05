Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:32993 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbcEERFJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2016 13:05:09 -0400
MIME-Version: 1.0
In-Reply-To: <1462281773-26438-23-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com> <1462281773-26438-23-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 5 May 2016 12:04:49 -0500
Message-ID: <CAL_JsqLAYk2S80LNvF2z2ZzPfCWAbpz2LNKK-04OgSkabjWbxQ@mail.gmail.com>
Subject: Re: [PATCH v9 22/22] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Bjorn Helgaas <bhelgaas@google.com>, dja@axtens.net,
	Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 3, 2016 at 8:22 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> This adds standalone driver to support PCI hotplug for PowerPC PowerNV
> platform that runs on top of skiboot firmware. The firmware identifies
> hotpluggable slots and marked their device tree node with proper
> "ibm,slot-pluggable" and "ibm,reset-by-firmware". The driver scans
> device tree nodes to create/register PCI hotplug slot accordingly.
>
> The PCI slots are organized in fashion of tree, which means one
> PCI slot might have parent PCI slot and parent PCI slot possibly
> contains multiple child PCI slots. At the plugging time, the parent
> PCI slot is populated before its children. The child PCI slots are
> removed before their parent PCI slot can be removed from the system.
>
> If the skiboot firmware doesn't support slot status retrieval, the PCI
> slot device node shouldn't have property "ibm,reset-by-firmware". In
> that case, none of valid PCI slots will be detected from device tree.
> The skiboot firmware doesn't export the capability to access attention
> LEDs yet and it's something for TBD.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

[...]

> +static void pnv_php_handle_poweron(struct pnv_php_slot *php_slot)
> +{
> +       void *fdt, *fdt1, *dt;
> +       int confirm = PNV_PHP_POWER_CONFIRMED_SUCCESS;
> +       int ret;
> +
> +       /* We don't know the FDT blob size. We try to get it through
> +        * maximal memory chunk and then copy it to another chunk that
> +        * fits the real size.
> +        */
> +       fdt1 = kzalloc(0x10000, GFP_KERNEL);
> +       if (!fdt1)
> +               goto error;
> +
> +       ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
> +       if (ret)
> +               goto free_fdt1;
> +
> +       fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
> +       if (!fdt)
> +               goto free_fdt1;
> +
> +       /* Unflatten device tree blob */
> +       memcpy(fdt, fdt1, fdt_totalsize(fdt1));

This is wrong. If the size is greater than 64K, then you will be
overrunning the fdt1 buffer. You need to fetch the FDT again if it is
bigger than 64KB.


> +       dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
> +       if (!dt) {
> +               dev_warn(&php_slot->pdev->dev, "Cannot unflatten FDT\n");
> +               goto free_fdt;
> +       }
> +
