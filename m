Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108E3AF64B;
	Thu, 30 Jul 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392848; cv=none; b=m4UCqe73enhh361YTo4ntG+qkkdAj9YSmYeUqfXbEP7hZ3PZaMvqkysELcUFkCzFS1MvuqMAuRJeBfumeD9g+VaJr+YzH5NPF8fez1oCmjuKEbyUZD2ERKpuMMPgPweBC67b6BavhbZjSluO3+07+K+w7Wta8J70ENpbgQcFV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392848; c=relaxed/simple;
	bh=k8/WnG3ePQdVblZPDObuf9UqlKYYUvPONQb60zzrpqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J2zGxps0iWYd5/QCDqHBUUUeDYvGeO7R0Kg+K7ENMGEqrr1Pm7ptDbT/qOi8vNyOcuzJ0CZtIkZ6K69/TSYcrDQNh+5wvfwPY2f/U3URMivTYvh7cTlBhT5mWaJJZEgx1d2o1yPILk9QD+5sEQmbZuQbw+3VQfZlBwMuSA2+kGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Rt+xRyeG; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Rt+xRyeG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Qqd8wGXWEw9LjEjKWEX/5ui0R27Uajy4hyfMozJIyIY=;
	b=Rt+xRyeG+TiNo/EjpbUkr58F4sKUjxE5+cx3G9V2AMZ+e0oyStS2I+T3Ha50VqaYd6DzVaiuv
	ijRpeWxCTOBesuGB2s60YJm+DZhsQX9mjCib58AFLtuHTPBJv6KDhIZ3msJPRTS//vSgvtwHHRJ
	fsOCQ5HX0ZoRRRoE0VtVdto=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h9fBf1bvQz1cyTD;
	Thu, 30 Jul 2026 14:17:46 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 52B9540572;
	Thu, 30 Jul 2026 14:27:12 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Jul
 2026 14:27:09 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wangyushan12@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <wuyifan50@huawei.com>, <liusizhe5@huawei.com>
Subject: [PATCH v2 0/3] perf hisi-ptt: Fix TLP header parsing and naming
Date: Thu, 30 Jul 2026 14:27:06 +0800
Message-ID: <20260730062709.534139-1-liusizhe5@huawei.com>
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

This series fixes bugs and issues in the hisi_ptt packet decoder that were
introduced by commit 5e91e57e6809 ("perf auxtrace arm64: Add support
for parsing HiSilicon PCIe Trace packet").

Patch 1: Bugfix:
The DW0 bit-field layout of the hisi_ptt_4dw union does not match
the actual little-endian memory ordering, so the extracted
Format/Type/T9/T8/TH/SO/Length/Time fields are wrong.

Meanwhile, make all DW hex values printed in big-endian byte order
for readability.

Patch 2: Fix endianness / Heap out-of-bounds read / Integer truncation
issues.

Patch 3: Fix spelling / abbreviation errors in symbol names and macros.

---
Changes in v2:
- Move spelling error fixes to the end of the patch series.
- Add fixes tag only for bugfix.
- Use get_unaligned_le32() to make memory read more robust.
- Fix pre-existing issues reported by Sashiko in patch 2.
- Link to v1: https://lore.kernel.org/linux-pci/20260729060220.624250-1-liusizhe5@huawei.com/

---
Sizhe Liu (3):
  perf hisi-ptt: Fix PTT trace TLP header parsing
  perf hisi-ptt: Strengthen auxtrace event handling and packet type
    detection
  perf hisi-ptt: Fix spelling and abbreviation errors

 Documentation/trace/hisi-ptt.rst              | 28 ++++-----
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 63 ++++++++++---------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 14 ++++-
 tools/perf/util/hisi-ptt.c                    | 24 +++++--
 4 files changed, 77 insertions(+), 52 deletions(-)

-- 
2.33.0

