Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A93905EA;
	Wed, 13 May 2026 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640577; cv=fail; b=i728hvnv0bZF+0ueYu7tqIydfXJmRLHaU9I/8ffNzaFBFwTLGkNnt7mZHl5n1ycOLiiQ11F9RmNAYDCVsskOBLTFxfFOFSU0nzm6QadM1HX4YDMB5w4OcYt4K5DCQeTTEly4RdUUoxMjiMZftuHCzRJeCBGsMgNzJS9R7jlkbU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640577; c=relaxed/simple;
	bh=dN82m0WVTmjj/fRhjLrb1lPwH4RclJ9L8xL1r4gU4yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKVg++y5+hXlLO2MUWDSYvgS/1S2zotplvxhmrGA4H8AE62+/tszN+TWyPEzsgvV/ToJpefvAJ2jjdAvGKFW18Zf9ZGDcscaishAetR7YmBL2rp9T2Drt9jk/zI0HQ/ExKmX24HOdPb4+olGA8UXFC7HJeIBESnfPMO/16WTFL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=m7bO1AXf; arc=fail smtp.client-ip=52.101.125.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="m7bO1AXf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0XZ4JtET7tVBy4GjD/0Ezc2VqXaiRTPgBsrjhTRiJY6QIUl6L8JpbhZbAzGErF/gecHXEfhkB7Y493bGG/+lOrcwaWVzIGvhNWx3JGST4l/hau1AqYLfocUXhW1/VFBBSsDow5ogsUgWsM96v+aP0cxEVkUF1zyZ6r6Fu6glQp8M+m4+6NfxTLxGasCBnLiv8ESOdYU0Spdu+Tl/aQWeHFqPH53yFTlfTJA9H1YywV1WixJkkwj2dAuQnOCMM0yJ/MkKwei2ZtcFHUfhK+truhvbmfP27voP4Z+N7YIGTmJNYXbE7FCIBY49k39F9Xoiwl0+hA0UYR8PTlGpjFGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++twxgvGr4g+9soBj77bwVxTKHSIFRKdoioska76avs=;
 b=PiXQxcQ++Z4WcbbXhcKLeHmqQYUiC+TFO7ycoDSbNEfbsOExNWyxTIhXmgBV9BxRoTp+f2+sDnluaAh5mW042QFQIS7rWNqjqO3TE64tN8/iUx5Nls9MxFowSpFdAuY5GpLxFnZMKut2PLSAt0pfi11LBVDcZ9vI0PjzGPNQk3NHY7yRKwgYTAEmI8Owc1djVPzF9EuNQ1q5xnm8zStR8nkAdW23xHecAgfDvSulmOH6yoxD/O7xGVDFX0Vi2ZvKSklvfZdPCofQ4jlWv/4ZFqF2nA4XlIA/Vb/NfpQbBAHJVesYlzVTTj7QfFmvu4LwPWMEazlzzjZdY4cQOIyfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++twxgvGr4g+9soBj77bwVxTKHSIFRKdoioska76avs=;
 b=m7bO1AXfrG/kXhPO6p8QjbiC7lKrTrvDCWjBj4nXcLnWfewmt4AMV5ZPaw186i4Vu22HW1uFO7Q9xMC18nO8Cg/wwuf3neBvcDE8xNG6eWDlZQiflMMzzKNjA2pxUT8R6F5w/Ek7FuvBkXYGHdDCkklkBC9Xdv9u04QCZ23sWfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4643.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:32 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 07/12] PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
