Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2249DB89
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529574; cv=none; b=UQgJV9talQ2p0tNIYSZXDnwdjS+nCzzBmVAL4dOYQXfQAnQBCOt3oGJSrI5q9JOsplOuF3kg0qv5Yuxf2wXMoGvMNdVpYHdCKgi766fPcHOt6N3TwQhZtkLRwr/gwN5f5m6Q45ss8PuRRp5ELxBPEi2/5dOJQDRvb+g4rVGyUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529574; c=relaxed/simple;
	bh=aRDNjiBSJdp4KAleprd2J6YFWETwk979Dw1PDfikz60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGbeIvUMbJ0p1t8JvYeojighyQ7I7zZKNH7Bm806DS66bbSdWHiAA+1OIG8UOAUE6M949TGfG8B98u1I3v4aYgkGsLIyaP4BMowx0+gOOFPWIrb99I0TERA7hSJG+Rfwk2NuTEPuGGyOlpO+NSL4ee3HOJ7WtYx4ZvvxiNFGmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=rMQxXj08; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="rMQxXj08"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5303557a6dbso12301641cf.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788529571; x=1789134371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nmxDfVgaXo0zCFfrt0BitM9JEDcb53UQDgVMwH70Kbw=;
        b=rMQxXj08jg3hHocTg2zWYmb3Pa+qjmobqsM6QC48oHWSAjcejnMrxXWdntOgXHUQa3
         65/q9rY5jsxxTx/afd4EWfXK3RDyl85kl9SNhNMauYA89NfRP90nx1XzMwmmcxHY2w4E
         eAObqArLBbjoihptgivUBOXEvBqI/mIAAhhd3omyOOzWogYYlfvk8DAU1CdS4A9MLlNO
         s3coR78DIY0nK09tIOTn1YCEz1ViWEzJX/ANguW6L6sgUXq1hCPTVsAWbNUbq3+2b9tW
         +/JAAG+QZuRTl5DjN/8k57E0+qXhY95KpJ72Fnh1IB7w+n8ltb2JV++/aDIUETHXGSVo
         b7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529571; x=1789134371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmxDfVgaXo0zCFfrt0BitM9JEDcb53UQDgVMwH70Kbw=;
        b=YVATezqCxM402E/YRili2lh8s7tOMyL620rjhJ7sZw2J3JFkvWTp5LyOKalalIzWwR
         YPlRZpNWfZ/h41CMOd2acu4wRIB2fREzSxP/oz9sq5ADU/7MNwsfDgnlnPFIWRthk3D4
         562f+srX4EEB25AzpQ1Xr8y0/szjtKQYwBfm95kE6VsY4VrC6HVFfMcRwL6SXvOq+/kk
         nfKM0Kk7vBAjQwHjgl3bAocuCbVD7BmtKOJfJ6swlyj1XmxbrBW16X4uUBLEmjDG+5yk
         rYebcKohmNJ9M1q2VP6yBPfJDbsegMPSnE7n9qd7XR8JgxDbJdq18x+52oFxBvU+4EsH
         TKwA==
X-Forwarded-Encrypted: i=1; AKwUvBxGs3lqvKrh1bNeVVjOL84z+TjnWdHRAy/Fx48QEX7HVmVDyTmpcp0d9O3UEdJGuaAAkMe/lt5EOTM=@vger.kernel.org
X-Gm-Message-State: AFuF++nbJvgEyWPBLqw4W7ZVhetkYKPBxH+afhlu83bfuZRfdYVTMsze
	mGFd52YAcDP1e6JppHx45NEjh+ZXW8/BVFIB6nMcCBFX15Z4biUCvJ/KTzrd9vWFoaY=
