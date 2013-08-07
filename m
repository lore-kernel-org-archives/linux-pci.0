Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:2616 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab3HGBxG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 21:53:06 -0400
Message-ID: <5201A877.2080303@huawei.com>
Date: Wed, 7 Aug 2013 09:52:55 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH -v3] PCI: update device mps when doing pci hotplug
References: <1375776540-23988-1-git-send-email-wangyijing@huawei.com> <CAPoiz9wAufM8HV_Drdxg50zs5=1AduBUN5oXNRBHYqjwMCOTaQ@mail.gmail.com>
In-Reply-To: <CAPoiz9wAufM8HV_Drdxg50zs5=1AduBUN5oXNRBHYqjwMCOTaQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +static int pcie_bus_update_set(struct pci_dev *dev, void *data)
>> +{
>> +       int mps, p_mps;
>> +
>> +       if (!pci_is_pcie(dev) || !dev->bus->self)
>> +               return 0;
>> +
>> +       mps = pcie_get_mps(dev);
>> +       p_mps = pcie_get_mps(dev->bus->self);
>> +
>> +       if (mps < p_mps)
>> +               goto update;

Hi Jon,
   Thanks for your review and comments!

> 
> It would be more clear to have it return 0 if mps >= p_mps, and not
> have the goto statement.

OK, will update.


> 
>> +
>> +       return 0;
>> +
>> +update:
>> +       /* If current mpss is lager than upstream, use upstream mps to update
>> +        * current mps, otherwise print warning info.
>> +        */
>> +       if ((128 << dev->pcie_mpss) >= p_mps)
>> +               pcie_write_mps(dev, p_mps);
>> +       else
>> +               dev_warn(&dev->dev, "MPS %d MPSS %d both smaller than upstream MPS %d\n"
>> +                               "If necessary, use \"pci=pcie_bus_peer2peer\" boot parameter to avoid this problem\n",
>> +                               mps, 128 << dev->pcie_mpss, p_mps);
>> +       return 0;
>> +}
>> +
>> +static void pcie_bus_update_setting(struct pci_bus *bus)
>> +{
>> +       if (bus->self->is_hotplug_bridge)
>> +               pci_walk_bus(bus, pcie_bus_update_set, NULL);
> 
> Why not just call pcie_bus_configure_set(bus->self, &smpss); with smpss of 0?

Because for safety, I won't touch the running pcie device(RP, UP/DP,EP) mps.
Consider the following case:
Root Port------>Upstream Port------>Downstream Port 1 ---->Endpoint device A (newly inserted device)
mps=256          256               |    256			128
                                   |Downstream Port 2 ---->Endpoint device B
					256			256

This patch try to update device A's mps equal to its parent DP 1 mps (256).
Because EP A device is not running, newly inserted, not configure yet. So configure its mps
to 256B is safe.

But if we try to configure DP 1 mps to 128B, it's not safe. its parent Upstream port still is 256.

> 
>> +}
>> +
>>  /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
>>   * parents then children fashion.  If this changes, then this code will not
>>   * work as designed.
>> @@ -1614,6 +1648,15 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>>         if (!pci_is_pcie(bus->self))
>>                 return;
>>
>> +       /* Sometimes we should update device mps here,
>> +        * eg. after hot add, device mps value will be
>> +        * set to default(128B), but the upstream port
>> +        * mps value may be larger than 128B, if we do
>> +        * not update the device mps, it maybe can not
>> +        * work normally.
> 
> This is slightly confusing to me.  It would be more clear to say:
> There are situations (i.e., hot add) where the upstream port might
> have a larger MPS than the device.  In these situations, the port MPS
> needs to be reconfigured to the lower value or the device will not
> operate properly.

Sorry for my poor English, I mean the device  is the newly hot added device, not
the port device. So we will only reconfigure the newly hot added device mps.

> 
>> +        */
>> +       pcie_bus_update_setting(bus);
> 
> This only seems to be necessary in the "TUNE_OFF" case.  It would be
> best to move it under that, just 2 lines down.

Good idea, will update, thanks!


Thanks!
Yijing.
> 
>> +
>>         if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> 
> Perhaps it is time to make "SAFE" the default option, per the
> discussion at last years PCI mini-summit.
> Bjorn, thoughts?
> 
> 
> Thanks,
> Jon
> 
>>                 return;
>>
>> --
>> 1.7.1
>>
>>
> 
> .
> 


-- 
Thanks!
Yijing

