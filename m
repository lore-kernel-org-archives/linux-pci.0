Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:63000 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbbDNHV5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2015 03:21:57 -0400
Message-ID: <552CBFDF.2010905@hisilicon.com>
Date: Tue, 14 Apr 2015 15:21:03 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
CC: zhangjukuo <zhangjukuo@huawei.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: [Query] PORT_LOGIC_SPEED_CHANGE set in PCIe designware driver
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

In pcie-designware.c, it sets the PORT_LOGIC_SPEED_CHANGE bit after linkup
finished:

dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
val |= PORT_LOGIC_SPEED_CHANGE;
dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);

As far as I know, it will try to use 5G/8G to communicate after setting this
bit. When I used LSI SAS2208 PCIe-RAID card to test PCIe host driver, PCIe3.0
link was unstable and can not read/write PCIe-RAID BAR. When I moved above
code before linkup, the process of enumeration was successful.

I wonder if anyone who also use the pcie-designware had met the same problem.
Could we move the PORT_LOGIC_SPEED_CHANGE before linkup?

It will be very appreciate if anyone can offer some information.

Thanks,
Zhou

