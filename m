Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768634AE137;
	Mon, 31 Aug 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190247; cv=fail; b=Phhd2Sm97YE0e3myFqDCepwdKR/IOTA9coagcbF86KWe7RbJYcjykdG591erICHb3id83HtXAbpItVAXpx7vPp3nHkDUCDbeizlL22TUHxjqwzIjolaHz+9PI4HO0XJowuE3tVNk/Xvu+yizNnNRvuWRJGJZpkbdKt0b3X+blzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190247; c=relaxed/simple;
	bh=NhbSlAWYrMvqYFGdqfUYcQWqCLicbkoRJgFV4d7kYMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET9nutfxX+AwCXICcVQAFZhSKE2hDj6kUz2Pg/ydIbXg2PVeqN2KsMZaVNpGZJGAZjfl7cvdnB6yyJoJc/zDhYwWJwn0cWv0/jiz0gyBxWHdSdFtKqDAFYwJ7cj8T5RzmOlxLd7TkugAIIvj/XDL+34+EtkVmm3GH6h+4ZIlNBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NEaiK1Yd; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NEaiK1Yd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpuc2fuFooIafp93qqVvO5BV43Xpua0KBocL4UZtnEFttOdDJmvrSZ/gJsg2aHHiw1nXZcmLTd3PDUcC239AYSwqw24YNhfCTkZljmI0bfqSonaJ0CV87II5pSgUfi7ZamIrH3WNz7O8CKGGiaAXjxgZDpiL6KKFD0Lrh+cNWdIaJjmbeUZK05OPmwIxs5hUoxixkmGmcVieq1ZVMqKbwtREjCtyj8eyDmnyP+C6tKnOGlzESABOhshufC3kofK9m4sXnNj/TI75ugWK9i1gJqRHVFSEgb1tlB6nKnRzc8FIpzaH2HYEbnt6bk5SdBeCe/hwMGaoZebcxIZFsRsEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cco01Zf/8YgCDioUvH2YXSkRSEJzcAo/1oFcCLxA6Wg=;
 b=aj5nZ2FyqNoV9PfD7MkIdsMewZj7UEl00CzJI6F59iGzlTgC6uiQGF1wgKDh5Q8cisrUorCpBUUgY2jvjXTgEhPqA6igPp3akQCOYRKdj3A2EwV6Kgv9mcMNLIdkeYrCz8+TrOqjgSG/MII4fDHOGEixu9W2OeDzi/CAdrZatIhUHcColHUI4cSM1aRERW41zqq0+XLAFP7bExAH9B62Wh5bVAkcMQmGtR+g5SrXkdJV00vuD1Za9Vt814K+H9f+Q5xZuR9tONuZZLhKQwI5+CX2rloSDndXLJMuGjInvM19pwtrZtjEJyGiOISEyndLLd8uuKtJwAgldtLMTAWpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cco01Zf/8YgCDioUvH2YXSkRSEJzcAo/1oFcCLxA6Wg=;
 b=NEaiK1Yd6q31lR7KP6OxZN0HR+3g0IHcMzRMJTLu4Q5foiJXz6T0V67YSHYUCYOK6u+bXyW1fr3MizlXOWHx234Wl4a5z2VHRAJ6Mq+Xmv+lNdM7/M155GENyjtMtr/fuZc6DhcSK1PyJQuilKQPUUQZbbsWYJ7aQtX/VfPCiLCt41ASQir69Xv+bpctW48Md+RH9p2UhzmLG2mgMoJsQRusiIzyvnUr+viLGfT6c+lSYihWvmEElXv6Fvs3bY69g3mxJB79s9ym2GojEFlYvpfhb9OGIzZuTRhdO5nwLGuY1aHwrlw2c6DUsRTRnKQA/CF6/Abeped9K3iwmJxgYg==
