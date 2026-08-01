Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A946391838
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627528; cv=none; b=i5/3T2c0or9RZlpuhoE0hFXIAXkvXYlnsAWqX9j1TljxkPUvP4i6ymPNt7Lkd0IF3lyeICdoEZUqsmkxFCABLj+2U64WfxTJXnmxLwXmRqG91p9bGyYD8QDrOEYZUubVlV8bWrP5twYjKyYThMyWqsgfiuA1UYHca8DqfCTCMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627528; c=relaxed/simple;
	bh=Fpll1If+XrFTiEzxvdKsJQ6Sl7877EDLn6Omwn0QV1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWPsEr3MFf/XH+xCUMKjp86o0BA8eBwygU+V4TKW2CByrASi6eXI/qVqoiELFMz5BJLYnlWvzTBwPyzWmeYxAY7lRMGlzrgaKM/LenN9szTWcmf6A9Nv8etC9yPudBb4btQztBtK2RPQmIkFaWJYzEcLxGAEErtZAwg9FzaGup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OovJq9q4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OovJq9q4"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so20201806d6.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 16:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785627525; x=1786232325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VvriIWF36dfjdh7Dlc/O57gznAO1gCidw4KO/Z/TIrs=;
        b=OovJq9q4D/JNYpLmzpaUgn7TJXb3r/ddAbEmcgPrCd/3Wg4ShBG6BT8FVopGKcAa7G
         5qqLyiOwS+9x5kxA3twStzCMwXaRCrIV4t2IdWtblrTT269JOI8ByLfDLLEp7Lw9rzmB
         wdkcSmviB34RarpPEhvM4/1SR+iUsBPxqfF6YnO1icaOQgGwV569PRuyK/IQ/ZtCS4zw
         Co7mB/gVTNRHkDtz0GP+9PzCCm6PhhWAgs1eflb3E78wH9V9CbUmqBlAvb9n5X0eZXf1
         KxlkgYQ60Mx9oCAaM6qM4D5C4xxIbbwL7sv75Z9i2XaClDjRxRbClvvpwcue+80LZWgl
         egZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785627525; x=1786232325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VvriIWF36dfjdh7Dlc/O57gznAO1gCidw4KO/Z/TIrs=;
        b=OVCSYwxaCk5KJJ2r5Ytq2DNT9YFC0pxqjoQ48Q4w2IFurCRY3BUuFtJ7Uv6b8R7Ohm
         4h5sUinv5y44glJRdqvfzYCfTDtZ9sZ8fwIa0amZHNcZOEjt9TmR+JvoOuZmztCyvJ6W
         ZGkSMIGZ8ql0r4ltoheTnHb3S/5XKG0B/s6vio9zNTfgD2a0yF8z3tpiwrV0qdJ+fy4G
         jat8mq2pEmwgIIhbWy4w2F1w5NHSqM5IQ9SQjfRzBbbvIKa7yJZHGUDeplPdKuuBmZHy
         lA3YsSW0Wb2WSOYnvDlsl0wU2Aigt7p/G4WHn2qCz5kfTRI8/cLi2w2qMHKwDpAe4Jdm
         vjEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4VDchVzfT3KaiNFznf84XKJ+qpHtbnG7shCJuO3CSvPnPRbo+CnoWbAvUFP/3IiQdXO/hyE3m2qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4ehvm0qeRRGHvJvaezH6QJajjHKavlkXWgipcurZvTSTDAKp
	vr89As4iubztrOOoy7H/PcM/lq8/tHgI7Ce7rzPBljh9uIfBiDsJyra9
X-Gm-Gg: AR+sD10glVzYv0Ab+iApIN4YgMZ03/zE0981e6nmAzbbAon9oZb4xk6vfynmasdvjEJ
	JioKkMaNqU75ODm595pP/VgV/zwbreau8/3cTU0mpZ5JuTuL66Q/UJ+Vzol64/LqhmYBt4gxiT5
	y7uRCCqaIrM/qEbuYROgcFtOuHMzPNFmJSdlI57fg3vSWDnMLDrHA40RhxTVTpuJVFbS/dH76zY
	7Vr9ZKNqxTusY9eRrd34gxnE4xBlICuLWDn7Nuvi62j8KJGt70MkBD37WSg1J0jKkz7X1JIJTmo
	UsG7MfTZZgnzR/QyflcyzagSRJ/FCqwcLozVUP/Ho24njNp1XnsNnIF6Xqkiwqjg5ujXfiZiOWV
	vLZAiKHA9azF3hbUXDWHm6GFdFyCuZFQFfDFQXbnSO1E6xRSiftVV0XxbOy6vJx42FmK7h0sd0S
	ll9FR9g9WooDFfvuH+uqIf85Js3MOR7efcK7bUoSB4b+QRnBT9bS6f6IE0VpgAdfFx9qj0cKJW3
	HRgcOTAXwdJSpKiE90fGQxoizLKe2dEGtIg/PUQMH/BZE6a4DtFJHBMtjC8LKE=
X-Received: by 2002:a05:6214:4306:b0:907:d89f:f9ce with SMTP id 6a1803df08f44-908495e088emr118693976d6.12.1785627525442;
        Sat, 01 Aug 2026 16:38:45 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434a26basm42614176d6.12.2026.08.01.16.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 16:38:44 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: marek.vasut+renesas@mailbox.org,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PCI: rcar: Release temporary device tree node reference
Date: Sat,  1 Aug 2026 19:38:41 -0400
Message-ID: <20260801233841.469826-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_matching_node() returns a referenced node even when it is used
only as a boolean test. Keep the result in a scoped cleanup variable
so the reference is released after the match check.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cd9171eebc28..7ed1bc0732ce 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -1122,7 +1122,10 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
 
 static int __init rcar_pcie_init(void)
 {
-	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
+
+	if (np) {
 #ifdef CONFIG_ARM_LPAE
 		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
 				"asynchronous external abort");
-- 
2.43.0

