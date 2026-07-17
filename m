Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3892F7AD2;
	Fri, 17 Jul 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264813; cv=fail; b=XfL+xvSJWiXnqxLun5nc4oxjnWOvEVqXj9XsQW9KPp2njLtb1OgEw3gHOUE6BdI9VCPTZM2aLeho5MpgfXcRPK3iIRY/uajVY+i2EB6hBqx453HN6xgvDrMgbvZKfQ1T4DMC4S5iPxM3UksUSpDaz1EWTXKAC1gtZ0nwu/11O80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264813; c=relaxed/simple;
	bh=7+05elsA4JMwhqItHdmeRgFx3eA0t2lBAPpIoouk88E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlMoHxuahLWWPBxJB+QC8x7JhP1GHGiUgFXRA30k1z/F4h2Xkpv4mQs0SgGGg3/7yxBd16ph7XhnMLKpCvHTAT8pniYeYNUZxEtRkgtsGt+f4zKjDnNuIqYOYaSINaDkCn2SWqSvgTpfILGZugVmNRi0kAu9ueiiDNi/7MQ9Fz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QqB+5zmn; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QqB+5zmn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnGbIu7FKw7W/1/tbeswgzl9/9YdSDCyfrRIHEdmLmqo+S2oDpRrazj62BVtvPd+i8IzFCvAGpMupgL0UHvHrKZ+np0Duq4IJGEc8WRoBTi0OBP8WknCcG6mwAHVfT9niHu22gsbxUHdwvO83VRT5FguFJOdH1J2tyOg0Sp7YgWpPE0lYgaT0uBJz420u/FQQ42zd49E7al+4ystHgMuy+A4BemMY/KT5FrThC3i0gUfppni8Zzwh0jsQ5I2RB+XS4oObN56XbcxyarNTCHSwE/gJl+nlZJm8qlOZoHW84tXcFQaYIzbOPlDnhslTyasCVEMiIKzSqLBLBUHFam0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eANc/FMiKHCc+cDCpsk1WH7/I9P5ZVMoA9VtvSrlBg0=;
 b=iaMEVeG6LQq6Wb6k3y7GM7s15V23a0CUEQIcnjS7ZqpZiHja00w+eRfE0b87aAmp46x56SrMdY4VFLXK0nQ3tubnV5Ud1RCvu/vie5jCUxGjHcJ2q4UMoDv4tWapKevk+cvQeY5vNuLtjWb+oIRyO/7nXpMqSO78d30vW011A4RQln0rGf9d0jcUwytERx/WGBC0RRHoHOibLTZm8wR38v06ulxXItYzABs/PFPkw8KuY0Ck4n/GuaB+fEiE8rQ89YGty/Qs+lkAAV5qQKpSPEblrrjQV2gAceoQlGalO1KTtaW6JSRGPPI2TLjpZPtqYK54drBPDXRe2EDYQU+7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eANc/FMiKHCc+cDCpsk1WH7/I9P5ZVMoA9VtvSrlBg0=;
 b=QqB+5zmnWoYAROTdi/y87p1Z+Yfo/fgdMGJu+5hl9RuWSoaXHkJdOuuYHjo/SV5auU1R1z3sTjj6kV+4hzWnaxMvXsBEbRN7ynsBkTBbbP8e+6ogiZmI+lXndSp5TzZhX3l7qM33fVPtlJ33tRJ5cwwWi0WHm5jINW97tTi9O5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 5/6] dmaengine: dw-edma: Add delegated channel request helpers
