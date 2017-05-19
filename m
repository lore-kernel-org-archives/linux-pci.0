Return-Path: <SRS0=lggU=4Z=microsoft.com=Jork.Loeser@kernel.org>
Return-Path: <SRS0=lggU=4Z=microsoft.com=Jork.Loeser@kernel.org>
From: Jork Loeser <Jork.Loeser@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "helgaas@kernel.org" <helgaas@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "leann.ogasawara@canonical.com"
	<leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
	<marcelo.cerri@canonical.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Date: Fri, 19 May 2017 02:13:55 +0000
Message-ID: <CY4PR21MB06313801D2312E9686F3520AF1E50@CY4PR21MB0631.namprd21.prod.outlook.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
	<1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
 <20170518165854.46fd92fa@xeon-e3>
In-Reply-To: <20170518165854.46fd92fa@xeon-e3>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, May 18, 2017 16:59
>=20
> > From: Jork Loeser <jloeser@microsoft.com>
> >
> > Update the Hyper-V vPCI driver to use the Server-2016 version of the
> > vPCI protocol, fixing MSI creation and retargeting issues.
> >
> > Signed-off-by: Jork Loeser <jloeser@microsoft.com>
>=20
> This patch conflicts with already submitted patch that removes
> vmbus_cpu_number_to_vp_number()
>=20
> commit 4b28e5c28cc32652d200a31795e38ee6c819a4a2
> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> Date:   Mon May 15 13:38:26 2017 -0700
>=20
>     hyper-v: globalize vp_index
>=20
>     To support implementing remote TLB flushing on Hyper-V with a hyperca=
ll
>     we need to make vp_index available outside of vmbus module. Rename an=
d
>     globalize.

Thank you Stephen, easy enough to adapt.=20

Bjorn, Greg, Vitaly: Do you have an ETA on when Vitaly's patch will be in t=
he PCI or linux-next branch so I can rev?

Thanks,
Jork
