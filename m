Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020074.outbound.protection.outlook.com [52.101.229.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D622F617D;
	Sun, 15 Feb 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173556; cv=fail; b=KT2zUWqm6wKxeUOYL35Gh+B90wi4R9gT8QUUdZ2Au/9CYly7xcbGRmv/t2ZSBMi7WLv3WQF7M9QTI/i8JYv/I33c+bfvAp8fia7MLcKytdb6L6IwfwAqBoacbpjD6JX80FWbG+lh5RhtLhRtwXJ3VWRyWQrVUhrG1b2aNDZkyN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173556; c=relaxed/simple;
	bh=7GVlESclAxEbWcjxLLAmeANTgDo/YehQPop3OS1jgrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baYBcTqzxI2dleIbJS+oAxc0CIvcxRULm7YvRDM8KfpPCMUkbd0LUVD+hqRi2vV0lYqUNKmyFE7KL9M0wpOlt+qclPe13eJ/EgyefzRW9mZJIplASAIV5Ss1OYrQ3jlrntljmY8p3F8DtKjr9jxIAXvHTbu2rfOtYfSikBQMVGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OTKkEZTd; arc=fail smtp.client-ip=52.101.229.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OTKkEZTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COMfuoHhgdG8EIq3e8TfRfK0Xz5QEUoY67WmbPqXIsRgiRJZoRU+m1aFYEjgXP3sMsEaJQCBvF1IgW3PRLixHCHCw97QfoYBy/H5LX3fP+qGAInGQhuN854KoxzU58Hki8Cc6POS45BfKqByB6WAKQuQ6xqCITMj5E5wj/blD0MQ1ZjuvHmk6spF/t75Z0zEEuiCUhd4H95xkPnpgQhX9BdaE13ZZ+3f3PDEYrCgYqG5tc36utMNwSojzvnyDT+1Lhnq3bPiokWj6BCk2XaehuWFLj3Z/MWBXmgXvjwNbA7X6htLHpdcqdlTgZz5yfrb7qQXOmFgymhX5VRPxnc3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8xqUzwhffuejSxAvNC4quupZc4ukQb8YBC/L5g5yYw=;
 b=LBFw3eQ9lsASbr+uzpuYB8EwTP+VgrJq30ybNE46+0PCEgJEFbe2s8TLJN69BfN/VR5cPguGHqh41eW+mjPMo0Rm/Wrun6Zplf730B/em0v7XsnmlIsBG3GASvkzXWt7ZRMx1p9Wo8AZol7R96KJ9lpGnRxswz3UeNWC56aVet/BFdtvASp1/gOZ1wPATU2FmDNcKndNrIaTmfx9lSc3KLUP8lMmxAFa1+C5Mucs2q6Gda3dbT/szPQ01g8RDi8CYeRLPMd3e+LKO2sgUooVAhWnOu8wRDupXOSBciYMqWW1sAsuKbQ1VV/HtYFBeA0z3Vzwz/n/7D2jz2q4z5BExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8xqUzwhffuejSxAvNC4quupZc4ukQb8YBC/L5g5yYw=;
 b=OTKkEZTdpPZZ8lfoUXpnGIdQrmUCOF5TW4uR4mFggUOj2QDcOpbcWENcHbLN1oL8hlzazCLN9FS6wTukIxkIyuVo+oednmdcKGgzJezhuDmW8m6lwRGpfKONQSlK7tdN+KKEuJNCV8Ook28/JvT8eW/KaktVyK7+E+BkaVK63wY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:08 +0000
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
Subject: [PATCH v7 8/9] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Mon, 16 Feb 2026 01:38:46 +0900
Message-ID: <20260215163847.3522572-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 419f58ac-26ef-480f-1f58-08de6cb0bd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?peDVLM8joTfoUcj/9z5kH6ol6V08Q32hBhUm9MFVUFplU9JWS62QmPT+leG3?=
 =?us-ascii?Q?lU/DFKQDGjgeGKaF/CyU/gyQgnRvYWfjB4MHcQnclqyZXexCbdhG0NBp/M1p?=
 =?us-ascii?Q?1T8HhaQPXAf5PjGW7PiHHWpyM5TGI1kvV6NPbOwWbPpILpfXOxSOqwmx0JR4?=
 =?us-ascii?Q?mx8P8RUCS0c1bOM53Tjt/wUX05PIOn7yiaHkLL0DVY9MnqSOFu3k08LEKfvk?=
 =?us-ascii?Q?XQ+s9L7PRETKeCPvfQOtTHvy+rgpYL58sfmLK5KRTGRo2/i8hPN/PKKqjvN+?=
 =?us-ascii?Q?Ca2eEVRV9fWgLJhZpK6O3IFpuiSUViLGINrBBbYGPFYTfVlQxOQ1pKCu5wPH?=
 =?us-ascii?Q?1lQKEho8+mFHrFzPXrgXibFaC5sPY7zOzEtFLQ9Zt9QGQs0egZWGq/VeSg6Y?=
 =?us-ascii?Q?5ApPcZArGPC8PiCoptmcGquhrGOBRpdv5qFAT9qm3Xjew9RR6jl+NpAG/DQl?=
 =?us-ascii?Q?fFPtzlBSHm3qpbfYzx+tcb2s255GogFuij4fFSwdF5w06BoKs5wxwHGrbzJF?=
 =?us-ascii?Q?iry9p3bvTmqiVVCtxHMM2pE8RFSWtkLv8lg0PxWnpzZSGufnMgE9Cwb2km9z?=
 =?us-ascii?Q?SGUVv5Twd0PMVeNnc2baW+FBiKg2BYq6SudBhzQmjfaZovnwNZ4lVE3yuwbm?=
 =?us-ascii?Q?HZiZtys/GGxgyts4URvHFdptiIQHMuouLUb8OxUL6Y3MNXmvBQ4QDRTn5PlO?=
 =?us-ascii?Q?kP0VroHl/STVtepoBT7d37uPU1/vibmozP1YlUmPobh9wRyfqrSPIFSCw1Ad?=
 =?us-ascii?Q?BNMc+XocVvggmv14MwyquD91CDJypaNbSIGZzDf/vQnOweiJDoniG29+BhYO?=
 =?us-ascii?Q?rOXeUY4OkpsCM4fi82GXLVTFXTw4NGruz8nAwHWECUqt6jy1JmWbJr9l+u3N?=
 =?us-ascii?Q?ofGXy/QZFZfDiMXbL8kmSMtug+gAXwUpojYPywqa4EV4gGYPZUrB5lYeFM5T?=
 =?us-ascii?Q?kdveFaoU3kJCpN4ynmKVwtReA7APvGyocGck9x1cQbSEaj7yti+LkXjX35FZ?=
 =?us-ascii?Q?hYJ458+jG+jaFnu21MItwgqNWzZZQq1WSphE6ETTKGxsuAU8UA0aRMA4iyZM?=
 =?us-ascii?Q?M44SSKpjcXxNSfY3Qw3x5LveHzyJoXoetX2Q+Ailhn/+DRFFaGyizm0M9On+?=
 =?us-ascii?Q?S+C5eC3B+vxQY8aSbx7+C3+g8wai2A5MWyqNp16SpTaJL4mPmyRaJ+FSwvV1?=
 =?us-ascii?Q?MWa2PBj0q+mlGfGQNuM7iKkNRtM8yeni+lbDGL1U9WUKaGzIHJOFddPR3G+G?=
 =?us-ascii?Q?GlsiURt7wG/1YJLAnvbuRTytPv2yfi8+A7l4ZggBbp4cHffeGB3rp327N88s?=
 =?us-ascii?Q?hjhgmEWhc1siNp+x4u8Sk7lFYQfN3lXWMA7KBE0HV76E56ayuI3g/mJqR46P?=
 =?us-ascii?Q?C7oTh7VFpU9QPysx3gwpurx10+f0euG8bLH9DWtKlk27ro9ofooCseC7/Svf?=
 =?us-ascii?Q?Er1MyBN/YKLTJUprPHyRSFvEFaBfOEWEmdzw2uow4i0tCx8/mAeJgR574TRN?=
 =?us-ascii?Q?rMWREQF++M9kwJA7GfN1jr1pknArlD3W1zKpAisba3tABk1zyJFYnq5b6RrQ?=
 =?us-ascii?Q?Qzn+sJS78EK7LNFbOyqurq27cEuLahH9SVAU1Go++3vA1l+WbQO/9HFVQljW?=
 =?us-ascii?Q?Jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2mcQDv+WdipefqRulofIC1m0mCRoaEEfMGquKi3QVoF4TSkD6wlrHskjgmU?=
 =?us-ascii?Q?bfqmTIElrGDRykKiEKzfx4fMoXxBCeeXI3aUVJ0jT731i7Zewg1ZMEUD53+R?=
 =?us-ascii?Q?obyqAslaBPZPG/rgRFu2zFT33T8fE2SliqN+ocM6fDplh1NDTmvLQQQ7Gc73?=
 =?us-ascii?Q?GT6QSgXBoZUIebPIU49jMVFRbDQmbcVeINE0cR8jCA3i8Zfx19T6h4f7G0S7?=
 =?us-ascii?Q?m1MOj1FUoudBRagWH52ZTu5dYrsCTQGfqf8k2w9KWie6YLy4A4LVhi0fe6ti?=
 =?us-ascii?Q?GwPFgXUkPynuJUdAlq0yJfrOUH/TblixGQ+L8At11+zs/9dxGSvxM8lur5Ui?=
 =?us-ascii?Q?DQF2RnIcOu0F5ug0NJb58s+B+RQGE+M9LGWf/l8DlqUQOTSrAMRbOYyUTN2F?=
 =?us-ascii?Q?8dxJtEBANBshokxRwByR/BxUdBsCBGE5MS1jHKTIhG10JYVvNbJ20OI0xrXf?=
 =?us-ascii?Q?ZjkgdjeBSBknm3Okr76P8cqhuSfWT7S/Gv3sN+4gmA6dWMzSBYTfx+coVHZ8?=
 =?us-ascii?Q?il/Kbxm7oFkgBexMVVCIgnTB68cReKccERWYUOGLo/ROhPiasbxL00gk+1W/?=
 =?us-ascii?Q?Kykyw8/hiIcsb+CPkoTjPOmM5FkN9sYOHaM2o65hcm8ze/M+mrF4DMilOmGL?=
 =?us-ascii?Q?iMJ24I49pU23UJKEQyIPiRvorm5sgER5qNjxfkQqKNRZkx8wfBAjbBe8wZfh?=
 =?us-ascii?Q?7n6D3x5Z/Y3iO/w9O8Y5wbNM3Pc7KJ2Mv8qS4m/QChgUnFh6Xf5k/G/7o0BY?=
 =?us-ascii?Q?BwCyDWqZZ6gEKq+DhaQ1RdLfNplCy6gEc3yCGirp57oNkDZZC8iwISafGf+Q?=
 =?us-ascii?Q?6zSZPyXDIcNKyf4v3JA5X6x7nbDcQVR5TuOFDnIiifE2z6MWv1zFNR1tWOri?=
 =?us-ascii?Q?hIuDL6mqhdKHb1OzSHduoAgKYAnj2tDmmuaIN7XbckMv4eTS6LeuSZWbe20X?=
 =?us-ascii?Q?ERdBXep4JDGgW6Y4N6lETPQzfhTRhLlfckKfmm54jTZC2cqpRrJ1EeKrveTB?=
 =?us-ascii?Q?8JgUEk+IVHPinkM418HTsCOwKJ90gFmr3I3QgLd5XDlPSIYvJpZIXVQdxASG?=
 =?us-ascii?Q?crhTSmDIUV8/NKUFHohIutHsUe8U89FXPtEFhUM9A8fvlqxd2+34u1bGQu/l?=
 =?us-ascii?Q?jAl/GaNNQ/nrQEzJx0ioafyNV/MIhx3BdFevptmNrQwv78zWeU3L0PI7VOck?=
 =?us-ascii?Q?teorVIw/UTNX5blNR6eh4Gy67mvTkVOyykMLXuwCCojkHqHfn5JchktWX6g9?=
 =?us-ascii?Q?jqriGgvowNhA/0MUCCsvxqYg062wSwL4o5C/3Ye9ZUU4qNwv1mrFNgQ/y5Gi?=
 =?us-ascii?Q?GH7DljASR70eQlBpKHNdf4BIhKGfOarOftykzMt4SVXSYzM2br7INp3NsZAp?=
 =?us-ascii?Q?yJbjZzkAGrJ2bFixiCTkwgi4/We6fBq6QFs9Vu3FNCIp3yoiGYaMTlX0aGEN?=
 =?us-ascii?Q?kdbkgG3oUs916ZmrB510uAUYMfPZbqssMc06G3EdlcsXzIO8gFhJZqMcxKVr?=
 =?us-ascii?Q?XKI1q5E/LP1R7KYqlGchHjZ+S15jljcpDiRVL2yzUSkCQe/1lc6mNnl8UDP6?=
 =?us-ascii?Q?Udjci2VrlNOmS3Uc6RN70y14c9tmAWI0RpcHUpfSPTmYA5nJ8YMc8edzP3Qn?=
 =?us-ascii?Q?OKWg/rxfVe8ppvGUSbRRUdR0ELoWKqHc8zp55DN1/y6JavIW84rbEN4SNmSq?=
 =?us-ascii?Q?FlH+JDC6wuhzt2jqheSnxDy8JLPTn4GUwdIfD3MhMWs+t3/dr2Wm8chrSnUC?=
 =?us-ascii?Q?wLrvbDBinQ2xjicl0JnpdSVlfWzMkw9WY73PY/k9qdd/d//8lhIF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 419f58ac-26ef-480f-1f58-08de6cb0bd98
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:08.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uteHzoVgqq+kJlqckeGdgSRS93FTPH0JZaoqxF+BYrLTSZin6XyT0yGkEynEdm4ssBOKcdF8m/0X3kcRiLTrIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

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

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index defe1e2ea427..7b0955b4c703 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -87,6 +87,7 @@ struct pci_epf_test {
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
 	bool			db_irq_requested;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -730,7 +731,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
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
@@ -761,25 +779,33 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
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
-		goto err_doorbell_cleanup;
+		if (ret)
+			goto err_doorbell_cleanup;
+	}
 
 	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
 		goto err_doorbell_cleanup;
 
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
-		goto err_doorbell_cleanup;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+		if (ret)
+			goto err_doorbell_cleanup;
+
+		epf_test->db_bar_programmed = true;
+	}
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
@@ -806,17 +832,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 
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

