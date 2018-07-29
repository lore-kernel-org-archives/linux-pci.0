Return-Path: <SRS0=nLAw=KN=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=nLAw=KN=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALBF4T81ArTWR_i6SogC4qe8xPf3WYvdrSkypXt65wOf_upopg@mail.gmail.com>
References: <20180719010107.22363-1-saeedm@mellanox.com> <20180719010107.22363-11-saeedm@mellanox.com>
 <20180718184947.6e472ee4@cakuba.netronome.com> <575e4a3a-af6f-aac4-fed6-fd4dad387105@mellanox.com>
 <20180724125135.19121f1f@cakuba.netronome.com> <98071d31-bf99-d713-7fd1-4b1cc156377e@mellanox.com>
 <CAKgT0UfG-4zuKArCbSLkZoCKs2-t6r9U4qQPPUvBk-e_5_3FCg@mail.gmail.com>
 <20180725174359.6952c937@cakuba.netronome.com> <20180726071433.GA2222@nanopsycho>
 <CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com>
 <20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com> <CALBF4T81ArTWR_i6SogC4qe8xPf3WYvdrSkypXt65wOf_upopg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 29 Jul 2018 15:00:28 -0700
Message-ID: <CAKgT0UfkBQKqy87BcnQvfzrbonR5rm9cd3Q2dzsyR04vY-+FWg@mail.gmail.com>
Subject: Re: [net-next 10/16] net/mlx5: Support PCIe buffer congestion
 handling via Devlink
To: Moshe Shemesh <moshes20.il@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <jakub.kicinski@netronome.com>, Eran Ben Elisha <eranbe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2018 at 2:23 AM, Moshe Shemesh <moshes20.il@gmail.com> wrote:
>
>
> On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyck wrote:
>> > On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > Thu, Jul 26, 2018 at 02:43:59AM CEST, jakub.kicinski@netronome.com
>> > > wrote:
>> > >>On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:
>> > >>> On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:
>> > >>> > On 7/24/2018 10:51 PM, Jakub Kicinski wrote:
>> > >>> >>>> The devlink params haven't been upstream even for a full cycle
>> > >>> >>>> and
>> > >>> >>>> already you guys are starting to use them to configure standard
>> > >>> >>>> features like queuing.
>> > >>> >>>
>> > >>> >>> We developed the devlink params in order to support non-standard
>> > >>> >>> configuration only. And for non-standard, there are generic and
>> > >>> >>> vendor
>> > >>> >>> specific options.
>> > >>> >>
>> > >>> >> I thought it was developed for performing non-standard and
>> > >>> >> possibly
>> > >>> >> vendor specific configuration.  Look at DEVLINK_PARAM_GENERIC_*
>> > >>> >> for
>> > >>> >> examples of well justified generic options for which we have no
>> > >>> >> other API.  The vendor mlx4 options look fairly vendor specific
>> > >>> >> if you
>> > >>> >> ask me, too.
>> > >>> >>
>> > >>> >> Configuring queuing has an API.  The question is it acceptable to
>> > >>> >> enter
>> > >>> >> into the risky territory of controlling offloads via devlink
>> > >>> >> parameters
>> > >>> >> or would we rather make vendors take the time and effort to model
>> > >>> >> things to (a subset) of existing APIs.  The HW never fits the
>> > >>> >> APIs
>> > >>> >> perfectly.
>> > >>> >
>> > >>> > I understand what you meant here, I would like to highlight that
>> > >>> > this
>> > >>> > mechanism was not meant to handle SRIOV, Representors, etc.
>> > >>> > The vendor specific configuration suggested here is to handle a
>> > >>> > congestion
>> > >>> > state in Multi Host environment (which includes PF and multiple
>> > >>> > VFs per
>> > >>> > host), where one host is not aware to the other hosts, and each is
>> > >>> > running
>> > >>> > on its own pci/driver. It is a device working mode configuration.
>> > >>> >
>> > >>> > This  couldn't fit into any existing API, thus creating this
>> > >>> > vendor specific
>> > >>> > unique API is needed.
>> > >>>
>> > >>> If we are just going to start creating devlink interfaces in for
>> > >>> every
>> > >>> one-off option a device wants to add why did we even bother with
>> > >>> trying to prevent drivers from using sysfs? This just feels like we
>> > >>> are back to the same arguments we had back in the day with it.
>> > >>>
>> > >>> I feel like the bigger question here is if devlink is how we are
>> > >>> going
>> > >>> to deal with all PCIe related features going forward, or should we
>> > >>> start looking at creating a new interface/tool for PCI/PCIe related
>> > >>> features? My concern is that we have already had features such as
>> > >>> DMA
>> > >>> Coalescing that didn't really fit into anything and now we are
>> > >>> starting to see other things related to DMA and PCIe bus credits.
>> > >>> I'm
>> > >>> wondering if we shouldn't start looking at a tool/interface to
>> > >>> configure all the PCIe related features such as interrupts, error
>> > >>> reporting, DMA configuration, power management, etc. Maybe we could
>> > >>> even look at sharing it across subsystems and include things like
>> > >>> storage, graphics, and other subsystems in the conversation.
>> > >>
>> > >>Agreed, for actual PCIe configuration (i.e. not ECN marking) we do
>> > >> need
>> > >>to build up an API.  Sharing it across subsystems would be very cool!
>>
>> I read the thread (starting at [1], for anybody else coming in late)
>> and I see this has something to do with "configuring outbound PCIe
>> buffers", but I haven't seen the connection to PCIe protocol or
>> features, i.e., I can't connect this to anything in the PCIe spec.
>>
>> Can somebody help me understand how the PCI core is relevant?  If
>> there's some connection with a feature defined by PCIe, or if it
>> affects the PCIe transaction protocol somehow, I'm definitely
>> interested in this.  But if this only affects the data transferred
>> over PCIe, i.e., the data payloads of PCIe TLP packets, then I'm not
>> sure why the PCI core should care.
>>
>
>
> As you wrote, this is not a PCIe feature  or affects the PCIe transaction
> protocol.
>
> Actually, due to hardware limitation in current device, we have enabled a
> workaround in hardware.
>
> This mode is proprietary and not relevant to other PCIe devices, thus is set
> using driver-specific parameter in devlink

Essentially what this feature is doing is communicating the need for
PCIe back-pressure to the network fabric. So as the buffers on the
device start to fill because the device isn't able to get back PCIe
credits fast enough it will then start to send congestion
notifications to the network stack itself if I understand this
correctly.

For now there are no major conflicts, but when we start getting into
stuff like PCIe DMA coalescing, and on a more general basis just PCIe
active state power management that is going to start making things
more complicated going forward.

I assume the devices we are talking about supporting this new feature
on either don't deal with ASPM or assume a quick turnaround to get out
of the lower power states? Otherwise that would definitely cause some
back-pressure buildups that would hurt performance.

- Alex
