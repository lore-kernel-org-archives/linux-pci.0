Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058238;
	b=nsY8N2i9k8W2KEljqOWI9Sow2nJTq3TNfi1raGX5q7w+l+S9qrF3c24GDRoR8FEvHbms
	 LWTtc1YrqxODINnOXIgUICxHJJBOjUz+xxWAQwlfhxbbCSOc8YCqZSLEjJn3F8O+SpnvD
	 JzKsMjT5lqFMbABmJBF+juUubQjL48c9bnIqGk5fDILxmBDNoLpPUUgxC8XCJGIweOTys
	 ETjBhmsn1HDZP5dSUl7W8UmN2ts6UfdIQQIxcYHl6cOJCZmaNgB0mZgkmB8FIxRul5nNf
	 QrAEd7/pL+7cz+S74uL36B3BYwzYETvY/dRaUP+JyB5OfMpNNW+A6BKQ6f21SWSRMCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058238;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lsIWURykGDbFOdOK0ZIvdkml8eD7J5C7LVGAP9QLGC4=;
	b=pi6NEeSOVnlKIWQ8VH0igao6BUuCZzfoTdgcaO7JV5zMtIgcThdxKA+cP7GoYLuuYL9c
	 EciNFKcw2VG4JjQ2H39DtdF9kl+B9T7J1/BgGraRqWDRE9WkLPNyYFfmGKs5krBc/70Cz
	 X1zbPF3SxI66md4oOf+WNBl8o8hIkCXpSOMJEgObBs4qLz9t5GNZuyKcQlN19AXsC7fEO
	 BdjIZCOaWt2Dkvrxw6OFfKZG84E/zMCDpcIvHlF++FRZizxBKEg31OISS1BdvoXtIr/Rd
	 DnEsAdeBvPySyW6D/mH6iBpYJlJmYBaP9AsBo7iy7S6lQglyzI6e7mka5A4IT7qDN+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=H4TDq3HY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.89
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C87606A333;
	Sat,  7 Nov 2026 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C87606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=H4TDq3HY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQI+j++NKRphaFj5JEi2Sx5MfwvITEJzGZE1vFAoiFRN07xJ2bqFP1E/t4UdwWtuHBTtfJNtBbRSKaGhpuBciN9z4UT+y/1AQ8Fkjhc7CilzLfsmSn5byWG66pLEqftvoW2mAE6cjHk4E9tQNibrvsXfqbNVfY8A1YijFOvWv3hzGUFf4tPtSbN0vmyMIatDn336eJ8oXfONrwBEbM8M9avLLhiwR1MgUGjujP1oMgEM9nU+ycwao6QwwguNZu1ucWZhcMkw3s5xY50NLSHVM3Iv5Tp8RZtzQnG9DeN3tWRHSaSjcT1sjHZ6h8+Re69iTeuFEDpa4wdb4ybJDg8VSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsIWURykGDbFOdOK0ZIvdkml8eD7J5C7LVGAP9QLGC4=;
 b=chxTutP0x6TBWUDNujJUxmbNXwn/7he6IgMlmkAw6C0CRD1FmbNImtY/MxfilUc96tFRvEhhI5Ks8ySPqqfwOkOnqmvix+tkX0AYItLnBXLZR2/q1XqOHnCbMVM56BPyG5gyCwno51ku2AUFQT/4K5CfW/K8hV3mNungjr6wBG29BMI5bdvQqYBSUabD1aZHXFnywnVW2TzKMqEvKXb4Z8dhcU6NfvjJ0jIDTzlqKxALposR4+88u36sBBcj5XAlQEBU3XrgNnl/bf2PJow21y0nrtxhHtnZk7fCd48Y3svtuLkj4e4U0TtB5F239FqozZTatNFrLfItXyJt3bzZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsIWURykGDbFOdOK0ZIvdkml8eD7J5C7LVGAP9QLGC4=;
 b=H4TDq3HYjWbZI0FDLSvTvRIWz9lhfUBA3Xhn2OE6MpM+jp6/9zgKEVSCO+REU4LseDbA6AfLkPNEt/NYs3PHa1JF60a80C+LCsLrqpHDhOgokoJPn9ij2lPsbIO/WyP6u3gR5Deu0rp6uk4JB3e25+Of0FlcAOYWB6aR+8RBoyQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 6/7] dmaengine: dw-edma: Dynamically append requests while running
