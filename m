Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886922;
	b=FdOMi47+4J7mJ/TbjzsYY1f1OnzCMneLsJ+gtfi6OC91SCS/cXfjxZ9Odx9p5JIl8Wij
	 8DIvZYA6cudvLadX3Ndh5SW2KI2W5EjusBjLfNzDXWMQixZ0V6KxsrhaygGKf0Ba7hWtW
	 Xu/4s/w/axkRvi4tZdazb4bwyJD5a1Zwixw29UQHPxLOYxjVvfK5DEvgZOx4rabYq6nPW
	 /eh6cODmo3K4SM+DOr6uVVj1dWOj1VqWER+ZP+JDkCjRhZAuKFCyuI+gcwcMaS3upSXNZ
	 nUaOR6dFeoh/LHPMoA9UZS8V2ziysBCYurIayK/0ngbcgshUiJGg0aj2b6N00nUvHug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L87JvKpJJyF+bYMYgk77+UwhsWenN6AX6oAJRMiE+s8=;
	b=qEiQI+Fl3qB6HENEUVYUYCbNVkMLGXRbvNIc2av3oIVYFYlo0ghf/RFs263pVWBpa5sp
	 q/h9RCPC2VkaDwQu9jAB3b0BnQE1Mlf0zTncHzYcmxFzKWcdAWsuuB2jDER0yEflytTiV
	 qexhThvsb5IWHAY8T4oWn+zByQIgwTeo1XwxO3MiPCykC+xBJl1yjQVYMXAt02l9Y9z1K
	 GOdsas1H52Cj5L2YzSv3yJio6OiZ1GNjdiOC/i8kZIlWUA0tl0YI6ECdk0q8poCALkb7R
	 2ZtHSduENgRX8a56sBIGsrlb4eFHpznhh9dBhDffW78NqGRiaYlaDuiTOHtfq+h2DDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNTXgKqS;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A922606A323
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A922606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNTXgKqS
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-675617e81f9so1741791d50.3
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792886921; x=1793491721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L87JvKpJJyF+bYMYgk77+UwhsWenN6AX6oAJRMiE+s8=;
        b=qNTXgKqSgc/u7OSxa1GHIRE0CwLKNk6ryi6Vf35S9cdOLSwdvv4ngBSMFuELd2c/VG
         yufAkOl4isyI5pyNGtbbI7SklxMzEV4cfu/7YXfZsEVvCIPXdf3RXahceBsK3GW/VwcR
         AHTdyWfsqVQCD+waq7ksCuTH9bLPfPjD+UzDwUA9RZglzcZdi1U/fhniIg8m8LbyDhKr
         gla7ZWweCWHbsozSNGeXyPd8+ri1R9gUUTIUBx3aEWVV5KcFbP+Q5/xGRv1WcWchhpll
         VQsS+vteLXr2C47mGIZUm2836vk1+u7FZQvJlp7mwEnQb5mp50f+2Af4BGBLDVAaYNKx
         pLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792886921; x=1793491721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L87JvKpJJyF+bYMYgk77+UwhsWenN6AX6oAJRMiE+s8=;
        b=qxHZdeqTXqaDVAzpEUAyrq2InRowKsgjTiQ/Vg5nVSTLB0z7V9ARYe3WF2i14xMCXb
         MrsWkQPTc7jb3lCWwXuoQZ0M3C3ChCtXyxiuqE/3pgVR3bHzF3O5h7euEYJtp4CFa79q
         EGxTcw/5UOVCz6Ac+QTeI4kThF/NbhCUxJFOdJ3uxsH6tSIISt/lTGbdUf75x9/FPfIu
         zfKdm2l9wLqnMiKasYMrojtC5Zhe2IPzDRNT54mczcIwJRMH6Hc8L7DlBH7acx+07s5M
         UK+1erUfQZKXSkyKuzk1ITRkUB3CzzChrvKSO95xAHRp1jqmVfKVgT4yvyRu5LAGqyBM
         uoGA==
X-Gm-Message-State: AFq9FYKC3M3fk/LJE3QIK0z8buAN8PKQP89aFe1rkkBdmKe8s4gnhWx7
	L2k1Op7sOrupVAq7bWlSvJVZkYsmRsjYBEOfdPom82FTEyQ/pwJjileN
X-Gm-Gg: AYBFou2ddUIsxZ0IcFofCmihqTkO1SWsNPpZbt3SDrI9xoU5g7RqQdj8jakjOgGuZ8/
	SbZbfGIcGLd1dIzG/E9UGUz8x5lY84tp8AYsjfpTZMZp6i93mVSeVwESbj/nqldf6K2mAZOI/Ul
	a3+XXZ3D5CfxyoD4lI5GYd7GBKDWsB0ESYCGEfCXEfJS9KqKOGVy1GgAh6+NoOIRTY9J2pPzLIT
	ptc0PuvrciaYkGI9P+iRUaPSU+FDL0qndq0k9hU3dQEvP1hFf2TdMysXo8+zVFIF6UGJn1K5pdC
	awtdb/MVNak0bwfZ5KtXwBBXhgjA3L0CuAnzB3pVPSRSRuY++o5UlBdIiQs5T/BCq5iNgltqXOO
	t72QDrAavHN0goXca8ua/x3D6BGVBWui98ieUr9H3/LAjB1kymSl2nZ8HG9ZKtAphYSPykdnwbq
	6wHqxgWp5asZgKBG47UwNVfBXEv8c1xME8M/hz8Q2i2quthaIgRF0CHZSV6+ssxeb713D0434Uy
	YCEhUHjtt/jMgv8RCdsaoOrohDR2Ztr71IsJHfwABpRAyL91+fy5w==
X-Received: by 2002:a05:690e:a4e:b0:674:1248:2b87 with SMTP id 956f58d0204a3-67a45393ac6mr2294812d50.29.1792886921216;
        Sat, 24 Oct 2026 17:08:41 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a462f814esm1520084d50.22.2026.10.24.17.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:08:40 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Nikita Vetoshkin <nekto0n@meta.com>
Subject: [PATCH 1/5] PCI: Add disconnected device checks to user config reads
Date: Sat, 24 Oct 2026 17:08:29 -0700
Message-ID: <20261025000836.58294-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025000836.58294-1-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
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
Tested-by: Nikita Vetoshkin <nekto0n@meta.com>
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

