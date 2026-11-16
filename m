Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821747;
	b=HQEV1GkEfR3rEOIYYIdpcV8lRxoaPqAjbyS4o9BCK3eC82elu2R43TOvkFpKFMyBJViJ
	 DejY2oTCvuGFmE47a3xhn3DSUcBSjzUd/A+ULAy2iEmRNeR75n0yMiRXgJV/lBkiEiOE5
	 M554gOoM5Lb5dNuxqbESPBK9amjNQrVFwXawSNhr48xPQYuWKBHG1Evt+IjY6yTH+AQLa
	 7i25BUEWXP4MpSmmAUoDeMS3x5YqhzVF+DZXQ1dxkvM00V3rjakWIlLEmigGCeHVKWcOX
	 cOeI7bki3akVd8c10g58VYOkX4/WKhx8rrYTbOAPiIJzGE1EAzQK/zOvmwmUfq9TevQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Zh+XulnPd/nR+IMT1WxzCnxZlOn4xssX41WPzE9FKU=;
	b=bRk+bEjscl63Q+dIfpBEInLA5QMfVYQ1rKpkRxrEB0//W3sml6Dx1Ao3FwCJvT4vM9FG
	 Ob51rdMu1VPfjadzyXKxpK+JXdCPtV+xmP18k3PrC/8e5Qupt1AR8bLXMJRGZ2dsrPCRS
	 8hbfZBPqStM7u+g+YIgNkXm/0UBzAU+/hQM1P6qGd5S4/lna4lLRqQA8uLhVWWsaL04l4
	 GU0zfWNmKT2GuJAI6nBlxs1ZzFQ0WT3ivKZIOIrA2AcIT5gpB+T517F+3wULmDV5AIF0U
	 ESWxyVNZTyP3pIH4BHYNhzdg2ePpcCdyzsQiSGba2xO+5iJ3b8N3Xlm7E/ApjyLtaow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6c3cS6d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC7606A332;
	Mon, 16 Nov 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6c3cS6d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794821747;
	b=BB9yxXXJwVc8Vk8MLP3nsX8IG2GvRWt6dIKlpilDzPODo+I+D8tiLGGiu5ROJtyr7cY+
	 xnsZd41Gb57H7P/FAiJ6wDa/cozMm1h45GE3TngxyBMWPArKArV7t1srewiJD1nonscSz
	 AQLjiMxi6j/C5/AyvgRE3tSeK595cOEoZJkwu656+zrea9u34E6TsaMlh0tW0VVUMOySn
	 Hs50Nt+HTklGFN2hI/XuDb69MnZJiL4YmTMvYs3MjgC2IMzLvx2g+8mP9mE8Hq2t5b+ee
	 uPkNjzwgOxj+8zgJ7BpJhdT3w8TnWlZd/U+R8mUYEVRA7q09vFkwmF67jMSB6YqJvSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794821747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Zh+XulnPd/nR+IMT1WxzCnxZlOn4xssX41WPzE9FKU=;
	b=zbOjBRQvum4E25D7nrV2IIFmTMq6VjgKLysQ2DMbIeU8CygscQoaQVIWjdxBCGAXyFzl
	 n0/gzWCcdVMhd1LSFRaZ+5bzMN20WqCMpSJanWkgSD3lg9PpHv5f9INxFaLXo4UV/0E4x
	 dzs4OixV8EJhhNYcFFdUxadCB92Q+EO3XEgqLD5dn75vtZgC/kYOYxKku2+YQCQymEtm3
	 YJoBIPgSKk54UkbwLaG5lTXT3siKhqerGKrCfsBVgRRowYXGPZB5hXtN7axyWlG7WdUAk
	 uWrVCW7FH6Zj3osJHmq43ZvcNbkXmwKLjoRB7z2PO+w4xqqSjB9fU/k0YWCeGfzM74Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D3B601F000C6;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821747;
	bh=6Zh+XulnPd/nR+IMT1WxzCnxZlOn4xssX41WPzE9FKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h6c3cS6dEiVHuSu/acrM84Rt9838k3HHJXs//6NE4KChiWO2D239ZPdgIKD4FY6O7
	 wFe6b9MFa9HfiXtpRkt+7gcBcA+g11Wf+ZgMuW7VwR87tFZOaK+zxkFPh9fPsH6WXV
	 5fpnoXX9DFYqXU4oOys1HnORkByJeR9MTRpzQ1reXrdOt5JsGmS2rN1UUbsGhSgKmA
	 knynY6MCfxNTSSd+i4tgBr6YnbyYrreCgP4LVJeyg/meelWkG63uNdqszPaIlt6xGw
	 1kxqH+q8V+xtk1rX3sl+qTbqt4Z0RGLV0NEr/y3VXsI/8NStiQRCzcCtO4JrAxY10L
	 i0frPRV10yX7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 608494A402;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Mon, 16 Nov 2026 02:35:44 -0700
