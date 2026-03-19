Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EC34EF09;
	Thu, 19 Mar 2026 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889824; cv=fail; b=Lx0CoRuMj+kWLOIpfEfTekRi49nX6U3gGp3FiBNfCQqmJ9i//oWtDkYFfUQN1YP9rdeD3YlD7q7f+NoTEYmylpP8rC3fm6bTPHRFSOmG7ntYlFe19TEvZQBGFIlm/M80LP14uvaUCUsqeCq3FVS74I08OnmgrYFnlC68lDXEMSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889824; c=relaxed/simple;
	bh=46yuNSf/WzvwY+AI4Y4/4PwWcTiltifVqDwuGRRqCu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX4O8mjjKc6H4+ZUQIo4knda6Hk9wAUIXJDQwCbqxQgRNDDbFjMOpi4EY18HyqaZscA6JyETmI5y9v37WBA2uJGHLQ0MzTqq4m+X4YrWfha6aziYA6k5As/qxYAtNqh+OczzPaZ5yqJ38eyYLibB8ZQshKe07GmF73ErQzXiCDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqtcyCM0; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqtcyCM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9Azwh+RLkfO0dRSCWSFGEfP6Be6LzMu9Raw8f/H/gBnHIo3XkoRDjVeOUyfJCSHCeo3oVhV7UGPlKYRucU8HdYCPNd9e37BIn0OL+1Yc6Wkl2vL4x63A6piTlmLL42jMTyYRUltYKuxq70b/30BPNA/P7WtMeyRQdK5+aHSQ7pDrTjahCudLZ+Rm6ycOSzxYlrz837lajzZbaqqvTp0xrPuMHLX+i0gCkhum3RmRjKx1UBw804BIl/YLOFoKZUmHg33Icvx3pITVBjnC2OnkURab8K1LZa+79bgblAmBO8MF3Bi5IfillXX6Phb2qRDBTEs6WscNSiMzvpfUXWOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAswW4AfGnaKuE8hUXKlT0YGEPGMv8wlrBB/Nhw2jvk=;
 b=tA2LLLN3lwGctwr09RkWmfkmbTJ+pCndpA85HUHTlze5RwU4KhfArHIObD+DszkmzDtH2cnS+PN28F12LsJauYnheGOZID24z2Sg/6vsu8bRb+NNistKYfpT1aU/Pe2sDzaw8EvUX6jtbL5vwiht828tQcoGcVzOx52/CvmRycTr3Dd0lhndaWxfn9VoH+QOR+9vCssZL9li2qBChfPHFPLoUfxFLGUD+/krJNWqWG1tbJ/qu/fu3uCRFl0EIfOzuSXmSjlTrAmPxoFFxiwhqolUrmL7UhUD1wQtQ1V3XxRai7iHC46Do1hG5evM3ktV/sfY4MZhWDC60/CanIsK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAswW4AfGnaKuE8hUXKlT0YGEPGMv8wlrBB/Nhw2jvk=;
 b=hqtcyCM0Ky1dQ0gZM1Mxj8/6KlNhsoDDxz7X9fbmOzYbDELnafs8Hixrp6FlL8k/8YdOBZFMjLLtLbo6vJpQ8CFLzWf9r1Xp8QN6f5snadwpXPA74sk2omuzfYnDcOzIs5tl5CGfU1VPnJn1EA5RVOhG4BzprIv9vi4uVy6dSOMHh8Whaw3m3ZlBiJ+iCP7t0/8SeMWCEGMqNCWPJ/6K/XimdJcROWDjQGe8YjC1SyFNYC+5SZ5qbCFWv80KX5YNmaZOMX+06UAmQqngv8PaAJC937HPRifghHijVPYUMzwWkls82mRYW45bVIBEcGGvwnTaVytH/RAo2WLhrqwWoQ==
