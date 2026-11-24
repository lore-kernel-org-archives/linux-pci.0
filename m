Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529052;
	b=I7K1S1TCUbDIHqmKg8myokNSpkunNNGkbtIi3/xBOX8xMyV+1d22XRCEefI7M6YLyco4
	 n51koYFwUZMoL4FoorhofuWuIQ+K9+beH9KCoN/ousUA9kgoDfOkVvGnhTKiZXR/hIxdM
	 4jzzFyzO97SymHaCW5YODfZeSzlfK+XgYwSGcaOiba67IPz8gVPLscQerCxi5SAEPrMTx
	 JHv6TfhRUpGoZ/dVaVpCdv7ubH/OzThpg0dPJlegfeQ9aX8PQ1g5S0RLOiDJd5lflz/Ud
	 0isfBZnEbLuN8yPY6sFNhxnK86h9XGp3MAJBgzou20nrLXK4TXagC2AKHHRWILfEUPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529052;
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
	bh=3OUE/diQcSahLty/haDt1zQ4EhD2ic/IojhtmpH94ZQ=;
	b=hpPwqg/qWBwvz0IWPjZbFGr3on4T8tQEqmdux8Qo66LdEpvuX8s5+Zoi3igP33uq4wdA
	 lN9P5WiESRaXZYycDp5Oser4YCwIKxLDbPaetTdpFfI0eFvmJRsx5HI4M1ll+w5GivnRh
	 2fXfAgxldi/DI4WZlSWVz8aYOUZM8eFbTNC2F+TENvyOq5HByLQke8aHObhkIeNbB1ns3
	 zZlhP9+15rxnyU5zLZHnvedTJGCgQKn+bzuqAgyzYxEXAQrsf8qXona1RXyU0iHiwi7L1
	 ecscCWjkRI9X6ybtOS3HZTUXtiYXiqO65wJabO/bJePXHoA32SVOv3QGJQaWmtLjnyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p0L9TtWc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042A60A382F;
	Tue, 24 Nov 2026 14:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E042A60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p0L9TtWc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI9TQ9KvwTW5ntsVHYzmi2FiCl4dN7UJSZP8Gsah02I6Ij39ZS9Y37pAF2Lj3zkqBrtC9n9J+Zh95CiX2XRCLRK+TWzLeAm9YdqhCO/yovKWqRP4f+p7RYF1y95PJ8apiilUA+UNevkpxcu34aMdcJQn5m+axCivRwSwYOMVPm9n6oFKKPlOxcIis5LFwYwm0yXjA/Ez/wtHnbj5Hls4ZWCaKrn9AvVsqOtboBAIsJlqTMp4NZHwWVT7QV6W3gx25YEinBcSeHSHwXHQjfKnBx+pyeM2ERNdqoyFVjA6J4oUxTrWYC69R63qV/JBeykUE8DT45B5ZQgj8lJnrWGItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OUE/diQcSahLty/haDt1zQ4EhD2ic/IojhtmpH94ZQ=;
 b=KCgniTvjhWbJhs9LWN2/r/Aq35wgGb2wKGCeM2hiAXhFmbiNz8dBAJEzU6avO65jWRwDpYrmlEDoaLPMwyEho1VEtOkXj+3WHT7ioMWb2BosSw9tx2IlzceimENGhsgEAmZQBCZpe+C45x2bS2S9UsSzHlnzSwlXwa+TWMHLWnbCO5Oxjpi+EDFm+OfAH9mSRy7+hc01WiuSX9kC/PnaMZqESnghPvxRP02B7tzXHvDz74oTjc60cIB4/EKL/qx64kmhLEPD/6/E0Ehnm+pignKCOoEscFjaSwLrd9PxDXgNyn9QY9AD18cxDGfCcqj1jpiSX+WgO+5imtevYChmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OUE/diQcSahLty/haDt1zQ4EhD2ic/IojhtmpH94ZQ=;
 b=p0L9TtWcsG2m03lTkoIeEzOpL9fdd/fGY4T+ObhjLgronDiw4nf31S0qCKmZWCi6heDuFroIadorHkGHeke4lxl9Ij098ha0yAGIK4wRCA2o5m7sfbOgIJrv7cJIIZHEtZQhRDJ+CdKZuNb3qCjJ7YLKMKPxSGeaAoLjxOTQ5nmTL098/142qiNBZe9CLcMRUvdrfGm/sRdSaRVAdHdk4rBtbJ890AOYxGBN+Icm/eiuutvQEM7CZvsG/+HgffvommHg3u3Co0+dN7f1+s49qXkPZWiiQPToEhQT5fQ2QBJAav2lCezZCLkOewq45yaqhVBr4BXELn103MO5wbIE9w==
