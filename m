Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46AC43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 12:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFBA20851
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 12:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfAQMH0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:07:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfAQMH0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 07:07:26 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EA785B104751EFBA7BE4;
        Thu, 17 Jan 2019 20:07:23 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 20:07:14 +0800
Subject: Re: [RFC PATCH] PCI: hotplug: Fix surprise removal report card
 present and link failed
To:     Lukas Wunner <lukas@wunner.de>
References: <1547649064-19019-1-git-send-email-liudongdong3@huawei.com>
 <20190116142235.6drd6avwk3e7rtwd@wunner.de>
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <aeec5f59-1f41-65d0-b2c1-7a606e32e58b@huawei.com>
Date:   Thu, 17 Jan 2019 20:07:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190116142235.6drd6avwk3e7rtwd@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas

Many thanks for your reply.

在 2019/1/16 22:22, Lukas Wunner 写道:
> [cc += Mika]
>
> On Wed, Jan 16, 2019 at 10:31:04PM +0800, Dongdong Liu wrote:
>> The lspci -tv topology is as below.
>>  +-[0000:80]-+-00.0-[81]----00.0  Huawei Technologies Co., Ltd. Device 3714
>>  |           +-02.0-[82]----00.0  Huawei Technologies Co., Ltd. Device 3714
>>  |           +-04.0-[83]----00.0  Huawei Technologies Co., Ltd. Device 3714
>>  |           +-06.0-[84]----00.0  Huawei Technologies Co., Ltd. Device 3714
>>  |           +-10.0-[87]----00.0  Huawei Technologies Co., Ltd. Device 3714
>>
>> Then surprise removal 87:00.0 NVME SSD card. The message is as below.
>>
>> pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
>> iommu: Removing device 0000:87:00.0 from group 12
>> pciehp 0000:80:10.0:pcie004: Slot(36): Card present
>> pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
>> pciehp 0000:80:10.0:pcie004: Failed to check link status
>
> What is the problem that you're trying to fix?  That these messages
> are logged?  Or is there a bigger issue?  If the only problem are the
> messages, then I feel that the current behavior is a feature, not a bug.
> We could probably tone down the "Failed to check link status" message's
> severity.  (Currently it's KERN_ERR, all the other messages are KERN_INFO.)
>

Yes, the only problem is the messages, looks not good,
as the card have been removed from board, the message still show
card present and failed to check link status.
Only tone down the "Failed to check link status" message's severity seems not
good enough.

>
>> The NVME SSD card is permited to surprise removal with slot power on
>> on the D06 board. The hotplug port's POWER_CTRL(ctrl) is false.
>
> I don't quite follow:  Does the hotplug port have a Power Controller but
> misrepresents that fact in the Slot Capabilities register?
>
Yes, SlotCap:  PwrCtrl- HotPlug+ Surprise+
The port support Hot-Plug Surprise without Power Controller Present.

>
>> Data link layer state changed (link down) event reported prior to presence
>> detect changed (card is not present) when surprise removal.
>
> It's normal that PDS and DLLSC events are received in varying order and with
> significant delays.  (I've seen 244 msec once with Thunderbolt between
> PDS- and DLLSC-.)
>
Thanks for clarifying this.
>
>> Current code pciehp_handle_presence_or_link_change() handle link down event,
>> then check the card present, but at this time presence detect state have
>> not updated, so have such issue. If surprise removal and power controller
>> present is not implemented, wait for at least 1 second before checking
>> card present to fix the issue.
>
> Thunderbolt doesn't have a Power Controller either and this change would
> imply that if Thunderbolt devices are quickly swapped, bringing up the
> replaced device would take longer than it takes now.  So I'm not really
> happy about this change.

I got your point, any suggestion to resolve the message problem ?

Thanks,
Dongdong
>
> Thanks,
>
> Lukas
>
>>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  drivers/pci/hotplug/pciehp_ctrl.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index 3f3df4c..ef8952d 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -216,6 +216,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  {
>>  	bool present, link_active;
>> +	bool safe_removal = SAFE_REMOVAL;
>>
>>  	/*
>>  	 * If the slot is on and presence or link has changed, turn it off.
>> @@ -236,6 +237,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>  				  slot_name(ctrl));
>>  		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>> +		safe_removal = SURPRISE_REMOVAL;
>>  		break;
>>  	default:
>>  		mutex_unlock(&ctrl->state_lock);
>> @@ -244,6 +246,15 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>
>>  	/* Turn the slot on if it's occupied or link is up */
>>  	mutex_lock(&ctrl->state_lock);
>> +	/*
>> +	 * if surprise removal and power controller present is not implemented,
>> +	 * wait for at least 1 second before checking card present as
>> +	 * data link layer state changed (link down) event reported
>> +	 * prior to presence detect changed (card is not present).
>> +	 */
>> +	if (!safe_removal && !POWER_CTRL(ctrl))
>> +		msleep(1000);
>> +
>>  	present = pciehp_card_present(ctrl);
>>  	link_active = pciehp_check_link_active(ctrl);
>>  	if (!present && !link_active) {
>> --
>> 1.9.1
>
> .
>

