Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10357313E2C;
	Thu, 27 Aug 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839504; cv=none; b=B0Ll+QMbWFO86KUkqLOKHZJQIlhfh0rlAL1KOCP58ik7G/rR/YpSTwtjIDn1dVzVLA3F2+nxwvPEteKYAi6+QIyX8XD7rOoGekMwJFBRNTjFcYvr4bjTinqBBr+o1OPejXfdqkiUkNVHwFopHAUbkOsIBKA+dW2wR91q1Nmcz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839504; c=relaxed/simple;
	bh=rEJaJtdN5in9yjrBAK/yUtS9KFyKGFmTneTp//W43iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pN0Zzo8+s7CCHClXGY49XvSAmudm9ZDfG+w5XHiu+2GOQgJ/inYOs7uzPmZB9YWn+TuaAezJ6I4qzxit/jqzFS86r/DI9f+QzYeOWTywLCDIpRoELuCoAKcldyazaRavfmiCdxI3KyNCWlnDggPv+/PxjhNIQ8L55XCWhbCPD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XQbn0Bdq; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XQbn0Bdq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wUSYVC8RFXMOBblpJTxkPOOEO8+kx3KB+SF4zeqbhxs=;
	b=XQbn0BdqJFCp5eXrsclw/2+1Ove1XReqsTNyH2vdH0yELJj4f/0S+YkVtOZtaY0MikUxpeEyJ
	SrZQnV8ho5fkQ3tq2XFRkNfw4faZvu4trS5rhnFqKEtOZlZ8/S57l+cgJn7WlEDk5QbYpjSJHT9
	shMLICOzS+N2kfqavFt3u20=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hW3091WQczRhR0;
	Thu, 27 Aug 2026 21:54:01 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 92BBA4056D;
	Thu, 27 Aug 2026 22:04:45 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 22:04:43 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wangyushan12@huawei.com>,
	<wuzongyu1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <liusizhe5@huawei.com>
Subject: [PATCH v2 0/8] Enhance TLP packet decoder with field-level parsing and versioning
Date: Thu, 27 Aug 2026 22:04:34 +0800
Message-ID: <20260827140442.2031128-1-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200004.china.huawei.com (7.152.184.18)

The original hisi-ptt-decoder only prints raw hex values with generic field
names for DW2/DW3, without classifying TLP types or decoding
DW2/DW3 fields according to the hardware-defined packet format.

This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
decoder in perf tool to provide detailed field-level parsing of TLP headers
based on message type, and adds a versioning mechanism for backward
compatibility both in hisi_ptt driver and perf tool.

---
Changes in v2:
- Split patch 01/10 and patch 02/10 from series v1 into independent patch
  series for backporting.
- Use bitwise operations instead of C bitfields for cross-platform cases.
- Add `pattern` parameter in hisi_ptt driver for layout compatibility.
- Link to v1: https://lore.kernel.org/linux-pci/20260604075005.2219785-1-liusizhe5@huawei.com/

---
Sizhe Liu (8):
  perf hisi-ptt: Abstract trace data buf and offset
  perf hisi-ptt: Complete the field names for 4DW and 8DW packets
  perf hisi-ptt: Extract the raw data printing part
  perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
  perf hisi-ptt: Add parsing of supported message types
  perf hisi-ptt: Add field-level parsing for header DW2/DW3
  hwtracing: hisi_ptt: Add pattern PMU config for trace format selection
  perf hisi-ptt: Pass pattern version to decoder for compatibility

 Documentation/trace/hisi-ptt.rst              |  25 +-
 drivers/hwtracing/ptt/hisi_ptt.c              |  25 +-
 drivers/hwtracing/ptt/hisi_ptt.h              |   4 +
 tools/perf/arch/arm64/util/hisi-ptt.c         |  18 ++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 291 ++++++++++++++----
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  68 +++-
 tools/perf/util/hisi-ptt.c                    |  51 +--
 tools/perf/util/hisi-ptt.h                    |   9 +-
 8 files changed, 404 insertions(+), 87 deletions(-)


base-commit: bec06676f4b2a4276b6277783eb91cd3cffd4b33
-- 
2.33.0

