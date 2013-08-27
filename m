Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:45438 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3H0BuS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 21:50:18 -0400
Message-ID: <521C058E.3070008@huawei.com>
Date: Tue, 27 Aug 2013 09:49:02 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jin Feng <joe.jin@oracle.com>
Subject: Re: [PATCH v8 6/6] PCI: update device mps when doing pci hotplug
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com> <1377141888-7000-7-git-send-email-wangyijing@huawei.com> <20130822181823.GA25721@google.com> <521ACE99.9000505@huawei.com> <CAErSpo70BYoJ4f9WD+vkYER6zZeJNO+Ar5cetRte6YYA24RYOw@mail.gmail.com>
In-Reply-To: <CAErSpo70BYoJ4f9WD+vkYER6zZeJNO+Ar5cetRte6YYA24RYOw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/8/27 5:33, Bjorn Helgaas wrote:
> On Sun, Aug 25, 2013 at 9:42 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> I think the strategy of updating the device MPS when possible makes
>>> sense, but I don't think we should do it in PCIE_BUS_TUNE_OFF mode.
>>> That mode is documented as "Disable PCIe MPS tuning and use the
>>> BIOS-configured MPS defaults."  This patch changes that to something
>>> like "Disable PCIe MPS tuning, except for hot-added devices" and there
>>> is no longer a way to tell Linux to never touch MPS.
>>
>> Hi Bjorn,
>>    Thanks for your review and comments!
>>
>> As you mentioned, PCIE_BUS_TUNE_OFF means "Disable PCIe MPS tuning and use the
>> BIOS-configured MPS defaults.", But hotplug action make the BIOS default mps setting
>> changed(power off, all registers reset). So If we only touch the newly inserted device mps,
>> I think maybe it's reasonable.
> 
> I agree, it might be reasonable.  But I think it's too hard to
> document that behavior.  I think it's better to have behavior that is
> easy to understand and explain, even if it is slightly suboptimal.
> 
> The current Linux default is PCIE_BUS_TUNE_OFF, and given that I don't
> want to touch any MPS settings in that mode, I don't see a way to
> safely fix https://bugzilla.kernel.org/show_bug.cgi?id=60671 (the
> problem with hot-added devices not working because MPS is incorrect).
> In the long term, I hope we can fix it by making the default
> PCIE_BUS_SAFE, but that doesn't help right now.

I also think we should consider to change default mode to pcie_bus_safe.
Jon mentioned that there are number of issues discovered on some x86 chipsets.
However, no further details.
But if we use PCIE_BUS_TUNE_OFF all the time, we never have chance to fix these issues.

> 
> That leaves us with only the workaround of booting the Huawei rh5885
> box with "pci=pcie_bus_safe".
> 
> I'm willing to accept that because I think we can argue that this is
> really a BIOS defect.  The BIOS *can* program MPS to values that will
> be safe for hotplug even if the OS does nothing, i.e., it can set
> MPS=128 in all paths that lead to a hotpluggable slot.  I think that's
> probably what this BIOS *should* do, since it has no way of knowing
> whether the OS will support hotplug or whether the OS will reprogram
> any MPS values.
> 

Yes, we temporarily make BIOS program all MPS to 128 to avoid this problem now.

Thanks!
Yijing.



