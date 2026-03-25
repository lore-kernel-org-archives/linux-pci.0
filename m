Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F81371054
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470445; cv=none; b=MHwlFu/YPNWX05WahC/4m8CNpxwSlIIk4cJrkUFwcrlRl2YKeH14QxvMbKwX4iYGrD3GDyL7iVb83uMpGGKZnJCRbksE8yDJPIgazXPc9SlBcV3aWz79JjUTERmQjD2xLRsSv5U0i1HoPUzOi3vQ/yKop5t8aRciS9ggLeY5Gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470445; c=relaxed/simple;
	bh=0onwSdC4aAc8cDI7zylJ8q/ArIAL1vgMBP4pvRTtjWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lN27ubSXdxAMqOslzJd3VSdq07AnAASuz102i+uv227+wDc2LpYdfJhWnGGzK/gs8n1Ik4SJjVGob2dTWd7M7hovw0VD9u2Rmv3lN9MjmG4/zs5Wb7H+uVpu7VSdJEjJ59dfKitGDVoPSnK1SK+c3TKQ+DMOqJvyk3N9AIm2Rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGD26ZYV; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGD26ZYV"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c1092cc08cso676954eec.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774470443; x=1775075243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0O/c1TvyMvLhySUBvQSZ4Jz6C1ecY6F0Rr8Y+sdjF50=;
        b=FGD26ZYVPQ4zpvVHC9qHDdxgTR/vbfCn+Jj+7cq+R/UZ7wwBkBq6BPj0LEdTlgKET2
         ywwQqxv0IJ024c/0jJucjiUqVoPFfnS2zfssQiVurThqX8ZEphTmrhSLq9OIT9Y7zdlU
         anCKHragPnUuBQBbWwyUuA/bOg7hULNIMuOrwtLmqf7GkDw8xhMsQ7prAspN1d82YnMh
         9Q6ETHfJGjDDAwomHEXEePLseoF1Ntbmo8oyrilApJtFAxfsWBjvS/Zr6fh9XDAeWeRf
         bvs0iEI7ataOaVgyqOvt8nPlcA32rHIkeYyxvcJIlAbPrmvaX4MsQ/gK8LN4X+DJSRtH
         R58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470443; x=1775075243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O/c1TvyMvLhySUBvQSZ4Jz6C1ecY6F0Rr8Y+sdjF50=;
        b=MDAHfy2CV/J/he4SK2dZfIRmIRZ7auagTArroiFSjtCaa+j0Kizl9VfhURExgmySXV
         yPKiRH4yDNM5JKFdAvwCnIF5nWWko+RPtOKQ4JUN0JkqtlO8AQvUotfwxaccZnqVBUH+
         NBpqYotWE/7/ntWlnEu8zypXYav/8a64cQbNb3rMUsWOUELm+9Cg+im+eMtWL0QuPkb1
         RbQO77wzSMHz6mf+jExZzSYYtq1lY0KXHRdBPGVUzCPRx0jWKO1auCkbRZUeDusWdIV/
         RBHMElCdaAHz+4+54wR27IWCVAxwq57Geu5eO6r/I2VfATMQpjNd34zeoFswpZ5ZVGwq
         fSrg==
X-Forwarded-Encrypted: i=1; AJvYcCX3BKYjPLBtqlYVkfuoWpnBd4mhZJtSJYtzjPZuH/YVeNJW9uLJZgrC8qxx/KPQ3etWtKTqzlGWqrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKhw/OD+Jvc0T+/v1lJmNTe2AHnQUgLVEGPg7Nq8NShz26B9u
	uWREFhLZbYTko66AtuQJ8AJhgSUKby2XEpCOnkb017rOHDfDYeqjFrEm
X-Gm-Gg: ATEYQzzl96E50Nle0GGQupwJryDJ2TU8iqQPxzNOpy7UVRNAFbTiBwuRt6LjDntJyig
	gl82HH8gtyHB39oJ12KnnUU+6y+oV8th0oOhEckZNqlRTkuMdXyouLjz9P0xlrJcXhtP3dwrb3b
	DjrSsoWrA/UrAXbk6kz6koQRpP6lfJcxh8e8vDJ5IwaWXllzEPtd5lv12rhBj438tz6O5UngsLO
	4uXyBGjv3+CfC7mCeg9MNiphCo4T8q7NgigPMpwoboCZ8idvGJfKUQD8hLkXO6VX7wZM5afNmAD
	n0gm86VpW9oAPBUQPHpRHdDEKo/EkwXO/DmK9gHtqc+ifY1Ffu7Ya2WeoggfoJRe6KFOmqjeG/F
	jdu5HmpgihuQe/i2wPDDMtSAEQxw6sNc9VPxDppHRqqF/ho8kfv9qkecKJjfut0KhR9ihHht/VU
	y3GSKVNDcRVY6gw3jjMTfCUos/aY5EIlbrxoggoXeQfXO6snEDZNc=
X-Received: by 2002:a05:7300:6a95:b0:2c1:6eda:476c with SMTP id 5a478bee46e88-2c16eda4baemr434739eec.28.1774470443233;
        Wed, 25 Mar 2026 13:27:23 -0700 (PDT)
Received: from brody-server.tail733610.ts.net ([65.173.245.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec815cesm643827eec.13.2026.03.25.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:27:22 -0700 (PDT)
From: Brody England <brodyengland3@gmail.com>
To: scott@spiteful.org
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: cpcihp: Check pci_hp_add_bridge() return value
Date: Wed, 25 Mar 2026 13:27:20 -0700
Message-ID: <20260325202720.389400-1-brodyengland3@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpci_configure_slot() ignores the return value of pci_hp_add_bridge()
and continues with resource assignment and device addition even if
bridge setup fails.

Check the return value, report the error, and abort slot configuration
if adding the bridge fails.

Compile-tested only.

Signed-off-by: Brody England <brodyengland3@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug_pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 6c48066acb44..7ae02071e796 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -269,8 +269,14 @@ int cpci_configure_slot(struct slot *slot)
 	parent = slot->dev->bus;
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn))
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn)) {
+			ret = pci_hp_add_bridge(dev);
+			if (ret) {
+				err("Could not add hotplug bridge for slot %02x",
+				    slot->number);
+				goto out;
+			}
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(parent->self);
-- 
2.47.3

