Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:32940 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934489AbcDMJI5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 05:08:57 -0400
MIME-Version: 1.0
In-Reply-To: <20160413083352.GI1714@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160412175203.GB13637@wunner.de> <20160413083352.GI1714@lahna.fi.intel.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Wed, 13 Apr 2016 11:08:37 +0200
Message-ID: <CAMxnaaVEPYfU15OGwygsT_RHvqBFPU4NHFRNKK4Eng-TJixFkg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 13, 2016 at 10:33 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Apr 12, 2016 at 07:52:03PM +0200, Lukas Wunner wrote:
>> Hi Mika,
>>
>> I'm working on runtime pm for Thunderbolt on the Mac and your patches
>> directly impact that. A Thunderbolt controller comprises an upstream
>> bridge plus multiple downstream bridges below it, the latter are the
>> actual hotplug ports. I'm using my own runtime pm code for the PCIe
>> ports at the moment but will rebase on your patches once they're
>> finalised.
>>
>> I've just pushed v2 of my patches to GitHub, this is nearly finished,
>> just needs some more polish before I can post it:
>> https://github.com/l1k/linux/commits/thunderbolt_runpm_v2
>
> Interesting :)
>
>> First of all, the root port on my 2012 Ivy Bridge machine suspends to
>> D3hot just fine, as do the upstream and downstream ports on the 2010
>> "Light Ridge" Thunderbolt controller. So the 2015 cut-off in patch [2/4]
>> seems extremely conservative to me, perhaps unnecessarily so. At least
>> you've made it possible to override that by setting bridge_d3 = true,
>> however I'd be happier if this could be extended further back, say,
>> to 2010. That way it would encompass all Macs with Thunderbolt.
>
> What about other non-Mac machines? Can we be sure that the same thing
> works there?
>
> I have no problem lowering the cut-off date but it should not start
> breaking things. I think Windows is doing something similar but I'm not
> sure what their cut-off date is.
>
>> Secondly, you're disabling runtime pm on hotplug ports, citing a
>> bugzilla entry as an example why this is necessary, however there's
>> a patch attached to that bugzilla entry which fixes the issue:
>> https://bugzilla.kernel.org/show_bug.cgi?id=53811
>>
>> It is therefore unclear why you're disabling it. This breaks my
>> patches and you've not provided a way to selectively re-enable
>> runtime pm for specific hotplug ports.
>
> If I understand correctly, it actually does not fix anything. By luck it
> works intermittently.
>
> I've been testing on Alpine Ridge (which is the latest and greatest TBT3
> host controller) and I'm still seeing the issue ->
>
>> FWIW I've had zero issues suspending the hotplug ports on the Light
>> Ridge Thunderbolt controller. Hotplug detection works fine even in
>> D3hot, all that is necessary is to resume the port on hotplug and
>> unplug while we access the hotplugged device's config space.
>>
>> So it looks like a hotplug port should be *allowed* to suspend,
>> but its parent ports (by default) should *not* as we wouldn't be
>> able to access the hotplug port's config space anymore. On the Mac
>> even the parent ports may suspend because there's a separate GPE
>> provided which fires on hotplug during D3cold. Just disabling
>> runtime pm *generally* on all hotplug ports is too strict.
>
> <- Now, my understanding is that Macs do not use ACPI hotplug but
> instead this is all native, correct? When you have the controller
> exposed all the time, of course you can get hotplug events and handle
> them in the driver.
>
> However, problem arises when enumeration and configuration is actually
> done in BIOS SMI handler, like in normal non-Mac PCs. If the port is in
> D3 the handler is not smart enough to move it back to D0 and then
> re-enumerate ports. It just gives up.
Is this issue specific to the "ACPI/SMI Thunderbolt" implementations
used in non-Mac PCs or is PCI hotplug in general done through SMI/ACPI
instead of the native pciehp port driver? Wouldn't it make more sense
to only disable runtime suspend on non-Mac thunderbolt ports (or ports
using ACPI hotplug, if that is detectable).

Andreas

