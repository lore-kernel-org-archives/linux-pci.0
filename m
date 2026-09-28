Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CC478842;
	Mon, 28 Sep 2026 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634578; cv=fail; b=XImhcX0TZbtlozvOvIkOUCiTxCQqObDFqTM0k2x2Lk40A3/EP5H8zhWKg2Ii3LEC5B7heaRjHwkGWfZceDEHmM4iK32pQxnU133HsDNnC2fA79ggrjnqSVu758WKrWsDUZhNDGm6Z921xitnOJa0G4gHz9nEOX7Ofsui0T32yhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634578; c=relaxed/simple;
	bh=NX64wE1vnb+JJA/0t53OorDmSWgFOd3it95n76iurhE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtdn6pBcVV3FbwERvk+b3lFUhdEPU5wVUOTnQ/VNgUjWGAzLQ6dPcrD9H5nMK+YcnPgFyIR7hrMjXxI7ob6cWR6nluJR/qWBDV594tMAGe2IGxunZeFJ1BonAWVIzia0cggCFQ6ukXG3t9kMtUB9neU8czadPQT9qCUm/be1pG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rja9iEY8; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rja9iEY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7mePuxpKvJ40T4iHTrGP+gydBYd0yQuj60yqby5Wv+Sr0g4zU/zlVA0SKBf5qoZX2epxUNIYPnfYn9bmJRAAnmeUznSC2h0xUq37xhVlOyvsxhQzTRT2i+NX+H4ORjrh29qXzd7llzuUF3DbmQioBWV8tpy+rksWlCS2tPmlYSEI4Zmnma7+6dsblIlf5IvvdnKALL3UDNpDPlkDXAcnPEGsnJS4XbVI5S/OI2VZ1k2ccm9O5jqRjRseDAuTxapwm+y2DxsmV7VpnMZyfDfK6HmtprqUBrDmuHfjaOL51SA8AtxhGevfN4D3AkWYbPgz96XVc6/eswThMHha19GQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=412pjYRAbHCQ7VuHA6+zqc2SlC6XKCjC5ntrrH3uZLU=;
 b=ll+Jk/gaCEsrQwgfQJckzWeRde1Pdi46UxFlbNZfzoYLu+hV9CC02IXqiGbvGbmhLFY+VXhKylP45XOAfUT3lIHCQpSSMhOnwHN9Cxbw8K6rAwh49wdXqj9RSKzP3yXXNsxqlm0YWkJ5CZXV7PVYTVL86cPOTwJq8JFqIFcWsdYZrqlQXpovuKVELlGk6Ef1fwZ1QLfMp/9vagog6zLx7w5yg7aSYdbqaXsOpJpyLG0nV0lzfhje3230jK1DhFVlQP4OWOzc1DpfcunvlllAH/DKDxmqlXWa14eTBH3MOUWJ76mcToT71zT0u/HrdY3RufqiiaUBMMxRbkblKfw8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=412pjYRAbHCQ7VuHA6+zqc2SlC6XKCjC5ntrrH3uZLU=;
 b=rja9iEY8t+7ZVHg7vwKRKlv8M6DUNg6G0qb1AUmSI44qRiB0ZBkoT66icXRAX6V7hSF/5pUqXC7/3jj9qKZdz9TRKoizLD6GF6YOBlJPIuDegZW/wgxSIoL6mHIAI2OYuzEgwYqG6+ki8WDUQkkYATEw+5f/DSJhPPjWZMV85M9H0vs1Z/nfW53w361kQeDnzhnSYg834iNch/0Wq3epFsvMck6JugmCcCE8EfuhehY9clKlRGVOR/vkVHkhjyMIP1xorNzxbm/i3tEFRKNV+LLrHeci6AtBGNLi6oIrL4HqSQUX9ZN5xJcIw0S1gezXLVZ9e9LpDYOxzW6Dp08euA==
