Return-Path: <SRS0=jNu+=KQ=gmail.com=moshes20.il@kernel.org>
Return-Path: <SRS0=jNu+=KQ=gmail.com=moshes20.il@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180731110649.GI45322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180725174359.6952c937@cakuba.netronome.com> <20180726071433.GA2222@nanopsycho>
 <CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com>
 <20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com>
 <CALBF4T81ArTWR_i6SogC4qe8xPf3WYvdrSkypXt65wOf_upopg@mail.gmail.com>
 <CAKgT0UfkBQKqy87BcnQvfzrbonR5rm9cd3Q2dzsyR04vY-+FWg@mail.gmail.com>
 <20180730140727.GJ173328@bhelgaas-glaptop.roam.corp.google.com>
 <CAKgT0UcbXT6EXt=zwoOzZ-wm7uS70wvm9xMcsoSf6OzuJsLxMQ@mail.gmail.com>
 <20180731023339.GG45322@bhelgaas-glaptop.roam.corp.google.com>
 <CAKgT0Uc2jTtpGC+q_THWQK33csrOW2jfuGRix387mmJExSSJaA@mail.gmail.com> <20180731110649.GI45322@bhelgaas-glaptop.roam.corp.google.com>
From: Moshe Shemesh <moshes20.il@gmail.com>
Date: Wed, 1 Aug 2018 21:28:17 +0300
Message-ID: <CALBF4T_UQ9qj7OzkAC7278+=3RV0kEoy5boyYSXDiQ_edD3iTA@mail.gmail.com>
Subject: Re: [net-next 10/16] net/mlx5: Support PCIe buffer congestion
 handling via Devlink
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <jakub.kicinski@netronome.com>, Eran Ben Elisha <eranbe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000c959db057263db7c"
List-ID: <linux-pci.vger.kernel.org>

