Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150033;
	b=0Z+zZc4d36hW/vO3k0xgtZhkHCpCilAcublpqcvxdKaP2Q5UjZDINVqObywvAjzQb9uI
	 ALylrtHlKKmymkH/M0kHmcxxHXQduVZBAVMQHSCQwCeNcLQBuJnB6WThwoxQ15hhnswr9
	 ro4mmmpQ1bfeChjeyQhObB9lKW8jRecsJu66Qg4IdeTPLTrG/3WPPd9sFmI6SJ+wprOVa
	 3HCD5FIhhU2eIUf/wunJg9TUt6cSWsl7VdnVMt4CJfUNu51OHYYx4RP4sorSKKE1wQ1Q5
	 MAURyXm3vVFKNjfSrdSye/XYZtQ+gXwkCMW9IgZCauXyExcoyIFDUrVD+kqH3NsxHdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150033;
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
	bh=R3hQRFuHtINxkZTyd7iRKudn6M+x1brGgWI0irDdep4=;
	b=YwjN0lOHgk526aq0/VC22Qwf9nqJHnxmuCvBXrgChKj/BhCrm9DKpjvNfPhPQ1PloHTZ
	 IUHC80klaDuUeZU7/CyUbqObByPSJvsMdeM753tXdpjIckFnLnFuj3CDFzuNYS7PXjfXi
	 4QimDJoNFvOXLnUGKAh3hr2XQUX8A0SbirD/9CCwIXT1QFpE6ZSC6n385GNxRybAxA4mh
	 3GvehIaHVANp5tTKl83iZUN8CnE1W3dWGGsRrFf+5Qkwl3/Ts4CHZCnMuGbug9hOVmuVu
	 v3XAHJKSVbgxBk2d1/Ij0J8kSJXtkIlR5e0hiwclDQZgHoj5rhFzSvMq3pRYQ9zRL6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R0Vf7ly2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7434606A330;
	Fri, 20 Nov 2026 04:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7434606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R0Vf7ly2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNnQr7L2oSxnvzTyGAWRK86gxRNfshhhKQhRQY931t8tgC7VAx6+8Y4ZSSuJ5XLVXM00JEdxiIG+eSEnDRqVoL/ObSfYbQ39PxRYyFYiYWgT8fhgxt/qjrRRH6qhZ2QZ2FbqvXT/F07tZ/MAW41cxWtnG4qYMG7iI4RPjCLjJHH6vaRTlH7h0hRWPx9C1H4Q1yKwESPPbnBb31DZN7OMJEvO2YznbnLaFRsfJsFzU65UIozOa87SN8j+nehc2Bs+16fbrOhYVss/C/AgZz60ecJ/BaZmoXPUCoVfjtWTzcPC4UKl+bgke96ZPR1KTad/viQLYu/DrjaBEZ/5THp4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3hQRFuHtINxkZTyd7iRKudn6M+x1brGgWI0irDdep4=;
 b=qaCYOcQeKfl8ro33K8s+t4UKvEyoRn9Pt21w/q0VNrqpsnI701/ef/AwEHEH7ML8ClWB3H75IHXVNXcF5N/MYJ2PVCAGdXMC1jtxM4EVgDwVul0fkPcxNHkcnl/VbFNdvlaPPVAdOeluIUcU/gAwnKw0ZEg2fOneBnUIr4hjfZ5xmCotoBywzdEQHeEBuNISGL+RDbSkAe0p6QPclygjxTrf4VJsyXHSuIQb2rZ7TU6YIuFLavp0abZNikMMdLgCy+5kpfGcQI/vKCiYWWRkCgkC0OOjMseTA9SmjmxmaZX1iuR1mNQ3ngHD1o64M8x+iNHU5IcKMU2KZvS4qIpcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3hQRFuHtINxkZTyd7iRKudn6M+x1brGgWI0irDdep4=;
 b=R0Vf7ly2TDO/smRWhsz547Mt6S8pWdBpynnKd1Ncga2SVtlOra4l8GqAfJJvJnvqsYp+oJQbZg01bTzCTSJQHFIb98lzwXHRNt78GU42RiDpOwUFpSvoTbHaaG2luknQ+hIJyaTm/vcEm8ixyNX8mQuf6A612ce8o3t6VhTnNPnfuOiIIXu0PAqEl9p9OoKedxMZtYXEJhQAGfSW8hj3xAhcpklJwpwRXmN76w+nFWKn7CYsliI5N6l72Jta+kt/u6FAyZbBrsZw895R9wzUIsPyJwun1LbOvUuVcwgARmMgFyM1GfPSHzoNTDwM7T+WcEQVqr86uQoVm1csFJHUIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:09 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:09 +0000
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
Subject: [PATCH 2/9] gpu: nova-core: falcon: factor out the wait for the GSP suspend
Date: Thu, 19 Nov 2026 20:46:57 -0800
Message-ID: <20261120044704.165223-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d1865255-d3a9-4b2d-485e-08df46c15597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OhkpkwbNDCHfz3/rTBEn+y449X5F7YW7XvA3/UNp8CKb4M/W36S6V+1N+uNffyeqdKZRsVTPnxhssDsGxyqReNRWYhbTSxX1AjAWc9GusMJQd/ut55+Y8hmZ4k7EphFRuUQO+V/HmYjvV8owLJW0fL/Loq7E3RpBdHvcwZLwIAXFTu2LfmaI+QgTWFFOoD5wQdvqfkZhPAVNwDhzSPEmWQQohqa25p5TPrSrFmQCXJ8NedGA/CfFiBdoQfx1Q5agAkjLxbIxpgmU904r4uc6KCVQ6GaskF/76KlSh508dNdQ/D1OPVxjbAMaEoaTcQ868lihaxvkxDnfUhzLwBK6yExqxUUtSAsrVrPVdphTzy1YFzjAg/4T5sFBH79rt8bw6UeHNl+GWuKMRA0gqgGWhego5lEkw1b7dz2/n9QgrUMDcS+d/f7QpwgnUV5IQ6+VYpPDsA8yekfHUds+zHq5+kitDeTQ8rcspFxDc21UtZnY7kh2SHGWjsZzZZYweOo62/btniBpO3dg2MoPONrscU5UUfClomRYBGTlU/vwntu1TRjvxRaqUTtVOYwoEnO+K41NYAlomAiHOplZDXtJm9MhKFPtSKtyWmxq/y1ud3heDpcTLoHmedJE1Sl+ImDvNI1/0MdNCea84BQkJzFv6r/W/v4IdWdd4xYoMUPeRE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wgy6NG9jHSFoNfHiEHKeNvGXZZJKgS8XWeOkyAHkl40WEgKTeQkbtluJ8VEs?=
 =?us-ascii?Q?04i56Ga5fmnM6fnW5LvA/8V6FgXF40Ro1K9h4INw8e7Rl25XOFhxyiJXD79p?=
 =?us-ascii?Q?9RXn+BD5Hc/0F/Ng1yyahupXtZCT7EpLi7J1YWgeGrM7qelpkjtlLmMPBhW4?=
 =?us-ascii?Q?J5lP061NYJBG1OvE/nUSAdqETuPOjZgmf9lDnc6Q0kXmoWh54aprl2gKJS/Z?=
 =?us-ascii?Q?TREMc4rv5k7RZDS0xHJsmcXWZ1RHWrhBS6yXpYVSoZyLBYVmeRldAY2YklQe?=
 =?us-ascii?Q?hQ67xlLZS5k2E9FOrn0Q4Ocg1IqfjpDETR9ZKuvka0DtDlpZQvuJbUrj5++w?=
 =?us-ascii?Q?/T0u3R2Z+E/P8C/DdNUe2zt4PuqkpxDyeygvA6eGuFog76rWakIghnQjfVIP?=
 =?us-ascii?Q?LKFGwjVVFtejeSyozb9QHKJkrj0oMsumowmKwra5SbcpwEZ273pdcsq/Wr7C?=
 =?us-ascii?Q?pE0Y9Tqsa/G1CpCHl45uqOrKX0yz4QE5XAyWmkNzbW17ILFIA8LuWWIYG7am?=
 =?us-ascii?Q?p47E7IIBChPQhVGNcojmJUL2ww1JfXagSBIeQJPgNfc6b4tdd+wNSN0QDlDZ?=
 =?us-ascii?Q?3Ut+DWG9q9TYOoZ+M/8sjWI8ELSRKy0wLOERTPOljjStHzndBOSClWijOshK?=
 =?us-ascii?Q?luQH/kZXaQ34pdBD0v4HlyXxNVPEqnlTgrVm2772E3S+Q4fpuj4WJG5PSahy?=
 =?us-ascii?Q?eLuh6W+G2Q8QAg81j2yy7yxucXFYY4R8db8ibepeGXD19R7NU9kfFYzFCsH6?=
 =?us-ascii?Q?gpZlFsxaNK+ig5my4XhEEcRb5E19OlBq5iehfIv0w26E+D89UWxGYWWdjTWG?=
 =?us-ascii?Q?1iymQJaMi9i9TzOwpEI65+pMmoQw14q65lXeoFZdfp2sscCvhw/PMk7cy6un?=
 =?us-ascii?Q?J4QR2ylb9FIKR6okHJ7d+Uk2zKTfXcjPj2WufS9mXN1US0tj+ZYGzO4MMr9F?=
 =?us-ascii?Q?7pOD3nlVB0CqjGHjGPWb5PeuGgsu1AoAne9pif1MQOGP++aIStZtDf4Qyvo5?=
 =?us-ascii?Q?q5y9bEv4KRQJsGWvxVc8qWVA7Y/H2jvJgFXiLK3adIHDb5GvMrqWgSe8QRfa?=
 =?us-ascii?Q?bTYTJ/R8BzcpZ0LYIf8u5MIx5uaM3lBok+eOeQh5dPxFAfXGgp+K16I0mKVz?=
 =?us-ascii?Q?vkQVNwn1hCp6vrUpxp0oqPL9mSZpZ0y18Rh6JLlool1JGzTI+tQI9piUpuZW?=
 =?us-ascii?Q?l1yMJ+AF2KiQepwECa/q3taZCeR2BD5+cX9rH7ccWPZ7NW283wPqn/js6R96?=
 =?us-ascii?Q?nmHTNxWTmSXiGin9EzPRKQ8NjHu8T4POI6lXv6vICsQxMt7eNQ6JoxPpombI?=
 =?us-ascii?Q?2TG83SjZXQjTfZqUPY9YfOs+tKjPl3lwHpTohxgLWverbyGqep8j9x+KwqMD?=
 =?us-ascii?Q?fzqQqzl3l2QjSoi0kkySPtGUbGUAj5v7tWyofApONpWyhH4Sbp/r6abfSr8e?=
 =?us-ascii?Q?eMl4EvYnnN7HofzAqAIu9EfbOsaMlZ3WR2Afx/u2GcANOs+4066YkjHsnRpQ?=
 =?us-ascii?Q?BxlhFVT4w079V971BIJeqcx0MmK6t/LQaVaVp4Ur4L8dtsRA5nt+bTL7fvqT?=
 =?us-ascii?Q?A2C6bXMFDAZPQFMEBpmq45zcUATW17jgvtDnuWVXe6JauVNT9kgmMBg+X+uZ?=
 =?us-ascii?Q?G1+a2AIqsAwN+PV0lAglnrXAe4FoaQ5QwCocCz1Ijmf92stVsGNpCMgjCPgG?=
 =?us-ascii?Q?dRew/vf7FAvF4iUEOvCf/KsccsPcWTOCl2bLm+9oGdxAx3HKFqOaKyNTV5oV?=
 =?us-ascii?Q?0Bmoz29ZpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1865255-d3a9-4b2d-485e-08df46c15597
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:08.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2jtRP6JrwC8NW+/kBzIK2wWj0JBa9JOLXH40VE9Oaki39BGjoDuTr3Onzwuuz2x1mbJNsINScwXR3WfRuxOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

