Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150041;
	b=b/VaXYYkgZmgivd/B46bfDmRCaYLsmafwP57UcgI/kT+5qFEeEqB2f7a5GRJka+pmHJX
	 AHI0JrDdRlUp+rlnRS4cTahqZpLvCTt5YDuTS9UT0BnFKcVxdID2pFAyEbGxApAkERiir
	 dDm6UyEfqL7JMT+Nzehd4+ysAdrzWXjCX+zDLhId9yrPlEM3Jrc6Dawf8CsvtrHF8NIDj
	 bHxppeh5qb207U57qWa3h3Zm/EuoyuRwzi1pnqfPv4U20FXlZIh2ds+bQzXXUlQdK9Qx0
	 kQWZYTDOvq5ZriKkNjjsoRBDskpFXKV4NHn+efVylBZ2ITNkPEPFag2rQvLdIxlELnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150041;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:X-NVConfidentiality:
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
	bh=OdRhMS6wq4ijM/gHaDk6J2muYT4y490sp8unpVN0Yuw=;
	b=ZbLQBomalj/+QB0nRsCRlv08Ec0vvkMfU/Y78YVOpL9KVWO56QTrgPaVmP+gAFfAbZbS
	 5GpMyUrN4Laln+Sdc/59XJHK7i5mox9D4nlT0ZW2W1eVWTFVdbZK1xN9CTy1k1GSS1qha
	 zSiA84SATp29m0itDNEqhE6ldWY48nKFjdF0CMbpQeE+HobNwB67g0wW1qsuLo8jHI4BO
	 VSQuPE8X+qBbQTL1sJkBSSFZ2qEH8FHOpOGvT/rxx+0nXhvPspFIgHCFfX4JvJpJOw3Bg
	 wfzkwexVoYlzQJqeZoe7GNq5fEnjSjJ7TWo/lIPlEH7j3YCDbSGbzOz1F1g6z1w3ajg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bi9LIYzb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.7
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BED60A3826;
	Fri, 20 Nov 2026 04:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BED60A3826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bi9LIYzb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HISuWuaFvppIdBv4wBqDEnMthlIf0QJ4nju1xh6oNVsSBhdNBc8tmaGWUSSqaYJuqtcwWtOM1L9Pylm2sKqX+3E/6TXEc3UiOyPvsRtM9VilsKg79MPGySTA2YfdLh/erNLleKZoVYdVDE4BztIhH3CYaMfuq8I7k8B0NQxf8uYwJ4i9cT554+OUOSQFKSWjnnavMAZlDUwCO4mdsV6fjUgaoZoWTwk7LwuVsUBxJ4L50yQKsCvAt13BnLfNYTepj6LSCqjCSoOxdJFT9HnW3kynIxQGFRRAaWA/84La6kX8BS14zr9B451Gkh84Sk+c3ioHM5WlALJAoDcwy42qNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdRhMS6wq4ijM/gHaDk6J2muYT4y490sp8unpVN0Yuw=;
 b=P+IsDrIYOM5JXAETAct+OPdZfx3A1hpLj127EBmfDiwoPktj/ggkD0FwwVfevA7/Fjrm6c/W1mxVSZ13Q2HS51/IuFcv0rw1kxthLqmY1j8d4GvIROPq8jgn+X+ksRkz7nGoepnrXsIDe0bSt5bjrM3ANeUGibCGfJev6JY1TnGT7JHFp7E/rHnE2SWMC/9xzhnjG0Z5RFOVa1yIE3j5o8vfHru+5svbjwWK+LRGZp6FTJqdnGVvP58zlQoRAeDOPg7ZFrvh2DLQJMrKvMhEXy8nuEEyk7j+03Z4KHuxVSkw8N/2Ad0iJmw7UcokJDODg/5HviVinSKQDHbQ9DKuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdRhMS6wq4ijM/gHaDk6J2muYT4y490sp8unpVN0Yuw=;
 b=Bi9LIYzbynXMo62sxMhpkxQr3AAM1IBRNAsD3a7zVzYWrcAJTwP4ZenmfNKppiWbMJY/nmKxWN9KeuK7trKWyQZexcCYMKgcZhEaOi27YdF/73lbUCg4czZA5C4cXYDgqg/2kj1FoBC3q1iLZVmJ7IoWQN49bdcWAvHLfv6yzzM41CLe36TICHtNMh0KcJNeH3E48Rmp73eJvb2d3W0qhHfKapC91IIA+8Qw1XX873n/D+MmJKxGEoxDJypfWU+FMNhGRKH1ppj5Ptd1ahNCWWLJUqPAY1FVxRWA3nxa4OVk+n9elzLB0m1mkphkMKCz6GmoK3GdFp62bGEsVQCCjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:18 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:18 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 9/9] gpu: nova-core: gsp: add the load-and-execute event dispatcher
