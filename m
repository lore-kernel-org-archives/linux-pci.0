Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD240BCB6;
	Thu, 13 Aug 2026 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603097; cv=fail; b=MSq11lk5hDQpn2S/24Zou217N0aoU+kyHzP7eGUDYXamfrmYzctvSa1TyVEYjUvYeQ1wc+XSj0iQ6Vew9EOxL0uljm3YOlXZLH/Gc2MVtqzY7II3YR1/fQmR/4atfitvwX2/2brLNs/Eh4wlP6UlSwvSb9k1lW07sIJfIfVuQ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603097; c=relaxed/simple;
	bh=sWugVa+ZSEw5lONElpoWGDTIWQtqtGTXk8IGYrSPkck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WrRDNTlz3c/z1dVW9wlmU4NPY+nvKTGGoIgYG4SjYtXp3WAEHbtGuXx4xlrmUNKdNqHsCR4KyvsNrK1hxNkabRvUDXxORR7k7jzA0C+C6qyrW5mIWeJm1CnMRx23aj9ZdUkMYsIDLeo5KUKWuniWQlZ0OJFCUKt2RPLtbNIiZls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aOnp4WP/; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aOnp4WP/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JttlaUGxzZYvCS2V51dyXmAxN5yWvzjvrdc+JZJ3mDfKG2q28cH2atwKrNg3BKu863v6jHw8iIxZjvzVLHByD4LK/FuVWI1n+olGvUFUNolMnh7GGO4e6qmsbj8bCTLfEhiOYwklgKWxqPXbl3tsnYLr93XsXTtsd67bKPdgoMrQ9EYcmUg5eAUOLgtEd1sWDMbvqdqq/n4qm5pdUImSFXYlwXTNYThN3Fy9MjZJExoG8Zuqi+teeoiPkN9MqZsvPTd9vo0ZNsVgeOnSs7X3qD9hNynbjiKfAHXSh8RC/bs3PEds/i0oFZTwOjWYcNUryly0qZT27rckoA+p6mSsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIDWMkK4ecjTBgUBWBuJtNa0b/f2kfidhaYtHfk2kSc=;
 b=tXuhGyTvIxLarg8iw+TIhJHjU6AzSolAHMtMuzshVULhczSnCfqYyJey29vgZkLc33kIUw8eyB1mM1/MlYA6/1kjyAVx2eibxYfs+DGVz3OBRtMWkNNbUQGGuS2BiqSDn8oP1Zo4eCs6jtpXmrGHbOVb3n5DKRXcL+19rPAUUaHlQgLOtyu6axRooObnxhOJS3CZXOg/AMP2gGHqZaX28YGLvfTzzLzG/Wp8NSzZPcR+lBYy2BQgGbAK3psYNOic8wIvikwFP76ThlPYa04JQ44yzvP+hG53K7Z5we7Fhoh2vdjPFKmYuP8Ensfty9CHlY0FPTpq5mOG/qeL7X+uHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIDWMkK4ecjTBgUBWBuJtNa0b/f2kfidhaYtHfk2kSc=;
 b=aOnp4WP/bvZKlXFP6xPbc37ORl5pLwxGFd+n1gbxaIiZyI/0aVRKH04q/3/XBwnpXeSSAaO4EmDVX1qEFfLagoEsOCjzFHIAWdlmEwrEkLaKdNg3xlRPpOVsxmKYGbZ1YDlu5Cz7t8gzW2DgelCKlKvXnvqr3dtzQZG+jbv+m2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:07 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 05/10] dmaengine: dw-edma: Add channel delegation helpers
