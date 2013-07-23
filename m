Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:64907 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933456Ab3GWRka (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 13:40:30 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so11995946oag.13
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 10:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 23 Jul 2013 11:40:08 -0600
Message-ID: <CAErSpo6i63uB0+kUu-PkM0gt67ZZV-8=N+VpmRDXoVNgp0C7Ag@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix hotplug remove with sriov again
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Found hot-remove pcie card with sriov enabled cause crash in v3.10.
>
> It is regression caused by commit ba518e3c177547dfebf7fa7252cea0c850e7ce25
> (PCI: pciehp: Iterate over all devices in slot, not functions 0-7)
>
> That commit change to use bus->devices to iterate devices under
> bus to run pci_stop_and_remove_bus_device().
> Actually it duplicates the problem with those bus->devices iteratation
> that we try to fix in commit ac205b7bb72fa4227d2e79979bbe2b4687cdf44d
> (PCI: make sriov work with hotplug remove)
>
> Change to iterate reversely as we did last time.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Yijing Wang <wangyijing@huawei.com>
> Cc: <stable@vger.kernel.org> v3.9+

Applied to for-linus for v3.11, thanks.

> ---
>  drivers/pci/hotplug/pciehp_pci.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> @@ -92,7 +92,13 @@ int pciehp_unconfigure_device(struct slo
>         if (ret)
>                 presence = 0;
>
> -       list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
> +       /*
> +        * Need to iterate device reversely, as during
> +        * stop PF driver, VF will be removed, the list_for_each
> +        * could point to removed VF with temp.
> +        */
> +       list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> +                                        bus_list) {
>                 pci_dev_get(dev);
>                 if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
>                         pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
