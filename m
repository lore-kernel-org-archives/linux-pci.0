Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A331E5714;
	Fri, 24 Apr 2026 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000163; cv=fail; b=I+jwrVxnNSfyeaxwgmOIzndqcWOfzcSW23X4bjJMSeV+3l8erDn+Gjx/A8AqayY62plDInMVl6xlhq1aR0I+4Sa+sssiNUMIqhcvz10N5gujmKOn8RJqc6ASs5S/2pZi2vJdTONBCSw9ZadempsNTSIOWm1O4WX489EqWDjUNB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000163; c=relaxed/simple;
	bh=fsaNkeJpS9tpgr93hX7/xo7Ek4K+VRL7BjGpixQ3sp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fimDGd1xGA8XgOBbBiZ4Rz8G1qtjdAHoXst1CVeJcSkoEKPAAFqjd9ISct94p1waqEHqkI9cWBnvLABGOA/SJ77LR04qnb9UssP+tonADJ/Cz2YTeOFsdfv3y4cQ632UuqzUMw7tGwE6esE3te9eeiHJdUZlLcpG663DTONAp04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OV+lMwux; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OV+lMwux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Az6Lqh3mv+ik9FqCk7bs6zPyLbakBzucxogbxdOUPt1iiUSxbAazcYTswRkI1yywDzm70E8AZNdukykpegkrntEFGmoNtg1U0OoGwP1d1ecYkrwhAtqUCsKrMpcn006u4988+42+xofhNvxxZRmkOl5aXZRfnPhi4xGKwH+oD3Zmm4VecH2vC6Iy3MQ3ITfD9oVXpjnSE7dJgnSrOt++8A5j1xl/vaFp2CoLYxxTCa9C7Fwdrc6TiOqkryoy/+1sr9tu97jPJOTw8xqjtC4i7GnmapbMvUYkm6RTrrtSLSwqW8N600QUs9J3IttrQCTcU7FFQz9xz+95+FRbdAuw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIhPV6JdXmJ7o7wri5yQ1P/GTLuGcDdHdUf/92+Kh8A=;
 b=R5Jt+44+Kc5IKi5GhYKCGg/r54dgsAbldH0iffsQdLwXu15nC7APJNWnZ639OO7vNqH3kby/grXBYZ20SHzORCtgkqW1AXCKpGIXvLVx+nIA2IxgweBUPtuzU92LErLfDmfPsnztHpc36YSKa+H+NlnPEVgCxmr+osVIkSI7kRlDMGS13f+qKDC+6Gr+fLvDcNR1UEfIA0/4m0VLHyIkpSzaeL4cPp5Ut05KOzMWtmB6KQLmr7E8DTwpA3TJidLhQmzytmj1uQ9aY4PkNoDjVbExQ+/tON+NIVRmk03X9F6f2hjQh+hUJ4yD3kQYFNsIc9sdcKJ2ZQjY+VxDc2u1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIhPV6JdXmJ7o7wri5yQ1P/GTLuGcDdHdUf/92+Kh8A=;
 b=OV+lMwux+XCsmJToe5E5KqVgGol9Z7IeDTtaQI2Vp/kRIVkel4mJpWoWzgGsRICKeJSAMeAxGTECYCNrr2jKrX2beaROgBEr6xUdBEtHecLIGSrqidm+9Zh0ifig3T9LDmzIPxM40+jlP4IO7RiZosdzQ1Na0ytBaiDQDQda6oTfX/e5khm7AFy01qbCdt4uvQSvSL1p1mI7IQDYUqc4aYwJm8LtT+dg8I/RDLkU9uZKe7HakDfyWsauZUpZ9OoevCCjuPSCYRedAKlUtRvNHyqs3eKYt3x+R9QgBLg6HKZCSe7ZwxFvOm2IDHAf2Z/IAPisf19bCTqMGuTPcPia8g==
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by PH0PR12MB999087.namprd12.prod.outlook.com (2603:10b6:510:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 03:09:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::ae) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 03:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 03:09:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 20:09:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 20:09:01 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 20:09:01 -0700
Date: Thu, 23 Apr 2026 20:08:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, "Mostafa
 Saleh" <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 05/11] iommu: Change group->devices to RCU-protected
 list
