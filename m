Return-Path: <SRS0=I+Vp=6Q=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=I+Vp=6Q=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Axtens <dja@axtens.net>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Liuxinliang
 (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        Rongrong Zou
	<zourongrong@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will
 Deacon" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
Date: Thu, 13 Jul 2017 10:29:25 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
References: <20170712050811.3620-1-dja@axtens.net>
 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Daniel

[...]

>=20
> Is this quirk useful on any arch other than arm64?  Per
> drivers/pci/dwc/Kconfig, CONFIG_PCI_HISI depends on CONFIG_ARM64.
>=20
> Would it make sense to put this quirk in arch/arm64/kernel/pci.c?

Indeed our host controller depends on ARM64 so maybe it would make
sense to move the quirk arch/arm64/kernel/pci.c; however regardless
why is it strictly required for a VGA device to be legacy one in order
to make it the default boot device?
i.e. couldn't we have:

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 0f5b2dd..a6b606c 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -667,8 +667,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *=
pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-	if (vga_default =3D=3D NULL &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) =3D=3D VGA_RSRC_LEGACY_MASK)) =
{
+	if (vga_default =3D=3D NULL) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
 		vga_set_default_device(pdev);
 	}

?
Thanks
Gab
