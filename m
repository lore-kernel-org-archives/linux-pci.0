Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119873;
	b=Mk7jE6szagmsW7+dA7OzwABa0FTU9/quyX0dt7U8xUs0WqDVVLVJezvk9eEvBoQtfNYO
	 mZxUlZHKf4g7P3wXUiMvxSg3lVR63Uep3/0PXWxPLh+cRAi0OIMTVck3cwNQ+XWoFsMRT
	 8J07IpGRW0ohXZwyDwY9EPeoBCldgahAA7HCJwEky0J9Bcz/phYNsOAj6D3w6BUMRkJ6g
	 PNMOulcs0DmMJHr6teP63oL1RLcrwSkgOjZhxOxnzDJeUfWMeWz6Q7LXXKe49R9bxPZDL
	 hXXaebM6OJrGfuSZ3BurAK5gGX8jiKkNHBnJ/IotQzuAIXWF0dWIcS3AGXwiRtLX5nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119873;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UNWiJ2aGWDUZBX9sPugj/3Xn6YKRojwJ4kAs0eNLFBc=;
	b=bToNmURzLnFDvVazhGIJ8tBnsmZi3CdUYtT6dmFs1JTKDD51j9nWn8VfWdHtIn2757Dp
	 raebqP4pQjH7aqjb7P2j04Ap0KjqxpvMBV/xfCCH0NeLVmfiwvWei2iIo2YY/6Tx5RCqF
	 6BWS3+E4AJo/MwWGKjmRnSa2xheN78wkUbvqTkTnbmaEyYjLqKPKB5PNHINiTz3RZFf/4
	 TkN3ql8Ig+JW7hsi55j1oI3Ug5gVEHTiD9Cn5m2lVXtk4bwDCm/u7Qx2ushYwnqmhksx0
	 YhUAwwUVrKpeeKDda+Z+pg6GDxd2kTLH0ak1+2uOMUDBq8hF6bG7wDY9G/3C8UE8vRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="CtZ/UvKH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.62
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104B606A32C;
	Thu, 19 Nov 2026 20:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A104B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CtZ/UvKH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzscrZxBWVaknp0GflX18QJTRbWZoR9edJC79jQYS471awSn0XGN9+cMgUuB0vihRFCTDB6yqZ+oeAem/j2vm/AkFyMpjUDs7Zaxiid39qgGuFRwAW1ITrHMzhDEVWeGScZnTcPuTyPrEru73WxpWuh6hCP0MJQNKQcHGLO+XE8lgyeyP498aJd2ayQCMg8Dwp8EJyCI92WzEPhzaDk0XoO4Wpe5Y2DTWELx4QDh73Xq79ulpg29xQMKjfMpeqZnnMsa/IJkI/ZfrKTfPV44/54UHp7jY3Ihxk8GhUwb3MmNQLE4xRY+QCi0/T1AAYzzCwQdi9Mw8USt1DpXfxHDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNWiJ2aGWDUZBX9sPugj/3Xn6YKRojwJ4kAs0eNLFBc=;
 b=yOvJ5f+shzIDhzzbbgrUEhfu5tK3HzhKOgEqnoFyHH9Z2gEtzPKyi4u+WNrmb53Oi/pLHVmcirkQCrl+Y6zGZr/SSPhglZsLgZMFa4hFW8rlY3kuAsU7DcCCaxQ4LjXBciyCD0Rnxya+chbRgttjc8b6VoleALqsCQqmAh6uH0QakNt110by3oX6NLlevX+VXV8mcsTFOXcnahNS2U68vP2GSN6GdnGv9+j1VB5zqOWxNTttUuNvyH6VwFWraUB4qX8KCVQqLze7kItHuUpswi7VlW6HkWN0jS7srIxu9xpRj/lYxBS5bhtHhktP70cQvgZ8+hT0jzsK2w7MqCc+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNWiJ2aGWDUZBX9sPugj/3Xn6YKRojwJ4kAs0eNLFBc=;
 b=CtZ/UvKHGifVh6yZcaz4Sr0rrMHQbIMZiw2/MIBE0UybXOdXwc6LFVMQwdb2/Ag1LmQ8GRkOZMBt9EKvzzKHmvJcbC51jZ+XDQxi3qNSoXMv4JRTJZDlll5TFflfKEhsOp4p77+omC7quIUDy4Cj76Ox+9iwU5hpdfHzv0lw8f4=
Received: from DS7PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:3b5::23)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:24:27 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::ac) by DS7PR03CA0048.outlook.office365.com
 (2603:10b6:5:3b5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:24:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:24:27 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:24:25 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 05/44] dmaengine: sdxi: support timeout-aware completion waits