Received: from CH0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:b0::24)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:30:39 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::47) by CH0PR03CA0019.outlook.office365.com
 (2603:10b6:610:b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 15:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:30:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 08:30:11 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 08:30:10 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: JC Chen <jc_chen@diodes.com>, Bjorn Helgaas <helgaas@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR erratum
Date: Mon, 31 Aug 2026 08:29:49 -0700
Message-ID: <20260831152952.2962522-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b4d8e820-4cd5-7225-5078-678c4f191297@linux.intel.com>
References: <b4d8e820-4cd5-7225-5078-678c4f191297@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb1817a-9e9b-4f73-da88-08df0774cf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|3023799007|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	AUN1m9OlhcqRnmi3pcay6vKR3rY53zaOyV1Onfg0xmne1WnSgS82QuWFFBIwcPzC7yC/CFbd9mc/ZIhBoDvh6YyKk6Gsfr8aQ/AZLSZcTjw9u9o1HHkpXziifzUJf5oazTCAyK2M9O3uqnny6nymw41s5ooidXoIxJ5JBdRZqfnnefVN8j/StI62y2JB76NBv+iC/IeR94PfGOF0YCOf2917hPngYwLwyi9eh82lpshaXBOm2lH+XD3A8HwPJdvc+LL/+q92kbA0qOkn9cm+X5dCb27YzDiPa3iu69YKyF1eOBgHu+aD2wf79PKF7GDh8w64Uzdi17TjaBzbwLbabjyweDg9W0qaaDXLr8Vhx9bvJBhgfEgW4rO2w6KnSh/fD1trEuhGXZ4Q+tZvLqgGeDLSRrIgGDX114guKCVp1uaul6FK8cnXYeARE6pXqxCo8BRSjY1ipSzih4M+Yu+L9aSWsy+x0A6ON+QD/+dRYrm/bZcyEeoHwZHg8h6byJmz5mpwIdRhs14Slx/QFvAovUymQM/OabAtZDvzLALZqepn+dLOxHJWAbSqFC6JpdW3Iq8Buun16B6ItpcSCpre4XKuIa4YLARsrgf7Q4A5Ul37F2wbbHNzIEmP9K80FXUuNIdEraZzkzqkUw36y1DPhersFkMoX/t629qt0sDZRUZAEKIl5yZaUnX5NoMeJOG83/LMdOYxqEtrltLEHkMJ6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LZbS7F/OKQFvcQyQZ5ZVTkmfguvczFDJWKZVkPxMtrtEkboBvze2E2o4bnsZCK0CVWGAIh7Za7tYgeBrcFojsb9vxUDZ7HDi8Pg429/yss+TUCR20djT+YzF6xui8Duy904TWU5Vy0eKVAkOlGghbZh5qcphgZFd4A9U5GsM9JZy1V5f1/NBLvORSKLRzoIhVYuU2UoAp2chxd7po1FaYCTVaW+iHrffllPJHs0KoXpkUjoWBejrlaB8dZz7UIpmoYzsJ3BdGMNdMx5tyDUh9v5qrggyOREn53rcYt4VljDY+UuQ56JSy7YgFzmZvDqKbwlmbwnzQNETeWktAVK4y3uEGSY5mEt/6uJZsfmdnt2Z1TktZ4OdB4IRX98miLG7EDdry3ijhEHfTlAfJMi2HQCkUUWzf1mBbJNJDZoiGfJOciZGcGTZdhyaaYmUwi9D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:30:38.1213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb1817a-9e9b-4f73-da88-08df0774cf22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

Hi Bjorn, Ilpo,

On 26.08.26 16:28, Ilpo Järvinen wrote:
> On Fri, 24 Jul 2026, JC Chen[陳饒靜] wrote:
>
>>
>> Hi,
>>
>> Attached are kernel log "dmesg.log" and lspci "lspci.log" output.
>>
>> I guess without this patch, MSI-X from the downstream port doesn't work correctly?
>>
>> => YES
>>
>> By "mirror", I guess you mean you want the same value in BAR 0 of both the switch
>> upstream port and the downstream port?
>>
>> => Yes, please use the same value in BAR 0 of both the switch upstream and downstream
>> ports.
>>
>> I don't know what that even means, because the upstream port BAR 0 can't be inside
>> its memory window, so reads should never reach the downstream port.
>>
>> => Yes, you are correct that the upstream port BAR 0 can't be inside its memory
>> window, so reads should never reach the downstream port. When CDEP function is
>> disabled, BAR0 of P4 is read as all zeros. If root complex send out memory address
>> 0x7F000 or 0x7F080 to P4, it will hit P4’s MSI-X Table or PBA address range, switch
>> will response UR and then cause SOC reports timeout. To avoid this issue, the patch
>> write P0’s BAR0 to P4’s BAR0.
>
> Hi,
>
> I have problem of understanding why touching that downstream BAR helps
> because the bridge windows on 0000:17:00.0 are disabled.

In the topology below, an NVMe endpoint is behind Port 4 and Port 4's
Memory Base/Limit window is enabled.

On this system, CDEP is disabled and Port 4 appears as a normal
downstream port. Although Port 4 BAR0 reads as zero, it can still match
memory requests against its MSI-X Table/PBA address range. An upstream
request from the NVMe enters the switch through Port 4, so the bridge
window does not prevent this decode. A matching read returns UR and a
matching write is dropped silently.

The workaround copies the upstream BAR0 to Port 4 BAR0 at offset 0x10;
it does not change the bridge window at offset 0x20. Linux exposes no
BAR or MSI-X capability for Port 4; only the upstream port advertises
the Table/PBA offsets shown below.

JC, please correct me if I missed anything.

Here is the relevant output from that system:

lspci -tv:

 +-[0002:a0]---00.0-[a1-a7]----00.0-[a2-a7]--+-04.0-[a3]----00.0  Micron Technology Inc 7450 PRO NVMe SSD
 |                                           +-05.0-[a4]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
 |                                           +-06.0-[a5-a6]----00.0-[a6]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
 |                                           \-07.0-[a7]--

lspci -nn, the same subtree:

0002:a1:00.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:c008] (rev 0f)
0002:a2:04.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:c008] (rev 06)
0002:a2:05.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:c008] (rev 06)
0002:a2:06.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:c008] (rev 06)
0002:a2:07.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:c008] (rev 06)
0002:a3:00.0 Non-Volatile memory controller [0108]: Micron Technology Inc 7450 PRO NVMe SSD [1344:51c3] (rev 01)
0002:a4:00.0 USB controller [0c03]: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller [1912:0014] (rev 03)
0002:a5:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 06)
0002:a6:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 52)

