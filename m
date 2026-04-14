Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F73E92A9;
	Tue, 14 Apr 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176199; cv=fail; b=fWpNFe30HpdcqzsUjojjsv1gujhWCMHNKjj1GC/gRezd8S+ONmwJ4amFi+eYnstVeD0r6e+mSBVi5HeWYpLGpdRUJj60UMeBbVJPDM8uPmDUtlR0EnNqMDeZ+54nEy+kgglDhgp9hIKLAE93q1pzWXJ+jG9UovADp9RZHVxGGhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176199; c=relaxed/simple;
	bh=VifbmuDhePhh4pA5/eVfh05M1bkFT1lnXVlxS+ld4tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzUKPoLjFitimd8iSVlmcAciFcnLK+88h2OinBSboyQGGaJeor3YYm3Jmp2Yllly7o7AvfpymNapTM2WtjEsCk7UsuwOGBRJNxFaFuAoHAeMW7reZk9ucxhcf4cuha0DW4rd0oGtC7aTyyifj+eTg/YJwFtbIpcVZ8b1WQ120G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZMmSVWNw; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZMmSVWNw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN351bDlK3+Fg+6F3bXn2pJThgDUb3uuWvFYUAorB9q9UGtEfoDoXeVnXvfo0KvZ/4oOSAZACc1+wz7lf3qwDlUV03GEAiV/6OsyId75RwoajW030xVUcVURhTLTEyfunWoIRos5FrMXNZ8CvLHAjOXGtXU7rvTROMaGvVwc8Dy7h0tQXOcDh79YtmsZbirPlPbBk4eGHXHits2hAUNb99l66e1cBroeK9Lb4HK7bsCDe6QK622jl21NMUfBwvEplaUJediiLGUP437ip4skLW96wuPWNRL4Y4FBusq8aWqnAe63or8PyaRIZ1105Cuahsag0ZGr4gOSx6bjA5atcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCJ5Z2AdrnpQvLaiZlI8Zol1cdABaHymgvMXXd2v4fQ=;
 b=fMAJ7bWzpD03SNO9V/NPNMslQvxAhZlHeDx7uDRP/+Dq6jjW+rzqwKEqxiOU52x9pjqHAAxq6woQPYeJwm6D0j2HUdugs2X75jzb8a82/fCC1+XqZarB/BDkv1nM97QJDR+m/laigAe0dWxuzV/0a+WU7T2DrySOOCy/HEQ2aOffahSWGKWg51yC+f6J0xLrmeTyN/bmqTHqIRu6H1lbi5RqaiLqlBGk7HfpQo0a0/HTqsvuHoa+7iDeojB5kjgO3nq7DS5uXWNdQdAVz3ZOahTmP9h9+gth1ZeFQNHIh1erhQAOtkraf3C4psukVgmzmFikVK3zyPz9UbwyyyDkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCJ5Z2AdrnpQvLaiZlI8Zol1cdABaHymgvMXXd2v4fQ=;
 b=ZMmSVWNwsKU3zg/ilsbLTtqdGcjRG7P4HvCk9lzRnI90IF8w0xep1Lckhblqv8nAHE8mKAyQZ4pH3V7sylTxJtouw7Z9E/J/mq82+M2UOYhBgSbPrpe+zBp5icGZv5sYVpshBa6TnBQ+YSWUBIbOfmgdpblGra/ILA3DDJPmpXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v14 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Tue, 14 Apr 2026 23:15:13 +0900