Date: Wed, 13 May 2026 11:49:18 +0900
Message-ID: <20260513024923.451765-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 51af193e-3878-456d-1b27-08deb09a42df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	cYxJDWHqAm3cKf+C20Iu6Z/Fa1WMZGwgGIaBCUMvb09bgsj3fEcM3NwRQf+24g/Q7RcERNhTxdfUcP/Uo2i855q6Z8uwPN+H5uWC//+r2/l4CIQPXPKrxhH8mvZw4MSTJZr8uTJvCvaHbJ1NAN9b0deD+2xv+BK3TDxKzwUZMHzXIy53QbnHlb+CdFTtkH2ooFHOjO19TnVYzIcIgaJrih1hbJbPUW/Wn9lA2KxVQ80THTo9EvDA+uFAyvYg03QuB0PyQ2SMFqbgQyubBJQKwUQHZ94XU/cxce0piwU3SgzXU9h029ShJC1ZMjkjMoEJOTw8QzsL1VHA5+3CIDX2+ARsAsMZ+nN6XHNSUdSIAyGKENLKGpi78IPt5aaD9M9vsNsFnwaqRAeGbbZnByUdb6gsxy3jHe+qtM4OICd7cQEpLtlrnERDQ0gNchnRU30oK5FzgFLdlabaykZQsAu4wNqrOSTTnjyGiw9qz9ED6VcJVmzFcXvIRbKrqnbPlgKjFrc0HFuz3oupuLn841cjk7wZpeuDz2dEov9KNGzgd3ILx4nZB2lBJHByfWYkvC/UUUT/2f7JQO2O93IT7d9P1k/EwJtsaPZRQKHFWi+Z/UEY9n/o5buYgEtvn5lQelHv+Ohu8k3mlyrYmW6UfiRugS6L6XmLG5Lyall71E/gP2bJx7H2sv/GEzeW3BDWiIt49YVK2pjxO3NnOGb65jFW60lZuX7LDF99n/ufb8smttA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7phbq8OCYHpfqrQ8y5GNkdm5zNF/jOe0yMO4GbvzjGfMCuO7Ok9M2qPeJuWS?=
 =?us-ascii?Q?w3hHK4R2NnGVL/qZC3c7UolCEFkFE7IHo4VVCTWRNTosx/uycWksfhKl/dmu?=
 =?us-ascii?Q?o84p0gvCV1n/NQjwAnbrIIyKUjuJyF1KVnr/R/E8B2gRJQ58ygikvNtkfi+d?=
 =?us-ascii?Q?SjGiFC2COzp0dKLtuGQGsWR38ckt70PMRghdpkyr0m4TBkiSTMhqzCqlt2mD?=
 =?us-ascii?Q?5w/twwPfClilT6Ii0tfOpt9s3E/ScM+sPkYq/JFTuogPhj195Zz7t4lHs0Oe?=
 =?us-ascii?Q?FaPh1iMnEeIb3yai40aQz53G7+AJv4T0SXAlkOxjcfH+/ofaT64M2yIi4Txd?=
 =?us-ascii?Q?5fxEI8k2vBqAWdeW3n+DzxtCFfIYMruUWGpGYjVSGueNBRQQ8NriWx4ZaHAT?=
 =?us-ascii?Q?8rDSczunmHyWUSU2cEWZH+0o1RngL11emhWQsZKGQFBuYrAl/aZ/Ng7F7hCF?=
 =?us-ascii?Q?UP/F/GdzKMcR0AHP/H3PaPvldQDqoz1TgYejPu9umpc3Bxi+LoGbY9THVqrN?=
 =?us-ascii?Q?6IpbO5LalWrY8E4IaTPqQX+O+LVptWZmd0g64LXqIJv71yxfbfjo1jWocHP+?=
 =?us-ascii?Q?bbZim/HL/ATg7c70nP9iGwLQRRz0eK6mnkvvOIOVN7t0cpyWsiQWvyaVzNVo?=
 =?us-ascii?Q?2t/glEpsfL5B9lBZgQyojNamN5wviRqy0ku9/K1EsbrTKboa+W053n6Q9+BQ?=
 =?us-ascii?Q?QczHtMcRXnhf7eiUQ7wj/acSEyZmN9frAtKlWGEXPHThpEfXo/GxFG1mX+BF?=
 =?us-ascii?Q?8h32m+iaMnjdRMv1I73E2Q3Fe7RYaTw8SxJLykirgP1aNbFyFQ6tGRb9hyST?=
 =?us-ascii?Q?ebgXJYm7W8HxsHLGmuYz0N784kI09+6vaCuUaKvfmJIqQFraCIMBdgDJBIqY?=
 =?us-ascii?Q?Wk5BIO2u/yoMmP8pEjegeh70Wn7uKdFtPwICy6YBvpOgEw4W7STsK1uMhUsL?=
 =?us-ascii?Q?5+IHwTTzE+s3QTdeVokSBIQ9a5CNhaNXpQz39mnAUr0crQ8222TGGsBr3NQz?=
 =?us-ascii?Q?vaUFJNu8YElkQ8Hc/zs2MEpzHoNsVx14rpQ1NeClEgs/WfeD+EOn6x9tQQyv?=
 =?us-ascii?Q?sSp9YamZLkXw9JevRk1FX/zcuvVn8JNp/xuSJkJw5XDUAp41Q9GX/63WtzEq?=
 =?us-ascii?Q?5B6AR/5ZlMqgrpeqgYegDhWc+QQxzYYfmlWaySe82QdXQvXrwO2h5oTnNyDe?=
 =?us-ascii?Q?HJeLcEKHyhbfGiI45s00NX0ND4CQ5ItQ6NY6usVFgGozlN1CqrgeTRHE2ufS?=
 =?us-ascii?Q?sKbp7TUWfhA5kmi2k/zoTLllc4VaaPVf3PU3VcNNAZLqpqN9Vg6lwa/GATCd?=
 =?us-ascii?Q?YlV7XnLEt7OcpuS7oJYPN6rr1u8GJrramG20DNzH/xke5khxt1G1ln/RabGV?=
 =?us-ascii?Q?3PTkV1AknEl+L8o9QRDoZ/OFgPohlDR7KnQItjb2iQYY5BB0H31n0wgwyxRY?=
 =?us-ascii?Q?z/O9H0AMK7TDlc/SrdXZJc+cOD/Cl8skE9vm0ZKXv8AlQiezay1b9/5x0ilg?=
 =?us-ascii?Q?S6i0Wq/ClCYBmjfWElMO8OuWJOBGszrqUX3rob6rgGNtMJK0flpL6Tx2XJ7H?=
 =?us-ascii?Q?ofax0ML2pEGgt8YZnxRyxNGTXTTgc3Jks/gO3uzVV5gBygu0c6jOzYidexQn?=
 =?us-ascii?Q?0tIu1xZKKQBka6BMIAy8AT6VHjqlJBlweRBshkFsxbGC5O1iSd1u6YtEVFzO?=
 =?us-ascii?Q?DwpbaHrraDkF5Bu+BZKWmsYyhNFuLpl7rnORtfeWaDfLojGt8YlEh/3DOxXa?=
 =?us-ascii?Q?kuA6ukuPOb21Cwhd1g/9wqkdO53cN8msuqRnQXtqwYZcbJETpJ68?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 51af193e-3878-456d-1b27-08deb09a42df
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:32.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QavrpnCQqNcWtfW7AbZpi1IP3aLXnB+CEdyM4y/NfdC+1U5v8Di2Hh+rUh6EvDab9jmPd88GllCHZ3ZuP3DdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4643

Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
doorbell events to per-vector work and avoid the thundering-herd behavior.

pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
slot 1 which is historically unused. Therefore the number of doorbell
vectors is (db_count - 2).

Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
corresponding doorbell bit. Build db_valid_mask from a validated vector
count so out-of-range db_count values cannot create invalid shifts.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Tighten db_count-derived mask handling after Sashiko pointed out
    invalid-shift cases. The new configfs guards should prevent them, but
    keep the helpers robust on their own.
  - Drop Reviewed-by tag due to the added validation.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 42 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 58e41d95d029..c3caec927d74 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1362,12 +1362,48 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->num_mws;
 }
 
+static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+	u32 db_count = READ_ONCE(ndev->db_count);
+
+	/*
+	 * db_count is the total number of doorbell slots exposed to
+	 * the peer, including:
+	 *   - slot #0 reserved for link events
+	 *   - slot #1 historically unused (kept for protocol compatibility)
+	 *
+	 * Report only usable per-vector doorbell interrupts.
+	 */
+	if (db_count < MIN_DB_COUNT || db_count > MAX_DB_COUNT)
+		return 0;
+
+	return db_count - EPF_IRQ_DB_START;
+}
+
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	if (ntb_ndev(ntb)->db_count < EPF_IRQ_DB_START)
+	int nr_vec = vntb_epf_db_vector_count(ntb);
+
+	if (!nr_vec)
+		return 0;
+
+	return GENMASK_ULL(nr_vec - 1, 0);
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
@@ -1617,6 +1653,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
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

