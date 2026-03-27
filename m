Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6573750B9;
	Fri, 27 Mar 2026 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583681; cv=fail; b=DE/rpALxAT40kvShtEslPUmH29TcPAwsYA9o2+pDVCNW1Z5T+tLK7L2GezwAESqXBV2KLn8U8q635jm9q9vAVk86kSs+FENMhRhdyJjwwsVPPobQaRJ0x6+SZ4CbjRc7LSausKhM4UGGNeHi7o2gxeHbuLY0GxBlfYuxbIKYl6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583681; c=relaxed/simple;
	bh=dlVnbhX8PxGnedfMNDpDYZosmRi6VsKB2pbJC0JUfqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHxl+LQAILHRNVQGvTUtzT9E65Nf1bzy1s5pP14hAbyYG2Rb9EUvvanwyHDh1v16cV7ezGF+7wxwwr8g32cR3ldGLkaZfeADsW0QHSHQfdaadfmddVt7prz1AXL2JIXra9Syb8zoQERp9Cq2zOXaPaywOLqxEpMe+ic7bFGmjEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WeNsb998; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WeNsb998"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpwOlkzjv96HoLZEjVN8euHVL7gFcSdzAIOKxFmZtRD/ZPJCSmXmeBdahTdrwp9VBw2C7Z/zy+vuMG83UP+CcmSeqZ0J8DYQ/G7ItC5zbMuCOUF61pN05xfZ9JC3GeYVSAAWaIKzUFD+y1d0WtiQpTaTF0YS/iHGWowZdNRcvakz+3EBF48JIYb0TYdv5NWYOp6g0cFgfs5mSPJMJb+LBLO5ImVQzKbcbCcLzYT8Z68hT+/fvcl8HFc77dQl6ZIY3aAFghOWaQL2sGA3y+4OdJbr9PIrzNrslpywJ8UG31HSn5shpTMT4DMwnoxRnbozWnMUkqZcYs2A8Ij+JuWMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdv0PXxOcHbw+RGn7yNzlRw8lKljXPhJ7YMgz3q8sHU=;
 b=ltOfKSVlKAMBZCEVglIgrEHhSEyE7AQK4xjWOJ1wl+WjTsRT3Gz4QJH/h64t02dem+x5Q7MiWPm+qjlELXZ2qHJitLL4MV/sh0cdKvLXFz3hIkzMn/H6Cr3SLzYaHvmnZOXuS0CYO8CRafMvArP7UlMD1W/umQb44BdIQXlw7JorYXoaW1Qtwnphw/gEGfa+K+AIW674mInla4ukFAIjsBVHiO5JyN3XsCTATIl67Ojkaga0SEuaetBxuioMSiAbZL8iHArV+wXwz5TFgl2otY9UXpvdrR+DLwqbzL9wxkEY8vd6TJJk7dM0XtbiiVTxegqEUOWtXWVcp6mVWiYV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdv0PXxOcHbw+RGn7yNzlRw8lKljXPhJ7YMgz3q8sHU=;
 b=WeNsb998yTnrzjNeml2untSnFs2LK/gfgwGvGwPRMf663KKiC5Im6YFnQjwdwFIfOUgM3mEFMj3yHD8kdon/Oc7fcMtT/H7uSvzMrtkIHvM8tCPblvyfA2uTbs91oW2dH9+7dTC4loN+kcIaf07F527Sql5nvMFOo8czD/CkvYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:30 +0000
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
Subject: [PATCH v12 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Fri, 27 Mar 2026 12:54:21 +0900
Message-ID: <20260327035422.4020455-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f876d0cc-d193-492b-ea0f-08de8bb48c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	blaK+0KA6eA8kGOhDyMB6XZWmcFmo0trj04eq2MuhZ4ZQ3e7ftQgRU51vvyyI0IgtJAccYlmOecJZQxVq6itd4Q+pvyCJmHRVo42DrL6DV6jKExOxh8g/PjBlnsyeZ0ohlAFsGxdr968lFaKR5Swi+DoHukg8t6U4aK/gqaS8gmepuVXXP8IudZwBD9AYN+GS3Gl71ZUJ0x6zN3DDKAZic2My4XkrrSUVtFHP23eKVSLvoqUFm6p5WxRUZTJoGlZgxTrPQ7Y9ZDeaNHXwNDWAl/f5ZTFrCDWvo26vHDmOO0PaoSGLKXXW5VP0QNLBM8F0FTYHslMh2vMTDnQoKSP8K/HJ4+w/X6ILnp2QTaVxiMqTuCh0PmXQ4ekEY/opAVsKpG7aWHHtE6ukpSHYe8uTwRUDMJA+vr6RAMyKjnhFDZzhIx/Pf3cCpAKtgmYQ/kAeyBo1MsRs3iABrtd621tTVqlcUet+ERwbyRFzG24pPvbhrQJb5ZyOEzziAUqiLPFw6Zrp/PlSViR4lwLDnNOd8SK+Ol/DeK0GcNMxKoGvelVT4jq1aNE87b9+JJsCA0UVkcIq7moAC7vEJYOUiIt/5i6/bOg0NS31T4ODcpIl4mkyUzUbqU5GzCK71+iqhmfi4414H4xM9FmCPO8CWWRYjVQr/oj+Md5xiANsOIkBEjxU0uPgS6GhcnmqjX+AnAILUJNttF4TJ3s8cPTD6jLM4kVGeai5FFsct68USH5u7cfPMaENF4UYXio4uAEuXQ4EKr0IsHyGLjJ2RRScqO7OQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kT/QfxALEZSgsiXrAhv9pZfAbUHTZTi7DgFjXAp3SSLwpcN7B/fFdCvZpDBn?=
 =?us-ascii?Q?pFBtELCS0Gsq2SUYA6bETKARhJGwxribPVMygJDgo3Zz1npjlvt/hX8x0UTo?=
 =?us-ascii?Q?5Eucs+OPQeyshqLqPuFpG2h4De64qFnk+KZys4iBdQkJDTeH9ZWMHvlMbUFf?=
 =?us-ascii?Q?2gZPlOv4OBlh3PHC94ESTc1UvC4yw+6/8fazozDWLAdlLfvIwZtmNngl+O/J?=
 =?us-ascii?Q?nFt3AdVnDEPx6V8sAi+QTSianjC26b8kVH4QO1t1aWrY+cdRwPs8EjDJyocc?=
 =?us-ascii?Q?loEm7yIsz70PNxSjX5m1oRSv8apZxaLSN1jljPV+VtNwUJMVJO/lIEt6D7Rd?=
 =?us-ascii?Q?b/ZR/9Nk68VVdwZe6xhPPO5et55RZoFf9vfz6SVwFvyf71eFOxF5gbObUfL3?=
 =?us-ascii?Q?X2xd/SLr7LVKzCyHn9iZ38nYbuCn3meiSvOSuKi+EktqJPqbKVUE1RMDz9Zt?=
 =?us-ascii?Q?MasmxRzhOXnt8tuF72pWdKFk06NNWz4eyI/XnQm15JNF3zBYa+GFuNR4LLvt?=
 =?us-ascii?Q?C28+bi4SktIXWW4KIapzLROKQM/SMGOG4DGdgl1Fl7ETd4C2IgTZ6CdGwFTL?=
 =?us-ascii?Q?TuyF1NkO95OQy0gQm0UD3OejOfcPPZgu1L31WPioWFiC2740ysnOBLMYr2GK?=
 =?us-ascii?Q?qenJwwvOcq/A0lL4hAFI8JrvOuSFXOmnu98PwJ50DrrNp7okLRPRGJEmFXNy?=
 =?us-ascii?Q?0pgUlhCgDRIhJxHOBKDPv0efAfGtyfQDjOwbBkYQI0cjcSiJM8603NPIWQG1?=
 =?us-ascii?Q?qmPVJ2rAWBqYFkUusRBeoQjCS4CQ+e4GKPGj2GCz8OHmdEZ+tWTEX2Kgr1XZ?=
 =?us-ascii?Q?YQthucqrc9AKdpeauTdIjSr+9JaJertCgf9NKPPnnt3L10PYDBWMZyo51T7i?=
 =?us-ascii?Q?qFy3YVxeJGkHFqPwr/V52J+n/wMfhdyANp8smn05WROTGLkuOQGQoTjzSJX+?=
 =?us-ascii?Q?ZCHk0QGh7WO8RgBDwb9n/NGKAIcZYWixfh8vAqIFRYb2tlQ7KTIkbOXeG1cJ?=
 =?us-ascii?Q?3eS3zm8rjsPpQu3oMWonfkC1MPobAwDGv6nQ5L0rLCI53piEtbtofYOqKiTa?=
 =?us-ascii?Q?0WtrISkrQgjY5tAwF75WuO5MyhL8+G+hRLvFSsnSPHw5IVgx0DQ4wAhXzh2+?=
 =?us-ascii?Q?d8UofJut9NNq3sGM4lNljIq2eKAQuhVdND02/hn1f+xohuoQutiIOoV/TBQM?=
 =?us-ascii?Q?gz4g1ZkNioKDbnADbL8QiqXpMDHewUTcWLSwviRBw+4Kwt+hYTNDYmz1tm53?=
 =?us-ascii?Q?UlZl3O5S/5pMFxyd1MNsmlKcZmJz2uZ4UxOcB3dqp9c7bf63berZGktXdA4a?=
 =?us-ascii?Q?QsnTxXIYW3D6doHME6eKT+A3EYbEOBvWPybrnTXYOBorXzWZm+gIOris59VT?=
 =?us-ascii?Q?MUIgV8EsNNl97b+E0L7rzYZ7b1WAjvSg5VTzjZijOjnk51+ilMTFZRsTsQzM?=
 =?us-ascii?Q?mQsT9Gw2j5AxmCCGjE33ncrzUWgH59au7L49uHiM0RFkpbZrSnMHUgpwLzXR?=
 =?us-ascii?Q?3jhf+N2Rx9u8ZDY/ZifczuVHl+qJpNuYfGah8Rqaxu0mqkLq8MRCszs9nG37?=
 =?us-ascii?Q?rXp+k8dDLLn1t8emfGYAHT0taO9A0SFYSDr/m34ztylPUuim3e2KXBlu3bgg?=
 =?us-ascii?Q?xQKtq/epMfPIsWmTPD3VLFwFN/W1dASHEPzqB6NGcX/anMdxa5vh4hK4zdb2?=
 =?us-ascii?Q?b6Vec6UP9kNfTgK+iYmyeH3Et+uuxkHD4eoYbWgIxALIWC1SZwsyoUt2Sl6y?=
 =?us-ascii?Q?i2vD3U/dflFWyoGISRjcpcLnZ536fA8GsmNpw0S9Te9ZheEBHvmy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f876d0cc-d193-492b-ea0f-08de8bb48c6a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:29.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2/8Kjd3jH6vUcazVqMFzvPXD8FLUZ5OkdQcRWFxsIz+OjHo27jEpO5HTqShphANZf9jBCh99Gh7UWPqBAfN1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

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
index 14e61ebe1f11..b6c865b0883d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -93,6 +93,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -732,7 +733,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_doorbell_msg *db;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -742,13 +745,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
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
@@ -760,22 +778,30 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
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
@@ -805,17 +831,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
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