X-Gm-Gg: AYBFou1PGIiHIIQiKfGYD2XIJQaDEGb3f8b69o95rImzIfImVzQbRtBAEw3j7G54Qpd
	S/Na79gUhlM6MWuco9UksPhzAScA0b3cuRoSNfqIXbiaETqI8b1LHt1ijynxA1B8Z39WT2CpzlL
	ycEslWeT4jK+hrW+KXF0zF0N9Wba+6hhM5WlEEsGveKEObgcrfeqEryIm2KYShJCNtChfrR722I
	lfjQBgtZ9hwnp/ADkXvBgtxHBUkEXI6frJ1dx7QPohPwWuFOoUv5uyCIQ6Nk3/HuHwAsqBbX//L
	PXf6/M2sz5U85R+TDjtfQtfLQIhmszm0n5b3+QuzX0IkGnj1//tvMvBJ3ZFyerxWMvy9xmCaJ3Z
	DrV21n6ll2iqmuyaoWmUYZgQFmmmMz3bt10RATtjGPxKmlAyVpmdAne3dFdNi89bPjh5nYlk4ec
	3nkklLnxFZfWe5hA21F9QRbhnfccV7b9PZLxhwdlEGyzBYrbx7iVmu8NwT/SX2G3murKx8dOIb/
	AE=
X-Received: by 2002:a05:620a:8017:b0:939:6ec8:6928 with SMTP id af79cd13be357-9398037ac44mr597251885a.16.1788529570935;
        Fri, 04 Sep 2026 06:46:10 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafc3a7sm211613885a.14.2026.09.04.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:46:10 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] PCI: of: warn on bogus device_type property
Date: Fri,  4 Sep 2026 08:46:02 -0500
Message-ID: <20260904134607.1856121-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check when adding a PCI device to ensure the device_type
property is (or is not) correctly defined when the device has
a non-null devicetree node pointer.

PCI has a well-defined bus and device discovery process.  The
PCI_DYNAMIC_OF_NODES Kconfig option allows PCI devices to *also*
have a devicetree node.  This enables certain things that are
not possible with PCI enumeration alone.

While working on a Qualcomm platform, I learned that some PCI
endpoint nodes were defined with device_type = "pci" properties.
Herve Codina pointed out that this was not correct.  Rob Herring
indicated that people seem to have trouble getting the PCI
devicetree nodes right, and asked whether we could warn if this
particular problem occurred.  During review, Herve Codina also
suggested that bridge nodes be checked to ensure they *do*
have the proper device_type property, and later, Sashiko suggested
that "pciex" (and "cardbus") also be accepted as valid bridge
device_type property values.

This series implements these checks.  A new patch in this version
removes a (now duplicate) warning issued by the devicetree code.
The last patch that was included in v3 of the series is now gone,
after Herve pointed out it the message it removed was not in fact
redundant.

The first patch prevents a possible null pointer dereference that
Sashiko pointed out some time back.  The next two patches are simple
cleanups.  The last adds the new PCI devicetree node checks and
warnings.

					-Alex

Between version 3 and version 4:
- Insert a first patch that fixes a Sashiko-reported issue
- Drop the final "duplicate warning" patch from v3
- Include "pciex" as a valid PCI bridge device_type property value
- Add Herve's Reviewed-by tag on the last patch

Version 3 is available here:
  https://lore.kernel.org/lkml/20260901011338.1323243-1-elder@riscstar.com/

Between version 2 and version 3:
- Drop a patch that made a change only needed by a different series
- Switch a function header to use kernel-doc format
- Add a warning if a PCI bridge node has no device_type property
- Added a patch to remove a duplicate warning in the devicetree code

Version 2 is available here:
  https://lore.kernel.org/lkml/20260812172247.276554-1-elder@riscstar.com/

Between version 1 and version 2:
- Check the PCI devicetree node even when PCI_DYNAMIC_OF_NODES is
  not enabled

Version 1 is available here:
  https://lore.kernel.org/lkml/20260807194100.455599-1-elder@riscstar.com/

Alex Elder (4):
  PCI: of: avoid allocations in of_pci_prop_compatible()
  PCI: of: drop the reg_num argument to of_pci_set_address()
  PCI: of: don't zero flags in of_pci_get_addr_flags()
  PCI: of: introduce of_pci_verify_node()

 drivers/pci/bus.c         |  1 +
 drivers/pci/of.c          | 32 ++++++++++++++++++++++++++++
 drivers/pci/of_property.c | 45 ++++++++++++++++++++++-----------------
 drivers/pci/pci.h         |  3 +++
 4 files changed, 62 insertions(+), 19 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

