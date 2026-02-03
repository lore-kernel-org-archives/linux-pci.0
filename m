Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF21386DA;
	Tue,  3 Feb 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144679; cv=fail; b=JjVYkSwPdG9cuLjUOXWRLOcTFtSAZhD2ZTlOzZet9NThWueTKE3v155I5vxDGQe7nxPPQxwRUkDuWsiktb6eQH7f8lk8tlJPEXYo/bc50YGGOBkYS1wqnPqNTBu+EnekNWZmVklbVW5j89ZazBNaqF4fEfjU7Rv/FubOKIiJEW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144679; c=relaxed/simple;
	bh=jRfsAtiqY/vLP87MQx55MLzAlNS0mBHwC6MtOFciLzk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUa+E/JmMT6Fg73i98eBl+rCF9bZ1V2aJPXs9Sn8Q9rl1LSSqWGxuaEVNCTCPOEJeVVohTCeyKJqkVwLimWWuAbEXzl+XXmntu7iq8mZb1QzxQZP4J2vzVi+EiAOCPfnaNEKcCIIN+RFEkh9Dg5NGLtZ7hAl1vmnFtD07Ak79rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBQN70Vo; arc=fail smtp.client-ip=52.101.46.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBQN70Vo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdBQuWV1Gvhkp7PefKkKMJfrITdYCVSXMvPFauyyWRA0zJw3gko6b31EdZFTl3LykQ56YtDYnyRnv4c7nDCd2it8GlH+JArsBixcEdCk5DEx/YcvfJ8TZhFLfX9nmxaFJ8URnoJNjlEOFg3b+yOjm9WDkLARyQFM0SwQybEkBzHNTjCAdjkOgRVlTEOlJ/Ty7iRvmAgLJiasZwNjTHxo3JY9yxylSjVDZmRAH+I1fVDj3N5qQm8lUdXfDzNXZyvpzA+MiwIlGcZqhPmUem02fo85wdwBYp2dXi45DB+1r6xEleNyxGuszr3TeSVVGooYwgpvwjwTkzvdfbvM7IsRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObWah1YM2G1xy4glIQbuq+tn7Uk7SDhGHxuCwn3gMSg=;
 b=Uaw7LBV1lGEan7gLxfz4zhl8tkC9U7O+Pp9rVuInnQIQ1y9/4ukmixkiP9egHdh4nwRml/C+cKNY+sgKrUsLNKzIhKUoFPDjYHY+5L0z+FwOpTUOU4DRVUOLG6NyjVI0NW5VBpUlcLrHR2Ij0JvZO9fjMWDDy6j6j4492IeXBi30sNrTxHMyR8ntOrdw6pQf19D+OZa3KmFSO2nl9yLN07JSO28vaHZJs/EoWDH1CvgXX9txtSrTwvqiZLFShDjibbhx5FYbaSTLFoS9ioLfBPq1CFunT8gR7jUDbtvL05/QHGgKXoZKDF8yTdifiK53uhXPJ6zPHp7SktOAgI8Irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObWah1YM2G1xy4glIQbuq+tn7Uk7SDhGHxuCwn3gMSg=;
 b=ZBQN70Vogwb83lbMjnpvAvgYWAzCUCqX0BjEFSoXGT8Em4JFQYC2+s7mFmcxMKbSC2t1fAY6ZnlT+8sG9fstV+pBcoVJ2GlvEUo8DZxT3sCN6WnqgoXYo2umRkqEU7nNFn8RD5yc9qrxbIcJUfnrzb2y051KqM6WynXXVVtMVNtO776Pb1+3BO4Av6IP0ZuJV447rdU/7+mytqn62hg59DX4zs3R1doGu5nGynixsGirSzWWXjsYrdr7N2eojLK1LBHpOr7K0JJyHjf8M+QFzvt46BY7AUl2LcBRy+08Q3gIijAnRcAPdbvWqcQZp+skv+EdwtRrnGxb8Gz2C7L6Eg==
