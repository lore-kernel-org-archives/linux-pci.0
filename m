Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36520 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbFEPLg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 11:11:36 -0400
Received: by qgep100 with SMTP id p100so29642921qge.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 08:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55714AA3.1070407@monstr.eu>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150604214929.2399.85988.stgit@bhelgaas-glaptop2.roam.corp.google.com> <55714AA3.1070407@monstr.eu>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Jun 2015 10:11:15 -0500
Message-ID: <CAErSpo6pMzOUwwxD0snOpcpdoCH5mBQhH2eXO74SVRnXvazX=A@mail.gmail.com>
Subject: Re: [PATCH 1/7] microblaze/PCI: Remove unused declarations
To: Michal Simek <monstr@monstr.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 5, 2015 at 2:07 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 06/04/2015 11:49 PM, Bjorn Helgaas wrote:
>> The following declarations were copied from powerpc but are unused on
>> microblaze:
>>
>>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
>>   int remove_phb_dynamic(struct pci_controller *phb)
>>   struct pci_dev *of_create_pci_dev(struct device_node *node, ...)
>>   void of_scan_pci_bridge(struct device_node *node, ...)
>>   void of_scan_bus(struct device_node *node, struct pci_bus *bus)
>>   void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
>>
>> Remove them.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Michal Simek <monstr@monstr.eu>
>> ---
>>  arch/microblaze/include/asm/pci.h |   12 ------------
>>  1 file changed, 12 deletions(-)
>
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
>
> Bjorn: Do you want me to take this via Microblaze tree?

Sure, it'd be great if you take all the Microblaze-specific patches.
There aren't any dependencies on them, so there shouldn't be any
problem.

I do have a Microblaze hunk in "PCI: Remove unused
pci_dma_burst_advice()" and if you agree, I'll merge that one through
my tree since the change for each arch is essentially identical.

Bjorn
