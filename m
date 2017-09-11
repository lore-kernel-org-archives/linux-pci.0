Return-Path: <SRS0=xM4e=AM=au1.ibm.com=andrew.donnellan@kernel.org>
Return-Path: <SRS0=xM4e=AM=au1.ibm.com=andrew.donnellan@kernel.org>
Subject: Re: [PATCH v3 2/3] drm: add fallback default device detection
To: Daniel Axtens <dja@axtens.net>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, gabriele.paoloni@huawei.com,
        ard.biesheuvel@linaro.org, airlied@linux.ie, will.deacon@arm.com,
        dri-devel@lists.freedesktop.org, z.liuxinliang@hisilicon.com,
        alex.williamson@redhat.com, lukas@wunner.de, helgaas@kernel.org,
        catalin.marinas@arm.com, zourongrong@gmail.com,
        daniel.vetter@intel.com
References: <20170901072744.2409-1-dja@axtens.net>
 <20170901072744.2409-3-dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 11 Sep 2017 14:35:51 +1000
MIME-Version: 1.0
In-Reply-To: <20170901072744.2409-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ccea6f96-4658-b25a-a8ba-2959815318e3@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 01/09/17 17:27, Daniel Axtens wrote:
> The VGA arbiter selects a default VGA device that is enabled and
> reachable via the legacy VGA resources (mem 0xa0000-0xbffff, io
> 0x3b0-0x3bb, io 0x3c0-0x3df, etc).
> 
> (As a special case for x86 and IA64, this can be overridden by
> EFI.)
> 
> If there is no such device, e.g., because there's no enabled VGA
> device, the host bridge doesn't support access to those legacy
> resources, or a PCI-PCI bridge doesn't have VGA Enable set, a
> platform may select an arbitrary device by calling
> pci_set_default_display(). powerpc does this, for example.
> 
> If there is also no platform hook, there will be no default
> device nominated. This is not necessarily what we want.
> 
> Add handling for devices that aren't handled by the vga arbiter or
> platform by adding a late initcall and a class enable hook. If there
> is no default from vgaarb or the platform then the first VGA card
> that is enabled, has a driver bound, and can decode memory or I/O
> will be marked as default.
> 
> This means single-card setups on systems without access to legacy
> areas and without arch hooks will work. Multi-card setups on these
> systems will nominate an arbitrary device, rather than no devices.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> v3:
> 
> Split out from re-organisation for simplicity.
> Add better description and better documentaion.
> 
> Thanks to (in no particular order), Daniel Vetter, Lorenzo Pieralisi,
> Ard Biesheuvel and Dave Airlie. Special thanks to Ben Herrenschmidt
> and Bjorn Helgass, whose prose I have borrowed.
> 
> v1:
> 
> Tested on:
>   - x86_64 laptop
>   - arm64 D05 board with hibmc card
>   - qemu powerpc with tcg and bochs std-vga
> 
> I know this adds another config option and that's a bit sad, but
> we can't include it unconditionally as it depends on PCI.
> Suggestions welcome.

Tested on our iMac G5, the fallback handler doesn't fire (which should 
be correct).

Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> +static void vga_default_enable_hook(struct pci_dev *pdev)
> +{
> +       if (!vga_default_active)
> +	       return;
> +
> +       if (pci_default_display())
> +               return;
> +
> +       vga_default_try_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_CLASS_ENABLE(PCI_ANY_ID, PCI_ANY_ID,
> +			       PCI_CLASS_DISPLAY_VGA, 8,
> +			       vga_default_enable_hook)
> 

Looks like you have some spaces/tabs inconsistencies here.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
