Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657363;
	b=EtwiJyU8Sfq9rWZ8uelp0VoWX2Oq/0CRMRII5z6kZ3os/MomjX5ezAecLgrUHf9aDpUh
	 HUiNvEpA6MnHEkFQ7U1EhsCZUfYLv27NwlKupAO3ud8rpfewdzWedQZzRkHi3CsGYlIcI
	 EHpoPDJiOpEN0YAuA1Es5/tz8eBcQ5qIld2Mn0x2TT3rLrhCMzg5irhi5kE8VjYIaKaAF
	 QbhTLP9O30dLQiaeeoOmT3EZ3pdw01SE02mfWEQ9YGDnauyEHB5aoIi0rch294wI22Kr4
	 +b9G17mpGHlUPMf9U4zsKzDgv5wChtQ2m2dpWbFHByLGD/8KuYhIWsJgqBSTHZYFEfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657363;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=irjzt6+lCZMtDRmH4lYApLOnqZZ7O8B+QT6XwYujfHk=;
	b=R6Ri5OUKOoaByKGvAV+odATmQemfs+PJkAwnvb52kiB0BD2TS10wTCpcVUYA/LOhCeJ9
	 Jf+MmadK4aGRrmfJ3d7IqAuEOhEpChGOLyr++PvmPJBx+ufC/zIUtg9QWC+I5HJmtefnl
	 sUcv36aiT57TINauXI4v/i7E9tW8axU+337fWQW2F1tEgmbT76RAhfsYQMuun/n5E8NoB
	 tnXokeza7UEFY/C0jQpSph6arA50ShGT8DOo3OnWru4oGoX/i1npA4OyDNIZV+K21kPYL
	 kQXIQmLFCq+FHpd+39X6gem6JECB/UUps9MGkhjl/vHapZsc5uke33vtTmSeJGBQrPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=FCHA3+69;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.140
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020140.outbound.protection.outlook.com [52.101.228.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE5606A327;
	Thu, 22 Oct 2026 08:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFE5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=FCHA3+69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8eS2SQvNazsOpLBnoDUx2jwPwu0ubhnOdpW3W+zwH1q8pjwQWtznBYM4N+tignGMlDUa3KbLxEfDlvSZmb+OgWv//XGaLXlmXmYZZjGAH+f0Cu6joVFhs5GJ0Qz3EZrbJ9fNrRFFiBSPFMNnw0MLww6edgBAP9+93Ula0px1pSUn4z9xTztZoqI2EDNng+Nw568c2b1JiE9AHVeCtMtItPqvXhr519hAxXXtDM+zgOjEcoy7jpVUW813EssnbUsXV/nC0qqWOQO1kGUrKYih6RMSgUMvLplI2yR4PN04BXUL01Ccll/AP1l+ux8Lm/flvwnB/Xrx2hoeCvinnPc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irjzt6+lCZMtDRmH4lYApLOnqZZ7O8B+QT6XwYujfHk=;
 b=F7yFsIvQwNH+lxR9puagc/Pu1qe/dCyg+7gPy6djJ20wQ0XgR/BiZojBwwAVkrHOnNsHX4ecp6nqBR8nLO5ciz51Tjme2uelPzSl3hJqQyemLrry1GvjBmBLiouD4HgA9m2DzF8VNHg3sTn0ykRyXDqqGyfNnBfhEnvLlu7H0iSdLZyh97aoOxoDSPH0v09kAJcj6xcdOTi2j+gdERX+ZrX7snjQ4t7w8J0RKOhkaTmA0vhQV2F4OaYlaP8xyhpHB+SuUoFn3Wgl1aQQlnZNMfrcGBjVR6C1vP8Y/ekyQ+USqKW76U45KZUyQizfvvzTuPVsnN/4rrC6azOpRHZPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irjzt6+lCZMtDRmH4lYApLOnqZZ7O8B+QT6XwYujfHk=;
 b=FCHA3+69KaLCFj8T0dT/1E5TNXM//dYzpOHbIvUgnIcSOQnboW0OadqaCVZeldmUmo/19TklzdNb/j399uhCTrY1cpjDFFyqHRuoFUh+XRWv6+c4COmAmLWrWJe7K46vv3/KX2cb3mWvXhMc8d9uhJL7uTcf5RRwKcwITT2uB6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7221.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:458::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:42 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a BAR
Date: Thu, 22 Oct 2026 17:22:30 +0900
Message-ID: <20261022082230.3164834-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 2330caff-7e73-4552-711f-08df3015a4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jLMTQxRj7VAHv6OWIU7rV+NQpYXuXNWzE2xN8Wmm4Cky2DW55WuLl447qGFAN3yDKfCaIJKZUWDK/JMk+qOXIG5kJsu7KBuBhfQ35zoekvkNnu29MEL/yzoGVEVN7bhrTw53c1zaOlipL+yY6goBO5KeYAihmPyQU1gd5AjXpbMAkPOj3wJfx0xyhBpqKZTGW5Hn5flL6GJQlv9qWpPuhS3GVz3ZvlK5pZxezJtydv7aSwZFRT8tjajtEX8MiLpVK6WOcBagoLTsFoX3jo+0TTg7+G114m0UQxeMhmjNhXK0JC6D1ot7T79FfvJK4utuQWJ8sDiYgNkp/FE4FwO6Rwu7r8udu8yW5YBIdy9oUtV0idW7zMAfYfVX4LUEV/dDRiMFOUT1685u0wtd3gxkLIwB2Chmsgs75w4q79lNZQYOIeSoSNdY/ulbhYCGvwiDg41YFrfhUPJ87rlzVO+y5EfTngVBgPAz3k4Mlca8Ixq8chxkxImJiZqXe+rZwCzjSf+OGP19Nt7RnSuHpDn02rOE6BW5Er1HJk3hysRqAbqVXQI7THCrbW3OobCp0ciPXiEeYZh+s0Y+nqFOyXk9O8kzwVZG5DedtrlNxrQPtV2GBlj8E7s38kjmdY6S9jAkq+wDw+DZ0mfPeUciHnhZ+Bo1s1EQyhtsKNLIOWrlBg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VoLOYfpGzYtWjP2JZba3Mdz/SdivFdxdbJDqM+XsfKHmOColRwCbgFq4pOxp?=
 =?us-ascii?Q?Md2w6zv9DkBRpwh10cIOKyDpXIn1YsKwwz6GB72zUb1e5Magt+z4yv9+cXfV?=
 =?us-ascii?Q?V5DzhoOfE6sQKpbsyPC1K4JhlzYdSs3Thr8Gwbc3l5A4uROjYkQqPVxd593f?=
 =?us-ascii?Q?bj3QzDZn8r61K+PpY/LODv784R92q9c7wpkKJxQC7HbBHW6NGCMy3AUFTacP?=
 =?us-ascii?Q?mrwncgtG9kaa7hgX2ELfCY71w+rCO3XbZRhPUsfXzh7uKt01cmHJMr/ouPE+?=
 =?us-ascii?Q?Kej83dIz5kWEe2LmLENl9P6gVLWmc5P0aVHOGjX4+4t7iJA389qXa7bqJc/H?=
 =?us-ascii?Q?nEBn7bO2qoRuSdYcWziW+dF70bDqtXOJTsvmbZjOEi1/0bl3OKZILWSthwMM?=
 =?us-ascii?Q?dNSFVTLgq7N/RKfAXWja+GZmvl58bJuKTjsCXUFUA0NVGRdx0JxjMTYxIkNl?=
 =?us-ascii?Q?m3vFGWd3XUsm4RDjzmdD7MxXPkkQTBwUZY0dAdMMW2Lkdu377bDcX4o+PGK8?=
 =?us-ascii?Q?03SbJIb+W/w4vXoX8nnzENnYpAfYw2V/Lzw9eVI+2wjbyxliyOlymZwyvyQ6?=
 =?us-ascii?Q?Qgnl+L4Z66Ipidz1cQxqbXO176/2Sn8InWx0Q6QftRBK+NnQIJ9ENNjFEyCZ?=
 =?us-ascii?Q?WC0lL3zwTtRxYxY6Gh7jL8oMzrJM6/miIt4Xr3mUkzbxSrhvf03O9yEA1x3A?=
 =?us-ascii?Q?6T6yq6WdSQbNVQksW9l4wbiMSiqDmGntDJkKBnIegkNohg083dMuPes31HBu?=
 =?us-ascii?Q?uT9pRZ8JVQvylxCqKZEPGANN+tJjPc1KQkwFPsQNPB4gCCLCn0XcP0kiAF3C?=
 =?us-ascii?Q?x0HnXPnj3WTmk/o8lsSPwSkTMrFt4rEOwJZIh2Zbd4iM3kcV3a4qE1NUV/Rj?=
 =?us-ascii?Q?22xJmH0EcEolk4dZLbbQX6WZUrD9s3I/a7AulvsBHZY93G3gU5clU5gTDeqj?=
 =?us-ascii?Q?LcKQyx4Z7uY+uHXkPKLnoLre2ADNHgo64rRLvhCtxoTRTePCMcdOpJAwexbT?=
 =?us-ascii?Q?xFK96t+Q7rGlp3bgHAsWe76wn+kIc9xZo0UT12VRSHoR+K2W9FCk4cNHTY62?=
 =?us-ascii?Q?PZB4RPkfhF6NKuW7mdoO6Vhgj3sg0PtrMro6G7LwcN5mITffXHGpt2BeSKAR?=
 =?us-ascii?Q?MC7fBtm0LA2D4k1QbPTX52UT9glbcexDiL+RNbOzVP2AgTjiVlWdzgHobIk8?=
 =?us-ascii?Q?Y6y66oaBLh/wGuxgSBBhgH/Hv9u/3g4OUDe4QGSNAw7zFzpnVp5u6WmGxXGs?=
 =?us-ascii?Q?Bvr3NrSPb2HyhKWsBvee/b4HkE4YmmH0vnuSNfDCwb86DjC30Fb5oxzItvBK?=
 =?us-ascii?Q?Ns5CeG9CyTSePbNndJSm1mRMpmMY86KfdvneD1UGP/SZWeUWPDlsa8Dfp8Om?=
 =?us-ascii?Q?FtncG5bolWT8m8bOqVbfrvbDmsqYFjD9EZcqXtX1s9YRVD4aTxPGd+9tYp6d?=
 =?us-ascii?Q?mQMM9XbgfG/PQ0nJijcQjrFXR+VDIQcr2sybcV/iORhZMXXYDBeO6sR/QWnB?=
 =?us-ascii?Q?d2g6zcPTcwy5OPkhmvFPDJCU1eUouSe72A0nKWUPn9bwcGKsPp8h+m1EA7P9?=
 =?us-ascii?Q?ovHSJbE7KPMEfTFckNkfYSQWxoWVSNK4UecuUcHeWgGUtmBnKt4C0bzGTjT5?=
 =?us-ascii?Q?8opzbftmgDkpR/lP6GpncQwj78tA31OS58Uj/IcuGshddKj9cNUey2PxAEZs?=
 =?us-ascii?Q?pQ3rZpPLiyqdK4stRUbE+zjNZ00X7Cn5Qcynho6udtGntNe9R0y/9kcigeQd?=
 =?us-ascii?Q?hijbiYdz5uHQpgBNAx9etA6+5dFg0QieXCUAV8rg4RWvWmCjMJdw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2330caff-7e73-4552-711f-08df3015a4b8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:42.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvqaH/eZaPn5U20xihciPtsZyX8MiZvvQSlj4n9HiUggXCf/ft8BChLZp9oodvnYX/w0lgX33x/l2CGeLdUTyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7221

A vNTB endpoint can place DMA resources after an MW in the same BAR.
Limit the MW to the advertised boundary so clients cannot overwrite
those resources.

Advertise this support in LINK_UP, including when DMA is unavailable.
Older endpoints ignore the argument.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Add Frank's Reviewed-by tag. No code changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index e0016128b95c..56185870cba9 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
+{
+	resource_size_t end;
+
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return end;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, bar);
 
 	return 0;
 }
@@ -524,7 +541,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
+				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
 	if (ret) {
 		dev_err(dev, "Fail to enable link\n");
 		return ret;
@@ -707,7 +725,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -739,21 +757,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, bar) - offset;
 
 	return 0;
 }
@@ -851,6 +868,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
@@ -862,6 +880,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Invalid endpoint DMA layout\n");
 		return ret;
 	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    ntb_epf_mw_size(ndev, bar) <=
+			    ntb_epf_mw_offset(ndev, i)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-- 
2.54.0

