Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1B386C36;
	Thu, 28 May 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957149; cv=fail; b=F9i3gciamoMf5kBcXjEcF7S545tnGagiqgDhjc3oNwP4vXGx5k3ikWMkltGYe40m87Kgc++nM6tt/hpM8dUqpnR2kU6Rr71TokLT5cexX0PvYcGH/AYMwlOELKSZiUsL4s5MQi4vahU4KoUoqlCaOlc7Jlq9gYgc9cVixoplZ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957149; c=relaxed/simple;
	bh=k7dnzyqnbjb4EhmF9QDZ1LYbH35pP5JQWKYSDDQKhrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czaS2lmXSfI44BqOpsp4g9561WtUk2TUEijg7ttlGohZrQrzRh625VsWUPiuRFwERhO2JT/Tx5H942iAm6qz3HyEoY1ZTa6Fuu7Tu+bwvHfEHT+spDxndSh3+AYXt5cpVvBdyS/InvWNw02TPxJM5I90SwTC8Ts0BLTqTNxAOg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0/Vd6i9; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0/Vd6i9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3qxYsFmj3KJDaMFZmPJ8bnYGirwyHELK5fLSvSTIQclPW8xjHP4Kglx4qcf9u92OKv9Xgw2EQ41+vG372Txxo8YIyxxEF7HuB2BwPRr+KH+WRxzdAAqpcfbROzqvhxMgGufNMFa1feG2QntOEOVGvBshzcCC3xmyVcuS1ejum5l3p2MlZCZymDr3Fvjd/XEYw333AjjlHLlHg0Bcp7JYYBs5BYsZ8yDn7efdv8P3vZ2kEDGbzq1hxLcY8tF4DBXgkajMnL4YIpytWzTImaCZhRueSJd+X0qm5Ezh+UfOrlntk0u2upoWfKIjBD7lkKJecTv0OX7phVpcQFBatn+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdJMEiXQh+7Mm9hjyY4lPhzVWxuKJV9CJ2m0WkCq/ys=;
 b=pzECV/Pjgg/IrMtAztDaNcEr9ZOPGmqf+Luvu16MBSWfor3+LMIxwc42SehnPLnvisliR5huBZRL+3upcR81yxrK6W1k3qYUCvzKSwuhq6yLnUZIThz9dxUtzVpJzBZUvqNPgLGLyj3twRZGQwW0CszRTDBkI+jYYUssYBcd3Mqe99KdNNfcwPHjarng445L/Dq1GGCI4v3Vje3z3J+0Uea7udh4HeN92Z+aKPq9VqFfxGUDnMD9Yf2HAv0ZhDOA1L+bezF5nQlbm7UhCJmBddVz0C4ocbp9OxmLhJ14jHe/Js0MDrIxlASbuYIu4S+8ZoxT6tn11JXeZ92T8a+O5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdJMEiXQh+7Mm9hjyY4lPhzVWxuKJV9CJ2m0WkCq/ys=;
 b=L0/Vd6i9DJIXQ+sC223YCgt6cUiumtZu9BFpIIUBZx8+vGD6bxQm8ubxrkbqBsX1BYQhmXIl/OivTGTnmWW4sBIYF1p4cThpIxhpRjjOc5gCi1vFeAoEFi5Y/mOZIfgLUrAb6c/wHvhqnseecCLe/tfxESXjQDu7s9Gk7nSgKoMRJWIy/OKVbjv3jpvmSMt7wLp2AdhwNIumCXTJpLb2jpAoORsYvAy8aZXFRWw4WlJDWoG5lf8giWB8auZJHNXkdBwnD0iZiUNSMWHCaH/3VJktZo3ldabR3yEhUk9Ex9XfjOACFNcHdWC+ZrgA4LB3nZa8UVnIs7/3eq5C9+sjzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:20 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:20 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v6 9/9] Documentation/ABI: Document CXL memdev cxl_reset
