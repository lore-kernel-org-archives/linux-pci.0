Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB933B97E;
	Mon,  2 Feb 2026 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020169; cv=fail; b=hu8ztKgxgWQbTANnWe+I1N8g0mgCIqjajSJTZ0MseEBttsosvBr40Hifqni0VSXP2B/Tr5ZBxWRFX7P4WSRPTKs40feYAOvwjby3fETbZu+8jVs6hbpLVEP10elExJ3DVWk+uA4Oi6UqG+SM9OHnQdl42zNRRKhD+WbCD9idTZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020169; c=relaxed/simple;
	bh=R5iAmpxauSps6AQyUxyQnCnzvsBQOjZm+k4sCZBLkck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUE3T+dq/mW6D4BVpHXXyUoRKg5xSfmw6HRvLKGH26USeRdejKIccBG+XuAx0E24ViNWyo/5Mlq2RBsdCZoxUVdAnnjxXk5VNK/vJEkUcVDpLvcQ34e+ge4Va3ig7AyhTE8jYQ7+OoGlrtwNtB8TJ527uTcrGdu/pgss9VDzHpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rcA1ZQYK; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rcA1ZQYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUX6eMrETCZqAZV0xw1WL428NjkOAXsL/EsJVS8MBVxQOmU82T6vP0QzQYv3CspkidxBKT2gEtoLFfDup/an/dnDD0ZO+7UHabtu10wO75rmCb5DmBZEVGOmfKxpyZSLrol+T4zYnS2QWZDBYRQFTQggx00phCPpWP4R35r3EvLZtWTH9Dr2c4ZHKwlykngNyRz2Lc2jLzvBuy4CQewYYrESNINGlrZpcvSwd+060AYl0nUBqle67+Sjl1SIDqO0gyCw4yozEspRox/UVxwxqLDCPAKIFCuokmX3mOsN+NkLIRJc/rBvwXE7rhUJ/rIt/+UiXDe7Xhgp8TPEMSnAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALQNiPwRjKrGYbl4NmT8KoxrfgjmKL5BDgLNg3BmMYg=;
 b=ND9MVt6iy0pZQKAmHxxB6XyckTzcAyqQTn8tcwTwL4iDQDBaHfrCQMuhlt3IO1w6SA8lreOpeDnliWaO177gemAihZJPsJr+YTaViRUmG7DdDBtq6PquCo4np5SdKdoraw1KJV2kOf6Vb6gNxKh/YGTTvflMXgppklVSyM0T5nrywEsgQc5yj9xKbmiiad+cdP01pxMsgc4DdgnoGnpatN2Q/YCDWTfPVD6bIzsgH1FjJfoZOQg5NxvkXkb4bVqLkIZSb4WlBItbNcklTdF5Hz1cRJ0VPOJEpOgYliM1lrgo0xXfYoMkFqgtvrwewqaKkE9T6JKIZdPeCbGk9rK+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALQNiPwRjKrGYbl4NmT8KoxrfgjmKL5BDgLNg3BmMYg=;
 b=rcA1ZQYKlm4cLLh+kJ63Gw1KsMsMHNQIBYVEOaFx0EvRwt+XCaS9QY9DxfRDJyDWj3d81qqTEduguIj8RFu/fquse5P9YTzT/9CWM/e/xZAzzFPbaMxL0b/9t8vI+YlxqX6ilNaPXZE0iZmsliAm167sFzt3Hht86gDUIjS25oU=
