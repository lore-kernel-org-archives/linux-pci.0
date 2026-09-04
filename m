Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270613A6B82
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490114; cv=none; b=eqXfnfKRVgaRgvFfbodqwXW1lPzN6Ek2PpYdAPEbvXM6dGwsIDHDKnA7l2uzlgRUacIvHq7OZGsdktthXnUs7xMmWaVAHshmIApwP75eG5rFRD9rc4FAigGDro339nWZ/JU7zUppsGNU5N2janN84FnWNfbORli/zzXaLI+C4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490114; c=relaxed/simple;
	bh=1M3as6/JbviFnzO+sZjaXmcLIqRvpUkfQlZvAuRD3Wk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/TM7cQ6k0uHXFnfDtFNgCfnEMNoljk+MrLu+c/3mRUBNNEDKHZRlI2Ujw5LmeeGLxtrlKp7R1fZbEI55nWrjb2DjBxHRp+KZC7Zw8W6vqAJ/u6LzEtXLC8WOPNr/ILhGA2QGS20AZ3nmWPZ5/OmXe6Ddi25vImtLYMVKyZ5XWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hn0T4dAy; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hn0T4dAy"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc39363cc88so692506a12.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788490111; x=1789094911; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sFYKtyudLOnvYV5nLPU7PI7+uaLgwyI8nUNXoVpPUU=;
        b=hn0T4dAyLdjsqyF2Xef1AO7c50OKWtz8oNLtMhE0WO05x0q2fAJgrMAG4Gn2xZoFJ5
         GI6pr5arf5d6oPSc9v+S2Y5B5EAqjpO0SNhsCy4sglUHgAVZbP06h17w3s0cIOf1X8Db
         m8zD0cPnT3UEaiENM/jZnjklfMfVxehJvWp60MId1TLtpI9Tp86JsClcJvuxUCJPjUO4
         mDzsoxPTWSGOH27QHgg0xxUAcTVmvwotFlXuCvF5G8W0EQIcW9OT8eJC5XYBHNoTuyby
         EAVWGd49hYhVJvFOL9pUP4XJrS7mo1B9smmLE/7Hlpw/MgTUEKNujfc7Pi7gNx4hRzgi
         Fe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490111; x=1789094911;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0sFYKtyudLOnvYV5nLPU7PI7+uaLgwyI8nUNXoVpPUU=;
        b=D7T8S4S4VJK6StjGKgt1QtUOtTdAWhZU7psP4ssnjmUvIjq5RMbBRic0gTG0uTYvQX
         oQif46MhqZawRl9SssKmeiE5BBfYNyuDi1vhvtpVZqkPfFd0JUTUE0huI3HNN04MrNfm
         w7qUhv/hVtgepDbk5WusgYYOi+mbBtbq4p8USXEHHWizgPDbkKcJtErpgEW0c7mLs3dC
         GIfakHLzOoPExwuanc4rlj4+MKJ9rglVspfwAhvQMHQVAzQFpUDyVR5rS5L+Z8AuZXoG
         SBQkmjzNerCOlKby7jUPMSc93D4DUtrdYlFjcuRgzGJeprWYFnH9PEmsT7Rvn3Xf7RzB
         xcoA==
X-Forwarded-Encrypted: i=1; AKwUvBwwLY5zwAbKPKumY56TtrDR36HLXR3v8w/GxjtROtlG3SNnCopi810X0bAMPQCKyLV+EAT/2aBgqZY=@vger.kernel.org
X-Gm-Message-State: AFuF++lkYq5CXaDLDvoyMha7cjP064vKihNr2N4M5T3XLnNk6UZgU40U
	CYQabmdu869FadhQ4I1b68QnYbmb+fQxbBX41qdUBkJ+uAGyTqzLInFnKFiL1CRIB0rhRIVGaiY
	PWy6DQV0UTBBGnk3gxpNvXbzZNoEMyje0yg==
X-Received: from pfbkx35.prod.google.com ([2002:a05:6a00:6f23:b0:848:5395:9a78])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4289:b0:852:38ea:3fd with SMTP id d2e1a72fcca58-861676b276dmr4658827b3a.11.1788490111027;
 Thu, 03 Sep 2026 19:48:31 -0700 (PDT)
Date: Fri, 04 Sep 2026 02:48:29 +0000
In-Reply-To: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260904-pcie-link-endpoints-v2-2-16fcb301a3e4@google.com>
Subject: [PATCH v2 2/3] PCI/ASPM: Add pci_aspm_inhibit() helper for temporary
 link state suppression
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	sashiko-bot@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Currently, pci_disable_link_state() permanently disables ASPM on a PCIe
link by setting link->aspm_disable. However, several kernel subsystems
and driver operations require temporary ASPM inhibition without
permanently disabling power management:
  - PCIe Lane Margining at Receiver (LMR): receiver testing requires
    the link to remain continuously in L0 throughout the test duration.
  - Device firmware updates (e.g. NICs and NVMe controllers): link
    latency or L1 transitions during firmware flashing can disrupt
    device communication.
  - Secondary Bus Reset and link retraining sequences: prevent
    unexpected L1/L1SS entry during link reset and recovery.

Because pci_disable_link_state() cannot be reversed by
pci_enable_link_state() to clear link->aspm_disable, drivers previously
attempted manual manipulations of PCI_EXP_LNKCTL (ASPMC). This
bypasses the ASPM driver, risking race conditions and state
desynchronization.

