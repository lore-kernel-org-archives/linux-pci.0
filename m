Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA1244667;
	Sun, 15 Feb 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173548; cv=fail; b=Mu/VpTLvu7fngqLm74cqpimKe5ufljbTOiczAYryVYbxZf+2myL8bs4DfXwbwgczlMKiQjPSFji1yjkHG97XghgoRn0FPuTji1J5Kzd39hNgf6LJJcYtQlEJmBB6LgW9asu+TJINUAU1JxTfQHkT6aKXZGC+EB8hjy/AZXMEbSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173548; c=relaxed/simple;
	bh=9Q9qko1WkESgBX7kwzR9bPXHZaZqmeuXgr3J5joEKik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsnCUSucgN3vhU64rDvlwCafv2tzZRHyCJL6bA6mvWANS+m20RPdeV/agcschK0iuyqz8BOHNqCjeHQpwnH23fqGqLNpPkcHSJXjj2tA9A/StR9+2YcH7ymXcnZana3k0ITD3OdpRyvMxkEtGK3cMiV8G18+Uu3p4J44bpvktnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YT3pUkFd; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YT3pUkFd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecFrX9BPWakGg4BASE+Rf2R8u2eL+6B3m0Dt/TKea33ls572IKwI7YLCkK1wC45lNKWl801qGFUvWcTh1a3LLDEOUtT+EH2LfPk1HDrV6028trq99/u3zu3E645WlXBo/vqigImwqecUL9xl1HZX78OCch0E6rMOz5MFTRUxbQUJRf9QJkI1V1Dspz6aaPR2CBaYF6QfhXcPZr8PZHCRBuJgx6HwnVodXLaxqFufVeQCjVRLYEbhyKw8FPEuRuIaJicpq0n3fTvKQFNdJQpimp/a372cB3Pa0kEZDRwhKSzsvxNGyCaL1SNlXn1byHJI0p5rNZlSjqBHHyj2mOzQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFcVKHil3Cz9aiQkWsEZEXTsG4xoIsNXs+oJdexGnc0=;
 b=bVcgKAw9PGfllrgTR42SorQ5kQq1LXmaacJJCvtcPC2kLTSrh+WObw+oZ36EBCI/XOuIMut1rg83LKaoxsbxt6QZpPD1CaKmWYZHsig1anEmR+4y1SKYGFpLpL39QHk6bvILrX8xO9VbgwisG1TYGRmKuOavd/e0Y+TP3JiXDErVNdF1G+W96Ox6Px73i5SP2yKv7aoQbYnWLOJ10UMLTdhcH0seEyPGyl8f9D/Pcd4senX/kF1OBxgkRQnXhDx7vT+ZNz6C1gOiqDTK+pB7667hQcgAg6waVQen7jMaDWZDKqqjZ5n5DAYPaBct+ydkoYenBrdwhO12JmNK18Gqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFcVKHil3Cz9aiQkWsEZEXTsG4xoIsNXs+oJdexGnc0=;
 b=YT3pUkFdSVduNGlWt9jZjc27Qt5IVehXLEqCZyiJmMfbV9SRZdIokP+H8ygc5YHlD/OA6XGOYI0/F6WhazBQqz12mwpWQdi0RGab32FUcwl+yeFTOh/ijufZrJKr3pPaK5jNhxyqKBCjxUBWSdfsKXAbYVGmLJmnq5mlvAkJ1RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:02 +0000
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
Subject: [PATCH v7 1/9] PCI: endpoint: Describe reserved subregions within BARs
Date: Mon, 16 Feb 2026 01:38:39 +0900
Message-ID: <20260215163847.3522572-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0034.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: d349f38c-cf22-4fce-08cd-08de6cb0ba0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gGlmpkXO9MP4nGYBM2HxwI90U0GFWPUO56voQd1etuiFesVQNIlInm5IzRng?=
 =?us-ascii?Q?C5n4tpPqjaDaYrkKlwCYm5CFIl5ac9r6rUIMnAT/B26ufV35Rpe1esUjTbJ7?=
 =?us-ascii?Q?2fWHQjNkg0h4ms0IuRv0mMf8VLlKRhw6KH9EM0QjOZym859FxUSxACsmPf3E?=
 =?us-ascii?Q?fuFKwphr9eR2thFWayFyQ2iAD4x8N8XIr/w5UcJXiVZDR9Q82zLIk9wCkCRC?=
 =?us-ascii?Q?Rk6Np75iQckoNoWWy4IYa3ju9QXCfbA4iUS9tn/89RyiYIn9cNtHnGTPL1OC?=
 =?us-ascii?Q?cBFNfhYSVfup15iX9w4RDg+8G9SWuE/7caHnoMUlv6U3WWF+GnIIRhe/OkV4?=
 =?us-ascii?Q?mnrGtE5mYFCvULrYr/aUfcgxtATSU/+Svng2B7Ciu1rV/H1dOG4Qs6aeViNz?=
 =?us-ascii?Q?0CVwCBQmHe7MWpklIvhM/ZRhpmqGlBXrQwUqskkUaSfh5fwCiPKI1d0c7kia?=
 =?us-ascii?Q?8EjXwFbhqUJMf4wiDrDKQ9A97INTCBiZ6CaPkltZ484gm9BFNIhzNZZIpSxv?=
 =?us-ascii?Q?IqPxwYP+XlSoctmCULcE4exCuy1gfyKlo82/1oYE4pdgj2367uYG+VwEiFEg?=
 =?us-ascii?Q?6Os1h2Cb/dNtFTiLK7AsqJsjkzv5R3/EFevVbU7qpMAEXEhNA8J/sZfHa2to?=
 =?us-ascii?Q?TWwkVAEDadO30X4ZSJjwmyeK61nMy5RdeIpLGbKRQPwh8XOSEVHv9YFzZ/j0?=
 =?us-ascii?Q?R193Tm30NiTOcuigT3ReAMgTdLaRaQadUYF0D72MDZIYD84eNqAmU7uaw5mS?=
 =?us-ascii?Q?p3GQDbxKOQCd6DXYPCEqBnTNSR6nLtZDjUsSRkIrd78h17laWnbblZzLEOOQ?=
 =?us-ascii?Q?lkOoWtU5j19ApVtc1pYymN4I+XyOoD14apFROFit2Mbxp0H59HZf9Whyvffn?=
 =?us-ascii?Q?Sh6YDiwJ+lKK37009cmqKMqkzePIazClV70FTYbhAtcPlpv6KnZJkW9LSZi7?=
 =?us-ascii?Q?Ff6gt+U1VplCoiiO0mvEHzXwrseM+6DJVgoBp+blANR0wsCJQH/VVjHE4kjQ?=
 =?us-ascii?Q?CTUywh5NrLMyN8pjCYjONxXjFaB+ttsUssfb48cqQl8hge/x05kQkApFk+wI?=
 =?us-ascii?Q?0IJOHU1NPlfYhfbKMFfXndUgZVOqD+A4kiuDGdTaVTIup91YkTSXXPDd2vs4?=
 =?us-ascii?Q?e8/CuRXRtS8FUFL604aBWNCx2Rx200FCvWdsIS7zfg1cOsMmhUb7ZlplKJpz?=
 =?us-ascii?Q?N1u5okRVciSwbMOBrClQnq5BN/6M7F0SAwSOumcvO5M8kltM9cK7+Lr+W1Tf?=
 =?us-ascii?Q?XWhaRu08mTu2r9KBc/2nGZRjFWLQ53NZ4bnUZHNL9f2dedBDRCkNR7xcdWyx?=
 =?us-ascii?Q?H4xyR8uSbKkhx26Hl7XNQTEr6FrkT0BH8KtJn8Z5KnIcdPVyw4bHPPTlxCNO?=
 =?us-ascii?Q?vz+gevQu2NGQkG6/A1XG0lcMjl0pJEXXuRt21tXUF1+W606p6JxHlkFgjiyC?=
 =?us-ascii?Q?tyuBDOg5yhzNLTgKpFfDm5d1jxQrvFO53Y0Av41n1gV10dt5zRUdoU8mkDjM?=
 =?us-ascii?Q?gQdyCKhtmQ2rUBXyKIJUqbJwX21IbuQ9fX/ZY+5nkM4lovu6LImrujSzgNly?=
 =?us-ascii?Q?A2QjA/XeVRu1wi7MCfdcB0kIGm6YMOv9CujtNMMY89zQ7/AcGwC2G2v0GX4w?=
 =?us-ascii?Q?vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iu7RgkuxCvvua67wyER7tPSucOBWjwDH0Ws6G0jCSoW7L5BlpghSWHSr1F/j?=
 =?us-ascii?Q?1xcniEDRaouw4er4m5eP6AFL5gsX1VWAcP+GLX621nlwfrV0+U8+RtKdwZdk?=
 =?us-ascii?Q?vw0uXIzmCU2PvHB0yiJ0fB0h8BuNGKpvuGIjZXGv783sq2tEX80TU3vK3se7?=
 =?us-ascii?Q?2wIsy0bIvJSZIZaL/xbO+6vqkzNAo4k88ZEinEsyLOl+0X0CrpiPtMPM0pl5?=
 =?us-ascii?Q?xCxdMOepmxTT0UwD27bMlwF8WUfUH8JlJcE9UiTJCRU5irgAPeJpqVOFztJV?=
 =?us-ascii?Q?WtO0MmYa+Xg6gWVy7zSXO6hKFup2Qa4kEwCdiqZVPBfGoYFdJeG2yH/qtCgw?=
 =?us-ascii?Q?CG5zsMi0dojiwb6Tj35c0ljkye2T1L+P2QdZ0zLT7ZbPBzjlTEKSmFoFad6D?=
 =?us-ascii?Q?Dy+upHuMjra13cyxcBzHToW1ICe11RPkUihQz47p9b1/A7DB3/tfQW2PFw6R?=
 =?us-ascii?Q?tmMtwFtAzqIt/Q7tKFWqVT1+wC5R8HW4vJxyCXTYdYpNhOErs1EgRJgJZWxq?=
 =?us-ascii?Q?uBCqIoxjk2nJKBtVLHNLsOxZPdbr9GFdchSqjhYT+do1ZMjXf+OVuPUpIOJS?=
 =?us-ascii?Q?RYtSaN3IYV+lTWGD0OCI+LxnvLCSM2Cuo/Y32rtqA1ILLUbfDtm/gH6FLarW?=
 =?us-ascii?Q?Bco4BZ1D6W2yJlW8/Hgci3/MYVW0ZpIiRiPEhdjBiXWQOuQo/nLz0kXS/68m?=
 =?us-ascii?Q?EHzy5i6b0xQOOnzpHjlpQh2gt4JLhc/SXuilNy6B75zzFDmCLEumb/Dpfgyf?=
 =?us-ascii?Q?l9pEkvo9LxHh5sjtnMMSO0kZtVWVoHtjaX3ENycV36Psc9qbJItXltFg+Qfx?=
 =?us-ascii?Q?v1VFiU06itynkXzm7BPoEk9nmt8iGc+BSdkVFhB14syqpK0QW+Vr0GB4S4rH?=
 =?us-ascii?Q?SIK+M2oJy9H8cwlEPd7FqmJXXSqVQ4GL1l+H000o+zx6Jy9aBWFyjVZRQ1Io?=
 =?us-ascii?Q?vmrxJs9TBdnuA+SXP3lq0PzCHqtHCwMPBsUZlWg5js46iUUfWhABpMZhGbr1?=
 =?us-ascii?Q?qfTPwu/C/40PaCWv+c9l8mOU2MuMhcYCjtUUR8j1Cccgacfb1XjNBxLHm0Xa?=
 =?us-ascii?Q?C1oUxJyn5LIU2HmGeSbdsF7lo9B6ybexFDKbHYJv0RGYWxguEs/e6ccOPxin?=
 =?us-ascii?Q?hqg4dVtwrnMU4giiPvVmZZTYRzljR2jymFxM3VQftuU0bbAOGZHi7iyNFK0t?=
 =?us-ascii?Q?HxPDXjc+ID1+JKe4um1yIrmkH/vUgRt5TwYep8qcTMiaSZ/k8lY7hK04ridW?=
 =?us-ascii?Q?h8DjEBiXx8HpKiwZt+8/1Ic7Kowk8Sm/U//lym0E0qSWwBczYiIcymF+JRF0?=
 =?us-ascii?Q?rMFlrG93itsI/eH+HgRzgqyp22cFh6fTtRSu8nW3vENd2XhQxPRy/dYuFQ+1?=
 =?us-ascii?Q?Nq/yQ2Apit0ZiAx3X+SuU6wn4YRfUPpnpiZoUZMBkdT7HjTgdBo565fxcGEb?=
 =?us-ascii?Q?LhMtjdnfMqJz2HmlVPv+7HtI5gUIQqng/Ja99/cP+IBMDvFeBLyY2uVIE5cX?=
 =?us-ascii?Q?LtaOmW4inElK/2gSRsGK+C50xi9eRBDsd3cDhZ9Ns9KimlxDpNiTfv1+LrFM?=
 =?us-ascii?Q?LR+Q9Nh1K/1OFI3sRYKBHigUKzTXFOoI7mDwu7APBDdOu0fyL3dTJJOK9lxL?=
 =?us-ascii?Q?JiYm9FgXDsO/h6oW70IZvui1vpnV6Ox7BDHkxMItTVLCGLKWmSz0h2jT0ZR6?=
 =?us-ascii?Q?e3hWyx390OgMzFtBNPSCA9ZvlUhlsIyn2cNf10qvzVuOoxQsaeRFZyFGNJXe?=
 =?us-ascii?Q?dRMe7eETQPXXWTt7+3ryv+BMWFFZY/g1TrSoF7zcD2QQZpeftVyD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d349f38c-cf22-4fce-08cd-08de6cb0ba0b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:02.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWgApkOG9Ul7jokMEUWw59KchXHAddxVr/CUpdEFtEzvgdLYcnXfnn2tXkA5dC76gQptbtsyQFKXo5/qCR+0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

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

