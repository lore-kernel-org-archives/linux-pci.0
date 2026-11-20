Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150037;
	b=PYBdUqEdDOLCwLkmlPpcKR7tWGoSvorKeoQqd9Zb+xo6nPqCy1E/x+frDkeBN+XkBBvb
	 vvqo5dQHZbUl1uI6lxoR2PrJLwrRtAg7EF8E7iNIdpHkjVLY0YVMnLjxbSGkdCz0vKbws
	 Mqk34cg9dYSmfbfLvr14JOi/93qltHJ2Z8Na3elajbaQuLdHzWGKsWJLVGiSwUYh7Idex
	 6/eWTlNojlKHRTlegSXErWsd+QjtiKWOhr3lHsTD4eiIFvKmratkrz4q7lHrbsbo8RBzK
	 VDFSrWAwh3NmUMz6fmnXG5n4zLJryxiGAKQ9FylVGlOLiDLLzkHeRryav/BSywfnjhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150037;
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
	bh=B4/trSNisrojJWVOBbpY3yPVTK3q6nfEObW6K0uBobI=;
	b=rTw5r2apU5mfdA3XSMM5kG0D4xD70NeSS2jpAEaW5jdE6eOiZa0FUPp7kbCle11WkcV3
	 hXRwNH4Iewn/a4XrCZjbrIMP4yOycoxJMl3CUSjFuoGjwiZ+hodkaLLyU0ZsYLHARYaan
	 hjFh2SDtuhZCbAo92scxMPJhNjsZHnenrl5k9YPVHr0Dbdjdfw83mUsjBieyb0+mrGKA6
	 qKkt/EeRKQAP1dqLp2ZpeK6KEBUWYBBhf3U5qAQMjr7uLtXZkQNA/ew7sfevsPoCNuKTu
	 poibexieNQQvom5NLI2ecHo1+fFnPafgtrQmPFOOyChisA5mHzNgXBFPSX5Nfp3q8kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j80TkUXY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB160A3803;
	Fri, 20 Nov 2026 04:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECBB160A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j80TkUXY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5scozf5gtu89QXFJh+ecfdtWgGdZnQnKmVOiHYKWxpoLkduZbbXo55PQKBZL4E/9Ap18Da9vEknJXkjNYjzGCvcwqfLf0LDyfurON76uWtvRHbSkPFp67kvUlIjevDBJv0Fud9X76WUmtSLdhbSRYF1lDaTtpw92kmOG09t7Y6lKnZ0fA7IzHRqdba9EZ5Wd1rDGwaGX/EZwpU3ZXdr/Zmrv1O9VPXLZH5Nnwj+iCAelggXevxDRQUTbwvI8vlb0BGtHd6WXgp7//Fa5Ze3J7JOuue8KM0THXi3t8tJuEatdeMSvdgKOqZiI4uz/nZWxrjevcyqGdq1Y9kR/7DODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4/trSNisrojJWVOBbpY3yPVTK3q6nfEObW6K0uBobI=;
 b=JxQ4+YzGftHyfbM8yzhil0ANcXWs42vU1aS+MSJlxj7AM6kwFkugTL/SjLDIZwItWie6jlqSADwsiu4ZvJoyw1dCOCHGkOlBBXPTqhxp/1mROTk7nrKydrJWH/183yB56Q+v30HLMSVtOPqgLq5MrP++AjbgxoGpt8aK6iKCvPlNxZSYd8VbSldxmrEATOSZqlbCz7rNdK1zJaj5n0n6Rj1Sxbr3r8CG800Lu3TPnc3ya8m4nqT8HEe4nR3ucRJA5XdSPhW0M622MveftwuxjG9Z7T+XRRkPsTanD2nYXGsIF3duyU51IRLzOCoIr38MysfThKrGcQhXF2Ol1h30KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4/trSNisrojJWVOBbpY3yPVTK3q6nfEObW6K0uBobI=;
 b=j80TkUXY69UEg4Ykw7GhalxX2vhOdvuFGkhB2snsrU7i4vGhe9QTZp2QX6T1z7KuSvFQZ3mNd+xxiAXf8pvnmQ9/7yXm/ws+AheittvP22GVo45NrUtx6ZuXA9qdWQNhJR4VuMitt9Q7wJGzWLlPUDQ9SsquYA2cpG0k/ZfoHyW8eTS2HcZJmRvmSuliqwei1n40ljw8BcNzYH3Anm3D9y3GjpOn9E95yCs8oMlrdJuGqO1hmXEm3CuqxGuWBXGCoLvGFzDdMSH5YWBGGOsivPTRjOuS+sR9aVeQul+u6lnNjENEncMpqMx5KBNO6yBlM/EQP7hxySqCKSPmsr3xMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:14 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:14 +0000
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
Subject: [PATCH 6/9] gpu: nova-core: falcon: select the BAR2 engine ID for framebuffer DMA
Date: Thu, 19 Nov 2026 20:47:01 -0800
Message-ID: <20261120044704.165223-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4a2cb796-5154-418b-e0e8-08df46c158a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pZ0bOX18EaT/KqDecvtpQ4bgAejajWCNTVxwHTdlKs5EY8uAfM8jzsPZ2nlIFLZwfUjB1A4GKhnXxPIYvahG8YtJXMC6O16uOfETxtNGC1k34S2YwXNJ/WqqGB5S4rnZtO3gHFamrRGoyzHTVgbHa4DWmIWdlse+TXWTsBJV0lQCoEdxbgoVvZ/l16sBCL69k5HItphPAhT1ic/S6+JJpKomQw1aoWMvIcPbLT5AwavGLVjfMroA34xdv+rTV4VWq32aJ8HzqgQ3B95NfHpDpBMjs0/BTRPq7kedQfnJlAabK33gWyDmx2uhlqTuxJNUdYnUMftoCYRfJBPw1+hrA4vQ332XicqAuLQ+/LRuoxwYKVToaPPi+rxSW6DY6Ww525XdDvxHLIDVegjAQoPNx8H+1yxNC+yGfJUVQqXZv7kIvVnfoKujnKz27mIErH/fnXZPwcAarnFL08XKqEPijoab+2jHdco46PZ1r9Kj7u5YTa8gSYROG+Ng5gt8ySeIC0QtUanz/E09ynkbuMKBIXSb0gAV02qckHv2R8VDndqCp+H02WMpTdu2Pkd8cCEKpxD/l+HY2VeJTBhJKQIvVJghIijdG1/Y9sg8iKmrdXBIBX5X9y6qi0MnjjHYaxM62gHtKLD4/lfRZNmKSVdLT4BythuKYK2kLrKksYeZ4oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?54Fpv+YazP/Fb4WqijZtPpmty/uMoPVi15qbyes3okkjAP9Mq4hUev0uYLzN?=
 =?us-ascii?Q?M8PWLrTjdu9YSJXPtZLIGQAcocDMTxYlD09/G/vC28kDAaw+FTYAXRMmSvtz?=
 =?us-ascii?Q?trJ3MoaL/9H/tkUUxmHrTEZztlnEmqUhIoFIL6R8jUo4Kxq0lu2EI9TYhf76?=
 =?us-ascii?Q?RM4zCRv8BfShlszSgUAWP8o+2jBL5fxQUsLLi2l2N10O7xge2dmLrzTOVS1b?=
 =?us-ascii?Q?kd4/Zzx6wFGGdmz7gf7Ms8vGFlDHDKjrsmoXn15P5VlbYfVzAMRZvX1BHYrO?=
 =?us-ascii?Q?+A/c5vP8THm3DipVBIvb+GxfBZ7l7BgokEnWOPlEt4IXRKmmu7LvBBmZ4g/I?=
 =?us-ascii?Q?a+J8u1GOBFidr/FfsudDsFfP1B8Sw+GX0lnpMzr2YiNZjakMD3B7ZLAcM5Z3?=
 =?us-ascii?Q?RmDf8wQkmUC2cN2uqx+95P/4gL+vN081jVbKAfARr5UWpwFNkUGkyKkFZpOD?=
 =?us-ascii?Q?PG7mKcldxA+zFrSyR3nDpQ3UH5KsNG//95Z0fGU3GTfsgDgPnOn7j8jRusVV?=
 =?us-ascii?Q?yh/5wlIa3ebOROQGfumDUaXweX5g/Jzo6Ru3Pm5+G0Sf7raXp+fBd/pOoVdJ?=
 =?us-ascii?Q?OnABdHehbD9Ml0/djVLeIP22POWR+w23PU4TzkB5R+m1nQzxvSwznDz57B41?=
 =?us-ascii?Q?3unbAU+OSgKIcb8rETK3esZS66JVEj7PkJIBsBH0ox6sU6SsFAgqYeBYKRDI?=
 =?us-ascii?Q?Pw7GGLR3UT/cPC4evTkBKaOwVY1Mc82UQHbOMMjBsfN1FadlwfsVF/FcZnz2?=
 =?us-ascii?Q?z9R/82CtyaXF2dEhQVeASp0Kq7+8q25LKGYAlm8ZTmdTlPSIGoSiDnwEuzwA?=
 =?us-ascii?Q?IGJj0rfwTCnpV62URsBQ2YtLpcin1vZhziB1PvIVaLwYPGVIXc/P6sjMGpob?=
 =?us-ascii?Q?AcbZwwNmSyFMNWVQeNpXIa+GiyafcFKfgxieuAhg5Pd7nmSPaSjCDDazyETC?=
 =?us-ascii?Q?gaL0mhraXjsQUbgzrXqRvmnjNaUpilLP9kg66itiDEe+ySVWHN3Ioe2i5g/Z?=
 =?us-ascii?Q?AgZAFp/2PJZCCKgSSdHXDnaRbFJDVxYWB6dmCsLhMY68BWDGNq0HhXgQS/vY?=
 =?us-ascii?Q?FfyOWZRlCpFfcgni+GrV+RFUIEX5nyhlYE7LYGm6sMJm9J6mgAuzM0ii0Vgb?=
 =?us-ascii?Q?KuR9UxPvaxYS8FrlzppkcCLfpqbPFRsM6mrHFgt0Ym+Z7suvJNiPpairYm0g?=
 =?us-ascii?Q?fr236B7nO1AT0DXVL0suNOKlpHvScdUqyFbvT0sDrsHweWPUaZlAmt1yM67P?=
 =?us-ascii?Q?TMD7BhjZTBGXCOBbWqyIeUySopKZiHxlrBemZ0G6hLbmXNrVDPDwQtIpRZOe?=
 =?us-ascii?Q?ZQ/JmIw3s4NwAnY/+Xvgx5wMeEzcBCrLygPiEP/3F/oMSmcVB45K3UpCjalq?=
 =?us-ascii?Q?rVZ/RTZjiToG/z4VP4dEl5/Eazs3FLi8pF3Md64EZRvN3JwyOPxVBuP+meZI?=
 =?us-ascii?Q?bVu+0SPGNMne+eqMqaVPabuna0rcscEjxym/V6dY5o4inaNPL/Cp8DmUq04Y?=
 =?us-ascii?Q?WCRutJHmJZkqKsDUI9X6jgP9R0C3KgXafTXxX74Iq/GsxFhSqp2if5aRJ6GF?=
 =?us-ascii?Q?VgYXv7j/23gOsHLfxCD//SMZgcaduUXegCwUHWunZMi5J7kZwnyB9LWpOUL3?=
 =?us-ascii?Q?J42tTIE9uWnpuzZlRC0BzTGzuDMaofTWTQ4JbVekbvPSLhD8AdRiuJyMzg7J?=
 =?us-ascii?Q?iiWFqh0Qh4BEVKEQLhfYuSj7rYbWmFHFXxhD6Wx4sM1NwjaanSSTb2MAq3ms?=
 =?us-ascii?Q?bKUuc+2H7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2cb796-5154-418b-e0e8-08df46c158a6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:14.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkmHizJGDRl6TwOh/w2cLLtlpfAEJFSmU5Dxmfu2GDTKUdWdtZQe/NHiiWTEXgdXCEoLT6X2AcVndU9YQhQLtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

