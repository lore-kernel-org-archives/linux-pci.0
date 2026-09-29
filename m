Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140C541E6A
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705473; cv=none; b=ciFAvWQWmXVwitggIRM45E+b8060PjmmlRD/xhH4CAjpi7QTxMf6iCHxV/qxdN7zCfRMGRByShdY4N/wChxneh1h7/fctsI/Dg3+Wpyn9OK/8+7FcKS/GoWZ7UoJEVwTbCB2Gd02Lt1WkLC0CD+LWFUWjwDqn21Na3mR3+tMgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705473; c=relaxed/simple;
	bh=bFC+TshhTmM0v4253iAy7r1VYxcLXC8treYolVAgLgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRMWny0uAlQNg9lE4EmZLdnWazFw+d0ZH0IOaaNSn4mhE6bUNBcv4Y3uO09B8JwdatILruiIB8xkLT+QqxrizNW9GJuKWlxuFUZ7N4lse1ulCoYL+cQWB1LQUmoFXk86KOe8DB150Eft/nQffNa8SYArdb8XUVK04HX+hYu/Gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2QO3N/y; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2QO3N/y"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d1403bbaso280342a12.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790705470; x=1791310270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Civ9zmYjZCgx8nR3DY84Bu2yh9FlAvluUU+pFA8atcM=;
        b=r2QO3N/yy1gTU4TdtEND5KbMyxGJaaa0GqoLLmfW2PJYZO9FiqOjXHKNeioo/SEya9
         69YO68PyWk0FV2blPUiLJFmO6tDGKTxN9YnVnxtaQ4JvQTRnadn8BhHRJJ9RiUrdQea4
         69TSf9aLC0Xc8o9vt5tJOnK4lmJCFG6ILmO3xarxX172BR43Kuk8Rb188/oXYz8arUDb
         xW/u+E88awQYcahT4aVnyiAWbBWzJ90LZ8ZiOYLJOx8v2dV2niffUHSVmLyPM3Siip7U
         IKX1FCl5iL/nMSfORbJPxzS6APRi+1JCopuQaAZDFSG9S9wYAFTLGxfY9mEVfWluStkJ
         kYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705470; x=1791310270;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Civ9zmYjZCgx8nR3DY84Bu2yh9FlAvluUU+pFA8atcM=;
        b=XBD+LtvbJeIQMs0tj+r2f+KDel1fH5SuMe97qdAdAkOekc2LGzY3XIxR0ilJVGo0c5
         Pr5kPOhCtnLJQ5lm6us4jHPqedUQVGEpsSHWZdtjFJwi2ddLLQzF67AhdCD3YQsIw//T
         fqSfrU4neRsZLH8Jay4B/lWwkAmwiUsQehFL/TUpvBjTna4dEZP3zAsoepqbkkUnJDov
         lWXnxbV7WXWsltKkTkXXdWiMdlgLztTjxLFJcx5ElMH0FNBro+W9y0dnRM9BHnyvlzGo
         +/sWD2sURlYVQSQPq5RIWGPPmJpBTFb3EnoTN9KJyWlhz4Ij85pLuJxhs8tvg7iVvJg5
         wxHA==
X-Forwarded-Encrypted: i=1; AKwUvByfSN/tjuo9spu5TEm80Er5Wqa6nlXwIH4TGcIZAV+wPnh3edFrCRg612ug/K9Y/IIknm67M9diGfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdT7b+usLQaB76B+ov4kHrqb9YPL7avcg2n9rZvYsEapVAaPzi
	/wRs1li3cuNRSRCvAxBs3kNFzuI3aPtowNbjJGDL552isDKhRHldahHjJkNzkQ==
X-Gm-Gg: AYBFou2eAOLOujOsXmv8oRJAUBbdL9PdXrid8PPNhVyZNLAmOMd7H25K7ENpl73cM4z
	ttbJ4IKB8FiO3BfBFHHcYyB2L7zAo7CXrro/wAOW5JzzBBvm7iLI0Afxw+HW8dJJEgT57HJWhT7
	V80sJWJK9sKbnv/KW7fo7qeBv9GqUeC5aIG04a5XVCZevwYTOSNq5nJmhUIijABzlsdoAeIsJwA
	zzubW1n+wAsKVGBHWy7HH4vdd5I9QyZ5Lr5sC1cW1GGvA2s0K2xSogeNgJHpXR+Uti/o+b/56hd
	LaqJIoA26skQP+KVX3Z07Te827X7d4kp88LtXAV6BEy3GFi93O35c87O+hhzUkV9XtJtiJzpDN/
	IARUNpnXFdu7DVeK6Rmnake0PRLFo0QRaRmtp4JOOMELu+HaCssOc/ho04an7YBQiaMvk0/nF08
	6tSW56ihthnNeCoJWpNODjVSdapERO1W+5OL5WZzkjcB32DQvSBwNeM7fGAAm+/rNaraD4+Q9Q+
	NL2fTrmpYuepnVTGjN4OqbUuVQMkrWMV/MdjqcIsq9OhCPz5KBonI4nKbCPh00O
X-Received: by 2002:a17:90b:4b87:b0:3a0:c13d:8b2b with SMTP id 98e67ed59e1d1-3a4bfedd2fcmr109934a91.33.1790705470160;
        Tue, 29 Sep 2026 11:11:10 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1910sm6914590a91.14.2026.09.29.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:11:09 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in pcibios_root_bridge_prepare()
Date: Tue, 29 Sep 2026 11:10:56 -0700
Message-Id: <20260929181056.4746-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcibios_root_bridge_prepare() currently has code to handle Hyper-V
guest root bridges with the sysdata parent field set to NULL. While
this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
Support root bridge preparation for Hyper-V") was accepted, more
recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
device to PCI device") always sets the sysdata parent field to a
non-NULL value.

No harm is caused by leaving the special case in place, even
though it is no longer needed. But in the interest of overall
code cleanliness, remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch does not just do a revert of 7d40c0f70d92 because
an intervening commit moved the code to a new source code
file.

 drivers/pci/pci-acpi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 42d545edd7fa..452a90317c58 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 
 	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
+	adev = to_acpi_device(cfg->parent);
 	bus_dev = &bridge->bus->dev;
 
 	ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.25.1

