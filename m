Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 15 Nov 2017 15:14:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
Message-ID: <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1510721808-27164-5-git-send-email-poza@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, okaya@codeaurora.org,
 linux-arm-kernel@lists.infradead.org, Dongdong Liu <liudongdong3@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 15, 2017 at 10:26:48AM +0530, Oza Pawandeep wrote:
> PCI Express Base Specification, Rev. 4.0 Version 0.9
> 6.2.10: Downstream Port Containment (DPC)
> 
> DPC is an optional normative feature of a Downstream Port. DPC halts PCI
> Express traffic below a Downstream Port after an unmasked uncorrectable
> error is detected at or below the Port, avoiding the potential spread of
> any data corruption, and permitting error recovery if supported by
> software
> 
> Triggering DPC disables its Link by directing the LTSSM to the Disabled
> state. Once the LTSSM reaches the Disabled state, it remains in that
> state until the DPC Trigger Status bit is Cleared
> 
> So when DPC service is active and registered to port driver, AER should
> not attempt to recover, since DPC will be removing downstream devices,
> and do the recovery.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 7448052..a9108ea 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -482,6 +482,27 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  }
>  
>  /**
> + * pcie_port_query_uptream_service - query upstream service
> + * @dev: pointer to a pci_dev data structure of agent detecting an error
> + * @service: service to be queried
> + *
> + * Invoked to know the status of the service for pci device.
> + */
> +static bool pcie_port_query_uptream_service(struct pci_dev *dev, u32 service)
> +{
> +	struct pci_dev *upstream_dev = dev;
> +
> +	do {
> +		if (pcie_port_query_service(upstream_dev, service))
> +			return true;
> +		upstream_dev = pcie_port_upstream_bridge(upstream_dev);
> +	} while (upstream_dev);
> +
> +	return false;
> +}
> +
> +
> +/**
>   * do_recovery - handle nonfatal/fatal error recovery process
>   * @dev: pointer to a pci_dev data structure of agent detecting an error
>   * @severity: error severity type
> @@ -495,6 +516,18 @@ static void do_recovery(struct pci_dev *dev, int severity)
>  	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
>  	enum pci_channel_state state;
>  
> +	/*
> +	 * If DPC is enabled, there is no need to attempt recovery.
> +	 * Since DPC disables its Link by directing the LTSSM to
> +	 * the Disabled state.
> +	 * DPC driver will take care of the recovery, there is no need
> +	 * for AER driver to race.
> +	 */
> +	if (pcie_port_query_uptream_service(dev, PCIE_PORT_SERVICE_DPC)) {
> +		dev_info(&dev->dev, "AER: Device recovery to be done by DPC\n");
> +		return;
> +	}

What happens without this test?

Does AER read registers from the now-disabled device and get ~0 data?
Or is AER reading registers from the port upstream from the disabled
device and trying to reset the device?

It looks like get_device_error_info() reads registers and doesn't
check to see whether it gets ~0 back.  I'm wondering if we *should* be
checking there and whether doing that would help mitigate the issue
here.

I don't really like the pcie_port_query_uptream_service() approach
(BTW, the name is misspelled) because it feels a little ad hoc and it
makes assumptions here in the AER code about what the DPC code is
doing, e.g., how it has configured PCI_EXP_DPC_CTL.

>  	if (severity == AER_FATAL)
>  		state = pci_channel_io_frozen;
>  	else
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
