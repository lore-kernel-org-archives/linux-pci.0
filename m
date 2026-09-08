Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918349890B
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903305; cv=none; b=NyTPcv+jL9yCxB+xa4NUhbD11YIYlsrjhKROnSLx9pJxVWx/jQ9T2eodfjdl5J70RxCVQKpyLuJO0TS+mKmy6n1Zdx71rfZZKBlD1ZXGifwWblmyvQJhzhj84p8N7Vy2Tw10yER94hsDy01zzIj6+0vofqstBuV0nb6CckQs9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903305; c=relaxed/simple;
	bh=SU1R4QKOuMLYjs4xMtC1UDxdDQxBPwW6jbYItMCVIlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nybPwXSv41debYYp1fx+BMIi8krrNCEfDirO51EoPa/hM/mSZQTqxiwdcp1lsTFnKXsRu8goIOArACqSjvFyKCwFxWn7WyKUFSjrNIuhFGFbxhzrs7DlRW1ZIyhSvem2PCF/drgpqi3COIWE+Qykjxsb8ZwJCuyTtMD+/VhkQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=N9SmWOYQ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="N9SmWOYQ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939c29c6616so45364585a.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788903303; x=1789508103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=29uwmA8S4hpFYYevpIh20NDUf1Fu5RH3fxGFGGFur6w=;
        b=N9SmWOYQeVvziz2qWF65nb4UFGbh/CKXZtN+tPhbzmW0r5dMTL1PWg78yZO2VaHu3Q
         GYEoiiRieLlDoB0r52P1Pwi2sxkMmmyK7eMuM2r6PEfXVRIvUqI7+SiiJeyCp7j8Y0K2
         hUBTHSny7BhlEzaRzuV5eBpb/Pt6JY47SLtkwGMtLKahEWwiqm9vAQhkUygE4CCEGcZd
         JhKVbDNmkLfuCHeYc6aHNEhFQino8OQSaWFzPQCz1iDtdj5Sd2sMZYdCPVx0fgIB2lhp
         VyRTziVQilbYJHZdaQHrESboHjAv7Ymth7cEoN17dxOPhg8mi/9+W6faaoSMA/WsginG
         pKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903303; x=1789508103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29uwmA8S4hpFYYevpIh20NDUf1Fu5RH3fxGFGGFur6w=;
        b=gIGbqhB2x8/s4RPzlHLIdGTK+E4XWZFh3/dB0v+p6uATX78me1NWPinOaGHTCVSZTF
         XDf3J46VCDteNoALGGt/QGFzdQJM/7S+maxy/PiRne2nqAvD4rII5pLUR1ZfkaO9T95i
         ysXPRtweowWiPXCoWaK4UrfMxUkwsyOlfFLeJDr1oFJoMrVxrLHgHZaHBga8dDRVDMIp
         It3rKy5HEGgt9eD0CRQDDbq36hA0PZDG9egMmTGk3Pa2Fq1CsqGRjkfh9XB8f5bqaV8K
         L7nDl6s2DytdxS+6pJbx6BrUO9JmXwo3E87nDd05iqvx+74uLYMLj9HGHco6EQ91/4DQ
         Dv6A==
X-Forwarded-Encrypted: i=1; AKwUvByWaMhB2E6W/k2FZ9c2UtapNPHn8G9R5mJfGHk+3gxi9FIMPEPcbBqVbrRleDNLwahxFuglKLbAyHo=@vger.kernel.org
X-Gm-Message-State: AFuF++n+JJy0DAvdEJOVrI7j+m/+tNYiCG3Tz0tros5AtkhNUCNYZNhT
	Jg30wNBemPtINhT5ibLlnnOOaHgelRDYl8uWfnmLH1iC36Yd0IMviD5ugp0JzUpUk2E=
X-Gm-Gg: AYBFou36rDBVPO/qr8SKI626Jpgygu4nMS3IbfbiSL8ZqbJpnw9lABEADw1Z7xJzrfL
	iG7s0xrg5aO6Cy7JXGXWkH8AvrejLFzvS6VVk5yMk/Ry59zwIjNrnR9w12JccPGIOrw40GFpPAi
	8+4YzqAJqnJKBV1VqAyFwazd6hOdRLuMmSWWl4Ob8PAEVXHck/A8fkul5sC21EfMQ6oGWueGMMO
	oIfdXivApaEvfE8HQOEripl4xXXMjA0kpN3x2FDgdL4VZGjPiPXivuLp9+zK9xmUL7O9UzpZEIm
	JnhO1kUHGoTG6uYT6QUGdVMDo9CyHfa5XAbBsiXFYc8jIY1D71+7MW97KcOk1lqUxF+uXHmh/Pc
	2kcuyBIf9XNTdZzN54G/vox4v9iLBgIkR4s44wGPTxXIEHrtIkBpNT12JzPRcn3Oxq5evSONDi3
	25P7ELVhxg6uv2jQHIJ93ANQzfxEGfioFPusD4l2840ZP/pzUS7WJTG9LaEHA88Q07
X-Received: by 2002:a05:620a:258d:b0:939:2c5c:7977 with SMTP id af79cd13be357-939c93fd11cmr302094885a.20.1788903302808;
        Tue, 08 Sep 2026 14:35:02 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1250497885a.4.2026.09.08.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:35:02 -0700 (PDT)
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
Subject: [PATCH v5 0/4] PCI: of: warn on bogus device_type property
Date: Tue,  8 Sep 2026 16:34:54 -0500
Message-ID: <20260908213459.2519059-1-elder@riscstar.com>
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

The first patch prevents a possible null pointer dereference that
Sashiko pointed out some time back.  This is the only patch that
has changed in this version.  (Last time I neglected to enable the
Kconfig option that ensured this go compiled, and it contained
two obvious compile errors.)

The second and third patches are simple cleanups.  The last adds
the new PCI devicetree node checks and warnings.

					-Alex

Between version 4 and version 5:
- Made a local variable (bufp) a pointer type in the first patch
- Eliminated an unused local variable (i) in the first patch

Version 4 is available here:
  https://lore.kernel.org/lkml/20260904134607.1856121-1-elder@riscstar.com/

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
 drivers/pci/of.c          | 32 ++++++++++++++++++++++++++
 drivers/pci/of_property.c | 47 ++++++++++++++++++++++-----------------
 drivers/pci/pci.h         |  3 +++
 4 files changed, 63 insertions(+), 20 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

