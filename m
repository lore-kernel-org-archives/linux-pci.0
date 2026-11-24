Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510150;
	b=Bn8Gq6Di2ymHpQ7ibdElLoJJwqPJ+DMYH6HySQwyh+4vD6WtJEp6/+aOqGcd7Sf9H/sO
	 ESpD4ierNsQdvt6LIMDSIDMBXJpsVg0TOLprq7hfcDiBSfFEisQiVwAfhNeWaRLJ97xKg
	 cloRL1BrveW/W+pvtbOT1NE8BBYG5uyR1ShaZgDjeBYSXMFZmzf2AhJuroelq9rXFM8il
	 R/QPWs68r0fix5LH9NlfxM9r7PBz7NVmxotG8HLeFS14HB9GNiwJuyZckb4CL1TDhZTg8
	 iwxY64En9/AzBqge5aeI6BMAPTCK2zWzUQF8ysVpcGgtx50Y4htjL/xGIzVmv3NzmlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MFg6AsJZlAHZYkg8EWkBVHGKeTBRg/h+xqjFyeI8VnA=;
	b=OqgTM6DyQAjsye/PRSms676150VMgdK0ALF9jqaX6hWRIJBjC7QV4oM9IsG4uMpIhE2z
	 xKX9OAFlUk/O0OrfvV6KWugDFAywtKlhmY6KC049R0czBb0an6Qup54gpey0SiRehI/n6
	 cL2J57qrw+cjJrcuxR4AGKhlVKHBEScPMdL3B5L/GDucYFs87sXanCxHgK4f3CXdW37ee
	 Lt5VHE9xLErKYeLvwJMQi/YE2c6Gb0KZYHoRbt7xMKKuS5qxjZkWUSZyh3GeKlWQezTSF
	 YpvFv2uH3e5wDIoOoHFUycQSlJ6AWygl/6bYbqyrrapSpKRLqnMNVnyTdOv2vLmZprQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qa+8K6Kp;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D24606A322
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D24606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qa+8K6Kp
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso2704746f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795510148; x=1796114948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFg6AsJZlAHZYkg8EWkBVHGKeTBRg/h+xqjFyeI8VnA=;
        b=Qa+8K6KpprmVocNR0qPP3+ECxTeqDLhv5D0nLQ9Q9rFR4ELA01sl8+UrM08OHiEQ0e
         gon9i6/HyR+FzMEpsPeoBgRTds/lHsT6AWq3Y16gVR3cqbxoUAHzq99V314EOSkyj2p6
         eYHf9s7uU31HhQNqxanx9elNSJj/CUAkJUKE+4R+57K1PlE1aMJP9hi8H88UNMDPhxWW
         Q2otxFGC3h9rnKdsfHnRO4dncMnV1y0z7Jp5v+NUmRZVEQbrvZcN6VgIf0ximeea5W0O
         /u9cbZYGGs3G8+ZYzbXkVVHFXrjpsmEVJL+i5skNNgQg9j7KBh01JOb8r4J1Yb9Ouj4c
         T80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510148; x=1796114948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFg6AsJZlAHZYkg8EWkBVHGKeTBRg/h+xqjFyeI8VnA=;
        b=Mpkfq7Xjo7i3Yzi2/EUHLTp6xhKtVPKfLmNEY58cgYeveBkITstxaU1Nxs39XRIv6N
         DITRDPffjH1cUsyy2OwuTmGg8+7s8mwKVjLNHkvnt6/Nl+dR6isUWhSdrhzdHYFlYgww
         FGpE4LCzDTXy9z/Pk8sUr+wkE5s5flf/YNFeqX66s8OUCaj7yCyL9hcB29gS9DK27aBE
         GDRN7wSFika9CPOXAFF3N6BQirioIFOJMC/XsWcn802a/VoVflfH7FkkA69/gQYDRnZs
         RanjP4kz4MMaftKOMHZSm8behc7nWQ1oMmS9N8wZz894F1uY0lVQ4a2ylNjAth9ikyOZ
         X3ZA==
