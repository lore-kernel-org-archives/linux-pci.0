Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249F367F48
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787376; cv=fail; b=AMirRKRWtD3FJRTYBMsm3mj9YfwfZ42ckMrl8kcvOXqSPbaZphEp3W+mOdk2lkWHhiAVmrl2e7YR6Uaf9I0LOn5k/1Z5TWctrccyFZsCEfM1lFVAR5lELxR6guHsWGJJce9iFnlFxt9hkMXsQOonjGuwTSrmzOEz8Q6VSYeqXBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787376; c=relaxed/simple;
	bh=Mdyj5Ajc+RonpxRHCRnovRvWPb/TkrWf7dDFV2K03CE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=By9fCjFyUMEZ1OwLXWA6ugn6mnWaSF+E7F9TnXVs/ogr3u92W6KTr0/5DeUjuoMuDD1jYtxbPM/fr1xsvs1JElvQEV3PoPFScawQvLvDMCqZ9783QSQZhqyufPMhwKE7xSKqx0mxJOmhFjM77xhhRrOwGWd2KdsqsAtdOxakCi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNAta5sE; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNAta5sE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTEUXf4+hpDcfuE96f7lFdCjlCMj1RZJ0xtPRVka/QDFN5+bbGzrosOfb9ZanDwlTZP5nKN05rgxppRBqrKLGtv+g7IwUSA1tJOE46/5XV+GyWcZ3P9HVdM4vFflTqYAzatwIgPjvLnpJNfDWlknYk9/u3ga0TUwvrX4EKwIJ0rnldTf4bIwZeCjMHCh+JHtBT6vforrm6k0Abf/IMl6f1T5JNVSR12BVB1Fk6wbEZlCvAOmVpAm62pcVR95JO41s0Jvn5iKg+njLJSyozs8FSO0I9hToMGP9Xi9xVrlQB34QsmjiMHqQgG0Sm1hil9va6N0o0oJhuuToUl/WyNe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Eppdagq+EsDUeCqbI+mBNGddByBeZjBO06e7mPXZzs=;
 b=gNSANf8EWhA2+eZTQbxCYHRm/o+fWpDJVHcHfh6ebhakUgbEfYofIDzhYzm4CLktY6dSdqm/6ZESPdMnF0FriArRlksDklg565Bf4fJm4Uyw69cpHRb7i1HHNf1xPVrgcIXIBmQ54G0rUMegR3mqq420YCQ63MPvc5AWd7ziMeGd5YA2VHYCYmER3BVC180ftebAHcGAG73KkxfeVAlDyBeYCfIOVVWW+nXHIl3Sx9PQeNn21vEUygLc52uAljc3z7T1uWJWzezBoqO8c0lyK/Jw99tOu3/ThvWrJG3cshfax/3dOenzJSLA8GJn01Q7wCPkDwLOODrVWSkfbDwkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Eppdagq+EsDUeCqbI+mBNGddByBeZjBO06e7mPXZzs=;
 b=YNAta5sEMjvGAkNYFXeu8vleOvEtNM/04gACgbdJDhxj6EPdxqtSOKYtynklUra1Tx+NwoS36KHUbpwX7Vu9KcpbvTEHEgol3YWKElV0X4NW4jxo7nmiNXKN+B0IC3jz8wF3id9a2d70Rwrdp2QIojeOPgAjKbKwiKB4LFpSsyI=
Received: from BN9PR03CA0604.namprd03.prod.outlook.com (2603:10b6:408:106::9)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:16:10 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::f) by BN9PR03CA0604.outlook.office365.com
 (2603:10b6:408:106::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 06:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 06:16:09 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 01:16:05 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-pci@vger.kernel.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bhelgaas@google.com>,
	<alexander.deucher@amd.com>, <mario.limonciello@amd.com>, <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/2] iommu/amd:  Fix default domain selection for PASID-capable devices
