Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688337;
	b=yhrR+J59f9Q0dW11MkptlrQrovfY+5JXjBjvESSW+pM97W2pw4ZKV2XL0QP9371uyXJF
	 iG5CWOg8sMnhaUcjTEEZ72lm+p0o5NgTIoGXVgVSuQyi8RGCuqWET2k0qNTEplTGTO7wr
	 YvugbcYmppMdCHeoWKxDotPbWyXeP5xGt4D91uRpyx53ji1+E464a5XJNgT+mMSR8MTOz
	 FRSYhBi93citxkhR0U9NEJSDz+9t30j60XlO6QnbSZJRXEKkfTZ02yLQJJS3JcNrwuSMK
	 kBWZcGDCk9zHYknSPR7oW04Kt0EaT7xFOkWq+zZ/Z2Mi7q9Mu85ucC7hCa75MgD1Q9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
	b=RLesfIkrlflKBYDpg8vIu+SzZOM4ZZ3FdonLa9YU/rNPvzjD/n9YZiil8QVa3oKm9aG9
	 aH0uOFwrZX/ynFJUqrsMCb1Q+lmINYnOW0kYVZcZoBrrXJoqWMG+tl7XXjRifmcHg4uIx
	 AQmmWm9blvtFsmR6Nw1fWGUs5pdk1IbTIM7qlllSOl9/yxIkBhkxzGLzXcaXp9X9Pr0QQ
	 DE+z4vkw2s0AFtiNWcla3NQAGI6l5y5h1P8GHKOArsLbuC75Zwjt1eC7p4qB417Ln0CEt
	 v+6c6YBvNv48cc7xBRihMt+A2tTKLls9yl0gebgoe2PPzGfjNswfkIXsi3db5U5g2gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=FL1ZaMku;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47587606A32C
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 16:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47587606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=FL1ZaMku
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so56696eec.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688336; x=1793293136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
        b=FL1ZaMkuY3485iIc3ZQCn3sG+fTJWBdV09VwotBgZrc/rZo7Cho79baKAkZAUlJ2JY
         uu/5e9rj05pf3lj3sBw7UBZfpuBp8V08rw+qABCc+IFc7QxBq/C0X9x5iGEsZzPT4YiO
         zrSz/MpcrWnCNgS//YZKHTrYOOfNuhtDXhgdg/TaBAHletiw4lGLDbU0nTmcvzGDYMW7
         q4GnWSZmABXUt9yGZmbyTuUhddJQndmGdbu7IegHeKuwwHH18YRtaACBapikc2uLQlOh
         UjvxsWAClH91Qkx1lCxQCtYyCv+wCXzSGfdY/1596lds0RqodFwXVYChF6kpT9hTg4eG
         iOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688336; x=1793293136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
        b=nSO/wm4QOGJFbPrQ715Sz8zFQa05WO7UEAl17luJvINKL6ykIHoSvTGkxInN2oiXQR
         v1EhOifaawUtVOaI5fHbjSI+EjVSZwP8bMoFVfAvSReLC2vGHQAZxxQwfZ59ahfQzvnM
         9C/v9ZlHGbKP/W2fhtKeK+wcCuk33i5uox3K6jGr2GZB1iKbmczt7/6qpBZLiMF8aDKu
         +wV6dSkmmNcMMcXQWwxk8yN6J9f50X7mn+Pf9H0laDOPXiHvlnZRV09N0P0TX2F1UrvO
         jDXJ4JfcMKmh1mT/azu9NlvfMy6g3GApzV7aDZiIdTacjnnZnwgBp0EmixukttMT+rh9
         NyFw==
X-Forwarded-Encrypted: i=1; AKwUvBxhtWbIf2T0/Tgr+YnKGfoptfFP2ZAsO4uWzFWZ6VMxiren0c6NtNCWxAlHwHFzKyPTzHk6wjeCRPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIkL/92PBA2rT2ch4X5uQW2pK+4gUxtxvINfsgs+Wl4+NrXbox
	g1ja13epxvAkhEX+VbwhFCqFTKsYh2Fx1LH61azeQzYVgnX5q7onE5hDPJ/wjV+kiA==
