Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D612DBF78;
	Tue, 17 Feb 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315574; cv=fail; b=EPqxVUnrX2PF9FbnHc9DlGZ6vk8toMg1qnc5UPoFGOUy8Uum6nqh070uiTVNeDmU7h79FworonHS93gvGhhsRZJcwD2GA1A2smEevW3vwF7w6IZEmjpc02xS2wr01Tp4QKAdeH6BCZCV1t8ur6r44q6ELew1gqC0VgaRkVDhvHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315574; c=relaxed/simple;
	bh=9Q9qko1WkESgBX7kwzR9bPXHZaZqmeuXgr3J5joEKik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJc87JrQOXaXkGfQv/sEzu8XyfZ/BydV+ekFSM+Mbd6LiyDwiIWTXhH7NgqdtVUgEDmKJF0nOwL9mESrOxfeCfBhpqZiIaWqbBO10840pwOSUA00fDTbSLj/WVLGcRgY6t5aC0eKqF0AcVIULv8boHhoCNn5XoEIFZ3o74LSNSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kHu2iBci; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kHu2iBci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgoamDk/UCM7MQ3OLA6IXbMtexZCxyoo1nYqkQlJojmZjIgPSrbbESVIg78RKSlHv6x5cebr9yIkikkRZD83f9PBU5vIYkZwwq3+c2WxPfygf14+zzkxrvZkkj3jvHu1ijQLokmRvI4X2x/PGmQKlNxjAZu1ONb+ZK9uVV/odZJOTrDaQT6X4GQFl6kDthd2WM0FpnF4Hy8/2MI7BOS3BfubEo3h2/xlMFtVHonanWGjYq7apssuuT1AHKozUxdr1vQXys08KAj5BIlsjXlyTnfcH8ZU4gGBi/ZHPOQtMDgcvC/Y+xYez5ZiWhnzchhJbdZ6uyuIwQp2nI8hLVq4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFcVKHil3Cz9aiQkWsEZEXTsG4xoIsNXs+oJdexGnc0=;
 b=OoNb2wUUfc6aOP02AycfNBBh8u/ek7WkyRA3wZWXbADdkKe5rf/oxA6Use+oOzFp4LsknXFaxh4qUnC8Y5dOXAoCgVM3PcRSQqg1yKmtG93TmAWVp7aBlSOJ7L5JFbyuwX1zgMXfirQ8LkwsliXOdU+6N9uQ55U+3gTjkAMEnFqVYhM0Ofu4gakHnSwDAapjPZVeJ4hJYdRG10w2hptoej2SNbIdCysLbvHxDfek5a+LamMApDGcZs1x0lHJ0ItJKZeuGj3G0TWJDuPYszJUr+pMxb2T62v8/6vdqroKVXdwASv2Q8gABaFFKVdEMnc9C+lNxK1roLRlJmGlRiX9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFcVKHil3Cz9aiQkWsEZEXTsG4xoIsNXs+oJdexGnc0=;
 b=kHu2iBciAKF9h7xE1rWQIdH4EFDV3qCFjy8LSLOSTN9zYH6KANzHlctPJox75WYYW6WMFsN5xwjeUeNQo0akCGP1nOhE50AuZWiFnZXuxoJHmuHbhFPsfAI7XvAaLkEnYAxoaC/UphIy78D5cjnTl3cslleeZijT+/fPJJEMTZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 1/9] PCI: endpoint: Describe reserved subregions within BARs
