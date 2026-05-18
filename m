Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD78C3F8EAF
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110636; cv=pass; b=ZURRgKL1AtHKS8ByNVdcnec/pZHZuD0pHykzp0IiIHRJeNzqzKQrhIv09/FvU91Xzr7ULzEFw3gA69ag2Z27QH5KKyriAEYQV3J8Aq4P/y/qjn3JntIFC9gMN+MugA4+PYOK0IPd8B65HqxEAiGbb0KWlPxgt+7qpohqDcZLnGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110636; c=relaxed/simple;
	bh=r8uqepWtcWCbo3g8XZJgo8dJTIh+Bn53roFrsh/VdHg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AS8O+IDu2uB69mODjsgdEh8r3dt++XX4+vLP80Tcv/pi9XBVBG7KNdxC7p5xwgrAuoFhmep4PGtjRGU2g5B/RLO9m5PAwj2usQmA+3H/xXHUv0aqGvnyxmCIcchVLB0kN//erEucnjKxtb/wmePe37AfnrSZBoVvcpK258Nm9ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=IAgMEVnM; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IAgMEVnM"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa0862dda1so3151421e87.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 06:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779110629; cv=none;
        d=google.com; s=arc-20240605;
        b=T7c9fEWSZkdfAMmQYgoCCVd7wdfR+9E1bNqWZihkXMg7IKaPGuuPX2QEDDf1eBvySf
         fBlI2tR9Mz0k51vpVxRNh9pPS6cqsfT3AOerU+r0nYEqlThCjYQ3Ih8qgvLFPRXEDth+
         mTWjzcDgaRQNX+33tu67C/Mdk5gvhqeHa2x1zw589QYUoAPpW8CKdWTWh9JnoFNweu5b
         WPeYvm30AblTPzUjM/2jiesz+qr+7UzpOh6vpmeiPSYkEL1tQg/ysMO0aoYkJelZ7agc
         zV9XXbxyAXjXpqdwceZfPcKlX9yQjzlE9VT1TFrFgoYDimH9MVKHu9sLTcjiLslWWdsA
         x46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
        fh=1QNRJUQSCPl+1p7yfiXJtfw2CJt6d13R4gD3RZZBrgY=;
        b=AjxKwSBF+Yx2vXspHNFdiY/bFis5YsbvaB8qpHs6+Of58xqu4FLGyizsLv2ade6h7X
         1IFESnIxcdpx6TJfInlbpu3MSfPNtonA/u+U4AfdD3T/hdymwITBPEQEtr61EC9afB4E
         clnaRl3Uje9vlG/HI2xc+zMhA5phXMKZGUfSpHZGm8QNu343Ma5nSyWXIhj8oHZF7ct9
         99Wgy79nrab0PE8NT/MeArFogJx1vaP50XRObWu18MBpllDNhmPyM+VspEEJ1+AvSOa5
         k7yWIhrtirJ5ud4F4NR4y+tpqs7lxV3+9HF0kbUKqv2+ZnIZxMYhVu3f2Krmj7abznKd
         WnpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779110629; x=1779715429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
        b=IAgMEVnMi1RJzReH/uLaU/G976gdfc3xFwpfpAmbKgbyWMG5nI02yfsLgVE/4ywLs+
         3KGu1Q5e2IEhaTWv4dTnDC2MefgpN5wjGvAtqe3Hu89gz2XfwT+Cz9KAKs01a/RO6YJ3
         jvVYguNthWc+c9ZajHgIA99LWNm4OaaONII6liMlgLx2DhgJR/9BbsnRbf4L/VPIGeWk
         7Mpo76+ZG7DMku1KY8zHrtwCYUW+EQMJ9HHE8DTW5yFlygCUDubK9nplOVOUY6XSQaXh
         Y45cKEtGT8NMemCYTxVBzNHkpTV7dpRKRpSRNvU03evGIX4BrLKUfhWHPZB0186od+vf
         Q7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110629; x=1779715429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
        b=dIIqoCC6CD32fcKBspmwhiFq9Oqzc1YUpfKmGJh3fnjYi4+W3o9SUgwzUCpZ4sHhPU
         kYPvt205nHqNh377Ew9/GrT0SRaT/iHysuPQKus/6QJd/Hla2NqzbcfeZOkxMDNuXGRb
         cosRp3h31rDpZQLY/hCqtfwW5y9FnoWPw4m+mzTHh47fkcm+ZrdJwSfqgAEGPaKfnCNv
         KaFQ7XRz2Ma2HRwsH2qMmEJ3KO+gnU8HsVzpuzw8fzMWEtLdf8R0LC9enDNOGYG4ZG8Z
         oPmJiiHZPAv+JVCcXNXdOUZJYNuVYQJXOka53Z6C4afJje05JeDCHEsJjc+canAmWCEw
         alCQ==
