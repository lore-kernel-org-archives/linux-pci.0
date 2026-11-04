Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808767;
	b=pyWhYO2X9l5CA3p/qKS5Xlynx0zhwPvV3NQAUQiCJIDfn7nu+p9l0RCB6Q2C7xcOhaYG
	 GV5MS3U802AFhz/5OFfBwGbzRQKPsFzCDFd8J0ARnuV0eypX7oHqrpwJkrriYqbN2cxjZ
	 dSgFkhTFoY6Qme4r5Tk0Pxvksj4cJWKi7KQS+lY+eGxzOTqPXGFvZmE0PcpK4Gceqrcl7
	 XGQ0tWHXD9W59Tv2IzyrAkJb+ylcn6Lss4iScVMEu3ldpwCOJZ5AehInydT3Wy3pJP8IE
	 wg5FNhBUfIeIXiOWGHIbsyKC0KBtMQGsxu1pgl1e0DkVOVt5Bxs72JdDGmNX5holVeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808767;
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
	bh=ReYN097UAPvz6F0a0WlvEG+kveh/ozGBZc2a7zY4ZM0=;
	b=xBjW4wJ1uJ2rI9V5AYeAnaDWigTRwm5t30czdUDEMveCC4VffrAhzpfclEaOd4ECzP+7
	 719ITNosofijvkUCpAWzcSsMhubW0hRKYpFCah5MMmezvxRitVXJ24oi0edSFklEKBBO+
	 yEXBH2lQoi9CzlzTZwOy4XVP2lCo2N+0SJzJetsk+7k/Co7BYq1rvvdohSQDOdZjwGr+j
	 TRi5vZyLvFqOcqFuTsri+aBFlreXFg0a4OiPCiO1/n8jxj+EnF40vR+ao4ZwyJkBxpVi6
	 yXB4p/Q3u9QbIWZust7ljs9vQvREetvosNdd6keSBZh8tdxEJPcwHhrjfPllAwoyEDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ZW+GplGe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE8606D812;
	Wed,  4 Nov 2026 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FE8606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ZW+GplGe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD01oiIpbcWFo1hyZi5r985FqPhq3wHUW7cnKwokc8YAinJd9aAkBI0pBqwWKz73I4klCiZJB3QMbDqpGqVUpGJbPHbgunRQVQz9A8fH5UkK1kd4O9n4vDubUJ5UQnahd1QVkX8mNmMOM9pIzAOaE8JtxtIdxgMDY3KouNBUEAj+LSPQadabAfVlMiubGmkNbuymZwFe8zDDZJQhIo3OIh0vUOKt8Enm4Rbofcp6hKTZknLIk0GPHJDymswKAO4QR1e/9AU7WEQzAVXYd2V0kUapR5RaZhIOjc6lT341rw83vBgrQnHxi6KDl0uM+bFhOIWnkv/s41RS9/Sq8WNMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReYN097UAPvz6F0a0WlvEG+kveh/ozGBZc2a7zY4ZM0=;
 b=I74Ps8DktWKeJlVfcUz3X4/R5hWEC9Y+HlIXxAWV8ELrTzB5qXUFgcxpykP7WAAItRAUB3UIRDOi+ZQvpUAU2/NMcuHEJcPJFOn2MoadlTg2Xx9wVBErIwrkjG3tNiFkPc8C+XdRwy4dq3B0RZ0TdVqUgFbOMxcHx7Y2ChXuyiwSpFciJzW7zFb+i5E3FFaLTaXJOv0/9GjnjeYjqh87NZLBLLpNn5t4uKbFVxfEXY/kv4Il9T/kS1YIioKK5FNw5Kl4kNtyGap2I2VlPunjeZYYoDXnT15bQq71Mg6UWhtHeUHoKIltktRqioY0v/dPMxMF50RkDYsCJPJjph/A2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReYN097UAPvz6F0a0WlvEG+kveh/ozGBZc2a7zY4ZM0=;
 b=ZW+GplGezY+fY2j/G2trvgdIrC5G5698ejpSeO3REQ/pKfPhn0h49y+pXn9WL4AiPJ5upA7W0jzSzs/CnAEnDzFSWtH6LSVKrX2N8xOpQZxYL2I9d6UlzMhX6HiR1PXhbEMJ4J3xc8ypje+ivBq/qDQYoGzFBJAfxsdk2IFPGUQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:38 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:38 +0000
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
Subject: [PATCH v7 6/7] dmaengine: dw-edma: Dynamically append requests while running
Date: Thu,  5 Nov 2026 01:12:26 +0900
Message-ID: <20261104161227.1742005-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 1806c472-226c-4ee2-4476-08df3a8e721d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026135527099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XXdsOJ10fOw65Tk4t4PisFvb9orNVYqCo9CMWjFFkjumy5tCSDovF2YHFX+DJNxxgRcrpr5klSxN/vBszZDF6S/zS6O7Ox/+yucjuBtbkUjjgDggnvHZ2AJs7AiFY0XRuchoLP/s7GuiZjnWSDoUH2rBY5zxlGh3qtVqFOHDj0vhSYsMflO/65VxqGoJCYj3TBe8tsHvrmVLiK6BzjncE0xnf26b9NUjA7TRi1qhLA1lGlVQ8Ma4C36kjEnoMxa4zHZUsF83WcnpxMS6WPddKIAsiCxh1C7xNBixDdBtVE181b9KS3hThLoZIS/fp+h7r0Q0Av6o1V9WRTTqN+4JQyfYi0JcKSil5HpkfthuSlEe6vlxf0tI3haVCmKhiAUoNwC1Epu+mdwOhYwHw+hIVXOoh2JSDfDcJQZtOpXa1DOn4sxE80ts6q+TtwAGZGP7mu0EQ0JLmDkutG5GPxyTNrCP0S4bPSETXyLD7bHAk18g36Eig1v8hS3auDztg/lMcGuLaL6DRscbf76NYRvvH7wifguCIDsz1CKo6kotgvzz08pioXRlK3IuLbpXQ7Qy8yT6dBIGFK9l3rEwSAXFFZqnHuCdT7OoeOn2bk9l+w76G/QvntjXsdWYlPQapu+7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026135527099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFD392qhQVnyQIEZ7GAcyKj6oR4o9Cpb7uyizG/3whdNSbHKnEUkqXBiXOpe?=
 =?us-ascii?Q?JpiZcRTa9sAtpck2M9rp7Z5p5DAPCtGoq/M+w6rxYDS+ZbAXWMWWF3rGKAif?=
 =?us-ascii?Q?3ijvCmxPR3rl5xdxlVYNd0mD7ZlqUqrtTB0Qgr06CBNhtxkvwq4AGPdVmR+B?=
 =?us-ascii?Q?eMkguuYfVgcpfHKsdPunA+ww7uLOjvCccA94GpZ7kMireMkVjUm+vsygYjP0?=
 =?us-ascii?Q?s4GK/L+X1Qsg1kPALZteNOuPI8Gvfc8mWu14YEbr7LckHls1SqMIuusvZ1XZ?=
 =?us-ascii?Q?ID0HAeQzC6XWY2Y0AnkzPQMCzD5FUQac47+vyyhbcG/45WWK5cG0E9d7lf0s?=
 =?us-ascii?Q?OcP8aPC9nA2YgelHXJod4NkDw46hS7wnNhA+XLgrZXe6FdvDwPKsMz+6B3Tv?=
 =?us-ascii?Q?bbcyWs/2L9S25X8b0iM0C8ZwuFllgqWSkIHzJ6RnEU8azSthgVBXJLdObRf8?=
 =?us-ascii?Q?ziWYmwuCDqIdMU4jOeXkjdkLg+PzZX6D6v7nTXpsTTFRHNH1JC7EKKjngAup?=
 =?us-ascii?Q?ezrhBMkwm57kEgp4HJ+ZpwcbD0cJlo0amryZOh0utYoYdAumbHswcJv+z0zR?=
 =?us-ascii?Q?/RIV63iXkYYyQWpAcvH3IOw8tQh6OxYadUHD+T+odLUodcBkO3lLJBWwJNOW?=
 =?us-ascii?Q?646g9qUl5p9RXDmUa2UHhnWkT9CEt8j/2DL80jzo71DbXKThRsh2jnRFR/Po?=
 =?us-ascii?Q?U7ermhw+hAr5cNa7/sEpXhQKeCrwOIMRboKX+WAEtsIBPhY0J85ol7OmPUJr?=
 =?us-ascii?Q?4+eo9P7QaK6wrMskdWzc2m7pQmDG572HS0YU98WLh3WCBCgi3Ek8khZEjCHF?=
 =?us-ascii?Q?wn0/cRAu562yqQco1Z85KBM/a8Nd0DWJYNRuYH6PnQrq5jR3x/jpa36cNINR?=
 =?us-ascii?Q?dHUkp9GJJaooa/keRHwHgx02VTm1i4sm53GyThECUNg7oElN8ADEpuB+nMRq?=
 =?us-ascii?Q?APU2EF0rcfkoXbPmwc4bQnlXSpBekzwWt4xXe4oAKAOCoxR3aqzkiUnxAhXN?=
 =?us-ascii?Q?wNrQbsLDqN55hwdZw21/fRpzgPGprfLvUFqTMQx379m1+zMXOI80QS8AEOEm?=
 =?us-ascii?Q?3Z7rhJFH8BpepzS+aA8EaCN1mWRVarmN6YykgcIfBsw+SB76xrnWQv+WBiIB?=
 =?us-ascii?Q?6sBEVA59vW8j1eY7UMKSyfCuWxrR1hcDasrBw4w8v/E0FtgRL9gBVdNXhY9c?=
 =?us-ascii?Q?ly8cIb5PQsJjEJz413s4gFTQVltw6DSt7XlLjmSlPFBQ1Dd2AZ9l300jzOYv?=
 =?us-ascii?Q?KqJ8R+U7E4J9J4cn3IpA10DxchE7oWAK2loeMmo5iCBgrR8dJLgW8lMzC3eW?=
 =?us-ascii?Q?iBpS/K1WWgYCxtIM74yiAqJvlzsTZbusv62lAeY8wI1XQgpjEkn7s8iu5FHo?=
 =?us-ascii?Q?fwQRD1nAGnRvm9vqz8C/Aqvx8oF6j5yCqnYksUl1jpvQQs5emNm8KLZR1qZX?=
 =?us-ascii?Q?fouqMBFW3YMlWwP5xtjLOX8yprrwMz9MdNcc6tUOydzBp7BWShn51dny+4hJ?=
 =?us-ascii?Q?K1851/2JDVLrOt4XkXI7KQTXJgMyBiSPKl4UvUfxiNtsBgMfqfk5ertKtjR6?=
 =?us-ascii?Q?FQee537J4T65XpNAJvIo4y/oNiQmVQI7rcgum65kytGyrCJHZTRFNRLP9xp6?=
 =?us-ascii?Q?OEW+tmKXw+ctgEAYTMqyjJ5n6LdwuZrjD65G8ziKMJFmriuzZYlBizt0es6y?=
 =?us-ascii?Q?5JQivK/3/aQYy2eG0X5NX0Ka8mCd9TX0wix8Zma4YEfVg7hJQvvZt5OfM9cy?=
 =?us-ascii?Q?W9q3da4mmaSwfZbZ60Yww2vw93oREZlG12Iu8TVF9O8qysKCNjLd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1806c472-226c-4ee2-4476-08df3a8e721d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:38.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+zqDVjoCdydRv8CN0s1XUBRTy7xAByorY93unrYCknMy2f6oXRG+SVgRThLm7yfpAdgEpf6AGZOpBwQ5e/PyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

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
Changes from v6:
  - Use the common descriptor completion helper when aborting pending
    descriptors during an LL reset (Frank).
  - Polish the commit message a bit.
  - Link to v6: https://lore.kernel.org/r/20261030150742.2586776-5-den@valinux.co.jp/

 drivers/dma/dw-edma/dw-edma-core.c | 65 ++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e2f2a535d5ad..69b5488282de 100644
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
@@ -278,21 +292,34 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
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
@@ -561,7 +588,8 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 		err = -EPERM;
 	} else {
 		chan->status = EDMA_ST_BUSY;
-		if (!dw_edma_start_transfer(chan))
+		if (!dw_edma_start_transfer(chan) &&
+		    (chan->non_ll || !dw_edma_ll_pending(chan)))
 			chan->status = EDMA_ST_IDLE;
 		dw_edma_core_ch_maybe_doorbell(chan);
 	}
@@ -610,11 +638,16 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 
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

