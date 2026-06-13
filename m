Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9309349AF5
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781386550; cv=none; b=RuKiy9qmlWx0uyDWA+VmBML4wClaW55badTrsPzuDzOsHwtWg4iGqw319n55RzLRa8vJ2eXoWCtNhZWZE0pEpYXEotFxBuMu9Ja5mVcbJUucBCrEgLWDWGKXi7VEdtukK3OxjERFBl7lcEcBt8j3DDBx8/qeVGVY3vaCCXqPGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781386550; c=relaxed/simple;
	bh=gh0eMxe+xTnaGWrjDhG/+1ymRuCSRIVEeISo22Rq2bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlTCoXH5WU9sevGfZXxaDNCQTqr7oXY+cH1icdsM3xTkzCLjxnMgsYKDu/5iXBegaqk+R7fJulOYb31QFsL64DRsWU+Y5TPUuy55YJYqbnu9Vu1G29wThSIGawChHVeJX3IBb9jVK31O7WyOWvs4RFrE3jlsoOkRszV9wXs+Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVlRvXsI; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVlRvXsI"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-304cf518c9dso3359411eec.1
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781386548; x=1781991348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHfZuRt8cUJbl6UK8rp5h1bo/oiqYK21wWenYt3Hevg=;
        b=sVlRvXsIZRivqC9C4YJphZuT9k7w2tQLKQ+MGaeq2kaowDcLRNdWgyoZKFPopCGEvS
         337IiD+FNeR6M/8P2z4Ech7j7L2mQJTpgLvr8Oo3QpCAVstL/JydlCZi+MMGfmNL7zjE
         4moIPcbsuhzYTgcsnyCqlABKZhT9xrO7VZJIeWzza0lplilaW0b+beYrMVjsRSDL9uWh
         n2GMV5/+Hr0kLKF0EnTz985ypE+zE6lRgWSoZcfPuwIOczRs9BtSbXDJY2rdSuljrTQc
         BxpkWIhjIj4C62xxrdguY+fqZIYcQjoV1WspW3L8hIGyacu27vcDtE/Orxw6gxUhY4xq
         Se7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781386548; x=1781991348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHfZuRt8cUJbl6UK8rp5h1bo/oiqYK21wWenYt3Hevg=;
        b=p+P4rHfCTdj1BoT89kdcEsPhHSv9fhnkORbmnhEZm5fNUdiw+Qdmj/lEW5HNK4nrvn
         z450RV/RwZX0tr0/EjzwkM+GrMlDv0JTEOTuLd5PYKfyfXdH8UiY7UjhhRqxmcIRSCzK
         rfHcd85aGICpRUxl+VjTekoDWDJPOjEM5NdYDRT/H7T9tTz1PAfJaI1YyMp48gFtCFPh
         9kqcpZX/Awu/JA/sGTa7NA8+qpp5kCB1s8Q2w/xTnsaiArMgpp5iAvr82yvHdswU0qt8
         eQI8ZRfo6vz5vlVIdhVTyDapmfKnC1zb2KGLCuAl+n04lu2WaMJCtVYg/bO9uLc9Vrpp
         B+KA==
X-Gm-Message-State: AOJu0YzLBDzVQ/dvaJSYVZSAjzKmDOKDbCxxt7l4WtMRvZvOxbgtsVjv
	fNG0ImaDh7aoKy0Dix9+zuzR4xZsGqq6j24aKvPhogEEMRQOj6ciRUAw3BXjffWO
X-Gm-Gg: Acq92OFpe+iQP8JSPhIPXOWZYIGoXHY1pXWeae6M+bp5FiYkkln7Cy2igee8/ySLoGp
	/XWNKk7FZDeSoIzU9jntE6NSVmP/CjDgeFM6tLuyMJJV7MjtrBDc0FgzX00LlSf1uzj2Xzw1opO
	SMWJJqOuIPI4euOVEAXk4d7eT6opnTgHcLnwq/QmcE3o41Z35Lae0oPUSks4joBVQQ1q+IVXeq0
	mN5hKqMERXjfosQOB9x7MJToTB8glR90UEVWfEN8UCosu85di5SHZcCEPV/fsEXi6MNxef23LoQ
	C8EThKFt5MbQsqlUIkcZeyq7Y9Hh6sm0JKEKj0H9Wez26bP7CF9NffNii7oyIBFYbYm+SuFofOk
	F9RqTKQYt6DBuZmVRCdAhyE9l7Liyr8qYEDTUmkdCrsrKK6opvlzM2yj3Kz3TE2VnKOsaU2CDOK
	WYhGqoAiTbVaKTVtRETuMQt9xSN/roXJMTWEdxurfMOoudSC6ssYwUreWWPOb9xKRJ/mrLZrkGR
	zJDw4RcCWnjUKGPqyg6aT75AzhP32aFH+x37hI+NVMjugxIqC7ERLIbN43WCJICKdeOaLWMSObj
	koqASOGHwAkuQWiylElBr0jqWEg+
X-Received: by 2002:a05:693c:3007:b0:304:5a53:7dac with SMTP id 5a478bee46e88-3093d259b86mr2342794eec.25.1781386547884;
        Sat, 13 Jun 2026 14:35:47 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm9892632eec.7.2026.06.13.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 14:35:47 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH] genirq/msi: correct CONFIG_PCI_MSI_ARCH_FALLBACKS macro name in comment
Date: Sat, 13 Jun 2026 14:35:43 -0700
Message-ID: <20260613213544.90613-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in kernel/irq/msi.c incorrectly refers to
CONFIG_PCI_MSI_ARCH_FALLBACK instead of CONFIG_PCI_MSI_ARCH_FALLBACKS.
Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3cafa40e6ce3..903be7289c53 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -591,7 +591,7 @@ void msi_device_destroy_sysfs(struct device *dev)
 	msi_for_each_desc(desc, dev, MSI_DESC_ALL)
 		msi_sysfs_remove_desc(dev, desc);
 }
-#endif /* CONFIG_PCI_MSI_ARCH_FALLBACK || CONFIG_PCI_XEN */
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS || CONFIG_PCI_XEN */
 #else /* CONFIG_SYSFS */
 static inline int msi_sysfs_create_group(struct device *dev) { return 0; }
 static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc) { return 0; }
-- 
2.43.0

