Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E433557D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006765; cv=none; b=XpAnF4Gqn4mc3qqfrZ+/iRo55IxPy3P3sj++UfXrqvXH5nsmGZqFZbbY/H3j7+q0CQ08L8wuycZJxtO+BUS63OsdcISUoGtrYwhRkrq+WYIo0qpVLCVbG6Krh2bP/egQxeNRSuwJHV4U/mZ0HnzIigPyBP8jGcumxlXNHIEiGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006765; c=relaxed/simple;
	bh=JzPrbtLU1aX7jPBx7o4xg1QwPf4aojsF7MwxzjDLuXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFGEUXcAb8NnFxJWdtxy1Je4rlA2IqU1q3IxvlWrAitAWdIsI2Tf2AqJnZoQvL8hydgqgYX/xhNuJq9kzgJWtzUgZKDzHRvTRgoqLjnZ94hvk+oNbOH/Al5kx+cLijTjvcRBfsJBdZe5zO2n0BP18bopzgUKevpdxVMXkyAEe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=PeOT03ul; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="PeOT03ul"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90ceab90152so56620796d6.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789006763; x=1789611563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2IJdQLgVNz13bowYN0scU7l+eW7QDn2APNBpPDBpQ/Q=;
        b=PeOT03ulNvtGuiqvNZ1Ut71Z8K75+Dwh0Cp6ZTsxP3RFmktG6KGkOOBRVoJHcUSykw
         xJyt3pAxuJen+dSHATwDiC6JFgOSpIVX3gln6IQdvGaPP8agx3KSOpakHL5218DPPHKE
         nLmrsKvT8MQT0mj/qIjlQA8GIgDDGvsXtK9xaYb8WQNqHmT6sHd1+I4ZssswJETVs6yi
         SkIUS1bu15FwkGwurmq5xDNO0i5czlQRD72BgK8MrnlF14dEiyu67RduJ3G2/x0uQT15
         cRX0XMJzW07hfAUdxWvwsR4PIGbCqM8Oy3A22ArQjJcykHVgbwLwN+vrKEC1F+viHZRT
         A1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789006763; x=1789611563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IJdQLgVNz13bowYN0scU7l+eW7QDn2APNBpPDBpQ/Q=;
        b=YSj92ueNKCVmxQsAZkS35Dt/fzxs3VaETLArA4D3hsTKZUg6Z/CtiOZqy1bSGgy6Px
         KveHeyf+l2ZvYq0pJaTh2pfKVzEAEptH54ST7RgXl2cR9rSIGtKRHpj+ZBSi3JxJkjeo
         f2vi26DAL1YS0BrOVBzVFqJ8NWYh461b6loXKR37rrrDIDRoOpwiqdMUWi4/o92+cE/+
         FG68L9ay1bY65d1MzexaU5QPfrJBcFTlepUokETheS3QXoAA16H1XNeikcoMGEjZfA48
         cVay1ShEm8EFX9PlcY+hoBdI3xrNTzNpZe2pJ/fsMS/MyA4OESt2uopcqCWnGlxdDiEE
         TNgQ==
X-Forwarded-Encrypted: i=1; AKwUvByoApk9vwjpnZD9GIxQr+yKBwCUHffzfI0e3Ca8rDccjo+KhPQiW3OqSwP1pdNC/6+N39I6DhxKmpY=@vger.kernel.org
X-Gm-Message-State: AFuF++mROMnV7Gde+7P6QmeQMZ1wf7gdMwH86t3U+O/Pwd1KniVbA/zN
	8Y1xqvTe6eNqZtL/Tz/b8ne8IBvhLPqpWiMdvhygI5+YHQzpAdXTTH0FPM7Rx2fq26M=
X-Gm-Gg: AYBFou1QjbWrHQzbUZpZhZCB7pmyuMD/X3+GIp6ycSCT/C6Brqjic7PzEzSVTuKCo4u
	6wwPuGKOxQlH5YyJ7v9a7sGkII1lSJcpIA+Qi4eYcmlt/T6kPS06kXdnsoGDlRxe6u592Z2lMFh
	6dKCmc1z+1shn4zuMupGqBx8huXzVy5ys21Z4SsK8hZXvKGdN6Snv41FB45R3lakjD8vAlrIBhU
	ZTbtpKuyvUgTiMedPvin51hZreuuUafzHVau1qOOJimT/W9/cQCTeHrT7yT333hmWU2fD5nR4ar
	HJCUpQjKjOvjjxcIr3OuLc6hlxcHEWpON6uIh/lX0+rcvsTjoHZCHsYMvjXGiIA0Fv+ZGYXQ9jw
	X2XnKUbC/OWGBtOUG7RDXlyYrIJzedzpSsczG3c6iF3DvLG4MSVMA1hgwqALYwDq1QyoH9Dgzdl
	1kS3sNq11AHjCONHMfMpuBuAcBzAYrweLVmGHGBaKUlboY+cYtYdoIjcejOq+PGrg5bVlOV5DMg
	EE=
X-Received: by 2002:a05:620a:bd3:b0:939:de6c:cb45 with SMTP id af79cd13be357-939de6cd191mr25538485a.47.1789006763100;
        Wed, 09 Sep 2026 19:19:23 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm1561375585a.32.2026.09.09.19.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:19:22 -0700 (PDT)
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
Subject: [PATCH v2 0/3] PCI: of: update endpoint ranges dynamically
Date: Wed,  9 Sep 2026 21:19:15 -0500
Message-ID: <20260910021919.3421449-1-elder@riscstar.com>
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
  https://lore.kernel.org/lkml/20260908213459.2519059-1-elder@riscstar.com/

The entire series (based on v7.3-rc2 and including those prerequisites)
is available here:
  https://github.com/riscstar/linux/tree/outgoing/dynamic_ranges-v2


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

 drivers/pci/of.c          |  89 ++++++++++++++++++++++---
 drivers/pci/of_property.c | 137 +++++++++++++++++++++++++-------------
 drivers/pci/pci.h         |   1 +
 3 files changed, 173 insertions(+), 54 deletions(-)


base-commit: 857c3561ea9f2c3107b5c6d830d3b3face159cbc
-- 
2.53.0