Received: from BL1PR13CA0249.namprd13.prod.outlook.com (2603:10b6:208:2ba::14)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 14:04:04 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::4c) by BL1PR13CA0249.outlook.office365.com
 (2603:10b6:208:2ba::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 14:04:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:04:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:03:39 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:03:26 -0800
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
Subject: [PATCH v5 16/35] gpu: nova-core: gsp: cmdq: gmc: add types for variable-length payloads
Date: Tue, 24 Nov 2026 19:29:12 +0530
Message-ID: <20261124135937.18583-17-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135937.18583-1-alkumar@nvidia.com>
References: <20261124135937.18583-1-alkumar@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: f17d2e18-9949-447e-dbf4-08df4a33ccba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|22082099003|18002099003|3023799007|11063799006|261026121527099003|5023799004|56012099006|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GQ3BYDgJNEHzZNe9ELztOuLpR18EO4gZ+YDd1fbalfl1AYe2od3OeITxjBvm5eB1iQ4I8vGh8hy+h0Y6g6/l8s0DCIojCrA8+4ncGbTAQo+d6onhGXgcGB335ACHyk9/S2rAm4VbGkx5tyAOHht3YcaxUWlkx5w4Vbt+osvGPoud8xTEWiTXM/A0TCpgfC7UKsbtl3uhdueLI2sNI53f974jaStdK2pCGUi/TtZVNESiLG46/IRsFo4MFUJf+sZfWp+At/ytUObixM34sHnpoT8zHm8Qh0qcd4mFajI2BHPSEHFH9h33Levr07PrkeJlD7KOYPZb9QlJ9J/znEy3zc37EQcacPWucYxHxeNivJzef8fmhM1mVVzll/QeWyBoy4woUufcyWx5kjlYVelkxFSQAy/o5GHXaoP3KGa8Gc/AHcjoPAcUhmohT3xYPi9A03YH3aYt/2te/mvMhI4VNVSl9rJv/9ols/zvNchPcicZpuZWnabrj3wByNLt6uVV6zSb9sTHrgc2qgQhARjQTN29FElWRvnVdr3lL6tHrhWSqCmfpOYqqAY3JD5/TLOkYCmCaxsZe4NJqeQjl/+KzjQOeD/0yrYijm+qzdhdNIcAwEN8bMXz/0R58CfKKc7WLVZs01pjmTwFcFuMbM7fEHjYegjnfpeIKpqEM7NvbMz6uxNw9ZUCI13KPKN2QqPjUTSHWpzizMwc+hddxGr3xQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(18002099003)(3023799007)(11063799006)(261026121527099003)(5023799004)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qr+zBqLcC0dRTYFfsuP/q/hSv0kA4gmX+gAncGN2igNE6p0NDID2raWPxQR2lThJFn47tt+kSjlWc71l5+5dgXEXy7cDnjNmkkn1gRwst9wQLnFAeLJvcmZqY8/UT0lgP/lpE+z4ChV4XBkORl0y6RchVb1zGApDGemEJD5UjDbM1xZHv2jzF/FcX1qkwoK8PapsW+RLniWNtzSiconuf1ZAdVZZaawC1wBY+WbV1lvtxgHE4OzvzcYnqA3+toCtgAdxjFiAaGvJ4B+foE09NHhmID+Ge4iO2kW8P+euKDyaaU7I9JWoD92cbm+6z42D+K2AqCXDaSpryeWfX6nXuuqwRL/9PhTd6QyRqcNFllPTA2SKDdG6Uug4GwwrXawv/k9yu2ZarNZjTRbiM0907qCx6I/jfn0EvW8Rg+JyTzFRJlROt7j2Pp9qYD8SelhE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:04:04.7117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17d2e18-9949-447e-dbf4-08df4a33ccba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

From: Alexandre Courbot <acourbot@nvidia.com>

Both the `CommandToGsp` and `MessageFromGsp` traits support a
variable-length payload, described using a `SBufferIter` of two slices
to represent the fact that the payload might wrap around the message
queue.

The type of this slice is rather convoluted, and does not convey its
purpose, eventually getting in the way of writing clean implementations
of the traits.

Define two type aliases, `CommandPayload` and `MessagePayload` that are
shorter to type and obvious as to their purpose, and use them where
relevant.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs     | 25 ++++++----
 drivers/gpu/nova-core/gsp/commands/gmc.rs | 56 +++++++++++------------
 drivers/gpu/nova-core/gsp/load_exec.rs    |  9 ++--
 3 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index 7215cbfa5ca0..bf54f73afbc8 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -37,6 +37,18 @@
     sbuffer::SBufferIter, //
 };
 
+/// Payload of a GMC command.
+///
+/// Since the command queue is circular, the payload may loop onto the start of the queue. Hence it
+/// is presented as a [`SBufferIter`] of potentially two elements.
+pub(crate) type CommandPayload<'a> = SBufferIter<core::array::IntoIter<&'a mut [u8], 2>>;
+
+/// Payload of a GMC message.
+///
+/// Since the message queue is circular, the payload may loop onto the start of the queue. Hence it
+/// is presented as a [`SBufferIter`] of potentially two elements.
+pub(crate) type MessagePayload<'a> = SBufferIter<core::array::IntoIter<&'a [u8], 2>>;
+
 /// Trait implemented by types representing a GMC command to send to the GSP.
 ///
 /// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
