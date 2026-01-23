Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AD376467;
	Fri, 23 Jan 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163925; cv=fail; b=fkhI59b4oDhZBNg/qm3B3et1TvPctgUWDizKjCB3ApwDL1MCfQdU0F7xJgC+ZNKa6U0E3leb8pnPb7okEh92V2rgb+JSmF3kr3fgaQMStzrKUuKaPUq3+ryidQHA8Ewmv3gIQgIZ75K3UiUt9TWTQLAElTwUcuHPNMY5rZRiJA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163925; c=relaxed/simple;
	bh=wkXQ+56JtgoX1V7mDNB3lwnMWQa5BQHY9Eo7XPKFcKA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1FtbqIS0IBu2hx/4EfV84kdQ/dXjaRiQde0NCLDzizMrDZXRGr78ko5qoWR58QJnw9xOyHjF/0SXscrIP1W8ECKpHGRkkNFnZ7xBZemtIAU6f38slBsLco+TfUBX6KZV3+cqwpXPiDlAMRnJCVROCo/XCZlzjtVIEI8NIRbuuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hOMqqElw; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hOMqqElw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chXxahhemZJToduM+FkRAKS/m8cT6tZTghYqCVH2sSx+nSS5qyz+Gh9kkS671OZt8nVcNo7x+DTH0wkK7XtUmg3P40g0iX3ckj36t7PVBuRTnWRH7WALWXCiIn2DO6K2Pa6AFU2CacFlwhGFeH6WMq5H+KutRYT7NURMew6WkHo3V3oOtAtDjrUkNsS/rMEEr7mtanvOiSHfayO1NbP+78wN7j23Di+WONx0dwXUdtkdamMp6vWLnkJc6D6gQi4doshRE/xa/0K5o41i+h4Yvkvgi0u+LGXqTdu1I7TAj7GNoytJJDgrzl7Un2r5qfoIiRqQl2MX63AwKKun0K/g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iPIXTQ017haYJzvav+u3IFeMoctWnOwcsc5Py5+iVQ=;
 b=ysRttMbMi3S+HmRjtWcdEdotW5wI6VlOTXB8AzTjIMn1ZIrLI3scPvz/jhFRPlfe5KY/pOy+bjcdUD6QDN1Avbk2jkfYCe4ymydPOZE4k+rO2hn8KoRNuvupCNG/7+mk5PQIOhXuxpwWIxW+9vHH/vcxMX6MG0blmH9ThjwSFvESFRVHz3huxZvfI73YXH/a4ygAaGFjs4J8x0S1WKif9F3qJEfiIUOaeOGCGKpZFQ+Q03+fReii/2K6WyAtdwmgJ4kQ6LLxRcY8U2iPsvdbACYgeGuKlG/FVpwD1j8B/ARde5Uk6M4RjFUBLOUVcKq355W6IfvGEX8AaMhvaPetvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iPIXTQ017haYJzvav+u3IFeMoctWnOwcsc5Py5+iVQ=;
 b=hOMqqElwHYNEwjqkPYwJC/mhAS9rMEtMHMHOtVNssHLHdpGNdQN5pYF76ijGeZNgmCOGjFpCcfdQN9bZYxeB8wUyKYgRiUrzMf1TK9Ho4w123xnzOkxaCXypXChAKLITa320WVcPwhZV1GQ59KI/BPwZrn0cYiBQtoZv0ET+BcrqG4t1LRGBhRzvS4UWNqSpr/SZEqGjXwGlYpcwJLN5j2ZsFDCp1NOMgHPLWEZPG6jVyLwM3mu9KUl2ekNj1sYc7G/GeN4QOkzWluuv6ajuNx1xf0EMHfqLQQI9XpxrxqNxzuSZJzTRb5Imw16BhoBK2iJVEWHvL3tSOZSz4KaMEA==