Introduce pci_aspm_inhibit() and pci_aspm_inhibit_locked() in the ASPM
driver:
  - Updates pcie_aspm_get_link() to resolve links for Root Ports, Switch
    Downstream Ports, and Endpoints uniformly.
  - Validates PCIe capability and resolves the link state under
    pci_bus_sem and aspm_lock in __pci_aspm_inhibit() before inspecting
    aspm_disabled with rate-limited logging, eliminating log floods and
    TOCTOU races with concurrent device removal.
  - Tracks inhibition via an aspm_inhibit_cnt reference counter on
    struct pcie_link_state.
  - When the first inhibitor requests suppression (aspm_inhibit_cnt == 1),
    forces the link to L0 via pcie_config_aspm_link(link, 0), which
    enforces spec-compliant disable sequencing (Downstream Component
    before Upstream Component per PCIe Base Specification Revision 7.0
    sec 7.5.3.7 & Table 7-24 "Link Control Register Description").
  - Waits under aspm_lock on initial inhibit to guarantee concurrent
    callers cannot access the link before the hardware transition
    stabilizes.
  - When all inhibitors have released (aspm_inhibit_cnt == 0), restores
    the configured ASPM policy to hardware (Upstream Component before
    Downstream Component per sec 7.5.3.7 & Table 7-24).

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aspm.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |   6 +++
 2 files changed, 106 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 95ac34a34bd5..4a85d029708b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
 #include <linux/init.h>
@@ -245,6 +246,9 @@ struct pcie_link_state {
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
+
+	/* Temporary ASPM Inhibit state */
+	unsigned int aspm_inhibit_cnt;	/* Reference count for ASPM inhibition */
 };
 
 static bool aspm_disabled, aspm_force;
@@ -1055,6 +1059,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
+	/* If ASPM is temporarily inhibited, force state to 0 (L0) */
+	if (link->aspm_inhibit_cnt)
+		state = 0;
+
 	/* Can't enable any substates if L1 is not enabled */
 	if (!(state & PCIE_LINK_STATE_L1))
 		state &= ~PCIE_LINK_STATE_L1SS;
@@ -1467,6 +1475,9 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	if (!pci_is_pcie(pdev))
 		return NULL;
 
+	if (pcie_downstream_port(pdev))
+		return pdev->link_state;
+
 	bridge = pci_upstream_bridge(pdev);
 	if (!bridge || !pci_is_pcie(bridge))
 		return NULL;
@@ -1531,6 +1542,95 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 	return 0;
 }
 
+/*
+ * __pci_aspm_inhibit() - Inhibit or restore ASPM L0s/L1 on a PCIe link.
+ *
+ * PCIe Base Specification Revision 7.0 sec 7.5.3.7 & Table 7-24 ("Link
+ * Control Register Description"):
+ * - To disable ASPM, software on Downstream Component (Endpoint / Upstream
+ *   Port) must disable ASPM prior to disabling ASPM on Upstream Component
+ *   (Root Port / Downstream Port).
+ * - To enable ASPM, software on Upstream Component (Root Port / Downstream
+ *   Port) must enable ASPM prior to enabling ASPM on Downstream Component
+ *   (Endpoint / Upstream Port).
+ */
+static int __pci_aspm_inhibit(struct pci_dev *pdev, bool inhibit, bool locked)
+{
+	struct pcie_link_state *link;
+	int ret = 0;
+
+	if (!pdev || !pci_is_pcie(pdev))
+		return -EINVAL;
+
+	pdev = pci_physfn(pdev);
+
+	if (!locked)
+		down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	link = pcie_aspm_get_link(pdev);
+	if (!link) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (aspm_disabled) {
+		pci_warn_once(pdev, "can't inhibit ASPM; OS doesn't have ASPM control\n");
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	if (inhibit) {
+		link->aspm_inhibit_cnt++;
+		if (link->aspm_inhibit_cnt == 1) {
+			pcie_config_aspm_link(link, 0);
+			usleep_range(2000, 3000);
+		}
+	} else {
+		if (WARN_ON_ONCE(link->aspm_inhibit_cnt == 0)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+
+		link->aspm_inhibit_cnt--;
+		if (link->aspm_inhibit_cnt == 0)
+			pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	}
+
+unlock:
+	mutex_unlock(&aspm_lock);
+	if (!locked)
+		up_read(&pci_bus_sem);
+
+	return ret;
+}
+
+int pci_aspm_inhibit_locked(struct pci_dev *pdev, bool inhibit)
+{
+	lockdep_assert_held_read(&pci_bus_sem);
+
+	return __pci_aspm_inhibit(pdev, inhibit, true);
+}
+EXPORT_SYMBOL_GPL(pci_aspm_inhibit_locked);
+
+/**
+ * pci_aspm_inhibit - Temporarily inhibit or restore ASPM on a PCIe link
+ * @pdev: PCI device on the link
+ * @inhibit: True to inhibit ASPM (transition to L0), false to release
+ *
+ * Increments/decrements a reference counter on the link's ASPM state. When
+ * @inhibit is true, forces the link to L0 on the first inhibitor. When @inhibit
+ * is false, restores the configured ASPM state once all inhibitors have
+ * released their claims.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int pci_aspm_inhibit(struct pci_dev *pdev, bool inhibit)
+{
+	return __pci_aspm_inhibit(pdev, inhibit, false);
+}
+EXPORT_SYMBOL_GPL(pci_aspm_inhibit);
+
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 671d8db5898e..b0ce8ee8d622 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1956,6 +1956,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
+int pci_aspm_inhibit(struct pci_dev *pdev, bool inhibit);
+int pci_aspm_inhibit_locked(struct pci_dev *pdev, bool inhibit);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
@@ -1968,6 +1970,10 @@ static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
+static inline int pci_aspm_inhibit(struct pci_dev *pdev, bool inhibit)
+{ return 0; }
+static inline int pci_aspm_inhibit_locked(struct pci_dev *pdev, bool inhibit)
+{ return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }

-- 
2.55.0.1003.g10538fe699-goog

