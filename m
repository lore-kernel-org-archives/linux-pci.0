Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593E348440
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568333; cv=fail; b=OBOzlDd06cJqIkiuSGzKpKNK+g5Mp/9mrXYIaCy4LuxHkGpgxWKG/U/7oSXTkcYxffpMaccyxI2PD1wrXt/UenSC2FKFPxYxo+urlsQMDAMVRRu2UyeE0fFDNu6pKj/7VI3XxWjxlfdj4zQ1/hW1nDUbP8mu4sKP+kz/ZDVW+wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568333; c=relaxed/simple;
	bh=mNBdUuL3spsfpCzfY9R3RR13P105NhA/2hEfErNIZgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9VGIF2tQaVRT4QchZACJetO/WZ59xzZg6gFtsl5fpJOvBGYriCytgI6hGPGpOy+DCRQPQ4M1dOcRDflSiHtjslfZDOFclm4HtTkTa++8z3CBRhTr6mAIyqeNpZTWlV0IwuoEHQtSfLsoW2CPscy1d5ifbrHQH+FXWQ57zKEvLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MuG7oKXT; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MuG7oKXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNStMGbX7QqDzv/LVJ8F7qFNFYCWSJueuqphkxH4AHNiGfEzVlosJQiqOZUrjkPhQwJO8QawCsc7Qn8OQA1tZIR30gPA/kAZpYUYEUgX0w7sgX5ff/zPK5nE6KJRVzl4J2eDVd34CafGaH2sQluUhmctw0uFBcEIDdnneuyOdU7fhGAYQpUlXrD8MGKuCxZthu+2Himbg2ZwaYnDoEO7IAF5XIBwYTJpCzY+x4V123EIPtrc3iXAM7loiZj49oB8Aw8j37WA7BEGICHg69kxWFsvOWw7c2o71Ts8h+NjZeVBvB8EhVX3lH6wq6i3zET3rvdiPafJhoe4JN8z7CW3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc+iWjynn7avlAfEl3qwGCEu6IvhOZaebJ0eF1tOT1s=;
 b=BvPh4SP8R9JG7DAlfkRhcd5QrMPBbAuN8TVac+LPzMX3eSgy5E0JfLP1JwOKIN7DdJSduNe5CaDyjrsyplzXUNLAq3pnBjvaky+ujIolOXf8x0fzIX39dU+fXzhB/KDazAuPYYqvfmBK+Wjv7ta5763os/+WB1YzQsZrCfA0bz2MSnmHEw3YFX6DKVKw0F0tQtFCfyOA/Rh67vKU6m3bHQsi/307S8sT/WWkbVlvrYN8EmE74nxCAIZCswiIuM0cMuJF/DzgHaWtHlghZkb6j7xDtmvr3CF/8Qu/bMHVQP5/UXxz3csa2l/MsS6svBY14nQaMtctc6FW3QqOL7MLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc+iWjynn7avlAfEl3qwGCEu6IvhOZaebJ0eF1tOT1s=;
 b=MuG7oKXTbJg4OKQNBW2729kjzDvmP1TuOcbc/LTntdNhQS3BjFX/wbwB9kIT7LELRTXVVstmFrVvUZHBnue6IBSSaR9dWi6d91rg1KoCovymShTYgMfoDl9Q5ULgvQoT0q2VK2dhp6h8ngTMbgK3G5vgYtfFY6d0SL8AXwPcDgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 23:38:48 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 23:38:48 +0000
