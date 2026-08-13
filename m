Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE341D215;
	Thu, 13 Aug 2026 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603095; cv=fail; b=Z+buVbceoq/gEHMXQjraUPubKBfp7biXsq94xWXPC9s2w8kHicIMYMS7t8gp2njNVqEpYv54q7OHSYEiM4nPKRavpzqNVDvACiETdXEvuPRb3vrjcUKla/zlyEZGq0Mo+TJAxrsZ/kueR7rTBlnBa+7t9+NkQ6WP9N2/r0dVnWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603095; c=relaxed/simple;
	bh=cJyjRT9/kvVcUXXHIXI2WqjjszidfQJbgDubxTFnRMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ts0pgD4+PlxbeSicj/u+p0d7ctBG1XgMC/dWApsTEOoUm0d4jdZ7QJ7JQLBNh4rSz4NIHcjwwTBgH3Pos7GH7EnRdvK0yJv8LGMXLNslv7wxiKrQNi1WnsvBlvit/nnqj7ep8QFeMIGQkwOsoqQzScSK980MS7qaguGcxJ7tSv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KX2Rg9mD; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KX2Rg9mD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU8mI2t5bYjBHOiEQVkDbld6/Lz2jtP3N88ZvWI+AIlea7D7iHzKUT5Hgp/iR+jyqw7LEvExhh20ZqQMyXzUT3NsTn6uRn9N8gVOHgA8m0fXkbvThfPfpc2dv7cLLpnMYPS+regQey+E7ZhMeop5dpdr3LugZl95oR82Xn17y7mIqHQNWK4+asI7WStStpGYmB5KOSRXzh1afFGvwxmEF9Xd1jSsQc3LDge6Zcv3xhBGutTTKoe10drzo9moLBytiRhM6CatIp6qJV9UjJSBisKlYSa05Xf4xNJsfXz8pqiY8YlPRm2qUMlnOPL6xjgtgBQwUlQWgaVqlnZBuAd12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq/HjVUvw6OAHRN4wyxz05RFCLx4nTKh03q9JqEko28=;
 b=dpZXQv6HlfQ+6XmYjjAW38MJmgKz54mkok3J40ja2GuAZ7DzLS7JLvzlKw/FaIpeFSCwt13HMm261CYRJgfCtXLme/zrqRQxmMM/oJGjYfvepQ7kpqhd0XpPw4BTKPH/WL0bWkCzzxt7UmVc6DFAvC5g0FHQrCDB8YEEf0CGxDLQhzFd2dsZOTMA7j2iVFfFr2SE5HmNagMQahvTOoVZfTOuTTJbIRUBAJTyPQh30SmaQ8+Q07Fzvkw3k+Nt0meOzIJ6AEHo5vvaPk7QTXOs7iOnChxDAHdUS+rX6jJOVWjpuzllqMixpHJUO2etMLATf5rOMVl72wl13HVKLbu4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq/HjVUvw6OAHRN4wyxz05RFCLx4nTKh03q9JqEko28=;
 b=KX2Rg9mD7GmQkN3n8+jAqtx5+8Je2EQRknGHtYa2P7tBuxQ4u1R5oYye8KCFKE1IxdeJklwcXApiQWryiXlkyGVmL8QwRLxaUSxEQDFtZVFH2tp1wlQVQhbVkX2+y64Ne7EmkkxeZ+Hw9g7qTrXZnr6FL9FddwP4qIgJ5SkTiK4=
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
Subject: [PATCH v7 04/10] PCI: endpoint: Add API to delegate EPC DMA channels to the host
Date: Thu, 13 Aug 2026 15:37:51 +0900
Message-ID: <20260813063757.3131865-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 699fbaff-e660-4fa8-7317-08def9056f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	eMLyy2ugUAe5o0EhgQe1R7/PGQejEnNxuj8tr5r72i9BpT8j2dT80WowPFJJveDp4xjzunX4C1t3NypeXbCUtnDUk+pRvZ3zO/w8E5IH1vRRCmn1SKZihMDT1ePK3bI5Ufg4cgYlx2aBcLvMTURxY98PPxltyIhaSIYZ0AcB9oGYnq9/aGvtKyemn9jAr+Tz5JgMziEVjanO9l5fDRej1hhfTYKAbLJ48D+0EH7vNR0cMqrHQdiXnIOKXTTST+jfBgWa0YKRtzsrVoZQuXRzmYGpI58kNlveUWsJIQN9/teKX12Y7ZNkyyAfLojPshVa3kYhahJnvrRkhkzfm8ZYX4pOfIaE4LsnUxb6NaqUNzFQiUUyc3Vn5WzFBVUh4h+6q8VEJpnR9u+WJ870ojqv3pIdeKFXogBsuuO7u9RXwsKvor3UMJNu+Xx+SNMA95GjvvadmL/Yuxe4ikWcQww3oDOeFyuyyvq7bgvj0kfhD+CTY8qpgsrs/0bd+KN1+JLRBqaJIruTIJL1c7N+tdmDfIKTSkMQxVUAxTlvPgwYChU9O0+ZOVveJ6EtB4GrLgol2PkT5QdJLtxPi/vZtIDPCJD0EqtXXd/b1XSOKdaGsFSjDSl8mFN81+nLmEDEY7RxCSd8zN0MObjcoRxTKufTwOr8mnQyFqS39ZJiSHkz8+Qe4+RWp5ELbNMIZX27VCwbloWVDO73860yyiinTDPV5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMa/QcFGiqzfOYTGkRnJMWL+TTzUt/O/Sg7+J2pjRjHGca7DsS4PYlHHqFzN?=
 =?us-ascii?Q?xXzC015UaQUVS80Kt80wsZ/KZbnvSnGNOoQTUw6+nn1Rgr45i5dTzD1Qo2dU?=
 =?us-ascii?Q?S2gUAnJUcqePhclgqA2V/lZUctAvBUhcbPbebxAaKPbdKemquQC1IzeLbSwS?=
 =?us-ascii?Q?hDziAw8v2soW+peeotoO525sjNf/4XhbZ8rqQCo6pUti+mmaAV0i0Zg1Ja/G?=
 =?us-ascii?Q?7fex8W/eIV08KbPMtpe/ArlihIBF+HT8z4OodxxKFBJGe0L6I8qoAU5+T8Ri?=
 =?us-ascii?Q?L18RLu+55Z2VLlx2kA6xK4/LF+9IuzuPd3KhNiRfvaIyMJb4vusqECrfqrB+?=
 =?us-ascii?Q?Enoqc7MiZyYFdsL0lcLDpdg/sH0B3+OFewVY7GSeTqfhDGohtejpaMBdeI3F?=
 =?us-ascii?Q?IriYclagxMbuMMpeU0GFs30jk7N9DvJZwgmQd5lpvVfdcNGx8LMZrZ4r4GTt?=
 =?us-ascii?Q?u5m6fxL4NBEdnn37H7jjwcAaqIf3z5ka3IXzUafNWvq7C5iG0oBVYMSWdZrl?=
 =?us-ascii?Q?9XfisD4q/U3CPUtqKuJfqzS50HIpR72S91LzgE5seNFyqwXaM8YUqbGqthT9?=
 =?us-ascii?Q?PqNYvoIk9p+Um74+MPiTD3wJ9N8mg8Y9BIDC6ucRA/izydt7Y4DVKWSNXejc?=
 =?us-ascii?Q?6xOx9OaM1KXLv9qhQ38E/ImTxtdGpqADsNlTSfoD3hyT6p0zjTejvvEOaao7?=
 =?us-ascii?Q?D49qKc9N9GNtYkJTrqX9xSopA0n6G6imeUEWphDCMwZJ9AIkO4SY0KmBbZB3?=
 =?us-ascii?Q?9huXRqjV2abII0pt0+dyCbP4rXgiDYqq1xVgiD9co9aDCClDTrUFGOKfRz9A?=
 =?us-ascii?Q?jqOJvHt4/ZEzxysgFIyqPYTpGrJaSuj9EOVtNvWirwcFVJi7wePzyavSeGdY?=
 =?us-ascii?Q?CUMZK1T65qRoYASyTieyyH6DXoZ+NmPu9zQ+eh93QkuRZ2Scryqgjq3Nk4nV?=
 =?us-ascii?Q?GI+UF15qgujQU7fu4/U67tfrATUDw5fv9t4HlhG6wJXQylSPvg0YzeLkEQSN?=
 =?us-ascii?Q?gdExT0DOxvx98wBmas3vLeDvdlCZOoUVRYhDHXswb8vLBy6lbH7c7qPWJr9i?=
 =?us-ascii?Q?OcD2AEJ5ToArcaXy5YISLBGk4ZQnuAPGVoqpIIvfrHX8kYOXPZTzJ3lm28DG?=
 =?us-ascii?Q?FX/VIuoQHB2Jk5OzI4fi9oROBghIuwvjGQwFgBc29BYigUUlIT1xHfM2UIyw?=
 =?us-ascii?Q?RTEpF/FnZhmR+llcsobp+Aw7IkODiV7gbcfV5BHpCOMqNP4zNMiPqfl6t2FX?=
 =?us-ascii?Q?084YmlET1yiZnyN0hMSuzEIhoW2/NQIfvFQig3xV4trPcUMaDy6Kcl9l0dLS?=
 =?us-ascii?Q?k8T7oYajiOiDCJ4ofYchS61iucZo+vzGsxeuYTgTEO/i4D25vD0xcrvkz74f?=
 =?us-ascii?Q?wseGRTv61xPpSnm4orD2VQtoX3gEClEMkB6cOvIqG5bFe835h0NgXW5UW1nc?=
 =?us-ascii?Q?4rAG/AAX+gndrqp55zt5+7BcqgoaQyJ6FHV/GNVaxts5XBkutIvoy2+QKyVm?=
 =?us-ascii?Q?Q7cvxDjCcz+CQZ0LhiAOAZybIkbH3gtUyHM1XaJJ38Eq1z8MnO+QqCBV1SX0?=
 =?us-ascii?Q?mY5OHZg+PJjtg5zClk5HF53Th5vtw16aCozw4NyGfzipaT0Ileos8+xeJyLH?=
 =?us-ascii?Q?tulf2JGrLsHMylhMaZ0F/0Sox1cPx9Wg7P3OLSl9D9w/II6Ks7g67XbuklgB?=
 =?us-ascii?Q?8Zj2NayEy2HTCURNgtGSjiwrGIL6mKmUIE3m6B4ZLb55Qy/8s60ROuE/+W/e?=
 =?us-ascii?Q?+w4vk4YCgxO/iOyDPmxm+6I4wTMUk36qL5W9j4mzRsX4r6Q1z2xL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 699fbaff-e660-4fa8-7317-08def9056f32
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:06.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgX1Zz0LQbnJVccCvTpvFywxyIv0F5wGanvl/YJC76alzfKEbCTgiyb+LrrLzr3OKjt1iTR94kQ2usCdJY56vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Some endpoint functions expose an EPC-integrated DMA controller to the
host. The endpoint function reserves the local DMA engine channel, but
should not need to know the backend-specific mechanism used to hand its
programming interface to the host.

