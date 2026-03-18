Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB7271448;
	Wed, 18 Mar 2026 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864318; cv=fail; b=V5osKQpPx+GvYLEtGFMttOyqUejnTosHFOnvEROINTeJzvxz0u9Ai1wkkJaRRMcT3lNaaS7yu49IiDuxaG4Q1K5kcU6wZNjyAwQBDLZc18cVhXLno/R1QWw5GKt3SITzpSoQY227/4Uv7WDq70VHjQF4msptHUej5a7Bs/jeBvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864318; c=relaxed/simple;
	bh=G4WwxVUozeAzqhIycYBu0LeXtgkWOl/NFsxXEMOxPO4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbU6dBLAWn43xC6PeyGcAmh+PXIHH/hHQjq7I0NQdZhtvg00+rKyzY2JqykUbnwHjnMVHyb+DRecTl95K+C6k7ud8lS+FiN66rSUMpNNVjr73VoobfbfSaQ+sMRxvg6amZ44Ord5k2LL1VebKBmKvutaHQUMDzC8uTzJ0h7aAwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHMEVlR5; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHMEVlR5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZU2ifw35jgkHqwRxMS7GfBok+8lkDjrQa01FEsYrDEKRdXaiNg3g029w5EZOnDeV4TYprRoD7O0GRnsp5xLCiqLVuljOyGPydtEVgZlUqOOtXpQrj519MJj6vzJ5dKqLiGh4leOkcGhDQ0PLCpsCRU2wjQRMJqQQ1k5uevL9F8YUlKwi8SRBCn/OgG69Y8kKd1LcfXKLGLWiZYRN/MPK4E/GlsCX6uxKoTG82t6l1x0jQsidcPXan673ryJz3xAZTHDVFmrI/01hKla/k+qDWEoEr1MVFVFOgpX6pidqCs0cep4PkQjnd8EvENTm4aAWtf26RTEoe3MleVzMOfurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNWGA8WGDuGqq1irBzTs+QvDEUk4f/zJ2rjUy10qfDM=;
 b=NfDClRk6lZNlWStpGdpdoofjAJFKDk+RQJDmnVfclBmDK1zIB2iwSnm+ikC5bYXf3osfDw1k2IRc1MYsDL+JRv7njMSjAPs5GZnsZjeU4CvVquitmbTKD6PLOi4p0nBk/uUEuGLyeA/n/L6Epsf3j5cV0GyrsgcgVeLHxjkaB2/7K6kpgCtVWgwf7uzDinlhHuwzdK082IJLfK4b2JbeFF2zhBdWv3gFPNqjraJV7w6j5ilOVvHJ+ll5euW7NkquhSvm71AsUtdEmiHvPVr3j/Mn3mCd5N3jQMeVIMbbknwe754/Qceg2GDRYz8aynbg0VbxsHJV8V2FWOxqw5FAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNWGA8WGDuGqq1irBzTs+QvDEUk4f/zJ2rjUy10qfDM=;
 b=iHMEVlR51YM13jvBm+NWCcNj2eOUC8y9d1EEUT3dJ0u5I2AsKl7N82HPxF6TUlqaQltaC/EawjnAf0RKMlqGRLkEuYH4W37NluHd2HiQpTd3Sb3lRHTUgGvUMy7mxoPc5iefSZ12UdKmvezSuGE0oU9WLSq/7HBZT84wIaP4jd68OorjgFTJ6+DjD6J1XY6MkIQnCI/QdN0TwEdjvEJufhOqLIYMaapjvQIl3oAxZc0Dm53CYLgr08c1vufvRZ+gFOCGo3SoM+fnAX1SNNi+w8J6gAzm5ob9TZ2cJ8OQJqHeigPmw6lhog2C509V63a2653mpCEWmM1HDgfnCmH4fw==
