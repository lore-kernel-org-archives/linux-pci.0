Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC34137B5;
	Tue,  4 Aug 2026 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814767; cv=fail; b=MLSXer4XrGfOnz6A4kpkV9+vJ2rUQPRWjZ+PFFD2uYdDtYrszYpbcbtXUFhx/OcYKZaNd7dAwkTDTAX+F3NOymOkeYHPAiAyeQIpZmgjJpl25APXg6n6VKuctzeFahd33MlfKM6AlrWPnjRv5UUEehE9eVl3/CCci5REJY7abuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814767; c=relaxed/simple;
	bh=VYn48wf4nphUPuHMmdP7FDneT3Wbo99pxxNtVFXcMR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plE/aI1rjEw7QGt7oq2WZe5LH2y0mjUaM8t87pWyOL4xiXzPi5Hf7EkU0blIua3q2X0NuyEzK/emCdSJiDPfFAKIskdgPNZCwgGewY7nW91UVPTV5qbtCkq+v+GcwhILL/ojbQreOPiNvJW5dWR8ispkbfHAB5Xdnn00sJJaRvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jgKX7GWE; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jgKX7GWE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss19/wROey3GcjwYkAWhyY8jYlbNG5r/ow3wBHDPTNJWx+uOvgXsM70ZzbtcgcR9HaJ6huLfMKb1CnBWwWyR1ok8yY4T6oF0ZNeRZA4t2DsraBIJiC0PpY57a6/4FYDHQe+3rYKTFUM4zfmJlwYPXbu5kyiiv66GN0KvQn1L0O5OZLQeaXs9jW+e7uOrIV5lO8/s7EieD0KF5reZnBqoD07cgi49t8tG3e9Yjyf8oIT+in4oTQpESOHM2R3eWn9GhQzgJ5/Cw1Q3ekFe88u8Mx/HIZptbzG6IRm8gF7DQOPyXHYCl+wsrszeGHypBuEsx3sL/+VmVjFO6U0+dr/j4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whYU13dhjcM3WOKxRgXh7kudZ0y5dbh4ts/JMmrPVfQ=;
 b=ZDNV8UYZ0u8IHXhwvQBcGya1EpBcarkdk/DRrT4rI3K0Y9P2qmrZFLmSHpJXm/tV+Eg0/ivpPfVsrZzoj5hKFqWDAySw81O6/PQa+kdmylX1X1VbkQx/0ICcmZgN9YDIA4KT8SwEMSJ1E/c+ezBx3DFfap+Td64qrNm81GB5Q+Av4OM3UwkJNwrq1z1+s+THPwBmyHTPlUduESCCFQuPlvlHIIgmlnb06SWDZScgwMJber1hxkaSFcuJ7sa+3cManwvhwffLLF7Hq7njXy3mrnc+Nw9yRZSLNr4FibS2AKj24NhDaWHTvrs64JiHC7tjy1t0uup+t5hhC3r0tGSDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whYU13dhjcM3WOKxRgXh7kudZ0y5dbh4ts/JMmrPVfQ=;
 b=jgKX7GWEihuLtCkitWGVVK5KBgQ1HosFevUgWoH7I+7jKYzg5B8znRDCnvxGvc+NhF5Bj6Ogie7Sp7mLjqi0icsOrQCXFakyN78TcuWy/iuA1mCtMJuYp8CcVjJrXnH9uakDcWp+zKyOD2vEKAuSXgoCEC/5XzxdstQIUnOvv4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7598.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:347::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request helpers
