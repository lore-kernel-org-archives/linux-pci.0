Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086337F748;
	Tue, 21 Apr 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752185; cv=fail; b=m0Ab+AzJ5qlpc0A2DP3OGVl9EhFyrDkb7E7Ybe4svLzK5YemhnRk61pP6jYejQbJw5h4Z+S+SFxK9v3sha73kbStuv92SevxERpszK7HfvUSsPk7iu9Mw9ZKLyy20oy7RXWf57NCMmglMZDikG2VpOhsJSH4FWjSvj6p4aB1djc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752185; c=relaxed/simple;
	bh=GHK4iM5gBBaTAl2rUeKtQ0IC2WT33bAe1W8rTTN9zcM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m7aoyCj866lm5pbmCGljSIGteLuiX4Yy7i5tWJbuJogAYtyDqJm8KCpvzipCytffAAOD4Bt0yqu9UoCoSNiJxJx/KfsdH0jzXgkIfMOU5dBbGYjml+HNpT2JlMnAbNzIgDpkEmvhqKgs7G/XlQ8FmrVayvBpUq1a1hhchDmIRxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SuSTY2Sa; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SuSTY2Sa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRS2Nbyfd49WYJEXDJ7GOwFK4Gt2R7qu5RYZvFeXGcwpx/PV32706lK8N9xT6ShQTh0jpYuv3cwi71fKTGbH+Y0Im5lytc+T1OXk4OL8b4r8QG90iYCaYUIk24rFn841VlAaPnS1oYZzozx8JIg1TloQvN+nLL3FA7Mibl1XC8irI8nRnzNVXGKDD5+PmmvtmND3zglVLoakmU5z/0uQT77rBAuncocB5fKuxhz21YDV+t0rAac6Eon9u4+n1ucvFGpk8TPDqxzJWudSPrZ988nDdIeScJtnkxTz+ZvzzntDm3cDV11EnG9lH+0N5kkBNPKAoJFIrcWFOGn2PvElzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgShyfgo098bQ9tJx/o2dExcu4BIrahVGCdHSGqskEw=;
 b=tkXNnfmd7Ke3+WYcKEievKHgGgzlWtHs8+OZCNK4XN+80hqoTDNkTGin5h5cnqkKI7u+yawGtqCRQXxUp6ZBce9Aiw6ZYJL4WHODa/BvdCMCmIUZrKtswCgkp3mTKBTnYhTDHJPZXTtmEvMLoaD0ubd2wd/MVRsEz5w+aswN86NPixqbfardF5NkKJW7Ufb+5lKn4Bgv6Kym0bpNTksgo9aDzWK3zzlLUrJWr8kOPmsN0rmTGAQVx82+3UgODg8VX9m0OQ9M5peAdLlDDpU9x+801+MhlZJDPuzgLoKH2vqrBNgHerPxXlWYQEhYp4t5U0xClWAy6Uwjcz7OtDIocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgShyfgo098bQ9tJx/o2dExcu4BIrahVGCdHSGqskEw=;
 b=SuSTY2SalNLoelAoKfTtkIAz9KxMQVMeQrAl3LqMJziuqX5J9W2ddOucNM+gKH9THgvK/JbQoBNKzB+KtOb5K2OrbXtvyDITJpFbjeQIZDeac7Orj5CDmDQYAGVWOukFtT5eRr8fHOwPL6/cJ/wKmBl+cy5VCqatXWRQWkrR3WnpVafZXfOaiB1tDdTjmTaBMF32sg7j+8ZebSYJyHEzMYydCvaixZoz9h34qLdw7x1qjQFVNe8PLSRrwDisuyKTo96kgYKpjFbu5ZPzToULCysWLK4L9Lw5d1N3P3kZbQ88Ylfs7GMFZUlpf9hegxDhgF/zLRCNzR9juuwyTX5HNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:16:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:16:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Apr 2026 15:16:11 +0900
