Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090824;
	b=rlGQ2bRT+QMAzz9ii+icStx5ANFw5ou3SKVd7txsgoQO7+QC5UTmQY/i2JzBZbNAJWZc
	 buAX4ELYwmxu+CwuzIpodkSJbsUcwZFet9aWk4vTjP7Ej60Na2LRb+sWDBUsjEcC701vO
	 dBHqMVWP+in6GxXvnUifY6C2uYy7qgcvwS80wFFDeJyccsTLvlpiiS/fz8oAZifSPNh3D
	 ZUrBkydOu7dHQoPgqDOzu4200hoJKFkGb5qn9NyMSfzWyfdefATt18tXA5pv9slXvJ9b/
	 4Ja7UuP4nupczHCi3UnvJS9BH9svYQg4NxEid2jAYmZmvwLa2lo2/sEJyTW4ErFdNiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+7xRvEg+xwDhzUl0OpKcCBhyEZfVnsH/Bc/HKtadj5E=;
	b=xsxvRrTsG6PK6AQSbm7t14r5L9GAHUGXm5QAD9Fjpe306umPkKWNN4q9bKsAXgO8bXHz
	 prOodqLhaITJ7PhkOWWUUmXN5KznPAzOgkKOITu7WM0c7Zu1FAeX/5KwuExeJWBxofRYo
	 z6v90CzYVzVoLzFsXT9EZIvKpS6BIOdmHJhJJ6ASK2RaFefZzClL0j4r+TMi4gjgemtAE
	 cLMoKcZofQIRRqpyi58gonb6wiEF1OhxKL2AyFv04Ic6hb8InuCQp10BjxlKAR4x9srTv
	 aMEFPwsu1B0tqCWGIGPbuswiWtLDnC5r6FXmTLHsDtxeFw4goXHozkFzigAsYyLPlfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVJTfLcZ;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44683606A333
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44683606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVJTfLcZ
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so16628925e9.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 04:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795090823; x=1795695623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7xRvEg+xwDhzUl0OpKcCBhyEZfVnsH/Bc/HKtadj5E=;
        b=zVJTfLcZU5QGrrkl+NOShXgsa9P57cNLvp46KvzrUobFfzi6Xp5+Ek/Gv3LIdqHCK0
         Lja1D+auP2ObH18RnjTTX+Dt9+2ujqfjfKYDu3QA4OObNL8gI6f5vAZKwX903IutIdli
         ObTX5DpO3Q8qwHi2e52Qrag7vCbVdjv0Q+wx1qgeJ5+AwqSEA/YVcOCDbdrQJy2Lw9lS
         ZgPNj3n2ytG6bbnDzJjG8EHm936lXvBuRO1Vo5ruZZRsuFoAMLMVNGDcD44YXownYrla
         lECUARfltydKKu1F0VcHdXH+mYg6M8ENCgzmyuuQ3walTRmKXB5OxUMMwer7GS/DmAwJ
         WMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090823; x=1795695623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7xRvEg+xwDhzUl0OpKcCBhyEZfVnsH/Bc/HKtadj5E=;
        b=exdScDG8cJ6/EnV58bCLR8J/ikrPtRdR6krrxouwOTP6AJ+I1Jeotn3Mk1DlRgzJIl
         ESrdIVBM2rp7c7AzcV1vttfeuqT0sHBTAFi9x1zAZqAkfsTzx3JnpK4L2PXNys8Wz+4E
         zHrlsjse+W1uO+LPiGju5WTrMWIuSmaZcVfjOL5UtTvqQAoOJCZRnwU8kbYT2cgqUDRo
         B+FEKtsGkltJ1YsVfug64HyfxOUKiZvtDLkAGUw1xG0x7diQ6Ysfmqv+oQnzysb1q6cw
         vSUyKTqAlqDvn4PoqEw3nATMdK3kkOBVlKmE1LBY4grPYS2Kb5tRH8aWpwEhWLpaVAN8
         MEog==
X-Gm-Message-State: APuU4Z+3Fjsj4Mi/U8OGp9fUvWRaaBslkgFUp2eJhfJ9fDnXYjBpu5IY
	9JMmMqOt4KMBjWrWA5/FfJ9mTsfg5maxNLz/toyZUAm2ZGRiwfzqlqv+mtRjl1xBnpk=
