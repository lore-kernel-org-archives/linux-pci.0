Return-Path: <SRS0=Aojj=ZM=netup.ru=aospan@kernel.org>
Return-Path: <SRS0=Aojj=ZM=netup.ru=aospan@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170128204407.GA20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1484265521-13497-1-git-send-email-aospan@netup.ru> <20170128204407.GA20550@bhelgaas-glaptop.roam.corp.google.com>
From: Abylay Ospan <aospan@netup.ru>
Date: Sun, 29 Jan 2017 21:40:38 -0500
Message-ID: <CAK3bHNV-O+k1rHSj-KTKOBNNDXpWxp7rXw8bi7ve7-T9qqs8dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: fix resource allocation for BCMA PCIe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a113d76f4dd72a8054746be4b
List-ID: <linux-pci.vger.kernel.org>

--001a113d76f4dd72a8054746be4b
Content-Type: text/plain; charset=UTF-8

Hi Bjorn,

yes, this is still actual. I didn't seen any other patches/followups about
this problem (am i missed some ?).
Seems like this issue affects following drivers too:

drivers/pci/host/pcie-designware.c
drivers/pci/host/pcie-rockchip.c
drivers/pci/host/pcie-xilinx.c
drivers/pci/host/pcie-xilinx-nwl.c
drivers/pci/host/pci-host-common.c
 -> drivers/pci/host/pci-thunder-ecam.c
 -> drivers/pci/host/pci-thunder-pem.c
 -> drivers/pci/host/pci-host-generic.c
drivers/pci/host/pci-versatile.c
drivers/pci/host/pci-xgene.c

so, I think we need more general fix for this issue. May be inside
'iproc_pcie_setup' (or deeper in 'devm_request_pci_bus_resources') or
fix all drivers listed above. what is better ?

If better to fix all this drivers then my original patch is actual and
need to be approved. If it's better to make more general fix then
please let me know - I will prepare one.



2017-01-28 15:44 GMT-05:00 Bjorn Helgaas <helgaas@kernel.org>:

> On Fri, Jan 13, 2017 at 02:58:41AM +0300, Abylay Ospan wrote:
> > Resource allocated on stack was saved by 'devm_request_resource' to
> > global 'iomem_resource' but become invalid after 'iproc_pcie_bcma_probe'
> exit.
> > So the global 'iomem_resource' was poisoned. This may cause kernel crash
> > or second PCIe bridge registration failure.
> >
> > Tested on Broadcom NorthStar machine ('Edgecore ECW7220-L') with two
> PCIe wifi
> > adapters (b43 BCM4331 and ath10k QCA988X).
> >
> > Signed-off-by: Abylay Ospan <aospan@netup.ru>
>
> Hi Abylay, there was some follow-up discussion and I couldn't tell
> what the ultimate resolution was.  Please repost this with any acks
> you have if this is still necessary.
>
> > ---
> >  drivers/pci/host/pcie-iproc-bcma.c | 18 ++++++++----------
> >  drivers/pci/host/pcie-iproc.h      |  2 ++
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-iproc-bcma.c
> b/drivers/pci/host/pcie-iproc-bcma.c
> > index bd4c9ec..28f9b89 100644
> > --- a/drivers/pci/host/pcie-iproc-bcma.c
> > +++ b/drivers/pci/host/pcie-iproc-bcma.c
> > @@ -44,8 +44,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device
> *bdev)
> >  {
> >       struct device *dev = &bdev->dev;
> >       struct iproc_pcie *pcie;
> > -     LIST_HEAD(res);
> > -     struct resource res_mem;
> >       int ret;
> >
> >       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > @@ -62,21 +60,21 @@ static int iproc_pcie_bcma_probe(struct bcma_device
> *bdev)
> >       }
> >
> >       pcie->base_addr = bdev->addr;
> > +     INIT_LIST_HEAD(&pcie->resources);
> >
> > -     res_mem.start = bdev->addr_s[0];
> > -     res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> > -     res_mem.name = "PCIe MEM space";
> > -     res_mem.flags = IORESOURCE_MEM;
> > -     pci_add_resource(&res, &res_mem);
> > +     pcie->res_mem.start = bdev->addr_s[0];
> > +     pcie->res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> > +     pcie->res_mem.name = "PCIe MEM space";
> > +     pcie->res_mem.flags = IORESOURCE_MEM;
> > +     pcie->res_mem.child = NULL;
> > +     pci_add_resource(&pcie->resources, &pcie->res_mem);
> >
> >       pcie->map_irq = iproc_pcie_bcma_map_irq;
> >
> > -     ret = iproc_pcie_setup(pcie, &res);
> > +     ret = iproc_pcie_setup(pcie, &pcie->resources);
> >       if (ret)
> >               dev_err(dev, "PCIe controller setup failed\n");
> >
> > -     pci_free_resource_list(&res);
> > -
> >       bcma_set_drvdata(bdev, pcie);
> >       return ret;
> >  }
> > diff --git a/drivers/pci/host/pcie-iproc.h
> b/drivers/pci/host/pcie-iproc.h
> > index 04fed8e..866d649 100644
> > --- a/drivers/pci/host/pcie-iproc.h
> > +++ b/drivers/pci/host/pcie-iproc.h
> > @@ -105,6 +105,8 @@ struct iproc_pcie {
> >
> >       bool need_msi_steer;
> >       struct iproc_msi *msi;
> > +     struct resource res_mem;
> > +     struct list_head resources;
> >  };
> >
> >  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv

