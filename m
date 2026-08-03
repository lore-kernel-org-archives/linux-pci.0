Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020095.outbound.protection.outlook.com [52.101.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644F42E013;
	Mon,  3 Aug 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780290; cv=fail; b=sWGu2Yhmk0UUn7h7C4w/DTaJd6sb6LDLM/qw8hDoFHzE0lur3iwGbOZTpFm+pKUyVJgVXbei2HeAnk2+vluns+ii6HlF4VLB1Dsz532On8zMiOvZrIusyApEnVM5jJ/l5xLyCRzh2ZioLqq7Gis7Ibo+tqOW8ABXCF/fdSAjZME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780290; c=relaxed/simple;
	bh=w6RXexy2x135vi+68xNYtDWaWwWCCttgpDypYI4KK0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neI2pqZ/Gjxkd0PckyXiZLnO0zXL+MYyx9V6inuM1aMRU2q8uBPNvu+oZtw25XrkhTw/wPNZdbekscwy8k04TKMPbrPRYfxQGjB9d6BjPEvg1tHZ52sTqc0nb+gP+49XYyzenE6F6wDc5++1N2YM0YEaBLB/ujeS81I1OmtTND8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HqWx76/3; arc=fail smtp.client-ip=52.101.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HqWx76/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPsdTQEGGK7wutwkbCKlfb/Kamn+aM0Na6v+868Gjz6uTrx5e2pJM4vh+e6ujQE7wMKVHpvk5WDTrwrjrT0NKl0LtZ8AT2jzRV5mHUZT/EJb6wqRF+xThEvzqbChd8SOIPHkkWR7+mJyr92JtWX62BSsveaRqpky9tFeZOnjjHfGBULwMq98WjuGBqckkHmj9ke22HGwiJc4VfM6Sycqc0pdA5jd00bVU36puzE3E52CTC8I319fGp7aEqVFOvINUNysaTIPnOrS+coFAq5xrgi/OnkSMEWbUOXXBiKwIO8Lukiy9Rj5czfrUQKSjamYJPBGcA2eqvBR1EYjlr2iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grCH+TCZ22douLSyLTukNNJZlbGmcRjelZhjXBdKIoU=;
 b=brcnv4mjHmAymOY3MlesY4iOy1qj3UOv6DykWVabBAOaYCrkX2Ycrvr9soGBJvmWvOjsg8qOQeJCHAmQrGS90Arp2gSqKnXf4EZN9Z3iv26Isz3rffnAVVqXVyQFgvRUfMKZvDscjAmhO1p+GLTYcfUHs71RD21apg3gz/h/UKnUkkNs31FFDjZe+bsYQ7+SNpGqCxAtHheMtnvJArLCnFseIeW39wzZVswczqwRGtLlmNc8c88Q2qY03+8EsOEzVN9e/9oCUFy1gNE59gRIhifo49CAQPE6Rk2bYsKHqsuGGKQ7cZT2Jg5l1ZbRrEtYT93C7FR2NXOmQ9eyj+1kNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grCH+TCZ22douLSyLTukNNJZlbGmcRjelZhjXBdKIoU=;
 b=HqWx76/3COVSwzpQUzWeNIGpbD31wY5h6GVOEl3Mlm0z4x7a+61mqXycvzaqRDI47Z4Ob0aIwilIHYWQlUZ167V75pbTRfd6Z3gEn5sB6w1ekvLHJsSVAYXyndfUXcqwuDx/shHtXMSpwWhFmdOsI5B9/hM6maVp/eaEEvintEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 01/11] NTB: Add atomic MW translation group operations
