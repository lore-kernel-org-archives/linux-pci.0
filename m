Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.132.183.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730463;
	b=zHpedLVdJABBQmKaJgdugcz13Keq0d6sgA5+AxmuVuD2nfxScn0Oub6CIht249knk6zx
	 Rs6phB07xYseZS/yDULDLg4EUEAZQXv4eQDll4bG7uv9QvIBB/oSVXGtSqzEgGcws+/Mu
	 KY+JM8ADhPz569Oqs/eY3KRDMC/TTLGqW/MUqVrCMudfy+L6VeXq4D+QxrG2I05GiVZLJ
	 AkfRevGCkf9lZ2t8pUFIrTNQsRUzrciYLIbyvM7TekU2CN1abX7yAP071+8tp2u9XTo6l
	 /Lz3tY3GHvirddTaD9fBbJzIuzhJs13d30rL0qBt0jab8dilpe+OWm43SVI7pZW/E1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730463;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-Sony-BusinessRelay-GUID:
	 X-Proofpoint-Virus-Version:X-Sony-EdgeRelay-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Sony-Outbound-GUID:X-Proofpoint-Virus-Version;
	bh=sdxF3vkRtlH6rrQuqkWOSJfe3HheP2sbjXDou/moBMw=;
	b=ZPZX1eVfiqVpf0A0LFzEhkUCiD2DcLEYI4llEBPTrHaTxGjxcfSQr9rKyDi3Rzx6B7OA
	 Ncnyem84GpqW9WNCcJPAvDHK1OrrSMIXv0ykNrcafWf8C33VtVjdOKn0QPiEozP79XApk
	 J+rW9CQMaLDe28iLB//FYFvnRsFQb2oD0+UWK+mk5fO1enG8hGn66zjsUUz2ZEJ1CvkvI
	 mlYhBc1UIDXJ7NXlsfJTYm2v7DrND5Mi1e1fTtB8RtRNbAEvtoY2EhoLp0FMIPRmwEGjo
	 6R8dP3Yq9O1W1NcRLGJBgTBQ45VuvwEfLfhDR3grOF2PpmYDE1WoP6XgqmjrcOnFGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=pass smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=QD5+bzOm;
	arc=none smtp.remote-ip=185.132.183.11
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F488606A326;
	Tue,  3 Nov 2026 18:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F488606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=QD5+bzOm
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HQJNq3732702;
	Tue, 3 Nov 2026 18:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=p1; bh=sdxF3vkRtlH6rrQuqkWOSJfe3HheP
	2sbjXDou/moBMw=; b=QD5+bzOmED7TVVOkv3bfNAaL1Lyexi6IdHUy1/Obyz8j/
	TKDCdRoGxBOYFit72jvdx6QIpjLVerODNSY6w+vVIaRFCfBtW/xEnQDi6uPTwgDW
	2EBh7AnKv7WkIKB2qDCVkgNEKmW6KjH8E04A24TK8Q4Ay5eZu2I+Hac1PL/vKXH+
	gyGB8WBPmxexeAf1CQeIn/7xswD9rsTICu8cTTzKe9Bn6Vc7AG++JDMR82hw5PJK
	TKldLuHFwn3zO7zCk9SxVGc9KAQcwpR+EbQEf7w/WJSorwhqPI+meeYvJOzZhG2k
	FX53iXTTGb8WmaqWNb1Z1e1vYh7k20ceqS1eW18ZQ==
Received: from sgppsea01v.sg.gdce.sony.com.sg ([121.100.43.225])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4hn6yuv5jw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 03 Nov 2026 18:27:25 +0000 (GMT)
Received: from pps.filterd (SGPPSEA01v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA01v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 6A3HQGdr1554954;
	Tue, 3 Nov 2026 18:27:24 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by SGPPSEA01v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4hn9dgp3ng-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 18:27:23 +0000 (GMT)
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by usculxsnt14v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HNvuZ020791;
	Tue, 3 Nov 2026 10:27:21 -0800
Received: from us842f57abef3e.ad.gaikai.biz ([10.10.10.214])
	by usculxsnt14v.am.sony.com (PPS) with ESMTPS id 4hp1wap27r-1
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Tue, 03 Nov 2026 10:27:21 -0800 (PST)
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com
Cc: Maciej Grochowski <maciej.grochowski@sony.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 0/2] PCI: Reserve resources for a delayed hotplug subtree
Date: Tue,  3 Nov 2026 10:27:18 -0800
Message-ID: <cover.1793724065.git.Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Sony-BusinessRelay-GUID: n8R1i7_7tag7JQJy7yRClj9jIhQJA5l0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Sony-EdgeRelay-GUID: yxa6HItiFSCcnj6cZB3mQkX2G79Zvaba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX/hXndmwIkW9j
 HSgBSmW7g95/ujydGbGwn0XOVogqFrYMSphgZ5GzSKToYEAo+IGruq9/Vs8V5mi7uCxjRa3jy7y
 P2tsIMfa5hx+PVi2MgkQNEjYQjHPFxPOpcU+8hkpLd0mBjIV3X+5
