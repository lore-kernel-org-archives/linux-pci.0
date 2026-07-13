Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863EB339B41;
	Mon, 13 Jul 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967179; cv=fail; b=YP9A2StBusjUYWpkTPxW17yMch19LuBDrFAnZnV9nVUDgZtybyojPxhyXq6CkQOSXpxUAANxy9DLkv0MJNJo82c2AVAS+pHvQRhz7rbukaoYugwELMQodKZmGSPuuhOkCWT/lluDTvbtrwFi19UBNVgG1bp3AzbhDXPKNDSuvY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967179; c=relaxed/simple;
	bh=1oJzzLDREQyeTdODZ23bYBuF4f1y3mwzUr4vkfmw/Kk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS4BGTZpcR6if0Jz8ozywI2NWWWJlJblq/KhmCHBmk2ZV5oXXHG/UrbrMFbH6G1TR3kZafryFrsWnZwbcDD9Sowgxv9Z6rhM0FnMnodl0ml2+vFPlDUcc5oFzBT1YTZtIe95Lp385V0N3tZYe2DMbH9evSaOzssS+INfuteOXcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n/TTA9W3; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n/TTA9W3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boXK4xXOhmmMAnBGmHqjZAy7HquZHus+i5z5av+2ifEvpshfwffLhRmiadPg4G0YHxfYYbfbfmEN8bBRJDVsfxFleQrHIDjdkdgfl6MT6mxn0wtsPbzXyBmrnC4wN0VbBIV+3MX5xchF4tNVf8vgqEn4sg/h9Sv2yp9pJJkLFZeJaQTqsImVuQfVXnQtCb0r23+z677Egfdp676xKKbE3ISD12w3k/iIfEOBL7iQLOOrxVXtZPw+1/LGQKdYSEugeyvKGyA+WlUXY/aq8m9ZFTEJgvJqTByVJnDytC50rsoyVFY6oPeq/9fvchZD6R64BiL/LhuUqfMkqpHw2t/now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shIXBlwbAsoyjj1jr+i3WCv8d1/krC8P7sBzSFhwvrg=;
 b=nvkaltMphGfgt26Oy/q+ozq+ZqiMnsqGiBhb5PW32n/vjaT9Kj48J+TI+QMoHkitanszKdIdEE1BvHqUmWuhgVxTSLlGZ08xaIFhsUaXJeH9AZ5fCr0F+G8NkJFQz6LJJ9Akoe0GV38CPcDk8uI0P1CnlZHiOfVVXpGqZXbvfy5ZRToGL039VxFYCYeXuF5yd6KMicJxb7/i9MKzMbHqL4SIx2wi4pY0YAZp31QeiZTlgZhSltzuahX1Ej6siQLPviFU+Yge1F2nOsN+v9nV6hEU5G9wH3E0lrimJAdToTT0DX2ceZb1w0A9oY8yXCjQtwQJgF6uPs1PySOkLN9ALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shIXBlwbAsoyjj1jr+i3WCv8d1/krC8P7sBzSFhwvrg=;
 b=n/TTA9W3rKSdFIWorQf1ahpePrSkbr5pIjxuA/ck9WfMKlx6XR7Pc91XRLFE84DNc7H/b/D2TJutxX2k/b7zd6F8s/top+9V9hoccGxWzrnDqRxcTJ4rS70axrfD17EOfKdIhoukzYBLLGe4c32X51+HdPrB/sJcfU4vDJh37mINg20/9G2m/RFBXQAcZzLO9jhUDEfhukO/UUQmdJ3GGk+3BEtFtXWN4CThblP3EK2iNi7ZMAjNE5VjLiUFdjjwjKlM3+vhYeg+sKncEYDrBwd3TgcCg4bH2d3AjM3ppaYC/I/Sa/ILoI7bNGV+8D0SODuHBIiiwavaoh4jmcJMCg==
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:26:14 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6c) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:26:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 11:25:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 11:25:46 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Jul 2026 11:25:44 -0700
Date: Mon, 13 Jul 2026 11:25:41 -0700
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
Subject: Re: [PATCH v5 04/18] iommu: Convert gdev->blocked from bool to enum
 gdev_blocked
