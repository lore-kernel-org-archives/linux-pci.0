Return-Path: <SRS0=YYvE=KO=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=YYvE=KO=netronome.com=jakub.kicinski@kernel.org>
Date: Mon, 30 Jul 2018 15:00:26 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Moshe Shemesh
 <moshes20.il@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Eran Ben Elisha
 <eranbe@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, "David S.
 Miller" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [net-next 10/16] net/mlx5: Support PCIe buffer congestion
 handling via Devlink
Message-ID: <20180730150026.022c729a@cakuba.netronome.com>
In-Reply-To: <CAKgT0UcbXT6EXt=zwoOzZ-wm7uS70wvm9xMcsoSf6OzuJsLxMQ@mail.gmail.com>
References: <575e4a3a-af6f-aac4-fed6-fd4dad387105@mellanox.com>
	<20180724125135.19121f1f@cakuba.netronome.com>
	<98071d31-bf99-d713-7fd1-4b1cc156377e@mellanox.com>
	<CAKgT0UfG-4zuKArCbSLkZoCKs2-t6r9U4qQPPUvBk-e_5_3FCg@mail.gmail.com>
	<20180725174359.6952c937@cakuba.netronome.com>
	<20180726071433.GA2222@nanopsycho>
	<CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com>
	<20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com>
	<CALBF4T81ArTWR_i6SogC4qe8xPf3WYvdrSkypXt65wOf_upopg@mail.gmail.com>
	<CAKgT0UfkBQKqy87BcnQvfzrbonR5rm9cd3Q2dzsyR04vY-+FWg@mail.gmail.com>
	<20180730140727.GJ173328@bhelgaas-glaptop.roam.corp.google.com>
	<CAKgT0UcbXT6EXt=zwoOzZ-wm7uS70wvm9xMcsoSf6OzuJsLxMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 30 Jul 2018 08:02:48 -0700, Alexander Duyck wrote:
> On Mon, Jul 30, 2018 at 7:07 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Jul 29, 2018 at 03:00:28PM -0700, Alexander Duyck wrote:  
> >> On Sun, Jul 29, 2018 at 2:23 AM, Moshe Shemesh <moshes20.il@gmail.com> wrote:  
> >> > On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:  
> >> >> On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyck wrote:  
> >> >> > On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko <jiri@resnulli.us> wrote:  
> >> >> > > Thu, Jul 26, 2018 at 02:43:59AM CEST, jakub.kicinski@netronome.com wrote:  
> >> >> > >>On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:  
> >> >> > >>> On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:  
> >> >> > >>> > On 7/24/2018 10:51 PM, Jakub Kicinski wrote:  
> >> >> > >>> >>>> The devlink params haven't been upstream even for a full cycle
> >> >> > >>> >>>> and
> >> >> > >>> >>>> already you guys are starting to use them to configure standard
> >> >> > >>> >>>> features like queuing.  
> >> >> > >>> >>>
> >> >> > >>> >>> We developed the devlink params in order to support non-standard
> >> >> > >>> >>> configuration only. And for non-standard, there are generic and
> >> >> > >>> >>> vendor
> >> >> > >>> >>> specific options.  
> >> >> > >>> >>
> >> >> > >>> >> I thought it was developed for performing non-standard and
> >> >> > >>> >> possibly
> >> >> > >>> >> vendor specific configuration.  Look at DEVLINK_PARAM_GENERIC_*
> >> >> > >>> >> for
> >> >> > >>> >> examples of well justified generic options for which we have no
> >> >> > >>> >> other API.  The vendor mlx4 options look fairly vendor specific
> >> >> > >>> >> if you
> >> >> > >>> >> ask me, too.
> >> >> > >>> >>
> >> >> > >>> >> Configuring queuing has an API.  The question is it acceptable to
> >> >> > >>> >> enter
> >> >> > >>> >> into the risky territory of controlling offloads via devlink
> >> >> > >>> >> parameters
> >> >> > >>> >> or would we rather make vendors take the time and effort to model
> >> >> > >>> >> things to (a subset) of existing APIs.  The HW never fits the
> >> >> > >>> >> APIs
> >> >> > >>> >> perfectly.  
> >> >> > >>> >
> >> >> > >>> > I understand what you meant here, I would like to highlight that
> >> >> > >>> > this
> >> >> > >>> > mechanism was not meant to handle SRIOV, Representors, etc.
> >> >> > >>> > The vendor specific configuration suggested here is to handle a
> >> >> > >>> > congestion
> >> >> > >>> > state in Multi Host environment (which includes PF and multiple
> >> >> > >>> > VFs per
> >> >> > >>> > host), where one host is not aware to the other hosts, and each is
> >> >> > >>> > running
> >> >> > >>> > on its own pci/driver. It is a device working mode configuration.
> >> >> > >>> >
> >> >> > >>> > This  couldn't fit into any existing API, thus creating this
> >> >> > >>> > vendor specific
> >> >> > >>> > unique API is needed.  
> >> >> > >>>
> >> >> > >>> If we are just going to start creating devlink interfaces in for
> >> >> > >>> every
> >> >> > >>> one-off option a device wants to add why did we even bother with
> >> >> > >>> trying to prevent drivers from using sysfs? This just feels like we
> >> >> > >>> are back to the same arguments we had back in the day with it.
> >> >> > >>>
> >> >> > >>> I feel like the bigger question here is if devlink is how we are
> >> >> > >>> going
> >> >> > >>> to deal with all PCIe related features going forward, or should we
> >> >> > >>> start looking at creating a new interface/tool for PCI/PCIe related
> >> >> > >>> features? My concern is that we have already had features such as
> >> >> > >>> DMA
> >> >> > >>> Coalescing that didn't really fit into anything and now we are
> >> >> > >>> starting to see other things related to DMA and PCIe bus credits.
> >> >> > >>> I'm
> >> >> > >>> wondering if we shouldn't start looking at a tool/interface to
> >> >> > >>> configure all the PCIe related features such as interrupts, error
> >> >> > >>> reporting, DMA configuration, power management, etc. Maybe we could
> >> >> > >>> even look at sharing it across subsystems and include things like
> >> >> > >>> storage, graphics, and other subsystems in the conversation.  
> >> >> > >>
> >> >> > >>Agreed, for actual PCIe configuration (i.e. not ECN marking) we do
> >> >> > >> need
> >> >> > >>to build up an API.  Sharing it across subsystems would be very cool!  
> >> >>
> >> >> I read the thread (starting at [1], for anybody else coming in late)
> >> >> and I see this has something to do with "configuring outbound PCIe
> >> >> buffers", but I haven't seen the connection to PCIe protocol or
> >> >> features, i.e., I can't connect this to anything in the PCIe spec.
> >> >>
> >> >> Can somebody help me understand how the PCI core is relevant?  If
> >> >> there's some connection with a feature defined by PCIe, or if it
> >> >> affects the PCIe transaction protocol somehow, I'm definitely
> >> >> interested in this.  But if this only affects the data transferred
> >> >> over PCIe, i.e., the data payloads of PCIe TLP packets, then I'm not
> >> >> sure why the PCI core should care.
> >> >>  
> >> >
> >> >
> >> > As you wrote, this is not a PCIe feature  or affects the PCIe transaction
> >> > protocol.
> >> >
> >> > Actually, due to hardware limitation in current device, we have enabled a
> >> > workaround in hardware.
> >> >
> >> > This mode is proprietary and not relevant to other PCIe devices, thus is set
> >> > using driver-specific parameter in devlink  
> >>
> >> Essentially what this feature is doing is communicating the need for
> >> PCIe back-pressure to the network fabric. So as the buffers on the
> >> device start to fill because the device isn't able to get back PCIe
> >> credits fast enough it will then start to send congestion
> >> notifications to the network stack itself if I understand this
> >> correctly.  
> >
> > This sounds like a hook that allows the device to tell its driver
> > about PCIe flow control credits, and the driver can pass that on to
> > the network stack.  IIUC, that would be a device-specific feature
> > outside the scope of the PCI core.

