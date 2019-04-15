Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D63FC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AB120880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfDOOGn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:06:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbfDOOGn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 10:06:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0157736DB3AAEA97740;
        Mon, 15 Apr 2019 22:06:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 22:06:30 +0800
Subject: Re: [PATCH -next] PCI: mvebu: Make mvebu_pci_bridge_emul_ops static
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190410140949.26716-1-yuehaibing@huawei.com>
 <20190415130009.GA12388@red-moon>
CC:     <thomas.petazzoni@bootlin.com>, <jason@lakedaemon.net>,
        <bhelgaas@google.com>, <gustavo.pimentel@synopsys.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6852d7a5-3f0f-ee82-89ef-f3d5caf7bd83@huawei.com>
Date:   Mon, 15 Apr 2019 22:06:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190415130009.GA12388@red-moon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/4/15 21:00, Lorenzo Pieralisi wrote:
> On Wed, Apr 10, 2019 at 10:09:49PM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warning:
>>
>> drivers/pci/controller/pci-mvebu.c:557:28: warning:
>>  symbol 'mvebu_pci_bridge_emul_ops' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
> 
> Is Mr.Robot reachable by email ?
> 
> If it is a CI bot I doubt it is useful to leave this tag there unless
> you want it for accounting purposes, just let me know.

Yes, it is our CI bot.

> 
> Thanks,
> Lorenzo
> 
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/pci/controller/pci-mvebu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
>> index d3a0419..ed032e9 100644
>> --- a/drivers/pci/controller/pci-mvebu.c
>> +++ b/drivers/pci/controller/pci-mvebu.c
>> @@ -554,7 +554,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>>  	}
>>  }
>>  
>> -struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
>> +static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
>>  	.write_base = mvebu_pci_bridge_emul_base_conf_write,
>>  	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
>>  	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
>> -- 
>> 2.7.4
>>
>>
> 
> .
> 

