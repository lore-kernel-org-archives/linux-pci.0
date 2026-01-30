Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C68309EFF;
	Fri, 30 Jan 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746374; cv=fail; b=EhPTTSqHQRSZ7RWTvVhGcN+iRZw8F2aQklQ7jarlsTqaQ2KANvEQNu9CrKuRQ3qTpNwbZt0APzDcevRprKiTGDRQ6+ajHsUrOYjvwBz1IlZ1qZFnFocgqmQPiCy5g12KGckSp88aJYQdxjVefz71xfUdF3qxRo55xlsjiybCU+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746374; c=relaxed/simple;
	bh=f2qnsm6mAJjBcqqT9CTX/fPTD5yeONt/KfCORXvwYhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cIXPLp66JOndAFFa5i8yaYtjTPcHNWGscnbY4PfWa+yQ2G2uNSkYh+rqlmzqDmYeZ0gM9uFGnY6Q4ucvvr8TKYh6R9jEwpD+mkWuVGKWQCHzkDJUOnAYleSjAkaaRaDDRoOfpvgQ3VAHft8qE+g9n+16FZrxGrQdz26BXXYgOws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QnBuRI4M; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QnBuRI4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnx1GTqy/kmtmKt9k3eUiz9VVWQVx8fzBuxhFa0fMVsmJv3FULvIXjKVV82jrPdKTD991Gra4sswQCvbQ+9OUjya/vFp0KhHQwwKQGpZkbUPmv8UsQX+AjozCByDpDfpGXEH5zhv6mqwXsrnddejBKQn+ZR7fhLP175o+W0u80hXL+XJf3bJcCJhUhK4xJQUbTucaW9nRKazpC1chRr4Kx5rtbsG0gF9d26BSCUqsyxEaslIQCjQujizYThLkbQAp/3S7o4tQWKQNeGwJSrvacZ/zJHRx3y8v8HHqF9C+l7iddRJGUKux+F/wm2pPAHWlQYKaGwFpck97PNmgSyZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xcsi+qoXADaMcbinFREBBuIHeQfl5W8y/8cKEM8Jao=;
 b=tQQ6g56R3L6pJubPKOPkBSqnNGd5unLbgDMYCJ5jIl3xw5XyUu1Ql5+yHGyunGpTDzUZatft0nGpNtsxSyfOfgYEz9CKXYfn3Dte3f9Vil78T2fZMBOGE63CNLj4wRrp6rKBTNNltO1KXaw/ppnS28zYiNC++X9Bloq/zGxRVvOZ1DlbpT7NiglxZH7eZb/OAQygb74SpxXKH2gWDrQG5c5gRz6ioW0ZPKL1H1TlWUkFrrmeFaTy4C6b5f+RKXEYoR+zeF0sMabU4mFcmFsyzT6K4F+ZP7cqE/ICTjBGR2XJEgiClTn9jeL63WPyanEtTElKabpH2Xtof+/Ctx9gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xcsi+qoXADaMcbinFREBBuIHeQfl5W8y/8cKEM8Jao=;
 b=QnBuRI4M5RdYrRB4jqTprpP9rJzPa4KPeNZzkebTXAMBbhjaSGEixDZQXmG6ZWxr+e4rl+rpFtBKsre1NWpAtOXaCaplmMycdFZ3wydlWAcOkA1rIGDgYsgj9UYNd8xlxYo/5RGXz0O3ZbeQTDBi/c9bdDIuGGm3qBoZGcwyeTQ=