X-Gm-Gg: AYBFou2B3e4K/itM8/e9jb5YNckCKZX2iBbQ9fprbZirYREnW3Xjnks0FPMLGpptIQs
	U2vM5WGshcs3Ge4fWBn6azdA66qc4hx4esLGrMckFeYqQAqAqJKH0NhAqJraBuOvqmvr9hCYRNR
	OIXc++x7fBM9eJO8HqFCkMrYGpw18xo0Olgg/1dAYpA4F9+OjHshHXY4jTdKLqhya1uebT7JZoI
	J2qiLho333yq3QwPlHTXOdUJZ77wSo2xD0q2thXlI0c077otnfsUncjrXzHFiCd4H+z+UQLspyD
	ad1s7W3q+qBGmXv1igfkLJGQX6absOmBrVQxIPRSKOrs3HjWPuGJU7aNscFXKY+wjlX9UlkEd89
	dHjeGPdX9lQiU7aC55PtaYYbKNiwZJwvmiFAa8CjdpDGrM0HSyXywU/yQpH1OCAwzoepJpZGZVB
	Mfk7/csD0AbRnGwGTnUKhNv5L5QJjAaKkMY119DrWk1U/ZaNGRgwVozCAfej3c1BqLtFBe9UE82
	7NNsVEgSmMJW3MqBtNoa8x6K7RcPgH/6YqGyfQ07sOKpXw2QIuyg8K10pdKfX5f4/mCS4t0xWM1
	IPHqOVvEmxpTc0cRlk8hc24FrwTBtHWYlXc=
X-Received: by 2002:a05:701b:204f:20b0:184:329d:eced with SMTP id a92af1059eb24-190a52de3edmr7715048c88.25.1792688336131;
        Thu, 22 Oct 2026 09:58:56 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:55 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/2] PCI: Add pci=noaer_recovery kernel boot option
Date: Thu, 22 Oct 2026 16:58:41 +0000
Message-ID: <20261022165842.1463451-2-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261022165842.1463451-1-yurypm@arista.com>
References: <20261022165842.1463451-1-yurypm@arista.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On large modular systems with a complex PCIe topology, allow userspace to
inspect uncorrectable AER errors before Linux attempts recovery.

Add pci=noaer_recovery to retain AER logging while skipping recovery for
uncorrectable errors. Check the option before dispatching either CXL RCH
internal errors or ordinary PCIe errors so CXL driver error callbacks
cannot bypass it. Also skip recovery for errors reported through GHES,
while retaining error logging and releasing error buffers and device
references.

Correctable errors continue to be handled normally. Skipping recovery
avoids its clearing of uncorrectable error status, but does not suppress
Root Port interrupt acknowledgment or change firmware error handling.
The option is AER-specific and does not disable DPC recovery.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
Changes in v3:
- Check the option before both CXL RCH and ordinary PCIe error dispatch.
- Preserve logging, correctable handling, and current GHES cleanup.
- Clarify the AER-only scope and rebase onto PCI next.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-2-yurypm@arista.com/
Review: https://lore.kernel.org/linux-pci/20260709190616.DF0CF1F000E9@smtp.kernel.org/

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/aer.c                          | 13 +++++++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4b..6047efd3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5118,6 +5118,11 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		noaer_recovery	[PCIE] Disable Linux AER recovery for
+				uncorrectable errors, including CXL RCH errors,
+				while retaining AER logging. Correctable errors
+				are handled normally. Requires CONFIG_PCIEAER.
+				Does not disable DPC or firmware error recovery.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a62af7320..9ca8d3fbb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6840,6 +6840,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noaer_recovery")) {
+				pci_no_aer_recovery();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c..ccc6a678c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1337,6 +1337,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_no_aer_recovery(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1348,6 +1349,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_no_aer_recovery(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c376c3adb..c41e5e13f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -142,6 +142,7 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_recovery_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -149,6 +150,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = true;
 }
 
+void pci_no_aer_recovery(void)
+{
+	pcie_aer_recovery_disable = true;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
@@ -1338,6 +1344,9 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
+	if (pcie_aer_recovery_disable && info->severity != AER_CORRECTABLE)
+		return;
+
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 }
@@ -1383,15 +1392,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (pdev) {
+		if (pdev && !pcie_aer_recovery_disable) {
 			if (entry.severity == AER_NONFATAL)
 				pcie_do_recovery(pdev, pci_channel_io_normal,
 						 aer_root_reset);
 			else if (entry.severity == AER_FATAL)
 				pcie_do_recovery(pdev, pci_channel_io_frozen,
 						 aer_root_reset);
-			pci_dev_put(pdev);
 		}
+		pci_dev_put(pdev);
 	}
 }
 
-- 
2.51.0

