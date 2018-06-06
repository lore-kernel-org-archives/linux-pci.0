Return-Path: <SRS0=fxO/=IY=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=fxO/=IY=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com> <B01FA80E1422A647BEB597328C544223D30B8F90@RTITMBSV05.realtek.com.tw>
 <20180605172805.GD30381@bhelgaas-glaptop.roam.corp.google.com> <C2132983-62FC-4099-892D-DD9E5F6587FC@canonical.com>
In-Reply-To: <C2132983-62FC-4099-892D-DD9E5F6587FC@canonical.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 Jun 2018 08:25:09 -0500
Message-ID: <CAErSpo5fM2mbRX-i51mMj5gmxw1YV-baGYO9rEFD_vK-=qfmzQ@mail.gmail.com>
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ryankao@realtek.com, jrg.otte@gmail.com,
	David Miller <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Francois Romieu <romieu@fr.zoreil.com>,
	netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hau@realtek.com, linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000048118f056df9191e"
List-ID: <linux-pci.vger.kernel.org>

--00000000000048118f056df9191e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+cc linux-pci]

On Wed, Jun 6, 2018 at 2:00 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi, Bjorn,
>
> at 01:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:
> >> Add realtek folk Hau
> >>
> >> -----Original Message-----
> >> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com]
> >> Sent: Tuesday, June 05, 2018 1:02 PM
> >> To: jrg.otte@gmail.com
> >> Cc: David Miller <davem@davemloft.net>; Hayes Wang
> >> <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com;
> >> Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List
> >> <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
> >> Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
> >>
> >> Hi J=C3=B6rg Otte,
> >>
> >> Can you give this patch a try?
> >>
> >> Since you are the only one that reported ALDPS/ASPM regression,
> >>
> >> And I think this patch should solve the issue you had [1].
> >>
> >> Hopefully we don't need to go down the rabbit hole of
> >> blacklist/whitelist...
> >>
> >> Kai-Heng
> >>
> >> [1] https://lkml.org/lkml/2013/1/5/36
> >
> > I have no idea what ALDPS is.  It's not mentioned in the PCIe spec, so
> > presumably it's some Realtek-specific thing.  ASPM is a generic PCIe
> > thing.  Changes to these two things should be in separate patches so
> > they don't get tangled up.
>
> Sure, I'll split them in two. I'll also consult with Realtek to explain
> what ALDPS actually does.
>
> >
> >>> On Jun 5, 2018, at 12:58 PM, Kai-Heng Feng
> >>> <kai.heng.feng@canonical.com>
> >>> wrote:

> >>> +static void rtl8169_check_link_status(struct net_device *dev,
> >>> +                                 struct rtl8169_private *tp) {
> >>> +   struct device *d =3D tp_to_dev(tp);
> >>> +
> >>> +   if (tp->link_ok(tp)) {
> >>> +           rtl_link_chg_patch(tp);
> >>> +           /* This is to cancel a scheduled suspend if there's one.
*/
> >>> +           if (pm_request_resume(d))
> >>> +                   _rtl_reset_work(tp);
> >>> +           netif_carrier_on(dev);
> >>> +           if (net_ratelimit())
> >>> +                   netif_info(tp, ifup, dev, "link up\n");
> >>> +   } else {
> >>> +           netif_carrier_off(dev);
> >>> +           netif_info(tp, ifdown, dev, "link down\n");
> >>> +           pm_runtime_idle(d);
> >>> +   }
> >>> +}
> >
> > This function apparently just got moved around without changing
> > anything.  That's fine, but the move should be in a separate patch to
> > make the real changes easier to review.
>
> It actually added a new condition to check the return value of
> pm_request_resume().

Hah, I missed that :)  That's even a better reason to split it to a
separate patch, so others don't miss it.

