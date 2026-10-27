Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118174;
	b=i8qvoiAP6/iTu8Cy7VJ0/dGFrPFKNEtvI3AknYb1YRtLzbNaZxFdDqGToQBjBki2tSZa
	 QD2+M8gopitqM4ENmdxdemqduWWKf2tCVt1qne7anKL2s+NSvfqZnKhvjzpVQkrCItoKk
	 poIFcfAz5AtMPWpW1w0O+UN+vpzWvC/usVy+C/FXzaH5XjnFIGwlV6dOGvHTef7wZ+/Z7
	 IZW0MVeIpe3/mtddzCKtbgbwlLFottBjfHi9p4QZlKn+K82x2pA5NMUtQQ7qrUG6eQJ2E
	 C3LyfZvjBZrMHRxTh9J+zey+ILohxVJWwsrWXjhGaruITWw9iCY8kPrzuxHDkI/89Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118174;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y3YveFxMxw83M3Yd+eCUAaJ7wBgNOrXPCdK3NcMjPBI=;
	b=SNSsvAWnV99i0MXm3lfuzwhndx1KEitGM1RUdwhiFFfRDWFS2TP/CpyTrOLPolJyKlS9
	 UqvniqFjbORL5Mpi2G+yCCZ244Ey9aQwG0DQGpz3xstMpC2MOrsi9lfeR4sD3dpg9ve40
	 N0NVs4eyVwu2bDqPt72OCP1G1ZwBS0g0JpyDO2cFyXOkTK4AYb6PPMpSnXRQk3Y2rq2ft
	 7SRRR3xmUkSJOCMU2gdkslQV6fUP3EXgIDjL63VWupe2jtg2ktp4hnJ35QnxgNdfWl5Tz
	 J129Ec24NWgYqBRmRRPnGV87t6dLK68xp6kTwnwl1aFL1d3N+WHwTnQ6hiBr8VIHXnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2DhDjDH4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.9
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D260A260F;
	Tue, 27 Oct 2026 16:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6D260A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2DhDjDH4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOXsZjFmm8US4yhZSwGQiXGJr9vYlT75zwynp5jQXtntcSxs9icguteWireOW0WOR37kG1ri2f8L1HLFNJdgKv+bTU9vJzyqNt0e4pIVC7eLpqLvX0gJBHhAPfP5aSbCfFPgOzZ2F8/MkaE2Tqt9d2aRTFxYTM93bMMHSfAUBiNPw+rDg4rqHmk9fW6imiIQRGnebQ7Vy3LfaH00rX2epEldNP15oeICpTX875/Ytxf9RkGkpnsxWkTRVBJlIBMNmKvSOtbrheLzhP3FEdpDz2C+d8Ri6i61HgeLopYMJTehNpXvsCBB7JY4NNY6fHRyet/NRPRuBF2QAhLoswgBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3YveFxMxw83M3Yd+eCUAaJ7wBgNOrXPCdK3NcMjPBI=;
 b=sZbVStdNqhmixLXft4lAYUJxbaEugm30gjWdBFCS026eyb+q6hFiNg/KMZxhdJwYZ1+ZUnF/6Wfvh97G+TWV9rOenF/ZxWYPlLZGu3wPum+iSkeEsvh3GFjeVzn0pJ+I++tKTX+SYhti5D+LVnhmRzHVon9EsCckQdPLO4IHCAmdb1spjK4QMSmOhlr8dM2B5eoym0aOGWj5fIIOUZ819nUfWixbayWuIeN5aYTPBGnbndwHtls2kJ2hGn5jUW3XrQyOMbg5Z/kAG9ssGPXgL9jEOaaY9AbuwzBJB8EjWzMUla4Ewd4AWZavRqnq3S12xBFqJLLAQUhXR6S/6YOgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3YveFxMxw83M3Yd+eCUAaJ7wBgNOrXPCdK3NcMjPBI=;
 b=2DhDjDH4lae94Bb5JCFYvkqKumlzKM7A7e56xHBeW9qc/sRevNXoQD0DUIoIjpiEQJLxMbPrGo1d/O5lQFdHmVXCK/2hkU2mSQLFEbIF/ceR13f75dX0wBmiVdt/izIydctupP8+MHi6YDVM3keb1mDusfJTwwQoB4WKP3uJCS4=
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 16:22:46 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ae) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 27
 Oct 2026 16:22:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 16:22:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 11:22:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 27 Oct 2026 11:22:26 -0500
