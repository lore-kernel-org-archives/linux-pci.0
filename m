Return-Path: <SRS0=r6kx=KN=gmail.com=moshes20.il@kernel.org>
Return-Path: <SRS0=r6kx=KN=gmail.com=moshes20.il@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180719010107.22363-1-saeedm@mellanox.com> <20180719010107.22363-11-saeedm@mellanox.com>
 <20180718184947.6e472ee4@cakuba.netronome.com> <575e4a3a-af6f-aac4-fed6-fd4dad387105@mellanox.com>
 <20180724125135.19121f1f@cakuba.netronome.com> <98071d31-bf99-d713-7fd1-4b1cc156377e@mellanox.com>
 <CAKgT0UfG-4zuKArCbSLkZoCKs2-t6r9U4qQPPUvBk-e_5_3FCg@mail.gmail.com>
 <20180725174359.6952c937@cakuba.netronome.com> <20180726071433.GA2222@nanopsycho>
 <CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com> <20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com>
From: Moshe Shemesh <moshes20.il@gmail.com>
Date: Sun, 29 Jul 2018 12:23:38 +0300
Message-ID: <CALBF4T81ArTWR_i6SogC4qe8xPf3WYvdrSkypXt65wOf_upopg@mail.gmail.com>
Subject: Re: [net-next 10/16] net/mlx5: Support PCIe buffer congestion
 handling via Devlink
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <jakub.kicinski@netronome.com>, Eran Ben Elisha <eranbe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000723c1a05721fe6c7"
List-ID: <linux-pci.vger.kernel.org>

--000000000000723c1a05721fe6c7
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyck wrote:
> > On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> > > Thu, Jul 26, 2018 at 02:43:59AM CEST, jakub.kicinski@netronome.com
> wrote:
> > >>On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:
> > >>> On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:
> > >>> > On 7/24/2018 10:51 PM, Jakub Kicinski wrote:
> > >>> >>>> The devlink params haven't been upstream even for a full cycle
> and
> > >>> >>>> already you guys are starting to use them to configure standard
> > >>> >>>> features like queuing.
> > >>> >>>
> > >>> >>> We developed the devlink params in order to support non-standard
> > >>> >>> configuration only. And for non-standard, there are generic and
> vendor
> > >>> >>> specific options.
> > >>> >>
> > >>> >> I thought it was developed for performing non-standard and
> possibly
> > >>> >> vendor specific configuration.  Look at DEVLINK_PARAM_GENERIC_*
> for
> > >>> >> examples of well justified generic options for which we have no
> > >>> >> other API.  The vendor mlx4 options look fairly vendor specific
> if you
> > >>> >> ask me, too.
> > >>> >>
> > >>> >> Configuring queuing has an API.  The question is it acceptable to
> enter
> > >>> >> into the risky territory of controlling offloads via devlink
> parameters
> > >>> >> or would we rather make vendors take the time and effort to model
> > >>> >> things to (a subset) of existing APIs.  The HW never fits the APIs
> > >>> >> perfectly.
> > >>> >
> > >>> > I understand what you meant here, I would like to highlight that
> this
> > >>> > mechanism was not meant to handle SRIOV, Representors, etc.
> > >>> > The vendor specific configuration suggested here is to handle a
> congestion
> > >>> > state in Multi Host environment (which includes PF and multiple
> VFs per
> > >>> > host), where one host is not aware to the other hosts, and each is
> running
> > >>> > on its own pci/driver. It is a device working mode configuration.
> > >>> >
> > >>> > This  couldn't fit into any existing API, thus creating this
> vendor specific
> > >>> > unique API is needed.
> > >>>
> > >>> If we are just going to start creating devlink interfaces in for
> every
> > >>> one-off option a device wants to add why did we even bother with
> > >>> trying to prevent drivers from using sysfs? This just feels like we
> > >>> are back to the same arguments we had back in the day with it.
> > >>>
> > >>> I feel like the bigger question here is if devlink is how we are
> going
> > >>> to deal with all PCIe related features going forward, or should we
> > >>> start looking at creating a new interface/tool for PCI/PCIe related
> > >>> features? My concern is that we have already had features such as DMA
> > >>> Coalescing that didn't really fit into anything and now we are
> > >>> starting to see other things related to DMA and PCIe bus credits. I'm
> > >>> wondering if we shouldn't start looking at a tool/interface to
> > >>> configure all the PCIe related features such as interrupts, error
> > >>> reporting, DMA configuration, power management, etc. Maybe we could
> > >>> even look at sharing it across subsystems and include things like
> > >>> storage, graphics, and other subsystems in the conversation.
> > >>
> > >>Agreed, for actual PCIe configuration (i.e. not ECN marking) we do need
> > >>to build up an API.  Sharing it across subsystems would be very cool!
>
> I read the thread (starting at [1], for anybody else coming in late)
> and I see this has something to do with "configuring outbound PCIe
> buffers", but I haven't seen the connection to PCIe protocol or
> features, i.e., I can't connect this to anything in the PCIe spec.
>
> Can somebody help me understand how the PCI core is relevant?  If
> there's some connection with a feature defined by PCIe, or if it
> affects the PCIe transaction protocol somehow, I'm definitely
> interested in this.  But if this only affects the data transferred
> over PCIe, i.e., the data payloads of PCIe TLP packets, then I'm not
> sure why the PCI core should care.
>
>