The r000 boot protocol requires the driver to wait for the GSP suspend
bit after each load-and-execute event, as the shutdown path already
does.

In order to make the wait available to the boot sequence, factor it out
of the shutdown path, into a method of the GSP falcon.

No functional changes.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs | 15 +++++++++++++++
 drivers/gpu/nova-core/gsp/boot.rs   |  8 +-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index 54247691b53c..2ea28fa53db8 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -54,6 +54,21 @@ pub(crate) fn is_processor_suspended(&self) -> bool {
             .processor_suspended()
     }
 
+    /// Waits until GSP-RM has suspended the RISC-V core.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if the core has not suspended within five seconds.
+    pub(crate) fn wait_for_processor_suspend(&self) -> Result {
+        read_poll_timeout(
+            || Ok(self.is_processor_suspended()),
+            |suspended| *suspended,
+            Delta::from_millis(10),
+            Delta::from_secs(5),
+        )
+        .map(|_| ())
+    }
+
     /// Clears the SWGEN0 latch in the GSP falcon.
     ///
     /// While the latch is set, no later message signals the tree, so a caller that consumed a
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 9d5da5b165ac..2815fe8b306e 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -97,13 +97,7 @@ fn shutdown_gsp(
         cmdq.send_rpc_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
-        read_poll_timeout(
-            || Ok(gsp_falcon.is_processor_suspended()),
-            |suspended| *suspended,
-            Delta::from_millis(10),
-            Delta::from_secs(5),
-        )
-        .map(|_| ())
+        gsp_falcon.wait_for_processor_suspend()
     }
 
     /// Attempts to unload the GSP firmware.
-- 
2.56.1

