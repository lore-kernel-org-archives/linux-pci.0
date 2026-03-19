Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CECB2727FD;
	Thu, 19 Mar 2026 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882956; cv=fail; b=ScvJJo78ZxJFtBGRNXPYkIEEyQZ5SC+FWoq6ytH/pcStmEXQhBwqXGX8HhFX+xas1sBcRoOKe/tN19I6zhIhmxXd+Cbh2qWNo1Iz3dyy8dv8jpYh78SR4/T9t8L4Ay+uX3VEEY2OIMW4ojMjhH1b9YhbdLupi2MqU03CPiDcWKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882956; c=relaxed/simple;
	bh=mJJOIAult866g835fh/WqgWC1sIGDf9ATbxFp6tTIl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdbcIqsVCkbUPsmfIDAC7KYoXHVubjmGKjd27vv0tXABzl5nLI/5NngCLa8bJCIwY/A4RBNH/a1MOFXEHOBDkTo0DEp16FIZoL5vk7fH4QQl7ErjIgItwxYPE8BgsRCnMr+bvWrKVhSxzqMtRncajJouQ2EN1H9T9Q2SgIPbpfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lSUNuwNe; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lSUNuwNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRvCMWBFB/Wv+ym8yz3dBsb68Jxrc+ZXvd8yyBtQhrh3bT17quNWABn/ae2sbOLasLX6HYqd5LpDleS2vI3uXhwpUyia6aLEFKqrzpjKSjizcu07ScpdU1QWlrhC/wIkJlOXDeiCsWHzPWabchToM2vPoYbSxtN7ay7bvAPtUQtIGNDNB5CFgY8e9xm9HQcTPn3sTpDGEaCqxIsqTORR90+zJiNFa2bNkf0sf86dwP43NhYCYYQHW9WEfQ8saza1B9nwMSzdaWz0QN4lYMbGVulY2ggpynxM7E9wx+sehI2KOkFtcslKfHyei/tKNcJWgMtVLzNmHExZXX5rWWHudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTVTGmdImpDhZLb5RCt/y/ns1LLTlO+l+ajvEcWWtCk=;
 b=lcrjxlOC/12Y2PEoAsDytsK2CEP49Swf03dG7P0O3MVuQCHmlDqlR58a6o1eCJfwRE9/ywLyWnxAWbqmYUTFmskaAkOVr3CnKVyxurco++OSve0uKEvCoAHfu/IYPTnKFpUdY7Qe+2ooEw5Y2avxhcVgkeMN9tlUt0rjeRd7NQRBw2WBS0aPR26x11D+4io1vupmb9xrgayQTWK/tPIZppfzQqJAad/v3qLYNj+t2+kov17ONn5tzRYtir16THg4Q6MGYa8jWCJN2fGNOmIu2FbHThSVfTHxNICT63tHTUqmVDZBwlpodOh8inSlwEzB8pT9jC5+XEIwtZAOCibYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTVTGmdImpDhZLb5RCt/y/ns1LLTlO+l+ajvEcWWtCk=;
 b=lSUNuwNeCFNT5E4RzSDjcnxT2iwd82MGUUeJXDVH9B78Mj60Wpf7Vk82Mt2db5xwV7QTcat2bu1sSCTMgwmFrY4aSRsyEwajfk/7/3IoVU4LBQVMWohtJyT1++DfuUTXtFkAGRDRirtDMa8oiQxmREdQrf+/7mCN1xbM+Lvg+GEV5y3ilflaNNqOOOduIrxnUII1DhQg6lsU+9KDbYzdHBMwqSvqR/h1i6Yx7HoS0Ikk0L5um7fEQPwtOk4YviHJLOGkaQzLiNaPggaZXX4mbzIepLsWh2x4z877RK9I74rF2rK1fZL5EeT7Sd7i/4x+o0YP7rBeNe6m467bJ9pcWg==
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 01:15:37 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::ea) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Thu,
 19 Mar 2026 01:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Thu, 19 Mar 2026 01:15:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 18:15:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 18:15:18 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 18:15:17 -0700
