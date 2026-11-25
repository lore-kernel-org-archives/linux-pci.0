Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588297;
	b=rsfeLaBjKS8R1rw6Ew8EHBY8outvZ5WqCv2lqlKjUm/GoJ5EDjSl2rgLl8wDSviZLnf3
	 N8aTgUcVZsHWV9LLceFAr2nIELPOMsbdro/JotHqrQw7ftagaID5fm6gVTYI006zkYWsr
	 clDbKYP5Ctv3M2Zgwj3XwecqP1PeF6je3jz5IZ+zohm2Ju5e04a952erDxRZQFiRhzzuM
	 92F5DLlQx6cVfthzwbso408YfvM7nB5YimjicN32dIzkUFSxLB9I2ddc5qIhaBUQa0InN
	 lC6ili2K5YUp4sGO0vLGnMZjRPD8HvCyEiq7l7JbhTj3ZBcNszReG94HoupkR4i/hZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=u1fr5mEso5Out/u6VPlJulnXboKyZvfVi9rGBsfIp30=;
	b=gHSac+D7O6Sm0ZGDLwWupgQBO9/6359TL0ZtSNI8ujILW3IiEt679K8ARIf6bHkw0hi8
	 WilGaJ/M2uLeSuhmmfW6ps5H/LSBRb0cW1F8dsGWwY8KiZ0L+2IRpxncGrmhcbQR4cODt
	 MwoWaaiganCcFomF9Sl2pkuzgHnrqUBnqRUneNbp4k+lsjEeIhuzROGgWnR3yoNfraD38
	 +IKmYZkcEdesZD4POeBrwql3g6Os7Yl6I03IZJK6rRqebWe6FQmN21YG6dxM095cIUr/T
	 Gfk3YKhYGHzpAh+0URU/jwfG8r4FejZiWrt4w3d8c5PtjUqRUgHv12u+KGX5C0os9yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AUD4m5G1;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF98606A337
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF98606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AUD4m5G1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so4499905a91.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 22:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795588295; x=1796193095; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1fr5mEso5Out/u6VPlJulnXboKyZvfVi9rGBsfIp30=;
        b=AUD4m5G1JqgSQ7lciH2BuoyXb9niiqD73Lf8COEEMhhexIBKdOpERb4ytiE9CPA2+n
         rA1swAMHqB3R25NBKJ5Q7hCaMY+RZXlPEJWPYfaiQuN4bla7Z4t2+ewR0isgpPJS7i5O
         tMuhVG/uyZDYMtBIM7wWY0yaVKTdyiJdQzZwhJSVUcV0obxgkf2+wzFn/HlBxP4ens5I
         Y3CZI3lECOoEelBTmUUkhGqS5gI7JOEZmGbQQ2ZKihsvYktxbIpb/NzAjS8WYX+YAywM
         C04ESnPAoVIfWifh6P4dT15rozrOvnDtcLCuDdHYsQ9Qvl6oDuIBNQlx66FN70fOdGJd
         sFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588295; x=1796193095;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1fr5mEso5Out/u6VPlJulnXboKyZvfVi9rGBsfIp30=;
        b=1zgXHBSjtIRyyMJXeIzVeJBg/hkVOM9qW5jWnh9ZmKffpFnvyCwRjMhKGaOxoQM8kB
         Q3xonQNipSTHwMMmew4RhcXEwj5dHZN36Hhv5oDl9Podu8VlmXHWlMJegTtDf8aKkAN3
         FRFsa2JeEWOrWsRoUmoKuZot0KeL9fjuqpqe/pV0kmDHrSJdscE5YBAWtvALwOovfqqp
         u8RvbbF1jPaGMWWb4Ek0zGFlNRUzX7cGdp8ZmS58UC6O7/g2Qf1lZMfAqGHaeuR3N5ZU
         pPF27hnMeVHM4q0aD0E1+6oB8/l/O5yzsoAgzueq1fs+ULgh1Os6b0ei8J/+66ekan9Z
         rEIg==
X-Forwarded-Encrypted: i=1; AL+hErFOp1Kzihx1nMsWTgpYZJkQrl7Joy/FeXclF9eSsptCB1ulgVzCv5j+yUbPuGMSfj9TZ2RleOhuxEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LPLmA2O105zbj82o8gomC6LCrRUzYI5UG4TpfTUd7cetJZfz1
	ThATmZ+LnwW0eoHlOW++TeA1njW+XgyJi/MM9e/IPXpxw+ULnGR1ME0KCudyusE2iXSPYKFrLLN
	6sw75bfuSSTo6SltSZmQpmqoXIeLo17s6OA==
X-Received: from pjor7.prod.google.com ([2002:a17:90a:9407:b0:3ab:d09d:a37a])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b86:b0:3b3:fe22:2739 with SMTP id 98e67ed59e1d1-3b41c9c34b5mr15412543a91.54.1795588295319;
 Tue, 24 Nov 2026 22:31:35 -0800 (PST)
