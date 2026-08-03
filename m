Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5A43231D;
	Mon,  3 Aug 2026 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780298; cv=fail; b=baGrFxakGTQRGofDBs9JxLoUKFjaGFjYJ8SXIejvkFK5uJ6RmUmki2tJ6hu1XpU1nobJszgvaG6zddGhXAeitOCGNYZKDjb6nsKJLoUHWBB4vNLYc1jkMGSYxg2Vrm9fpzFx87DymAWgIcJSdDNzkcdYTpUq0Fqrnjg7VG7mv2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780298; c=relaxed/simple;
	bh=j5l0qI1sp4tRfewDrM9Ps/aJwOnq3X5vW9PoeouLdkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qspTT5yKO/OgOMLMJ9Y2N4soKHSPkkCGfS/NPdO0tAwWC5XDKliFYRYulbWU6RLq1x+LovisMNrKWSIWs8/pXoWbevN+a0l6AqdhN+J0wqmWwtTcpYDzOvh/sU0drMzVjCMknMycWa1JPjmeSludHU46qrtG/v51B1MGwz4aD/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rA3XR8dz; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rA3XR8dz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPswWYc7p9VXQbV7TBGJlaEpPJ/b9DGoREUDDpokB+3B4I4X2hxKq0VBeEmxp2DgBlWgm659KdeUgTLDMTdUXANiflvx3g6yOnb40TycEVarH7jEKba5FKEczg2/AoOQ6ec9flutL3EyZgl92DKe6QGUt4NbGuM71XZQghTTE0LYu2f+hQSeRWr+5r5f1SSQmkekF6oFec8s7tLgV0Mk7axhgd+YcBOuOh1cO2Z65WGLFH/gJkZK3IOGFzCyrJG0Lmm5fPDGeZKhtjk0yUYYTRTc3HKZbBp40/0k/E+q+RKKiZAmZr5V4S0+s2aFj1r/YduGobrNnTBabYyVq2V9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krvPwx8R2qv7Yh/LwWeB2iZCi8KJ2TXbV9n6s+Kr5Qw=;
 b=NhT9ehv7X14WuW2folJ9mhxQODaPcW0xbvI/bVi/Jk8IQbCUy6Faoa7xawfiJalZ3KPSz1G1xPH3TQQxkiHMTaeftHLRf2coLJg4mKZSH5SXAQZs6SzT6hS5p9U0evkQh3K4LuPVR9QGBBF6JQ9PKsw7iZq4e7YDOdsWnDKUHlCbmXsOzQWOcc3+XT4nhAM95ntFpQDCTCRAQbQl6jl0bDmjWs5boGmN3h5Kh4e3qovouUTHeTavU3EPAc4xB3dLIvxdcyNlZzaWbPpaIUVuu14LqleTf2Lq+J+IWwqDwRpcEE5EdWjmW6PU3ZOqpgW4Z6PvXk0Ie2wQnl2oTo2DIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krvPwx8R2qv7Yh/LwWeB2iZCi8KJ2TXbV9n6s+Kr5Qw=;
 b=rA3XR8dzRh274B/mtd9if6RqKZ8hkgqCNSZkqModu+Rn7KpSurJqiCWSTKaogj/NlUd9JX+JaNIo2qhbZyhnxE6UQCvuT+UPEe8L3NLSJ4OVvBntMopCIBA1IxNaCrcawahbT1PG+4zm5zUPip7PurHvcfe+aChxrB2Lyz0SuQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:48 +0000
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
Subject: [PATCH 09/11] NTB/msi: Require a singleton memory window
Date: Tue,  4 Aug 2026 03:04:36 +0900
Message-ID: <20260803180439.1963864-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f36be4-4a7a-4d35-2645-08def189b536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TWqF1Tez1rLF/Phrlns1R5IKpLUqh1igPAulhBl8mwPh7b/HzwJ2tySfIIrsLMZx7g4A6fyVn+E55GLvWF5asPfoq60VNqS3/o31SXAj22A4GlTDlfJpM3+6OJSn+kz7x1orfVPYyrJFqgBEmYAMKKDKiBUpHiLsDypyAl9MOtH3vYmooWXEuk5ae8CYGa+KH4tH3PlAcQwfT7nxNJFx0RV9ocJ47tbMUl+rV/C+4qia5bRrwj1t2bwoopxcXZ1uy1Eph3Q/ucFekaz55PVBxXT+hDIVj/wG4AtQ7zOegmsKDKBHgPw3OC4VulOtFWhLurq6rEGMceefFv5jx/H7M+XseLO8TqsNBshMwdNch5hL0B09W2kCjCA43Xd215y+QhDTcME7+u95ICl9gL1ZTTgvg17P355dtCMraTiK87pDnJIjJfAVnOa/UxyEQILt8rbOjo/K4PzCpQM11loBPjaRULx83FHbqWG9G7qt54qCJWrYdMa5+u6DXMyAOshe0ddBQfKHmXQhCWKNQjGhq2/l0INJhmw5xQV9VxFSGe3Q7jTTPKM5K5PGCRq8G/nbRw7+qXw5RR2z2xP4d1iwxAP3V1mhWTSKE+6yr/Oz1aqSmsGoiEfy+VizVEpl6JWxK+EBrbowiTj1aIGzKnh8PtUiqEohoKZf0Prl0QQ7SP+icjDH7Eokp/k4rmFbTDdEW6s52yBi9dm7+PU2M09Hrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsLihnvbMgJrLdwMvD2Q8wpTgyRGRao1FnrZSnJw5YUKh4Hor5hpVBYyyyU7?=
 =?us-ascii?Q?tVMM0llGfVK1QOf0qVRJ7zkWqs3NgJfnHSXv9SD2uQ9oAONG9Ubmzv73l9uD?=
 =?us-ascii?Q?GIYstodHEPxhn5N9HDoKbcrPvLkwN9yUJlOgkzJgNKV4RRINgLSHO+y4d04o?=
 =?us-ascii?Q?mzcR2XMkBW2aiIsGQy6KCqCGgvHcVXc7gHKWYxoy1vprCXBUxhZGCL55e0T0?=
 =?us-ascii?Q?oUUB6EvfkPtBaiShUmdn0bCfR8HN6/rcDrnx3BqpVYIYgMdSlS7cThQ0xNen?=
 =?us-ascii?Q?s+YRVac3ByzYJ1JSsN1DepzCrN3HSbKtdUabIK21PDpwPpsaa0Iqa+6OmEoC?=
 =?us-ascii?Q?Kpzf5f1YSytomtKxQnnSRzu2bkUrTXk/z3BcGAzo8YSoSnEtep/V4vRQT3JD?=
 =?us-ascii?Q?oCgFWSsdb66TrQmseHCa4OwbwXOcHWFVMn6KndReLi8A72Xw6gE5fGY0EGct?=
 =?us-ascii?Q?KgZj9kgDl7fk2cMmsAkDQcza4Qjn1k1gsbV31YhHRg6Lv+5EYL/OsFEHjEvG?=
 =?us-ascii?Q?QUuleNw4Qy1ax32u07SO+GvQ0juAeE6o9l9w9H0Mi4FZF+1wZ3H45MZ57JdA?=
 =?us-ascii?Q?eARII6pogxFk3sNV/yIFd8MzKdJ7AIyaDQcZWIov9T2gqKxLSvg6MuhVbhC5?=
 =?us-ascii?Q?nfOeHwjLzHr4dDBeWkV0VAd6X28RREvDGFlg2c0uotkKipP3gllYDv2ajCZ8?=
 =?us-ascii?Q?gR8TYWwJnCHK/8vn6PNKDKv0QFL+0QuxKSWinfUmrB/cIkN+Un3EKoLz9Nwn?=
 =?us-ascii?Q?ine9fqq9lkmMCTG4AquZKTeHdzGtu4dT6lmag6Wbu3ACDF3aZ9tIXTsQTCzA?=
 =?us-ascii?Q?0UZhgCFlXnpMIriRUNhfFMnGt8JkYEzo4mjzXBf9BK60u0mugo3K7ebWVTio?=
 =?us-ascii?Q?bP1P4oBuyE53WNJz87P5dadkieLbFeA85wLLNkYxg43ok+5G+85MjDs4HGwA?=
 =?us-ascii?Q?vjeB7Z8y+bE3OQkJAbi6Fb9WKizJC3QDJL2H/d+8dslirFqcZhTjiwHd3mun?=
 =?us-ascii?Q?of1X/qKJUrpZXU15K8h+Yw1YREwE6LDSxeTD75IwFjybjxP3mi7Zo+zdKrAT?=
 =?us-ascii?Q?XAomYDtmwzDRIv6M4HleEiS1hcaQBr0zMQfG77ui2IEzdao90H7G1lybTyOt?=
 =?us-ascii?Q?ppm/7YPTvPOo2xKv2pezdbCX8HAW6Y+37g7U61YfM11v/DllIiDlj6incLl+?=
 =?us-ascii?Q?eHtc3KS8fCfPXB4P78YfZRuSAws2Jc7dx5QTXmxLASjKvRB8YDd9V6U5auTx?=
 =?us-ascii?Q?tI4S+xJfaGPd/M8I2i288IrhkJDNo8norh/twIsuHiT66QlsEB6P/UzVEv4z?=
 =?us-ascii?Q?Jfj7OEuk0mfiNMNB+OnUMhhWJSY09O8NYD0m3VJd7sDTR3TAA3zToaL5VWDy?=
 =?us-ascii?Q?vI+5JEWZnLOTXquSGFVX3QBjC7FB3cj3fRkCD+UlpiDw2dRsiVXvlQfTIvsf?=
 =?us-ascii?Q?HuHVYopqQ+qqpoiCZW2toPXizTZPgOkKbrRvYAri3DH1tbmU+DRr3kWmJdjH?=
 =?us-ascii?Q?pVeh1IvCegjI4owRue/MhGvdZcfXId8G3iCOt+RxGKuf1pX2dgllnawsNiZk?=
 =?us-ascii?Q?HgrGAeFbqiQHxg4qCIx4cbNb/vnfTw+dv6c0YBUOdzgYWO9FMzn8a0lMqtn1?=
 =?us-ascii?Q?kNyc7dN1Fvs0oF7fRtq8iynG5bJpPoBfmhsVosGkBvdSSaDuUN+XA8+bqL5C?=
 =?us-ascii?Q?6GKEb1Caa0yiBPDRmh2G9NKoi8rJQSBQYW3izSL+OpJlzUDFZ8JGdFIz7Qe3?=
 =?us-ascii?Q?w8IKs6+WpSBftacHi7V4l3tzYfEU35rXrRTwu7UoHDRk5c0cC9JY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f36be4-4a7a-4d35-2645-08def189b536
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:48.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHHnCT7XPPHPy/OUqIuwcwMu0flqb8bpeCznHbgfDPr8e1NYvGBJgOYSARVfUKyzDBPvUQp3TttlIk3BdZK1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

