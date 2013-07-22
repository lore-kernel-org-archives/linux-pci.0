Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54917 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab3GVRjk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 13:39:40 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so15895535iec.21
        for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2013 10:39:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Jul 2013 11:39:19 -0600
Message-ID: <CAErSpo405XN5f4tKp=kJhuqimoYV5+KhdZG=rJ31tkHdOEhx7A@mail.gmail.com>
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

Can you post the dmesg or console log showing the crash?  If somebody
else sees this crash, having the log in the mailing list archive will
help them figure out that this is the fix they need.

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
>
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
