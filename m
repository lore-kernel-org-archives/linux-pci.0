Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1BE26D4C7
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771814275; cv=none; b=dqwne+T0WTNYj+EKV7KSnNiBGBh+y2ncEHoM/oieW/jyhLk8S5iRNd2MiGwPbosiWRiniMdGbLT6pVMuYIxTPBPZe0r0qNviAuEaFi0mn5oNB0WAVttObRf4hUz50uulIgsp3YLukW67d2Wq2InUtPtj15QyNZdLGPx6PR/fpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771814275; c=relaxed/simple;
	bh=U1qqUSl+ekG80aAN0BL8qAKe1EwwuLWWeKmOeg3iaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUnyr87FPGi/et4Bar6c3rpIWP2PNvbo2QvcBRL7hxdwEkjPEqd6HoU4cO1bO7x3KqYHKLEQtaRXJvgpKvkWR2V8zT5ZKtx47Ah9OuNTWpw6+b7gKOEMdhxp54zcVwDDRi3t0i3WCOMB/CFdKOzRSk6LKWd0xnpQVpTcZ7rQAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdoClBb/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdoClBb/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806bf39419so35191845e9.1
        for <linux-pci@vger.kernel.org>; Sun, 22 Feb 2026 18:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771814272; x=1772419072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4l6XEq4Cu+6mytZi6jUh4pUu7eeB+DRuzflxR/izUA=;
        b=RdoClBb/OMWfGFJM7XkFF/caTESIOqOGSB1Q8Q5NYgivP9950wr42D30rTtpwdI2Yp
         UUfb0vQP5UwWffd2DWRZnBuNN0n9qxxOB1oy0U1K5xvdFM3Za5L1sby94JpAnEy/3PbW
         7vDRg5UrYE1FW+7ATxoSgX3Za4N1egi3a95XZoo1d9NEYHJEDLPXPLMLH6+0ssVJ/Np9
         gDt4aaEnuLJr8sAruoZY1pHriEuAGZ3ua6ZIgVZy47II7KOgrmZyUOqQADWJTjsB/X4Z
         84+pR1gtxRw8HWg6Rh4X/K2iSVHqLBq7DSwL5PdJaen+7zoPUg3sPT2ydZiC4rxFoy7l
         7Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771814272; x=1772419072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4l6XEq4Cu+6mytZi6jUh4pUu7eeB+DRuzflxR/izUA=;
        b=QypvSSkegtHOecVIjW+9x8ir4kwDgneBkhvxPbsL/yuN1hAKA9SKDLWSEOeBv4tnf3
         9E9gnc0AD+su5lKCRXQ/FYgS0T+2MzmXqRM/1YJuv52i9BcIwND11gdEc1fxFbfU5Xx6
         NfsD4W0iDtxZ36eIxjkCb1FCshlv7MhR0Sr6rVzP4tQtVEX+vGRhIyOvKj0ndnF4J+MN
         +24xxGCjUjpPar1BMKcsIuW62Q8ND9qCYPRV+4x2aw0IQYKScVwzN7GwwGMG6EyidK1i
         ktjF+ss0HGyBGwW9z4TtvP3AlQxB8mEs1AP1kgSFIfiG99huULY6zEJWscXNqVF+lV9S
         xkaw==
X-Gm-Message-State: AOJu0YwNmaM6FVP10dPH7aUAviz20Mlpge2mqzOWla3/xeYOlzBrtUCr
	58SMruq2C7uJjrqsz+T/N1/SH/usrj2FgydgYoxDZkGh7he/yD9oVqUX
X-Gm-Gg: AZuq6aIZTBTd083BJj520BY9378JkJQNfs7eLOtk9I2nTQ5KE+5g1SGICrrLELUQVX/
	hDqriEvshmAUFououvrQKna+HPS3VI2250/6F91tJcbWo4aEbPsZJAEwqBhMwuoCBJjwalZRZK4
	bvXAmIky20s3YboabQAmNz8foxkec0igbXAWsdris6foopGlwcGLuGDNveYC1BeGzz5B9Pn5dfJ
	kimCWLIsvsWmYzfO1UkfTS+gDREhtizI0dGrlr8dWC2HS0y3U5iyy2a4xE8iV4Wjmi04nQAs9De
	vpMDKEzW3IO2UneMMfrR6e+EWiOx90dDVFMpgGT7fwrT6cSyOUFxqqyF0Z0qLlS12leLMUKSm6a
	AvHySRcavUbPGn16gjbQSxtNRDHnhBY8OSiLkLrOqlJQkq3bYtRKYAOvubRGuFu1dwxoV2WyAL4
	DNLIh50eYsXCzZOfjSGYupb5ctlu8V073pBdIRcNJfE0aXXLnK+6NP9CYmAjditHQ=
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-4839fe90522mr178048815e9.3.1771814272381;
        Sun, 22 Feb 2026 18:37:52 -0800 (PST)
Received: from LAPTOP-B9QI2C1K.localdomain ([31.205.125.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm17687341f8f.5.2026.02.22.18.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 18:37:51 -0800 (PST)
From: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
To: Scott Murray <scott@spiteful.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Majed Alkhaleefah <majedalkhaleefah@gmail.com>
Subject: [PATCH] PCI: cpcihp: Check pci_hp_add_bridge() return value
Date: Mon, 23 Feb 2026 02:36:46 +0000
Message-ID: <20260223023645.344137-2-majedalkhaleefah@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of pci_hp_add_bridge() in cpci_configure_slot(). If
bridge initialization fails, log an error message using err().

Current functionality doesn't consider uninitialized bridges a failure.
Changing this may introduce regressions. As such, intentionally avoid
propagating the failure (e.g., returning -ENODEV).

This patch addresses an item in the cpcihp TODO list.

Compile-tested only.

Signed-off-by: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug_pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 6c48066acb44..331c21833c44 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -269,8 +269,12 @@ int cpci_configure_slot(struct slot *slot)
 	parent = slot->dev->bus;
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn))
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn)) {
+			if (pci_hp_add_bridge(dev) != 0) {
+				err("Failed to initialize bridge %s at slot %02x",
+				    pci_name(dev), slot->number);
+			}
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(parent->self);
-- 
2.43.0