Date: Thu, 28 May 2026 08:31:54 +0000
Message-ID: <20260528083154.137979-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 18628973-fe0c-4728-9269-08debc93a28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	R9CleqvWbTUwTgi+8OuYcri8xaWD+gCrqAT21ZGPLz8MpzS7mjrLpmxb0KFx88ZkNwXDEHZL+1hYSH1egc0kQYPszOOl/lFaQ0VEemJ4yNwzMl1CaOUMqJfue5IDTLNgYL46i2gXQ1EnTHgnc7ZJiBMul/wU7JTNI/r43lhDnIsfzeEp+4oilxBIHeQVRk3Gv4GpDjKtywYL3+RlCBqFuof+kuwzlwfBp2jSsSAPj4qQoPmbBDE+rH/2ekAcBkt5+cYUKW7q8pxoQk+j4b+rFL/D6fiMkFmyXtnbJGQjloquqrntBEC7hZiHzZeHMm3fmXgVvPLm9SKXKnC9W2pDldZMjPLnllYAF43shWFCw7HZdZfd58J9vsGDUhL9dABmRZp6O/l2mGt231nrLyE5P20mKraiJHXc5Wc9M1fJA82/VpnZ7k+Mg//NOmTONEvIvaEfi0cZQhfvRNigr2RL+9YtRV2oqBdf7iuwxZDZr2k5N56TNrxt7FP3wpf6k2IoO4kPEGbtoE19tU4DZF4hYVvJjqERxoBh6T4BGPVRbczQHvENrpQb3XDS3v94zuxJVoQ4GjpHO+YSdUGvyf/qKIuYoeAjy+Opw1VuyRYx4ZlzEnB1atT8tfg1f8J8Wo+xj5X9K+/uSLJ+PpSuegUS+UcDIxGJsqOZQwqUjojOZOIanHr2tZCTz2EEyOmssGyw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BjF8oR6ARjtXPS7iJkUIv2TirYNyEV8Qke2iVN1r2S2TBJXS79tiXXq1nIcN?=
 =?us-ascii?Q?hUNS1iWGgFjz8kCBX0mNn/pF5vyy5RxmOnySEvdX2geRD90aPXb/QmWTMONR?=
 =?us-ascii?Q?apKH0JOKSCla33/FBNFkQlZg812l8Pda/MvvwwP9ySj+EVSgNhzLFcHBtIwM?=
 =?us-ascii?Q?StaFQh0jAXLogZX1VYrO3UyRiZ8MUr6PIAk0+dzQJuNCG+/RpmSWOOIdWM7k?=
 =?us-ascii?Q?EF80WrZ4kzgL5lNZIrs821djRvyKrgxx9kLFcGr5LE6MduVDW9doIgaoQ0Sk?=
 =?us-ascii?Q?jnrb838I6fi9F+kjqPsWcXIP1aCme7w7djp50Gy+PHRaxzQNXx/EDTHQ9EZN?=
 =?us-ascii?Q?+MjmjJg8kYDDZ1Ko5KH60L23ntCRLbii+fyGqj8ewOedPYY+2TiRITvCelgU?=
 =?us-ascii?Q?Vh0U0vD+ZQ8vfqBgsy59hCnh7ZQzOGMXWfGU16Kx77x25BJ7HUN0aBqgLmMH?=
 =?us-ascii?Q?FM68+8zrSZT6vO9qyY2gzS4uh6UWEQofo8Wcn6IYKywQ9wPrCXzWFjOy4w7I?=
 =?us-ascii?Q?XsZziB2lIny4TqOMrlFb4qJP741K3B+oe4LQw17dKnvAEyLaOKtOEl7trlVQ?=
 =?us-ascii?Q?ghR0FgcjzmxEVHOTHBASZBq5i9dvsLzvOcQw2u1RV3KaAoYbbufpVvLQlRay?=
 =?us-ascii?Q?+LB9ZFr1qPbPW67qnbxV5mHk4TiY1TT8ATo+r5TB4MGc8n/OjOJs1QkTSGmn?=
 =?us-ascii?Q?UjeRocO94h+EAAs8NBJRWRg8QIU/p+xB7nLiiPW19/2PkRukymdHSRrI58Ie?=
 =?us-ascii?Q?jjIeWk5Fq/X7UzRp8ZWvbscc4vmwe1ncFdIAdkQDvG+oRmz+pHcn6KNOjSRY?=
 =?us-ascii?Q?JEGJGCfoWcJ6SVrh99bzJYW1sMYvS0M3DJJXcLvO5BabHcrbcfa6Jr9mzXm7?=
 =?us-ascii?Q?s/2AuM+X9KrGUQzFAx6NWUKrjUPBTBCt+qOnKII5m/ZLmQu2GVlR1BSx1XOK?=
 =?us-ascii?Q?Zjm9Ymg7LNfZGTMlBSE/kOdOpYwjuJ2oKBF5FQQ+0JMjVL037A7WQmjNimBh?=
 =?us-ascii?Q?XwJ6DEtWbUb+4JE3geRJ0SFtx3F14W/9OSXUO+Ce16d1NEl4dj8zJK4y0E7W?=
 =?us-ascii?Q?1MDmqJPG0xBQLerUPpWj34pvK397fSkqecyO6s8c90NfkNHxAyfDd7aO9IbC?=
 =?us-ascii?Q?dzbmvuW8/RqbMWHY6vNTshX3yWLYtEcVXsdsmc4wsUQJzxeCMW9XAFJSJwpQ?=
 =?us-ascii?Q?b6WN73/MobY7X683vxo3IE4D8DOnbHH1oB1aZmSjt0ZgV0IzV7wSHVz7aSY8?=
 =?us-ascii?Q?g0p+/EJ7c7pngIcVOW5H5XmBUtXKLxrz9TrU12QQRwkUAPa1bBrCq5odyQFD?=
 =?us-ascii?Q?UEABDRnWPb2UShYxs2kiSibEEr9Kfmg8ezWqnSyG3p9nFLliywrGgEsh388X?=
 =?us-ascii?Q?U9JLv6CRiEYdwxBEqqEBMw/wAXxk6BibnXKh2jj7NNd6TENlqC7BxGZbUneV?=
 =?us-ascii?Q?Z6V46kPuI2/CW/YG0++CnXQ4p8fYGPtOLr3PK4UFIbm/EZWC98nu3lvIoEgG?=
 =?us-ascii?Q?ObVD/D5WKa3UjvbG4JiAzhWysWVnqRqb/DZcEJFTz07TmJp9YUgzV4eLjDL1?=
 =?us-ascii?Q?5cJw5QZt8OHtfeC4qhlruDwbW7QUcHaH8eviI3FuyaxrKC+vDdUuvIaByDC+?=
 =?us-ascii?Q?yEma3lbrBH+4Go4Z+uDEx+HpYIMIuoaU4fbQN/SYfctVIV0aD8tSqSk78eHu?=
 =?us-ascii?Q?2rOuaQ7lSKe5TB1q7mmhrV/d/m166N7TtrNbRPt7jyN8KjSWMG8eGf96iV2d?=
 =?us-ascii?Q?SH++MC5/mg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18628973-fe0c-4728-9269-08debc93a28c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:20.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mOCmDIn68MC2YBztnS2MotpmJwaEJS/TN3UpgCHEMg9Rd2UAgpqMINZGNNpYKXdZ1zFv8P6zt/vT/QF+zYp9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Document the write-only cxl_reset attribute under CXL memdev devices.
