Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519869;
	b=hVx+jElS6UdgUvVqVrpTANFRmffiH7Em0LvttuNg9bH2+qpiLr2KE8hL9xIe36cF2zd3
	 ec4eQdio/ez02UR4OVM6PsjwEHtZBP7Ome2m2zc/J6sK/9JCQ5VFEQdqtjscU68ja0jQc
	 FYsZbq7fdt9u4urldYZqy4880qqIlWEP+6YCeYJ08ohDmWcy2+7PUYNC+azRVbCPbh8F9
	 dUsZmI0sSGSXrRt38g3Nq/dH1ZjfhesdI6tHHEHSedyGHNvwcHoL+qBAwiF3+cpiiKni7
	 hAdEOqpE47jVwfQSxJ0krg9XfPOhtARV/obVmbdMmxqZkVsLkfDfPaJwumV9srFU4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ym49b0iug7aszg9sKvRy0g7m6DL1gnPAibODuAY4lA4=;
	b=ikTYGsItbq93knDo+61a6aEjt6wqdgOxOps2Jp3vyPZRR5ogzfAjWYCTJOSoxGaYqhv3
	 0v9dj/mtGznMK9ZOZ4GyAkXe20xem23TUu20lwETQlWFV3C8nMCWX90WqWahal2/rpBk8
	 Q6LafjJDWdKg1vkA9CLpHKzuwowNXNAsPykWzN+B8duuXxffqedbKlgjsKcpQLJs4TQ9/
	 cJz14qYthwA68EUd2mKXE7Nfw1qkcYFxmpkA64jYbnlXSyUdd+J7dPk+U9xXVMTcQ5856
	 U4IvvUJnxbwlDIpz4njd9ubsB2gSTzOvTe9nlYVFCGMTokpSAg77a7JuxEA3i4TAIuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=E1ZJdFMm;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A7606A31C
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=E1ZJdFMm
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35cbea41088so5809311eec.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792519868; x=1793124668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ym49b0iug7aszg9sKvRy0g7m6DL1gnPAibODuAY4lA4=;
        b=E1ZJdFMm05GbyBcvkXPVnMYUlAfeEc6J+KuQadUJexQm6DSNcYFHVV9espJqBenVkG
         PLfqj2B8TnuK3/0GLL+bTVmDTHno3vRYvl8X0yfPtDOtLTXKGU9rwkuZEVyW+q0Bx5HU
         upons782AikQc/u81NgKpmtda+AG0t5GmMf0onXPJr0hhd7iSlQ5AdDK054B2imMmdNE
         M7xE7Qrb0ZfL99822jJRCrW3lOSsE35FCpTYJ3P73qhhYBIEC7w/JoPAY6fqvosH42GI
         H3NYjLOfy347Xn3O/VmynMzHoNwzh9LC52jQAMktfK/RKpDmBRMDCQXHfFAkaEn0dzVG
         C5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519868; x=1793124668;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ym49b0iug7aszg9sKvRy0g7m6DL1gnPAibODuAY4lA4=;
        b=mSLSJLpSOjqur7SjrQuHEK2g630KiajYI/33ixy4X2+6UUE9FitGVIwNAV2JZhH9wu
         HvZj0ECViVB4knjp5MQPt2XqMCFl49hYSLzqrvYQSmLUdIh1TvNb7f7NkxBZbDMF7m7W
         vl2zJLtUqD2tsyUJhBPYVELvaWnrG0OC7obB1Ew8YdsQ8Wc/GVoAEQiNTUcFVC60SMNS
         YNnRsNiVsJkk+dM/u2hF9slCT1UKiKr14q8AIMK9ZAclunKlDruB11W3MXD1z6fax88H
         SVNtDSrJZzQ7Asxgf6qYZrCRQWGhxcqtLU6/LIXyBSmakyvEtSN1+7CR6+RfM5rPd9ZV
         NxGw==
X-Forwarded-Encrypted: i=1; AKwUvBwU/HlljTeyhPkkGgq8gaf7UOmfDc2u/ONrt2zW1QInLCfWJFlUAYa1pdNaCSZAwqCCZV7U6nIGK6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG+UuRK1Zx3ttBRB+lRDBul50Cz6dBUJ+E8aHlZ1DlUA7TmiQf
	S6KB9w+rtZ2Mn5EwEiB+QvGyLqzGy6nh/gwFoOWW8X/LulguvibGaOqKTW6cd82wMvg74oCiSw4
	SYg5h/jvCVIlllw==
X-Received: from dycmb19-n1.prod.google.com ([2002:a05:693c:20d3:10b0:351:731f:c917])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:bf9c:b0:34d:755b:d60b with SMTP id 5a478bee46e88-3674de4e3c1mr32887eec.34.1792519867908;
 Tue, 20 Oct 2026 11:11:07 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:10:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261020181053.2646782-1-digonzal@google.com>
Subject: [PATCH] PCI/ATS: Disable ATS when ACS TB is set upstream
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Decotigny <decot@google.com>, Sheena Mohan <sheenamo@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

Enabling ATS allows an endpoint to cache translations and initiate DMA
requests with Translated addresses, which an upstream bridge with ACS
Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
PCI_ACS_TB may remain set on upstream bridges.

Update pci_ats_supported() to walk upstream bridges and return false if
any bridge has PCI_ACS_TB set, leaving the endpoint to use Untranslated
addresses.

Tested by booting a machine with an endpoint advertising the ATS Capability
behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
system boots cleanly.

Signed-off-by: Danny Gonzalez <digonzal@google.com>
---
 drivers/pci/ats.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..094f4f825acf 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -31,6 +31,24 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 }
 
+static struct pci_dev *pci_acs_tb_path_blocked(struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+
+	for (bridge = pci_upstream_bridge(dev); bridge;
+	     bridge = pci_upstream_bridge(bridge)) {
+		u16 ctrl;
+
+		if (!bridge->acs_cap)
+			continue;
+		pci_read_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
+				     &ctrl);
+		if (ctrl & PCI_ACS_TB)
+			return bridge;
+	}
+	return NULL;
+}
+
 /**
  * pci_ats_supported - check if the device can use ATS
  * @dev: the PCI device
@@ -40,12 +58,22 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
+	struct pci_dev *bridge;
+
 	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
 	if (dev->is_virtfn)
 		return pci_ats_supported(pci_physfn(dev));
 
+	/* Do not allow ATS if any upstream bridge blocks translation */
+	bridge = pci_acs_tb_path_blocked(dev);
+	if (bridge) {
+		pci_warn_once(dev, "ATS disabled: upstream bridge %s has ACS Translation Blocking enabled\n",
+			      pci_name(bridge));
+		return false;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
-- 
2.56.0.218.g1ec904b173-goog

