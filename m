Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:16180 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbbETDEi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 23:04:38 -0400
Message-ID: <555BF995.60209@hisilicon.com>
Date: Wed, 20 May 2015 11:03:49 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	"Arnd Bergmann" <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
	<gabriele.paoloni@huawei.com>, <yuanzhichang@hisilicon.com>,
	<zhangjukuo@huawei.com>, <liguozhu@hisilicon.com>
Subject: Re: [PATCH] PCI: designware: Add 8 lanes support
References: <1431499474-102380-1-git-send-email-wangzhou1@hisilicon.com> <20150519232243.GY31666@google.com>
In-Reply-To: <20150519232243.GY31666@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/20 7:22, Bjorn Helgaas wrote:
> On Wed, May 13, 2015 at 02:44:34PM +0800, Zhou Wang wrote:
>> This patch adds 8 lanes support. Following suggestion from Arnd, just split
>> this patch from http://www.spinics.net/lists/linux-pci/msg40467.html
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> 
> Applied to pci/host-designware for v4.2, with acks from Jingoo and
> Pratyush.  Thanks!

Thanks for the applying and the review from Jingoo and Pratyush.

Best Regards,
Zhou

> 
>> ---
>>  drivers/pci/host/pcie-designware.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index 2e9f84f..4ce0aa5 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -31,6 +31,7 @@
>>  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
>>  #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
>>  #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
>> +#define PORT_LINK_MODE_8_LANES		(0xf << 16)
>>  
>>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>>  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
>> @@ -38,6 +39,7 @@
>>  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
>>  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
>>  #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
>> +#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
>>  
>>  #define PCIE_MSI_ADDR_LO		0x820
>>  #define PCIE_MSI_ADDR_HI		0x824
>> @@ -778,6 +780,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>  	case 4:
>>  		val |= PORT_LINK_MODE_4_LANES;
>>  		break;
>> +	case 8:
>> +		val |= PORT_LINK_MODE_8_LANES;
>> +		break;
>>  	}
>>  	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
>>  
>> @@ -794,6 +799,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>  	case 4:
>>  		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>>  		break;
>> +	case 8:
>> +		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
>> +		break;
>>  	}
>>  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>  
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


