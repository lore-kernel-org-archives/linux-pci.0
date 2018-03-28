Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "netanel@amazon.com" <netanel@amazon.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "mheyne@amazon.de" <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "hch@lst.de" <hch@lst.de>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [pci PATCH v7 2/5] virtio_pci: Add support for unmanaged SR-IOV
 on virtio_pci devices
Date: Wed, 28 Mar 2018 21:31:40 +0000
Message-ID: <52734805-4A20-41C0-A46A-A8AFF8D79A72@intel.com>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain>
In-Reply-To: <20180315184132.3102.90947.stgit@localhost.localdomain>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_67787A4F-EC56-438D-B41A-B2FB4E4FBB45";
        protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_67787A4F-EC56-438D-B41A-B2FB4E4FBB45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2018, at 11:42 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Hardware-realized virtio_pci devices can implement SR-IOV, so this
> patch enables its use. The device in question is an upcoming Intel
> NIC that implements both a virtio_net PF and virtio_net VFs. These
> are hardware realizations of what has been up to now been a software
> interface.
> 
> The device in question has the following 4-part PCI IDs:
> 
> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
> 
> The patch currently needs no check for device ID, because the callback
> will never be made for devices that do not assert the capability or
> when run on a platform incapable of SR-IOV.
> 
> One reason for this patch is because the hardware requires the
> vendor ID of a VF to be the same as the vendor ID of the PF that
> created it. So it seemed logical to simply have a fully-functioning
> virtio_net PF create the VFs. This patch makes that possible.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v4: Dropped call to pci_disable_sriov in virtio_pci_remove function
> v5: Replaced call to pci_sriov_configure_unmanaged with
>         pci_sriov_configure_simple
> v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
> v7: No code change, added Reviewed-by
> 
>  drivers/virtio/virtio_pci_common.c |    1 +
>  1 file changed, 1 insertion(+)

Tested with the identified device.

Tested-by: Mark Rustad <mark.d.rustad@intel.com>

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_67787A4F-EC56-438D-B41A-B2FB4E4FBB45
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlq8CbsACgkQPA7/547j
7m7IXg/+IlfLEdVeKE9r7YPA/yg+kKRNuPXfNTEGfo9fobGLIys3pZpqNrkH6XO8
duZJE/XM481LgYhwwllX+WEUrfCnvwP/Kgaf5J3TA7HVOk8+0jCiuz3YcuPy+D1B
gMS5QsG/HyLjJpd8Qs72nS7uuGTgghVSMfwxvhk6kqbVt0MVumCrXffWsvEyKdpK
KHChBqKpbMix6Jt66bVg2vJpRWJEVg3dgdO34VdYAn0+N7WMygOLtsyPATqLvgl7
IWq3O2p2j91lyCn4u2QF4lc+Juye94PWHTgggXej670nNuJ+wwjCy0VZMvlZ+zCP
BKdBSnOuJU81Bp1Hrc6T5R6PVvoMgwJnqwm+JvsdCLM0dqw8MqubkmUZ4ZjKSnwY
qxGFHgMf+iuue2Se7Dcg5nv+z6rVf4xO7GuK8b874sI681tKGW5ETGQ+/Ws2pgIR
/n/HMcdWaaOsJ2fj9drCRlKxQIrMNFRgdDqyJeVaMpN5KrkwdMGY48QSgD7wV36E
7ZuKiQKFN58D9BmcECfrHN4WiP33aTmDPITD9leSGBdpw/YGZTm68T/+mxYcEbq1
GJNpQxuQ2eZaXdsBVchh1KQHkxEYhmhSgnrupvzi0uf3KM9CcliOg6IzAACYfkJv
+Q9+otsqaRp3ABczrGY26h7Riqrd3G4hSCqur/jNmQydxgMXFPo=
=KFIy
-----END PGP SIGNATURE-----

--Apple-Mail=_67787A4F-EC56-438D-B41A-B2FB4E4FBB45--
