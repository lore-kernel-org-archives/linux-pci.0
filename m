Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8447 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbbIPBSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 21:18:11 -0400
Message-ID: <55F8C268.2020809@hisilicon.com>
Date: Wed, 16 Sep 2015 09:14:16 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux@arm.linux.org.uk>, <thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	<jason@lakedaemon.net>, <gabriel.fernandez@linaro.org>,
	<Minghuan.Lian@freescale.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>
Subject: Re: [PATCH v9 5/6] Documentation: DT: Add HiSilicon PCIe host binding
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com> <1442321361-174300-6-git-send-email-wangzhou1@hisilicon.com> <55F874F9.1060804@kernel.org>
In-Reply-To: <55F874F9.1060804@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/9/16 3:43, Rob Herring wrote:
> On 09/15/2015 07:49 AM, Zhou Wang wrote:
>> This patch adds related DTS binding document for HiSilicon PCIe host driver.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>> new file mode 100644
>> index 0000000..2afc9d1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>> @@ -0,0 +1,46 @@
>> +HiSilicon PCIe host bridge DT description
>> +
>> +HiSilicon PCIe host controller is based on Designware PCI core.
>> +It shares common functions with PCIe Designware core driver and inherits
>> +common properties defined in
>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>> +
>> +Additional properties are described here:
>> +
>> +Required properties:
>> +- compatible: Should contain "hisilicon,hip05-pcie".
>> +- reg: Should contain rc_dbi, subctrl, config registers location and length.
>> +- reg-names: Must include the following entries:
>> +  "rc_dbi": controller configuration registers;
>> +  "subctrl": whole PCIe hosts configuration registers;
>> +  "config": PCIe configuration space registers.
>> +- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
>> +- port-id: Should be 0, 1, 2 or 3.
> 
> What is port-id for? Use of instance indexes need to have good reason.
> 
> Rob

There are four PCIe controllers in HiSilicon Hip05 SoC, port-id just indicates
which one we use. And we will use port-id to locate related registers in driver.

Thanks,
Zhou

>
> 
> .
> 


