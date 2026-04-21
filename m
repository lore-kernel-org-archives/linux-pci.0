Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3E382293
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741659; cv=none; b=ct/nXRe4ZiqPIQS/qEwE3gNDKNZh1hQzgmNjl0Z21H5EBdN6BPQcABxSgSKXSEK0WAn+1OrlNcrYSnHTBPXGIqpaO38vq/Hh4EMiWt09W2kFuuOYSAMRHfHO2Uu44NIGH1SVBgayZfTdErlxYutUeytKfjw6bdYbjEUtc1GRF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741659; c=relaxed/simple;
	bh=O2E4CdfZ7Usp5PY9isuYsA7nHK5C9A8Hkp3iAd5U0Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYVdzF4oj1YB91yIpJ64z/Ie2FmcNJwylz/VY2NqyKfWqxh41Vwghj5AYoEUpEq5vBo6kdXGcvjgO88mUN0sd+xe/p9bDwMGrqIHwvqIkx3Lr2WVhqUKlVqFUksNtu6ruETBKdSgPZ+zfuGS2xVJ32bQvRe3kTvCnEmgy9cyZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBfG/8Ho; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBfG/8Ho"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so2857647b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776741657; x=1777346457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubMnOeDkqTk2dHHLJbjBEoJK4qf4ceJn4yhDeONpxwI=;
        b=JBfG/8HocRcEihDnBYoRI1Uk03ykMJJbG1kb/1SgY81k+ZE1dMI0BrzE2u8TEMJ8VI
         PGXT7NuJTrryT7UCkUIY0SYstRGkhqEIWgvLXmDTxEBnBIa10NtoJintInvPmNqZXnj8
         A1KaJ6XbZ5wXsXCPidOSwZb8RQDTZCzenihJwBlCtz/nmdiNaCHix46uUDj6/3xnumgS
         uZqSdYV61tDRiqQMxutfXbu3yi7VeRCl5JBOJ5jYDqtecsbwdjhkAtFjl8xFzI19kkwZ
         O+KMBwqx07xa2wQv67T8Jjb/WJNfcHFD+ECxzIvzp0P+9C2snpo1UJJ/hxjPT4VwVaJ0
         dAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776741657; x=1777346457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubMnOeDkqTk2dHHLJbjBEoJK4qf4ceJn4yhDeONpxwI=;
        b=eUzWKjC1zYL8L4D13Vz0AjmDPz+GlvxARubYc4AXXbGsXG3hE62GUyR2TXCCCND8Wf
         IOb+7idFDefVs3ylfDn/19q58PxCito8kppkpMpK8wIZzaNoZOMUYezxMZmlljSFIAnJ
         ztEXMvktGLOmfi4KDEe8/TvZUMgw+KZEweWIJcXcshEzBt6fQBA42L95UkNaKxVWGnY0
         VjJUUEydXMTLZtoRX2cOD34r3WDg3Y0sNaSKh6GHVp4F6+J3tbCZ36NCShIb/E3AemtT
         e373Jjky2cKTS8cXC3jcVasBWeJZCIhAW15ftnCeFgFOSTtF77y9lgIvalF7ba232sU3
         /BtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YrHI1jC2iDN6HLL/H7rRP1dePS5AaQw7h6FDQds27s7zp7jXtJ7SLCwY8w2voBb/j6keKN14M4b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkqwLVthH8/4zv8F4ka/3OMhZ/wmtE815W7G3I6f0W+5QnQVK
	rajKU7wTzqKJ5v88A7npkgvtd4VawCqZH09RqIKV/M9jR9SXrn85leX1
X-Gm-Gg: AeBDietZfqhEr92vlWx2847fJ7ZYecRSWsW0oU5/QCJmsQZvQeoS/PoeMUHUT1bzgCw
	4K7PdkB9nBySUV5leVu2kVrH0Qtr/ZOu8df7qQOnUcX8v4OM/dbE58RLbhJ9vQoNMBZ0K+VcWeY
	Yw9026JImYsGxhhC8SEZTiEXMtSi5gIbeXFEWNyu89dQP+2tWO6Ot2Y+Dc7cXAjFQB6kmLLeGqd
	RFLkZxXTnzEW7V5ehOBchQYNoRYbfoq9TRjNEzy6bUzOMGwgKbwH8u3dBATzbMu3wxBPqvyLd0E
	23WtQvrkos78yv1Z43UcxFx47FT/NUFc9sdPEoQ9oi60Z4cSx5H3hI8tsqcRi7Z9rDIFwNPWNDc
	EQUHZGRzuuT0hlV3lAhsrMlLpP1IGkSpi9veXuSE70KTeWpCo2uiyLVZxA0UnF7CL1xJ1KPBO3o
	reBTHBvrnhTpVYWS8ZjGCaUdD7rpWmikmw4g3PQhas9IlSBRMcBlgnK5S5OO88dM0JLhc=
X-Received: by 2002:a05:6a00:bd0a:b0:82c:9897:70e6 with SMTP id d2e1a72fcca58-82f8c8e8aaemr17361158b3a.34.1776741657347;
        Mon, 20 Apr 2026 20:20:57 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm12385858b3a.21.2026.04.20.20.20.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Apr 2026 20:20:56 -0700 (PDT)
From: neilfsun <loyou85@gmail.com>
X-Google-Original-From: neilfsun <neilfsun@tencent.com>
To: 18255117159@163.com
Cc: bhelgaas@google.com,
	hans.zhang@cixtech.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	loyou85@gmail.com,
	neilfsun@tencent.com,
	shawn.lin@rock-chips.com,
	tglx@kernel.org
Subject: [PATCH v2 v2] PCI/MSI: Fix memory leak in pci_alloc_irq_vectors_affinity INTx path
Date: Tue, 21 Apr 2026 11:20:44 +0800
Message-ID: <20260421032044.55948-1-neilfsun@tencent.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2caa071e-85ee-4e76-bb33-8f27a4579fac@163.com>
References: <2caa071e-85ee-4e76-bb33-8f27a4579fac@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the INTx fallback path of pci_alloc_irq_vectors_affinity(),
affinity masks are created and never freed.

Signed-off-by: neilfsun <neilfsun@tencent.com>
Signed-off-by: Sun Feng <loyou85@gmail.com>
Reviewed-by: Hans Zhang <18255117159@163.com>
---
v2: use __free to auto-release pointers
---
 drivers/pci/msi/api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b6272c..994f12813ce3 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -285,8 +285,10 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 * the device driver can adjust queue configuration
 			 * for the single interrupt case.
 			 */
-			if (affd)
-				irq_create_affinity_masks(1, affd);
+			if (affd) {
+				struct irq_affinity_desc *masks __free(kfree) =
+					irq_create_affinity_masks(1, affd);
+			}
 			pci_intx(dev, 1);
 			return 1;
 		}
-- 
2.52.0

