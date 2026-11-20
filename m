Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150039;
	b=1+Gqt9nh6aJpWgH1pgOsq8eMjOoGADWX9OMLgDmywIjtfEje82wy86vvyCvBAnR8Zj8X
	 1lJPPVTBvswGXXsXKWZelihYNtk3KhyoOk/bXWbpHIY8bP/UtTIX1/KSzR4MRypSlpTw0
	 nYPwvIFPNyQEuRJ3iS2yCNMDnG9UNO7XpSR27u+QNcu9l/5xnah8NcUAJ/cGLzb0vUGhE
	 C/I29DQcEUhSRq+iljrHFqZA3NzqAzd8dc08ZxpPgCoBerVFCs+oKZwk7IHzFPm/gYu+c
	 GwD083YoPzyOYcTFIYFQLxuGMFN29j7qIkvJOCoKbN0hRzXVaYWaKh5jQhbqnDSqaMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150039;
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
	bh=eZiDd+YffaGyeYLmXvsLuKDtVmm2Dr8wXyyq24Syvss=;
	b=YXSgK8CF4rAhLgqP1pRpsGJJ4OZr63SaVIEkNhcn4lTiUrv5wukVBJ3M2lIssoVBwpNP
	 GmktZwFwHZTpZpDzK1DjRAROttF0kAYDs1g77o2TrXZtIe6WHCGgGowmATYBiJzmMOSsQ
	 Wp2+18bLTLW6HTS7wIeqrJ5B+YEhTQnijrOeZVSn8DlnQQpOTC7GtR6UOlm2aa+Y2FSCS
	 qerjxnWgjV79tD3WemnQO+TI2d79/yi8xLed/I56K1VCtSdvmKgbZqDteu9rouVEX3hwj
	 uxzTdeQz0MA64NPcZHjcgcjGu8sgmwG/oLLl2bEScm9zIey6urq0wyxmkkPoxzjlbiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wxq0thXo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.35
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8A60A3819;
	Fri, 20 Nov 2026 04:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C8A60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wxq0thXo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGfL59iUm/GRyiSAWqYMs3sTUc4MN1XYpQ3zYzKqJ4a6Z3MbgKZBHxZGmRC8f4q98gNISkp5LxC/k3ZZh7Vx1eXZC/AnEASWfdetV4qRHcNC4rOiYS2v8Lb49yPMLF14st6zG8RjvkSMK49xZCgdmKatO7mQmdA367niZ4W8opL+XebqCGGWnqJf9+W8bb1XWAOGeBfcyaHRhWatLYyZ5JZNhvr1YCVh/BA2+97gLhngMnbQuoRERrfW6FIDEL34nWGU8IfvifSJWJUZRDmYm9GnIhZppTe6sadekt62AQQqdCbgELrQ7WlrbZWdihq57brGLZo8n7LMvy/b+/xZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZiDd+YffaGyeYLmXvsLuKDtVmm2Dr8wXyyq24Syvss=;
 b=xDibgA2WMCfbkneywj9AgqxpJYIJL4Xkdx8743EvR4+JUKzL84nT4l/lnourywEG3cViD6+6L+oXuSiXs05rzht0pG7UEC8gHoxnhW5xjuQf/485Jb8SBpp5owov2ngSPZISPQMkuodZbs4T0okTxmOvCauXD5GTYH8jG3LFKc7QYnCDbVjqXfAnwbFX6tDisntqrw9kmtN9oshBZRJ1ScVAlNYrQ7Wo+aJ8tTaKK6HhANx0DeGCBkgYmFi6EG7pcyJqpMr6JuwzU0li9hHO9GSkZNmlKLXeMjUnILOq0nX35Npwfv0ShFCon8TIu/8e6qdUiBnlswey5JVMZM0kbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZiDd+YffaGyeYLmXvsLuKDtVmm2Dr8wXyyq24Syvss=;
 b=Wxq0thXoXJon090y2LPhvRutL9ClhjQ1ioT+yIlY7YZiys6NfDgqQd8ndqjwegS4fukOLmPcvONB6ySJhDw/QgICgzKM1ZreyZjzFBmv/f0VDE4DZdcfPjfFTiebXXfymopgTr/9GNwQzsTjvQzeCQYRommDBNZEk62Hzl+RcW3Rkx39xBrRnQHk2eC8zGZZRaqmWF6PDPth7xEcPwVFrKx7b9glHmuBUEXg7XvEDdCyRPeA0OzjiWtJLb22O5z16jeb25thtIua3QP1tZXheBmEMSz7TA6+L7/IKc7WS2UUMFN6U0ucM9O/rvsD5QGMYbQ4TolDk075/t3AcDE1YA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:15 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:15 +0000
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
Subject: [PATCH 7/9] gpu: nova-core: gsp: add the r000 load-and-execute HS binary handler
Date: Thu, 19 Nov 2026 20:47:02 -0800
Message-ID: <20261120044704.165223-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 055f8cf6-ff43-47b6-90a8-08df46c15977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261022113327099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Bg011lhkl9PlYb4WIAau50pqc89R5UzUDXwN/VGggbs2Y81zSUG6xWkhsI1obMNC+dkdqARVFg3CiQyuGbhc9aBqV1Lpohm+Lgoeh2BzQStnhmqd6vEI2FAYZir7cCtSzvDRU7x2R2xq8Q+PCQi1h+8WS/j+tzK7uVVsVOavH+KwzM2eGhNmvn8Y6Vvg4P1Soko/a4ticyWgkbVdtDrGmxvq69Sd03P6J06AN7q+zddFqd/ZgHtKqGgGwZW0eyI4QdYghFOnjjnvhnd0VOOmGf5Ep6vbAurlPBK3c3A164QGdO2MH6xjoWZoz2SnLDsmR78S+iR8OBumKohzAJIw2awWds0JSYSv0ZDVnxcr6bpY8sCGIxGIFNxrhgZm2UBXHJLYoxKvwYfFqFEm4amXazto19olde9N59QXlBdArGEDTJj8CssdL3Nlcehctor/PTxPtAGVrI8a7LfytgSN5eH0cD5MULXfNaBfODY9rhLNpnQVix7Qxi5bAvKKJ0GOXw6nEWP7V9QFtM7i3lzCoQqRRuyipuuHgYkb+yiXcHR6ZHezysZfUzI6rLhUc5+avIbBLBrFbJF/pf8EvaWoNEpSyFq7LhK2lzPjHL7YCkWN3kDTL3tzO2mYRLC5t6pdDRnN1lTwxs/1PefoRDNyqb3ASQ7oPSpRbmeLg0WItiY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022113327099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kj439EE4VjdQByIZYr3vQSkgbI4MbH6H/EB+Pwhv7zH223dc6Bht4GfbKCw?=
 =?us-ascii?Q?MmRJCMHoiXMFmUPZLkeVF783NAyZJ6OqWerKjz2asSftQSj0DV3XIXznRVtd?=
 =?us-ascii?Q?mi9hvC0zgf2L/WCgERS5/G/GCSIw89bGGnIodn1TfKGq33sUyzKIZ+VDbdxC?=
 =?us-ascii?Q?BOqLJ/lBNlPd5rnGUAASBjQN4WA3lP7dB/Wpek9OhO0a4J3vDoAgt7YPsU3l?=
 =?us-ascii?Q?PDIOa5lc6patBUQ5mNhrgMPwxAPrRayfZpMB9Jn3sXu1IVTAuLt1RTpEqMGT?=
 =?us-ascii?Q?YLVKSbz00Qt75vjAYzI8THr6+wVLX2S1+GI26LhQM0Ykew4KzmIZeu+viZXx?=
 =?us-ascii?Q?4Pop6oNhPcMzK8h0BP79xWKkdh6CFu/jsWb8uPVh2+rpP7JY3mBcoApxaETv?=
 =?us-ascii?Q?RAXUaeSRx/01iUG9iU43GYaolOJuP+j9TDGP/9JqhAVK8lCp2Hu+6/pX9oMZ?=
 =?us-ascii?Q?JzfQ5ni0W2myCNhZyWjsIT8IAR5oTWHMVNq1kqZKOAk3kh+G8vPUq1E5RWtP?=
 =?us-ascii?Q?/1KpEo80T9NQaRgnCIpwpyesBoElz5e+chedpEtRfFuDO8L8C8A9DMRcHh2S?=
 =?us-ascii?Q?foZuWuvemsV3jnX2r9xQNYOa2/58WCpNw2pVegrMZjz1nV4HqgFWsrUFRQNr?=
 =?us-ascii?Q?40B7lVrROGG4KLj0mIwfA1TrAmbWuuigdWbv8O++4cmT+AxZYnBRFb0n/zyw?=
 =?us-ascii?Q?miG3kKMC8ZDhobi7mpw0bMtJKmI/ycb6VD+72zXR6kQShQG8reUah6cV+F0o?=
 =?us-ascii?Q?yIMIyiLm/GL+o4jzAyKDwPk7NaCi5mOMc57k7xgDs0ekV7+jPj5t4U5S6onb?=
 =?us-ascii?Q?9+XW820oF2FJvm1cP8ZjIBlbfUnRJ5cqoDCkpbPp8uHCRItU366WYYIxy/T3?=
 =?us-ascii?Q?cGGi/UFPGRPUsbMfv6Q9HKbgKPf6cqqzz+19VsGAQrhVY40rpwHAr6zVg+bR?=
 =?us-ascii?Q?b3Cw1wjUAcyw1H2XxOICm1el8924/RyPvmZadV0GKpyoCOclQBTmEvmioD57?=
 =?us-ascii?Q?t6pupckm2uZ35aQYCjZm59QBBEf4ELA2/cQbHmb5VJyUqun3gloHrWtVLQjr?=
 =?us-ascii?Q?DcySaAYcZ1Fl7HGT3ParfZlEky/W5WH18jlumzBwniNveexI4fQu7IIKnuH2?=
 =?us-ascii?Q?plamKpfmfe2m41Xm+jyR1HLpYyHtwu4kICYBiFY/KAz6GkMjz22EZYN2Iv9k?=
 =?us-ascii?Q?he+FFg0t9tZgeVOuxjotrbSjV7taCt5etm2mRIYFfYcFlDmMwFCBy2juFRf4?=
 =?us-ascii?Q?hJvRpIZ2O6pFpeb2Zo8itQnMxaAfnjSRXYxljxI0cOXsEvcaMzTkIVUBHf6+?=
 =?us-ascii?Q?eBOtcxPaJj55BQW+TYp3jwKfb+nOUNsTj5uL7WtcjFgab/+wHeGRY0gg4Olo?=
 =?us-ascii?Q?TAYOz0Urmm8s00jByPJdtTEWuO9tsl86DrIiyFBpDgmCEn9SLqrzqaDA14Qd?=
 =?us-ascii?Q?3xeGz79ZMWxJo8B3cuXrF9OkeqgJMuR5MpuOJwQY2HjX9eDNYaTaIeRvtANd?=
 =?us-ascii?Q?KLbtiw2rf29ma4WpfqHvyKeYrrgsqugxX/SmUJpLxQ5S221bXXrrSmkN3B/B?=
 =?us-ascii?Q?41MUolwUIAToySHV06uiBGR4ResZlBwTJ6s3p2s07f5AcKgstunfQOxjZWAX?=
 =?us-ascii?Q?rh82J/D8GeEzf8yF+hKRyHm1JgClNLH3CPR3yKHUPFr5z6+luyX85MpZR3dH?=
 =?us-ascii?Q?HxASMBvV6M+73e17gKiOKpCawVeTAZO/MlkhyFFk3+bPUhlwjvlAL5OOfmlq?=
 =?us-ascii?Q?WDimH5nOkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055f8cf6-ff43-47b6-90a8-08df46c15977
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:15.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUd2Uh53zFqWVoDb2ALyNYJnVe5s1DX6MV5/hur9bTlLyPaYvfv6tZob6DheWpklEMF1VmopodvxuMoUSymLng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