Received: from CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::30)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 20:05:09 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::73) by CH3P220CA0024.outlook.office365.com
 (2603:10b6:610:1e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 20:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 20:05:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:04:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:04:49 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 13:04:48 -0700
Date: Wed, 18 Mar 2026 13:04:46 -0700
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
Message-ID: <absFXmFcpG8O7uNB@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: a4051207-c669-4da0-f276-08de8529a828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	23ysBzoucviuRE4dmOYS03w97DApvm+1oTPtkKyjbgVGozn6DiOySxius6JS3vfsjrO3mzXX79CR+0Pz8eb/GTvhg3E45OY1IKZ2X11iavSt0cTQ71wUmKbJljmhcEMDvwEQa+/2AnC0RczC67Qcqhv3bN/re6ExOoBT3MGjVrXcJaFcvB3j3O+muQUXXIOpkK0/FB3iLUvwuRtqOLUrwlOXSNVlcfPquRbh1LEFs+qwtQDG3bGmx6H6b4v6Yx/Hpj31D1dHj0QVrCR3sOUKmr4BklpKOrP71Xw+oU/wLAwqWbZIDsszscLhfiGMl31Aby8u7UnkfZgbAO9huhOCtHQ8EB2cYrNe6tHoWQI0noXnI3WZj3o/51yIQhlKkwbwC5qI9X2o15LqgSE8fwaCg4UamUjpVJTBX/3d7ZpNOEpq7XWCqu36On9k2X9qhgV843bEGQC69qfJ8OfDE3Zw8miavxEYmOaH+D4sdgL8++X1ps7N++u+XZtqgLAilpsCDgH1lBD6sWJfB0GlJwFIOdpaMMl3veDt5d2O2/dKW+E1sbo1XFhdEuSBgl3YNTjopIdD1s0AoGIH8EDR35xRoRXTxiiqKa6AOIsHEWZKwMr35g0f/Ww2Zqpp3+xX3nywgXfhH39cx2KhFt9Zh2vAjcKp20/iwpMdiPRqqUZspCbuq6B/g3kv6nd1qGunOF/yN152kLTFx7A5tco75Pa/pp1/ubBdXP11CLays4g0ifMeHr19XPz0TFCsJmfItPWetzramBGnHbHuwZzCr3Fz9w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JClN7nPNlrPdvECuRnCietkcwBzm3Xq1zKt6flnoxvBS2GR6i9kVIJl+S49lvoSNgs4tAGorPD+0Zn7uHhzccYVpORYc53q5KsR+YYTlNf6/SUglrIzVGjz7bCV9uV6ZjXDOhfTXH/pqzXGH1bqte/0LkOu58lVFGGefnr8IxBS3fWB78OsIaxNNxkIkc/9MXBpVNijKzlKOwGI6B/MO8Rc74JVD5FoESK7L2HIRdELMwUKXREr/dLBdOE+oXGo9ozcCB7FGDJoYV0uarkrigTjy0P0CLbyqnDWs7Xmm4VZ/7J/OBGniDeByWor7ya5+J5jaRC1/9oHZlDmTrPJG2bWa8NFfcO257dOCkzslgqfx95FrHBbq5Pada3Q+QRDGripcGz8gdxzEy5Ocv6Nrj3dY3mqzw/qP5qNWCp+zGsaQXMFxMa58i/uHaKtjtEFA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:05:09.3118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4051207-c669-4da0-f276-08de8529a828
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

On Wed, Mar 18, 2026 at 07:47:18AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, March 18, 2026 3:16 AM
> > 
> > Hi all,
> > 
> > This series addresses a critical vulnerability and stability issue where an
> > unresponsive PCIe device failing to process ATC (Address Translation Cache)
> > invalidation requests leads to silent data corruption and continuous SMMU
> > CMDQ error spam.
> > 
> 
> None of the patches in this series contains a Fixed tag and cc stable.

Hmm, I guess AI overly polished the cover letter so it sounds too
strong?

This is essentially a vulnerability (potential memory corruption).
And none of these patches actually fixes any regression. The PATCH
7 even requires the arm_smmu_invs series which has not been merged
yet :-/

Nicolin