Date: Thu, 13 Aug 2026 15:37:52 +0900
Message-ID: <20260813063757.3131865-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 81262b65-c0ce-4367-8391-08def9056fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	uQnZWYkAxHARl2fnTRbQ8mmPxzVJyPG0si8oC8SP4I2m5VVAFOb+wS3T/n+laPONhEtU3wty7Evv6GzDlUkLH8lo0McEZm5Sfb948vcSuDPSuDGwHuadWShkog8HqedaYw1M+wy1tneQVZSboWpaFl0qGdGvTNJISyJe7R6NGF8bd4lt9vzXoxfO6mpnZdqDsFXKulIMCEfP17DZkGvxt/DVPHhFJIgb61zlHbbbp7avAkPVO0R6zUvqfPnZuoQt8mjPMZU0uDauXrP+bAvhh60xFJwrdV5pLkoT5lWZJQ5MCgHgpgw2E6XSQ1xriGhGlZmuXICfUHrpiU0rQu5+rX9Mt7YSJ0/lO7+kmGzfEnwODEHp0iJxyzFDGfk1A0dJoMRL3PtB2dT8qdr10K8VsTDlS0J5S+19mlRlKOp+qWwc2edTUGOyv6klOUNw0e2aLHev0NJAoAhCukLZhMAYICH9wPctcV+k++PBBkwuwWB4/IWpX20QA8VcfE1AJzMKQq8mrkVvNJ1aeflrAYS2SM+BYuYPfERpdNZRGOGjSYX7mEPsT6vIxcso+H+fZ1jQ/ps2ArbnctJOMGW6LItQoSGfahF3A15KRUV85sItbOOvLv7dHVOuEdx0cOpTrrevcjQUgISRerKe8UJPlgc66kjBatfxVplW2g7L84WT2TVBSm6Cp7bQObXcxxMqKqwy/m7B4lw6EDJPoupwUKmWrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+09pTIWxHil2Htap5JqhnoHqM8GZvKCHlB9cUlmWOQ/m+/ngWPnfgGnxz2am?=
 =?us-ascii?Q?odm7UCAO/doIKE6g0qMxc6P10d3W7v3NrGR0VYSXfKlza0gZvebQ6Z98wQop?=
 =?us-ascii?Q?54MsDHBphGycHNEXgqE6lJEHYhMZaNcdjI5mpvPckIJbZQ/UBPbt94FhdafP?=
 =?us-ascii?Q?XNyfEFs+VmqCQXWpQRwAOy2HIDOO8MSk6pmn4ZRzgOpA3pCpYoGw7/LAEauH?=
 =?us-ascii?Q?LF7KCa31zVyBmNYjBhv7P0qPX/E49ORKQq7HjA6CSdj/IQnvU1r+bz3kOBQt?=
 =?us-ascii?Q?WLOsTFlTI1PUF9kvfaKR2tFqJHdR4CbR4kihcVyGhjbK0ism9S4MyAjVRjp+?=
 =?us-ascii?Q?CEivnUOzbf3AT8ag6FZ467ACPlMRZAS5sJxlqBezTwkitzHu+ga3Tin/MBZp?=
 =?us-ascii?Q?HsV0k7vrEP3tTzCM2wCEsD9z7Xn6KUqkyiboh+3QgsB05H1BaTQxz873QIMB?=
 =?us-ascii?Q?ZfL43x80jPbHXnjEy7Y5LxnYgCj8SRsS37cQ0qzYFoVPfcY6eFwjJX4E3v5A?=
 =?us-ascii?Q?n64XkmESGpQt2XyvTZMyhyQltLAB8BMitk459Dird0TeHW3osokuVWycMYEt?=
 =?us-ascii?Q?/oaMmeylPYpVTNeSVzefk3ptKT3U1ptE65w7O4bIOI2zFzWIyTa/eHjYsGe3?=
 =?us-ascii?Q?5xnRtu1ZuyfDduNo13f5daL3v+NU3emYS26rhaxKmC98GykW+MtInTC7leUx?=
 =?us-ascii?Q?pWJAmXo4UosJd0HJ7CcReIkEdmxkp3V/dJzLWxkMXVoeGoLpBVCSz0SoybRA?=
 =?us-ascii?Q?Jpswgc09taUr6OuoPNj+30FfTGr4oaYP4eV3FbqsVKDTlqnFfmSiUGnBD31y?=
 =?us-ascii?Q?HgF/2wd+/LIXDI+7HofSdCU884N2vQkDQAv0kvE+64STuJn33v9DA+WR0IY0?=
 =?us-ascii?Q?sAwPx0PdHDmnzKYkkN4vqbkZMAAzhhrey1zEP39/2mE4nk4VREwt5A7JpmQ6?=
 =?us-ascii?Q?MTVytOzmh+BBYS29Mxj4xjZklVdVnUoZr9irPhmObPz0jj9T2n4SVbZrJ5hC?=
 =?us-ascii?Q?fb6LqpN2qJCHzMqGzPui6Q7iYyiP1aGoulzkJR42+a+GJjACReDT6MPStlis?=
 =?us-ascii?Q?N8cqPR+wxjPbplOZCoSBlc6dTvUikD4a54wNiV6HrakRcZhdePtkJ1MEyxU2?=
 =?us-ascii?Q?CGLKy6pd+Lo8Nggg1COJNpZPZt2jckxfHbCsuw99bsgOmmLNOOSFXHYDY/+B?=
 =?us-ascii?Q?/JpBe7yWhopFsAG9VKOvxTQVtM+qaKfJO5c1Qa/q3QGuQcccgapUFaIg1A/i?=
 =?us-ascii?Q?YGBg9Ix3akhDr8B19Wpq4Li3gkpVlMTcCjNYtTOeNGtVbBRZPex0O+6dvfmt?=
 =?us-ascii?Q?jsRtsOyfWzCsfV06vdHhwrVYCwhn/WmUoh5fvEKyQY4hNw4Rv51eNkzfurug?=
 =?us-ascii?Q?7BOeMARlCTpxGnphZpyT3juX0/WV7RyigBawGuEeSoTn3ztoPPHmAXB6gGhz?=
 =?us-ascii?Q?HFPE+d4270jqyUEjvIYmzIgP8jHStVl5658CkCDUiHiWpfz/uebI92/p5I2Z?=
 =?us-ascii?Q?IvhsaTDhcghczm1N9ccAgTpcwXlm5xSqNplbDqucrlLY7eP+Y73bkrGALXo/?=
 =?us-ascii?Q?V5MQHLRKU1y9LTpjtn+DdqsCIQDFgCjRQohUH/X2k4QCbhKgnLOLPw5sANy9?=
 =?us-ascii?Q?xlLNF8AkH0rmwj7T7rCczBymKnW159Bs8uFmsX52rCSUtkH4rE9ln4ZRrarq?=
 =?us-ascii?Q?EWAmBEcJpH97rF7OMK333HlMDX7QuJZW1fLaVbaycNE4dmMvl3hddwuzj2uy?=
 =?us-ascii?Q?wEmqgXBcMa388qOjSNL95d5ke7tTgWNycaFznnZSbTKI8BpRl3rM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 81262b65-c0ce-4367-8391-08def9056fc2
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:07.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngc0loAR+TGq+o+S8mdGH05oaGdvejOnByyScon2faHj44VbefLBUFS2xdDUGNXbHMB60zyWzhW5i4b4gumJiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Endpoint functions that expose endpoint-local DesignWare eDMA channels
to a remote host need to reserve exact hardware channels and hand
interrupt ownership to the remote side before publishing the channels.