Subject: [PATCH RFC v3 2/6] arm64: Allow synchronous abort fixups for
 guarded MMIO reads
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
Message-Id: <20261116-rfc-b4-v3-2-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
In-Reply-To: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821744; l=3957;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=O2LbMV/iAQG9voycLpkvTk5xx5a7660O6hR4aIZ4gWk=;
 b=oIwmQLQEfkvjG3fwx1Oix4dLW8HQso+6ytYvjcn5izVk500rqVfftQDITyY7UZ1vr92siqtBt
 stlGgmnS3w2DzNTYnE2R9PN0Ym9LpCcfUuUgrTkLvFVoG5vJO88clfA
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io
Content-Transfer-Encoding: 7bit

From: Matt Thompson <matt@boondocker.io>

An RK3399 PCI configuration read can raise a synchronous external data
abort if it does not get a usable response. Allow an explicitly annotated
MMIO load to return an error in this case.

Match only a current-EL synchronous external abort on a read instruction
with the new exception table type. Keep existing handling for other
faults, including asynchronous SError and translation table walk aborts.

Signed-off-by: Matt Thompson <matt@boondocker.io>
---
 arch/arm64/include/asm/asm-extable.h | 15 +++++++++++++++
 arch/arm64/mm/extable.c              | 20 ++++++++++++++++++++
 arch/arm64/mm/fault.c                |  4 ++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index d67e2fd..ac78167 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -11,6 +11,7 @@
 #define EX_TYPE_KACCESS_ERR_ZERO	3
 #define EX_TYPE_UACCESS_CPY		4
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	5
+#define EX_TYPE_MMIO_READ_ERR_ZERO	6
 
 /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -80,6 +81,11 @@
 #else /* __ASSEMBLER__ */
 
 #include <linux/stringify.h>
+#include <linux/types.h>
+
+struct pt_regs;
+
+bool fixup_sea_exception(struct pt_regs *regs, unsigned long esr);
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
 	".pushsection	__ex_table, \"a\"\n"		\
@@ -111,6 +117,15 @@
 			    EX_DATA_REG(ZERO, zero)			\
 			  ")")
 
+#define _ASM_EXTABLE_MMIO_READ_ERR_ZERO(insn, fixup, err, zero)		\
+	__DEFINE_ASM_GPR_NUMS						\
+	__ASM_EXTABLE_RAW(#insn, #fixup,				\
+			  __stringify(EX_TYPE_MMIO_READ_ERR_ZERO),	\
+			  "("						\
+			    EX_DATA_REG(ERR, err) " | "			\
+			    EX_DATA_REG(ZERO, zero)			\
+			  ")")
+
 #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, wzr)
 
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 299a244..dcb84d8 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -28,6 +28,8 @@ bool insn_may_access_user(unsigned long addr, unsigned long esr)
 		return false;
 
 	switch (ex->type) {
+	case EX_TYPE_MMIO_READ_ERR_ZERO:
+		return false;
 	case EX_TYPE_UACCESS_CPY:
 		return cpy_faulted_on_uaccess(ex, esr);
 	default:
@@ -101,6 +103,8 @@ bool fixup_exception(struct pt_regs *regs, unsigned long esr)
 	case EX_TYPE_UACCESS_ERR_ZERO:
 	case EX_TYPE_KACCESS_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
+	case EX_TYPE_MMIO_READ_ERR_ZERO:
+		return false;
 	case EX_TYPE_UACCESS_CPY:
 		return ex_handler_uaccess_cpy(ex, regs, esr);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
@@ -109,3 +113,19 @@ bool fixup_exception(struct pt_regs *regs, unsigned long esr)
 
 	BUG();
 }
+
+bool fixup_sea_exception(struct pt_regs *regs, unsigned long esr)
+{
+	const struct exception_table_entry *ex;
+
+	if (ESR_ELx_EC(esr) != ESR_ELx_EC_DABT_CUR ||
+	    (esr & ESR_ELx_FSC) != ESR_ELx_FSC_EXTABT ||
+	    (esr & ESR_ELx_WNR))
+		return false;
+
+	ex = search_exception_tables(instruction_pointer(regs));
+	if (!ex || ex->type != EX_TYPE_MMIO_READ_ERR_ZERO)
+		return false;
+
+	return ex_handler_uaccess_err_zero(ex, regs);
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b227368..ebe8054 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -30,6 +30,7 @@
 #include <linux/hugetlb.h>
 
 #include <asm/acpi.h>
+#include <asm/asm-extable.h>
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature.h>
@@ -879,6 +880,9 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	const struct fault_info *inf;
 	unsigned long siaddr;
 
+	if (fixup_sea_exception(regs, esr))
+		return 0;
+
 	inf = esr_to_fault_info(esr);
 
 	if (user_mode(regs) && apei_claim_sea(regs) == 0) {

-- 
Git-155)


