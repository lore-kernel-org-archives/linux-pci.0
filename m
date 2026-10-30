Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382559;
	b=rxpAbjjYq4oWlHQf+8tvPC0i8ejahYFAIVgL8p1duwt1JbBcFZWB5u72AOpjrcjc3MnJ
	 n+ERfWSCjuoFcaV/8Z5I5HcriWXBygM+/rdnAxIgKdqokInn+JbVyFg1OI08fR/Bz4aJc
	 ZMbt2Fzrq5f5S9oWlVxEmuqAwOesDXOjxPEb+jcbBhg59ioOhX9Z2O/UFKjoJE7pHjcX/
	 u++PNoB8QNd6hd9/mVcRzXOnxYWtzDyB7sCTbd6DUu3PpSwYPEhcinIAK0p0/8DTb7j23
	 733irUlE15K7PwZ6bBDQL96m5uEV1UzJosv0pKbCG1pS6RBHaE0jMjRKc6LBGf98xVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zZSGNZyoex1Ny4VtARv1HhzJUCE7mRyQh/Bod30dY5g=;
	b=fSKExazVMZ3GHoOFY3Y7DskIizIXETSURnR3cgRFkzVxpHynUiESHFNXw13spqVzfFR3
	 L2d7BR6yKCiS7lvi7P01QNkW62ZcQOXYpLqRa1osKHBEEQRFUvgfNldu7CvvxQScuNN0K
	 i6gCZAtY0Cf/UOWoJUjMWqKKNcLU8StHwFdv4eAZAddi7uBhmtDViWgkTYt9ab+CcNQfc
	 G/3i0Ut0nik4saCcIQtfNPpazQ0kip/nR7UnOzG/mjlubDK6pHjkVs3EJUmYhWvyGbWXH
	 DoQrPjV9ehJYIH+syKgYnWDbceoPTV59hJjlmoEOrwa1HOPiTHnkxLu/i30QoifSd+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZveAlPZ+;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D7606A32A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76D7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZveAlPZ+
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so487700a12.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382558; x=1793987358; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zZSGNZyoex1Ny4VtARv1HhzJUCE7mRyQh/Bod30dY5g=;
        b=ZveAlPZ+nFok+90icpB8sORrjQMhfWicqM7+ICRGnONs/KV4J01GCEVB9aB0xS8JOu
         Sy5myCjT9Xo1rt99nVBCh4dGWAIKJQ5Qv+iMP1Py12MD1Zr3AsQrDQ+4j0QbWSLZbSwk
         av/q0PZHd+kMI2apA+PyCi5r/angVwbI+xyqDJbbDlLWukYMPNweAyDovry1kZ2lTdGq
         6LS2JYW/k8xRmV3sN3YKPSX8aPHstaAF07c22spEj/RKht36y116KxfoVSMV1gaC5vRd
         FCLCsYJ8L+YSYwuUUOBiy3xt3iBIPhwsVxxJAsqJz0wZ6iiMcFhAKfo1arEpFASa8TGo
         E6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382558; x=1793987358;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zZSGNZyoex1Ny4VtARv1HhzJUCE7mRyQh/Bod30dY5g=;
        b=gOW13s9raMtvqkmWfj8H8RXjhWgaqneO12xPg5M7kppo+KXyWDtHNZPCl8xcuxGfv6
         xagfkdjpEIYjzgKfVQCNlbe3A9HxIQwDsAP7tloSBekqM7NA+aJMlKxXyR7Ypztsjkd8
         E7hyWtYF87eo6GfBLCtVfFTTVhSfoAGOaDoFyGK/PCgM9K8wr198X1RcmRPlqxjmaBMj
         qBNZwlSdkSCvPequx0vA9CubLYJ+OIoraU6eEryvA5fOhan8x+rW/vsFkoucv/206Mje
         Q7bR1wNlaGbxDx0jkgTG2AMmVExNvG4ZVJeLMK67t79fCY9iGY0onNhsvKh2AW9xt9HN
         pztw==
X-Forwarded-Encrypted: i=1; AKwUvByPSS40Ft0F17HITfYPWicy7IG/1FUZRIOQQFjpz8pKlrQnySdJafUMAKMEzVS6i5bBipDhyeORtqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG70IWW4nrrdX2W6xY35UJHERxsQGSxfovdyRrNc12T8FEjcmI
	k05tLQtgSwu4uEfh+sUc6xYuAWWkugD4ZfmKYkRxslkcGiahWf/ynIvVvqH+XMbU
