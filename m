Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160424152308.GA16898@wunner.de>
References: <cover.1458126755.git.lukas@wunner.de> <4560ddb26a2bb15eeaf8eab565ac41c35e36d092.1458126755.git.lukas@wunner.de>
 <CAMxnaaXLAEERtc7=odiqXAp_pA-PnsaQFw6bQhLN=DWeBngq9g@mail.gmail.com> <20160424152308.GA16898@wunner.de>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Sun, 1 May 2016 13:18:46 +0200
Message-ID: <CAMxnaaVT0L-7L2TURARX-oD5GNooOkzqA3T88Oz_WzegraRh4Q@mail.gmail.com>
Subject: Re: [RFC 4/4] thunderbolt: Support runtime pm
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-acpi@vger.kernel.org,
	Linux PM list <linux-pm@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 24, 2016 at 5:23 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Andreas,
>
> thank you for your valuable feedback.
>
> On Sun, Mar 20, 2016 at 02:53:10PM +0100, Andreas Noever wrote:
>> - My firmware does not provide the TRPE ACPI method, only XRPE. So
>> either TRPE is only post CactusRidge or it is only present in newer
>> MBPs. In any case the OS X driver looks for TRPE first and uses XRPE
>> only if TRPE does not exists. I suggest we do the same (but see below
>> for TRPE).
>
> I only had the acpidump of an MBA6 (2013) available when I implemented
> this and it uses TRPE. I have since been able to obtain the acpidump of
> an MBP10 (2012) and you're right, it uses XRPE. Both have the same
> controller, Cactus Ridge 4C. It looks like they changed this on machines
> introduced 2013. It's just a rename of the method, there are no machines
> which have both methods.
>
>
>> - The XRIN GPE fired immediately after the power was cut. The problem
>> seems to be that the controller takes a bit to shut down. The solution
>> is to poll until XRIL returns 1 before activating the GPE. On "Type 2"
>> devices the OS X driver polls up to 300 times with a 1ms sleep in
>> between (for me 1 or 2 iterations were always enough). Afaik no
>> polling is done on "Type 1" devices.
>
> Hm, this means that the semantics of XRIN and XRIL changed on Cactus
> Ridge. I have changed the behaviour to be exactly as you've specified
> above, this works fine on Light Ridge and should hopefully also work
> on Cactus Ridge, no distinction between Type 1 and Type 2 necessary.

ok

>
>> Also the OS X interrupt handler checks XRIL
>> and only wakes up the device if it returns 0. This was not necessary
>> to do on my model - but maybe spurious interrupts can happen with
>> newer controllers?
>
> They're doing lots of stuff which seems superfluous or needlessly
> complicated, e.g. they also reset the controller upon driver load using
> the XRST method (which exists only on some models). I don't think we
> have to do everything exactly as they do as long as it works.
> FWIW I haven't seen any spurious XRIN interrupts on Light Ridge.
>
>
>> Concerning TRPE style hardware: It seems that pm is more complicated
>> here. I see a bunch of references to SX* ACPI methods (SXFP, SXLV,
>> SXIO) and have not yet figured out what they do. Maybe we should not
>> enable PM if XRPE is not present until we find someone to test it.
>
> But you do have the SX* methods on your machine even though it uses
> XRPE, right? I've mostly figured out now what these methods are there
> for and have documented them extensively in upstream.c. However I cannot
> verify if my documentation is accurate as they are not present on my
> machine, but perhaps you can if your machine has them.
Yes I have these methods but I have no idea what they do. Just that
they have to be called before suspend:
http://lxr.free-electrons.com/source/drivers/pci/quirks.c#L3175