Date: Thu, 19 Nov 2026 20:47:04 -0800
Message-ID: <20261120044704.165223-10-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|LV0PR12MB297887:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d019e31-aac0-45e1-eb3f-08df46c15af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|11063799006|56012099006|261009221227099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	bM/WrSKYmdLZ87EiGACq2whc2GKO3yACp3h2kbMQpVY+9pgvmFE+mIhX2Q1TL1TxjXX4oS/pdihFxCW96ZrCcreUHyn1aRsWN+SJoqIYYFdCcullwuU5q1mUQJVUhgqI9H/yGOUOoPz9n4aEqt2O47Rqtg0F+1kLQbR3w/5MfHytRkTXYDnPGUEzn/SMYunuYLy5AgcnGobH6cai9t63l+KWSrb+hV6WofTEqsc3PoBP4kEE7GjSpG5BaUU3WDAAdtJbVYabmK/MMbRSRJVcMI2DJh4M59L57VmJNAY2E0LapvF9z0IvfcEtJUdm05mYpzwVMlrOry4s57ztFEPstM3PgRr1aZQo2RPmr+Hl+LlCmfQLgI7FB76I6tkYbIexEFs+ZS58zkxAd/4smy0H7RY3CklXxHgZm7DaW6TD1S8K6c6yzpCLU6vXvtyltl1eYLo0hq0iHg0S11unWHbKntoUT9KrqWDdoYXc0z0YWVKJlsCW5U0CL0+x9h/UY4vse+gw5/0nyIg209uKAiHXJb7Iq6WESOULV77DQjKyNACailVAb7+uFYLesdUgZkWW4snmJNevKCXWZfPaYj1NF8olzHVC7pmsPsa8Dc/lsjsVds/IwxXuQUMGTWQpV2Mfs6Nl/sTy91DPWRvxGUqQmjdwIq++DppERFdQ9yzZsP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nXkCtuHGfa9MBgtLNjEb1QZbT6F3Viq29RRdz2Esn6GsQzyHn85z713CvSN1?=
 =?us-ascii?Q?PnBKRnS4l7+YAWP9CeOOA2CexLrahOH+u1tuZcNhMAiromVk4l1GKObR1bus?=
 =?us-ascii?Q?VqTlAzN8niWZMpD3n/TBPRM9XMIMN5WFCizWcDlcAV9MmHEKVg/v0GMwgY1O?=
 =?us-ascii?Q?P5qBmfqK+x5jQyrb0YUbl6E9Jbtx58W5rU2kk67OU5dyXG13W+jHqa3Ts879?=
 =?us-ascii?Q?ZLr0S5Mwv7p7Fn+aYiKGTHaul+ZZIBb+/zH9opQOMu+a1rqrcmROjHY+paE8?=
 =?us-ascii?Q?GkY/tx07AszWjP5OfJiZIJb/GeCUxtWAgFs+RI89fZ+lBx25JYBQ/bxee9iS?=
 =?us-ascii?Q?DnVS6De+rvzO+toKE/hQHrvc/+pWuNUm72ltWOomyYJMHOBQnkzD08qeIuPY?=
 =?us-ascii?Q?6yA6tL1ahis83BMDMoVQgZOkq/eH474f/QmukXg9wiXncxxaCCbpivlUgRN/?=
 =?us-ascii?Q?pRyie0KIQZH/uNGHCMwx46DhXsxxFRBK/i3a5FJHxB5Lg5AavoQfJhqQ0a9j?=
 =?us-ascii?Q?yhFMxdXbLXnFRTFLE0cKxJMVTv5+A50WLEUXSVVAtVT5SU4ybCYP/VRZc+gQ?=
 =?us-ascii?Q?u+/eCEvX95QyxZsc9O2VIB1Z4z9amSeANXVCc0nDby2d8Z6WDX/6YseSUAlM?=
 =?us-ascii?Q?rB7gJnMze5bq5NJWj414kC67w4/ucNuI7SQWFKMdcmP+u0HMya9eGMIKEZk3?=
 =?us-ascii?Q?kPBNpQ4kaPwW6e3XpPqZcBgewP3HZd1YbxEiF0zyhiLb7aAIIw27ExQRJ8GM?=
 =?us-ascii?Q?vyfpr03IGm3v//Vz+WVqD2+A/kTWed5GP3R8kRw25LBpXamav89PsukoB22p?=
 =?us-ascii?Q?vSjafnkL+trL0eEhfhN/6p0dXGUneupHeQItfHoh7h6pmixtUg0qVgRX4Vmc?=
 =?us-ascii?Q?KGjzWaVJqeDWjdjZpiYgTsm+ZOY90l0yc6gJ4vPH7MHKmdDIatRLHp9GLLQR?=
 =?us-ascii?Q?Q20BoFgKyf3Dk+PQjt0myznewjiwUbHvssHnHTCjU4vXzdnw6qDaRI3US/Pe?=
 =?us-ascii?Q?7pCLZzJQJhpX83T6g/+plwA0+GhDcWk6ktl08V4en5k2a54IeN20/M96X7Hj?=
 =?us-ascii?Q?TMVdnmul7GefNPBofLR5VSkUorsxQDgQ2/oMQ5YeZ4xB+8fyaCkwxb7vah2K?=
 =?us-ascii?Q?PhYvdlxKQ9uiQPG6TKIGvhnivw0Gz+tgZaoNc8BaY2+ObygosqP7F143cLyx?=
 =?us-ascii?Q?JEe6Qq6eEcmJtTdf1o1zzoFdXNVjAGQVWO2yHaT5uGR41U1y/RxqnhLPH/f8?=
 =?us-ascii?Q?rnQDrpO/QBrb3xzrM+lbulhhgVwF7jXmzadS1vbH3yhU2lOy8lRYQt5fIrw/?=
 =?us-ascii?Q?54pujDarH4QCRtANb9xn1uJH4hD2Ip6ft5Mz+zhyncXuZRtMENnhlRjRXuYM?=
 =?us-ascii?Q?tN7K1snrLcgYS9v9eSGMY7bh4nGDsrhu4ZZZR6VGF2DmOH+gG5PepCSA9oZn?=
 =?us-ascii?Q?tp0uNx8W+SRU0RNRfyggPheA2IV1opw9lUP7LuBNfPqaUDwLtWmonsVMQgCA?=
 =?us-ascii?Q?Cpcf4JNYEgrB+QU0i4YDI+v7K2n/q8EkG3SJdumHFoUlK9evdU91vE7dIvYU?=
 =?us-ascii?Q?mJsvjnPAFc0Jd2K7kCqAZ8chEZSEXAfb1/6f7nalGCantHHqmeKYG3jhQS6A?=
 =?us-ascii?Q?rYKg1QmKydV8TGfq59LSepy/asRnM0373OVRqXqAFdk3d104IdsVMez/sBrt?=
 =?us-ascii?Q?cm9Osu+eVx8YlJe52Ji/eaz9ky4H344Jlg6kUdPCaHDIMRLhvjTCNQVDa9Ou?=
 =?us-ascii?Q?OoffCfqGqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d019e31-aac0-45e1-eb3f-08df46c15af1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:17.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mcsmf+PAevDHlUMSLzWfMp0bGRcOfLgcTV8sK+B8dalJ6tzN/4REnqc4fzMokFO3vD9WglLwO1sUbq5GcEReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

