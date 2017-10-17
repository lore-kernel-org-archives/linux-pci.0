Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 13:56:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        alexander.shishkin@linux.intel.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, hch@lst.de, sagi@grimberg.me,
        kishon@ti.com, bhelgaas@google.com, nab@linux-iscsi.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com, jlbec@evilplan.org,
        ccaulfie@redhat.com, teigland@redhat.com, mfasheh@versity.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] RDMA/cma: make config_item_type const
Message-ID: <20171017105641.GN2106@mtr-leonro.local>
References: <1508167134-6243-1-git-send-email-bhumirks@gmail.com>
 <1508167134-6243-13-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qhD8kUEc5MK9MdKG"
In-Reply-To: <1508167134-6243-13-git-send-email-bhumirks@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--qhD8kUEc5MK9MdKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 16, 2017 at 05:18:51PM +0200, Bhumika Goyal wrote:
> Make these structures const as they are either passed to the functions
> having the argument as const or stored as a reference in the "ci_type"
> const field of a config_item structure.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> * Changes in v2- Combine all the followup patches and the constification
> patches into a series.
>
>  drivers/infiniband/core/cma_configfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--qhD8kUEc5MK9MdKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlnl4ekACgkQ5GN7iDZy
WKeXjhAAianTJjpS3Q7Amt68dVak+Zy2iyjm1IkgvBu0u2FdrPHb15D8sEr4jOg+
NxfJ4zH+C2fgBYvEXa9+aEIb72WSQHQoA1G8EKdfP+D6ci1eHZ60yG7sxmMi2Bsr
4hCGCe/KiiftWsk47Y7KBrHj92HusNRTcM48a1wYNUoAmHq4fRjLyhL8uIVsXl3o
Af/DvQP4d37U9UHMFiekaFgT2K0TfHK1uKUSB7AMvxVb9U+FZFKEXnq6Vcp45uZY
1FzTXYbSC0ckAFd+iYDxly3lsSAekPa5rUV+MLSwKOATP3vksOh+tQ1prJMnT1Kf
QVsN6lRqTTLMmrM1QgRvkT6PjhAQo6qcNgAfkCQjK4V6s9FQdJg95japfefDz6rq
BTwez0ekKroiVtO/8bcJNyDXCpRKNH9EZuQzRL9gqddhe8/xaqc9VrJHDuH93p1q
NimWkby6EiDvXhnGuEaO7P5gmubTbgx+D26n+g9XDPML5orUX2DZ1H6DBD4YR6/h
4BjPfk2eL92oXLLM88PPFf60ctQ8VIgiVq7oUEfBL3QLwFv0NQoZsOTilPrucJiW
lHe1J1t8FO/mDMb4jFXsbeQi8mmKX5ICCwwMKt8Fw9NRzN/mXqRpnC4jzQ13qbKT
viWVz2ZixqgMKLCGUfstRliyiIFmBZhoBNMf2SYEGS+yAOUYca8=
=kyDA
-----END PGP SIGNATURE-----

--qhD8kUEc5MK9MdKG--
