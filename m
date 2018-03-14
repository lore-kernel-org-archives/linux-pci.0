Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "'bhelgaas@google.com'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "'stable@vger.kernel.org'" <stable@vger.kernel.org>,
        'Jack Morgenstein' <jackm@mellanox.com>
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Date: Wed, 14 Mar 2018 17:17:13 +0000
Message-ID: <KL1P15301MB0006D5A4BD0ED296804637C9BFD10@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
 <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
 <20180314115000.GC27868@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180314115000.GC27868@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, March 14, 2018 04:50
> On Tue, Mar 13, 2018 at 06:23:39PM +0000, Dexuan Cui wrote:
>=20
> [...]
>=20
> > Hi Lorenzo, Bjorn, and all,
> > Do you need more ACKs? Currently Michael and Haiyang reviewed and ack'd
> > the patchset.
> >
> > Should I send a v4 that just removes the "CC: stable@vger.kernel.org" t=
ag
> > for patches 1, 2, 4 and 5? I tend to avoid a v4 as I supppose it would =
be
> > easier if you just remove the tags if you belive it's necessary (IMHO a=
ll the
> > 6 paches are not big and it would be great if we can have all of them i=
n
> > the old stable kernels, but I respect your decision).
>=20
> I think you need a v4 since for patches that are actually fixing a bug I
> want a Fixes: tag added and I want them to be applicable independently
> of other patches in the series. Send them in a separate series if you
> prefer - I just want to make sure they apply independently.

Ok, I'll send 2 series: one for
[6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
[3/6] PCI: hv: serialize the present/eject work items
These fix real issues reported by Mellanox when they tested SR-IOV with VMs
runnning on Hyper-V. I'll add stable tags for them.

The other series will cover these 4 patces which don't need to go in stable=
:
[5/6] PCI: hv: hv_pci_devices_present(): only queue a new work when necessa=
ry
[4/6] PCI: hv: remove hbus->enum_sem
[2/6] PCI: hv: hv_eject_device_work(): remove the bogus test
[1/6] PCI: hv: fix a comment typo in _hv_pcifront_read_config()
=20
> As for marking patches for stable kernels, I do not think it is right
> to send cosmetic churn to stable kernels anyway, at least that's my
> reading of the policy.
>=20
> You can easily post a v4 with patches reshuffled - I will apply them
> accordingly.
OK.
=20
> Before re-posting please read this to improve formatting (I can do it
> for you but while at it you can do it yourself):
> https://marc.info/?l=3Dlinux-pci&m=3D150905742808166&w=3D2
Will read. Thanks!

-- Dexuan
