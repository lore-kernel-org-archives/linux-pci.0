Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED439E6D4;
	Tue, 24 Feb 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940112; cv=fail; b=eNNdk8luzTmd6aA2aKlXGWltXImmx70GaJEwO2JBkjCF0nkcUW0T//HhCQpwvEIdw0Dpd25CpjkSMJAKz8Yr48OmUjRhO1W638KLb757TQisBtCCdGsCOsoWs5z1jh22t4N2yAM6pTpGYdm/u/YD3DHJ4SdEveS51LSoCESBwu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940112; c=relaxed/simple;
	bh=p0Zi27fbu0sQGf92zYPtJv5XZgIlX4L/SQ9IRbb+Wj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JG9PMUbfSVMIPZps1zd/NRHiY33YfYFgoKRXiJrmmGqJezaTw1CAgVZ8ZHeApkyDqohJ1HoXe+MVeZSrt8NNMuA7ZNmPpI6gR+SdSkR/cNirnpxiQFGvqGR1zZpv75pLsBpgEBxBz7oPJ3Lyvf/lmlKSLzgPsUZFggCWRxO20ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JqG9uzlQ; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JqG9uzlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxXFJUb2D7sPvZAAsLFsc7N6DHlwfcspuBCfTAZGGO69oslg8x9Nmpb3l1i+Vciwho7jN99WaiyvakLRdJDt1gmXzfFMaJik278SQ6RSCbGTozntWhuIQDJCTcikektGdjpxYV6oKp0J+4HgiKwQF9IoTl2kRCrXByo/BZdXHxx5GUum+Nw0AkJ1YFMSRuB7gZgI26nRGz84EUvUr0LlFXJpvDySBaCsO6qCbuC3ttJ2MOQHoxDOBZL3QGgx+yj/zi+L7cDCZzJXb3FPH423rI35qFUQkZ/XZfnOSpVQ1pRmYVDXSLM2TATuF1Gl7Nm/lOTgo3h1UeISJ0eHqnR7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcV+YAlrjKI84nCvpSeD6t2VbC7W8TzOtZDRWc4voUg=;
 b=jzxMw+SPRN3AbCTI3slbabtgIf2Jwpk+MAf8RaXRqNtTgyWzWvDgKOLkmrI2n0LXE5rj/tSR3a3vDak9B9LtjtBw6FPLWSvzxFAMa9MnSVA9dAO9bsMpDtG5OGaiP+x3zBJ8K0kzU55igLbAspfaUv+zfmy4JzwtjTpn/jIuPS35uWoH9jB1aUakRQUIgY9lZFq5Ffi1HUlWQ7drW2oe5ymt1ef7LvcYdhPwIDDl9KU8CiCbtV5TipUQJEkr0sBxV2auAU0N0oh5L7t+a5NeyIP3Up/daCNB+RC43Gy4jmXIodiH/Qc/dOOKgJPVSQGRJOKmBYIw1JEvP3CQhXRMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcV+YAlrjKI84nCvpSeD6t2VbC7W8TzOtZDRWc4voUg=;
 b=JqG9uzlQ0Wwub1DtjqckNO1JH0UI/c1zjWuvB+KAIJQE9ujvNZbsn5zdfN8G2t1gH42QMIYzimJFYfK77636Y9std2wMtkTtL3V7NlNVt3KKG4WCKGaBLNhszunYfg6eb5sMPLksN/f7oDOhVNsfIMVfTu7rgc0jnSiHfOs53oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
