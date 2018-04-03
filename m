Return-Path: <SRS0=lrmI=GY=intel.com=jacob.e.keller@kernel.org>
Return-Path: <SRS0=lrmI=GY=intel.com=jacob.e.keller@kernel.org>
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jacob Keller <jacob.keller@gmail.com>
CC: Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>, Ariel
 Elior <ariel.elior@cavium.com>, Ganesh Goudar <ganeshgr@chelsio.com>,
	"Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
	"everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute
 max supported link bandwidth
Date: Tue, 3 Apr 2018 16:54:52 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882D4AA53@ORSMSX115.amr.corp.intel.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
 <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
 <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com>
 <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
 <CA+P7+xr1N+X5DyPwNpWUtfqr9U4pLL9bMoB1wkBdf2K9n6cxKw@mail.gmail.com>
 <20180403140552.GB60020@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180403140552.GB60020@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, April 03, 2018 7:06 AM
> To: Jacob Keller <jacob.keller@gmail.com>
> Cc: Tal Gilboa <talgi@mellanox.com>; Tariq Toukan <tariqt@mellanox.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavi=
um.com>;
> Ganesh Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g;
> linux-pci@vger.kernel.org
> Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to comput=
e
> max supported link bandwidth
>=20
> On Mon, Apr 02, 2018 at 05:30:54PM -0700, Jacob Keller wrote:
> > On Mon, Apr 2, 2018 at 7:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > +/* PCIe speed to Mb/s reduced by encoding overhead */
> > > +#define PCIE_SPEED2MBS_ENC(speed) \
> > > +       ((speed) =3D=3D PCIE_SPEED_16_0GT ? (16000*(128/130)) : \
> > > +        (speed) =3D=3D PCIE_SPEED_8_0GT  ?  (8000*(128/130)) : \
> > > +        (speed) =3D=3D PCIE_SPEED_5_0GT  ?  (5000*(8/10)) : \
> > > +        (speed) =3D=3D PCIE_SPEED_2_5GT  ?  (2500*(8/10)) : \
> > > +        0)
> > > +
> >
> > Should this be "(speed * x ) / y" instead? wouldn't they calculate
> > 128/130 and truncate that to zero before multiplying by the speed? Or
> > are compilers smart enough to do this the other way to avoid the
> > losses?
>=20
> Yep, thanks for saving me yet more embarrassment.

That's what patch review is for :D

Thanks,
Jake
