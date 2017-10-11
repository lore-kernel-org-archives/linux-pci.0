Return-Path: <SRS0=ztmW=BK=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=ztmW=BK=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dongdong Liu' <liudongdong3@huawei.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	"charles.chenxin@huawei.com" <charles.chenxin@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH V4 2/2] PCI/portdrv: Add #defines for the AER and DPC
 Interrupt Message Number masks
Date: Wed, 11 Oct 2017 13:01:26 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0091277@AcuExch.aculab.com>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
 <1507719178-112556-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1507719178-112556-3-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Dongdong Liu
> Sent: 11 October 2017 11:53
> In the AER case, the mask isn't strictly necessary because there are no
> higher-order bits above the Interrupt Message Number, but using a #define
> will make it possible to grep for it.
>=20
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 4 ++--
>  include/uapi/linux/pci_regs.h   | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_c=
ore.c
> index 9692379..2b48297 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -116,7 +116,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *d=
ev, int *irqs, int mask)
>  		 */
>  		pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> -		entry =3D reg32 >> 27;
> +		entry =3D (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;

You've still got the hard coded 27 - which is almost more important than th=
e mask.
Perhaps define things so this is:
		entry =3D PCI_ERR_ROOT_AER_IRQ(reg32);

Think I'd shift then mask with 0x1f.

	David
