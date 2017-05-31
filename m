Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 31 May 2017 06:43:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: Re: [PATCH] PCI/PM: Set D3 power state only if the end device
 supports it.
Message-ID: <20170531064340.0dcec477@w520.home>
In-Reply-To: <1496230412-19028-1-git-send-email-gakula@caviumnetworks.com>
References: <1496230412-19028-1-git-send-email-gakula@caviumnetworks.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 geethasowjanya.akula@gmail.com, robert.richter@cavium.com, jcm@redhat.com,
 bhelgaas@google.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 31 May 2017 17:03:32 +0530
Geetha sowjanya <gakula@caviumnetworks.com> wrote:

> Pci driver doesn't check if the device supports D3hot/D3cold power states 
> while setting these power states. The device that doesn't support these 
> states will fail when a driver like vfio try to do D0->D3 power transition.


That's because support for D0 and D3 device states is REQUIRED by the
PCIe spec (Rev 3.1a, 7.6).  Is this yet more non-spec compliance?
Thanks,

Alex

 
> This patch adds a check that allows to set D3 power state only
> for the supported devices.
> 
> Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
> ---
>  drivers/pci/pci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 563901c..cadd046 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -661,7 +661,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  
>  	/* check if this device supports the desired state */
>  	if ((state == PCI_D1 && !dev->d1_support)
> -	   || (state == PCI_D2 && !dev->d2_support))
> +	   || (state == PCI_D2 && !dev->d2_support)
> +	   || (state == PCI_D3hot && !pci_pme_capable(dev, state)))
>  		return -EIO;
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