The GSP falcon is a microcontroller with two cores, a falcon core and a
RISC-V core, and only one of the two is active at a time. GSP-RM runs on
the RISC-V core.

On GA102 and later, the r000 GSP-RM requires a Heavy-Secured (HS) binary
to run on the falcon core during boot. GSP-RM is suspended while the
binary runs.

The driver runs the binary on behalf of GSP-RM, in the following steps:

1. GSP-RM places the binary in the framebuffer.
2. GSP-RM raises a load-and-execute event.
3. GSP-RM suspends the RISC-V core.
4. The driver waits until the RISC-V core is suspended.
5. The driver resets the GSP falcon, which selects the falcon core.
6. The driver loads the binary from the framebuffer into the GSP falcon.
7. The driver starts the binary and waits for the falcon core to halt.
8. The driver resumes GSP-RM on the RISC-V core.

Nova-core has no handler for the load-and-execute event.

Add the handler, which performs steps 4 through 8.

Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs        |   5 +-
 drivers/gpu/nova-core/gsp/load_exec.rs | 203 ++++++++++++++++++++++++-
 drivers/gpu/nova-core/sbuffer.rs       |   1 -
 3 files changed, 199 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 75954856ad7c..459a0a88146a 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -145,7 +145,6 @@ pub(crate) enum FalconDmaSource<'a> {
     /// A DMA object in system memory.
     Sysmem(&'a Coherent<'a, [u8]>),
     /// GPU framebuffer memory at physical address `base`.
