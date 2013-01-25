Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:43108 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756955Ab3AYQeG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2013 11:34:06 -0500
Received: by mail-ve0-f179.google.com with SMTP id da11so277482veb.10
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2013 08:34:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51024A2F.2000005@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
 <CAErSpo6NaQK-BcoadBbVS4LTFzDdDu_JWWGpb8QAFUJ0aU3+gw@mail.gmail.com> <51024A2F.2000005@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 25 Jan 2013 09:33:44 -0700
Message-ID: <CAErSpo4UV=ZYN+KctP88hyUs3BhFxZL+Yj42r_4p+m0P=Hq8Wg@mail.gmail.com>
Subject: Re: [PATCH -v3 0/7] ARI device hotplug support
To: Yijing Wang <wangyijing@huawei.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 25, 2013 at 2:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2013/1/25 6:45, Bjorn Helgaas wrote:
> Hi Bjorn,
>    Thanks for your review and great work for this series patches!
>>
>> I applied this series on the pci/yijing-ari branch in my git tree,
>> with the following changes:
>>
>>   - Updated changelogs for readability
>>   - Reworked next_fn() and made it static
>>   - Updated the unconfigure/disable paths for cpcihp, sgihp, shpchp
>>   - Check PCI_SLOT for non-PCIe drivers in case a bus has several slots
>>   - Reset "Author:" to Yijing (since you wrote the original patches)
>>
>> Please review the changes I made and test the parts you can.  I need
>> your acknowledgement before putting these in "next" with  your
>> Signed-off-by because I changed them so much.
>
> I reviewed the changes and tested this series again in my hotplug machine.
> Most of the changes looks good to me except [PATCH 3/7] PCI: Consolidate "next-function" functions.
>
> Currently, if parameter "dev" is passed as NULL (pci_scan_single_device() return NULL), next_fn
> will return 0, so pci_scan_slot() will stop scanning rest function devices in this slot.
> According to PCI 3.0 Spec "Multi-function devices require to always implement function 0
> in the device. Implementing other functions is optional and maybe assigned in any order".
> So we will miss some function devices when scanning pci slot. I tested this patch in my machine and found it boot failed,
> because some usb devices can not found.

Oh, right.  Thanks for catching this!

> +static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
>  {
> -       u16 cap;
> -       unsigned pos, next_fn;
> +       int pos;
> +       u16 cap = 0;
> +       unsigned next_fn;
>
>         if (!dev)
>                 return 0;
>
> lspci info:
> 00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
> 00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4
> 00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5
> 00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6
> 00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2
>
> I fixed this problem with [PATCH 3/7] PCI: Consolidate "next-function" functions.
> And attach this refreshed patch at the end. This patch has been tested, and result is ok in my machine.

I replaced [3/7] with yours.

>> I think there are really two defects you're fixing here:
>>
>>   (1) If you hot-remove an ARI device and replace it with a non-ARI
>> multi-function device, we find only function 0 of the new device
>> because the upstream bridge still has ARI enabled, and next_ari_fn()
>> only returns function 0 for non-ARI devices.  Patch [1/7] fixes this.
>> I think this is the issue shown by your dmesg quotes above.
>>
>>   (2) If you hot-add an ARI device, the PCI core enumerates all the
>> functions, but pciehp only initializes functions 0-7, and other
>> functions don't work correctly.  Additionally, if you hot-remove the
>> device, pciehp only removes functions 0-7, leaving stale pci_dev
>> structures around.  Patch [4/7] fixes this.
>>
>> If my understanding is correct, I'll update the commit logs to mention
>> these scenarios explicitly.
>
> Yes, exactly.

OK, I made these tweaks and updated my pci/yijing-ari branch.

I'll merge that branch into "next" as soon as Jiang confirms that his
Signed-off-by is still valid, given that I made significant changes
since your first posting.

Bjorn
