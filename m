Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.codelabs.ch ([217.150.249.120]:58090 "EHLO
	fenrir.codelabs.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbcCWKok (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2016 06:44:40 -0400
From: Adrian-Ken Rueegsegger <ken@codelabs.ch>
To: linux-pci@vger.kernel.org
Cc: ken@codelabs.ch
Subject: PCI support check in pcibios_init()
Date: Wed, 23 Mar 2016 11:34:28 +0100
Message-Id: <1458729269-9440-1-git-send-email-ken@codelabs.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

We are running Linux as a VM on top of the Muen Separation Kernel [1], where
we only allow PCI config space access of pass-through devices via MMCONFIG. In
this use case the PCI support check in pcibios_init() fails as raw_pci_ops is
not set:

int __init pcibios_init(void)
{
    if (!raw_pci_ops) {
        printk(KERN_WARNING "PCI: System does not support PCI\n");
        return 0;
    }
	...
}

As a consequence device resources are not allocated since the following call to
pcibios_resource_survey() is skipped. Extending the check to also consider
raw_pci_ext_ops (see patch) leads to the proper resource allocation in our use
case.

Is the described change the correct solution or is there a particular reason to
only check raw_pci_ops in pcibios_init()?

Regards,
Adrian

[1] - https://muen.codelabs.ch/