Received: from SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 18:51:10 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::39) by SJ0PR13CA0077.outlook.office365.com
 (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 18:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 18:51:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 10:50:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 10:50:41 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 10:50:40 -0800
Date: Tue, 3 Feb 2026 10:50:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aYJDf7fWIxH1017J@Asurada-Nvidia>
References: <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203175540.GC3931454@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1e868b-8736-4e32-d7ec-08de6355314b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hMZqGYH3MycTXbsT9NSu+zwok9VX4z12pA1Dc+uEkft18/3jtgbvEm8tD5I?=
 =?us-ascii?Q?C6+dRu1YKjrZX0YBNeF2VjptcefVB3axHgh2ohBvK7rejuFBAClqOWO7Z2Xi?=
 =?us-ascii?Q?/C3OCdNYaBX1yZ/9Q6O4Xq4hhgbxHLFjZI0AFi3vaslEmsgnjAeBsYHp94wq?=
 =?us-ascii?Q?Wxj9CsXvad5Gikd5vwzsFd1zJ5oGMuukTN69fsEHn+9SNAw+3MG4DVCwy5dB?=
 =?us-ascii?Q?ddXHsblQI9mFAfyjaEGR4VGwxSAEnW+W65t9npA3vXOlLrsIxib/Ertp7G3F?=
 =?us-ascii?Q?cMMlS5AMb+2x1+8xH5u5FjJziCCAfk1WeGm0gxdmxllQLC7haeNZGqKWH5SM?=
 =?us-ascii?Q?P3D6RGLbBRjflSfZ3gROIjSlln4p7QnLfBbY/5ZdmiSG7MwY6CdoCqOkm3wx?=
 =?us-ascii?Q?RlhOA3raUj5E87n25K37lplbaPkvbP2Uk1dNGMDL+GgyjUpIJ3JmrVQYNfm5?=
 =?us-ascii?Q?tspZA6+M467v6cnaUIpiyLzXf3OIY2zf1Y2n0Q1xZEumfHUmWlJQrPE98KlR?=
 =?us-ascii?Q?TjQRj1nKKW8QqRAVWJTeoUcSbjgYXL2z27L2G5MxKC6NfNIK1+wqiyzKfOE+?=
 =?us-ascii?Q?LdzJnLhja9tIuJE+ZBODu6056kPn7OvNH3t6lZ8rdgnlabZYdwfMJ9GeSVyh?=
 =?us-ascii?Q?JJmhCbE1mpoDyEOCDczfiLp1d8iRDVC0J2BJG3RKMWLJWK4cuPRQ0WLUcf3y?=
 =?us-ascii?Q?Bcq7RRLSBQvqZgevkk56dRxLLsbibUWAHDlQpt/rn7K8smakpPOhQVo3NrCD?=
 =?us-ascii?Q?sQualDS0mJ3y44bQDF2krgb/213jL0HUSctjwMNp5oFzhLL/OjGUhV5qr/yw?=
 =?us-ascii?Q?oIpVsYELCD4Jp9AfyvcDJja03yTgPeOqRDE1PS1e5Yi2iXC5kgXO/plcMdFy?=
 =?us-ascii?Q?J4qPIKmIrhO0GmZLqlMT6dUG62/RWtlrZe9ZR4hVvDzWrDpqKiWYcF6M1Umd?=
 =?us-ascii?Q?K8hWPj75YU2kW1S3GK2KJl0knnhFNj7u/b/oj9f60cOh0Iq8S0MLOvt5+lQX?=
 =?us-ascii?Q?5OEtu4vEg6WKI5IGUvKrvE53KW1PZ5CqlZ1Rkr4w9wOhnlOMOoLpgJCMvJW5?=
 =?us-ascii?Q?1KnL8Pr/w6crujUGbpBqpyT1MmfGX95OFdLC+mrBE/efTY9H7Kw+xfZCgUXc?=
 =?us-ascii?Q?EEMVjZKx2wkzcr0W8n7c+aR5grvQF17zDTXpNdyYHCL3xmU+gaa6jPSSDsLr?=
 =?us-ascii?Q?6HthcJy6rPejYio9hhDQPazWILxa2M6PqjAmDOroFRZBNUXgmEo95LgQe6Qc?=
 =?us-ascii?Q?+r1xdXrEqjaJ4c5u7+1rlCMkEplO5MbHWo7Rzyk0tWgxfHePm5yDOkrjt6Vw?=
 =?us-ascii?Q?xo4ZhHKOv80kbLGlE979XUBdFwZk5L2KmITS52cmuPx+LSplBCSMpIPAWGNw?=
 =?us-ascii?Q?F+nSl312AQ/wENBdJjhIL8wfzCoLrkFFntQJlP54oa6F6iK8/KUXWvOBmKY9?=
 =?us-ascii?Q?pvK4P9QGP0I6ANr2MTc81qOEvs0PvObAW7viKecjcK2A6XlrzfKChmcWc0CP?=
 =?us-ascii?Q?mFPN3SS/XrJ+qqR6G9+7oB2bHUzJZbOGfaCrRjFerXNrXkXaaOdbY9fE4w/p?=
 =?us-ascii?Q?N2+2Da0QhT2a4KnxaMUhMpCaIAGhC865dezIDullnZedmZzd1q0D3Jz/Edxa?=
 =?us-ascii?Q?ExmPTeb3RB8qcF6/2K3sHQAiobkxVWMi/qwMzDRxMce/UWoE794mMcsqjboi?=
 =?us-ascii?Q?0wV62Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	braLlzD/w8iR9Op5nktOP9IOYi9Gn0OjqCMTIA/exRdFgeaGex03f5brt5hWNxbHxDBIzEaN5ojKhPzToWw6T8e1eaEO8lSVbdGZ99zBFbl9QCyESaCtOD5DkktFD9RhmY5+ZzJOS9uzbxdYOjyt8AXPHxc/ZhAeidCF/LVvbeHivzT31F2yweg568i6fPHePn/QE9Kafb8S4ERGLJjfZr91M4p+xTSTfexN0wOU+Cuy2q+I0OYmhrXnzYd2kk1OWzquI2vMOsnOUHFDhA/Y/t8SxfumEndaK7zmhJWiVuWkX/XvjPGbAbR2WRDXqJoEk91UP5n91IvIWMCRLMT2yHsfNCpmFw9DhqpEj0JkM5S3sE//OFzP1y4U2uVHSewRu8079ntPB7JxmQOTWOjRuMrXuYT1Y4Ir0ANvtRMx/qnqYT4PKHHtxGgiLOIUA8e2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 18:51:08.2269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1e868b-8736-4e32-d7ec-08de6355314b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714

On Tue, Feb 03, 2026 at 01:55:40PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> > Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> > allowed in general if require_direct=true. I assume this case can be
> > an exception since there's no point in allowing a device that has no
> > driver yet to access any reserved region?
> 
> If require_direct is set then we have to disable this mechanism..
> 
> I'm not sure exactly what to do about this as the require_direct comes
> from the hypervisor in a CC VM and we probably don't want to give the
> hypervisor this kind of escape hatch.
> 
> Perhaps we need to lock off to failure on CC VMs if this ever
> happens..
> 
> But baremetal should just keep working how it always worked in this
> case..

OK. I will put a note in the patch, since it would literally skip
any VM case at this moment.

I just realized a corner case, as iommu_probe_device() may attach
the device to group->domain if it's set:
https://lore.kernel.org/all/9-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/

I am not sure about the use case, but I assume we should skip the
blocking_domain as well in this case?

Then, this makes the condition be:
+	if (!dev->driver && !group->domain && !dev->iommu->require_direct) {
+               ret = __iommu_group_alloc_blocking_domain(group);
+               if (ret)
+                       goto err_remove_gdev;
+               group->domain = group->blocking_domain;
+	}

Thanks
Nicolin
