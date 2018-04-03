Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 3 Apr 2018 15:45:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
        arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net,
        dann.frazier@canonical.com, andy.shevchenko@gmail.com,
        robh@kernel.org, andriy.shevchenko@linux.intel.com,
        joe@perches.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de
Subject: Re: [PATCH v17 04/10] PCI: Apply the new generic I/O management on
 PCI IO hosts
Message-ID: <20180403134531.GD27789@ulmo>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
In-Reply-To: <1521051359-34473-5-git-send-email-john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 02:15:53AM +0800, John Garry wrote:
> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>=20
> After introducing the new generic I/O space management(Logical PIO), the
> original PCI MMIO relevant helpers need to be updated based on the new
> interfaces defined in logical PIO.
> This patch adapts the corresponding code to match the changes introduced
> by logical PIO.
>=20
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Tested-by: dann frazier <dann.frazier@canonical.com>
> ---
>  drivers/pci/pci.c        | 92 +++++++++---------------------------------=
------
>  include/asm-generic/io.h |  2 +-
>  2 files changed, 18 insertions(+), 76 deletions(-)

Today's linux-next regresses on NFS boot for Jetson TK1. I was able to
bisect it to this commit. I'll comment below for where I think this is
buggy.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3f30b7d..09c2490 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -22,6 +22,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/log2.h>
> +#include <linux/logic_pio.h>
>  #include <linux/pci-aspm.h>
>  #include <linux/pm_wakeup.h>
>  #include <linux/interrupt.h>
> @@ -3436,17 +3437,6 @@ int pci_request_regions_exclusive(struct pci_dev *=
pdev, const char *res_name)
>  }
>  EXPORT_SYMBOL(pci_request_regions_exclusive);
> =20
> -#ifdef PCI_IOBASE
> -struct io_range {
> -	struct list_head list;
> -	phys_addr_t start;
> -	resource_size_t size;
> -};
> -
> -static LIST_HEAD(io_range_list);
> -static DEFINE_SPINLOCK(io_range_lock);
> -#endif
> -
>  /*
>   * Record the PCI IO range (expressed as CPU physical address + size).
>   * Return a negative value if an error has occured, zero otherwise
> @@ -3454,51 +3444,28 @@ struct io_range {
>  int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
>  			resource_size_t	size)
>  {
> -	int err =3D 0;
> -
> +	int ret =3D 0;
>  #ifdef PCI_IOBASE
> -	struct io_range *range;
> -	resource_size_t allocated_size =3D 0;
> -
> -	/* check if the range hasn't been previously recorded */
> -	spin_lock(&io_range_lock);
> -	list_for_each_entry(range, &io_range_list, list) {
> -		if (addr >=3D range->start && addr + size <=3D range->start + size) {
> -			/* range already registered, bail out */
> -			goto end_register;
> -		}
> -		allocated_size +=3D range->size;
> -	}
> +	struct logic_pio_hwaddr *range;
> =20
> -	/* range not registed yet, check for available space */
> -	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
> -		/* if it's too big check if 64K space can be reserved */
> -		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
> -			err =3D -E2BIG;
> -			goto end_register;
> -		}
> -
> -		size =3D SZ_64K;
> -		pr_warn("Requested IO range too big, new size set to 64K\n");
> -	}
> +	if (!size || addr + size < addr)
> +		return -EINVAL;
> =20
> -	/* add the range to the list */
>  	range =3D kzalloc(sizeof(*range), GFP_ATOMIC);
> -	if (!range) {
> -		err =3D -ENOMEM;
> -		goto end_register;
> -	}
> +	if (!range)
> +		return -ENOMEM;
> =20
> -	range->start =3D addr;
> +	range->fwnode =3D fwnode;
>  	range->size =3D size;
> +	range->hw_start =3D addr;
> +	range->flags =3D LOGIC_PIO_CPU_MMIO;
> =20
> -	list_add_tail(&range->list, &io_range_list);
> -
> -end_register:
> -	spin_unlock(&io_range_lock);
> +	ret =3D logic_pio_register_range(range);

This ends up returning -EFAULT at some point, causing the driver's
(pci-tegra.c) ->probe() to fail.

Let me comment on a prior patch to pinpoint what exactly goes wrong.

Thierry

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrDhXkACgkQ3SOs138+
s6F7pg/8CQFtf5RHxNaZb5V8K1P/lB1HG4URViYpzlooy/NUaLxFjjlBaCBc6glR
mviQR2CzLpKIjDs4OvkNs+oQXVNVAf9kT3dl3cvMtXadgXbnm2NhnHlkQdv5fve2
4V1F2aOFfGj3T/jH4+o63yZ7eJ7DzgCaFUoeHYH6O4S80Uk4gK9iNTFNEApMO6uF
14M6yAJsPU+mn69JyGLkADSYJej5XoT7keCc9IyBArBonn2TCsI9Wl4xURp4cW3h
a8I9Ts2KzVP4TtZ0Qm0SBXsVF7anf5/ukHGbnSBEOclRSO6ojxJQAcnZjrQt/uez
0Uc3QdowmC4X3BRVv2NCRth8dfK255GDffobVs5cgd4PjdrZSonRpYpP9Cy27Nu4
01uO568zENdGXVmjEZduh0F+XBauBD4k8EkfEKBnD4wKfZUkflv0mY8ATJ51+XcL
uxeFXtxNhIskdr4oZy3bVpjNRO1OXugaiqx98h7hhfwLAK1w6gu8XMgvP2CFqVIP
AvugRZdf1oxrupeLDatJwe/IGCUplUD9zki6SPk7AtZuDJUop0b+OLp9PNiCDiTw
0PPZfhMKErlpepAaACNzk5B4Xs8LFyy5L9K+VVtwLXLn104E9i0H5l7b5isNnHrH
DYFas4uAeDTtQA5U96J1OSwA64mFAGOjKLAxlCpwnRt8z0yDuqY=
=/ZDM
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
