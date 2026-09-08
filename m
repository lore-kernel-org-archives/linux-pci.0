Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3658596A;
	Tue,  8 Sep 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886861; cv=fail; b=NsnKN+sJmuCNUeoy8IBnIjVE/q5wUHHMqNEB8LlNX2pi+n2p4l77asTmEiH2xjVxNoz6YHzcG6QfZXTsTgxC5kQpli3O9FRFN80XjQtUL8QD07lQkdGMcB51MpYdNFntsuh3NCnzVrKDgc+PhtKnsYb3Up4hPY8uIyz1FVEqsxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886861; c=relaxed/simple;
	bh=ghZE6IN24+oLmoGfQXrad5FBriZVjxKxUwTDLr7S0kE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nleh5RNUAxew4FIOMeZfUtuLsMb7tdapNGYdFdlS8HVR2SZojGC+tUg+7Sog0oVbAfbV0LxJ5PqptxVzzp/zNLH5sv5RQzf/xjPp0i0V3Ny2S+zOgTQWYlqVo7BAnZUW+2vBLRUH2uiS7faJnyTkl58kAedKcWWKnPDORysz+9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiEmDsDs; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiEmDsDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJvBkpzlmwrflMOkbhb59XC1t99LbXT1swYLrMvQzBpU3Z6MQ2btBqsJS1RtadAlYE31Cy9hsqC43R9jnJxIdOvlHtTuk3nMZO8Yik9OCpIAJUDYl/NG17EjJLU5pDH7N4vNzWpCgkt+95G8g+yH+GzwNNIeEPFqIAVjT9YyLXGelJQRGrs5qW8FC4Hp9EvPOF+XbJGC+NBqPhnlXgszP10NDOi9wdBrK+0rmgEas32SjN8wXUj8yu1FCJmuYUz/nxRavW2lOzavjSafn8G06VRRR/lHX1EmAoB3KX2gRMoEry/6oKsQXkLoTvgG3nv9bzKaQq8lC4SH68GPYTwxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr+OJJcr0j4kGMwXnWpZrvQZprTroK5BN9K0PHTcOVc=;
 b=qQDNYmIWNomvzDnE9rP5NTzrDm9fKLePuooQKqE8VazaDQ3rqwrHpdP7LX6BLNXEKHLotNXThcuOCb8RgvIzVwSVRh2nJUOJYJZ9rEWMuyivoF/HN7UORTGhtiTUVbFNmgZAYvyfvyKIe1Dl3ThazVwO+cCgyto9cu68lFRPeLD7NxJXmskXGbX3Pupz9UAQABgkZdoNtJLcIzgPfUfrUu3lDaDd3fgEs1QFOt86RRPkbM12NZhsNXwFg5bjckNepHUrEfFYt1rjL0Cpy+ptpan8js5qE5pES5A3oc/VLYocYAsH8/TzKBaYnTuwPviRuteFLx9HwR/kaS2yWbjASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr+OJJcr0j4kGMwXnWpZrvQZprTroK5BN9K0PHTcOVc=;
 b=JiEmDsDsakWtsH/EqLlaZcQY2YYE54NUhHvj0wE1K1Nii6+TFuoxEUIyX1WKMpHgN0vRNKsQF2TOCRw+719beeF5qRNXUQS8eXhMyJOGIPGKthSRWKOVqwLKTAYFpN9WROUWzdha1l9KjhvKWC1EewLda7hT3+kNaLrxvKXs8tc=
Received: from DS1PR05CA0013.namprd05.prod.outlook.com (2603:10b6:8:457::13)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 17:00:55 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:457:cafe::6f) by DS1PR05CA0013.outlook.office365.com
 (2603:10b6:8:457::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 17:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 17:00:55 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 12:00:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "open list:PCI SUBSYSTEM"
	<linux-pci@vger.kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial and
 Parallel ATA drivers)" <linux-ide@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit DMA