Date: Thu, 19 Nov 2026 14:22:41 -0600
Message-ID: <20261119202321.1734355-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fec0384-0eca-4708-9b67-08df467b1c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|11063799006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102124527099003|261102123227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4ZFrffzfO3vVU4iu0fVhAUIAWJqLJd+7Fcz3fhwQXEN2IuW3HwhkLwjIPqOQLVXjzS+vjYQG8st6hv9Y7TqTSrhEuNQ5byM+Md42WgNLBp7Kz7hsX3wDw2g8bGc87RudSQNIX4Lsa/kf69JSMES8P+vY23k4v+QWrSOkrTYtHC11FIjdAxWQ5mamcs+zCyTqEu2S7ONqjFcIPeqoZKbT+UK8ytibJHdL+99HS2lZ/detrec8nsN39l9fcoDNtawRZ03oXjdWHKIIqVL6cOK/qZlplSwD36kG4eL0OYrn+zbXiAs6TBP57eBj/jBkfwY+13/4+mKSac/ZGC5GOR6PrABOq6NqaBJIjOhtyySjhGwmb+FYGEUOnOFG6IfjmoMazRJM3ZRBoGLA6Wr/jTnp+lIuYv0wJlmW2+RKteSE3KdTZ7IcP3laUME5ykBoAwQHeeY4pPrvYItoOyavFMAQzR9Duh5TdynJVpfZ0+4U963Uchy1F5PL+lNvvcjjuzsCbxJlNT7TlRmFW0uh9YY82OudStbLOzpMmSIyCtHIpHSsBqAb5pCI6HgJX9A+IOtujKI+Jk6FqTsuCl1fKDZJhgJApBuw9dXt5KWPZCfP7xAS/lmUlGSxUnBAnmnVAI0uY3/hIwEiX4L/RIJ4m9yhhFfFnGdBNixcNARf+/dqlVc87VFa9enZb5eGkTBByYbxpM9doGUeOEHbxr7hjJTS4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102124527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d60DiRyRYTzXSm7LrMZJv1R6Os9OYHna1N62IZ9Nj0OpImB7qTOobG5hfZn50grinmE62ErKo/ORWyDSrDla0Asmhy9fLzg305Zwh9EDfl7kp+iM4RSoZ4gzH4RNJLsibZl5r8ArQTIK1nH346diVT8/ELCK07DMEwdQxAryIBI7VAf3lM7W7kaCId8o1O6HWjSEU32Rs7ElN/tvsWHQyaixI91MgU7tl74qegwJNrvBCi/Zvni0Q5Ka/lkzwpeuRoFZ2hBCSffp/liacLMustlPMj2Nzk0CACCEIx4fKhWrnzDMi3SIzuZuvp7mKpDrCRCOEOvDNUiseAg+2SYffiNGeHKzL1wInutKaZC5U3kp8bQt/ZZkzYzxvT3WqK5BasOSufb1dduBbmF7K0sCGFfk4DmOz0Voyyq4Z31EQTRWaPkdmD4ImqcUx3fSXRgH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:24:27.6674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fec0384-0eca-4708-9b67-08df467b1c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

Extend the completion status block API with interruptible and
non-interruptible timeout waits and raw flag access. These extensions
will be used by the descriptor submission code added later. In the
meanhile, keep existing CQ ownership and simple completion mode
unchanged.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/completion.c | 37 ++++++++++++++++++++++++++++-------
 drivers/dma/sdxi/completion.h |  4 ++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
index dacd1cac6303..555a24c31341 100644
--- a/drivers/dma/sdxi/completion.c
+++ b/drivers/dma/sdxi/completion.c
@@ -7,8 +7,10 @@
 #include <kunit/visibility.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -176,14 +178,35 @@ enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst)
 
 int sdxi_cst_blk_poll(const struct sdxi_cst_blk *cst)
 {
+	return sdxi_cst_blk_wait_timeout(cst, USEC_PER_SEC / USEC_PER_MSEC,
+					 false);
+}
+
+int sdxi_cst_blk_wait_timeout(const struct sdxi_cst_blk *cst,
+			      unsigned int timeout_ms, bool interruptible)
+{
+	unsigned long deadline = 0;
 	enum sdxi_completion_state state;
-	int ret;
 
-	ret = read_poll_timeout(sdxi_cst_blk_check, state,
-				state != SDXI_COMPLETION_PENDING,
-				10, USEC_PER_SEC, false, cst);
-	if (ret)
-		return ret;		/* -ETIMEDOUT */
+	if (timeout_ms)
+		deadline = jiffies + msecs_to_jiffies(timeout_ms);
+
+	for (;;) {
+		state = sdxi_cst_blk_check(cst);
+		if (state != SDXI_COMPLETION_PENDING)
+			break;
+		if (interruptible && signal_pending(current))
+			return -ERESTARTSYS;
+		if (timeout_ms && time_after(jiffies, deadline))
+			return -ETIMEDOUT;
+		usleep_range(50, 200);
+	}
 
 	return state == SDXI_COMPLETION_ERROR ? -EIO : 0;
 }
+
+u32 sdxi_cst_blk_flags(const struct sdxi_cst_blk *cst)
+{
+	dma_rmb();
+	return le32_to_cpu(READ_ONCE(cst->flags));
+}
diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
index 18c89701d1d6..9a7a0838bb3d 100644
--- a/drivers/dma/sdxi/completion.h
+++ b/drivers/dma/sdxi/completion.h
@@ -47,6 +47,10 @@ static inline void sdxi_cst_blk_init(struct sdxi_cst_blk *cst)
 }
 
 int __must_check sdxi_cst_blk_poll(const struct sdxi_cst_blk *cst);
+int __must_check sdxi_cst_blk_wait_timeout(const struct sdxi_cst_blk *cst,
+					   unsigned int timeout_ms,
+					   bool interruptible);
 enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst);
+u32 sdxi_cst_blk_flags(const struct sdxi_cst_blk *cst);
 
 #endif /* DMA_SDXI_COMPLETION_H */
-- 
2.56.1

