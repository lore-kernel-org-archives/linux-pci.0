Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941C38C430;
	Tue,  5 May 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971180; cv=fail; b=X6svTZogWBr2CoGXwICyPCY/+1oeSF14HBnT3SrT+W94Wo5tGolrvnNVqImjvXU/+7b2JZJ2DF+yVoCViC8u5ERdwdqzW+UnRoJpo0YIfLWsJbdJ2dSkmVupnQINfW7g1zmyJZqsnqffHRgS95Cp1+DoS6FNN6an5ER/XWBLzb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971180; c=relaxed/simple;
	bh=oEdzhG28me6isnRrjAGys+kdhSaOxfBDwBH6pmu+3as=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FlWKCTcmHctx7eep8mYxWwITr3Jmpm96rxcCUn6X4HsrDfaJqIgfXiZDBJFKlx3uPpkmO8kCpo6UEParCNk57+98uDtgFpNlLsFx5WNphksJs2Y8K7JwuOEidjGbwdPctOuD7qQJAANhSTjlmva38dxNpD6tLhssnlkC3dSwsFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=coqaFGlb; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="coqaFGlb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsZN1/fGl7oC6o93TA3BB1mVWngqNgVpvvIHTaTWzwemyQHW2m3DuI3JANGVhTUrEYP61gNcCJNUyrQYze2ybszTZSV1tuMp6iaI+sHHYvQKTVZ3vrXdc42KG4wXaDIkpqZJKNZTYKRwdrHWvpXNb8jfy1GXiK3BO7cJOTjwXmE37zuYvyJvkF35Oh5UywqzLM28bhgZhZ4hGg7IpQOJ2rOyAhgA/sYYuWN0vp68qSGpyNVMSV9slWmwGmUQdeCycHUVwegoPSM3BXpFPN+gVCEnPk9Xt3vjOc/1ssLmr/3woP/3LiRS8pCSGw6tzUMY3ZccJ3Lvp52LRPwdJtfpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvxp796XgJjUalvx6y57xMLefEfqWYjVcEp+hyvjcYk=;
 b=sLcB/vbQ6FUN+1ysWsZzhL4qBXbo7HnYHo5cjd+sClhP3h0YZmzxdpWFP4TAVrubxe5cUoJzVZNCImiBF+5CLQvLRo/pwN3HIPaUkgyiJuqGNKxkzomxeM+Eslz2atSE64sn2xk9rXqBR82D/V/nUoY2ifwKYh171Y0c1qEYYZj/Qc5jT/4EMiuSaaqnobn3fWAdXs3dHro89+/3D9luLSOuny9YckuZYaCGXsLgRSnAzAPu5uQy7mDbOSbVbEJxwMzy7O/lzHbbBkqgxT5SDNRey89et9yAQofacZX8nAGvcfIvLAlXTPcXJPsMIwRX55dcwmOYTGQpGvqAaZj0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vvxp796XgJjUalvx6y57xMLefEfqWYjVcEp+hyvjcYk=;
 b=coqaFGlb/4RB96ngLKOg3QI969uC8BHLgxiBWHV7y3i+glXam7OXi71nYd5Rc759eb2nHfbejkpsGeZ8K3YS4ab/NzOBfdgUnZPlwJI3fHSKS+xwaCNlB30lVcagOWINW79y519f7vA9qHlCzaqbvKLsN2ry8bwieptNSIosf+I2WCjPRx3fsiXLo511yfmnz5lxbkEEMwi0EqP+o2DzJHcSzYC2IYpsmBm2FUr/xezfykzq/pWLVm56qk3O+OcfD2YEzkNWLUmohFxdFF6TX3Vg8ZQrzyfyZ9ZKb5z3nXSxFKW5IhLHHpJgFa6Ju/0IXVignEOqaLRMiBVtc40oHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:52:53 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:52:52 +0000