Date: Tue,  4 Aug 2026 12:38:53 +0900
Message-ID: <20260804033855.2115817-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d8eeca-e73a-47d6-3f70-08def1d9ee35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iePykcwgVSBDHcPrJ1gxIIenfSbKgbInTJQTYc2YLt/4Z8L1FQ91kCdBTyt3qKFN8mw78kb7zsZHIUJYTxTMjMbrsA82VfS28ICpXSHeO6ywlQKUPoPk0GwQBbAAFkBsqeFkgPUVJQ0F4SCh1B4gIyDoFN8wqL6HfW/PDtTkmYh2h55VJw5Q1speg+6pcbGMSvE02+EaaH5ERV0/4pC9E7b2HzPJo0KznP9JO2fBF7VJVZxnB/MPHUwOIu6FH34WIByHlaNSuzqHhfXKX6QTsKReAAXulBeVc/iE5v0Y7mDwIc7cyzhdSnHnbWrC9cwW3wldJT/kKCBQ3a9fc7xBHs3dUtDnpP4ycCgqEDAWBDSBQyDbkKBCzK2JVBuEta8KFGsSIAMVO5LhYE0McfpT2ngtHZ0MX5voV+qqri+z1WJ/a0GpOJ5yQPOxfMbLC51nnSGE45SzgIkYh1EQP4VMaTYeDZKeN3r8KPaXgoiv7sReP28mDzex/Mh0VmJMkiroDFvxkYK7zEbBk74RvNwSf2TPJE9E9snX7eW1XPm2s6okT6X/ONZvh+FdRFABrEpxAz/fNVt7095lc51VKqMeGCS89dO7OAn9T8ldcU6KnGff8IPQR+a+OBtTkJPiU/MLlNMTywVWia8WvoMl23lVmqkiKvEvn9QKkD8Tp8Omw0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?byoa7vkCBZCeVCwAG0t1IKy3eYnF+hVyAhiXCh81S3sUJ5oAIf5uqgyXs4wF?=
 =?us-ascii?Q?RF5evXdqenXoz0qEQr46HDqjXQqJ+2fRbB5qfOPT/O/9CsgEmyEzytcJWLGC?=
 =?us-ascii?Q?Lp6lQtUHQMY9qR1QUT6+hRORHmfPd4AIcQrrAzphhUOaxLm0dfWSq7sSFkkK?=
 =?us-ascii?Q?8UgLA050xaPtF58+RnucBJe9NZqBkDHNcIN6z/HmDdY6tE9lKjLzwEEoQXV6?=
 =?us-ascii?Q?YRD+hd2hG+QsIs3xuxEI4mELem97EZIuI3jyQsJ3FSeDYvyFkzNLsl0n9fWJ?=
 =?us-ascii?Q?mmXVOXTtHVC+n875V7ZpJzn1GFy2lT4f466D3gbwtlXYcGskGMjaktuDcQ/p?=
 =?us-ascii?Q?CeaV+W0hYAWrvrfkOMdqvqgazmvDhlY1RaBw9xP4R/kFuYQ/MgpYnO1oLv10?=
 =?us-ascii?Q?WDgV5I+/WE4hxAKWuC2/bg7qXBBxAviSX/24tjXYSJXUy64v9vR5V5wug6Eb?=
 =?us-ascii?Q?lo2axVoJJECmnnQ4XiW+33CG5JND4GtTaEQIGP7W4mBdp4hVrKJevv9divMB?=
 =?us-ascii?Q?YkLFlZmTB+Xxk/Qh4jr8VGt0t3Z6CCsXWz/4EDeo/pwjtKiA5HkNVkJzDWIC?=
 =?us-ascii?Q?rkQFJxnXJJD/QV8f3S2JRWv440JV3GVFuEVtYAnXrdUp0g0DCnye48M6cUnu?=
 =?us-ascii?Q?yMx9qvoKVfl8h9MdkEaVkjh+uWwWPtd4xZxF+WFBR8Xoln6gE6Qosh05WNDk?=
 =?us-ascii?Q?s7GibbWYNYs7frqiaRYvHeatmvheFY+mWLqFWy5TAFHIHMpLP2c3UAuGm06w?=
 =?us-ascii?Q?gOQjQy5MKGX7Oe2ABmTOUs46yibHLoaHZAivZMvueKU//bHu6srusfvNnBdV?=
 =?us-ascii?Q?9Uh9Dr92aBOiZfiXHaizytQ5zD1IjHh79TQzpQ7ujL8/5/53LGjW4g2dOtX8?=
 =?us-ascii?Q?C0WkbBY/Xb/z3MYc6fAqm1whLOPGwj0jf7+iaYotyXvGJ/8TXpsmiCxngJhM?=
 =?us-ascii?Q?/padUdJHGmvD1hiG1Lm8N47B9uBwVLibhbgV9NhmTTczKnjRKZTGU5JtBa07?=
 =?us-ascii?Q?j7ePIhRqprLFh7nrdUledvmDCbnb6jsF0w9jkCRcgtpwQtCttBs0sXLAXhc2?=
 =?us-ascii?Q?apOjeacReRR2dAojfXR7DoC+1hgLnUJLVwqyqEonLLC3s5skvF7hgNjwgEnF?=
 =?us-ascii?Q?PK2/HG09DOJbyVmosQflOVcKkMPjU5ngpSrHGdNOwUctPtC80a9PK6/NLs08?=
 =?us-ascii?Q?batEN9aWOL2g6L8LYLGMjykk6SFc7hW0UANvd5RA/7CPlNGwTdgYCQplM5ty?=
 =?us-ascii?Q?OMIEIjIN/DzMQUfMkUCl251uGoH70nPI6PKkXu7f/w3yO6wr9cq5P0e5pZkg?=
 =?us-ascii?Q?5HGZGHWrHg8quz9f6ao28odBfv585fXboaXwGpvQiY42zopbIhAMXAnOw85d?=
 =?us-ascii?Q?27rjRi/ESGA6RTQ+Ka9YC9YZt+jyyYBnY7zjpdudRAqA5/FKDDRXQdgwrgHu?=
 =?us-ascii?Q?RO+v/eX98YWWRLxK6onrqw4iJ4mz/BtMVAFGt+s7BstaAgs4DW9Y5cXHZN63?=
 =?us-ascii?Q?OPRslaGLJsKO+UFkbriLM+kxq/2uLJ2ib+6QJ+tTaQmfQ4fmp7pqFLrlFyl0?=
 =?us-ascii?Q?N8uvXonM445NFM6NVPLCTo+JSFQPnK+9S32y6mdEGC1mT27Bf/B2IRUe2IxY?=
 =?us-ascii?Q?kJP3oPxdZedsW/2J7mzTNOKKxFbJzosJP2NyCkLFerijnYeJ+FlPmHpapTMg?=
 =?us-ascii?Q?kU+WtWrWxyIpNRO0W34cNaI/M2w3ricKGjFOCjRezRMlK3yDUdUBPIl3gfKT?=
 =?us-ascii?Q?EE6X7TgX9HBFXhJjXZ+7pmNL8ROTvDsxBciJ/AgYaBf+nWeBxUxC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d8eeca-e73a-47d6-3f70-08def1d9ee35
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:04.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzOE74D9PQ5eeEIw9v1e0EXePFfKbJ4IrZ1pRW4yC1jgDW0UjHAN6YuMiXiQwNIUOkDXHrF/vTfs0aTn7PHaHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7598

