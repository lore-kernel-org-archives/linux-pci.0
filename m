Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3655295D;
	Tue,  8 Sep 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876342; cv=none; b=mcl7rTwK1T2XSG/wT5CZkluLe/t9fAk5sBo7+T93kvMEWiTECDCqkelA6U1NDtz13rreMJt4jJIZmJdSXXB7dBRdgCborK0lt0QlvQZsq/82Blw9IzMB9/VPXufduVsDhS11cINFx8iyAsnTTgQgdWw22ZuwjdDqiqiHtwUgNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876342; c=relaxed/simple;
	bh=oNagAoiLPeAHyFczTOdhq3KY2IDlLHS+ZRGsujd9c+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOFBX9o2BjreHZIy5npvuvwATaqLVndd1R3FmYviDXGmo5sTRXQQulImbNOJ+2c7+7tlzqxASOMWhj0duRe/Yw2/xNnY4MeJOK7vRSIIBYBP0+RMOqKaTDW2E0qf1mCOkl8UstH0N5lwLQoE8RX3Fp5CWc/84cJJIJQwB8qpMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KnNaAEdw; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KnNaAEdw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pd9x46nrmAOaC2BjKspVDuYVO1rQ3lmlYo9Ncu9f5iw=;
	b=KnNaAEdws/1ozk/JlA0HrBb4EKhznmfvIy2+XmntI8y+3YaFztipNOLb3wVX2SS9sDILDYyky
	kKIaZlApFm125MuxT2WuB5nc03Ih055e36P7Lta7L4Z6qnH1O3E/0Q9ETWlxpm7XKXrH8rEGU0G
	5BIKROtvtGgOI7AqBhCDutE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hfQRB6H2pz1cyPY;
	Tue,  8 Sep 2026 21:54:30 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BFCA40563;
	Tue,  8 Sep 2026 22:05:24 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 22:05:21 +0800
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
Subject: [PATCH v4 5/8] perf hisi-ptt: Add parsing of supported message types and proto length
Date: Tue, 8 Sep 2026 22:05:06 +0800
Message-ID: <20260908140509.2485649-6-liusizhe5@huawei.com>
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

Classify TLP messages by Header DW0 Format field and Type field for
both 4DW and 8DW formats, according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2.

Parsing packets into:
- MRd  (Non-posted Memory Read request)
- MWr  (Posted Memory Write request)
- DMWr (Posted Deferrable Memory write request)
- Msg  (Posted Message request)
- Atom (Non-Posted AtomicOP request)
- IO   (Non-Posted IO request)
- CFG  (Non-Posted Configuration request)
- CPL  (Completion request)

The parsed message type is stored in pkt_buf->pkt_msg_type and will
be used by subsequent patches to select the correct field layout for
DW1, DW2 and DW3 printing.

Classify protocol defined header length by Format field, according to PCIe
r6.4 sec 2.2.1.1.

Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 89 +++++++++++++++++++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 40 ++++++++-
 tools/perf/util/hisi-ptt.c                    |  1 +
 3 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 00bd9309df68..c9515676ba5c 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -79,6 +79,94 @@ static const char * const hisi_ptt_4dw_pkt_field_name[] = {
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
 };
 