X-Gm-Gg: AYBFou22prtQD3CG/ZOfT6OACtpzQ1lXkqGRZF6J8LZFBF2pqVEofEoMOit1V2+InHl
	AdR8LCkcd5TcMhGqHgSdWzdIODqyPpVAIVptlHwR8WIiG5c3Sb1ZycJhoiTij34o/jlP6V77GU+
	NFRBoOdyD9E3uxytRgOyVQ1iZRF0VrUShoeJ5Ss18TGsXWW/PGWbd3F2K2ihQc4/goetdnexC+N
	TeMQHwRAauCyAjA6CnyLoKzP6NqMPCqBN0sMPdkRVTsBFNnGQysdi8bQ40iW7uAzJq3+XEy39Kw
	ZDfTX30wtj3iYR4WvaiufgzLrGpIG+PVzvktKSnJUEUazmm88PLACv+K5gSYq+Y/bTxMGglLsTk
	8pTp0FapYSL3TJwRsCK4PDr+Oyqs+WY/45c+pN4Wj0v7YZv2Dqsa2EaSvIYTooinFl5upSyln0Z
	o2rdi7ufmP/Ayb94DxOYeyW1QZw+vOE9fF88YfME88aS9nYumtXWHD4h1cLoImIge4tdptEcdJv
	5R0m8IJ840L+tCDaE43li/LV8hWFpK4dxPte6WJaEkukddtRQXBrlazt5svGc0MSeaRTpxDevDz
	79+8z2r60dv/sILFWLGMxg54ZSyjwmCeUa90YqEWbYEH/Ocv67Ei3PO20S0MgyCrL+POXSypNHh
	N3RGYbqdoHugT7h9IjEmGt0tszg==
X-Received: by 2002:a17:90b:4c52:b0:3a7:9adb:2a0d with SMTP id 98e67ed59e1d1-3ae89176b89mr2515145a91.0.1793382557889;
        Fri, 30 Oct 2026 10:49:17 -0700 (PDT)
Received: from junjungu-PC.localdomain ([2408:820c:9009:b6e2:1438:125a:b22c:6f3f])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ae845432e4sm4850566a91.3.2026.10.30.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:49:17 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 31 Oct 2026 01:49:08 +0800
Subject: [PATCH] PCI/pwrctrl: generic: Fix leak on clock error path
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA2MD3YLyouSSohxds0QLUyNz0ySDZEtzJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAHaaG85rAAAA
X-Change-ID: 20261030-pwrctrl-6a85275b0c97
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793382552; l=1682;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=oBQEdT/H25SxYRrFmJQBTUFDHaorTwDR7TbOrdVbh1c=;
 b=8oJuDlM/nmQq2F1ijHqiTGEU+KyXF52/o0PtSocNFK/GBAj5fNPU3jLsrz9x/mV9LJP6zspdo
 B/OfMiZ+piwDHdwjuVLreGe4NUUFx1D5Uc1IQ3U6KH2KNZgPhD1AzbZ
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

The devm release action for the slot supplies is registered after
devm_clk_get_optional().  If clock acquisition fails, probe returns
immediately, so the resources eallocated by of_regulator_bulk_get_all()
is never freed.

Register the devm action right after of_regulator_bulk_get_all()
succeeds, so the resources are released on any subsequent probe failure.

Fixes: 9cb64f61ec7a9 ("PCI/pwrctrl: Add PCIe M.2 connector support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/pwrctrl/generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index 4b6cbbb52248..85d568b381e2 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -92,6 +92,10 @@ static int slot_pwrctrl_probe(struct platform_device *pdev)
 
 	slot->num_supplies = ret;
 
+	ret = devm_add_action_or_reset(dev, devm_slot_pwrctrl_release, slot);
+	if (ret)
+		return ret;
+
 	slot->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(slot->clk))
 		return dev_err_probe(dev, PTR_ERR(slot->clk),
@@ -101,10 +105,6 @@ static int slot_pwrctrl_probe(struct platform_device *pdev)
 	slot->pwrctrl.power_on = slot_pwrctrl_power_on;
 	slot->pwrctrl.power_off = slot_pwrctrl_power_off;
 
-	ret = devm_add_action_or_reset(dev, devm_slot_pwrctrl_release, slot);
-	if (ret)
-		return ret;
-
 	pci_pwrctrl_init(&slot->pwrctrl, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->pwrctrl);

---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261030-pwrctrl-6a85275b0c97

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

