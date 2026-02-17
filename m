Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A22D838E
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315314; cv=none; b=Oqv2MJmaKh8S0+eEE6qcBpyo8tiP22cHdXOPEHgCpP1KQyZQxCl5TbylKlOsZeZfnhr9NWkTX2Bfj+wQFUsL3JiVlyQwTEm1lchQeRZYPONV3d31WPC6Pw/MKG5bO041NBb9GOVLTK/MuKNaYFDTWYCG0g/5di9A8m3qRYFeymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315314; c=relaxed/simple;
	bh=8nP+G60xORVioRFODry6ZjQeDIwlkPrlnyc6+fGyYoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNCrcl3L7G5OqQZmac98WtIHbM9YdVep51ttQloSHBGWOZhA+TFmBNj+HnHFXZ3iW7DklcbbNqp+gnwf8o7pmpoidvDLjCnEoVusY9MRTKg52koNq3yLqlGZFNbJe8J5FzYQ5Fbxog5CmLVioSlhGockC0vG4iR3hxvv1ET41fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXR/Z1rL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXR/Z1rL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so36767395e9.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 00:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315312; x=1771920112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8SIe7TJNGTZOpsiu2TBh23Lr0Mt6PONYwJs1/+BcyM=;
        b=EXR/Z1rLunDELUYp//7MJ+GeqVb1qx49bnC/1KU1ULDBI+i8CJQ2Ib1gh4EUGwOHKw
         atnyado78PyU0TLJsvEfbIQO6lVr56X301nutCUzRy4uI3iCwrf9Kh4lJ68ooBSNQHwM
         HfFJ9FmqvAyTQxsqCTJ/jozImYQyyzru9eBb3p+gGd+5lW1mwsc9LrWmPLjOf/6Nwqes
         NMElAiJOSOVoe9KHv5bUFW2D3yPe6imhWOuGuHHSrf5B0af1L7J2ny0puTwN3bPwbh4t
         K5wm0qCKOGLqyAymL7Pah0elDgAobHtCVNH8t54n+istwJxd3mWY9amVqVC5/SqEoI+o
         S78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315312; x=1771920112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8SIe7TJNGTZOpsiu2TBh23Lr0Mt6PONYwJs1/+BcyM=;
        b=FCaXZc43ogvespACCZEbz5mO9QagxyTqDoXLDDBOjwUW1GSScCN7Ccr0GcnrgBet/v
         +hpR5RrdONINpqe47PYGF9NU0OiMmOhwp2Ae+8dj2/vNbwdS8td08dlxi9yAiHbUG3y0
         T41nal2obdn40h7Mr4cjsM7J4Kiw26k/ahlAVsLakZEp5MP9fJ8eqXHYbEMr8lB2gjv9
         ZOAGHsOFhei8YXlluh+hlBF4QlBwJOSrl3uA6GWQQE7y+RkdQXLstXMzXMWwfLS/N2Jg
         +nrhg0CXxnZWTI0C5KPkmk+PJCgrllrvPuJomtjr4GUgl6Li3cVaeQAQroFAiaiS7pap
         vHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlQ1oKTJL+Of63Z4GNAjCxUeuyfngqpRQHf19ltYVga1ysdoSlD1S8c35X5aNfcrEFUV0O2gHe7kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLnoW0vWLg3uNx4JTq24CHNyQtCQ0tXsWz5SUBjCndl7uFL9m
	L1GU2FekRkw+2ZNMgHdlOA1GNoi7UgLjGcIhRPfmG2NVRHiGP0tMiJlM
