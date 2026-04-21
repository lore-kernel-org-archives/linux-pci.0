Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531943DA5D8;
	Tue, 21 Apr 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783400; cv=fail; b=LvrrcJT8JL49c6rQonsZoNR3US2R1P5Z3isoMpxZL9zNdf+WiQ5uY1aMwDUySI8prodck809ZDRFdPzBNEFU5J3d0+GhteVQhYNg/h73GtPn3NXewfly6K5lrkpe5oUpz/Hb7TdoB4J5bVThn8G80Yj+xRDlMjKwEJ7qhh3T1gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783400; c=relaxed/simple;
	bh=uAP2XusktosMg6Sijfjq1oOzEOUFYQ++m7dbhH46Bzc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PJRj3wDhRihCgCqdWBYY1fWTx5Sh7p1+af95VMXW5mfpG+esibC9wXFtUoNFNAuYvOUkbiX01j0VC3WWIVM+xA2AUnptqdsr+EOgpMDS16AheSwSzw5rm+eM6d+qws/piqbplUDIcIlmmDYlLUZAL+ZPIKlLWczKbhQdzKVEZlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vQPuSpRS; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vQPuSpRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+r1DNLQt5Vbi02/Gn+32d443GmuEvCo7/c0R/jXZygbSIVOJp6iU55MP1ojkt51AFy7mRSI0U6q4P7/JXPOjW0EEl03Lh6Km7mrwMpfNh8Y8TouRJfzc5wSbhjb0ealklVJDAWCe1pgF6QapDMI0sRr/VqCLJCN5TE8eYzwwpsv83Dynp3mw0QM22wXEWRbo4+YiXKxjUIRRtBuAb8A9ntOP+vqxtOycyGIDtR31Hx2ORQu6fSHX1uqflAkDBwKXDhTCUIb+qLkf52kJ2NPhUAbk5tyKHBRBW6yJMdy6PseQ/ksbqYvwnxuxgPNSZ+LPNCFcC1KCRgUrnxIA3i/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MS5uMU0rcBULjS2MOKbxruodp5TKYeruE7ZCaGTkKU=;
 b=pukbv0okIDjzX5MTHQ8+/v5yWnHTOOjmWLSDLuzZ/ladF5ngco2M37fBGAfIQvYSKZNMV9Z8hHhDSRaaQgyE9zM+wIOgRu0+TVomWy5W+dsUDcvTQ6LoAHTDTz0sKBgXDYDTML6c6aV9JL+7w7coFrARmo3k8riFO4t7qKKMKchmuzq9W2poP6z0MfB23rYjlCHYW5wo+GczK3Dj+c7XpuwSzrzIN469Ssjl0Y5GyuYp2+jZ7o4JEiiCjHG1oq+xhg1/8eAnznUALW5s2WbPwUJOIC9d9NOdpZSSZYDWbVaAq1IUrxm11U/FR0cGgxew6TRj9G7gcFOq1Ci/IEnwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MS5uMU0rcBULjS2MOKbxruodp5TKYeruE7ZCaGTkKU=;
 b=vQPuSpRS/CB9bjpsmDQecdvBxt6r2wJuPMjY8m2iUu6UFdgIzOnGAwDLT5NoSio81BZ2pNLoosEhB9OFY/B8kU+4l5Ov6P6uK9cLCx7QhZi7y/rI4K/rEjtY0PfefTUkt+LoBReokZbRjDf6lU+V7a/eGFCdWfu2zxZo0AtPoLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5523.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:28 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:15 +0100
Subject: [PATCH v2 04/11] rust: io: add missing safety requirement in
 `IoCapable` methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-4-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