> >>> @@ -7649,8 +7757,12 @@ static int rtl_init_one(struct pci_dev *pdev,
> >>> const struct pci_device_id *ent)
> >>>
> >>>     /* disable ASPM completely as that cause random device stop
working
> >>>      * problems as well as full system hangs for some PCIe devices
users */
> >>> -   pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
PCIE_LINK_STATE_L1 |
> >>> -                                PCIE_LINK_STATE_CLKPM);
> >>> +   if (!enable_aspm) {
> >>> +           pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
> >>> +                                        PCIE_LINK_STATE_L1 |
> >>> +                                        PCIE_LINK_STATE_CLKPM);
> >>> +           netif_info(tp, probe, dev, "ASPM disabled\n");
> >>> +   }
> >
> > ASPM is a generic PCIe feature that should be configured by the PCI
> > core without any help from the device driver.
> >
> > If code in the driver is needed, that means either the PCI core is
> > doing it wrong and we should fix it there, or the device is broken and
> > the driver is working around the erratum.
> >
> > If this is an erratum, you should include details about exactly what's
> > broken and (ideally) a URL to the published erratum.  Otherwise this
> > is just unmaintainable black magic and likely to be broken by future
> > ASPM changes in the PCI core.
> >
> > ASPM configuration is done by the PCI core before drivers are bound to
> > the device.  If you need device-specific workarounds, they should
> > probably be in quirks so they're done before the core does that ASPM
> > configuration.
>
> You are right.
>
> I think calling pci_disable_link_state() is unnecessary, I'll also consul=
t
> with Realtek about this.
>
> I'll also do some testing and send a separate patch to remove
> pci_disable_link_state() for -rc kernel to test if this is something
really
> needed.

Great, thanks!  Would you mind copying linux-pci@vger.kernel.org
when/if you post an update?  The ASPM parts are of interest there.


On Wed, Jun 6, 2018 at 2:00 AM Kai-Heng Feng <kai.heng.feng@canonical.com>
wrote:

