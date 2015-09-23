Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:64003 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbIWD2K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2015 23:28:10 -0400
Message-ID: <56021BC4.9030000@hisilicon.com>
Date: Wed, 23 Sep 2015 11:25:56 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	<lorenzo.pieralisi@arm.com>, James Morse <james.morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Jason Cooper <jason@lakedaemon.net>, <robh@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Zhang Jukuo <zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liudongdong3@huawei.com>, <qiujiang@huawei.com>,
	<xuwei5@hisilicon.com>, Liguozhu <liguozhu@hisilicon.com>
Subject: Re: [PATCH v9 3/6] PCI: designware: Add ARM64 support
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com> <1442321361-174300-4-git-send-email-wangzhou1@hisilicon.com> <5600C285.5090603@hisilicon.com> <CAHM4w1mabn8SiE_oqWBbr1chrQTUPiUhc8fCsxJ0t=AyOZOadA@mail.gmail.com>
In-Reply-To: <CAHM4w1mabn8SiE_oqWBbr1chrQTUPiUhc8fCsxJ0t=AyOZOadA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/9/23 1:05, Pratyush Anand wrote:
> Hi Zhou,
> 
> On Tue, Sep 22, 2015 at 8:22 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>> On 2015/9/15 20:49, Zhou Wang wrote:
>>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
>>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>>> move related operations to dw_pcie_host_init.
>>>
>>> This patch also try to use of_pci_get_host_bridge_resources for ARM32 and ARM64
>>> according to the suggestion for Gabriele[1]
>>>
>>> This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
>>> untranslated address") based on 1/6 in this series. we delete *_mod_base in
>>> pcie-designware. This was discussed in [2]
>>>
>>> I have compiled the driver with multi_v7_defconfig. However, I don't have
>>> ARM32 PCIe related board to do test. It will be appreciated if someone could
>>> help to test it.
>>>
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Tested-by: James Morse <james.morse@arm.com>
>>> Tested-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>> Tested-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> Sorry for delayed response. Since I moved from ST, I do not have any
> test board having designware PCIe controller :(, and also I do
> designware work only in my hobby time,  so it took time to understand
> few modifications. Anyway, all modifications looks fine to me. So,
> 
> Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

Hi Pratyush,

Many thanks for your reviewing :)

Best Regards,
Zhou

> 
> PS: Does someone know about a economical test board from any vendor
> with designware PCIe IP?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