Date: Tue, 17 Feb 2026 17:05:53 +0900
Message-ID: <20260217080601.3808847-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e12b00-c874-4e17-2b09-08de6dfb6811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zZgIdZ41Dei4UnZm1PxK2jl0XjbW/OLDkyqAed7xc2SLzu24Mbc5hFklTcS?=
 =?us-ascii?Q?f6uRb0AMJQQHLh2gPjAcxNDFgUGYFEaIoHfCTYrT8ax3Y0jakaDIIcW+L7B+?=
 =?us-ascii?Q?F4NzbBavd8i6fJUFuhe5m0XV/msCMP8O/lKa14Xy8Kh8rgwPbl29q4qFXFOB?=
 =?us-ascii?Q?0T/ECDgu9PrxpR4soDRYv+zWSpRH414CTpq6hK8Xa0s99XPJlzYg7lV93v5J?=
 =?us-ascii?Q?rbutxuM3EoxOkyjKhxfSb8VqnGJgoYik6K8Do1sZddEejiJ/sJC42dc6FU+R?=
 =?us-ascii?Q?8gb2YLotJXwdVIHX6pt1r1kN7uu1gV9QYLyMN/Z+/TDWn3+ClVwxlL2pxY3D?=
 =?us-ascii?Q?f9wHHUiINePn8n8NTzECDiqywHKOl11b0OTHVwwIL8b7tolQhXx9DHKqwoQF?=
 =?us-ascii?Q?ODwGoUpYuN9bpyZUZYBL4PUvkon9ocbxNerdX96Nc6TN58fKdwZJ48O/7sD4?=
 =?us-ascii?Q?F6VYVFW4EacfKaQy8SFC9jzE85aC3RvOOpHCQLzqWfKS6yazm8++gUquAS63?=
 =?us-ascii?Q?cmviRC6NWbCfvZG7o0dqGN7nOifcVdinHsfjckJQT+kDfuEbVW7a+w47W2uv?=
 =?us-ascii?Q?P7WxulT8I59m0fK7TMU81jgJA9SlQDFTJqVcHHciiONrNDAgYO/GfUZYd7R6?=
 =?us-ascii?Q?arwBaCTXKgVhoq+SseEEhy/pfkd7/8golxlQ1qAQt82w1hmc+S8vuQDJxXCR?=
 =?us-ascii?Q?nlXlDiH1QEgrsz06VmjZG7Em1Tq5QmCb80b1QxXJkisKm/90E8R7cabhvCMj?=
 =?us-ascii?Q?N2bs25lG7eONLfcuiDXrCko5LqRk630V0EJ6oPrZpyOHBSdSrZb4VV0IivkU?=
 =?us-ascii?Q?6jv5edlHBiN2xlugbRAT9QMuuQC8MLB/rbx1arUHF6V00YypjNigy6jXmVkr?=
 =?us-ascii?Q?f9Um5mV2SJRi7zKMUQb1yXH3bJwrtnuEcxv1nGqvKrJvgg1lRm5E0KRH07Up?=
 =?us-ascii?Q?Cyj5HsNQOdNjPB0P8/E5FoYk7mD+GXy0ZQriK9Ah2tFKYbxIAHkuLn+WfaCa?=
 =?us-ascii?Q?Pjpzn/ebRHe5z/nbHg828+vzG6AgQLN0tIFOEuh0F/YwkF6IzfoiRx85sUGF?=
 =?us-ascii?Q?0S+sb+9XbOVvBk1XcP9qNvJM0jP75iRGbl6ajRxCNl6YAcmviS8n4fkPQ2FW?=
 =?us-ascii?Q?wcW7Z1Fo8wCp3BUksNcOURKUiAIBeBLf8e4IFWujEucjJAP+2ocW6RsF9/8s?=
 =?us-ascii?Q?jow4i7QthFUnDFv/QewKMhLmwIownQKqUKCo5XFNN+/p373CFt3L8cT0DeLf?=
 =?us-ascii?Q?KZp9K0tpx9PL2U0acmtODL8tPARkmQ0Lw3SoED7CaNNsZ4rvbm8JrK8EaeLH?=
 =?us-ascii?Q?rJs3pFJkaKrPV0HyesS8+3b/trB63Mx+/myfaaupHXyllDYbLHQLeairrobe?=
 =?us-ascii?Q?fadHLpupwPa7kJl1yyy4qkJ4OliAnjNkXZOQpblRz6eSPEjNbFU0mJG+pZlT?=
 =?us-ascii?Q?KUfLU7P5ezTKpDNc1gvLUTT2ezJCdw+5KTdd4JNR0+EOnbVbz5ySJ51nqYXW?=
 =?us-ascii?Q?oU9ANa1THMxBnprD19y8DyfmvpgnZ9LcBcgQCCfopcO8iz3w0AyDeBCwxVqT?=
 =?us-ascii?Q?P2/K8LaygHw45IN7Jki4w6tZbjbg1h+Jkex//5mP4Cm+/Y3+DJ6qimzQrKzt?=
 =?us-ascii?Q?QQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hs87sIMVKPJLQX3ufSLXHo40yDEaq3y2jbjVzKmWL15JDOBaysaQl20wm/Uw?=
 =?us-ascii?Q?5Sqg5EfHzPzgjXQc4XEQkbzm/btMN2cpCnLVa61WGGqDab/T47Ql+TO/RsUJ?=
 =?us-ascii?Q?iivTEvDtW80FxHEYYG8xIaSjnRl62F3PUtx7hvB9x2Hu6UekTyRm0SuJ9H6k?=
 =?us-ascii?Q?EXVxNFPfvEmURYYtEM/V9K1H0FbpTSu84g7xoJWwN9KKNzKuIL2bU5Gt3URL?=
 =?us-ascii?Q?uPoQjK84m2Jln/A0hw/yArUw59/v0UbmtuR/PK36GJCshJK7CIF1juPgsPpo?=
 =?us-ascii?Q?6G41f1pnSwe0nlIch7Tqqag8ZjwuVIlVEsLJjw+rmHW7SiNZ8SI0wpUqmjro?=
 =?us-ascii?Q?O7CiEdGeFVfWJ+wvwZ9lOlUUUN3Im73LrYbDJ4/DXuDGsPrNWprmWeWA43+/?=
 =?us-ascii?Q?5eFBU2wmJugNk88EfqCV9alGgAJ7wXcy9dmsispsiW889yQcKV6ntL7AcBwR?=
 =?us-ascii?Q?5ctzW/AR7B0Tx8751k08bzQ/M7Ved14Ykj/k+JlLhUWLWGFt0Jb5a75XBAwG?=
 =?us-ascii?Q?VIUpGhGqhPrd/nczktSY5Pae5JhYbvQ4NxSAG1N/8yxGxY+hGt9ht+F/FvfZ?=
 =?us-ascii?Q?hVeOXTNKYwvaHCYiOsF1G65/7Dw90meGmrkd42mP/CGYW99crMMVi4CKHS1w?=
 =?us-ascii?Q?uvjliO6MAh5UESqEKs+RxPQw7Y/loq8axYTkWn+LU3rNuwMXHvmoDyOc52S4?=
 =?us-ascii?Q?3Juohfl196n6W8QkC28GIKsGSN70sNhs22INeqmcAf5cNigTYS8GHxwBcj+L?=
 =?us-ascii?Q?AxvrFVBw0HGy6Rvkb6RZZUYKq1m4JflSX+y9CCI8zz27y7j+L78ROnPZNe2U?=
 =?us-ascii?Q?9LdpMqIvkK9zSBidtEKF92eIb2yL8z4ujNlyK84s9coO1D6uQiKUSag68mbQ?=
 =?us-ascii?Q?DJnrhS80+8tHt3JM9+dL4p5FaUpzNbhaluNm8/WwgKUihWLGrUr6mN8PZAw9?=
 =?us-ascii?Q?2wNV3T1DZz5/AZj+MuS0b6Rd/o5MvRSGWwo/phXEjfhsHiNWQSsmLrXenx6x?=
 =?us-ascii?Q?vaOnoItI99iVym7QIOK8s/pu9YMA3goM1S2iAfenOTfg6WM8QeLh5FpElFPH?=
 =?us-ascii?Q?H1KFRg+Ox5/ljiHCdu4v6JQBStBUtDtiEMMf27wynIkLGldDyZUYUpiOoRWf?=
 =?us-ascii?Q?8fWaVfm4yRIXVMxoNEI2n3cNXVS1cd0wh8nxJ8iBHqt7thjQFr5ACdpZ59Yq?=
 =?us-ascii?Q?sDcr2F90rrSbxLnqcoqAFs0oWsVoYydsdX8DJNJfMX6zz2+lZkGREUoF7h6i?=
 =?us-ascii?Q?nk+ONwZlw2BKGT6vnnDzCARp2zmpW8yq85I9A/OWJj1M3jJmlRCaqdU4DTRq?=
 =?us-ascii?Q?t8c2hhVFtTyl9MkBeXCVUbomvMrbrlUhG9n8imJLT6Pqci4jo5Ngpbcfh+MB?=
 =?us-ascii?Q?rC7Ku5DBsF7mkbwUQbVnRQtxasJYzNudDlxUtruP9UFHl/Er0aAXeHMgDvm7?=
 =?us-ascii?Q?oujErQzgOjM6cxou0nn2KcMb1b5NEiRU9Dzlll68oH0YaZJTkHIrmoW42maV?=
 =?us-ascii?Q?Nl4as3s4LuX3FDGoV8cdRZHe04xo4qv1+60VFcYs4i2Alq4maRP+yxpKgBuC?=
 =?us-ascii?Q?rT11sKydS6SOtOb98h796Px2dVEhDiAWh1RQfa0rLntVX7V+ykj2V4f6jBoj?=
 =?us-ascii?Q?eNye1i1RJwSDih4AZWY0ANhs65Kv4vpsR35IRShxQNG2hDln8TErNsFdflXY?=
 =?us-ascii?Q?P0k9IgJ+aT6Ld01bz9Un15DKqHDY7NhPt09oPNjLDrF0l4Q4toWRFEwhUubm?=
 =?us-ascii?Q?RLUvnB718MP8K6I2vVzPpOeyIE4A081Pu41D2V43d0+hpY2J07Gy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e12b00-c874-4e17-2b09-08de6dfb6811
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:08.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dU63ebQSHM8CUigvo8U/MTvJSdL0Q42o6uGYWR8cFPG7UTWacsmGxJ+pcQ+4X8tOlU5SLxnH9+wLLt0fgdJ3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

