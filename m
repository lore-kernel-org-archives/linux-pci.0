Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Oct 2017 17:06:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 4/5] PCI: wait device ready after pci_pm_reset()
Message-ID: <20171011220625.GV25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1506212218-29103-4-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 23, 2017 at 08:16:57PM -0400, Sinan Kaya wrote:
> Rev 3.1 Sec 2.3.1 Request Handling Rules says a device can issue CRS
> following a D3hot->D0 transition. Add pci_dev_wait() call with 1 second
> timeout to see if device is available before returning.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fd4a3b6..074adf9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3963,6 +3963,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>   */
>  static int pci_pm_reset(struct pci_dev *dev, int probe)
>  {
> +	unsigned int delay = dev->d3_delay;
>  	u16 csr;
>  
>  	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
> @@ -3988,7 +3989,10 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>  	pci_dev_d3_sleep(dev);
>  
> -	return 0;
> +	if (delay < pci_pm_d3_delay)
> +		delay = pci_pm_d3_delay;
> +
> +	return pci_dev_wait(dev, "PM D3->D0", delay, 1000);

1) Why do we wait up to 1 second here, when we wait up to 60 seconds
for the other methods?  Can they all be the same?  Maybe a #define for
it?

2) I don't really like the fact that we do the initial sleep one place
and then pass the length of that sleep here.  It's hard to verify
they're the same and keep them in sync.  I think the only thing you
use initial_wait for is to include that time in the dmesg messages.
Maybe we should just omit that time from the message and drop the
parameter?

>  }
>  
>  void pci_reset_secondary_bus(struct pci_dev *dev)
> -- 
> 1.9.1
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