X-Proofpoint-GUID: U2siSd78_9m140BmhnK6PTLVN7X_RE1Q
X-Proofpoint-ORIG-GUID: U2siSd78_9m140BmhnK6PTLVN7X_RE1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX+lOSdCPkSIl6
 +RyZ2782ucyq3x5JK3/xaloNJKK+rZSK96N6/OQr1viuYBC+tKXd3eU0l9sAK9eSPO6uYgO33sR
 jQ3DwRB17TfKi4SscdaReYdLhg7+vOztq/ZK/ROFHppAwYwqG9P01XEhiCIeVbgRorrkgKeq7AG
 diBt73WsyEVqwyISB7jBQJDhWHgC6HkAkCy9lt5a1MCOxET2A8uVFyrKN3RANxK1Y7DOIuhWIfW
 /NtyX2Zup11mp0OYaOqNikA8Zpyh+jPATs/pRAtMRrzkiQl0esBNpHsUO9Kll3J+/0+7uQv/C80
 DGMvknBe5pFLZUqMx/WYG5JG3x9lL+p45tevdWZdR4LRAwicC4CY42yaMOGxk7Kg79odFl3v8cZ
 Pv1mau4CFBmqCFEcsLjmEl17r9LPtIvnY/EYURxyktOX2phYsPvcuC+9lXm7b5CYi8kiqP9/BWV
 pyw/WVqrGRF8EdAvKCQ==
X-Authority-Analysis: v=2.4 cv=T4YZ3PKQ c=1 sm=1 tr=0 ts=6aea278e cx=c_pps
 a=XNW8778QP6juiAqijDMnrw==:117 a=XNW8778QP6juiAqijDMnrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=pQehfwC0D4oxWvs5GOjV:22 a=VwQbUJbxAAAA:8
 a=z6gsHLkEAAAA:8 a=3NI1pkrnQhYOloL9CnEA:9 a=QEXdDO2ut3YA:10
X-Sony-Outbound-GUID: U2siSd78_9m140BmhnK6PTLVN7X_RE1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01

From: Maciej Grochowski <maciej.grochowski@sony.com>

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

V2 extends the existing pci=hpmmiosize, hpmmioprefsize and hpbussize
parameters, as Ilpo suggested, instead of adding hpreserve. Patch 1
requests a required memory window size and size-derived head alignment;
patch 2 reserves bus numbers before the remainder is shared among sibling
hotplug ports. The path form tolerates downstream bus renumbering. Bare
values retain their existing global meaning.

The v2 setting for the same port is:

  pci=hpmmioprefsize=1032M@0000:80:01.1/00.0/03.0,hpbussize=11@0000:80:01.1/00.0/03.0

A 1032 MiB minimum requests 1 GiB head alignment without a separate
alignment option. Placement and parent resources still limit allocation;
assigned firmware windows are kept.

With v1 on a v7.3-rc2 based kernel and the hpreserve setting from the
original post, we tested a cold boot, two top-switch hard resets and one
nested-switch hard reset. After each reset, the nested port retained
its eleven bus numbers and aligned 1032 MiB window, the 1 GiB NTB BAR was
assigned, and both switchtec devices responded to MRPC. These are the
previously reported v1 results; this rebased v2 tree has not been boot-tested.

The failure affects our PCIe hotplug infrastructure. The two-level test
shows that a per-bridge reservation can preserve one delayed subtree.
With three or more switch layers returning at different times, this
approach appears to need a reservation at each port sized while empty.
Each ancestor must retain enough bus numbers and aligned memory for the
eventual subtree. We have not tested that case.

Consider three top-level switches, each feeding six second-level
switches with eight NTB functions apiece. If the child links return late,
that gives 18 selected bridge paths, plus any delayed ancestors. With
separate memory-size and bus-count options, those paths normally appear
in both lists: 36 value@path entries. The NTB BARs affect resources per
bridge, not the entry count. Device-ID matching could shorten a homogeneous
case, but risks reserving space on same-ID ports without delayed children.

One possible extension, not implemented here, would let several explicit
paths with identical requirements share a value in each option. Would
that make a kernel command-line interface practical, or should firmware,
platform data or a PCI core policy describe the expected resources? We
welcome feedback on the interface and the underlying allocation problem,
including required versus optional per-device memory sizes.

Changes since v1:
  - Reuse hpmmiosize, hpmmioprefsize and hpbussize, following Ilpo's feedback.
  - Derive head alignment from the requested size instead of mmioprefalign.
  - Apply the scoped bus minimum on the plain child-bus scan path too.
  - Include small sizing/sharing safety corrections; keep the two-patch design.
  - Drop self Tested-by trailers and rebase on PCI next.

This revision passed W=1 PCI object builds at both patch boundaries on
ARM64 and i386 PAE/64-bit resources, plus focused userspace source checks.
The PCI sources emitted no warnings; one Darwin host-tool macro warning
was recorded. These checks do not replace hardware or concurrency testing.

Plain-rescan minima are now handled, but existing firmware ranges and
retained-child optional spare remain limitations. The sibling-window
allocator retry issue reported with v1 is outside this series. The
separate bus-number overflow fixes overlap a scan guard and will require
rebasing if both series are taken.

v1: https://lore.kernel.org/linux-pci/20261002193111.51637-1-maciej.grochowski@sony.com/

Maciej Grochowski (2):
  PCI: Allow hpmmiosize and hpmmioprefsize for specific hotplug bridges
  PCI: Allow hpbussize for specific hotplug bridges

 Documentation/admin-guide/kernel-parameters.txt | 41 +++++++++++
 drivers/pci/pci.c                               | 91 ++++++++++++++++++++++++-
 drivers/pci/pci.h                               |  3 +
 drivers/pci/probe.c                             | 87 ++++++++++++++++++++++-
 drivers/pci/setup-bus.c                         | 25 +++++++
 5 files changed, 243 insertions(+), 4 deletions(-)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