Some endpoint controllers expose platform-owned, fixed register windows
within a BAR that EPF drivers must not reprogram (e.g. a BAR marked
BAR_RESERVED). Even in that case, EPF drivers may need to reference a
well-defined subset of that BAR, e.g. to reuse an integrated DMA
controller MMIO window as a doorbell target.

Introduce struct pci_epc_bar_rsvd_region and extend struct
pci_epc_bar_desc so EPC drivers can advertise such fixed subregions in a
controller-agnostic way.

No functional change for existing users.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epc.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..7a87f5962dd0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -200,6 +200,30 @@ enum pci_epc_bar_type {
 	BAR_RESERVED,
 };
 
+/**
+ * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
+ * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
+ *
+ * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
+ * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
+ * EPFs may want to reference (e.g. embedded doorbell fallback).
+ */
+enum pci_epc_bar_rsvd_region_type {
+	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
+};
+
+/**
+ * struct pci_epc_bar_rsvd_region - fixed subregion behind a BAR
+ * @type: reserved region type
+ * @offset: offset within the BAR aperture
+ * @size: size of the reserved region
+ */
+struct pci_epc_bar_rsvd_region {
+	enum pci_epc_bar_rsvd_region_type	type;
+	resource_size_t				offset;
+	resource_size_t				size;
+};
+
 /**
  * struct pci_epc_bar_desc - hardware description for a BAR
  * @type: the type of the BAR
@@ -213,11 +237,15 @@ enum pci_epc_bar_type {
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
  *		touch, then both BARx and BARx+1 must be set to type
  *		BAR_RESERVED.)
+ * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
+ * @rsvd_regions: fixed subregions behind BAR_RESERVED
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
 	u64 fixed_size;
 	bool only_64bit;
+	u8 nr_rsvd_regions;
+	const struct pci_epc_bar_rsvd_region *rsvd_regions;
 };
 
 /**
-- 
2.51.0

