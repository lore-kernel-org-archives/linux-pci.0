Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3822765F8;
	Tue, 24 Feb 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920604; cv=fail; b=UjdazfR+xHTAPBLGvP2LPbjBuKEAKMEB+OCch+E4l937HMYpDNCOJPrAiBiznjv9hb4RGJI341FAI1FfJd2Vo5xbyiVgdZoRKYWdPbhhhjeFwnXHUoQAXewhKDSO32bPWGi2doAGi537e+jaBBojv5xJDlIQi7G92WiWbo2ecsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920604; c=relaxed/simple;
	bh=7r7QGaiBPjjEY0VKKiLyj4f4Tt5CHR/ay6VmtcUyOwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TSR71QrMHLCbR1K0v3vNLant//3G/QdRCRnYA743cwcsnsdEIhvGoPXyYaaXgOMGcWXtvvk31dsTZM3eBFe0pnJ6fVOamUGUuYU3HZuttMdj/RCkU5NcnHHyo5CAFMS3dg6qZHjAmf0ayrgCIyZYBoXmLzbaCvYcIWUWul5o/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KHiEj/g2; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KHiEj/g2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYjFtljeGdlzniIrqugvJWVpPjvBmOUkkBoB4fdGDcXD3SkzmDbaFOT3rFWQh52zmx3G5HQ99Cpe4BSAvrbrMWLx1x+kIov2UWkPGAXphHkHFG6hH362hDr62C33zSJOybE2J2XD54cjOaXyC6J59cWbzZr83od7g+Ih6GZrhyZCxC36o7u/SIh1G0NcEJRxzLpfLTSpLEs2hIz6V44+OnaMBud+pvxUEW0ea7IDGuiLbleflggn723IPyG8o2ZtY+YkPIajUcVl/nUyI011nWM+RO4JsgUjxxp0k1MTFpoyA8hWU1sNwheI1Mwd/022KLZ4z4rBhhavL82Ph012Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+c34iRs3/j99hAU8KV7QhMBqFk2DOUF3kCmAj/9lWI=;
 b=ImSpMlwav0WbpG2ZdhUzfiA81Han8pVsZzw45gyodKtShCXIAZ+BlhJ6A9c8qEJLJRmQMzVzXztC8gLUHKQSpvbuk9t5yvF3VS8RnBKng31E5dqI0U7BezHRDqeqpyb/7yhcB6ozXjahqCj8wwAQFVE50N8yifUcXzkvXJRQ6T5d2Wtm3xUf3Hgv2BMw0Qfv1QMLFYZHHK6DNIbXE6ekwYyM6iZ3QZtGvAkSl99kru0Gzl2qIoWhCnpO4vQ7ri5ywn+1nSVVnIFTD9vNXjdCeyrqgVfz0Q3MxBvmNTpVtD3kZrfrY3+w97n1ET7nksdoowEFtuEMKcQUHMHNPfpH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+c34iRs3/j99hAU8KV7QhMBqFk2DOUF3kCmAj/9lWI=;
 b=KHiEj/g2xQJnPa2U4HsUs+DA47AI1lE0HxahUCFSDinVo+TCi3AJYMnmFV0MN24SM+ffQllEmONsxwxE/Q7ze1W/OBQASypFdtFXsZrvv00+NIasXAzN4b3qG80TDMVA20bAJSrF2+ZoR94XSfL4L0gyP1LU4zUB0iF+myV4pMU=