Received: from BYAPR07CA0108.namprd07.prod.outlook.com (2603:10b6:a03:12b::49)
 by SJ0PR10MB4445.namprd10.prod.outlook.com (2603:10b6:a03:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:16:03 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:12b:cafe::9b) by BYAPR07CA0108.outlook.office365.com
 (2603:10b6:a03:12b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Mon,
 2 Feb 2026 08:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 2 Feb 2026 08:16:02 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 02:15:54 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 02:15:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 02:15:54 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6128Fo8X1386742;
	Mon, 2 Feb 2026 02:15:50 -0600
Message-ID: <7e1c38de-c3a8-4275-a9a4-03773ed9dd6e@ti.com>
Date: Mon, 2 Feb 2026 13:45:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to
 correct physical function
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260202072758.101845-1-a-garg7@ti.com>
 <20260202072758.101845-2-a-garg7@ti.com> <aYBYgrM6SPWQy6iP@ryzen>
 <aYBY_K21cmj4ICxx@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aYBY_K21cmj4ICxx@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SJ0PR10MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaa5659-a653-4b1c-3132-08de62334de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWFwaDRBeW9aUkptRWN6MEc4dHVUYm5aL0NOeXhUdE84UjRXTFlGZGlvUjlB?=
 =?utf-8?B?dElMZ2MwYmswYnhZa2hwalJXMVhhSVZOTm5DSVU0UThNUGh4SnFFUGI0Wnly?=
 =?utf-8?B?WjZ0NFRvSG5ETkRHOGc1aXgvZWVwcDhrTGEza1hyamowRDZjVGpqM3FyM2Zi?=
 =?utf-8?B?U3VxdFpQOUpGdVNFV1JPTndYYVptMlVKVWNFeU01UzBsM0lHNHlNNUpUeTFE?=
 =?utf-8?B?b2VaWElwdHpQc25pMFd2a1p6ZEI0RUNUNnRPd3BHUDZMZ1hnN1gxTzZoVkFF?=
 =?utf-8?B?WXRYa210NzlDYVhjOFhKb054NStxMlovY3g4cnlvS3JhUVRUMXR5M3JyVEVO?=
 =?utf-8?B?Z1F0WkZjaGhYVnVJbDFWZEdua1l0U0JVNXdqWXM0RGtZckNJS0M4MnZPOE80?=
 =?utf-8?B?d0FDS21SSm5VVjNKN1RhTDQxSzdIWDVGblUzYlMyTkNVaSswTjdEbzhMLzNz?=
 =?utf-8?B?ejZUaEpPTGZMQXFKTjZmbVd3S0NBTnBYVkpGZi8vQ280Y2RpY1hxWUxtNDVD?=
 =?utf-8?B?aHEzaFREdWV5ZXc4bSswUm56MjduNytOZ1k4dXFCUk4rK2gwSFMrcmxzMnV4?=
 =?utf-8?B?Vm45K2xBeDYwQ1VEVk9PQ1JQTUQ2b3RnT29sUE1lQitZc3doRC9Ea1lFdkor?=
 =?utf-8?B?QWt0dGNJQ0NUV1lic0JtZlYwb0lsV0pOVDhkcnRCRVRCRFlKYkZQQ0Z0cGt5?=
 =?utf-8?B?MlNZa0Y5bmFPWkhWOE8rRUJpMU1hTG9xZXJncWpQZE8rNVRGenFKN0pIVTFu?=
 =?utf-8?B?aDd3MUwvVjdjQlhsZXpWQlhIdmRlblcvQUVDYi9uSVBDZUl5N3dRaGFzaG9G?=
 =?utf-8?B?OUZFRVJSNzRaN0E0TVdQcmJHMTRBcVdQZWM4Q1BjTlFxRDA3RkxEYVhVM3kw?=
 =?utf-8?B?N3pqQjQ1VUpoVkovSGlvRGtsNzloRjdmY043c1l2aGgrOExwUkVkbzNkOWJN?=
 =?utf-8?B?WStnQ0VKbEliZEVYaFFsKy9DS0pKVkhVS25LY1R0RUpkcU1YdHBjMko1ZDBp?=
 =?utf-8?B?VlQ0UjBqSmRJSlZTRDQwVGRtNGVPT2Ewd1ZQWm1TcElJVW9DWUhhN0hvN0F6?=
 =?utf-8?B?ZTJkUG1wWXR2VS9nNi9HTlg0aXlBZE02OXpCbGJmSGc4S0pWSTQ0ZGExTEpq?=
 =?utf-8?B?eVNlSWFzdE5nVFpTakQ4Sko3RGR0OVBYZVRzRE9Da0N5VXNJdlBWSHI1eXZw?=
 =?utf-8?B?MXI0QnR4bTU5ZlhTT2dvbERxaStzK0Y5VmtCWEs5TEpWQTdncEhBK2VBaEY3?=
 =?utf-8?B?MVovaERUL3ZCTUtmT08zaGxKZkZZM1FFWHFLL0Z6NkdtUlNlVU81M3FjVkV4?=
 =?utf-8?B?VEIvdURGOEZ2S2NRNkJKUVBTdjJaUzVQQ1FqaDR0cEg3KzV5ajdyVEt3NmR0?=
 =?utf-8?B?S1lCU0RQYjc3NExwQnZzaDJrY1VPanlIUmJVdldJUnk5Vm9MVFdnV21ra3Jr?=
 =?utf-8?B?T1IyRTVGRG81d1NmSEN2NU1ZT013N3FmbmhNYzh6Y3lzN1paOWNwZUlkdmZ0?=
 =?utf-8?B?SXpkRTIrK2dHUk54OHFXMFRtYmFlUUsySlljUGs5eEw2VytCcVhHdC9mNlNE?=
 =?utf-8?B?ZVpaMlBlTEsvclNUNHV1VVZYMlpQQU4rK2V6aGlJbTc3TW5XQm9QbkUvZ3Nl?=
 =?utf-8?B?bUtnOEplbGQ4Z1FRQkppZlo0Y0ZBQW1Ock9UTlhjeHVWdEZDUCtBQXhxbkpo?=
 =?utf-8?B?cGU5cDRKMk1WTDJEZTBtdzVNTUF0cGRoY05vUkVXbHZwU1ZFKzZrOEp1RitH?=
 =?utf-8?B?MDlic0J5ck5uRDZRcytkS0RPWm55VEpDS1VCQTFoekcvSEk5QUxKRDJKUnBo?=
 =?utf-8?B?MTQ5ZGF0Z2R4cGE5MWdQaU52Z2hLdnJsOFlqelVXdENabVFhNFZTUFA3a1Nz?=
 =?utf-8?B?UkZqMFd6cy8rb0Uzd2lFN20wYk1GVjhsdlNpbGJiYWJEYXdnWG4za2tFSjdQ?=
 =?utf-8?B?K2xaTVRJL0wydVNVd1l4eGZGOEJlYTAvN3l5aWI2dHJQeGJpQzBxaGd4aTBu?=
 =?utf-8?B?ajdlRWFOMVIwWVhpV0QrUFh2OExhSjcveitYeW1pU0Rib0FTRFhvVFdWSTdZ?=
 =?utf-8?B?MHF5N0JRM3VKU0FVWlZpa002VG5iVXF2V0tKb1ZMblBPQ0JPY01MK1dkUHl2?=
 =?utf-8?B?OTZLamsrK3QveStaTUJvcG1DVUVjeEJ0dkpMUy9MQmlleWlrRjBmWU96T3hi?=
 =?utf-8?B?bnpWWkY0VG9EaVRjdDFqeFJnRXRJODEzaDBIL2VuVFY0SG5VN083OGgybURt?=
 =?utf-8?B?Z1JtLzZETVdPc2w2ZFBpRnRoN0dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LatVGJy2MKilEYkohGy5PrntbqMuT4/pDk38Wv6GHY0RELt/odcMZBRuuDwOtb1dm6SElO/Lv29nN1kDzmqbeWHs+2VN2OhDRc7Qe6SfCQaNQA7HeCCI2Q5V92mE1x2R0vFesLkx69fTSje2w+ItvG83CcK70SW9/0VpT5bxsS1TTQSQdXjQEAGRo4j2k2x3/1nMB+uQElF9gVoDDWiBuJoMuGfhlJnLAsAZ8IvpFbsu6z4YIh/U1qxI78rPg/fpJURLAHRa2yigaUemZCVfW2o688SzGqqC8j9OKbMJr78c2VmpqNPlEtW1/wwcMhye7+4DkK4KEEzbfSy5pj5xMofRh7PzfV/gC3jMkqYVUiDz4PBq4xHoI2nsxLQMWtYs0arId+FQL8VMpYkBv1FmmlLr1rTX3264FSfy2Sv5w2P2H1nTESytUBX9qqUmTQeE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:16:02.1450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa5659-a653-4b1c-3132-08de62334de2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4445

On 02/02/26 13:27, Niklas Cassel wrote:
> On Mon, Feb 02, 2026 at 08:55:52AM +0100, Niklas Cassel wrote:
>> On Mon, Feb 02, 2026 at 12:57:57PM +0530, Aksh Garg wrote:
>> > The MSI-X configuration code reads from the correct physical function's
>> > register space using dw_pcie_ep_readw_dbi(), but writes back only to
>> > PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
>> > MSI-X configuration for other PFs.
>> > 
>> > Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
>> > register space, matching the read operation.
>> > 
>> > Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
>> > Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> > ---
>> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> > index 7e7844ff0f7e..771241e1a2c9 100644
>> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> > @@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> >  	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>> >  	val &= ~PCI_MSIX_FLAGS_QSIZE;
>> >  	val |= nr_irqs - 1; /* encoded as N-1 */
>> > -	dw_pcie_writew_dbi(pci, reg, val);
>> > +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
>> >  
>> >  	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
>> >  	val = offset | bir;
>> > -- 
>> > 2.34.1
>> > 
>> 
>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>> 
>> 
>> However, please also fix the only remaining place in this file which still
>> uses the incorrect dw_pcie_writew_dbi() instead of dw_pcie_ep_writew_dbi()
>> 
>> i.e.:
>> dw_pcie_ep_raise_msix_irq_doorbell().
> 
> Perhaps doorbell is special, and there is only one register for this...
> 

Yes, we have only one doorbell register.

> But then, perhaps add a comment why this is the only place that needs
> to not supply func_no.

However, I think the offset (0x948) of the register is self-explanatory,
as after 0x700, we have port logic registers, which are per-device, not
per-PF.

> 

