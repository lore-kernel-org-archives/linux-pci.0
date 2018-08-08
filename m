Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39652 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeHHC1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2018 22:27:12 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so531942qtp.6
        for <linux-pci@vger.kernel.org>; Tue, 07 Aug 2018 17:10:19 -0700 (PDT)
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tomasz Nowicki <tn@semihalf.com>
Cc: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Subject: [RFC] ARM64, PCIe, annd ACPI
Message-ID: <89484aa0-08c4-0cff-500d-407d21e2f5fd@broadcom.com>
Date: Tue, 7 Aug 2018 17:10:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo/Bjorn,

I have a question on PCIe controller APCI support on ARM64 based systems.

If my understanding of the implementation of "pci_acpi_scan_root" under 
"arch/arm64/kernel/pci.c" is correct, it appears 
"pci_acpi_setup_ecam_mapping" is called within "pci_acpi_scan_root".

Does that mean for a PCIe host controller on ARM64 to support ACPI, it 
needs to support ECAM and MMIO based access to the configuration space 
registers?

If the above statement is true, does it imply that any PCIe controller 
on ARM64 that does not support MMIO based access to the config space 
register cannot have ACPI support?

I might be missing something here so I'd like to send out this email and 
get your opinion on this. Your feedback is highly appreciated.

Regards,

Ray