Message-ID: <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
Date: Fri, 27 Mar 2026 10:38:15 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org> <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260323182014.GR7340@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0078.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: d524d8d3-c8e2-4463-b8fa-08de8b90d42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LqdhkYsv5h9/uNmz4FiJc721zhRxMrW1qlJNSQO/NZmmEOykxKZ29W3yBYBJ+FV9ZtYZnZShiWACFVTbIQdePt/QFXcSs0XG+QWfXTlqGut3i0d8OEQIfywu+gMclRwFSs/pwFUDqRr+0zS2pX0g8xJPtAtWm4gCqrDk+3/S4xa8izIvjHOlS5+QyMudWIIkeIOR3XvBZhzFHETZSDe4cQ4lBt2S3rl4q2jYTgGXFeKZOysKnFgJiOVugXQCaA+923P120DZJIRkIDDgoqxJ8eQ0xYrDfk+O3Z70TJbEQs1BcpZHsITAVVfk1Vl/Knxopp2FUUjC+VR30K/UEBtlBwYodf289vDaKkAxogG7BFq0WpDZPIVTAmvMa1w7FU8zRQBm5cR5VBhLc2qve1Q7JL0ibY+xMMH3pJNquKb2tCk5Py4OOeVRaOG+HzIHYCSTL2D72EgDt/f2Cu+ObexKxjX4zA2IsClaLSwBX8n//uVUhIbDIO0O8A3inTwHqTv/KycV7UgiScl6vDp7tW2dCVdB3s21IFi+fObB+HX2vs4h+jp7jP5erDRMBn75H+QTZV88RGygvE16baeZ9xMxm3GdCPEy+kWM/YGCmk79MwreUQ1dDd5Y6xalR3sjZLlRzxfAj2tvbTXI8xC6c/4ig82vTqOk093Vb5jLdj1TRrPH16ryr6c68GB7VvcqjfjRG/r/sOPAoop9VjGEIBv/Ni15I83HO8itZGYi86dG0hs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2lQMXd0VTAzbFBoYVgzSE1qM0k0cEJhQzN5NHVEai9lRWRnOVROeE05eHMr?=
 =?utf-8?B?QTMxMVNobVFKdXpXSHFMc0U3S3hUY2YxbTh4Tm5Bb1JOSi80ckF4UlhreE5s?=
 =?utf-8?B?cERPa2RMQXIzb1BjUUFrZkFFbkFoQ0hxaC82cUlFNUhUTlhRL1hmUGMwMkgx?=
 =?utf-8?B?V2FrT3lqSndaalhQaVEwdkwwd0pGN1djcGxnU3NZYk91SnN2N3Q4UDZnZ1NP?=
 =?utf-8?B?dFM0anNqYmlwRHBUeGZpTXY5eHJMeitxS1FMMk9FNml5dGpkemR3cXZ2dGNq?=
 =?utf-8?B?SWlsTTE4OXRXNkhETnc0WDRTaFZpakpkRGY0b3FiUGVMQUNNWXJqNW5oMkQv?=
 =?utf-8?B?cGxRZHBCbE9JWnY5QTRPd2dIVTh5d2ExelpwZXZJVzE5N3E3czhPc2ZOSzZP?=
 =?utf-8?B?eFM2R09NOUdHdWk2ZnRqZkFBMFJHTi9kbFpDbVBLRmJFTGZnRHU2NTg5Ympk?=
 =?utf-8?B?bnJlSUd5WlhSek9YVW1OMzAvSkU3Sk5lN05oRVUxK3lpMWRBS0xsYUFQQm5j?=
 =?utf-8?B?Yng0VEdrdUczeVc4SDlTTndvM2k4R0R1QXN0aDYyRDdCWE1wV3FGT1N2R1lj?=
 =?utf-8?B?TDR3TnVnWnl5Y2ozbEFHY3RkNTNJeWxLRW5EbmxwNHNaVG81UUFWNmVKMmho?=
 =?utf-8?B?eHFob0kvOWJRdG1VZzZaZWt1aGNaSmVHM2lNUmlid05VTkkxRkY5VFlScThQ?=
 =?utf-8?B?eFpnZlZaUGsyOFZyS0h3ZWsvSSsveUtJUlVCUWRTQ2xFaDV5YUlENzdsR1cv?=
 =?utf-8?B?UjA0dm1vNVFKZDJ0Z1owZnhwcVFKaVU4ZzFnMFFsQ0hvTEpIZXpESVBCeG50?=
 =?utf-8?B?bnJJT0dUM2xDY2w4MDVRdFZqMHNwNXh4MWtZb3BTM2JtZS9HK1RVbVlOMG5N?=
 =?utf-8?B?MWNDWFp2Z1Z1Ni9YNFZhUm0zVjJEOXAwL3IzNDB2TWpRT0N3Q2pLSllkQlNl?=
 =?utf-8?B?L21Pc1lLUXpDTTVOUUg1QUFJVWoyYjIxbnpRVENRK1R0aVZIeWJyNzBIc21q?=
 =?utf-8?B?QUZ2d3RZeXZQQnd6WXNseUlzeExsNWF4Y2hSMmFyL1hyc3RQN2xRUnJqc0hj?=
 =?utf-8?B?VE1LbDMxQlNPKytsNVV4Y1p1OE8wUUdYS3BQLzAwcS9xZlBuQkVvZkZSNDFF?=
 =?utf-8?B?Ym5sMUZ3cm51M3RSVS95VnpVTnpQWTZwUUpFcjJ6R3hQYVdFN1RzWnlhbjhz?=
 =?utf-8?B?QS9TQVRVRlNmWFFHTW41cnliV2lvaEtWTHpQRDJhWHJWcmN2N3FvSllpdjZH?=
 =?utf-8?B?VzFEcWVjKzRsaElnbFVHOW9HT1E2cDZSdDVZaUhHTi91N3B1cnVmUVZNa1Rs?=
 =?utf-8?B?TG91NDkrWitKdVUvR1hBSDlyN01xSTFvc0ZMemlpdFR3NkYzNzU3SzIzdmNX?=
 =?utf-8?B?WTF2WmIvQ2Fzdm5XZHYzL1JsWG9nN2lTa2djWEU1RFBuYXlTY2Y0RDBVK1Ew?=
 =?utf-8?B?cEVmS0xhZkUwZ0ZtNjQ1RGhMK1BXUGhraFBvbEFxL2xRY3ZTc1pBV2ZodkRL?=
 =?utf-8?B?QmdidzNTNlM3ajRFRWg5WTJFWnUyZk04VG13MmVmcmpUYnduOW9LWWthTjh0?=
 =?utf-8?B?Q2xjZ0hsNlM4aXJxM3V0OHRsaTVCU05od1V4WjA5MDlJMld1c05DTWZIOFZP?=
 =?utf-8?B?NXUveHpuM3E1NVNEcVJvZ0Y2NXAvN2ZBYmczZG51SjN6K0JWMm5sSkZQRE05?=
 =?utf-8?B?QmRocjB1RnJhQk5LVXBEQlBaVXZOdGx1YmRTc1YveVZFa24zaUYrT1ZuSkRE?=
 =?utf-8?B?eUZkanRHb3liaThsNnZKVFk0TE1kNmxJdkRLWW9ET1A1Y2RScGhhWUU1SzlL?=
 =?utf-8?B?YlJRQ2o2VkRaK2Q2TjF2QzQ3Ynp6aXFKV1c3M3hHbUROQkdNTDBUUlR5TCty?=
 =?utf-8?B?OTMzMmRFb0JVWlQ3b2hteHlTNU9YY0phQ00rZXVuTHliaU9vdDBiOUZ2VzZa?=
 =?utf-8?B?a3ZxdVp1OGFmYkdOMUVxSnIrS2NvWkUwL1ZGSHA2V29lQzdSZGM0cHFVOWhi?=
 =?utf-8?B?YzRMVU1oZmxBdWhQSmxOUWtwUGpyWEp5WGpYdzV1dEwrOEtMM0sweUNtNXZp?=
 =?utf-8?B?ZE05RUZUMm5RVDIveUNDRm9KR3IxajRhYkZMN2lFTm9kSktOMDNueVBrZHNo?=
 =?utf-8?B?SWYzKzNRcW50eDR3c0plOFd3SUdJVnY3U3FyU25CajBreFNqOFFzcXplYXB3?=
 =?utf-8?B?VnlUMVdzNWpqQkpOWE1abk9GYmlIUjBsS2xUbi9oNEdsNlZBemVleStGU2cr?=
 =?utf-8?B?WmtmbHlMdHljUG9FRmRwWllWWHV4bDVTVzNINjRsS3VzSkVNNkJlcFBQRzYw?=
 =?utf-8?B?UnpycWJxZFNya09hckhEZEFsQmdtQXo3TFpjajIwM3hoU2VvQVZndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d524d8d3-c8e2-4463-b8fa-08de8b90d42d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 23:38:48.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsqnz04qkR3YsEbGYpiPp916lQMfY9ng0QEdsUJ3LXt22w9gvcBzoHknVmP9a7+CxCLJiJq629OzBZD//Jf10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432



On 24/3/26 05:20, Jason Gunthorpe wrote:
> On Mon, Mar 16, 2026 at 04:19:30PM +1100, Alexey Kardashevskiy wrote:
> 
>> and btw this only works if the entity generating the MMIO reporting
>> offset (==TSM) knows about BARs sizes, which is not the case for AMD
>> - the FW has no access to the config space (so the HV needs to feed
>> this to the FW? may be). Thanks,
> 
> Then your platform just shouldn't use the mmio offset feature. Set it
> to 0 always.

pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:

"Each MMIO Range of the TDI is reported with the MMIO reporting offset added."

My english struggles here - can the above be interpreted as "Each reported MMIO Range ..."?

as if it is each (except msix), then I know where msix is and can amend the report inside the VM if msix is not locked. Thanks,


-- 
Alexey

