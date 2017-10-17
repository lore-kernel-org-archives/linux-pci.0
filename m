Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Felipe Balbi <balbi@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        rjw@rjwysocki.net, lenb@kernel.org,
        alexander.shishkin@linux.intel.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, hch@lst.de, sagi@grimberg.me,
        kishon@ti.com, bhelgaas@google.com, nab@linux-iscsi.org,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        jlbec@evilplan.org, ccaulfie@redhat.com, teigland@redhat.com,
        mfasheh@versity.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH v2 02/15] usb: gadget: make config_item_type structures const
In-Reply-To: <1508167134-6243-3-git-send-email-bhumirks@gmail.com>
References: <1508167134-6243-1-git-send-email-bhumirks@gmail.com> <1508167134-6243-3-git-send-email-bhumirks@gmail.com>
Date: Tue, 17 Oct 2017 11:30:34 +0300
Message-ID: <87r2u2jhw5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Bhumika Goyal <bhumirks@gmail.com> writes:
> Make these structures const as they are only passed to the const
> argument of the functions config_{group/item}_init_type_name.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> * Changes in v2- Combine all the followup patches and the constification
> patches into a series.

I'm assuming this depends on patch 1 of the series. In that case:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnlv6oACgkQzL64meEa
mQZAHBAAzevMuWnGzq3NbozQhxU/Ze7hjSKUUwpDeh5lig3COHhuUW8dbW95O5wr
pEcJCpPztIvXkmT6umC0Z+L3+ylkvRKpBRUimhe212PG7LWY4XKlQF4Jjscvs0Fg
84GPDsoYiGMrsfrZ1TLUj70y6gl4W/ft3c9FiVkxCN4F0w/a7lGYykKMBSX6WGVe
Zu7YEnSWom4D9irkkCl4gUCA31IKsCzz6JnR+S0nN7tQiKDzXIuhmCjE9UimABsm
L1nJ6fv/t5D+1SWmJg6IV3/HsoXFahjgdX0OevIZNCyVRHjSmjjOC9DNl8FU9K49
UEnm/lMrL8pEHbuGeahmKG/iuFxG3COxtY4kzHH2vJ22su/nHk8qDkBzB+cItxO0
iZ5tQhr555dQxfICJuTvg9UKcsj/oNyYuXDTUZbgX4+dKYxCJrfc8jt33gnz9z6O
1KTL6iQlhXEHS4fNgaSVktpyMzDJd3aws3i9ota2bp+zr8PSmcrXgLP20WOEKs/W
TsmCN+RCfgw9rdVro1D7cEOvMwBBoDxGzjA1MX1q61J/BVzgAd5pqE6ILQgQtmFh
6gBh0y1Pde6xDWU6J+rNXFOru21gK9iiTUA3/M2Kfci9DBk+GWtPGGV8R9ovnTzC
R6p5tT+Rtm0ns7aHybs0HsX4Zh0HsZAF/z3sps1IiMUeBdq25QI=
=q5aO
-----END PGP SIGNATURE-----
--=-=-=--
