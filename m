Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134198;
	b=eSJNOdHMuN43wuTHOfe4sAk9Ahv4dD74UTSZMV9akMRtYkVFJZqXDn6/ZKTz29QNCc3u
	 MF1ZizfZoPdGxdSM+7HPkoPjFqP8EuVLnU0LXwZEnnHqUDoy4Js8OkAdCbDM9+pPjZIXN
	 FmGR6n/9lmOwUY+5R+ll9qIZrbaWo/z6gUm8eP+hKhftg5kKhzycDvYXWv6gAjgOLxzt8
	 ffhI5ZHuH66ZivZSiwYrGp0RVTAMAXMi3Jzo/dPFJrQqMLXTzsZUS829ic48THEmHFihh
	 Z2waU9lcqGHq4gcYN0uVxRIV1Y8QwlySaetQcXfONuolUnjOgJkAULRPJBnu8iNQC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RhGQm/UF9vMhWbFcBfDkOgWYLiWfHuOG+Gc7mXjwfx8=;
	b=GwQcEq1IzRw0tIo0YGzWdqKQF+oAQAGVSsSe84SreqKmljWZVJcb1kD3alhEf8kJ2/Tn
	 VYIlc3pnScppnKvmp6kMPirG8GeqbAm8BZWjWYgYX41o5Rfye8u3eNitvh+SbwtpXhzQ7
	 REddoSdDPbzAWye9h6V3q7lWNaTp6c4u0LOK92xXNKbglQjfOnDLBcKIZ1h4k/DSdPfGJ
	 Dw4TDcwoq7p350jcdVK7j2GOlAaqG74SZe8BAs+jPbsCg0cJ6tmrtmfoxN4fDMB0XP4s9
	 j1YoXOjpjJOinYSUqAh9mQVzkQ6WCm7HoI9zIHCb3lXrWfDtS4GmF4PSK4Hy2cDGAVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DbtLXRIu;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299B60A260C
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E299B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DbtLXRIu
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so423525eec.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 16:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795134197; x=1795738997; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RhGQm/UF9vMhWbFcBfDkOgWYLiWfHuOG+Gc7mXjwfx8=;
        b=DbtLXRIu3Ph7iF1hmZe9jA96DPyHZoPR+YhpvVw3xa+eD/ELZEQXa6OlMROdfLVYAl
         958lXS/RAoR2dvUudKiJXL9rZC6dPK9LJjkz1bWNepr2Zn+92eGvhoyxP5Zzwno+WwTF
         TYw1OHFqKxCGFv8ceDX805r/xQO/S1LKxQW9yDM4z9dr+gXW/ySabtQf8tyMc6IK+kLG
         jsqh+CY5tSPIGoAgA+XFkqXIIgmUlQtiddsiInw/0OQaKLnR2ewXQF1rjI3gODM8QZPg
         gbXIho5pfiLxbt8HglRkksHMt8vi0KaN1Eiift41OEZndaLm2VtS7Vq+kYe1DG6pRSjZ
         5tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134197; x=1795738997;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhGQm/UF9vMhWbFcBfDkOgWYLiWfHuOG+Gc7mXjwfx8=;
        b=A14Z30OjxOTul2u1ft56FgmNpbQl7baeRtnpxpVdwSlTxEyn/fXXApocdAzVpC8Z5D
         wxkEv7IjrjLePfcGQld9QLndF0UhCTmZMiJ/UyjvNXU7ohcJh4/jNurXkyBSpiOMvgxq
         IoP5LwrAvaUocH9gKhwimIZ0yQIBT3VLa68vMzzW/KWeKPCp78Sn86RKdYwlXqItMDoH
         YkcWu/t+2NcPQSPyLogTntWTOU1IqejMDBuyD/EQiCQP+JvzsaCqI+q/B2QZnZxJUj47
         v7tHzOX0NJNPuPDkosrs6BTpMw5osU7Toqt2Ek95/CXrCF8yFe+dqakQNsQm0SLY6RTQ
         e25w==
X-Forwarded-Encrypted: i=1; AL+hErFu0xSMv45jVO/umuogeUHFWq7EWJ7Rqhi3k+c7wu6wJubk8TCq/I6p/BX8QsVIf+VjZ/824TAW3i0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lsStBVJeZCyoB3kEh14jdiUjZA+n7vpVlY1Zlv+ZpeaoL+/tF
	s8WPoI/7fudRc3F3NZ5eXKNtLrBzNeRsUFhGkXlSUMQyAu/7lTPq0tjjbGMlUAkBtnLPUh58fMC
	I6DdFw/WxjtlIww==
X-Received: from dlbrf24.prod.google.com ([2002:a05:7022:f218:b0:196:1ea7:17b6])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:220d:b0:1ab:fe29:5055 with SMTP id a92af1059eb24-1b556865255mr1475296c88.9.1795134196559;
 Thu, 19 Nov 2026 16:23:16 -0800 (PST)
Date: Fri, 20 Nov 2026 00:23:11 +0000
In-Reply-To: <20261120002311.394649-1-digonzal@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120002311.394649-1-digonzal@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120002311.394649-3-digonzal@google.com>
Subject: [PATCH v3 2/2] PCI/ATS: Disable ATS when ACS TB is set upstream
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, decot@google.com, praan@google.com, 
	sheenamo@google.com, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

Enabling ATS allows an endpoint to cache translations and initiate DMA
requests with Translated addresses, which an upstream bridge with ACS
Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
PCI_ACS_TB may remain set on upstream bridges.

Update pci_ats_supported() to walk upstream bridges and return false if
any bridge has PCI_ACS_TB set, leaving the endpoint to use Untranslated
addresses. Ignore bridges whose config read fails or returns an error
response (PCI_POSSIBLE_ERROR()) so inaccessible bridges are not treated
as having PCI_ACS_TB set.

Tested by booting a machine with an endpoint advertising the ATS Capability
behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
system boots cleanly.

Signed-off-by: Danny Gonzalez <digonzal@google.com>
---

v3:
 - Move the upstream ACS TB check back into pci_ats_supported(),
   dropping pci_ats_check_acs() and changes to pci-driver.c and pci.h
 - Read PCI_ACS_CTRL directly and check the return value and
   PCI_POSSIBLE_ERROR() so inaccessible bridges are not treated as
   having PCI_ACS_TB set
 - Remove the pci_warn_once() logging and separate helper function

v2 (based on sashiko review):
 - Move the upstream ACS TB check from pci_ats_supported() into
   pci_ats_check_acs() called after pci_enable_acs()
 - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly

 drivers/pci/ats.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..e3c78a575800 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,12 +40,31 @@ void pci_ats_init(struct pci_dev *dev)
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
+	for (bridge = pci_upstream_bridge(dev); bridge;
+	     bridge = pci_upstream_bridge(bridge)) {
+		u16 ctrl;
+		int ret;
+
+		if (!bridge->acs_cap)
+			continue;
+		ret = pci_read_config_word(bridge,
+					   bridge->acs_cap + PCI_ACS_CTRL,
+					   &ctrl);
+		if (ret || PCI_POSSIBLE_ERROR(ctrl))
+			continue;
+		if (ctrl & PCI_ACS_TB)
+			return false;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
-- 
2.56.1.708.g77570a6a1d-goog

