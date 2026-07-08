Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9633E360;
	Wed,  8 Jul 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524430; cv=fail; b=gRUKQQynWaL/R+bYGGvKqkSSw8xOrZJC7MuKk0bjM4A8xQ3vvKq+0g+NaINZkDxDOwbQTNSyposRZCb8uUXU8N0PSYNKTvvsXcz/4fEzdzWFArZHMMkOWBmjQ5DS5x1BHM+g+GCb3UX7kISb7NTISsu62WdOUKtd3na8kQLiDOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524430; c=relaxed/simple;
	bh=KHb9+dc5BgZwagUoE8PeQpt1mbO0IAL6vhGWr0alK04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZHeqsRS2LKklIfKSbbravg4FCUGbEoDILg9GccLsbV9gah/4sAnDnopUVLa2PhpKoEXMeeKJYvcmjoycwwkkakuI5sEO41snsnP1OLTUHRntNPVb2GtDKcF4tmvpcLIMJgcRwJ3gNczQCacPuqd64I34rO+GoXVue11FDyEJag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zoOPizzS; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zoOPizzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu1CvNH+eqQbEi83OBhHW+rzwZ3UFD1ELdcHH4s8QC0NOMShQL+eCw5M7tdZcmHOX1MJiPChVah2BijiEfS3W88IeWQEP/mSJNkT1T9pPW7JDvRkj8JC85TZcqbT3unFoldCS1/6uNBHxSFyHluCQWQq7tlc4+imynqloPL2g4Ryf10hfjk5Dp55Owscx8XWBy0JcfDaufQ9+GmC+FZD3XFUq5m6p5a8wMGcwFuSqAC8xMZgwAdQP0EHMeR4EYcJBBOzCoYxmUqkLilQR0PKSEOzmhentJFQLDPjX7i0UxjjvHz3tKG9EzZnmuW6m+b015V6hwnZc/ZCwdvKgfVlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URZzMcb9WvaW8TlnOGaGcWS/PvUWykvXv1RUNu5dGrU=;
 b=gPL9ldONRQ/jGGA8O219RUvOvEau4YMn96s2wYzL3qWt3lehxD6PlJN1Luv5TQpEvNel2jdXhzulmkBqlhLvOhgFOlp5p9afNtT68qpYjsbkfWEI7agqlUeffdQsYUqq9fzU5+u4xryIABunAHWbhoGzUWKLH4D5+aXgYLO6Dah5zlwGGzYdAhaLxxmU/curexMQ3+nBZe2x1jy/ei+e5CJUzHBD2VNr45F62/buOdJKjxEIyC9VMg/7FdUlgjKr1VspZciZoGynwnX1FXEkgSlTqvIkftL59R8XgDWV7l1g6NLILYg3BAKHSr7EmcVoHcS+92SpZ8TQTNaREgp4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZzMcb9WvaW8TlnOGaGcWS/PvUWykvXv1RUNu5dGrU=;
 b=zoOPizzSODbIZZSvESerkQHg1pQZN+6b+p1k/BIACcC/AcFiYdJP2um8QqZthDHJs6bz7HGNn5HCxoAMpiLqK0olSBwPrGN1d0Wc6Niy0/AwUn5iD4LSF3AVbIpDlLC8ZvDU8mgq6PFanIazN5uj2XjYQ+6g9Nzhs7RIi+rm3fU=
