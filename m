Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35308 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab2E2QOL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 May 2012 12:14:11 -0400
Received: by dady13 with SMTP id y13so5624058dad.19
        for <linux-pci@vger.kernel.org>; Tue, 29 May 2012 09:14:10 -0700 (PDT)
Message-ID: <4FC4F5BC.5000102@gmail.com>
Date: Wed, 30 May 2012 00:13:48 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Joerg Roedel <joerg.roedel@amd.com>
CC: Antonio Quartulli <ordex@autistici.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: Re: warn_slowpath_common in drivers/pci/search.c:44 on linux-3.4.0
References: <20120526082551.GA2723@ritirata.org> <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com> <20120529083552.GN2604@amd.com> <20120529085648.GA13941@ritirata.org> <20120529101657.GO2604@amd.com>
In-Reply-To: <20120529101657.GO2604@amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/29/2012 06:16 PM, Joerg Roedel wrote:
> On Tue, May 29, 2012 at 10:56:50AM +0200, Antonio Quartulli wrote:
>> attached!
>> Some days ago I tried to put some printk in the code and, as far as I can
>> understand, you are right.
> 
> Hmm, looks like device 03:00.0 is a 32bit PCI device attached to device
> 00:1c.2 which calls itself a Root Port instead of a PCI Bridge. I am
> not sure if the check in search.c is really necessary. As I see it there
> are also other possible pcie_types like PCI_EXP_TYPE_PCIE_BRIDGE.
> Putting Anil Keshavamurthy on Cc.
> 
> Anil, is this check in pci_find_upstream_pcie_bridge() really
> necessary:
> 
>         /* PCI device should connect to a PCIe bridge */
>         if (pdev->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE) {
>                 /* Busted hardware? */
>                 WARN_ON_ONCE(1);
>                 return NULL;
>         }
> 
> ? In the warning that triggers for Antonio the value of pcie_type seems
> to be PCI_EXP_TYPE_ROOT_PORT and from the available types I think that
> PCI_EXP_TYPE_PCIE_BRIDGE is also possible.
It seems that device 00:1c.2 is a real PCIe root port, and device 03:00.0
is a CardBus bridge. Should we call device 03:00.0 as Legacy Endpoint here?
Could a PCIe legacy endpoint be directly connected to root port and downstream
port? If the answer is yes, the assumption in pci_find_upstream_pcie_bridge()

BTW, does PCI_EXP_TYPE_PCIE_BRIDGE mean PCI/PCI-X to PCIe bridge? Do we
really have such chipsets?

Thanks
Gerry
> 
> Thanks,
> 
> 	Joerg
> 

