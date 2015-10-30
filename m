Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:40785 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448AbbJ3Gcm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 02:32:42 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 30 Oct 2015 16:32:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3F19A3578047
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 17:32:33 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9U6WPCS58196064
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 17:32:33 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9U6W0eW030780
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2015 17:32:01 +1100
Date: Fri, 30 Oct 2015 14:31:34 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 04/12] powerpc/pci: Remove VFs prior to PF
Message-ID: <20151030063134.GA5940@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632DE2C.4050306@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5632DE2C.4050306@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 02:04:12PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:15 PM, Wei Yang wrote:
>>As commit ac205b7bb72f ("PCI: make sriov work with hotplug remove") indicates,
>>VFs, which might be hooked to same PCI bus as their PF should be removed
>
>A comma is missing before "should be" (or you did not need a comma after
>"VFs" may be :) ).
>

I think you are right.

>
>>before the PF. Otherwise, the PCI hot unplugging on the PCI bus would
>
>s/on/of/? "Unplugging on" does not make much sense to me in this context at
>least.
>

Sounds I need to improve my English :-)

"on" here means those PCI devices are attached to the PCI bus. So "of" is the
correct word?

Change "unplugging" to "removing" would be better?

>
>>cause kernel crash.
>>
>>The patch applies the above pattern to PowerPC PCI hotplug path.
>>
>>[gwshan: changelog]
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/kernel/pci-hotplug.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>>index 7f9ed0c..59c4361 100644
>>--- a/arch/powerpc/kernel/pci-hotplug.c
>>+++ b/arch/powerpc/kernel/pci-hotplug.c
>>@@ -55,7 +55,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>>
>>  	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
>>  		 pci_domain_nr(bus),  bus->number);
>>-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
>>+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
>>  		pr_debug("   Removing %s...\n", pci_name(dev));
>>  		pci_stop_and_remove_bus_device(dev);
>>  	}
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me

