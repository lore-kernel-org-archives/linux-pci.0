Return-Path: <aditr@vmware.com>
Return-Path: <aditr@vmware.com>
From: Adit Ranadive <aditr@vmware.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Shrikrishna Khare <skhare@vmware.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, pv-drivers <pv-drivers@mailman2.vmware.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH] vmxnet3: Move PCI Id to pci_ids.h
Date: Fri, 5 Aug 2016 21:22:16 +0000
Message-ID: <BLUPR0501MB836F0E58C62EB35F561E4D4C5180@BLUPR0501MB836.namprd05.prod.outlook.com>
References: <1470420039-23125-1-git-send-email-aditr@vmware.com>
 <20160805182332.GA6369@localhost>
In-Reply-To: <20160805182332.GA6369@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 05, 2016 11:23:41AM -0700, Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> On Fri, Aug 05, 2016 at 11:00:39AM -0700, Adit Ranadive wrote:
> > The VMXNet3 PCI Id will be shared with our upcoming paravirtual RDMA
> > driver. Moved it to the shared location in pci_ids.h and updated the
> > driver version.
> >
> > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Adit Ranadive <aditr@vmware.com>
>=20
> Please include this in the series that adds your paravirtual RDMA
> driver.  Please do not change the driver version information in this
> patch, because that change is unrelated to moving the PCI ID.

Ok, I will. Please drop this patch then.

Thanks,
Adit
