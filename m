Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756C3F1064;
	Tue,  8 Sep 2026 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901330; cv=fail; b=BHceYiZpb3ppGFrqutqaDCWJIMu/9LPtqsJ9/OEHDVUEd4vtO4cfpccchtJfm8f5+LgtkGxGrdqVYmC44Iu8PqKa0dNVBa/MmZ0BCKvpoDckg2wBZBxDHnNpEwevnOyn16jWVbDtzrXx5SU3an36GXxtuhic74v5CJGGAdLRC3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901330; c=relaxed/simple;
	bh=UXgdC8DW9vowYk8Qm9Bwtg4G5Mv/d92CvyKNeBrA01M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzyNMg8iUKr4UJsW/9nAvsdk3hOxf1VuyRk9dX3AqSXh3MvJxHy4gd6prv5RhGZ4kOYV4QZv4vsL53j8q9iII+urfH96Te4YfVtzGO2nxTyWxR//koiu/3WckM4G/Eb6bWg7XXeFM3nJc0BGM9tBJ9j3ZBDTr36B8vh/m2vsSNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neQn9Hu+; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neQn9Hu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPKKclhGH/RInChCr5VwrvnIEzQja2EE2RgcS3U7UYhedOom08Ii7XXh6Q4NjO/QxpfCGweNKtbqiZtdODl1QRqah9yNtreAp/zRqWgMV3IRMmDvq2Ij4b8PumF5TPa9+/ejKp6yJVMvP2t2WjhoCZJexzcw2BliWOQ03eZJq+h0JrOUrapfBsFxLK+7cEpXzCdMSGGv5YWF8mqct5TLcECiD46Pbd1lLMM4b8RdWG+NNcP9+rxLo/GkSX4jRyTSPI+y/9D6gTLHg/9t+GsNUXETAia5XoC8TsuOXMtLj5AAy9n8YvrcDxxWGcC4Wopib8N1cxRylg9YpL1ACWrLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBAWwAbLgWb2CidJZKVQQnRFdFzB4hgSoxCfAwgY6nY=;
 b=M4tCEWSH0zD26gYlpCyj9LRyJBkhfx9yDmej3CPuYROew9J1Uh48Cc95MhMmElNpZSu+HT0Orl2GbJLn2Q4/QzjmQkBc+cD6253lHD9W60ZT/tNt1LwMiK2E6Y321v7w7VX5CVxk0cdN6ikvuLGluu2MiWjEn4L2TXCj8I7kZ6G7pW9Dbt2opqcLE0Yp9//d//ytRONwILgkL1nZy6grsXWcHTbLm+XDfKlT4fWUxhs1aRwAxAKLy3/oWQxOn+Rr5GH5tu6GS9l4y4u5SPD0sApB6bl6ndPvGGX1n+gBbh9pctVSGCEph5SYE6yCAJkhQUDgEcGYBT6VxlmZ2KWdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBAWwAbLgWb2CidJZKVQQnRFdFzB4hgSoxCfAwgY6nY=;
 b=neQn9Hu+zDZOSq/YQtlZ9ph3kqbLkZ0SQFyUY9nLhGAHKRN2BGGgdmoHFHk3RTeOF1ChKXLOr2HOSy/95aJB723GusyOmdFwrSwPbvfynMUE/j4dN8UGvoSAaQ1TVNruB2JmE/ucSmvq9UtlAmXeeCdNEea9Zzoc7HZC0ITX8yfzSxJaDenEg696+GqtRsoDs8ja5Qo388F5qE6DZPiL3BKGUCnGE6C6r5zWd+AOhe42/eMTyvKRqFGdF7//yPepC5jnECft1mo0S74DLUmyHrveKHX1ZENutOgZ0gRPbtDRlnm1JGGd+KglVuQjAdEMdHpboHF96wLe45JP5xKBKQ==
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 21:01:56 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 21:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 21:01:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:01:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:01:23 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:01:20 -0700
Date: Tue, 8 Sep 2026 14:01:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <kees@kernel.org>,
	<smostafa@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <aqB3nlEUS/XAB4H5@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
 <178846311316.1308030.6266899352044838554.b4-review@b4>
 <20260904140906.GR4157646@nvidia.com>
 <aptMynoQtAf1Jcr5@nvidia.com>
 <20260908163643.GB2779763@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908163643.GB2779763@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 0907461d-869e-4fd7-d019-08df0dec6a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	NwviJQDCxQdmjKZ9bDKZPbVhZyvkm9g3eFtTBxV0/v1YTx8PO29NQac3UDjqVuTvov+hWi7K5i8HW9CCCDjGvuJZ370yHBwhVwYvtrIs0ozfzImP7PvC5kxnpY94jg8HSOgopigwfGvwKJCGMqAWbgJ7kkf065d3oeOrMUcFKZu+usdMqP70+oWzogYv4K38W3hbTqtZOCvqbFNa0lC81ERUXKyzc6IwLDvdJf7jvSqFgU/GEwimUOjCtosrUlVUIg41p5cWbaSvEf0czOVN2qOh6iOhuSfzRfZ8Flmg02XlEBE3gJ/N5Dl9LFHAqD6sFTcDw0oFKmIkcC+WzuBCu0Ror6yJrO/RShIGmDe7zSbFZcmckEDxVWgh5LI8+HzqEkWY8E78Q+NT4RiKpjThScPGztjPz4QWfoCauFIW8q+RT2S5f7RaMxpFyjffkAHaiMECkySp70u6+CC1G2WLsrB/wuZ1HwbTdddED5cP2NqcIoecf9QYliwIeBpN3CZEf+/80lxeGIV0kNsGMW3uHi9mSg9kllTUjcV+BCH/BztBsXRUTjUNN6PglYabq6zHMZLlUOlcS5znQTaTZcFcEQJnCQ1veecm4OmfbLjOaeEXF2pM4f6k9A9Nb3MPfVq+eVfa22hX9lfv6hyAPRTIzmETYtjwrPk1QiVBTtoed+XwOWShf+8qE4K0cqiasknnRPH/3tpuY5yzUMxsJl1X4A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2UxsOAgUGVYaFPlLW+K8LdDgp5Huby4WPo9EQt3HeksR7M2hQKmoA6lDabsWKczHArq4hjB40Wnc6Y9g5xYkyEDL3dyli9B3jyqbsvXMifUMaZrfkfjuV+VWFMv1dKs5GOG5ASPLdQ5Q/N6/NO2PtpbM94sNkGqSxhdy+epxgA81hiLlKZyi41OQ6R4j0/FIIooIST1LYTvovDNhsF8mBXvWAsi9L1t03lHCPBHZublMdJorCTuy83u+YvT915eo5eB+oQvUDuQw2RsmJlduS2BbgUJ7F2RxbJNiUnddQF9ZKjvevEBXL6qHHsFfTmwF5riUq0XdFLzPaJOkB6TmCQBBLf2eU+EeXmQ1s7e10mj+YeQVYGiIXBdhM/o1+332dpA8IKwlAFwGXbzISSAuRy0MlYvN2HkiZceErmKHAodB8EtzxG8XoMbX2FLWqls0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 21:01:55.8813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0907461d-869e-4fd7-d019-08df0dec6a72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781

