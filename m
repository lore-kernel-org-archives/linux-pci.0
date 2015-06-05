Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:50954 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbFEIPi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 04:15:38 -0400
Message-ID: <55715A24.1030007@hisilicon.com>
Date: Fri, 5 Jun 2015 16:13:24 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: James Morse <james.morse@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"fabrice.gasnier@st.com" <fabrice.gasnier@st.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v2 3/4] PCI: hisi: Add PCIe host support for Hisilicon
 Soc Hip05
References: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com> <1433320542-49576-4-git-send-email-wangzhou1@hisilicon.com> <55705163.3070201@arm.com>
In-Reply-To: <55705163.3070201@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/4 21:23, James Morse wrote:
> On 03/06/15 09:35, Zhou Wang wrote:
>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
>> new file mode 100644
>> index 0000000..2a4d72e
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-hisi.c
> 
> New file? Please update MAINTAINERS.
> (Also add your new Documentation file in patch 4/4 with that patch)
> 
> 
> Thanks,
> 
> James

Ok, wil add this patch next version.

Thanks,
ZHou

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