Received: from PH0PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:e::14)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 10:25:20 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::49) by PH0PR07CA0039.outlook.office365.com
 (2603:10b6:510:e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:25:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 02:25:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 02:25:06 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 23
 Jan 2026 02:25:04 -0800
Date: Fri, 23 Jan 2026 12:25:02 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Message-ID: <20260123122502.006a01c3.zhiw@nvidia.com>
In-Reply-To: <29a1e16a-e50b-4d69-a6fd-41d11ca9e393@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
	<20260122204232.15988-2-zhiw@nvidia.com>
	<29a1e16a-e50b-4d69-a6fd-41d11ca9e393@nvidia.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: b7429bb5-5ff9-49f3-7d38-08de5a69b5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESPDWfZQVlC+gy/OUIcyVY4SfQC5t3bWUhzsiTV0NbyCgFyO0TPLFKpFISUp?=
 =?us-ascii?Q?C/Tf2AAf9rzd9qyt8H7gPL1HBrFWQTbHzhNhBl9PLjQVV4xuWJcX0i4L6ML7?=
 =?us-ascii?Q?PxaAMipFoLAPgeBnIOHksf2TuV1sUqQfJKO8Mkx4PLTgno6bJ42Im594vcRM?=
 =?us-ascii?Q?9rlb15rdVLrSaUuLFmXt62jL8IfZi3HCfOeQ9xo6YbOrZa8y25+PG5ABiHQB?=
 =?us-ascii?Q?hmDPXVJAQMIHs8jw7URGV6S31lTkxm0V2oNwgpXDu0GywBRdnvHQ0D7uEYHV?=
 =?us-ascii?Q?L2luspwUTRpUWgZe1owZMjWL3AnpmO9TmpnshPP6rfDlCvv4tdK5CzcpzSFc?=
 =?us-ascii?Q?PSW0k6+CHfTKzk9nrk9Pf/UGm+qfF/UuvV7ioQM8Pp85C00qQxnETaOIurwW?=
 =?us-ascii?Q?Hs70ZFsTLmdQltUMg/ZOyN9BEMMsA12Inz53HCuuLz2GqYKGuajceDNGTEpx?=
 =?us-ascii?Q?OPW2HJyKHq6eNcwPIuQka+p7URpl1R39jMHlDiTVpyU19CSjUBLBueWXOz+K?=
 =?us-ascii?Q?Z92Pi24Qc5+2QqrtnOfZu5r8CzfUNMmTJfIRrteu1Swn6V4eCb12VkXo2FUF?=
 =?us-ascii?Q?CfsYLw9SXfCU42ekcJb0P7ZHuvHqalA5NXcn7cudwlpSLY5b8iJyluPaSRqP?=
 =?us-ascii?Q?+BlNFwm8nUxPHymJKoUd3mo+QfO+FiD8avOnGr5yu1LnSpeQmMNYRVWyy9HN?=
 =?us-ascii?Q?VI56N1gEiUZLK1CYyyVps4q1YCBgeo+c/8kCE6RTtoUsSv95qzCnuXryznmp?=
 =?us-ascii?Q?hqNcZPTR2oKypty0dDZFmfmrafmStAusyq/RMFZHiW2wqxwMT9/vFW+47QZ2?=
 =?us-ascii?Q?WVdZQz61EeVX89EHJPmuC29MqFuQ7c68rJ4SCUMa5QvC6qRb26cmW+z+2Q6D?=
 =?us-ascii?Q?L8Y7i7MODO6A1LWLRl4hi2l4m1eaa8q+2ITEd6UAwvbIt7u12lB/l+9CB1dr?=
 =?us-ascii?Q?7hG4RvDiRi/JI+KsTYme+VL+RaohbMs+p5EQe9bpLwzT+tWW59GAzpXSVWi/?=
 =?us-ascii?Q?2XpXZklCRJaUd7ml/XB01SODUn1MGgLiHaBgIpyNWyNFyA0BhVSTtsXkPoW6?=
 =?us-ascii?Q?Zz3sYmXy6xGV9M+n+AZ6C7XuZjoMxGJ1TNFywfzgPAWFB64/d8iBB+oLJMa0?=
 =?us-ascii?Q?CKPWtJRJcdODptw6nQs3YhdPVfQJ9RVeMr04H4H8zMlRecHkWMOQ6mQN9/Xa?=
 =?us-ascii?Q?XXR+O36FOIoZfCbH2uOCCrWxZcfaGRmMTPl6uBxt3UQ6t0GL3NoVl4PoNnwD?=
 =?us-ascii?Q?LrxIIinClZQKvf09WHF6nozi62/tQm7TdDh7nY85y0Od7H1Rtqkt6V5K/tU0?=
 =?us-ascii?Q?w10xmnVpAnoh89iZF+6aZFYIsVpbIYmxRda1xT8z+ktI5rFlbSgIWBhv14cU?=
 =?us-ascii?Q?kK6d2hmUvdKwakxq7PHCs7kxrxz3tmPH2pQf/701tmgytSMPSC+FrMDryQ+9?=
 =?us-ascii?Q?YA7hKXzCIYiolftikAD0AnHSJthHmV5m5mcHOK9wGPy6nUEbGYnXk5tvdr/B?=
 =?us-ascii?Q?xVG9pb3NtDYvtYZ+ZjgyQ5OxAYnRyWgb4zfsrJazyxeDNU/sRJ5PEiYC4hL4?=
 =?us-ascii?Q?f9RE25wU2YFHMwXMR7TlmphOHuY+kZHXSRBS+hoBiQygbsoQSzizh7EAvo8Q?=
 =?us-ascii?Q?Fs7BaDYiXGfQwCQ8sK4AdncRyfNxYWncsiTSYP9DlnVsKownZeyYl2NFth4U?=
 =?us-ascii?Q?AbHstA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:25:20.2429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7429bb5-5ff9-49f3-7d38-08de5a69b5f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

On Thu, 22 Jan 2026 16:17:55 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> On Thu, Jan 22, 2026 at 10:42:30PM +0200, Zhi Wang wrote:
> > +    /// Called when a userspace RPC request is received.
> > +    fn fw_rpc(
> > +        uctx: &mut UserCtx<Self::UserCtx>,
> > +        scope: u32,
> > +        rpc_in: &mut [u8],
> > +        out_len: *mut usize,
> > +    ) -> Result<Option<KVec<u8>>, Error>;
> 
> Exposing a raw pointer in the trait API means drivers that want to
> "reuse input buffer" need to write unsafe code right?
> 
>     unsafe { *out_len = ... };
> 
> I believe the unsafe code should be confined to the abstraction layer
> instead, not in the driver.
> 
> How about using using an enum return type instead to properly wrap
> inplace versus driver allocated outputs?
> 
>     pub enum RpcOutput {
>         Allocated(KVec<u8>),
>         InPlace(usize),
>     }
> 
>     fn fw_rpc(
>         uctx: &mut UserCtx<Self::UserCtx>,
>         scope: u32,
>         rpc_in: &mut [u8],
>     ) -> Result<RpcOutput, Error>;
> 
> Then the abstraction handles the pointer write:
> 
>     match T::fw_rpc(ctx, scope, rpc_in_slice) {
>         Ok(RpcOutput::Allocated(kvec)) => {
>             ...
>         }
>         Ok(RpcOutput::InPlace(len)) => {
>             unsafe { *out_len = len };
> 	    ...
>         }
>     }
> 
> fw_rpc() as a bonus also gets 1 less function parameter and cleaner
> return signature.
> 

This is a good idea. Noted. :)

> --
> Joel Fernandes
> 

