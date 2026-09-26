Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55499476CF0;
	Sat, 26 Sep 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431825; cv=fail; b=PtucKqODLROZe/N9h1ioagMGbFJnzMX5IAwHIpoBzS/aNZIIPk6R5bUgirDSaiAw7FqgeMvOk0gUmorpMZ3cmWJsEdF1Tz1cpz0Qrs811KLlqOidW2mrvcI1BEMW19StnmpYrtDgy2ZyaMrUsYB55n2DKWY+zuXCryMBQ0xN9i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431825; c=relaxed/simple;
	bh=gchbM+0HEBa/OC9w3uxpI6bJprKT+/SKw14Yigw6vAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=radeAV/B4CIIpHYSnL7JnEFrqjOvvmyJztAHHfMsdnh3FYokG5PEJfdYbncoRnjciCgqqwBQCCVujixqvJI+Vz17OWfMKYNLY+73jSbw4HAm+K1LSebIhWFCLrr/UtjRpxF+vbrFQ3ULMQLenx1FT0xhssYVc4ZOCxTpEBBq6mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jGeV0sy6; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jGeV0sy6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc2pxwIqv+sUKkYWyloR1Jqr96SHmyv6Z9iE0IkjK0wp/G8l8OQzEnp9bV/x+6jmPGUASQbRX7qRN159dEZpe6rDB/8oa+8KUJSayjuRQni8q+6wFttxp1t+/6CZHXTUkEHu3Qw/PeF3zVb2k2D+GEFcRai7gcS1rr4iNaw5QwOSA/H/OQevLMIlz3Bc0lEiqUzHSkdGtI2qNGLWilsXxo3RtMcfVaxBh0YA9bLaIfkca9RJklxdIwoLZgKGzi7GicMPVHAK57SdCzhpoCZR6iaryAoUB9nCaKsmBtKITt1zkZX/jHShZ68fVUJ17r2tkm8ZRSIIBVKz8ug8dRVGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoEsRZuGbMi7buHDO/915t6q3YXGHtn+SZURYujPHHQ=;
 b=fI+7C6x6EnFd2B3RmYQDBj4rgrDsIS/+Lk3Ao/IsF4eh6N1sarj/7Qg8OJM2nA2vZtcgyMQtVyUuvwp/CmWP/vHwL0oCbymRLJET34491t6va7y7GVq8L9Ie53QnqpFa8sMTMZ5WSVi7GACcFG0YmcuLTz1JHLPzZU9kCDRiSLEDSy+g6ibhK4lERC3QHJ9cUSFs41In2gSL8KxepWarsHkuS1EIXYA3qYpFpFn5aaKNyrF4bH2HSHs6JqEJy1Hg6/vrTj0CymuZepwS1gPuFMGuNUTK2dmv7bE/oYjxR1XunbF64C4RJeUAGKnyohj4gli06Rkdgp5QTbjcHeTBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wunner.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoEsRZuGbMi7buHDO/915t6q3YXGHtn+SZURYujPHHQ=;
 b=jGeV0sy6WCviu5VF2jRxNppGv/PmLQ+Q3+djq/5BS86mQA9Jv/iAr2F7UimMiz4ivBxDnx6uM2Pbq9U+d1QkrvQkzSf2HYApUqhTmGf5uK5KHcv3tlf2/5e4ehWhshY60J+q1K4KSZDFcHJPQ2vdkxYPSEhtQkmCwJvJJU6EaNY=
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 14:10:14 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::34) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Sat,
 26 Sep 2026 14:10:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 14:10:13 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 26 Sep
 2026 09:10:09 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Zhu Qiyu <qiyuzhu2@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: pciehp: Avoid dropping hotplug interrupts due to stale HPIE
