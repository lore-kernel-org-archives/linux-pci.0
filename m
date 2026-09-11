Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B143415B7E
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169755; cv=none; b=RrGN3tvb84L9Y0YV6f7BXLvtAHOdauZyL1pX8/7kj+T19QXer185/89LPPAbNWp4OTXPPaJfdwan6lA7tqBOdxm7RdM08OrRrd2Ae1HiwJED2v5DusRgFyUGWe1lQ111iTiG3GuuTjWlKW4ucjnuhDwgJRoLd7a8568J5S69TIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169755; c=relaxed/simple;
	bh=6vGIDcmhazuSg6c294X5jHvcuYI0emXRsQHd63WgHcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suqUQwNs+yyORamZXPw04TgILdsewLpJ51l0TOvpAsQmiA6bETRNMM2n0Yln/Fu7cmHQohR1PMcpEGC4B48boDCjT6hLVJenJaBLJrdRaRrZr3IccZC3JE2gMeEGkNJDf6AybWkzwC9nZbgx3eOmYtyFlq8+vKANmcV+kg7AZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BjoZKq+Y; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BjoZKq+Y"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1662270a91.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169753; x=1789774553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rotk05yu0Xd3HMjEskHty3X9+grsIXwKqieBRwiJJGY=;
        b=NMQmFIrXpBH1qsRgbeqZ10wkztusFcFYfRvvpw2uCNYWzyan0P4FhkKCkj43HbrJCN
         PHaSSY3OSqC6J6hNKHU2wBdIYUGNcDjKVQMcGDgdCNN9eRDTuKo2q1Bxyv3ToiiEQ3ep
         /9Ex2oRDIpgYxqtJqkRxgEVgRDHKjhCQ8FmIGIR9D8QHJgvzhksWQlgdSa7fHT05cIvi
         DKP9LHC27o2g1JapxNv2F/fxeethAh3rEfzOpQqTD+3lEo6zHkFTMSPLSu0ftcuGnkLC
         AXB9x8LutN3LvUPtnUpgb2Cz1nGfQJ1HlwScoVepqeyepciUtNbtMWi3grdWGs59W+E2
         9m1A==
X-Gm-Message-State: AFuF++mESqj/e/3tuJ/TfjXf4CuGbEnX3I6nKu4dICZPlS+6n4XPAKwR
	rbvIOYgMjV3Wkx6QqoAlNxht9H58/+e8nQRiZw2gv84acbmx9IZ7q1L2KD5qclPbGvpMDdGbPzp
	SIsD/wBvN8gdXMFre6TS0dM4/ZyD0p9p5uxOUMEtt7sOwsNCETHE3MApcJ67V3ZsD/QNQqjd9VO
	9t8P49YNKv3uu7dKke59QZ0zmNq9sz4aNVEYA7OGZ7iCxcrBF6cr4y8LLdiF7Sx10pZ5VIILg4s
	4lwTkj9FSAe+uxt
X-Gm-Gg: AYBFou3FCu3LKHiL53OqKxVMRocbBgL1ctWoy46PmzQudCz1RQfo//SvvlZr2Hc2WDm
	I9j+R1RPwS2WdPzWNFDNaDNWhiu9PjJhX/RiRV0z8dPV0V1LxlBgzg9R+3NucWDjZTOLeu1LR0p
	X6ydzUT9jPQ0EQtWHt+Fz16GRbaPMFQ/81fq/Gil10DN9HcPxC5NiWWLPP5v+Yn9/4yjvwJ/SLj
	6g6F9Eqqcy7U3qUs4KsBFGh2gGTpDerP3qGCW0ALrFQ8m+tGrSURvlp3q7/Vrw/htY7WjXMYtsJ
	ZFFX3zuienN3POAxrPk/ZoCebaM7rU/A+d90YNTBxLnqKbdsKlnIQ+gxmGBIhO3MkC0oXlSjoEd
	lKpRQfBkk0i6t03WV3pEAEdUXr4ie3KTmjVPdEAFvUy0oHnDqJZxIQ4eqlRzi
X-Received: by 2002:a17:90b:4c4e:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-39d9805da27mr6006144a91.9.1789169753285;
        Fri, 11 Sep 2026 16:35:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39d98a53288sm2135180a91.2.2026.09.11.16.35.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9105be46009so31513026d6.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169752; x=1789774552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rotk05yu0Xd3HMjEskHty3X9+grsIXwKqieBRwiJJGY=;
        b=BjoZKq+YWIv4uX3wPRuEWD542YvWgrjfPkfjjE9FaPMlFMQQ7qscRD5kviclTVKKFq
         43uPeMf5Em4574Hu6C5PAVh5U4nr4zT22y2qBOUwEmaLmjB5fvNeqQGAQAZT1650E50O
         LB+gBtvccApO7TuCN6+TN8Ml/E2u2j3pODBFg=
X-Received: by 2002:a05:6214:40e:b0:910:6686:1542 with SMTP id 6a1803df08f44-9120289fbdfmr146244406d6.8.1789169751731;
        Fri, 11 Sep 2026 16:35:51 -0700 (PDT)
X-Received: by 2002:a05:6214:40e:b0:910:6686:1542 with SMTP id 6a1803df08f44-9120289fbdfmr146240876d6.8.1789169746357;
        Fri, 11 Sep 2026 16:35:46 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:45 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	Rob Herring <robh@kernel.org>
Subject: [PATCH 00/13] PCI: brcmstb: Stop using chip numbers for conditions
Date: Fri, 11 Sep 2026 19:35:25 -0400
Message-Id: <20260911233541.1650895-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Much of the brcmstb PCIe driver code does (essentially) this:

        if (pcie->chip == 0x1234 || pcie->chip == 0x5678) {
                /* ... */
        }

when it should instead do this:

        if (behavior_xyz(pcie)) {
                /* ... */
        }

This series does the above.  In addition, some other minor improvements are
added in the hopes of making the code more readable.

Jim Quinlan (13):
  PCI: brcmstb: Remove redundant const specifier for struct fields
  PCI: brcmstb: Use flags u32 instead of bools
  PCI: brcmstb: Add Broadcom quirks macro
  PCI: brcmstb: Declare and assign quirk OB_WIN_32BIT_ADDR
  PCI: brcmstb: Declare and assign quirk OB_WIN_MAXSZ_128MB
  PCI: brcmstb: Declare and assign flag IS_BMIPS
  PCI: brcmstb: Declare and assign quirk 32BIT_PCI_OPS
  PCI: brcmstb: Declare and assign quirk NO_RGR1_TIMER
  PCI: brcmstb: Declare and assign quirk EARLY_PERST_ASSERT
  PCI: brcmstb: Declare and assign quirk PERST_PCIE_REV_CUTOFF
  PCI: brcmstb: Put max_burst_size setting in cfg_data
  PCI: brcmstb: Use order-0 indexing for inbound BAR window array
  PCI: brcmstb: Split up complicated function into two variants

 drivers/pci/controller/pcie-brcmstb.c | 267 +++++++++++++++-----------
 1 file changed, 158 insertions(+), 109 deletions(-)


base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
-- 
2.34.1