When Open RM loads a binary from the framebuffer into a falcon by DMA,
it selects BAR2 as the MMU engine ID of the transfer, in the falcon's
FBIF_TRANSCFG register. Nova-core's definition of the register has no
field for the engine ID, so the DMA transfer code has no way to select
one.

Add the field, and select the BAR2 engine ID for a DMA transfer whose
source is the framebuffer.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 24 ++++++++++++++++++++++--
 drivers/gpu/nova-core/regs.rs   |  2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 28c37c82b8a2..75954856ad7c 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -175,6 +175,18 @@ pub(crate) enum FalconFbifMemType with From<Bounded<u32, 1>> {
     }
 }
 
+bounded_enum! {
+    /// MMU engine ID under which the falcon's FBIF issues a DMA transfer. A kernel driver should
+    /// select `Bar2Fn0`. (Only GPU firmware selects `Own`.)
+    #[derive(Debug, Copy, Clone)]
+    pub(crate) enum FalconFbifEngineIdFlag with From<Bounded<u32, 1>> {
+        /// The engine ID of PCI function 0's BAR2.
+        Bar2Fn0 = 0,
+        /// The falcon's own engine ID.
+        Own = 1,
+    }
+}
+
 const PFALCON_REGION_SIZE: usize = SZ_4K;
 const PFALCON2_REGION_SIZE: usize = SZ_4K;
 
