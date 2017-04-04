Return-Path: <SRS0=zeLE=3M=microsoft.com=kys@kernel.org>
Return-Path: <SRS0=zeLE=3M=microsoft.com=kys@kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "leann.ogasawara@canonical.com"
	<leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
	<marcelo.cerri@canonical.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH 0/2] pci-hyperv: Some miscellaneous fixes
Date: Tue, 4 Apr 2017 19:54:33 +0000
Message-ID: <DM5PR03MB249052D8580711F8999048D8A00B0@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
 <20170404190331.GD27692@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170404190331.GD27692@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, April 4, 2017 12:04 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> Hemminger <sthemmin@microsoft.com>
> Subject: Re: [PATCH 0/2] pci-hyperv: Some miscellaneous fixes
>=20
> On Fri, Mar 24, 2017 at 11:06:40AM -0700, kys@exchange.microsoft.com
> wrote:
> > From: K. Y. Srinivasan <kys@microsoft.com>
> >
> > Some miscellaneous fixes.
> >
> > K. Y. Srinivasan (2):
> >   pci-hyperv: Fix a bug in specifying CPU affinity
> >   pci-hyperv: Fix an atomic bug
> >
> >  drivers/pci/host/pci-hyperv.c |   13 +++++++++----
> >  1 files changed, 9 insertions(+), 4 deletions(-)
>=20
> I applied these with Long's reviewed-by to pci/host-hv for v4.12 with the
> following subject lines:
>=20
>   PCI: hv: Specify CPU_AFFINITY_ALL for MSI affinity when >=3D 32 CPUs
>   PCI: hv: Allocate interrupt descriptors with GFP_ATOMIC
>=20
Thank you.

> There were two copies of [1/2], which makes this error-prone.  I applied
> the second one that defines CPU_AFFINITY_ALL.

Thanks again; sorry for the confusion.

>=20
> They're both marked for stable, but without any clue about when the
> problems were introduced or how serious they are, I did not queue them fo=
r
> v4.11.  If you want them in v4.11, please supply those additional details=
.

I think these issues have been there since   the driver got merged upstream=
.
I would want this to be applied against 4.11 as well. Let me know if I shou=
ld resend
these patches.

Thanks,

K. Y=20
>=20
> Bjorn