X-Forwarded-Encrypted: i=1; AFNElJ++Fc+g6Sqr87Z638GSTw7PjxZeyrk9fmZvg/HgLjjiI78Nw1lFgQTcy/Gcb8/zbiF2lU/wm9bT2nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyua9Utqoz4MlIgNOUpMthEo+YtJDojsDBTkIk+SChu2UHCkdnU
	UW91aFplJgve3oEYC+9e4V4Yc/4YdYmVTZVkNtzKd7pWS5HsxJmuoSsUu/Ea8RnBzVoEXtBxZRi
	HzTSXNCVpijQwc3iLaxtDn+w4NF1ACUCXouLrGt7j
X-Gm-Gg: Acq92OHsvUzyPyN9iB7M4tBkRt0BhsJiiyFTPLVKu2QPZbAUFe5FRW7/CIO8ye6FfRc
	dKN2Tu6frkN+eCw1UsIcgyqRZncatQ+R/q9dgTnvA7rgp/Qkqmc0EFVsvJxCBAU080g0LkUfQx7
	a+ECwvSeWb7vex09V/LSohA3Nyy+JvA4IRcPbFM1O9tWLnFbkfh20nufnVfvo5l0VPpFQvy+hkO
	nuriFVUKe11jxMXumt8CJ/xDu2H8JtRRiTCj0MtaFBEbC+MqkdFrg9XR9RO+A8qxcSytYnB7OYQ
	+kkGh1IxkXw6T73c3fc=
X-Received: by 2002:a05:6512:3d04:b0:5a2:b8cf:39ce with SMTP id
 2adb3069b0e04-5aa0e7428damr4225351e87.10.1779110628885; Mon, 18 May 2026
 06:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yury Murashka <yurypm@arista.com>
Date: Mon, 18 May 2026 14:23:36 +0100
X-Gm-Features: AVHnY4JOrJy53gmu77kAh1twBosgSM7U8IAMkHT73ISMbEifpQmD_iNo2Y-2TdY
Message-ID: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
Subject: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: bhelgaas@google.com, mahesh@linux.ibm.com
Cc: oohall@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Yury Murashka <yurypm@arista.com>
Content-Type: text/plain; charset="UTF-8"

pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
If a new AER error is subsequently reported, the AER driver calls
find_source_device() to find the source of the error. It rescans the
whole bus and picks the first device reporting an AER error. Because the
previous error was never cleared, the error is attributed to the wrong
device and AER recovery is started for the wrong device.

Add a kernel boot parameter pci=aer_clear_on_recovery_failure to clear
AER error status even when recovery fails, preventing stale errors from
causing incorrect device identification on subsequent AER events.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/err.c                          | 13 +++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb..5a9e266f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5301,6 +5301,11 @@ Kernel parameters
                nomio           [S390] Do not use MIO instructions.
                norid           [S390] ignore the RID field and force use of
                                one PCI domain per PCI function
+               aer_clear_on_recovery_failure
+                               [PCIE] If the PCIEAER kernel config parameter is
+                               enabled, this kernel boot option can be used to
+                               enable AER errors cleanup even if error recovery
+                               failed.
                notph           [PCIE] If the PCIE_TPH kernel config parameter
                                is enabled, this kernel boot option can be used
                                to disable PCIe TLP Processing Hints support
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651..701459c62 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6769,6 +6769,8 @@ static int __init pci_setup(char *str)
                                disable_acs_redir_param = str + 18;
                        } else if (!strncmp(str, "config_acs=", 11)) {
                                config_acs_param = str + 11;
+                       } else if (!strncmp(str,
"aer_clear_on_recovery_failure", 29)) {
+                               pci_enable_aer_clear_on_recovery_failure();
                        } else {
                                pr_err("PCI: Unknown option `%s'\n", str);
                        }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e5..093a7c896 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1292,6 +1292,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
+void pci_enable_aer_clear_on_recovery_failure(void);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
@@ -1301,6 +1302,7 @@ static inline int pci_aer_clear_status(struct
pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) {
return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
+static inline void pci_enable_aer_clear_on_recovery_failure(void) { }
 #endif

 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc11..29d655a34 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,6 +21,13 @@
 #include "portdrv.h"
 #include "../pci.h"

+static int enable_aer_clear_on_recovery_failure;
+
+void pci_enable_aer_clear_on_recovery_failure(void)
+{
+       enable_aer_clear_on_recovery_failure = 1;
+}
+
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
                                  enum pci_ers_result new)
 {
@@ -289,6 +296,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
        return status;

 failed:
+       if (enable_aer_clear_on_recovery_failure &&
+           (host->native_aer || pcie_ports_native)) {
+               pcie_clear_device_status(dev);
+               pci_aer_clear_nonfatal_status(dev);
+       }
+
        pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

        pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
--
2.51.0