Message-ID: <aerey+ULGG589rdi@Asurada-Nvidia>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
 <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH0PR12MB999087:EE_
X-MS-Office365-Filtering-Correlation-Id: a21a36fc-d7aa-419f-1739-08dea1aedf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ryZKCl95TtqD/I2f6F+vuRhEZCBE+uFrknDdX+GAir612EAhtJ/+gJBHAkg7M+6SUmd1QYcg2jPlFbkW2Yi1R2JPAtRfYQ08U7EkxNHFBBaPFH6v3ydiHqjdfSFgeRT/Szf1KgO6vRHr5iGMtjsvTFweFLpwCP6v4ZiLIXh5HembP0cZ3FBxzjX5mrR84qNtlP7RLFic/eYsHNAAkQN6QisqgxuzWClnIAAK0fswuUWB2kq7TBjmcJkkThXnWLs7/+xO6Sz3B2z276GjHyKvdPZ6QVD0GDirhYlOF4isO59MtVyPKgoDqq/h8uPKxJdpBGUufgz0jlPBsMP7IzuMf6SLOFqROuyODW52Suh/op+icOdKZH+dnflleZXlGoeRhomVh+a7+Kfnwzgh3H+5ia+h81la1nwV3lpAGNwEyx7sDh215pabU7QSpdlVCfOgr3lKGjrUbLzFoMqhOPN5yzZSrfmZ1EvHyQAcFhJgVWAEXgUQVZJlvzyOiLZzm6B/bUTSQ+g4EBrC59zWubLEOdy4Kj17/zcoTd1y5twDURJubFCuvWNEDpIWz/RImRQP2NhsodateofPFwWzMMGk6njc5MN9IVPHFzsrrtFMp+eTAajFmNfVRXTQ1oNOoELIbCIluVkjGTpNBxjo3Te8NMF9zSC9V5FsYemCtTA4mI+eVzq3QWev988Nk8EXoDkRQ2AlL6xZrSOC3qAGy1AADSc9A+TToJF0rRIKggJ1+2jwNbg2e5YJLQJDNa0dy7w8YcXPRR14iAHwSnS3vbHNMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZbDUIv1wFMx3HEb8mtHmyf9+CocfL9Zpg8hciEQ2as5xmL6Kks0W3DWV8Eol1EpY9o1aWIU5evnkckqaUAB4mjF6CVWhnqfPeqL7tX2gywfB02RP8vXDT87Bw7hf4Gojjg7r5QX4wUofDmu/UjnLdGLa8MSHRof0IUSIIHEXOokJYfXrJFBJeyRti6MfxboZK9DlDm6PHO26Aqw2pgL/Kh8HOEA8u7Q3+V7WjHa7tcFAoVLQIdpGPao+jm6nTQHTk1szPtkZEftgnHWMz42pIBIaThcxnTNJaw0Et2zV0DTp2UpBKQVZMvUYzlTxxZaKFT47veDKRrUgunXLL9Cv7092jsZWrcP/d7aYS4Xtz2Oh+WscspXK6uJT+SzzEe/r8xhyq5TK4RAAKoS4fZr5MSl3WHGKHv76fA4/hfkGC3hkRnGb1Cj/gtgKn7KFkEf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:09:17.2248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21a36fc-d7aa-419f-1739-08dea1aedf33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999087

On Fri, Apr 24, 2026 at 10:53:49AM +0800, Baolu Lu wrote:
> On 4/17/26 07:28, Nicolin Chen wrote:
> 	    mutex_unlock(&group->mutex);
>             /*
>              * FIXME: Mis-locked because the ops->probe_finalize() call-back
>              * of some IOMMU drivers calls arm_iommu_attach_device() which
>              * in-turn might call back into IOMMU core code, where it tries
>              * to take group->mutex, resulting in a deadlock.
>              */
>              for_each_group_device(group, gdev)
>                         iommu_group_do_probe_finalize(gdev->dev);
>         }
> 
>         return 0;
> }
> 
> Will the change above trigger a lockdep splat due to this "mis-locked"
> case?"

Oh, I missed this one. That's a good finding!

Perhaps we can just change it to list_for_each_entry_rcu holding
rcu_read_lock() and drop the FIXME.

Thanks!
Nicolin
