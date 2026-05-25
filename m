Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60721429D;
	Mon, 25 May 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738165; cv=fail; b=qs78WZ8bIm6nRLPNK+0MbGMUsK68Nnfv8dgu+0PgMy8LcNaBpGRFliIlv0rxiCY4uZm2/LYUH/GTp0ODxxRR5i8+xzA4g5HnOuQt7EewThTGJ2gHqZP1i9V6MGNBpoB4AkRgEIfd0teXZ3Lsz/epdSYDB2kVWoLDBlFICtvTAyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738165; c=relaxed/simple;
	bh=RN5lJv1Koq5hGXS8DOiu3i5N2MQUtAz1BMovZFDV8pA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEc/BF2mNPOXeGkakMm9cmZ2EkRficxzyTjz4MTwhqUWtcc9ikpxUuMFQK9QmvjBXKGqo9ENTIaXidqv2kPbhnLUN6aaFo1G94Viya8Nxx5mxYGCFdGdsRdV8+Z/91U+M2nxQ0iGS7nDeO8JrylUa8ZCZsKrUdbTDbRs1R8MKcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCt2FH28; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCt2FH28"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsU6jhjaDnJEUKL59qc1FN3lKf59G+ChF42rPLWkuw1p7YZrLg2CuvupSvRjcSYH+e5dBfVWVnbUBeOY2kpnCjf5nxYnoLfsRgdP+JOGLKcJMBmTK7cwVKoCp06MOkx0WrYWCWDJYZAuwdKfozpX6UMUVkp+vWNo1k4jjwizYRgbaphVvCORXPyT/O8s/g2ytKYJgkT7Zp+MvsRhQ9YAduJW5afvIKFEdPlYmblYe5nEn1fEXGYASDWla3EffLUR4mOSsXAyNBiXk/yWLETLH0wrGy2EdAYc4rVT1P7P2tnGZFKo6DJaYlovKEtagfV7XDPzJs+eer9yk4hQmmxaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vjiaZfyPzTM9hyMiJfEG2GECj9nPzxJtWgGOOU/EtY=;
 b=CybYN3dd18wUw4MmRCDcXS5AVWnL17xpv3T5d1VRRyAMoIn/uq1e1cid+MNVTsifHXreMZnuLfRZhqAKpwARmV+RtctKwHnAr1V9bSDl7NG674cZFiUQMgQocAYDDIvMZrlGA1AZD/w0p+qH4YIzAqIYq85+bVSiAt9JVojy95cUpQhsNzpd9eWBKf+OJ91zWdQydtg0TtQIlu82nZNQTqRry6ognh4Yi9RRTLaBtZLl46IzcomuW3Cx6hxSmpHg3xQBccGsQLW+ttL4vUIo8t9a2eWpOHECASht7I+5OScxGOSsTZO45VHVFFBhoTgGyrjWW017uPtfGUTcXCHipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vjiaZfyPzTM9hyMiJfEG2GECj9nPzxJtWgGOOU/EtY=;
 b=VCt2FH28pAXkyRj8DIEyV+qjz+33ReYt3f7TWdUjZtsMwNjiJteyuWkuY0w7rgT6PJVKTELbM6wTpGBPSrUiKZw0nP7XnQ5QYh8hR9sw0HZ5S0O9oGinZFXasts1HonbXQIv9AIHpJCivlNWdNB6aRUvG82jk3E59N5vY65l0ZbaIENMhotXY9CMp9C01pqxFeHuD7n4W6SgwzPAjs8KfEEv7lcVaGtIP1V7qUTJ0BX287wIGo8aXiIqZl00hAvGbblmtfEr49yV/YJQaHXOcOZH6LNEbDl2cuqMBE56NVpZC5zMlplsrGbsQAZY/lylSmIdCxXkl6zjJKGQiPOaVQ==
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 19:42:37 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::34) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 19:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 19:42:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 12:42:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 12:42:24 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 12:42:22 -0700
Date: Mon, 25 May 2026 12:42:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Message-ID: <ahSmHVGOUQDd2bkk@Asurada-Nvidia>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-2-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260525184347.4059549-2-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 35206d1d-1177-4ddb-143c-08deba95c621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NfocWSbxofXfhdmZcJ9dtNrDH4a2Mwcnu6YzA5iCgc9yDyAEsvylyKMCQEX0huq1BjGEiFONg9ldYP5vQ9tZCtwgqVw6PvAryPGSkWN2yHeEq6cjAWGu3GEF50g0jKZVIcft7YXYC4iY9Q3T4r3GVWApwbS4fIfo5iB0O31Hds2Y3WbQNAXKh3jIwiP1sHKhHpp6og4yCK8NrW2AIJGQ0MiGJs2vE31jGcLLas20D8CO5MtJHpjZEk8iDC+VXNBO9U0Z9iFTqACDzwcSpd0/kLEwGsrVcOUrpNuNYQ5i0VqMn+d3boXW/omItifa9aU82p0s+1n330OEsgoYHmIqntYdr6BZ5wIQysIz1acHuBC7TO/aklycpIKe1rXnbI2N3+IQq0Zyf1e5amckeZH7JZvGrS7IoN01JKkGHUo0toSiDLSPcK2EJZxMboo6pldlp9r2KWMXgFH0NGOiBFwuFEI0dldX1EHBGCj6naZbXbp4uetWLSXXA5W7xSzENLyWCXtlZuG0Sh26cwyd0Lal4H2sTULjMa9vYZJffg07pyTdWNPxtDco4XAYP51hSOh246piegHvjssbXO0E4Iwc5Ir27QB3IYYcw6KYOPPQzfFELCJ05nRPpgpSk++ZvXfFkTlytnZQP8al3KVd+5ee6msW4b+L4IApNLDo8hloVMzWziLIgOJD4N3SeXyy5dR5EthtYDZeq3rJskfjnGDu7uGL6iOzdgNRTKVBkTZDRJE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	07gVdphXsbJ8+wn7ARjmZLRnuUlN5geHRT5tC08md0VTHbvTVsbtAEYmst2iCMKLixmxXTr07gMrWhwDqhhDXUef8WnZt79/8P/TgyI7v0/Nz/L1QTraW8J8QkdTNqT3TwJvT4cHjJEn5W2RGUWbCYh6d7T85GbbD5C1ZaJRSVEb6LvpnUU/N8XvkXWG3wMzUMDsZ08eIyl0kkENetg1subwGIjzAOFZOFLtjFqysF2DN8IuvLkbkoKORt3CppjvEs7Qy+f3nc8qFqYYS/UyYkHHRzIHWPS0Ng3OGd40+43s6M6cWs+ERMb/CxbQIETFVikTYnnSa/LqRQVxfZHhQ1y3i4aio3l+Hmaw2Qym7uXNIeSpo3E1kAjHRQ3iaSnFvzU6KSuGQ5yHrTtOdetcYUH5kU7GqYq3D9tc+aspyrUrirccYdsRfpuvZRiljmQ5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 19:42:36.8328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35206d1d-1177-4ddb-143c-08deba95c621
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325

On Mon, May 25, 2026 at 06:43:43PM +0000, Pranjal Shrivastava wrote:
> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
