Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1366038686.2918.101.camel@bling.home>
Subject: Re: [PATCH -v2] PCI/VFIO: use pcie_flags_reg instead of access
 PCI-E Capabilities Register
From: Alex Williamson <alex.williamson@redhat.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	jiang.liu@huawei.com
Date: Mon, 15 Apr 2013 09:11:26 -0600
In-Reply-To: <1364867547-15300-1-git-send-email-wangyijing@huawei.com>
References: <1364867547-15300-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-04-02 at 09:52 +0800, Yijing Wang wrote:
> Currently, we use pcie_flags_reg to cache PCI-E Capabilities Register,
> because PCI-E Capabilities Register bits are almost read-only. This patch
> use pcie_caps_reg() instead of another access PCI-E Capabilities Register.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index aeb00fc..12a81f7 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1017,13 +1017,9 @@ static int vfio_cap_len(struct vfio_pci_device *vdev, u8 cap, u8 pos)
>  		return byte;
>  	case PCI_CAP_ID_EXP:
>  		/* length based on version */
> -		ret = pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &word);
> -		if (ret)
> -			return pcibios_err_to_errno(ret);
> -
>  		vdev->extended_caps = true;
>  
> -		if ((word & PCI_EXP_FLAGS_VERS) == 1)
> +		if ((pcie_caps_reg(pdev) & PCI_EXP_FLAGS_VERS) == 1)
>  			return PCI_CAP_EXP_ENDPOINT_SIZEOF_V1;
>  		else
>  			return PCI_CAP_EXP_ENDPOINT_SIZEOF_V2;

Applied.  Thanks!

Alex

