Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C963C457D
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243135; cv=none; b=B+9amgnsCH6sQ+R/hiPwkWXoYvgZFpYTUcK9pjpIo2e2w2tu53gB0wlBd0LpS3JbxE9XiEapTQP7dHOZCJ8PMwj17tG+ApInJ3shoJOJ5pzt0cfl5uYY4zzZNAhN76v32+agw7xwkUgKKZYYqs83FZs0Q//C1AbYx8a2Cy12haY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243135; c=relaxed/simple;
	bh=XjCIt0KCuhMV6ueAwPxlgNW+xh//owQIPs0SDmY2sfk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tPm30Gy1kK6ex/u97BiSo8ZTJdLp3xqduPEJe143FA4R6v00BKS6Y66RAutq3lBl24UW34BeH1U+5x3CR/0Z4nlhFDLXUnaxWpWL14EzXHufZmRcRENB5rW8TyKjmZzAjHDTHgBJh7jTHHuA4NLvpZtTpzUfDhMojuuD/2BJiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=BY9uy8vl; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="BY9uy8vl"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80a123ef90aso21293707b3.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784243132; x=1784847932; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oK6R8pSf4q5klrNu6IUKUSP5IXczJYV+oguJ7eE6+Dk=;
        b=BY9uy8vllM0UE12i7YclTsjPodApYYod0TqiS3gste2okK/qRmsUIwMIg1cFGqdpez
         i+t9GkAXw01I6dUsrPlcUDW+0JEVVSEzNa9EhZ6qXU9g+Gjrc8ddtxBBSgOWbaEOLIHK
         PaeDy6ZP7LaShIzGbXscAmlyXCN6/ZEuWr851m5PnlX7yp8aMqwGTXCLmQwIiLG/S0dl
         BIrLMkZ/lE5B+7NWIvO/tpKpdYzZ/wdu+L2YMcIy7LM7Z8Ir2K8j/JbPUuqKDTSvxc0R
         T3uisZsLxpZfzoEy18rQeijoWtLzvVTVKABC74ip3Mn7hynJ9slvyGeHOXDkd4/MAxT4
         FiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784243132; x=1784847932;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oK6R8pSf4q5klrNu6IUKUSP5IXczJYV+oguJ7eE6+Dk=;
        b=oQGEEL18UMcYM7tLNPjfcUiw+ik2O3ABQ9GXL0zyIhRVy9zF9kjBTRCYYb8P64KE34
         aTMKpPqo4o3Sa9jEWcpKWGsIfG/yyuLHlyekIJqzFlBE0+eO3mPhBqONmaMt8LvFfARD
         ZX+jqhCq3p54RVIH1mF1LTPJ+L44t/7Ec5NEvt+Ms68MsrtRfMRCfPCpgfSJm9y/AaQj
         oknR5t+0V3NEDId9ctm8qURiaj7FnMKmGkFPg5A9ntrzlHuy7sCdhKSdMPXuvAvZwHJ+
         elCWYH123nU8c20lGnUnZNuLDAfzIm3pYZtR/g11/C/DhRMn/elAoemG26HLm/MU+bJt
         wIDw==
X-Gm-Message-State: AOJu0Yy7cfmNhKQm0lre84VKXnPL1GbwsV0YdFittVHCws42lbeAVkGp
	xcIoTf9kUcvwUy8HpVzIkBSspcZl36lSgAVmI8RvPrW+wvof3OeegYMim3VWiK0AG3g=
X-Gm-Gg: AfdE7ckXwJFMu0D4ME87343HSovym5yk04S7a/qKogcKBkK3ygJLMDd2bjHYSlSPX0i
	ydZK57rlYwUu0O6d6n95joxr7I9bGOLN/7pXFngU6HWW5+lMTXZKK22SUsMXTufXwQ2/jbEBzgC
	bHx3cQN/cj1UFI77pZPqlz1owsnguc0iiGryaYGfoen0L1aXvrKzLFUlfyOpj5OPbNTEF0lAh30
	+cuZeFmAVsEHZj8V7wMtkzVQcX7CKbwPTtrbZOYTA0IpkGZrjaMfAejVdUNGpl9UYOkE1lqfmD+
	QMMWdSlkz6ADWb7KAr61ln9V/35XtkgaltQtYFqkJYWMhWZRoky7RmNJTMNBJcdTumRJ80BAcEL
	mLlLoZrmAlw3G8PDySbHPt4vdYNGcPvBqVGlRjZq1YuftzeBO50SEP9Ur3LPfgDL/B1/aSEgn/F
	dFPuE9J8kmPAaLGBksoCkyTyhV6NQwoujt+sEEKK8mn23q/glRpWHPSRY51g==
