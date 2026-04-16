Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7E39B947
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342627; cv=none; b=PBCig3EA+36EWpqouvmfvaTBISzF4mSgaD14m7rSYlPdg5qU+AloRppF37+L2U3pnLz51ezImBu+EljPQ/LBSivSy6NqN2WspXQA2oO4E200hJNEG0HHg5cvXoyLe6a01E6d5uQKQNDlqnLGKjX9Li19TEV4UKNoG+yopZ+GsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342627; c=relaxed/simple;
	bh=gxmdeBujeV0jMHCbtCpMQ5fj+WZiF0J1mmGcycJtdpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kAvD4CcQA5HEZxMixv5NSmsXsZQ3WMHS3UnnWegIHooRMtXWQ9sl+sXTlhkwjGhMKqD8T/RYgs2pzoR6XE41t8yVm8DwSOHBj6TJgJJxzEIoiw8zZfV6i28KcXa9iwsMvjQncR6ijj6k4iHWWa+5GLRNtQYQc94ncNvtFk/ogw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqGr4swy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqGr4swy"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35691a231a7so5061860a91.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342626; x=1776947426; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXyx9Of1fZk9FgzWy3f9pZji2NYevahYiZ7odSyvBh8=;
        b=MqGr4swyqbH2+ZX0i1hBKP4ilbv541ap58EDdORKMscc0DhtbdohqNCRlkrNShfiVY
         CsjwYWEl4pIIubX35LWOufbcrixiK2w5DTnbM/T9PUle5w2BlY3iRDiJhOFHEDqRpIFe
         gQa/5sHehutFnA8HY1AtLZoVcrlwghz0kY4hm3hnGPp4oKG1m6iAcXZCIlHeB/dPH7My
         Aa6n1NQ8SyZqg+Ys7VfvqG7+UujxXE3iIX81QyaDzfJgAMFGzw8dYdvIfHhhNVTSymYa
         DEfQY+xhH3CDPvI3QMV0oku39HeacWPG+OeUGTngg31jD8uUEG3bqd2bqxdL8rWgB7IU
         ThAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342626; x=1776947426;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXyx9Of1fZk9FgzWy3f9pZji2NYevahYiZ7odSyvBh8=;
        b=KNoTj6mC+uxzzaXPb4XjyKaJ3FmmV15KykZA9VW6teifawmCI/YcffmA4Fl5IY/oCf
         id/jQhUqybQv0c8ahut6A6Hbm9UDFKbOok7fGJOsN10ut0oQMMFjfRnMy6TrzKn98/Gs
         04FWZh7MQdUzc/XIpNW0REBwh0MFcRFg+zv9ZzILHhSjjhKMkHgyNbyMkdpacEWZr34D
         TzHj/YHNzfHoBRTev/eqag3uEKGkQ87fsNjki27mTzwzFuc4JZ/a/D8/bj0TQF3dDAcE
         Wgb2wSYr2w0g4y8PDVdbe93/UYk9dbdbulmq5/s+WrX3ksRxwgDDuLVRKmDIlBDQ3Ws6
         dCFg==
X-Gm-Message-State: AOJu0YxH2GidEyFN628MXOqZMWEXaYGNbsX3lXshK3QXPLJ5Z+nc96Wl
	MccvPpO97dYfqC7Euwe7FpeKOtQ7qidr8sfwZdOVK8kF+XygGJ0qaC+r
X-Gm-Gg: AeBDiesS2zlmL4yCEfmvvcyCOlRpQEtPiOvgXqg8lGrFHi9qUTKiFoSyhmoQTNIFK+X
	6f8wX5u7XSNnL9D2ZYJrURp9vyzztFWoYLcXrMvK0+SehVEOuUu5n5QPeHnBEksmCp0R/VEsm31
	ElNVEjq1xEI3pPPhZNtlZhlMZuq1ADMZEG3pySj8/PdmQ4NEB/3svYPwB35S6KrBLvoP2UAkzWU
	uG8wYYA0FVodE6iUT9WNCDLyw5Xs0Fy9Zc1Ud8RinPf7IYSeUqK9NVNweF/Garc4iiJZG83qKH1
	RI856WB7hDmsRJ1dwgfW+BZRLNZ0kv/QP+qHyzxQoL6UXPypDFlhPBMyBGBAn0ey30Q62WOiHgI
	PYeaGY/C6ZM0W+xs10cG/Add9jnRNKWcM22Mu7W8dwvlIFCo0wTNxh2cH02wdp8H49yJbORDdoF
	uX3ogKUXJu3jlHrnT26ht2cvH2WVaK7zjjmzx6oN8xsH3uE6YcDxRVuftltW2SNm8roxWkpyzgZ
	8Gfm28TEZtY403hwjYhRvRxyE9qDyo=
X-Received: by 2002:a17:90a:fc4e:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-35fbddd407fmr15048305a91.6.1776342625803;
        Thu, 16 Apr 2026 05:30:25 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cd538asm2373787a91.8.2026.04.16.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:30:25 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 16 Apr 2026 20:30:20 +0800
Subject: [PATCH] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFvW4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3dTi8sw8XZMUA8uUNJNUizQTCyWg2oKi1LTMCrA50bG1tQB4Wd+
 RVwAAAA==
X-Change-ID: 20260416-eswin-4d09df4e8f48
To: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Yanghui Ou <ouyanghui@eswincomputing.com>, 
 Yu Ning <ningyu@eswincomputing.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776342623; l=1191;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=gxmdeBujeV0jMHCbtCpMQ5fj+WZiF0J1mmGcycJtdpY=;
 b=Yhm/LfwgzcTnfwUhoJsNjILRPY3cdic+tF7NVO9Pzo3jGEbpzACn1GShqKSW4xYlhy0soWmyM
 iO1zOJaq9pQD/DmJ97YhRDKEn6rHbmRa6DYVcio9cig2dMr2QvMmsCn
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When dw_pcie_host_init() fails, the code jumps to err_init which
only calls pm_runtime_put() but skips the clean up of port resources.

Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/dwc/pcie-eswin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index 2845832b3824..0185b55e09e3 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -348,7 +348,7 @@ static int eswin_pcie_probe(struct platform_device *pdev)
 	ret = dw_pcie_host_init(&pci->pp);
 	if (ret) {
 		dev_err(dev, "Failed to init host\n");
-		goto err_init;
+		goto err_pm_runtime_put;
 	}
 
 	return 0;
@@ -358,7 +358,6 @@ static int eswin_pcie_probe(struct platform_device *pdev)
 		reset_control_put(port->perst);
 		list_del(&port->list);
 	}
-err_init:
 	pm_runtime_put(dev);
 
 	return ret;

---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260416-eswin-4d09df4e8f48

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