Date: Tue, 24 Feb 2026 22:34:55 +0900
Message-ID: <20260224133459.1741537-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f48d36-e4ee-44c8-0ad5-08de73a986be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2mX9c5K09J/YTtduievTy40UK3iHyMCHx7GbUumqDlA9KIDv2m0b5Ts7cda?=
 =?us-ascii?Q?Ik3BkZtwy9+ovPNfYOFdSfkd8HR8epL1n9NDuVBUDXaHkEN8+PLvLJBAafpY?=
 =?us-ascii?Q?tntRa2DksAMr3qNDLLXli+dxsHh/yW9j4iHW1eJd73jbO8scYi+VC1bxqrNM?=
 =?us-ascii?Q?RGm3Ds7xEXDTItdp0uNmRIrxrDR52fFg6sWXlpQ1E1jdCSeO2aaGh2qtbbCh?=
 =?us-ascii?Q?BBurva01Lp1Ck//Wk4k3KoVLu/7foJgZz4CTVCPz81qpHaXuvsTCMPcuLd3n?=
 =?us-ascii?Q?iZ38eOmlg9SOH2gkV2NjtbuwlXr8eCl20Mnaj2wYTPszKbCp8gMPkmyFhwVR?=
 =?us-ascii?Q?9GFV8S6CBIIFs+AMzQ+WyXInK+Qh+6UMakEhxhHgAYmI5THynGR/sBecVhiI?=
 =?us-ascii?Q?lESuI408w4EUbedNcVIJFfbSUDk6gCUMYWzMyqg6rztbaeKVMw+yR33ve40b?=
 =?us-ascii?Q?LToALbUk3Yu2PMPkXM276+YRF2dad7Qt25/5NJYi5NiNkVAuyBF1kUPeBKnI?=
 =?us-ascii?Q?JrGEcHC5pN0555eL5cO/D7hcRHTjl1EfGtla9+2zQq30E5MjBrTokWC6fO00?=
 =?us-ascii?Q?2yeHv0cK2dJGR7LWx2s3j+OjUwoxnP6jbzJtS7iNGzqcDCz/w7vDhsVJW1uV?=
 =?us-ascii?Q?0HDubJuYTAxVVNKQWwugPwwxR7WXNVAz83wAUlI60nbEfuZfrbSuaIOGddKY?=
 =?us-ascii?Q?COWAfFPbKQy5dTku+6C6kl4Tt2DSob9r13kQ8WQXxyn5s0/9561y+jDsnkXQ?=
 =?us-ascii?Q?HRtWCHJDNio3xpqS7NItUVOxWQEe3BVdqYRSIelggftCWZX3WzY5Y7OVhO1Z?=
 =?us-ascii?Q?QqTFPOpbcak0JjU+PehhGz2E8OlIh4myzHurSmoh6v30N1amEgC1cz+qfmLN?=
 =?us-ascii?Q?Q5r3j1PG7Yucs2Hrckm4lnH7Kub4Pqqrze+wZ1sZZAlU9I5QhikztuSSuqe/?=
 =?us-ascii?Q?iZn4XB1W1IHeYqYzdoTdyfdutHxClqQYPUKZgfwxONUFPbCG30rjO/ud+v5D?=
 =?us-ascii?Q?nq0jGl4eGkQyREQTzTG7T8pymYg1EkgwsD2Lx5MxQjnlnQZT5Nay5i+xDHgR?=
 =?us-ascii?Q?cT/rDIEDJRqSFYsi96jLIwvmR3piIPOIgzADLwIEErEpgz64t6wQws7l67jg?=
 =?us-ascii?Q?5seYp8h3KnIpj3yVfxyMnmU+ySfERctheQz8zjNYZvn7CzidlE/RrG2oGmTr?=
 =?us-ascii?Q?hwwVKfYD1ZjvTG6xu9bfYFD2QFiMly9E0izvTFg1f9Phq8F4ugT2/1MTCkW7?=
 =?us-ascii?Q?Oz7qk8+d+YS3DKIJK4G0eZm0wv65kUiPQltTvjOtfuW2ff5QkvTQVFJvrB2a?=
 =?us-ascii?Q?8KAWm7RCol/EVGRbZoL22cynS07a2SrlVApvkkr7WZO9qV8yGgrKCykGaqVS?=
 =?us-ascii?Q?WY8si34FEIlsVOaEUd64m9hJnNeao1qnnSduIsNZQZOD3n7OhCTHGm4EDi/8?=
 =?us-ascii?Q?Y2kUaKjHnvdy8a/pi86CfB+crKW21PA4BL6fSZJ8uok4QPCNaiqnfn9zNXD3?=
 =?us-ascii?Q?iFeY7bEiQt4Kx9MdeYnQRI/h74PCN+uprwhdDcuMMTqfirUARfeQZsQo4jy6?=
 =?us-ascii?Q?VNBBTlh/PlgJWbliWPyywM8hasNlY+EBX+CqpoQIpKhjgBvG9xXWEF1DQRvX?=
 =?us-ascii?Q?lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQIcmvTihTJGKazoYUOkEt4hNPcE5m5iGd1YUjrDr0ZhRH8F4gFhXKoOlHnF?=
 =?us-ascii?Q?pOkc8MtCYwCNAQC5x1UR+m8aCFE3RAWiarU1gV/aSYe+EUWr8KbGXzVGLeuK?=
 =?us-ascii?Q?EqqfaZ4hWYyKAoBO2HS37Rj8UouTDkeSAQxixr61XPvXqjaJ1xC5l5iofuB+?=
 =?us-ascii?Q?fvU/OXpoxCscofx0eYizzK1xxjoU86axwt2EA274x/ZXLsKHN1tEppYdSYS4?=
 =?us-ascii?Q?3yPoC9qHI5mc0ValP6/V9MGVtoBnsp6PRa6XSz0HHRzIH9k/AtwKATJFlWdC?=
 =?us-ascii?Q?AqiBP3Lol/6UdP3vyaT7ehVWUYLRnQEVstfS9WPLP+kc15KRKl/zw/GEvZNI?=
 =?us-ascii?Q?jJM3jEX5iKqKMM8FO+a3ljYsyndTdkEx4ubJ/KGC38SqAJby95SsWupdzuaT?=
 =?us-ascii?Q?RXtjqB+Zfwq3duipjWVY/z3m1TjCjUSMzQ0adUYPoXsAYR7C+fKCTWZ9JlZf?=
 =?us-ascii?Q?ccK+8WGdxZzbl7jJ5OYHRcvaysT8Bfov8JNDI5sBMuhkkz2bxrhJ2lVrhXzP?=
 =?us-ascii?Q?FsaazncE2A6TqEJLALSQ+Tlvcond+Fe4srzMiChYAuRLgF1z+61PaUd8eCIl?=
 =?us-ascii?Q?ZcVLMkU4nIQsa10isor9RzaMRu7iEbea0X+hNm7T682Z/IsbxKS7FDNMAQIW?=
 =?us-ascii?Q?k+mTak3Qaq2EQKwmcB3+UcTNFhC9QiyiWUxWUbpzi5iGFUFa8/5xuXMJLMei?=
 =?us-ascii?Q?43f7B+EaZahAaCAnfLLYxAPfgSuPbgGO295/s+brwxxhWyPrSs8EwEejojhu?=
 =?us-ascii?Q?IisD4SWyXTVeizC0rtf4FGMMBnAOB6M0Vdov/d+fyKv9lvdLNU/SJCQ3Nqfg?=
 =?us-ascii?Q?L9KGuVJ5yvCCJSLAurcMeVEDvW3D4QlyFqJ9BRcGD5O7obpxJkE+zXZgVu8O?=
 =?us-ascii?Q?paV80ybb3VH1T1Ql17FWcy0/Ns/RRSHxT4PtZHEjsJawiqruTlVJyjVEAQXb?=
 =?us-ascii?Q?pGUPndkb2zD9YQXBFLkJ29wsOv1JS3Vp71Z2/Qh23FVE2+KTsblnwwPJNXTm?=
 =?us-ascii?Q?1XYkbxwrdDLztHqGUZPCUfAoA1k4LtpvZPsKnL2qBjqXvPWFuItq2pCfjExG?=
 =?us-ascii?Q?BbwgZPb6FESiEJWdDoQqEhR4r2zHknj3Yidb2qE6A3nrVdljDnXKIlQPUGwd?=
 =?us-ascii?Q?63Dm/5TnfMJNLqWgwRrBzQiWekTL5VsrpUi5lkgQ9Df6EiYTGFa6g7M+q+Vi?=
 =?us-ascii?Q?1+gENQobcM1lRwEIGYddDXMk3S5bk70GDewdDp5WByLJmuN0yun8COt1qdA5?=
 =?us-ascii?Q?rS+xR8ESH4c2vK2fGS/CE9ck3OgvVU2pbB6BiNmi7OWIht3cEj1VF17XGW6W?=
 =?us-ascii?Q?4v3VnQ4YVyPFMGsYi1SsykAyumaypTciCYc7LkxG+07SuAt1SarbNCY4XypU?=
 =?us-ascii?Q?F+FszsPshhetR3NY8Ddl33Rgc240lsYWynFNBML7IeSuKyPuvcUI4++Cyl+d?=
 =?us-ascii?Q?6SHRqRwJe816n3ZaTa70dYxJOPVSIZdCu0kZoOz/4HCACdpHZ4j6YAprzJxz?=
 =?us-ascii?Q?NEGABiKeEzkXkrBIv5vr0MhWaoHwCBJAokubm2fwWNb+XsAoQTCZghV57XCe?=
 =?us-ascii?Q?EHlt3Z+O8ZYXMrmJ0QCiV4e+D5NJLFPSTqCCOFll+dasAaGURV0S/NBnq40K?=
 =?us-ascii?Q?x0+s6y+dMmuoC94SNM+/tHmnAp/L3xriJWgxK2QaPzH2cQuCthR1l019j2Sl?=
 =?us-ascii?Q?cjxmcdQAUdHyF5VZyus2gTPo2q+5L+5ETuYIQyqvNwwNKWrpPpRt8WvzQJzU?=
 =?us-ascii?Q?uyR6c3X3IcK6cAEiTT60145CL3RqGhRvDxbe3lG1jYAUd1ADmODw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f48d36-e4ee-44c8-0ad5-08de73a986be
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:08.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmmidpbJ88Wtp5+RYuFH/Pqz0UKy+p/FN5/7YFr6XutVysVA2B1XhTDjPOopQrj2/4t7ZmC8+zMuwODOpTRDew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

