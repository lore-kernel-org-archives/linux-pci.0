Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9654EED1;
	Tue,  8 Sep 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876358; cv=none; b=M5LpOdNqbqPynZj3/FLbNczxhuTblj5msciyNQvb02JM3AhRYAYzQ+jRY3iMnARpsjcgkAbVkV/hiSesSh4aWOBrXfEA44IaOrUXgcsQeWFGRUPbIuxEhYjQfKV0BXbtrr5a+60nenNuLZbL5vOHfgRt7BbOO3TuIFGXUnf/U+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876358; c=relaxed/simple;
	bh=W1VwhXPhIyRDCSnSemNsnoMkcKwfZtTpoqwIoeFGE7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlfFLLK/bzxiFsGcF4lO254hgYSqR3AEscXdmC9aZTmEgN8zXa3jSD38NWNfpU4zmZC1CcMqtuCD4ikF5LGNxVmQlDp6d+fgqSdUtfHiotoZVJd/2dvi8xbDRVjGI/muBIxGSc0rxYZuwyHrtzEmoTtKQb1g8gzZNUJYx2K1zLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H0ZBxixl; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H0ZBxixl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gWvItwcvRDtpm+4cG8lep+8yTi+6ko6t7VY0PWBGT+0=;
	b=H0ZBxixlC1kQVrJnFuXCxTX1f1Kj/EDEHa/l4aeuejxp4i9IEXX5YV27QvwFhaxfE4sdxKNdW
	hD1Mn7INPGPNbO7aSoK0Xd4QlWhGiU0mnqdBHj+ICvlPrc4hIvwiR2+qDCDAepemrbd6zlJfdBa
	00ewsFWP1kD1iSMZMaebZEo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfQRB6r8yzKmT6;
	Tue,  8 Sep 2026 21:54:30 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 7112540563;
	Tue,  8 Sep 2026 22:05:28 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 22:05:25 +0800
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
Subject: [PATCH v4 7/8] hwtracing: hisi_ptt: Add pattern PMU config for trace format selection
Date: Tue, 8 Sep 2026 22:05:08 +0800
Message-ID: <20260908140509.2485649-8-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260908140509.2485649-1-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
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

Introduce a `pattern` PMU config field (config:36-39) that controls
which TLP header format the hardware traces. bit[3:1] are reserved for
future extension and only bit0 is used currently:

- pattern=0 (default, compatibility mode): the driver sets bit[8] of
  HISI_PTT_TRACE_CTRL so the hardware traces the data in compatibility
  mode.
- pattern=1: the driver clears bit[8] of HISI_PTT_TRACE_CTRL so the
  hardware traces the data pattern including some bitfields of the TLP
  header defined in PCIe r6.4 sec 2.2.1.2.

Note that bit[8] of HISI_PTT_TRACE_CTRL is inverted with respect to the
`pattern` value: bit[8]=1 selects the legacy format, bit[8]=0 selects
the new format. Bit[11:9] is still reserved, which is consistent with the
PMU config field. The driver validates the 4-bit value in
hisi_ptt_trace_valid_pattern() and applies it in hisi_ptt_trace_start().

Document the new parameter in Documentation/trace/hisi-ptt.rst.

Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 Documentation/trace/hisi-ptt.rst | 26 ++++++++++++++++++++++++--
 drivers/hwtracing/ptt/hisi_ptt.c | 25 ++++++++++++++++++++++++-
 drivers/hwtracing/ptt/hisi_ptt.h |  4 ++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
index f6a2655f99e5..a70719386159 100644
--- a/Documentation/trace/hisi-ptt.rst
+++ b/Documentation/trace/hisi-ptt.rst
@@ -255,7 +255,29 @@ directly from the TLP header.
      DW2 [                     Header DW2                            ]
      DW3 [                     Header DW3                            ]
 
-5. Memory Management
+5. Trace pattern
+-----------------
+
+You can control whether the trace is taken with the new version of the
+TLP header format by specifying the `pattern` parameter. The default
+value is 0, which means the legacy format is used for backward
+compatibility. The parameter value is 4 bit and bit[3:1] are currently
+reserved for extension. Current supported values are shown below:
+
+- 4'b0000: legacy trace format
+    DW0 (in 8DW format), DW1, DW2 and DW3 are printed with generic field names,
+    and no message-type-based field decoding. Consider using legacy trace format
+    when the current PCIe link generation is not higher than PCIe 6.0.
+- 4'b0001: trace format v1
+    DW0, DW1, DW2 and DW3 are decoded according to the TLP message type (MRd,
+    MWr, DMWr, Msg, AtomicOP, I/O, Cpl, Cfg) with detailed field names.
+    It is recommended to use trace format v1 when the current PCIe link
+    generation is higher than PCIe 6.0.
+
+For trace data recorded by an older tracer without the `pattern` parameter,
+the decoder will work as `pattern` forced to 0.
+
+6. Memory Management
 --------------------
 
 The traced TLP headers will be written to the memory allocated