> That is the reason we do not runtime suspend those ports.
>
> We can allow runtime suspending PCIe ports that use PCIe native hotplug
> but I do not have such hardware here so I'm unable to test that but
> since you have, maybe we can co-operate on this :)
>
>> The changes required for pciehp to work with runtime suspended ports
>> are apparent from the following patch, I can spin them out into a
>> separate commit if you would like to include them in your series:
>> https://github.com/l1k/linux/commit/97d1140926670e6498f6671d91201e6d66e78680
>>
>>
>> > +static int pcie_port_runtime_idle(struct device *dev)
>> > +{
>> > +   struct pci_dev *pdev = to_pci_dev(dev);
>> > +
>> > +   /*
>> > +    * Rely the PCI core has set bridge_d3 whenever it thinks the port
>> > +    * should be good to go to D3. Everything else, including moving
>> > +    * the port to D3, is handled by the PCI core.
>> > +    */
>> > +   if (pdev->bridge_d3) {
>> > +           pm_schedule_suspend(dev, 10);
>> > +           return 0;
>> > +   }
>> > +   return -EBUSY;
>> > +}
>>
>> It's unclear why the pm_schedule_suspend() is needed here and what the
>> 10 ms delay is for. I don't have that delay in my runtime pm code and
>> haven't seen any issues. If the delay is needed then I'm wondering why
>> this isn't implemented using autosuspend?
>
> This part is from the original runtime PM patch. I did not want to
> change 10ms delay here. Not sure if it is needed.
>
> However, we need to have pcie_port_runtime_idle() callback because here we
> actually check if we are allowed to suspend the port. Using autosuspend
> does not work because of that. Documentation/power/runtime_pm.txt says
> this regarding ->runtime_idle() callback:
>
>   The action performed by the idle callback is totally dependent on the
>   subsystem (or driver) in question, but the expected and recommended
>   action is to check if the device can be suspended (i.e. if all of the
>   conditions necessary for suspending the device are satisfied) and to
>   queue up a suspend request for the device in that case.
>
> So delay probably is not necessary but we need the callback to check if
> the port can be suspended.
>
>> > +static bool pcie_port_runtime_pm_possible(struct pci_dev *pdev)
>> > +{
>> > +   /*
>> > +    * Only enable runtime PM if the PCI core agrees that this port can
>> > +    * even go to D3.
>> > +    */
>> > +   if (!pdev->bridge_d3)
>> > +           return false;
>> > +
>> > +   /*
>> > +    * Prevent runtime PM if the port is hotplug capable. Otherwise the
>> > +    * hotplug SMI code might not be able to enumerate devices behind
>> > +    * this port properly (the port is powered down preventing all
>> > +    * config space accesses to the subordinate devices).
>> > +    */
>> > +   if (pcie_caps_reg(pdev) & PCI_EXP_FLAGS_SLOT) {
>> > +           u32 sltcap;
>> > +
>> > +           pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &sltcap);
>> > +           if (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_HPS))
>> > +                   return false;
>> > +   }
>> > +
>> > +   return true;
>> > +}
>>
>> Why do you re-read the register here, seems like just checking
>> pdev->hotplug_bridge should be sufficient?
>
> Indeed. Although it does not check for surprise hotplug I think we can
> use that field instead.
>
>> >  static void pcie_portdrv_remove(struct pci_dev *dev)
>> >  {
>> > +   const struct pcie_port_data *pdata = pci_get_drvdata(dev);
>> > +
>> > +   if (pdata->runtime_pm_enabled) {
>> > +           pm_runtime_forbid(&dev->dev);
>> > +           pm_runtime_get_noresume(&dev->dev);
>> > +   }
>> > +
>> >     pcie_port_device_remove(dev);
>> >  }
>>
>> I think you're missing a pci_set_drvdata(dev, NULL) here.
>
> Device core does that automatically.
>
>> In my runtime pm code I've set pm_runtime_no_callbacks() for the port
>> service devices to prevent users from mucking around with their sysfs
>> files. Feel free to copy that from the above-linked patch if you want.
>
> OK, I'll check those.
>
> Thanks!
