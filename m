Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54409 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbaCXVyf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 17:54:35 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so6064620pab.20
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2014 14:54:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAA93t1oMD3bR_zKUK5_Hw+J_LeF3GTGBfR+JA=mV=L7z9X+y1Q@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
	<CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
	<CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
	<CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
	<CAE9FiQX+hOUsLRrL8u_T7SPU4s3SKdUiXOHSwoswKZoBNqXGUw@mail.gmail.com>
	<CAE9FiQVN9R3DJWasRqNyzNK2vOpmnRZdbp0KjnPUeMtoJXoJiQ@mail.gmail.com>
	<CAA93t1oMD3bR_zKUK5_Hw+J_LeF3GTGBfR+JA=mV=L7z9X+y1Q@mail.gmail.com>
Date: Mon, 24 Mar 2014 14:54:34 -0700
Message-ID: <CAA93t1rPE3yUh8nAGJDiqeGhixznZdhdyFwRoX_c1VWT3WEtvw@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Rajat Jain <rajatxjain@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>, Guenter Roeck <groeck@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I tested this today, and it works fine. Apparently It even solves the
problem my systems were facing, thus I do not need my patch anymore!
:-)

Thanks,

Rajat

On Thu, Mar 20, 2014 at 6:30 AM, Rajat Jain <rajatxjain@gmail.com> wrote:
> Thanks, I'll test it out on my systems today.
>
> On Wed, Mar 19, 2014 at 11:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Wed, Mar 19, 2014 at 8:16 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Wed, Mar 19, 2014 at 3:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> On Wed, Mar 19, 2014 at 12:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>>
>>>> I think the current pciehp design is a bit broken.  Today we perform
>>>> commands very synchronously:
>>>>
>>>>     pcie_write_cmd() {
>>>>         write Slot Control
>>>>         if (Command Complete supported) {
>>>>             wait for Command Complete
>>>>         }
>>>>     }
>>>>
>>>> The typical driver pattern would be more asynchronous, like this:
>>>>
>>>>     pcie_write_cmd() {
>>>>         read Slot Status
>>>>         if (!Command Completed) {
>>>>             wait for Command Complete
>>>>         }
>>>>         write Slot Control
>>>>     }
>>>>
>>>> With the asynchronous pattern, we would probably never wait at all
>>>> unless we performed two commands in immediate succession.  I wouldn't
>>>> be surprised if doing this asynchronously would effectively cover up
>>>> these hardware differences.
>>>
>>> I like this idea. Will give it a try.
>>
>> It works. Please check the patch that check CC before wait/write command.
>>
>> Subject: [PATCH v2] pciehp: only wait command complete for real hotplug control
>>
>> On system with 16 PCI express hotplug slots, customer complain every slot
>> will report "Command not completed in 1000 msec" during initialization.
>>
>> Intel says that we should only wait command complete only for
>>            Electromechanical Interlock Control
>>            Power Controller Control
>>            Power Indicator Control
>>            Attention Indicator Control
>>
>> System with AMD/Nvidia chipset have same problem.
>>
>> Two ways to address the problem:
>> 1. change to only wait when (EIC, PCC, PIC, AIC) bits get changed.
>> 2. or check CMD_COMPLETE and wait before write command. Only wait
>>    when CC is set and cmd_busy is true. For chipset from intel
>>    will only have CC set for real hotplug control, so we could
>>    skip the wait for others.
>>
>> This patch is using second way.
>>
>> With that we could save 16 seconds during booting, later with 32 sockets system
>> with 64 pcie hotplug slots we could save 64 seconds.
>>
>> -v2: use second way that is suggested by Bjorn.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c |   26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
>> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -158,15 +158,8 @@ static void pcie_write_cmd(struct contro
>>      mutex_lock(&ctrl->ctrl_lock);
>>
>>      pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>> -    if (slot_status & PCI_EXP_SLTSTA_CC) {
>> -        if (!ctrl->no_cmd_complete) {
>> -            /*
>> -             * After 1 sec and CMD_COMPLETED still not set, just
>> -             * proceed forward to issue the next command according
>> -             * to spec. Just print out the error message.
>> -             */
>> -            ctrl_dbg(ctrl, "CMD_COMPLETED not clear after 1 sec\n");
>> -        } else if (!NO_CMD_CMPL(ctrl)) {
>> +    if (ctrl->no_cmd_complete && slot_status & PCI_EXP_SLTSTA_CC) {
>> +        if (!NO_CMD_CMPL(ctrl)) {
>>              /*
>>               * This controller seems to notify of command completed
>>               * event even though it supports none of power
>> @@ -182,16 +175,11 @@ static void pcie_write_cmd(struct contro
>>      }
>>
>>      pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
>> -    slot_ctrl &= ~mask;
>> -    slot_ctrl |= (cmd & mask);
>> -    ctrl->cmd_busy = 1;
>> -    smp_mb();
>> -    pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>> -
>>      /*
>>       * Wait for command completion.
>>       */
>> -    if (!ctrl->no_cmd_complete) {
>> +    if (!ctrl->no_cmd_complete && (slot_status & PCI_EXP_SLTSTA_CC) &&
>> +        ctrl->cmd_busy) {
>>          int poll = 0;
>>          /*
>>           * if hotplug interrupt is not enabled or command
>> @@ -203,6 +191,12 @@ static void pcie_write_cmd(struct contro
>>              poll = 1;
>>                  pcie_wait_cmd(ctrl, poll);
>>      }
>> +
>> +    slot_ctrl &= ~mask;
>> +    slot_ctrl |= (cmd & mask);
>> +    ctrl->cmd_busy = 1;
>> +    smp_mb();
>> +    pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>>      mutex_unlock(&ctrl->ctrl_lock);
>>  }
