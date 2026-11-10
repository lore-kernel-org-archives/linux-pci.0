Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794281859;
	b=BsglpE7dZNEyTwjaVCfLP7dhOm1HoJSj/CzqsLvxzsmymrKtgSvaic2LaclXNKp1UeCU
	 0UjFqvH7/pox+qfabC8yz1S92PwmTYEDYhF0vQa2UzRBnMTxZacen6jxC8Wf4kbopeZJC
	 dCXMkeGYxIAHAoX027aP8AhR4oPrgWmeHLTazYaooRrBxUkDbHBYV20hMj+EiYeIh1/O4
	 JrQIu7V4jng3m7UyfKF//DrglazfquC2OwPRAx4Q4WqISuGX0QohrcHBYv1kIoHgghyLP
	 z8kQVbgG2Ee4jB6ej5NQFEzGA33DETBbUfkp5wnRdddymEriY2PBXd+Ug2gRvzs+TKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281859;
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
	bh=UA3JzOcD8AseSokwXvgTFCDIVIanwkUCoO93Mvm0Jc8=;
	b=cczHlhwJnNdv+GKRfhlCvGo9/JMQnjL60pDGNvyetgpnLB75rGmO0jhfbBMUbHRX8XXj
	 UdcyyWU6IIIuvD7oRXnoRPGyMqlMrC94sCp7YeSIQL0Scq2oqWu2nQEAKjXmyATNuYbIO
	 sDVaUyv5UbZPcNSG43DvnY+k2Wm7bBgurODpZIYWYcNsb+O6e7vPzf5GhBvi3L7mOEM3m
	 AyJUoLB3jsuQM+6TG5fbwoZmhkYNeg43Fjy1+z7nBbfS0s7q5J9rUltZ+k31UOiy+znIp
	 cMTDiLaLriJFyIOAtFZQTUBrwDHYOmO7Vbpx/7XEGaFHs+w5BGsCewEYrkVC9nowsZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ALEsgktN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0960A2630;
	Tue, 10 Nov 2026 03:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D0960A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ALEsgktN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRrwhnh44FGOngd9eYE3CxLfFmTU+/jBvhXZt7s3c3j0cNrZVavKsgRV0N/FzqNe4sV5oYDnynuSTh+2Y65Q9yd72IwgukcNtCWEoffrDvSWksv3J/hqO8w3SvUjzoeLpm9XnbM/cVtCk4/ms9TFW0t3GheSUz207B3WrUqZPLjev1C0Yx8FQzMxjKNkOc6upeYJP4r3Vg6mr1zzbx78l2PDrgAxa1QA8GCoIHNpLTFsJ+5+QPlXZaWgDCM3rQIpgUBHxqKU1iaREjG5CDgasEckxyDQfMwXGMVPFhHwR5loOUYTNFhYhaz1VjHNgj+X4fisqS7SKTUFgbxCNlisWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA3JzOcD8AseSokwXvgTFCDIVIanwkUCoO93Mvm0Jc8=;
 b=jhs9DjXoCeLCWioTTXRXbWYFO3SsHvIkAzZIppIIRFComkxtKM7Wwj8+Bcb+lOEPoOeXG0nTVo8oLPAYtFJyjMyhVowbM5b2DY8RlVouX90ufyQDoW7qJM7m/d8kr9XpxNQzlQyMsBgl63981EuOo7Tt3i4y8fW4wNmMjHXcR1zXQKsbjpMc3x/aIlIUj2uRY9gnUPqmrEvIEJy0FsDJ2G68CXOEEoWllQrlj3xNvdQ3Ln2ZzkkqBfqz5jCjx+Ter7MRR5j45F3KLpS8KZ223TYiCz0uperpjwyq9mRpSluNSgw7BGIzr79xMzn0n2pohaK4tZ+eAt5/OPxtAyANmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA3JzOcD8AseSokwXvgTFCDIVIanwkUCoO93Mvm0Jc8=;
 b=ALEsgktNmUuVI49RQwexZkpUCLf8fUyRExsF7vzoHVR/0W4kyChgWHaFpVbwfO8jyRoVXBNHjuhX4YJBWcv9ggnBR+ALt3czULjtIfZjz+srqNK73YYylGoOGdn1T6e9s9OQXt+URBygwce/LkJyK0bHLovbPAHn0okCGSRl/8xsfg+atpArqzXXw9SRPXxcrs+WOj2Tbj8li1ePuWbgTzXUXbBbIyyCuFeGp83tJxHITaax1VGclb/DyYjZrkP8EbHJeCdfT1Rh2S7GKwHk0GUTMwNNtoxXxDhvYFq5cd8iRqqMeCo0w203H1aXROqG42/192QpujZq4KaK8Vf8Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 03:37:01 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 03:37:01 +0000
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
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] gpu: nova-core: factor out and expose Falcon::is_processor_suspended()
Date: Mon,  9 Nov 2026 19:36:54 -0800
Message-ID: <20261110033655.148487-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110033655.148487-1-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e7a17b-8383-4959-8d07-08df3edbe1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|261022113327099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Unm9qImJ5eYCuEy4myDEtFLPmVZUXPVv5rADgD8srUrHXFGdPjZTzl3CfXy5ZZjtyX2dlCKrMiAGnEuAapOqS/ubGGYvY7QnooiXufcC8gCSzskSUlvVcekMlNwOS5zkugVPu6rfZHrQaKtm0O6IZQiwwaVaZKeKIKhZNDCBJEotwawqjxThW1j0scnDA+rBT7S2GBfOPcVNcn6kHYpoG55bRpWZBcqFyO9Wp8z/Frtc/0efn8GqLarh7izYl4LISP+aGLaG8vm4kKlA0JBVusthKrAAyVcP+GcSWcu88oemqRatDls5KEtzf9xoGiTA9LKCRq4tNetEKQU8hNltu1dnwoA/zvqCFudNe16O5Qk/NvjDJr3hVU3P1O9HfUdymFirWA2I0jHHc5LOk3rCLr/5GM7lprvzA1A2Wp6w+S4YfE9sny6cB+23bzLjSdUNq05Z9G6allgEsKdA6SNZFXHzxfdJ4JmsI9hKjjWiaXZOP8RJj60q7eIOiN0Mt9mfqFuj7QFVO9BL0x+fPHY/Xgo2n04LgW/WdFuSWrc9a/+55i/vWyAOMxQjZMtNTFWvDabKsONF1IVy0Nwp+xJU4N77Z5S3COYfCuDl0dbFh3mTCVa0jLHwLEAYvlv+uiVkcVzD8uvtpqEZKBzaA4+ZMx2v5O1gp6WuAK23iOVmnVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022113327099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njnaSXwBgqtsymoP/4duUu3/Hp0k9HaPM2qo4RsJM9fiAL/nqrRjTUhafIme?=
 =?us-ascii?Q?HMCYRa6h7FM6DtzMZiN2aXSDMh2ssBSAC3jnfHsA9I3Zi5uoorRNgS5/Ye/N?=
 =?us-ascii?Q?tqcBIX5RR63tUcmdA0cHWmPq0MSiu0Hab69AeNsjjtrPmhatMlnQ4HP5MERD?=
 =?us-ascii?Q?4QyAzK7+Q6LW29GrKZEIJWESjJ6rb3qv1TeNx2OX7KdX34qIlJ0+AssFgNft?=
 =?us-ascii?Q?miLJyB+V3wViXjHoRqNocFME79Y/TqqoXGgvKYD0jM92ar/AfBbV1Wy0fXed?=
 =?us-ascii?Q?oXiGu0j7UJ9LjC7ztB8pRmGkUeQ62j3PM1kEOcKRucLmVKqULq7FUScu3tgg?=
 =?us-ascii?Q?yCFXwKwkfEJwM1WnI8TbBkqweGq36+3bGHVsjJ+FtTlrCsNk2tYPwATPZ1ax?=
 =?us-ascii?Q?u5xMlf//H6/1Alr+25o3dgQfWFAIIc84AbxK2MRrYr3S2yhFdV/SjE63hNYJ?=
 =?us-ascii?Q?aJQ1Y0oxvYZZyvpgA1hVZLcPO0/B/mD6ckT/iWU2H5qje2zoteQvWM992V+X?=
 =?us-ascii?Q?PvvaJwhEq+KJfXPKcA2VMskzQAfK6GbVJkmZ2ws13IZb5eNyQx3LeefYAgA8?=
 =?us-ascii?Q?ydMv6UecgVjTAj5ANiORkFyBeKJ1mfBk6GCenN6Yr8141CWGmlgDfEC3SFy2?=
 =?us-ascii?Q?oFyaOOy5mXCHPH3gpSQT+MUQG4UB5juBUJUOkdwl8VjZxhFEDpoq/DQD+Quk?=
 =?us-ascii?Q?PzH+NeKQD1XSF3weto5kH3eaOfUpjWaiwza/+uCbRJiwxQcajI1MKT+FPGrM?=
 =?us-ascii?Q?JpynHMxwFysLS+ITimenkZz2g0btPnPfME63JkHjQt15CaA4fnqBnqmgv4I4?=
 =?us-ascii?Q?XYhWPiepe5K8OMMsdbYG91Ab/ljlaqGkYyzguQG8rrgUOxJL42Z9jScZOCuC?=
 =?us-ascii?Q?TvdnCaAQ9XPJ3xeJQKORSrnOwGeRCAGOmIJPvHYUipK2ynObkVfOJQfkxD9w?=
 =?us-ascii?Q?fP07ZpayFxe/kBe5v2l9iNKaNTK/P/fXDrJo+Cw8WzBnMrVCYnviZ4QuTDPa?=
 =?us-ascii?Q?a2L2QJCvy/X2EIID97phK2UxbZ/s0V4cKhG30DstjX0aCSwr3OsEiGuQMC5W?=
 =?us-ascii?Q?1q0Km9gG+hEUQsteqKGzQS4Rdx1oCN7IH7FUvigMC5BXqkyi6tEuVY64ZRev?=
 =?us-ascii?Q?UZeTsTmDAFSPy5rynxXuPcyc4dLayAnPOjcYCnfULGSzoVvO5zcxjwOAJb41?=
 =?us-ascii?Q?TwPfVnnk3lpZ4F+JOCmnz6Ae/B4TRf5B9nyzyRdRn0DJpgAQt06Oje0iC/vF?=
 =?us-ascii?Q?sW03E6+GZlgFSlrZfn5WNBk9jclF7NTU9zN4rEnth2pNEKJww8k6Nk9xJLnn?=
 =?us-ascii?Q?92asDBcXUggZGIGc72RiR66dtTRf5HDo7b3VJxy/XFZwJTiYQQXhWhrON79L?=
 =?us-ascii?Q?PpcrsTC+U/wmqpFAYBx35ZCkysfHEfmWdgZJkRDBWyBhV3zeCjU7aEnCN6pK?=
 =?us-ascii?Q?PyBD51aJj7wUHthUYUZ1bhUR1D5Bd0u3t4zUJiUnBWiGPcJCrwJhKKxrojx6?=
 =?us-ascii?Q?xEkrARZvOGC0vukttD2WW5W0E9CV/6SeB0k1lCp19S4GEZ5s54L3TvErgUv6?=
 =?us-ascii?Q?EbgDw5+LNcj+pgbrffGJXZuvIP7tOPuLfDtnCPQwdeldtKEhmgpa3cv/fvCK?=
 =?us-ascii?Q?wZbcvRKdtdA5RgJnl4f7QvOSY7jWMU7ZVsIlNcxKvPoo4uA5EKoDM+MnuW6Q?=
 =?us-ascii?Q?YwedxSuBbrvSttBXc9G/sgrwFOaCY+Dtf1DaDzFg4+7V2TUQ6f2UakguQQBy?=
 =?us-ascii?Q?Gy062z8blg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e7a17b-8383-4959-8d07-08df3edbe1a3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 03:37:01.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99Ym+OVfjWFA8YqBq1ozphCwmPETU8YO023DneKEbd5Wm3ZYZaKk4MmfMyLxnnf8AOrJfFGMgjLcsFQ999deYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

