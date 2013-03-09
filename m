Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:19602 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760297Ab3CIEow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 23:44:52 -0500
From: "Huang, Xiong" <xiong@qca.qualcomm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"unified-drivers@lists.infradead.org"
	<unified-drivers@lists.infradead.org>,
	nic-devel <nic-devel@qca.qualcomm.com>
Subject: RE: [PATCH] PCI: add MSI INTX_DISABLE quirks for
 AR8161/AR8162/AR8171/AR8172
Date: Sat, 9 Mar 2013 04:44:50 +0000
Message-ID: <157393863283F442885425D2C4542856489D731E@nasanexd02f.na.qualcomm.com>
References: <1362549547-2160-1-git-send-email-xiong@qca.qualcomm.com>
 <20130307094214.GA2317@richard.(null)>
 <157393863283F442885425D2C4542856489D6DA2@nasanexd02f.na.qualcomm.com>
 <20130308012236.GA5213@richard.(null)>
In-Reply-To: <20130308012236.GA5213@richard.(null)>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >Wei, thanks for you feedback, this patch is just follow the function
> >'quirk_msi_intx_disable_ati_bug' in quirks.c Is it ok if I revise code as:
> >	static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
> >	{
> >		If (dev->revision < 0x18)
> >			dev->dev_flags |=
> PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
> >	}
> 
> I think it is ok. Have you tested it?
> 
> If your test passed, I think you can send out another version.
> 

Wei, 
     I have tested it. It's ok.  thanks for your help.
     I sent out another version patch yesterday.

-Xiong
