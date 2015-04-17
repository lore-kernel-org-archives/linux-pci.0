Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:25023 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbbDQGpx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 02:45:53 -0400
Message-ID: <5530AC0F.3090301@hisilicon.com>
Date: Fri, 17 Apr 2015 14:45:35 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [Query] PORT_LOGIC_SPEED_CHANGE set in PCIe designware driver
References: <552CBFDF.2010905@hisilicon.com> <EE11001F9E5DDD47B7634E2F8A612F2E01385C3E@lhreml505-mbx.china.huawei.com>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01385C3E@lhreml505-mbx.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/4/14 17:48, Gabriele Paoloni wrote:
> Hi All
> 
> Looking at par 3.13 of "Synopsis DesignWare Cores PCI Express Controller Databook" v4.20a (pag 159) I've found:
> 
> <<Speed Changing
> 
> When you set the default of the Directed Speed Change field of the Link Width and Speed Change Control
> register (GEN2_CTRL_OFF . DIRECT_SPEED_CHANGE) using the DEFAULT_GEN2_SPEED_CHANGE
> configuration parameter to "1", then the speed change is initiated automatically after link up, and the core
> clears the contents of GEN2_CTRL_OFF . DIRECT_SPEED_CHANGE. If you want to prevent this automatic
> speed change, then write a lower speed value to the Target Link Speed field of the Link Control 2 register
> (LINK_CONTROL2_LINK_STATUS2_REG . PCIE_CAP_TARGET_LINK_SPEED) through the DBI before
> link up.>>
> 
> 
> So my interpretation would be that at init phase it would be correct to trigger the DIRECT_SPPED_CHANGE before the link is up; that is it seems correct to me to move that part of the code before link up.
> 
> Does anybody have any idea about this?
> 
> Many Thanks
> 
> Gab
> 

Hi Gab,

Thanks for your reply. I will send a formal patch based on v4.1-rc1.

Regards,
Zhou

> 
>> -----Original Message-----
>> From: Wangzhou (B)
>> Sent: Tuesday, April 14, 2015 8:21 AM
>> To: linux-pci@vger.kernel.org
>> Cc: zhangjukuo; Gabriele Paoloni; Liguozhu (Kenneth)
>> Subject: [Query] PORT_LOGIC_SPEED_CHANGE set in PCIe designware driver
>>
>> Hi All,
>>
>> In pcie-designware.c, it sets the PORT_LOGIC_SPEED_CHANGE bit after
>> linkup
>> finished:
>>
>> dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val); val |=
>> PORT_LOGIC_SPEED_CHANGE; dw_pcie_wr_own_conf(pp,
>> PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>>
>> As far as I know, it will try to use 5G/8G to communicate after setting
>> this bit. When I used LSI SAS2208 PCIe-RAID card to test PCIe host
>> driver, PCIe3.0 link was unstable and can not read/write PCIe-RAID BAR.
>> When I moved above code before linkup, the process of enumeration was
>> successful.
>>
>> I wonder if anyone who also use the pcie-designware had met the same
>> problem.
>> Could we move the PORT_LOGIC_SPEED_CHANGE before linkup?
>>
>> It will be very appreciate if anyone can offer some information.
>>
>> Thanks,
>> Zhou
> 
> 
> .
> 