As you wrote, this is not a PCIe feature  or affects the PCIe transaction
protocol.

Actually, due to hardware limitation in current device, we have enabled a
workaround in hardware.

This mode is proprietary and not relevant to other PCIe devices, thus is
set using driver-specific parameter in devlink

> > I wonder howcome there isn't such API in place already. Or is it?
> > > If it is not, do you have any idea how should it look like? Should it
> be
> > > an extension of the existing PCI uapi or something completely new?
> > > It would be probably good to loop some PCI people in...
> >
> > The closest thing I can think of in terms of answering your questions
> > as to why we haven't seen anything like that would be setpci.
> > Basically with that tool you can go through the PCI configuration
> > space and update any piece you want. The problem is it can have
> > effects on the driver and I don't recall there ever being any sort of
> > notification mechanism added to make a driver aware of configuration
> > updates.
>
> setpci is a development and debugging tool, not something we should
> use as the standard way of configuring things.  Use of setpci should
> probably taint the kernel because the PCI core configures features
> like MPS, ASPM, AER, etc., based on the assumption that nobody else is
> changing things in PCI config space.
>
> > As far as the interface I don't know if we would want to use something
> > like netlink or look at something completely new.
> >
> > I've gone ahead and added the linux-pci mailing list to the thread.
> >
> > - Alex
>
> [1] https://lkml.kernel.org/r/20180719010107.22363-11-saeedm@mellanox.com
>

--000000000000723c1a05721fe6c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Jul 28, 2018 at 7:06 PM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"=
><div class=3D"h5">On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyc=
k wrote:<br>
&gt; On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko &lt;<a href=3D"mailto:jir=
i@resnulli.us">jiri@resnulli.us</a>&gt; wrote:<br>
&gt; &gt; Thu, Jul 26, 2018 at 02:43:59AM CEST, <a href=3D"mailto:jakub.kic=
inski@netronome.com">jakub.kicinski@netronome.com</a> wrote:<br>
&gt; &gt;&gt;On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:<br>
&gt; &gt;&gt;&gt; On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:<b=
r>
&gt; &gt;&gt;&gt; &gt; On 7/24/2018 10:51 PM, Jakub Kicinski wrote:<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; The devlink params haven&#39;t been upst=
ream even for a full cycle and<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; already you guys are starting to use the=
m to configure standard<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;&gt; features like queuing.<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; We developed the devlink params in order to =
support non-standard<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; configuration only. And for non-standard, th=
ere are generic and vendor<br>
&gt; &gt;&gt;&gt; &gt;&gt;&gt; specific options.<br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt; I thought it was developed for performing non-st=
andard and possibly<br>
&gt; &gt;&gt;&gt; &gt;&gt; vendor specific configuration.=C2=A0 Look at DEV=
LINK_PARAM_GENERIC_* for<br>
&gt; &gt;&gt;&gt; &gt;&gt; examples of well justified generic options for w=
hich we have no<br>
&gt; &gt;&gt;&gt; &gt;&gt; other API.=C2=A0 The vendor mlx4 options look fa=
irly vendor specific if you<br>
&gt; &gt;&gt;&gt; &gt;&gt; ask me, too.<br>
&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; &gt;&gt; Configuring queuing has an API.=C2=A0 The questi=
on is it acceptable to enter<br>
&gt; &gt;&gt;&gt; &gt;&gt; into the risky territory of controlling offloads=
 via devlink parameters<br>
&gt; &gt;&gt;&gt; &gt;&gt; or would we rather make vendors take the time an=
d effort to model<br>
&gt; &gt;&gt;&gt; &gt;&gt; things to (a subset) of existing APIs.=C2=A0 The=
 HW never fits the APIs<br>
&gt; &gt;&gt;&gt; &gt;&gt; perfectly.<br>
&gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt;&gt; &gt; I understand what you meant here, I would like to hi=
ghlight that this<br>
&gt; &gt;&gt;&gt; &gt; mechanism was not meant to handle SRIOV, Representor=
s, etc.<br>
&gt; &gt;&gt;&gt; &gt; The vendor specific configuration suggested here is =
to handle a congestion<br>
&gt; &gt;&gt;&gt; &gt; state in Multi Host environment (which includes PF a=
nd multiple VFs per<br>
&gt; &gt;&gt;&gt; &gt; host), where one host is not aware to the other host=
s, and each is running<br>
&gt; &gt;&gt;&gt; &gt; on its own pci/driver. It is a device working mode c=
onfiguration.<br>
&gt; &gt;&gt;&gt; &gt;<br>
&gt; &gt;&gt;&gt; &gt; This=C2=A0 couldn&#39;t fit into any existing API, t=
hus creating this vendor specific<br>
&gt; &gt;&gt;&gt; &gt; unique API is needed.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; If we are just going to start creating devlink interfaces=
 in for every<br>
