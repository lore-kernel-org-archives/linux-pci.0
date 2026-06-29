Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D593932E9
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713197; cv=none; b=D/H3pmw7i7tQ/6KCiX8FVtyh0bPrt8k8LDPRwF35PJ5v/eFPxgkbgzi6jppRHauTJh49OQUsSOdYChCEprBAEa56xbyehDfuLYNZg5NSpI9mbo9Ph4YRpDSUrlkVbOg5BUbs97ti0hFzm99054AVWdMQ/iv4iwnBN8vw05+uf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713197; c=relaxed/simple;
	bh=JJ9YhrpiTKVV7Ecv2t1GqlbfLynJXxS5IBrOWNUQaww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZqKS3C8hG8wN1Dr+rpWTeY5JyoGU47HRXiFOgwhW83IFvnJGqNrFcXgD9hKx+foXs84FoRfOUA7OmbZdoaK7Sx/6HiyDT6GqsdjHpBGUYr6+xDR6YpXS6lT/eOGA7EOsLp5AvVr/w3WVq32nIuDLY77Uhln9gzPd///Yv0Qve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC6CA759A8;
	Mon, 29 Jun 2026 06:06:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F890779A8;
	Mon, 29 Jun 2026 06:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yulrJWoLQmo0EgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:06:34 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 11/32] x86/pci: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:05:02 +0200
Message-ID: <20260629060526.3638272-12-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: EC6CA759A8
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

The 32-bit MSR interface rdmsr_safe()is planned to be removed. Use the
related 64-bit variant instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/pci/mmconfig-shared.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index acdb8dcaeb52..9749820f68f7 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -189,7 +189,7 @@ static const char *__init pci_mmcfg_intel_945(void)
 
 static const char *__init pci_mmcfg_amd_fam10h(void)
 {
-	u32 low, high, address;
+	u32 address;
 	u64 base, msr;
 	int i;
 	unsigned segnbits = 0, busnbits, end_bus;
@@ -198,13 +198,9 @@ static const char *__init pci_mmcfg_amd_fam10h(void)
 		return NULL;
 
 	address = MSR_FAM10H_MMIO_CONF_BASE;
-	if (rdmsr_safe(address, &low, &high))
+	if (rdmsrq_safe(address, &msr))
 		return NULL;
 
-	msr = high;
-	msr <<= 32;
-	msr |= low;
-
 	/* ECAM is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
-- 
2.54.0

