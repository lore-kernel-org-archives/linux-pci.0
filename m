Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:29615 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3DPI4a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2013 04:56:30 -0400
Message-ID: <516D120E.3030907@huawei.com>
Date: Tue, 16 Apr 2013 16:55:42 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: huang ying <huang.ying.caritas@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 1/2] PCI: decrease pci_dev->enable_cnt when no pcie
 capability found
References: <1366009135-19088-1-git-send-email-wangyijing@huawei.com> <CAErSpo7dgFR8a7Wee4CE7Rj+nZg_-+8uNOFq__d8EzY+gHQHGQ@mail.gmail.com> <CAC=cRTOPg+Db8AkA6sWMe9ggESY=vO7W1zWzr5E-JWLxoxg=7Q@mail.gmail.com>
In-Reply-To: <CAC=cRTOPg+Db8AkA6sWMe9ggESY=vO7W1zWzr5E-JWLxoxg=7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/4/16 16:22, huang ying wrote:
> On Mon, Apr 15, 2013 at 11:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Rafael, Huang]
>>
>> On Mon, Apr 15, 2013 at 12:58 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> We should decrease dev->enable_cnt when no pcie port capability
>>> found for balance.
>>>
>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> Cc: Jiang Liu <jiang.liu@huawei.com>
>>> Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>>> Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>>> ---
>>>  drivers/pci/pcie/portdrv_core.c |    4 ++--
>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>>> index 31063ac..aef3fac 100644
>>> --- a/drivers/pci/pcie/portdrv_core.c
>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>> @@ -369,8 +369,8 @@ int pcie_port_device_register(struct pci_dev *dev)
>>>
>>>         /* Get and check PCI Express port services */
>>>         capabilities = get_port_device_capability(dev);
>>> -       if (!capabilities)
>>> -               return 0;
>>> +       if (!capabilities)
>>> +               goto error_disable;
>>>
>>>         pci_set_master(dev);
>>>         /*
>>
>> Does this fix a problem you observed?  If so, please refer to it in
>> your changelog.
>>
>> I think this patch is incorrect because pcie_portdrv_probe() will
>> return 0 (success) with the device disabled.  When we call
>> pcie_portdrv_remove(), we will attempt to disable the device again,
>> even though it's already disabled.
>>
>> I don't know whether it is desirable for pcie_portdrv_probe() to
>> succeed when no capabilities are available or not.  Maybe somebody
>> else has an opinion.
> 
> I think this patchset is incorrect too.  Even if there is no PCIe
> services for the PCIe port.  We still need the PCIe drivers, at least
> for runtime power management.  Although runtime power management is
> disabled for the PCIe port now, I think we will enable it again after
> we fixed the corresponding issues.

Hi Huang Ying,
   Thanks for your comments! I will drop this patch, because as you said pcie port
device need pcie port driver regardless any pcie capabilities found.

But there is still a problem about two pci_disable_device() called in pcie_portdrv_remove().
In this case, If we unbind pcie port driver, the pcie port device will be disabled. The child devices
under it cannot use anymore. I send this patch in another reply.

Thanks!
Yijing

> 
> Best Regards,
> Huang Ying
> 
> .
> 


-- 
Thanks!
Yijing

