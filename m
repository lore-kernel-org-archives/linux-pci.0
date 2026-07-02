Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02847DF8E;
	Thu,  2 Jul 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987366; cv=none; b=qiXawvVZjuJxCG20DwAonp4Fbs7yXQwfbbU7T/fbJlDwe+eNzDRbFSO9U+imfsURbLpWeGaT2vA1IItqFykIDlvITIAxLTbmSXw8+wLhgrxWXPGfsuXsi8V/JqESy1fReCwt2OVVMsqLlmuphtLImtcaOyvFvZ7U1t/FvkszrU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987366; c=relaxed/simple;
	bh=YsI5+CzU+voC1KBUN83OrkACKIHZNK4WIQdqIOnO69k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BhVVZLAEblI9Y6tQhDLyaNtHuortf3bMLzghEEGhSYhr6vrIq15iGtNML+nDaahuEeQ+KtjF4poG910nKLtdKItMS8WYINN88e5H06huSfexZ/G80fas+qRocFR4FJ0GCQpZ5aAeV3s4oHx7qPkq3s8UZQk7hR+lrzDqbDV0pYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzMds6+J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EnVTDAuw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzMds6+J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EnVTDAuw"
Date: Thu, 02 Jul 2026 10:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782987363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xed8pkdEo2sJMF+D/NEsO72PEB5ydAzw5y9iwL5MCSU=;
	b=VzMds6+JnHGAODmGcUh/PTOMPj4mix+dl40Y8QJ+LYT2nKADCj2YzZCgnuSLok44uEMCr3
	0s0gRo/7evYG6ilzcpfh0INpIKjmqRz5VOfZIKBXPsFfjjqck0I8vCU777Y7ISQXXLSP1J
	GnABTBRt1umHspRGHX+Rnjl8/IO8ZZTD8jgwyRuZaPqtZEh2gA2UatApST6fDZFTeKMa/7
	HNUwqksokW1q+jbeDwZDic4sG9cdVluEJnnxqRwPxu0gpE0y9RCkG+VmxpP4Pwj5Vxg3/M
	MFEugBZWX8myjpmn/cEX/LKyDYlvgxYNjSAzZQN/N5Wz77eFnsq13TzutJS8BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782987363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xed8pkdEo2sJMF+D/NEsO72PEB5ydAzw5y9iwL5MCSU=;
	b=EnVTDAuw+vDbOC92Ys7FKV4ZBX7Kxphb/jp7S2iiZJAmmi06ynbtKyTp/Bc09WdZOJbicN
	z1g9Aq4w9pg5vaDA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/pci: Stop using 32-bit MSR interfaces
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260629060526.3638272-12-jgross@suse.com>
References: <20260629060526.3638272-12-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178298736191.3843924.4213710231240809260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     b67096f9dbbb4295c892e266a80b816f24c32f7c
Gitweb:        https://git.kernel.org/tip/b67096f9dbbb4295c892e266a80b816f24c=
32f7c
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 29 Jun 2026 08:05:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 Jul 2026 11:54:52 +02:00

x86/pci: Stop using 32-bit MSR interfaces

The 32-bit MSR interface rdmsr_safe()is planned to be removed. Use the
related 64-bit variant instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260629060526.3638272-12-jgross@suse.com
---
 arch/x86/pci/mmconfig-shared.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index acdb8dc..9749820 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -189,7 +189,7 @@ static const char *__init pci_mmcfg_intel_945(void)
=20
 static const char *__init pci_mmcfg_amd_fam10h(void)
 {
-	u32 low, high, address;
+	u32 address;
 	u64 base, msr;
 	int i;
 	unsigned segnbits =3D 0, busnbits, end_bus;
@@ -198,13 +198,9 @@ static const char *__init pci_mmcfg_amd_fam10h(void)
 		return NULL;
=20
 	address =3D MSR_FAM10H_MMIO_CONF_BASE;
-	if (rdmsr_safe(address, &low, &high))
+	if (rdmsrq_safe(address, &msr))
 		return NULL;
=20
-	msr =3D high;
-	msr <<=3D 32;
-	msr |=3D low;
-
 	/* ECAM is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
