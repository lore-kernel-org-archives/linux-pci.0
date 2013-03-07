Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44100 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab3CGRoE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 12:44:04 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so553698obb.39
        for <linux-pci@vger.kernel.org>; Thu, 07 Mar 2013 09:44:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <157393863283F442885425D2C4542856489D6DA2@nasanexd02f.na.qualcomm.com>
References: <1362549547-2160-1-git-send-email-xiong@qca.qualcomm.com> <157393863283F442885425D2C4542856489D6DA2@nasanexd02f.na.qualcomm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Mar 2013 10:43:43 -0700
Message-ID: <CAErSpo4BEiL6+0LJo0_yavVv4gTBanJnp39FUX8eNL9Lqbmtfg@mail.gmail.com>
Subject: Re: [PATCH] PCI: add MSI INTX_DISABLE quirks for AR8161/AR8162/AR8171/AR8172
To: "Huang, Xiong" <xiong@qca.qualcomm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"unified-drivers@lists.infradead.org"
	<unified-drivers@lists.infradead.org>,
	nic-devel <nic-devel@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 7, 2013 at 8:57 AM, Huang, Xiong <xiong@qca.qualcomm.com> wrote:
>> >+static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev) {
>> >+    static u16 qca_eth_devid[] = {
>> >+                    PCI_DEVICE_ID_AR8161,
>> >+                    PCI_DEVICE_ID_AR8162,
>> >+                    PCI_DEVICE_ID_AR8171,
>> >+                    PCI_DEVICE_ID_AR8172};
>> >+    struct pci_dev *p;
>> >+    int i;
>> >+
>> >+    /* AR816X/AR817X MSI is fixed at HW level from revision 0x18 */
>> >+    for (i = 0; i < ARRAY_SIZE(qca_eth_devid); i++) {
>> >+            p = pci_get_device(PCI_VENDOR_ID_ATTANSIC,
>> >+                               qca_eth_devid[i],
>>
>> xiong,
>>
>> The "FINAL" fixup is called just in pci_apply_final_quirks(), if I am correct.
>>
>> In this function, it will go through all the pci devices which are registered in
>> the system. And try to invoke the fixup hook.
>>
>> Also, before invode the hook, in function pci_do_fixups() it will make sure
>> the hook just apply to the devices whose VendorID and DeviceID match what
>> you defined in DECLARE_PCI_FIXUP_FINAL.
>>
>> So I think there is no need to iterate on all those pci device, before you want
>> to change the pci_dev->dev_flags.
>>
>> >+                               NULL);
>> >+            if (!p)
>> >+                    return;
>> >+
>> >+            if (p->revision < 0x18)
>> >+                    dev->dev_flags |=
>> PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
>> >+            pci_dev_put(p);
>> >+    }
>
> Wei, thanks for you feedback, this patch is just follow the function 'quirk_msi_intx_disable_ati_bug' in quirks.c
> Is it ok if I revise code as:
>         static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
>         {
>                 If (dev->revision < 0x18)
>                         dev->dev_flags |=  PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
>         }

Per the comment in pci_ids.h, you should not add #defines there unless
they are used in more than one place.  So in this case, you would just
use the hex constants directly in quirks.c, as we already do for the
existing ATTANSIC quirks.

As far as the loop with pci_get_device(), the revised patch is
probably what you want, but it is not functionally equivalent to the
original.  Let's say you have two devices:

  1) 8161 rev 0x18
  2) 8171 rev 0x17

The original patch will disable MSI for the 8161 because there is
*another* device (the 8171) with rev < 0x18.  I doubt that's what you
want.

I'd like to see a dev_info() saying that you're disabling MSI for this
device so that when somebody complains "my device should be using MSI
but isn't," it's easy to figure out why not.

Bjorn
