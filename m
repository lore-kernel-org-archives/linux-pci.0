Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:64580 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3G0Oa6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jul 2013 10:30:58 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so6481879obq.35
        for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2013 07:30:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7C2jG+MwLd-1JhrGbn0WJWpMKrAvG22mK0-M4k5QH94w@mail.gmail.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<1374261258-23036-2-git-send-email-yinghai@kernel.org>
	<CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
	<CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com>
	<20130723155645.GA18422@google.com>
	<CAE9FiQUQirapRONeb1ndOoKsiYviyXJVx3wZTcgzJj7bHX-1xQ@mail.gmail.com>
	<51EF516F.6010102@huawei.com>
	<CAErSpo7C2jG+MwLd-1JhrGbn0WJWpMKrAvG22mK0-M4k5QH94w@mail.gmail.com>
Date: Sat, 27 Jul 2013 07:30:57 -0700
Message-ID: <CAE9FiQVNxtUUjAPmjR-6ycA5zevXaPT2=Ok6z1Jb5Gqsynf0hQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 26, 2013 at 3:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jul 23, 2013 at 10:00 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Hi Yinghai,
>>    The third patch make pci_stop_dev call pci_disable_sriov(dev).
>> It looks asymmetrical, because pci_enable_sriov(dev, NR_VIRTFN) always
>> be called by device driver. Why not work around this in device driver like ixgbe?
>> I'm not familiar with SRIOV, so I'm just a bit puzzled.
>>
>> Thanks!
>> Yijing.
>>
>> ------------------------------------------------------------
>> Some driver (like ixgbe) does not call pci_disable_sriov() if
>> sriov is enabled via /sys/.../sriov_numvfs setting.
>> ixgbe does allow driver for PF get detached, but still have VFs
>> around.
>>
>> But how about PF get removed via /sys or pciehp finally?
>>
>> During hot-remove, VF will still hold one ref to PF and it
>> prevent PF to be removed.
>> That make the next hot-add fails, as old PF dev struct is still around.
>>
>> We need to add pci_disable_sriov() calling during stop PF .
>>
>> Need this one for v3.11
>>
>> -v2: Accoring to Bjorn, move that calling to pci_stop_dev.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Jiang Liu <liuj97@gmail.com>
>> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
>> Cc: Donald Dutile <ddutile@redhat.com>
>> Cc: Greg Rose <gregory.v.rose@intel.com>
>>
>> ---
>>  drivers/pci/remove.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> Index: linux-2.6/drivers/pci/remove.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/remove.c
>> +++ linux-2.6/drivers/pci/remove.c
>> @@ -25,6 +25,8 @@ static void pci_stop_dev(struct pci_dev
>>                 pci_proc_detach_device(dev);
>>                 pci_remove_sysfs_dev_files(dev);
>>                 device_del(&dev->dev);
>> +               /* remove VF, if PF driver skip that */
>> +               pci_disable_sriov(dev);
>>                 dev->is_added = 0;
>>         }
>
> Can you post these as a new thread with -v2 patches?

ok, will repost them on top of pci/for-linus

>
> Why did you put pci_disable_sriov() inside the "if (dev->is_added)"
> block?  Is it related to is_added?

yes, only have pci_enable_sriov when is_added is true.
driver is detached when device_del() is called, and at that time
pci_disable_sriov should be just called.

Thanks

Yinghai
