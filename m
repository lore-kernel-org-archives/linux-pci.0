Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36E223336;
	Tue, 21 Apr 2026 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752189; cv=fail; b=e2VBL6DlcNBE/MGS7r6BREr+Cvzv0za4AxAxXGOt/1QQ7oHZ5tUIQ3hZF9/i9DJf2ma+IM0Ra+KT3BwSiPzyJmeYbkqAuDORSoTK5eA/gXGaPbumzO4z8gJEM7KvtWmOt4JsIwP7HaPW1mUN44EIbZaMEZc9BUSoIFMdBw3HViI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752189; c=relaxed/simple;
	bh=Jj+IC2t/PZbeTCtMc6F5Wofmogp69pO2PC175yz6xX4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qr/fta5GOfN6wWfPMhc1f548Vs8yVl3+3lbySTJ+nlBxx5TIoXVBoPLa8hYRVaPp+4H8BafYYSV/mUBKfkxNRYb1RlCfwv8dKrHVwGju7nu/fH3cTZQHMn0IjLiB8T3C8F9j5jDij2qXIvtCXRVXpd2gMWD1AK+mzDxKMcmyUmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a622oRNz; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a622oRNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLiDd83FtLPvc+KBtunYx4XrFYlijkgvMAYEIKJbw4Rb8z/EHFimm4xyybXBdTFhsMshot6eR0prXd2Qn+JGk4n2KrQxwWc9bGlg4sBUFwPxE6IpAYySoupTlSUGFnve9sN769Y7159BUAHp3wsDf7AmTRkDxjY5/q/KiYJ1Vtbg5WU/LBlkFKsMjiWFlZHrrpp4kAMh+AZEiw37YkTwkR3xYKzrLJIXAPrhseliCfdweCE6g/esA0wYCtLzu1pzpayJbhIFrbqpoY6sJ4qRwfvJ2eG2JI+ezzfm65u83EcNrLd0J5preVZcD3dCXGxe1ccwFYTUnEWaR6F3Rha6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAzLwaziRXkvaxR8YooA4xbA/aXdhKtnWKSUvoKNonw=;
 b=yFyxF+G1Lq0LYWG493qFLgl/ykX+daftt1gcp62kpb+ogBv2ua0Z9InQNmIZdce3rBs2Den+1xiqDrkVhP4yFdwxXDEVE+Zrf/jUl0NkGxQd3WaV/WmlSKbMHtF8i0ipMRN6PPXMR1wRvCA+AUVLUD/oTR4D4+X7SHrY7aM+4bD54vilFXXb+5+WZtBcWBbKVy2Li18eYLynWj+vTjZpNrVUqgoDDxYaqSBufbk7zAbFFMmKN8YTS7lCOvatKVbvU8nJdk3erLN3+VkdKrqa3ydYe8hHzUK8Lfo7ajA30Xb8GazwZn3nwYg0/nZxYaBlcAGUmE/YoV21U8ybZkMOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAzLwaziRXkvaxR8YooA4xbA/aXdhKtnWKSUvoKNonw=;
 b=a622oRNznyG0HgiYsfu65sXUsIt6BVP+F4L60auVWTogiN7h1EQrcg7xUQFDdKQUaJ20y+1ROCFeZ6a9wkPYBDNBUos+0/zy6IhpGbv0VvUcjXDAobXIWg7Nzpf9wipMF9SLEvqrf5yIK8Cw/zB/cFuRzYtGYFRoEvkRb3ZGDRw3Dv+k4sa0ztO37hu945WsWFJca/apuJQMT+79fCaU07nyCkfz5NpYwxVPhtOZv5LfGrAUTD1AykDySUFSVCTwi9KvUCL3Ado93rcpTq2ZSKPOwLruiwfiay+Dzb6RvLTc2K8DZoggEPEqifNYvP7FBbrfoz48jhcp1Sahix2//g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:16:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:16:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Apr 2026 15:16:12 +0900
