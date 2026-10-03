Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FB41229C
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022947; cv=none; b=XJYR5zMdauLxWvOHkK1f+kzjaeGJ48SLYUZRrS4BQpfWRMdiuYt7uQrDiYCwFdf3Q/ld+nS7SkvrtBRlL9P+VIj2QW5t6cbL8PhawXqtmqCBeJ8PJn7D2OL1+yXJbliJDMAo02lNELhHReMttDJiq7vDz3ThMiPr59ICj+LDJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022947; c=relaxed/simple;
	bh=9dbU2MdjPPQ+2L06YpaubCzSFA40VM5mN5AfcEjE9ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFNJN0vV//P+Uj9jozOYF1mvUNkMD8ohxj0iwduiQHMB6Eyj6UXirHK+uGvZ2a8uCFh6lbQsJd+BhODqD9gHkRT0g218/Ggg8DIc9mTCSsvxP+IPHxCDaAmQfpNf9ah9YQZXF8Tn+SJTmMwvW+7Sm+AiyRmUvOAJvX1cz7N5hVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWSkUf+P; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWSkUf+P"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so144921a12.0
        for <linux-pci@vger.kernel.org>; Sat, 03 Oct 2026 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791022945; x=1791627745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUMcFmx4x50WyYpp/LJX866o0Ow7gt7cpBwhiL0d2Ic=;
        b=UWSkUf+PEHylaSMq5Vy3FTo6DZK+MgmkajW2dK0w3tkmPO2Ah8vCiWtNwokrmiDXX9
         smeYQjm/1c1hTU4SPsYtq395XzCJok9ydVdda5z9aBXAwIQmL0HuJBRsfJ9prYdFPIzn
         ma7A4q+qebzcbf8pflOCi229JTJVJ4ozc48K3V7pheeSPEo5DmKayJCmqdP87LzL8WQL
         CWpVQ/vkfwM9G6b8qWc/L1cFWX2wTFNKTHt+fx3kZhfRs6ykB8GytJrLhgHtyAs5OR4a
         V4UIUGkPwpvFwR3eF6UKlTBvr/wkoQfcKThV46El7JYe4wgYRm8zNB4smGP9OpwTQexs
         VqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791022945; x=1791627745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUMcFmx4x50WyYpp/LJX866o0Ow7gt7cpBwhiL0d2Ic=;
        b=2L/szLNBAysUocg9TnIqQaGg+DmG8Y9qTvYCo2YSG+l5DXYpoUqQbpDLGt6xEGWfcV
         a5kks3ZQUlN8810C/ZpnDvcO/VzlPP+90paQ5PqVgGcJXhmUsZFZ8ZPzFvKXQ7CWDyE3
         xJP/iDddZI7MOmA3I22LDOTwO+ZgBaZDHEgakazd8Oqgz92vS0WRTbcRZYYhDwnUPzGu
         KfXshClEYspVZGAVd98GmICJZ2HKyEWF5PIuNc80+FgLS8iNYU7s5LqnNoqFR6IfeUpw
         mhxaFe7uub21qh7oUbTKAqwbulr4kx8t426k5jwAfir/qyJEKNnh66LzaHLLbPk1ycv1
         of2g==
X-Forwarded-Encrypted: i=1; AKwUvBz3CMg7S4jxwi4/pG8X3yd/H7wQguqizE/IJoSqA4tDD3jSUkxSpuL6qx8WZrWviXdgoH6RrzAqlsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFeRW5Cq6Q1AlAAIQg/QlxPKSiJR981flAtHKHdCflZiX56XS6
	GEN3bDcQmNAyXja9gsUa/kg6dyAAUKN+c9cxGSrqSJc19go5e6xoZrM=