In-Reply-To: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=1265;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=uAP2XusktosMg6Sijfjq1oOzEOUFYQ++m7dbhH46Bzc=;
 b=T/DxIPKbR50JPwauKc5lcbKe8Mc0kJXvMEuqXWE5g5y+xfPhMfFcBFVAWT1k6UbmxYseMW83l
 Vqf7hzomrTsByj538hlbVQpY6MU0PDoCPP/DtuIXFbeRxCMabFiZje2
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da74dcf-26b1-4093-b139-08de9fb62adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KDhs8dUvvw00usTUzEvc6xHCvg4Yn2nqTmek4iHFXuODVMuzLdiVHN/KduYg89nfuMN5axXURzFxFIa+k6JF8cTFHLnz0wfqReGmfY9D785tSljz0uDpSbgpkzsaoSlLQ3S0KxuXQ375Dnq/qRWBJGu2Rh3SV/DKIKW4YVWSF0GwH5QcDLu1K0nH8/lfc3F81FyyW5+zgHYV7sy1Ag0+PoBrRomT78DYovQdq7Q+Du3qhw26sFnaboUzRQ3kC8j7G5x8HZaUBB4J13/2VTYo4YRa24ci4dBGcAmjNwUN4syByJQpzm9UM5dlVCIG8Hw8E792pzJ/H2fJwXzqZ4ug3wcHJ4RiLOITeMZVgt/yal1+yITyR0to2cl49fMCUkchK4ZiiMqMSilD8iIlHsN2THz9hxAdMnS7yuazvH2V0DKiuFDHLPGKp4kOeTeWfoCwFBavsKd3/HkkMBaAGULrL1JZNp0Ecg3x1jhR6YcPjjq5QIwCanZYsNCZbCjkKu8kNIdcOuaP7vK78vB7vTxtXCqFsrcRUGooh4Pz0HbUs9B6BidB9UDziQEZ3Db2gAQAG+GuL+zFvmCuwMY+lCmbhnH7kJar9mr5S9+WxBsGiFT/6cp+i+m7iWpn/jpAz6nidJHzhzPb9tqLpWt/jfmIPIBAe/QVOGVzh1DAn79yMI9fcVKuu81POh/ChHupV6iGeRzXyUWjnJG2fyGpHy1s6MA2YuRR7BgF0TS+btKjlMxCPkVkVw+2ScfHqKpSxXy44z6Z97woWrylz0TQxiZVog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTdVTGJmTFJ6SGg1ZUY1dHBTa0FabWFObnJpSExUalhUaXVLVCtYM0d0bUhV?=
 =?utf-8?B?SkgyS21HVUI1ZFZVZEFRZ0xZNzYvRDQ5MElvK3FqUzU0NmYwSy96UktuRGZ3?=
 =?utf-8?B?SjRITjlYK24yNmdtY3VINHFPSmhYVXduMFBzOWhaejFqQUxBTmh1MUZtRndt?=
 =?utf-8?B?ZXYxRWhXZXNjaVozTy9GSU1RTnRING94OENXL2x1RTNEZk5sOE9PRGduSWQ2?=
 =?utf-8?B?a3V4QVhLZWtOaFRUZnBqQ3FZa1RIS2oxTXF2Z0RiNEJVa1E2NlNDN3Rkdjg5?=
 =?utf-8?B?K2tZcnoxeHh1czVXMU5Tckdhd0liZmIraU13REp5K2NvbHQxWDBlQVVpcGlN?=
 =?utf-8?B?cWZaakxObVZIeUJMSERzWEZoVkJYT0lpMEF3ek9pd0NOOWVuMmdRcWJzTDFG?=
 =?utf-8?B?RVFKcUN5QlFiZmVFMTVEK2hNV3RkaWE2bUJnOEZpUVVKYkVRWFZuVTc3a20z?=
 =?utf-8?B?YlhJdUJoa0R2bHc4MFVCTWg0dlhNRERkSlZMSFlaNWYybDEzcDJaNzNKS1l1?=
 =?utf-8?B?cmZ1MEYrTkFPUEk5ZUpUYkNsV2tRcjRCcFZRdEN2b1VvMkxtNDNCSVJmMzdq?=
 =?utf-8?B?dmxBaGl3SWxWdG5NVFNQdmd3aUxyMkhkb01TaFpQZndaYWNjRFM3N1Rwclh3?=
 =?utf-8?B?TVorNGZmTU5lTHNHK28wMnQzamVmT3lyQkZFcUljS0tGNHNNZjg5WE4wUlNh?=
 =?utf-8?B?c0lCRnFvcDF6UFdCZnF4aDNBT2N6UXk3MThwbGk1N3BFbGo1ZS9vRXNNU29v?=
 =?utf-8?B?ZHNNRHlsV1FVVVZkcWZRYjI0WEZ4bHhwRUdjempFZGYybGlZeWlJRmZxN0tC?=
 =?utf-8?B?VWVvbk1na2hBMUFXeVNUR3AxVTZvUFl6S3VYcFJvaEIxWVpNYTNEL0FCZWdz?=
 =?utf-8?B?WjdqaHZqbkhEVG5kQmErVjJmQjRMWjJ0Vm84VERhdENPRU53VmIzWG0wQ2FE?=
 =?utf-8?B?SlkvY1h3L2FHZFZYV0Y3TjlhazVZdDRGN01LMS9CT3FkNlhMSUptdkdEVmRm?=
 =?utf-8?B?bzdmZUhzQzA4WDNpdXhqY0ZwbWNXV3RYNTJwU29Kc1FIODYxd3FlOWpYOW8x?=
 =?utf-8?B?RXZhNmZMeDh5ZG5Hb213aVErdDZwaUxjWUZZQWhCWjBmQndSanpXZS84Ui9V?=
 =?utf-8?B?ZnVoNzZnT3JUZitVRStOSzJXOWlIcVJBQXZQajhJODFzUFVGamQwa3NJRzlL?=
 =?utf-8?B?cWRSQTJMQnhES2NJQjhsNUVKMWJXeUR4b1JPM2VNRllNWUFNNEtXbms2RmNN?=
 =?utf-8?B?TVMwdWRCcG9oZEtKdkVIWHgvSkhIczNDek8vcDR1RFErVTNDTm5Balk0Tk9O?=
 =?utf-8?B?dXJidmZZbkZoYWFiUHJhOC9OZmtTUEswNng3SnFldUFNMFp5Q1B1alJ1NlJG?=
 =?utf-8?B?TGRTS3FiNUVZOEVwV2p6ZmRTbTliMzhPSGsycGtHa3JTMlUvNUtFcGlaZmNT?=
 =?utf-8?B?TUJ1eDBUcld1VDVXMm5JM2U0dzdEN3NlclhOeVYxQTNGbm5MQ1lQWDVIUjEv?=
 =?utf-8?B?QkY0RDVkUE1rQWcvd2hUSnlISFFqWUJFVEtONkRCK1EraFVNM2dRaHFUWHJO?=
 =?utf-8?B?Y2xyWXlaWSs0MzdQc3JFRGxyc0pZT1d0MTZJa2hLNmpxSHIreGMxbXl3WXY3?=
 =?utf-8?B?eDZZbHZEU0ZBT21QYmFENkp6dk5oM0JIU0ovazRjRXJXL3ZWSnVxYVliM2N0?=
 =?utf-8?B?YURrSVVpa0R5TEhQcjFFV0tlR3k4aWJCODY5Um40MzBSZDd6dW9TUW1YNDB2?=
 =?utf-8?B?RGpkenBDVGRCRnQ1LzREa2JPZmQ0YU1xTXNWUmtOR093amFNb1ZYaG5EaU02?=
 =?utf-8?B?V0RDMkk3bnV5RlVVUThDa2E0eEYxaTNVUGxlL3FJODJKTkxzYjZobmw2Wk9r?=
 =?utf-8?B?cjZEZEtGOThvbURQZ1dWWHZSajk5U3VtWXZ0N2Y5cmdhOTJtaEowSGRSd0Zq?=
 =?utf-8?B?dTU5QWhiaXpMNGEyNzM0SU03K00xWUFwSUdMY01saUE0QmgreGxMSWppNHQr?=
 =?utf-8?B?NUJ4blNHckt6aHYwamRYdFN5bkVEaGtQQzNzcWxnSk5hUDlORVZVWWNpMFNh?=
 =?utf-8?B?aWFTRXVQRzZLWHh4c2RralZYdnEzRXMrdG1CT1pIaDZJQ29vSWN2ck5Vby92?=
 =?utf-8?B?SUJhVE1aL25HcXRlY1FwWUxucXkyWWpHemtZY2NGdFhCR0RsQWlnaWIydHhY?=
 =?utf-8?B?cW9uRUpxYWNNRWlINDRDRU1iWGp5bW9nMXdOT2NiSVJ4THhJZkRxS25SSzdJ?=
 =?utf-8?B?cGYyeDVqNkR3Zzl0SnN0dkMwMFJYYmxLLy82OFJ2NGVmMWFabnJqRXBUSmk3?=
 =?utf-8?B?bWV0Sm9VNHNEZHhjVFZBT3RFaUVuK3NiOUxrNVVHVzcxRkM2RGVQZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da74dcf-26b1-4093-b139-08de9fb62adc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:28.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLXfx8rZGrWT0EWSYtOynl1DHW37qRUxvgjE/i46PJW8T4le/tpK2mJrushn6xQM+xjyhIFXWjllTkEMREJReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5523

The current safety comment on `io_read`/`io_write` does not cover the topic
about alignment, although this is guaranteed by checks in `Io`. Add it so
it can be relied on by implementor of `IoCapable`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 1682f2a0d20d..c6d30c5b4e10 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -216,14 +216,16 @@ pub trait IoCapable<T> {
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_read(&self, address: *mut T) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_write(&self, value: T, address: *mut T);
 }
 

-- 
2.51.2