&gt; &gt;&gt;&gt; one-off option a device wants to add why did we even both=
er with<br>
&gt; &gt;&gt;&gt; trying to prevent drivers from using sysfs? This just fee=
ls like we<br>
&gt; &gt;&gt;&gt; are back to the same arguments we had back in the day wit=
h it.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I feel like the bigger question here is if devlink is how=
 we are going<br>
&gt; &gt;&gt;&gt; to deal with all PCIe related features going forward, or =
should we<br>
&gt; &gt;&gt;&gt; start looking at creating a new interface/tool for PCI/PC=
Ie related<br>
&gt; &gt;&gt;&gt; features? My concern is that we have already had features=
 such as DMA<br>
&gt; &gt;&gt;&gt; Coalescing that didn&#39;t really fit into anything and n=
ow we are<br>
&gt; &gt;&gt;&gt; starting to see other things related to DMA and PCIe bus =
credits. I&#39;m<br>
&gt; &gt;&gt;&gt; wondering if we shouldn&#39;t start looking at a tool/int=
erface to<br>
&gt; &gt;&gt;&gt; configure all the PCIe related features such as interrupt=
s, error<br>
&gt; &gt;&gt;&gt; reporting, DMA configuration, power management, etc. Mayb=
e we could<br>
&gt; &gt;&gt;&gt; even look at sharing it across subsystems and include thi=
ngs like<br>
&gt; &gt;&gt;&gt; storage, graphics, and other subsystems in the conversati=
on.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;Agreed, for actual PCIe configuration (i.e. not ECN marking) w=
e do need<br>
&gt; &gt;&gt;to build up an API.=C2=A0 Sharing it across subsystems would b=
e very cool!<br>
<br>
</div></div>I read the thread (starting at [1], for anybody else coming in =
late)<br>
and I see this has something to do with &quot;configuring outbound PCIe<br>
buffers&quot;, but I haven&#39;t seen the connection to PCIe protocol or<br=
>
features, i.e., I can&#39;t connect this to anything in the PCIe spec.<br>
<br>
Can somebody help me understand how the PCI core is relevant?=C2=A0 If<br>
there&#39;s some connection with a feature defined by PCIe, or if it<br>
affects the PCIe transaction protocol somehow, I&#39;m definitely<br>
interested in this.=C2=A0 But if this only affects the data transferred<br>
over PCIe, i.e., the data payloads of PCIe TLP packets, then I&#39;m not<br=
>
sure why the PCI core should care.<br>
<span class=3D""><br></span></blockquote><div>=C2=A0









<p style=3D"margin:0in;font-family:Calibri;font-size:11pt">As
you wrote, this is not a PCIe feature<span>=C2=A0 </span>or
affects the PCIe transaction protocol.</p><p style=3D"margin:0in;font-famil=
y:Calibri;font-size:11pt">









</p><p style=3D"margin:0in">Actually,
due to hardware limitation in current device, we have enabled a workaround =
in
hardware.=C2=A0</p><p style=3D"margin:0in">This mode is proprietary and not=
 relevant to other PCIe devices, thus
is set using driver-specific parameter in devlink</p>




<br><p></p>




</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt; &gt; I wonder howcome there isn&#39;t such API in place already. Or is=
 it?<br>
&gt; &gt; If it is not, do you have any idea how should it look like? Shoul=
d it be<br>
&gt; &gt; an extension of the existing PCI uapi or something completely new=
?<br>
&gt; &gt; It would be probably good to loop some PCI people in...<br>
&gt; <br>
&gt; The closest thing I can think of in terms of answering your questions<=
br>
&gt; as to why we haven&#39;t seen anything like that would be setpci.<br>
&gt; Basically with that tool you can go through the PCI configuration<br>
&gt; space and update any piece you want. The problem is it can have<br>
&gt; effects on the driver and I don&#39;t recall there ever being any sort=
 of<br>
&gt; notification mechanism added to make a driver aware of configuration<b=
r>
&gt; updates.<br>
<br>
</span>setpci is a development and debugging tool, not something we should<=
br>
use as the standard way of configuring things.=C2=A0 Use of setpci should<b=
r>
probably taint the kernel because the PCI core configures features<br>
like MPS, ASPM, AER, etc., based on the assumption that nobody else is<br>
changing things in PCI config space.<br>
<span class=3D""><br>
&gt; As far as the interface I don&#39;t know if we would want to use somet=
hing<br>
&gt; like netlink or look at something completely new.<br>
&gt; <br>
&gt; I&#39;ve gone ahead and added the linux-pci mailing list to the thread=
.<br>
&gt; <br>
&gt; - Alex<br>
<br>
</span>[1] <a href=3D"https://lkml.kernel.org/r/20180719010107.22363-11-sae=
edm@mellanox.com" rel=3D"noreferrer" target=3D"_blank">https://lkml.kernel.=
org/r/<wbr>20180719010107.22363-11-<wbr>saeedm@mellanox.com</a><br>
</blockquote></div><br></div></div>

--000000000000723c1a05721fe6c7--