Subject: [PATCH v2 1/5] rust: add warn_on_err macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS0P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9c::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0707a325-d58b-43d6-0828-08de9f6d8154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j+Tqi1nS04ICHlrbOyPkFjucASMNr8rG8y5p+FnrzlfLL9+GhKidYsbAE/6LOsDzf2rHZvdWEhvm7Uyyt4mlhtS0nI06TXVlPWkBQx9q9I3f42uOvE9YeKsmKiKjmFDl912LJZZKHzd8kr42By3BMzIzPTzDl5VNbqJ1zLnmrCpSyXhC98ky1igWvmKZVHxEW9HvYXpcfyG/OMDhOSM9MQv/hC0pVAyoG5Mrx0liriTFa/bgSh/zhm5RVtT+3wxSQjpguocYV/BNqjSFeMIttRq8n3TRWPI33I5glaukY9t+eJhMDLC3sqDJKZaIn3iWgclQ79cVQFPwZSAtevkkI0Hdwwo5NHFx0iflcWdjWfR2KWMx+zYIu5Metjc/NM/T7XXfi1CHv1/vPE547rjc9qPwKUqpuJFXuBep2yhGibNFgj/kH4U///PPyI2xpD9YRm/LaSqUfsIloH1/LtUNSkQ+Gs74RHQ9+LyRBSu1joZvtAQ43IUzweqAcrvqBBZiDMeafbRevHE+KL/NPLMdk2TYu/2mOM2P6GNvS/GfdQmAGoG0gK9LTQhLsO0jy067GkOA4yJMmrYWzs3AkewlxtN8c1wtgZ3kKrDuTR7FnEAv6jkKfJvnCXgIN12CX7b3dl68e+4UeW2uRUAjruoL/VipgQ0nDTpazu6sEST0pijhmk4c657fSZwJ09EFzF98ipNk4PXsoipBPlXOnzD6vBgn5FtHQdTI3dtZP12QjweoHe4ecdOpW9CncJa/i2M9r74NYg9EUHOmeyf3Cor6Ig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3dLMW1ibDB0TWxPMEhrenQyTyt0L2thV2FtczAwUjZMUEpXRkM4NTVEUlVB?=
 =?utf-8?B?TUZKNVlJMmE0VE15S0wyVkZvNU1zYXY4M2hScDYyNmlPdjZpTC9CWmdrM1hX?=
 =?utf-8?B?WlFScHI3QmxCS2tQU3hsUXpuY1NrK2lsNVB3cDh0UE0rczdBUEgyTnl2bzlL?=
 =?utf-8?B?aHZ5b2pkMkJwOXVlMkN3Vk1RbU4yQXYyN1FIQ3draHZBbUgrTkJPSHZTNFRR?=
 =?utf-8?B?bHZpenl0REl6ek9kS005VjdkKzlvSnQ2UDF0dXJ2NWxWZDlUUUdBaWI0RE1h?=
 =?utf-8?B?dlppZEpVb004UlV2STk0aWR0L1RlSlJMMjVIUzBMUHQ1VXpTam80Q3pMM1lW?=
 =?utf-8?B?WFRsVGM0V2VsVkNJSXI4UkcrTUlzbDdGUlZEeklMMEhyNHQxY1MyVWY2OVln?=
 =?utf-8?B?UVlXaE5sWXZsUmk0K3ZDM0l2eGhJcEFHalZ2WmxSSVhJNFozNzVRYjl0VGth?=
 =?utf-8?B?VzZHb1A0L2N2VWJpazVlV2gxUm1TT2FPQ3RrWGMwYTMzSFppRHdiWm9ENjEr?=
 =?utf-8?B?NndnbS9ZK2oxZFdGME95NmxlWDdYcmhSajh6VmlGM2VkWG9vVkRnR0xKN3Zn?=
 =?utf-8?B?K2dxYVZqK1RQQmV2RzFpdWRBcTN0RkxKS2Z1cVc1NWJwK0xURHN0YjVVWitX?=
 =?utf-8?B?dDBmSysxN1lGOUpqamNIZEY4ekJyNnpqUndGdm5lSEhzcXJ6enZMMnlwWEtp?=
 =?utf-8?B?aXowNlJDakwrdkRiTzcwVGZFTEhiallVd0ZGS2xjWmhUMHNwdWx3eVZwdXdH?=
 =?utf-8?B?TUNoT0x3UXNNb0JIeDdXaTUremFIRFNoTzZhbzhlS3hzbWtFNDZ1V09BUk9a?=
 =?utf-8?B?RzI1SEVCTFdzaVJMZlBBSnBCUlFQZDVmWG90WlZGTkhxaTE1WmNIZDVkNmxN?=
 =?utf-8?B?bnRYNExZMFp5aTNlVXVYem5yK1psWUlSQWQ0TGhRcy9yMWdHZERadnk5WTRt?=
 =?utf-8?B?emlyR0Jrc2tUMmIxL3NPdndMNVYxMTB1NERERTNoQ1N5dXFKZHpKdUNlVWZM?=
 =?utf-8?B?WVhFUk5PUHhrSENuS1U1UFJsRDM0SDBMdGxRZE9WUkRmR1B1MkZjL1Z4TERm?=
 =?utf-8?B?Zlc4YzlYeGpnY2I3VVROL0pjOVNIUkRtM0p5aWEydVBOdGFOcTFaZHpxbHR0?=
 =?utf-8?B?SFJwaU55Tm85ZlZTRCtadjFqa0RLRnhaS1JCV2JWM0ovZlhLOUg5Qlhac2ds?=
 =?utf-8?B?MzJVZjlDd2JyR1RVMXlhYkE3YVpEQ1d5dW5TeDJDeVBjK1VBSEhXNXI0T3p6?=
 =?utf-8?B?dDY1TDAwOUlPRnNjR1NxSGNqaHdyNHorTEVVQSsyd2kzUzQ5bWo0NUdHMWVj?=
 =?utf-8?B?VGEwMVNYbDVGdjFZSDhQeE5lMW1UYWRtOHNZNTFwUGxvdnhVUFdiZGRJTEVI?=
 =?utf-8?B?L2w1bDh6Rmtqck5FbURKOEVDV2M1UzFTRTlRbFl1OVhCT2xrNXBLUldYZGVZ?=
 =?utf-8?B?RXdMR1I2OWlBSWRseTlUYjRqRGNWOVhURzRYRitmUTNPM1dSdmtoV3RwaEtB?=
 =?utf-8?B?TmxXcTYxNkZ2VnIvcWRYaHVCY01Cb1VrdG1LTE5OUCtIRmVKTWNyekFhU0hs?=
 =?utf-8?B?MlRWeEZKUUhWMHI4cjZiTDJtM3kxVXNna1BzTy9yM2JwTmNFeHRsRFJaN3pr?=
 =?utf-8?B?TVcvb0Jvd0ZNaDBZZDl4QXpUQUw0M05oQm9HU1VFTU1zNmQzYjZGTlFkQ2tQ?=
 =?utf-8?B?QnFaVUhkWjc2a1kxUkVvUUtWSnZoaDV6NmwxVGVuSUVzeGJtbTZ2dlNhbDZ4?=
 =?utf-8?B?QTFPYWJJMGtkQUI2N0FQenNUb3VPMCttcmJHcE5QaTVyY0FBdTBWU01rQ2Ni?=
 =?utf-8?B?anlvZU1maU1XbG8wWUdLNnA1NUxISG14ZjJrUVM1VEFXTm9QbXF5MUh0Y2pi?=
 =?utf-8?B?bEhYQzEwMDBYMDdhczVNQ3VIaW1NWVUzd3poUVhNYWxkdGZIay9jM2lXQ3lE?=
 =?utf-8?B?Z2FoVWdHUWJTNEhGbi9UVUdaRzVFcGc0ZkdTdmxvQTJIM0xSdTBadG84S3Zq?=
 =?utf-8?B?WGlWT1lacTJ5OUdqVFZ1SHBOQ0hocC9jWU1BOWo0bTVXdlBtM2k0amlqc1J4?=
 =?utf-8?B?amNMelQ5NG15bDZBVHFNaXJmY1dyZjZHWlNkZThVL0NNOGlFTGtwcWsrTUZL?=
 =?utf-8?B?M3dML3phdUg0T1lGeXI4Nk1sOC9UME5renUvNmJpalVGVGlZSE1aa1g1Z3g0?=
 =?utf-8?B?dmp2eFcyQklNSy81aG1WRC92RjgxT2F6UkpkL21uSWQwM1NueExxLy96bDVR?=
 =?utf-8?B?N21PT2g5VVRNRmhlVFdFMkVFVGk3QTk1TGJtQlkyVUozeE9JajRlaEdHbGJW?=
 =?utf-8?B?elZLZzVPWXRHWTc5K2V4UDMxcXZoSkY5SGowNlp1MGFZK0ROZ0xLa2pwQ3pL?=
 =?utf-8?Q?/cn0d+f3md3VkAZdwvDUbVtX+wHuAqv6EfaYV/Q/IA4qF?=
X-MS-Exchange-AntiSpam-MessageData-1: XLCllXvPLkDfTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0707a325-d58b-43d6-0828-08de9f6d8154
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:16:20.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/ovRUOfImGV6EeFB5/eGnwdYvD5ZJJpKnNKUaRvITy13IjK5QZg1uyTUgMobGmmhfITkc4lacbVu5IzZ0u2kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

While we already have the `warn_on` macro, a common usage pattern in
Rust is to check whether a `Result` is an error. Add a helper macro that
allows this.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bug.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index ed943960f851..2fefc0aeef81 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -130,3 +130,13 @@ macro_rules! warn_on {
         cond
     }};
 }
+
+/// Report a warning if `res` is an error and return it unmodified.
+#[macro_export]
+macro_rules! warn_on_err {
+    ($res:expr) => {{
+        let res = $res;
+        let _ = $crate::warn_on!(res.is_err());
+        res
+    }};
+}

-- 
2.53.0