Date: Wed, 25 Nov 2026 06:31:33 +0000
In-Reply-To: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261125-pcie-link-endpoints-v8-1-19d49c17c05f@google.com>
Subject: [PATCH v8 1/3] PCI/ASPM: Add internal pcie_aspm_inhibit() helper
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Internal PCIe services such as Lane Margining at the Receiver need to
temporarily keep ASPM disabled on a link and restore its prior policy
afterward without clobbering link->aspm_disable, link->aspm_default,
L1 PM Substates, or Clock PM state.

pci_disable_link_state() permanently sets link->aspm_disable, and
pci_enable_link_state() intentionally refuses to clear it.  Introduce a
PCI-internal, reference-counted pcie_aspm_inhibit() helper:

- Track temporary inhibitors via aspm_inhibit_cnt on struct pcie_link_state
  under pci_bus_sem and aspm_lock.
- Force state = 0 in pcie_config_aspm_link() whenever aspm_inhibit_cnt is
  non-zero, so concurrent policy or sysfs changes still update the saved
  state cleanly and take effect once all inhibitors release.
- Return -EPERM rather than overriding firmware-enabled ASPM when the OS
  lacks ASPM control, and return 0 when ASPM support is disabled.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pci.h       |  6 +++++
 drivers/pci/pcie/aspm.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..e24a6dbf48ce 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1150,6 +1150,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_configure_ltr(struct pci_dev *pdev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
 void pcie_encode_t_power_on(u32 t_power_on_us, u8 *scale, u8 *value);
+int pcie_aspm_inhibit(struct pci_dev *pdev, bool inhibit);
 #else
 static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
@@ -1163,6 +1164,11 @@ static inline void pcie_encode_t_power_on(u32 t_power_on_us, u8 *scale, u8 *valu
 	*scale = 0;
 	*value = 0;
 }
+
+static inline int pcie_aspm_inhibit(struct pci_dev *pdev, bool inhibit)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b039b57f8466..0d43dc517098 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -245,6 +245,8 @@ struct pcie_link_state {
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
+
+	unsigned int aspm_inhibit_cnt;	/* Reference count of inhibitors */
 };
 
 static bool aspm_disabled, aspm_force;
@@ -1055,6 +1057,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
+	/* Temporary inhibition overrides configured policy without mutating it */
+	if (link->aspm_inhibit_cnt)
+		state = 0;
+
 	/* Can't enable any substates if L1 is not enabled */
 	if (!(state & PCIE_LINK_STATE_L1))
 		state &= ~PCIE_LINK_STATE_L1SS;
@@ -1538,6 +1544,70 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 	return 0;
 }
 
+/**
+ * pcie_aspm_inhibit - Temporarily inhibit or re-allow ASPM on a link
+ * @pdev: PCI device below the link (Downstream component of the link)
+ * @inhibit: True to inhibit ASPM, false to release the inhibition
+ *
+ * Maintain a reference count of temporary ASPM inhibitions on @pdev's
+ * upstream link without altering link->aspm_disable, link->aspm_default,
+ * or Clock PM state.  On the first inhibitor, ASPM is disabled in LNKCTL
+ * (Downstream component before Upstream component per PCIe r6.0 sec 7.5.3.7).
+ * When the last inhibitor releases, the configured ASPM policy is restored.
+ *
+ * Return: 0 on success, -EINVAL if @pdev has no ASPM link state or on an
+ * unbalanced release, -EBUSY on counter overflow, or -EPERM if the OS
+ * lacks ASPM control while firmware has ASPM enabled on the link.
+ */
+int pcie_aspm_inhibit(struct pci_dev *pdev, bool inhibit)
+{
+	struct pcie_link_state *link;
+	int ret = 0;
+
+	if (!pdev)
+		return -EINVAL;
+
+	if (!aspm_support_enabled)
+		return 0;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	link = pcie_aspm_get_link(pdev);
+	if (!link) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (inhibit) {
+		if (aspm_disabled && link->aspm_enabled) {
+			pci_warn_once(pdev,
+				      "can't inhibit ASPM; OS doesn't have ASPM control\n");
+			ret = -EPERM;
+			goto unlock;
+		}
+		if (link->aspm_inhibit_cnt == UINT_MAX) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+		if (++link->aspm_inhibit_cnt == 1)
+			pcie_config_aspm_link(link, 0);
+	} else {
+		if (WARN_ON_ONCE(!link->aspm_inhibit_cnt)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+		if (--link->aspm_inhibit_cnt == 0 && !aspm_disabled)
+			pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	}
+
+unlock:
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return ret;
+}
+
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);

-- 
2.56.1.831.g720f3f5937-goog