Hm, I might be wrong but AFAIU the patch which sparked the discussion
does not go all the way down to the PCIe FC.  PCIe layer works at max
possible rate (single VC etc.), but there is a mismatch between network
and PCIe speed.  E.g. with a 2x40GE NIC on a 8x8 PCIe v3 (63 Gbps) there
can be more traffic flowing in than PCIe bus will be able to transfer
to the host. From a networking ASIC perspective it's a fairly typical
problem of dealing with mismatched port speeds, incast, etc.  GPUs or
storage devices will not have this problem, it will only happen with
non-flow controlled network technologies, i.e. netdevs.  It so happens
the device is on a PCIe bus but the same problem can happen on SPI or
any other bus.

Having said that a PCIe configuration API seems to continue to come up.
Examples Alex gives below seem very valid (AFAIU them).

> >> For now there are no major conflicts, but when we start getting into
> >> stuff like PCIe DMA coalescing, and on a more general basis just PCIe
> >> active state power management that is going to start making things
> >> more complicated going forward.  
> >
> > We do support ASPM already in the PCI core, and we do have the
> > pci_disable_link_state() interface, which is currently the only way
> > drivers can influence it.  There are several drivers that do their own
> > ASPM configuration, but this is not safe because it's not coordinated
> > with what the PCI core does.  If/when drivers need more control, we
> > should enhance the PCI core interfaces.  
> 
> This is kind of what I was getting at. It would be useful to have an
> interface of some sort so that drivers get notified when a user is
> making changes to configuration space and I don't know if anything
> like that exists now.
> 
> > I don't know what PCIe DMA coalescing means, so I can't comment on
> > that.  
> 
> There are devices, specifically network devices, that will hold off on
> switching between either L0s or L1 and L0 by deferring DMA operations.
> Basically the idea is supposed to be to hold off bringing the link up
> for as long as possible in order to maximize power savings for the
> ASPM state. This is something that has come up in the past, and I
> don't know if there has been any interface determined for how to
> handle this sort of configuration. Most of it occurs through MMIO.
> 
> >> I assume the devices we are talking about supporting this new feature
> >> on either don't deal with ASPM or assume a quick turnaround to get out
> >> of the lower power states? Otherwise that would definitely cause some
> >> back-pressure buildups that would hurt performance.  
> >
> > Devices can communicate the ASPM exit latency they can tolerate via
> > the Device Capabilities register (PCIe r4.0, sec 76.5.3.3).  Linux
> > should be configuring ASPM to respect those device requirements.
> >
> > Bjorn  
> 
> Right. But my  point was something like ASPM will add extra complexity
> to a feature such as what has been described here. My concern is that
> I don't want us implementing stuff on a per-driver basis that is not
> all that unique to the device. I don't really see the feature that was
> described above as being something that will stay specific to this one
> device for very long, especially if it provides added value. Basically
> all it is doing is allowing exposing PCIe congestion management to
> upper levels in the network stack. I don't even necessarily see it as
> being networking specific as I would imagine there might be other
> types of devices that could make use of knowing how many transactions
> and such they could process at the same time.
> 
> - Alex
