Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529083;
	b=1pWqolUYQUigk/JoqraB0qBok/dRo7ZiSu9r8zicBKlobOL+zqREeGwnfd+v57mmzhqw
	 7WzqvvgMouWjWxYUrQHNWQFoUmHq1v0cfDCxqOjaXKCr5LajhT9tfEZBpjnldou3SfikV
	 kA8k9jjc98H3yo569FzB+Vbu7VipFN+29OcadVvohf/ZFxrE/w6fCjcAkq9XVPPvgkAZf
	 EdzFuRQ4025ZNumCo7fGS4G4NGVku/syqzoEQcEP7B+/jr0YPbwJDTZwL3Nf4uMjqPbUg
	 2ottoaPftWwdJPnCJXa1pIVU+dmLDS51t83LPtMT+MNJp6lQENCasLZF2jHLeoASZww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529083;
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
	bh=OmOlp0nVCYM2B/UCMNo/OBoqJy3A5qoOQZrJ4DhMlW4=;
	b=pDHA98cjFjHLWFhOmBxOEL4ahe52LOvhTxlG0GrGL++1a7V4v6XNhG+i8DdSao9azuI0
	 32HIiplcS6CWIZL99t/nfjXcuwA+DKRf0+1BEuDfwrqrNbm63C3Z9XRvE4kKr7WHzhH1z
	 grLzrljp/RaHg3uANGCXbJS5N7iKwxNMWUQvjy84KGsF4pFnSUawPEtU4Fz80mrg32bQn
	 ASzcDb+9tc7mRfg+nXhbI4Ph0EXWGhifuW60jQVhp8FLrHibQyoO8Y39g/JJ3ssg9DCad
	 51bL3hnVkFnMVPpth1frReu/jFrdmHguNPG+WXEk2mxnpO7NdE+0jJeVEsx9ZIY0cKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TFBJujVv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.26
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AE60A6F6C;
	Tue, 24 Nov 2026 14:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 651AE60A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TFBJujVv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7HG9itulnUDWeJ9HFqY0o6HtOvLrRV89mF5iufDiXcEKzyohEtqXbjSGOoB/WFGFD0B+7VgEYkpbMw6KLHNuO62EiyB0uIo3Lq44tdAM8gvCXD/mtZCysLIo96TQX3FH/LQMWHOr1uAlLNxKC6HshsCOrz1vwyjiJ6+RNJnKoJKV1ZiGGEtTlR9LSvKPq1Bh4dXcEJNXyBWRYTdtTpFKjFobeA8xRb2GspouFM/HcE/uegcc3bVCGdkcZPaxSIFnot/w1SLmzl4fXFL/+5xsJWTH+JfM9hZFx7dSaWp4ouGIZ+HZ2bjt5T4DSMvn5o8BYUEUwM7yJpArPJ6PW46Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmOlp0nVCYM2B/UCMNo/OBoqJy3A5qoOQZrJ4DhMlW4=;
 b=BelA2BhjRHkDoje1zqnL53ua8RM3c8j1sx2pfuNe6TGTq6wDM0XEEKXxdxx3sPDFoLzzjCpjgvo8cs9p/ESpYlP8XSTZLERFbKSQ3FZKqP+ul9VgZXIS78KUpAo4/ZZ35YXYZ/mCMbUhJS3kiDIbTPIICeWDZwE3TkSXQt1uH+aVcrlpaUw72xUdBTf7Fnt0EyYgUl4ps6Tdn+kIsMvylFSa2npSezb4zxCkWksIJnvbrqLINk7jiVx3WZnOgUp3SRpW6AnUbwAGpuOUTwMqe13cP1IM2lULw+Z88sbFvpbwd5nkAwye8Ve3BZPdR7v7XbmqAVcXmKBiyjegTNudIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmOlp0nVCYM2B/UCMNo/OBoqJy3A5qoOQZrJ4DhMlW4=;
 b=TFBJujVvYgCRprzBVi09dSAKNIlVLg+WfIkz2ZAlB1V4k98NQGk+4sKSKmWU2MwcnMcbPnoaumuai6ZO4GPHuQcX94oZN8Qrf2rCPesR1wMVwwzu++p6bPuPWLB2JKxp1VDT6i/0MNDauCSOS7QoNgr4AnoZuixeUYC9TjdcwjViiX5G/mrH8frbpJJquK2t/T1i3AW1VdCBAUkcwgR0Juu9h0F+DHg/1NY29g4vB6tcz+9rwssh9rPnueEZ5pZMS8flY4UaeDde7vT5I+ZdrqGyeheljL4SczAye3yjOAF4WlHKF4W3pikodrOrirCbqZo+7deaOLK+Avqnt2rYcQ==
