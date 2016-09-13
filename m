Return-Path: <monstr@monstr.eu>
Return-Path: <monstr@monstr.eu>
MIME-Version: 1.0
In-Reply-To: <20160912222138.GK23532@localhost>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com> <20160912222138.GK23532@localhost>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 13 Sep 2016 09:27:28 +0100
Message-ID: <CAHTX3dJOxec+P7oUkK0mf7uoawdpkNUvrFxWQO9Xy8--p1_Cgg@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI: xilinx: Keep both legacy and MSI interrupt references.
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, grygorii.strashko@ti.com,
	Arnd Bergmann <arnd@arndb.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Bharat Kumar Gogada <bharatku@xilinx.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, christophe.jaillet@wanadoo.fr,
	linux-arm <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
	rgummal@xilinx.com, Fengguang Wu <fengguang.wu@intel.com>, yinghai@kernel.org,
	Soren Brinkmann <soren.brinkmann@xilinx.com>
Content-Type: multipart/alternative; boundary=001a114db10c2195de053c5f6286
List-ID: <linux-pci.vger.kernel.org>

--001a114db10c2195de053c5f6286
Content-Type: text/plain; charset=UTF-8

2016-09-12 23:21 GMT+01:00 Bjorn Helgaas <helgaas@kernel.org>:

> On Thu, Sep 01, 2016 at 03:44:41PM +0530, Bharat Kumar Gogada wrote:
> > When built with MSI support the legacy domain reference is being
> > overwritten with MSI.
> > Instead creating two separate domains for MSI and legacy interrupts.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>
> I'm looking for an ack from Michal for these...
>

this driver is only one which is using these pci fragments in architecture
that's why I can't see any issue.
For the whole series here is my

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform

--001a114db10c2195de053c5f6286
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-09-12 23:21 GMT+01:00 Bjorn Helgaas <span dir=3D"ltr">&lt;<a href=
=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Thu, Sep 01,=
 2016 at 03:44:41PM +0530, Bharat Kumar Gogada wrote:<br>
&gt; When built with MSI support the legacy domain reference is being<br>
&gt; overwritten with MSI.<br>
&gt; Instead creating two separate domains for MSI and legacy interrupts.<b=
r>
&gt;<br>
&gt; Signed-off-by: Bharat Kumar Gogada &lt;<a href=3D"mailto:bharatku@xili=
nx.com">bharatku@xilinx.com</a>&gt;<br>
<br>
</span>I&#39;m looking for an ack from Michal for these...<br></blockquote>=
<div><br clear=3D"all"></div></div>this driver is only one which is using t=
hese pci fragments in architecture<br></div><div class=3D"gmail_extra">that=
&#39;s why I can&#39;t see any issue. <br></div><div class=3D"gmail_extra">=
For the whole series here is my<br><br></div><div class=3D"gmail_extra">Ack=
ed-by: Michal Simek &lt;<a href=3D"mailto:michal.simek@xilinx.com">michal.s=
imek@xilinx.com</a>&gt;<br><br></div><div class=3D"gmail_extra">Thanks,<br>=
</div><div class=3D"gmail_extra">Michal<br></div><div class=3D"gmail_extra"=
><br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signatur=
e">Michal Simek, Ing. (M.Eng), OpenPGP -&gt; KeyID: FE3D1F91<br>w: <a href=
=3D"http://www.monstr.eu" target=3D"_blank">www.monstr.eu</a> p: +42-0-7218=
42854<br>Maintainer of Linux kernel - Microblaze cpu - <a href=3D"http://ww=
w.monstr.eu/fdt/" target=3D"_blank">http://www.monstr.eu/fdt/</a><br>Mainta=
iner of Linux kernel - Xilinx Zynq ARM architecture<br>Microblaze U-BOOT cu=
stodian and responsible for u-boot arm zynq platform</div>
</div></div>

--001a114db10c2195de053c5f6286--