Received: from CH0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:76::9)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:10:18 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::aa) by CH0PR04CA0004.outlook.office365.com
 (2603:10b6:610:76::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend
 Transport; Thu, 19 Mar 2026 03:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 03:10:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:10:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:10:04 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 20:10:02 -0700
Date: Wed, 18 Mar 2026 20:10:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Message-ID: <abtpCXAnqLRnbG1z@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <absFXmFcpG8O7uNB@Asurada-Nvidia>
 <BN9PR11MB52764771C48B39C09F129F218C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764771C48B39C09F129F218C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: d119fd8e-55b7-4c93-dc0c-08de85650ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UVBiJwd431kmWxIDU065qJEcXyioUxg/x31d77WLuYruxwv7VEhFZTgGKbOqUWaYtVbPzX2vvFOF1mq/vWFluywgehUOCZAWMveph2+Nz90h2sPspOTJ5TZrjyXqkLQaCr7YW3sEnpzQ9oE5DuGePkwhCbydb4WdVMsZb3z0ahiKsDT3cvXbIBSLrUL86b04wrL4H+0zDR87II/rvffY902ZgKAKhLurv3korwibP9b/eSUIebLZih/fFjxIWXl9ifJazgV52VRbJh8UCyPEg9B1j+avrm13cRcCsDcxiOc/PY7IqvPnloxllLDLSY9mLLUTXqgQ6q8gtxtJJNsVp5NDsCSW/L4L6SRTKdHYufSJja/DRlDZxBMMqZN/+7Z4vsURmCxNpVzn6Kdxd2NAaZXiMvRJ6/6kn5X6TxsGcKWYc6K796vux9q+MSlh6CNCC48AgyfJMJvCOF3B+HCSRxAS7HkFYtp6qG+4D68gjdeU0f2X0V0eRdP4Oof9HskaC1kHUK4Udf/Mqb1IkyUUc8DVOjeEpMygkuG4SpR+rFC61LDL5DTzQZXVWDp3zJlKOWsExgWZUGyr4ZJ6GxjRq2oGBiQBBgIQoTmklAujCbr1YspF/jKM78BA3m7VvWGudZwi6NLFDx4DQXSH1PjfoyLURQVbwaB0a4sAeTAtmuDTMJWvXYjhxRJZD+B4ERBEOjqhN6n5pj/iaBBsC20YSRTdV8Vhcci78fLE/jguuWZhAXD8W1gUPoKrbGnj5Va/0jnTszGylIe0wl7XunVMEw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0s9C57b60BAW5DHzywEmatt1L9Yxwp5ivuuyFPj6KNI5q4EZCf7llshIFD5Q4H0iExm/aMuCJZHxTtZDf7RCg0kbBBUq2wNyVdOdojdUhtrbDVuGelTxI4aRA2UnhiIP8/0AYq8BePIZT3whbHKUuDiJCZ/QPjZtnj3vjYiKgupgpWPmopyF1IRR0QHRQYN04CgX2zx0Agt3yhJY4JNF5InJfl+HSU1vT7puZdE8AlABrANqlmag2SYDqsAdLioXrfS4tqBhjuqFAIUYRylTv+VmVZmzI6HX4aERtpR7LjE09krs4zNGQQpAXDfG3Yes+O/tOxEZ9mn9OrR0nqRseGdk7VGEFD8Nk8X1oH7ldeeDxD1LEt5g7GypoNXu73l8FdypRYwEnuTbIZYfU73i+WYeaqcqBWWJL/LVoYBIafCVMvxsVKPTPQlOldVU3T/T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:10:18.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d119fd8e-55b7-4c93-dc0c-08de85650ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

On Thu, Mar 19, 2026 at 02:29:38AM +0000, Tian, Kevin wrote:
> > > > This series addresses a critical vulnerability and stability issue where an
> > > > unresponsive PCIe device failing to process ATC (Address Translation
> > Cache)
> > > > invalidation requests leads to silent data corruption and continuous
> > SMMU
> > > > CMDQ error spam.
> > > >
> > >
> > > None of the patches in this series contains a Fixed tag and cc stable.
> > 
> > Hmm, I guess AI overly polished the cover letter so it sounds too
> > strong?
> > 
> > This is essentially a vulnerability (potential memory corruption).
> > And none of these patches actually fixes any regression. The PATCH
> > 7 even requires the arm_smmu_invs series which has not been merged
> > yet :-/
> > 
> 
> Fixes tag and backporting are not just for regression. People certainly
> want to see reported vulnerabilities fixed in stable kernels...

Well, maybe I'll just leave additional line telling people that this
can't be a bug "fix" because it's written on another unmerged series?

Nicolin
