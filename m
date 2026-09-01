Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798F38A700
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225227; cv=none; b=M6QF2T5xlLFPwaY5/kU08c7yh3gRXu8UVMlgJ6NpV5RHLAGZ1Wc6lX4Y33GAtgsYBzWw6xyuF1f7RTL2y3zg4pVQfjB0ER4NvWnq65onqw5l9mAaAmH3Uxd42jiWz0kcZVY1O2PFqcwjTsGBkfFYl5b/U8c0R53JfVo63xu3x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225227; c=relaxed/simple;
	bh=rs+2fZVV9ByQL5i9/TtHRqWXsvk9leqFzUUrmK2TuU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6UkoFGHqqxo2+mLE2TMB/Bk8j65BMH04iWTQogIp18yxfJQHMWA9QmwGAxHkclaFK39P/w3Maf7QjfGfMjlvh8+xHb/aCx1fHyytYBBlpoyjmueuozUnhJFK43Rh1+CRFKT9hKo3lGJDf+iVLXM2n2k84KsmCcQi0sxI2M9yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=EfLBL45G; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="EfLBL45G"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e99ef0902so292506985a.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788225223; x=1788830023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytwfszyKfXhVAWFRmhX54kcxCTfd0qMu7Y/FbiXLliw=;
        b=EfLBL45GmjdTAYcqOz/GNeYvVSxKU9JXcb+/wX9MUOh9uTYE8igUI+X1hiyBw7va6m
         sXBnxMZ4GN97tmE4xsovVgjqaWT/JjwoVdhw+RgilmUaPMYyYA+zEJUHyd8R7n8UVLzh
         oHlkOEK0NdB6rk6RyLBojQkS7NLAQX0iyydvBNBj3efhVEC6VJ7MU8to28aUeZee1YhV
         UxyOi0ipAfIsg4EGxCKWjy7Zt7/F6hP7EE6zxBvEr+FMCGdbSFmnbVayWyryiGrtHloq
         CrPY/jvzA4imegslAh4looudK5boCslF8elksK3opzT6po6Bs9y85XPcLxIMm3NS9QPv
         exyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788225223; x=1788830023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytwfszyKfXhVAWFRmhX54kcxCTfd0qMu7Y/FbiXLliw=;
        b=sKw298sDVqd4oZrBbCRfVJt3LPF43V1qZ07qs80V0TqskfqcmD8OuoPYtQYQK0lbWs
         YlpH1EF4Ra/7Hn22wrRII2gaT/DmtMr+COmLKtoNhNw75iD2Y5frn5n4KurWn2Cww5YY
         YmwOWXWOhMF+Qv8z0cKiiwtUDVX/fj3fcFxbTkYHSSYK3KHbI7SP6T9ZDlNUnsC3aczZ
         Z7pnC4vXeJ61jLYGp8pk2inDDJCHwZ48R0mpXZX2tNxWLPXi4I5sppkQSqfEGZF+KSc7
         Q2IamMDUTwpXd7jTzmKcwl4quoKiEOLleXeP467kuiBfKhfILH0C0VTBl922JigU4Sju
         BQYg==
X-Forwarded-Encrypted: i=1; AHgh+RqkHffc7LvHCUY10T77RcJgy1r8qahOve/Xany/IG3nn+Csyu8uwHBbjO0tBzO80LbpZ8Ou+hKXW3s=@vger.kernel.org
X-Gm-Message-State: AFuF++nfsgrZYxMcrNA9a5AVUJ0VRE/KW0b4fmWl/TbLUb37/6K/NSq+
	2WfIas9zdEj1+F0wNs2YUDOL7a0ybfawM2TYfDA2R4GK1Gk01kH33IQv5qLuaJqptcA=
X-Gm-Gg: AR+sD10FYNN6RznaJRC/2ODH605JetkitZ3u1qsU/iIfmBWKLt096q50/ArdXKqvLxq
	rNY7tuxOce53QpuxlfP3hU1hx5RO64CRVaIbT5eW8wrxvUI+ZxJfpLwnBNgih8IlqJqchmHkEQp
	1bpgig18h0v2uv955ESdlToOPk9eDVtPZC9dbOqQGwk6xc2UBldE0DQvfaU+DNBcXNFr/LYlOSf
	CPDopl9bFJBUI5/XD/sGoagdSbMa7VELiQIhcD8WTVH+cWa2ZW7jYv74scS4voHsnZaPFgFiGGR
	8nE6yJe9yvuC6IyxlCKpzXQ1OerY9LI2d4VlDHplup/pN6ag9lh1btzYwisxoBzX9V2ZDrKCsJA
	DZqAVfCdfK+nq47C5/0UiEJtTO1rCRpTHZGu3+hEO/dGDKkItV7l04G/MAe0dP6jc89p3J3uKpU
	6hqmOPgDB/U3Zw8gqzGJ18fs3V7/N1BpsAw4jv4tDPfNzFGZ6g9jej/PCL9MevrsyF
X-Received: by 2002:a05:620a:3908:b0:939:28ab:e90 with SMTP id af79cd13be357-93947d428b6mr670912185a.0.1788225223270;
        Mon, 31 Aug 2026 18:13:43 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740a307sm581347285a.42.2026.08.31.18.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:13:42 -0700 (PDT)
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
Subject: [PATCH v3 0/4] PCI: of: warn on bogus device_type property
Date: Mon, 31 Aug 2026 20:13:33 -0500
Message-ID: <20260901011338.1323243-1-elder@riscstar.com>
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
have the proper device_type property.

This series implements these checks.  A new patch in this version
removes a (now duplicate) warning issued by the devicetree code.

The first two patches are simple cleanups.  The third adds the new
PCI devicetree node checks and warnings, and the last removes the
duplicate warning message.

					-Alex

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
  PCI: of: drop the reg_num argument to of_pci_set_address()
  PCI: of: don't zero flags in of_pci_get_addr_flags()
  PCI: of: introduce of_pci_verify_node()
  of: address: kill of_node_is_pcie()

 drivers/of/address.c      | 12 +-----------
 drivers/pci/bus.c         |  1 +
 drivers/pci/of.c          | 31 +++++++++++++++++++++++++++++++
 drivers/pci/of_property.c | 14 ++++++--------
 drivers/pci/pci.h         |  3 +++
 5 files changed, 42 insertions(+), 19 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

