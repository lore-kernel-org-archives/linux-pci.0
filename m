Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37079 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111Ab2KEWJS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2012 17:09:18 -0500
Received: by mail-wi0-f178.google.com with SMTP id hr7so3568777wib.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2012 14:09:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <509270D2.7060505@huawei.com>
References: <20121031095148.75dbb6e8.izumi.taku@jp.fujitsu.com> <509270D2.7060505@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Nov 2012 15:08:56 -0700
Message-ID: <CAErSpo47jaFQ78QdHYifUmXFCfRSn45DmL9yvMTiQjmS9+GgFw@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Fix regression introduced by commit 2dcfaf85
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	wangyijing@huawei.com, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 1, 2012 at 6:53 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Hi Taku,
>         It's a mistake introduced by that patch, thanks for fix it.
>         Reviewed-by: <jiang.liu@huawei.com>
>
> On 2012-10-31 8:51, Taku Izumi wrote:
>>
>> PCI/portdrv: Fix regression introduced by commit 2dcfaf85
>>
>> After commit 2dcfaf85, hotplug slots for port devices
>> w/o slot implementation come to be created.
>> This patch fixes this problem.

I applied this to my for-linus branch as v3.7 material.  Thanks!

>> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>> ---
>>  drivers/pci/pcie/portdrv_core.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Index: pci/drivers/pci/pcie/portdrv_core.c
>> ===================================================================
>> --- pci.orig/drivers/pci/pcie/portdrv_core.c
>> +++ pci/drivers/pci/pcie/portdrv_core.c
>> @@ -272,7 +272,8 @@ static int get_port_device_capability(st
>>       }
>>
>>       /* Hot-Plug Capable */
>> -     if (cap_mask & PCIE_PORT_SERVICE_HP) {
>> +     if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
>> +         dev->pcie_flags_reg & PCI_EXP_FLAGS_SLOT) {
>>               pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &reg32);
>>               if (reg32 & PCI_EXP_SLTCAP_HPC) {
>>                       services |= PCIE_PORT_SERVICE_HP;
>>
>>
>>
>
>