Message-ID: <835e33b9-e5ad-470f-b21a-cc9a11362ed0@nvidia.com>
Date: Tue, 5 May 2026 09:52:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: dwc: Apply ECRC workaround for DesignWare cores
 prior to 5.10A
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp,
 hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260410062507.657453-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260410062507.657453-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0073.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::18) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: ba494704-43bd-41fd-db23-08deaa83b175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YVkij7XpRaMZTcKTm8FcwEv2f+gcEES/kFjrReSQKOlS1iVpsab/QaKyJsoL+f9VcyApe2YeFRvnyldzCff3PMQpmiUcWsrDNR57uhG8PR7Clr/NnZy+K9m+BbwjXdldqk8OtT8UwW1SHMoYOSaTihnYw6/QeysxH4rwZNfYmAdDsWBTmjGcqqZlQRURibm5ZIeJP0O+cIcKq3NIqsPY4YrC09CFVZbrcH7Zu8Po+7kqN3CXGOkcN0W7MxYDWI6h7EAcOu2jy8jRX4QB1CJIl/1KmA273gFUyKRtUL4WJIiiHvl2tfnMslKTw8Sktxz8THoFY9HyOiBLKSaamZh4XImEvz0GGIsw8aIozocke6iy4h3MS1IZWSjj/wpFrpEPkh9byFzoxhm9CMjksql514a5M4VPf1qtWGhcxMrS/+JZ632Irz3c3veFSSQgIsPXtnEe/JYnN26lPCmQcQNratrkRjCq/SaphQAIRWD5e2JEMtGilh2BSQxPbf3DJOGA56Bnm4L4sPoKgmvzk+b5P2h2/38jnxWlraxeaPHLvusQgkVk4+OvZxoCGphPMvul/aObZ9ve9Jfd3FUghTWledF6sjVgbLXSGTFjlaEGi23A6wT9o2ThdbFPceRm6Y2vRaBIgHl4qCsO0MwsIkaGFO/ioqM7oxkkddOxGtho9LptW6cHCyzdzIWL71hVw8/lE8DeRltcFYtNzvMY1j3gtVa2ymwPsOi7+Pipenvm8jE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ektueWh3a0NCV1RITjNPdmdaTHk1RkozdFQ2TENYLy9oYVlTazFZTThWVy92?=
 =?utf-8?B?UXlXR2VkUzBFaXVmM2U0U3E4Tk5nTTNVUkVWN1lVd0xhM0lGM0dwais1SkZx?=
 =?utf-8?B?YlNNclY2Y0d2ZmwxR0Z4U3lTOWxFc1JpcHRNTEh1YlFGbWxFSUxHMGc5ZHdI?=
 =?utf-8?B?MTFrWS9NampqQmRXS1hnMWh4YmQwMHErUEhkZjRocGJEQjFaNGNocXV2VkhI?=
 =?utf-8?B?VVJ0NUN1b3djVVp3UnZ2WmN1a1BQOVViNWlqMWtoK3NqaTJlcEZCV3oycTB6?=
 =?utf-8?B?ZzlEK2lSUzhydHo5bFkzbnBqTFlpeFBUSjRGcXFGTHBOalVrQUxEZnFxSEZQ?=
 =?utf-8?B?R2VyMy8vUm9WOXA2RmVhdkQxMW9PVzdnNThMK3QzdjBxM0hpTS9NbUdTV3Vq?=
 =?utf-8?B?R1dMdEhvY214MTRmMzd5WXg3SWVDMFphZ0ZUY1g5d1R1TzlsOEJpdnR3YWNn?=
 =?utf-8?B?aVVleU1QcCs3M096NkpKS1ZaTnB3ZW1iZUpzdjI4MUkrR25kZlQvV0tPekcw?=
 =?utf-8?B?NTErR0RXbXZOSVZmaWVYNlZUYmNOVHRPYTBDSHlKeEcxVUF0cHlRUkx5b1p6?=
 =?utf-8?B?NUtqbkMzR3dnaEhVRkNWMDhZSzJaR25BejNzWUZNVHYvalJOTkhhK3pJdEF5?=
 =?utf-8?B?ZCt6RGdmcm1KeFMwZ0RvOWN0YW5aejZ0ZjlDaFIrTmVDYythMHAzUXpUS0RM?=
 =?utf-8?B?TUIrVXpqdWVFbHl5Sm9HV0wxYXRwUVZFMVhEVVBrNjFVczBPY0I1Z2RwbHd6?=
 =?utf-8?B?b0xUZEVwL0loVVRNcng0QnZWVGVtb01mQVB2ZEhWL1dsRFkxUVp1WmQzTVpu?=
 =?utf-8?B?NWdqUTJ6MXREeW5qakc1dXZ0b1VZZjg3d0J6VHRTazFNRHM4VjIyZmZKRWRv?=
 =?utf-8?B?VGF0NmxpenVBeUtCUkRyTEJBSkJaZjltMUxLc3Z6NzZQR0dHLzNKc0FYK0lM?=
 =?utf-8?B?TDlkT0paRFJlQjZFUnFjdUJvckVlQ2xvSTVqTHdRdnMwMnByWDRGakdMZjM1?=
 =?utf-8?B?VVp3ODRMK2FQbncvRlp4ZjFuUnZ6b2ZoSjlhWXRRK0o4cnhmUkg4ZXU4WWhu?=
 =?utf-8?B?OUFrWkw0enYvZDVVSWttT2pBK3VDcEFVVW8zdlZYbWxxUFp6akFEODkrUCtZ?=
 =?utf-8?B?cmM2TVVzNllZdWNxdVFMa1l6ckFJTjlldUJ4Tk4zc3I5Z01WWTFJWG44Q3hy?=
 =?utf-8?B?L3h6Wm9CRzNpVEwzL2pyMXVmWFh1V1dYaHNGTVhyblJQNUtVaEJNUkRMdm5v?=
 =?utf-8?B?SmRPZUxPbHRsaFVEUDZ0VnV4cVMxL3FiVGlxZ3VHRFI2bjF0MGlzMHJ3R0J4?=
 =?utf-8?B?dDhlU2JrYmpzU0REZEVHOE9CaUcyUXI4b0hWdEZGSnBxRDkyT2JxNWZJV3F2?=
 =?utf-8?B?MmNONGxDTDFmc1prZFRUaUpGNmw0SUFoWThhdEJJNk9YeS95ejBTYlZpNmJW?=
 =?utf-8?B?Y1BPNU12M3JrNzhueGVtY3NUQjVmeHBtWlJoK2lqbVhJbjlPckFHTkYrSnox?=
 =?utf-8?B?TUF1WVFQQWcyTXBsZmpRZHgyVnBBS2xSOGI0NTdXQVREY0pZSGpzcDBNbWUw?=
 =?utf-8?B?TEs5NUZUSzVCcDFncW1xMzd5TXdSamw1NW9HUEpYMG9uTFd4TzBRdkdkZU5a?=
 =?utf-8?B?Z0NLK0VLUlVjQlI4bDFNOVFpWlJnK3IrU3YwczlpcStKL2VLeXhxWC9nODZN?=
 =?utf-8?B?ZTEwZURrZUllV1ZRTS9VdytJZmFTd2s5NlpURVdza0lyUmg5T3hlcXZDcHMz?=
 =?utf-8?B?eGJPaUwyU2hNN2gzcXMyNEhEU2ZRdEo1bktHbUw4ZlFvNjM5aFhLMnVFS2Nt?=
 =?utf-8?B?ZkFFNERoRGYxNS9sVlgva1dYZER2NEN3ck9td3BoR0E1R0g4aFFrWW1QL3Jk?=
 =?utf-8?B?Q2lqSVU2b3FId1prcFhGOWdIc0ZmWVoyaG5GY3gzNE1MQjJYQ1cwZzBWOS8w?=
 =?utf-8?B?Z3M2dnpOVkhyd0t3bVBwcXU4d2N6NWZnNFRwZVBQWGRDT3daeTZDV2RaWGk5?=
 =?utf-8?B?Zi90bVFzdUQ0UjBFV2lZcXlPZXkxVVRkY0tUeC80MFFoanF4WHkvMXFaYVEx?=
 =?utf-8?B?V2VQeHRXVitvRGpNbUQ4R2xsUnYwbUc1U1h3N3pwcWIwVU5tNzFzb3BrUG5j?=
 =?utf-8?B?S0tyNU1YVTVOcjROV2U1QW9QamtCM2hvVitTUHVBbmJwN1RhYkJyNVoxRWFh?=
 =?utf-8?B?SUZGcTVJbFdtY3lnWFhOdE1sQ05FMkpUTkk2WEkvRXRjQnhtU3lScWFXenVk?=
 =?utf-8?B?bXU2djJWMS84MDNBOUl1elRNN0N1T3grVVZhRHBnWXY4eHZBM3RkWldEVWJz?=
 =?utf-8?B?NzBwUUV0WGN6RVJoKysrUDd1NUp0bnVOMy8zaW1PaVByU1Mzc2xVdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba494704-43bd-41fd-db23-08deaa83b175
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:52:52.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6MayclRzHB4GkvWL4VChDkewjQkIZrUikF2AclgVoJgVdDcNcKlB+kbXZGEZgsO6MQWEnkCYDBUQAonq0RsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100