The two load-and-execute events of the r000 boot protocol arrive as GMC
events, and the command ID of a GMC event names its kind. Nova-core has
a handler for each of the two events, and no code that selects the
handler from the command ID.

Add a dispatcher that selects the handler from the command ID of a GMC
event, decodes the payload of the event into the parameters of that
handler, and rejects an event with any other command ID.

Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/gsp/load_exec.rs | 64 ++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/load_exec.rs b/drivers/gpu/nova-core/gsp/load_exec.rs
index ab0c2959d3e8..5fef09f16185 100644
--- a/drivers/gpu/nova-core/gsp/load_exec.rs
+++ b/drivers/gpu/nova-core/gsp/load_exec.rs
@@ -38,7 +38,11 @@
         GenericBootloader, //
     },
     gsp::{
-        cmdq::gmc::MessageFromGsp,
+        cmdq::gmc::{
+            GmcMessage,
+            MessageFromGsp, //
+        },
+        fw::GmcCommandId,
         GspBootContext, //
     },
     sbuffer::SBufferIter, //
@@ -116,6 +120,62 @@ pub(super) fn resume_gsp_rm(
     Ok(())
 }
 
+/// Runs the handler of the load-and-execute event `event`.
+///
+/// The command ID of `event` selects the handler, and the payload of `event` holds the parameters
+/// of that handler. `bootloader` is the generic falcon bootloader, which the handler of a
+/// `GMCAPI_CMD_EXEC_GENERIC_BOOTLOADER` event requires. Each handler ends in [`resume_gsp_rm`],
+/// which receives `libos_dma_address` and `bootloader_app_version`.
+///
+/// # Errors
+///
+/// - `EINVAL` if the command ID of `event` is not that of a load-and-execute event, or if the
+///   payload of `event` is shorter than the parameters of the handler.
+///
+/// Errors from the handlers are propagated as-is.
+#[expect(dead_code)]
+pub(super) fn handle_event(
+    ctx: &GspBootContext<'_, '_>,
+    bootloader: Option<&GenericBootloader>,
+    libos_dma_address: DmaAddress,
+    bootloader_app_version: u32,
+    event: &GmcMessage<'_>,
+) -> Result {
+    let dev = ctx.dev();
+    let command = event.header().command();
+    let (slice_1, slice_2) = event.payload();
+    let mut payload = SBufferIter::new_reader([slice_1, slice_2]);
+
+    let (id, result) = match command.id() {
+        Ok(id @ GmcCommandId::ExecGenericBootloader) => (
+            id,
+            GenericBootloaderParams::read(&mut payload).and_then(|params| {
+                handle_generic_bootloader(
+                    ctx,
+                    bootloader,
+                    libos_dma_address,
+                    bootloader_app_version,
+                    &params,
+                )
+            }),
+        ),
+        Ok(id @ GmcCommandId::ExecHsBinary) => (
+            id,
+            HsBinaryParams::read(&mut payload).and_then(|params| {
+                handle_hs_binary(ctx, libos_dma_address, bootloader_app_version, &params)
+            }),
+        ),
+        _ => {
+            dev_err!(dev, "Not a load-and-execute event: {:?}\n", command);
+            return Err(EINVAL);
+        }
+    };
+
+    result.inspect_err(|e| {
+        dev_err!(dev, "Load-and-execute event {:?} failed: {:?}\n", id, e);
+    })
+}
+
 /// Waits until GSP-RM has suspended the RISC-V core, and then resets the GSP falcon.
 fn reset_gsp_falcon_after_suspend(dev: &device::Device, gsp_falcon: &Falcon<'_, Gsp>) -> Result {
     gsp_falcon.wait_for_processor_suspend().inspect_err(|_| {
@@ -159,7 +219,6 @@ fn reset_gsp_falcon_after_suspend(dev: &device::Device, gsp_falcon: &Falcon<'_,
 ///
 /// Errors from the reset of the GSP falcon, the DMA transfers and the resume of GSP-RM are
 /// propagated as-is.
-#[expect(dead_code)]
 fn handle_hs_binary(
     ctx: &GspBootContext<'_, '_>,
     libos_dma_address: DmaAddress,
@@ -260,7 +319,6 @@ fn handle_hs_binary(
 ///
 /// Errors from the reset of the GSP falcon, the run of the bootloader and the resume of GSP-RM
 /// are propagated as-is.
-#[expect(dead_code)]
 fn handle_generic_bootloader(
     ctx: &GspBootContext<'_, '_>,
     bootloader: Option<&GenericBootloader>,
-- 
2.56.1

