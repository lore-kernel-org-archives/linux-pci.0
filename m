Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844252CCE9
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766448; cv=none; b=VY4mfp1FJAPhL80+DqNX4hN/sYxlZhxdaWdzo3+Dmj7x82gYV4Z+uNgXysYq9IQ0wSEUrf1gxYepC5PdfJ0/Za4nDjdgmmpwFlyRZhnJuz2HfHaq7ALEORrt4Rye7qLETS4RUP5pWmHx5p/s/Ij9x/RCI28XzeE8AdX0qRNdw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766448; c=relaxed/simple;
	bh=cLaFuMsX/J0zSn55GeVISf0SU6o/PJijEaT3vRfGDQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4ac0yxaWUUseuYdqMlIFCXtPmpU68V4WINPeZTIh7joVHUWtes3FOgyp6DQCldr0cxE2IoVHfFEtzQrSWShfqALgmoUTmvca7d2BP9xoUVmBu/UwkyUWDsfIzyhknrNC9VFb3tIz7CPQaj+QMRB2UNv7RtN7/X9QibvJwNvkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=bApyeyVC; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bApyeyVC"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so907613a91.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1789766446; x=1790371246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DlvPZmkodSWKlZLq43ZSJsHfXL/FkAr8wO/PLm1mStM=;
        b=bApyeyVCR/bJJ3v0JIVee1948Dkvt6h6SvtgD/XWfsBcRjn9Z8Lj6rd/1xMCCd3RKy
         +BtZ8T5KUJNhudMipDO3XWyZCYoH04/W7OglRIX1B+X2a1PPfe2fmq3z8CqDLuhWHDMR
         8EUJc0gC6jed2a31rN/SJyCmxzyAQ8SofJEMxdmMIn9VLI+/4nwb97GkblziZcVqiC6F
         1Kb1OuYgp5BMC8XyuNV9jrhCESnChb4uMrMJa1qS6vxfLAvIWkJoFvhjhMeoNMhKTwo/
         Y84bG3x/k/ppBSv/bleNG1pgoeueMfOldkFjVZszFAvKmwUPI3lcOAZuUuw+AA9A/sd/
         pu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766446; x=1790371246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlvPZmkodSWKlZLq43ZSJsHfXL/FkAr8wO/PLm1mStM=;
        b=eLrQKDnz4151EncYUFF+DyhaobVUQbN9NUoIrVpYAhUWMgMykFZwWUM8wAa2XsY3nv
         Q4InnZLuTMv5ZxxpF2AdYd/8aKzNY5owk6riWoNeSgmNMXIRZQYIhdYBly3rhZ0F5hdb
         6okWOXlG2icb9o5hn/Oh783BcVmURRaAYsaZLc9wHVW8EDjsb8qVyYvdCINZJwwG7zMJ
         KlqxiLCesCM9tYwlvbOreNRW2INRUeZZrP4Ysob9qVJ8usKxHVAyboAEPSDXGllJpfW2
         ciHKRPnjRl3HOP2zwFLRKU5+pgmMddSQ/QcvgbqX+vRYYPsOKyTDyyLlLCMH/0mMO+Je
         ze9g==
X-Gm-Message-State: AFuF++m1RD+AxzVp/LJdVwNeWN/3CU9gU7olhOkKGQWR6Il9p7DoQr5Y
	FCKlm8Jtppl0TDLoSq+NBw720Hqnd7H59v8cr/N/eUW9xl24iIy83hkeDogYBa4aFQ==
X-Gm-Gg: AYBFou1Ylgp6CBUm1H0QBTV+jLeQyefH4494t7Ru1ic1TooPRtc3tNyI/Sk/Sc4M9m6
	5yF5xPvifZtmL69YryK9Yj8uiwhncwAK6wmmhA0cyYjol3JnyTe21+XqUdYDQ5K8b9jio8P7O7D
	WjyQQwfOQ8NGIVe8warVpsEmuGhUdrateuHdErVMvQ/voC1eVjRlRDSQaofWW0UFPh9lyvwWpuv
	+DAQxFyBeBOZIq5UORMI3LXoHomYqdzfdCDfn89/dHjpaGvljvOliyRXLPN7mflU1Rzy6z7OcS1
	U5KpYq6eA9VDy4I2KxeNePsF1dv3sFup7pIvJKk/rLNZMV487SsLNcA18lLK60JIdR/jMHghDw3
	8AB+lJCmBtSMYoJpcpr6lz7wsKTUrScdNPdIqSlzgIvi5Xhit57NAAbpvJ5D/xCSLDZA5csUkeB
	XXrFD3nZvhlLp62zYxmehVcuOXPmsL+JBX2JXgRRXAsLo1IMToVK0Uq9eh2EY7RuP9jnM810yWW
	Y9+nKHR+UuP1gpKk5W9HlgRyRDXwHpPkDn23LhVfpsvk/DT7uxv
X-Received: by 2002:a17:90b:52cf:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39e54bd0941mr7847088a91.15.1789766446231;
        Fri, 18 Sep 2026 14:20:46 -0700 (PDT)
Received: from yurypm-new-58lzp.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55e71a4sm1004948c88.13.2026.09.18.14.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:20:45 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH] PCI: pciehp: Add PLX quirk for missing Command Completed events
Date: Fri, 18 Sep 2026 21:19:26 +0000
Message-ID: <20260918211926.1480-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All PLX PEX 8600- and 8700-series data books say the Command Completed bit
is set only after the Hot Plug Controller completes a command that changes
the Attention Indicator Control, Power Indicator Control, Power Controller
Control, or Electromechanical Interlock Control fields.  It is not set
after writes that only change the Presence Detect Changed Enable or Command
Completed Interrupt Enable bits.

Consequently, pciehp waits for Command Completed after changing these
notification Enable bits and logs a timeout.

This behavior exactly matches the conditions described when
quirk_cmd_compl() was first added: both controllers report completion only
when the same four Control fields change and fail to report completion for
notification Enable-only writes.

Add only the PLX PEX 8600- and 8700-series switches on which this fix was
tested to quirk_cmd_compl().  This makes pciehp mark Enable-only writes
complete immediately while continuing to wait for commands that change
Control fields.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3..5450aa6c7 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1122,3 +1122,17 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8717,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8725,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8749,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8604,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8608,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8609,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8614,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.51.0