Date: Wed, 18 Mar 2026 18:15:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<xueshuai@linux.alibaba.com>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <abtOJCEwZd754mUA@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <absfAT4jgL2f3UfR@google.com>
 <abs0CQCrFlCsV6Ls@Asurada-Nvidia>
 <abs6PudCAh-eVRPA@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abs6PudCAh-eVRPA@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: b474b95c-2f2d-4dba-c491-08de85550720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QJ7I5poPHBFYn7flxFnVBOSeD2SGAVgWG+BM68QsxI3bJ1uK3ZpbYdo04fpCswqdu1w3M9bGTH/sR+iOXvFgmvi/aq8vQN04cv6ROVk6RYoHzgVvwnzMeXAmMnLKqVvGSx69qeJ6i2UF+VGpOv6939bzGgRpB8KjkulbgFTcJfB5tQ4x8kcAog2UKVq63Z7UFy9rBHwKKAHELyVGRTknjIj+QImVNAf4DU7hQmnJNRgcJuaXjoHQf8h0aIkaRESw74mqiDhnRHKNFfDGQraIRKBZoUDYv4Q8BCe4ylEcp2kj2WmiP1cuL0MFtZwzHJm9NIAjRDPwlJkbV40hDQ5a+UWPq0Op+VRzTX3UbjU2EXRrayMIE7ttwikEOKyD21kJ43pweA6qubSJngmNyjG5RcfsK2CLw6OAWg3jTtS2MF8bUqYkK6AtedquPSa+LldqNoyb4wt8M9ZMHITAsk1Iww6POkNJUll8m2FQE7Gsd5DS5Sa1LwN0zX/VttTXhg57I81msVZfaDZ//9Ly+f8dI5Xh2LO3gcclO1FaC1KcVn0tbn8/98uGHnlHX72p2uUiqzx+FbyVWCB7vC7ZEbXuV1yDy9WiTWVF2V0J17BJIK8p/+hYq94z2kvaXuJWA3lRBJEgTFW6ibzd+KA5baX+VyqlyggNL37nM/c2TQqSyxYbE2D6EbLSF66pPT4mA3LlSFLmdaW27MzHRDyLwmbZtqRaqDoLojzegHacQrnBP382pIqEYcuYTqCtVPrsJUtSlTl5+Ov8bgjjz4+gEW3izg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C7iiV64at77tipElzHKdGRNY+utd1rBPo5beSrA9oOYb5z4aTFt1OvM9JWLfMpQ2B/HM03xoZL9PSCqrnGOCImC7CVc/mQsfIH0CgXT0LZg80Z3iPrWMWHZudyH9ly6LbtlwimteumeytFmfHgQ3AJYGX9mbIr4kJa5xRJioanQwmG8IcAKWCJrZ9lG052tvp9UlzxzqeP8FG9IRGSYaoZnhyVsAokgHLNEkldrmPjdsD69wvBWElBqmZY7MwIG5538FFSEadYRHHzvRM2HlXxBwrEqgekrI/VQNAosIi5S6gd5/BzKgVFD0CYDtENLsoBNo1F85tWOSglJh8NmeGMDYX6jcvUcYdBvCdcgrP3tU28o1FWARYTlb7aGuSz1cXSFr9I7x/Re4AUKxM3Y/XKnN4NQaR0kyOgRv6Ja9U3Sv0F5L6Lj617Sw9aVuzsGH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:15:36.9700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b474b95c-2f2d-4dba-c491-08de85550720
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

On Thu, Mar 19, 2026 at 12:08:04AM +0000, Samiullah Khawaja wrote:
> On Wed, Mar 18, 2026 at 04:23:53PM -0700, Nicolin Chen wrote:
> > If the software times out first at 1s, it means the CMDQ is still
> > pending on wait for the completion of ATC invalidation. Then, the
> > caller sees -ETIMEOUT and tries to bisect the ATC batch or update
> > the STE directly, either of which involves CMDQ. But CMDQ has not
> > recovered yet.
> > 
> > Then, in case of a batch, all the reties could timeout again. So,
> > it will fail to identify which device is truly broken. This would
> > end badly by blindly disabling all the devices in the batch. Also
> > the disabling calls require CMDQ too, so they might fail as well.
> 
> Yes, looking at VT-d currently and the queue length is 256 and this
> spirals out of control quickly.
> > 
> > Thus, partially to answer the question, in case software timeout,
> > I am afraid that we can hardly do anything.. :-/
> 
> Agreed.
> 
> Do you think we can maybe document this somewhere? Maybe add to the
> cover letter?

Yes. I will add a note inline as well where software times out.

> > This means I need to set a different return code for ATC timeouts
> > v.s. software timeouts.
> > 
> > Also, there is another problem: when PCI CTO finally reaches, the
> > GERROR ISR will set atc_sync_timeouts but nobody will clear it..
> > So, before calling arm_smmu_cmdq_issue_cmdlist(), we need to make
> > sure there is no dirty bit on the bitmap too.
> 
> Yes, Just to confirm, do you think this needs to be handled regardless
> whether we handle the software timeout for the ATC invalidation?
> Basically to cleanup the bit on bitmap.

I don't see a reason not to. I think the next issuer who sees a
dirty slot in the bitmap will not have any idea about that ATC
timeout (batch). Basically the previous issuer was returned and
the batch is gone. So, it can do nothing but clear the slot in
the bitmap and move forward.

Nicolin