Date: Sat, 26 Sep 2026 14:09:47 +0000
Message-ID: <20260926140947.217926-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arbCNu_Ozv2j_CEv@wunner.de>
References: <arbCNu_Ozv2j_CEv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 92952c19-4be2-4085-9deb-08df1bd7e1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|11063799006|6133799003|3023799007|22082099003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	B8e1idVGY+/8DYE7ETqW/b9LcCbA4YG3dGtzWeVwUqMwVSPs3hmcq8woXYdN7nGZ3SAajgZUU31xFhVR1Ec9+vrbmb3poYPF4oowVZPgIAaIzIKw+jdz5AAfAyskm95JvjaRe5Xb5aufjquObV4JtpEzpxmawJ3BVkMKf70S1n4l2EakcJm6hBugYZgOgnirAwjbN5gOxUvuav6B5hpEYX6s9bVMmQKOzHNcS4GuAyNxV0z99ge/3c+lPVkuXLI5rK0phll+IdfIodtwNLKqwmLujzaY0/CL/9uS6DKjQCNWZg5Y/nm5cU/UVJqTmjKNlSau7KGeqmeUbOVjcHyPCd9i4XlIhqd1Ir9MQskunTBdNYTtD6Tbso9KXARcQrzj3a6VeoV+1Wxg36bGu67B80dpcTbLyvgLQg5nzzMdXPzIs89pLOhZ2dalLDCmdhSumP0h1/G1wwvVsc1g6iaTABSHWSYrbQrWa8Pl8OvF1A0gHeVrOTj9ClB5appWrpWoo9+Ia2q6dlmvC27zeycgKmjBlZm5rgYpSLfMoIJj3VQk4+z3Avy2z/bmsMktZ/2Zoq8Z7gSMcOWQeoX06PHJBRdfdf4GgkjUPnpv3yJVuIv6nopZL3JlPXMBp8IzlFjqPdPxbKRlnM1CItAFriju8kqyNOuvmWQBUttz4Wq7N+DMGp0UfRbvgfjQWsHnQSp+76Q/X9vebY5jIcIPG7SmIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(22082099003)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D69YpbvBvFAgWjcUp9lU7RIk/D9rcFtCeTeiZr8MPlAww1MEaYt/joo+m+Khf9AAtKTb7yH4o3ZazmxToyOKd0+VTcyFmM++RrWkk6xmEd5gNu0wYqGAu0IRY37+8n6LKnjGCjOD4uLZOEfOOC+rX29FpjVHnkXG86ga8rPaFjOXiPRvmx90sJ4kwblRpEYwqKOTgavDUZE760sBkwJv9vD9d5pG59rY0pjNfameDxJrsr7nQJEitSzOI+a/UhOQPACVONqdJTlhQLUSLdD9W4HC/1UAN4mKxlP18b9Bw9/PqKCC3wyP05a2XBHyFf1k+P3D8vd7fVnqxoDuWzvWHBVj5YgFVTM+YgIRftqVJol5i1lvvJKOjr1l7sLpcxa3zNXs2utbJy37ngISIeYk7VHFcN1nvSXjEPnWhCadNS9IhEeuMYCUNPpyy5O3zYeX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 14:10:13.2092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92952c19-4be2-4085-9deb-08df1bd7e1ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

Hi Lukas,=0D
=0D
> Are you seeing this on a real-world system or is it an LLM-generated=0D
> hallucination?=0D
=0D
Yes, this was observed on a real system during NVMe hot-add:=0D
=0D
  System: AMD EPYC 9554=0D
  Port: 0000:c0:03.4, slot 71=0D
=0D
Our PMFW temporarily clears HPIE and sets it again later, with the intent o=
f=0D
suppressing and then re-enabling DLSC interrupt notifications. The previous=
ly=0D
mentioned race condition prevents the DLSC event from being processed corre=
ctly,=0D
resulting in a failure to clear certain status flags, which in turn affects=
 the=0D
subsequent hot-plug state machine.=0D
=0D
Only PDC event, no DLSC event:=0D
=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: pciehp: pending interrupt=
s 0x0008 from Slot Status=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: pciehp: pciehp_check_link=
_active: lnk_status =3D 5041=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: pciehp: Slot(71): Card pr=
esent=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: pciehp: pciehp_set_indica=
tors: SLOTCTRL 70 write cmd 200=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: pciehp: pciehp_check_link=
_status: lnk_status =3D f045=0D
[Thu May 14 11:30:46 2026] pci 0000:c7:00.0: [144d:a900] type 00 class 0x01=
0802=0D
[Thu May 14 11:30:46 2026] pci 0000:c7:00.0: reg 0x10: [mem 0x00000000-0x00=
007fff 64bit]=0D
[Thu May 14 11:30:46 2026] pci 0000:c7:00.0: Max Payload Size set to 512 (w=
as 128, max 512)=0D
[Thu May 14 11:30:46 2026] pci 0000:c7:00.0: Adding to iommu group 54=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: bridge window [io  0x1000=
-0x0fff] to [bus c7-c8] add_size 1000=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: BAR 13: no space for [io =
 size 0x1000]=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: BAR 13: failed to assign =
