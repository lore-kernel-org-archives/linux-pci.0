Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([119.145.14.52]:53474 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751466AbcG1IQH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 04:16:07 -0400
From: wangyijing <wangyijing@huawei.com>
Subject: Question about cacheline size in PCIe SAS card
To: <linux-pci@vger.kernel.org>
CC: <jianghong011@huawei.com>, <wangyijing@huawei.com>
Message-ID: <5799BF23.2020902@huawei.com>
Date: Thu, 28 Jul 2016 16:15:31 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all, we found a question about PCIe cacheline, the cacheline here is mean the
configure space register at offset 0x0C in type 0 and type 1 configure space header.

We did a hotplug in our platform for PCIe SAS controller, this sas controller has
SSD disks and the disk sector is 520 bytes. Defaultly, BIOS set cacheline size to
64bytes, we test the IO read(io size is 128k/256k), the bandwith is 6G.
After hotplug, the cacheline size in SAS controller changes to 0(default after #RST),
and we test the IO read again, the bandwith changes to 5.2G.

We Tested other SAS controller which is not 520 bytes sector, we didn't found this issue,
and I grep the PCI_CACHE_LINE_SIZE in kernel, I found most of code change the PCI_CACHE_LINE_SIZE
are device driver, like net, ata, and some arm pci controller.

In PCI 3.0 spec, I found there are descriptions about cacheline size releated to performance,
but in PCIe 3.0 spec, there is nothing related to cacheline size.

I wonder what's cacheline register roles in PCIe spec, how can we use it correctly ?

Thanks!
Yijing.