Date: Tue,  4 Aug 2026 03:04:28 +0900
Message-ID: <20260803180439.1963864-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: c0973b22-b70c-44f9-e95c-08def189b16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nEsPe6CDm0u4VBDVzwO3pbHZEqyK1ayOQ70m8zyf6j9hq7lIojOoAnqK5GRMkKGKGlIJxM5cpHRUFsgoIoBXidfcJklHGOaeksga3ttrHphwNbzXuOCGUrVw9ZtrK20cCykfdbN93AiIoOOCbFzFcxmNaDIsmMWLDoWlKkoRom8mlGjsWCRod+fr9p6u30Iyk59F7OeCpuhjPoSklUlgYXao+7OlJq/gF1MpEAhJxBIy9mUVUbE4A8dTeIDEOuWiDmzowT5+bQ6cCfWlRggtQP+Ok68KqEM5qsvpDNP/XmFRB2LJAGLU2G81VnR/ol90ltE9lODX3/9699nfgBiMoAqNonMscVjnXxFiSqVBGatFR0XkJpsf5agrPzNINxdb5XKg7PebfviqTpUn1vykJ2wdENGCLaDYAaU3CcoS4LNMiUHUHvOsG8r7Q9qeDGngRCS3N6L9wUjOXx4FLnAXkdrhQe+TAeMvbkgFU8Mr5fr7PYw28/Af4lb8WT6LQqPnNHnfH8CR/YKfZ0GaAoA4fmzYI0OT4xm7t669y9pPon+hjXH5aJUePCj/wiHH3LG/JkYQ41AesLEaq7bPTceKMQpqID6wd1Ch/jobrcTk4QzQthrsS9jpFj4zI32O1UpcZk706iPp/AW1HeZsK2UUSlXokpTHEosDpotq8onkBsTar55CfMZdzYMi9DJMiZTi8na9fsYoJ+esow34itdG2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qgjg5SpH69WpcDBGo4VgO3nXKH9hU6EKwFD81ZZQ+5GxCxB1LojCzgkN+m1x?=
 =?us-ascii?Q?+Ufz2+S8zvTs3g0os4K1WiXjCmYfqRHxEBTkpT8SrHyxiyZHr+T58oRXHpe0?=
 =?us-ascii?Q?k7GSy8zsLNNHfPavowv5YIgjXpG6mrzhaPWMr1GyMRiqtzkyUoYWelF93qR6?=
 =?us-ascii?Q?iDRkbfA0EM5/Gzfalke4Y5eGULCiqs5sYhvVymPSRDERS9AYLFNbSudeSKoY?=
 =?us-ascii?Q?dBMq6XX+z6C9ryb1jAK0n1BMUcQTKN2CS9DL3E5ctRSXvyTdSovIGW7p7Ueh?=
 =?us-ascii?Q?Fwhwux40Xgykrb0Gvx8mQ3XMbfjZl+wRGXXwpe8gXAAvYhJ0rYQtEdym54D3?=
 =?us-ascii?Q?D5uydz9FyqR5WcX1lLXJ5w5d0eQ2QsV6pNzLvsWdlfuzAPzDB77ZSlVgTads?=
 =?us-ascii?Q?whIR9dBAhKh04XLGWbIzw44QDfDoSgQi05DP2UIvGla2xmnrx4M8Mcji82AZ?=
 =?us-ascii?Q?nYD3cBzgG2buUSNSdFZvj+1Oe3COTh8vlDviygyalBrmDZcWc6L1/1Rcpa2z?=
 =?us-ascii?Q?wD9z7RavAL/EBNh4igj3U9Zkfeh/cgkUM/gNlmQXh7ySIgjxGPXQogZC7FRw?=
 =?us-ascii?Q?NsICKJB0M8S284OshpeClvqDLol054mz4u4AxAzHCsjyODQPbnDutGAbzuuN?=
 =?us-ascii?Q?VDn/GUFEA3RC5VHIkZ/Y5Dr8Wxq5xSwmZyr1n9vfUo9FU23cH7VFkzoQsaSH?=
 =?us-ascii?Q?TeNm7h+6O0Jb45SBODz03MNqvq12FpZRWMA90npBIGqF1D2TG6a8JMYux1gC?=
 =?us-ascii?Q?RImh3jtOvnl0sY/lJX5aaksNcH8DgwkTSQ2vTpo10Rkp3BTuxzetotQGBJMI?=
 =?us-ascii?Q?cw9rJpI1GcVU0Y7Byrl/Tp/sSzSOG+f3J94678cEccW+5OYzOazMT8dBiHPe?=
 =?us-ascii?Q?Phlo9qMzuff4/2Lwp0fNrXBUoGLOvRTyEBzBoY4okWBxQRSUEfHlo9P+oKyk?=
 =?us-ascii?Q?QLcapbk++xgi1qFfP1a4vxbkc2yPD/Y6qw64Qw1oN5EfuoMJY5f4s1hRmJ7P?=
 =?us-ascii?Q?YOVlGMoBYRMGiFKU2+/zNAQCsrt0vwVR8owQsnP0C5XjQRZMKLH0AS380DPj?=
 =?us-ascii?Q?11urAsUS6K9s8EUsf7GhLKPJ29MGZFbHhM6Nqk/SfWAeNKCMUuZLPfzg/0P4?=
 =?us-ascii?Q?cdnkdYaQqSsjrxH+gvwwTfGuyDSx3OfGkyukgfzLuJv32cVJQQI9eQZ+2gWn?=
 =?us-ascii?Q?Cqf1unfjzYM6ydUaI5jgj1o9PWPWp3C+pb7Da9embtvCy7iv9kCOvvhgZp63?=
 =?us-ascii?Q?QTklF5Os0bSvBvw7GogAaLRokz/XDNma1lLPKx+vSLU1jqq9oqpyybZXz5dk?=
 =?us-ascii?Q?+5Wa8UlJKQse2kV/zaU1UsWvSqPatFoUWlAxmgKTF/8xyLT2qfxfirbhktjM?=
 =?us-ascii?Q?kMg6i0ehn8ls142y7ffVMHJ7tR3msov84mu27dSpNnmnTco1nFxBiDqPUXXD?=
 =?us-ascii?Q?IpVW2MGY4kPcHWqiZQU9QBKpqOHbAk/B4DcQa4SNaxfEqPoFbUBsKzec0x7n?=
 =?us-ascii?Q?Bq243lyex2YkSRML4q1vYJkFuDNKeCWDGQKw6G5UEMB/V7qAmkGgPvHzgomo?=
 =?us-ascii?Q?pti2oMK3WIVezeSWzUv2TZUQGXCmWCQ2RzONPmCL4HHTKhpZdHNawPIczNBw?=
 =?us-ascii?Q?958oRi5Qnfjdo4FL7HXWXHo22rqujnBofHs0tfjVhgqSjH4gffC4OIDPBSJs?=
 =?us-ascii?Q?5TE3rIMDX+jyTTywPcVZTmElgNHJi3KhsyPbqL5ItoYT2dpkanehaewpLI42?=
 =?us-ascii?Q?wS1a4spYzeWIiJGuexn+8IedNaVNTBvyYhD8G388Pl0lwcHWpJoR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0973b22-b70c-44f9-e95c-08def189b16a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:42.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IQYbhJcQwfO++jjKgsxtjvNgcdNQbuARIWT7hqfV3f+GbcrB+I3RWWpBxZuknOANQFI3aURkmY0Qzsxs0142Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

