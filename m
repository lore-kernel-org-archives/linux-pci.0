Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34529 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbJ3DES (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 23:04:18 -0400
Received: by padhk11 with SMTP id hk11so59412341pad.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2015 20:04:17 -0700 (PDT)
Subject: Re: [PATCH V10 04/12] powerpc/pci: Remove VFs prior to PF
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-5-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5632DE2C.4050306@ozlabs.ru>
Date: Fri, 30 Oct 2015 14:04:12 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-5-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/26/2015 02:15 PM, Wei Yang wrote:
> As commit ac205b7bb72f ("PCI: make sriov work with hotplug remove") indicates,
> VFs, which might be hooked to same PCI bus as their PF should be removed

A comma is missing before "should be" (or you did not need a comma after 
"VFs" may be :) ).


> before the PF. Otherwise, the PCI hot unplugging on the PCI bus would

s/on/of/? "Unplugging on" does not make much sense to me in this context at 
least.


> cause kernel crash.
>
> The patch applies the above pattern to PowerPC PCI hotplug path.
>
> [gwshan: changelog]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/pci-hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 7f9ed0c..59c4361 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -55,7 +55,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>
>   	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
>   		 pci_domain_nr(bus),  bus->number);
> -	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
> +	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
>   		pr_debug("   Removing %s...\n", pci_name(dev));
>   		pci_stop_and_remove_bus_device(dev);
>   	}
>


-- 
Alexey
