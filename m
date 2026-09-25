Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADED4825A7
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335748; cv=none; b=YRRQtFhgBBoLWIkG2iphTQQ6CEhuxaarmGryT74Eb21MbCw40nGHWkpgyyPQaeL/hWPDPVzK6Rv3N5szHxJkJZXu4+9IwVGY3sLaaQkUcVDOqgW4nxZXzv2S/tp+ha++h8lRqIQh1uyjfMg4wb4eupYR7M0bkmiUYzU6vl7qCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335748; c=relaxed/simple;
	bh=vtFHEfwG8rqRvpTaGWmRjsAFTF1IORf7A7Dx8YJnPMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZxLczd5Bf7ZCCH4HRiWcCGT3u8LYq5u4Woy8/e27OGkJ3mtOPpghv7DRKbJMTbx8IZMXaTEY11SwaE2JZ57XYuDaMtHYlkjujgfWrxIDo1QJ0nutkS5vM1tMlsHDdoV4heBW1iJB//Wn5PmCmPQQwSZxoEl94lKqsIqgc/ErJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzTVOIUE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzTVOIUE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e2406so3994115e9.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790335745; x=1790940545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
        b=dzTVOIUER8bZogRROOXBtWh4hUQdfATpI7Lots9/9Ty01QLo96cAqaV7x3ii5QjGu1
         v1Meg4gISNL5ZZeO9CnlJC69oGa4XxPgYseGeS24dtFqdFEaYANFa+yH06l8GL2F6upV
         n3bHpPBVgjYk5y12UICuCxK3f1iktSjq7W6Dze5ILvxkWtmDKhDAKd6Wt9L1AlyS6SdU
         To9tSCxf8LwT0rCdwCkWkNAM8Rl1asAAY5ymCUhiUg4V/jWJoyeT5w3TQpL6hc7zPGX2
         3kxAoHdkm8DoUQK+2lYfyVYzyarAZzxjZelHfwGvASCmVvOvM3upF0lxBBq3+uTDzcAD
         UNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790335745; x=1790940545;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+voox/U6tCkxGYTDLWhRDj4A0ThgP+32hpU9k9pFGLo=;
        b=Jxu1INljNzEWG5pF4cA7pVZdsHpINvoO8n596z/uVoB7hTJcAhpTSTu4TR3gdLi3Kz
         siYaFWBsNRsPB1sB51Yv9nuW5v3UBsRzDtu7AN/8pn4i/SMMm5jXv1mU3iTgLDJera2Q
         Og7Q8uoN+gLVRmisxL/yzrVv2jz4K1wNJ8Y2EBwFIi28rGIv+PbN+VQdAmVIxXq9iWC4
         HDvZGXKeMpgVw8mVAzjjOfWVNoBr6oad4AVAKs5Obn5QXpnD5us2qN+uCQgDaTChRlun
         axl42+sA2gGnWUjDup+ai1AFD95mbcK3rsi4GZetayEFOnzR91D6P1RaLpPAoxbyWede
         SmUQ==
X-Forwarded-Encrypted: i=1; AKwUvBybhlpL/TgVOup30vS3gXun0ZwyGg0Acx0gEEb8o41QCG0ME3BhZkO5qDJI07ETvpiSvhDMYXLuxxU=@vger.kernel.org
X-Gm-Message-State: AFuF++lpvI4L3vIa7nr8NX+p8utXEvLG0A0uVYN1HR45dmcZwPIb/JUe
	TS9jheYXPWQmHslXIN3Xq3IFwr27mlJjBPbgS9Xe5CuKFGHje7E6XkN5
