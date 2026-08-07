Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E912175A5
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131667; cv=none; b=JAbbCa7RkM0QslKyztyt9FLR9Pxl+VQ/kJtX1fSlp+zMmbswMELYfa8g+BFHI9BkMTnFakukxmZ9HJoVt+iSqx9zmMr+2ooKOtzMiELgY11nVPF8L8sp1JmjrLjQ7AiCDri7CSWn5q+gRvmbdd9J/2uKIH3avDi4y5ZfReW+NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131667; c=relaxed/simple;
	bh=pIxz8es0l7NHVt4rPf5JLNwenGKE6L8ikfko/REfnio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7Ivz5BNNI/OYsnJny3X+S/0X/Cz84n/aCOhUzQ693CgJKoWXy839UdMvPLZwTvTLe2V1UPC4LgCKcqbbOXVGaTlQCpRerHhGuOwCl8THyQY/xgoMpbxF5g/dsGj/ny5UMDXh4hrXBZfoqjgBscNn9a7+r2gtpYBehYIpD0vPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=M8lVAZcD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="M8lVAZcD"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e7632b193so273154185a.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786131664; x=1786736464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYmF0A8uqvDVQZglorDtEEMVhUonz1Kois8AmVRMQns=;
        b=M8lVAZcDS8Jdl8lTPm+3L+9GwgI94QLYOIrWCtHJo59erfRfZOQESsBwQ0oj2VqgyA
         NqRarJRQHmIoygGgscWH9XsFKfM2WHzWMGzMLPjelLWVSatxSJOWSoc/EKgUCcKwcevY
         ZY7kV9z4ZBU+IQ7VHrlMzXKq0BFYBSIGa4okaCzwind9l0eKEP9BsFt+NCDi/9CYhgkZ
         ONWFgqepQybUUgeIpWH5rWxkMuZaIb9B5TyL5QhAvKYq3f6spIA9tRYDomb6nZCDjHBf
         k1hMAD1Ak8itTVs7gHn4ggNNMtf2fqLRM04chlGfddBWI45xoG0ZjVHnfDPhIt396ecj
         DGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131664; x=1786736464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYmF0A8uqvDVQZglorDtEEMVhUonz1Kois8AmVRMQns=;
        b=qx8utN/sCowmBRHDldQ0NDiBM5ZphBBrqhJcy2XUhgO8QEmIzA2kSnoBV9SG2k+4oj
         O+CJeeBfIRVelrwOezN2TqV4qCt+xRY+aD5gVD+K/XJieJy8qW5O64foX+kQUNs84StH
         DjARYgnSldIZj3uWkVanCGCOTRbrtD1BRLv6txxZR7OvmXv3xYroqV5wanIESYjjV5rR
         rZw9LtWSwGld28qAMseUXpElz2VALvwjKcgzPMvTZpuSkvii3OtwWVVwo3LeqBCKRAF/
         1HcmaqlGWLoEvd69QsyYOxGnbS0M7OLZE+TILs+4fmhJXkreepg3wWegHoo6qy5FnOs4
         cuoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpriWfMR/62hEhHWBDuKsuzabIhehwTA3/XuIe1nluz/eJhkbPWGTO9NmR4KUl+8Bawn7dIgZyMqFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPT6/XvjvqL7xTOJODac6decwYWv+xS4ezqYkGbrJTyFBgUHz
	sc3yOn+xlMoDE3msB9Le60KzKn5rOvshk5RIUfIhndPr14H4JvzCpZh41J+DunmeWc0=
X-Gm-Gg: AR+sD12JZxCu1/9R+IUk/xjWjaJdZHOEYw44ercsBszaQ8JxTW3U1uMb9tXt3pVJ+/C
	cRbZrAiOAywGifbVp3b8Yyd6nItztoddVhrQPTE1IB2VLoCjPRqQtAB9O4he5ddnzuH0QpoZe3u
	dGDRsQ68ON4V0I79/5fvbleYA8g3PTojIQmRh2WeNWnb+2iLyR5h0eXdJi2UQI5oR8NiWSFhKGs
	DSkW2ShcEjqhZ11e64hCIqnSaZo84K2nCf/7NTcQwe8mKLa3WD2wDOC6Ophkzw+BdcYeFXnUXMQ
	j/MNy/IsAsJXZTdyxyzG0CUQ6lIZvaRimPQaEAB3PB22YHO0yHuOHHADdq6uesSIhK39l6xDXRe
	RjXv5Bi4eachrM1a4mRicIB8oowQVckSyHqTtE11iaDXy8JXf9N9nTyk9iqTLSQA1vP7OMjVJx/
	MR+YtsUsdN9hDfCfPeSYMSAtn9JRqcFR42qTQhnyUe9VXkaQ71J3N45c6NytPirDWW
X-Received: by 2002:a05:620a:7001:b0:915:a111:86ae with SMTP id af79cd13be357-936798a4868mr319767585a.35.1786131663991;
        Fri, 07 Aug 2026 12:41:03 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03aeadsm219786585a.3.2026.08.07.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:41:03 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] PCI: of: warn on bogus device_type property
Date: Fri,  7 Aug 2026 14:40:54 -0500
Message-ID: <20260807194100.455599-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of this series lies in its final patch, where a new check
is added whenever a PCI devicetree node is found to already exist when
one might otherwise be dynamically created.

PCI has a well-defined bus and device discovery process.  The
PCI_DYNAMIC_OF_NODES Kconfig option allows PCI devices to *also*
have a devicetree node.  This enables certain things that are
not possible with PCI enumeration alone. 

While working on a Qualcomm platform, I learned that some PCI
endpoint nodes were defined with device_type = "pci" properties.
Herve Codina pointed out that this was not correct.  Rob Herring
indicated that people seem to have trouble getting the PCI
devicetree nodes right, and asked whether we could warn if this
particular problem occurred.

The last patch in this series implements that check and warning.
The first three patches are fairly trivial changes to clean up
some related code.

					-Alex

Alex Elder (4):
  PCI: of: drop the reg_num argument to of_pci_set_address()
  PCI: of: don't zero flags in of_pci_get_addr_flags()
  PCI: of: make a flags argument optional
  PCI: of: introduce of_pci_verify_node()

 drivers/pci/bus.c         |  1 +
 drivers/pci/of.c          | 27 +++++++++++++++++++++++++++
 drivers/pci/of_property.c | 20 ++++++++++----------
 drivers/pci/pci.h         |  2 ++
 4 files changed, 40 insertions(+), 10 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.53.0

