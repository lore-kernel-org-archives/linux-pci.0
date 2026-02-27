Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16173A0E85;
	Fri, 27 Feb 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182226; cv=fail; b=mp5Q2C3j3HnTypoHbQQ/2mSLSj7rUz/D48xPSCLsZUpR7RNz/zgAufRLTDVW5IoMJ1hxCqxarBxeWLeSaxY0aPsi7QU739F+o5UG/yVJWfTRcpoTLEQVUGYIzyWOnNnYUHZW4TePruSUrWa4AA3kNSidPvkrWSYt9fUSrs1TDog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182226; c=relaxed/simple;
	bh=mhN3KAHKDTwNT2uQAlKHY5f+i19UclzZGs/AaZFQ6Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DZrGmFOTp1JKqWxULCV9VaOmKnvg5QpqUs6NRdsHNAGtE0fRAZZ1wghvlfW4UHmuM9hhoUUOC98ooecH+mu1u32tG4rB0C4JWtJbOXF3II8vliKrV/Ov7z0SuAvI/V+9PnCkVS3Gh05/eu0r3j46ZuomPeLpaPv/sARAv2Icrc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BN8/DF8a; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BN8/DF8a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUk5wOFZ8dNZpjLhLPAxEPeKcRGPDpJdzb2Sc2OpxVcW3OgaVoIX2Ws3F4QAM5kHMb1fep7Cr++7t2EjhaYIgCfBh1/L7oMNr5SOxDUMIH32OIdrrY4WYT4/DPPymrkqOQ6/SdDdE+Epf36BrcjR4LKtNN3rkxrq3hOS0YyzLrnGSRb7XuGsFTElXf3CvRA2OlkikPUSy762PEUV/hHLbJuc7n1BGeiXSBDy1SuCLt9ds22/FY3Ig+xCU9nF1otZYpsIHSDAkxvMb8RJ7u028NnW+ngf0XHWeDq73QZoVjOj76HgySMJpDysU5t1s0zRmPapZ0TA1BQjbTi61gI7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8PTt1p0I9itT/2x/vobaF3TcBa73gnbAZj3P4uiu88=;
 b=TL0ODqJYwYWULXQhvda3i3jPDoZfWSrhJOwmGrR7ptH2tCpyDx2uHbItJFh3CC+gBoPdgOOIYgE7eGKRP6p96ilMSq40/W9byyFr38UraFuWkedbitCr0gt9f5Qze+OnV0TY76UOUbC5scKjYjvVOxNO2O0vtClQA41lpAEoNPNSdwCuPDUz1S7krmFeq96Kz15dKShdUZ0ZCrqD1+9R96Z8mxLtsM1gpNPepfnV8ur/9R9znHq2t8WxqG8Uj8PoBmFfwXB2gtyV6fmEW69au9Pbh1qs8bg9l34DPa7UPaPk46m3pq64v1aY/Zmb2y2i2+lcJi5S150HgJq9CqyYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8PTt1p0I9itT/2x/vobaF3TcBa73gnbAZj3P4uiu88=;
 b=BN8/DF8agT9oKqQevW2hmC8lmmoBxvo7Dvvt9XwVJskyLaG/Wqv9U4js4BOjvPBqFf4YrtShuK2ODbjwek8Xn+dp4ZaHJyNJ6LAk10xqdbgVjZCCm+HDRQczvLSQKuummCZOpDIy6WyLvk6W5BiEqZ+89JAL7AeyCdAx6TO7pqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 08:50:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