The r000 boot protocol requires the driver to wait for the GSP suspend
bit after each load-and-execute event. The shutdown path already does
this.

The boot sequence will soon need this same functionality, so factor it
out into a method, and put it in it's logical location as well, as a new
method of Falcon<Gsp>.

Also, use register!() for this, instead of manually masking off bit 31.
As usual, that results in much more readable code.

No functional changes.

Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs | 7 +++++++
 drivers/gpu/nova-core/gsp/boot.rs   | 6 ++----
 drivers/gpu/nova-core/regs.rs       | 5 +++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index 1faefaede9fe..54247691b53c 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -47,6 +47,13 @@ fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
 }
 
 impl<'a> Falcon<'a, Gsp> {
+    /// Returns `true` if GSP-RM has suspended the RISC-V core.
+    pub(crate) fn is_processor_suspended(&self) -> bool {
+        self.pfalcon
+            .read(regs::NV_PFALCON_FALCON_MAILBOX0_LIBOS)
+            .processor_suspended()
+    }
+
     /// Clears the SWGEN0 latch in the GSP falcon.
     ///
     /// While the latch is set, no later message signals the tree, so a caller that consumed a
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 1887806dc330..9d5da5b165ac 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -2,7 +2,6 @@
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 use kernel::{
-    bits,
     io::poll::read_poll_timeout,
     prelude::*,
     time::Delta,
@@ -98,10 +97,9 @@ fn shutdown_gsp(
         cmdq.send_rpc_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
-        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
         read_poll_timeout(
-            || Ok(gsp_falcon.read_mailbox0()),
-            |&mb0| mb0 & LIBOS_INTERRUPT_PROCESSOR_SUSPENDED != 0,
+            || Ok(gsp_falcon.is_processor_suspended()),
+            |suspended| *suspended,
             Delta::from_millis(10),
             Delta::from_secs(5),
         )
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index df2eddc58efb..3a0c7159fa7e 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -147,6 +147,11 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         31:0    value => u32;
     }
 
+    /// `MAILBOX0` as LibOS, the kernel that GSP-RM runs on, writes it.
+    pub(crate) NV_PFALCON_FALCON_MAILBOX0_LIBOS(u32) => NV_PFALCON_FALCON_MAILBOX0 {
+        31:31   processor_suspended => bool;
+    }
+
     pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ 0x00000044 {
         31:0    value => u32;
     }
-- 
2.56.0

