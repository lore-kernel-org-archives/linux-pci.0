Return-Path: <SRS0=mjUw=KP=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=mjUw=KP=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180731023339.GG45322@bhelgaas-glaptop.roam.corp.google.com>
References: <98071d31-bf99-d713-7fd1-4b1cc156377e@mellanox.com>
 <CAKgT0UfG-4zuKArCbSLkZoCKs2-t6r9U4qQPPUvBk-e_5_3FCg@mail.gmail.com>
 <20180725174359.6952c937@cakuba.netronome.com> <20180726071433.GA2222@nanopsycho>
 <CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com>
 <20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com>
 <CALBF4T81ArTWR_i6SogC4qe8xPf3WYvdrSkypXt65wOf_upopg@mail.gmail.com>
 <CAKgT0UfkBQKqy87BcnQvfzrbonR5rm9cd3Q2dzsyR04vY-+FWg@mail.gmail.com>
 <20180730140727.GJ173328@bhelgaas-glaptop.roam.corp.google.com>
 <CAKgT0UcbXT6EXt=zwoOzZ-wm7uS70wvm9xMcsoSf6OzuJsLxMQ@mail.gmail.com> <20180731023339.GG45322@bhelgaas-glaptop.roam.corp.google.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 30 Jul 2018 20:19:50 -0700