Received: from BL1PR13CA0385.namprd13.prod.outlook.com (2603:10b6:208:2c0::30)
 by LV0PR10MB997589.namprd10.prod.outlook.com (2603:10b6:408:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:10:00 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::4f) by BL1PR13CA0385.outlook.office365.com
 (2603:10b6:208:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 08:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 08:10:00 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:09:59 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:09:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 02:09:59 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O89rM11886139;
	Tue, 24 Feb 2026 02:09:55 -0600
Message-ID: <a0dfbb87-b9d8-4d09-a1a2-c84652d639fc@ti.com>
Date: Tue, 24 Feb 2026 13:39:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Mirror the max link width and speed
 fields to all functions
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>,
	<linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260223185558.GA3701139@bhelgaas>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260223185558.GA3701139@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV0PR10MB997589:EE_
X-MS-Office365-Filtering-Correlation-Id: 919b9c47-a7d6-4dd5-faf6-08de737c1b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnFackZHMC9TcFI4L3lVV0l0OG5Vb3VXcWgvallLN25UN1RIWXVhYmkvZ1dS?=
 =?utf-8?B?VHp1aHVFZE5sNXgxQ0dqRkppdWdxUTBCTUFhbmhLNXJiZU1nSWgvb2IwQW5Q?=
 =?utf-8?B?TzdCOEdoSmVlSGJKNjVvd2Z0RUdaU1AxbmRwdlZTeGJXU0E2eCtZYXU2WUcw?=
 =?utf-8?B?cVYveWU0bk5lVWV6ZTB4Mms5WTFlV2o5ZG1OR29hMStqSTF3MHB3aCtUU1Nr?=
 =?utf-8?B?WmVQRzU3NUQ3dmJYSkFPYUcxUXc2K0tVVTdDdXdYcXA0cHppbTVVbFlsc2tE?=
 =?utf-8?B?c0N2eDhydkN3alZNWHRZaVlNZEl2MjErNHFOUGdLUGFqcGFGTDQxWWg4Q3Ft?=
 =?utf-8?B?bXBZRE1GNi9DU080SmFNY1dFQ001dGxIZ0tRVXh2dmFtK0hoN2V0b2J3VTQ3?=
 =?utf-8?B?VDludDJRdTRKRlFDVXRyYUNZU0piU0hKQkhpMlVWTFkxT1ZoclJSQlMrZDYv?=
 =?utf-8?B?K0FDOWRCMWhuTmZOT0pwSTB6aWJsektMVVBya0d5YmpPRDh6RG03bjFEVWlw?=
 =?utf-8?B?QmhXYWR0blB1YkRtenhMWmgvczhSVXc4WmpROUlKd3dWOTl0dmlTYVcwTVo0?=
 =?utf-8?B?emVuc1Nya3RPUkhSeUNJRzZVUnFMTWZ1SVNEQzJXNU1LMWVkcjVBdDFZTm45?=
 =?utf-8?B?WEhEWDBpcDk3NnZ2b3VHOFZkMjFkTjh5RHBJRHhpZU0wS3ZxOU5oSUpEZWY5?=
 =?utf-8?B?bkN1QXU2ZGE2UWpMdURwV3Z4aWl5ditIbXBsMGk5dUplcmhjWmdIU2dmV1hG?=
 =?utf-8?B?WTkyWGNNMmxGejBtaExsb3VuSDdBbVp1akdGKzE1SjZnQm8rZG50VnhLWGtx?=
 =?utf-8?B?bzR6T1F6K2puWG84UERvOEtDczYvZHhxeCtlRk9na2Y3V0xiQ1oxcGRDdHRI?=
 =?utf-8?B?U1JhUWdZNktLQktFWlprdE9WcktUWlhYK0FZS0tFdFVSdW9uU3hqemJyM09i?=
 =?utf-8?B?RHc0Y3FTOHJtbDBSMFQ2YnJ4cFhjZnY4SStWL1h2cnd4SE04YnZETDExc2V1?=
 =?utf-8?B?eW1pRGdjVGVPdTEzZE45bmpGZEhuaUtvdnk2U0JVYmY1UjU4ZzRLSU11NmJZ?=
 =?utf-8?B?RVBQRXVMRE0wZmczaElzZmk5SC9aRFdseGp2TkwvcWU0bkx6ZmF3WURFeFlG?=
 =?utf-8?B?Uy8vcWFlSUtZV0lIOUlrZUV6TWtaKzJ3WWJySkZ6MEVZQVFSazNKUXpxTERj?=
 =?utf-8?B?cWhQdUJJZUt5WDFOdU1zQTlSZHRBR0ZhUEoydC9GRkQ3aFY1b3k5K2cvLy9I?=
 =?utf-8?B?YjVBS09NRU9nVDF3L25YR1ZTK2h6Q0NjSFRhdllHUHhLTW9yeVV1MFA5aWlZ?=
 =?utf-8?B?UFFhY0MzckVaL1ZoMzEvRXkxQXh5UEZSQzBpVjdNN2Y5ZXJDZ1htTnJzUm1j?=
 =?utf-8?B?STArL2pRODhsY0s5bis0cHVOcXJyMjFtSDF0S042Z01FVHh3TzU4ZFJqVHhQ?=
 =?utf-8?B?YUh5Um1STk52aHlnOTRkU21WS3ZjSGVQQ1d5WXZSc0hqaDBPS0RoWHBYZnJX?=
 =?utf-8?B?dU1mRkpwa3NQb1QrUVpsS2NUejdUUHRxQjBjZHEybE9KQzZ3VnhnOHZpdzRC?=
 =?utf-8?B?TSs4ZTBBbHF1WU1yVWNuOWI2bUE2SVJ3ejRnUnZSdnZqMm1UQ3RraE5ibVVi?=
 =?utf-8?B?ZTBFNjZvQzkyRENHSEMyUmN6TFNYUlJEUDNoWTFHbnJrMExzazVxZHJ4Y0Y1?=
 =?utf-8?B?R3JxdTZ5M0hRaVorT3lyMVQyenFRU3d0T0pZWDczM1hQd2hQQ1JvOGZMbThS?=
 =?utf-8?B?c3JUN3psSFNabGhDRms2M3YzLzhldlQ3Y1ZKQjQ3dDFleE9KMEZQTXQ3WFRr?=
 =?utf-8?B?Z3dyU1hYdFN5U0pPdERvK0VJL1ZUOUtqNEwweGZlaXdXYUJjVXpuVFRpSnNl?=
 =?utf-8?B?VGRKa0pBcGFPcUhpeFAyVzZ2SnBDM3IrSGdIZnc1cnZxR0ZmWndLYnNiRU1W?=
 =?utf-8?B?LzQ0OUpSOURTNDZGVEdjN1JWcW5Ga2ppb1FURUhHZnN1dU1JVXc4OWhyT2Fi?=
 =?utf-8?B?ZGFLcDgreCsyMzNjUWFDSXdlS3E4SkcyNVVnSkNHK3p4RVMwMk96YU1QMzBl?=
 =?utf-8?B?ZzB6OFJSbmhDdlZGUGJ5YVU1L3F6cW9uZlVlWWNyZUYrclNIK1VWbHJDbjZj?=
 =?utf-8?B?VEdiUW0vWkpZR3lHOEdta0JiVFdxT1VDaHgwMGhVeU5xZGJOV1pmMGdhUWhw?=
 =?utf-8?B?ZjZ4dEpnbjhUcUxDZmdjN2ZoRk94WFVqUFpwbGlTUTlnQkdEN2trc3lyMWhQ?=
 =?utf-8?B?dVJpWTZVaUVDczZVdGNBanZncnl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8FJMoU34uqdVqVAKsGEiA/c1kAcwZyQ7ySD97SFcDCzcSeqhtx61Fcc7cybLQO+clCJWYmuoaquoVQwmVKyyr1jK5lUZlebPORd2PUz9ebIpYJn9zto3cD/wS8MWXGc2Lj8bJZzZb11J52HWLX+va3JNNoS27UHBntFLWxrHz10VjB/0ShHw5VPYqRPfkgDhnJN/fTfsZehuTLLZUHsEd47DKWNJwmdzyzVYR2eRYJLh81DUC5PO58o9J2iqCwNr0KVeOSVMB8FGJxTaZJCpYUisxRpacx60S+jLxRrGB2lN8GEDfVO6hi1vOgpYdpJm2QRJg0HQY1aEc9KSloFeWaCJlZ1uYHWLsNMeFrY0wxesYd89nZaigR+APUL1V97PxqDSKaprnnVSjxe1BsXOwYNlSVTPzbQSN2oGM4xjGomv2VycVYYOwytRJ5WIXiK/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:10:00.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919b9c47-a7d6-4dd5-faf6-08de737c1b1d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997589



On 24/02/26 00:25, Bjorn Helgaas wrote:
> On Thu, Feb 19, 2026 at 12:15:11PM +0530, Aksh Garg wrote:
>> PCIe r6.0, section 7.5.3.6 states that for multi-function devices, the
>> Max Link Width and Max Link Speed fields in the Link Capabilities
>> Register must report the same values for all functions.
> 
> Please update the citations here and in the comment below to r7.0.
> 
>> Currently, dw_pcie_setup() programs these fields only for physical
>> function 0 (PF0) via dw_pcie_link_set_max_speed() and
>> dw_pcie_link_set_max_link_width(). For multi-function endpoint
>> configurations, PF1 and beyond retain their default values, violating
>> the PCIe specification.
>>
>> Fix this by reading the Max Link Width and Max Link Speed fields from
>> PF0's Link Capabilities Register after dw_pcie_setup() completes,
>> then mirroring these values to all other physical functions.
> 
> "PF" and "physical function" are terms that apply to SR-IOV, not to
> ordinary functions of a multi-function device, so it's confusing to
> use them here.  Instead of "physical function 0" and "PF0", just refer
> to "Function 0" as the spec does.
> 
>> Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
> 
> Sorry I missed it earlier; it's also the wrong term here in the
> subject of 24ede430fa49, but it's too late to fix that.
> 
>> Fixes: 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling")
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>
>> The link speed and width would be negotiated through PF0 during
>> initialization that controls the link behaviour, hence it didn't broke
>> the driver. However, the change is proposed just to make the driver
>> compatible with the PCIe base specifications.
>>
>> The fix is implemented in pcie-designware-ep.c rather than modifying
>> dw_pcie_setup() directly to keep pcie-designware.c independent of RC/EP
>> specifics and maintain it as common code.
>>
>> Changes from v1 to v2:
>> - Used FIELD_* macros
>>
>> v1: https://lore.kernel.org/all/20260202072758.101845-3-a-garg7@ti.com/
>>
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 23 ++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 771241e1a2c9..6b9f90810fec 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -1094,7 +1094,8 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>>   {
>>   	struct dw_pcie_ep *ep = &pci->ep;
>>   	u8 funcs = ep->epc->max_functions;
>> -	u8 func_no;
>> +	u32 ref_lnkcap, lnkcap;
>> +	u8 func_no, offset;
>>   
>>   	dw_pcie_dbi_ro_wr_en(pci);
>>   
>> @@ -1102,6 +1103,26 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>>   		dw_pcie_ep_init_rebar_registers(ep, func_no);
>>   
>>   	dw_pcie_setup(pci);
>> +
>> +	/*
>> +	 * PCIe r6.0, section 7.5.3.6 states that for multi-function endpoints,
>> +	 * max link width and speed fields must report same values for all functions.
>> +	 * However, dw_pcie_setup() programs these fields only for physical function 0.
>> +	 * Hence, mirror these fields to all other physical functions as well.
> 
> s/physical function 0/function 0/
> 
> Wrap this to fit in 80 columns like the rest of the file.
> 
>> +	 */
>> +	if (funcs > 1) {
>> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +		ref_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>> +		ref_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS, ref_lnkcap);
>> +
>> +		for (func_no = 1; func_no < funcs; func_no++) {
>> +			offset = dw_pcie_ep_find_capability(ep, func_no, PCI_CAP_ID_EXP);
>> +			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_EXP_LNKCAP);
>> +			FIELD_MODIFY(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS, &lnkcap, ref_lnkcap);
>> +			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_EXP_LNKCAP, lnkcap);
> 
> Please wrap these too, it's not too hard to make these fit in 80
> columns like (most of) the rest of the file.
> 

I will work on these feedbacks and post v3 series.
Thanks!

>> +		}
>> +	}
>> +
>>   	dw_pcie_dbi_ro_wr_dis(pci);
>>   }
>>   
>> -- 
>> 2.34.1
>>