Received: from DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::17) by
 CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 22:29:26 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::55) by DS7P220CA0093.outlook.office365.com
 (2603:10b6:8:25a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 22:29:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 22:29:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 15:29:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 15:29:06 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 15:29:04 -0700
Date: Mon, 28 Sep 2026 15:29:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <arrqLmlco3TeC/lV@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
 <179018862538.3334538.17643821143626392419.b4-review@b4>
 <arRTojIlWBOF57zO@nvidia.com>
 <20260923233920.GJ2545495@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923233920.GJ2545495@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 237dd99e-df44-4c60-af30-08df1daff44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lPrWsilX3vhkjBeDJi9beTIpsPxWrIMV2feBBdMtDMosmPCJdYcMXH+P3ZRTfyT+JulbCeOZ9zV4li4JmFZEaht1z1EuqUQ9MKSAvqaQTm9HjR9Fxh/1jUtFxMAkwtMxPd2c5/ueQnLY7kCQQtqAqFbUI3M2jwW+IJshAA88+KX/fG2GPDsBIQgjMIC4UfHjOJxVc3HvwJczgPsdqCgRGM1G+3YnpKuRDgCYhS2Yjwj6utEb16UDYqdWsFlW4ygVBnodgN39fgs0c1pRKpSIM3xm0Dr0ef6VwDh0NWUAAO+eRBu1UhueUzvnNZFTqQ0D/I9cMmNtbydfyz1Tnf4kdQASl4vUCkTOEjDHvm2jSEw9RVT1PyEzy7THLGaun0S4WAAtFcbLsL+0dEXFRyBH+simJGvuPgITlGLGOh34gu5r/oCZ3a0V5jd2fYV0f0DquiDGl16IM/92K/XjsltXdepRsghIOL+gA1FVpdxKl8WSlDSYBcLJhWLaC0NdGMwMpDlvQeTFcDsIJ3UC9rW4JVnQfKA5A2RmQKnl6024KEjuw6wuo6KgObl8VEn71ltq001X43Vsb96f8Ag0I9+TJbLkm8BVb9raCtv3cL7qBBWmcQfnoWupFbhUVV6ETtFof4IE6w3Y9sgXyTCYfKNzv/JiHN4D2+TOMRlh+KRWpKMT2ecf6IDdAg1SXdd7uG0N49Wut3/MeSb8tmHVAUI8TQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sFoqOzxI5/MK9YdN5u6vw0vpMMbLqfrUMl7oBO6MNfcQeUY2MBtUAycAH4m+05sMbGdOn9oHaoyk2MCrE3fBC274rbzq3YJz86Ax8JsTr6UGHEatfzNfLWeGPEg9xYgORRWDSv/It0SIGoRF9AyZnOeUEKWWccPzHXVl3ePu2wX3hmOir3z9djvtY3iprS1gaU41OKlO9srbcUcyVyhuB/gW+hHrTg0nxePuWCMUR/+HI2w0b7u+TSAvNekzpoSyYQQo9WDnTTR7PwaKYGvPgvv+0+MxlwI+xN6N7fWfbhgHa+1ui3CW1KhhBfo5bjZwBxfk4WzVZ2vS3wqlwxElEr99JFMqjhoBVXmPhupb3JM5pcYYt0u8S4Vkl8ldcMd7R+wzxrYzmeofFzs2mXZhKjIgarvX8ut3VukHj8/JN/+w1leMijG7mKA+AYGA4M6A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 22:29:26.3490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237dd99e-df44-4c60-af30-08df1daff44a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682

On Wed, Sep 23, 2026 at 08:39:20PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 03:33:06PM -0700, Nicolin Chen wrote:
> > > But I wonder if the point of this has been lost? Prior to calling the
> > > driver attach functions the core code already changes the xarray:
> > > 
> > > 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> > > 			  XA_ZERO_ENTRY, GFP_KERNEL);
> > > 
> > > That immediately makes the threaded IRQ safe since it calls
> > > iommu_attach_handle_get() which now fails.
> 
> Hmm, actually that's a sneaky cmpxchg that is only doing reserve..
> 
> > I am not sure about that. Looking at iommufd_hwpt_replace_device(),
> > there can be a old_handle != NULL, in which case the cmpxchg() would
> > not change the xarray?
> 
> I think this is wrong, there is no way it can work like this where the
> attach continues to see the to-be-detached domain across the
> flushes. No amount of flushing can fix it.
> 
> Somehow we broke it :\

I'm trying to fix this by replacing xa_cmpxchg() with xa_store().

However, an asynchronous iommu_attach_handle_get() could return the
old_handle in the iopf path, before xa_store() in the detach path:

 - If a different domain is replaced, a driver callback is invoked
   calling synchronize_irq() and iopf_queue_flush_dev(). And this
   closes the window on any the old_handle reference before being
   released.

 - If a different handle is replaced on the same domain, the driver
   callback is skipped. Then, the iopf path could hit UAF while the
   old_handle being released by the detach path?

To close that window, I think we might need an ABI contract for the
second case by asking drivers to sync irq and flush the iopf queue?
This would require to roll out driver-level changes as well.

Thanks
Nicolin