> Hi, Bjorn,
>
> at 01:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:
> >> Add realtek folk Hau
> >>
> >> -----Original Message-----
> >> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com]
> >> Sent: Tuesday, June 05, 2018 1:02 PM
> >> To: jrg.otte@gmail.com
> >> Cc: David Miller <davem@davemloft.net>; Hayes Wang
> >> <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com;
> >> Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List
> >> <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
> >> Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
> >>
> >> Hi J=C3=B6rg Otte,
> >>
> >> Can you give this patch a try?
> >>
> >> Since you are the only one that reported ALDPS/ASPM regression,
> >>
> >> And I think this patch should solve the issue you had [1].
> >>
> >> Hopefully we don't need to go down the rabbit hole of
> >> blacklist/whitelist...
> >>
> >> Kai-Heng
> >>
> >> [1] https://lkml.org/lkml/2013/1/5/36
> >
> > I have no idea what ALDPS is.  It's not mentioned in the PCIe spec, so
> > presumably it's some Realtek-specific thing.  ASPM is a generic PCIe
> > thing.  Changes to these two things should be in separate patches so
> > they don't get tangled up.
>
> Sure, I'll split them in two. I'll also consult with Realtek to explain
> what ALDPS actually does.
>
> >
> >>> On Jun 5, 2018, at 12:58 PM, Kai-Heng Feng
> >>> <kai.heng.feng@canonical.com>
> >>> wrote:
> >>>
> >>> This patch reinstate ALDPS and ASPM support on r8169.
> >>>
> >>> On some Intel platforms, ASPM support on r8169 is the key factor to
> >>> let Package C-State achieve PC8. Without ASPM support, the deepest
> >>> Package C-State can hit is PC3. PC8 can save additional ~3W in
> >>> comparison with PC3.
> >>>
> >>> This patch is from Realtek.
> >>>
> >>> Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
> >>> Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request
> >>> settings")
> >
> >>> +3507,15 @@ static void rtl8168e_1_hw_phy_config(struct
> >>> rtl8169_private *tp)
> >>>     rtl_writephy(tp, 0x0d, 0x4007);
> >>>     rtl_writephy(tp, 0x0e, 0x0000);
> >>>     rtl_writephy(tp, 0x0d, 0x0000);
> >>> +
> >>> +   /* Check ALDPS bit, disable it if enabled */
> >>> +   rtl_writephy(tp, 0x1f, 0x0000);
> >>> +   if (enable_aldps)
> >>> +           rtl_w0w1_phy(tp, 0x15, 0x1000, 0x0000);
> >>> +   else if (rtl_readphy(tp, 0x15) & 0x1000)
> >>> +           rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1000);
> >
> > There's a lot of repetition of this code with minor variations.  You
> > could probably factor it out and make it more concise and more
> > readable.
>
> You are right. Will do.
>
> >
> >>> +static void rtl8169_check_link_status(struct net_device *dev,
> >>> +                                 struct rtl8169_private *tp) {
> >>> +   struct device *d =3D tp_to_dev(tp);
> >>> +
> >>> +   if (tp->link_ok(tp)) {
> >>> +           rtl_link_chg_patch(tp);
> >>> +           /* This is to cancel a scheduled suspend if there's one. =
*/
> >>> +           if (pm_request_resume(d))
> >>> +                   _rtl_reset_work(tp);
> >>> +           netif_carrier_on(dev);
> >>> +           if (net_ratelimit())
> >>> +                   netif_info(tp, ifup, dev, "link up\n");
> >>> +   } else {
> >>> +           netif_carrier_off(dev);
> >>> +           netif_info(tp, ifdown, dev, "link down\n");
> >>> +           pm_runtime_idle(d);
> >>> +   }
> >>> +}
> >
> > This function apparently just got moved around without changing
> > anything.  That's fine, but the move should be in a separate patch to
> > make the real changes easier to review.
>
> It actually added a new condition to check the return value of
> pm_request_resume().
>
> It's probably a bogus check though. I'll ask Realtek why they did this.
>
> >
> >>> @@ -7649,8 +7757,12 @@ static int rtl_init_one(struct pci_dev *pdev,
> >>> const struct pci_device_id *ent)
> >>>
> >>>     /* disable ASPM completely as that cause random device stop worki=
ng
> >>>      * problems as well as full system hangs for some PCIe devices
> users */
> >>> -   pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
> PCIE_LINK_STATE_L1 |
> >>> -                                PCIE_LINK_STATE_CLKPM);
> >>> +   if (!enable_aspm) {
> >>> +           pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
> >>> +                                        PCIE_LINK_STATE_L1 |
> >>> +                                        PCIE_LINK_STATE_CLKPM);
> >>> +           netif_info(tp, probe, dev, "ASPM disabled\n");
> >>> +   }
> >
> > ASPM is a generic PCIe feature that should be configured by the PCI
> > core without any help from the device driver.
> >
> > If code in the driver is needed, that means either the PCI core is
> > doing it wrong and we should fix it there, or the device is broken and
> > the driver is working around the erratum.
> >
> > If this is an erratum, you should include details about exactly what's
> > broken and (ideally) a URL to the published erratum.  Otherwise this
> > is just unmaintainable black magic and likely to be broken by future
> > ASPM changes in the PCI core.
> >
> > ASPM configuration is done by the PCI core before drivers are bound to
> > the device.  If you need device-specific workarounds, they should
> > probably be in quirks so they're done before the core does that ASPM
> > configuration.
>
> You are right.
>
> I think calling pci_disable_link_state() is unnecessary, I'll also
> consult
> with Realtek about this.
>
> I'll also do some testing and send a separate patch to remove
> pci_disable_link_state() for -rc kernel to test if this is something
> really
> needed.
>
> Kai-Heng
>
> >
> >>> /* enable device (incl. PCI PM wakeup and hotplug setup) */
> >>>     rc =3D pcim_enable_device(pdev);
> >>> --
> >>> 2.17.0
> >>
> >> ------Please consider the environment before printing this e-mail.
>
>
>

--00000000000048118f056df9191e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[+cc linux-pci]<br><br>On Wed, Jun 6, 2018 at 2:00 AM Kai-=
Heng Feng<br>&lt;<a href=3D"mailto:kai.heng.feng@canonical.com">kai.heng.fe=
ng@canonical.com</a>&gt; wrote:<br>&gt;<br>&gt; Hi, Bjorn,<br>&gt;<br>&gt; =
at 01:28, Bjorn Helgaas &lt;<a href=3D"mailto:helgaas@kernel.org">helgaas@k=
ernel.org</a>&gt; wrote:<br>&gt;<br>&gt; &gt; On Tue, Jun 05, 2018 at 06:34=
:09AM +0000, Ryankao wrote:<br>&gt; &gt;&gt; Add realtek folk Hau<br>&gt; &=
gt;&gt;<br>&gt; &gt;&gt; -----Original Message-----<br>&gt; &gt;&gt; From: =
Kai Heng Feng [mailto:<a href=3D"mailto:kai.heng.feng@canonical.com">kai.he=
ng.feng@canonical.com</a>]<br>&gt; &gt;&gt; Sent: Tuesday, June 05, 2018 1:=
02 PM<br>&gt; &gt;&gt; To: <a href=3D"mailto:jrg.otte@gmail.com">jrg.otte@g=
mail.com</a><br>&gt; &gt;&gt; Cc: David Miller &lt;<a href=3D"mailto:davem@=
davemloft.net">davem@davemloft.net</a>&gt;; Hayes Wang<br>&gt; &gt;&gt; &lt=
;<a href=3D"mailto:hayeswang@realtek.com">hayeswang@realtek.com</a>&gt;; <a=
 href=3D"mailto:hkallweit1@gmail.com">hkallweit1@gmail.com</a>; <a href=3D"=
