Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134943E08D;
	Tue,  8 Sep 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876336; cv=none; b=dvYfP5pd5TBNtkHHzUb+rez/J+0meiwRen80WpGafyl8UPgP6tg037jbdx66bp7I9zCTHYXL+OjmBCDjObZeZbBFoWC9TBA7dsfCMK0jg4s2xG+L2EWwV6r1h1Ir/cK/LtKXaQcLn/iTk019iOjPrk7rQA9RUbBsHvOQtPolLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876336; c=relaxed/simple;
	bh=22x/kBWd//W1qiC5Y3i0XAk7i1mKVb1lzM2N3i/edRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e0mXuPt6Lb8bvp79yxKvUx5OWY1y2+bWZAkcSSln36KuxDuVON7IyyJbFDTX5UNB+Vdwat3ZwFOlsEMAT5Z365gI8NReQ/xq6AnUyx6RGN9OfS5t4KmAsNRcjAaVPx20tlnfU5+Rg1cHyl+FrulRa/0ZB7F+g2vzG5nT9dqm814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FOa5Us/M; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FOa5Us/M"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fCGCrcQvIQHCn6Oxjj6Hi2AwQkQyjYQI5P2kxUyRvKU=;
	b=FOa5Us/Mz5jMfQjzLRBNfzSzt7Vljrygj0ZrWc9Vu6U0nTQlV7FupdO5ssLL8r1OYRE3Et4M1
	T3tddajUt9SZgm1sEqbk+jqgUcs+5KvEfgennyk1TbsDsR4r01hWtaD7u3jh88dFaA2XYHVqWeu
	G9e6jMmmkgJCX8JwfblTpFk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hfQQz1FKNzLlX2;
	Tue,  8 Sep 2026 21:54:19 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id F2F0F4048B;
	Tue,  8 Sep 2026 22:05:12 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 22:05:10 +0800
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
Subject: [PATCH v4 0/8] Enhance TLP packet decoder with field-level parsing and versioning
Date: Tue, 8 Sep 2026 22:05:01 +0800
Message-ID: <20260908140509.2485649-1-liusizhe5@huawei.com>
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
 whupemo200004.china.huawei.com (7.152.184.18)

The original hisi-ptt-decoder only prints raw hex values with generic field
names for DW0/DW1/DW2/DW3, without classifying TLP types or decoding
DW0/DW1/DW2/DW3 fields according to the hardware-defined packet format.

This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
decoder in perf tool to provide detailed field-level parsing of TLP headers
based on message type, and adds a versioning mechanism for backward
compatibility both in hisi_ptt driver and perf tool.

---
Changes in v4:
- Add missing space in hisi-ptt.rst (Sashiko).
- Widen the pattern bit field in struct hisi_ptt_trace_ctrl (Sashiko).
- Add protocol defined TLP header length parsing in patch 05/08.
- Add MRd and DMRr message types parsing in patch 05/08.
- Add comment for enum hisi_ptt_pkt_msg_type in patch 05/08. 
- Add DW0 and DW1 fields analysing in patch 06/08.
- Refine bit-fields parsing of DW0/DW1/DW2/DW3 based on different requests
  in patch 06/08.
- Refine the description of pattern=1 in the document in patch 07/08.
- Extract the bit-field printing of v1 version into functions in
  patch 08/08. 
- Link to v3: https://lore.kernel.org/linux-pci/20260903075241.1445338-1-liusizhe5@huawei.com/

Changes in v3:
- Add explicit inclusion of <stdbool.h> (Sashiko).
- Make patch 07/08 apply cleanly to mainline (Yushan).
- Pick up the reviewed-by tag (Yushan).
- Link to v2: https://lore.kernel.org/linux-pci/20260827140442.2031128-1-liusizhe5@huawei.com/

Changes in v2:
- Split patch 01/10 and patch 02/10 from series v1 into independent patch
  series for backporting (Bjorn).
- Use bitwise operations instead of C bitfields for cross-platform cases
  (Sashiko).
- Add `pattern` parameter in hisi_ptt driver for layout compatibility.
- Link to v1: https://lore.kernel.org/linux-pci/20260604075005.2219785-1-liusizhe5@huawei.com/

---
Sizhe Liu (8):
  perf hisi-ptt: Abstract trace data buf and offset
  perf hisi-ptt: Complete the field names for 4DW and 8DW packets
  perf hisi-ptt: Extract the raw data printing part
  perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
  perf hisi-ptt: Add parsing of supported message types and proto length
  perf hisi-ptt: Add field-level parsing for header DW0/DW1/DW2/DW3
  hwtracing: hisi_ptt: Add pattern PMU config for trace format selection
  perf hisi-ptt: Pass pattern version to decoder for compatibility

 Documentation/trace/hisi-ptt.rst              |  26 +-
 drivers/hwtracing/ptt/hisi_ptt.c              |  25 +-
 drivers/hwtracing/ptt/hisi_ptt.h              |   4 +
 tools/perf/arch/arm64/util/hisi-ptt.c         |  18 +
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 593 ++++++++++++++++--
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 241 ++++++-
 tools/perf/util/hisi-ptt.c                    |  51 +-
 tools/perf/util/hisi-ptt.h                    |   9 +-
 8 files changed, 872 insertions(+), 95 deletions(-)

-- 
2.33.0

