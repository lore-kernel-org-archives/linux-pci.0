Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sabertooth02.qualcomm.com ([65.197.215.38]:28681 "EHLO
	sabertooth02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab3CGP6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 10:58:04 -0500
From: "Huang, Xiong" <xiong@qca.qualcomm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"unified-drivers@lists.infradead.org"
	<unified-drivers@lists.infradead.org>,
	nic-devel <nic-devel@qca.qualcomm.com>
Subject: RE: [PATCH] PCI: add MSI INTX_DISABLE quirks for
 AR8161/AR8162/AR8171/AR8172
Date: Thu, 7 Mar 2013 15:57:59 +0000
Message-ID: <157393863283F442885425D2C4542856489D6DA2@nasanexd02f.na.qualcomm.com>
References: <1362549547-2160-1-git-send-email-xiong@qca.qualcomm.com>
 <20130307094214.GA2317@richard.(null)>
In-Reply-To: <20130307094214.GA2317@richard.(null)>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >+static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev) {
> >+	static u16 qca_eth_devid[] = {
> >+			PCI_DEVICE_ID_AR8161,
> >+			PCI_DEVICE_ID_AR8162,
> >+			PCI_DEVICE_ID_AR8171,
> >+			PCI_DEVICE_ID_AR8172};
> >+	struct pci_dev *p;
> >+	int i;
> >+
> >+	/* AR816X/AR817X MSI is fixed at HW level from revision 0x18 */
> >+	for (i = 0; i < ARRAY_SIZE(qca_eth_devid); i++) {
> >+		p = pci_get_device(PCI_VENDOR_ID_ATTANSIC,
> >+				   qca_eth_devid[i],
> 
> xiong,
> 
> The "FINAL" fixup is called just in pci_apply_final_quirks(), if I am correct.
> 
> In this function, it will go through all the pci devices which are registered in
> the system. And try to invoke the fixup hook.
> 
> Also, before invode the hook, in function pci_do_fixups() it will make sure
> the hook just apply to the devices whose VendorID and DeviceID match what
> you defined in DECLARE_PCI_FIXUP_FINAL.
> 
> So I think there is no need to iterate on all those pci device, before you want
> to change the pci_dev->dev_flags.
> 
> >+				   NULL);
> >+		if (!p)
> >+			return;
> >+
> >+		if (p->revision < 0x18)
> >+			dev->dev_flags |=
> PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
> >+		pci_dev_put(p);
> >+	}

Wei, thanks for you feedback, this patch is just follow the function 'quirk_msi_intx_disable_ati_bug' in quirks.c
Is it ok if I revise code as:
	static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
	{
		If (dev->revision < 0x18)
			dev->dev_flags |=  PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
	}

Please advise, thanks !

-Xiong
		