Subject: [PATCH v4 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261027-vfct-regression-v4-2-0e7190e39c2c@amd.com>
References: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
In-Reply-To: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c18ced-ee5d-42f5-a8e9-08df344688fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|261026121527099003|11063799006|56012099006|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022115727099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	0z2v3KuaZ0EvwfkdFsyevPrUDRRTD9nP8uVj7nzVn5XSO82hwyak8B0FeULoibJx5khzTcg5tB1hp3SvNKvGQ6vtrSklSqw04e7c2kLl4zE+wtnD51ROFj8qRgXNwSX8DjO6jiBTvZoxf15160Xufa0ter/fugmraEk2df6TV95/+4R+ikQRHEAaTtNjEhuatYIr9j99Kp5BznHl0dNjExcKk4HvmUrSZf3UXKqDaPJ8GD4Er5BXqD3gJ5HesUxN6rAPNgzo7Kt8rbZODJFpN2lDzIVBIYArSUV9UaTdEFgjlKN8o12AU0TFSaXRRUIwn+xt89EpqL2y52lA0jZ84cOkBvR28jKEVACsGiWPKBGxpfGSY6MfSC4Kqm2QWNsvzXtNGP0tzbg9Uys7LPBm0VmNKnqCQclAHe9iCsn0YuI74cQpe6qQF4RC4yqGU2dX4S1jjUYHxcsJ/qFjniCcchTWceut3T6R4sWq5Ul+COrxKRBtWCdqxsiSxcnyX/9kQQ6mdmSRaepWTuDk1ItRjOrgIydPHAt5GBHuM56g6uNqcII2qOHgoCKlxR3ONu2y5879zNsAf9d0va3fjzo4OGayq8QO4o6SUmJ8tiYgWIBPlrIwUN7VPqDiauMklpnnEr9Eha6jE43+l6gJzdN3B8DFf0/3oIdhqlaMaorgcew=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(261026121527099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022115727099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j0MXhLkSVQkgsSRTT5ftEB0XT5yLSOP+LGv10tnPhCKJXlwHFIzHwiWQ0bUzHF7NZgV3Pk0T5eJ+Tgkav1ZI2D1jFXqLGpcq6qbyxb8jSuKpTGhpBNjB8uwvwnQ96yDXnbdKILebKfSsEdV4iuFVa51TOetn7/CfZ3I8ROR7LOyQXDG5IFzbz+06rdA81cNhJljqbAyiQDOmdhBbNnTrDA3feEh3Ei5hMqHn2R9b/fEkcA/e1XlP7+Jqifs14e9eQ8FJgSdv0LShVjxATb1I8q5FAvDxE0efbuDxsYvRjKR6VmzH6bzBspaUxQihOT++g62m6jjKZB34Wwrb3B+jYgztGqkJbqCxEtXvU8LO5Sgl8eBqPB+gInfyX39kr2cpXM8mt44mLB7Htsbtn4wiqHN0KReDXc/Vg/1cOPkngfDds1ijprgojc9anQWtor4a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:45.9959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c18ced-ee5d-42f5-a8e9-08df344688fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present. Compare against the bus number captured
from the firmware bus assignment before bridge renumbering.

Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..051be1905e296 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -386,10 +386,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
  * VFCT entries contain the PCI bus number as recorded during BIOS POST.
  * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
  * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
+ * value.  Match using the bus number captured when the device was
+ * discovered, before any bus renumbering.
  *
  * Returns: 0 on match, -ENODEV on no match
  */
@@ -405,16 +403,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == adev->pdev->bus->number)
-		return 0;
-
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(adev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, adev->pdev->bus->number,
-		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == adev->pdev->bus->number_initial ? 0 : -ENODEV;
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

-- 
2.43.0

