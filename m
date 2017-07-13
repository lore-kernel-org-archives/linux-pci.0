Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Jul 2017 06:29:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
Message-ID: <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
References: <20170712050811.3620-1-dja@axtens.net>
 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Airlie <airlied@linux.ie>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Rongrong Zou <zourongrong@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ben, David, Daniel, Alex]

On Thu, Jul 13, 2017 at 10:29:25AM +0000, Gabriele Paoloni wrote:
> Hi Bjorn, Daniel
> 
> [...]
> 
> > 
> > Is this quirk useful on any arch other than arm64?  Per
> > drivers/pci/dwc/Kconfig, CONFIG_PCI_HISI depends on CONFIG_ARM64.
> > 
> > Would it make sense to put this quirk in arch/arm64/kernel/pci.c?
> 
> Indeed our host controller depends on ARM64 so maybe it would make
> sense to move the quirk arch/arm64/kernel/pci.c; however regardless
> why is it strictly required for a VGA device to be legacy one in order
> to make it the default boot device?
> i.e. couldn't we have:
> 
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 0f5b2dd..a6b606c 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -667,8 +667,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  	/* Deal with VGA default device. Use first enabled one
>  	 * by default if arch doesn't have it's own hook
>  	 */
> -	if (vga_default == NULL &&
> -	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> +	if (vga_default == NULL) {
>  		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
>  		vga_set_default_device(pdev);
>  	}

I don't know enough about the VGA arbiter to answer this.  This test was
part of the initial implementation: deb2d2ecd43d ("PCI/GPU: implement VGA
arbitration on Linux") by Ben.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