Date: Fri, 17 Jul 2026 14:06:34 +0900
Message-ID: <20260717050635.2145014-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050635.2145014-1-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0113.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5b585c-0f93-4a1b-9ac9-08dee3c13169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1V09A4pQQ+gO4HNGwSypzTHUmEizGp+ip5voxlDuWZZSBnUA388XdEqKQYs8iLn60UaYMioG76sz+fqN8St+uz/TQCrJGxX5Y87bTH5FpGZVJjHR+pnBNhwPTS2Tex7CxAXlRD/ruJOZrC7547CLZvc5y4v8CTy7AdOTkeK8+jcrVwQht97Lb7XV6/wZaeDp5GPv51D9ZDB6E0aDbM6rkiW1fcWLEn24LEbDvakO9ZtR0/SJ4pgH5mPFBCOeGipRbUYbeyO6XLQfWLFuwTY1cSdcg32UmS6STtCMhoI7XGOyM33hkA08SURRAOSxQQkccrodfvrkZKUYL0yUq2+HxDuVI6P+/sfIR9IrNrDaXUkebm3qwsKLElSNCXWBkk+/CWbE19pECIL1S+LJd22j+nPZzjsuQ/H/hH6Sm5KELSRmOc7p4WG0jenNovaxrX6s/GO3c7rYOHQq0Qs+5Xk7r7UnAN0qfbUD8keHnpj0M3uLTEkv1AP5OI/0V79ML7p1IgmsrBXJ45rjWFB3jyJfCztfjTBKl3LN8SAB5fRTxH7o8i5zOSuYWm3ZjgZZV/IQEx6MKkeNVVo15hjnFspyTKgu7fbDU3nJuhDXqt8W2ltHn/Az/DhsRSCAwn1hNuv/Ohz4WPMkJP/pv+bDSX5XJjEiz7U1Mjq9vv1lWENZJC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPYVzD8tFDYyHRn2oruIz+N5FgjOz2Xm+e76xBPfoq04jWs1gy7pY39dxXJ6?=
 =?us-ascii?Q?yeK8DK0xpDSECVjoKfp+VVKYZRQf49TU4xCl5M/Dsok/0uzPwVfwnmPtoJBt?=
 =?us-ascii?Q?wZUV8PPF2SLUtSSJlrNOI0HNWyaISjkGqnWXjM9srwgiAWEaxUKODp5ntl7h?=
 =?us-ascii?Q?PF5h0/stTYUGBH72v1JFfTWJUm00PKVVH3jRKLkd8rAQKRQgtPNdhLo1sLME?=
 =?us-ascii?Q?T7+WUZHk5zqGSuyzkH8mNcUX1AaUtCUM6/oV7dFbCWKKESkR57yJCcfOZ4ul?=
 =?us-ascii?Q?2nuJbq9fkM2k/X+DikApHGqxj8Qcm3M3ENhCScgBEsVxtqfwRWwDW5cmijIK?=
 =?us-ascii?Q?k44ZG+9kfSzjSNV7H7tfItiiwsgC/hiR316nr9XBShcyHA3PCSky/hHmeK+L?=
 =?us-ascii?Q?fCiQAsfYLRh7X1VVV3DNLlZ+qaGUG3hErTEqYLgFV37rKY2cAQt0ADlfaJ3W?=
 =?us-ascii?Q?orxD+J8yw5Yt6yiAQAluI8iY1exs4VRXZXRvkHGibs0gvlE9ebNTggBxyhcO?=
 =?us-ascii?Q?GcUeY9wiG4cdngeGfVp1oofziDQMIWYq5y+LLNW4QCaVD/c76N60gwO832KC?=
 =?us-ascii?Q?Q1MXTI+XAkLTnkdchnE6S7P/HxTnu8MeVyf3yLTzdiEoh7evn8w1HEkgxNi6?=
 =?us-ascii?Q?ONoNCmYpjPCHwvg6eEvUPqlmoygsALVN6X5JOexVk2aP7NFn8b8p4L+1W62o?=
 =?us-ascii?Q?JKcIIQmNZkr+ETucwwYbjB0P8PREMrZpnjyLTKtMECNcLjHUUTvxaKeZa7Wl?=
 =?us-ascii?Q?f+NMS8+C05znL4p6APIGmxdXPWbLD6sbcMJEYqQrTY0vsiaYNlz/dXvzw124?=
 =?us-ascii?Q?+rGNL2Ze1X+F+6ZAn/zzS6/PYVbBt4ohevmFgpN/wJp19eg0pYYiXXiaFGXx?=
 =?us-ascii?Q?a5NPddZqbGRZjtuhoEXZQd9wpv/niz4WAC7p2d+uDka3kQ4VE6T9HHJrppqF?=
 =?us-ascii?Q?zbbUu+NsFaMe4UqoCKlKvzmFO1PnOOZ9CuhNrLY2OE4c9/b9d5Oc/O1jvN79?=
 =?us-ascii?Q?VHEVTejfaF8nnqo5RxC2iTKH6Y0Aa8JXAHbgDggBm1118/0vHFyTL1knMw4E?=
 =?us-ascii?Q?awMzEBvvEthWS4yWLRYKWCRGcRKHimUsuyiRHQhK0/0f2H9LwBTueFBODf/A?=
 =?us-ascii?Q?IgxA8/LFmly1bIVEDh8xS1ktp6yfZbOWDiVJwMw5RArecgNkkRB+chyC80NF?=
 =?us-ascii?Q?jtWXdKuw3+vWiohzs2MsQy3AfUoALSBCwbOLbNuDWpQxV0QI7y60Je1WpcNc?=
 =?us-ascii?Q?Z/Xf08Ds2cE+bnT5iNhJZugrQXzoe1xS8jsmwCz+d+4EF3MSM4cq4JMmCDet?=
 =?us-ascii?Q?ImY2SzEfknE8N2X5Pv+7pnmKWgCRqHncT2XqOQ87TMV43Nm+hxtgEdoWm9NB?=
 =?us-ascii?Q?3NsntqVgRNalCos6VCoC6a+Ji8spXcpGzMVxPlQXRX2s+CV6yRO942/5dbWz?=
 =?us-ascii?Q?r/IBBruLhnaQaXCjoYfAtFynSsX623fvcY5+w2m9utuqzoYWWt7BGKTbe2+W?=
 =?us-ascii?Q?YZw2qYHQlu8Oz5DgTBSvvFZ0WLOaViZUfyz0xQ3JSKNREQAnW8ctTbrL4ter?=
 =?us-ascii?Q?CshnhCB12L6b9WiEbg73D76xzJwbi+pOuGwGPZcVqg5dv6pgKVVxVUvCwCYT?=
 =?us-ascii?Q?i/3h6H0JqwGtCACFS7Xpko7v0e7gGKPlqfk0kwnucM3tGlxDPS0EHCw4g4m7?=
 =?us-ascii?Q?wmLQTTm29LRE7dQt01rWmMDECAYFqSzl4NwBUm5w9bhgkX6FjKSew8SAFGXa?=
 =?us-ascii?Q?E026iER2SdNRvoCx4gqcLO7Atw14+2zVsd1rlmKH0ObmzqHg500L?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5b585c-0f93-4a1b-9ac9-08dee3c13169
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:43.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SzuzjvuKBnyfEwURBf5CZytFHNhch48IWPfyT63MyS+AwSXiEJI7M5DFN7mZSsqw72joxHEan+vnuC4Mm/l2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

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
Changes in v5:
  - Keep release best-effort while reporting quiesce failures.
  - Serialize irq_mode restoration with channel state updates. (Sashiko)
  - Use guard()/scoped_guard() for new code.

 drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 14 +++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 43f8280b5811..89781d1c1d6e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1162,6 +1162,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
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
index 45f66fc523d7..1c932e5addb4 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -151,6 +151,9 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id);
+void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -161,6 +164,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
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