Received: from PH2PEPF0000385D.namprd17.prod.outlook.com (2603:10b6:518:1::6b)
 by DSSPR12MB999238.namprd12.prod.outlook.com (2603:10b6:8:374::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 14:04:38 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH2PEPF0000385D.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:04:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:04:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:04:05 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:03:52 -0800
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
Subject: [PATCH v5 18/35] gpu: nova-core: gsp: cmdq: add send_gmc_command_await_event
Date: Tue, 24 Nov 2026 19:29:14 +0530
Message-ID: <20261124135937.18583-19-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|DSSPR12MB999238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca0059f-d1cd-4ea8-91f0-08df4a33e084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|7416014|22082099003|18002099003|261009223027099003|3023799007|56012099006|261102123227099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|11063799006|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	oweDng3xAUdqsTnwutK0Bw5F6KmFrkcK3oKnPsLg1tC0cztU3wZMt8xD9FhIpn94VrU8A7f331bWF0VIsyTeKn4LAy0eUcus71bjQfRtSxrtvRY3Z9tUHT+t0gIzlO2Jq0pmcNC93e0Xuqq/quniBC2cZsijaDBpmeLhtRiCRK1UNphRRscEs/SJIaJsSEWjU4W4g2tRoKzL7I3pcbetc8EKzIUMBXkTcpiQS02/uUa5JITyFHjeMH80e4vbo7TZunq2w2JDXzkxuiMSFxALI+A5q/jipNQUV8TF4nJICS7BCgIKNjhuzfDN7OLcU+kxAd3Wl/9NRpNyx/xgF52665ddr6pV+Gmn2z337gUPd7BQx+/OjKTTXYe0p4EDA2RwD8FHtIt5v3lufFsKjDkFYy7fPHgilT1sf93BYjiDp3MEitMyfymybV50EUqq1CsShti0b//+zYkqJ2bTE/34HHEfzKvHcL+DnccBvtlyvwTwmWktcmvc485yhKomWf258ezpPbcALt8wzasF+gFaoLlJZ9SNnCaLwAnaMCA2SbPt90dg/uh/RtivCO4hUicWQLK3B/7kCeeqgSyUSNng6JEggPYnlj/IBJ2czgBdKbDS6c0eQ5WYy1QT1QWMRlVoxhRvAv9Bu2h1PQzMB1qwyySkgZE6yHMF2iwdLRhKXw9dibW7o4CpG/RGPi6okak8picyZmnUSFehaOzbvostqg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(7416014)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(11063799006)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pPyrizn1PgZeDu+D8i4q5MJORSpjnVdJ6o63gDqU2CVN06Iq8sFfneVgMeof54q3ut55Rd/sl6uCC6vSdHbQo+rmF4/GrEjbRFpoLhtoSQddSpS7KwMP4T8psfoeNjWX9cXsQYjd6PL8R9IMrR5TNCW9G6NxWvoTvYHwWmeIFuyesA6PbHo4Jlgi/IcVbMobH1nu9hMT9Kg9gIYy0I9RFjd5O7nQrMNpYWqXldU57DaWp2YZGvIAuW01TJhi3OscF5HzcJcBBS2Axy4zoWF4maTAQpOO+Iei5P+y7pFOnallyr2blnRCavOIOVMawTFhHTCCda2cEqKDG7HO+JSgufWuoihgmgmE0Ak5DmJDYF0dzChMIuKtITWmH9x4uzHwjYaSJV3bBQoNf6AA5VkVwzm2uIyvefpkkWfe7tz8bAGLU0A1ZNp8BLH+HP390BSi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:04:37.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0059f-d1cd-4ea8-91f0-08df4a33e084
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999238

From: Alexandre Courbot <acourbot@nvidia.com>

Some GMC commands are not answered, and report their completion with a
separate event instead. Receiving that event after releasing the queue
would let another receiver, such as the interrupt thread, consume it.

Add a method that sends such a command and offers the GMC events that
follow to a closure until it accepts one, all under a single lock of
the queue. The wait is bounded by the command's `COMPLETION_TIMEOUT`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index bf54f73afbc8..d4017c2e04ce 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -349,6 +349,50 @@ pub(crate) fn send_gmc_command<C>(
         })
     }
 
+    /// Sends `command`, which the GSP does not answer, and waits for the event that completes it.
+    ///
+    /// GMC events are passed to `on_event` until it returns `Ok(Some(_))`, which ends the wait.
+    /// Other messages are logged and consumed.
+    ///
+    /// The queue is locked for the entire send+receive cycle, including the calls to `on_event`,
+    /// so that no other receiver can consume the event. `on_event` must thus not use the queue.
+    ///
+    /// # Errors
+    ///
+    /// - `EMSGSIZE` if the command does not fit in a single command queue element.
+    /// - `ETIMEDOUT` if space does not become available to send the command, or if `on_event`
+    ///   accepts no event within [`CommandToGsp::COMPLETION_TIMEOUT`] of the send.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method, or if a message fails
+    ///   framing validation.
+    ///
+    /// Error codes returned by the command initializer and by `on_event` are propagated as-is.
+    #[expect(dead_code)]
+    pub(crate) fn send_gmc_command_await_event<C, R>(
+        &self,
+        command: C,
+        on_event: impl Fn(&GmcMessage<'_>) -> Result<Option<R>>,
+    ) -> Result<R>
+    where
+        C: CommandToGsp<Reply = NoReply>,
+        Error: From<C::InitError>,
+    {
+        self.with_inner_locked(|inner| {
+            inner.send_gmc_command(command)?;
+            let dev = inner.dev;
+
+            inner.await_msg_with(C::COMPLETION_TIMEOUT, |message| match message {
+                GspParsedMessage::Gmc(event) if !event.header.command().is_response() => {
+                    on_event(&event)
+                }
+                _ => {
+                    message.log(dev);
+                    Ok(None)
+                }
+            })
+        })
+    }
+
     /// Sends `command` to the GSP without waiting for a reply.
     ///
     /// # Errors
-- 
2.53.0

