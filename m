Received: from cstnet.cn (unknown [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFE36AB56;
	Fri, 23 Jan 2026 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148492; cv=none; b=dNT1J7zuJqaic6x5btMJWIxudjp7Q9U25iaEVqvDapU2BncHhE6+owRAAT25I8zzFrtA+2X17rC8959xE0I5h7g1xmA0udg6KJSXKDevxQmSyUVMTf6S7GlVdYt4FpPr5iIdeZZmQ2x3QpHKyNwWBs/ww5bq6oVKboGv1YehkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148492; c=relaxed/simple;
	bh=MpTxXaaQr28qUBNtrfTyN44MX9ojvMkGhwveMjD2MxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMA55JfYlRXz1fojGxadkpcCw208h/pjz38JppEauT2h+KfXmKQTXrn4QwttVNpcj/VVHoy6mDy57J0SXlU4PLVUgEdM68uCYexp+TnhzN+1dMOrlgEYDH7s7QCVWghbQu4Zd1UCM8EaQqAiFVlUFAFVojvrs7wi/+/NeZXprCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowACnPBAiEHNp9tMuBg--.1678S4;
	Fri, 23 Jan 2026 14:07:32 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 23 Jan 2026 14:07:29 +0800
Subject: [PATCH v3 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-pci-msi-addr-mask-v3-2-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
In-Reply-To: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
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
 Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowACnPBAiEHNp9tMuBg--.1678S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy5JryfGw1kur43Aw45trb_yoW8GF4fpF
	WqgayDAr4Fkw15JFsxXw1vqF15ZFZ0qa4fGrW8G34a9FsIqwnFyw13K347K3WfXF18Gw15
	ZFyYyw4UGFs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sREIzutUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Instead of a 32-bit/64-bit dichotomy, check the MSI address against
msi_addr_mask.

This allows platforms with MSI doorbell above 32-bit address space to
work with devices without full 64-bit MSI address support, as long as
the doorbell is within addressable range of MSI of the device.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

---
v3: %llx -> %#llx (Bjorn)
---
 drivers/pci/msi/msi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 48f5f03d1479..77713f89a10b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -321,14 +321,17 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	u64 address;
 
 	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
 		return 0;
 
 	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (entry->msg.address_hi) {
-			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
-				entry->msg.address_hi, entry->msg.address_lo);
+		address = (u64)entry->msg.address_hi << 32 |
+			  entry->msg.address_lo;
+		if (address & ~dev->msi_addr_mask) {
+			pci_err(dev, "arch assigned 64-bit MSI address %#llx above device MSI address mask %#llx\n",
+				address, dev->msi_addr_mask);
 			break;
 		}
 	}

-- 
2.52.0