dmesg from the unpatched 6.17.0-1011-nvidia-64k kernel - Linux first
discovered the upstream BAR0 at 0x10300000 and then assigned it at
0x10c00000. Any firmware mirror of the initially discovered value
would therefore become stale. The quirk reapplies the mirror after
resource assignment and during early resume:

[    6.440083] pci 0002:a1:00.0: [12d8:c008] type 01 class 0x060400 PCIe Switch Upstream Port
[    6.440107] pci 0002:a1:00.0: BAR 0 [mem 0x10300000-0x1037ffff]
[    6.440111] pci 0002:a1:00.0: PCI bridge to [bus a2-a7]
[    6.440119] pci 0002:a1:00.0:   bridge window [mem 0x0f000000-0x102fffff]
[    6.440323] pci 0002:a1:00.0: PME# supported from D0 D3hot D3cold
[    6.440499] pci 0002:a1:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x2 link at 0002:a0:00.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    6.441514] pci 0002:a2:04.0: [12d8:c008] type 01 class 0x060400 PCIe Switch Downstream Port
[    6.441542] pci 0002:a2:04.0: PCI bridge to [bus a3]
[    6.441550] pci 0002:a2:04.0:   bridge window [mem 0x10200000-0x102fffff]
[    6.441734] pci 0002:a2:04.0: PME# supported from D0 D3hot D3cold
[    6.441917] pci 0002:a2:05.0: [12d8:c008] type 01 class 0x060400 PCIe Switch Downstream Port
[    6.441944] pci 0002:a2:05.0: PCI bridge to [bus a4]
[    6.441951] pci 0002:a2:05.0:   bridge window [mem 0x10100000-0x101fffff]
[    6.442135] pci 0002:a2:05.0: PME# supported from D0 D3hot D3cold
[    6.442317] pci 0002:a2:06.0: [12d8:c008] type 01 class 0x060400 PCIe Switch Downstream Port
[    6.442344] pci 0002:a2:06.0: PCI bridge to [bus a5-a6]
[    6.442352] pci 0002:a2:06.0:   bridge window [mem 0x0f000000-0x100fffff]
[    6.442534] pci 0002:a2:06.0: PME# supported from D0 D3hot D3cold
[    6.442719] pci 0002:a2:07.0: [12d8:c008] type 01 class 0x060400 PCIe Switch Downstream Port
[    6.442747] pci 0002:a2:07.0: PCI bridge to [bus a7]
[    6.442936] pci 0002:a2:07.0: PME# supported from D0 D3hot D3cold
[    6.443191] pci 0002:a3:00.0: [1344:51c3] type 00 class 0x010802 PCIe Endpoint
[    6.443250] pci 0002:a3:00.0: BAR 0 [mem 0x10200000-0x1023ffff 64bit]
[    6.443258] pci 0002:a3:00.0: ROM [mem 0xfffc0000-0xffffffff pref]
[    6.443268] pci 0002:a3:00.0: enabling Extended Tags
[    6.443458] pci 0002:a3:00.0: PME# supported from D0 D1 D3hot
[    6.443571] pci 0002:a3:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x1 link at 0002:a2:04.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    6.445352] pci 0002:a1:00.0: bridge window [mem 0x0f000000-0x10bfffff]: assigned
[    6.445353] pci 0002:a1:00.0: BAR 0 [mem 0x10c00000-0x10c7ffff]: assigned
[    6.445356] pci 0002:a1:00.0: bridge window [io  size 0x1000]: can't assign; no space
[    6.445358] pci 0002:a1:00.0: bridge window [io  size 0x1000]: failed to assign
[    6.445359] pci 0002:a1:00.0: bridge window [io  size 0x1000]: can't assign; no space
[    6.445359] pci 0002:a1:00.0: bridge window [io  size 0x1000]: failed to assign
[    6.445360] pci 0002:a2:06.0: bridge window [mem 0x0f000000-0x107fffff]: assigned
[    6.445361] pci 0002:a2:04.0: bridge window [mem 0x10800000-0x108fffff]: assigned
[    6.445362] pci 0002:a2:05.0: bridge window [mem 0x10900000-0x109fffff]: assigned
[    6.445362] pci 0002:a2:06.0: bridge window [io  size 0x1000]: can't assign; no space
[    6.445363] pci 0002:a2:06.0: bridge window [io  size 0x1000]: failed to assign
[    6.445364] pci 0002:a2:06.0: bridge window [io  size 0x1000]: can't assign; no space
[    6.445364] pci 0002:a2:06.0: bridge window [io  size 0x1000]: failed to assign
[    6.445365] pci 0002:a3:00.0: BAR 0 [mem 0x10800000-0x1083ffff 64bit]: assigned
[    6.445376] pci 0002:a3:00.0: ROM [mem 0x10840000-0x1087ffff pref]: assigned
[    6.445377] pci 0002:a2:04.0: PCI bridge to [bus a3]
[    6.445381] pci 0002:a2:04.0:   bridge window [mem 0x10800000-0x108fffff]
[    6.445401] pci 0002:a2:05.0: PCI bridge to [bus a4]
[    6.445405] pci 0002:a2:05.0:   bridge window [mem 0x10900000-0x109fffff]
[    6.445441] pci 0002:a2:06.0: PCI bridge to [bus a5-a6]
[    6.445445] pci 0002:a2:06.0:   bridge window [mem 0x0f000000-0x107fffff]
[    6.445452] pci 0002:a2:07.0: PCI bridge to [bus a7]
[    6.445463] pci 0002:a1:00.0: PCI bridge to [bus a2-a7]
[    6.445466] pci 0002:a1:00.0:   bridge window [mem 0x0f000000-0x10bfffff]
[    7.855244] pci 0002:a1:00.0: Adding to iommu group 13
[    7.855303] pci 0002:a2:04.0: Adding to iommu group 14
[    7.855360] pci 0002:a2:05.0: Adding to iommu group 15
[    7.855418] pci 0002:a2:06.0: Adding to iommu group 16
[    7.855474] pci 0002:a2:07.0: Adding to iommu group 17
[    7.855534] pci 0002:a3:00.0: Adding to iommu group 18
[    8.703116] pcieport 0002:a0:00.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    9.741839] nvme nvme0: pci function 0002:a3:00.0

