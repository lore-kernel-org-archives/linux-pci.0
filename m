Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982202;
	b=eEMsgzoSURWrZE9SJEG8zUCA7NvchIIO4BHPxds8nCrXm2rDpNts1+0Wh8bVj+E2wFt7
	 llLTb2XmxU6+X892WOHjecQn9P3/3lf0pUiSYTgJ9qeyAYGRSbVmjHpYUCcER1mm3WMY2
	 +tZmf62Z90CZz/mz16ZpSV7tCGk4Jh1hk2eGwfijALpRD8kictjvrb4PNs6srNyGcXFA7
	 kAspOlz4F7bK931oAYsus2GVNsS/sGtsUlDtiJNBitkZcONM0KVEDf1Ptrhlvd13mDdbc
	 Bmys9QnwwFZyXsUGbg4HU2TAYyNJrByLLQO7fkgAlI+kSjHRXFtA97oqzNEDmHtv+FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982202;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=tZZm4rx+rHXtJJwzFR/LRnZyCk2ZZ1fBVnu/RB4Koyk=;
	b=mom7RNHvzk6BlW6zm7vgNRNb+hTfWtKPktiyR02ye8y4DVFPsaJFtkJAnEBH/f5sItAt
	 Fju+h0g9jfWYL7EaOJbS2teZpjypTsAL42kQdxTFmf9HAGcFBj5ati0kWQBIyVyyAJM6X
	 pKDBNNVK4K6C9gXXhDXhosQbCHyxOIZwNIRdHis0Xfw5Plfoziu1GzMW5f67xInwVkqUc
	 cTsDMasZjUPJzd+ONSJleWyuAF2OSiRnLI1ilxNz0TwpWjhMvwweVdHv7w6gLOB7RY2SN
	 IPlm6H13P1TO6UUsWpNSnAhkM3f6QSopwrtk2yPYSpSTxlo1gF3NCgdrQNpFjHCXhmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD71A606A32C;
	Fri,  6 Nov 2026 16:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD71A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkxh4B1Tz57DCk;
	Sat, 07 Nov 2026 00:23:20 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A6GNA1N089302;
	Sat, 7 Nov 2026 00:23:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:23:13 +0800 (CST)
X-Zmail-TransId: 2afb6aedfef13f7-bb369
X-Mailer: Zmail v1.0
Message-ID: <20261107002313901Qf1gr0l9hu3M35MHK0Mya@zte.com.cn>
In-Reply-To: <20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn
Date: Sat, 7 Nov 2026 00:23:13 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gUENJL0FTUE06IFNraXAgbGluay1zdGF0ZSBzZXR1cCB3aXRob3V0IGRvd25zdHJlYW0gZnVuY3Rpb24gMA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6GNA1N089302
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:23:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFEF8.001/4jLkxh4B1Tz57DCk

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pcie_aspm_init_link_state() builds a link state for a downstream port
whose subordinate bus is non-empty.  For a bridge whose bus has devices
but no function 0 -- a multi-function device with function 0 hidden, or
functions isolated by a hypervisor -- pci_function_0() returns NULL, so
alloc_pcie_link_state() sets link->downstream to NULL.

pcie_aspm_cap_init() then dereferences child->aspm_l0s_support, and even
if that site is guarded the same NULL link->downstream is dereferenced
again by pcie_config_aspm_link() (reached through pcie_config_aspm_path())
and by pcie_aspm_check_latency(), so the link cannot be safely handled at
all.

Skip the whole link-state setup when the downstream bus has no function 0;
nothing below (capability init, latency check, link configuration) then
sees a NULL downstream.

Fixes: 3bd7db63a841 ("PCI/ASPM: Always set link->downstream to avoid NULL dereference on remove")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG x86_64, q35) with a PCIe root port
whose downstream would have devices but no function 0, emulated by a
TEST-ONLY hook (applied to both kernels) that makes pci_function_0()
return NULL for the QEMU root port; QEMU cannot model a function without
its function 0.  No extra hardware is needed.

Unpatched, pcie_aspm_cap_init() dereferences child->aspm_l0s_support with
link->downstream == NULL and the kernel panics.  A guard placed only in
pcie_aspm_cap_init() is not sufficient: with the default (performance)
policy the same NULL is dereferenced again in pcie_config_aspm_link() via
pcie_config_aspm_path().  With this patch pcie_aspm_init_link_state()
skips link-state setup entirely and the kernel boots cleanly, the endpoint
probes normally and the guest powers off.

  unpatched                               patched
  BUG: kernel NULL pointer dereference,   no fault; guest powers off
  address: 0xc0 (aspm_l0s_support)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b039b57f8466..003b13db5850 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1243,6 +1243,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	if (list_empty(&pdev->subordinate->devices))
 		goto out;
 
+	if (!pci_function_0(pdev->subordinate))
+		goto out;
+
 	mutex_lock(&aspm_lock);
 	link = alloc_pcie_link_state(pdev);
 	if (!link)
