Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37671 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434Ab2HPQme (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 12:42:34 -0400
Received: by lagy9 with SMTP id y9so1578606lag.19
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 09:42:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120810151150.a3942c58.izumi.taku@jp.fujitsu.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <20120810151150.a3942c58.izumi.taku@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Aug 2012 09:42:13 -0700
Message-ID: <CAErSpo6k8d6AfnSPpvenxjDU1rpqCBnYgNSJFL6cGkovJdNk1g@mail.gmail.com>
Subject: Re: [PATCH 1/7][RESEND] x86, PCI: Fix non acpi path pci_sysdata
 leaking with release_fn
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 9, 2012 at 11:11 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> From: Yinghai Lu <yinghai@kernel.org>
>
>     x86, PCI: Fix non acpi path pci_sysdata leaking with release_fn
>
>     Non acpi path, or root is not probed from acpi, during root bus removal
>     will get warning about leaking from pci_scan_bus_on_node.
>
>     Fix it with setting pci_host_bridge release function.
>
>     Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>     Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>
> ---
>  arch/x86/pci/common.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> Index: Bjorn-next-0808/arch/x86/pci/common.c
> ===================================================================
> --- Bjorn-next-0808.orig/arch/x86/pci/common.c
> +++ Bjorn-next-0808/arch/x86/pci/common.c
> @@ -634,17 +634,19 @@ int pci_ext_cfg_avail(struct pci_dev *de
>                 return 0;
>  }
>
> +static void release_pci_sysdata(struct pci_host_bridge *bridge)
> +{
> +       struct pci_sysdata *sd = bridge->release_data;
> +
> +       kfree(sd);
> +}
> +
>  struct pci_bus * __devinit pci_scan_bus_on_node(int busno, struct pci_ops *ops, int node)
>  {
>         LIST_HEAD(resources);
>         struct pci_bus *bus = NULL;
>         struct pci_sysdata *sd;
>
> -       /*
> -        * Allocate per-root-bus (not per bus) arch-specific data.
> -        * TODO: leak; this memory is never freed.
> -        * It's arguable whether it's worth the trouble to care.
> -        */
>         sd = kzalloc(sizeof(*sd), GFP_KERNEL);
>         if (!sd) {
>                 printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busno);
> @@ -654,7 +656,10 @@ struct pci_bus * __devinit pci_scan_bus_
>         x86_pci_root_bus_resources(busno, &resources);
>         printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busno);
>         bus = pci_scan_root_bus(NULL, busno, ops, sd, &resources);
> -       if (!bus) {
> +       if (bus)
> +               pci_set_host_bridge_release(to_pci_host_bridge(bus->bridge),
> +                                       release_pci_sysdata, sd);
> +       else {
>                 pci_free_resource_list(&resources);
>                 kfree(sd);
>         }
>

The patch itself is OK, but as far as I know, there's no mechanism for
removing a non-ACPI host bridge, so I don't think the release function
will ever be used, will it?
