Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD81FC8;
	Wed, 29 Jul 2026 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785304956; cv=none; b=iXEPQI20vyQYjIZTZRYclD4FXHYHvMRKAqHLDqSpJRYK3SrPbECg47SuPq0UA5h03ET4A80Uj1N9A1dvqoj635y5D5bGtjUj5TD6j47fyl8YD6M88FSW829O7cCMujEs9aFnAe6BM9136+9F48UwsqmI9vwlQ65Z/2dE/r76SOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785304956; c=relaxed/simple;
	bh=d1jpF8vb6aXhLUfdO/qksYq35dIQEz8HZq0Nrq1lgvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B412EVN4yqAXpU3943YTnvTS0OuhIBs42HUkzMxDPeuop0+1SqqQUWyxBtMnb//PooEztzk8VSpIrIQKn4m8XE/bFcUrwa3CWCblwag/CShGHDpIG36vRwOGWeg2McAXXoVJDKxyldffiDPVLMUrwR+MbTaSAA3aXg/2xirtaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gedM1U4d; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gedM1U4d"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=V71nthpwGO+GJAB/erhP7HVeTYXWWzSBe1yNAaRYKzY=;
	b=gedM1U4dPxFnmbzPbb3fHUR2F44fUXtqWGFuEihLGoQAzSofJYQSXHFw6UMr9MIFqEh6k9RcJ
	8o7qXbpqweRP/Er++EJCnfYOZzcWIe680lE92SEZXzrtidjzVWvytlA5e6L6xKfysJzfBfeo6sq
	S1MCiisNWZmudGbwK2WrNfk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h91hQ0nSqzKm4b;
	Wed, 29 Jul 2026 13:52:54 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E2CE4056C;
	Wed, 29 Jul 2026 14:02:23 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 14:02:20 +0800
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
Subject: [PATCH 0/2] perf hisi-ptt: Fix TLP header parsing and naming
Date: Wed, 29 Jul 2026 14:02:18 +0800
Message-ID: <20260729060220.624250-1-liusizhe5@huawei.com>
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

This series fixes two issues in the hisi_ptt packet decoder that were
introduced by commit 5e91e57e6809 ("perf auxtrace arm64: Add support
for parsing HiSilicon PCIe Trace packet").

Patch 1 fixes spelling / abbreviation errors in symbol names and
macros.

Patch 2 fixes a bug:
The DW0 bit-field layout of the hisi_ptt_4dw union does not match
the actual little-endian memory ordering, so the extracted 
Format/Type/T9/T8/TH/SO/Length/Time fields are wrong.

Meanwhile, make all DW hex values printed in big-endian byte order
for readability.

Sizhe Liu (2):
  perf hisi-ptt: Fix spelling and abbreviation errors
  perf hisi-ptt: Fix PTT trace TLP header parsing

 Documentation/trace/hisi-ptt.rst              | 28 ++++-----
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 62 +++++++++----------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 14 ++++-
 3 files changed, 58 insertions(+), 46 deletions(-)

-- 
2.33.0

