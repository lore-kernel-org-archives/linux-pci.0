Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180866;
	b=Apenv3UhFPWFTzvQ9AdgjzMSCGVpbrluue8dT+EEqHuckiwfOPy/VuqV5eCFLQYzmXNN
	 Lhi/fIiHPYA4k3i9s6MpMlHVjpY36m3/7XJzvE1aejG/DalzBizPGiPedpBGaq96NNtBC
	 Z5hrq9WoKMJI0hzBM9jk/bXY6ctCDJfgoFr/p7WVrafZ0+WcWF/tDtnu994010I7xB1Lc
	 IK2HfKdnPvTT1wAMLMSbrSFxMKtpWQHAPVSXk7VYyQcjL545whuNub68DSYXaIVtWHoIf
	 I39lhGQLeAezA2Gj/gPSxDUrla0/7oCQgZTBDouzy7q6+2DPooN2tlAuVa8wF9xm33g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180866;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=jwu93O0r5jyG0xwNtXyzwSpYXaM7JMXv4NzJ2EU/I4g=;
	b=NfS61kYgsP3hYYsyxiCo5L6Hq+EDa0jqNls/9a5O4cHAfKKl3lqKyBCSfzLlC+xLTZH7
	 45s0kIwDqG8UsKRG72KhFKBf6vhWvmJMI4pD36vuTh6qistUuisY2H4Y6PFM4Qcq27jAB
	 gaf7O52mdR4Y9S2WbCXIufTNLEa2mYhLv3oyOmrbk02NGMcMePKzmzOPqG5gMeZ/6O1Qt
	 /4LY4x8fCtPkplYXzQqe+UZPdEkgEalxG+PBOGtRt+F6MwpP6Exp2WWzXtNKur0lh33Hi
	 S7t95P8b4Fyy48cCtCOc6VO2bL412QDtXLhPY+arf5xKSmH4LzgDKTRP0LU0mvNI0Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE3606A31F;
	Wed, 28 Oct 2026 09:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFDE3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.172])
	by gateway (Coremail) with SMTP id _____8AxS_CxxOFqwxQaAA--.10356S3;
	Wed, 28 Oct 2026 17:47:29 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJAxHs+wxOFqB+MwAA--.11789S2;
	Wed, 28 Oct 2026 17:47:28 +0800 (CST)
From: wuqianhai@loongson.cn
To: bhelgaas@google.com
Cc: wuqianhai <wuqianhai@loongson.cn>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	javierm@redhat.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] PCI/VGA: Fix boot device detection after framebuffer relocation
Date: Wed, 28 Oct 2026 17:46:34 +0800
Message-Id: <20261028094634.766723-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:qMiowJAxHs+wxOFqB+MwAA--.11789S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryfKrWrAF43KF1Uur4kGrX_yoW8Ar1kpF
	Z3JF4ayFWkWr4xGrsFga4vvFyrZa1kCa4FkF4UKw1F9w13C34jya4rK3s5K34Dtrs3A3Wa
	vF13Jw1rCFZ8GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vJPtUUUUU==

From: wuqianhai <wuqianhai@loongson.cn>

PCI resource assignment can relocate the firmware framebuffer BAR, which
leaves the base address in screen_info stale.  The VGA arbiter then calls
screen_info_pci_dev() from vga_is_firmware_default(), which fails to match
the framebuffer against any PCI device's BARs.  As a result, the boot VGA
device is not recognized and the arbiter may select the wrong default
device.

Fix this by calling screen_info_apply_fixups() in vga_arb_device_init()
before adding the VGA devices.  This relocates lfb_base to the assigned
BAR address so that vga_is_firmware_default() matches the boot device
again.

Tested on a LoongArch platform, with vga_is_firmware_default()
additionally enabled for CONFIG_LOONGARCH via local changes.

Fixes: 337bf13aa9ddab8ae47f2677ab75cf69ae33437b ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
 drivers/pci/vgaarb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3e58b2c05c85..aca594651f58 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1527,6 +1527,14 @@ static int __init vga_arb_device_init(void)
 	int rc;
 	struct pci_dev *pdev;
 
+	/*
+	 * PCI resource assignment may have relocated the firmware
+	 * framebuffer BAR. Update screen_info's lfb_base so that
+	 * vga_is_firmware_default() can match it against the boot
+	 * device's relocated resource.
+	 */
+	screen_info_apply_fixups();
+
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
 		pr_err("error %d registering device\n", rc);
-- 
2.34.1

