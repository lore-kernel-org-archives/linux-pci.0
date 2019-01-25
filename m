Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB16C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B8E20881
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 14:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfAYO2O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:28:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfAYO2O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 09:28:14 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4263CDAECA18B12F402;
        Fri, 25 Jan 2019 22:28:09 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 22:28:02 +0800
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@kernel.org>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
CC:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
Date:   Fri, 25 Jan 2019 22:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190124213701.GA9882@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith, Sinan

Many thanks for your review.
在 2019/1/25 5:37, Keith Busch 写道:
> On Thu, Jan 24, 2019 at 10:18:26AM -0800, Sinan Kaya wrote:
>> On 1/24/2019 8:50 AM, Dongdong Liu wrote:
>>> The patch [1] PCI/ERR: Run error recovery callbacks for all affected
>>> devices have broken the non-fatal error handling logic in patch [2].
>>> For non-fatal error, link is reliable, so no need to reset link,
>>> handle non-fatal error for all subordinates seems incorrect.
>>> Restore the non-fatal errors process logic.
>>>
>>> [1] PCI/ERR: Run error recovery callbacks for all affected devices   #4.20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfcb79fca19d267712e425af1dd48812c40dec0c
>>>
>>> [2] PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=86acc790717fb60fb51ea3095084e331d8711c74
>>>
>>> Fixes: bfcb79fca19d ("PCI/ERR: Run error recovery callbacks for all affected devices")
>>> Reported-by: Xiaofei Tan<tanxiaofei@huawei.com>
>>> Signed-off-by: Dongdong Liu<liudongdong3@huawei.com>
>>> Cc: Keith Busch<keith.busch@intel.com>
>>> Cc: Bjorn Helgaas<bhelgaas@google.com>
>>
>>
>> According to what I see in the code, link will be reset only if the AER
>> severity is AER_FATAL.
>>
>> 	} else if (info->severity == AER_NONFATAL)
>> 		pcie_do_recovery(dev, pci_channel_io_normal,
>> 				 PCIE_PORT_SERVICE_AER);
>> 	else if (info->severity == AER_FATAL)
>> 		pcie_do_recovery(dev, pci_channel_io_frozen,
>> 				 PCIE_PORT_SERVICE_AER);
>>
>> Can you show the path where it leads to link reset and severity is AER_NONFATAL?
>
> Yes, I don't follow what this patch is saying either, and it actually
> looks quite broken: it assigns 'bridge' to 'dev', which may not even be a
> bridge, and then dereferences 'bridge->subordinate' which be NULL.
>

I want to fix 2 points by the patch.

1. For EP devices (such as multi-function EP device) under the same bus,
when one of the EP devices met non-fatal error, should report non-fatal
error only to the error endpoint device, no need to broadcast all of them.
That is the patch (PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15)
have done, but current code PATCH [1] broken this.

2. We found a NULL pointer dereference issue for 74:02.0 device
when the device met a non-fatal error (firmware-first) after 4.19.
The topology is as below.

   +-[0000:74]-+-02.0  Huawei Technologies Co., Ltd. HiSilicon SAS 3.0 HBA
   |           \-03.0  Huawei Technologies Co., Ltd. HiSilicon AHCI HBA

The callstack is as below
[ 1564.489537] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[ 1564.588821] random: crng init done
[ 1564.643295] Mem abort info:
[ 1564.789341] ESR = 0x96000004
[ 1564.798182] Exception class = DABT (current EL), IL = 32 bits
[ 1564.812802] SET = 0, FnV = 0
[ 1564.821677] EA = 0, S1PTW = 0
[ 1564.830729] Data abort info:
[ 1564.839257] ISV = 0, ISS = 0x00000004
[ 1564.848744] CM = 0, WnR = 0
[ 1564.854670] [0000000000000018] user address but active_mm is swapper
[ 1564.867392] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 1564.878540] Modules linked in:
[ 1564.886637] CPU: 0 PID: 13 Comm: kworker/0:1 Tainted: G W 5.0.0-rc1-28680-g7558ecf-dirty #753
[ 1564.906319] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - V1.10.01 12/29/2018
[ 1564.923217] Workqueue: events aer_recover_work_func
[ 1564.932973] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[ 1564.942555] pc : pcie_do_recovery+0x58/0x244
[ 1564.951091] lr : aer_recover_work_func+0xd4/0x108
[ 1564.960497] sp : ffff000011e23d00
[ 1564.967117] x29: ffff000011e23d00 x28: ffff000011d9bcd8
[ 1564.977742] x27: ffff802fbb9df438 x26: ffff802fb74030cc
[ 1564.988368] x25: 0000000000000000 x24: 0000000000000074
[ 1564.998994] x23: 0000000000000002 x22: ffff000011e23d54
[ 1565.009620] x21: ffff0000114a6090 x20: ffff0000117e5000
[ 1565.020245] x19: 0000000000000000 x18: 000000000000000e
[ 1565.030870] x17: 0000000000000001 x16: 0000000000000000
[ 1565.041496] x15: 0000000000000000 x14: 3d746e6567615f72
[ 1565.052122] x13: 6561202c72657961 x12: 674238a07d44a100
[ 1565.062747] x11: ffffffffffffffff x10: 0000000000000006
[ 1565.073373] x9 : 0000000000000810 x8 : ffff0000117e5b48
[ 1565.083999] x7 : 636e755f72656120 x6 : ffff00001067a680
[ 1565.094624] x5 : 0000000000000000 x4 : 0000000000000000
[ 1565.105249] x3 : 674238a07d44a100 x2 : 0000000000000002
[ 1565.115875] x1 : 0000000000000001 x0 : ffff8a2fbb860000
[ 1565.126501] Process kworker/0:1 (pid: 13, stack limit = 0x00000000d6c8d0e9)
[ 1565.140435] Call trace:
[ 1565.145315] pcie_do_recovery+0x58/0x244
[ 1565.153154] aer_recover_work_func+0xd4/0x108
[ 1565.161866] process_one_work+0x14c/0x3ec
[ 1565.169880] worker_thread+0x130/0x3e4
[ 1565.177371] kthread+0x100/0x12c
[ 1565.183817] ret_from_fork+0x10/0x18
[ 1565.190960] Code: f9400a60 f9401c13 7100083f 910153b6 (f9400e75)
[ 1565.203154] ---[ end trace 980b44e0229f8807 ]---

Thanks,
Dongdong
> .
>

