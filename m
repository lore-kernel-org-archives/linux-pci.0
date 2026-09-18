Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14C2E22B5;
	Fri, 18 Sep 2026 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722465; cv=fail; b=cyz1r9WlMjIhe2xYK3i7F5E8eMCyc2HmfmYrWE09S+dWRBdfygL8qsQynWYOvL8qKir8RaRc5Uazvk9SqvowojanAMbVuYi9BAUuA66FstUJmKIrpmAVkV1egx9pNMVLlWPkoZo9JHsg/Hgg2UgU+PA1pPVzccIUujPJC3V0LC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722465; c=relaxed/simple;
	bh=Rq/WsLnZXkWnZP9Wgz0WInZMyHJpxRDd5SAnhSJvTXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Py0hEL/WTGfCCLflDjoi9AtnZsJps5d9aTDVwJkZZAohvGeGGZX/eE8qaro84c77qN5rb3bE0YzWyPAH2yh3ePZWBTWA1Dc5ziyHlLDFa6x+5IzbATXdDZD7Ny6fYQ1Urw3T8ZWKq8RHyI2jDkAXQL4jn7HFtaxPuOBc2M2W6wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0NVp5c+t; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0NVp5c+t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKhIlnNa7mj8OloX3Wn+Q5TH2BPEU0RQysWf5Y2S296GBo4XeqlbVw3J1bXAzGArOnHcOCTs8BE/7gz+hxIO4Kc1B+q8ea4QUnMj3PqGIODlefgsOBUx2vJJv9ZNNaiLmY0X5py0fhlpWdNV25XIAS34iyU9EGJQokgRk1/oeENFRJcOMIXj9SVgq/kqmdu5l8mXdtobJiXN4M/Vd6dI4JTMZiwuw7j1PlC8WsnJ4NNTF7R9caW+ClEplsjnNg8Kot+XXfOcqkvFQwkYOr52I5Q9YJMRlEeLtyKYm0kcMcaZZek/xXej1//IcNbgcyF3GQddhdTPQTEV3bR+CZXjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w12Np2BqT4smMEhOqtc2J9uSSjgZbszA1naVqLbI5pY=;
 b=QmYTj7maUhZetOTf43hyMbrp572eoujdSYhRIS+L4z9FHB6YMNlK5qL3GyCfeJH9UwmQTHV7qOWXLaTslNE/XLICqJnPFR5//1r0iu5ccZAp6hNpnioLz3MY1YAXU57hGhV6HdpsE6/Rj5NE+4HIP5dA8iBtvShexKzj3xJKG/upbftWxprncyLn6t/iXRZQBkH7gG1TSnssGR044f/6MAwJ1qQZQXgiSStEAELumMLfDZbYJKg6gU8HpEkiolCWyo/2uRyFgz8ks/XfTGmWHSy7cnzlGz3K9Hoi+nWGTQ2PT3Y2CRYjpyAX8RT9ebONbQUKd7DbNufi3DLYN1ZJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w12Np2BqT4smMEhOqtc2J9uSSjgZbszA1naVqLbI5pY=;
 b=0NVp5c+t/R34HpbJSQHqk4vtyMoOp/ogMgoEgGOjO2FsPO8z3FvXhkNkYdakvSFyvy0Gv7lPVz0tv9vonwvgPDxhPl7Osj8s+rctRi/gf39GMLGRhO4h7NLXz/kmubQfcOezF4UnVk0kBHvuS555O0Of4R6ZJsxKR/mNsS625C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:07:38 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:07:38 +0000
Message-ID: <97aa96e8-b553-47a2-aeea-e5d830ab0184@amd.com>
Date: Fri, 18 Sep 2026 11:07:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Nikola Prica <nikprica@amd.com>,
 bhelgaas@google.com, Niklas Schnelle <schnelle@linux.ibm.com>,
 Alexander Schmidt <alexs@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
 jim.chow@broadcom.com, matthew.mcclure@broadcom.com
