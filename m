Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Rajat Jain <rajatxjain@gmail.com>,
	Guenter Roeck <groeck@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH v2 2/4] pciehp: Use link change notifications for
 hot-plug and removal
Date: Sun, 15 Dec 2013 22:23:45 +0000
Message-ID: <50d381066c864b5c93e88eda308084e4@DM2PR05MB671.namprd05.prod.outlook.com>
References: <529E5C0E.80903@gmail.com> <20131212224407.GL4699@google.com>
 <CAE9FiQX8XXkwbhhuNhCF-pHdc_3or_dMEH-VN5NBSEV_eXE-Pg@mail.gmail.com>
 <CAErSpo5BsaLNrny3T1sYknz3wo4hN0SKJk0_u6eNyEd6qq5o=g@mail.gmail.com>
 <428d664592c2466c9e5e6b393df9d690@DM2PR05MB671.namprd05.prod.outlook.com>
 <CAErSpo5NjOCqkao03Ea=98gunVEaUUitq8mGLarpKW_DQoDF8g@mail.gmail.com>
In-Reply-To: <CAErSpo5NjOCqkao03Ea=98gunVEaUUitq8mGLarpKW_DQoDF8g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> 
> On Fri, Dec 13, 2013 at 12:04 PM, Rajat Jain <rajatjain@juniper.net>
> wrote:
> >> On Thu, Dec 12, 2013 at 11:26 PM, Yinghai Lu <yinghai@kernel.org>
> wrote:
> >> > On Thu, Dec 12, 2013 at 2:44 PM, Bjorn Helgaas
> >> > <bhelgaas@google.com>
> 
> > Also, I think the device removal should _always_ be initiated (if not
> done already) whenever the Link goes down for any reason (irrespective
> of whether the attention button is implemented or not, or whether the
> surprise events are supported or not). I think this is logical as it
> makes no sense for the software to think the device is accessible when
> in reality it is not. In fact I think we should also remove the checks
> in pciehp_disable_slot() that ensure that the adapter should be
> populated and latch should be closed.
> 
> I agree.
> 
> >> What does the "other OS" do about this repeater?  Did you verify that
> >> it disables the link when powering off the slot?  If we were smarter
> >> about presence detect, I wonder if that would be enough.
> >>
> >> > Also we can get rid of annoying aer during power off slot.
> >>
> >> I don't know the details of this issue.  It may be possible to avoid
> >> the AER in some way other than turning off the link.
> >
> > Sorry, I could not understand what we are talking about here. I'd
> appreciate if you could elaborate if you see this as a problem related
> to the patch?
> 
> I assume Yinghai means that when we power off the slot, if AER is still
> enabled, it may report errors caused by the link going down.
> PCIe r3.0 sec. 3.2.1 says some of these cases must not be considered
> errors if the link is disabled, the port is associated with a hot-
> pluggable slot, etc.  Maybe his platform doesn't follow those rules, or
> maybe there's some other AER error that's not covered by them.
> 
> It's related to your patch because you are removing the link disable,
> and Yinghai says that if we leave the link enabled, he gets unwanted AER
> errors when powering off the slot.  Sorry if this was all obvious to
> you.  I don't know any more details.  It'd be nice to know the exact AER
> errors and the PCIe capability info.  Then we might be able to figure
> out a way to leave the link enabled while still suppressing the AER
> errors.

Thanks for the explanation. I understand now.

Yinghai: would you be able to give any details on what AER errors were seen, and a dump of all of the capabilities? 

> 
> > Once again: the way I interpret this is:
> > * Always enable Link events.
> > * Disable presence events if attention button is present.
> 
> That sounds like a good plan to me.


Of course, this'll be done only if the link state change notification capability is present, otherwise I'll leave it to the current default state :-) 

Just FYI: Today, I once again used a truth table to convince myself that all possible combinations of (attention button support, surprise event support, power controller support) will work fine and if there is going to be a difference in behavior before and after this change. It looks the user experience is going to be exactly the same except for the following 2 which also seem to be fine: 

a) If a port has none of them: Attention button, Surprise event support, power controller. Then the current behavior is that it can only be added by doing "echo 1 > /sys/...../power". After this change, no need to do this. The device will be automatically added as soon as the link comes up (which would come up as soon as it is plugged in, since there is no power controller).

b) If a port has all of them: Attention button, Surprise event support, power controller. Then the current behavior is that it shall be enabled as soon as it is plugged in. But with this change the user has to push the attention button to enable it. Which may be fine, because we just seem to have said that the attention button presence indicates that it takes priority over everything (including the surprise bit).

> 
> I'm also dubious about this use of presence detect:
> 
>     pciehp_power_thread
>       pciehp_enable_slot
>         pciehp_get_adapter_status
>           pciehp_readw(ctrl, PCI_EXP_SLTSTA, &slot_status)
>           *status = !!(slot_status & PCI_EXP_SLTSTA_PDS)
>         board_added
>           pciehp_power_on_slot
> 
> because we apparently look at PCI_EXP_SLTSTA_PDS when the slot is
> powered off.  Only in-band presence detection is required by spec, and
> in-band detection only works when power is applied.  So I think this
> pciehp_get_adapter_status() call should probably just be removed.

Hummm, right, understood. However, then I think we also need cobbling in pciehp_probe(), pciehp_resume() because there also I see the same problem:

        /* Check if slot is occupied */
        slot = ctrl->slot;
        pciehp_get_adapter_status(slot, &occupied);
        pciehp_get_power_status(slot, &poweron);
        if (occupied && pciehp_force) {
                mutex_lock(&slot->hotplug_lock);
                pciehp_enable_slot(slot);
                mutex_unlock(&slot->hotplug_lock);
        }

I think 1 way to overcome this may be to always turn the power on to the slot (if not powered on) in pciehp_get_adapter_status()?

In fact going by the logic of the spec, I'd think we should actually NEVER turn off the power to the slot, since present detect depends on it? And if power is Off, in-band presence detection will fail (needed for surprise hotplug). 

Nevertheless, I think this needs a separate discussion thread (did not want to tie it to this patch) since the changes shall be more, and not directly related to this link state change?

Thanks,

Rajat

> 
> Bjorn
> 