X-Received: by 2002:a05:690c:289:b0:7dc:1c56:2901 with SMTP id 00721157ae682-81ee27da32dmr27774457b3.1.1784243132428;
        Thu, 16 Jul 2026 16:05:32 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:40df:d071:3a06:1c14])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be90499sm207006837b3.5.2026.07.16.16.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:05:32 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH v2 0/2] Enable WiFi on Spacemit K3 Pico ITX
Date: Thu, 16 Jul 2026 18:05:09 -0500
Message-Id: <20260716-rtw89-spacemit-k3-v2-0-392b577ebf75@oss.tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKVjWWoC/32OQQ6CMBBFr0K6dkhLAxVX3sOwoHWUamyxU1BDu
 LsFTdy5fJP/35+JEQaLxHbZxAKOlqx3CYpNxkzXujOCPSZmBS8qrkQJIT62NVDfGrzZCFcJrVS
 mVkpoaSRLvT7gyT5X56H5MA36giYuom8i4H1IY/EX6yxFH17rJ6NYrv9GRwEcsFRKm0oqXum9J
 8ojukUS0MXc+Btr5nl+Az91dJ7jAAAA
X-Change-ID: 20260715-rtw89-spacemit-k3-a37c9771b3c3
To: Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-wireless@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

The Spacemit K3 Pico ITX has a RTL8852BE Wifi card attached via PCIe.
The probe for the rtw89 driver currently fails because driver tries to
allocate a kernel page with GFP_DMA32, and this board has memory only
above the 32 bit range. The rtw89 driver has the ability to use 36 bit
DMA addresses, but this is only enabled for certain PCIe bridge/rootport
that have been validated to work on. Enable this ability for the PCIe
root port. A similar patch seems to exist in the vendor kernel tree.

To test this, you'll need the 3 patch series adding the K3 PCIe RC
Driver[1], K3 PCIe Phy[2] and K3 PCIe DTS[3].

I've dropped the dependency on [1] from v1 and added the PCI IDs to
pci_ids.h here directly. Inochi's PCIe RC series will now use the PCI
IDs added by this series.

One question I had was about whether the IOMMU on the K3 could be used
to do DMA mappings and allow the wifi card to work with a 32 bit virtual
address. The K3's IOMMU isn't supported currently in the kernel DT. It
seems to not be enabled in the vendor kernel too. Even if the IOMMU was
enabled, I'm not sure if it would help with this exact problem. The fix
proposed in this patch works to solve this problem, so I've sent it to
the list.

[1] https://lore.kernel.org/spacemit/20260709040027.958400-1-inochiama@gmail.com/
[2] https://lore.kernel.org/spacemit/20260703021024.495433-1-inochiama@gmail.com/
[3] https://lore.kernel.org/spacemit/20260709040415.977784-1-inochiama@gmail.com/ 

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Changes in v2:
- Updated Patch 1's commit with reason for where the PCI IDs will be used
- Dropped the hard dependency on Inochi's PCIe RC series and add the PCI ids in this patch directly 
- Added Acked by from Bjorn and Ping-Ke, Tested by from Aurelien
- Link to v1: https://patch.msgid.link/20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com

---
Anirudh Srinivasan (2):
      PCI: Move Spacemit vendor and device IDs to linux/pci_ids.h
      wifi: rtw89: pci: enable 36-bit DMA on spacemit K3

 drivers/net/wireless/realtek/rtw89/pci.c      | 4 ++++
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 3 ---
 include/linux/pci_ids.h                       | 4 ++++
 3 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260715-rtw89-spacemit-k3-a37c9771b3c3

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