mailto:romieu@fr.zoreil.com">romieu@fr.zoreil.com</a>;<br>&gt; &gt;&gt; Lin=
ux Netdev List &lt;<a href=3D"mailto:netdev@vger.kernel.org">netdev@vger.ke=
rnel.org</a>&gt;; Linux Kernel Mailing List<br>&gt; &gt;&gt; &lt;<a href=3D=
"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org</a>&gt;;=
 Ryankao &lt;<a href=3D"mailto:ryankao@realtek.com">ryankao@realtek.com</a>=
&gt;<br>&gt; &gt;&gt; Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM =
support<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Hi J=C3=B6rg Otte,<br>&gt; &gt;&g=
t;<br>&gt; &gt;&gt; Can you give this patch a try?<br>&gt; &gt;&gt;<br>&gt;=
 &gt;&gt; Since you are the only one that reported ALDPS/ASPM regression,<b=
r>&gt; &gt;&gt;<br>&gt; &gt;&gt; And I think this patch should solve the is=
sue you had [1].<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; Hopefully we don&#39;t n=
eed to go down the rabbit hole of<br>&gt; &gt;&gt; blacklist/whitelist...<b=
r>&gt; &gt;&gt;<br>&gt; &gt;&gt; Kai-Heng<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;=
 [1] <a href=3D"https://lkml.org/lkml/2013/1/5/36">https://lkml.org/lkml/20=
13/1/5/36</a><br>&gt; &gt;<br>&gt; &gt; I have no idea what ALDPS is.=C2=A0=
 It&#39;s not mentioned in the PCIe spec, so<br>&gt; &gt; presumably it&#39=
;s some Realtek-specific thing.=C2=A0 ASPM is a generic PCIe<br>&gt; &gt; t=
hing.=C2=A0 Changes to these two things should be in separate patches so<br=
>&gt; &gt; they don&#39;t get tangled up.<br>&gt;<br>&gt; Sure, I&#39;ll sp=
lit them in two. I&#39;ll also consult with Realtek to explain<br>&gt; what=
 ALDPS actually does.<br>&gt;<br>&gt; &gt;<br>&gt; &gt;&gt;&gt; On Jun 5, 2=
