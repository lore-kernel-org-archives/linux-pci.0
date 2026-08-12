Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2909470E8F
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555375; cv=none; b=dzn7wOJjVXTGUv8ujFQ5+jzkd1NzoRKDionNhlADbO1CZJEyNm/0hFkzc/8nGHwasb5ZTqEnSiIti5ev1DX5RZDHlCO2BQSKzB15a8G0BbpaS8VW2JUenyg2YOkLQ3BUl2yGZS3f9D8tGu9nNFMAytH0svCQ2+jgUBcUwMPCpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555375; c=relaxed/simple;
	bh=xfBluy7Chl/vLJhCzywHuDMFmQp+P0Rb+La08jMwq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlR4qLEbF7TbbjYT+q1laY1JWKZUib550gGVs7eEtVe0raRnbDJfTA/n5SfnWgew6hWB/Ms8t9zNXM83MXogmdeKmODB2saem4dKrDtxk8GVLjGWDtw8VmZLiqKPDBdIkpSV0Ssa1fsMA0G4LiyMabtfH7GxaSg6KDQ4eEg0sSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=q7ons0fd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="q7ons0fd"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-934944f2d22so88255385a.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786555372; x=1787160172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B05U0xMoca4JG8dTYzovZSbd79SZOJKbHErof79XjFA=;
        b=q7ons0fdPFJ7QhEZ5neGMVNUJUTI0NWwzBAqntwdeLedJakPVJJbG/KAdOcKWdcPZr
         XHycFLju3EJeqyk9GRmZwfWrPX1wIz0Wo4biDPGi+28sN3bkQGkRkaNdJCN+REVegK2Q
         OzPWcwppUo38VcrFTCpgZHbcukNuH7dM5xA4pp8QajK+6c3yHicCjP34txf4Zt17GUn/
         40nuXs4qeFMYpkdnTpiamRdjqZKfbTAZt/Pw5CDzZF7HhzqmoGKLcbQy5XLmQm1Chk4k
         tujC/aPtAqdxWS+zd4jzR2hYnGy6NIzCDPZOeX83grkgTzSGqBxOucowc1rYIqcB4Fgd
         j9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786555372; x=1787160172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B05U0xMoca4JG8dTYzovZSbd79SZOJKbHErof79XjFA=;
        b=FtBsKxY3T1mauJXRX8DGPgEA71FP0XwexeVPUZiHGXR9M+oWu3d+gwOl8dOrAcVvXi
         2GGy6VjN2Xs1iMqL2nlj3ReKpzfYWKVjQslnYUnbRC+rAk4X9CyZUAWE7HXt5bhBdeKz
         5HmjqtNdjKpQJ4ZwRX6UyLRXx6G3da2eM3WGy3l1hCj0qW9WRlFfpCNJrlY3+3YZ5lsl
         WpO0rK2IceUo3EVoFz7EiQXxOBuDgmzutvzRjBeSXX1t+8mcLAmIrsbe45MUOzSQoKGA
         qUHyTU+d01WopeWLtkLXO6wg51y2+GNwly5rLmvLHDfvqZ5Qao9tTwHAKhYjwDr6qNSM
         IS1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrHfHrvKp22kW9TCnkRqMIQ5iRSe6IDJqeUIYpJZzdiqmiCIwOH7EcM132KSrRrEIKjfh2WhjGydvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWEFzewwXN4TsKv8Fvz5tiYWIbOfr60cDKD3ccaULnReK+x6Y
	qTS99LPo4L02zh2OChMqksxr+imEqtA0PBAEsnOuHf1CS0dKF3CtgXk4yfkFHjMtdgMDRylEiC4
	HuwsNtg8=
X-Gm-Gg: AR+sD11MczrS2IK2UawE8o5/sQRgX0yt+3PTJkiGZo3vBYs/r5zDLqVDxJzLekS4PdJ
	XecCdX3GgaamF4RgTwaiNqlBnGdGNH5mB5bCodXaWZn+tmsL5DJsHW9aRjaQluGc4JZl7czuPLp
	9BXPmzUpJdT/fS1bJe/f9P925pJ1SSErHkk3meAJYTtedKegdG77sSnijqoAsZPiqpKe3zt3y1K
	fDBGWjj2mqMhuezzwP/nrqPVqlvVBlh6Rd4mxFBohNuINoIYpHKS8YRlVZygvp/IiprIpNLUdQk
	s73ydBpA27rrkVEmTAuzCQm+EItU+uCDrs1avkhXI/G8kiqEmEnoRUOUYTpZK22bR/eVC+gU7BE
	xo+2KZhQqQXQ7auGJyV4PwKpwvH7TyElop7v0SdsWvbzHhNs2sPqwAAWRSJoWPO4Ft2fQY0AVYx
	mEOaviRJGJ4fq+0TAZkK20t/L2M80o9VEm+uigGlkeh8KuP6h/kiJluYF3+kpy58RP
X-Received: by 2002:a05:620a:1a17:b0:92e:59b0:df08 with SMTP id af79cd13be357-936b3a20e6emr569522885a.3.1786555372598;
        Wed, 12 Aug 2026 10:22:52 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f720eesm173587685a.47.2026.08.12.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:22:52 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: of: warn on bogus device_type property
Date: Wed, 12 Aug 2026 12:22:43 -0500
Message-ID: <20260812172247.276554-1-elder@riscstar.com>
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
some related code.  This is the only changed patch since v1.

					-Alex

Between version 1 and version 2:
- Check the PCI devicetree node even when PCI_DYNAMIC_OF_NODES is
  not enabled

Version 1 is available here:
  https://lore.kernel.org/lkml/20260807194100.455599-1-elder@riscstar.com/

Alex Elder (4):
  PCI: of: drop the reg_num argument to of_pci_set_address()
  PCI: of: don't zero flags in of_pci_get_addr_flags()
  PCI: of: make a flags argument optional
  PCI: of: introduce of_pci_verify_node()

 drivers/pci/bus.c         |  1 +
 drivers/pci/of.c          | 26 ++++++++++++++++++++++++++
 drivers/pci/of_property.c | 20 ++++++++++----------
 drivers/pci/pci.h         |  3 +++
 4 files changed, 40 insertions(+), 10 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.53.0

