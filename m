Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794616132;
	b=vYDzLjemA8NdJElNYKpwqS6K3tAWTDXMmWfxjHrFy5kXqAAPoUai/9TjNV7nSOgbMTn0
	 lL1cnkM0TRHCrni5djVe5RRUsfEMOljs5XQrkj+TJPrPzs56ixTmXKc0dDU2Ln3pmE2hl
	 zB5+5RmBFJ/mZbY8YtjFAfxK0/5Uq9JGJsVl0U3/iqKgA3sRZzhsHlpc+L7WSsSyrotyE
	 OxzJUVHNfrq+KnAqV1GnJmNu3xXXTr4ZcopezNvhmkMd6Br0TcxGx9sZCK4LMh767/row
	 3e4F47aN+XgHhFixTCtpebP95RCQOO1r/c++8SgLn8LC3MTOI1cvGR/AHl3ZkHrf2Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616132;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1nL03MBSTpW+t/jOuo1Bo2Pb/7wKI1Rte6iAFtfXmns=;
	b=OtKeHzOOCBdjwFtiSogqvbXc8TrVOA3f7o1VYAjwl/VpvhvwB8vXtzVzvAJ2lv3Hk+wu
	 2cPBEwsvzuNRQqIGcL79bhQGwb4kS3E+BxSgos9K2wWvyukBQaC4z4O3V2lat48i2tT0h
	 h0DX8gX1FlzIodsO2F7lvxTrOKpQCo/MUsX8BxpkJaUaY4F6hHjKN2sDqaGEcWioN7Akq
	 3pW67FveQ22uzd/legVSOLc/E3YC6zXBCqkYfzxSKzAESIMKKe2JX1+6PSYi59AVHEBdq
	 ZCygY3eBVC2y450k2dzcRBZgL4pY86ZBesk4DRhNCxEs67OoBTAtp9rVtDwgp5JppsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3soLgCJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5853606A336;
	Sat, 14 Nov 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3soLgCJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794616131;
	b=Xha2Xh4WCQlLDG2LTabAS2zXVdf7rPyf2xFo+lirNnatw9m0G9k+Uld0QmsNWvHjQjeo
	 O1KjyLu+HLF7SXWo5AUFmBVeN5F1jMHybz4pTlyZHHX8padU5WZ2fe4Hxu+L0kGdhfvX+
	 ONROcTmdwpDarHfJH9yy9wstPtVL7skrQYbAqM7vT6gpFacPFoN2YI8wGjMkIjCc3GTDS
	 0WXZyKOiu12hHk02T0ngMGaMbQKgFAujMrSFiYpCH9iQ6l1ZWBmmbHa3MEbyfMGtMx/e6
	 m3dMjZ73z69PmWiSxStdS3zDB7XaICdKIeFjZWMr+iYIUGh7lfW5cyRpT9VGwnJ+sEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794616131;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1nL03MBSTpW+t/jOuo1Bo2Pb/7wKI1Rte6iAFtfXmns=;
	b=tDlv0g+D5SPCJbiZEhNADZoex78HgXDR0QeYsnnsJ8Ehq92kpKTxoQwcCkUKSgXnB3Qj
	 XL4lex2Sv1gDXxlb6U2jap+MsM9yCeHGQUaAJRzg6cRT7UYEeucMIqRrL9Mx3NPBeGn6e
	 QxgamS64gWjYBGSGFMKTsTyflMSb504khuabl0SHDHfvboWtdb/CY++7N3THoEAHgCcuH
	 7UR7nIfoIHpu4qfT0rAdvQyA2hXvXAcXNrNvwzFHogwXC6odBxes/w2BmGz7HslUCZfhT
	 RbtEl+2FYacfnhre84gVf0JCDiOxviyMDr+5b1R5vTyLW87RDsYiarCfxc8MBtxo6Yw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CFFA01F000C6;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616131;
	bh=1nL03MBSTpW+t/jOuo1Bo2Pb/7wKI1Rte6iAFtfXmns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h3soLgCJL0w8MuLp6PrQKX9kgyZWLN9jIcw4wKqx7pPWqo3OifhYJ9UY5665iCDYO
	 QY37lZPO3cZElWU/CpnT9GhcdT6T3/ZAoT9eBJWimOdnH7m9NjN3jXDAGgOEQJIuuG
	 4K0UkTtAm4onpN7cG4Un5BK5POTP5YRqbdGPvAPSceA3JKW3xa/fMHWSny4uwkLiKa
	 gL2o+8jLogeZ/gRvxy2HU/QZ6N7txAwrwuawWkt87rt+2Jg1JQGkmehIwhrUcpW9Aq
	 tizZbRdnRNfhClgDWfoUR4nJOv0MEMPW5uw5ptC5tiCj2SdJ6Bf+1NVFAXsWb88JKn
	 gXhnukafHKCVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5949149BE3;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Fri, 13 Nov 2026 17:28:50 -0700
