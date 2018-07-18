Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 18 Jul 2018 17:30:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH V5 5/6] PCI: Deprecate pci_reset_bus() and
 pci_reset_slot() functions
Message-ID: <20180718223027.GI128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
 <1530572336-20296-6-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1530572336-20296-6-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 02, 2018 at 06:58:54PM -0400, Sinan Kaya wrote:
> pci_reset_bus() and pci_reset_slot() functions are not being used by
> any code. Remove them from the kernel in favor of pci_try_reset_bus()
> and pci_try_reset_slot() functions.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c   | 55 ++---------------------------------------------------
>  include/linux/pci.h |  2 --
>  2 files changed, 2 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a31e6db..7e3f2e9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4784,9 +4784,9 @@ int pci_probe_reset_slot(struct pci_slot *slot)
>  EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>  
>  /**
> - * pci_reset_slot - reset a PCI slot
> + * __pci_try_reset_slot - Try to reset a PCI slot
>   * @slot: PCI slot to reset
> - *
> + *`

Is this "*`" intentional or a typo?  I can't find it in kernel-doc.rst
(but it's full of ` and maybe I missed it).

I do see a few other occurrences in the code, although they look like
typos to me:

  $ git grep "\*\`" | grep -v Documentation
  arch/mips/cavium-octeon/octeon-usb.c:	 *`	0x1 = Big endian
  arch/mips/cavium-octeon/octeon-usb.c:	 *`	0x1 = Big endian
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:/*`

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
