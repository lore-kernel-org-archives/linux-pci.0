Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BD315D58;
	Thu,  4 Jun 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559414; cv=none; b=BVhHD+GI4PSxzEPqLl+cF76s/tZlM9Pw1WIZPCmGYS70EV5HhGWbPM18dZ63riSTy5oS6SWeG20I4SIXO7qIKz94D/8wyC2WhcN2XCKoUywtWkkPIXr7LNHUzkHDpA3XKCh1Tq59CTot0OZPJQ+e3T2aYB9UmsAoHLnPLUwWmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559414; c=relaxed/simple;
	bh=xXAo7JA/FCQGU0PydG/CbstStee8P3CnLDdGkdFqfkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U+aMcWNAfrmUdzhh0asljeKW5ff0bYdfDk5J6XfSoQlVWsDvCeq//Iz0mr5Odu0SsfQbJKthzQ8ypP1eLG6NeRI5bsLeDw+hWnE4gbrB2HJDrTslBYx0XrtAzUvhAlUc0bJdF0HEdM0heymh4UyJvIBT9Oqj0H06EkXvvyh7MJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ioFbu4NV; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ioFbu4NV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iKhnmKKSbhjeNdqT2fB30yYTWXHZcg0QMpTiu5anmd0=;
	b=ioFbu4NVRgf3LNPhc//0xFgLW/sRh9rqxYVVddoZbjMClBRr/6NDkF7bkGHmFpANOSXBcY9Vk
	ZaPiu9leZp97LBHEsrw8FVfsuFTOdQdikbm19YHu3yVHJFDpEQkrPpfGeLZvcP9svaIPVA/Q3Cl
	w1tvAPATCnOb+95EV2ScSfM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gWGjy27Cpz1prPH;
	Thu,  4 Jun 2026 15:42:14 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 54E3D40561;
	Thu,  4 Jun 2026 15:50:07 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 15:50:07 +0800
Received: from huawei.com (10.50.163.32) by kwepemn200012.china.huawei.com
 (7.202.194.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Jun
 2026 15:50:05 +0800
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
	<shenyang39@huawei.com>, <gaozhihao6@h-partners.com>,
	<yuzhichengcheng@h-partners.com>, <liyihang9@h-partners.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <wuyifan50@huawei.com>,
	<liusizhe5@huawei.com>
Subject: [PATCH 00/10] perf hisi-ptt: Enhance TLP packet decoder with field-level parsing and versioning
Date: Thu, 4 Jun 2026 15:49:55 +0800
Message-ID: <20260604075005.2219785-1-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200012.china.huawei.com (7.202.194.135)

This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
decoder in perf to provide detailed field-level parsing of TLP headers
based on message type, and adds a versioning mechanism for backward
compatibility.
The original decoder only prints raw hex values with generic field
names for each DW, without classifying TLP types or decoding
DW2/DW3 fields according to the hardware-defined packet format.
Patch overview:
  Patches 1-2: Bug fixes
    - Fix spelling/abbreviation errors (FIELD_LENTH, kpt_desc)
    - Fix DW0 bit field ordering and DW hex value printing
  Patches 3-7: Refactoring for field-level parsing
    - Rename union and add named struct member for multi-DW reuse
    - Abstract trace buffer/offset into struct hisi_ptt_pkt_buf
    - Complete missing field name entries in 4DW/8DW tables
    - Extract raw data printing into function
    - Unify 4DW/8DW HEAD0 printing into hisi_ptt_print_head0()
  Patch 8: TLP message type classification
    - Parse Format/Type from DW0 to classify packets as
      MWr/Msg/Atomic/IO/Cfg/Cpl
  Patch 9: Field-level DW2/DW3 parsing
    - Decode DW2 fields for MWr/Msg/Atomic/IO TLPs
    - Decode DW3 fields for Completion and Configuration TLPs
  Patch 10: Version compatibility
    - Add V1/V2 version in auxtrace info to distinguish old
      (generic field names) from new (detailed field parsing)
      trace data, with backward compatibility for V1 files

Sizhe Liu (10):
  perf hisi-ptt: Fix spelling and abbreviation errors
  perf hisi-ptt: Fix PTT trace TLP Header parsing
  perf hisi-ptt: Rename hisi_ptt_4dw union for reuse
  perf hisi-ptt: Abstract trace data buf and offset
  perf hisi-ptt: Complete the field names for 4DW and 8DW packets
  perf hisi-ptt: Extract the raw data printing part
  perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
  perf hisi-ptt: Add parsing of supported message types
  perf hisi-ptt: Add field-level parsing for header DW2/DW3
  perf hisi-ptt: Add decoder version compatibility

 Documentation/trace/hisi-ptt.rst              |  28 +-
 tools/perf/arch/arm64/util/hisi-ptt.c         |   2 +
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 352 +++++++++++++++---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  27 +-
 tools/perf/util/hisi-ptt.c                    |  46 ++-
 tools/perf/util/hisi-ptt.h                    |   4 +-
 6 files changed, 365 insertions(+), 94 deletions(-)

-- 
2.33.0