Add pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan().
Add matching EPC operations. They pass an already reserved dma_chan to
the backend. This lets generic endpoint functions delegate channels
without depending on a specific DMA engine driver. The caller retains
the dmaengine reservation until reclaim completes.

Let reclaim callers tell the backend whether hardware exposed to host
programming needs to be quiesced before local ownership is restored.
The quiesce may cover a provider-defined sharing group, so callers must
hold every delegated member and stop peer programming before reclaim.
Bind failure paths that only unwind local reservations can skip quiesce.

Reclaim is best-effort because it runs from teardown paths that cannot be
aborted. The backend always consumes the delegation and reports any
quiesce failure itself.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - Take an already reserved DMA engine channel and leave its lifetime to
    the endpoint function, per discussion with Frank on v6 patch 4.
  - Remove the opaque pci_epc_dma_chan handle and pass the EPC and function
    identity explicitly on reclaim.

@Frank, I haven't picked up your R-b tag because the API has changed.
Please take another look, thanks.

 drivers/pci/endpoint/pci-epc-core.c | 70 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 15 +++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..d0bcf3dc7039 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -236,6 +236,76 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
 
+/**
+ * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to the host
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @chan: DMA engine channel reserved by the endpoint function
+ *
+ * Some EPC backends integrate DMA channels that can be exposed to the host.
+ * This helper asks the backend to hand a channel already reserved through
+ * dmaengine to the host and place it in a state where the host driver may
+ * program it through the exposed register window.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA channel
+ * delegation, or another -errno on failure.
+ */
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct dma_chan *chan)
+{
+	int ret;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!chan)
+		return -EINVAL;
+
+	if (!epc->ops->delegate_dma_chan || !epc->ops->reclaim_dma_chan)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->delegate_dma_chan(epc, func_no, vfunc_no, chan);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_chan);
+
+/**
+ * pci_epc_reclaim_dma_chan() - reclaim a delegated EPC-owned DMA channel
+ * @epc: EPC device
+ * @func_no: function number used when delegating @chan
+ * @vfunc_no: virtual function number used when delegating @chan
+ * @chan: delegated DMA engine channel
+ * @quiesce: quiesce affected hardware before reclaiming the channel
+ *
+ * Reclaim a channel previously delegated to the host. Set @quiesce for channels
+ * that may have been exposed to host programming. Bind failure paths that are
+ * unwinding local reservations before exposure may leave it clear.
+ *
+ * Some providers share enable and interrupt controls among channels. The
+ * caller must retain every delegated member of that sharing group and prevent
+ * further peer programming before requesting reclaim.
+ *
+ * Reclaim is best-effort because it runs from teardown paths that cannot be
+ * aborted. The backend always consumes the delegation and reports any quiesce
+ * failure itself. The caller retains the DMA engine channel reservation and
+ * releases it after this function returns.
+ */
+void pci_epc_reclaim_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct dma_chan *chan, bool quiesce)
+{
+	if (!epc || !chan || !epc->ops->reclaim_dma_chan)
+		return;
+
+	mutex_lock(&epc->lock);
+	epc->ops->reclaim_dma_chan(epc, func_no, vfunc_no, chan, quiesce);
+	mutex_unlock(&epc->lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_reclaim_dma_chan);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 3b60cf6628e2..3b0aaaa9a259 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -11,6 +11,8 @@
 
 #include <linux/pci-epf.h>
 
+struct device;
+struct dma_chan;
 struct pci_epc;
 
 enum pci_epc_interface_type {
@@ -176,6 +178,11 @@ struct pci_epc_aux_resource {
  * @get_aux_resources_count: ops to get the number of controller-owned
  *                           auxiliary resources
  * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
+ * @delegate_dma_chan: ops to delegate a controller-owned DMA channel to the
+ *                     host
+ * @reclaim_dma_chan: ops to reclaim a previously delegated DMA channel.
+ *		      The callback quiesces the channel or its provider-defined
+ *		      sharing group when requested.
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -212,6 +219,10 @@ struct pci_epc_ops {
 	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				     struct pci_epc_aux_resource *resources,
 				     int num_resources);
+	int	(*delegate_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct dma_chan *chan);
+	void	(*reclaim_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				    struct dma_chan *chan, bool quiesce);
 	struct module *owner;
 };
 
@@ -445,6 +456,10 @@ int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epc_aux_resource *resources,
 			      int num_resources);
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct dma_chan *chan);
+void pci_epc_reclaim_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct dma_chan *chan, bool quiesce);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