> SXLV, SXIO and SXIL exist only on Cactus Ridge machines and utilize
> the Go2Sx and Ok2Go2Sx pins. Judging by the PCI quirk you've added,
> it seems that a Go2Sx dance is necessary on this controller before
> power is cut (either by going to S3 / S4 / S5 or by using the Force
> Power pin, which is what XRPE / TRPE / SXFP do).
>
>
>> As you have noted the "correct" place to but this logic would be at
>> the upstream bridge. Ideally the downstream bridges should go into
>> D3hot by themselves if no devices are attached. The NHI as well
>
> In v2 it works exactly like this now:
> https://github.com/l1k/linux/commits/thunderbolt_runpm_v2
>
> The trick is to allocate a Thunderbolt port service for the upstream
> bridge which we can bind to. In fact I'm allocating such a port service
> for *any* PCIe port on Thunderbolt devices, this could be useful for all
> sorts of other stuff.
Just tested your branch - works nicely (runtime pm, suspend and hibernate)!

> Binding to the upstream bridge also allows us to replace the PCI quirk
> which delays resume_noirq on the downstream bridges, as demonstrated by
> this experimental commit (works fine on Light Ridge but YMMV):
> https://github.com/l1k/linux/commit/79e0b8b8fb5da50b63836939f75212f824d8cba7
>
>
>> (did you by chance check whether the NHI can be put into D3hot without
>> killing the thunderbolt tunnels?).
>
> Amazingly this works. However the NHI does not act on hotplug events
> after thunderbolt_suspend() has been called. Even without calling
> thunderbolt_suspend(), it seems that the control channel is down
> when the NHI is in D3hot, I'm getting RX timeouts. Also, I cannot
> see any reduction in power consumption when putting the NHI in D3,
> same for the downstream bridges.
Interesting. Looks like the NHI is really just a a device on the tb
swicht. But then it is understandable that turning it of does not
decrease power consumption.


> You can test this for yourself by commenting out the two calls to
> pm_runtime_get() and pm_runtime_put_autosuspend() in switch.c.
> Plug in a Thunderbolt device, wait 10 sec for the NHI to autosuspend,
> try accessing the Thunderbolt device. Works for me.
>
> If the NHI suspended before you had a chance to plug in the device,
> invoke "echo on > /sys/bus/pci/devices/0000:06:00.0/power/control".
> Plug in the device and use "echo auto" to let the NHI autosuspend.
>
>
>> (1) should be possible to fix? For (2): D3Cold always requires a
>> platform specific mechanism and the pci subsystem only supports ACPI.
>> Would it be possible to add an API to tell the pci subsystem that we
>> know how to put a specific device(tree) into D3Cold from a platform
>> driver [+CC Bjorn]? Then this whole thing would become a normal pci
>> suspend operation.
>
> I simply go to D3cold in the driver's ->runtime_suspend callback.
> There's just one small fix necessary in pci_raw_set_power_state()
> for this to work. Plus some changes in portdrv to call down to the
> port service drivers on each pm transition. (It already does this
> for ->suspend and ->resume, we just need the same functionality for
> additional pm callbacks).
>
>
>> Bridges in Hotplugged TB devices might have the same PCI ids as the
>> "root" bridges (if they use the same TB chip). You probably should
>> check that dev is a bridge of the builtin controller (for example by
>> checking for the presence of ACPI methods, see the comment in the
>> other tb quirks).
>
> For the upstream bridge I'm checking if its parent is a root port now
> to determine if it's a host controller built into the machine.
> I think the only chance for a false positive is if two machines are
> connected with Thunderbolt and one of them has multiple Thunderbolt
> controllers built in. Might look like this:
>
> RP - UPSB - DSB - UPSB - DSB - RP - RP - UPSB - DSB
> ^^^^^^^^^^^^^^^   ^^^^                   ^^^^^^^^^^
> local machine     remote machine         secondary controller on remote
I don't think that it is possible to tunnel into a different machine
like that :) The root port check should be sufficient.

Best Regards
Andreas


> If the topology indeed looks like this (which I'm not sure of, I lack
> the hardware to test it), a thunderbolt_upstream driver will try to
> attach to UPSB on the secondary controller of the remote machine but
> should bail out because it can't find an ACPI handle for its NHI.
> So we should even have this corner case covered.
> Best regards,
>
> Lukas