X-Gm-Gg: AYBFou2bk2mkW71S6A/eDCqZp0So7xw58tvaGAReZlsb0S8bn9Sr6orMe1m+LI/wZww
	XzODRQT74NcXJ5QiFMbvb/txyLv41EWSFuYCQDheGTDJgrA6zN7JzKlZTMJua429+luK6aUY/1v
	htwhfRSY/HZmiN0g+Uw/DuiWvS1/3nh9tCE4DHZdypqIsNmkD5p+6ib7NvB68kwzK0F/IEAq2Jf
	ICyy58bGaCLHdHrRb0VB13m9lBoVrkdDCGBvenmtxa/mjqPU7Fp8MUqN5bVLHAvtho8YZc8kmr2
	sWeIWd3XkFbHTTPcTiqJFPXOPutreTOnF655yY88ukivyPGx9Zx8eXn+bg5xzAesRAbHiReadk8
	8slwRwUPGeXqibNVB9D//h8yfCDjkes5RYMCvxBwQU73JhjmFiI06nGCZBMnKvhZ4m1Pd3dWenm
	b9F15OEUBPMtBK9JMCIBosZo0q8SOkzzH332KhCEK/7FjHjLfFk8MTCKwJDZs2m6l+RvTFUYm+B
	QVmPLLiLEcho6fP9O770cbQNppeRclsQw7hA+GSNz3wLPg0ZKGY6YbZObA29oCIXDnoPSR19+Xl
	GpdfPsLKfTsXc92VOrFNz+cU136eb3sdaU0xRf57GOVHdDeJuyiWXOOAWSUI79z0IOt9dNdJCX8
	vXsPiOwyk2tHfU7z68N/aiaKo/OrqGMkxvdI0rg03dQPOTNjpy4xoqB5cMAb2tEj/8mw8tgd7pk
	vzDrt5bnIIXkxtqaeLGtZz3w1dY1sclWD/PjblvWWpprZacQ7/LEJSP2baEY6ioh8rXPIzqHGes
	JCjpF/XrssbOV5IYQ==
X-Received: by 2002:a05:600c:4fc6:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb7da26333mr115390035e9.18.1795090822118;
        Thu, 19 Nov 2026 04:20:22 -0800 (PST)
Received: from coder-gsekar-hip-hyg-new-5c97b6d788-n6g25.coder.svc.cluster.local (ec2-13-205-193-176.ap-south-1.compute.amazonaws.com. [13.205.193.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8532f08dsm32579225e9.2.2026.11.19.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:20:21 -0800 (PST)
From: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
X-Google-Original-From: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2] PCI: Correct PCIe port type field encoding
Date: Thu, 19 Nov 2026 12:19:47 +0000
Message-ID: <20261119121947.204565-1-Gokulkrishna.Sekar@harman.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_pcie_port_type() validates PCIe port topology and corrects
invalid upstream/downstream port type information in the cached
pcie_flags_reg value.

When performing these corrections, the code updates
PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
decoded port type numbers, not values encoded for the
PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
wrong bit position.

As a result, a device whose type has been corrected may subsequently
be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
upstream or downstream port type.

Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
port type is encoded consistently with the format used in the PCI
Express Capabilities Register.

Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
Link: https://lkml.org/lkml/2024/12/13/198
Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
---
v2:
 - Use FIELD_MODIFY() as suggested by Bjorn Helgaas
 - Clarify impact by describing the resulting PCI_EXP_TYPE_ENDPOINT
 - Add Fixes tag
 - Add Link tag to previous discussion
 - Add Reported-by

 drivers/pci/probe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..93e2e1f688ca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1673,8 +1673,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		 */
 		if (pcie_downstream_port(parent)) {
 			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
-			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
+			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg, PCI_EXP_TYPE_UPSTREAM);
 		}
 	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
 		/*
@@ -1684,8 +1683,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		 */
 		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
 			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
-			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
+			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg, PCI_EXP_TYPE_DOWNSTREAM);
 		}
 	}
 }
-- 
2.54.0