Endpoint functions that expose endpoint-local DesignWare eDMA channels
to a remote host need to reserve exact hardware channels and hand
interrupt ownership to the remote side before publishing the channels.

Add DW eDMA-specific helpers that request a write/read hardware channel
through DMAengine, keep the hardware-channel filter private to dw-edma,
and switch the selected endpoint-local channel to remote interrupt
routing after the channel has been successfully reserved. The matching
release helper can quiesce the channel while it is still remote-routed,
then restores the channel's default routing before releasing the
DMAengine reservation. This lets callers skip quiesce when unwinding a
reservation that was never exposed to host programming.

Release is best-effort because its callers cannot abort teardown. Report
a quiesce failure locally, but always restore the default routing and
release the DMAengine reservation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v6:
  - No changes.

 drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 14 +++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1f893dc54c79..4c0d2bba755b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+struct dw_edma_delegated_chan_filter_args {
+	struct device *dma_dev;
+	bool write;
+	u16 id;
+};
+
+static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
+{
+	struct dw_edma_delegated_chan_filter_args *filter = param;
+	struct dw_edma_chan *chan;
+
+	if (!filter || dchan->device->dev != filter->dma_dev)
+		return false;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
+	       chan->id == filter->id;
+}
+
+static int dw_edma_delegate_chan(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	int ret = 0;
+
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		return -EINVAL;
+
+	guard(spinlock_irqsave)(&chan->vc.lock);
+
+	if (chan->configured || chan->status != EDMA_ST_IDLE ||
+	    chan->request != EDMA_REQ_NONE)
+		ret = -EBUSY;
+	else
+		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
+
+	return ret;
+}
+
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id)
+{
+	struct dw_edma_delegated_chan_filter_args filter = {
+		.dma_dev = dma_dev,
+		.write = write,
+		.id = id,
+	};
+	struct dma_chan *dchan;
+	dma_cap_mask_t mask;
+
+	if (!dma_dev)
+		return NULL;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
+				    &filter);
+	if (!dchan)
+		return NULL;
+
+	if (dw_edma_delegate_chan(dchan)) {
+		dma_release_channel(dchan);
+		return NULL;
+	}
+
+	return dchan;
+}
+EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
+
+void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
+{
+	struct dw_edma_chan *chan;
+
+	if (!dchan)
+		return;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (quiesce && dw_edma_core_ch_quiesce(chan))
+		dev_warn(chan->dw->chip->dev,
+			 "failed to quiesce delegated %s channel %u\n",
+			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
+			 chan->id);
+
+	scoped_guard(spinlock_irqsave, &chan->vc.lock)
+		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
+
+	dma_release_channel(dchan);
+}
+EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3c8e2ef9dee0..944469258b8b 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -153,6 +153,9 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id);
+void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline struct dma_chan *
+dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
+{
+	return NULL;
+}
+
+static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
+						  bool quiesce)
+{
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0

