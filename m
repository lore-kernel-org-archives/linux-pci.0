Return-Path: <SRS0=tvTh=46=microsoft.com=Jork.Loeser@kernel.org>
Return-Path: <SRS0=tvTh=46=microsoft.com=Jork.Loeser@kernel.org>
From: Jork Loeser <Jork.Loeser@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Jork Loeser
	<jloeser@linuxonhyperv.com>
CC: "helgaas@kernel.org" <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "leann.ogasawara@canonical.com"
	<leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
	<marcelo.cerri@canonical.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Date: Wed, 24 May 2017 14:58:11 +0000
Message-ID: <CY4PR21MB0631089CF34075759924DDE0F1FE0@CY4PR21MB0631.namprd21.prod.outlook.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
	<1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
 <87o9upupzl.fsf@vitty.brq.redhat.com>
In-Reply-To: <87o9upupzl.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Vitaly Kuznetsov [mailto:vkuznets@redhat.com]
> Sent: Friday, May 19, 2017 02:59
> To: Jork Loeser <jloeser@linuxonhyperv.com>
> Cc: Jork Loeser <Jork.Loeser@microsoft.com>; helgaas@kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; leann.ogasawara@canonical.com;
> marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>
> Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
>=20
> Jork Loeser <jloeser@linuxonhyperv.com> writes:


> > +	res =3D hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size <<
> 17),
> > +			      params, NULL);
>=20
> In my 'remote tbl flush' series I defined 'union hv_hypercall_input', you=
 can use it
> instead of hardcoding ' | (var_size << 17)'

Good idea. We can adapt this later.

Regards,
Jork
