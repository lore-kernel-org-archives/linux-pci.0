Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A183A0EBB;
	Tue, 24 Feb 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940119; cv=fail; b=o+GFHdNVEP2ll2UmxpQWVeyaG74aocVHHN0E+o9B02SqiQSN8g6Z2LQ0MQdbYLiN4Jsf9WryAHhezBS2qbrmFKxwb8aWXhhVt3hdUjVTZTq8B3NTTt+FNbSrEfJDhiVWdQOxKKRYI+X1Eq5RU6ZZDMgNnFLcpe+EaHBps2u1GHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940119; c=relaxed/simple;
	bh=GjvZtk3P16xgIeaFGzCGhqfH6QAfDkOscSrIIw/VAAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aw9EB5MtDwMiH6BQcf/Y1q8m2/xNaVKmYaUagLdxoO/Q3Nn5r8xTfYio20idX+/2PTwU8+ODJ1j87PnG+dBd8M2VxiYrJh3k1aUuE4VLsaH94z1L0Y41WUhAl46JW8X95twd8UozEORkxgq+5BftCOzmPMX4ONy8UE3vOz6E7bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KaBQXMTr; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KaBQXMTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofUsb89QM/A3phn9ZguumVLcbvz8+hlaOqV4mkDuRqYVI/3kBelCcRdRiqPqATYLJlKlZDR1ASz8b9z8gkalm8ADf0cmpzrlCfNeGrJIRyRxZUU2iTYeS0d75yEMkifiJy7vcVeJtogWzpoSE+SWN3Aa/mddjd+NCprewbA55SQVGrNfu6XaIB+7OQ1UWwsymSPs6/tP2nt/P/FBvGpZwDGkuQnTOJZtH6mFvFkqzAub+EPfqxdCvrK2nhLw7HDFeaaE0UEFca8i2WwSJElwDD9lLt9Bo9SdJKyZoT/6oTitG/YyUaye6k6sGxMEJpcmvCJJKQPna/ZKnSB/H6imZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS97Nm/uJsFebPU5x9/248bVrOiLeBXp9cX6l7gDpAM=;
 b=AbQvk/OMJ1vC7stYP3ADvxIYCFDqzbuYC2JqtZCNMiNv81jBSWybS+hSuJxea+I2A68Gk2ZNYSNs6e9m3G65WZyWn4x84FPLgqt1qjzafcqWt3OgYpNAB3KCPi6ie73H/vidCuF6jJ9zZFzMCCxTyns2xyDYjsRID5dhjh98mWmquAXafF0LYnzINOxK8WojWoCAag8a6YBixwQiru0Ygpw2JV9XxONoW1ihJU/S2uBo+5DcPQDsSmb4KDTY2Br5pu+PdgWjv1cox5iIvOj8yEpMz2TPsQdhqrCoMPCRnlGANjm8XuaiWpGnkaGri4BoSbq2kmLgehflHelMeehbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS97Nm/uJsFebPU5x9/248bVrOiLeBXp9cX6l7gDpAM=;
 b=KaBQXMTrSV0n5FAEiclE25ehV1rPc7GD4BkvkoHuB4n3B7teZTbE6HoW+7+hfRbcuCwXENhZaRn3IR3ozpEdp6Gy34crKFTHPatE5gVVmdamMYDZU1q6tqP8R8ytUDHm+NoSberWrpOeiXw+2KWVqyHK1MnCyhH3TJ2puRP6dSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:11 +0000
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
Subject: [PATCH 10/10] NTB: epf: Implement db_vector_count/mask for doorbells
Date: Tue, 24 Feb 2026 22:34:59 +0900
Message-ID: <20260224133459.1741537-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:405:379::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e634e5-21e5-446e-a973-08de73a988a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2i1YhIB9tJTq8cBbrHGhmqe+2qK6p5aKXfi3rqHp3bkWXmXC9KYce+J+a29O?=
 =?us-ascii?Q?5RgutoLF3LFYFpiuiFs6+6iW3AYYCwQfMWfLtd3/W2o3AeIhjtOPjBWQQ5dj?=
 =?us-ascii?Q?plAT5BYPLLjDolHVBnzCE/bRoJuZC1RWPs/FSoK44cIsoINfJRnhgNtoMSLJ?=
 =?us-ascii?Q?iuBXwLYLo3P6xFWxozaTWsGrGinZAUzifZo0i2TEq+l4PJV25iekXcYtpC7d?=
 =?us-ascii?Q?SweznFBG1QX4g1izMDOJBBZ9ysYvCygwJACWmQ98qTO7pEob8HBrPb1e15R7?=
 =?us-ascii?Q?toLxjentkqDMC8B9EOfysCtGpsGVkOJnHOE1rYDzsXktyGnms7JlvQT+AT1T?=
 =?us-ascii?Q?81kzDpnBxzydmA5WudqDMt4tSxMZGdDH1LKtXV1z67G8m9jP0q/a1Bw8dDRg?=
 =?us-ascii?Q?8gSCqqkEqjXlQv59Txx8Q7IJo9DUGle4pZoZ7EKVnPbGmpxdAPC0K2ln9S8O?=
 =?us-ascii?Q?FDsHYCyK9IHLB4jtQe6GJS0P/mfe0ND4pnfBiviN5QcTpImM/8rnviiaLBe3?=
 =?us-ascii?Q?Ae/5M38UGcEe5pGBQ6qTb6q+kkI+cGrPSQnnWbc21q+4pvfMpWwYTNAYHpOI?=
 =?us-ascii?Q?rmwDa59Y4GvYw652I8sERjmQ3q3ma0G0rI8W0oAOHsQh4UfC1jsxDT3ytRqv?=
 =?us-ascii?Q?xdHKeN3Cv0TbwQc35szAgR8WTFHc6OQBh0tQBUYr91DEVilyEvisbuuU/1T7?=
 =?us-ascii?Q?JN+SH7tj2MjWIfZu2OgMNcS/lfpKDvG1Wug8mV9sEqMKfZWYfOQhjDykycql?=
 =?us-ascii?Q?NgGh25Isr8JsJooZWQXBJ2ExDlbiWcxe6D67hUzSNaZO5Tk+g+0JJ49wYAwm?=
 =?us-ascii?Q?rZE7Yz1kk5/I+KxlxvIB3cR8+I3JuGAqSjDRNsfSIWBA3O7M9ipf5TkWeocD?=
 =?us-ascii?Q?vVOqoFmTpuff99ah4Nm9dEsaTRoPuE1H6KeqINLxxSpkEFzbECHAWXy+K0li?=
 =?us-ascii?Q?EIAZnFGqGV6Kkch/Xi5ivfi9vCJcSBNZVsFNKGOdWWJWIIbk9INBAfbqdaax?=
 =?us-ascii?Q?Xd+qomsPw4MJjVhEF7JCWE+jZkH9G6cs/evnJDscoOlLVriCDrXVks19f5Hv?=
 =?us-ascii?Q?QCRuIzwssbT7P9lukprrKVe6ZtC/pt8Xfqv8pGs5b9bogNLDBZ/L9bEnuL+u?=
 =?us-ascii?Q?5bTr4Pxu84znNAgN/jVUr2DhQauqU1CnKgYaFWkifv0wfl1jbGcelf/0ulZH?=
 =?us-ascii?Q?HIAXsVAdaNgjGW+pU1ZyKr/qTveBW2NZfYBpBXL3cbAP7bZx1rJfnFfO4xkK?=
 =?us-ascii?Q?wthl6k8DGobJiNYPaq2fFDV3YHkoAMw1C8rkADQkcTGnZOlUdj9XJwGwlNxl?=
 =?us-ascii?Q?SiOsbeM0A6k+zb2nKbDoy4GtHjIQK3guV5nmcolCVaADN3Tm+r7Z/0SqsmM8?=
 =?us-ascii?Q?7uZPjfvVPdo9bSjyEH7dcEfAtmVJbUqVti0TLfo3zo8vzMgCDcf47dyZgjV8?=
 =?us-ascii?Q?f98fCTo2E3EjI8fHMGiVTc0ZkQFf958ktSF5CtKrV+RwWeaHuJVnq52S24/r?=
 =?us-ascii?Q?TvKDmjOsrdFysc/YEfQRu/70f1cNrWqp+btxTAI9tVgnN6HHqtSWCC6dJ9pU?=
 =?us-ascii?Q?X7jcPC+HBTSYHQ1THSROSZWIF2bOVnubCp1RaY0fMQt3hLumnCR2nw7RMBYk?=
 =?us-ascii?Q?VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jT6a2XjCBnDJ4Hyn6pwScx8zOjKh0vePvYtMTuoAEGIBxCMeA96iMGWQLzw1?=
 =?us-ascii?Q?jtLQrccTdoDEHSi88gRMKKn0uBvYQl1x3XnTip9pRmk+F4gCtAKdT8Mp9lhQ?=
 =?us-ascii?Q?WHlv/kZbTXBFnBAl3q47JmKF0uLY800XpTsTUZtsi+H12icnCVCziG9gFyCd?=
 =?us-ascii?Q?Z5FSRcM6Cxh1Ict4mvNQ/UUygIXhi0cOwghh3iOPXBsN5SGlDuw0DxI4rzIY?=
 =?us-ascii?Q?lCBZD1r/j8nqb/9etVoJYflvSJZYm4RMcpipNspJ4wV3+nqvQYpKQcrgWg+P?=
 =?us-ascii?Q?yie2JbXJT8mjegBnKwFOrJv+raYaRC6e0G2rb50E8inEZeeJh1o+FebCe5NZ?=
 =?us-ascii?Q?b8q4W1dpN1BKEQN7jrIWb7kWa8gUnj1if1Z5TMdGTRwATPnvNNnaZ9mVLyZg?=
 =?us-ascii?Q?kIh+kKhd1p/ZosJoNPohhr5gtTXHTgLDAnBNVB4lvELQYzkjsvognHRumL24?=
 =?us-ascii?Q?Ja8GSJTulYoiKI9oCsycG7EpFZniTeXDJj7D4/okvznaYXYbNkHK5SuDQC/m?=
 =?us-ascii?Q?MP1d+j1k9+1BDA0FAK4PrZKJ/Y+4r0dRI3mIjPbhteERYJfhJm3ndl7cXqgm?=
 =?us-ascii?Q?KwmLNJ5RAJPSKI+li0G16edyX4YmSITRTRu6t76maTqLnDtHTmPmHnB3bMU9?=
 =?us-ascii?Q?rMa4ufpGwY+oDO9dI80EMiHQEIr17xN8IMhzd8QHWaA990jqkH0LFP1ZvpFn?=
 =?us-ascii?Q?JFMfDN47qebxFJwkBnSRsHBRQpQBXHprbchfeCVMVPAkxhPMEo8jG1gLY16D?=
 =?us-ascii?Q?pp7xqEtefiLMCqKYQB4GkpNFhoQnY800UvKzNDg3oUDuvXKB3zp1G9rbwYqp?=
 =?us-ascii?Q?KlSfYX2IM2vNO5FDYLPWcIrR7V3vlSDnm5DbycPZNlP15GdwBwJvCUd5K++6?=
 =?us-ascii?Q?Lc1UM8k1KhnUwDltP1VTbmwZ/YZGSf95OeLOrS5E6BDlSquQpALmBkE6vGN/?=
 =?us-ascii?Q?tA3e9AY3aeEEqnhG0BXNlwT0No1pSCxMQRzMJPxE+v4f4zIFf6Lbixy7hUy6?=
 =?us-ascii?Q?Gj118T/TcBgf3i+v/lXfA4b1PtLEGb0TBULjWJ6KmJnOrNpgPk8dRTa+MJnz?=
 =?us-ascii?Q?cqCyP5CSWFz1s5ZfqKKsFEns/Q0gR4ol8+dANu3xDXSUnMKc9I4M2RuLghUC?=
 =?us-ascii?Q?BnISOqZbv5gQw1twy7tIEIl94UmaEA6ujakmSDZK/yHIqtwIVicFqJez+nRr?=
 =?us-ascii?Q?Q4AbdOfe5DE18Ghy9aOt+fHOuLOcDxqgzVJ5Cig9UsOibTEhAM2YdNaneImt?=
 =?us-ascii?Q?dHAGyPcVFCnFB4Hqk+5CtCWaLGYVuF1QfyT9C6IXlZiEEcwpRKelkee0grms?=
 =?us-ascii?Q?12ZQjM+HW4GixwBDNVUC+WZGaTvNHTMwXqOL2i/mJTCGtbpfGkxNAP+FozY/?=
 =?us-ascii?Q?1hXn56r+Cvqx0Dbuj5waRLo16p3Ye2/R7vhnHwxyrfRCcstX95TCPbnKqqno?=
 =?us-ascii?Q?9xE6dFbr4UCXr9esJado/IApm3fgdvrODrs83d2JIU0q4OdWZMzCKMbJL+D3?=
 =?us-ascii?Q?S3nuEPCR5EhM6JXE3L8PgGFvH5TndylkTV1tFop9DttbeKk1W5KcJPmjNSlY?=
 =?us-ascii?Q?yC3kFiJGI9fpl6+lDcKw3xgOmTEHW9XiIGhu2hHKW7MRJjXItp1Z+RZglxsf?=
 =?us-ascii?Q?44x7pUIEPU1DNqvoYYdPu8Gxavh1imAPOF4iCln84aj+xkna6IdW/W3k5QQD?=
 =?us-ascii?Q?s2kZ/+JEPNyoikz4Zvic8k975xqc/7ogY3fXzQgUes/5Js/S/0zxOOwbv7Gz?=
 =?us-ascii?Q?5SQnarq3DF35PlMJsn+DrHObzSL1MyKJ8WrAjIKzzljJR30pZXvM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e634e5-21e5-446e-a973-08de73a988a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:11.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35Q7jpsmYUULQ+yb54bcyrlgDMMvbn3JfqaADOBloSnaLvwn1l1mN0ypdgOUfDRrXQ1nIXIM6ibxF2YX0qAgRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

Implement .db_vector_count and .db_vector_mask so ntb core/clients can
map doorbell events to per-vector work.

Report vectors as 0..(db_count - 2) (skipping the unused slot) and
return BIT_ULL(db_vector) for the corresponding doorbell bit.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 0018adc35f16..7c76039a79d2 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -414,6 +414,34 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout. Expose only the real doorbell vectors.
+	 */
+	if (ndev->db_count < 1)
+		return 0;
+
+	return ntb_ndev(ntb)->db_count - 1;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count includes one skipped slot in the legacy layout. Valid
+	 * doorbell vectors are therefore [0 .. (db_count - 2)].
+	 */
+	if (db_vector < 0 || db_vector >= ndev->db_count - 1)
+		return 0;
+
+	return BIT_ULL(db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -548,6 +576,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
-- 
2.51.0