+/* TLP message parsers below according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2 */
+static bool hisi_ptt_is_mrd_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0 || format == 0x1) && (type == 0);
+}
+
+static bool hisi_ptt_is_mwr_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x2 || format == 0x3) && (type == 0);
+}
+
+static bool hisi_ptt_is_dmwr_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x2 || format == 0x3) && (type == 0x1b);
+}
+
+static bool hisi_ptt_is_msg_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x1 || format == 0x3) && ((type & 0x18) == 0x10);
+}
+
+static bool hisi_ptt_is_io_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0 || format == 0x2) && (type == 0x2);
+}
+
+static bool hisi_ptt_is_atomic_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x2 || format == 0x3) &&
+	       (type == 0xc || type == 0xd || type == 0xe);
+}
+
+static bool hisi_ptt_is_cfg_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0 || format == 0x2) && (type == 0x4 || type == 0x5);
+}
+
+static bool hisi_ptt_is_cpl_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0  || format == 0x2) && (type == 0xa || type == 0xb);
+}
+
+static int hisi_ptt_parse_pkt_msg_type(uint32_t format, uint32_t type)
+{
+	if (hisi_ptt_is_mrd_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_MRD;
+	else if (hisi_ptt_is_mwr_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_MWR;
+	else if (hisi_ptt_is_dmwr_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_DMWR;
+	else if (hisi_ptt_is_msg_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_MSG;
+	else if (hisi_ptt_is_atomic_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_ATOM;
+	else if (hisi_ptt_is_io_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_IO;
+	else if (hisi_ptt_is_cfg_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_CFG;
+	else if (hisi_ptt_is_cpl_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_CPL;
+
+	return HISI_PTT_PKT_TYPE_UNKNOWN;
+}
+
+static int hisi_ptt_parse_pkt_header_proto_len(uint32_t format)
+{
+	if (format & 0x1)
+		return HISI_PTT_4DW_HEADER_PROTO_LEN;
+
+	return HISI_PTT_3DW_HEADER_PROTO_LEN;
+}
+
+static void hisi_ptt_parse_pkt_info(struct hisi_ptt_pkt_buf *pkt_buf,
+				    uint32_t dw)
+{
+	uint32_t format, type;
+
+	format = (pkt_buf->pkt_type == HISI_PTT_4DW_PKT) ?
+		  FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw) :
+		  FIELD_GET(HISI_PTT_HEAD0_8DW_FORMAT, dw);
+	type = (pkt_buf->pkt_type == HISI_PTT_4DW_PKT) ?
+		FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw) :
+		FIELD_GET(HISI_PTT_HEAD0_8DW_TYPE, dw);
+
+	pkt_buf->pkt_msg_type = hisi_ptt_parse_pkt_msg_type(format, type);
+	pkt_buf->proto_len = hisi_ptt_parse_pkt_header_proto_len(format);
+}
+
 static void hisi_ptt_print_raw_record(size_t offset, uint32_t value)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -114,6 +202,7 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 	uint32_t dw;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_parse_pkt_info(pkt_buf, dw);
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
 	if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 6747878b030e..f02ba29dfe00 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -7,15 +7,18 @@
 #ifndef INCLUDE__HISI_PTT_PKT_DECODER_H__
 #define INCLUDE__HISI_PTT_PKT_DECODER_H__
 
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 
-#define HISI_PTT_8DW_CHECK_MASK		GENMASK(31, 11)
-#define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
-#define HISI_PTT_MAX_SPACE_LEN		10
-#define HISI_PTT_FIELD_LENGTH		4
+#define HISI_PTT_8DW_CHECK_MASK			GENMASK_U32(31, 11)
+#define HISI_PTT_IS_8DW_PKT			GENMASK_U32(31, 11)
+#define HISI_PTT_MAX_SPACE_LEN			10
+#define HISI_PTT_FIELD_LENGTH			4
+#define HISI_PTT_3DW_HEADER_PROTO_LEN		3
+#define HISI_PTT_4DW_HEADER_PROTO_LEN		4
 
 /* Header DW0 fields for 4DW format */
 #define HISI_PTT_HEAD0_4DW_TIME		GENMASK_U32(10, 0)
@@ -27,6 +30,10 @@
 #define HISI_PTT_HEAD0_4DW_TYPE		GENMASK_U32(29, 25)
 #define HISI_PTT_HEAD0_4DW_FORMAT	GENMASK_U32(31, 30)
 
+/* Header DW0 fields for 8DW format */
+#define HISI_PTT_HEAD0_8DW_TYPE		GENMASK_U32(28, 24)
+#define HISI_PTT_HEAD0_8DW_FORMAT	GENMASK_U32(31, 29)
+
 enum hisi_ptt_pkt_type {
 	HISI_PTT_4DW_PKT,
 	HISI_PTT_8DW_PKT,
@@ -38,11 +45,36 @@ static int hisi_ptt_pkt_size[] = {
 	[HISI_PTT_8DW_PKT]	= 32,
 };
 
+enum hisi_ptt_pkt_msg_type {
+	/* Types do not support analysis */
+	HISI_PTT_PKT_TYPE_UNKNOWN,
+	/* NP-(Memory Read requset: MRd) */
+	HISI_PTT_PKT_TYPE_MRD,
+	/* P-(Memory write request: MWr) */
+	HISI_PTT_PKT_TYPE_MWR,
+	/* P-(Deferrable Memory write request: DMWr) */
+	HISI_PTT_PKT_TYPE_DMWR,
+	/* P-(Message request: Msg, MsgD) */
+	HISI_PTT_PKT_TYPE_MSG,
+	/* NP-(AtomicOP request: FetchAdd, Swap, CAS) */
+	HISI_PTT_PKT_TYPE_ATOM,
+	/* NP-(I/O request: IORd, IOWr) */
+	HISI_PTT_PKT_TYPE_IO,
+	/* NP-(Configuration request: CfgRd0, CfgWr0, CfgRd1, CfgWr1) */
+	HISI_PTT_PKT_TYPE_CFG,
+	/* CPL-(Completion: Cpl, CplD) */
+	HISI_PTT_PKT_TYPE_CPL,
+	/* Type max in enumeration*/
+	HISI_PTT_PKT_TYPE_MAX
+};
+
 struct hisi_ptt_pkt_buf {
 	const unsigned char *buf;
 	size_t pos;
 	size_t len;
 	enum hisi_ptt_pkt_type pkt_type;
+	enum hisi_ptt_pkt_msg_type pkt_msg_type;
+	size_t proto_len;
 };
 
 int hisi_ptt_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf);
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index ea659947c27f..78817ae7a8ea 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -63,6 +63,7 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 	pkt_buf.pos = 0;
 	pkt_buf.pkt_type = hisi_ptt_check_packet_type(buf, len);
 	pkt_buf.len = round_down(len, hisi_ptt_pkt_size[pkt_buf.pkt_type]);
+	pkt_buf.pkt_msg_type = HISI_PTT_PKT_TYPE_UNKNOWN;
 	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
 		      pkt_buf.len);
 
-- 
2.33.0

