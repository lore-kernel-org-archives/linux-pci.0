Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:53478 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755555AbdC2Nqd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 09:46:33 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id C1B1A280352
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:39:03 +0200 (CEST)
Received: from spamfilter2.desy.de (spamfilter2.desy.de [131.169.56.143])
        by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 1AB7215E9
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:39:03 +0200 (MEST)
Received: from spamfilter2.desy.de (localhost [127.0.0.1])
        by localhost.domain.tld (DESY MTA) with ESMTP id 5FD2A18E72D
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:39:01 +0200 (CEST)
Received: from amavis01.desy.de (lb-56-26.desy.de [131.169.56.26])
        by spamfilter2.desy.de (DESY MTA) with ESMTP id 580F818E72C
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:39:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by amavis01.desy.de (Postfix) with ESMTP id E34FD3FB11
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:39:00 +0200 (CEST)
Received: from amavis01.desy.de ([127.0.0.1])
        by localhost (amavis01.desy.de [127.0.0.1]) (amavisd-new, port 10027)
        with ESMTP id WL1wFUpMhrM8 for <linux-pci@vger.kernel.org>;
        Wed, 29 Mar 2017 15:39:00 +0200 (CEST)
Received: from smtp-intra-3.desy.de (lb-56-26.desy.de [131.169.56.26])
        by amavis01.desy.de (Postfix) with ESMTP id D8B6F3FB19
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:34:47 +0200 (CEST)
Received: from [131.169.146.36] (mcspetros.desy.de [131.169.146.36])
        by smtp-intra-3.desy.de (DESY-INTRA-3) with ESMTP id C295715C2
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 15:34:47 +0200 (MEST)
To: linux-pci@vger.kernel.org
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Subject: PCIe hotplug
Message-ID: <9dcf544b-33c5-60fb-48ca-3f34ecabf3b3@desy.de>
Date: Wed, 29 Mar 2017 15:34:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Linux PCI support team

I need help !

We are using MTCA crate system with the Ubuntu Linux for an accelerator 
control system.

The hotplug is very important for us, as most the crates are installed 
in the tunnel.

For a long time the PCIe hotplug works fine, we use the following boot 
parameters:

"noacpi noapic clock=tsc acpi=off apic=off pciehp.pciehp_force=1 
pciehp.pciehp_debug=1 pcie_ports=native"

After some point (seems after upgrading to kernel 3.x.x) we got problems 
(main problem is: the memories not remapped,

I mean: if I have some endpoint after removing and inserting back the 
memories are not remapped,

I know that I could not add new endpoint in running system, but it has 
to be possible to remove and insert back existing endpoint).

Now I am mixed out: what to use PCIe native hotplug or ACPI ..., I could 
not find any documentation about using PCIe hotplug

and how to configure.

Could somebody help me!

with best regards

Ludwig