Date: Sat,  7 Nov 2026 22:30:26 +0900
Message-ID: <20261107133027.364237-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0370.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad271de-0899-42d7-491e-08df3cd34da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	LgXDQCIM7NCIqu4siFNZDil9ZVU/9c5PT4WpI02yQTWl1A2MMhP79/4dxh7j863wELNYEEI9DOJ0ca+hPQHVrKyGubzHzwZe1WthfJzyaTHYo+Jk8zufNv6kAjFTslWOrw2Nx0i7zFXfRh4/s+m2d4G4eZ9hY/Q2qtfJ7QsQ1Gt3HYKrMfHezi0coucPDPeTEPHLkF01XjBiz0azZCCm3ZBvEywsqhyaeWVelN+T05rWbJqZHykxjsizqeCCmCf1slr9Rqx0bz59A1T4E5Rlayj2SrXazLoHh5e9k1cXtoxvGsn/X7BQvzc8YHjUAkrV/tH4yRrlCPDAsnl8gSYJjcoIXHgG9lttkgQtuhOqaVydP48NFJrCLPu6sKxJgYwOQqQXKrl+Kg5HE68iX5atPJAkkUeK98B/8xQKtyQZbjCZgMR7ouSdhW7dVZhDZmKn1hZKg4eL2w6ZlCfBsTh1br8hv0aH5dWMWHWqrw33b0ZMe/KPvBCHnT26+9X5hLVSy6KhtlYxCPOGsmELUHPfS0Z/Y6LmJeQrMpL+Niv6wkqmolbVJf7ZkEKe4R9NdPAj9Pc3g2Cimdbi7c1FoVEjrFKFVo8srqx88o1I881EuEuxMQYPmcv06TR7eX90lI37
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLrbxNhVK6qoJTftm6rXdGPwJ97e+buZQKEQiv8eivBFMO3Pm71FmMGVhGLF?=
 =?us-ascii?Q?lg1NUCvlHFNaIlCR7UAUVJcF3ECGUXYVMX4jxcZeuxUAet/Og1Ud7rUjb9X5?=
 =?us-ascii?Q?nYfzUm3POZym+JKmcMDVuLe03vM3wfJoT5uB9wGxa6dxp8NBNNHHZ2YIJ9hN?=
 =?us-ascii?Q?oe8f56EWBmXpLCvJn5RtJZtqUzruoHfsOe1sJfqUWake0xA3ic6/upvGlkkY?=
 =?us-ascii?Q?38UpCzBFfe939UNschMR1hnyyyy+k9Fa37et6rPaFxP6PWuhQk/tb9GYZyUf?=
 =?us-ascii?Q?BHkZ+ElkkdsHAyeZy+AsiLmBCXP2rC69zNsbor8SL9Cy2c+D7tKMywHBI9Qu?=
 =?us-ascii?Q?mW8AN9WvXrFdzdvXxWQvipMDlR7HRCgY0U8mcyDzpSbo6+zjxuUDgp8RP0I7?=
 =?us-ascii?Q?gFsa969vOxmTmv8/oX8RGbqQ0g6qUTMf4DDOP2XVkFKWG0CI4PVWmY9Me6Xc?=
 =?us-ascii?Q?m3NAZjo4VEVQBkdrHG7tILXYdTcugWlGLX0UCwNqtQRm9GC8Rs/U9oBPTs9y?=
 =?us-ascii?Q?A2iooO4M9c6frokpj/p3YSXXdKpxENzwo304GGqKhURBz05xcm8kgeJAL5PF?=
 =?us-ascii?Q?IfGTW1WhePColsQQSeFG+epf2qyhNeGneW9LjvBU/9Jdw8vq11qZeFDdMAUN?=
 =?us-ascii?Q?rb4eQ+6SI2r3DDz8O+7K1lvT9TfYFKOFEMIOdNn3qXcyR4YEKD3ZgqaFa89c?=
 =?us-ascii?Q?+bvEfk1I0gD3kpAS4nIUA5r+BrFFweTH/ZOf66WUd2CdlXzwx3Jpdp+euh16?=
 =?us-ascii?Q?fOpGFfAvrGqaXrT7kEiCqhNcO62st/DwZ67t7W7MnZkMx9Y8rE676Oe2/Ft7?=
 =?us-ascii?Q?VRpmsOCRokBtKJDIlihTnhQuO7zvH5HwFrGCGWqmxVLSda8elkh7cBsPXSCh?=
 =?us-ascii?Q?vyHDW5qQFzj5in9pXu1aW5UtvSpzgzIcjtrHCnzPBE1TRWKQxz+dVEMbElhU?=
 =?us-ascii?Q?9yJj9BV+iRHoVdBjXgQwsFJ08F8rTcReWgpQ4BsC7OGK0SYQK8+UQG4FhDTj?=
 =?us-ascii?Q?iuUPSz+pnyEJ4u4XPcdENAW4LiWg+JYJl/xHAbqCEbk6ZjtMQNdkFuo6KUfo?=
 =?us-ascii?Q?hQEw5mPWlbSe/CN+PTgJu8bG8QxlGm4Dy3IlH0naxO4EEyWjdpyNw3zgumiP?=
 =?us-ascii?Q?wQ7XALgUrbfKyOql9Wrp1M8ij0mlrY90pAmIi4TDWoQAUFXfJcx6cb6XYe7E?=
 =?us-ascii?Q?4Rj2F/UfPHMYGNhSxZR5YyQzjWVcnj3NSVGPq1wfoqIZRPpg6yew/W4FC/us?=
 =?us-ascii?Q?/2mNHwpZT/D1VTH36cL8tejvE0YTgv0MhKLidnoVT5VfZ2dhkBWh3SufjcVU?=
 =?us-ascii?Q?gzFERDYfFsDPFof1Yc2JkgPScvn7zmIsS8D0i/pcmzjNU/m4XbsRXHfHP9qZ?=
 =?us-ascii?Q?Jz+z5ogjJzREmgzvrv4LIDoDSp2Vs8g8u45Uk7/33g1DFrjeXExJ+8YU8C4K?=
 =?us-ascii?Q?ZABeqWLeR9DSvW3W3buI6F9fxwEuDDne1cnI6Z2st2JRptjUeoWPL98UmOJR?=
 =?us-ascii?Q?Cw125Z2gqlm2A9dUJcYCEJ2WDku8DpviXP/Q5AwKqWcRrG4TqKcitwXLL6wV?=
 =?us-ascii?Q?yqpRj+FucDl4MrorfXmm4wME6KMdy0VI/f7OKtGln3nwBt6Xs4UqTU1Ffc8D?=
 =?us-ascii?Q?Gd4Je+VpDpBbPWmUo5lf0yi1fEeaRD71ckG7LbUjNvXLUxAmKT9eU0nrTgd8?=
 =?us-ascii?Q?gTYGg6+RWEAG/PUEpfOVErqUNZrxuNlMHVSePxvPkKMybgiqdOyoIfWRjHua?=
 =?us-ascii?Q?gjVhNaO3CiDHNQh5897PAnBeJt6oQvnXVZyA3HmDDUAx9pm32DYG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad271de-0899-42d7-491e-08df3cd34da9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:34.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQk9HDzuOrLMSMXiD9+if/DNe9NZEoyHyj0PTz/7M++riMweNMDsIIy0+j13nsRORDDPZE2/DRKkeZrD8f857A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4725