On Tue, Sep 08, 2026 at 01:36:43PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 04, 2026 at 03:57:14PM -0700, Nicolin Chen wrote:
> > On Fri, Sep 04, 2026 at 11:09:06AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > > > Also run the drain for every stall-capable master, even when the departing
> > > > > attachment did not enable IOPF: such a stall event has to be aborted while
> > > > > it still resolves to the old attach handle, 
> > > 
> > > That isn't the model for fault handling. The fault is delivered
> > > unpredictably into either old or new domain. It doesn't matter which
> > > one.
> > > 
> > > Domains have to conclude their fault proceessing before they are
> > > destroyed, and attach to the a non-fault domain has to conclude faults
> > > before completing the attach.
> > > 
> > > But there is no requirement to deliver faults to any particular thing.
> > 
> > Edited:
> > 
> > Also run the drain for every stall-capable master, even when the departing
> > attachment did not enable IOPF. An attachment has to conclude its in-flight
> > faults before the attach completes, as the incoming domain might not handle
> > a fault at all.
> 
> I still don't understand from this why an non-fault capable domain
> would need to flush on becoming replaced?

Actually, I missed the part that the iopf core already resolves
this via an IOMMU_PAGE_RESP_INVALID.

So, drain should happen when:
-       if (master->stall_enabled) {
+       if (master_domain->using_iopf && master->stall_enabled) {
 		arm_smmu_wait_for_queue_drained()

And I will drop that paragraph in the commit message.

Thanks!
Nicolin
