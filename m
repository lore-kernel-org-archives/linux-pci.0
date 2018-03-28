Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "netanel@amazon.com" <netanel@amazon.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "mheyne@amazon.de" <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "hch@lst.de" <hch@lst.de>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [virtio-dev] [pci PATCH v7 1/5] pci: Add
 pci_sriov_configure_simple for PFs that don't manage VF resources
Date: Wed, 28 Mar 2018 21:30:29 +0000
Message-ID: <C573B44F-097F-45D2-AB4C-B8BCCBCC2C4F@intel.com>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184055.3102.2435.stgit@localhost.localdomain>
In-Reply-To: <20180315184055.3102.2435.stgit@localhost.localdomain>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BBED0712-6906-4470-94B1-31A72AA8A265";
        protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_BBED0712-6906-4470-94B1-31A72AA8A265
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2018, at 11:41 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds a common configuration function called
> pci_sriov_configure_simple that will allow for managing VFs on devices
> where the PF is not capable of managing VF resources.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v5: New patch replacing pci_sriov_configure_unmanaged with
>       pci_sriov_configure_simple
>     Dropped bits related to autoprobe changes
> v6: Defined pci_sriov_configure_simple as NULL if IOV is disabled
> v7: Updated pci_sriov_configure_simple to drop need for err value
>     Fixed comment explaining why pci_sriov_configure_simple is NULL
> 
>  drivers/pci/iov.c   |   31 +++++++++++++++++++++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 34 insertions(+)

Tested with the device identified in patch #2.

Tested-by: Mark Rustad <mark.d.rustad@intel.com>

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_BBED0712-6906-4470-94B1-31A72AA8A265
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlq8CXQACgkQPA7/547j
7m6pew/8CP45+0ywjt3/o6XIMCG2lY8I4kEyzMy+qDRd6Enk2kQkcORMhSxNOrwF
MXK7CSa01s3Y0AwjHuy+0d+/jDvxyUGuhw0Tb98DkL3T9OQDhgCuTPTC8/wu9XYS
AoACL8alz4pouJM/P9VT24pGIkwbEWl0bE/LZ0fZvhOkVjLBp6f3E5aqgcMZlI4V
uAEDdP/AHdessoOktzRWxmlEFJdBN/TDkobLM0I+ipI2VIJh+Wu8n2Cb9nT9ZrFz
bgOVdwJMloky6CF23XHu/R+vrfmtQJf7/OKpI63it2ryX9g0c2ZKTw3RhqrBCR+c
470ZslFbxfQTMNZnI/+6pU5/mriHtEuN+X/Pyr0UVgjDezjtiId9bwNxbRUsZrvF
MvzfHBixgYmtRa+cBguiV48qfkWrfXdmhteqYta786+Tr0zvKX833WAydO+/V6bx
ZiBaZEa3LoSuOhGbzRjPxyMIy6nrkVYKvulm/N1G4iTzgs1Lj5heWiH6onW1y32o
sLyEYpLVLHAEGVtHEUTxJU4xIbyW5hvY/dUqjOiXnvcIdP7yc+bo9s3kLiuEVn81
r8/VkR1W6+q1r5J/ED9iWEt7D7BkOBdH9THRIQIDq3O1vSzX6m+Pvhw2mjLcsY9U
A5ABZsKAF+7gYtNlM4X5bl8tXhzNOJo4pP7zAHTOqffxeOIYD0A=
=39ai
-----END PGP SIGNATURE-----

--Apple-Mail=_BBED0712-6906-4470-94B1-31A72AA8A265--
