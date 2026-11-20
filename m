Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150036;
	b=4SiflcqYrtCg6wQIzCNSNjES9Xbj/Qe9kzWFT0WL4QzCunoAZzq+kZLX7Sa37yWpm1Te
	 OMR1Y0O7sFsxpbLKt+HJo/ZwuntKxv+NsOqcT8JNo4GN5tLr+x1sE79Il+xDQpy6gnuzm
	 81dv/IotL1ykvNWZH4wW89ur4apz1FPzbPIimC8284O0HNP9Az3f8yiVQqhesA74r36w5
	 K54HpBzm38mXQrWfme/5lah8QbYhUes6GOS1IAGf7OjiolSA5n2QEw7rKAOzOprgZjQdB
	 yES1EGhQYoSAAEOGE9QwvDvXzP9YSYFT1i7cVmwoA4SXA7RLtuzYhS0XkNBbzHA01MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150036;
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
	bh=qdwzBbyfP2TsYP1Nj0KsNKVdbfwQ4/BH/P/8EBK7jBA=;
	b=Ak/6I4dln9fvLeUBvzYbJ4nYKpORTKowS9EaWv8a39aGONby6L4nODNUgulyyD1kkkYQ
	 WTlNaNHf142zFmYgFYFyasUiqMBpJaVMwKdoyYIJalq6D3bkhvyJdPg2llg/SLk2ozuwj
	 MyxG+yKgdLlGptsOAP6rrA+ZwIb2m7/QkRe3EyMl8i56sR8BoW89QJUnFjx/LG8KDeG9s
	 H9tBlBFRN/9bTFjAFJ8Y7TFh/PTAqB43NIyJlg2UQkUsl969hGqroCQbbisainf1d50oe
	 uMjq62c5dVae/qiRQ3xd4ojhPPMAeB+o3v0agtWFDxbYm6TJm+HM/bw9j0lv3NBqBOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NbKi5rJb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435A60A2620;
	Fri, 20 Nov 2026 04:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8435A60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NbKi5rJb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+m8ks4Fa+kLSA0noDs3sq3S3BN7Ffe7htHJTYTN6eBu0z43R6IgR63dWOx5IWls7rSPVHymw4Fs/KcoqccdkaxkXpUGFR6GbewmGMfJb0wjEb3bMOM+ljfVKdAxivxG80oaltlPruKVqVrrWtMVD1itAITP4wDTONQ7Rj8OcmNQmgI4lHdlOX6g/Nkh5BnB7j7evcZaFcMIASyC0vXEas/w+BApGMfItbEWYHeF0eu3hPqAi6EdUNRYON0TwrGWKAFM5CpqS0GxtZoQFCvyWmTbttmUYU7yBEUn3/fCqPfmPm2EOZ82+RWsCNTo0Q76z1KYwR3xxfKm6IqHiPVeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdwzBbyfP2TsYP1Nj0KsNKVdbfwQ4/BH/P/8EBK7jBA=;
 b=R3QhoaXCZ5XQwoKANcVRbWYwO3Pta38A6fmUMoDOqHf9KEC4AhTxHS/cUtLCt2fitLapY5T3tooKc7JAautVqvuQee3AqrmFdqudFvHF7cfWyTM8xkJhvWxRmlqnMU9IZLPxwFUo+e5dwSfrT8aStLPJ3x0XwwVRsrdeIoJohz50hgYalXb1gEylUUXrCoTEdWMo8vfNsLRVOmGo0YBPHCDchv8c+MnA7ffjNeUxqirHOKh90ZO5Vtp75VTPxBtoPbgavwTLc8E83ea9CnH9Rb9T1bBoKFh0pCio6A7nl3SFwjbuDZcB/tG7s2AQlhZBumFo7BRbgK8uxsd4ZKLnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdwzBbyfP2TsYP1Nj0KsNKVdbfwQ4/BH/P/8EBK7jBA=;
 b=NbKi5rJb5D+MzkoUpIHVABtwXdKPV5dlkJO9JaJiearShZqGtiGlLnpw+GqcDw9/W/jEkDr+K8c0sgHZVsk69+IYy1KD2LrHhMPuz2Gp4rtljubmEkFR8nTQuXBtk0ernuq19CtoV/TuVgITXbRdZdmX4SPhGgIfbHwTJcvkyMUMYYTR3jC0Ldyy2Tafuv8dEAh8VQNxw3fkDDqapJ9nLmFalUSLP3/YMA+2yr6hkTaACzu3BmQSvBt+MvWLziEAw6eDVc+dlAtUYadawaf27BKnwNz9hcio2EV/hoNt7FHNnQUY8/dAmm3qZj2gwpo2wChVVU84InC62SgXafCSuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:13 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:13 +0000
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
Subject: [PATCH 5/9] gpu: nova-core: gsp: fix resume_gsp_rm()'s error messages
Date: Thu, 19 Nov 2026 20:47:00 -0800
Message-ID: <20261120044704.165223-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6c3017b9-7f3f-455c-f13d-08df46c15807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3JP/9H0NvxNfIDRsTxJu9Rl4V1yk9CkNY46hCEp5OiuVzyv6+cbay8sTf9Upq5zncY8xJEqg7uv2Lsjk504TNn6BgLqnj3tsX48v99P+EC+KyTyeFdc5y02/oPBGZdw9DCN0523p9pQqnQKBHDFkNTb9dA+gvZH7hYdAf2O+ab6RKCCQmv1fNoEKNs2JDISFfnr7mxteVs6GnflJ7If8eof9qKOh7NQxPuT0eUhCx+pkg71STDU3g8HytTn/FcVf+wyC2t8XVOJ48BD4++9KL3CpPYwfWTtVWn+7TuEonOvAQywW+lX2cEE5f9ubMtMHUJ6XK7OsyXI3VLOdMmuKMAd2pvILQAs5DJxmaNj92fAm1k38+n11KM1CoVw10O8Tv9enXQe8SXDt45mYDKSC3rP4yueMghYrJP4IBVpUntFUUx/XsPrCOwURDLWZSyyWQx9qdEKq/wfBYEsmCYHHCK9OVgPoJ2qd02+HOgKFTZpzGAsdjkNcmZ/mTmEhdp00nuLsJEHmd/3a9WYr4eQ0A3yXGBKl0+WBdGWDqpsvwxjF9Npy7cWLbdbleU+Se4Gbh1n1x9YqNOf/D6RamHch08jqLOxbj5Hhup3gJfwdKX4USd0A1X6nJMKp2ULvKuwejR+OpWAPMRGMGvXri26UZuz+3uyaRa7OWCy7oXK6g7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2K/i81fJcmpFgZdP/qHiFZqY9pa9reOTToKYIo27h6ger2dhaezqlIuB+0L?=
 =?us-ascii?Q?E/YM52BP1qZ7RD0Yaqox6obZUoCACme3lkBXZZDrPCUlWJ9yfzTzJuKN+ACb?=
 =?us-ascii?Q?hRhVFgKIsBgE6vyP5co99YsdhE/qkLjhk6kikYjOBD4fw59zBzA5bo0ouG1Z?=
 =?us-ascii?Q?Q/AVBeZkyj/3Gum2DNkHgEcQ2z9EM4xeA764DI7cWaHE65vRVyjDMUgXl+G2?=
 =?us-ascii?Q?lloZUUvF27GuyRsKjpUqWbDEr0frqiYUOAx8pwtMuaeZyfp/spGCyWlJaFrY?=
 =?us-ascii?Q?lJ3uEibPYadWt1VCQdmgmKest5WeZ0B9HhiVtL8PDGG6rLnZPe6td2Q9P372?=
 =?us-ascii?Q?KHSCf8dH/oBbv10CA/gsWD6TdiXnwNxP4x7GhmWn5jUN5cRsIae43scq/bFE?=
 =?us-ascii?Q?a0MPRDv9ju+sr6lL/ahl62y9pSe5rCIqg6EmL4BiejO2csQg4T2AnnAjqECm?=
 =?us-ascii?Q?g3L3dH/nR3GsKJuf9kIw1jAzMOy0o8Ipb50mV3FkJockehrKStY53K6xKcV6?=
 =?us-ascii?Q?6sPWwfZjgHSGdT6qDO7tLxj1Fd2Tl4t3DJszogVnN3A2JdtBBZdmnfxbClHu?=
 =?us-ascii?Q?yfNSOGTS0+lhtPpGyfTKkNpst/3w+V19lb9bW7jl/1aD+w25un2wSeHB4qep?=
 =?us-ascii?Q?19fi07xaCjVkFjs/xycScyDSvhn9OwxHRFODjvXmSViD3GKQ0aT5ENu6p52d?=
 =?us-ascii?Q?s/NHKtKEYn7YyM+U7IpZybYeVPCbwYU6/99uyygWKhzA0HhCjd94O+UFCPIh?=
 =?us-ascii?Q?GFVDwYHcfI3z5b30SIvQzn9NHMImwyofWK7HwxOerWK7FnccxdhvhlvUfIU2?=
 =?us-ascii?Q?Vpl8slRRabARodqjTw87FKpiv3ZeX7AIvrnSMZKtyBHDU8dFE9nq4SxSvmH7?=
 =?us-ascii?Q?bfxRjJESjG9qsgdwhkatiZqU7zNcnN5Jo1R/OavJ2NrHoei/KOaKpgV0KHtx?=
 =?us-ascii?Q?dabizubkDbawP0tDHy3ikk6q+cKd22kCzdD8I3hXyN+bpgD13ZBIQm1LV8WD?=
 =?us-ascii?Q?/t1IzOuXlUxFYsjScM7dGJwyqNKSqh9KLC5qMEZfySD/CjyVYMSmhNYiOu+C?=
 =?us-ascii?Q?qmslWL5FNPHbMNjEgEj25feGMES+zj37rENtb2E8/7A1+QmKbIYfd/CFLalp?=
 =?us-ascii?Q?u61SouDFywwX2OXbiAWoa9Lj9ZyU8+ryXV6wsc8+rClMzXmRoPJH79he5A4U?=
 =?us-ascii?Q?8G8Z4bJqYtCg0jMcyH6Rt5nYJT3eDm7ODW/E4123vvmCSX2U/lEReCDG7424?=
 =?us-ascii?Q?FpovHMs4V1rZkj2Xmjn0TpQF2/P2Yqid5wLg9Iu/7NMUxv/vOdBDX/c9g9NP?=
 =?us-ascii?Q?MrtEHgA+qmI0BqNJrFJXJYOZxDbaFdEFCl76/CXIhkdtxeV5+wARnSQYfTEX?=
 =?us-ascii?Q?A1XtPjvJ1TUG2l2rD+WoUI1CC4jw4A7IKo84s2DMtFhBzdT4bofyPRinHWul?=
 =?us-ascii?Q?UVuHGaqBsW6Tjpg/MvlkQ+s135jZhHd/hlNmGVf5kjjQ2o779gNbmF6bcpn7?=
 =?us-ascii?Q?HkFo7rhniqTL8z1aL/WtMvsamfw3rO91suddn0UKfuydgeM6pDN0LnhgatuQ?=
 =?us-ascii?Q?CvXkVJP90Z4fV71RKZ+457FPUGoomtRR1y8Vp54F6T59/tL2y85iOTBsGXl4?=
 =?us-ascii?Q?GndvYy6njgIoXYF3Nri7+D3YmPCz6+FHKhc3s4NECJ/HO22zswrkNCprB2cb?=
 =?us-ascii?Q?Gw/cCI7NqhHiv8MjLa1BFFNhca7eIRpuVGIgBHFQETt4fUCx+n+utb3ueWPN?=
 =?us-ascii?Q?MnFkjF864Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3017b9-7f3f-455c-f13d-08df46c15807
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:13.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwvjUC7gHpzpZNUc4vWjhy8oPi1RL/PhVovvP+aV5bEHDW2X0tJPwQcbOa88neEpXl5EtG2y6AEglAEDdI6SpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

