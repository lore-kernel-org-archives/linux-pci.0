Return-Path: <SRS0=oQWR=65=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=oQWR=65=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf5hdXUXja_jUB6_kBg6pyX8zXuOMOGzCVNgeBFMUsWqQ@mail.gmail.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org> <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org> <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home> <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAKgT0UeAad6WArvrE71MFJywDs1wOnCF-iJRnbNLrL+knqhXeA@mail.gmail.com> <CAKgT0Uf5hdXUXja_jUB6_kBg6pyX8zXuOMOGzCVNgeBFMUsWqQ@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 26 Jul 2017 11:44:56 -0700
Message-ID: <CAKgT0Udn2vh6NaqZyiF69nXVnz2sT=e0ZgiDjWznhGZz-Gk+qQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
To: Casey Leedom <leedom@chelsio.com>
Cc: Netdev <netdev@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	Ganesh GR <ganeshgr@chelsio.com>,
	"asit.k.mallick@intel.com" <asit.k.mallick@intel.com>,
	"jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>, Michael Werner <werner@chelsio.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>, Ding Tianhong <dingtianhong@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "amira@mellanox.com" <amira@mellanox.com>,
	"Bob.Shaw@amd.com" <Bob.Shaw@amd.com>
Content-Type: multipart/alternative; boundary="001a11475bdc2afec105553cd8ab"
List-ID: <linux-pci.vger.kernel.org>

--001a11475bdc2afec105553cd8ab
Content-Type: text/plain; charset="UTF-8"

On Jul 26, 2017 11:26 AM, "Casey Leedom" <leedom@chelsio.com> wrote:

  By the way Ding, two issues:

 1. Did we ever get any acknowledgement from either Intel or AMD
    on this patch?  I know that we can't ensure that, but it sure would
    be nice since the PCI Quirks that we're putting in affect their
    products.

 2. I just realized that there's still a small hole in the patch with
    respect to PCIe SR-IOV Virtual Functions.  When the PCI Quirk
    notices a problematic PCIe Device and marks it to note that
    it's not "happy" receiving Transaction Layer Packets with the
    Relaxed Ordering Attribute set, it's my understanding that your
    current patch iterates down the PCIe Fabric and turns off the
    PCIe Capability Device Control[Relaxed Ordering Enable].
    But this scan may miss any SR-IOV VFs because they
    probably won't be instantiated at that time.  And, at a later
    time, when they are instantiated, they could well have their
    Relaxed Ordering Enable set.

    I think that the patch will need to be extended to modify
    drivers/pci.c/iov.c:sriov_enable() to explicitly turn off
    Relaxed Ordering Enable if the Root Complex is marked
    for no RO TLPs.

Casey


I'm not sure that would be an issue. Wouldn't most VFs inherit the PF's
settings?

Also I thought most of the VF configuration space is read only.

- Alex

--001a11475bdc2afec105553cd8ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Jul 26, 2017 11:26 AM, &quot;Casey Leedom&quot; &lt;<a href=3D=
"mailto:leedom@chelsio.com">leedom@chelsio.com</a>&gt; wrote:<br type=3D"at=
tribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">=C2=A0 By the way Ding, two issues:<br>
<br>
=C2=A01. Did we ever get any acknowledgement from either Intel or AMD<br>
=C2=A0 =C2=A0 on this patch?=C2=A0 I know that we can&#39;t ensure that, bu=
t it sure would<br>
=C2=A0 =C2=A0 be nice since the PCI Quirks that we&#39;re putting in affect=
 their<br>
=C2=A0 =C2=A0 products.<br>
<br>
=C2=A02. I just realized that there&#39;s still a small hole in the patch w=
ith<br>
=C2=A0 =C2=A0 respect to PCIe SR-IOV Virtual Functions.=C2=A0 When the PCI =
Quirk<br>
=C2=A0 =C2=A0 notices a problematic PCIe Device and marks it to note that<b=
r>
=C2=A0 =C2=A0 it&#39;s not &quot;happy&quot; receiving Transaction Layer Pa=
ckets with the<br>
=C2=A0 =C2=A0 Relaxed Ordering Attribute set, it&#39;s my understanding tha=
t your<br>
=C2=A0 =C2=A0 current patch iterates down the PCIe Fabric and turns off the=
<br>
=C2=A0 =C2=A0 PCIe Capability Device Control[Relaxed Ordering Enable].<br>
=C2=A0 =C2=A0 But this scan may miss any SR-IOV VFs because they<br>
=C2=A0 =C2=A0 probably won&#39;t be instantiated at that time.=C2=A0 And, a=
t a later<br>
=C2=A0 =C2=A0 time, when they are instantiated, they could well have their<=
br>
=C2=A0 =C2=A0 Relaxed Ordering Enable set.<br>
<br>
=C2=A0 =C2=A0 I think that the patch will need to be extended to modify<br>
=C2=A0 =C2=A0 drivers/pci.c/iov.c:sriov_<wbr>enable() to explicitly turn of=
f<br>
=C2=A0 =C2=A0 Relaxed Ordering Enable if the Root Complex is marked<br>
=C2=A0 =C2=A0 for no RO TLPs.<br>
<font color=3D"#888888"><br>
Casey</font></blockquote></div><br></div></div><div class=3D"gmail_extra" d=
ir=3D"auto">I&#39;m not sure that would be an issue. Wouldn&#39;t most VFs =
inherit the PF&#39;s settings?</div><div class=3D"gmail_extra" dir=3D"auto"=
><br></div><div class=3D"gmail_extra" dir=3D"auto">Also I thought most of t=
he VF configuration space is read only.</div><div class=3D"gmail_extra" dir=
=3D"auto"><br></div><div class=3D"gmail_extra" dir=3D"auto">- Alex</div></d=
iv>

--001a11475bdc2afec105553cd8ab--