018, at 12:58 PM, Kai-Heng Feng<br>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:=
kai.heng.feng@canonical.com">kai.heng.feng@canonical.com</a>&gt;<br>&gt; &g=
t;&gt;&gt; wrote:<br><br>&gt; &gt;&gt;&gt; +static void rtl8169_check_link_=
status(struct net_device *dev,<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct rtl8169_private *tp) {<br>&gt; &gt;&gt;&gt; + =C2=
=A0 struct device *d =3D tp_to_dev(tp);<br>&gt; &gt;&gt;&gt; +<br>&gt; &gt;=
&gt;&gt; + =C2=A0 if (tp-&gt;link_ok(tp)) {<br>&gt; &gt;&gt;&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtl_link_chg_patch(tp);<br>&gt; &gt;&gt;&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This is to cancel a scheduled suspend=
 if there&#39;s one. */<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (pm_request_resume(d))<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _rtl_reset_work(tp);<br>&gt; =
&gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netif_carrier_on(dev);<br=
>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (net_ratelimit()=
)<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 netif_info(tp, ifup, dev, &quot;link up\n&quot;);<br>&gt; &gt=
;&gt;&gt; + =C2=A0 } else {<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 netif_carrier_off(dev);<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 netif_info(tp, ifdown, dev, &quot;link down\n&quot;);<br>=
&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_idle(d);<=
br>&gt; &gt;&gt;&gt; + =C2=A0 }<br>&gt; &gt;&gt;&gt; +}<br>&gt; &gt;<br>&gt=
; &gt; This function apparently just got moved around without changing<br>&=
gt; &gt; anything.=C2=A0 That&#39;s fine, but the move should be in a separ=
ate patch to<br>&gt; &gt; make the real changes easier to review.<br>&gt;<b=
r>&gt; It actually added a new condition to check the return value of<br>&g=
t; pm_request_resume().<br><br>Hah, I missed that :) =C2=A0That&#39;s even =
a better reason to split it to a<br>separate patch, so others don&#39;t mis=
s it.<br><br>&gt; &gt;&gt;&gt; @@ -7649,8 +7757,12 @@ static int rtl_init_o=
ne(struct pci_dev *pdev,<br>&gt; &gt;&gt;&gt; const struct pci_device_id *e=
nt)<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt; =C2=A0 =C2=A0 /* disable ASPM=
 completely as that cause random device stop working<br>&gt; &gt;&gt;&gt; =
=C2=A0 =C2=A0 =C2=A0* problems as well as full system hangs for some PCIe d=
evices users */<br>&gt; &gt;&gt;&gt; - =C2=A0 pci_disable_link_state(pdev, =
PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |<br>&gt; &gt;&gt;&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCIE_LINK_STATE_CLKPM);<br>&gt; &gt;&gt;&gt;=
 + =C2=A0 if (!enable_aspm) {<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |<br>&gt; &g=
t;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PCIE_LINK_STATE_L1 |<br>&gt; &gt;&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCIE_LINK_STATE_CLKPM);<br>&gt; &gt;&=
gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netif_info(tp, probe, dev, &qu=
ot;ASPM disabled\n&quot;);<br>&gt; &gt;&gt;&gt; + =C2=A0 }<br>&gt; &gt;<br>=
&gt; &gt; ASPM is a generic PCIe feature that should be configured by the P=
CI<br>&gt; &gt; core without any help from the device driver.<br>&gt; &gt;<=
br>&gt; &gt; If code in the driver is needed, that means either the PCI cor=
e is<br>&gt; &gt; doing it wrong and we should fix it there, or the device =
is broken and<br>&gt; &gt; the driver is working around the erratum.<br>&gt=
; &gt;<br>&gt; &gt; If this is an erratum, you should include details about=
 exactly what&#39;s<br>&gt; &gt; broken and (ideally) a URL to the publishe=
d erratum.=C2=A0 Otherwise this<br>&gt; &gt; is just unmaintainable black m=
agic and likely to be broken by future<br>&gt; &gt; ASPM changes in the PCI=
 core.<br>&gt; &gt;<br>&gt; &gt; ASPM configuration is done by the PCI core=
 before drivers are bound to<br>&gt; &gt; the device.=C2=A0 If you need dev=
ice-specific workarounds, they should<br>&gt; &gt; probably be in quirks so=
 they&#39;re done before the core does that ASPM<br>&gt; &gt; configuration=
