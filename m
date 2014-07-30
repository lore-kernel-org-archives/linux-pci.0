Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65220 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966AbaG3D6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jul 2014 23:58:18 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so757223pad.35
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2014 20:58:18 -0700 (PDT)
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
From: Ethan Zhao <ethan.kernel@gmail.com>
In-Reply-To: <53D86993.8020702@huawei.com>
Date: Wed, 30 Jul 2014 11:58:08 +0800
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	"<Jordan_Hargrave@dell.com>" <Jordan_Hargrave@dell.com>,
	"<keith.busch@intel.com>" <keith.busch@intel.com>,
	"<jon.mason@intel.com>" <jon.mason@intel.com>,
	Jon Mason <jdmason@kudzu.us>
Message-Id: <76A89A35-D0BA-4E83-97BA-3FF490EF0877@gmail.com>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com> <CABawtvNAOm1VuLnN6vvwH1RtetYk-cu7VnQ6MCtJ4WVufBh2hw@mail.gmail.com> <53D86993.8020702@huawei.com>
To: Yijing Wang <wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> 在 2014年7月30日，上午11:42，Yijing Wang <wangyijing@huawei.com> 写道：
> 
>> On 2014/7/30 11:33, Ethan Zhao wrote:
>> Yijing,
>>    Seems you want to workaround platform bug in generic PCIe hotplug
>> code, while not specific to some platforms or devices, that is not
>> safe/fair to other vendor's platform.
>> and the updating to MPS of device is out of PCIe specification.
>>    So the best way is to fix within platform, at least, any platform
>> specific way in Linux code.
> 
> No, this is not a platform bug, and this is safe, you can refer to my last reply
> to Alex.
if is not a platform bug, why Didn't other platforms that can do hotplug report such issue ?
If it was safe, is it possible that you have all other vendors verify it ? 
> 
>> 
>> Thanks,
>> Ethan
>> 
>>> On Tue, Jul 29, 2014 at 4:17 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> Currently we don't update device's mps value when doing
>>> pci device hot-add. The hot-added device's mps will be set
>>> to default value (128B). But the upstream port device's mps
>>> may be larger than 128B which was set by firmware during
>>> system bootup. In this case the new added device may not
>>> work normally. This issue was found in huawei 5885 server
>>> and Dell R620 server. And if we run the platform with windows,
>>> this problem is gone. This patch try to update the hot added
>>> device mps equal to its parent mps, if device mpss < parent mps,
>>> print warning.
>>> 
>>> References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
>>> Reported-by: Keith Busch <keith.busch@intel.com>
>>> Reported-by: Jordan_Hargrave@Dell.com
>>> Reported-by: Yijing Wang <wangyijing@huawei.com>
>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> Cc: Jon Mason <jdmason@kudzu.us>
>>> ---
>>> drivers/pci/probe.c |   39 +++++++++++++++++++++++++++++++++++++++
>>> 1 files changed, 39 insertions(+), 0 deletions(-)
>>> 
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index e3cf8a2..583ca52 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1613,6 +1613,44 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>>>                dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
>>> }
>>> 
>>> +/**
>>> + * pcie_bus_update_set - update device mps when device doing hot-add
>>> + * @dev: PCI device to set
>>> + *
>>> + * After device hot add, mps will be set to default(128B), But the
>>> + * upstream port device's mps may be larger than 128B which was set
>>> + * by firmware during system bootup. Then we should update the device
>>> + * mps to equal to its parent mps, Or the device can not work normally.
>>> + */
>>> +static void pcie_bus_update_set(struct pci_dev *dev)
>>> +{
>>> +       int mps, p_mps, mpss;
>>> +       struct pci_dev *parent;
>>> +
>>> +       if (!pci_is_pcie(dev) || !dev->bus->self
>>> +                       || !dev->bus->self->is_hotplug_bridge)
>>> +               return;
>>> +
>>> +       parent = dev->bus->self;
>>> +       mps = pcie_get_mps(dev);
>>> +       p_mps = pcie_get_mps(parent);
>>> +
>>> +       if (mps >= p_mps)
>>> +               return;
>>> +
>>> +       mpss = 128 << dev->pcie_mpss;
>>> +       if (mpss < p_mps) {
>>> +               dev_warn(&dev->dev, "MPSS %d smaller than upstream MPS %d\n"
>>> +                               "If necessary, use \"pci=pcie_bus_safe\" boot parameter to avoid this problem\n",
>>> +                               mpss, p_mps);
>>> +               return;
>>> +       }
>>> +
>>> +       pcie_write_mps(dev, p_mps);
>>> +       dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n",
>>> +                       pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
>>> +}
>>> +
>>> static void pcie_bus_detect_mps(struct pci_dev *dev)
>>> {
>>>        struct pci_dev *bridge = dev->bus->self;
>>> @@ -1637,6 +1675,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>>>                return 0;
>>> 
>>>        if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>>> +               pcie_bus_update_set(dev);
>>>                pcie_bus_detect_mps(dev);
>>>                return 0;
>>>        }
>>> --
>>> 1.7.1
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> .
> 
> 
> -- 
> Thanks!
> Yijing
> 
