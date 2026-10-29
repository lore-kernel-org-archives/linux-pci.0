Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301639;
	b=029pcYnEMpcfieo87o0gMpe83VurksCfKDddNzqoTzifMlfMgNnnAzxctk825HR2vMkE
	 q+PWekFvumr/73iB0+lTgByIRJ95xwR+8tVZ0T+eMLMeLtmXbVi3vPgmV0RWmve2adRZa
	 xmlSvk3uOHqXRKBie8uCqHWnBb7yRKJqHtUivgrlDiDXIaxTvuDFTdfKUR1AKAz+vCf9D
	 KnCrcHJ4q7cfBLDofODrU5WG+qsiaaAQR0xxhTBK3wETARXQt1ax8D5NPxp0KU6i8BUuO
	 6oEnYK/YSxn8Ypp7PIZwL3QxTZPjbx3uz0MUd4pXs+sTxmVASOpzKADDbBWjQYBDJzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6VUj5I95g/DnmFhalu50syOf9VCbIVGKu2KqtebqEpM=;
	b=gNnpeVcMSSQeg8Do0IxxVRZj+Vw0sFjKwBKD+6R763s7+aoZHIP2qPu4nVLMyk/vKdiM
	 6wpQDv0IyGTUbJGsV+tL2m9zPdXS5G1djaJmkyjC7IfAbUmLhKn5xylQp1Ty0naZ7W/Lp
	 /ay+aW7rLlcK3AxspEW8ZtefsiqUP3vh7eNIeH35WWYT+3C52E/fvnBTiGrYkVq4m0/Dg
	 cYULqRPMKJRZKx5HHp+UxpBQXvzYS7Ob+X6c2zwsRqjYYCIS9bIWFPUI82pfFmLC9AGYK
	 Q35Po8q+kSsWxXbhJ8osA3v1/stfqLYGF55Tmgh3JR3xjNy3r7HoJaoyEkKygO3et6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yItuUYyR;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83673606A326
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83673606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yItuUYyR
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679a420b5afso2346902d50.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301637; x=1793906437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VUj5I95g/DnmFhalu50syOf9VCbIVGKu2KqtebqEpM=;
        b=yItuUYyRL0uSigkf9uWU/pnnQytcz9WrM6TwWB2wZBWfD8R/icWviMFJc0wiZAhV7o
         Dxsy1NSkMtErdjj7kWtdY8L9DT4z0V2LRqNBz0ZynonuwFlFKyc4C/YpV4QdTpHWNsCq
         oxs9r7TpX2STl4aSXv0OCwUAJnQcZgggwSsea6KozBhA8XkvjGQtHWP2Kn9HEhxcG95B
         C7/aagbM/xp16A7iju4s+kbuv58TU14ekFxzF8j1kOinfJ7YAR/wiYxc3JsF0Nem299H
         KDPOxQpgB7GVI4XmDgwDPCNDweqsObXWY6NSbDiqsiRVIyBHgTTD79m1nRDFhC631g30
         v/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301637; x=1793906437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VUj5I95g/DnmFhalu50syOf9VCbIVGKu2KqtebqEpM=;
        b=lrnIgU/THlia3F84AlzTpVeCdt/aCwYphhleJLbJW13io/OB8I5MsMXCPqGJXMe/3P
         zPg8bry8lfi1qznN07iO9qAn/HxdxTjSu53Bw/qPp2Bc94ndwTn5G98CLNhtPw+hAVCY
         Ddb2+7ykWUT1gTmtOTjFs7b9Vlqgo0p49SJFvsKgzHp8QJ8yX+U+PQ1zV8s421V2zKuS
         QG9n1CqHFOocvNV5Idu7KIpK02yYqc/ltrkl9bsyYgpDGusoupt+r5b1nD8C7G4q/MF7
         do/MicEV0O5YCcrEu6WDij/9ST2x9GjdgZp00JRW0lLpC6r3WF14Rl2Auj9DsRkyHET2
         GLsA==
