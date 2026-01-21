Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAE288C2B;
	Wed, 21 Jan 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967430; cv=none; b=QJzusP7bGQlBOujRbjM5h50izmndEKsluGB3ZKnPzIWYl2dYyfeTxu2Kn43WCzH6l1kda+tG6ueZBnPK3GjyvWJwAa5aNdejKge0fT8c3MhCY+Bv5sQPhHXPr+G9WHXba65rC9wm81LSrziYMJf9jBASROYi16KgSY+WCr9Ovpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967430; c=relaxed/simple;
	bh=TZ+z0R3yrG5kA59So43cspzq6B2JrLPm3ZxctrnLUnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAhwiYnL5CmmCWLb1DL2saD+S9B2Kf/VnjilJnIs3h8ub954f0NiSx4jlIXKa7jH3hR9nPJsfMFHwUVEjKk7uwARRoYL2icKzTo/K/xGth31FJT6FrTNxqtQIMwkW2ejAXJ7LV2u/6u8Qc7aMjeZkqpuylWDSFU204qALT7lDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowADXfWnhTHBp_WqTBQ--.5409S6;
	Wed, 21 Jan 2026 11:49:55 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 21 Jan 2026 11:49:40 +0800
Subject: [PATCH v2 4/4] ALSA: hda/intel: Raise msi_addr_mask to dma_bits
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pci-msi-addr-mask-v2-4-f42593168989@iscas.ac.cn>
References: <20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn>
In-Reply-To: <20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 sophgo@lists.linux.dev
X-Mailer: b4 0.14.3
X-CM-TRANSID:qwCowADXfWnhTHBp_WqTBQ--.5409S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kGw13tw4DtFWDKFyrXrb_yoW8Ary7pw
	4DGayftF4YqFyrJa1kKa1DZF13CFZYkwn5GrWrK34Ska4Yvr10gr9FkryxJa4xGF4vgw1Y
	vrWjv3WrWF45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRNdb1DUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The code was originally written using no_64bit_msi, which restricts the
device to 32-bit MSI addresses.

Since msi_addr_mask is introduced, use DMA_BIT_MASK(dma_bits) instead of
DMA_BIT_MASK(32) here for msi_addr_mask, describing the restriction more
precisely and allowing these devices to work on platforms with MSI
doorbell address above 32-bit space, as long as it is within the
hardware's addressable space.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

---
v2: No changes

hda/intel maintainers: I don't know if this is the correct restriction.
Please help with checking. Thanks.
---
 sound/hda/controllers/intel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index c9542ebdf7e2..a44de2306a2b 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1903,11 +1903,6 @@ static int azx_first_init(struct azx *chip)
 		chip->gts_present = true;
 #endif
 
-	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
-		dev_dbg(card->dev, "Disabling 64bit MSI\n");
-		pci->msi_addr_mask = DMA_BIT_MASK(32);
-	}
-
 	pci_set_master(pci);
 
 	gcap = azx_readw(chip, GCAP);
@@ -1958,6 +1953,11 @@ static int azx_first_init(struct azx *chip)
 		dma_set_mask_and_coherent(&pci->dev, DMA_BIT_MASK(32));
 	dma_set_max_seg_size(&pci->dev, UINT_MAX);
 
+	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
+		dev_dbg(card->dev, "Restricting MSI to %u-bit\n", dma_bits);
+		pci->msi_addr_mask = DMA_BIT_MASK(dma_bits);
+	}
+
 	/* read number of streams from GCAP register instead of using
 	 * hardcoded value
 	 */

-- 
2.52.0

