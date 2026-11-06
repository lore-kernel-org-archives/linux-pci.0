Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982204;
	b=cP6hozEE4j+dWrJCcum1bgieW4+QX6x5qMod72N6L5OM8eNGYV2V2NbGbGKHxtT6sONG
	 IjejdzyU4s50OPRWhPsEPmquRHCmg5R7+2QGJcJR6zgxbMg30ZGGBSZJ0qkwA4tIFk7Ij
	 id63WeeyPM0hFfC9sePlCexMHMVbSWuSL7pvwSkl571PMBn94H9RGjQszuiWBHrzX80VX
	 oaToNrmvQ34uh63GpeIUJ6Ltg6zrtwFGGQNmO19N8LprTWVuFT6+sMhOJ9ho1Gd4oYrqa
	 FtBAYRhS4K61iLPjGe5A5j1iO9FaJbJUlGcjrrzY1PoLiTyRXINkBRPbRkzLaCHF9jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982204;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=YxmWsTmr1auuxcSSnlwjgJZYMkAsaA6pUVC/hywBMss=;
	b=p2jYSI9IXv2JnBtckrR4mavAFr5dMYOLcgsM5R3H53p7Gb3ipH2LI4L+AKxMo0ndWTIA
	 fKIRmr98895CH7upHtqO9v9b+gsG7LyDkXldFT/TLZNKOKglAqaCGezSqyDAmJ+cnSclg
	 37XIHKGFagObbX/vWf5CEiRUdejQZRaBAvI6wjjpFmv9KCYB98ePi4NZ+dHaytap4q9dV
	 I7ExIXi+W+B9NT3zhV4FtgmEUzKviE7+sRgT4cJuZycWFtghXiAWLiOpzO9oJhTKVPBf2
	 aKQVMvAEix2VfaE/8vTTzqNF0IPhRpqJYwXEp/LJor7WToQS8RM942JuLZuIK/fdfTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406C606A336;
	Fri,  6 Nov 2026 16:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D406C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkxk4P5qz8XrrM;
	Sat, 07 Nov 2026 00:23:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6GNCbE011696;
	Sat, 7 Nov 2026 00:23:12 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:23:16 +0800 (CST)
X-Zmail-TransId: 2afb6aedfef44b2-bb424
X-Mailer: Zmail v1.0
Message-ID: <20261107002316495thppDxT_WC_3QyEVfQn0e@zte.com.cn>
In-Reply-To: <20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn
Date: Sat, 7 Nov 2026 00:23:16 +0800 (CST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Cc: <mani@kernel.org>, <kwilczynski@kernel.org>, <lpieralisi@kernel.org>,
        <kishon@kernel.org>, <Frank.Li@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gUENJOiBlbmRwb2ludDogUmVqZWN0IGEgemVybyBpbnRlcnJ1cHQgbnVtYmVyIGluIHJhaXNlX2lycQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6GNCbE011696
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 00:23:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFEFA.001/4jLkxk4P5qz8XrrM

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pci_epc_raise_irq() passes interrupt_num straight through to the
controller's raise_irq callback.  The DWC and other controllers compute
"msg_data | (interrupt_num - 1)" for MSI/MSI-X, so an interrupt_num of 0
underflows to 65535 and raises a message with a bogus vector that no
configured MSI/MSI-X entry matches.

Reject interrupt_num == 0 for the MSI and MSI-X types in the core API.
INTx raises use interrupt_num 0 and are unaffected.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest).  QEMU has no PCI EP
controller model, so a TEST-ONLY hook (applied to both kernels, not part
of this patch) fabricates a pci_epc whose ops->raise_irq records whether
it is called, then drives pci_epc_raise_irq() with interrupt_num 0 for
MSI and MSI-X.  Without this fix both reach the controller callback (the
DWC style "msg_data | (interrupt_num - 1)" would underflow to 65535);
with this fix both are rejected with -EINVAL while INTx (interrupt_num 0)
still reaches the callback unchanged.

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..d8e5dd6355ac 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -295,6 +295,10 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
+	if ((type == PCI_IRQ_MSI || type == PCI_IRQ_MSIX) &&
+	    !interrupt_num)
+		return -EINVAL;
+
 	if (!epc->ops->raise_irq)
 		return 0;