Date: Thu, 23 Jul 2026 06:15:46 +0000
Message-ID: <20260723061548.10187-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bc00dc-7deb-4b32-8ef4-08dee881e386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|5023799004|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DehZqERzV75Xa40LtXJgG1AMncDnVtZqTtQfbphsFcsIoXVGUdviay7oU9J/Obg1QK6QsXFKMexuRgFfhDoDiEG8vEuaqyaBS2lzAQGKJN2DgrJDTZg1b79s6ymp4Rljp62UpTCEUgmDZHIaONUR4RfxBrCmF/Do0SozwDHm0wb2wecAZ5+yItjoEBhgeX3T2TJZzULxYUNtVgrUmmCl+/nzM4C8zfA7Ekr3KX1ufEpQhfy/Pi0SrlHpmYvqoDZEGbLJK6m24W8bY4Aoa6bOTh2V5WjQAjgiRhPOkVb8uyvgojSEM41jIYVoJyGmeyF6sZOa5Rwee3uffD4FcfxsvszqgsMtIwUHLsOdrmUx4a58OEOAI8xvSeMoINlsS37vrfr4yXaXoRHnS1VEmnwIglOLGBXMDi/78ktnBYbjfJ5uVEPuubRhoDQuMlpWqdvUpZv+y7IOPHxZZW6xi9URWplVcJwl205S+zsn25jZre150NOZ+v8sSMtmNZ4XYnGrwMYPsSBGrK5oZ2sYYQjo+/iTVCrTIy5lIdZOL+CIXYTAnilhY4FyXX+aMcIHMgX6ae5Xfji8pKz77qb+kZbhq2xcCzufRpdvDFDzNV2qT3SUf62QcLbnryhVCeCgFjBSTrP9z9LITCgn+pr0S2uBPVTBrDQN5+aNVtMEsvSiuiut4KarfHXFQRXPruBH1al6RaoZG5cVB2eaMA9ZHLQVjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tZ+k7uHaFj/M79vUkayWIAYyIOGYBSZeQibA3AOlPnJRhlxKlEVb/fMqZ5KH/POPdEGcQz/Xn2hqxCBbWgda7Oqa/DzEPZSLielkbw0kPr+lSEaaZlO0+wQYBIjqnRElLM6bihi9lmC2xW8Nn1CS0ZknWQ9YZUZxy3PITlYyUlqDKQArzVsNdDNfg1weK+NQZ85tjNZFx1JSsR1KsNfNahbDGk/k0aB3GX7Ai8LpozTPgPMIxGpZEDproUFX+NpVvQKX1EmKtdoEvrzPH9RlffHONXMStICMvNNiAqgoVPxx3dTyvAMzk4PByV+u7UXNexB64HSbYOI79MuyQsppo1Mue7qAIOck4htFsbuG2gvPnOzfDocRFea5hmNJiwVeodR/ZiUootnNbCyc2Xgf+dYoHIEcCDdz6aQOtwuKzMidk0RUpDpP0sBvtFC+nUwn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:16:09.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bc00dc-7deb-4b32-8ef4-08dee881e386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

This series addresses a long-standing issue in the default domain
selection path of the AMD IOMMU driver.

Currently, the driver unconditionally forces an identity domain on all
devices that support PASID (Process Address Space ID).

This series introduces a more targeted approach: instead of applying identity
domain assignment globally to all PASID-capable devices, quirks are added only
for specific GPUs. All remaining PASID-capable devices are now allowed to boot
with a paging domain, enabling proper use of page tables (v2 page table).

In addition, this series adds an ATS (Address Translation Service) quirk
for the "Radeon GPU WX 4100" to ensure correct operation when booted
with a paging domain.

Vasant Hegde (2):
  PCI: Mark Radeon Pro WX 4100 ATS as broken
  iommu/amd: Force identity mode for selected GPUs only

 drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
 drivers/pci/quirks.c      |  2 ++
 2 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.31.1