Date: Fri, 27 Feb 2026 17:49:50 +0900
Message-ID: <20260227084955.3184017-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 68dae635-62d3-4e0b-3e37-08de75dd321b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	bMsuGhx+VaMRKke4TkV3matJGnA/l4wBvKCSa+F4hmfBexGgJXRrxD3aFX+rV6YUJEX7u+xPJZxv09K0QLm754E7zktwO6ax/O8hz0rFtBkXgH7GErennLDZkq0IQ8qoE+8STPkuqlO2Z1Hi0oyAPlBf94GFX0cOssIJ6s8pyf0TrV56HcWsEk3uS3E3IzwSSJI/S84relMZHwnhAykuPddCm4xL67ObtmXGo9Oet9Vhh1gogz7jQ1ZlXOq14TZ8CYelDvF1vYxgXg/7lI6xirpTb6FSzYvfJ+yNdvQNJGtUEKaDUwW4Sw9cxc6ackjek9sfXTiFD41ivRP7AE7CjxezVWS+T+brdBg8Cz7QzOALoZKJOOJhU9sAYB/XUHxsUWIFxOjQ5OoT39RRDsPIFAbD9iGwNAof3S0+1sN2K0QFiBVO4rv3vxEkRacf3usRINMghLHEi1ffNr57RcfE3wdYvndz4QHJrrnaBXTDkBnapMxM3Zvx8DaVMrR7E9qzdlxWBfmSvYhMz4RySmgQtJPFxNWcUsQnSdOdRaSXd9a5Qlu3mVptiiO1CW7+oJXmXgCH4toPWEZwFKxzeJJGR9O04WAVZx163rAEpN97AUjSiv+zeYuyFGycYgMqso8Dyw8o/TuZO1eVAg8+DV/DsooLeV+0+UHSusaQy8DpLdMNsVepOWErKv+SVjp1fVRweXUov9aEmqbMYWpgx/1IOxIIyCgkSBV0w6pkM79eFXHmZa0CqgBkxgIRVAf3weHPVAxLEbVDRZ2FHlpBBzMPqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8TrFLoLCl8NLHZOz/bRkLuRrYEcgrxUVC7Bi/OtZxyTHtbJqCiXcKt3UhSj?=
 =?us-ascii?Q?VYi1Vn4sr/ZyF87U6FzLdhZCPVDel6EbWLIMA6cV5Ke2DcoIFvbR44JAewj9?=
 =?us-ascii?Q?p4P4/bpDtCJ4nOwyPla/QEAtObJTZY2+ZwkuA9KkO6WTeDgXdOOjQT2KnVoU?=
 =?us-ascii?Q?PMFSc7Il181XYYuYP91pIIOgJcDoVfdecw4xhrq3NmDziDY0qN6UllTG+VM5?=
 =?us-ascii?Q?lnzyOP2xevT4XKpH+tp8BfP9x1A3smxus1BrqNDqSIatd5IkoTrFxsukQqrw?=
 =?us-ascii?Q?dRtjaOET7wcf1vA91Pit9oUoHYp43KdY5it/n2haF/90QSbRMc5B3I9xJmtI?=
 =?us-ascii?Q?D5DXYvKNCQTQCrYM27RSGOeo8ygTULVaqgIv4VaIcNjzvAnQl6c8eqQAYFeC?=
 =?us-ascii?Q?WCNGXLovJwAn5odUlJCffyRZyJVVotiqzSPVbeieN1gjl+fT7WzlvCxt4GSn?=
 =?us-ascii?Q?Ft9E3xwdHwEc/otQOdE9lg69dJH66NIRVVNrM90lw7SqfX+U9DnkmPp9JFB3?=
 =?us-ascii?Q?QXwZA/ajqSLKoZRCZ831uqIqWK7lf1nQwGlzvBVq3k+qRYPlhWP8NqM4sshM?=
 =?us-ascii?Q?ue6Z1aVsYSo6dEGnQRdhQCTrUubi/Rp/+IMGOFx9SVDE9xiNGJLkPsuvsKqr?=
 =?us-ascii?Q?YO1rJ9x+YavkhX9MY86b8MK15eXMlwcqOrdl1B2XgrvED0jHwuPk1YJfguFu?=
 =?us-ascii?Q?r1b26WeaAFjWdmo+VGFz0+SXaW91GcUmgEg8inPjvUCIFwEPcqIqq93zEvh2?=
 =?us-ascii?Q?zXZKupfNG3cdtcHjP8cyJP5uzCCZAQz7RTvYxzQ/EGlIn8nhhBTlEgrwWz1t?=
 =?us-ascii?Q?xwa829D62UO/OFz+6ak1+FqPzTYHc/9O0mghPWDBQIPV2UM59D+TEGNnCHGt?=
 =?us-ascii?Q?Xzk7TU2hA0iatR5Pr8OjyQ6l5KMwM7eRmkRUFjOOZz3nquu0OwOm/Ev/pT4M?=
 =?us-ascii?Q?CnLSbKg75KXWB6RvR8TerjeWUI5ZqAQ5a1DfhrILc0b8h+2vYKynopQb3rR3?=
 =?us-ascii?Q?qIhehY2/gf81BL6/4NUMcIZ+p0b2aZc78uTTo7ITqVlxCyAf9/py/GkjYbeE?=
 =?us-ascii?Q?1Nw9nzBEzfZeXAI/sw0nEjcsBEa+hDPaPhBkSNkH1+2dbmr4mDMd5NAheusl?=
 =?us-ascii?Q?ifaIhDs+P6xG8taq5Ale50Cyd9QPPssE1l6eBSMrSCMtgoQvGG+TFoLfr0Gb?=
 =?us-ascii?Q?93lClCNgFdJ8qlAv9Xs5OguoU6Rg5INPNSERC/5/g2FA3Ov5J+XPoYiPw7u+?=
 =?us-ascii?Q?kTMjBKUf8USzMptk+iAZdiSI6LAUfEr8r2Ovt+9udFThDSwfoTZVKY56LSnt?=
 =?us-ascii?Q?bxKhqiO9pJlZAkia05V62/qxBlEoX8sJUhsUyhCqzlQ/Jeuyj0wt54VTioyI?=
 =?us-ascii?Q?XIpGL5tV62kgk0GUSfCZk1h8uFBdc14q5KAu2t1cunw01p12TA4IdxGf2y+R?=
 =?us-ascii?Q?fd9whUfviZEy/cq7bKBU7eE3o+O+HTbWtaTob65VQIFH4Q9/eD9Ibv/wM3Mn?=
 =?us-ascii?Q?8yY7FvaDi0bbWsmBn5c6/K5/UESitBTcTm2nhZTCTb+41PK2YrQn4VCvSuPE?=
 =?us-ascii?Q?BZtKM1+DRqkISsjnqfDHAIPqq8+9nBUjwkoo3A5xy+mkcjJdMprjKeQim8Pp?=
 =?us-ascii?Q?p9v1i4uglzXCKq6w5Ms53cmVEkrhds2iFxkGJDCZmGhryHmlXQ7rinncEZSr?=
 =?us-ascii?Q?baESXg9LlnqMiymzCSO3/W67898B8iS42iCk0Pk6cOWQuNCMuSiYf61npmvD?=
 =?us-ascii?Q?THSXNTqshWOuN5Eq4yfuCM5rDigg/+81a/B9vOJEHi6XmHwf5pRO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dae635-62d3-4e0b-3e37-08de75dd321b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:02.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKKEk29SFGcIrepf4uor65VUJWUien65wCDjy5kbCtGjg/8waJ9oPsBzz/ww7sUNWBpoVSFsrCm8QiPJHjTISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4075

Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
doorbell events to per-vector work and avoid the thundering-herd behavior.

pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
slot 1 which is historically unused. Therefore the number of doorbell
vectors is (db_count - 2).

Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
corresponding doorbell bit. While at it, use vntb_epf_db_vector_mask()
to simplify vntb_epf_db_valid_mask().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - No functional changes.
  - Use EPF_IRQ_DB_START instead of magic number 2, to be consistent
    with the change on Patch 8.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index b94e2e1d3421..832600b6eae1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1278,12 +1278,42 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->num_mws;
 }
 
+static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count is the total number of doorbell slots exposed to
+	 * the peer, including:
+	 *   - slot #0 reserved for link events
+	 *   - slot #1 historically unused (kept for protocol compatibility)
+	 *
+	 * Report only usable per-vector doorbell interrupts.
+	 */
+	if (ndev->db_count < EPF_IRQ_DB_START)
+		return 0;
+
+	return ndev->db_count - EPF_IRQ_DB_START;
+}
+
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
+	return BIT_ULL(vntb_epf_db_vector_count(ntb)) - 1;
+}
+
+static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	int nr_vec;
+
+	/*
+	 * Doorbell vectors are numbered [0 .. nr_vec - 1], where nr_vec
+	 * excludes the two reserved slots described above.
+	 */
+	nr_vec = vntb_epf_db_vector_count(ntb);
+	if (db_vector < 0 || db_vector >= nr_vec)
 		return 0;
 
-	return BIT_ULL(ntb_ndev(ntb)->db_count - EPF_IRQ_DB_START) - 1;
+	return BIT_ULL(db_vector);
 }
 
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -1520,6 +1550,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.spad_count		= vntb_epf_spad_count,
 	.peer_mw_count		= vntb_epf_peer_mw_count,
 	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_vector_count	= vntb_epf_db_vector_count,
+	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
-- 
2.51.0