X-Gm-Message-State: APuU4Z+Tb9WJl4UZsZTHrLgy9ISKORoNJ016bibgUZ7xvTQ7aePcvyAK
	eXMD0K5cIpsygldveu3liAXcJXfrb7Dy3++dW4rZLjLaIpQxe62JQAE5zWb59pMX
X-Gm-Gg: AZFdTZeL8X66ivxy9vp+NFkFjeVcVH8BvGw2am+2Xqm8uwzAd5Zibdh3TZkJdIbqXeQ
	cvFkvTb8bgYepj2EMJLHUSU47Z2cFfuGvkKH96PzcnfsY7P3Qeg8mKahVg47zSlq8hLKbPhNyLZ
	jcEWR3aHFx43SRvhWojOj4OBLRiUuNTsL1PZ7uUCRXzMY3O5/xFKnsFFh451WMUVlGEJDynyb/i
	/tOLpGN9q1plpLdR2G9kZCWpxxTVR7HP36gL8kHfGV74Z7wdOxBP7CAfomg95UIny7CpFcd2Ews
	fsaRJS84BA0NaYMxgJ52sotyPq1lxVqdog3o3WJgcEy0MeHehZlxh3zE7jfdmEvRf5MlEmRd2rV
	BmwmAxwQVM2yzAM2YYCA7F7tlhFDh30hHObyGzVrbBj+b5eyZ92r2jSnZF5tCwJIKOMP64xGj9q
	WeQgxirwFYbWelgJuKv5Je3MjFimjOBRZdR3DhfZ/qAZYpiJvKNbBOFM8fjYJ1A4rAbfir8uuh6
	jrhc+bmKx0y6Rikp/Vk4wiKMFkMgeNM6r/SmrNMMjm4CLTs8qp2E3Qfdved4matpb5PphLHQUJu
	v4mq2nOClWTPcIrCQve866gvJEPvJvL9o0gKHBWchCi4TZ9LLNAtHFW97CEosw3GOtNghDxt91Q
	yQiIC+w3LHWmmIMhCzt29q72i2fID93KYuSwONWg3D3QPj8EvznXO00MlHmWle+TuG10UNX2HPF
	KW0ZbJceBAxOAfuktsn8m1brxQ28E0Y1p91TyQYJpkSf1EKnyHCguE3Ohqs5YxfDc24/YtRNqCv
	Du+m45eUgP5z43jgLD6ghTR+pc2vQe/Ot0S/YM=
X-Received: by 2002:a05:6000:288e:b0:49e:4ba2:a775 with SMTP id ffacd0b85a97d-4abb86e50eamr26630676f8f.56.1795510148163;
        Tue, 24 Nov 2026 00:49:08 -0800 (PST)
Received: from coder-gsekar-hip-hyg-new-69bc66c5b4-skkj6.coder.svc.cluster.local (ec2-13-205-193-176.ap-south-1.compute.amazonaws.com. [13.205.193.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm27270565f8f.3.2026.11.24.00.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:49:07 -0800 (PST)
From: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
X-Google-Original-From: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH] PCI: Correct PCIe port type field encoding
Date: Tue, 24 Nov 2026 08:48:28 +0000
Message-ID: <20261124084828.15318-1-Gokulkrishna.Sekar@harman.com>
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
Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@marvell.com/
Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
---
 drivers/pci/probe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..4c7e0ad1aa1a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1673,8 +1673,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		 */
 		if (pcie_downstream_port(parent)) {
 			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
-			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
+			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
+				     PCI_EXP_TYPE_UPSTREAM);
 		}
 	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
 		/*
@@ -1684,8 +1684,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		 */
 		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
 			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
-			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
+			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
+				     PCI_EXP_TYPE_DOWNSTREAM);
 		}
 	}
 }
-- 
2.54.0

