Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58507374E42
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352887; cv=none; b=N2bNfDAL92qvFvyrA8wwcjtbiwJOaIf/8Hv3KERIzy0rehlsOlbo80A1MDUR+aCX1yoDq2AMI4ZAx7X1I0058NarnUqCWs0YvZtyeK4AsZoiEuGygS7zhq+587e2NVKofK8gaqApz4E2sSFofNa3YwUgIlY2usn1JgYhx5m73Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352887; c=relaxed/simple;
	bh=/gM/wzE6xLTNyKPirLgLD21U1HI/NdRJfB1ViZocnAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=ZG0SbejjsGVYMtvgc4R3j20zSvHnnBhlrU8MLiyTrU7ut6vt2QWbRIVJvAaoIm+BH0tVtGkxU5JHfJ45dq5Tv1U+Gd1h9JNFxnDpLykeQCPwEl3qpCvVsMOPJTPXNdf/elCyeTnO0YYZIJSFc9O4t+dIecOB9EkcUwj4P4B+yqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BKI1Bix4; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BKI1Bix4"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260625020116epoutp03804970209c5d82e18d68e03c1e5fceb3~8MH_OPSHN0128601286epoutp03k
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 02:01:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260625020116epoutp03804970209c5d82e18d68e03c1e5fceb3~8MH_OPSHN0128601286epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782352876;
	bh=rqciwAtiNjhmxE6qraKNhQ+B1MTRFF85VVu7t9VeR/Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BKI1Bix411MlJX/P3pVhpK/c4N8xqR83Ey6oNz4fmS3j3sGvK7zynFNpoPfN6G85X
	 UurwoLqyu3BYHnecUTrRzc3FjYJDDQ985NkDEqvSHWMVhBxfkqn5JRkTx0Fj+wegMh
	 KSaJM4/M4uiIu75q66xMoqMExAd/moj912mDOgDo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260625020116epcas5p38700649bc16267a411e909ea482fc18a~8MH99STCF0536605366epcas5p3z;
	Thu, 25 Jun 2026 02:01:16 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gm28q6YQxz6B9mG; Thu, 25 Jun
	2026 02:01:15 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260625015930epcas5p33fa9d4833d45b53597e2994fb9ec2577~8MGaqDO8k2255722557epcas5p3_;
	Thu, 25 Jun 2026 01:59:30 +0000 (GMT)
Received: from hexue-PowerEdge-R7625.. (unknown [109.105.118.129]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260625015929epsmtip2d4550d10c526f641965e1d2d4cc8e647~8MGZ0aT2G2157721577epsmtip2a;
	Thu, 25 Jun 2026 01:59:29 +0000 (GMT)
From: "xiaobing.li" <xiaobing.li@samsung.com>
To: bhelgaas@google.com, logang@deltatee.com, m.szyprowski@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: kun.dou@samsung.com, peiwei.li@samsung.com
Subject: [RFC PATCH 0/0]  PCI P2PDMA: Add observability support via
 tracepoints, debugfs, and sysfs.
Date: Thu, 25 Jun 2026 09:59:27 +0800
Message-ID: <20260625015927.5704-1-xiaobing.li@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260625015930epcas5p33fa9d4833d45b53597e2994fb9ec2577
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260625015930epcas5p33fa9d4833d45b53597e2994fb9ec2577
References: <CGME20260625015930epcas5p33fa9d4833d45b53597e2994fb9ec2577@epcas5p3.samsung.com>

Hi all,

The Linux kernel's P2P DMA infrastructure is already very mature, but currently it is not user-friendly in terms of metric observability. 
For example, without manually adding logs, there is no intuitive data to see how many P2P transfers, which paths are taken, 
    and how performance is. It is impossible to clearly observe P2PDMA activity from user space, making the following operations difficult:

- Diagnose the reasons why P2PDMA may not work (or perform poorly).

- Verify whether the P2PDMA mapping uses the expected type (BUS_ADDR or THRU_HOST_BRIDGE)

- Monitor the use of P2PDMA in production environments

- Detect potential memory leaks (unmapped allocations)

P2PDMA is a subtle feature. When P2PDMA mapping cannot use BUS_ADDR (Direct PCIe Switch Path), it silently falls back to the THRU_HOST_BRIDGE, 
       routing traffic to the host bridge. This significantly reduces performance (usually by 10 times or more), but it cannot be detected 
       from user space.

Therefore, I plan to export some metrics in the user space to better observe P2PDMA activity.
This series of solutions adds three layers of observability:

1. Tracepoints (5 events, optional, no overhead when disabled)

- p2p_dma_alloc: P2P memory allocation

- p2p_dma_free: P2P memory release

- p2p_dma_map: P2P DMA mapping (including client/provider, mapping type,

PCIe distance and process information)

- p2p_dma_unmap: P2P DMA removes mapping

- p2p_map_type_change: New mapping type calculations (xarray missed)

All tracking points include the calling process (comm pid), enabling P2PDMA activity tracking for each process.

Example:

$ cat /sys/kernel/debug/tracing/trace | grep p2p_dma_map

nvme[1234] map nvme0 -> p2p_mem type=BUS_ADDR dist=4

python[5678] map nvme1 -> p2p_mem type=THRU_HOST_BRIDGE dist=8

2. Debugfs (global cumulative counter, always available)

- /sys/kernel/debug/pci-p2pdma/

- 11 counters: total_mappings, bus_addr_mappings, host_bridge_mappings,

total_allocations, error_count, etc.

- Enable the calculation of the "BUS_ADDR ratio" to quantify the effectiveness of P2PDMA.

3. Sysfs (Statistical Information for Each Device, Production Environment Safety)

- /sys/bus/pci/devices/*/p2pmem/stats/

- 4 attributes: alloc_count, free_count, mapped_bytes, peak_mapped_bytes

Performance impact

- Tracking point: Static branch, zero overhead when disabled (by default).

- Debugfs/sysfs: atomic64_t counter, no locking, negligible overhead

- After disabling all observability, the P2PDMA thermal path remains unchanged


I would appreciate feedback on:

1. Is the overall solution worth implementing?
2. Is the set of tracepoints appropriate? Any events I'm missing?
3. Are the tracepoint fields sufficient for debugging?
4. Is the debugfs/sysfs interface design acceptable?
5. Any concerns about the implementation approach?
