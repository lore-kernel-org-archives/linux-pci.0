Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8248987E;
	Fri, 31 Jul 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490408; cv=fail; b=T4oAjGZ8Wp4k8OZyre05CLCpnFa1o7p0BIDUkrN7cYU5phtKR9ue0dWn6qjA/P+g2cRlFP06fOoD0XPZbEl9nhVGEq902AuMkrwYZ7hGp3SmuvbTTuM1ybzKBJWOWV/rKg1fWBC9ohfQz3Lt9rQns7UngYi35Q7kR7WS5+LTg6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490408; c=relaxed/simple;
	bh=lvCratnRvPs0cVG2pwSkFgEwzucD9yjQ9lPN7/4rT4k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yx4g00yQEIBbtwvsdUiwH9BeTUGS+Qddcg+SMg8ds+MGnoljf9l6FOU8KYVO8xxnLrN6yVziteKBqvWeV6WINb+nt5gTEIIdlBnG5+kNQqW+xD/rzkVi6cWZwFzKSqja++vo2ekcuArGa2AawHH3/QRwmmglQ6d8IOoJXy4FvGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vvk3LvhO; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vvk3LvhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fREIaKPzD0uiKa8/+pDfY7TqbMSDn6Jy07pxWFoeIujNVj4M9qOWAa+e3Ywbpp/r7a6IJJgHzpo62apSL3JY3WwerNAQOKjiQwpko6RjHdzHvwBlxBEDE5IZvNIqDzKzCNw0MJf2Ge+JNKEaHFSpXYIr7Hd+kg6RXvZT4aYRxpXkeSW9+7nFYRDj5Il0fFAMOKu+CzHalZpZ6pc4cXMYPReGZ64iug1HTfMZuynvsx4l9PSXuwyHRFSmkdN7k2+lLE34qDv8KUhhgJ3LbbFm72llN8kJlBNIe6h1bSGXLaupgggMj3BBW4D5Ws162Q+cKbZhJ+6yxCM+hBawq8DYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3F3OHBToXXlr7VDSPpOt09WjMUL03LbITDQSoYtUR8=;
 b=Br+sQN/k6B3uNnkhGOIXGbVaz9Z3cMlBsnha26kEX3APl7h+09MtzUOwO07LnW7ux9BWen/lnQ8RnjJBe8PN2wVy8Mbcao51FO48DZoWtldhd5ppVvIR4DXDIF3r784FH4n6ql7/kICBOTp306Ofa9SPW78cjXOZl0Tt8J6xXSzP4XU/uRxN/5dwpk4w1O7YgAEWGz4iCR2UVzTUK3esy3pwn790lqCDpuR+S6O6Dt0iuMwxVHZELY2OaXguCL3EBinAhH5I1qTYA7EudjGtnFKWQwq6Yc7IGOviuuddQZFi3qDdDcU0GIqCRNroKC7ZDfbb38kN+Xfmt5tcaI9sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3F3OHBToXXlr7VDSPpOt09WjMUL03LbITDQSoYtUR8=;
 b=Vvk3LvhOXE4OGsyZO6hU96Td7ejYvSERiq/c3IMWc5OpYpJRcx1zmbdsCGe7t7+yBMkOEPKQMqwOBBCKAYdsaJwe8i2ZR7Fk/9vvf8B0yyac+hU81s8z8NX1Jt8rOXdyo33IK5/FVJduYKC0f5rfSBCHqZPEwb7ciJvPrNmkbFhjBJnbQoxBOtWy9RYqYgYo70At3luV81ixKyeJS9DUsRKjHZzRVzOmeUS3I/l88LxbPcQHgVe0Mih1o8xgMS6UFAnCAJxeTnOyO45Ck10Jc1fjeGsTCr7OrOvRFR5fRh5EFhbE89XFbjdyR/kd5t81fgk2bFr56lww6XsaFgRwSA==
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 09:33:20 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.9 via Frontend Transport; Fri, 31
 Jul 2026 09:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 09:33:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Jul
 2026 02:33:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Jul
 2026 02:33:01 -0700