Message-ID: <20260414141514.1341429-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: c97429c6-ce84-41b6-eb34-08de9a306ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AEn2yFO5zLQoZw/m7YVBBGOjzILxw8dnFE4ByEsFBMKS9ZrMfuKwfKZghFX58b06HAw1H90JGhVpTGcm4gP+UhxBp9GPYw9rIQBz4daG7xEeIYZyHxChDvZq3lwHayRdufET3bbqH25kDWVyv3QEzhF4WxrFkANvyWVMDjcZApk8ZkkqbORwVGtOFOnzpP1nIVvvbJi99uQflCclOlIzc+5KgYOJmEZu7CQUeRqZ4S3CgyD6FGrzbIDNUTDDrq+czT0lUcK1Xw1P0X/4mtXLve5Yo9jHWa7e622xt8n3O0JD8MEmCe9T2oc0WLSjgkh9Z76CK0sh06zintZMoeG9/WNgRWwYnBrGsExEyXrBV3DSvNAViUueYl5e/ZbS6Njc3LUIu3mZ2BZ7Dmvtfu2+tDBXbBz74yJebZQeIkTDJlS3ttN8/OMjyaXBihrOug3vMEmVKENMtLGBLb5ch3DLB2VaCOL1p6sxGkI+5DPAb2+BvEIUo4PhOqZKSwgMAbNwbyumFHwGQkIUnnhaPi8F2uf1vYJFVtMjLWif0EWCJZXsq7H2mrV75orVPbcahZf+oELU/h8dC2h4XGSsIxI5ieK002v6MtVudNK3p/hTI1m5v3qGlew7kgbiPPFU/sJMjMt9qnxSb13treKIejYxSE4YvcpUhb1TLaSNMnUxp8b+jgIHOeKqhG475s8hRj40BmSGacbd34PV0axingoqsueYEZdm+nHzXVKF1BZejJluLUyf59bGfCJNtu4ev6I/VMHkiwwFJaH3GrNfnQnMIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MbCkJnq1WpbO+a0aUu5T64QniwiJYTz+7h6qlwbvUo67EIe9qB2Lc4MUXViR?=
 =?us-ascii?Q?uL507zOq0ew3bYd9Z+kAmIQub4hGaHrMTicUD9egdy1D7cQlDzRSbd+LP5K/?=
 =?us-ascii?Q?ItPLr4txE7xuAi7QmCrqsIpxWYSm8LZOZva3QltXcsD46qiB8dUuA9pfnhdQ?=
 =?us-ascii?Q?FmHTuoYq65shGr6Otm/EYrIq3kG3HnUH8H0rneqxw7rfy4xF/kW7Nwa9pw8K?=
 =?us-ascii?Q?vcAeXmldS7k/FGkUpve4k1V2Ya16uoA2sTJELHzgjZtPgZIT2VE+CUmwyYhf?=
 =?us-ascii?Q?88lVRqzKWd5Dt1rBddNHCdn9sqn7Rm79B+smNWefF/g1+jYxWdapM9UuL3Nx?=
 =?us-ascii?Q?lPUH6LWoq9x1RnWzmjaLKc0VNaspQ4t+BUVmOSvdpr+aSboejrhj/y06/Oug?=
 =?us-ascii?Q?UkDrmUGXLM8iudpEoyW4aEHBypKPAi6Ij2gVxpTvxZGpVdET8W6uKPXcU74+?=
 =?us-ascii?Q?z95XKWazXWlR4FNvpBloxGiUivHNZSvgSQE4hw7dbfmyLVdfTqMqe/HHUai/?=
 =?us-ascii?Q?z7YRff9nINfnLhrcIWM5PQ9JDqLtwGwSCCaCZs8nRPoK08QlW5knByVTdSPk?=
 =?us-ascii?Q?NpkqjTBUBKLJ5wou8eyHP+Xxex7AnqwvnzbxmZgXKqh5cL/kMYq0+UP7PtCb?=
 =?us-ascii?Q?dG3eoTbPvaYGaobhTqDjlAlFfLiy7/9LBAAjIwBPhdSoUMRV9JrEVw/WLgFy?=
 =?us-ascii?Q?7NAuWkpwWfebfqwcNwME+KoOEoV44xF3B2sJw/PwvNcckoywm69xTeD6ERdv?=
 =?us-ascii?Q?bE8wnRldljhMLpb1ryZEWuzGbjx45bBDtPSJm23h5TcBZjI+P8MDbfl8peUN?=
 =?us-ascii?Q?UYY0wwRjJWwQY+k6NM6+wwDmIf5CO7plq0yZc15JtoAdZ6X6pdqkRzknijRm?=
 =?us-ascii?Q?F0CacmVpIWJednVTysbmw4cmgIJ78eiqrl5s93MmElKxZp3sGwIBz8KxRAYc?=
 =?us-ascii?Q?O2fAZeVgAW7aeXif2csfuzwJ8/D/59bPqGxu5x37gXQD39ocXRxyTUGUOBU1?=
 =?us-ascii?Q?2YciAznyrS0XGWRJ+WHamF5J5iPqnhRuxU0Lc02u9qDi0NAcUw0I2H4Scjmr?=
 =?us-ascii?Q?XMPks6hymM365ifGN5X/ra444QQZF28L4fsIzpNeR5cjR0/C/T3JzTuWlSdw?=
 =?us-ascii?Q?w+a3PMG/4/vvTgm98HXFRDvx/InYUhXOUH9OE9sGVUo+xHxLEboHj5VwSuV+?=
 =?us-ascii?Q?DK1ETumWxrnO7ia3m/ZvCjKPyXA6+S8J1TcIUPcnlapSHd93ReZEKLfVlAl/?=
 =?us-ascii?Q?euE1jrwycg9whSrTzklrV+T66nAqIyV7Uy7pOvQ4ZD1O362ak8gEjllxPxml?=
 =?us-ascii?Q?b5Up46B75XL6fPQHOfSt1zIuqc4AWtl55Axzmc+OFsyMedUtLbww9Wtqa5Sw?=
 =?us-ascii?Q?XEPiCyxZWxfaR0N8p3FtSNWV6zQccr7aR1rigiq4fFJWh9ZqbZ8QN8fqVShG?=
 =?us-ascii?Q?LzjqYCRQA9phCVSari9aZl4as7JLhkpYPeJHJGp3K/UzRCQ79xPNfb5iXFfu?=
 =?us-ascii?Q?o4klzARqH1lNMhqGmFnKNRqtwDvc1tU5ilr6rRpA2Wu89Ak2qPLR+jv8w0pa?=
 =?us-ascii?Q?VAQi8MBP0UhrfDFg9/uT17pwoo5Bw8KcChpr1nnMlT2vCi1dUDmfm6V23xiV?=
 =?us-ascii?Q?WURQ/FqZvI+n+aV7/giEZmZPBg0FeIY5aBgdv0riwNLucNhXnpIraWckGzUI?=
 =?us-ascii?Q?VBCGPD1ub03C0fPAjLW6K8rENEKgFANjXA3Jy9I6l4cVMIcnoQo3JYyx8Qsd?=
 =?us-ascii?Q?pF9gJrZY15tqW4JHxBhpeht3ucCGMXdcBYVqmPp7lLEsoYUWl3hZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c97429c6-ce84-41b6-eb34-08de9a306ac2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:27.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg6w+9kvlQ05c5WwLulJE3gzedFcCoMHQznUZHdp870rUTQfGUToR/AjPby1ahSI9LD5kVjrrw/EWF13nJpMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

