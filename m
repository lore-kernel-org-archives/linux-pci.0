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
Subject: Re: [PATCH v2 07/15] usb: gadget: configfs: make config_item_type const
In-Reply-To: <1508167134-6243-8-git-send-email-bhumirks@gmail.com>
References: <1508167134-6243-1-git-send-email-bhumirks@gmail.com> <1508167134-6243-8-git-send-email-bhumirks@gmail.com>
Date: Tue, 17 Oct 2017 11:31:17 +0300
Message-ID: <87o9p6jhuy.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Bhumika Goyal <bhumirks@gmail.com> writes:

> Make config_item_type structures const as they are either passed to a
> function having the argument as const or stored in the const "ci_type"
> field of a config_item structure.
>
> Done using Coccinelle.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnlv9UACgkQzL64meEa
mQZQhg//Us3sJZUbfVmsAmf2IlBuez8wGH2V7mJtJCLYzgENwMbLQvD7E1nHjCTt
JkiH+zAtEB0xnD7/ZvUqxQTaZdiRQfw059PEzq7fntUcNiO6KhqiSuIpLKO/YyQq
dMrn13XN17iEC+ubTVquSnoi1h2s4UsUL5jlvFlYGIpuq3SW3rSqJkJDe6McTpgJ
nlNCRxF09UctuKVczbjurXyaJ7UmzXDxSyLJHBADq+jpByqpOBfcYEho3oEfsroc
7dd80z4cywzRJQ/Udho/AZ72qj18yWZvekBpHS9bUzLOUx8yDN7V20XTdmyeVtcg
0vxqraf7VNWQy82o32ptA2EfvfQ2j4GV5Kz3eYzapMF85qmarjAqlUwhtyKE2oiX
C6Udsm7h44322k7dmLQB8ZS8K/iVfYcgeOnr5koGw5ze7h2ajaAW8kADreVfeM52
NR+nBkC20gYUROtDe99YyJ3FnOwKrh5l4L6fT8qXBiaXN0QPotY98QROMAX3i3zl
62kOmbAnCjuxei/y5cApsuo874PSEz6lCOMa0hkvothqbS+kpq9dQQuI5EfSsAKu
jR46aG1rpMGlZNPWVzF+DaNaGat5CmbO4Y8LkbN4sU7qSunNkSbd4YgBB0pj9Dg6
52MwP7kUgqLasgz5fVvn9YXCIcqcEXWXsUADJh8+DrQkjXnOs+g=
=nx9P
-----END PGP SIGNATURE-----
--=-=-=--
