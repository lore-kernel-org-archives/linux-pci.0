Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705B49B5D0
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078660; cv=none; b=fnDmPQzog5hb9sDWyiu9v/7F07hyrnD69fjpAnZb0o8gDG0Jsxq0SYj4APr32RXJTRYoGsuyw3FW/W+jF5K09gTRCta270WP6mzermTormSDCTuxQtoNtBq/Pgo8QS8QZUjr6cYqMC/koRnlRF2X3uv5JZoJT5Wrv63+0RupiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078660; c=relaxed/simple;
	bh=dD2MbE8iWzrOQjOcB9Fc+ItDw8U6u6JrMfm3i3wPru4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrHVIJE1xH7TuwblFiNpQbukEqNKisKby9nCv6VTVEU7MSKEyR89gIe08V+xEFCIDqdKDLp192XH1Ft8GeLnIJsqrI6cjbz6b+qTiuaRUv7b76knYOqkaHpWpJU+2dkdLTesndqzHa2g3/yMr1lBQNNTQOcN1Euorx+aiOdmZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq4KVn9I; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq4KVn9I"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939da4e517fso9006985a.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789078657; x=1789683457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=phZqrumo434IM6M4R3cvUgGvziwdgVdo1+7d/hsBRIU=;
        b=gq4KVn9Ilm1wljKBeVQy592L/SpDUiJN2XnPgfvdH+47cShKSxeXua/19r30MF801E
         jCAanBo1QVEAbUuFfp1kvwJ33U6wY6p3lJsftZEG5iRF6omFv2corCxi7ye5NDXXiPko
         NW8gZGvvRINCJ6qngKybtvs7anG+f7n1Wht9Kds3FmTfTQNZc9PoWrEVl3aT/ufYifEb
         11oeC6vAyv8QQyR0z2bfR4dji0OtNkQDiwFOr/MOJSZhAfyFxhR9BL8BDL11Fzj1D1Fw
         jkAx1/NeRQ5oo6w/KzWQZ4rVwzf173N1i4MIgYVVuo0vHdAFtrK6WueOSqSv5ObAJ0KG
         8smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789078657; x=1789683457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phZqrumo434IM6M4R3cvUgGvziwdgVdo1+7d/hsBRIU=;
        b=gwag1ewP63nNm5kfuimOD/0FCu4YZQ7jL+L1t31GnJefes0wUKweTrw9WCNIIYkVvQ
         iKn1JaM4a7WjRN1NsyhtAZ0N4XT1KshX3L43TPfY1fnryLqIXYU0yP/1gmTteUO/T/IG
         8VCuriYNEqSAqmAFUjSpvOkms3+AYMj1yseEQ4bpZ+6vR7t87v11Ws/fi+1z3BsHUZzL
         h82xIGbW9qeUT9uSufYJa7RpLe/HhE50iLcyOjO+Yhod304bpKm9BkDN3OGbe0ibWtpT
         hEho1+orxJUNcXAocqYPM+P5OKQqV9ghnHRbSP1TQNROpiRTdNNkb7KRFPVYDpJ3iSEN
         mqAA==
X-Gm-Message-State: AFuF++njzSc9RSmnIBpGNW1XfYTCrJwB7nqdU1umYeN6CC0S3efFgQgm
	cY3yqoyUxptbc2c1kfmMmdjaBxyvdGLKbUsIdjp3mhecS3UicjQOV2D3lDIBMWc=