Message-ID: <alUtpW+CEvVAQBVS@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
 <05ffe5f1-0d88-40b1-bef9-e9633d618ce5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <05ffe5f1-0d88-40b1-bef9-e9633d618ce5@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3ea46c-6f76-42d6-155f-08dee10c3853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	mcKXBIn2GnuMgY9orp4TTPp1Mqo3Jo001t+SWwHjbxFBmZ1KTBBGy08kubjcGB0Su+slSpfEYZJkTkJc5CKk4FAPwh2P2NemSjF0H3aaOWMR3IPucm3N9aXI0GnBauwurGOxAnaoJitl4ae3Y9fqp3aDqrKAqmncz6r5r35rKdbVa79sugMTBTE9993JaQQ1ctloKRfe3Oxkh+HlPk1BxkTmB/oh3oFpvvOJxogN/znY4TPzJv5TQxoZfWWttCHFAF5ABdjvn54UFhigD6O+zSZOb7xRVApDCPYyztmUb83yuOQ2emZjtM+8aQTkgvNptSh9GxA68/m8qS+moKPwE8+5OlNxeXZ8PpszZxYAybg2X3RbXTMtCYDASwknZwDr91VGqzymd+tP7WIR5RffDrQq+O7SJXk+LWOgidp/6eDdlpcmzQ/JxYbwvDhAaZYe1eix5w0O7y11bKPj4zNWl1RIhpdcQEYHsQQkno5NfCH1rJd7vYH2+D27xEtDthkz1+0JT8p5Thrz6V1ZoEXUItwW2SvhpIMb6tvhvuPlgPjNqo+qCZ/ygqmEtSOCEL4KVqWsjSeSETk0R3qzpB+8/LDRCad33ejJFMjI/QCfL5yh0fT6OVzL5iWnziosfcZ3kHE2lt+UfhCcUPBLZj7p0Swuq6ncowV7PBr7NOsC8E3nowtARp+5PJkK2wEUTvvmIJgAKuYhu6tpSiFqMqYr1w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VqAu9M7PzS3Wvh1VNjspAwSBpquoczo0/VrdhgbSAP94Wb1LMHRuvEOconfSaBZvwjEiQEigM1kDuLrkLgXIyZvjrKjCHtKmOXJx3qGRoSmuYRNxBgNGW4XT6qzwWNL2YE0q5DBlS7siK0/7Meci8fucj8S//JudSJzf4NPWB2Eavh1kjMpdVh5sTPGrty9dTshSWhq8CpIcF6bvmleFJRv/+583kyvodEE5fI1o8lMyIrd+ZFGR8rOgtEAOIyOde5QD7g45lZVnFecOmVRgBFcBXipfy0iQLIzYJ2m/gnq5CyF4SkibKqkeFKG27Bzdx/7NWiYpCfm34VuaN8ZTtYZ66jrpv26dN5fCRzmBCLloUGcYcMQxLjnyYWHAQTaj0zJvie3/PkFKCBm1laaaWP4zZ+XIHM+r6G/HO7qCKtaQCOdbF/o+IQeg7FDoTj13
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:26:13.2988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3ea46c-6f76-42d6-155f-08dee10c3853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668

On Mon, Jul 13, 2026 at 07:33:51PM +0800, Baolu Lu wrote:
> On 7/3/2026 12:06 PM, Nicolin Chen wrote:
> > +enum gdev_blocked {
> > +	BLOCKED_NO = 0, /* Not blocked */
> > +	BLOCKED_RESETTING, /* PCI reset in flight */
> > +};
> 
> Nit: Would it be more readable if we rename this to 'enum
> blocked_reason'? Something like:
> 
> enum blocked_reason {
> 	BLOCKED_NONE = 0,
> 	BLOCKED_RESETTING,
> };

That should work for me.

Thanks
Nicolin