Date: Tue, 8 Sep 2026 12:00:33 -0500
Message-ID: <20260908170035.160166-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: eefcc2a5-25ff-4624-16aa-08df0dcabf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YCAssL7Cit67ciLhNFJ0FhlWuA4pK2w1Y9WUVKiKq0RuMkrGYd0enRXW4eNyo+NbSHUPLpIITFNPLo7WU03si9/0IsZrwr56w2vVg0LeaCSFgIF5BUL/Qk+HWWfR2dYwlSrQ89mfXlM7F5IoWOwv7RJIbvmgAWWBExnAR7jWnqyyfP0llwPXtYcCODaNs6bXlVwbetXd2bqSGuNBGIfrNoCvLU2eKNH/vkAz3uPYvSP97eylB2JVu1Z5UCy7OXjqn90LzZyU6boPgJn4frydv1FFYhtK+yRqDjsL9hqwRTwj+ginD3lrn2KT8IwaAVf0kfV1TWlampzfTM1bODdl1kwwC/qD6X2QW/D///HlR0lRZG5rY9kk4rOSPzmQ9sHAnzQXraz9s95giwZHatutbpg63G+wx/4k84HxTe+NaIiHesfDAUjXrZGtpe/u7hKB5xPrVpdgaX5YY9vgpahGzkdZ4Ce0R4rCOPDjpr1RmrQRANkrJglENpW21HAv1d8ls2kI4OFigRygNe8ptsUr6XVyhldsPsQNJrxHhwJzQW/T/me1T5jQvoxYq3gA9W+4fIdLNaRjqH3htZ3Qvs0WmmyCrMQkZJDM+Yd0DjGYRHExg6LSlBhUIdKsV1Yg1p96DA40jMoS2wU3Sc9wHUJefZdhMAkQOjVxPcPkLFm0BDmFTgxCWtwGlNCfwtl9v09MzioQKEoeAUYZtEl9qk6lYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vRyQGeHQET2IMdtaSDLuHSWFBIjDrDJlvPT+6WmcWdzi2HoynTEP6qzvR14vPTfZToJlODFXcy1JvTzrtqqXz39duG9bh20Lve7wRR8UhgI0AYBv0t/Ee29tSMzWPXrzZpHtCuB9DsYZ1Ota/sqMsTHflwQJ4S5teK7MQBoYX9QB95FQV0efHG0TC/U7/xR/vjaZTRpjNHzcUT9pbioIfxR4uT80rv7yJQtGdIBYkqc+69qtOKBfbLvSSCiZLP1NQkrDKVODbCndBhnXa+UChIYiATPoVnUxreiyFvRDsSzw+ujEqRnmhxJ5mpg1sabxbqCQNsGjGDx0IipZiekKhXT+0u2BRoRWlzIf1ZLMDil9Fp8Ni3oY+L1t0O3m8NHUVP8pFFoEPIw4STRX++CnstFkj7zCMIXetVOXJNdgoF+ETKyS0sQajP12KQYI0y2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:00:55.1662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefcc2a5-25ff-4624-16aa-08df0dcabf37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

An issue has been reported by a number of people that corruption
was occurring on storage for desktop systems.  It's notably reported
on SATA, but the same issue also appears on NVME.

At a glance it looks like an IOMMU issue as turning off the IOMMU helps
the issue, but it's actually a problem that occurs specifically with any
IOVA addressed >58 bits.

This is because the BIOS on these systems is enabling a feature of the
root port called 'enhanced atomics' which repurposes those upper 5 bits
of address space.  That feature should only be enabled by the BIOS when
the partner device supports it, but it's instead needlessly enabled on a
number of root ports.

As some of these systems probably won't receive BIOS updates and there is
active reports of data corruption root caused to this add a quirk to
disable it on affected models, and also remove the quirk that was
introduced to work around this issue in drivers/ata.

Mario Limonciello (2):
  x86/PCI: Disable enhanced atomics on some AMD PCIe ports
  Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"

 arch/x86/pci/fixup.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci.c   | 18 ---------
 2 files changed, 93 insertions(+), 18 deletions(-)

-- 
2.43.0

