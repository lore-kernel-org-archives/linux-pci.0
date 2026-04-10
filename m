Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7A30F523;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826469; cv=none; b=smABdKUS3RSZ7BKnMITlhFwrVura+BDtAz7CkZzQ43G97ysaxQu1y6yJ8f6meTISUkWdjWbDRL9wa8YvT1SqaMwuOvS0BJSW6PahtTl82TkWZlpDh94O0/u321VPMZlxMx3ME0P810i0dvwOoLOennNFmm2DhqtA3vkRaOl8omo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826469; c=relaxed/simple;
	bh=EtHv+6xgjHM6UCkczN6cxddsd0dy2hFRST3nBXrjue8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTlR4oEh+mXfyHa347jdMHKE0O6TjGFvxzNsyrib7UsYFVHV8y/Dj8DOyXz3kxFNcZQL88b2O9ZvqAaP9CyJj+mj24GQWfM8xGFzDd+IObP4O4i23d+mQzh/iKQk5XVLwkTbJSHi8pz/2yYxzd5s361cHn6ZnHO/dk1W2wdf8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKvR2AFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKvR2AFq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D5A8C2BC87;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826469;
	bh=EtHv+6xgjHM6UCkczN6cxddsd0dy2hFRST3nBXrjue8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kKvR2AFqHpUpK65Rui7o+9TTSme7ojteEWQCF8k3Xq/pOK8K0yiBJjWhWP8fdZJOT
	 3yG09dWqb5qFI3sBbhr0p1k2eeeVsLxTpICi1SqlvTVK7nqzdlAHEBfBtME/uc0J9t
	 rafVUsnGw8mwxJl6+QttgReztJvMZp78jk3Q8Use2iAckDovgEt8fOUhrst9IpzJQ2
	 sPp2adyCyn8WhkvqjGZDS5ovibkNznT/ihbTYQQugREiQU6cMpgQzcQhTMZtZFj4J3
	 8lk4lwt/dXer5qhDC4ILi6W8EfeUCdt4ZPY1gu8e1doBLn1U2B2bitCTggO50cUQWg
	 B8vwfIxIl0FyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3DDF44858;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:11 -0500
Subject: [PATCH 01/23] PCI: Add SNIA SDXI accelerator sub-class
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-1-1d184cb5c60a@amd.com>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
In-Reply-To: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
 John.Kariuki@amd.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=777;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=0hS0icv4e/Aa4EokWK6lx8glYEB0shN8OGORA4fjcu4=;
 b=9aZablbuUb59BddxNdawfY+qt3YEjvA7XynRIR51YF5vdpNUz3+IQl2RoNT9EZ2Qg3NBu2pxm
 XIBv+8TG614AFHQBbZfWn/REVCC3iNfOAiA4DtR1dFrSg/HkSgf8G9F
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add sub-class code for SNIA Smart Data Accelerator Interface (SDXI).
See PCI Code and ID Assignment spec r1.14, sec 1.19.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 406abf629be2..e3c68f90f3ad 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -154,6 +154,7 @@
 
 #define PCI_BASE_CLASS_ACCELERATOR	0x12
 #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
+#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
 
 #define PCI_CLASS_OTHERS		0xff
 

-- 
2.53.0


