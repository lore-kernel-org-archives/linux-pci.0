Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD654B1BC;
	Tue,  8 Sep 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876338; cv=none; b=L2Qnj03cf3pp5qRa55TM0HVV6Q2JfIB/tlNiGUF7mq4peNl8B3GAYYJo5nb5cjmnZj/gJ6CvDL9KYS9v9Ks+kSytrL7VvOTg/dbsSCPHF02RpYv75S5DM6X4Dmbc1pv5GA2hQtZrmh2gMmOpJhmTUecT1p9dGmlUL/fyy7pp9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876338; c=relaxed/simple;
	bh=uv31mMGJY8917i0D41i+PSbwTCNxtolCmItMY7GqkH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2gtsmcaju5hnD339+WMM7E3oNuhTL+fwxTGxsuHSDnP2/+CioazLO6a2UQ0b/zm+nJf0RhK+uMLQQMYDH0JK0Q6MMEcaWlY19aNi+hWP2NY6/fHPxWQn/Vyks28HYRdB4KJOrkxdVGl/lXkFgjfRcfAbcTT05PlJclVi6SRKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KWuF6IC6; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KWuF6IC6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SHFtsegYkSXAAQ6VLTBIGRfXAcm81uMjTTor0MXHuTI=;
	b=KWuF6IC6bGKi3ranAbI8gv4Ii8gUY2i6kQGwdMJTdCvr84XKLmPVUEiqnlsqQezcuJF0YoE9V
	n+IXuXFtWfSPpwbhu1sHzejM/vwmpPiFHKShH/JP3LT0DdkhFBdE+eZ0at7vhrFHa4xhAltw2w9
	zzRxS6N5Gufcj4+3IEI7YS8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hfQR204Zsz1prlJ;
	Tue,  8 Sep 2026 21:54:22 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 691AE4057A;
	Tue,  8 Sep 2026 22:05:17 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 22:05:14 +0800
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
Subject: [PATCH v4 2/8] perf hisi-ptt: Complete the field names for 4DW and 8DW packets
Date: Tue, 8 Sep 2026 22:05:03 +0800
Message-ID: <20260908140509.2485649-3-liusizhe5@huawei.com>
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

Add the missing HISI_PTT_4DW_HEAD0 entry to the 4DW field name table
and add the HISI_PTT_8DW_CHK_AND_RSV0/HISI_PTT_8DW_RSV1 entries to
the 8DW field name table so that all DW indices have corresponding
names.

Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index ef72223d3854..766665414ad8 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -54,6 +54,7 @@ enum hisi_ptt_8dw_pkt_field_type {
 };
 
 enum hisi_ptt_4dw_pkt_field_type {
+	HISI_PTT_4DW_HEAD0,
 	HISI_PTT_4DW_HEAD1,
 	HISI_PTT_4DW_HEAD2,
 	HISI_PTT_4DW_HEAD3,
@@ -61,15 +62,18 @@ enum hisi_ptt_4dw_pkt_field_type {
 };
 
 static const char * const hisi_ptt_8dw_pkt_field_name[] = {
-	[HISI_PTT_8DW_PREFIX]	= "Prefix",
-	[HISI_PTT_8DW_HEAD0]	= "Header DW0",
-	[HISI_PTT_8DW_HEAD1]	= "Header DW1",
-	[HISI_PTT_8DW_HEAD2]	= "Header DW2",
-	[HISI_PTT_8DW_HEAD3]	= "Header DW3",
-	[HISI_PTT_8DW_TIME]	= "Time"
+	[HISI_PTT_8DW_CHK_AND_RSV0]	= "CHK & RSV0",
+	[HISI_PTT_8DW_PREFIX]		= "Prefix",
+	[HISI_PTT_8DW_HEAD0]		= "Header DW0",
+	[HISI_PTT_8DW_HEAD1]		= "Header DW1",
+	[HISI_PTT_8DW_HEAD2]		= "Header DW2",
+	[HISI_PTT_8DW_HEAD3]		= "Header DW3",
+	[HISI_PTT_8DW_RSV1]		= "RSV1",
+	[HISI_PTT_8DW_TIME]		= "Time"
 };
 
 static const char * const hisi_ptt_4dw_pkt_field_name[] = {
+	[HISI_PTT_4DW_HEAD0]	= "Header DW0",
 	[HISI_PTT_4DW_HEAD1]	= "Header DW1",
 	[HISI_PTT_4DW_HEAD2]	= "Header DW2",
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
@@ -100,7 +104,7 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
 
-	for (i = 0; i < HISI_PTT_8DW_TYPE_MAX; i++) {
+	for (i = HISI_PTT_8DW_CHK_AND_RSV0; i < HISI_PTT_8DW_TYPE_MAX; i++) {
 		/* Do not show 8DW check field and reserved fields */
 		if (i == HISI_PTT_8DW_CHK_AND_RSV0 || i == HISI_PTT_8DW_RSV1) {
 			pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
@@ -150,7 +154,7 @@ static int hisi_ptt_4dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 
 	hisi_ptt_4dw_print_dw0(pkt_buf);
 
-	for (i = 0; i < HISI_PTT_4DW_TYPE_MAX; i++)
+	for (i = HISI_PTT_4DW_HEAD1; i < HISI_PTT_4DW_TYPE_MAX; i++)
 		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_4dw_pkt_field_name[i]);
 
 	return hisi_ptt_pkt_size[HISI_PTT_4DW_PKT];
-- 
2.33.0