@@ -607,8 +619,16 @@ fn dma_wr(
 
         self.pfalcon
             .update(regs::NV_PFALCON_FBIF_TRANSCFG::at(0), |v| {
-                v.with_target(fbif_target)
-                    .with_mem_type(FalconFbifMemType::Physical)
+                let v = v
+                    .with_target(fbif_target)
+                    .with_mem_type(FalconFbifMemType::Physical);
+
+                match src {
+                    FalconDmaSource::Sysmem(_) => v,
+                    FalconDmaSource::Framebuffer { .. } => {
+                        v.with_engine_id_flag(FalconFbifEngineIdFlag::Bar2Fn0)
+                    }
+                }
             });
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index dfe7944cf1e7..050054a2b23d 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -18,6 +18,7 @@
         DmaTrfCmdSize,
         FalconCoreRev,
         FalconCoreRevSubversion,
+        FalconFbifEngineIdFlag,
         FalconFbifMemType,
         FalconFbifTarget,
         FalconMem,
@@ -291,6 +292,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
     }
 
     pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ 0x00000600 {
+        16:16   engine_id_flag => FalconFbifEngineIdFlag;
         2:2     mem_type => FalconFbifMemType;
         1:0     target ?=> FalconFbifTarget;
     }
-- 
2.56.1