NTB MSI reserves the last MW for each peer and programs it
independently. A member of a larger translation group cannot be reserved
on its own.

Reject such layouts during initialization. This lets ntb_transport keep
the whole group for data and fall back to doorbells.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/msi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 6817d504c12a..029edcf40078 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -24,7 +24,8 @@ struct ntb_msi {
  * the peer memory windows.
  *
  * This function reserves the last N outbound memory windows (where N
- * is the number of peers).
+ * is the number of peers). The corresponding inbound memory windows must
+ * each form a singleton translation group.
  *
  * Return: Zero on success, otherwise a negative error number.
  */
@@ -33,6 +34,7 @@ int ntb_msi_init(struct ntb_dev *ntb,
 {
 	phys_addr_t mw_phys_addr;
 	resource_size_t mw_size;
+	int first, count;
 	int peer_widx;
 	int peers;
 	int ret;
@@ -42,6 +44,21 @@ int ntb_msi_init(struct ntb_dev *ntb,
 	if (peers <= 0)
 		return -EINVAL;
 
+	if (ntb->ops->mw_get_trans_group) {
+		for (i = 0; i < peers; i++) {
+			peer_widx = ntb_peer_highest_mw_idx(ntb, i);
+			if (peer_widx < 0)
+				return peer_widx;
+
+			ret = ntb_mw_get_trans_group(ntb, i, peer_widx, &first,
+						     &count);
+			if (ret)
+				return ret;
+			if (first != peer_widx || count != 1)
+				return -EOPNOTSUPP;
+		}
+	}
+
 	ntb->msi = devm_kzalloc(&ntb->dev, struct_size(ntb->msi, peer_mws, peers),
 				GFP_KERNEL);
 	if (!ntb->msi)
-- 
2.51.0