resume_gsp_rm()'s error messages have two problems:

* Both messages open with "Sequencer:", which assumes that the function
  knows which code is calling it, and that that will never change. This
  kind of tight coupling is almost never desirable in well-structured
  code.

* One message prints the SEC2 mailbox value in decimal. That needlessly
  complicates looking up the error code, given that Open RM documents
  those values in hex.

Remove the sequencer's name from both messages and name the GSP-RM
resume instead, and print the SEC2 mailbox value in hexadecimal.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/gsp/load_exec.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/load_exec.rs b/drivers/gpu/nova-core/gsp/load_exec.rs
index ccbfcbfe3ce5..bf465ac1151f 100644
--- a/drivers/gpu/nova-core/gsp/load_exec.rs
+++ b/drivers/gpu/nova-core/gsp/load_exec.rs
@@ -62,7 +62,11 @@ pub(super) fn resume_gsp_rm(
     // Verify SEC2 completed successfully by checking its mailbox for errors.
     let mbox0 = sec2_falcon.read_mailbox0();
     if mbox0 != 0 {
-        dev_err!(dev, "Sequencer: sec2 errors: {:?}\n", mbox0);
+        dev_err!(
+            dev,
+            "SEC2 reported an error while resuming GSP-RM: {:#x}\n",
+            mbox0
+        );
         return Err(EIO);
     }
 
@@ -71,7 +75,7 @@ pub(super) fn resume_gsp_rm(
 
     // Verify the GSP's RISC-V core is active indicating successful GSP boot.
     if !gsp_falcon.is_riscv_active() {
-        dev_err!(dev, "Sequencer: RISC-V core is not active\n");
+        dev_err!(dev, "GSP RISC-V core is not active after resuming GSP-RM\n");
         return Err(EIO);
     }
     Ok(())
-- 
2.56.1