.<br>&gt;<br>&gt; You are right.<br>&gt;<br>&gt; I think calling pci_disabl=
e_link_state() is unnecessary, I&#39;ll also consult<br>&gt; with Realtek a=
bout this.<br>&gt;<br>&gt; I&#39;ll also do some testing and send a separat=
e patch to remove<br>&gt; pci_disable_link_state() for -rc kernel to test i=
f this is something really<br>&gt; needed.<br><br>Great, thanks!=C2=A0 Woul=
d you mind copying <a href=3D"mailto:linux-pci@vger.kernel.org">linux-pci@v=
ger.kernel.org</a><br>when/if you post an update?=C2=A0 The ASPM parts are =
of interest there.</div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>On Wed, Jun 6, 2018 at 2:00 AM Kai-Heng Feng &lt;<a href=3D"mailto:kai.hen=
g.feng@canonical.com">kai.heng.feng@canonical.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Hi, Bjorn,<br>
<br>
at 01:28, Bjorn Helgaas &lt;<a href=3D"mailto:helgaas@kernel.org" target=3D=
"_blank">helgaas@kernel.org</a>&gt; wrote:<br>
<br>
&gt; On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:<br>
&gt;&gt; Add realtek folk Hau<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Kai Heng Feng [mailto:<a href=3D"mailto:kai.heng.feng@canoni=
cal.com" target=3D"_blank">kai.heng.feng@canonical.com</a>]<br>
&gt;&gt; Sent: Tuesday, June 05, 2018 1:02 PM<br>
&gt;&gt; To: <a href=3D"mailto:jrg.otte@gmail.com" target=3D"_blank">jrg.ot=
te@gmail.com</a><br>
&gt;&gt; Cc: David Miller &lt;<a href=3D"mailto:davem@davemloft.net" target=
=3D"_blank">davem@davemloft.net</a>&gt;; Hayes Wang=C2=A0 <br>
&gt;&gt; &lt;<a href=3D"mailto:hayeswang@realtek.com" target=3D"_blank">hay=
eswang@realtek.com</a>&gt;; <a href=3D"mailto:hkallweit1@gmail.com" target=
=3D"_blank">hkallweit1@gmail.com</a>; <a href=3D"mailto:romieu@fr.zoreil.co=
m" target=3D"_blank">romieu@fr.zoreil.com</a>;=C2=A0 <br>
&gt;&gt; Linux Netdev List &lt;<a href=3D"mailto:netdev@vger.kernel.org" ta=
rget=3D"_blank">netdev@vger.kernel.org</a>&gt;; Linux Kernel Mailing List=
=C2=A0 <br>
&gt;&gt; &lt;<a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_bla=
nk">linux-kernel@vger.kernel.org</a>&gt;; Ryankao &lt;<a href=3D"mailto:rya=
nkao@realtek.com" target=3D"_blank">ryankao@realtek.com</a>&gt;<br>
&gt;&gt; Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support<br>
&gt;&gt;<br>
&gt;&gt; Hi J=C3=B6rg Otte,<br>
&gt;&gt;<br>
&gt;&gt; Can you give this patch a try?<br>
&gt;&gt;<br>
&gt;&gt; Since you are the only one that reported ALDPS/ASPM regression,<br=
>
&gt;&gt;<br>
&gt;&gt; And I think this patch should solve the issue you had [1].<br>
&gt;&gt;<br>
&gt;&gt; Hopefully we don&#39;t need to go down the rabbit hole of=C2=A0 <b=
r>
&gt;&gt; blacklist/whitelist...<br>
&gt;&gt;<br>
&gt;&gt; Kai-Heng<br>
&gt;&gt;<br>
&gt;&gt; [1] <a href=3D"https://lkml.org/lkml/2013/1/5/36" rel=3D"noreferre=
r" target=3D"_blank">https://lkml.org/lkml/2013/1/5/36</a><br>
&gt;<br>
&gt; I have no idea what ALDPS is.=C2=A0 It&#39;s not mentioned in the PCIe=
 spec, so<br>
&gt; presumably it&#39;s some Realtek-specific thing.=C2=A0 ASPM is a gener=
ic PCIe<br>
&gt; thing.=C2=A0 Changes to these two things should be in separate patches=
 so<br>
&gt; they don&#39;t get tangled up.<br>
<br>
Sure, I&#39;ll split them in two. I&#39;ll also consult with Realtek to exp=
lain=C2=A0 <br>
what ALDPS actually does.<br>
<br>
&gt;<br>
&gt;&gt;&gt; On Jun 5, 2018, at 12:58 PM, Kai-Heng Feng<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:kai.heng.feng@canonical.com" target=3D"_=
blank">kai.heng.feng@canonical.com</a>&gt;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch reinstate ALDPS and ASPM support on r8169.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On some Intel platforms, ASPM support on r8169 is the key fact=
or to<br>
&gt;&gt;&gt; let Package C-State achieve PC8. Without ASPM support, the dee=
pest<br>
&gt;&gt;&gt; Package C-State can hit is PC3. PC8 can save additional ~3W in=
<br>
&gt;&gt;&gt; comparison with PC3.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch is from Realtek.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Fixes: e0c075577965 (&quot;r8169: enable ALDPS for power savin=
g&quot;)<br>
&gt;&gt;&gt; Fixes: d64ec841517a (&quot;r8169: enable internal ASPM and clo=
ck request<br>
&gt;&gt;&gt; settings&quot;)<br>
&gt;<br>
&gt;&gt;&gt; +3507,15 @@ static void rtl8168e_1_hw_phy_config(struct<br>
&gt;&gt;&gt; rtl8169_private *tp)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0rtl_writephy(tp, 0x0d, 0x4007);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0rtl_writephy(tp, 0x0e, 0x0000);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0rtl_writephy(tp, 0x0d, 0x0000);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0/* Check ALDPS bit, disable it if enabled */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0rtl_writephy(tp, 0x1f, 0x0000);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0if (enable_aldps)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl_w0w1_phy(tp, 0x1=
5, 0x1000, 0x0000);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0else if (rtl_readphy(tp, 0x15) &amp; 0x1000)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl_w0w1_phy(tp, 0x1=
5, 0x0000, 0x1000);<br>
&gt;<br>
&gt; There&#39;s a lot of repetition of this code with minor variations.=C2=
=A0 You<br>
&gt; could probably factor it out and make it more concise and more<br>
&gt; readable.<br>
<br>
You are right. Will do.<br>
<br>
&gt;<br>
&gt;&gt;&gt; +static void rtl8169_check_link_status(struct net_device *dev,=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rtl8169_p=
rivate *tp) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0struct device *d =3D tp_to_dev(tp);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0if (tp-&gt;link_ok(tp)) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtl_link_chg_patch(t=
p);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This is to cancel=
 a scheduled suspend if there&#39;s one. */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_request_resum=
e(d))<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0_rtl_reset_work(tp);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netif_carrier_on(dev=
);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (net_ratelimit())=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0netif_info(tp, ifup, dev, &quot;link up\n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0} else {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netif_carrier_off(de=
v);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netif_info(tp, ifdow=
n, dev, &quot;link down\n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_idle(d);<=
br>
&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +}<br>
&gt;<br>
&gt; This function apparently just got moved around without changing<br>
&gt; anything.=C2=A0 That&#39;s fine, but the move should be in a separate =
patch to<br>
&gt; make the real changes easier to review.<br>
<br>
It actually added a new condition to check the return value of=C2=A0 <br>
pm_request_resume().<br>
<br>
It&#39;s probably a bogus check though. I&#39;ll ask Realtek why they did t=
his.<br>
<br>
&gt;<br>
&gt;&gt;&gt; @@ -7649,8 +7757,12 @@ static int rtl_init_one(struct pci_dev =
*pdev,<br>
&gt;&gt;&gt; const struct pci_device_id *ent)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/* disable ASPM completely as that cause ra=
ndom device stop working<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 * problems as well as full system hangs fo=
r some PCIe devices users */<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S=
 | PCIE_LINK_STATE_L1 |<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIE_LINK_STATE_CLKPM)=