Subject: [PATCH v2 2/5] gpu: nova-core: use warn_on_err macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-nova-unload-v2-2-2fe54963af8b@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2302ee-db66-49bf-c580-08de9f6d8412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	865ThFFxgAeFuB4pffWlcfTXFUqV/1fz7PIzfTfnAKiNDdmpEEhc42b47fWbRMigajfVK4xOiVzJfuyGUd68kE9eAHxmmRtZuPLsDgmGBlx4AVEriZ/baDe1Ckcbh/8oVcij5qPLCNzKsVmojCKU9niBm5JeHgrWyTkYXlazAdAPw/I8njqb2mv+zW0jzQjbiId0Eqhv9q35Sw8ueoloqvietRKLLfReILnKE8f6i/t9KVGGpM6/XVXDWOtA3GXR7ZJeVD/mqJiKOjdeHq5EEDk5FK5YnZKSzhYi32NwOHY7wPFrDGo61lhxnoGZ577lojSY7BNrDDg1pQ+8IiU65cEY1N12osDPxFrikVdpjz5oxXWKdjgml15A8gOSgVfAybnGt4JCYIxsdb4hAy+tEUEcgdRYgOml7Ti+U2iqq7rjTpoxB5RKoZO2rM++2N3gNGj+9kUS4+k5BaQRelkz8D+d1+TEJzryh9RtPKyJa1i9AGxUwmYWwuxNydXpLbfR3vrwpBTa3ptBW6+sYKEfA1PiTwVHzUZzlc8lBHctixmNsAcNU+SC7dRVDUdzkZCUO0zVCwbllL5bhoSEoJQQ92TKYjpS26ukpUZB509vmSoFgwoggY/NedHYzD50BMByVQFXHw27/33FkO2ccY17JmveXlbiad+hv1jJSbFTIpArY/dqDjBI/ye48yH245B0Fg5rtQPpX049bR74W8AgDQzMKNNN3ip+qJ0m3HMBkhm+YV4QslQF97HD4+INt/WbzeAWnnG7VMuOkNl75AYASg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE9Xd0t6UzIrb3NnSVdVcDBJVFVjMjJyMUMxRFgxZHRmTWlRckxQazg1V2I1?=
 =?utf-8?B?VGpnMnQ2aW9lWFFOSmdxUkZ0cUlmYnZ5bDJxOHJwNzZ3UjZzUm51VWowYW9H?=
 =?utf-8?B?TEx3MlNqOU0vWGtILzZyM25VRUltcXJoNnB5TW5vTk9lNkRhYUZuMFU0T0Nj?=
 =?utf-8?B?aHllZTJ6dGR2Z3pvVXBTTzVZQXRPQUVDYlhqeDZuWm9XblBhTVFlWk5SaEtG?=
 =?utf-8?B?cWhJQnVDQXZQRXh0cDMzd3dONEl1NkJrVzBEZG1iNTc0Smt3Ykc0L2cxYXFP?=
 =?utf-8?B?UmM3WktIOEgwTElobzJFQm51OVlnbC92ajd0bDM3RVdoZjBCWUExUWg4NGgv?=
 =?utf-8?B?Rm1HYlM5ZmUxQitTYmdPNVRSZStwUFFoZjZqYTlnL2NDWXRjQ20zUTQxVVdi?=
 =?utf-8?B?RmxHSUE3SWswRHNvZmRCSmhtL3l1SW9IUVo3aFcxd2hUTUVENEdMMVVhTytl?=
 =?utf-8?B?eGFkcndLRHpIV2hESzEvd1BNcEdNZDRNa2EwM2daV1Z5bmNROVFuN3cwRHhQ?=
 =?utf-8?B?TGlLRVA1S2RiQjZxR3IzVmpITGZnSHhsSUJQTXVKWS9HVlRTQjNFYi9kRko4?=
 =?utf-8?B?U1dKN2V0azNndjYxM2Q2OEN0QTRxZ1Z3YThCTXhuZCtkbXVkNGZqVnhkQWlx?=
 =?utf-8?B?V3N5dVhLbDlnS2xZZHJqUkx2Um5lSzAxNHpOOXlFR1JCOGRBd2lNNmQyRVV5?=
 =?utf-8?B?U0hGbHdiMUYvSkZCRGQ2NEgrOGpjZUNvWjAvZ3g4NWxzNHV2RE1pYm44dUZI?=
 =?utf-8?B?aWdZWjlZOUVpUUZrNGNKekhkbHR3d0VDNEVGdHN3SjhSRjRzeUxWSlFOZ1Ax?=
 =?utf-8?B?SjMvcmtSWjN5TmtWTlN3NXA4aDg2bUVnbnV4ZlJzZTBsWUVad1doNWpGM29Q?=
 =?utf-8?B?cC9BeVAxYUNqSlh6Y1ViRTUvT3c2Q2NQRnVQUDJ0Um8rWHgzNmNpS2Z1T2Y0?=
 =?utf-8?B?cTJ6RTRNaEJNWXBrd1MxeDRjblQ3Y0FMeHhpMVVTclpobTh6WjFKREZmNU9L?=
 =?utf-8?B?dGlDc3lJYUJra2pNOEJRRkZuQlBnckptT1Rzd1FTem9mSjdrRnBpRDBjby9t?=
 =?utf-8?B?SENYTWNublllWEtMdzQrYkV0Z25RRlRoVk40QjgvbnkvdGxMMGNieHpqMEQw?=
 =?utf-8?B?SWMwdWp6OG9nK3lFWEdpQlM4ZldLSHV5VWs2bUNXZjVGRHFpM0pHL29zMTZz?=
 =?utf-8?B?R0hURDFsYUF1TmJ3N0t2SWkxT0luOVREUmlrZjFNT25wNkx4ZjEwODZ3ejVz?=
 =?utf-8?B?dTdGYzB4R1RBR2NITUlpWGhUQmIyV3k2TVV5dUt3bzVJaDJYenZzK1VLdzB0?=
 =?utf-8?B?ZC9Ua0w4bVFlQ1dVeUpXeG1VbXZBK2lLQis1TWJUU091RVhQQmRrdkN5L0sr?=
 =?utf-8?B?UTVYR3gwNE53aHRFQzZvZWRoL05Td1NmRjhrK3ZKcG1ET0JseSsrVGtkWHVo?=
 =?utf-8?B?NGxKMjl1U3NMZzFMRElEQjB1TXFEd1g3NFFrVjdMMGVlSWpvTmJ1UnZIZDZt?=
 =?utf-8?B?bTgvT3oxWWQrOWdyN0Q5Q0R3T0kxRVJmdmZ4WHkvalYzbDFhcGtyZFE1MTFU?=
 =?utf-8?B?bW9OYnBRRFI3c0Qwb0dmSE5nR3R4RzFSeld3K2pFY3VBZm9oQjBWNFp3ZlNa?=
 =?utf-8?B?SEExM3I2T3N5c2JHMDdiRjVBYjl0dGRBMW0zRTlsem5vSjdYS3pKMGVEeXRZ?=
 =?utf-8?B?blNPTWNlczdCcEsvOG5PQ1M4WWs2cnNWNkZ5Q1EyMUMvUzM2UzRpZnV5Y2FG?=
 =?utf-8?B?M1p3MzM5ZE5xZkFoUThhU0NZMWlndENxVHZLcVVLQ3Z0bHdHYlB4MnhaazhD?=
 =?utf-8?B?MVJsNEg5ZHJXVWFzNUVqbWJCaGpwVVo1M0VtS25jcDQwdGtSekorS0FsSmNY?=
 =?utf-8?B?OGE0c1NYazVRTVlzVWErTzhWNW9NYzF3dzMvalY5VllrMnZrd2JPTjFzWnlt?=
 =?utf-8?B?cnRpN2RocHpkY2p4Zlc5bGV1c3RwT1dZb2NlOHJOVXhlbUlBU1lLM0dldlBX?=
 =?utf-8?B?Qkp0U0UyT2xqbnBjWWRmTXo5STRIeW9admI2QTJ5MDhlOGlQZzdsL3MzUkNj?=
 =?utf-8?B?Q2h0K0k0cG96b2YycjJUV0RBNE4zZUlKeGN1dkFDRTVhejltblBuSU9vVTdX?=
 =?utf-8?B?UzJPWVdzeWpmY0NCcUpOc2ZuRVZLMkFWOXRsVXArTjVmSFNZV0lYOW5Lengr?=
 =?utf-8?B?Y3JPTHo1RWZzZ0ZydFVvZXMzY2NERDJwMXRYb3VqUnJ5ZGtxVDc1T0NaekJr?=
 =?utf-8?B?cGVJdDVEdzdWOC9xOFBKaC9XK0V6Mml6R3V1Rk51VXFlMndNbllwZGtHL1pU?=
 =?utf-8?B?a2ZndkZXUmZ2M0dITTFGL2wvS0gwcXFGRVNHU01BY1Jjc3dNN1duKzZLRXNW?=
 =?utf-8?Q?RRjZXJ76PxC5Dr6mDbySQEhgsPtViJxAcKHOLbDs4Gki0?=
X-MS-Exchange-AntiSpam-MessageData-1: aGproGQ30nAB1A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2302ee-db66-49bf-c580-08de9f6d8412
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:16:25.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92nHmB+0vKlWj9xHgYhggdkWBZksSpJophkIOpFaWsUEtaOO3u3SH6HTbN1GnDOnXimZlREy434H2Xc8ZfiYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

Use the warn_on_err macro in the unbind sequence, and refactor it to
early-exit on the failure path as we will need to use the bar for other
purposes.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..1701c2600538 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -279,10 +279,10 @@ pub(crate) fn new<'a>(
     ///
     /// Note: This method must only be called from `Driver::unbind`.
     pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
-        kernel::warn_on!(self
-            .bar
-            .access(dev)
-            .inspect(|bar| self.sysmem_flush.unregister(bar))
-            .is_err());
+        let Ok(bar) = kernel::warn_on_err!(self.bar.access(dev)) else {
+            return;
+        };
+
+        self.sysmem_flush.unregister(bar);
     }
 }

-- 
2.53.0

