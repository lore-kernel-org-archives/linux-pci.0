Return-Path: <SRS0=ycBd=HT=mobiveil.co.in=l.subrahmanya@kernel.org>
Return-Path: <SRS0=ycBd=HT=mobiveil.co.in=l.subrahmanya@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180427220932.GA73638@bhelgaas-glaptop.roam.corp.google.com>
References: <1524634505-9598-1-git-send-email-l.subrahmanya@mobiveil.co.in> <20180427220932.GA73638@bhelgaas-glaptop.roam.corp.google.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Mon, 30 Apr 2018 10:11:36 +0530
Message-ID: <CAFZiPx1asBwpTrvMXa9WVgF8vbiwT-AmMS8e_0eE7jRS=yaU_g@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] Implement MSI support for Mobiveil PCIe Host
 Bridge IP device driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Peter W Newton <peter.newton@nxp.com>,
	"M.h. Lian" <minghuan.lian@nxp.com>, Raj Raina <rajesh.raina@nxp.com>,
	Rajan Kapoor <rajan.kapoor@nxp.com>, Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: multipart/alternative; boundary="001a114719a60de838056b097892"
List-ID: <linux-pci.vger.kernel.org>

--001a114719a60de838056b097892
Content-Type: text/plain; charset="UTF-8"

Thanks Bjorn,
updated the patch-set and submitted version 9.

Thanks.

On Sat, Apr 28, 2018 at 3:39 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

>
> I should have noticed this before, sorry:
>
> s/Implement MSI support for Mobiveil PCIe Host/
>   PCI: mobiveil: Add MSI support/
>
> This makes "git log --oneline drivers/pci/host/pcie-mobiveil.c" look
> sensible.
>
> Also, please add a commit log in addition to the subject.  It's OK if the
> commit log repeats the subject.
>
> On Wed, Apr 25, 2018 at 01:35:05AM -0400, Subrahmanya Lingappa wrote:
> > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: linux-pci@vger.kernel.org
>

--001a114719a60de838056b097892
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;color:#073763">Thanks Bjorn,</div><div class=3D"gmail_default" s=
tyle=3D"font-family:verdana,sans-serif;color:#073763">updated the patch-set=
 and submitted version 9.</div><div class=3D"gmail_default" style=3D"font-f=
amily:verdana,sans-serif;color:#073763"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;color:#073763">Thanks.</div></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Apr 28=
, 2018 at 3:39 AM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a href=3D"mailto:he=
lgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><br>
I should have noticed this before, sorry:<br>
<br>
s/Implement MSI support for Mobiveil PCIe Host/<br>
=C2=A0 PCI: mobiveil: Add MSI support/<br>
<br>
This makes &quot;git log --oneline drivers/pci/host/pcie-<wbr>mobiveil.c&qu=
ot; look<br>
sensible.<br>
<br>
Also, please add a commit log in addition to the subject.=C2=A0 It&#39;s OK=
 if the<br>
commit log repeats the subject.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Wed, Apr 25, 2018 at 01:35:05AM -0400, Subrahmanya Lingappa wrote:<br>
&gt; Signed-off-by: Subrahmanya Lingappa &lt;<a href=3D"mailto:l.subrahmany=
a@mobiveil.co.in">l.subrahmanya@mobiveil.co.in</a>&gt;<br>
&gt; Cc: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas@google.com">bhelgaas@=
google.com</a>&gt;<br>
&gt; Cc: Lorenzo Pieralisi &lt;<a href=3D"mailto:lorenzo.pieralisi@arm.com"=
>lorenzo.pieralisi@arm.com</a>&gt;<br>
&gt; Cc: Marc Zyngier &lt;<a href=3D"mailto:marc.zyngier@arm.com">marc.zyng=
ier@arm.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:linux-pci@vger.kernel.org">linux-pci@vger.kernel=
.org</a><br>
</div></div></blockquote></div><br></div>

--001a114719a60de838056b097892--