X-Gm-Message-State: AFq9FYIes323qRtV6vG+8hcH84Fb6JQTKPIdjXDARusBCTGPnlshx5z0
	SAumLxNvX5GVSbsEu7GhBLgYL+DCAvHQ6SRZqO4FSX1Xwp+/71Nemaku
X-Gm-Gg: AYBFou3A6lizGiUlJUhIH+yBw8heoE0voimlVlrvQK4Iomr+hOTTR6Tc+XEoRJ2YK+p
	Gd1N5JPFgnjHj9agYBBqgEm8JBMv8P6qVSOKc7Oxk03dxU5BUMKtJ9qd5HBIlCWzrYGc3f22AwI
	7L4r0UsInnYhv7tEhC+YCYcTu4KqG64Czap7pi10SKv9j/XC5vZdrcAsay+6zDr6Sf8U/sH+5y7
	PlphTHGE4n8peUks8wH/Y777OCkS/BS3hDMpBRA4Bwn9NcyX8C6DYKVJypjYuoI/ndcRFTDNbC8
	TDlxu+H9tHxBis7q/C1+UWCNmiGCDeaahPfm55MuzRbeG6z3IEAzEXJ5R7uCXvmCcEQPIXKOrxM
	rh7T+tj4Y7J2JVxTrkZxQr7NCfGoWGfo3cdRjrIl/oJoOKjNJ+FBgpk93QJ5ejNo/xt9pIc9OdF
	9R6/mwlL9ME4kAbYCnmVl1NF91P3cjtDcJPwgGOO1ENFqmBpxe18kTQLJyIhgdA7yIpz1edF0Y8
	2UfVTHzFECDXyWZoaCaNoChSuyDeDMTrKMWT3WKyrdVkw/G3cFw/uMNeaztFTlu5Fe6mFa4JxiH
	9Qne70womhrT2Z7Qoon539XhyrzC
X-Received: by 2002:a05:690e:205e:b0:67a:56ce:ac2d with SMTP id 956f58d0204a3-67ba4c882f3mr52677d50.3.1793301637481;
        Thu, 29 Oct 2026 12:20:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:4b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba335ad79sm175635d50.0.2026.10.29.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:37 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 1/5] PCI: Add disconnected device checks to user config reads
Date: Thu, 29 Oct 2026 12:20:25 -0700
Message-ID: <20261029192032.1325629-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
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

Since commit 4b1038834739 ("PCI: Don't attempt config access to
disconnected devices") the kernel config read accessors skip devices
marked disconnected, returning PCIBIOS_DEVICE_NOT_FOUND and ~0 data.
The user config read accessors still issue the read, and if the host
bridge completes it with ~0 data and no error, they report success.

Check pci_dev_is_disconnected() in pci_user_read_config_*() as well,
failing with -ENODEV and ~0 data. Do the check after waiting for any
pci_cfg_access_lock() holder so a reader blocked behind a reset also
sees a device that was disconnected while it waited.

This prepares for converting sysfs attributes from the kernel
accessors to the user accessors so they keep skipping disconnected
devices.

On a disconnected device, existing callers of the user read accessors
now behave as follows:

  - The sysfs "config" file and /proc/bus/pci ignore the return value
    and return the same ~0 data as before
  - pciconfig_read() fails with -EIO
  - VPD reads and VFIO config reads fail with -ENODEV instead of
    returning ~0 data
  - VPD writes fail with -ENODEV instead of timing out with a
    "firmware bug" warning
  - VFIO writes to PCI_COMMAND fail with -ENODEV, since VFIO reads the
    current value first

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
---
 drivers/pci/access.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..18a206bb2a94 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -237,8 +237,11 @@ int pci_user_read_config_##size						\
 	raw_spin_lock_irq(&pci_lock);					\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
-				  pos, sizeof(type), &data);		\
+	if (pci_dev_is_disconnected(dev))				\
+		ret = PCIBIOS_DEVICE_NOT_FOUND;				\
+	else								\
+		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
+					  pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);					\
 	if (ret)							\
 		PCI_SET_ERROR_RESPONSE(val);				\
-- 
2.53.0-Meta

