Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDF1C2324
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.183.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969497; cv=none; b=TEJUqDasZb0bbLGQ7XSR2PVqvWIO3TfAChFl27cEMjvd24feCmXhdMNwPY2AQtstpfS8E2d7kjWkQjYW0qrJnKhDYxympBbZWYHgMdlciJlPPKs1UQ75d+7tfPCU3APPV83tT7b8BTDJiLDtgZ6he8y8Qg8YCFc+AsYqio5Mzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969497; c=relaxed/simple;
	bh=LTGCTC54hdIZr1mBEC/sqjRyyfWeDcRkhFrHVPxz4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVA3DnsQ7N9NKHBe/cK5x9KX/Q+Pa7HQuXLptdTCrBc07Wjm7zELztVkCwC1DP4cevD66ZePWwZF78qscyi5eQEfGTlttR9UZ/4qZB5neTIP7qK7H02ZY+VujdDD65fbEhy0L7+cICnx7vOAmu21vAx0XWIEZemSVkgFMYbzCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YD4YQ0Ad; arc=none smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YD4YQ0Ad"
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692J7mKt3467515;
	Fri, 2 Oct 2026 19:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=p1; bh=T+b5Bnv++kA4uMPiW+niVnbe5CYZpvaoJc4K7n599m
	M=; b=YD4YQ0AdvBQOW/nuP+jI9TK08FZ8ROSWVucWAoUlrAFhjadKWuiH7Hajr1
	kAyFxrFWnx/GPH36y80GPhitiQN1nu4iHbnZWirlxgl3UCkIEG/yJBduUSbaMZ42
	N4Ju+w0d7JOfFiutvONEDWDV0nGjb8aarwy0E9oJDLHQHymh/BOXPr4ryK0n0YOz
	0f2VUuMLjK4SWBJ49Cp7bALGqkTTxh+n4XwOpdx2IhNGwvfPGjWcNclORs4S8rsG
	7unzLPceG9Q9fzM6xOey/ctjOC/+JOMsCGFfidk/WByLWRSwezbG4Z7VanyKrCjT
	7pn5UJrwOPMti9IrMSYWGdhRLqsA==
Received: from sgppsea02v.sg.gdce.sony.com.sg ([121.100.43.226])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4gx77h0g9k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 02 Oct 2026 19:31:19 +0000 (GMT)
Received: from pps.filterd (SGPPSEA02v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA02v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 692JA6Ub1656282;
	Fri, 2 Oct 2026 19:31:17 GMT
Received: from usculxsnt13v.am.sony.com ([146.215.230.187])
	by SGPPSEA02v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4gx74j0yaj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 19:31:17 +0000 (GMT)
Received: from pps.filterd (USCULXSNT13v.am.sony.com [127.0.0.1])
	by USCULXSNT13v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 692J942q1761800;
	Fri, 2 Oct 2026 19:31:14 GMT
Received: from us842f57abef3e.eu.sony.com ([10.10.10.214])
	by USCULXSNT13v.am.sony.com (PPS) with ESMTPS id 4gx5afe81c-1
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Fri, 02 Oct 2026 19:31:14 +0000 (GMT)
From: Maciej Grochowski <maciej.grochowski@sony.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH 0/2] PCI: Reserve resources for a delayed hotplug subtree
Date: Fri,  2 Oct 2026 21:31:09 +0200
Message-ID: <20261002193111.51637-1-maciej.grochowski@sony.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sony-BusinessRelay-GUID: 4O2BXBdQdMwVEo400rgDQ9mKauBPHAxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Sony-EdgeRelay-GUID: owdxwTqk05rGbMdKw9vII70c2MqFGwjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-GUID: 72ad3kLu7SraXTWZPPUcOxXZRWwsboDT
X-Proofpoint-ORIG-GUID: 72ad3kLu7SraXTWZPPUcOxXZRWwsboDT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NyBTYWx0ZWRfX7WUsYiC0mBXm
 7CDaO6mNP0E4Inuz8Vvwx/gjNMVtDiBg9wgdFjjBPaFgVflxMp9w/MBwkYao70wJ9QFBwjyLiP7
 vL38f8LlVn1TUqqDOS29/R/5fuNINsXRSx4fau+z78eNebE6HY1Z
