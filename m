Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E73AEF49
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658843; cv=none; b=bo6LlYLGdyezg3vYLKPZ6Vr0Er/KZ5aPraPyFwYdMarUjPjJMv0GYQCvIpBRyuqBArqFBlczVJSVptbDNIZCzR9s9+gQX8WmnL/8w7ayAokWgVVJqtvC8flc6srkwby8yLG3zZbWVWLRJHevxveEacoXWSlc8EaRI29+NzSna8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658843; c=relaxed/simple;
	bh=XxRz6eIi4vrbGSsrtHk1K9sZwlUFzoyA5/RS2yUTgGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjmYG1AaysrZuwe/+xn04cPjRmk8xKVAcziifcciNBoNXFVbeOQ7/ERYoQPJViQ6tNGPO8OYvze0U/1f7a2K62dIHw+nLndE++LgOrD2D842S9LjUbn4wHhPTL9csNZ2NeHiV8hZQR4AkX413GsC7E8ofDUmztWkgeZwC8HThw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=CvAgzI5P; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="CvAgzI5P"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e55b62640so21743085a.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786658841; x=1787263641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pdj1VPsCLSMdSAO15ZyEARW2To6jf4TLj09ZtMHsVfI=;
        b=CvAgzI5PTI+Fb9y0PhSxV3zRCu749+La2+ZbVCyR5OjNTPLaJ/t8m/Qn878cHvUO9P
         TnMr2kUITXhc7zFQPam+nJrdyY7aN7mmZgSAeJIblL2OQL1wbghlQaSM3T5UdIkUL/bi
         lWqE92uucF75PCHO7UKcsiYPVFfptJBc/7nBaQBJxtkrObGQyjTmWVc9MpIsda/FesqB
         ku3vhF6+qebx6pxUfL+lPqEsNnbDu2gt7Scq4eU0KnwBlTIiE2u6Uch6FBUXoXpudUrG
         Sz6dbAoz1trp6W1RCU3SBWSapUBtxXivj9rm/C83gEmMncaYGVyU/NG+i4uRtf4s0XFh
         Y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658841; x=1787263641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdj1VPsCLSMdSAO15ZyEARW2To6jf4TLj09ZtMHsVfI=;
        b=nTjB0nuMLoZYL+Vqsiy3j+JYfnyBUpJBXk6C/X5eS2MLazT6/45SpLZlkXj1KYao/W
         osAhYzyFgX4/xxq5m0PMF7goQot6HORO+L5D6ITJ2V7jhBgsQRL1+1ouma7wD0Or/Cbk
         lwpAKXu7YOGRZOddBuLw2vUqndGFq51efKOJ+157Jh27Sq+Ygv69u2+jIFy7WhD3ODdw
         2VmtugJxeWfH937RteWpZCDhCwA8noxwD5ap32CpWD9E2ZoqwGLXvCMIlOdgCoStuYn8
         4BCNkwzhWjzuvlGvXQCP5SbARBVwW4uZXCLBcNFdc8UotgoMwQHBy8xFcvyeGKvGTNcs
         Noiw==
X-Forwarded-Encrypted: i=1; AHgh+RrlO5ScfQC6h7wNhTfVflVVwis8I5r85ZPAGRps1VyB/IaSZ5YVYeuJ8bHkzao73kXMimop3IagD2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMFyMn4vTPNiOJRzvGlQ1Af/tFtj62+erjAQokTxvz2yY9m3R
	s0MVUw4+CzgQtKdYvrO8D7wyMdO4clgO6fZuIdM3i4xVSGdkkNYIt6T+u0kwq2dmSMw=
X-Gm-Gg: AR+sD12U9Pgv7mY4LFhPa+U+/9UukYBzAybcVk5nhQTIQ/XvNYDXI5nqT82GPSHe3Be
	KonamvLY2P+Su/EYwxmSV+dGFkP0MfJ8AUKeT24j1OQE0TZyVY3JmEAz+UrIYtI6g8WWr5yCw9N
	PFVPnurc7ev3uEbyHHQRY4MJCgze0ZfSsGvgS0mwrT95MVbA91SwxyqAWCXWM9EaAYOW+KBUDzg
	ry5Fn5bR8w1uuXojGDGjXTHZ3um8nhhI2rfHlX8VfyV8YRVwY3RzkQKiBN2TLtT64pxxs765e6q
	QimJlFWDRv084d5Ircno6qb8ytOwDeTAEP1ASNizPwQIXyETiIwV4iN67Q+kRcBerTxiYXNQOw1
	f6XBJwmaJ6nF67ZA7bjsrWyRXQ6lYD6aI/iA2cbrOYaZiqByigTKIG9nUnUb1dNu6aQ0vOx4JYs
	/rFSqrW1xX1uKEJ0ZTGXKF2NFI0JvxtByK8EmCcLqPd006YBOGppq2bJl3AysRU/vOtcuc5ryD/
	v4=
X-Received: by 2002:a05:620a:6884:b0:936:6c8a:f7aa with SMTP id af79cd13be357-936d1fddbfamr124328085a.4.1786658841069;
        Thu, 13 Aug 2026 15:07:21 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce22e990sm86776985a.38.2026.08.13.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:07:20 -0700 (PDT)
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
Subject: [PATCH 0/2] PCI: of: update endpoint ranges dynamically
Date: Thu, 13 Aug 2026 17:07:14 -0500
Message-ID: <20260813220717.1394644-1-elder@riscstar.com>
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
enabled.  The first patch separates the code that dynamically builds
the property value into a helper function, and the second arranges for
even statically-defined devicetree nodes to have the "ranges" property
updated.

					-Alex

Note: this series is built upon these patches:
  https://lore.kernel.org/lkml/20260812172247.276554-5-elder@riscstar.com/

Alex Elder (2):
  PCI: of: introduce of_pci_build_prop_ranges()
  PCI: of: introduce of_pci_update_endpoint_node_ranges()

 drivers/pci/of.c          |  59 ++++++++++++++---
 drivers/pci/of_property.c | 129 +++++++++++++++++++++++++-------------
 drivers/pci/pci.h         |   1 +
 3 files changed, 139 insertions(+), 50 deletions(-)


base-commit: cb0a459e8259a695f4c2d179534b931399e6847f
-- 
2.53.0