--000000000000c959db057263db7c
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 31, 2018 at 2:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Jul 30, 2018 at 08:19:50PM -0700, Alexander Duyck wrote:
> > On Mon, Jul 30, 2018 at 7:33 PM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > > On Mon, Jul 30, 2018 at 08:02:48AM -0700, Alexander Duyck wrote:
> > >> On Mon, Jul 30, 2018 at 7:07 AM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > >> > On Sun, Jul 29, 2018 at 03:00:28PM -0700, Alexander Duyck wrote:
> > >> >> On Sun, Jul 29, 2018 at 2:23 AM, Moshe Shemesh <
> moshes20.il@gmail.com> wrote:
> > >> >> > On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas <
> helgaas@kernel.org> wrote:
> > >> >> >> On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyck wrote:
> > >> >> >> > On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko <
> jiri@resnulli.us> wrote:
> > >> >> >> > > Thu, Jul 26, 2018 at 02:43:59AM CEST,
> jakub.kicinski@netronome.com
> > >> >> >> > > wrote:
> > >> >> >> > >>On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:
> > >> >> >> > >>> On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:
> > >> >> >> > >>> > On 7/24/2018 10:51 PM, Jakub Kicinski wrote:
> > >> >> >> > >>> >>>> The devlink params haven't been upstream even for a
> full cycle
> > >> >> >> > >>> >>>> and
> > >> >> >> > >>> >>>> already you guys are starting to use them to
> configure standard
> > >> >> >> > >>> >>>> features like queuing.
> > >> >> >> > >>> >>>
> > >> >> >> > >>> >>> We developed the devlink params in order to support
> non-standard
> > >> >> >> > >>> >>> configuration only. And for non-standard, there are
> generic and
> > >> >> >> > >>> >>> vendor
> > >> >> >> > >>> >>> specific options.
> > >> >> >> > >>> >>
> > >> >> >> > >>> >> I thought it was developed for performing non-standard
> and
> > >> >> >> > >>> >> possibly
> > >> >> >> > >>> >> vendor specific configuration.  Look at
> DEVLINK_PARAM_GENERIC_*
> > >> >> >> > >>> >> for
> > >> >> >> > >>> >> examples of well justified generic options for which
> we have no
> > >> >> >> > >>> >> other API.  The vendor mlx4 options look fairly vendor
> specific
> > >> >> >> > >>> >> if you
> > >> >> >> > >>> >> ask me, too.
> > >> >> >> > >>> >>
> > >> >> >> > >>> >> Configuring queuing has an API.  The question is it
> acceptable to
> > >> >> >> > >>> >> enter
> > >> >> >> > >>> >> into the risky territory of controlling offloads via
> devlink
> > >> >> >> > >>> >> parameters
> > >> >> >> > >>> >> or would we rather make vendors take the time and
> effort to model
> > >> >> >> > >>> >> things to (a subset) of existing APIs.  The HW never
> fits the
> > >> >> >> > >>> >> APIs
> > >> >> >> > >>> >> perfectly.
> > >> >> >> > >>> >
> > >> >> >> > >>> > I understand what you meant here, I would like to
> highlight that
> > >> >> >> > >>> > this
> > >> >> >> > >>> > mechanism was not meant to handle SRIOV, Representors,
> etc.
> > >> >> >> > >>> > The vendor specific configuration suggested here is to
> handle a
> > >> >> >> > >>> > congestion
> > >> >> >> > >>> > state in Multi Host environment (which includes PF and
> multiple
> > >> >> >> > >>> > VFs per
> > >> >> >> > >>> > host), where one host is not aware to the other hosts,
> and each is
> > >> >> >> > >>> > running
> > >> >> >> > >>> > on its own pci/driver. It is a device working mode
> configuration.
> > >> >> >> > >>> >
> > >> >> >> > >>> > This  couldn't fit into any existing API, thus creating
> this
> > >> >> >> > >>> > vendor specific
> > >> >> >> > >>> > unique API is needed.
> > >> >> >> > >>>
> > >> >> >> > >>> If we are just going to start creating devlink interfaces
> in for
> > >> >> >> > >>> every
> > >> >> >> > >>> one-off option a device wants to add why did we even
> bother with
> > >> >> >> > >>> trying to prevent drivers from using sysfs? This just
> feels like we
> > >> >> >> > >>> are back to the same arguments we had back in the day
> with it.
> > >> >> >> > >>>
> > >> >> >> > >>> I feel like the bigger question here is if devlink is how
> we are
> > >> >> >> > >>> going
> > >> >> >> > >>> to deal with all PCIe related features going forward, or
> should we
> > >> >> >> > >>> start looking at creating a new interface/tool for
> PCI/PCIe related
> > >> >> >> > >>> features? My concern is that we have already had features
> such as
> > >> >> >> > >>> DMA
> > >> >> >> > >>> Coalescing that didn't really fit into anything and now
> we are
> > >> >> >> > >>> starting to see other things related to DMA and PCIe bus
> credits.
> > >> >> >> > >>> I'm
> > >> >> >> > >>> wondering if we shouldn't start looking at a
> tool/interface to
> > >> >> >> > >>> configure all the PCIe related features such as
> interrupts, error
> > >> >> >> > >>> reporting, DMA configuration, power management, etc.
> Maybe we could
> > >> >> >> > >>> even look at sharing it across subsystems and include
> things like
> > >> >> >> > >>> storage, graphics, and other subsystems in the
> conversation.
> > >> >> >> > >>
> > >> >> >> > >>Agreed, for actual PCIe configuration (i.e. not ECN
> marking) we do
> > >> >> >> > >> need
> > >> >> >> > >>to build up an API.  Sharing it across subsystems would be
> very cool!
> > >> >> >>
> > >> >> >> I read the thread (starting at [1], for anybody else coming in
> late)
> > >> >> >> and I see this has something to do with "configuring outbound
> PCIe
> > >> >> >> buffers", but I haven't seen the connection to PCIe protocol or
> > >> >> >> features, i.e., I can't connect this to anything in the PCIe
> spec.
> > >> >> >>
> > >> >> >> Can somebody help me understand how the PCI core is relevant?
> If
> > >> >> >> there's some connection with a feature defined by PCIe, or if it
> > >> >> >> affects the PCIe transaction protocol somehow, I'm definitely
> > >> >> >> interested in this.  But if this only affects the data
> transferred
> > >> >> >> over PCIe, i.e., the data payloads of PCIe TLP packets, then
> I'm not
> > >> >> >> sure why the PCI core should care.
> > >> >> >
> > >> >> > As you wrote, this is not a PCIe feature  or affects the PCIe
> transaction
> > >> >> > protocol.
> > >> >> >
> > >> >> > Actually, due to hardware limitation in current device, we have
> enabled a
> > >> >> > workaround in hardware.
> > >> >> >
> > >> >> > This mode is proprietary and not relevant to other PCIe devices,
> thus is set
> > >> >> > using driver-specific parameter in devlink
> > >> >>
> > >> >> Essentially what this feature is doing is communicating the need
> for
> > >> >> PCIe back-pressure to the network fabric. So as the buffers on the
> > >> >> device start to fill because the device isn't able to get back PCIe
> > >> >> credits fast enough it will then start to send congestion
> > >> >> notifications to the network stack itself if I understand this
> > >> >> correctly.
> > >> >
> > >> > This sounds like a hook that allows the device to tell its driver
> > >> > about PCIe flow control credits, and the driver can pass that on to
> > >> > the network stack.  IIUC, that would be a device-specific feature
> > >> > outside the scope of the PCI core.
> > >> >
> > >> >> For now there are no major conflicts, but when we start getting
> into
> > >> >> stuff like PCIe DMA coalescing, and on a more general basis just
> PCIe
> > >> >> active state power management that is going to start making things
> > >> >> more complicated going forward.
> > >> >
> > >> > We do support ASPM already in the PCI core, and we do have the
> > >> > pci_disable_link_state() interface, which is currently the only way
> > >> > drivers can influence it.  There are several drivers that do their
> own
> > >> > ASPM configuration, but this is not safe because it's not
> coordinated
> > >> > with what the PCI core does.  If/when drivers need more control, we
> > >> > should enhance the PCI core interfaces.
> > >>
> > >> This is kind of what I was getting at. It would be useful to have an
> > >> interface of some sort so that drivers get notified when a user is
> > >> making changes to configuration space and I don't know if anything
> > >> like that exists now.
> > >
> > > You mean something like this?
> > >
> > >   - driver registers a callback with PCI core
> > >   - user runs setpci, which writes PCI config space via sysfs
> > >   - kernel hook in pci_write_config() notices write and calls driver
> > >     callback
> > >   - driver callback receives config address and data written
> > >   - driver parses PCI capability lists to identify register
> > >
> > > Nothing like that exists today, and this is not what I had in mind by
> > > "enhance the PCI core interfaces".  I'm not sure what the utility of
> > > this is (but I'm not a networking guy by any means).
> >
> > Well in general I have been wondering if setpci is really the cleanest
> > way to do any of this. I have found it can be a fast way to really
> > mess things up. For example using setpci to trigger an FLR is a fast
> > way to cripple an interface. I recall using that approach when testing
> > the fm10k driver to deal with surprise resets.
> >
> > The problem is setpci is REALLY powerful. It lets you change a ton
> > that can impact the driver, and many drivers just read the config
> > space at the probe function and assume it is static (which in most
> > cases it is). That is why I was thinking as a small step it might be
> > useful to have the notifications delivered to the driver if it is
> > registered on the interface so it could prepare or clean-up after a
> > change to the PCI configuration space.
>
> Yep, setpci is very powerful.  I doubt it's worth having drivers try
> to react, just because setpci can do completely arbitrary things, many
> of which are not recoverable even in principle.  But I do think we
> should make it taint the kernel so we have a clue when things go
> wrong.
>
> > > I think it's a bad idea for drivers to directly write config space.
> > > It would be much better to provide a PCI core interface so we can
> > > implement things once and coordinate things that need to be
> > > coordinated.
> >
> > I agree with that.
> >
> > >> > I don't know what PCIe DMA coalescing means, so I can't comment on
> > >> > that.
> > >>
> > >> There are devices, specifically network devices, that will hold off on
> > >> switching between either L0s or L1 and L0 by deferring DMA operations.
> > >> Basically the idea is supposed to be to hold off bringing the link up
> > >> for as long as possible in order to maximize power savings for the
> > >> ASPM state. This is something that has come up in the past, and I
> > >> don't know if there has been any interface determined for how to
> > >> handle this sort of configuration. Most of it occurs through MMIO.
> > >
> > > The device can certainly delay L0s or L1 exit if it wants to.  If
> > > there are knobs to control this, e.g., how long it can defer a DMA, it
> > > makes sense that they would be device-specific and in MMIO space.  The
> > > PCI core can't be involved in that because in general it knows nothing
> > > about the contents of MMIO BARs.  Presumably those knobs would work
> > > within the framework of ASPM as defined by the PCIe spec, e.g., if we
> > > disable ASPM, the knobs would do nothing because there is no L0s or L1
> > > at all.
> > >
> > > That's not to say that device designers couldn't get together and
> > > define a common model for such knobs that puts them at well-known
> > > offsets in well-known BARs.  All I'm saying is that this sounds like
> > > it's currently outside the realm of the PCI specs and the PCI core.
> >
> > Some of this was already handled in LTR and OBFF. I think the DMA
> > coalescing was meant to work either with those, or optionally on its
> > own. As far as being ASPM dependent or not I don't think it really
> > cared all that much other than knowing if ASPM was enabled and how
> > long it takes for a given device to come out of either of those
> > states. The general idea with DMA coalescing was to try and save power
> > on the CPU and then possibly the PCIe link if the value was set high
> > enough and ASPM was enabled.
> >
> > Anyway we have kind of gotten off into a tangent as I was just citing
> > something that might end up having an interaction with a feature such
> > as notifying the stack that the Rx buffer on a given device has become
> > congested.
> >
> > >> >> I assume the devices we are talking about supporting this new
> feature
> > >> >> on either don't deal with ASPM or assume a quick turnaround to get
> out
> > >> >> of the lower power states? Otherwise that would definitely cause
> some
> > >> >> back-pressure buildups that would hurt performance.
> > >> >
> > >> > Devices can communicate the ASPM exit latency they can tolerate via
> > >> > the Device Capabilities register (PCIe r4.0, sec 76.5.3.3).  Linux
> > >> > should be configuring ASPM to respect those device requirements.
> > >>
> > >> Right. But my point was something like ASPM will add extra complexity
> > >> to a feature such as what has been described here. My concern is that
> > >> I don't want us implementing stuff on a per-driver basis that is not
> > >> all that unique to the device. I don't really see the feature that was
> > >> described above as being something that will stay specific to this one
> > >> device for very long, especially if it provides added value. Basically
> > >> all it is doing is allowing exposing PCIe congestion management to
> > >> upper levels in the network stack. I don't even necessarily see it as
> > >> being networking specific as I would imagine there might be other
> > >> types of devices that could make use of knowing how many transactions
> > >> and such they could process at the same time.
> > >
> > > It sounds to me like you need a library that can be used by all the
> > > drivers that need this functionality.  Unless it's something
> > > documented in the PCIe specs so we can rely on a standard way of
> > > discovering and configuring things, I don't see how the PCI core can
> > > really be involved.
> > >
> > > Bjorn
> >
> > I am kind of thinking that a common library would be a preferred way
> > to go, or at least a common interface to share between the drivers. It
> > wasn't my intention to imply that the PCI core needed to get involved.
> > I was including the linux-pci list as more of a way of checking to get
> > the broader audience's input since we were just discussing this on
> > netdev.
> >
> > My main concern is that those of us on netdev have historically we
> > have been dealing with features such as SR-IOV as a networking thing,
> > when really it has been a combination of a PCI feature and some
> > network switching. I might have ratholed this a bit, as I kind of see
> > this topic as something similar.
>
> OK, thanks.  Sounds like we have similar perspectives and I appreciate
> being looped in!
>
> Bjorn
>

Thanks for your comments, as already understood this is not a pci core
feature, this is a NIC specific hardware limitation workaround.
It is not common to drivers, not even within Mellanox drivers. The previous
NIC generation driver mlx4 does not need it. The next NIC won't need it
too, it should be handled by hardware automatically.
We are sending version 2 with clarification on this in cover letter.

--000000000000c959db057263db7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Jul 31, 2018 at 2:06 PM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"=
><div class=3D"h5">On Mon, Jul 30, 2018 at 08:19:50PM -0700, Alexander Duyc=
k wrote:<br>
&gt; On Mon, Jul 30, 2018 at 7:33 PM, Bjorn Helgaas &lt;<a href=3D"mailto:h=
elgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br>
&gt; &gt; On Mon, Jul 30, 2018 at 08:02:48AM -0700, Alexander Duyck wrote:<=
br>
&gt; &gt;&gt; On Mon, Jul 30, 2018 at 7:07 AM, Bjorn Helgaas &lt;<a href=3D=
"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; On Sun, Jul 29, 2018 at 03:00:28PM -0700, Alexander Duyc=
k wrote:<br>
&gt; &gt;&gt; &gt;&gt; On Sun, Jul 29, 2018 at 2:23 AM, Moshe Shemesh &lt;<=
a href=3D"mailto:moshes20.il@gmail.com">moshes20.il@gmail.com</a>&gt; wrote=
:<br>
&gt; &gt;&gt; &gt;&gt; &gt; On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas =
&lt;<a href=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:=
<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; On Thu, Jul 26, 2018 at 07:00:20AM -0700, A=
lexander Duyck wrote:<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; On Thu, Jul 26, 2018 at 12:14 AM, Jiri=
 Pirko &lt;<a href=3D"mailto:jiri@resnulli.us">jiri@resnulli.us</a>&gt; wro=
te:<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; Thu, Jul 26, 2018 at 02:43:59AM C=
EST, <a href=3D"mailto:jakub.kicinski@netronome.com">jakub.kicinski@netrono=
me.com</a><br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; wrote:<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;On Wed, 25 Jul 2018 08:23:26 -=
0700, Alexander Duyck wrote:<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; On Wed, Jul 25, 2018 at 5=
:31 AM, Eran Ben Elisha wrote:<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; On 7/24/2018 10:51 P=
M, Jakub Kicinski wrote:<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; The devl=
ink params haven&#39;t been upstream even for a full cycle<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; and<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; already =
you guys are starting to use them to configure standard<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; features=
 like queuing.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt; We developed=
 the devlink params in order to support non-standard<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt; configuratio=
n only. And for non-standard, there are generic and<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt; vendor<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;&gt; specific opt=
ions.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; I thought it was=
 developed for performing non-standard and<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; possibly<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; vendor specific =
configuration.=C2=A0 Look at DEVLINK_PARAM_GENERIC_*<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; for<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; examples of well=
 justified generic options for which we have no<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; other API.=C2=A0=
 The vendor mlx4 options look fairly vendor specific<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; if you<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; ask me, too.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; Configuring queu=
ing has an API.=C2=A0 The question is it acceptable to<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; enter<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; into the risky t=
erritory of controlling offloads via devlink<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; parameters<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; or would we rath=
er make vendors take the time and effort to model<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; things to (a sub=
set) of existing APIs.=C2=A0 The HW never fits the<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; APIs<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;&gt; perfectly.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; I understand what yo=
u meant here, I would like to highlight that<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; this<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; mechanism was not me=
ant to handle SRIOV, Representors, etc.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; The vendor specific =
configuration suggested here is to handle a<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; congestion<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; state in Multi Host =
environment (which includes PF and multiple<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; VFs per<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; host), where one hos=
t is not aware to the other hosts, and each is<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; running<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; on its own pci/drive=
r. It is a device working mode configuration.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; This=C2=A0 couldn&#3=
9;t fit into any existing API, thus creating this<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; vendor specific<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; &gt; unique API is needed=
.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; If we are just going to s=
tart creating devlink interfaces in for<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; every<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; one-off option a device w=
ants to add why did we even bother with<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; trying to prevent drivers=
 from using sysfs? This just feels like we<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; are back to the same argu=
ments we had back in the day with it.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; I feel like the bigger qu=
estion here is if devlink is how we are<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; going<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; to deal with all PCIe rel=
ated features going forward, or should we<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; start looking at creating=
 a new interface/tool for PCI/PCIe related<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; features? My concern is t=
hat we have already had features such as<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; DMA<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; Coalescing that didn&#39;=
t really fit into anything and now we are<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; starting to see other thi=
ngs related to DMA and PCIe bus credits.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; I&#39;m<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; wondering if we shouldn&#=
39;t start looking at a tool/interface to<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; configure all the PCIe re=
lated features such as interrupts, error<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; reporting, DMA configurat=
ion, power management, etc. Maybe we could<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; even look at sharing it a=
cross subsystems and include things like<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;&gt; storage, graphics, and ot=
her subsystems in the conversation.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;Agreed, for actual PCIe config=
uration (i.e. not ECN marking) we do<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt; need<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;&gt;to build up an API.=C2=A0 Shar=
ing it across subsystems would be very cool!<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; I read the thread (starting at [1], for any=
body else coming in late)<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; and I see this has something to do with &qu=
ot;configuring outbound PCIe<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; buffers&quot;, but I haven&#39;t seen the c=
onnection to PCIe protocol or<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; features, i.e., I can&#39;t connect this to=
 anything in the PCIe spec.<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; Can somebody help me understand how the PCI=
 core is relevant?=C2=A0 If<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; there&#39;s some connection with a feature =
defined by PCIe, or if it<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; affects the PCIe transaction protocol someh=
ow, I&#39;m definitely<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; interested in this.=C2=A0 But if this only =
affects the data transferred<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; over PCIe, i.e., the data payloads of PCIe =
TLP packets, then I&#39;m not<br>
&gt; &gt;&gt; &gt;&gt; &gt;&gt; sure why the PCI core should care.<br>
&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt; As you wrote, this is not a PCIe feature=C2=A0 =
or affects the PCIe transaction<br>
&gt; &gt;&gt; &gt;&gt; &gt; protocol.<br>
&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt; Actually, due to hardware limitation in current=
 device, we have enabled a<br>
&gt; &gt;&gt; &gt;&gt; &gt; workaround in hardware.<br>
&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; &gt; This mode is proprietary and not relevant to ot=
her PCIe devices, thus is set<br>
&gt; &gt;&gt; &gt;&gt; &gt; using driver-specific parameter in devlink<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; Essentially what this feature is doing is communicat=
ing the need for<br>
&gt; &gt;&gt; &gt;&gt; PCIe back-pressure to the network fabric. So as the =
buffers on the<br>
&gt; &gt;&gt; &gt;&gt; device start to fill because the device isn&#39;t ab=
le to get back PCIe<br>
&gt; &gt;&gt; &gt;&gt; credits fast enough it will then start to send conge=
stion<br>
&gt; &gt;&gt; &gt;&gt; notifications to the network stack itself if I under=
stand this<br>
&gt; &gt;&gt; &gt;&gt; correctly.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; This sounds like a hook that allows the device to tell i=
ts driver<br>
&gt; &gt;&gt; &gt; about PCIe flow control credits, and the driver can pass=
 that on to<br>
&gt; &gt;&gt; &gt; the network stack.=C2=A0 IIUC, that would be a device-sp=
ecific feature<br>
&gt; &gt;&gt; &gt; outside the scope of the PCI core.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; For now there are no major conflicts, but when we st=
art getting into<br>
&gt; &gt;&gt; &gt;&gt; stuff like PCIe DMA coalescing, and on a more genera=
l basis just PCIe<br>
&gt; &gt;&gt; &gt;&gt; active state power management that is going to start=
 making things<br>
&gt; &gt;&gt; &gt;&gt; more complicated going forward.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; We do support ASPM already in the PCI core, and we do ha=
ve the<br>
&gt; &gt;&gt; &gt; pci_disable_link_state() interface, which is currently t=
he only way<br>
&gt; &gt;&gt; &gt; drivers can influence it.=C2=A0 There are several driver=
s that do their own<br>
&gt; &gt;&gt; &gt; ASPM configuration, but this is not safe because it&#39;=
s not coordinated<br>
&gt; &gt;&gt; &gt; with what the PCI core does.=C2=A0 If/when drivers need =
more control, we<br>
&gt; &gt;&gt; &gt; should enhance the PCI core interfaces.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is kind of what I was getting at. It would be useful to =
have an<br>
&gt; &gt;&gt; interface of some sort so that drivers get notified when a us=
er is<br>
&gt; &gt;&gt; making changes to configuration space and I don&#39;t know if=
 anything<br>
&gt; &gt;&gt; like that exists now.<br>
&gt; &gt;<br>
&gt; &gt; You mean something like this?<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0- driver registers a callback with PCI core<br>
&gt; &gt;=C2=A0 =C2=A0- user runs setpci, which writes PCI config space via=
 sysfs<br>
&gt; &gt;=C2=A0 =C2=A0- kernel hook in pci_write_config() notices write and=
 calls driver<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0callback<br>
&gt; &gt;=C2=A0 =C2=A0- driver callback receives config address and data wr=
itten<br>
&gt; &gt;=C2=A0 =C2=A0- driver parses PCI capability lists to identify regi=
ster<br>
&gt; &gt;<br>
&gt; &gt; Nothing like that exists today, and this is not what I had in min=
d by<br>
&gt; &gt; &quot;enhance the PCI core interfaces&quot;.=C2=A0 I&#39;m not su=
re what the utility of<br>
&gt; &gt; this is (but I&#39;m not a networking guy by any means).<br>
&gt; <br>
&gt; Well in general I have been wondering if setpci is really the cleanest=
<br>
&gt; way to do any of this. I have found it can be a fast way to really<br>
&gt; mess things up. For example using setpci to trigger an FLR is a fast<b=
r>
&gt; way to cripple an interface. I recall using that approach when testing=
<br>
&gt; the fm10k driver to deal with surprise resets.<br>
&gt; <br>
&gt; The problem is setpci is REALLY powerful. It lets you change a ton<br>
&gt; that can impact the driver, and many drivers just read the config<br>
&gt; space at the probe function and assume it is static (which in most<br>
&gt; cases it is). That is why I was thinking as a small step it might be<b=
r>
&gt; useful to have the notifications delivered to the driver if it is<br>
&gt; registered on the interface so it could prepare or clean-up after a<br=
>
&gt; change to the PCI configuration space.<br>
<br>
</div></div>Yep, setpci is very powerful.=C2=A0 I doubt it&#39;s worth havi=
ng drivers try<br>
to react, just because setpci can do completely arbitrary things, many<br>
of which are not recoverable even in principle.=C2=A0 But I do think we<br>
should make it taint the kernel so we have a clue when things go<br>
wrong.<br>
<div><div class=3D"h5"><br>
&gt; &gt; I think it&#39;s a bad idea for drivers to directly write config =
space.<br>
&gt; &gt; It would be much better to provide a PCI core interface so we can=
<br>
&gt; &gt; implement things once and coordinate things that need to be<br>
&gt; &gt; coordinated.<br>
&gt; <br>
&gt; I agree with that.<br>
&gt; <br>
&gt; &gt;&gt; &gt; I don&#39;t know what PCIe DMA coalescing means, so I ca=
n&#39;t comment on<br>
&gt; &gt;&gt; &gt; that.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; There are devices, specifically network devices, that will ho=
ld off on<br>
&gt; &gt;&gt; switching between either L0s or L1 and L0 by deferring DMA op=
erations.<br>
&gt; &gt;&gt; Basically the idea is supposed to be to hold off bringing the=
 link up<br>
&gt; &gt;&gt; for as long as possible in order to maximize power savings fo=
r the<br>
&gt; &gt;&gt; ASPM state. This is something that has come up in the past, a=
nd I<br>
&gt; &gt;&gt; don&#39;t know if there has been any interface determined for=
 how to<br>
&gt; &gt;&gt; handle this sort of configuration. Most of it occurs through =
MMIO.<br>
&gt; &gt;<br>
&gt; &gt; The device can certainly delay L0s or L1 exit if it wants to.=C2=
=A0 If<br>
&gt; &gt; there are knobs to control this, e.g., how long it can defer a DM=
A, it<br>
&gt; &gt; makes sense that they would be device-specific and in MMIO space.=
=C2=A0 The<br>
&gt; &gt; PCI core can&#39;t be involved in that because in general it know=
s nothing<br>
&gt; &gt; about the contents of MMIO BARs.=C2=A0 Presumably those knobs wou=
ld work<br>
&gt; &gt; within the framework of ASPM as defined by the PCIe spec, e.g., i=
f we<br>
&gt; &gt; disable ASPM, the knobs would do nothing because there is no L0s =
or L1<br>
&gt; &gt; at all.<br>
&gt; &gt;<br>
&gt; &gt; That&#39;s not to say that device designers couldn&#39;t get toge=
ther and<br>
&gt; &gt; define a common model for such knobs that puts them at well-known=
<br>
&gt; &gt; offsets in well-known BARs.=C2=A0 All I&#39;m saying is that this=
 sounds like<br>
&gt; &gt; it&#39;s currently outside the realm of the PCI specs and the PCI=
 core.<br>
&gt; <br>
&gt; Some of this was already handled in LTR and OBFF. I think the DMA<br>
&gt; coalescing was meant to work either with those, or optionally on its<b=
r>
&gt; own. As far as being ASPM dependent or not I don&#39;t think it really=
<br>
&gt; cared all that much other than knowing if ASPM was enabled and how<br>
&gt; long it takes for a given device to come out of either of those<br>
&gt; states. The general idea with DMA coalescing was to try and save power=
<br>
&gt; on the CPU and then possibly the PCIe link if the value was set high<b=
r>
&gt; enough and ASPM was enabled.<br>
&gt; <br>
&gt; Anyway we have kind of gotten off into a tangent as I was just citing<=
br>
&gt; something that might end up having an interaction with a feature such<=
br>
&gt; as notifying the stack that the Rx buffer on a given device has become=
<br>
&gt; congested.<br>
&gt; <br>
&gt; &gt;&gt; &gt;&gt; I assume the devices we are talking about supporting=
 this new feature<br>
&gt; &gt;&gt; &gt;&gt; on either don&#39;t deal with ASPM or assume a quick=
 turnaround to get out<br>
&gt; &gt;&gt; &gt;&gt; of the lower power states? Otherwise that would defi=
nitely cause some<br>
&gt; &gt;&gt; &gt;&gt; back-pressure buildups that would hurt performance.<=
br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Devices can communicate the ASPM exit latency they can t=
olerate via<br>
&gt; &gt;&gt; &gt; the Device Capabilities register (PCIe r4.0, sec 76.5.3.=
3).=C2=A0 Linux<br>
&gt; &gt;&gt; &gt; should be configuring ASPM to respect those device requi=
rements.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Right. But my point was something like ASPM will add extra co=
mplexity<br>
&gt; &gt;&gt; to a feature such as what has been described here. My concern=
 is that<br>
&gt; &gt;&gt; I don&#39;t want us implementing stuff on a per-driver basis =
that is not<br>
&gt; &gt;&gt; all that unique to the device. I don&#39;t really see the fea=
ture that was<br>
&gt; &gt;&gt; described above as being something that will stay specific to=
 this one<br>
&gt; &gt;&gt; device for very long, especially if it provides added value. =
Basically<br>
&gt; &gt;&gt; all it is doing is allowing exposing PCIe congestion manageme=
nt to<br>
&gt; &gt;&gt; upper levels in the network stack. I don&#39;t even necessari=
ly see it as<br>
&gt; &gt;&gt; being networking specific as I would imagine there might be o=
ther<br>
&gt; &gt;&gt; types of devices that could make use of knowing how many tran=
sactions<br>
&gt; &gt;&gt; and such they could process at the same time.<br>
&gt; &gt;<br>
&gt; &gt; It sounds to me like you need a library that can be used by all t=
he<br>
&gt; &gt; drivers that need this functionality.=C2=A0 Unless it&#39;s somet=
hing<br>
&gt; &gt; documented in the PCIe specs so we can rely on a standard way of<=
br>
&gt; &gt; discovering and configuring things, I don&#39;t see how the PCI c=
ore can<br>
&gt; &gt; really be involved.<br>
&gt; &gt;<br>
&gt; &gt; Bjorn<br>
&gt; <br>
&gt; I am kind of thinking that a common library would be a preferred way<b=
r>
&gt; to go, or at least a common interface to share between the drivers. It=
<br>
&gt; wasn&#39;t my intention to imply that the PCI core needed to get invol=
ved.<br>
&gt; I was including the linux-pci list as more of a way of checking to get=
<br>
&gt; the broader audience&#39;s input since we were just discussing this on=
<br>
&gt; netdev.<br>
&gt; <br>
&gt; My main concern is that those of us on netdev have historically we<br>
&gt; have been dealing with features such as SR-IOV as a networking thing,<=
br>
&gt; when really it has been a combination of a PCI feature and some<br>
&gt; network switching. I might have ratholed this a bit, as I kind of see<=
br>
&gt; this topic as something similar.<br>
<br>
</div></div>OK, thanks.=C2=A0 Sounds like we have similar perspectives and =
I appreciate<br>
being looped in!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Bjorn<br></font></span></blockquote><div><br></div><div>

<span style=3D"font-family:&quot;Times New Roman&quot;,serif;font-size:14.6=
667px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;float:none;display:inline">Thanks for your comment=
s, as already understood this is not a pci core feature, this is a NIC spec=
ific hardware limitation workaround.<span>=C2=A0</span></span><br style=3D"=
font-family:&quot;Times New Roman&quot;,serif;font-size:14.6667px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial"><span style=3D"font-family:&quot;Times New Roman&quot;,serif;fon=
t-size:14.6667px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">It is not co=
mmon to drivers, not even within Mellanox drivers. The previous NIC generat=
ion driver mlx4 does not need it. The next NIC won&#39;t need it too, it sh=
ould be handled by hardware automatically.<span>=C2=A0</span></span><br sty=
le=3D"font-family:&quot;Times New Roman&quot;,serif;font-size:14.6667px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial"><span style=3D"font-family:&quot;Times New Roman&quot;,ser=
if;font-size:14.6667px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;float:none;display:inline">We are=
 sending version 2 with clarification on this in cover letter.</span>

=C2=A0</div></div><br></div></div>

--000000000000c959db057263db7c--