From: Frank Li <Frank.Li@nxp.com>

Allow issue_pending() to fill free LL entries while the channel is busy,
then check progress and restart it if it has stopped. Publish requests
in descriptor order.

Multiple descriptors can now have entries in the LL ring. When resetting
the ring after an abort, mark the other descriptors with pending entries
as aborted too, so they cannot be replayed.

Since dw_edma_start_transfer() can now return zero with LL entries still
pending, keep such channels BUSY on resume.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - No changes. The premature completion Sashiko reported on v7 is fixed in
    patches 2 and 4.
    https://lore.kernel.org/r/rtfjvblptmdez2znjgx7t4v5fumj6wabp2ft6zmnsm353nsves@vow63wcrnpol/

 drivers/dma/dw-edma/dw-edma-core.c | 65 ++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1d13a25663ef..bcf4fca34591 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -111,8 +111,22 @@ static void dw_edma_complete_vdesc(struct virt_dma_desc *vd,
 
 static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 {
+	struct virt_dma_desc *vd, *tmp;
 	u32 i;
 
+	/*
+	 * We cannot tell which pending entries completed before the reset.
+	 * Abort their descriptors to avoid repeating a transfer.
+	 */
+	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
+		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
+
+		if (desc->start_burst == desc->done_burst)
+			continue;
+
+		dw_edma_complete_vdesc(vd, DMA_TRANS_ABORTED);
+	}
+
 	chan->ll_head = 0;
 	chan->ll_done = 0;
 	/* Drop stale CB bits before reusing the circular LL ring. */
@@ -301,21 +315,34 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
+	int ret = 0;
 
-	vd = vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	if (chan->non_ll) {
+		vd = vchan_next_desc(&chan->vc);
+		if (!vd)
+			return 0;
 
-	desc = vd2dw_edma_desc(vd);
-	if (!desc)
-		return 0;
+		dw_edma_core_start(vd2dw_edma_desc(vd));
+		return 1;
+	}
 
-	if (!chan->non_ll && !chan->ll_valid)
-		dw_edma_core_reset_ll(chan);
+	list_for_each_entry(vd, &chan->vc.desc_issued, node) {
+		if (!dw_edma_core_get_free_num(chan))
+			break;
+
+		desc = vd2dw_edma_desc(vd);
+		/* Fully published descriptors may still be in flight. */
+		if (desc->start_burst == desc->nburst)
+			continue;
 
-	dw_edma_core_start(desc);
+		if (!chan->ll_valid)
+			dw_edma_core_reset_ll(chan);
 
-	return 1;
+		dw_edma_core_start(desc);
+		ret = 1;
+	}
+
+	return ret;
 }
 
 static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
@@ -593,7 +620,8 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 		err = -EPERM;
 	} else {
 		chan->status = EDMA_ST_BUSY;
-		if (!dw_edma_start_transfer(chan))
+		if (!dw_edma_start_transfer(chan) &&
+		    (chan->non_ll || !dw_edma_ll_pending(chan)))
 			chan->status = EDMA_ST_IDLE;
 		dw_edma_core_ch_maybe_doorbell(chan);
 	}
@@ -642,11 +670,16 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (chan->configured && vchan_issue_pending(&chan->vc) &&
-	    chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
-		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
-		dw_edma_core_ch_maybe_doorbell(chan);
+	    chan->request == EDMA_REQ_NONE) {
+		if (chan->status == EDMA_ST_IDLE) {
+			chan->status = EDMA_ST_BUSY;
+			dw_edma_start_transfer(chan);
+			dw_edma_core_ch_maybe_doorbell(chan);
+		} else if (!chan->non_ll &&
+			   chan->status == EDMA_ST_BUSY) {
+			dw_edma_start_transfer(chan);
+			dw_edma_ll_advance(chan, false);
+		}
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
-- 
2.54.0

