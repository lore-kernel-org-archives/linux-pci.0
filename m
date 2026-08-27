Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50E29B78B;
	Thu, 27 Aug 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839509; cv=none; b=BiNksiZuLRGtP9DagzZwroS4/+1lChFNPKL2sKLu+9vGuevIOvKRcZgkix+oGTayRSahhYo4ebgiOmed7d0/Cz1PESxDYcjrQF+mbxkuO+R7RmVXa5E/X69ruoJ0hc/KqYa3++pe7R0b0kqVcOYIu5F8c3YX9Q0V1HXfbQaNXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839509; c=relaxed/simple;
	bh=ThXLS+1EDeZcHtTvHRKNMqaMzxq7/pY3B7pJOrDYX+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVWnB/zOlXcXEwykiTC+V+xUoMyz4VL4zUJ6ClcE1Ow/m2IzSu2OoLeRIG734MA1FA6n45Az/8xTQQmCzYEkRf5HQRq/ybUuAtK8+WndDQ1UGyZ6EsEhDd3ABkl0shXh7Adw9kXmSm10eA3Wymkfc3KXOg/EAQRMM0pBTELe/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2wqJOUsE; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2wqJOUsE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f7BWGKlrl6bmn8Sz57qbIUsb8dlk+ldZG55Zj1BFAvA=;
	b=2wqJOUsEFUeIidsWW+5SgqYsTy9O/raW/8tZB4L4a8X7aty3GnYrvUa8TM/XKhh+zjfhQTgLG
	/UTFOPozzuTotO4ytS+qhl+TFnqzW4e4Lff1LlG/Zf8AZA7t+9Jxq2/ywGa4tLZn7oT2r3rBk4l
	BY+utr5keBSqNr9RVyCxtxw=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hW2zn4csHzpT0b;
	Thu, 27 Aug 2026 21:53:41 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F4CC40537;
	Thu, 27 Aug 2026 22:04:52 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 22:04:49 +0800
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
Subject: [PATCH v2 3/8] perf hisi-ptt: Extract the raw data printing part
Date: Thu, 27 Aug 2026 22:04:37 +0800
Message-ID: <20260827140442.2031128-4-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260827140442.2031128-1-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
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

Extract the raw data printing part of the TLP header into
hisi_ptt_print_raw_record() for reuse by subsequent patches that
add field-level parsing of individual DW headers.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 766665414ad8..23ae99f33c9f 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -79,23 +79,31 @@ static const char * const hisi_ptt_4dw_pkt_field_name[] = {
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
 };
 
-static void hisi_ptt_print_pkt(struct hisi_ptt_pkt_buf *pkt_buf,
-			       const char *desc)
+static void hisi_ptt_print_raw_record(size_t offset, uint32_t value)
 {
 	const char *color = PERF_COLOR_BLUE;
 	uint8_t byte;
-	uint32_t dw;
 	int i;
 
-	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
 	printf(".");
-	color_fprintf(stdout, color, "  %08zx: ", pkt_buf->pos);
+	color_fprintf(stdout, color, "  %08zx: ", offset);
 	for (i = 0; i < HISI_PTT_FIELD_LENGTH; i++) {
-		byte = (dw >> (24 - i * 8)) & 0xFF;
+		byte = (value >> (24 - i * 8)) & 0xFF;
 		color_fprintf(stdout, color, "%02x ", byte);
 	}
 	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
 		color_fprintf(stdout, color, "   ");
+}
+
+static void hisi_ptt_print_pkt(struct hisi_ptt_pkt_buf *pkt_buf,
+			       const char *desc)
+{
+	const char *color = PERF_COLOR_BLUE;
+	uint32_t value;
+
+	value = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, value);
+
 	color_fprintf(stdout, color, "  %s\n", desc);
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
@@ -120,19 +128,10 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 static void hisi_ptt_4dw_print_dw0(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	const char *color = PERF_COLOR_BLUE;
-	uint8_t byte;
 	uint32_t dw;
-	int i;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
-	printf(".");
-	color_fprintf(stdout, color, "  %08zx: ", pkt_buf->pos);
-	for (i = 0; i < HISI_PTT_FIELD_LENGTH; i++) {
-		byte = (dw >> (24 - i * 8)) & 0xFF;
-		color_fprintf(stdout, color, "%02x ", byte);
-	}
-	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
-		color_fprintf(stdout, color, "   ");
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
 	color_fprintf(stdout, color,
 		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
-- 
2.33.0