A PCI function has only a few BARs, but an NTB device may need more
logical MWs, for example to give queues separate windows. Splitting a
large or resizable BAR avoids spending one BAR per MW.

BAR subrange mappings for that would consume one inbound mapping region
per logical MW. Those regions can be scarce on some PCIe controller
integrations, limiting the number of MWs.

Introduce translation groups whose members use contiguous local
backing, so one inbound mapping can cover the whole group. Add a group
query and atomic group set/clear operations. Singleton groups keep using
the existing per-MW callbacks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 133 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 5 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index ae72caa03859..c21c6495d18f 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -217,6 +217,9 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @link_disable:	See ntb_link_disable().
  * @mw_count:		See ntb_mw_count().
  * @mw_get_align:	See ntb_mw_get_align().
+ * @mw_get_trans_group: See ntb_mw_get_trans_group().
+ * @mw_set_trans_group: See ntb_mw_set_trans_group().
+ * @mw_clear_trans_group: See ntb_mw_clear_trans_group().
  * @mw_set_trans:	See ntb_mw_set_trans().
  * @mw_clear_trans:	See ntb_mw_clear_trans().
  * @peer_mw_count:	See ntb_peer_mw_count().
@@ -275,6 +278,11 @@ struct ntb_dev_ops {
 			    resource_size_t *addr_align,
 			    resource_size_t *size_align,
 			    resource_size_t *size_max);
+	int (*mw_get_trans_group)(struct ntb_dev *ntb, int pidx, int widx,
+				  int *gidx, int *gcount);
+	int (*mw_set_trans_group)(struct ntb_dev *ntb, int pidx, int widx,
+				  dma_addr_t addr, resource_size_t size);
+	int (*mw_clear_trans_group)(struct ntb_dev *ntb, int pidx, int widx);
 	int (*mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
 			    dma_addr_t addr, resource_size_t size);
 	int (*mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
@@ -352,6 +360,11 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->mw_get_align			&&
 		(ops->mw_set_trans			||
 		 ops->peer_mw_set_trans)		&&
+		(!ops->mw_set_trans_group		||
+		 ops->mw_get_trans_group)		&&
+		/* Group set and clear operations must be provided together */
+		!ops->mw_set_trans_group ==
+			!ops->mw_clear_trans_group	&&
 		/* ops->mw_clear_trans			&& */
 		ops->peer_mw_count			&&
 		ops->peer_mw_get_addr			&&
@@ -836,6 +849,102 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
 				      size_max);
 }
 
