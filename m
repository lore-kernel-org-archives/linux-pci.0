Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:46484 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbcIHRfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2016 13:35:07 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id C4749A57
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2016 17:35:05 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 9EC2E54
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2016 17:34:59 +0000 (UTC)
Received: from div_linux.localnet (unknown [16.93.61.14])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 8C12E51
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2016 17:34:59 +0000 (UTC)
From: divakar <divakar.chitturi@hpe.com>
To: linux-pci@vger.kernel.org
Subject: multiple uio support for single pci device
Date: Thu, 08 Sep 2016 10:30:19 -0700
Message-ID: <2406414.7j1iKk5fDN@div_linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi 

My fpga device has multiple msi interrupts and I am trying to create an 
uio device for each msi interrupt. In the probe function of the pci 
device, I enable MSI for the pci device and allocate mem for uio info 
structures ( one for each msi ). First uio-info->irq is equal to the irq 
number in pdev->irq and It successfully creates /dev/uio-0 . For the 
second msi  i assign uio_info->irq = pdev->irq + 1 and different 
uio_info->name, but uio_register_device fails. When traced it fails at 
the devm_request_irq function. I am running on 3.19 kernel and after 
checking the latest 4.7 I noticed devm_request has changed to 
request_irq. I get the same error even with request_irq. 

- Does the uio framework support multiple uio's for the same pci device?
- if yes, is there something extra i need to do ?
 
Please let me know if I can provide any more information. Below is the 
log from my driver.
 
 103 fpga_uio_probe FPGA_PCI_UIO: probe
105 fpga_uio_probe FPGA_PCI_UIO: bar_base=183fffc00000
107 fpga_uio_probe FPGA_PCI_UIO: bar_len=1048576
125 fpga_uio_probe FPGA_PCI_UIO: pci_enable_device
132 fpga_uio_probe FPGA_PCI_UIO: pci_request_region
147 fpga_uio_probe FPGA_PCI_UIO: pci_iomap
153 fpga_uio_probe FPGA_PCI_UIO: base_add=ffffc90012a00000
169 fpga_uio_probe FPGA_PCI_UIO: nmsi_requested =8
211 fpga_uio_probe FPGA_PCI_UIO: irq_starting_indx =101
219 fpga_uio_probe FPGA_PCI_UIO: alloc mem for fpudev
226 fpga_uio_probe FPGA_PCI_UIO: alloc mem for uio_info
233 fpga_uio_probe FPGA_PCI_UIO: alloc mem for uio_priv_info
298 fpga_uio_probe FPGA_PCI_UIO: reg uio dev
__uio_register_device 805
__uio_register_device 813
__uio_register_device 819
__uio_register_device 821 get_minor ret=0
__uio_register_device 825
__uio_register_device 835
__uio_register_device 840
__uio_register_device 846 devm_request ret=0
__uio_register_device 851
311 fpga_uio_probe FPGA_PCI_UIO: Enable all INT

298 fpga_uio_probe FPGA_PCI_UIO: reg uio dev
__uio_register_device 805
__uio_register_device 813
__uio_register_device 819
__uio_register_device 821 get_minor ret=0
__uio_register_device 825
__uio_register_device 835
__uio_register_device 840
__uio_register_device 846 devm_request ret=-22
304 fpga_uio_probe FPGA_PCI_UIO: Failed to register uio device for 
msi=102, irq=1 ret=-22

Thanks