Received: from PH7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:33d::12)
 by PH5PR10MB997710.namprd10.prod.outlook.com (2603:10b6:510:39d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 04:12:51 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::89) by PH7PR02CA0012.outlook.office365.com
 (2603:10b6:510:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 04:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 04:12:50 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 22:12:47 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 22:12:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 22:12:47 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60U4ChLe681946;
	Thu, 29 Jan 2026 22:12:44 -0600
Message-ID: <4c71700d-e4a5-496b-825e-01f346f73949@ti.com>
Date: Fri, 30 Jan 2026 09:42:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
To: Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com> <aXtrW7viGZfMNZur@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXtrW7viGZfMNZur@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH5PR10MB997710:EE_
X-MS-Office365-Filtering-Correlation-Id: adf92f0a-50a7-4c8f-abba-08de5fb5d522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clBaVWJZOUoxSWxvdEVkVWJ1UWFKNnlKeXFtZzRnOWlzS3FsaDY3QlA1RGN1?=
 =?utf-8?B?SVVBaXpnQXVoMXlOcGRjSGxMYnYxVUdsK084UzVUUTFGSTlqbFVUZERkRTZL?=
 =?utf-8?B?L3YxNXVRWStxd2pSUWprS2w1RDhxVVh3Nk4yNjNIaHpER3R5MmhLbHZjYUNP?=
 =?utf-8?B?RjJOVHFOZFNRZnZDSjZsYWxQa2VzeE9aU1ZBWHp1SWtOU1A4UjR0OG80WFVX?=
 =?utf-8?B?djZ2TnI3TElCMHg3eUxxREdnZ1IvODUyamI3Mk1oZWphdlBrK0ppNHZRdkNG?=
 =?utf-8?B?Y0tpTXIyeHUvQ09mb1BpeUVnTGNsbUpkMWdOM3k4QlI5OXQ1ZGlyUytqSFBI?=
 =?utf-8?B?Z0tHaUNGbnloQXpMWWZ3ek91QUxZZlhUREVxTlFmckl0NGRUYjdyb0JRMlZi?=
 =?utf-8?B?NXNXUkwrY0p1ZDdabzNoclpaYU1ac3dMU2lkdXZwOTBLOFNzY0tPN3dsWkk3?=
 =?utf-8?B?UDJUZFJTblc3aEc1amtVY2xqZEh0QTNzdGFrMEhFcjZPUmdPUGdNZXpFS3Zm?=
 =?utf-8?B?Q0RndDY5bzV3aWx4STdpOUxRTW9nWGkzSm1kK1prQ3lLUjRGbUN0Q1B0dWZi?=
 =?utf-8?B?ejhVVTVLWDhPc09XTlNXcTljZHAwVWJjdkZGaUtiT1dZYWw2Vm51UEFvc2I0?=
 =?utf-8?B?V0JIL2hFRUZTcHAvS0JUVWpoZmE4OTV4TmpTWEppcVowdTZsTHE3dW5IQ3Y5?=
 =?utf-8?B?eGhYaU1yaTlZczNSK0JuV0x5bWVmN0R4S1VEcTZwT2RuKzNEVGowL21jdm1y?=
 =?utf-8?B?dU1HT2gwQTd4QTVJamhyNlJ0dVpBSW5EQUJhL0RVVmZLdFhsaWtDSDJLRlQ3?=
 =?utf-8?B?WkwrdmZISjJ0eTNuOXRYK2ZVbCtEK0h0MElubFNsVGd6WHVoaDBwK2FpblRW?=
 =?utf-8?B?YUNCU09tS3lCU3pHS2ovWHp1bHpCenE3SUk5Si84N3o0K0Z2YXRrUFFScEIz?=
 =?utf-8?B?QkVyOC9aRnU1M0tpY3FFQ3VqSWN6UC9qNzU5N3pyRWh2MENyWEN6alJGWkxi?=
 =?utf-8?B?UCtabThyMEtodjByMGg5bDFkQjBGRk1JQXhTeEhpcFc1VUp2RjVCMjAvSGtl?=
 =?utf-8?B?NEpzZ0hCeXZpRkZOSDU0TC9ubTJzMThIMGVBTlBTUXVxNTBvMzl2L1FnSGk0?=
 =?utf-8?B?YlpmSTNzVmpvZUhjSG85aTc1NzRuNzdOeU1hSmgxWHZZNTBTbEVBdklLNndl?=
 =?utf-8?B?YWtzeURSaUd0NHNhZVZrTUFSZmhSTUZvVDNieFlVNTNuQ2ROZy9velExbVdH?=
 =?utf-8?B?WmdLaWRNaU9IbDkrcW9FMEE2VXJaaFp3RkZkU29GdUg5bmdYbXNCc1ZnM1JZ?=
 =?utf-8?B?T1AxbWJaRFRNejJNZzRmNnZJNnd5SFRHeityOEgxT2VWOFJhL0JENzZyV3h4?=
 =?utf-8?B?aG9LeERJSXdwOVVyRHVYYTd2ZXZTQmtQRjQyeFQwUDhENkVoSXh1K0ZEVlcw?=
 =?utf-8?B?WXhrM2RKSGJoZjAxWW5YRXhVc1duS3dTTVZmcmZsc3RycFZMamIwQ1FaSXJh?=
 =?utf-8?B?RXpyYUNqNG53L1BVZlovOFpocy94WkZUbDcxU0VTSUN1dVpyWm5PN1QvRkl5?=
 =?utf-8?B?U09ObVZ5QzhaTUpLMVQwbEg4RWJNUEVqb2h1ZFdkaTc3Y1Arb2xFMlZ6RlI1?=
 =?utf-8?B?clB5OE5TUmNmVWZVN24rN2lRMnR6UEdFRXlMRGpMZTN2Zmp1Y2dUV2k0M1RI?=
 =?utf-8?B?dHdoUlhGdUUyVnVkVHVkMTdoSXQ1UGh3U2F4NnBURlNPOG4vcDY3YU1pQlhG?=
 =?utf-8?B?WkZkK0doTGZXZ3dDVk9ubGhUVVMzbmVGekhwVkFvWU8xbkVMS3dPZ0hNd0dy?=
 =?utf-8?B?ZElwTDRnclJLaVNoVm5JRUtUdkYvMnJVTmV4R3BZWkdNRzNnUmtwZEZYRzdW?=
 =?utf-8?B?bnZWSy9yUkdUZFYvMkh6MEVoNHo1a1NhYmxxbEJjcDBMQklENFNobjByU0ZS?=
 =?utf-8?B?VXFOTUdDaWRQQ2sxQXNKQXAzU3p2YUEya2ZySk1FYjNqOVdZMFNFVEVPRDVw?=
 =?utf-8?B?M1FldWhxTDVabmptUElOT21YY1ZkempHMUs0eXJSbmQxTTJWWVBLdWJXd1BC?=
 =?utf-8?B?UlNzdUpTcTBBYjhrblkzQSt1dm9VeFdBdWdGckVsRDkzdlZ2VmpQTzg2dVFs?=
 =?utf-8?B?ZHRkSzFaUjhZcXl2cmZzaVBVU2FJbWMza3JZY0paRy9mUmlWUjVhZi9iNUIz?=
 =?utf-8?B?c0Y2VHBqZEFNMjNCUGpJNi93R2p5RHdZLzlEWGtpRlVKTXRBd2dYd3JlYW1X?=
 =?utf-8?B?OHhCdmNDMlk0TERTb0tYS011U1RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iwIY8G5ihwyBW/dW+ZtHz5Uu5KvW4GBqaBPE30qJcBhZ3/iCe2u5tVwb3zt+tn9rvKafykv1YYl9TAUb2m8q3FuOA5pglWLcMDNyc9i4hd2jF75k11wgFdPQiWqBIw5QowXIeV0mTgodCUxpAv+tcJIzBw47Y5yTVEkc82CfeBnVMZQd+nMrS5nuHc/SF2XRqO9k+WS8u5JM85ZxiWf+9JX4dndiDEr+Kzdy4Asno7ekOdP7PlcMR2RndxpxbEPX5TpjpZKn9noROP9ZFxiTWgxI7W1b7Wk6L1gCiSLNQ0LpF0zZDQi/w5pvGgcAKphnnMIfpPT4rG1OdVRwhKbKIlSycYUJ9as98OwfqccOBDpwKjvhkPVBolNfusrEVpXNuqbFoiPSf5Nyp/UmARM6sntbzKrPh86FKRcxAme5jtmYl9uFhyX8QhRTXEN8op+a
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 04:12:50.1837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf92f0a-50a7-4c8f-abba-08de5fb5d522
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997710

On 29/01/26 19:44, Niklas Cassel wrote:
> On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
>> -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>> +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
>>  {
>> +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	struct device *dev = pci->dev;
>>  	unsigned int i, num;
>> @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>>  	u32 *indexes;
> 
> Hello Aksh,
> 
> Considering that all other functions that you have modified, you have added a:
> 
> if (!ep_func)
> 	return;
> 
> 
> I think you should do the same to this function.
> 

I omitted this NULL check here because all the current call sites of
dw_pcie_ep_clear_ib_maps() already perform this validation. I felt
adding it here would add redundancy in the code.

> 
>>  
>>  	/* Tear down the BAR Match Mode mapping, if any. */
>> -	if (ep->bar_to_atu[bar]) {
>> -		atu_index = ep->bar_to_atu[bar] - 1;
>> +	if (ep_func->bar_to_atu[bar]) {
>> +		atu_index = ep_func->bar_to_atu[bar] - 1;
>>  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
>>  		clear_bit(atu_index, ep->ib_window_map);
>> -		ep->bar_to_atu[bar] = 0;
>> +		ep_func->bar_to_atu[bar] = 0;
