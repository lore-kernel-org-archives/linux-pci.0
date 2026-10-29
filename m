Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793244944;
	b=akQPk/uA6g4W1PDc9ya0i+pgZ6hWQgoam61cnIwSt9inbu5OP0dEaPMVnW1Z3bn5mNS7
	 GHkE6ucywzpoEHgWmXLmDqFh6AL7h42djyIURE/gZ0YiTbyZQMWEV3TX1s36NuPdoq7ee
	 m7bOt1MxmENpKq8H5qVvoIzv1+O0aCwbjR9SllZMboMzwfFDByTW3+wusg/6kUcBYl2Tk
	 cwWHEEilWJgac20/1aoWLf64FYR6ZOmxcGKnbfgDOyWW5tbGNdHO3yKmRMxl3ELzZMBTH
	 A6GnypTsu5JHAWkcRiVZY5r+1Bo/wmD+w+oUXr/wP42Ib8xm31qMliLwwhkJo39QRhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244944;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Ehj6q/ZEC4usLdLn/AVAP94G4zTNFHPJCBhuvzK1Q+k=;
	b=4a8BaALq0icCpKO58Jbt6KFUhvTOAezD6udDoHLwdTtqYWk9FvcaodudmMoZKIYqS+gh
	 BNsfOvN9BUE0TcYMX5Wr753MFyTR+BEDKFTYGo49M+H8UPWDRqBFAoyuYng445bqF4aLZ
	 idUs7v/CRQzt480+fWMspzflFSCffmX5lb2+x65MN/bPvSVRzVRpm53baZNozFWBgnCGT
	 JTDa0iXYkXjgzz+8vIJP16cWgflQ9mnz/FeK+3/CUxxrLktS5ycTA3U79XZRaqHvVbpix
	 FoQwurvnj3KQ0kG4Xl4lsCfeXmqvGC69pCwZpFq/w0tBqJ98xgOMEtMEbQbPZLDxy+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B89606A31E;
	Thu, 29 Oct 2026 03:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B89606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.172])
	by gateway (Coremail) with SMTP id _____8AxHNIMv+JqyFMaAA--.11181S3;
	Thu, 29 Oct 2026 11:35:40 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJDxzM4Lv+JqVhAxAA--.11788S2;
	Thu, 29 Oct 2026 11:35:39 +0800 (CST)
From: wuqianhai@loongson.cn
To: bhelgaas@google.com
Cc: wuqianhai <wuqianhai@loongson.cn>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	javierm@redhat.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] PCI/VGA: Enable firmware default device detection on LoongArch
Date: Thu, 29 Oct 2026 11:34:40 +0800
Message-Id: <20261029033440.973077-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028094634.766723-1-wuqianhai@loongson.cn>
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzM4Lv+JqVhAxAA--.11788S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1UZF4UJw15Cw1rKw1rGrX_yoW5JrWDpr
	WfJFWIyFW8WFsrG39rJ34DuF90van7Ca4YkF45Kw13ua47C3yUJa4ftr98trnrJrs5JF4S
	yF1fJ3WrAFyDGagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
	I7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
	GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vJPtUUUUU==

From: wuqianhai <wuqianhai@loongson.cn>

On LoongArch, PCI resource assignment completes during subsys_initcall
(acpi_init), before vga_arb_device_init() runs.  By that time the
firmware framebuffer BAR may already have been relocated, leaving
screen_info's lfb_base stale.  Enable vga_is_firmware_default() for
LoongArch and refresh screen_info in vga_arb_device_init() before the
boot device is matched.

Unlike x86, sysfb_primary_display is only defined when CONFIG_SYSFB is
enabled on LoongArch, so have VGA_ARB select SYSFB there.

Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
Changes in v2:
- Add VGA_ARB's select of SYSFB for LoongArch to avoid an undefined
  reference when CONFIG_SCREEN_INFO is not set.
- Restrict the screen_info_apply_fixups() call to CONFIG_LOONGARCH so
  x86 and other architectures are unaffected.
- Enable vga_is_firmware_default() for LoongArch.
---
 drivers/pci/Kconfig  |  1 +
 drivers/pci/vgaarb.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba2..55cc60f5d312 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -256,6 +256,7 @@ config VGA_ARB
 	default y
 	depends on !S390
 	select SCREEN_INFO if X86
+	select SYSFB if LOONGARCH
 	help
 	  Some "legacy" VGA devices implemented on PCI typically have the same
 	  hard-decoded addresses as they did on ISA. When multiple PCI devices
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3e58b2c05c85..1b7e915629f9 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -566,7 +566,7 @@ EXPORT_SYMBOL(vga_put);
 
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#if defined CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 	return pdev == screen_info_pci_dev(&sysfb_primary_display.screen);
 #else
 	return false;
@@ -1527,6 +1527,16 @@ static int __init vga_arb_device_init(void)
 	int rc;
 	struct pci_dev *pdev;
 
+#if defined(CONFIG_LOONGARCH)
+	/*
+	 * On LoongArch, PCI resource assignment completes during
+	 * subsys_initcall (acpi_init), before the VGA arbiter runs.  Refresh
+	 * screen_info so vga_is_firmware_default() can match the relocated
+	 * BAR.
+	 */
+	screen_info_apply_fixups();
+#endif
+
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
 		pr_err("error %d registering device\n", rc);
-- 
2.34.1