pci-epf-test advertises the doorbell target to the RC as a BAR number
and an offset, and the RC rings the doorbell with a single DWORD MMIO
write.

Some doorbell backends may report that the doorbell target is already
exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
case, reuse the pre-exposed window and do not reprogram the BAR with
pci_epc_set_bar().

Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
only restore the original BAR mapping on disable if pci-epf-test
programmed it.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7eb94dffac2d..bdc1bb932aa5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -94,6 +94,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -733,7 +734,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_doorbell_msg *db;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -743,13 +746,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto set_status_err;
 
-	msg = &epf->db_msg[0].msg;
-	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
-	if (bar < BAR_0)
-		goto err_doorbell_cleanup;
+	db = &epf->db_msg[0];
+	msg = &db->msg;
+	epf_test->db_bar_programmed = false;
+
+	if (db->bar != NO_BAR) {
+		/*
+		 * The doorbell target is already exposed via a platform-owned
+		 * fixed BAR
+		 */
+		bar = db->bar;
+		offset = db->offset;
+	} else {
+		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+						epf_test->test_reg_bar + 1);
+		if (bar < BAR_0)
+			goto err_doorbell_cleanup;
+	}
+
+	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
 
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
@@ -761,22 +779,30 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-	msg = &epf->db_msg[0].msg;
-	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
-					 &epf_test->db_bar.phys_addr, &offset);
+	if (db->bar == NO_BAR) {
+		ret = pci_epf_align_inbound_addr(epf, bar,
+						 ((u64)msg->address_hi << 32) |
+						 msg->address_lo,
+						 &epf_test->db_bar.phys_addr,
+						 &offset);
 
-	if (ret)
-		goto err_free_irq;
+		if (ret)
+			goto err_free_irq;
+	}
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
-	epf_test->db_bar.barno = bar;
-	epf_test->db_bar.size = epf->bar[bar].size;
-	epf_test->db_bar.flags = epf->bar[bar].flags;
+	if (db->bar == NO_BAR) {
+		epf_test->db_bar.barno = bar;
+		epf_test->db_bar.size = epf->bar[bar].size;
+		epf_test->db_bar.flags = epf->bar[bar].flags;
 
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
-	if (ret)
-		goto err_free_irq;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+		if (ret)
+			goto err_free_irq;
+
+		epf_test->db_bar_programmed = true;
+	}
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
@@ -806,17 +832,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
-	/*
-	 * The doorbell feature temporarily overrides the inbound translation
-	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
-	 * it calls set_bar() twice without ever calling clear_bar(), as
-	 * calling clear_bar() would clear the BAR's PCI address assigned by
-	 * the host. Thus, when disabling the doorbell, restore the inbound
-	 * translation to point to the memory allocated for the BAR.
-	 */
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
-	if (ret)
-		goto set_status_err;
+	if (epf_test->db_bar_programmed) {
+		/*
+		 * The doorbell feature temporarily overrides the inbound translation
+		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
+		 * it calls set_bar() twice without ever calling clear_bar(), as
+		 * calling clear_bar() would clear the BAR's PCI address assigned by
+		 * the host. Thus, when disabling the doorbell, restore the inbound
+		 * translation to point to the memory allocated for the BAR.
+		 */
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+		if (ret)
+			goto set_status_err;
+
+		epf_test->db_bar_programmed = false;
+	}
 
 	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0

