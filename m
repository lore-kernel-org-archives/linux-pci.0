Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943872;
	b=HBQqAMINnVk2NgbFzjQD8ToG383HuNeq7u+lPVcgXMmJ3E+FoRQJttycDEmwBMn8DgPS
	 Y4ly4bYSi99gee2DVPfIXqamsF5OHZvSSAtpL5IGU7kdAybdlr0jx8DXbLrGPrTalBp48
	 j6hLvEbmDWiHrlqhvtuOmRXN3lukCP545CBAEB1VnEcBWZJqNtvE6hUjBQ+dESFOn7PQ0
	 fRjgx/4DojfvRbbND4uWn8zcfng8ObeOnq4cdk3OPETcR6w1AE19bkvC61AlA72+G/wn8
	 hNp+955x69ks+qi+4u0nrDVG7Zq2jymg21+55aPId3+G9w7b4ocBpWn1QCM8NqOG5vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943872;
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
	bh=2oexfqJvBlQ2Gq87Q3AJ95M/kddT8qTpZDxWywKsuso=;
	b=HLYFw6MPup5tq/957F8bRz1FCS7vzjFhNXWlKi2pMUkR1i778aY3CwfGFo2K0Zp+2H9Q
	 hTE58oJy7R7LuZZoHMRXFyW4fG3rTDU4Ga8eQchd5TVrVKMoj8mzNoUzu5coaLHIdGdFA
	 q31kVMInsK234Wt3nBiYJf0al57tF0Q/LLp6a9Rf7CpgHJIeDjiQkGFHzQvmmR9teYYlv
	 oTW//5ZSLEtDGHogdfCtOnYS8rjYmUvau5+1E6jF6ue5cKWsw81cOXqg8fBKdA17T4jE3
	 ERnT1yMFCKt8ECN315rs1l9DXZbErUY+Nqgi8MA+/g5nH1I6n8iQQf8ErvMyFRYPLXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VQr023HM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.52
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236E606A326;
	Fri,  6 Nov 2026 05:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8236E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VQr023HM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbKtH59UbnPYWgQrw8tlSEVFc2aYqv+MCXr2fbmu7myW1j6Ycq+sPqpDyebhRjPUXavJWjsdFRGTV/zyiKpeT9qg4vBuEMn7CNbpkDuEvrckx/p0jbpa+/0SsVyMRJL17yv+N2sdslc5lrToncK5Xi0m0ygVtMzYCiHGxgKQGq0hoPzV8t/Y1pe2ti/pd1gnSwmyUJwQlNrE0agQdVK8yXBk8exeyS5+OFOi6KoTRVc5nD//C1i9ByUKbdoEnfLQOJFRbYN14OvyyowzW6hkJzTvbwZJ3sxCT6V5vey3MJXuOfaDjSCj7rBfj2jTpWoIkSF9st7ahDLCb6WBZAsuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oexfqJvBlQ2Gq87Q3AJ95M/kddT8qTpZDxWywKsuso=;
 b=VqSW0N1TBJ7pOpt7YErcvC/DmvbXknzlSAtghMlxVgAYFlSI/78XimQ85v3KcqcSNzZYnYF0PkE+b7jU7znVFdgdKMxovASCqljuwzDwqQ10XuW70HWGTX/79zHdipjZUAFQElegiK8R2shjRHldm2huKViUnnCnVZfCEXLa9ouGy+B13GDSm0RQFFdlWWj5Oo9Fl5MoUZilT8iNYoZ5HfIqp1/fyPLBELZtwG/5BW9f5xT6sGaAYkznfjCZDUfxlPo/tTtTlcD6STeSPXKr/rhX421MJSVorGfBX7tCEnUGo+n/JfO75eJJ5fvtZZyGLlYjNfAbMxAgDjOH/YxlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oexfqJvBlQ2Gq87Q3AJ95M/kddT8qTpZDxWywKsuso=;
 b=VQr023HMEvUI3z1DMvMUVjPK+BUyyfZFFdyV2rIITESc23ClMG0/xkBr3wdWwJrTv9kYHXmSI5rmEbZ5BXL+DNuFvXSGzudBXtVVSptTSeI83b2h7cx22QGhfCc99hokxDAILvO06bplYvxMSWaFi7OXt4t2SREoMRkq2M4eWEBEw47g1NrhfkvltkrsycQBHoQUKh4uJnvlROTGOxeLjFKnG2Iy/CCjMxt+9+eEtX2JJ6q5cOl/+cSXEpU9hF0UvvrabtSBeNoBdOpxNi3wu7JNddC9Es4w/Ps9KXZUWSw4C0PTDhmwJ5fKypAF4GXtGy6HTWwT7UOxHGMh4Vsx+A==
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:44:20 +0000
Received: from DM3PEPF000265C1.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::1a) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:44:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C1.mail.protection.outlook.com (10.167.23.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:44:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:44:09 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:43:57 -0800
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
Subject: [PATCH v4 14/32] gpu: nova-core: gsp: wait for GMC completion events
Date: Fri, 6 Nov 2026 11:09:47 +0530
Message-ID: <8ddb36b189feb56642ed531e5199d3a01e7d7f5e.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C1:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 732dcb90-4ae6-4424-2952-08df3bc900f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|82310400026|376014|36860700016|261026121527099003|56012099006|11063799006|261021121427099003|261102123227099003|261026140227099003|261009223027099003|261021135927099003|261028144727099003|261021123027099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	C/zKVAaXetEp9s30m/+Y47qOa45/eNDzm/7UIlRwCthKSwsoK+NlU3c5Z9uJZp49GxzohBIlOJ2oFO8IwHaMmASeKEg8bZU+HfRQpOsqQpZ9CYhILV4hfDbR40Cv4pkzXfxD1+e2HBRewoImddL75IoFNTGTaLoaJhu+vk7ZSsfY8qIhHhmLTUhTQEGvZ9aNJW9NUI+qvQ35GtRcABWnbt5DrZu2M12YJhfcnkdgD2uwpLAuhOlYSKPtcI25yIl26ipqZP2sS44hIF3bho1cJSRy4mVeF1JJyJPiGoSL2gUDH+vFb7HLBk+cQKiJxgjaH4K3z5N20h/Df9bnyVZBauXD/gL+RffWxMiNFJEh75A5Y/vZjMb2uamPc7p+YMKv6uRLzO3lh7CMOCTkNInMDJw+mN2alYsNQbmWVI8/UL9nJSlBJbxKE6iJSWZwY2FMVNliGidlsvLqFLID982dHruPZhICP/F6yTmFZtg5IILD/Z+ydIVhXt6U1uxetZ2R6TIgEz5KaEGucKbPABPtkisks/aTizUeTHd+tRla16l4AfKsuVkjXRyX15vVooKMfCbodb5wqZSN1M8kLjbc4ju2DyBNQcYnrDiEbCFVSLuAsnR23iT7RtxjKJbfB6VMHyWoqYnIhQ02YqPEmija+K6rQZ0mb/kNOcUtZPbSDiqooahzP+s9k+8k3tzED6IiXoMnFZ2Ylvuv53HyeJ1d6g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(82310400026)(376014)(36860700016)(261026121527099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261026140227099003)(261009223027099003)(261021135927099003)(261028144727099003)(261021123027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uVxHotoR+4aXtXA4nN8HqLxglA08ywVhGYzXBTExKyoboucvZEbpx1p1qmLSh1trgOJYbixSlEGcXH8UKPridmtwnSDCb+anwritDzfsQMViAGHbmBqe86lPXz1ChuO/aMwklzW5SWx/nFG9ArqL+CCI5eLMOnCxfv0FmDLrtighzkLELDc77n/liBvbDRl6eyLoqcpyF/tOgldrozyvygGhw1GsGzMYRBLX36/oI4HZC/te1anp10VPUEhaUnr8RDMjx5ydYYorSZ8xCSpJFz/61OHXHMre/DdSxvawhG55VGLCgND/1dx1tUAUepYqYSwzwexl3H+9+X8sI1WGaQOvmBpf+RdrlWArBoDcWUiG/sbskkmA+6/TFVdoHZRL4FjyQLNLVfaJH6KdRLy1SxXGQxu+n4FtyIshi1vobidC4+fs/Z89Zrru6QjuVVW4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:44:19.9492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732dcb90-4ae6-4424-2952-08df3bc900f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

From: Zhi Wang <zhiw@nvidia.com>

GSP plugin shutdown completes through a separate event carrying the
GFID. Releasing the queue guard after sending would let another receiver
consume that completion.

Keep the guard from sending through the matching event and use the
shared Inner receive deadline. Offer GMC events to the completion
predicate, pass unmatched events to the caller's handler, and consume
interleaved responses and RPC messages. Represent completion with a
value and all continuing cases with None.

Propagate callback errors after consuming the current valid element.
Document callback non-reentrancy and that the receive timeout starts
after sending, excluding mutex acquisition and command-queue space
waits.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alok Kumar <alkumar@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 Documentation/gpu/nova/core/interrupts.rst |  9 +--
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs      | 65 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs            |  9 +++
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/nova/core/interrupts.rst b/Documentation/gpu/nova/core/interrupts.rst
index 7f61e5d6334e..d686d8004aea 100644
--- a/Documentation/gpu/nova/core/interrupts.rst
+++ b/Documentation/gpu/nova/core/interrupts.rst
@@ -582,7 +582,8 @@ command reply or an unsolicited event, and the two differ in the function code.
   arrival with its sequence number, function code, and length.
 * A GMC message carries a command id in place of a function code. The
   ``GSP_INIT`` wait and synchronous GMC transactions claim responses with the
-  expected command id and sequence number. These waits consume interleaved RPC
+  expected command id and sequence number. A GMC completion-event wait uses its
+  caller's predicate to select an event. These waits consume interleaved RPC
   messages as events. Unmatched GMC messages are handled by the wait's callback
   or logged and consumed; a queue drain with no waiting caller logs unclaimed
   responses and unknown commands at warning level and drops them.
@@ -607,9 +608,9 @@ mutex. Replies and events share one queue and one read pointer, so one lock is
 held across the whole drain. A thread waiting for a reply logs each event that
 arrives before the reply and keeps waiting. One receive deadline applies to
 all messages in the wait. The default timeout is 5 seconds; GMC transactions
-can specify another timeout. For send-and-wait operations the receive deadline
-starts after sending, so it does not bound waiting for the mutex or for
-command-queue space. The thread holds the mutex from sending through receiving,
+and completion-event waits can specify another timeout. For send-and-wait
+operations the receive deadline starts after sending, so it does not bound
+waiting for the mutex or for command-queue space. The thread holds the mutex from sending through receiving,
 so no other caller consumes the message it waits for.
 
 With one lock, a drain waits for an in-flight command's receive to finish or
diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index 392143e534f6..c5ae5943c8b8 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -448,6 +448,71 @@ pub(crate) fn send_gmc_and_receive_timeout(
         })
     }
 