-    #[expect(dead_code)]
     Framebuffer { base: u64 },
 }
 
@@ -563,7 +562,7 @@ pub(crate) fn with_fbif_transcfg<R>(
     }
 
     /// Perform a DMA write according to `load_offsets` from `src` into the falcon's `target_mem`.
-    fn dma_wr(
+    pub(crate) fn dma_wr(
         &self,
         src: FalconDmaSource<'_>,
         target_mem: FalconMem,
@@ -699,7 +698,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
     }
 
     /// Programs the BROM registers with `brom_params` and the `BOOTVEC` register with `boot_addr`.
-    fn program_brom_and_bootvec(&self, brom_params: &FalconBromParams, boot_addr: u32) {
+    pub(crate) fn program_brom_and_bootvec(&self, brom_params: &FalconBromParams, boot_addr: u32) {
         self.hal.program_brom(self, brom_params);
 
         self.pfalcon
diff --git a/drivers/gpu/nova-core/gsp/load_exec.rs b/drivers/gpu/nova-core/gsp/load_exec.rs
index bf465ac1151f..d9a4ccd88289 100644
--- a/drivers/gpu/nova-core/gsp/load_exec.rs
+++ b/drivers/gpu/nova-core/gsp/load_exec.rs
@@ -1,21 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-//! The core reset and the core resume of the GSP falcon.
+//! The load-and-execute events of the GSP boot.
+//!
+//! See `Documentation/gpu/nova/core/falcon.rst`:
+//!
+//! - "Falcon security levels" describes the Heavy-Secured (HS) mode of a falcon and the boot ROM
+//!   that verifies an HS binary. The note in "Root of trust establishment" says why the GSP falcon
+//!   stops running GSP-RM, runs an HS binary, and then resumes GSP-RM.
+//! - "Falcon memory subsystem and DMA engine" describes the instruction memory (IMEM) and the data
+//!   memory (DMEM) of a falcon, and the DMA engine that loads a binary into them.
+
+use core::array;
 
 use kernel::{
     device,
     dma::DmaAddress,
     prelude::*,
-    time::Delta, //
+    time::Delta,
+    transmute::FromBytes, //
 };
 
-use crate::falcon::{
-    gsp::Gsp,
-    sec2::Sec2,
-    Falcon, //
+use crate::{
+    falcon::{
+        gsp::Gsp,
+        sec2::Sec2,
+        Falcon,
+        FalconBromParams,
+        FalconDmaLoadTarget,
+        FalconDmaSource,
+        FalconMem, //
+    },
+    gsp::{
+        cmdq::gmc::MessageFromGsp,
+        GspBootContext, //
+    },
+    sbuffer::SBufferIter, //
 };
 
+/// DMEM virtual address value that means "no virtual address assigned".
+const FLCN_DMEM_VA_INVALID: u32 = 0xffff_ffff;
+
+/// `MAILBOX0` value that means that a falcon binary has not started. A binary that reports its
+/// status through `MAILBOX0` replaces it.
+const FLCN_ERR_BINARY_NOT_STARTED: u32 = 0xfe;
+
 /// Resets the GSP falcon and its DMA-related registers.
 pub(super) fn reset_gsp_falcon(gsp_falcon: &Falcon<'_, Gsp>) -> Result {
     gsp_falcon.reset()?;
@@ -80,3 +109,165 @@ pub(super) fn resume_gsp_rm(
     }
     Ok(())
 }
+
+/// Waits until GSP-RM has suspended the RISC-V core, and then resets the GSP falcon.
+fn reset_gsp_falcon_after_suspend(dev: &device::Device, gsp_falcon: &Falcon<'_, Gsp>) -> Result {
+    gsp_falcon.wait_for_processor_suspend().inspect_err(|_| {
+        dev_err!(
+            dev,
+            "Timeout waiting for GSP-RM (RISC-V core) to suspend (mbox0={:#x})\n",
+            gsp_falcon.read_mailbox0()
+        );
+    })?;
+
+    reset_gsp_falcon(gsp_falcon)
+}
+
+/// Runs the Heavy-Secured (HS) binary of a `GMCAPI_CMD_EXEC_HS_BINARY` event on the falcon core of
+/// the GSP falcon, and then resumes GSP-RM.
+///
+/// `params` describes the binary. The handler:
+///
+/// 1. Waits until GSP-RM has suspended the RISC-V core, for up to five seconds.
+/// 2. Resets the GSP falcon, which selects the falcon core.
+/// 3. Loads the code segment into IMEM and the data segment into DMEM, by DMA from the
+///    framebuffer.
+/// 4. Programs the boot ROM parameters and the boot vector, and writes
+///    [`FLCN_ERR_BINARY_NOT_STARTED`] to `MAILBOX0`.
+/// 5. Starts the falcon core, and waits until the falcon core halts, for up to two seconds. The
+///    binary halts the falcon core when it is done, so the handler learns from the halt that the
+///    binary has finished.
+/// 6. Logs an error if `MAILBOX0` still holds [`FLCN_ERR_BINARY_NOT_STARTED`], which means that
+///    the binary did not start.
+/// 7. Resumes GSP-RM on the RISC-V core, via [`resume_gsp_rm`].
+///
+/// A binary that reports a status writes the status to `MAILBOX0` before it halts. The handler
+/// does not check that status, so the result does not depend on it.
+///
+/// # Errors
+///
+/// - `EINVAL` if the engine ID mask or the ucode ID of `params` does not fit its
+///   [`FalconBromParams`] field.
+/// - `ETIMEDOUT` if GSP-RM has not suspended the RISC-V core within five seconds, or if the
+///   falcon core has not halted within two seconds of its start.
+///
+/// Errors from the reset of the GSP falcon, the DMA transfers and the resume of GSP-RM are
+/// propagated as-is.
+#[expect(dead_code)]
+fn handle_hs_binary(
+    ctx: &GspBootContext<'_, '_>,
+    libos_dma_address: DmaAddress,
+    bootloader_app_version: u32,
+    params: &HsBinaryParams,
+) -> Result {
+    let dev = ctx.dev();
+    let gsp_falcon = ctx.gsp_falcon;
+    let brom_params = FalconBromParams {
+        pkc_data_offset: params.hs_sig_dmem_addr,
+        engine_id_mask: u16::try_from(params.engine_id_mask).map_err(|_| EINVAL)?,
+        ucode_id: u8::try_from(params.ucode_id).map_err(|_| EINVAL)?,
+    };
+
+    reset_gsp_falcon_after_suspend(dev, gsp_falcon)?;
+
+    gsp_falcon.dma_wr(
+        FalconDmaSource::Framebuffer {
+            base: params.imem_dma_base,
+        },
+        FalconMem::ImemSecure,
+        FalconDmaLoadTarget {
+            src_start: params.imem_va,
+            dst_start: params.imem_pa,
+            len: params.imem_size,
+        },
+    )?;
+
+    // A data segment with a virtual address is tagged with it. One without starts at the DMA base.
+    let tag_dmem = params.dmem_va != FLCN_DMEM_VA_INVALID;
+
+    gsp_falcon.dma_wr(
+        FalconDmaSource::Framebuffer {
+            base: params.dmem_dma_base,
+        },
+        FalconMem::Dmem { tag: tag_dmem },
+        FalconDmaLoadTarget {
+            src_start: if tag_dmem { params.dmem_va } else { 0 },
+            dst_start: params.dmem_pa,
+            len: params.dmem_size,
+        },
+    )?;
+
+    gsp_falcon.program_brom_and_bootvec(&brom_params, params.imem_va);
+
+    let (mbox0, _) = gsp_falcon
+        .boot(Some(FLCN_ERR_BINARY_NOT_STARTED), None)
+        .inspect_err(|_| {
+            dev_err!(
+                dev,
+                "Timeout waiting for HS binary to halt (mbox0={:#x})\n",
+                gsp_falcon.read_mailbox0()
+            );
+        })?;
+    if mbox0 == FLCN_ERR_BINARY_NOT_STARTED {
+        dev_err!(dev, "HS binary did not start\n");
+    } else {
+        dev_dbg!(dev, "HS binary halted with mbox0={:#x}\n", mbox0);
+    }
+
+    resume_gsp_rm(
+        dev,
+        gsp_falcon,
+        ctx.sec2_falcon,
+        libos_dma_address,
+        bootloader_app_version,
+    )
+}
+
+/// Payload of a `GMCAPI_CMD_EXEC_HS_BINARY` event, which describes the HS binary to run.
+#[repr(C)]
+struct HsBinaryParams {
+    /// DMA base of the code segment, a physical address in the framebuffer. The code segment starts
+    /// at `imem_dma_base + imem_va`.
+    imem_dma_base: u64,
+    /// DMA base of the data segment, a physical address in the framebuffer. The data segment starts
+    /// at `dmem_dma_base + dmem_va`, or at `dmem_dma_base` when the data segment has no virtual
+    /// address.
+    dmem_dma_base: u64,
+    _reserved64: [u64; 2],
+    /// Virtual address of the code segment. The binary starts executing at this address.
+    imem_va: u32,
+    /// Physical address in IMEM at which the code segment is loaded.
+    imem_pa: u32,
+    /// Size in bytes of the code segment.
+    imem_size: u32,
+    /// Virtual address of the data segment, or [`FLCN_DMEM_VA_INVALID`] if the data segment has
+    /// no virtual address. The DMA transfer writes no tags in that case.
+    dmem_va: u32,
+    /// Physical address in DMEM at which the data segment is loaded.
+    dmem_pa: u32,
+    /// Size in bytes of the data segment.
+    dmem_size: u32,
+    /// Physical address in DMEM of the signature of the binary.
+    hs_sig_dmem_addr: u32,
+    /// Mask of the falcon engines on which the binary can run, with one bit per engine.
+    engine_id_mask: u32,
+    /// ID number of the binary. Each ID has a fuse register that holds a version number. The boot
+    /// ROM uses the ID and that version number as inputs of the signature verification.
+    ucode_id: u32,
+    _reserved32: [u32; 3],
+}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for HsBinaryParams {}
+
+impl MessageFromGsp for HsBinaryParams {
+    type InitError = Error;
+
+    fn read(payload: &mut SBufferIter<array::IntoIter<&[u8], 2>>) -> Result<Self> {
+        let mut bytes = [0u8; size_of::<Self>()];
+
+        payload.read_exact(&mut bytes)?;
+
+        Self::from_bytes_copy(&bytes).ok_or(EINVAL)
+    }
+}
diff --git a/drivers/gpu/nova-core/sbuffer.rs b/drivers/gpu/nova-core/sbuffer.rs
index 3a41d224c77a..b8c01104c255 100644
--- a/drivers/gpu/nova-core/sbuffer.rs
+++ b/drivers/gpu/nova-core/sbuffer.rs
@@ -146,7 +146,6 @@ fn get_slice(&mut self, len: usize) -> Option<&'a [u8]> {
 
     /// Ideally we would implement `Read`, but it is not available in `core`.
     /// So mimic `std::io::Read::read_exact`.
-    #[expect(unused)]
     pub(crate) fn read_exact(&mut self, mut dst: &mut [u8]) -> Result {
         while !dst.is_empty() {
             match self.get_slice(dst.len()) {
-- 
2.56.1

