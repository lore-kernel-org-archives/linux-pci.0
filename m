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
References: <20170629032648.3073-1-logang@deltatee.com> <20170629032648.3073-13-logang@deltatee.com>
In-Reply-To: <20170629032648.3073-13-logang@deltatee.com>
Subject: RE: [PATCH 12/16] switchtec_ntb: add link management
Date: Thu, 29 Jun 2017 14:11:51 -0400
Message-ID: <000201d2f103$2f3d2d20$8db78760$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> switchtec_ntb checks for a link by looking at the shared memory
> window. If the magic number is correct and the otherside indicates
> their link is enabled then we take the link to be up.
>=20
> Whenever we change our local link status we send a msg to the
> otherside to check whether it's up and change their status.
>=20
> The current status is maintained in a flag so ntb_is_link_up
> can return quickly.
>=20
> We utilize switchtec's link status notifier to also check link changes
> when the switch notices a port changes state.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 130 =
+++++++++++++++++++++++++++++++++++-
>  1 file changed, 129 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c =
b/drivers/ntb/hw/mscc/switchtec_ntb.c
> index 0587b2380bcc..8ef84d45bda6 100644
> --- a/drivers/ntb/hw/mscc/switchtec_ntb.c
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -64,6 +64,7 @@ static inline void _iowrite64(u64 val, void __iomem =
*mmio)
>=20
>  struct shared_mw {
>  	u32 magic;
> +	u32 link_sta;
>  	u32 partition_id;
>  	u16 nr_direct_mw;
>  	u16 nr_lut_mw;
> @@ -102,8 +103,17 @@ struct switchtec_ntb {
>  	int nr_direct_mw;
>  	int nr_lut_mw;
>  	int direct_mw_to_bar[MAX_DIRECT_MW];
> +
> +	bool link_is_up;
> +	enum ntb_speed link_speed;
> +	enum ntb_width link_width;
>  };
>=20
> +static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
> +{
> +	return container_of(ntb, struct switchtec_ntb, ntb);
> +}
> +
>  static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
>  				 struct ntb_ctrl_regs __iomem *ctl,
>  				 u32 op, int wait_status)
> @@ -161,6 +171,17 @@ static int switchtec_ntb_part_op(struct =
switchtec_ntb *sndev,
>  	return -EIO;
>  }
>=20
> +static int switchtec_ntb_send_msg(struct switchtec_ntb *sndev, int =
idx,
> +				  u32 val)
> +{
> +	if (idx < 0 || idx >=3D ARRAY_SIZE(sndev->mmio_self_dbmsg->omsg))
> +		return -EINVAL;
> +
> +	iowrite32(val, &sndev->mmio_self_dbmsg->omsg[idx].msg);
> +
> +	return 0;
> +}
> +
>  static int switchtec_ntb_mw_count(struct ntb_dev *ntb, int pidx)
>  {
>  	return 0;
> @@ -192,22 +213,124 @@ static int =
switchtec_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	return 0;
>  }
>=20
> +static void switchtec_ntb_part_link_speed(struct switchtec_ntb =
*sndev,
> +					  int partition,
> +					  enum ntb_speed *speed,
> +					  enum ntb_width *width)
> +{
> +	struct switchtec_dev *stdev =3D sndev->stdev;
> +
> +	u32 pff =3D =
ioread32(&stdev->mmio_part_cfg[partition].vep_pff_inst_id);
> +	u32 linksta =3D =
ioread32(&stdev->mmio_pff_csr[pff].pci_cap_region[13]);
> +
> +	if (speed)
> +		*speed =3D (linksta >> 16) & 0xF;
> +
> +	if (width)
> +		*width =3D (linksta >> 20) & 0x3F;
> +}
> +
> +static void switchtec_ntb_set_link_speed(struct switchtec_ntb *sndev)
> +{
> +	enum ntb_speed self_speed, peer_speed;
> +	enum ntb_width self_width, peer_width;
> +
> +	if (!sndev->link_is_up) {
> +		sndev->link_speed =3D NTB_SPEED_NONE;
> +		sndev->link_width =3D NTB_WIDTH_NONE;
> +		return;
> +	}
> +
> +	switchtec_ntb_part_link_speed(sndev, sndev->self_partition,
> +				      &self_speed, &self_width);
> +	switchtec_ntb_part_link_speed(sndev, sndev->peer_partition,
> +				      &peer_speed, &peer_width);

Should we only set self_partition?  I think each peer should be able to =
set preferred speed, and negotiate down.  As written here, the last peer =
to set the speed overrides the setting on the peer, and even that is not =
atomic if they race.

> +
> +	sndev->link_speed =3D min(self_speed, peer_speed);
> +	sndev->link_width =3D min(self_width, peer_width);
> +}
> +
> +enum {
> +	LINK_MESSAGE =3D 0,
> +	MSG_LINK_UP =3D 1,
> +	MSG_LINK_DOWN =3D 2,
> +	MSG_CHECK_LINK =3D 3,
> +};
> +
> +static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
> +{
> +	int link_sta;
> +	int old =3D sndev->link_is_up;
> +
> +	link_sta =3D sndev->self_shared->link_sta;
> +	if (link_sta) {
> +		u64 peer =3D ioread64(&sndev->peer_shared->magic);
> +
> +		if ((peer & 0xFFFFFFFF) =3D=3D SWITCHTEC_NTB_MAGIC)
> +			link_sta =3D peer >> 32;
> +		else
> +			link_sta =3D 0;
> +	}
> +
> +	sndev->link_is_up =3D link_sta;
> +	switchtec_ntb_set_link_speed(sndev);
> +
> +	if (link_sta !=3D old) {
> +		switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_CHECK_LINK);
> +		ntb_link_event(&sndev->ntb);
> +		dev_info(&sndev->stdev->dev, "ntb link %s",
> +			 link_sta ? "up" : "down");
> +	}
> +}
> +
> +static void switchtec_ntb_link_notification(struct switchtec_dev =
*stdev)
> +{
> +	struct switchtec_ntb *sndev =3D stdev->sndev;
> +
> +	switchtec_ntb_check_link(sndev);
> +}
> +
>  static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
>  				    enum ntb_speed *speed,
>  				    enum ntb_width *width)
>  {
> -	return 0;
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	if (speed)
> +		*speed =3D sndev->link_speed;
> +	if (width)
> +		*width =3D sndev->link_width;
> +
> +	return sndev->link_is_up;
>  }
>=20
>  static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
>  				     enum ntb_speed max_speed,
>  				     enum ntb_width max_width)
>  {
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	dev_dbg(&sndev->stdev->dev, "enabling link");
> +
> +	sndev->self_shared->link_sta =3D 1;
> +	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
> +
> +	switchtec_ntb_check_link(sndev);
> +
>  	return 0;
>  }
>=20
>  static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
>  {
> +	struct switchtec_ntb *sndev =3D ntb_sndev(ntb);
> +
> +	dev_dbg(&sndev->stdev->dev, "disabling link");
> +
> +	sndev->self_shared->link_sta =3D 0;
> +	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
> +
> +	switchtec_ntb_check_link(sndev);
> +
>  	return 0;
>  }
>=20
> @@ -555,6 +678,9 @@ static irqreturn_t switchtec_ntb_message_isr(int =
irq, void *dev)
>  			dev_dbg(&sndev->stdev->dev, "message: %d %08x\n", i,
>  				(u32)msg);
>  			iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);
> +
> +			if (i =3D=3D LINK_MESSAGE)
> +				switchtec_ntb_check_link(sndev);
>  		}
>  	}
>=20
> @@ -659,6 +785,7 @@ static int switchtec_ntb_add(struct device *dev,
>  		goto deinit_and_exit;
>=20
>  	stdev->sndev =3D sndev;
> +	stdev->link_notifier =3D switchtec_ntb_link_notification;
>  	dev_info(dev, "NTB device registered");
>=20
>  	return 0;
> @@ -682,6 +809,7 @@ void switchtec_ntb_remove(struct device *dev,
>  	if (!sndev)
>  		return;
>=20
> +	stdev->link_notifier =3D NULL;
>  	stdev->sndev =3D NULL;
>  	ntb_unregister_device(&sndev->ntb);
>  	switchtec_ntb_deinit_db_msg_irq(sndev);
> --
> 2.11.0
