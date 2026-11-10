Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323095;
	b=u5x7byb4Y0S7p++aY6egtbydXVgqoKD1r5jHV1M+L9bg930ssf2V22sak3MYN+X20VQ7
	 rkEuPgzN7Ddm+oxS8Lj6WWx97G5xzXOhwcQ0VZ0eDAWx++wKQvvnGNvh2Q17ldsjdYjOZ
	 89yEGc5kOTetlMqUJO3zSGUTaDzVcaG2w3A+ImcKnE0/gezmEjPuCtCd2MZggnOlngvgo
	 Eu2X8OifZybTuR5Dr2+ljRddjcCkUKEkAUrQ3qWJcbv+lmEWmQbUGiTM2TtRnafuA0i2y
	 3Il4Q7geMW4D+1YboYfVtgm8IeKvoQtv5QNZT6NmP692ZUStnm389rmsPuGxTSoklPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323095;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=I9eNLNHnnsZymMi+Ov7Sf3KUgE/w+/e3nuXMzPXdo7A=;
	b=BKYiH9hdsRxPGC2uLZ1JN6B9dDfHKdzKuPP1kDbPjGefbP6gWrpP4FraVKZ2WDm4Qhnd
	 KYcYr4AtSp9VC6YU6B+ZVU2iWrgrQZ+TbSoZz+EwQIx/Ag3s6x6WkGlq5f9CRnAaPSQ+W
	 XvDvlDsVv7tlvAKOlaMSj8rBxeCtQ3KdsEm4hkM1H07UvdbWfm5xdO3dX2tnMGYsEA+Mg
	 3sqiRhYYU4IyqccuQZ23Qnd+XjvsBnjdMUvq31aREO2r4LiHw/Lawf7KiH8zxoAxWWijF
	 jrxCUJN42ah5AnT7Ii2B05hleNF7XTKxSw38e1jhE5LakX1YJ9AlHrgTpLg6RclMHXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d31qrwmQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163B606AA7C;
	Tue, 10 Nov 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d31qrwmQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A004E1F00935;
	Tue, 10 Nov 2026 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323095;
	bh=I9eNLNHnnsZymMi+Ov7Sf3KUgE/w+/e3nuXMzPXdo7A=;
	h=From:Date:Subject:To:Cc;
	b=d31qrwmQaRvK/ADa3U0zOM+VzAuREe6D7CuqyI4wn7eIoIWsiJowlhGpP1tO7EC4l
	 OtPyU6NlkxUOon36x2BTMdPqIzkLQLvwU7+G+n8ljd32Nf3/cpnLsa4l8zIjFKm1h8
	 2Xavaph0dvYw0BhpbsOXHGDhufOvzQ9FSM+5iaPR/0TjD9LSDUoOBo/zMYa006tKIC
	 /9EaTGMhaDfCGx4P5AZ0SKp4ow5rzMwxXkoSrUQ+riWDCT/SIrlzKjmf7TEs5El0d7
	 BKxdId7pwoQ8E4CbbdSh+O5RRcJIpOiTxFrTxDkIDmMDdhfEYJ6TTXzrx5vplGxAo/
	 7BbdJ4q5ADu7g==
From: Troy Mitchell <troy@kernel.org>
Date: Tue, 10 Nov 2026 15:04:49 +0000
Subject: [PATCH] riscv: pci: allow write-combining mmap of PCI BARs
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-riscv-pci-mmap-wc-v1-1-1d16fb8c74b4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQBGLRq0gXdhztCNGQaVUQ7
 260y7f4fwflJKxQFzskXkRlnjLsowD6tNPAKF02OONKa02FSZQWjCQYQhtxJex9yeTZOu+fkLu
 YuJftfjavv/X3Hpm+1wiO4wRWHpRMdQAAAA==
X-Change-ID: 20261109-riscv-pci-mmap-wc-f56ec5e12557
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=troy@kernel.org;
 h=from:subject:message-id; bh=zLbxZxQzl4eEu3cEA0QdNlkw29aWNgLaoGnwM3MjuRo=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFmfjSYr3/vT7b2Vx/M5zybhwAlvXRbflziZe8te7cLir
 Oh39+WUO0pZGMS4GGTFFFm6H/BsK/CJsi0QKPSFmcPKBDKEgYtTACain8fIcOGk9F7D4uKJpvd1
 nRQN5nXeFe263eB+dB5Dc1zQxcU2FowMy839/okaxyetu9Y544GP4cPoR3UW74WPnzA+rT1R2nc
 HPwA=
X-Developer-Key: i=troy@kernel.org; a=openpgp;
 fpr=3FE5535CF1B0E658E57DB59BAE1C2FBEA7DB42E1

Define arch_can_pci_mmap_wc() for RISC-V, so that the PCI core can
create resourceN_wc in sysfs for prefetchable BARs. Without it, the only
sysfs mapping of such a BAR is resourceN, which uses pgprot_device():
with Svpbmt or XTheadMae that is the IO memory type, where every access
is strongly ordered and nothing is merged.

resourceN_wc is mapped with pgprot_writecombine(), which selects the NC
memory type when the kernel uses Svpbmt or XTheadMae. Without either,
_PAGE_NOCACHE is 0 and pgprot_writecombine() changes nothing, so
resourceN_wc would get the same PMA-defined attributes as resourceN and
no write-combining at all. Make arch_can_pci_mmap_wc() true only when
_PAGE_NOCACHE is non-zero. On 64-bit this is a runtime check, as
_PAGE_NOCACHE is chosen at boot from the CPU extensions; on 32-bit it is
always 0, so nothing changes there.

Signed-off-by: Troy Mitchell <troy@kernel.org>
---
 arch/riscv/include/asm/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
index b2f91abebd61..2b2db5533576 100644
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/pgtable.h>
 
 #include <asm/io.h>
 
@@ -32,6 +33,14 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 #endif
 #endif /* defined(CONFIG_PCI) && defined(CONFIG_NUMA) */
 
+/*
+ * resourceN_wc is mapped with pgprot_writecombine(), which gives the NC
+ * memory type only with Svpbmt or XTheadMae. With neither it changes
+ * nothing and resourceN_wc would be no different from resourceN, so only
+ * offer WC mmap when there is an NC type to use.
+ */
+#define arch_can_pci_mmap_wc()	(_PAGE_NOCACHE != 0)
+
 /* Generic PCI */
 #include <asm-generic/pci.h>
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261109-riscv-pci-mmap-wc-f56ec5e12557

Best regards,
--  
Troy Mitchell <troy@kernel.org>

