Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341392D0C95;
	Fri, 20 Feb 2026 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617233; cv=fail; b=JEFrX5rW8fmYwD/FflFUgJ0eAja/AtAuyB+hZFnJr2yw0LFoSElCKK/Jlyrr1YP638iFH7SYiCS6+Xp8wokAzY2Dq+XkBbquAcGEMhbY6aiMMNZ9tQxXrKnDMgJ1VkUPL2oL9gwINxJ08u4Pv/sXlVhCnSAsLzgr9njxY576BTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617233; c=relaxed/simple;
	bh=xEqLec+KkMYkHe/RWzWBflXgAA1QSGHbiH0m8KoQkOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kG84t5BNbkM35bIP1E+Vt4NzbyAFopo13YOWbK+HOGshUgFAEqMUYOfBVCmj1wSTTMIzgbzw2mKryFSETq16CqS7LeDAjf9AZFFSFHALHjX3qbduTZNy6eMAaYQfJ7++ekfSnEKyx48hdGzH16IwBgOYPo5Sv4Lz7ZVIJRqQp0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=okUDm8x+; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="okUDm8x+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUZcrONO6cucabq6VcJve9Kz+oylgTW+2eJK13Jl7be0f7nr5Os1Q8N6/t1rnCkAhzG/Mt/HqNJ9Hv2HCg9G01RwZM23Ed0XSSwF/L806PSgXQ8vEOFW6oHk9XTuKPmYMeXQEAIUXjQa8yBLKPbdivKrrC9KgGDyl1ggN5mtcHFZjvh0P5gfiXZ4pLHpLyDYbxFffbfvya5QUJxz7oHZ8UNtvLu4vf3bYMWAJ0C2q3pCAZqzIJvENHXgxXJxe0LFTz9bNNZ1zcIfhPedeBbW9N+ePEmrsSqefGW8CrWFoNd8YMGAV8V+vBQ+qRRBOfbn09JmwR2u4fC5hH2cb4Fpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+h/7E+06/KYfn73tIrcC93xgJibyeZemzNUma5mBto=;
 b=Z48dJyYv0aVb/VsAVUxtajjzN+qiqLnCSt7rc3gHta5geHG4dyRbVkLAe49DphnrI9PT+adz3d+B2q6whLgM2kavkS3DGo6XMw/ZQrzKlTafFqE6LpOG9Er4dsgCqyiHSfKIs1I43ZaisqnorLss+8bBnHLwQ68bVEDHu6gwfp+tbXl9DyJKv5dKseM33rIB8Ry465Q9eEudi0DaL5Q+Y9TdkCob9YuePMzREiPyfK1GYmsJENuvFSCVAQQrOFirHBY4WAhiz3cS9RmaHoqVp26z8twglU4YreKlk/qx6gquVl5EDf82iIVX+eLZwt+5VRw2vzgfp8lXh0FBCpTVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+h/7E+06/KYfn73tIrcC93xgJibyeZemzNUma5mBto=;
 b=okUDm8x+LKUlrPz2a6gfejIiH/H1Jqm7DyL64o9GveCScD7IO2LJIfrAdNy2eQHFSpbJu/7Xx7Rm4MeDQatVK7rf/yBt6fVucj8BWpZDxfSaO6frR0I7sKR/S69uY3KjzYHVJgyexckSsjmdtQhFWFTIQt3yHtOnletBgW2NoVfXLwXgNhHZulZkr7D7ZqHoJm7qzm2w2JzW95Usn5+7dFA8hIM6I2HsgNN+DqtGURLCoisS7ZddjvYp5RCNZ2ufXD9iY4yRvnfZggp7EEnlXePbusl7ubUpyAyv0Mbb1m++ezBt78Qiq2BHMERacqnm+OiGfz2NFWONi9iy2zDgXw==