X-Gm-Gg: AYBFou1X0OSyLtf2HtE1A//BRaxgxiCYXkuYuhxID6TdEXvelGJmQ7AHw+8hOhuMQD4
	D/VKw4yu28WttnI411cn0Dbdj2hLwCpMl4IjIZmQzzTv/u6hHCqXvWntVVN6thdXO7sfLKMxFAO
	YwzcWhuAYuAQmPi4pWxCkYIK3ETeDfKph7XfxoIKhbgdVAHJDAzIRkmgBjXJgyK+FMXcQW7S/ri
	7LwgAB0UA7XepE+KasUb8cWe35ltjUyJd9e1pT7Q1dFlGF8kkfoCWI9ugDV278BQvkxFN4lwegf
	UrPKZtvMUZBqGqOi4KcIHITWv6FaB0f5yUGSgYtj7nJWcXIjWjdyN7g8imf+mC+vJLIQWOzynrp
	Rhz2DM3hxijckXwcbSMn1B4uzbtgGGEM4qbeHq2UJFDEsiCkHMdqiMtZvaljM3IA4qhNKMDBS6K
	RZqwTnNbRyykEMGDIW/UAfKVgfGwPKy2sOvmAa2QHEPcD8mFWIRNDPdK+utnwQxjQSvDqyJ1Ajz
	3VDeAbkEVRzslfsBqi3qzh7TynJo4hVbCbxsBgKAvIVtI9Uw8m8bg/tVgSrvSqncOeiqmf4h4kY
	dDtiOLD0iqNHJNvXjqAB8YBaTcwdOeAq3w==
X-Received: by 2002:a05:620a:2604:b0:939:a9de:83ea with SMTP id af79cd13be357-939e8b1c875mr207985085a.10.1789078655448;
        Thu, 10 Sep 2026 15:17:35 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80d453esm87548985a.38.2026.09.10.15.17.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 15:17:34 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: linux-pci@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	pali@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] PCI: aardvark: Disable PHY on probe failures
Date: Thu, 10 Sep 2026 18:17:25 -0400
Message-ID: <20260910221725.91980-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

advk_pcie_setup_phy() initializes and powers on the PHY before the
emulated bridge and IRQ domains are created.  If any of those later
initialization steps or pci_host_probe() fails, probe returns without
powering off or exiting the PHY.

Replace the direct returns with staged cleanup labels.  Remove IRQ
domains in reverse order, release the emulated bridge allocation only
after successful initialization, and disable the PHY on every failure
after advk_pcie_setup_phy() succeeds.  A setup_phy() failure still
returns directly, so its partial internal cleanup is not repeated.

Fixes: 366697018c9a ("PCI: aardvark: Add PHY support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/pci/controller/pci-aardvark.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ecb81ac73019..2bbdb73cfb45 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1864,28 +1864,25 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	ret = advk_sw_pci_bridge_init(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to register emulated root PCI bridge\n");
-		return ret;
+		goto err_disable_phy;
 	}
 
 	ret = advk_pcie_init_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to initialize irq\n");
-		return ret;
+		goto err_cleanup_bridge;
 	}
 
 	ret = advk_pcie_init_msi_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to initialize irq\n");
-		advk_pcie_remove_irq_domain(pcie);
-		return ret;
+		goto err_remove_irq_domain;
 	}
 
 	ret = advk_pcie_init_rp_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to initialize irq\n");
-		advk_pcie_remove_msi_irq_domain(pcie);
-		advk_pcie_remove_irq_domain(pcie);
-		return ret;
+		goto err_remove_msi_irq_domain;
 	}
 
 	bridge->sysdata = pcie;
@@ -1893,14 +1890,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = advk_pcie_map_irq;
 
 	ret = pci_host_probe(bridge);
-	if (ret < 0) {
-		advk_pcie_remove_rp_irq_domain(pcie);
-		advk_pcie_remove_msi_irq_domain(pcie);
-		advk_pcie_remove_irq_domain(pcie);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_remove_rp_irq_domain;
 
 	return 0;
+
+err_remove_rp_irq_domain:
+	advk_pcie_remove_rp_irq_domain(pcie);
+err_remove_msi_irq_domain:
+	advk_pcie_remove_msi_irq_domain(pcie);
+err_remove_irq_domain:
+	advk_pcie_remove_irq_domain(pcie);
+err_cleanup_bridge:
+	pci_bridge_emul_cleanup(&pcie->bridge);
+err_disable_phy:
+	advk_pcie_disable_phy(pcie);
+	return ret;
 }
 
 static void advk_pcie_remove(struct platform_device *pdev)

-- 
2.50.1
