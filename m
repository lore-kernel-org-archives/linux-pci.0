Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40279 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab2AZRR6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2012 12:17:58 -0500
Received: by ghrr11 with SMTP id r11so349829ghr.19
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2012 09:17:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F2183A2.7010007@jp.fujitsu.com>
References: <20120119223221.15239.6758.sendpatchset@dhcp-189-101.bos.redhat.com>
	<CAE9FiQWKRxZcm2FBhP2SxaBGYpROc4grJQtE68OyayPhjQHdsA@mail.gmail.com>
	<4F2183A2.7010007@jp.fujitsu.com>
Date: Thu, 26 Jan 2012 09:17:57 -0800
Message-ID: <CAE9FiQWQzwYQz7MAGC=Gjpr5HMsT-bn5t77fi7EKD1LDGbXizg@mail.gmail.com>
Subject: Re: [PATCH v4] Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp driver
From: Yinghai Lu <yinghai@kernel.org>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, greg@kroah.com,
	kaneshige.kenji@jp.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 26, 2012 at 8:47 AM, MUNEDA Takahiro
<muneda.takahiro@jp.fujitsu.com> wrote:
> On Thu, 19 Jan 2012 15:41:09 -0800,
> Yinghai Lu <yinghai@kernel.org> wrote:
>
> snip
>
>>> Index: linux-3.2/drivers/pci/quirks.c
>>> ===================================================================
>>> --- linux-3.2.orig/drivers/pci/quirks.c
>>> +++ linux-3.2/drivers/pci/quirks.c
>>> @@ -2665,6 +2665,35 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AT
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4375,
>>>                        quirk_msi_intx_disable_bug);
>>>
>>> +/*
>>> + * The PCI bridge from Integrated Device Technology(IDT) has a problem
>>> + * with MSI/MSI-X.
>>> + * An un-wanted interrupt is generated when PCI driver switches from
>>> + * MSI/MSI-X to INTx while shutting down the PCI Express port, if it
>>> + * provides the Native Hotplug service.  The interrupt does not happen
>>> + * if MSI/MSI-X is not used on it.  Therefore, turn off MSI/MSI-X for
>>> + * this device.
>>> + */
>>> +static void __devinit idt_bridge_msi_disable(struct pci_dev *dev)
>>> +{
>>> +       int pos;
>>> +       u16 reg16;
>>> +       u32 reg32;
>>> +
>>> +       pos = pci_pcie_cap(dev);
>>> +       if (!pos)
>>> +               return;
>>> +       pci_read_config_word(dev, pos + PCI_EXP_FLAGS,&reg16);
>>> +       if (!(reg16&  PCI_EXP_FLAGS_SLOT))
>>>
>>> +               return;
>>> +       pci_read_config_dword(dev, pos + PCI_EXP_SLTCAP,&reg32);
>>> +       if (reg32&  PCI_EXP_SLTCAP_HPC) {
>>>
>>> +               pci_msi_off(dev);
>>> +               dev->no_msi = 1;
>>> +       }
>>> +}
>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IDT, 0x807f,
>>> idt_bridge_msi_disable);
>>
>>
>> do you have statement for IDT, says that is chipset problem ?
>
>
> I'm trying to contact to them, but not yet.
>
>
>> it could be your platform fw problem.
>>
>> if that is the case, you will disable MSI/MSIX for other platform that
>> do not have fw problem.
>
>
> Yinghai,
> Btw, how about other pieces?  I'm thinking to drop the quirk code temporary,
> until I get the comment from them.
> Can you give an ACK if I remove the hardware specific quirk code?

yes, other part is ok.

Actually quirk code should be separated to another patch.

Thanks

Yinghai
