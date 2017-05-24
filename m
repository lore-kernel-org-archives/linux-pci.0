Return-Path: <SRS0=tvTh=46=microsoft.com=Jork.Loeser@kernel.org>
Return-Path: <SRS0=tvTh=46=microsoft.com=Jork.Loeser@kernel.org>
From: Jork Loeser <Jork.Loeser@microsoft.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: "helgaas@kernel.org" <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
	"marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, "Stephen
 Hemminger" <sthemmin@microsoft.com>
Subject: RE: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Date: Wed, 24 May 2017 15:07:00 +0000
Message-ID: <CY4PR21MB06313E63A651ED6BEC9782F1F1FE0@CY4PR21MB0631.namprd21.prod.outlook.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
 <1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
 <20170519112701.adqxvpkorrthjf7i@mwanda>
In-Reply-To: <20170519112701.adqxvpkorrthjf7i@mwanda>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Friday, May 19, 2017 04:27
> To: Jork Loeser <Jork.Loeser@microsoft.com>
> Cc: helgaas@kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> Hemminger <sthemmin@microsoft.com>
> Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
>=20
> Minor nits only.

> > +#define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
>=20
> Use BIT(11).  I thought checkpatch.pl complains about this but I guess th=
at's only
> with the --strict option.

Not addressing here as per Stephen's comment - this use is prevalent in the=
 current code.

> > @@ -900,36 +1074,42 @@ static void hv_compose_msi_msg(struct irq_data
 [...]
> > +	switch (pci_protocol_version) {
> > +	case PCI_PROTOCOL_VERSION_1_1:
[...]
> > +	default:
> > +		/* As we only negotiate protocol versions known to this driver,
> > +		 * this path should never hit. However, this is it not a hot
> > +		 * path so we print a message to aid future updates.
> > +		 */
> > +		dev_err(&hbus->hdev->device,
> > +			"Unexpected vPCI protocol, update driver.");
>=20
> We should check the protocol version in probe() instead of here.

It is checked in probe(). The catch-all is merely a helper in case future u=
pdates miss adapting.=20

Regards,
Jork
