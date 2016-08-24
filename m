Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 24 Aug 2016 11:47:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Omer Khaliq <okhaliq@caviumnetworks.com>
Subject: Re: [PATCH v2 1/2] PCI: quirk fixup for cavium invalid sriov link
 value.
Message-ID: <20160824164736.GA23914@localhost>
References: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
 <1471994835-2423-2-git-send-email-okhaliq@caviumnetworks.com>
MIME-Version: 1.0
In-Reply-To: <1471994835-2423-2-git-send-email-okhaliq@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: herbert@gondor.apana.org.au, David.Daney@cavium.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ananth.Jasty@cavium.com, linux-crypto@vger.kernel.org, mpm@selenic.com,
 bhelgaas@google.com, clabbe.montjoie@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 04:27:14PM -0700, Omer Khaliq wrote:
> From: Ananth Jasty <Ananth.Jasty@cavium.com>
> 
> Cavium cn88xx hardware presents an incorrect SR-IOV Function
> Dependency Link, add a fixup quirk for the affected devices.
> 
> Acked-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Ananth Jasty <Ananth.Jasty@cavium.com>
> Signed-off-by: Omer Khaliq <okhaliq@caviumnetworks.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you update this patch for any reason, please update the subject
like this:

  -PCI: quirk fixup for cavium invalid sriov link value.
  +PCI: Fix incorrect Cavium cn8xx SR-IOV Function Dependency Link

This will make "git log --oneline drivers/pci/quirks.c" show more
useful information and look more consistent.

I assume somebody else will merge this patch along with your HWRNG
driver.

> ---
>  drivers/pci/quirks.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 37ff015..5980aae 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -834,6 +834,17 @@ static void quirk_amd_ioapic(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
>  #endif /* CONFIG_X86_IO_APIC */
>  
> +#ifdef CONFIG_ARM64
> +
> +static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
> +{
> +	/* Fix for improper SRIOV configuration on Cavium cn88xx  RNM device */
> +	if (dev->subsystem_device == 0xa118)
> +		dev->sriov->link = dev->devfn;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa018, quirk_cavium_sriov_rnm_link);
> +#endif
> +
>  /*
>   * Some settings of MMRBC can lead to data corruption so block changes.
>   * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
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
