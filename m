Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 24 Jul 2018 10:18:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Intel DC P3700 NVMe delay after FLR quirk
Message-ID: <20180724101849.36f635eb@t450s.home>
In-Reply-To: <20180724161446.2729.78211.stgit@gimli.home>
References: <20180724160440.2729.75178.stgit@gimli.home>
 <20180724161446.2729.78211.stgit@gimli.home>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Jul 2018 10:14:46 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Add a device specific reset for Intel DC P3700 NVMe device which
> exhibits a timeout failure in drivers waiting for the ready status to
> update after NVMe enable if the driver interacts with the device too
> quickly after FLR.  As this has been observed in device assignment
> scenarios, resolve this with a device specific reset quirk to add an
> additional, heuristically determined, delay after the FLR completes.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/quirks.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

I forgot to link the bz in this one, if this somehow becomes the final
version, please add:

Link: https://bugzilla.redhat.com/show_bug.cgi?id=159265

Thanks,
Alex
 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3899cdd2514b..08fafd804588 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3751,6 +3751,27 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +/*
> + * Intel DC P3700 NVMe controller will timeout waiting for ready status
> + * to change after NVMe enable if the driver starts interacting with the
> + * device too quickly after FLR.  A 250ms delay after FLR has heuristically
> + * proven to produce reliably working results for device assignment cases.
> + */
> +static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> +{
> +	if (!pcie_has_flr(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	pcie_flr(dev);
> +
> +	msleep(250);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -3759,6 +3780,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
> +	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
>  	{ 0 }
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
