Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943915;
	b=zvj6Z8yJR2L94zjOjavausMBJ7EFT2yuy/VlznWHZucJFpuQleQYBVzrUtMWYos3KGLF
	 pAFFksVlnnMLxTm98IM9XIRa66J0yjEHjYhm2rKIZHuKvMnKZCFSDFNQTNTH+JJ0guSgx
	 N7E8JXf6GuqPDBq7VJJHVKmQfPfOnedJRGAgRx9X3wXFMG0jHyJg18kWTolxs6QIpyZxx
	 yF3O9I3P5ZrJ0QKY3TrV31UwV5eHJmyrB/+NlrDMlRkobClnBVGoFNfb3Z9afRxUYs7v/
	 v6yQT7tFl26iwIHCiMGhV0vr7GEQHcJL/sSGdRg+d1mu5bDkbTsc7CToS2uP3sxsTGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943915;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rCmU80LKbBVhC4ibu/Kzfb/8NW1Hrg0eVgB4SFpougc=;
	b=ztF0revfgPNABUAWhAxsAwtP3UtN41ymS3mDO312zw+WuZ7a4mmvkJr1rP+cpYq+N58r
	 ugG6PzE6Cw0B6Ju8mS6IIQW6Ru9PmwOhMKZ0NqeN7jlctHJL6p3KJOxgrzzWWIvM56U03
	 Qcw65lljatYtgaq66Gr+zUt0BwIqf996VQcqadPdLXUgMjxjBaxxML77a4+8zYLkqMXPj
	 VoGFCVTWv9fyjHAu/rSsZNVUg1tiakvVt9tM5jW+HHzqW7G6JR+45kvc5WHPynhvjK/+S
	 GwXZBV6RYQRFbIipfi90piFo/hGoPoRwUkbOLssBvXV3hKH2yqzgNC5sSGf8wCQtJdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f33AoJz9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.37
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C4606A32F;
	Fri,  6 Nov 2026 05:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8C4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f33AoJz9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnzwHRlqoZzzW7DSZ+7nORiAvMMMo5fJ8wlHoEGrXjWvOEkO1pvib9S59IWPciIDjP323b3xjPN7EBjT31wQLP0V3LhJpEYnrgslFVV86lTMb1baDw3nJ+M6PV9RU/lkLua8r0QWAxV/aanTnMIm2+NzfD0C0Csxf4k+lE+lvSEEsGhus4/2MPI1eOIALNxPY1FkLN+N/4zJl8qo38hmOgcgBlz1tg+I3w5VHqzWCqQtoPUyrv3jVRzGyBP4mtsKad7mLTNAycb7QILi0G0hDVwNjmxtmHMuNOjPFHWZlQOqO+vXjhAryX+PkNbGAEPgVE+jN2ta5E8yrTZc+VJKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCmU80LKbBVhC4ibu/Kzfb/8NW1Hrg0eVgB4SFpougc=;
 b=L/kXQf5k5jo2SwzhTV4usmb6FiCbn7Gid3zVAORG1eBbcqWVoh/21RuvASWajYline3geV4xC7Z+W6iIZcPMMTaWspDv9W/oOrnHeu9YIcaZZrizZcbt7js5u/WNUjyih6YncQY+KVkG8LRUGNvzLH0jVO8rB2+DZwty8IYF0Xk8YQ81N2uHuX9dhAySWce6Hk+7J6DwYBHp1gFzruBAYjXcsU7PDTh+zT4Lccw+KtbXY4VYBryLtK2vflU5mgkzfH6hxplxj/mj/WrshUgDVkrnj6Gfsm5y84cYHxZGGJrGrHjVBEHmarNtcabPo4Pfd9ppGu3wdAY2vNuXOkdRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCmU80LKbBVhC4ibu/Kzfb/8NW1Hrg0eVgB4SFpougc=;
 b=f33AoJz9GAhaEfZbficAqmQxHDHqrl+OyeeNmfT/1LNPgEwVHNOJ6qqxpXfRUFDGKVDXcnFwhbX1BGUEzqe7hlGH++Fz/MvwRCTrfWZsR6Fs1tqIu4ywp8wbgllVPbVpt6jX7ReX6fL9yBK73XMknr+eyVjjEd/YaGbgzPHjs6lzzyygF5tHiJm+2JNq3TGJZK91jWX7WAPlz5LB32z5nT6S1+DLSxeb41Lyta0MtNceYkSZHW6uuVUMs//yVxR0tIYvRi93CNDOK9K3FLuaIcGf21b3wUTWMkvuY8jB7Ezc7xCUxgNHfxkaY0Npo9COcpg/TB4psRkZxhwVfF0tlA==