Received: from PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::19)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:53:47 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::99) by PH8P223CA0005.outlook.office365.com
 (2603:10b6:510:2db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:53:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 11:53:24 -0800
Received: from vidyas-server.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 20 Feb 2026 11:53:20 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alex.williamson@redhat.com>,
	<raphael.norwitz@nutanix.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <smadhavan@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
Date: Sat, 21 Feb 2026 01:22:59 +0530
Message-ID: <20260220195259.2397847-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 792a5071-7b77-49d4-fcd1-08de70b9c2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWJ/ffWXvbFygtSxbBLnSDJS1/vihpqN0A9G5TWSbhIQ+ayC1R1UemhUTkeg?=
 =?us-ascii?Q?l+crkOBOyoNJ6ydgfXCq5SQZC91PPnea7ipT5wSc4U7mUnEsmugh0DbO17BN?=
 =?us-ascii?Q?5rsCzlGIJthKVolPSp99ONeQm/Sw7nXDmrqBWieqQMA1FlFCvZY15rZ1zTYI?=
 =?us-ascii?Q?ruQPdIB9c7zfgSVALFv5fj8nOP2zbFe+iSpEE5JIgOw410lAo5FCeYFV88uN?=
 =?us-ascii?Q?lpo7/Cp39Axq+KHUEheIqlIkjZdDPRdMEbV8+O24xZ/kE8xQ6XY5jhuu37s8?=
 =?us-ascii?Q?ETVlyUuhi5uSwI9+c19Is5qKbO3v3aSRAS0ZGgguOZCFMYwSI/2flEFZ4RR8?=
 =?us-ascii?Q?F/2iLFNdH/vUA5GRQHzyPQmECOcCW92qOrAYnPcaUbxjHzGJ6GsNyqJ3H0y4?=
 =?us-ascii?Q?ZJpIbI5AuNkOMx8pwtmpkm8cw5DclFAz4ISC8C4N6U1v2npf2IA4TGXSvEPp?=
 =?us-ascii?Q?nUKVMGWRppGPGoET4NIr5yL0woBhkfmgueAWYA4zqXjytNmAMnw+Nt1kq374?=
 =?us-ascii?Q?Y1sqfPDBX+fn02KBUZy3JFBcQs3kYy7KInRy4IrBVWIodJ3p/Lu7y56RY916?=
 =?us-ascii?Q?q8GfAiMSLR4WWZinrW44np7x5NY7nfHK6upWqc8+9qhTfHiIqHmZhNmD+DPH?=
 =?us-ascii?Q?Pwd22ITlGFaLH15KXnjtph89MNRqOrLZyJlSvsrrIUjl4IrvQVL5IEpeBEGK?=
 =?us-ascii?Q?snAdFQ51vlzs8+6Y/IEFyrNxnIejaixys4rIZwdmjbaMl9l2Q2qValeJtA3K?=
 =?us-ascii?Q?KRRWIu6VWMlDV2MoHucOGX8xBOLsbu65wxVqzDf/3wVESrRTQ5IkI0zI6XQA?=
 =?us-ascii?Q?PtGtAEbQcrVn6QwWtVrEUcwxYDI96eqjxzb/S7G2XfV6lmfkqBGOuhoWsj9k?=
 =?us-ascii?Q?OkTsgZyYyGYz0dOslCqGgFd8IDti1cKWnQWUQn/VC3Kv7gvjRlH37ssOtnRP?=
 =?us-ascii?Q?tbSVYHikH9NslzHGrsjHUxHij7hr/ysCgr18ipnabQlKboAY4SdqIJRNhkW1?=
 =?us-ascii?Q?RLOPuo8IEKrn3sHhhW61HE0e7Q566+w6D2l5F+iHxXns73f9vGEAifPjUced?=
 =?us-ascii?Q?rs7ym+C31ZEaDr8v/zVsv6n9nAtj59jp+9S6aqPZ47GM7MIs6PBtQywY9ZDq?=
 =?us-ascii?Q?O4QcgLXk1bCR9lZs0ThN5IgEhSaUSHxFNunk+UPv5lm9pdWBiqg4XQM3Dur0?=
 =?us-ascii?Q?F1lXPCVZEAnMdch3/DUQzw7Z2iUzOWVlU1adA1Cgo83pJGCmghrxx3o+uksF?=
 =?us-ascii?Q?m+DXw3TDr6ApiWnWWxe0BHEQaQGTHWnMN1toWU6zvyFD++0X5GnN2TQxg5dm?=
 =?us-ascii?Q?Ght4367/o5G8reCYi59BKipaZ6ZoiY6BXaaDSTpvUick/LQBoSlWDJGFDW1+?=
 =?us-ascii?Q?T8q0pevSqAdFQb/drTFo/nko33SFbG+yiucoyaPCtVPytO7E3fXNSvLcjZbs?=
 =?us-ascii?Q?FBX8J/4M2aEghI4znN8eMDkFD9gc7kikB2faB99+PLXo7MguC7oSkh9ssYpZ?=
 =?us-ascii?Q?hB84kwteNuQU2xkP53NiPCa/nErkXcC57bCZEX/FQ++l/BdgtGnzrDU7TmRK?=
 =?us-ascii?Q?g6XX0BpJwmACobtErSAYIDJ52mWqlGPzuOIsK49XI92920WXtdw697lEY00h?=
 =?us-ascii?Q?WecpOiH35aifWmZbqyFT/lxXj1VQi2c+Fn+bi2eYgHRHbjjshlhZwqT9hcOb?=
 =?us-ascii?Q?xZJpcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XAMaR/usGbsv7nETRIiEFomYmQgZrdHpBIW262tlhGiR/vH6qhuoTUc9MGFsVES2rASW5N5e3BsaMKRt4ANSdlmbwFh/G+Kv6ODeZN9OGcDJ4bgg8Q9E526pc6626pOEhDJ52WMs0KdPQYZdvzrbUzsQVYlzQH2KHLUmVrDLn3DYjAzUd11X+hjfXxepMVJdD5FVVbg/mRaNUnUKqDZRg9/XFP8Lsdrk+qYK/4bGUsVG1iD8wfZ10+o+PFe2lQ7gUXrqfom3ypFwiHFALGSIRLAy5n5ITHNgGRs/5t5dD/fwWNOR3btwdIwZajX6XzBVGr5kfnKp/LV0aX6EIl/62rj5PHQ3FvQzvt1UYh5WoE+P+pa1dWOjI2k8IjVylpsho8n+kN+tAZ2aW9l/qLsBUc4SdxPaxwvdDMJ83kY+LGc3Fmz1UlH9KJnjGKhpRCmk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:53:47.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792a5071-7b77-49d4-fcd1-08de70b9c2bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757

The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
the "Unmask SBR" bit in the Port Control Extensions Register.
When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
in the Bridge Control register has no effect on the downstream bus.

Currently, the Linux PCI core checks this condition in
pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
execution of the reset. However, during the probe phase (when probe=true),
the function currently returns 0. This 0 return value incorrectly signals
to the PCI subsystem that SBR is a viable reset method for the device.

As a result, 'bus' is listed in the device's
/sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
is incapable of performing it. If a user attempts to write bus to reset
method or triggers a reset that falls back to SBR, the operation fails
with: "bash: echo: write error: Inappropriate ioctl for device" error.

This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
if cxl_sbr_masked() is true, regardless of the probe argument. This
ensures that 'bus' is not advertised in reset_methods when the hardware
prevents it, improving clarity for users and aligning the sysfs capability
report with actual hardware behavior.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..57e24300d1c7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4915,12 +4915,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	 * If "dev" is below a CXL port that has SBR control masked, SBR
 	 * won't do anything, so return error.
 	 */
-	if (bridge && cxl_sbr_masked(bridge)) {
-		if (probe)
-			return 0;
-
+	if (bridge && cxl_sbr_masked(bridge))
 		return -ENOTTY;
-	}
 
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
-- 
2.25.1

