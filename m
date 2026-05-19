Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A23326928
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158556; cv=none; b=sftCKf/raeZrbzPk1Jyb8K5LOM40WJYqHTSN0/iMnlqxkbmHCLroik0gNX48KI+AccQO4gDaga0ycoFs101GF2IfFgcPJAGZqIkm+OPca7bHCN2LqOvjPmH1vDP8LPO9egNshayvSi7jUxUE+MNDqWDbnZKO+dZROTS+sY0TUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158556; c=relaxed/simple;
	bh=sb0CgRFXAPPaoeqAhGOV697lVRa7YjmeITFvpxoLnf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2IhIBA5RrMRqjpDdsDljGtok4HHJYThlav34PQVokmvjVi2GuwpgqGgMM+2GEGihpCOEQeKZuz6d7uVw+feFCM510acGUN11KUXhsPs0nXMS56in/1w29KyaY2bsQmjCKq5GQdCctLWFT3YqrdFYt0Gms1YmiFtse863UsR2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxiCjxlA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxiCjxlA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-835399c11e0so1306452b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779158554; x=1779763354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkGqRxrVlDEEds6QZ6IxKqnZNbpZ4EPWpqJ38pxMcvo=;
        b=lxiCjxlAb6LnJuUpLwzGLC6g6L0ie4V0VshfxAy/nodCsAdkzq0+m0UAvtUzz2A+6s
         2TP9PS3a0mdcsQGAqJhjrxLRyeAJK3rXpIekxbGgckPSd8JIEnGUvcJjVmngRV9vVhkB
         +1W1gv0T9KQb4NGRgEjFCURTob6BLdrIuOdIdemfSvv1AXL/B8CIELNDodltBuum7GVR
         MtTz+gp/g+pmezPIbi9VG1NWJE5R3sDrg7oUtw0zLyiTmKsmqmyTSPGmYZ73c2C5vl/w
         n+QPVUTtPX7INNrsbEQmgsqP3nPy/3BMm/4MD5keiuBIt/IbWlr+GXYnpKGCMjDow/Yo
         shvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779158554; x=1779763354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkGqRxrVlDEEds6QZ6IxKqnZNbpZ4EPWpqJ38pxMcvo=;
        b=WLo1eb1jzq4IyrykD0R3Bu6CysHbE8EjHRN9sI8sAvf57Ww63LW7H3QzvLbDwYzedv
         ofMOrRaJycTZJQri8DjrioLuwJUXgiSchPYUTxfFJzZcCd3M/wMKRVN31Zpyy4k2rH66
         Ujz51/pcLXM6QTq34SEVWLpbZ6gTh+TQNwHLai9Bxv1S0sSKeHwHZe1Oq1vn03LgG+sg
         SwvhjsSL2WIk+jZ3xQzgFi7lGcMyllti4p7nfCDYqYUFFFpboFNltxsgx49dgi2sk8vI
         M/rcPFh/XSqu03HmTvem4F3lvcJ1kdhD8CZPp80YrhQRtLhEVq+m8gpRPrQavZO/BXX+
         Yk+g==
X-Gm-Message-State: AOJu0Yz4kDoz8mDk6l83xaBAGHKh2HdeV4geu8y2lWSiRfOyIaZMbx6A
	l0yNNZPCAFVv0RPw6SwSiINWxL9+ZXGkVnMtdwXs5doJ1F+FuM+1+xFxXCC1+Dq8
X-Gm-Gg: Acq92OGLxHw0g2JgD6PjFJwGObJq2OLOADp9qJxq2vxAup4U1opxkvOY9WTYwXjRna1
	UeSpbXVKGEorDkaxdv+nRjhZmDI2b8LFHDN7IVSrSPvhjuvEGrsodkLEgtENHcTGo0uElzTSPpW
	6KXinR56TzhY6xV3lRpkmJ5hP6VyuRwxtT8F1ONWwYya080i2iun9xjnVqjO8Nbhu2e1hfomBCi
	TWoXsMsxQEhpqu5vYagxeYOSAfAbc1Dwa+yFTYU7mOEgYKwxQluwzvX5fOKq8DrZDl8UhND7mxZ
	VHRqjAWiJaUOVCocpk0ZZM/uia87BEwLb5K+AzZ9BgxRP/SH1so1LLKivNxakStEvsQpk8sO4YA
	GXRQFhUlK+t/mOV911RqmmR51vYlK7Le6IP6UKr/hsJHXQUjuAq/b3+yibIko9dSicwGZEo1Rzv
	01TTIBIf0orhb7ebnI4ACoUe5yzrsSOl9hq1tEEZe/HIZQxHqnqlHLmAfZ4vkdzUo9I569JwU+T
	mbyODFVUDg8Y2TVTpGZCJcLVebiKfqtiEo=
X-Received: by 2002:a05:6a00:18a9:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-83f33d227c0mr17453650b3a.21.1779158554208;
        Mon, 18 May 2026 19:42:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ceb3sm15969617b3a.34.2026.05.18.19.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:42:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: hotplug: compaq: drop X86 dependency
Date: Mon, 18 May 2026 19:42:16 -0700
Message-ID: <20260519024216.671889-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver needs X86_32, not X86. It does not compile on x86_64 because
of invalid assembly there.

PCI_BIOS already selects X86_32, so the explicit X86 dependency is redundant.

Authored-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/hotplug/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 891a81bac5e9..f30a600deaf3 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -20,7 +20,7 @@ if HOTPLUG_PCI
 
 config HOTPLUG_PCI_COMPAQ
 	tristate "Compaq PCI Hotplug driver"
-	depends on X86 && PCI_BIOS
+	depends on PCI_BIOS
 	help
 	  Say Y here if you have a motherboard with a Compaq PCI Hotplug
 	  controller.
-- 
2.54.0