--001a113d76f4dd72a8054746be4b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bjorn,<div><br></div><div>yes, this is still actual. I =
didn&#39;t seen any other patches/followups about this problem (am i missed=
 some ?).</div><div>Seems like this issue affects following drivers too:</d=
iv><div><pre style=3D"white-space:pre-wrap;color:rgb(0,0,0)">drivers/pci/ho=
st/pcie-designware.c
drivers/pci/host/pcie-rockchip.c
drivers/pci/host/pcie-xilinx.c
drivers/pci/host/pcie-xilinx-nwl.c
drivers/pci/host/pci-host-common.c
 -&gt; drivers/pci/host/pci-thunder-ecam.c
 -&gt; drivers/pci/host/pci-thunder-pem.c
 -&gt; drivers/pci/host/pci-host-generic.c
drivers/pci/host/pci-versatile.c
drivers/pci/host/pci-xgene.c</pre><pre style=3D"white-space:pre-wrap;color:=
rgb(0,0,0)">so, I think we need more general fix for this issue. May be ins=
ide &#39;iproc_pcie_setup&#39; (or deeper in &#39;devm_request_pci_bus_reso=
urces&#39;) or fix all drivers listed above. what is better ? </pre><pre st=
yle=3D"white-space:pre-wrap;color:rgb(0,0,0)">If better to fix all this dri=
vers then my original patch is actual and need to be approved. If it&#39;s =
better to make more general fix then please let me know - I will prepare on=
e.</pre></div><div><br></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">2017-01-28 15:44 GMT-05:00 Bjorn Helgaas <span dir=3D"ltr">&lt;=
<a href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org<=
/a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Jan 13, 2017 at 0=
2:58:41AM +0300, Abylay Ospan wrote:<br>
&gt; Resource allocated on stack was saved by &#39;devm_request_resource&#3=
9; to<br>
&gt; global &#39;iomem_resource&#39; but become invalid after &#39;iproc_pc=
ie_bcma_probe&#39; exit.<br>
&gt; So the global &#39;iomem_resource&#39; was poisoned. This may cause ke=
rnel crash<br>
&gt; or second PCIe bridge registration failure.<br>
&gt;<br>
&gt; Tested on Broadcom NorthStar machine (&#39;Edgecore ECW7220-L&#39;) wi=
th two PCIe wifi<br>
&gt; adapters (b43 BCM4331 and ath10k QCA988X).<br>
&gt;<br>
&gt; Signed-off-by: Abylay Ospan &lt;<a href=3D"mailto:aospan@netup.ru">aos=
pan@netup.ru</a>&gt;<br>
<br>
Hi Abylay, there was some follow-up discussion and I couldn&#39;t tell<br>
what the ultimate resolution was.=C2=A0 Please repost this with any acks<br=
>
you have if this is still necessary.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/pci/host/pcie-iproc-<wbr>bcma.c | 18 ++++++++----------<=
br>
&gt;=C2=A0 drivers/pci/host/pcie-iproc.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<b=
r>
&gt;=C2=A0 2 files changed, 10 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/pci/host/pcie-iproc-<wbr>bcma.c b/drivers/pci/hos=
t/pcie-iproc-<wbr>bcma.c<br>
&gt; index bd4c9ec..28f9b89 100644<br>
&gt; --- a/drivers/pci/host/pcie-iproc-<wbr>bcma.c<br>
&gt; +++ b/drivers/pci/host/pcie-iproc-<wbr>bcma.c<br>
&gt; @@ -44,8 +44,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device =
*bdev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;bdev-&gt;dev;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iproc_pcie *pcie;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0LIST_HEAD(res);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct resource res_mem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pcie =3D devm_kzalloc(dev, sizeof(*pcie), GF=
P_KERNEL);<br>
&gt; @@ -62,21 +60,21 @@ static int iproc_pcie_bcma_probe(struct bcma_devic=
e *bdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;base_addr =3D bdev-&gt;addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp;pcie-&gt;<wbr>resources);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res_mem.start =3D bdev-&gt;addr_s[0];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res_mem.end =3D bdev-&gt;addr_s[0] + SZ_128M - 1;=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0<a href=3D"http://res_mem.name" rel=3D"noreferrer=
" target=3D"_blank">res_mem.name</a> =3D &quot;PCIe MEM space&quot;;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0res_mem.flags =3D IORESOURCE_MEM;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0pci_add_resource(&amp;res, &amp;res_mem);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;res_mem.start =3D bdev-&gt;addr_s[0];<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;res_mem.end =3D bdev-&gt;addr_s[0] + SZ_=
128M - 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;<a href=3D"http://res_mem.name" rel=3D"n=
oreferrer" target=3D"_blank">res_mem.name</a> =3D &quot;PCIe MEM space&quot=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;res_mem.flags =3D IORESOURCE_MEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;res_mem.child =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_add_resource(&amp;pcie-&gt;<wbr>resources, &a=
mp;pcie-&gt;res_mem);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;map_irq =3D iproc_pcie_bcma_map_irq=
;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ret =3D iproc_pcie_setup(pcie, &amp;res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D iproc_pcie_setup(pcie, &amp;pcie-&gt;reso=
urces);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &qu=
ot;PCIe controller setup failed\n&quot;);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0pci_free_resource_list(&amp;res);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bcma_set_drvdata(bdev, pcie);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/pci/host/pcie-iproc.<wbr>h b/drivers/pci/host/pci=
e-iproc.<wbr>h<br>
&gt; index 04fed8e..866d649 100644<br>
&gt; --- a/drivers/pci/host/pcie-iproc.<wbr>h<br>
&gt; +++ b/drivers/pci/host/pcie-iproc.<wbr>h<br>
&gt; @@ -105,6 +105,8 @@ struct iproc_pcie {<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool need_msi_steer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iproc_msi *msi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource res_mem;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head resources;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *=
res);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; linux-arm-kernel mailing list<br>
&gt; <a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kern=
el@lists.<wbr>infradead.org</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mai=
lman/listinfo/linux-arm-<wbr>kernel</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><span style=3D"font-size:12.8000001907349px">Abylay Ospan,</span>=
<br style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.8000=
001907349px">NetUP Inc.</span><br style=3D"font-size:12.8000001907349px"><a=
 href=3D"http://www.netup.tv/" style=3D"font-size:12.8000001907349px" targe=
t=3D"_blank">http://www.netup.tv</a><br></div></div>
</div></div>

--001a113d76f4dd72a8054746be4b--
