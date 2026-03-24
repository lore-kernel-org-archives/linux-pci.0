Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020122.outbound.protection.outlook.com [52.101.228.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CE3D810B;
	Tue, 24 Mar 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341530; cv=fail; b=sm4PjBE0Cnzb5Z2r95QWrITSwY1q5ZL6Ws/bdePpyR/LxRjAGl28LZl2dCgDYKaDRNKkCcVG91QmaY5MakfUkbDRb4KlUVq5EsO1WT8jmXNR/vDCrtwAbc/NOAAd4AE6YBI2qonzoHI3sqrvrbNd+WKrqk1HsHeHOOpJjAVqHKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341530; c=relaxed/simple;
	bh=dlVnbhX8PxGnedfMNDpDYZosmRi6VsKB2pbJC0JUfqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JoHQGnTQjN+nqsjAP1xYZnVn7PWverN/x8WCFXs3V0MdCbg7pGQGiK2hsHLkj+A1tRD0y4zcDTkp7lXqKy7Wo1u01K6o7yhNWntUNtkBmStYeN3dbUWJ/1B5tq6ODSZdEuPSk216uAwk+pKvOFF8b/R9IHYuJN1FQqA3ywE/e0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T4ToIibX; arc=fail smtp.client-ip=52.101.228.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T4ToIibX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpOmv50m5cPD4++tOjwgz/zIbzyiBsz8FF86AU2COBrdf4tVIEi+L2k6jyVGSCoMwp2r9NkQUF1+Ahr14m90D8Ook4q1FV2Vqx4TsFxK0X4z8qmhQJQ13gJaj3/Uo01qvmQmFA+K7OOIXRs05Xprf20g/jZgHpB6MkwfhK9SeKpPehsD66IEmH8/EHPfPyWWgtz4oXA/I/d/sPpudjWYOiqdL6EGOQyIbm/pb1PUsGv+lsS7EuNPeBWNAYBsg+6FmywGYjEIkY08zHjg05uXQBIW2FjrJD44nfuLvOQDB+i+BcK0KACOJaVqh09X96V6B1dnxV6ibRXgKiXYidZuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdv0PXxOcHbw+RGn7yNzlRw8lKljXPhJ7YMgz3q8sHU=;
 b=lqmZbMEzetRtAdXyamFJHiXM1KvuBvKwE4kIArdUkoPSqpLdVTeCORTm1q+D62r7oaZsiKg1K/aa1hs9OpGRxrCwNBRm+2hxrkvQa7XyGseg1XVHhv7FqvkYQoZd/1DcvUh8io4TEJ0ENb9mBcwmlGZMEe/TeAHio/5vRVyqTWGcLH2Aou0MTQkrci/xjGJXLRPUTpCi/GROeqQnMfUaesBt1wTrMt6g/DF6V0bQWjOdBSM4Mxn5sB+z5EwZSH8HP6ciMeXAPiC9oIw++EjO4nB+Avp+viPnR0GG9/L5pQ5Es8QB2NeyYow5oulJjl7eWjcPym2ERqAhRvoO3AcLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdv0PXxOcHbw+RGn7yNzlRw8lKljXPhJ7YMgz3q8sHU=;
 b=T4ToIibXh/pcTSIXmbEGgpICm9MU+jIW7IU3VeTqiZFBlIIA+/2JIuP7Ll3UmRZbHw/uhNwXZrEH4fNce8ikXqWeQdiCppf4iYopQx3SNT92dUJsFaGf5COOmDFoJh24jefX9mmwOo5szFwqAlEWURg1zsKTninvArCZlDG/CIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:21 +0000
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
Subject: [PATCH v11 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Tue, 24 Mar 2026 17:37:27 +0900
Message-ID: <20260324083728.3744734-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324083728.3744734-1-den@valinux.co.jp>
References: <20260324083728.3744734-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf3e11e-af40-40d4-db5d-08de8980b494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+EyIF+n89c8h0ah4B8U4icS+v40wW+3/ynl2f2SqB0yOJjXmvLCaCd6OM0+18VpRoCjb/TQw69mm+s7+jgCot9H1Wn04Ytiy/+4hLSd0E48CcZKyeWgwAM9+KnzTvFDSs3odfe4b14LEjZwzKvI5ypegPvf7axc+lSRyeG2DLr9ljUpsouvOR38Jyq26Iezcq5S/KA/+04JlkS5MFfAZ5Sxo4KnGpFBpKikaiHEsqx3OnonA8yGFBrZVX/pP9M1Fa8pUzDKIY7hLmZ3yYxNC7bNNXHCV38RbgER+9amMGwGhWHkq62zwEM0OGEDioz2vK5pnOe0cbK+OzhOAwoQPaShZNAvGUHmP+8D0+b8wATHBJnaKNGD/BTpS4Uz4nMIUsePDcKYNV2mOcQ97XYzKEd0Krq3TxYAHVF8fVSyhtC6GD1JoZqgpcnDJKuXn2+U/XRy1onq/e3mfqbWXW9z6ukCNGXU1ncOPyGn+SVxXOC3uxDh3Sjbd3uq8R0j8k/gJCH7FJ+lh0jdeqO0+UwK/++fkV8iNrHqfgGknSfWC6E5VE4YWyc8M7KRVmTda9YM4tkHor6ZG7iXdgeoySt7jwO/58yOezUGpYION47hGU3NESgdJP5ZJdW3/x7Dq8Iu7BqzDle8GBNONF5ZmSP3yRx5IDPzli52FMynbRXHdm81Ng1mBEo1VviET3NJl/Cw+M3dpMA/hkz9xhd0SMUeeJ2w9DgXlQvwALvqig+uYK8v8YmMK8BLo7sV62GThRJWfUkU1IDnBBhmWzlfQvhLEYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+vAH4Aoji/V8EqBuPv2JQqRjqsW5rgxdtLrY8kUtYiv7ES8tW+mC5A/JdAty?=
 =?us-ascii?Q?Ih206ND/6IAXmV5GXwHLeliUB+BIVEorXBBH4Q2B1reME80JC/2HxqyGcHNr?=
 =?us-ascii?Q?osLWFvHgzyC3ctIp3Rq070FGXh1RnI4E4FmRm5D82hhyUdBw2G3Eky0Xcvx3?=
 =?us-ascii?Q?kv83Pm2U0x4ZwL5j0Uza5RmBnrlKMYz1Mbu1DEIoy0rjubQN99a79W0axZV8?=
 =?us-ascii?Q?k5NGsp0pVbmakA71VmOnC8uycGbqSPdGFSO2uGVhg08PRFm5m1039NcNDLSN?=
 =?us-ascii?Q?QP9wyyJQV2tln27Ho/AvLtw4/nSvU2V3dNxTxX3TtRWplulWMmeOMJgxdMJf?=
 =?us-ascii?Q?nydOSaJWGoTEkRpZns0luPCqFTyNj9V/qwahUNMujBUEEtJvWEdTwNiuEXn2?=
 =?us-ascii?Q?3B4zEQrFdMgWgZOAoOaMzCgQJ+7RUN27YXsaNijo4FSdz+EEky/CPowzFK8S?=
 =?us-ascii?Q?qvK58WTRXGNNoqOVzXR4gNobzgAx8esvjQnrfSMimZlMNq1D+XKheq2Ds2NU?=
 =?us-ascii?Q?nOcwA6qvFX2Q8fpJzaWLBcy1hVCsgY5yrdtS74ayeT6tgNkcE1tOO34Q4x1K?=
 =?us-ascii?Q?4/OR+WpSb0uTAv3kn5ZUy5hqrJPmGzgIlHcX0TPlEaO3JHNx3i5tO0ADIScf?=
 =?us-ascii?Q?TjDQ1zG8jMXDGZMcsTZn4tiPLhS9yQ8y1hlA2z+nHyDKUOOEGyGByepfx2qN?=
 =?us-ascii?Q?AsfpVQZRZcOv3IJ1aRBTH+aRxub32dZ+EcY0fnUi++Y7nm8AHhQF7006MLDI?=
 =?us-ascii?Q?+xQ1VkCyJWSiMTKOwgFtRJ1LKWi9ve7IGhMZVfoVaqZYrK9B/7C8b83sqbTa?=
 =?us-ascii?Q?WHHXtV8p3XJ+YHmt9dsd7HiZvk1Fn0nUBdtGRP+IcZ42MdirAbY6gWem9vk3?=
 =?us-ascii?Q?JE1CN+1yHW8XExBJCFnTIqWiYcMFJQ1wLt0IR6nAkDZHP27UPh6SujoWLZz/?=
 =?us-ascii?Q?eqq8t5xQeTCuJPq9FNoylcM7xbaJBCMGVLZ6Ld+Ab9UwUswfqLbuSW1qGxar?=
 =?us-ascii?Q?dcec611YbsfOa8Da1omQ1S1IlYvLoZ6zZ3FreY64MSjUVts+8Y9DfGWfTXId?=
 =?us-ascii?Q?bpNnB7lcbHD/l0d3Sm73kPP1L1Af5s50EFOfLWoUaJXk7k3zz7RhGEQEmAda?=
 =?us-ascii?Q?q3l41qr0GPTbXKHALftzqWNhORCr12Qw0E1yAT/Zsq9sAquakndbbARJrAds?=
 =?us-ascii?Q?S5oot/kcX+QLkdP1Bm76gTGkMyMrfbXjnmLX9lQfPn4yFdpsQyS78FUI3/G8?=
 =?us-ascii?Q?uxoapXukIB4GhS1GKlMJQBtIwAyxnjijhDfAGuEWv3Vn3xRrDHaQ7tHpvHXm?=
 =?us-ascii?Q?NuCAdTRqKl8Dy3H1mmz5nAsRZIqqBo+Pq4B5Wdm8qJAUwHJDnQOI4/QpXBi1?=
 =?us-ascii?Q?LjtjUQyqvID5m8jORVWHmyvwYWwqZggTdvcmvw9Fgbx4F9xqePcfKkifAEUO?=
 =?us-ascii?Q?D/MgsRT8rE6qHnV8qtjrk1OPF8I2X12TBvMiwTw2R2kcSBaTKcnjjdUrHcWr?=
 =?us-ascii?Q?eUDDCQiDSfZgBjM2k4OsySIyHIWaIEoFYs8WqM6oReZ/eEzID2xCzRTfEeVB?=
 =?us-ascii?Q?twYhlsrfTDxq5k22t1la5D9Bn4M4nEx6J09aT24tWB4l2tCxICt2tt6XVzjG?=
 =?us-ascii?Q?KslR84cz8/5D3Gq7sqTByAFpOm9bCkRJMBRYQnNue3Lhc5wasUW1bswQGPI0?=
 =?us-ascii?Q?8XcfQooyg55oFj3XVroW2ymLDGti0eyoA45AskVjKcYELekh2Ybv9TdXkc3x?=
 =?us-ascii?Q?uMC3b3yk8su+P+5Vxl6Sa4EFKeWizwdKnV9QWASu1Yil5fPZY3hf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3e11e-af40-40d4-db5d-08de8980b494
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:21.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEO4PqjL8yCvE5sNcmw178K4xLWy+ZJi4JKacP5PVeGidyTo0eGGvyWbLGZ2wQgzwyO0V3rGiiKQNXB7meg1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

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

