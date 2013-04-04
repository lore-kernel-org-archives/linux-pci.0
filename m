Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48530 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764009Ab3DDRfJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 13:35:09 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so1798089obc.4
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2013 10:35:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <513fd46e.6983440a.0ebe.4853SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1362682516-9840-1-git-send-email-xiong@qca.qualcomm.com> <513fd46e.6983440a.0ebe.4853SMTPIN_ADDED_BROKEN@mx.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 4 Apr 2013 11:34:48 -0600
Message-ID: <CAErSpo6DOTdKi5ZKM=mVSOLLojD+vTwjbOmcJBbgiMY5ZR1kuA@mail.gmail.com>
Subject: Re: [PATCH] PCI: add MSI INTX_DISABLE quirks for AR8161/AR8162/AR8171/AR8172/E210X
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: xiong <xiong@qca.qualcomm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"unified-drivers@lists.infradead.org"
	<unified-drivers@lists.infradead.org>,
	nic-devel <nic-devel@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 12, 2013 at 7:20 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Fri, Mar 08, 2013 at 02:55:16AM +0800, xiong wrote:
>>From: "Huang,Xiong" <xiong@qca.qualcomm.com>
>>
>>following PCIe Devices with revision lower than 0x18 have this bug:
>>
>> AR8161(1091)/AR8162(1090)/AR8171(10A1)/AR8172(10A0)/E210X(E091).
>>
>>Signed-off-by: Huang,Xiong <xiong@qca.qualcomm.com>
>
> Reviewed-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Added Reviewed-by and applied to pci/misc for v3.10.  Thanks!

>>---
>> drivers/pci/quirks.c | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>
>>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>index 0369fb6..4273a2d 100644
>>--- a/drivers/pci/quirks.c
>>+++ b/drivers/pci/quirks.c
>>@@ -2594,6 +2594,14 @@ static void quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
>>               dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
>>       pci_dev_put(p);
>> }
>>+static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
>>+{
>>+      /* AR816X/AR817X/E210X MSI is fixed at HW level from revision 0x18 */
>>+      if (dev->revision < 0x18) {
>>+              dev_info(&dev->dev, "set MSI_INTX_DISABLE_BUG flag\n");
>>+              dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
>>+      }
>>+}
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>>                       PCI_DEVICE_ID_TIGON3_5780,
>>                       quirk_msi_intx_disable_bug);
>>@@ -2643,6 +2651,16 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1073,
>>                       quirk_msi_intx_disable_bug);
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1083,
>>                       quirk_msi_intx_disable_bug);
>>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1090,
>>+                      quirk_msi_intx_disable_qca_bug);
>>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1091,
>>+                      quirk_msi_intx_disable_qca_bug);
>>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a0,
>>+                      quirk_msi_intx_disable_qca_bug);
>>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
>>+                      quirk_msi_intx_disable_qca_bug);
>>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
>>+                      quirk_msi_intx_disable_qca_bug);
>> #endif /* CONFIG_PCI_MSI */
>>
>> /* Allow manual resource allocation for PCI hotplug bridges
>>--
>>1.7.11.7
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Richard Yang
> Help you, Help me
>