The attribute is visible only when the memdev's PCI parent advertises
CXL Reset capability, and writing a true boolean value requests the CXL
reset flow.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..d5d055e7a756 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -110,6 +110,34 @@ Description:
 		affinity for this device.
 
 
+What:		/sys/bus/cxl/devices/memX/cxl_reset
+Date:		May, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a boolean true value, for example "1" or "true", to
+		request CXL Reset for this memory device. The driver performs
+		CXL-specific reset coordination for the target memdev before
+		issuing reset, including any required preparation for affected
+		CXL memory regions and related CXL memory devices.
+
+		CXL Reset control is Function 0 scoped. A write to this
+		attribute resets the CXL.cache and CXL.mem state for all
+		CXL.cache or CXL.mem functions in the same CXL device reset
+		scope, not only the memX device associated with this file.
+
+		The optional CXL Reset Memory Clear operation is not exposed by
+		this attribute.
+
+		A reset fails with -EBUSY if any affected CXL region is
+		online as System RAM or has an active region driver bound.
+		Userspace must first quiesce and release affected CXL memory
+		mappings.
+
+		If this file is not present, then CXL Reset is not supported
+		for the device.
+
+
 What:		/sys/bus/cxl/devices/memX/security/state
 Date:		June, 2023
 KernelVersion:	v6.5
-- 
2.43.0