Received: from inno-dell (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Jul 2026 02:32:55 -0700
Date: Fri, 31 Jul 2026 12:32:49 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Gary Guo <gary@garyguo.net>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260731123249.02bc6ac7@inno-dell>
In-Reply-To: <DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
References: <20260730182954.783568-1-zhiw@nvidia.com>
	<20260730182954.783568-2-zhiw@nvidia.com>
	<DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 17790885-cbe0-40bf-7904-08deeee6c22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lsLOD0en3A2jj2CVRBb5ye4z1cjTXpgjhn820+HRZ8SMkfob7rjHPlrgohQBY3Jho5ROGDxJay1KE6WXMOwgtQiHNwKyvkB4VvissGq5qge+B9uTGHiUFBalF0aXxJzLuEfSOGZLlLeVo3WXGZFP6lQwKDtsiTdfepZtmAuaTNZlBnGU/bm+ROIuadIiLfJvlo7EkQzIbp/6UJpJ+p7yE8rgIfig/E2EGYsFSqhJ42OYo7NPK7MZqysVDK38uB1omKhBmpK76J3W5Lu8UVds7x3Z+IO+dGnwD1VFELET5P4mGQtnOlLXmL4T2YzTfCih12XgW9VHDMGxpkjxyLB96YG9ukujkvzGHAs8T9ajPrrj0voZDDV7s/ZXABwfXoZ+qAg3FzspQ4yNQbVjt+bKXSaIr9DiYvNmsbEKFY9sMd8MS7LisTy5PBuhJoezypWEN9skT04zDk6R6Pv04w4gO7l8NUPB6sEjzppRwILfUa+3Fa4dOe+siRz9z7/WbEyXTfFgpvA6uOmFXC8JanIcI/mjGNz6+p39y6ibK0rO9PRj/aAv59FS+0ktsrjGjXTuns6SRZ/jHq3jqo6K9wBmwJd0MEKj0gAsOm3YNzQnpTmW2Ca5Rw+FE+us+mRflm3U3lgA87radcsh5u1D1JGuC84XK8SzO+zb/4Ru2+XsqhxR2JXN/cYnYKTup/1Hv32yhiaK0dCp4/CGfbLXuJsWHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qoaEEetITe48TNAeeKFM9oiv7gw/EjU0qhQkWzF/NKrDJeQlm60havXlwr5ZwUA5emHDIb294/1d2ZehmweqxKIRAANl9DX52jNpwyeXyLim4lrmmCJJHwdioW7mW+zon327PiA5z6xEnAjM2kuuTDekxKZQT3r1CInnNO0r79qCbmATLT7JjLnfSK+7mev96ZvqUQPe7dvpdZukkNGYwnku48aeYyVYyLa42JYrz5QrkdvqO8ZDQ82UTj9s7fTMjOehxrAI31KpEgyUYW/xPpfb9ShS09oNx59mJ2qTA+DQwiiVUhpZljwY5JMvGyxMxsW2KHmOAvmxvZoLVNTzLuHe/tkP+PgAAX2LEh0fQel4gThWwwAwpEVjt+D3R1MBsftVqkTOnLZpKjhFtEcoc7OmspVn88Qb3Ck8Q4yt7z4haBgcluOpNYvHJlC2uxdO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:33:19.9023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17790885-cbe0-40bf-7904-08deeee6c22d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

On Thu, 30 Jul 2026 19:45:05 +0100
"Gary Guo" <gary@garyguo.net> wrote:

snip

> > +
> > +impl ConfigSpace<'_, ExtSriovRegs> {
> > +    /// Reads and decodes the VF memory BAR at configuration-space
> > slot `bar_index`.
> > +    #[inline]
> > +    pub fn read_vf_bar(&self, bar_index: usize) ->
> > Result<ExtSriovVfBar> {
> 
> Do you expect people to pass in a random index instead of 0 or
> next_index? If not, this should be an iterator. Otherwise it'd be
> possible to index into high part of 64-bit address.
> 

Yes, that is exactly what I want to avoid. Looking at the driver again,
it does not need random access, and I was thinking to make the
interface more convenient for the driver and avoid ambiguous numbers
from driver. Alex also suggested an iterator in an earlier review. So
having an interator makes more sense. I will rework this into an
iterator in the next re-spin.

Z.

> > +        if bar_index >= NUM_VF_BARS {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let low = crate::io_read!(*self, .vf_bar[try: bar_index]);
> 
> Given the bound checking above I'd use `panic: ` here.
> 
> > +        if low & bindings::PCI_BASE_ADDRESS_SPACE !=
> > bindings::PCI_BASE_ADDRESS_SPACE_MEMORY {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let is_64bit = low &
> > bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> > +            == bindings::PCI_BASE_ADDRESS_MEM_TYPE_64;
> > +        let following_index =
> > bar_index.checked_add(1).ok_or(EINVAL)?;
> 
> Just use operator here as it cannot overflow.
> 
> > +
> > +        let (address, next_index) = if is_64bit {
> > +            if following_index >= NUM_VF_BARS {
> > +                return Err(EINVAL);
> > +            }
> > +
> > +            let high = crate::io_read!(*self, .vf_bar[try:
> > following_index]);
> 
> Same here.
> 
> > +            (
> > +                (u64::from(high) << 32) | u64::from(low &
> > !VF_MEMORY_BAR_ATTRIBUTE_BITS),
> > +                following_index.checked_add(1).ok_or(EINVAL)?,
> 
> Same here.
> 
> Best,
> Gary
> 
> > +            )
> > +        } else {
> > +            (
> > +                u64::from(low & !VF_MEMORY_BAR_ATTRIBUTE_BITS),
> > +                following_index,
> > +            )
> > +        };
> > +
> > +        Ok(ExtSriovVfBar {
> > +            address,
> > +            is_64bit,
> > +            next_index,
> > +        })
> > +    }
> > +}
> 
> 