lspci -vv of the upstream port and Port 4 - note the upstream port
advertises the MSI-X Table/PBA at exactly BAR0 + 0x7f000/0x7f080,
while Port 4 exposes no BAR and no MSI-X capability:

0002:a1:00.0 PCI bridge: Pericom Semiconductor Device c008 (rev 0f) (prog-if 00 [Normal decode])
	Subsystem: NVIDIA Corporation Device beef
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 0
	IOMMU group: 13
	Region 0: Memory at 10c00000 (32-bit, non-prefetchable) [size=512K]
	Bus: primary=a1, secondary=a2, subordinate=a7, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: 0f000000-10bfffff [size=28M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [68] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x2, ASPM not supported
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x2
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: EgressBlck+
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a4] Subsystem: NVIDIA Corporation Device beef
	Capabilities: [b0] MSI-X: Enable- Count=6 Masked-
		Vector table: BAR=0 offset=0007f000
		PBA: BAR=0 offset=0007f080
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=05 MaxTimeSlots=64 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [1a0 v1] Device Serial Number 08-16-48-96-00-00-12-d8
	Capabilities: [1b0 v1] Power Budgeting <?>
	Capabilities: [1d0 v1] Multicast
		McastCap: MaxGroups 64, ECRCRegen-
		McastCtl: NumGroups 1, Enable-
		McastBAR: IndexPos 0, BaseAddr 0000000000000000
		McastReceiveVec:      0000000000000000
		McastBlockAllVec:     0000000000000000
		McastBlockUntransVec: 0000000000000000
		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
	Capabilities: [210 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2b0 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1- L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
		L1SubCtl2:
	Kernel driver in use: pcieport

0002:a2:04.0 PCI bridge: Pericom Semiconductor Device c008 (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Pericom Semiconductor Device c008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 134
	NUMA node: 0
	IOMMU group: 14
	Bus: primary=a2, secondary=a3, subordinate=a3, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: 10800000-108fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
		Address: 00000000ffff0040  Data: 0000
		Masking: 000000fe  Pending: 00000000
	Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 8GT/s, Width x1, ASPM not supported
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
		LnkSta:	Speed 5GT/s, Width x1
			TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug- Surprise+
			Slot #4, PowerLimit 25W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd+
			 AtomicOpsCap: Routing+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck+
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a4] Subsystem: Pericom Semiconductor Device c008
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [130 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=05 MaxTimeSlots=64 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [1a0 v1] Device Serial Number 08-16-48-96-00-00-12-d8
	Capabilities: [1c0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [1d0 v1] Multicast
		McastCap: MaxGroups 64, ECRCRegen-
		McastCtl: NumGroups 1, Enable-
		McastBAR: IndexPos 0, BaseAddr 0000000000000000
		McastReceiveVec:      0000000000000000
		McastBlockAllVec:     0000000000000000
		McastBlockUntransVec: 0000000000000000
		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
	Capabilities: [210 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: LaneErr at lane: 0
	Capabilities: [2a0 v1] Downstream Port Containment
		DpcCap:	INT Msg #1, RPExt- PoisonedTLP- SwTrigger- RP PIO Log 0, DL_ActiveErr-
		DpcCtl:	Trigger:0 Cmpl+ INT- ErrCor+ PoisonedTLP- SwTrigger- DL_ActiveErr-
		DpcSta:	Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:00
		Source:	0000
	Capabilities: [2b0 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1- L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
		L1SubCtl2:
	Kernel driver in use: pcieport


Please let me know if I should share any other details from that system.

Regards,
Nirmoy
