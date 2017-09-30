Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:53170 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbdI3Ar2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2017 20:47:28 -0400
Received: by mail-qk0-f169.google.com with SMTP id o77so1176408qke.9
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2017 17:47:28 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Subject: [RFC] PCIe bus address at 0x00000000
Message-ID: <a9aba0db-4865-2a6b-b77c-9cb70a4eeab0@broadcom.com>
Date: Fri, 29 Sep 2017 17:47:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and all,

One of our ARM64 based processor (NS2) has our system address reversed 
for PCIe outbound transaction in the range of 0x0000_0000 and 
0x1fff_ffff. If we use 1:1 mapping between the system address and PCIe 
address, we end up having the PCIe address in the same range.

In this case, we noticed that certain USB-PCI adapters will decline 
access to BARs mapped in this address range with "Unsupported Request". 
In this case, if we change the PCIe address range to something else like 
0x8000_0000, it would work without an issue.

This sounds like an issue with the USB PCI adapter that cannot allow 
BARs to be used with specific PCIe address range. Is my understanding 
correct?

Thanks,

Ray