On 10/04/2026 07:25, Manikanta Maddireddy wrote:
> The ECRC (TLP digest) workaround was originally applied only for DesignWare
> core version 4.90a. Per discussion in Synopsys case, the dependency of the
> iATU TD bit on ECRC generation was removed in 5.10a, so apply the
> workaround for all DWC versions below that release.
> 
> Replace the misleading comment that referred to raw version constants
> with readable DesignWare release name aligned with the implementation.
> 
> Fixes: b210b1595606 PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 6 +++---
>   drivers/pci/controller/dwc/pcie-designware.h | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d69db0ab3b14..d0b3b93fc940 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -487,8 +487,8 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 index, u32 reg
>   static inline u32 dw_pcie_enable_ecrc(u32 val)
>   {
>   	/*
> -	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the 'TD'
> -	 * bit in the Control register-1 of the ATU outbound region acts
> +	 * DesignWare core versions prior to 5.10A have a design issue where the
> +	 * 'TD' bit in the Control register-1 of the ATU outbound region acts
>   	 * like an override for the ECRC setting, i.e., the presence of TLP
>   	 * Digest (ECRC) in the outgoing TLPs is solely determined by this
>   	 * bit. This is contrary to the PCIe spec which says that the
> @@ -563,7 +563,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>   	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>   	    dw_pcie_ver_is_ge(pci, 460A))
>   		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
> +	if (!dw_pcie_ver_is_ge(pci, 510A))
>   		val = dw_pcie_enable_ecrc(val);
>   	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 82946bf78b21..739a213c27c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -35,6 +35,7 @@
>   #define DW_PCIE_VER_480A		0x3438302a
>   #define DW_PCIE_VER_490A		0x3439302a
>   #define DW_PCIE_VER_500A		0x3530302a
> +#define DW_PCIE_VER_510A		0x3531302a
>   #define DW_PCIE_VER_520A		0x3532302a
>   #define DW_PCIE_VER_540A		0x3534302a
>   #define DW_PCIE_VER_562A		0x3536322a


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

