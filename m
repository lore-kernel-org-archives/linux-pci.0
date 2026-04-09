Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E91B7910
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746896; cv=none; b=P14DYowAQ0WsinpOR7twwSD6FLYuzYI2IoS11i06ZL5eKpyhsPaTRhVYmsKz3VFqUhlWHUN5t+KeALTFiJwTzwQfmEyPx375jfyqL+WbRnEqDja772hs49GxgCJ4U+gcJO2Btgvfe692+Awij9VXpbcq0ro/JntVsILwdfqdELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746896; c=relaxed/simple;
	bh=0dUpKuRld0LNuKQNAGx/U+q/AkjRKZGFOUSuzM0yjyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VLVtwPf0YbNK9oPtTorvoUhbB20lAZyuku6dW1DHgEMNYEE+TQQxmPg3D2MMbWSqU1cm0MXVit/MCTRVsqbMKQKxi8qrfDO07YXCZemV9wjWrDGaIVw6+bVoU6+9ewwx5HWwyLepmSGPfIs/k7W9WPbS4Xt3Z01RhrfvlKHGlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crX6Eh/L; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crX6Eh/L"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8e8c47a3so27779741cf.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746895; x=1776351695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nO53q0xyW1duF5akyybiEZjbURbECt/Kcb+1zYaiQFk=;
        b=crX6Eh/L5Nnvo1mYJNsTHYJ/wq6eoCUO1jL3SyauDB9wprFXBF2Qwi2KzJlh5GURSK
         O99OvZK01e4xfk5LewWqm/XSSxr6uwG25l6Vuqw5tVeWGki0c7q++5fy7wUAbPgLh9GH
         vRFrIxk/RuMhqB5D1MIMAmz9wfq0xEFR3VYdMBEcQuBrBsTYQfGA9Wos35PfRmzf45TQ
         PsYilMclwc2oMjcXaIfPqM6p7okcG3IqIIuxXVAy/VyFW97PUvuJJe/Ef+sRM9h82Dv7
         xU7edbsJ4eDItzb9qEURgLuicw4N5mnbpAOSHtfWhR8xFWOQ42rwMZu/2GiAN5mHAawZ
         mCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746895; x=1776351695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nO53q0xyW1duF5akyybiEZjbURbECt/Kcb+1zYaiQFk=;
        b=YRijJVZhQAi+/DsPkQ8ZqPUbr2FnqPWMQuvX/YClfwpoEcr1kPr/AFzYToMYJR+C08
         MplF9epjJ2RI+61Hv7HydQa1IFlVHQF6ahFpG3HrORe2sTI3CG6E0QtyjzNXQ7vHLN1p
         b15wBGfcZtl8SqoTHUNGu/ELXfuv1NtsUSQGI/v+DXdSZdLc2ktn0GkdZo53jXwt84FR
         FkHby10J8uybz3uhEcJmgdqJSaGcYQM4GnVQUoMrJ2MAaMl8icHpzdgO7kZKfqIE9RqN
         phoj+xQTVGfZvGf318naBNWqBSbSCCjarX9QsPpJ6DWdxyMZe91pMzEWH9I/jTdu87D1
         jXlQ==
X-Gm-Message-State: AOJu0YwOhc2Pg16S+cBP9D49/QhYBXHaAIphheW7WtxwHoKkQo5bh1Mn
	URbCAcu0sh2e4J0GobX2FnX3DBX5c65JBicWbRNsp5VSERbWTbbgcEKdCJxDF76PHi8KolgXAQS
	iCJBsdCwdRg==
X-Received: from qtxl14.prod.google.com ([2002:a05:622a:50e:b0:50b:85bc:e768])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:6906:0:b0:50b:3d9f:384e
 with SMTP id d75a77b69052e-50d62cbf981mr369957251cf.44.1775746893057; Thu, 09
 Apr 2026 08:01:33 -0700 (PDT)
Date: Thu,  9 Apr 2026 15:01:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409150123.3538444-1-jmoroni@google.com>
Subject: [PATCH 1/2] PCI/P2PDMA: Allow wildcard device IDs in host bridge list
From: Jacob Moroni <jmoroni@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	David Hu <xuehaohu@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the pci_p2pdma_whitelist array requires an exact match
for both vendor and device ID. Some hardware vendors support cross
bridge p2p across their entire silicon lineup, so add support for
wildcard device IDs to avoid the need to continuously update this
array.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/pci/p2pdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e0f546166..25e9358d0 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -530,7 +530,7 @@ static bool cpu_supports_p2pdma(void)
 
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
-	unsigned short device;
+	int device;
 	enum {
 		REQ_SAME_HOST_BRIDGE	= 1 << 0,
 	} flags;
@@ -601,8 +601,12 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 	device = root->device;
 
 	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
-		if (vendor != entry->vendor || device != entry->device)
+		if (vendor != entry->vendor)
 			continue;
+
+		if (entry->device != PCI_ANY_ID && device != entry->device)
+			continue;
+
 		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
 			return false;
 
-- 
2.53.0.1213.gd9a14994de-goog