Message-ID: <CAKgT0Uc2jTtpGC+q_THWQK33csrOW2jfuGRix387mmJExSSJaA@mail.gmail.com>
Subject: Re: [net-next 10/16] net/mlx5: Support PCIe buffer congestion
 handling via Devlink
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Moshe Shemesh <moshes20.il@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <jakub.kicinski@netronome.com>, Eran Ben Elisha <eranbe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 7:33 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jul 30, 2018 at 08:02:48AM -0700, Alexander Duyck wrote:
>> On Mon, Jul 30, 2018 at 7:07 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Sun, Jul 29, 2018 at 03:00:28PM -0700, Alexander Duyck wrote:
>> >> On Sun, Jul 29, 2018 at 2:23 AM, Moshe Shemesh <moshes20.il@gmail.com> wrote:
>> >> > On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> >> On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyck wrote:
>> >> >> > On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> > > Thu, Jul 26, 2018 at 02:43:59AM CEST, jakub.kicinski@netronome.com
>> >> >> > > wrote:
>> >> >> > >>On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:
>> >> >> > >>> On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:
>> >> >> > >>> > On 7/24/2018 10:51 PM, Jakub Kicinski wrote:
>> >> >> > >>> >>>> The devlink params haven't been upstream even for a full cycle
>> >> >> > >>> >>>> and
>> >> >> > >>> >>>> already you guys are starting to use them to configure standard
>> >> >> > >>> >>>> features like queuing.
>> >> >> > >>> >>>
>> >> >> > >>> >>> We developed the devlink params in order to support non-standard
>> >> >> > >>> >>> configuration only. And for non-standard, there are generic and
>> >> >> > >>> >>> vendor
>> >> >> > >>> >>> specific options.
>> >> >> > >>> >>
>> >> >> > >>> >> I thought it was developed for performing non-standard and
>> >> >> > >>> >> possibly
>> >> >> > >>> >> vendor specific configuration.  Look at DEVLINK_PARAM_GENERIC_*
>> >> >> > >>> >> for
>> >> >> > >>> >> examples of well justified generic options for which we have no
>> >> >> > >>> >> other API.  The vendor mlx4 options look fairly vendor specific
>> >> >> > >>> >> if you
>> >> >> > >>> >> ask me, too.
>> >> >> > >>> >>
>> >> >> > >>> >> Configuring queuing has an API.  The question is it acceptable to
>> >> >> > >>> >> enter
>> >> >> > >>> >> into the risky territory of controlling offloads via devlink
>> >> >> > >>> >> parameters
>> >> >> > >>> >> or would we rather make vendors take the time and effort to model
>> >> >> > >>> >> things to (a subset) of existing APIs.  The HW never fits the
>> >> >> > >>> >> APIs
>> >> >> > >>> >> perfectly.
>> >> >> > >>> >
>> >> >> > >>> > I understand what you meant here, I would like to highlight that
>> >> >> > >>> > this
>> >> >> > >>> > mechanism was not meant to handle SRIOV, Representors, etc.
>> >> >> > >>> > The vendor specific configuration suggested here is to handle a
>> >> >> > >>> > congestion
>> >> >> > >>> > state in Multi Host environment (which includes PF and multiple
>> >> >> > >>> > VFs per
>> >> >> > >>> > host), where one host is not aware to the other hosts, and each is
>> >> >> > >>> > running
>> >> >> > >>> > on its own pci/driver. It is a device working mode configuration.
>> >> >> > >>> >
>> >> >> > >>> > This  couldn't fit into any existing API, thus creating this
>> >> >> > >>> > vendor specific
>> >> >> > >>> > unique API is needed.
>> >> >> > >>>
>> >> >> > >>> If we are just going to start creating devlink interfaces in for
>> >> >> > >>> every
>> >> >> > >>> one-off option a device wants to add why did we even bother with
>> >> >> > >>> trying to prevent drivers from using sysfs? This just feels like we
>> >> >> > >>> are back to the same arguments we had back in the day with it.
>> >> >> > >>>
>> >> >> > >>> I feel like the bigger question here is if devlink is how we are
>> >> >> > >>> going
>> >> >> > >>> to deal with all PCIe related features going forward, or should we
>> >> >> > >>> start looking at creating a new interface/tool for PCI/PCIe related
>> >> >> > >>> features? My concern is that we have already had features such as
>> >> >> > >>> DMA
>> >> >> > >>> Coalescing that didn't really fit into anything and now we are
>> >> >> > >>> starting to see other things related to DMA and PCIe bus credits.
>> >> >> > >>> I'm
>> >> >> > >>> wondering if we shouldn't start looking at a tool/interface to
>> >> >> > >>> configure all the PCIe related features such as interrupts, error
>> >> >> > >>> reporting, DMA configuration, power management, etc. Maybe we could
>> >> >> > >>> even look at sharing it across subsystems and include things like
>> >> >> > >>> storage, graphics, and other subsystems in the conversation.
>> >> >> > >>
>> >> >> > >>Agreed, for actual PCIe configuration (i.e. not ECN marking) we do
>> >> >> > >> need
>> >> >> > >>to build up an API.  Sharing it across subsystems would be very cool!
>> >> >>
>> >> >> I read the thread (starting at [1], for anybody else coming in late)
>> >> >> and I see this has something to do with "configuring outbound PCIe
>> >> >> buffers", but I haven't seen the connection to PCIe protocol or
>> >> >> features, i.e., I can't connect this to anything in the PCIe spec.
>> >> >>
>> >> >> Can somebody help me understand how the PCI core is relevant?  If
>> >> >> there's some connection with a feature defined by PCIe, or if it
>> >> >> affects the PCIe transaction protocol somehow, I'm definitely
>> >> >> interested in this.  But if this only affects the data transferred
>> >> >> over PCIe, i.e., the data payloads of PCIe TLP packets, then I'm not
>> >> >> sure why the PCI core should care.
>> >> >
>> >> > As you wrote, this is not a PCIe feature  or affects the PCIe transaction
>> >> > protocol.
>> >> >
>> >> > Actually, due to hardware limitation in current device, we have enabled a
>> >> > workaround in hardware.
>> >> >
>> >> > This mode is proprietary and not relevant to other PCIe devices, thus is set
>> >> > using driver-specific parameter in devlink
>> >>
>> >> Essentially what this feature is doing is communicating the need for
>> >> PCIe back-pressure to the network fabric. So as the buffers on the
>> >> device start to fill because the device isn't able to get back PCIe
>> >> credits fast enough it will then start to send congestion
>> >> notifications to the network stack itself if I understand this
>> >> correctly.
>> >
>> > This sounds like a hook that allows the device to tell its driver
>> > about PCIe flow control credits, and the driver can pass that on to
>> > the network stack.  IIUC, that would be a device-specific feature
>> > outside the scope of the PCI core.
>> >
>> >> For now there are no major conflicts, but when we start getting into
>> >> stuff like PCIe DMA coalescing, and on a more general basis just PCIe
>> >> active state power management that is going to start making things
>> >> more complicated going forward.
>> >
>> > We do support ASPM already in the PCI core, and we do have the
>> > pci_disable_link_state() interface, which is currently the only way
>> > drivers can influence it.  There are several drivers that do their own
>> > ASPM configuration, but this is not safe because it's not coordinated
>> > with what the PCI core does.  If/when drivers need more control, we
>> > should enhance the PCI core interfaces.
>>
>> This is kind of what I was getting at. It would be useful to have an
>> interface of some sort so that drivers get notified when a user is
>> making changes to configuration space and I don't know if anything
>> like that exists now.
>
> You mean something like this?
>
>   - driver registers a callback with PCI core
>   - user runs setpci, which writes PCI config space via sysfs
>   - kernel hook in pci_write_config() notices write and calls driver
>     callback
>   - driver callback receives config address and data written
>   - driver parses PCI capability lists to identify register
>
> Nothing like that exists today, and this is not what I had in mind by
> "enhance the PCI core interfaces".  I'm not sure what the utility of
> this is (but I'm not a networking guy by any means).

Well in general I have been wondering if setpci is really the cleanest
way to do any of this. I have found it can be a fast way to really
mess things up. For example using setpci to trigger an FLR is a fast
way to cripple an interface. I recall using that approach when testing
the fm10k driver to deal with surprise resets.

The problem is setpci is REALLY powerful. It lets you change a ton
that can impact the driver, and many drivers just read the config
space at the probe function and assume it is static (which in most
cases it is). That is why I was thinking as a small step it might be
useful to have the notifications delivered to the driver if it is
registered on the interface so it could prepare or clean-up after a
change to the PCI configuration space.

> I think it's a bad idea for drivers to directly write config space.
> It would be much better to provide a PCI core interface so we can
> implement things once and coordinate things that need to be
> coordinated.

I agree with that.

>> > I don't know what PCIe DMA coalescing means, so I can't comment on
>> > that.
>>
>> There are devices, specifically network devices, that will hold off on
>> switching between either L0s or L1 and L0 by deferring DMA operations.
>> Basically the idea is supposed to be to hold off bringing the link up
>> for as long as possible in order to maximize power savings for the
>> ASPM state. This is something that has come up in the past, and I
>> don't know if there has been any interface determined for how to
>> handle this sort of configuration. Most of it occurs through MMIO.
>
> The device can certainly delay L0s or L1 exit if it wants to.  If
> there are knobs to control this, e.g., how long it can defer a DMA, it
> makes sense that they would be device-specific and in MMIO space.  The
> PCI core can't be involved in that because in general it knows nothing
> about the contents of MMIO BARs.  Presumably those knobs would work
> within the framework of ASPM as defined by the PCIe spec, e.g., if we
> disable ASPM, the knobs would do nothing because there is no L0s or L1
> at all.
>
> That's not to say that device designers couldn't get together and
> define a common model for such knobs that puts them at well-known
> offsets in well-known BARs.  All I'm saying is that this sounds like
> it's currently outside the realm of the PCI specs and the PCI core.

Some of this was already handled in LTR and OBFF. I think the DMA
coalescing was meant to work either with those, or optionally on its
own. As far as being ASPM dependent or not I don't think it really
cared all that much other than knowing if ASPM was enabled and how
long it takes for a given device to come out of either of those
states. The general idea with DMA coalescing was to try and save power
on the CPU and then possibly the PCIe link if the value was set high
enough and ASPM was enabled.

Anyway we have kind of gotten off into a tangent as I was just citing
something that might end up having an interaction with a feature such
as notifying the stack that the Rx buffer on a given device has become
congested.

>> >> I assume the devices we are talking about supporting this new feature
>> >> on either don't deal with ASPM or assume a quick turnaround to get out
>> >> of the lower power states? Otherwise that would definitely cause some
>> >> back-pressure buildups that would hurt performance.
>> >
>> > Devices can communicate the ASPM exit latency they can tolerate via
>> > the Device Capabilities register (PCIe r4.0, sec 76.5.3.3).  Linux
>> > should be configuring ASPM to respect those device requirements.
>>
>> Right. But my point was something like ASPM will add extra complexity
>> to a feature such as what has been described here. My concern is that
>> I don't want us implementing stuff on a per-driver basis that is not
>> all that unique to the device. I don't really see the feature that was
>> described above as being something that will stay specific to this one
>> device for very long, especially if it provides added value. Basically
>> all it is doing is allowing exposing PCIe congestion management to
>> upper levels in the network stack. I don't even necessarily see it as
>> being networking specific as I would imagine there might be other
>> types of devices that could make use of knowing how many transactions
>> and such they could process at the same time.
>
> It sounds to me like you need a library that can be used by all the
> drivers that need this functionality.  Unless it's something
> documented in the PCIe specs so we can rely on a standard way of
> discovering and configuring things, I don't see how the PCI core can
> really be involved.
>
> Bjorn

I am kind of thinking that a common library would be a preferred way
to go, or at least a common interface to share between the drivers. It
wasn't my intention to imply that the PCI core needed to get involved.
I was including the linux-pci list as more of a way of checking to get
the broader audience's input since we were just discussing this on
netdev.

My main concern is that those of us on netdev have historically we
have been dealing with features such as SR-IOV as a networking thing,
when really it has been a combination of a PCI feature and some
network switching. I might have ratholed this a bit, as I kind of see
this topic as something similar.

- Alex
