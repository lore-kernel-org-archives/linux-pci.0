Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0053.outbound.protection.outlook.com ([104.47.36.53]:47772
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751657AbcFIDGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2016 23:06:39 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Subject: PCIe EP DMA driver with DMA Framework
Date: Thu, 9 Jun 2016 02:51:14 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B1EDD@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

We are planning to write a PCIe EndPoint DMA driver with DMA Framework on x86 machine. ("https://www.kernel.org/doc/Documentation/dmaengine/provider.txt")
We are targeting to measure PCIe performance with this Framework driver. 

But I did not find any PCIe driver with DMA Framework. Please let me know if any such PCIe driver exists.

If there isn't any such driver, Please let me know if there are any limitations with DMA Framework to be used with PCIe or Is this DMA Engine Framework is targeted for different purpose and not for PCIe ?


Thanks
Bharat 




