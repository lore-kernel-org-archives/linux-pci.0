Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B23A0B22;
	Tue, 24 Feb 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940116; cv=fail; b=TjlOmGq+0K20SjxTWQNRz15ZA2DhRjhJUAQxvKE5PZAlcnb8BYJ4FzA3A0bHXeOL598jcfb5ySl0CNnxsfYNp6EE3UPbPjuSEZIXTcjjZI5aF5GiNVKD0q9oaGsn2dLgBJVWG9c0p+2pkbfaxJ+A5lyiL5ea3LdVGvk2bsyMAl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940116; c=relaxed/simple;
	bh=rOMXfMAtwox7ZDh1yHvObxHfGCSSEgzMKhwEp/F996c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6YmXZsjUPL4D/s+XTbTRlsscGHaIssTTqFI5dChYDNbMDFkMN1LA9pUeT7LQGofsSqdA1fch3CF46QY7a8Gz8PAQRFEfDn+rqNCQ/g1nw6TNvIxBDQkuHmTqN2CpchzTmgWgkRyOa15T41rszH0W2WXp3srPDdIs3u6+q1shwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FAXTH4dn; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FAXTH4dn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0qtaNemUcuiaGGDOjdSfdedz1JFFvz7gOVZ6sDCsxsTFnLHx/rfKNSPGE5+bIDJAeD/XoqKWpVaptLe31Mb0L6Kv96l7J8FP06SvqLJiIXz7c1dIQ9ehXzsm+NqadXbunYhlEP0USPCGwk7YOcHMBCEaPzlupG5JVuWXnIlkUqIjAVbDf1XbdJDoWks0QXq7fTW4odprOX0szey9AgMw8qvV8iCvRGIZ3XER8IAAbL8Q3cUEbxhtbPRyA4ncKXNk8MH9UymwbqGcHjAaUGv9dOhGkthbzhu9AAw9XZs9R/RY8zbdx4S/rSvhf7b9F/lleeRGqIG3nwHr99VcZmzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/B/0PCRzLNuY59NmcEss2WkkYzPgZazhWMRQCipHTU=;
 b=Zal5PlItfM9f+nVuedHiSFOJWbtRaK3+4c0gIYprIxbQ/uFdBKW3IioFYU7kDLiru7TgwPUhezt2qucbKdzMuMA3sFY1y0p5OSLV1lHSw1aMFnq98LywV4WJvVPu8WKY5V0reDdZ6jhxySl65mEvmuu0y5d5gzsKuyL7/jqVSATqInHPYceFcmERPM5MxaM0yTm+NyDe1iHkALFMPBGg2PgKMJp5iPyHfIOV+tFYWPRHB2BNSqxIyF/alYJi4stKPPPyul6awpvY0yKZXJKHdxZclJU+LpNPcGWPgyNI2XEF1TFGx5lOKeqwr9a9f72Ol+MTmMTlPgPLMuLL86vZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/B/0PCRzLNuY59NmcEss2WkkYzPgZazhWMRQCipHTU=;
 b=FAXTH4dnUlsk62W/ozpa9floaidvAnu3vrCL+TFXTm3hjr/UDR8TXezb2reFpwrS1iYdhrxj7tSdB2P5kblWVwiKqloIf3VvzNyMoZSjA3PE7IgBV1dF2XJ4Q/fkM58PVPyvcSRpYPGqttF0qV7mgboEzq1vt+ebh7/V6D554a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:09 +0000
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
Subject: [PATCH 08/10] NTB: epf: Report 0-based doorbell vector via ntb_db_event()
Date: Tue, 24 Feb 2026 22:34:57 +0900
Message-ID: <20260224133459.1741537-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:405:379::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: c9220632-3bcc-4232-eea6-08de73a987ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emIU8CUp+bM4h32g3Wo82WBwjfkVzxysNhvlmcBBs5gYOBitk9cDjQMEpcoO?=
 =?us-ascii?Q?lj/B1x2UqRqwFAK1BaY07PuPaY4T8SPzdh/DIXwjxawqnppLfPW0qwYjIDV3?=
 =?us-ascii?Q?yLobX2uFQcK7AlfScIxDeQ/sfWTchTBbSsC8e4DJ2PGUUBukFk+H4LPnmdNm?=
 =?us-ascii?Q?q/DP5SydQojIiQOGkmb6FTmRAZQvnv8YklqR75rcdG3VUpvbIEMPapfW6gcx?=
 =?us-ascii?Q?VgKV2J+yWAET6KbfB9DY4+K+hg8vtprmDCq/x8E+A+Il0QPxO6BliPlnTEcZ?=
 =?us-ascii?Q?lex3UPEThs6eb0iBamOoBVaGS1WBJ5mI50f1S9v5DLK+G0cQt2V4IfDbWCb0?=
 =?us-ascii?Q?uTjCSxTgoZ/tYDeh4MQwvrKACxz1S3yJKuj5lHf7ZTGXh57GIquuJUIla2Fb?=
 =?us-ascii?Q?vrwe7FQ2E+whsjqvZOB1BLR9raRzjNg7b/QnFcEDH/OFKBMCQ4dAPrYpgIr1?=
 =?us-ascii?Q?5jqQSoDUZmMfOPoUbti7/YHTP2hRPKecyk5zDDmn+/CZjgR8H+tA2aeK78f5?=
 =?us-ascii?Q?cHwf0hnaH0e9Ue64bqhXUyDwmwHzhE44HvfiPdVpNxLuf1ykh1zC0pmFwf4R?=
 =?us-ascii?Q?OoOqKjpgeneqqUwAyIykMWhmPMQXnkq1R/uzZqLjL+Ipezl7NBDhiu7G3d5s?=
 =?us-ascii?Q?XR+9hvN40x2K25mTxQ1mDOnaookHAQwVGSf7nQ4QM+GuvyX66bx8DxsBoudA?=
 =?us-ascii?Q?g58CxFHlINmK8wKATKFiMrkD82ecHC1XzZj0WD6/xWHVnfygsfwfl3f1dW9m?=
 =?us-ascii?Q?4pXnykUh/W8pS04+s8mJ414e2fhWrcpBEZfkzmYjlGJkkivyEaIreXDoRUdN?=
 =?us-ascii?Q?P7/qGt2LyjWg/F0HDk2aBbVZ+Lzc1cW3UZq2iLAduNin2L/4vfI0PhimZHi2?=
 =?us-ascii?Q?hTmM02z1poudykFb9B/wZd2RsXkFWvtsvoemLmcN5zZNOMBVQvSGtkU8Fpxe?=
 =?us-ascii?Q?1xSH63syvFbau8POskzc3dxuZjMsvL8J1iOz9YkZ6yj1nigsyMlh6OaDoHZi?=
 =?us-ascii?Q?hPJAeaHaoXE2G0tB0XwxVI/LxCKB7OTu5uqkq9F2dQOwP4Vrob3LjSxfPSoU?=
 =?us-ascii?Q?Yt1vdR8ccbpEFEibL/H48fpQiJ3D0t4Baj7vhP0MpOA9BIJfVwZcB0zWsGAV?=
 =?us-ascii?Q?0sPaYtZBDu9KOy1g83EY1g4PvkwQUecRHRwE9QJGs4tcbPT7NlItis4N0Ew8?=
 =?us-ascii?Q?H60EInRph/BmmA76mibzsEX4ZuGykE39kQvCIVTTBBB5FuuloN2OBWYsNcZU?=
 =?us-ascii?Q?vbIqAkxSzDTvSQeljfkCJQB3sSU+G6Hlg7JKTO/gQPVUaNDDdnFQAq6xgmEn?=
 =?us-ascii?Q?+NTzMxjpuZ6OmPbYXlevZaEpzzp3chT21t0hWzuyEWx1MjzoDxBEkCLTL4Hw?=
 =?us-ascii?Q?QTBKh4uuTO19DXFCzSYa1FMJ51XlvoBLIeSNH68lY0mlOgchkhcjvocDFMkW?=
 =?us-ascii?Q?sVHp07FGdRF0ITeAmJYCEKhm4G76A9NJK/F1mMSiokiLTJazVqu9FKrjfV1h?=
 =?us-ascii?Q?M8SLx9zhg/3DpHUBV+gi1+gdZ+CCj7GzmSV8V3dRAc541q8AMJNj/xbbnHOM?=
 =?us-ascii?Q?PeJRoNv+sGzHwzv/rt9S7YIU+CH9Ks3O5VodugEQJGvXOum59ifoCZb2VR9M?=
 =?us-ascii?Q?Jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ys4R5XmA3m6gIrRQzpd9rNg3oSPx2Sg0mOhpWPlzgKNmTksa1GofEk/bt9Cn?=
 =?us-ascii?Q?G0cMx+UeJ/+wl1+9A/7KPdEYsP2yqwzEUcwHzLM8nicnT4kW8EhBHHtAsK0V?=
 =?us-ascii?Q?cvb7U5tVOTvvVHgFM6fWmceKtEzHIo534EJJeVMRqG80YRXbCl/5mtbE/Mqi?=
 =?us-ascii?Q?KIq324HYW7B4oZJnArQZKAqQ/OIPkPikPLcmtSwZ4oGo/RBuYmT7ut6S+Md7?=
 =?us-ascii?Q?K0DCEmjm7VqTt8OxTNeVGdZhvivXckPkAm/vqnyQG3UObjuIuon1cbVdjEm0?=
 =?us-ascii?Q?3mXss/btcgJd/3/3CbqjxwwOvnVsmFMpp6/kIRMgW7vMh3f0rm87INwD9lIr?=
 =?us-ascii?Q?dNS+B93l0+u7o6FlF0O8ybtShz89GpkEuDhm7eE7rl7xJ/64rl1bQ07tUl67?=
 =?us-ascii?Q?/SwX+YqyZB8yMAm223y3rqt++yReTuSQOPZB/cWGrNWYDze22laPu8m9ohve?=
 =?us-ascii?Q?JiTSxdWuGf910RKYyEGRxFB6mi/lx8hkhTchHUY7WGch16uDTYpzqorzWRHq?=
 =?us-ascii?Q?0mQZFyz2jkC8nBmVw2RXVDvg1j9Aa6oozGH3z3bUq13ZNyZ6D5hGj5OHDyiN?=
 =?us-ascii?Q?pqeDSlrx1gYby2nAVrFqdWEF+oxT++S2Tj6zf7Qi6LMS+/3RTo7NR33hmD68?=
 =?us-ascii?Q?oWvVNkcSW9C3DrscIhVosA9+eh+TqBoA6K+CUbVEj85G4GtDvzh8FMpwa6gY?=
 =?us-ascii?Q?eBhUC7Bv+bsG53N4hgfrheOQFUgC9OJx7hRhqo/HJ1vSQdm4AOPlwyTu46jc?=
 =?us-ascii?Q?2Ml8OxN2yGgHck05gTHmkzCP4zhE1LPYPpioXGXzwweRy8APrZWHhvFgbUdz?=
 =?us-ascii?Q?LmSG7itkJluOw0FGDprOonMYa+MrpefUISn7xcc5q8T/Ych01F1eZuIAkzdd?=
 =?us-ascii?Q?C8KVLnfyZlJPSjOHnXYHIyaodtFHOLJaK4PL6ISNWqPrfXMBLlJViXKVWzyJ?=
 =?us-ascii?Q?NeNJoVR9ALYqPrhmjTOx7paauRxUsZdWJnC0JWWh8IRGWP39Ob8dLc/ziUzN?=
 =?us-ascii?Q?eHYlysxyylbcFzSsMUHjPEZRjxxE9fV7VUhVIADW5ogXPt7KGAyv7TY6cF7C?=
 =?us-ascii?Q?3sK3ZmUGEgpNzOJ61zjzaaqLjF2VEhr1tMp/5BXRiPvLaGgDK3mpIyxvOROs?=
 =?us-ascii?Q?OK6iVlED4iubCdy/RjoFhdiMbJNUZ7Te0jhpS538ihIzvjQ0dEavm6dk1Olu?=
 =?us-ascii?Q?tELQJAOv1ntG9wfxjsWuxmyV6Ms0obBXJYwoMkpAkR2D1dMvt5X4kS3GJCKC?=
 =?us-ascii?Q?CgYn1G9k3jVvUTKiidgvpG9hbkW6OeLA0mtAd7ElwpO1bKnKbJfI5u9vAEYw?=
 =?us-ascii?Q?CfAzVlR/MDZvzJxZRh5QRMXMdk0tGDHPI1NebLSHNVmzv/qoeEuPmWyw7wAx?=
 =?us-ascii?Q?5MyVyFPN5BourPB/L9iyvXE2UmZ4igZWsEpWWbSgu02z2e4FkqUI9U1Pm5CU?=
 =?us-ascii?Q?Cb5ufMcj0CLU2vmzMl6npNQ9LxZ1c9a/nM82EbFB7wXRzfPILXJj5ttrfXhN?=
 =?us-ascii?Q?0VnakZHloL6YMGAM3fayI1xvNaRfkuonyDOzWIrMdtiOR5j9z36/6Ag5py5o?=
 =?us-ascii?Q?+M+J11cGbTBPdFDmOYjjPh1+ST203GNmnSGHt5EqQbI7o4X+qp4ccjbFL4nB?=
 =?us-ascii?Q?9EWKFGZX4PotLZB/Kp589ZETKwzSAd+5Xa+fXOnmReuwJy+wVZ5DXWBYBYST?=
 =?us-ascii?Q?L8bp3UO4SYIRRQaaDLmom6YVbhAStvccs6lD/qCTnGsTbFUVFyEz3HCLoF2O?=
 =?us-ascii?Q?rNZRcR2o4iXcGLP7nOVl9EqMQ/2ORuK/niw09M+uhUdDvwNOGddb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c9220632-3bcc-4232-eea6-08de73a987ad
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:09.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pocnjN6ALXzkrLvswR2pfcGFpJDf6Y6bvLcGhzsM1rEdXdg6cNQL9nWRiXtta49XR5nlmG+KG5shpxHL3UoRwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

Vector 0 is reserved for link events in the EPF driver, so doorbells
start at vector 1. However, both supported peers (ntb_hw_epf with
pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
started doorbells at vector 2.

Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
If irq_no == 1 is ever observed, treat it as DB#0 and emit a warning, as
this would indicate an unexpected change in the slot layout.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index ee499eaed4f3..00956ab2fbf5 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -333,10 +333,15 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
 	ndev->db_val = irq_no + 1;
 
-	if (irq_no == 0)
+	if (irq_no == 0) {
 		ntb_link_event(&ndev->ntb);
-	else
-		ntb_db_event(&ndev->ntb, irq_no);
+	} else if (irq_no == 1) {
+		dev_warn_ratelimited(ndev->dev,
+				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
+		ntb_db_event(&ndev->ntb, 0);
+	} else {
+		ntb_db_event(&ndev->ntb, irq_no - 2);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.51.0