Received: from PH7PR17CA0034.namprd17.prod.outlook.com (2603:10b6:510:323::12)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:44:14 +0000
Received: from CY4PEPF000392DB.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::9c) by PH7PR17CA0034.outlook.office365.com
 (2603:10b6:510:323::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:44:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DB.mail.protection.outlook.com (10.167.247.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:44:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:43:57 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:43:44 -0800
From: Alok Kumar <alkumar@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v4 13/32] gpu: nova-core: gsp: add synchronous GMC transactions
Date: Fri, 6 Nov 2026 11:09:46 +0530
Message-ID: <124b9805f160d9992974cd4a4b730b275325ca8c.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906667.git.alkumar@nvidia.com>
References: <cover.1793906667.git.alkumar@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DB:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5c61ee-7ac7-4439-b023-08df3bc8fd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|30052699003|7416014|22082099003|18002099003|6133799003|3023799007|10067099003|56012099006|261026140227099003|11063799006|261026121527099003|261028144727099003|261021121427099003|261022113327099003|261022075727099003|261102123227099003|261009223027099003|261021123027099003|261022105027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	ehkQdhh4iBfFKh+qTf1pqzYZ4hvrD+WdrfmbdiA6XRIVMLwFvcDwHSSmhR9RgtVpMnU1Eo/FdUk1VL8D/ON35ZmlfQ1DuM3p7ML7XUaBWGV8OLjk5ihVuZIvxdQfCgGgCIA4EDyfQSMc1FFIQ2RWil3o2oM/aDaSNgILo8MoxEnRlrfYgqExtVpJ6/q9rA6PuT3p3pTTjK/d5IS1j40cE8yCMurmHCGhbR8d5U2pRXwGPOgMT/8QLlx48Z/xy667sNUFMrLRzrgdoddxSh5yhi5W8V5dpdZXBhEyTkw9H/riPZbjxnjo2hGu4xxii8+kC82jfL7P/IREj8xew1FRyifdq2r1BB0FT+jn+wX73ESvXDqQcb12gKdJm+iaHPYK+TNZ4KY5nMIvJGhg14J+W68wjXzuj7Xo6D565ag+tu1lkyzzfVoku25DpZ/et+NJWeseA9wkzOXsSY/QHMsMkAqdrWtgDQsizTklHS1ekCnQKr0aRBf0R+sZVBg1/mOsDCClDaDqwJfHBcR0++TfpjgS5IGEd+7Jn/68L4lKYq+FJKlWLyDKwayYvey8GiYGsL/XgJOlvN/kzPcmfaQ0tjZEsjkpuUTpVLdXmj3lZaKZLkejqs+m9eszXbKRlpcgBTk3vsw/oWtQ13PKPnTg66K/ig66sdhCG2lzr1LgAc9AT3jDRBigFxh4QTlAAq717rM77EHGZAwe+bamRTz8RA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(30052699003)(7416014)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(56012099006)(261026140227099003)(11063799006)(261026121527099003)(261028144727099003)(261021121427099003)(261022113327099003)(261022075727099003)(261102123227099003)(261009223027099003)(261021123027099003)(261022105027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WO++BqJj7jPh5pUGLoactRQiqeGOtXN209c91P136hBrpRhG3EI1JeMjwdq53t9AD+bEuquRMCZSYLH1H+V4njUgBapvADzTEJ7kLGTPBvMqNq4SFu+ouhgr6wWNGaDnFY6dTGcGefdYuG0TPu197kAbve04TQYq7czU/BriFq2XyOyfnz5od6WR1Myaxk/9V7rMk6qsrE0/wD+wmT8sduQCJGgEoLWWU31YHOtyOr6zxEBhCfqeBh6RpJ9/7ASFDLJWBjc4eEjjro3/8E4xypOd2Wmsnbo83MiilDYlxMBg9lPBqF86qCVNAZoHTh7aOehRwxD8v4it7VVy/3FRGI3s1qskqNaKapCGtR+jFCi4fDr8+nbDkmbzohxnOR6THxEC8TieAWA0an6nobBNGQmzEh9Vn79urfVQ7PpIsWW2i9sfmmYcsJ6qOVVK/VrI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:44:14.3393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5c61ee-7ac7-4439-b023-08df3bc8fd98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

From: Zhi Wang <zhiw@nvidia.com>

vGPU management queries need an owned response payload after the receive
queue releases its slot. Sending and receiving must share one queue
guard so another receiver cannot consume the reply.

Match the response flag, command ID and request sequence, then copy the
payload and return the raw firmware status. Support the default receive
timeout and a caller-selected timeout without converting firmware
rejection into a transport error.

Share the receive deadline and retry loop in CmdqInner with the existing
GMC boot response wait. Preserve each caller's matching and status
policy, consume every valid element once even when its callback fails,
and keep a single deadline after sending. Document unmatched-message
consumption and distinguish a zero response payload capacity from a
command that sends no reply.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alok Kumar <alkumar@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 Documentation/gpu/nova/core/interrupts.rst |  19 ++-
 drivers/gpu/nova-core/gsp/cmdq.rs          |  28 +++-
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs      | 162 ++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/fw.rs            |  26 +++-
 4 files changed, 215 insertions(+), 20 deletions(-)

diff --git a/Documentation/gpu/nova/core/interrupts.rst b/Documentation/gpu/nova/core/interrupts.rst
index 3fcc886e22c1..7f61e5d6334e 100644
--- a/Documentation/gpu/nova/core/interrupts.rst
+++ b/Documentation/gpu/nova/core/interrupts.rst
@@ -580,9 +580,12 @@ command reply or an unsolicited event, and the two differ in the function code.
   records, lifecycle notices) need no action and get no line of their own,
   because the receive trace at debug level already records every message's
   arrival with its sequence number, function code, and length.
-* A GMC message carries a command id in place of a function code. Only the
-  ``GSP_INIT`` wait during boot claims GMC messages, so one that arrives
-  anywhere else is logged at warning level and dropped.
+* A GMC message carries a command id in place of a function code. The
+  ``GSP_INIT`` wait and synchronous GMC transactions claim responses with the
+  expected command id and sequence number. These waits consume interleaved RPC
+  messages as events. Unmatched GMC messages are handled by the wait's callback
+  or logged and consumed; a queue drain with no waiting caller logs unclaimed
+  responses and unknown commands at warning level and drops them.
 
 A command's reply must carry the RPC sequence number that nova-core wrote into
 the command, as well as its function code. A message with the awaited function
@@ -602,10 +605,12 @@ element stays at the queue head, and every later receive fails on it with
 The polling path and the IRQ thread both read the queue under the command-queue
 mutex. Replies and events share one queue and one read pointer, so one lock is
 held across the whole drain. A thread waiting for a reply logs each event that
-arrives before the reply and keeps waiting. One deadline of 5 seconds applies to
-the whole wait, rather than a fresh timeout after each message, and the thread
-holds the mutex for the whole wait, so that no other caller consumes the message
-that it waits for.
+arrives before the reply and keeps waiting. One receive deadline applies to
+all messages in the wait. The default timeout is 5 seconds; GMC transactions
+can specify another timeout. For send-and-wait operations the receive deadline
+starts after sending, so it does not bound waiting for the mutex or for
+command-queue space. The thread holds the mutex from sending through receiving,
+so no other caller consumes the message it waits for.
 
 With one lock, a drain waits for an in-flight command's receive to finish or
 time out. For log and error records that delay does not matter.
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 4b25bd58ab93..70de84079d20 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -2,6 +2,7 @@
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 pub(super) mod gmc;
+
 // No RPC command is sent since the switch to the r000 firmware: GSP_INIT and GSP_SUSPEND replaced
 // the RPC commands that the driver used during boot and shutdown. The RPC send and reply paths
 // stay for the commands that later series add, and are built as dead code until then.
@@ -67,6 +68,9 @@
 
 use super::regs;
 
+#[expect(unused_imports)]
+pub(crate) use gmc::GmcResponse;
+
 /// Marker type representing the absence of a reply for a command. Commands using this as their
 /// reply type are sent using [`Cmdq::send_rpc_command_no_wait`].
 pub(crate) struct NoReply;
@@ -722,15 +726,29 @@ fn consume_element<R>(
     /// - Any error returned by `f` with the exception of `ENOMSG`.
     fn await_msg_with<R>(&mut self, f: impl Fn(GspParsedMessage<'_>) -> Result<R>) -> Result<R> {
         let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
+        self.await_msg_with_deadline(deadline, |message| match f(message) {
+            Ok(value) => Ok(Some(value)),
+            Err(ENOMSG) => Ok(None),
+            Err(error) => Err(error),
+        })
+    }
+
+    /// Waits under the queue guard until `f` claims a message, using one receive deadline.
+    ///
+    /// Every valid element is consumed even if `f` fails. Unclaimed messages do not extend the
+    /// deadline. Framing errors stall the queue and are returned without consuming the element.
+    fn await_msg_with_deadline<R>(
+        &mut self,
+        deadline: Instant<Monotonic>,
+        mut f: impl FnMut(GspParsedMessage<'_>) -> Result<Option<R>>,
+    ) -> Result<R> {
         loop {
             let remaining = deadline - Instant::<Monotonic>::now();
             if remaining.is_negative() {
-                break Err(ETIMEDOUT);
+                return Err(ETIMEDOUT);
             }
-            match self.consume_element(remaining, &f)? {
-                Ok(m) => break Ok(m),
-                Err(ENOMSG) => continue,
-                Err(e) => break Err(e),
+            if let Some(value) = self.consume_element(remaining, &mut f)?? {
+                return Ok(value);
             }
         }
     }
diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index f3f4e265f023..392143e534f6 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -6,6 +6,11 @@
 use kernel::{
     device,
     prelude::*,
+    time::{
+        Delta,
+        Instant,
+        Monotonic, //
+    },
     transmute::{
         AsBytes,
         FromBytes, //
@@ -59,8 +64,8 @@ pub(crate) trait CommandToGsp {
     /// reply.
     type Reply;
 
-    /// Largest reply this command accepts, in bytes. Zero for commands that the GSP does not
-    /// answer.
+    /// Response payload capacity in bytes. Zero permits a status-only response; whether the
+    /// command sends a reply is determined by its protocol and [`Self::Reply`].
     const MAX_REPLY_SIZE: u32;
 
     /// Error type returned by [`CommandToGsp::init`].
@@ -249,9 +254,8 @@ pub(crate) fn payload(&self) -> (&'a [u8], &'a [u8]) {
     /// Returns the status code of this message if it is the reply to `command` sent with sequence
     /// number `seq`, `None` otherwise.
     fn is_reply_to(&self, command: GmcCommandId, seq: u32) -> Option<u32> {
-        if matches!(self.header.command().id(), Ok(id) if id == command)
-            && self.header.sequence() == u64::from(seq)
-        {
+        // CAST: `GmcCommandId` is `repr(u32)`, so this cast is lossless.
+        if self.header.is_response_to(command as u32, seq) {
             self.header.status()
         } else {
             None
@@ -295,7 +299,155 @@ pub(super) fn log(&self, dev: &device::Device) {
     }
 }
 
+/// Response from a GMC API command.
+pub(crate) struct GmcResponse {
+    /// Response status (`NV_STATUS` code). Zero means success.
+    #[expect(dead_code)]
+    pub(crate) status: u32,
+    /// Response payload copied out of the message queue.
+    #[expect(dead_code)]
+    pub(crate) payload: KVec<u8>,
+}
+
+/// A byte payload sent with a runtime-selected GMC command ID.
+struct RawGmcCommand<'a> {
+    command_id: u32,
+    payload: &'a [u8],
+    max_response_size: u32,
+}
+
+impl CommandElement for RawGmcCommand<'_> {
+    const NVDM_TYPE: NvdmType = NvdmType::GmcApi;
+
+    fn size(&self) -> usize {
+        size_of::<GmcApiHeader>() + self.payload.len()
+    }
+
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result {
+        let (header, payload_0) = GmcApiHeader::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let init = GmcApiHeader::init_raw(
+            self.command_id,
+            u64::from(seq),
+            self.payload.len(),
+            self.max_response_size,
+        );
+        // SAFETY: `header` is valid and is not touched if initialization fails.
+        unsafe { pin_init::raw_try_init(core::ptr::from_mut(header), init)? };
+        SBufferIter::new_writer([payload_0, &mut dst.contents.1[..]]).write_all(self.payload)?;
+        dev_dbg!(
+            dev,
+            "GSP GMC: send: seq# {}, command={}, length=0x{:x}\n",
+            seq,
+            GmcCommand(self.command_id & 0x00ff_ffff),
+            self.payload.len(),
+        );
+        Ok(())
+    }
+}
+
 impl Cmdq<'_> {
+    /// Sends a GMC API command and waits for its matching response.
+    ///
+    /// Uses [`Self::RECEIVE_TIMEOUT`] as the receive timeout. Firmware rejection is returned in
+    /// [`GmcResponse::status`], not as an error.
+    ///
+    /// See [`Self::send_gmc_and_receive_timeout`] for message consumption and locking behavior.
+    ///
+    /// # Errors
+    ///
+    /// Returns the same errors as [`Self::send_gmc_and_receive_timeout`].
+    #[expect(dead_code)]
+    pub(crate) fn send_gmc_and_receive(
+        &self,
+        command_id: u32,
+        payload: &[u8],
+        max_response_size: u32,
+    ) -> Result<GmcResponse> {
+        self.send_gmc_and_receive_timeout(
+            command_id,
+            payload,
+            max_response_size,
+            Self::RECEIVE_TIMEOUT,
+        )
+    }
+
+    /// Sends a GMC API command and waits up to `timeout` for its matching response.
+    ///
+    /// Matches both the command ID and the request's sequence number. A nonzero firmware status
+    /// is returned in [`GmcResponse::status`]; the caller decides how to handle rejection.
+    /// `max_response_size` advertises the response payload capacity in bytes, so zero still
+    /// permits a status-only response.
+    ///
+    /// Unmatched GMC responses and events are debug-logged and consumed. Interleaved RPC messages
+    /// are logged as events and consumed. The matching response is also consumed if copying its
+    /// payload fails.
+    ///
+    /// The queue stays locked from sending through receiving. One receive deadline starts after
+    /// sending and is not extended by other messages. It does not bound waiting for the mutex or
+    /// for space to send the request.
+    ///
+    /// # Errors
+    ///
+    /// - `EMSGSIZE` if the request exceeds the command queue's maximum element size.
+    /// - `ETIMEDOUT` if space does not become available to send the request, or if the matching
+    ///   response does not arrive before the receive deadline.
+    /// - `EIO` if the command queue slot cannot hold the request headers, the receive queue is
+    ///   stalled by an invalid element, or a received element fails framing validation.
+    /// - `ENOMEM` if the response payload cannot be allocated.
+    ///
+    /// Errors from initializing the request headers are propagated as-is.
+    pub(crate) fn send_gmc_and_receive_timeout(
+        &self,
+        command_id: u32,
+        payload: &[u8],
+        max_response_size: u32,
+        timeout: Delta,
+    ) -> Result<GmcResponse> {
+        let mut inner = self.inner.lock();
+        let expected_sequence = inner.send_command_element(RawGmcCommand {
+            command_id,
+            payload,
+            max_response_size,
+        })?;
+        let dev = inner.dev;
+
+        let deadline = Instant::<Monotonic>::now() + timeout;
+        inner.await_msg_with_deadline(deadline, |message| {
+            let GspParsedMessage::Gmc(message) = message else {
+                message.log(dev);
+                return Ok(None);
+            };
+            let header = message.header();
+            let (payload_0, payload_1) = message.payload();
+            if !header.is_response_to(command_id, expected_sequence) {
+                let kind = if header.command().is_response() {
+                    "response"
+                } else {
+                    "event"
+                };
+                dev_dbg!(
+                    dev,
+                    "GSP GMC: skip {} seq {} cmd {:#x}; want response seq {} cmd {:#x}\n",
+                    kind,
+                    header.sequence(),
+                    GmcCommand::from(header.command()).0,
+                    expected_sequence,
+                    command_id,
+                );
+                return Ok(None);
+            }
+
+            // Each byte slice is at most `isize::MAX` bytes, so their sum fits in `usize`.
+            let mut payload = KVec::with_capacity(payload_0.len() + payload_1.len(), GFP_KERNEL)?;
+            payload.extend_from_slice(payload_0, GFP_KERNEL)?;
+            payload.extend_from_slice(payload_1, GFP_KERNEL)?;
+            Ok(Some(GmcResponse {
+                status: header.status().ok_or(EIO)?,
+                payload,
+            }))
+        })
+    }
+
     /// Sends `command` to the GSP and waits for the reply.
     ///
     /// GMC events that arrive before the reply are passed to `on_event`, and RPC messages are
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index dfe7aafcf31f..c75488e7a787 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -834,8 +834,8 @@ impl GmcApiHeader {
     /// Creates the header of a request for `command`, sent with sequence number `sequence` and
     /// followed by `payload_size` bytes of payload.
     ///
-    /// `max_reply_size` is the largest reply the sender accepts, and zero for a request that
-    /// GSP-RM does not answer.
+    /// `max_reply_size` is the response payload capacity in bytes. Zero permits a status-only
+    /// response; whether GSP-RM sends a reply is determined by the command protocol.
     ///
     /// # Errors
     ///
@@ -845,9 +845,22 @@ pub(crate) fn init(
         sequence: u64,
         payload_size: usize,
         max_reply_size: u32,
+    ) -> impl Init<Self, Error> {
+        // CAST: `GmcCommandId` is `repr(u32)`, so this cast is lossless.
+        Self::init_raw(command as u32, sequence, payload_size, max_reply_size)
+    }
+
+    /// Creates a request header for a runtime command ID, masking off command flags.
+    ///
+    /// Returns `EOVERFLOW` if `payload_size` does not fit its 32-bit field.
+    pub(super) fn init_raw(
+        command: u32,
+        sequence: u64,
+        payload_size: usize,
+        max_reply_size: u32,
     ) -> impl Init<Self, Error> {
         let init_inner = try_init!(bindings::GMCAPI_HEADER {
-            command: GmcCommandWord::zeroed().with_id(command).into(),
+            command: command & 0x00ff_ffff,
             size: payload_size.try_into().map_err(|_| EOVERFLOW)?,
             sequence,
             __bindgen_anon_1: bindings::GMCAPI_HEADER__bindgen_ty_1 {
@@ -863,6 +876,13 @@ pub(crate) fn init(
         })
     }
 
+    /// Matches the response flag, low 24 command-ID bits, and full request sequence number.
+    pub(crate) fn is_response_to(&self, command_id: u32, sequence: u32) -> bool {
+        self.command().is_response()
+            && GmcCommand::from(self.command()).0 == (command_id & 0x00ff_ffff)
+            && self.sequence() == u64::from(sequence)
+    }
+
     /// Returns the `command` word of the header.
     pub(crate) fn command(&self) -> GmcCommandWord {
         GmcCommandWord::from(self.inner.command)
-- 
2.53.0