X-Gm-Gg: AZuq6aK9qO9v4SQfQjLUtilcXT01Pd6396JaObiic1/uZWXESbjOLeWw7L7B68B0rmZ
	MwWPFILpQOnzhyroKVwdu7J2HWR8pK51mQMmqFeZvUqmBVaFO4ntAlHTyS6wgkUfB4UyZXAxfeE
	jK2NnXiTZTweSoINBBjjy3BgcPLUXqEkvUWpOpi+DzCBYPWT29r/1jB4RONVnd0yXd60QVcqplE
	SXS2i77gjDiqg9Rd1Vr1B1nl9B/2vXce0pA/+JVMq4MQLGIOaz1V6XpPZrP/YENsGMB9ZSo3dxa
	3gQJeDzKaS+fP+jzlXe2WfrEyZcBE9JB4IhuIOB1rblDJT221OFcgTK2f6fEEbHZCq87K0R61Eu
	czMTxKlSSMpOXY6lTA7u4Ep1S9lO0sPcUqDO/k6Q4GmOFVlNflZVHg+ybQbVFfO6Ln+CrbDjZgt
	6Ucp07npXuZhwC8jRfbwlKGMXJAoXm+QaEoUNhNG+1OxySSFoj9IMGaO1AFz262oA4K+aFDg==
X-Received: by 2002:a05:600c:529b:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483739fc4d0mr244661825e9.3.1771315311694;
        Tue, 17 Feb 2026 00:01:51 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:51 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ionut Nechita <sunlightlinux@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [RFC PATCH 3/3] PCI: Update bandwidth control and thermal cooling for Gen 7 (128 GT/s)
Date: Tue, 17 Feb 2026 10:01:02 +0200
Message-ID: <20260217080102.206581-8-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217080102.206581-2-sunlightlinux@gmail.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut_n2001@yahoo.com>

Update PCIe subsystem components to support 128 GT/s link speed:

  - bwctrl: Extend pcie_valid_speed() range to PCIE_SPEED_128_0GT,
    add PCIE_SPEED_128_0GT to speed conversion table, widen
    supported_speeds variables from u8 to u16
  - portdrv: Switch hweight8() to hweight16() for supported_speeds
    to match the widened type
  - pcie_cooling: Add static_assert for PCIE_SPEED_128_0GT enum
    contiguity check

Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/pci/pcie/bwctrl.c      | 7 ++++---
 drivers/pci/pcie/portdrv.c     | 2 +-
 drivers/thermal/pcie_cooling.c | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34e..b9125b40cb860 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -50,7 +50,7 @@ static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
 static bool pcie_valid_speed(enum pci_bus_speed speed)
 {
-	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_128_0GT);
 }
 
 static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
@@ -62,6 +62,7 @@ static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
 		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
 		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
+		[PCIE_SPEED_128_0GT] = PCI_EXP_LNKCTL2_TLS_128_0GT,
 	};
 
 	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
@@ -70,7 +71,7 @@ static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 	return speed_conv[speed];
 }
 
-static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
+static inline u16 pcie_supported_speeds2target_speed(u16 supported_speeds)
 {
 	return __fls(supported_speeds);
 }
@@ -88,7 +89,7 @@ static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
 static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed speed_req)
 {
 	struct pci_bus *bus = port->subordinate;
-	u8 desired_speeds, supported_speeds;
+	u16 desired_speeds, supported_speeds;
 	struct pci_dev *dev;
 
 	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9a..5ee8795107f26 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -274,7 +274,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
 		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
-		    hweight8(dev->supported_speeds) > 1)
+		    hweight16(dev->supported_speeds) > 1)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
diff --git a/drivers/thermal/pcie_cooling.c b/drivers/thermal/pcie_cooling.c
index a876d64f15827..9a2e39398674b 100644
--- a/drivers/thermal/pcie_cooling.c
+++ b/drivers/thermal/pcie_cooling.c
@@ -75,6 +75,7 @@ static_assert(PCIE_SPEED_5_0GT + 1 == PCIE_SPEED_8_0GT);
 static_assert(PCIE_SPEED_8_0GT + 1 == PCIE_SPEED_16_0GT);
 static_assert(PCIE_SPEED_16_0GT + 1 == PCIE_SPEED_32_0GT);
 static_assert(PCIE_SPEED_32_0GT + 1 == PCIE_SPEED_64_0GT);
+static_assert(PCIE_SPEED_64_0GT + 1 == PCIE_SPEED_128_0GT);
 
 MODULE_AUTHOR("Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>");
 MODULE_DESCRIPTION("PCIe cooling driver");
-- 
2.53.0