[io  size 0x1000]=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: BAR 13: no space for [io =
 size 0x1000]=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: BAR 13: failed to assign =
[io  size 0x1000]=0D
[Thu May 14 11:30:46 2026] pci 0000:c7:00.0: BAR 0: assigned [mem 0xba30000=
0-0xba307fff 64bit]=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: PCI bridge to [bus c7-c8]=
=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4:   bridge window [mem 0xba=
300000-0xba3fffff]=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4:   bridge window [mem 0x60=
0e1600000-0x600e17fffff 64bit pref]=0D
[Thu May 14 11:30:46 2026] nvme nvme3: pci function 0000:c7:00.0=0D
[Thu May 14 11:30:46 2026] nvme 0000:c7:00.0: enabling device (0000 -> 0002=
)=0D
[Thu May 14 11:30:46 2026] pcieport 0000:c0:03.4: pciehp: pciehp_set_indica=
tors: SLOTCTRL 70 write cmd 1c0=0D
[Thu May 14 11:30:48 2026] nvme nvme3: Shutdown timeout set to 8 seconds=0D
[Thu May 14 11:30:48 2026] nvme nvme3: 256/0/0 default/read/poll queues=0D
[Thu May 14 11:30:48 2026]  nvme3n1: p1 p2=0D
=0D
after hot-plug, run lspci -vvv and find that the Linkstate+=0D
=0D
DevCap:    MaxPayload 512 bytes, PhantFunc 0=0D
ExtTag+ RBE+=0D
DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-=0D
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+=0D
MaxPayload 512 bytes, MaxReadReq 512 bytes=0D
DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-=0D
LnkCap:    Port #0, Speed 32GT/s, Width x4, ASPM L1, Exit Latency L1 <64us=
=0D
ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+=0D
LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+=0D
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-=0D
LnkSta:    Speed 32GT/s (ok), Width x4 (ok)=0D
TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+=0D
SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise-=0D
Slot #71, PowerLimit 75.000W; Interlock- NoCompl+=0D
SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+=
=0D
Control: AttnInd Off, PwrInd On, Power- Interlock-=0D
SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-=0D
Changed: MRL- PresDet- LinkState+=0D
=0D
> Firmware is not allowed to change the Slot Control Register once it has=0D
> granted control of PCI Express Native Hot Plug Control to the operating=0D
> system.=0D
=0D
Thanks for pointing this out.  I checked the boot log: the host bridge=0D
covering the affected port does grant native hotplug control to the OS.=0D
The relevant lines, with timestamps omitted, are:=0D
=0D
  ACPI: PCI Root Bridge [S1D1] (domain 0000 [bus c0-df])=0D
  acpi PNP0A08:05: _OSC: platform does not support [AER LTR DPC]=0D
  acpi PNP0A08:05: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeC=
apability]=0D
=0D
There is no pcie_ports=3Dnative override in the boot command line.  The=0D
same boot also reports:=0D
=0D
  GHES: APEI firmware first mode is enabled by APEI bit.=0D
=0D
That refers to APEI/GHES error handling, not hotplug ownership. Firmware-fi=
rst error=0D
handling does not justify changing Slot Control after the native hotplug ha=
ndoff.=0D
=0D
The runtime log shows PDC on insertion, followed by successful NVMe=0D
enumeration and queue setup.  A separate instrumented capture shows the=0D
ISR returning early with cached HPIE clear.  These captures do not trace=0D
the complete firmware/driver write sequence, so I should have made that=0D
evidence boundary clearer in the commit message.=0D
=0D
I will follow up with the firmware team on why the HPIE masking logic=0D
runs with native hotplug enabled, and pursue a firmware-side correction.=0D
Please hold off on this patch while we investigate that first.=0D
=0D
Thanks,=0D
Qiyu=0D