X-Gm-Gg: AYBFou2481CkiRq4o5i6RF36N/gZDh4W6gQ/nJ7PqceYRisDc3gQitfY6QYKBOEmEiF
	RNi8vcJv6rF+7f0Iu3zS3+EL9nzp5VjP5nPMHMBGiZGBkPkfcIAu7jK2XjEoX4FQxTxryapIkqp
	HT/jspUOikbMyJXWL9E+t0U9KhX379utHllS2PXp8b7pT5Jhx9ZM87Wi0/LxHXLrB0oq0kBhXG5
	3z6191DIZeG5jeKL/oyXT1zAx6rbsW2eAt3z8+p53A0FSbz94WhXNj1i+poSefqd2RYow8pbvyV
	SbaBc8oGrGMsAKKVXPPYjsBmwILyyDW+3qiVch/Hp77fOMrYNfH+i51vH46pzSs12tcFwqvlycf
	NumrqMc16A21BFYy4kuKTSLzNVV71+lan0mbeiEky4stTYLBd4khHLy5QFmPbiSJ+dxY6RWMOYZ
	uwp1J/2+W/QB6q3ovszdfwp5i5lXMXLxCeixvaMJdLdjkkJpyH7XZiPxXhl17DfpiR0CTr6YatF
	KuRH00H1jturMr6YnRb+QMB
X-Received: by 2002:a17:90a:fc50:b0:3a2:b70b:9cc8 with SMTP id 98e67ed59e1d1-3a7877462d9mr1377137a91.61.1791022945437;
        Sat, 03 Oct 2026 03:22:25 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79a98e7c0sm1240273a91.0.2026.10.03.03.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 03:22:25 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bhelgaas@google.com
Cc: alistair@alistair23.me,
	jic23@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI/DOE: Fix double free of a duplicate feature's sysfs name
Date: Sat,  3 Oct 2026 19:22:21 +0900
Message-ID: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DOE feature is reported twice, sysfs_add_file_to_group() fails
with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
frees that attribute's name, but leaves the pointer in place.
pci_doe_sysfs_feature_remove() frees every name again when the device
is removed, or when a later feature fails to register, so the name is
freed twice:

  BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b0
  Call Trace:
   kfree+0x11a/0x420
   pci_doe_sysfs_feature_remove+0x117/0x1b0
   pci_doe_sysfs_teardown+0x90/0xf0
   pci_remove_bus_device+0x128/0x2e0
   pci_stop_and_remove_bus_device_locked+0x1d/0x30
   remove_store+0xd2/0xf0

Clear the pointer after freeing the name.

Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
Cc: stable@vger.kernel.org
Suggested-by: Alistair Francis <alistair@alistair23.me>
Assisted-by: LLM
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Changes in v2:
- Keep freeing the duplicate's name in pci_doe_sysfs_feature_populate()
  and clear the pointer, instead of leaving it to
  pci_doe_sysfs_feature_remove() (Alistair Francis)

v1: https://lore.kernel.org/all/20260928035035.252394-1-donggeunyoo.kernel@gmail.com/

Tested under QEMU (q35, cxl-type3, KASAN) on 72d3fcf802c4. The device
reports its CDAT feature once, so a test-only change either registers
its DOE capability as a second mailbox or inserts the feature N extra
times into one:

  case                                   before           after
  no duplicate, remove                   no report        no report
  no duplicate, a name fails at probe    no report        no report
  two mailboxes, remove                  double free      no report
  two mailboxes, 3 remove/rescan cycles  3 double frees   no report
  3 duplicates in one mailbox, remove    3 double frees   no report
  2 duplicates, a later name fails,      2 double frees   no report
    probed twice

The doe_features listing is the same before and after in every case.

 drivers/pci/doe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index ac95b1d2d9997..6b5d9ba8e9697 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -208,8 +208,9 @@ static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
 				pci_warn(pdev, "Failed adding %s to sysfs group\n",
 					 attrs[i].attr.name);
 				goto fail;
-			} else
-				kfree(attrs[i].attr.name);
+			}
+			kfree(attrs[i].attr.name);
+			attrs[i].attr.name = NULL;
 		}
 	}
 
-- 
2.53.0