ntb_epf_peer_db_set() uses ffs(db_bits) to select a doorbell to ring.
ffs() returns a 1-based bit index (bit 0 -> 1).

Entry 0 is reserved for link events, so doorbell bit 0 must map to entry
1. However, since the initial commit 812ce2f8d14e ("NTB: Add support for
EPF PCI Non-Transparent Bridge"), the implementation has been adding an
extra +1, ending up using entry 2 for bit 0. Fixing the extra increment
would break interoperability with peers running older kernels.

Keep the legacy behavior and document the offset and the resulting slot
layout to avoid confusion when enabling per-db-vector handling.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..bce7130fec39 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -43,6 +43,18 @@
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
 
+/*
+ * Legacy doorbell slot layout when paired with pci-epf-*ntb:
+ *
+ *   slot 0 : reserved for link events
+ *   slot 1 : unused (historical extra offset)
+ *   slot 2 : DB#0
+ *   slot 3 : DB#1
+ *   ...
+ *
+ * Thus, NTB_EPF_MIN_DB_COUNT=3 means that we at least create vectors for
+ * doorbells DB#0 and DB#1.
+ */
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
 
@@ -473,6 +485,14 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	/*
+	 * ffs() returns a 1-based bit index (bit 0 -> 1).
+	 *
+	 * With slot 0 reserved for link events, DB#0 would naturally map to
+	 * slot 1. Historically an extra +1 offset was added, so DB#0 maps to
+	 * slot 2 and slot 1 remains unused. Keep this mapping for
+	 * backward-compatibility.
+	 */
 	u32 interrupt_num = ffs(db_bits) + 1;
 	struct device *dev = ndev->dev;
 	u32 db_entry_size;
-- 
2.51.0

