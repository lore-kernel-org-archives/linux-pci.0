Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF55C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 01:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B3520833
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 01:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfDOByE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:54:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:54184 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDOByE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 21:54:04 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 21:54:02 EDT
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.158])
        by lucky1.263xmail.com (Postfix) with ESMTP id F00D32F0E7;
        Mon, 15 Apr 2019 09:46:52 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 0
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29205T140646411134720S1555292811449255_;
        Mon, 15 Apr 2019 09:46:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c3d1131c66fe1eae6618fdc8c5ef4cca>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: fix bitwise operations on status and
 ROCKCHIP_PCIE_EP_CMD_STATUS_IS
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Colin King <colin.king@canonical.com>
References: <20190330150910.9389-1-colin.king@canonical.com>
 <20190412095125.GB8113@red-moon>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <1df4816e-8d16-e894-e99e-ee16cd1c4cb8@rock-chips.com>
Date:   Mon, 15 Apr 2019 09:46:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412095125.GB8113@red-moon>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/4/12 17:51, Lorenzo Pieralisi wrote:
> On Sat, Mar 30, 2019 at 03:09:10PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the bitwise operations on the u16 variable 'status' with
>> the setting ROCKCHIP_PCIE_EP_CMD_STATUS_IS are incorrect because
>> ROCKCHIP_PCIE_EP_CMD_STATUS_IS is 1UL<<19 which is wider than the
>> u16 variable.  Fix this by making status a u32.  (Not tested).
>>
>> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Shawn,
> 
> I need your ACK on this patch, thanks.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>> index a5d799e2dff2..d743b0a48988 100644
>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>> @@ -350,7 +350,7 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
>>   	struct rockchip_pcie *rockchip = &ep->rockchip;
>>   	u32 r = ep->max_regions - 1;
>>   	u32 offset;
>> -	u16 status;
>> +	u32 status;
>>   	u8 msg_code;
>>   
>>   	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
>> -- 
>> 2.20.1
>>
> 
> 
> 


