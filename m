Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>
References: <20170629032648.3073-1-logang@deltatee.com> <20170629032648.3073-15-logang@deltatee.com>
In-Reply-To: <20170629032648.3073-15-logang@deltatee.com>
Subject: RE: [PATCH 14/16] switchtec_ntb: implement scratchpad registers
Date: Thu, 29 Jun 2017 14:11:40 -0400
Message-ID: <000001d2f103$291602f0$7b4208d0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> Seeing there is no dedicated hardware for this, we simply add
> these as entries in the shared memory window. Thus, we could support
> any number of them but 128 seems like enough, for now.

Scratchpads are not natively supported by this hardware,
 - but the hardware does natively support more than two ntb ports,
 - but this software substitute for scratchpads looks like it only works =
with two ntb ports:

> +	if (pidx !=3D NTB_DEF_PEER_IDX)
> +		return -EINVAL;

This could get in the way of letting the driver support more than two =
ports later on.  Is there already a plan to change this to support more =
than two ports?

This is also not the only hardware to lack scratchpads, but does have =
memory windows.  Wouldn't it be better for a software substitute like =
this to be done in a way that it is not tied to a specific hardware =
driver?

>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 75 =
++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c =
b/drivers/ntb/hw/mscc/switchtec_ntb.c
> index 980acf2e5b42..a42e80742b52 100644
> --- a/drivers/ntb/hw/mscc/switchtec_ntb.c
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -69,6 +69,7 @@ struct shared_mw {
>  	u16 nr_direct_mw;
>  	u16 nr_lut_mw;
>  	u64 mw_sizes[MAX_MWS];
> +	u32 spad[128];
>  };
>=20
>  #define MAX_DIRECT_MW ARRAY_SIZE(((struct ntb_ctrl_regs =
*)(0))->bar_entry)
> @@ -453,22 +454,90 @@ static int switchtec_ntb_peer_db_set(struct =
ntb_dev *ntb, u64 db_bits)
>=20
>  static int switchtec_ntb_spad_count(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	return ARRAY_SIZE(sndev->self_shared->spad);
>  }
>=20
>  static u32 switchtec_ntb_spad_read(struct ntb_dev *ntb, int idx)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	if (idx < 0 || idx >=3D ARRAY_SIZE(sndev->self_shared->spad))
> +		return 0;
> +
> +	if (!sndev->self_shared)
> +		return 0;
> +
> +	return sndev->self_shared->spad[idx];
>  }
>=20
>  static int switchtec_ntb_spad_write(struct ntb_dev *ntb, int idx, u32 =
val)
>  {
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	if (idx < 0 || idx >=3D ARRAY_SIZE(sndev->self_shared->spad))
> +		return -EINVAL;
> +
> +	if (!sndev->self_shared)
> +		return -EIO;
> +
> +	sndev->self_shared->spad[idx] =3D val;
> +
>  	return 0;
>  }
>=20
> +static u32 switchtec_ntb_peer_spad_read(struct ntb_dev *ntb, int =
pidx,
> +					int sidx)
> +{
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	if (pidx !=3D NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	if (sidx < 0 || sidx >=3D ARRAY_SIZE(sndev->peer_shared->spad))
> +		return 0;
> +
> +	if (!sndev->peer_shared)
> +		return 0;
> +
> +	return ioread32(&sndev->peer_shared->spad[sidx]);
> +}
> +
>  static int switchtec_ntb_peer_spad_write(struct ntb_dev *ntb, int =
pidx,
>  					 int sidx, u32 val)
>  {
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	if (pidx !=3D NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	if (sidx < 0 || sidx >=3D ARRAY_SIZE(sndev->peer_shared->spad))
> +		return -EINVAL;
> +
> +	if (!sndev->peer_shared)
> +		return -EIO;
> +
> +	iowrite32(val, &sndev->peer_shared->spad[sidx]);
> +
> +	return 0;
> +}
> +
> +static int switchtec_ntb_peer_spad_addr(struct ntb_dev *ntb, int =
pidx,
> +					int sidx, phys_addr_t *spad_addr)
> +{
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +	unsigned long offset;
> +
> +	if (pidx !=3D NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	offset =3D (unsigned long)&sndev->peer_shared->spad[sidx] -
> +		(unsigned long)sndev->stdev->mmio;
> +
> +	if (spad_addr)
> +		*spad_addr =3D pci_resource_start(ntb->pdev, 0) + offset;
> +
>  	return 0;
>  }
>=20
> @@ -494,7 +563,9 @@ static const struct ntb_dev_ops switchtec_ntb_ops =
=3D {
>  	.spad_count		=3D switchtec_ntb_spad_count,
>  	.spad_read		=3D switchtec_ntb_spad_read,
>  	.spad_write		=3D switchtec_ntb_spad_write,
> +	.peer_spad_read		=3D switchtec_ntb_peer_spad_read,
>  	.peer_spad_write	=3D switchtec_ntb_peer_spad_write,
> +	.peer_spad_addr		=3D switchtec_ntb_peer_spad_addr,
>  };
>=20
>  static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
> --
> 2.11.0