@@ -274,7 +296,7 @@ will commit the AUX buffer first and then apply for a new one with
 the same size. The size of AUX buffer is default to 16MiB. User can
 adjust the size by specifying the `-m` parameter of the perf command.
 
-6. Decoding
+7. Decoding
 -----------
 
 You can decode the traced data with `perf report -D` command (currently
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 52f168f8b459..b63985c2b30e 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -232,6 +232,10 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
 	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
 	if (!hisi_ptt->trace_ctrl.is_port)
 		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
+	if (!ctrl->pattern)
+		val |= HISI_PTT_TRACE_CTRL_PATTERN;
+	else
+		val &= ~HISI_PTT_TRACE_CTRL_PATTERN;
 
 	ctrl->started = true;
 
@@ -806,12 +810,14 @@ PMU_FORMAT_ATTR(filter,		"config:0-19");
 PMU_FORMAT_ATTR(direction,	"config:20-23");
 PMU_FORMAT_ATTR(type,		"config:24-31");
 PMU_FORMAT_ATTR(format,		"config:32-35");
+PMU_FORMAT_ATTR(pattern,		"config:36-39");
 
 static struct attribute *hisi_ptt_pmu_format_attrs[] = {
 	&format_attr_filter.attr,
 	&format_attr_direction.attr,
 	&format_attr_type.attr,
 	&format_attr_format.attr,
+	&format_attr_pattern.attr,
 	NULL
 };
 
@@ -941,6 +947,15 @@ static int hisi_ptt_trace_valid_format(u32 val)
 	return -EINVAL;
 }
 
+static int hisi_ptt_trace_valid_pattern(u32 val)
+{
+	/* Currently only bit0 is used, bit[3:1] are reserved for extension. */
+	if (val <= 1)
+		return 0;
+
+	return -EINVAL;
+}
+
 static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
 {
 	unsigned long val, port_mask = hisi_ptt->port_mask;
@@ -991,6 +1006,9 @@ static void hisi_ptt_pmu_init_configs(struct hisi_ptt *hisi_ptt, struct perf_eve
 
 	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
 	ctrl->format = val;
+
+	val = FIELD_GET(HISI_PTT_PMU_PATTERN_MASK, event->attr.config);
+	ctrl->pattern = val;
 }
 
 static int hisi_ptt_pmu_event_init(struct perf_event *event)
@@ -1025,7 +1043,12 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 		return ret;
 
 	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
-	return hisi_ptt_trace_valid_format(val);
+	ret = hisi_ptt_trace_valid_format(val);
+	if (ret < 0)
+		return ret;
+
+	val = FIELD_GET(HISI_PTT_PMU_PATTERN_MASK, event->attr.config);
+	return hisi_ptt_trace_valid_pattern(val);
 }
 
 static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 46030aa88081..c1636676c8c8 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -41,6 +41,7 @@
 #define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
 #define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
 #define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
+#define   HISI_PTT_TRACE_CTRL_PATTERN	BIT(8)
 #define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
 #define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
 #define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
@@ -89,6 +90,7 @@
 #define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
 #define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
 #define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
+#define HISI_PTT_PMU_PATTERN_MASK	GENMASK(39, 36)
 
 /**
  * struct hisi_ptt_tune_desc - Describe tune event for PTT tune
@@ -127,6 +129,7 @@ struct hisi_ptt_dma_buffer {
  * @filter:    filter value for tracing the TLP headers
  * @format:    format of the TLP headers to trace
  * @type:      type of the TLP headers to trace
+ * @pattern:   pattern of the TLP headers to trace
  */
 struct hisi_ptt_trace_ctrl {
 	struct hisi_ptt_dma_buffer *trace_buf;
@@ -139,6 +142,7 @@ struct hisi_ptt_trace_ctrl {
 	u32 filter:16;
 	u32 format:1;
 	u32 type:4;
+	u32 pattern:4;
 };
 
 /*
-- 
2.33.0