+/**
+ * ntb_mw_get_trans_group() - get the translation group for an inbound MW
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ * @gidx:	OUT - first memory window index in the group.
+ * @gcount:	OUT - number of memory windows in the group.
+ *
+ * Return the first window index and number of consecutive windows in the
+ * group containing @widx. All translations in a group must be set and cleared
+ * together. If the device operation is not implemented, each window forms a
+ * singleton group.
+ *
+ * Group definitions for @pidx must not change while @ntb is registered. This
+ * function may be called regardless of the link state.
+ *
+ * NULL may be given for either output parameter.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_mw_get_trans_group(struct ntb_dev *ntb, int pidx,
+					 int widx, int *gidx, int *gcount)
+{
+	if (!ntb->ops->mw_get_trans_group) {
+		if (gidx)
+			*gidx = widx;
+		if (gcount)
+			*gcount = 1;
+
+		return 0;
+	}
+
+	return ntb->ops->mw_get_trans_group(ntb, pidx, widx, gidx, gcount);
+}
+
+static inline int ntb_mw_check_singleton(struct ntb_dev *ntb, int pidx,
+					 int widx)
+{
+	int first, group_count;
+	int ret;
+
+	ret = ntb_mw_get_trans_group(ntb, pidx, widx, &first, &group_count);
+	if (ret)
+		return ret;
+
+	if (first < 0 || group_count <= 0 ||
+	    widx < first || widx - first >= group_count)
+		return -EINVAL;
+
+	return group_count == 1 ? 0 : -EOPNOTSUPP;
+}
+
+/**
+ * ntb_mw_set_trans_group() - set all translations in an inbound MW group
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @widx:	First memory window index in the group.
+ * @addr:	DMA address of the local memory exposed to the peer.
+ * @size:	Size of the local memory exposed to the peer.
+ *
+ * Set the translation for a multi-member group. @widx must be the first MW in
+ * the group. @addr and @size describe one contiguous backing range covering
+ * the complete group. Singleton groups use ntb_mw_set_trans().
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int
+ntb_mw_set_trans_group(struct ntb_dev *ntb, int pidx, int widx,
+		       dma_addr_t addr, resource_size_t size)
+{
+	if (!ntb->ops->mw_set_trans_group)
+		return -EOPNOTSUPP;
+
+	return ntb->ops->mw_set_trans_group(ntb, pidx, widx, addr, size);
+}
+
+/**
+ * ntb_mw_clear_trans_group() - clear all translations in an inbound MW group
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @widx:	First memory window index in the group.
+ *
+ * Clear the translation for a multi-member group. @widx must be the first MW
+ * in the group. Singleton groups use ntb_mw_clear_trans().
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_mw_clear_trans_group(struct ntb_dev *ntb, int pidx,
+					   int widx)
+{
+	if (!ntb->ops->mw_clear_trans_group)
+		return -EOPNOTSUPP;
+
+	return ntb->ops->mw_clear_trans_group(ntb, pidx, widx);
+}
+
 /**
  * ntb_mw_set_trans() - set the translation of an inbound memory window
  * @ntb:	NTB device context.
@@ -851,13 +960,20 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
  * of that method.
  *
  * This method may not be implemented due to the hardware specific memory
- * windows interface.
+ * windows interface. A per-member request for a translation group with
+ * multiple members returns -EOPNOTSUPP.
  *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 				   dma_addr_t addr, resource_size_t size)
 {
+	int ret;
+
+	ret = ntb_mw_check_singleton(ntb, pidx, widx);
+	if (ret)
+		return ret;
+
 	if (!ntb->ops->mw_set_trans)
 		return 0;
 
@@ -872,16 +988,23 @@ static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
  * @widx:	Memory window index.
  *
  * Clear the translation of an inbound memory window.  The peer may no longer
- * access local memory through the window.
+ * access local memory through the window. A per-member request for a
+ * translation group with multiple members returns -EOPNOTSUPP.
  *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int pidx, int widx)
 {
-	if (!ntb->ops->mw_clear_trans)
-		return ntb_mw_set_trans(ntb, pidx, widx, 0, 0);
+	int ret;
+
+	ret = ntb_mw_check_singleton(ntb, pidx, widx);
+	if (ret)
+		return ret;
+
+	if (ntb->ops->mw_clear_trans)
+		return ntb->ops->mw_clear_trans(ntb, pidx, widx);
 
-	return ntb->ops->mw_clear_trans(ntb, pidx, widx);
+	return ntb_mw_set_trans(ntb, pidx, widx, 0, 0);
 }
 
 /**
-- 
2.51.0