Received: from BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:27:05 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::71) by BLAP220CA0029.outlook.office365.com
 (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 15:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:27:04 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 10:27:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:PCI
 SUBSYSTEM" <linux-usb@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <mrh@frame.work>, <stern@rowland.harvard.edu>,
	<hannes@vonhaugwitz.com>, <jase_harley@protonmail.com>,
	<superveridical@gmail.com>, <david.c.hubbard@gmail.com>,
	<bugzilla@logical.ink>, <michal.pecio@gmail.com>
Subject: [PATCH 0/1] PCI: Add mandatory delay for D3cold resume
Date: Wed, 8 Jul 2026 10:26:49 -0500
Message-ID: <20260708152650.536604-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 794ea9e8-68fa-45c4-c4a8-08dedd055d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|36860700016|376014|82310400026|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	K7IV0F26RtQd+nOdgZui3o8dS4BhwilVXBJj2oH7xqZuSwjmU6FqiuHuCYdJS3FmxGiLxqM+0tXej0juI5dJk5gDfY9gPj3PPfo/W/446c218PrxMQUjMv0aAGPTGYUEFAx+w43Gp8OW/AFMCqvQJ54mSAcYDSSZlKH694W3l9Jf9ICHJSriOhPWBHu/ouJrhGvIpmNlaTNF/mC6Y4qSsy+nJNCRiiBKaJ908ffUamkqiFXOr/Qu/1HesFDHHyPz0CMcKvRsMleUSHJVsGP8XYrhFnHlTavhWDNTEAzCLkWxvg+G7G8L5a9PhYJRD4a6g2Yj2zoYJUnwcbz9AdMyjEF+SosdhEPsA9ORIsXt066lGDTjM1ObKQ7q5ugwM24FJWTiKtGLOR4J5xNeAdUgMlHnO/tA+27VFBckAwvaXucJrGaC+BOBQuJ58yfh52RxxPoz59fBLBI+Uq09S+kzxKl2cyTPU/qFsgHuKbQOlBUS+A1eOS/b3Mkmz0ImehbdqdY5AbYpY1mWU+PAYA8OwI1yZPOI7fZaQEOcjp0Zi0khkdxdYruh9THwHn6SYBCsWXXWaQm7MKIIymPK4Rg6hFdKjmKknrqjxrj7NnWyI3MkMQjIATNS1XjjrPD+R7o/EkoEimOmeHsoeSIcWC4Dz/6+/JDWeD/u8JMtIJgoa7yVBOSVJ9Qfk18xP+yBPtHhxmUuwfi+9LXE9glCg4eiwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(36860700016)(376014)(82310400026)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nXBGIfRHL0EpixrvuPUSwJHOKXXzDRFWfSpLREG15M6iT2X1Q2szW2LtkBP4PnqioEpQHf4x1p4nsUPcR3EGC56YojhvE2impjanCxZzDPMT8gJNgdxmPThouJWKyfXpD0gv8H9uMJUp4gVHTEj/jKliF12Wq+XbjLFDOyeD2cg0CYOZzRNSrrvwu3oLG0kLNH2XgdlRzOENZ05TYkGb0yuI7SG4iD4amZcJ/1CA44cNSjmXQjZMcwjmx/SuWE9sVEA3DOd1uzBYauf9imskRFX1RKyCEMAYceZNj8mngoNXqQFpPRAggIjYyFm/gR2TdFAQ+ndfvbev/4GRJ23bkH42PTg7jPnZpIDiD+PD3NJEeXBSGvZTVvBS1Nu/xNJ/P0itiT/AqUngQsRzp/++FZRzhazjFnTa1spsmXiFYsWg7ROEwp59KpAywOBDKNvJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:27:04.7755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794ea9e8-68fa-45c4-c4a8-08dedd055d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

An issue has been reported that xHCI host controller doesn't come back
from resume on some systems.  This issue has a failure rate, but that
failure rate is confusingly tied to the size of the VRAM reservation
that the BIOS makes.

That is if the VRAM reservation is small (for example 512MB) then no
failures. There are some comments that mention that the larger the VRAM
size the higher the failure rate.  I personally don't really understand
why this would matter, but I would like to mention it in case it jogs
anyone else's brain.

Various workarounds work:
 * Using legacy interrupts instead of MSI
 * Resetting controller on resume
 * Creating device link dependency between XHCI and display PCI devices
   (for device resume ordering)

None of those workarounds appear to get at the root of the problem to me
though.

I did some tracing around the code and cross referenced the PCI spec.
The XHCI controller should be in D3cold during suspend and thus should go
through a D3->D0 transition.  The PCI spec says that D3 transitions need
10ms delay.

However we don't have any mandatory delays for endpoints in D3cold, only
bridges have this.  For endpoints we only have mandatory delays in D3hot.

So my suspicion is that adding a mandatory delay for the D3cold to D0
transition will help this issue, which is what this patch series does.

Cc: mrh@frame.work
Cc: stern@rowland.harvard.edu
Cc: hannes@vonhaugwitz.com
Cc: jase_harley@protonmail.com
Cc: superveridical@gmail.com
Cc: david.c.hubbard@gmail.com
Cc: bugzilla@logical.ink
Cc: michal.pecio@gmail.com

Mario Limonciello (1):
  PCI: Apply mandatory recovery delay on return from D3cold

 drivers/pci/pci.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.43.0