Subject: [PATCH RFC 2/3] arm64: Allow synchronous abort fixups for guarded
 MMIO reads
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
Message-Id: <20261113-rfc-b4-v1-2-b91dcb502250@boondocker.io>
References: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
In-Reply-To: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794616129; l=3185;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=+Rysg52MQ+WEH6U9bLqWMjonnyRMjgwZRj3Gm/L1z2c=;
 b=ivVIwpe9aQT6YH1SgFrUGUyAEZu4oOmIHxxnVxegwaq4g31oxKOagJc5lROvzRq9fuKPwg4vx
 yF+wEx3J69hCEMKYrIWpInK/vgWmpsDqq5yoGfMy5rE5sN+BOPEvhcR
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
 arch/arm64/include/asm/asm-extable.h |  9 +++++++++
 arch/arm64/mm/extable.c              |  1 +
 arch/arm64/mm/fault.c                | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index d67e2fd..ed80aec 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -11,6 +11,7 @@
 #define EX_TYPE_KACCESS_ERR_ZERO	3
 #define EX_TYPE_UACCESS_CPY		4
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	5
+#define EX_TYPE_MMIO_READ_ERR_ZERO	6
 
 /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -123,6 +124,14 @@
 #define _ASM_EXTABLE_KACCESS(insn, fixup)				\
 	_ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
 
+#define _ASM_EXTABLE_MMIO_READ_ERR_ZERO(insn, fixup, err, zero)		\
+	__ASM_EXTABLE_RAW(insn, fixup,					\
+			  __stringify(EX_TYPE_MMIO_READ_ERR_ZERO),	\
+			  "((.L__gpr_num_" err " << "			\
+			  __stringify(EX_DATA_REG_ERR_SHIFT) ") | "	\
+			  "(.L__gpr_num_" zero " << "			\
+			  __stringify(EX_DATA_REG_ZERO_SHIFT) "))")
+
 #define _ASM_EXTABLE_LOAD_UNALIGNED_ZEROPAD(insn, fixup, data, addr)		\
 	__DEFINE_ASM_GPR_NUMS							\
 	__ASM_EXTABLE_RAW(#insn, #fixup,					\
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 299a244..c9b5944 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -100,6 +100,7 @@ bool fixup_exception(struct pt_regs *regs, unsigned long esr)
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
 	case EX_TYPE_KACCESS_ERR_ZERO:
+	case EX_TYPE_MMIO_READ_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
 	case EX_TYPE_UACCESS_CPY:
 		return ex_handler_uaccess_cpy(ex, regs, esr);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b227368..148f7c9 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -877,8 +877,19 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
 static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
+	const struct exception_table_entry *ex;
 	unsigned long siaddr;
 
+	/* Only a synchronous data abort on an explicitly guarded MMIO read. */
+	if (ESR_ELx_EC(esr) == ESR_ELx_EC_DABT_CUR &&
+	    (esr & ESR_ELx_FSC) == ESR_ELx_FSC_EXTABT &&
+	    !(esr & ESR_ELx_WNR)) {
+		ex = search_exception_tables(instruction_pointer(regs));
+		if (ex && ex->type == EX_TYPE_MMIO_READ_ERR_ZERO &&
+		    fixup_exception(regs, esr))
+			return 0;
+	}
+
 	inf = esr_to_fault_info(esr);
 
 	if (user_mode(regs) && apei_claim_sea(regs) == 0) {

-- 
Git-155)