@@ -94,10 +106,7 @@ fn variable_payload_len(&self) -> usize {
     /// unwritten space will lead to an error.
     ///
     /// Most commands don't have a variable-length payload, so this does nothing by default.
-    fn init_variable_payload(
-        &self,
-        _dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
-    ) -> Result {
+    fn init_variable_payload(&self, _dst: &mut CommandPayload<'_>) -> Result {
         Ok(())
     }
 
@@ -178,18 +187,14 @@ pub(crate) trait MessageFromGsp: Sized {
     type InitError;
 
     /// Method reading the reply from the payload of the message and returning it.
-    fn read(
-        payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError>;
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError>;
 }
 
 /// Reply type for commands that the GSP answers with a status and no payload.
 impl MessageFromGsp for () {
     type InitError = Infallible;
 
-    fn read(
-        _payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
+    fn read(_payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index 14e04db90594..e1d47e86c82e 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -11,34 +11,33 @@
     transmute::AsBytes, //
 };
 
-use crate::{
-    gsp::{
-        cmdq::{
-            gmc::{
-                CommandToGsp,
-                MessageFromGsp, //
-            },
-            NoReply, //
+use crate::gsp::{
+    cmdq::{
+        gmc::{
+            CommandPayload,
+            CommandToGsp,
+            MessageFromGsp,
+            MessagePayload, //
         },
-        commands::GspStaticInfo,
-        fw::{
-            self,
-            commands::{
-                GspInitRequest,
-                GspInitResponseSchema, //
-            },
-            GmcCommandId, //
-        },
-        nvkv::{
-            Decoder,
-            Encodable,
-            Encoder,
-            Schema,
-            UnknownKeyPolicy, //
+        NoReply,
+    },
+    commands::GspStaticInfo,
+    fw::{
+        self,
+        commands::{
+            GspInitRequest,
+            GspInitResponseSchema, //
         },
-        GspBootContext, //
+        GmcCommandId,
+    },
+    nvkv::{
+        Decoder,
+        Encodable,
+        Encoder,
+        Schema,
+        UnknownKeyPolicy, //
     },
-    sbuffer::SBufferIter, //
+    GspBootContext,
 };
 
 /// The `GSP_INIT` command, which carries the system information and registry keys to GSP-RM.
@@ -88,10 +87,7 @@ fn variable_payload_len(&self) -> usize {
         self.payload_bytes().len()
     }
 
-    fn init_variable_payload(
-        &self,
-        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
-    ) -> Result {
+    fn init_variable_payload(&self, dst: &mut CommandPayload<'_>) -> Result {
         dst.write_all(self.payload_bytes())
     }
 }
@@ -147,7 +143,7 @@ impl MessageFromGsp for GspStaticInfo {
     ///   or omits a required key, if GSP-RM reported no framebuffer region, or if the FIFO engine
     ///   count or indexed entries exceed the supported table capacity.
     /// - `ENOMEM` if the words or the decoded regions cannot be allocated.
-    fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Self> {
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self> {
         let bytes = payload.flush_into_kvec(GFP_KERNEL)?;
 
         let chunks = bytes.chunks_exact(size_of::<u64>());
diff --git a/drivers/gpu/nova-core/gsp/load_exec.rs b/drivers/gpu/nova-core/gsp/load_exec.rs
index 6ea853e31b77..cef6f314151a 100644
--- a/drivers/gpu/nova-core/gsp/load_exec.rs
+++ b/drivers/gpu/nova-core/gsp/load_exec.rs
@@ -12,8 +12,6 @@
 //!   memory (DMEM) of a falcon, and the DMA engine that loads a binary into them. The DMA engine
 //!   accesses the framebuffer or system memory through the FBIF (Framebuffer Interface).
 
-use core::array;
-
 use kernel::{
     device,
     dma::DmaAddress,
@@ -40,7 +38,8 @@
     gsp::{
         cmdq::gmc::{
             GmcMessage,
-            MessageFromGsp, //
+            MessageFromGsp,
+            MessagePayload, //
         },
         fw::GmcCommandId,
         GspBootContext, //
@@ -426,7 +425,7 @@ unsafe impl FromBytes for HsBinaryParams {}
 impl MessageFromGsp for HsBinaryParams {
     type InitError = Error;
 
-    fn read(payload: &mut SBufferIter<array::IntoIter<&[u8], 2>>) -> Result<Self> {
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self> {
         let mut bytes = [0u8; size_of::<Self>()];
 
         payload.read_exact(&mut bytes)?;
@@ -482,7 +481,7 @@ unsafe impl FromBytes for GenericBootloaderParams {}
 impl MessageFromGsp for GenericBootloaderParams {
     type InitError = Error;
 
-    fn read(payload: &mut SBufferIter<array::IntoIter<&[u8], 2>>) -> Result<Self> {
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self> {
         let mut bytes = [0u8; size_of::<Self>()];
 
         payload.read_exact(&mut bytes)?;
-- 
2.53.0