+    /// Sends an asynchronous GMC command and waits atomically for its event.
+    ///
+    /// The command queue remains locked from the send through the matching
+    /// event, preventing another transaction from consuming its completion.
+    /// GMC events are passed to `predicate`, then to `handler` if the predicate returns false.
+    /// GMC responses are debug-logged and consumed without invoking either callback. Interleaved
+    /// RPC messages are logged as events and consumed.
+    ///
+    /// One receive deadline starts after sending and is not extended by other messages. It does
+    /// not bound waiting for the mutex or for space to send the request.
+    ///
+    /// Both callbacks run with the queue locked and must not reenter this queue or reset it.
+    /// Their second argument is the raw `max_resp_or_status` word of the event header.
+    ///
+    /// # Errors
+    ///
+    /// - `EMSGSIZE` if the request exceeds the command queue's maximum element size.
+    /// - `ETIMEDOUT` if space does not become available to send the request, or if no event
+    ///   satisfies `predicate` before the receive deadline.
+    /// - `EIO` if the command queue slot cannot hold the request headers, the receive queue is
+    ///   stalled by an invalid element, or a received element fails framing validation.
+    ///
+    /// Errors from initializing the request headers and from either callback are propagated
+    /// as-is. The current valid element is consumed before a callback error is returned.
+    #[expect(dead_code)]
+    pub(crate) fn send_gmc_and_wait_event(
+        &self,
+        command_id: u32,
+        payload: &[u8],
+        timeout: Delta,
+        mut predicate: impl FnMut(u32, u32, u64, &[u8], &[u8]) -> Result<bool>,
+        mut handler: impl FnMut(u32, u32, u64, &[u8], &[u8]) -> Result,
+    ) -> Result {
+        let mut inner = self.inner.lock();
+        inner.send_command_element(RawGmcCommand {
+            command_id,
+            payload,
+            max_response_size: 0,
+        })?;
+        let dev = inner.dev;
+        let deadline = Instant::<Monotonic>::now() + timeout;
+
+        inner.await_msg_with_deadline(deadline, |message| {
+            let GspParsedMessage::Gmc(message) = message else {
+                message.log(dev);
+                return Ok(None);
+            };
+            let header = message.header();
+            let (payload_0, payload_1) = message.payload();
+            if header.command().is_response() {
+                return Ok(None);
+            }
+
+            let command = GmcCommand::from(header.command()).0;
+            let max_resp_or_status = header.raw_status_word();
+            let sequence = header.sequence();
+            if predicate(command, max_resp_or_status, sequence, payload_0, payload_1)? {
+                return Ok(Some(()));
+            }
+
+            handler(command, max_resp_or_status, sequence, payload_0, payload_1)?;
+            Ok(None)
+        })
+    }
+
     /// Sends `command` to the GSP and waits for the reply.
     ///
     /// GMC events that arrive before the reply are passed to `on_event`, and RPC messages are
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index c75488e7a787..ce4a7c45caf2 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -905,6 +905,15 @@ pub(crate) fn payload_size(&self) -> usize {
         num::u32_as_usize(self.inner.size)
     }
 
+    /// Returns the raw `max_resp_or_status` word carried by a GMC header.
+    ///
+    /// Its meaning for an event is defined by that event's command.
+    pub(crate) fn raw_status_word(&self) -> u32 {
+        // SAFETY: Both union views contain a `u32` at the same offset, so every bit pattern is
+        // valid regardless of whether the header represents a request, response, or event.
+        unsafe { self.inner.__bindgen_anon_1.request.max_response_size }
+    }
+
     /// Returns the `NV_STATUS` carried by a response to a command.
     ///
     /// Returns `Some` with the `NV_STATUS` code if the `response` flag of [`Self::command`] is set;
-- 
2.53.0