References: <20260903121217.23F751F000E9@smtp.kernel.org>
 <20260907161701.454364-1-nikprica@amd.com>
 <85a220af90568124bd4e7d354a8741b612955595.camel@linux.ibm.com>
 <2631bfe3-7123-4f44-b34e-8fd697c7dd2e@amd.com>
Content-Language: en-US
From: "Prica, Nikola" <nikola.prica@amd.com>
In-Reply-To: <2631bfe3-7123-4f44-b34e-8fd697c7dd2e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To DSWPR12MB999127.namprd12.prod.outlook.com
 (2603:10b6:8:36c::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSWPR12MB999127:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 97154434-7939-437f-1dfe-08df15644934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W6Zvg9XEAu9OQcRSQ0R/Qkvk2zFmH1I+jFIlGFYvlyqYTdC7/CyBL7BKcSwqRlzT2YQyS+N/NIVsMjKACq0Gm/SDTOQNnqGDVfoqz8EMI6Xfa2lRkuHDVjACtvDz54vz50BBHT1CVNzCAa0hSQXerEK6+lZgWMC+OUbnyDI3jAi76ImeJj/tlxKJEYBbjYZJqZxw9FpyEXQOnhDhRjRMh2/upAetiR8vK/xPEiVYqIvmaead+nz6bOkYzd88xQAm+biP/esY91I5UWBo1xLkiUDH31CqTO+mwKcblfK37IrVZjVfuVxTRmx/+d6pesue+rS42t10GI3BoOc54EYEW95EQKMakt73UoUKFXWQ20GvEfqQviVVsPNqN3Ciq8PuEumckBI68rIIrjouAcl7lYKeda1VvA5ZXF4EH+NcKjJA+qtKY6tuC/Jk9UT4dWhakQbtbngMnfc6OY2HUc8rc9c3bMPwy8KiomVAyRzN3soenyBmyAAgVGQ47whRZCyzaySroPpw+t6yWWK2t4B7QCylSEEw6LcG1JST845Uyeofgx+XLGKB/bgHeyrs1KYogO1UD8zmG6CvXNGpIAc7PeURdHWB5m7zXUrVYvgyBP9iNqNWtPexKhTwLVt0MWvVhF25GgEbTWYt7eiKe2I9Tw4uQc7Kap6Biy8WPIvXpM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR12MB999127.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnBUQXA1Y2xtVTR0bXhoSTM0MXRGVDNwSDc3WU04eXBrVEJ5Qk5tNTZ3ZTFU?=
 =?utf-8?B?N3ExanVqL3JrSmtpSm81eW0rNGlqamtEY1hoczhsR3BJMUljaWdwbjZUYXZv?=
 =?utf-8?B?eHExTXpLYURBNGJOVElISW90MUVSYk9PcWozMHZLL1k5Nm9NeHI3c21neTFt?=
 =?utf-8?B?V1pCRGM4RTQ2VDRQZVU1YUJxSEI0cExCc0NHNm1vcFd0aDVQbFJJbjZlQmty?=
 =?utf-8?B?SmVqTEppUldNRjVpWmozQVdlOUdqOFpmOEZKUXFZcEFLQ3kxQ2RydHdja2tP?=
 =?utf-8?B?YUI5YWI5QkRKdzNvaFFPWS9ISlkyenZqQ0ltMzVxMCtDcWVCdzdRNUJWdmxU?=
 =?utf-8?B?eEJjcXBOL1FmYzZzVVZobkZDaFpPdmpJNFR3VWFYYnpzM29uc1cxT2tUYnNF?=
 =?utf-8?B?b1d5YklHMjdabW1TNE1mT2pXN2htZnU0VFNIQm1MV3dWZ2NRNXlFTWJVNmtE?=
 =?utf-8?B?b3YxVnZpbU52M0ZvK2JWUnh4VXR6ZGJIeVc4NE1ZN1dsMk5ka0pwd3BjWHZI?=
 =?utf-8?B?c1IxMUk3MURHOEZvNjVOOHNuWUI2bmlzSGMzSlI1OEYxdk0xcm5ZTUZxMkhi?=
 =?utf-8?B?RXJRVnorSzJOem5CVysxUjRkVHJQMGs0cUtzalJpaWswOFJpZzBTNjhSMkdH?=
 =?utf-8?B?Umgzbk5VMjFUanZsK2h0SXZSOU1NOHhScWtjenBvRlRTUTRMM0ZsdHpDR1pI?=
 =?utf-8?B?Nm1hMDFXcGUwTTJaV05JYmo2Y1c5aUNKRk5OTnFNczhWcldST0E0MkJhcDhu?=
 =?utf-8?B?Um01VHFJcDVEUnRpek1uS1hmeGVBcEFUR3EwMWFGTVJ1QWVMR2ZyTkZRN2d5?=
 =?utf-8?B?MVdwNkQxTEYrdFBHY1ZvaHk1aHp4eXhra0VzWXdPMTNJWlRJaXpyUC8vb1NV?=
 =?utf-8?B?NHh0K2dsY2RDaDl3VDl1N2pCd1pqQkppdUNIUUpVY0MyeVQ5K044ZEI4V2Jo?=
 =?utf-8?B?bFh0Z3NLcnU3MXhUTnJwdFJMdnJwV1V3VVBLRktZUjUzUmlXTVNNZWNKekg5?=
 =?utf-8?B?bkpSUi92V2FSY2NQSjh6UFU1RGUrZEhiRG8zdjAxV1pMK3dpaFhnckdvNlNu?=
 =?utf-8?B?L2ZTMk54enhqZEtkMm83VFdWL2xDd2w3ZDU0dEs5Rzd3MTNybUdLNXB6bFAy?=
 =?utf-8?B?RVNJMzJyZks2Z21vVkd3UHl6dVZ4SjZQaFp0SlI5d2hUdGI5WHNnR1NTK2pZ?=
 =?utf-8?B?K3ZDZHVrQXZ0UTB6R05xZTZ6anZ4WlZUUWI2TkVsaitLVUJMR01jUTlYSkdo?=
 =?utf-8?B?REFwQ0p0OC9lRjFsc2pnanl1OFhXSmNDR2tCeWNpdVQ1NTNrakhHSy9WWlRu?=
 =?utf-8?B?RFNTVVVwajdDcWRQdEt3elRFa3MyUG03T3BjbU44cDdqNklmek1pTDJ5Z3B6?=
 =?utf-8?B?TUpDc3RPTXBwRzJpYTZjbTdUMDYzd2tSMk5HaGlpd2VOWDRqOVJlbStwUlRB?=
 =?utf-8?B?OWxzbFVmU3JMRFk0M0xmSndYWm9kV0ZKS0IzUi9NYmVkOTV2ZVlQcldrY2xx?=
 =?utf-8?B?ekVJQmhNSjFJdmpXT2tMNThjc0JmbFZJUVVHbi92ajFOV0ZFS3c4TVppZHVJ?=
 =?utf-8?B?ZGExRkxSTXhhOFhVOEkyRDNRc24yU203MTJGZ05vaWt5ZHUvS0ZxSHd2bFhr?=
 =?utf-8?B?SmY4SmR5TmgzRHE4cEgxaVRqbnF5c2dlQ2ZiOFdhZEVpOTVhSUpNWWwwMlNH?=
 =?utf-8?B?OWZTV2tWRkRtdWhUZlRLbWtRRE9uT2RtRmlha2dqVFJTNTZ0elA1VTlBMHJQ?=
 =?utf-8?B?YXVJb2xrWFg1M3Zhbm9KVVNQc04xeTN4Y1QxeUlpVTdMWmlRYWZLNExsZWxu?=
 =?utf-8?B?R2xmR0ZSUk9BSmpremY3bUIwbUkzbU4xQW94dXVSY2VPaTErc0NQN1h4VXBL?=
 =?utf-8?B?VWNBaGxJUktlaHdIVnF3VjNNb2NNbFNLUkFmbTlma0pHQWRzZlNRbFQyc0JE?=
 =?utf-8?B?N0NZMUdlYWdtOFc1NEsvVlhkNDlHTDVYa1VXeUNuc3NRMnRSNGNodlJMRExO?=
 =?utf-8?B?RGZrRi9hdGxOcVBaSitLaHBVWk9waThhZytzN213dFZHamhVV2U2bWFxZFNk?=
 =?utf-8?B?S29VMG52ZU1vOXRhTnJjcWRTcFp5RkRPNncycytMSExsZkIxS3F2S09JMHQ1?=
 =?utf-8?B?dVFkSHlsMFAwcGhzYnd1b05sVCsvbHpPUkJlQXo5eE1HWW9jaXoxdnVHRDNy?=
 =?utf-8?B?TEpHakhudDUwQmQwTjRLZENBSkxibys5WGZNWkZTTi9HM1NTc2hJL0pNb2dK?=
 =?utf-8?B?eC9LaS90clhsblJMRHNXUHQwNXR0K0FiM0dxVERlUTYzbVUvTjdGaUNnQU0v?=
 =?utf-8?Q?D7MrSAahtq3LOzjPBz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97154434-7939-437f-1dfe-08df15644934
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:07:38.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0WOFw8RGHL2faL4zeAzE8Yo2gX4Tns42XxTfUJU0UOR9Ysab6haYHeV8dYhsPgGgvaIonP6Ywuzif9ACs9J7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

Hi Christian, Gerd,

Yes, this fixes a recent regression that we recognized with 6.8.0-135-generic kernel release. And it is the commit that Gerd referenced. I'll add Fixes tag.

Thanks for your attention and help!

Regards,
Nikola

On 9/14/2026 3:54 PM, Christian König wrote:
> On 9/14/26 15:41, Gerd Bayer wrote:
>>
>> On Mon, 2026-09-07 at 18:17 +0200, Nikola Prica wrote:
>>> From: Nikola Prica <nikola.prica@amd.com>
>>>
>>> pci_enable_atomic_ops_to_root() currently fails when no root port is
>>> visible. That is common in passthrough guests (ESXi, Hyper-V): the
>>> endpoint is assigned to the VM, but the guest topology has no root
>>> port above it.
>>>
>>> In those setups the hypervisor may already have enabled AtomicOp
>>> requester enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
>>> treat AtomicOps as already enabled and return success instead of
>>> failing the Root Port walk.
>>
>> Hi Nikola,
>>
>> your patch got me interested, since it touches those parts of
>> pci_enable_atomic_ops_to_root() that commit 1ae8c4ce1570 ("PCI: Enable
>> AtomicOps only if Root Port supports them") has modified.
>>
>> I like your solution for putting the hypervisor in control of the
>> enablement of Atomic Ops on root-less PCI functions and did test your
>> change on s390/Connect-X, successfully.
>>
>>> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
>>
>> If that commit of mine regressed your use-cases, you might even want to
>> add a Fixes: tag?
> 
> Oh, that's an interesting point. I wasn't aware that the root complex check was added so recently.
> 
> So indeed question @Nikola did that worked out of the box before kernel 7.1? If yes then that would be a regression.
> 
> Regards,
> Christian.
> 
>>
>>> ---
>>> Changes in v2:
>>> - Be more strict and only apply logic in headless device case.
>>>
>>>   drivers/pci/pci.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index b2879a6be5f8..62729ade496f 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>>        }
>>>
>>>        root = pcie_find_root_port(dev);
>>> -     if (!root)
>>> +     if (!root) {
>>> +             /*
>>> +              * A hypervisor may expose a headless topology with no
>>> +              * visible root port.  If it has already set AtomicOp
>>> +              * Requester Enable, there is nothing more to do.
>>> +              */
>>> +             pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>>> +             if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>>> +                     return 0;
>>> +
>>>                return -EINVAL;
>>> +     }
>>>
>>>        pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>>        if ((cap & cap_mask) != cap_mask)
>>
>> At any rate, feel free to add my
>>
>> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
>> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
> 