;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0if (!enable_aspm) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_disable_link_sta=
te(pdev, PCIE_LINK_STATE_L0S |<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PCIE_LINK_STATE_L1 |<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PCIE_LINK_STATE_CLKPM);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netif_info(tp, probe=
, dev, &quot;ASPM disabled\n&quot;);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; ASPM is a generic PCIe feature that should be configured by the PCI<br=
>
&gt; core without any help from the device driver.<br>
&gt;<br>
&gt; If code in the driver is needed, that means either the PCI core is<br>
&gt; doing it wrong and we should fix it there, or the device is broken and=
<br>
&gt; the driver is working around the erratum.<br>
&gt;<br>
&gt; If this is an erratum, you should include details about exactly what&#=
39;s<br>
&gt; broken and (ideally) a URL to the published erratum.=C2=A0 Otherwise t=
his<br>
&gt; is just unmaintainable black magic and likely to be broken by future<b=
r>
&gt; ASPM changes in the PCI core.<br>
&gt;<br>
&gt; ASPM configuration is done by the PCI core before drivers are bound to=
<br>
&gt; the device.=C2=A0 If you need device-specific workarounds, they should=
<br>
&gt; probably be in quirks so they&#39;re done before the core does that AS=
PM<br>
&gt; configuration.<br>
<br>
You are right.<br>
<br>
I think calling pci_disable_link_state() is unnecessary, I&#39;ll also cons=
ult=C2=A0 <br>
with Realtek about this.<br>
<br>
I&#39;ll also do some testing and send a separate patch to remove=C2=A0 <br=
>
pci_disable_link_state() for -rc kernel to test if this is something really=
=C2=A0 <br>
needed.<br>
<br>
Kai-Heng<br>
<br>
&gt;<br>
&gt;&gt;&gt; /* enable device (incl. PCI PM wakeup and hotplug setup) */<br=
>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0rc =3D pcim_enable_device(pdev);<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.17.0<br>
&gt;&gt;<br>
&gt;&gt; ------Please consider the environment before printing this e-mail.=
<br>
<br>
<br>
</blockquote></div>

--00000000000048118f056df9191e--