X-Authority-Analysis: v=2.4 cv=cdpHPXDM c=1 sm=1 tr=0 ts=6ac00687 cx=c_pps
 a=6mgWUpd4vGE96FGw1JXD8A==:117 a=6mgWUpd4vGE96FGw1JXD8A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22
 a=jHItnBwsj8f3cr25iGAb:22 a=twwIdXyZLhAGH-z1IiAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NyBTYWx0ZWRfX3wY3c5MABJMg
 FwFjDQzEOJiszI+vXqvs/xa/tF9ripJo35oNgkBwODRoZGy9oGCwu5DtTMI04Mm+PTPPOhJ2lA/
 c71vSPyII8ILP9Fruz7/8FhTn1r00bryClfeoLyTpifLlGLkKURTBL73ftYBqcoS/UjLezcqt9F
 PAgnQwTBDypLH6ZYaegf16RcBDyceIUVp0EwF2YmADcOexz4zBaRFgu5mEMzKNp8dOh2n8G/R1V
 goXHq96wqloOkNfNom8DN331xxqCIzOd+C9IyziwZMDST0XHypaRYYP/RnmZAccmqn/zNb/bM5f
 w5LKIriaPA/OGAnr71X6ka1YaF68dEjdKt1kfGxKDamRr/d6B+2RZvihq8VC48FTv33RNaBvdQA
 P8tBU2mpcQv5puOMs52btR2zGR1+lLBPaGvjKLkZ/bDldXofz7DF9vR2DAZjfz3gXTEGwnAhBHw
 6W/sc46ZswZIQq4Wvww==
X-Sony-Outbound-GUID: 72ad3kLu7SraXTWZPPUcOxXZRWwsboDT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01

On a two-level Microchip PM50052 (Switchtec PFX) hierarchy, a hard reset
of the top switch removes both switches from the PCI tree.  The top
switch returns before the nested switch, so pciehp enumerates its five
hotplug downstream ports while they are empty.  The port leading to the
nested switch receives three bus numbers and a roughly 206 MiB
prefetchable window.  When the nested switch appears, it needs eleven
bus numbers and a 1 GiB-aligned 1032 MiB window for its NTB BARs.  The
missing resources leave part of the hierarchy unusable and the nested
switchtec function cannot bind.

Switches from other vendors can encounter the same resource shortfall
when a child appears after its parent hotplug port is numbered and
sized, if the child's requirements exceed that allocation.

These patches explore pci=hpreserve= to specify minimum resources for a
selected hotplug bridge while its child is absent.  Patch 1 reserves
memory window size and alignment; patch 2 reserves bus numbers before
the remaining bus numbers are divided among sibling hotplug ports.  The
path form tolerates downstream bus renumbering.  With no parameter, the
existing allocation policy is unchanged.

On a v7.3-rc2 based kernel with both patches and
  pci=hpreserve=bus=11:mmiopref=1032M:mmioprefalign=1G@0000:80:01.1/00.0/03.0
we tested a cold boot, two top-switch hard resets, and one nested-switch
hard reset on the two-level system.  After each reset, the nested port
retained its eleven bus numbers and aligned 1032 MiB window, the 1 GiB
NTB BAR was assigned, and both switchtec devices responded to MRPC.

We are posting this RFC now because the failure affects our PCIe hotplug
infrastructure.  The two-level pciehp test shows that a per-bridge
reservation can preserve one delayed subtree.  With three or more
switch layers that return at different times, this implementation
appears to require a reservation at each port sized while empty, and
each ancestor must retain enough bus numbers and aligned memory space
for the eventual subtree.  We have not tested that case.

Consider a larger layout with three top-level switches, each feeding
six second-level switches with eight NTB functions apiece.  If their
child links return late, the current syntax could need 18 full
path-specific entries, plus entries for delayed ancestors.  The NTB
BARs affect the resources required per bridge, not the entry count.
Matching by device ID could shorten a homogeneous case, but risks
reserving resources on same-ID ports without delayed children.

One possible extension, not implemented here, would let several
explicit paths with the same requirements share one reservation, e.g.
<reservation>@<path1>;@<path2>.  Would that make a kernel command-line
interface practical, or should firmware, platform data, or a PCI core
policy describe the expected resources?  We welcome feedback on the
interface as well as on the underlying hotplug allocation problem.

Bus-number reservation is not yet honored on a plain pci_rescan_bus()
path; the hardware test above exercises pciehp.  A separate allocator
retry releases a sibling bridge window on this system.  This series
does not address that issue.

Maciej Grochowski (2):
  PCI: Add pci=hpreserve= to reserve memory windows for a hotplug bridge
  PCI: Allow pci=hpreserve= to reserve bus numbers for a hotplug bridge

 .../admin-guide/kernel-parameters.txt         |  42 +++++++
 drivers/pci/pci.c                             | 108 ++++++++++++++++++
 drivers/pci/pci.h                             |  22 ++++
 drivers/pci/probe.c                           |  58 +++++++++-
 drivers/pci/setup-bus.c                       |  33 ++++++
 5 files changed, 259 insertions(+), 4 deletions(-)


base-commit: 5225b8eec4c9bb21aecff6295fab6346a3c3738e
-- 
2.47.3
