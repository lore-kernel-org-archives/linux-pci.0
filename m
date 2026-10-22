Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648700;
	b=1Jsfn4jJLFvG7pI4qnTfTWf96NOiumSuCC4foIjyorMLJSNmYOcso1ZQVZ+RoIFrVdzJ
	 yNKEaN2EyoTN6pyk4fYpjurWSYKVStDYL1iBQzM+nbJ3aThxr2du7Deel6XNw+NvHIDin
	 xojzDK+F6ZDSWYvdFeFptWzKg1/qUVTehexPldRe1lqiILtBGeJHRO26Ef3CtiQjL6aON
	 XBP6c33xBxVwlAp+uZY3wjlxsXTVUKzrBfJUnFT0IV78yr8aWzQXw0gp+eFWHjZ766SJ+
	 xxut3GgtCgYYpQFzlrIIY6/FVsLmWNBJrkZ4FpxXrXFsEWWdENmpN0W8Qn8OzIRhrNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648700;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=lop1HsMsxUGw4mXUZtviND4KSaGoUoHPS58M2aTNKLs=;
	b=sXuWeqSOkGBUZpL/pOhJ4kuTjTwFsJvpv3iY8Dct41wgp+42Ena1ClH01LFfQbTuqARX
	 woTYbs8JQ/tltDO2GoRVBuzcJ7rFIrtSyXy415kzmaaZctKJt1n34cZ+IMpzehVbe2LPN
	 8uXVADt2AsRlXellUZP+YY0gUCq1WeMqKTBVWoTJ/odSpAt9k6ZdFsrOhU23Fkz5crF4u
	 eKnljrFQW6PJeFGWEBtGqP8WFqKmiKuEOWBdkC73x3Dtty7MkE4UyiNLSgoIuHTrmHbWq
	 b/RW5dIMH2ob8gb88ClBNXEKBGMbWjuFA1hxiCvcgb6ZviZ4YwqvcJf7F410nAv/kbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB6606A319;
	Thu, 22 Oct 2026 05:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54FB6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ar (unknown [42.86.112.99])
	by APP-03 (Coremail) with SMTP id rQCowABnckD2pdlqipdrCw--.1489S2;
	Thu, 22 Oct 2026 13:58:14 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Alexander Gruhlke <gruhlke@mailbox.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Ignore Immediate Readiness on Samsung PM9D3a NVMe
Date: Wed, 21 Oct 2026 22:58:14 -0700
Message-ID: <20261022055814.2566044-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
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
X-CM-TRANSID:rQCowABnckD2pdlqipdrCw--.1489S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5uF15Jw48trWxWF1rWFg_yoW8XFykpr
	W5Wr95ZrZ2gr1UX3yjvw1fuas0yanYy3yjk3y8t3sFg3ZrCryDXa4fJFy5Gr9xArZ2qrWa
	v3Z8Jw1kJa1jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgtr4UUUUU
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRIIAmrZhEoilwACsb

The Samsung PM9D3a [144d:a80e] (MZWL63T8HFLT-00B07, firmware LDD5702Q)
advertises Immediate Readiness, so pcie_flr() doesn't wait after FLR,
but the drive returns ~0 for up to 6 ms.  The config restore runs about
1 ms after the FLR, so the BARs and Command register are lost and
neither vfio-pci nor a rebound nvme driver can reach the device:

  pci 0008:01:00.0: reset via flr
  pci 0008:01:00.0: restore config 0x10: 0xffffffff -> 0x10010004
  nvme 0008:01:00.0: error -ENODEV: probe failed

Ignore Immediate Readiness on this device too, so pcie_flr() waits.

Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
Tested on two PM9D3a drives on a v7.2.6 kernel with 0f8b5d90d179
backported: FLR-to-restore delay goes from ~1 ms to ~100 ms, BARs
are preserved, and nvme rebind and vfio-pci both work.

 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1aa87a3ef9ed..706e128f408c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5645,6 +5645,7 @@ static void quirk_no_imm_ready(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_ready);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80e, quirk_no_imm_ready);
 
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
-- 
2.56.0