Add DW eDMA-specific helpers that validate an idle, already reserved
channel and switch it to remote interrupt routing. The matching reclaim
helper can quiesce the channel while it is still remote-routed, then
restores the channel's default routing. The dmaengine channel reservation
remains with the caller.

Reclaim is best-effort because its callers cannot abort teardown. Report
a quiesce failure locally, but always restore the default routing.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - Leave dmaengine channel selection and lifetime management to the
    endpoint function, per discussion with Frank on v6 patch 4.

 drivers/dma/dw-edma/dw-edma-core.c | 39 ++++++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 11 +++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index d214df55da3c..1582ecfc2965 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1303,6 +1303,45 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+int dw_edma_delegate_chan(struct dma_chan *dchan)
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
+EXPORT_SYMBOL_GPL(dw_edma_delegate_chan);
+
+void dw_edma_reclaim_chan(struct dma_chan *dchan, bool quiesce)
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
+}
+EXPORT_SYMBOL_GPL(dw_edma_reclaim_chan);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3c8e2ef9dee0..61ebb808981e 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -153,6 +153,8 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+int dw_edma_delegate_chan(struct dma_chan *chan);
+void dw_edma_reclaim_chan(struct dma_chan *chan, bool quiesce);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -163,6 +165,15 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline int dw_edma_delegate_chan(struct dma_chan *chan)
+{
+	return -ENODEV;
+}
+
+static inline void dw_edma_reclaim_chan(struct dma_chan *chan, bool quiesce)
+{
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0