X-Gm-Gg: AYBFou0r2ugQ5SpF14sfMnEbAWKzNYW4Ye+36vWkqXL54fZNv1IX7o2XALauKZBMKhz
	oG3/QvibnOkMk4a7ZQAzABWMko2kcqXwpWjUAJQD4MJXhDGCMTuQJjyxnTLC+H1L+/Y0ZbHRJiW
	LMq7QLx8WGcIDGP+BJ3Mx9chwy5KdS+TUEc+DVvQtPkjpoX1EI4D+FGfPpILCgkJIF5VLZvdXkD
	ulx7+GELiFB0SGAcCpETVRKaYuiIbveINsIzHirFA4eal7Oh/vgDL/6bhbCxHoC90nEO/WJN1ap
	hOl/l0TAEZYTJeNz+WoPMgRrA+S8GUU34OwvVol5a3siCugqYrY/WBMLt6EkMCBgdMpVJZX6dUG
	c19XSWvmT9IJo+sG/zp3y6TEa5oqZbZpEGw2U9JmUMpq/wGR5MY8HXOczxAB2n3cuA5M+YLZfvc
	4LOys3ecspFQGPaJX//iVad6OlUzL71GKL+ZOhuYCXjx2MZECjyDPe2Gm6nXrbms2CDs91X5hXK
	inmLdb0O/XVGFtsjN2bQjr20aTSEDhAS7e/3jtHNGVumawZwL+NakoL7x2b2CATrHt5N9ISkYvJ
	g/peGgFnt88PRa5NYS1wttwOWxGP+gD2a9XcDn6MJhmAdRQsBmtAqKuu97YpaYuDig==
X-Received: by 2002:a05:600c:3b01:b0:49f:ce79:7a8d with SMTP id 5b1f17b1804b1-49fe670b3e3mr96282485e9.17.1790335744644;
        Fri, 25 Sep 2026 04:29:04 -0700 (PDT)
Received: from AHERLNXVDANI01.tail39a996.ts.net ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff044406dsm61608925e9.1.2026.09.25.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 04:29:04 -0700 (PDT)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and I226-LMvP devices
Date: Fri, 25 Sep 2026 13:28:50 +0200
Message-ID: <20260925112850.189302-1-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid
performance issue") disabled the L1.2 substate on I226 controllers due
to hardware exit latency limitations. However, IGC_DEV_ID_I226_LMVP
(0x5503) was omitted from igc_is_device_id_i226(), and IGC_DEV_ID_I225_LMVP
(0x5502) exhibits the same L1.2 exit latency constraints.

On systems where I225-LMvP is connected behind Thunderbolt/USB4 bridges
(such as the HP Thunderbolt Dock G4), negotiating L1.2 triggers severe
BadDLLP packet framing errors, link timeouts, and system hangs during
shutdown. An earlier attempt ("igc: Mask replay rollover/timeout errors
in I225_LMVP") proposed masking AER reporting. However, as Bjorn
Helgaas noted in review of that patch, simply masking errors is
undesirable and fixing the root cause is preferable; disabling L1.2
prevents the link from entering the unstable substate entirely.

Include IGC_DEV_ID_I226_LMVP in igc_is_device_id_i226() and disable the
L1.2 substate for I225-LMvP across probe, resume, and error recovery to
ensure link stability without masking AER errors.

Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
Link: https://lore.kernel.org/lkml/eb5a9805-3e53-ec22-696e-21c6b8cf0bfc@molgen.mpg.de/T/
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a3127f..6865fef4049f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
 	case IGC_DEV_ID_I226_V:
 	case IGC_DEV_ID_I226_K:
 	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I226_LMVP:
 		return true;
 	default:
 		return false;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..6c4e04661068 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7172,8 +7172,8 @@ static int igc_probe(struct pci_dev *pdev,
 	hw->subsystem_vendor_id = pdev->subsystem_vendor;
 	hw->subsystem_device_id = pdev->subsystem_device;
 
-	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
-	if (igc_is_device_id_i226(hw))
+	/* Disable ASPM L1.2 on I226 and I225-LMvP devices to avoid packet loss */
+	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
 	err = pci_save_state(pdev);
@@ -7559,7 +7559,7 @@ static int __igc_resume(struct device *dev, bool rpm)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
-	if (igc_is_device_id_i226(hw))
+	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 
 	if (igc_init_interrupt_scheme(adapter, true)) {
@@ -7688,7 +7688,7 @@ static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
 		pci_enable_wake(pdev, PCI_D3hot, 0);
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 
-		if (igc_is_device_id_i226(hw))
+		if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
 			pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_L1_2);
 
 		/* In case of PCI error, adapter loses its HW address
-- 
2.53.0

