Received: from mail-qv2-f13.google.com (mail-qv2-f13.google.com [74.125.230.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E963F54D2
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288690; cv=none; b=N/4mblkx6mLlbJM+H4TXc5kG+HODZIkgbi2Exqh3tpRuquR7/4rsaQVaeIySB41XDB0zHnPB/tPefY6rvpRDf7saKc8/MsuxTQ38AyH0LS7p0Gaw20/4BDu/p1aL6FgnFWWoU9wHXY0OW4lrLoAH9vOIIG24VYkgHw4XwA1NWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288690; c=relaxed/simple;
	bh=ZdWlOg2k4wxwvxy1HHMmM2VbraDjgj2FEzkLGTct57s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaJrUxJPA4jPm0uzaGF0TytunzU0j9oO/41ZATE8zcCKSfrttuXUCEStok6p2W6B+4gKa0ywDIDZ9kXydDZAyU6loFB4IRKk8hTwG1sODfaOajI3NgrpwkJs7OYg9stTl6/MY6XOe6yUpEbPIW1a2y/HE7i0qJoAAPtFh4P3Cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=s91mQQyH; arc=none smtp.client-ip=74.125.230.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="s91mQQyH"
Received: by mail-qv2-f13.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so3530276d6.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790288688; x=1790893488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1d3roQUV6QY6LJLrYwiArT/fpcpm+0hr4Nw+vflAtJ4=;
        b=s91mQQyHhYS+HMZgdDRfd8/mRcV2rYaGmb6Fl9jGeDBEzk3Hv8WBLz5HFRaqqz9H4p
         1aJvy8RNIlGAGyOy8cCV1gK+hoBQzdvcEqjQONkLKyirR1RNWenqxtwXu+X9Hahz90XY
         zIvA45X9kS1EsW9OB+gH7aH1GCTC9oQiitKqfPDcROjBy4txzKIdhbwwLpWS+u3t5Etg
         W9gV0lOuj9AdADXltV4ajrvnpnzZ3hUNihTWwILv01knJ7jlVGz9wjobM7OQm3XMd5gG
         1yHIKv16a482pLo8gcdcd8pvpIFtYqVH0n6+k1W6tOa4OUcOaR8PsXFEigeJ1p4isTV2
         AC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790288688; x=1790893488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1d3roQUV6QY6LJLrYwiArT/fpcpm+0hr4Nw+vflAtJ4=;
        b=hnr61VGtYfc/FvK2u7vlJqkp6MXkTMt7x7+UqnBj6XkqeIxk790KtNUTuZye8JShs/
         ON3U/QJqsovSPeALP/TGqeOrty4giAt7rmPj39r/QYsMvndxuoTPA/yylgrWkzMuAdMn
         p5ATOeaqE4oL7lTZfQ0a1LagvVmBqEFwPf7bWl2fjc0VMXODRf3FE09tUe01vuQTy6KV
         wTosKZZ8f1ma/p6uYi+SwzmnrzHN8H7/eVcgNsnv3tgr8l2AMSEi3+tOpnQCO4l8tZE6
         pPUYhywSz2Vd2GeRwbgaXcNfkXNNBGewnO5QDP2krBFVMHpWbYs5ic/Kn3AlWq39K6Q9
         effw==
X-Forwarded-Encrypted: i=1; AKwUvBwzm+c9btULjp5WfS+UYNkxGCKn4xBIdhWHnVdW3HeMm5ASmLoIz59h9nZ1/BpvOFynTdktRbZywqc=@vger.kernel.org
X-Gm-Message-State: AFuF++lJcfhJAYjqVxBodr+Rg1TvGLwF4efHEqoIYqI/Owc5g8PZMCl1
	LvjBCvLfmIctjzru2qzP3eua4qCW5mMPE38NTPTUq9gH1WHy+RCG/KEvFtjSDr+xumU=
X-Gm-Gg: AYBFou0/xXZz6CNKRRD7WuI8gttcFFPoWrsCAbNYxQYoxire+2GXJwHeNGgyYF9dNKB
	EUzm17q7RijfrE8f/NL4NMr+NP5qvNhC1ZiFKWhB65HWWeNmUCGAFQGCviTgEWs0qsz/w4kSVkF
	ZNuvPlFtREhblSAzDnwvenIQ2kAX4Is/QAaM0apKvM5l/9n8tLDgHERr4okclIkwlIVQ3pQ9vFN
	UvHvrZnVzQGfFcnV91lSntuS3GXFpMm48/WskUWsgIPuMQwfSbejWbCtWsgZGhwBO93mfkTIly4
	nyisdQRRnc1dI5ojYMbkmhutd2x5e65sIMuD1EXDntGfCn4RiHD45HQNSs+jCnm3hSdyw4t6kCx
	GTLAP5EHwZ4qOyw71Y2qy/ghXvRWl4A9QIniciK5idW8Ew3oTPjyyWMXJTx0IFs8RrOjW13dCH5
	G5MRSM7yO+rtgl/VwZ3BvtkgEIqqDD50lNhmFE3WrVh5fTameZ31uxcBtxasDURs1yt0LWrePUG
	d8=
X-Received: by 2002:a05:6214:5b08:b0:910:3453:7d8f with SMTP id 6a1803df08f44-9142f91cbe6mr13728836d6.36.1790288687772;
        Thu, 24 Sep 2026 15:24:47 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430eaf5basm3516496d6.44.2026.09.24.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:24:47 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com,
	herve.codina@bootlin.com,
	andrea.porta@suse.com,
	daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	mani@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
Date: Thu, 24 Sep 2026 17:24:40 -0500
Message-ID: <20260924222444.1351466-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PCI endpoint bus is a devicetree construct that allows a PCI
endpoint (function) to have sub-devices defined that are accessible
in an SoC via the PCI endpoint's BARs.  Such a bus is represented as
a devicetree sub-node for a PCI function having the name "pci-ep-bus".
There can be one or more pci-ep-bus nodes.

A PCI function with a pci-ep-bus devicetree node must also define
"#address-cells", "#size-cells", and "ranges" properties, to specify
how endpoint bus addresses are translated to the PCI parent bus.

An endpoint bus address has three cells; the first indicates which of
the function's BARs the address is associated with, and the other two
specify a 64-bit (2 cell) offset within the BAR's region.

BAR base addresses are determined dynamically by the PCI enumeration
process, so generally it's not possible to include them in a static
devicetree file.  When this addressing scheme was introduced, this
was not a problem because the devicetree content was generated
dynamically--after booting--based on the information (including BAR
addresses) available following PCI enumeration.

It is possible (and in some cases, necessary) to define the devicetree
nodes that represent PCI devices ahead of time, in a statically-defined
devicetree file.  In order to support the PCI endpoint bus model in this
case it is necessary to dynamically update the static devicetree so that
the BAR base addresses assigned during enumeration are reflected in the
endpoint's "ranges" property.

This series implements that dynamic update, leveraging the same code
used to create the "ranges" property when PCI_DYNAMIC_OF_NODES is
enabled.  The first patch makes an argument to of_pci_get_addr_flags()
optional.  The second patch separates the code that dynamically builds
the property value into a helper function, and the last arranges for a
statically-defined devicetree node for a PCI endpoint to have its
"ranges" property updated (if it includes a "pci-ep-bus" sub-node)..

					-Alex

Note: this series is built upon these patches:
  https://lore.kernel.org/lkml/20260924150222.1179235-5-elder@riscstar.com/

The entire series (based on v7.3-rc4 and including those prerequisites)
is available here:
  https://github.com/riscstar/linux/tree/outgoing/dynamic_ranges-v3

Between version 2 and version 3:
- The ranges property for a PCI endpoint with an existing devicetree node
  is only updated if its ranges property has an empty value (i.e., it is
  "ranges;", or is not defined)

Version 2 is available here:
  https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/

Between version 1 and version 2:
- Included the first patch (which was previously posted in a different
  series)
- Modified the last patch so the ranges property is updated only for
  PCI endpoints having at least one "pci-ep-bus" node
- Rebased on v7.3-rc2 (and the prerequisite series)

Version 1 is available here:
  https://lore.kernel.org/lkml/20260813220717.1394644-1-elder@riscstar.com/


Alex Elder (3):
  PCI: of: make a flags argument optional
  PCI: of: introduce of_pci_build_prop_ranges()
  PCI: of: introduce of_pci_update_endpoint_node_ranges()

 drivers/pci/of.c          |  94 +++++++++++++++++++++++---
 drivers/pci/of_property.c | 137 +++++++++++++++++++++++++-------------
 drivers/pci/pci.h         |   1 +
 3 files changed, 178 insertions(+), 54 deletions(-)


base-commit: 6ba8359b84d69a07d508693551ed3f661d838e9f
-- 
2.53.0

