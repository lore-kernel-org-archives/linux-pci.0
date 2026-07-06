Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B025388E50;
	Mon,  6 Jul 2026 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306809; cv=none; b=CGP6iS6y4UJPLJRNI8o2TeEZ7PNzpEuezKaD4ICkYdYHAATqOdBuG3KR8DIPFiUTN6nAWLOOjAYAE9tqYM1xyBEF9C/M8AsNNFXlcXqnwcd2dYPW4V2BRSHSrMJWmEUsELPkCWw07OJ22nGM0N07Zig11Lt0+h/4iOcL5R2rbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306809; c=relaxed/simple;
	bh=AkfPA88hzw9mmbRqh680+6d2kNx1wp0KTT1gm8k6dXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2jyG04C+OLTLwheRGzPXMYH2nP57O6NAYBRtVfHjRxWNVmW1qEq0ocaVndMt+4t/bzpn88/NH+j1tQmJlp0lN5WI1W+So2kwOa5Ji0pQZCaW4Xzbwt2goxaFq3d98x8mKjg9LT+3RO5KfXXCtdYYv62x0KbOfz0EJB2nG1puUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gJ+zEycI; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gJ+zEycI"
Received: from localhost.localdomain (unknown [10.101.193.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9CA0942D1B;
	Mon,  6 Jul 2026 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783306470;
	bh=7oYFzpNHl6jwkjTAlFyl2KmP3mZQKW6NhYxlueuyVWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=gJ+zEycINoLWFf9noR+MQjwKojXmn0h8ZDBrU6vpJwitTzC5KCIgxiNXDQA7LRDjT
	 BIbEX42HtaL6MunQl8Bf3W1Rnv3ZcBFbUB75X2ySh34Q3dBIWFRv1UK0yXY8f4VaE3
	 +bOgvzXojbNERpVQsCIJ3LmZVe4MnRiXrhnH5ZWv+JWTfcJIJ1Q+CENSOoR506pklr
	 YHy/en+Y4DrAvEbXzv00i8pwZSf/6Dh71ZFvAp/Rnkpgu3hOrEy9JG4V1XY95MGAZX
	 K4fFqdueK3w1Gmgnqnx4sBwUsJfShA+L6+Dd52LfdG3hkeSx/K7HliCImFaGZi8vnm
	 nEQk53mduirsW92Bk2luGeitiSiFSlqoz7CDE5A5kHtfSaSrdKAHTq+ull2zBRDzTz
	 uLLQIVQ7m3w2DqkV6f5Ie4UgxHVhwiVc0wCRDC7z96PeoYS7+CLgWif/smGu+6W8JU
	 z9BhCpGt02JuyCzkGv4RXHDJOfuh1iwMSs1ASYfaNGaV1PxmVhmKUobdxHvgnprkm/
	 pJZXxyyCUbVBmP5+14Np7K/cSH2RN3PQ+jlvkoKemJpAH6wQAEJjRXV4+BUl9Ni2j6
	 qdflucZVRiuKjISeRF87ow1KvwPMo/Kf9TG3Oq+vYBEVoSgfwJGfRQUWfZg+0bLjU4
	 FGTO0eF/f42B4/ju4cu6okGs=
From: Max Lee <max.lee@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com,
	mani@kernel.org,
	helgaas@kernel.org,
	kaihengf@nvidia.com,
	victorshihgli@gmail.com,
	lukas@wunner.de,
	pandoh@google.com,
	Max Lee <max.lee@canonical.com>
Subject: [PATCH v3] PCI: Disable ASPM L0s for Realtek RTS525A
Date: Mon,  6 Jul 2026 10:53:58 +0800
Message-ID: <20260706025358.516607-1-max.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610024723.188514-1-max.lee@canonical.com>
References: <20260610024723.188514-1-max.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
HP ZBook Power 16 inch G11, the Root Port received tens of millions of
AER interrupts from the RTS525A even when the rtsx_pci driver was
blacklisted and the endpoint was not enabled by a driver.

Testing with OS-native AER control showed that disabling only L0s on the
RTS525A link stops new AER interrupt and counter growth while leaving L1
enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
storm.

Prevent the broken L0s configuration by removing L0s from the RTS525A
advertised ASPM capability.  This avoids enabling the non-working ASPM
state instead of masking the resulting AER Replay Timer Timeout reports.

Signed-off-by: Max Lee <max.lee@canonical.com>
---
Changes in v3:
  - Disable ASPM L0s for RTS525A instead of masking AER Replay Timer
    Timeout reports.
  - Keep ASPM L1 enabled based on testing that only L0s is required to
    reproduce the storm.
  - Drop the endpoint/root-port AER mask quirk from v2.

 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..e63ed055f466 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2520,6 +2520,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
+/* Realtek RTS525A generates Replay Timer Timeouts when L0s is enabled. */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x525a, quirk_disable_aspm_l0s);
+
 static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
 {
 	pcie_aspm_remove_cap(dev,
-- 
2.43.0

