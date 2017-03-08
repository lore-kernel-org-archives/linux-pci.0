Return-Path: <SRS0=Ttk3=2R=google.com=rajatja@kernel.org>
Return-Path: <SRS0=Ttk3=2R=google.com=rajatja@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170308223938.GA28050@bhelgaas-glaptop.roam.corp.google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
 <1483425255-101923-6-git-send-email-rajatja@google.com> <58C05114.5030202@arm.com>
 <20170308223938.GA28050@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 8 Mar 2017 15:08:59 -0800
Message-ID: <CACK8Z6H7V=dM71LuUh7653qnLXJmGCNVcm3cG4_s4hwQKe58aA@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI/ASPM: Actually configure the L1 substate settings
 to the device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: James Morse <james.morse@arm.com>, Rajat Jain <rajatxjain@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Keith Busch <keith.busch@intel.com>,
	Andreas Ziegler <andreas.ziegler@fau.de>, Jonathan Yong <jonathan.yong@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, David Daney <david.daney@cavium.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>, Ram Amrani <Ram.Amrani@cavium.com>,
	Doug Ledford <dledford@redhat.com>, Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Brian Norris <briannorris@google.com>
Content-Type: multipart/alternative; boundary=001a114fb0501f7c4a054a403968
List-ID: <linux-pci.vger.kernel.org>

--001a114fb0501f7c4a054a403968
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 8, 2017 at 2:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Hi James,
>
> On Wed, Mar 08, 2017 at 06:44:36PM +0000, James Morse wrote:
> > Hi!
> >
> > On 03/01/17 06:34, Rajat Jain wrote:
> > > Add code to actually configure the L1 substate settigns on the
> > > upstream and downstream device, while taking care of the rules
> > > dictated by the PCIe spec.
> >
> > While testing hibernate on an arm64 juno with v4.11-rc1, I get a NULL
> pointer
> > dereference from pcie_config_aspm_link():
> >
> >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a70afdf..6735f38 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -597,11 +683,23 @@ static void pcie_config_aspm_dev(struct pci_dev
> *pdev, u32 val)
> > >  static void pcie_config_aspm_link(struct pcie_link_state *link, u32
> state)
> > >  {
> > >     u32 upstream = 0, dwstream = 0;
> > > -   struct pci_dev *child, *parent = link->pdev;
> > > +   struct pci_dev *child = link->downstream, *parent = link->pdev;
> >
> >
> > Here link->downstream is NULL,
>
> Sorry about the breakage.  Can you try also cherry-picking this
> commit:
>
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.
> git/commit/?h=for-linus&id=3bd7db63a841e8c5297bb18ad801df67d5e38ad2
>
> Yinghai tripped over a similar problem in a different way, but I
> suspect his fix might also fix the problem you're seeing.
>

Yes, I think that should fix it.

Sorry for the breakage, can you please let me know if it doesn't fix it for
you.

Rajat


>
> If that doesn't fix it, we'll have to look farther.
>
> I'm planning to ask Linus to pull this fix for v4.11-rc2.
>
> Bjorn
>

--001a114fb0501f7c4a054a403968
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Mar 8, 2017 at 2:39 PM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a =
href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi James,<br>
<br>
On Wed, Mar 08, 2017 at 06:44:36PM +0000, James Morse wrote:<br>
&gt; Hi!<br>
<span class=3D"">&gt;<br>
&gt; On 03/01/17 06:34, Rajat Jain wrote:<br>
&gt; &gt; Add code to actually configure the L1 substate settigns on the<br=
>
&gt; &gt; upstream and downstream device, while taking care of the rules<br=
>
&gt; &gt; dictated by the PCIe spec.<br>
&gt;<br>
</span>&gt; While testing hibernate on an arm64 juno with v4.11-rc1, I get =
a NULL pointer<br>
&gt; dereference from pcie_config_aspm_link():<br>
<span class=3D"">&gt;<br>
&gt;<br>
&gt; &gt; diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c<br=
>
&gt; &gt; index a70afdf..6735f38 100644<br>
&gt; &gt; --- a/drivers/pci/pcie/aspm.c<br>
&gt; &gt; +++ b/drivers/pci/pcie/aspm.c<br>
</span><span class=3D"">&gt; &gt; @@ -597,11 +683,23 @@ static void pcie_co=
nfig_aspm_dev(struct pci_dev *pdev, u32 val)<br>
&gt; &gt;=C2=A0 static void pcie_config_aspm_link(struct pcie_link_state *l=
ink, u32 state)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0u32 upstream =3D 0, dwstream =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0struct pci_dev *child, *parent =3D link-&gt;pdev;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0struct pci_dev *child =3D link-&gt;downstream, *par=
ent =3D link-&gt;pdev;<br>
&gt;<br>
&gt;<br>
</span>&gt; Here link-&gt;downstream is NULL,<br>
<br>
Sorry about the breakage.=C2=A0 Can you try also cherry-picking this<br>
commit:<br>
<br>
<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/com=
mit/?h=3Dfor-linus&amp;id=3D3bd7db63a841e8c5297bb18ad801df67d5e38ad2" rel=
=3D"noreferrer" target=3D"_blank">https://git.kernel.org/cgit/<wbr>linux/ke=
rnel/git/helgaas/pci.<wbr>git/commit/?h=3Dfor-linus&amp;id=3D<wbr>3bd7db63a=
841e8c5297bb18ad801df<wbr>67d5e38ad2</a><br>
<br>
Yinghai tripped over a similar problem in a different way, but I<br>
suspect his fix might also fix the problem you&#39;re seeing.<br></blockquo=
te><div><br></div><div>Yes, I think that should fix it.</div><div><br></div=
><div>Sorry for the breakage, can you please let me know if it doesn&#39;t =
fix it for you.</div><div><br></div><div>Rajat</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
If that doesn&#39;t fix it, we&#39;ll have to look farther.<br>
<br>
I&#39;m planning to ask Linus to pull this fix for v4.11-rc2.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Bjorn<br>
</font></span></blockquote></div><br></div></div>

--001a114fb0501f7c4a054a403968--
