Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C77221FBB
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778130192; cv=fail; b=IRz+VLV0KBt84jdaELKqOF9dwqChpyLYF5//Eh5WPmhIFn1XzS9lS92HClqWpRZXUb5I6+bri5vK+yIT+ggQh6X8yR3Ri7QGL9aOt8w/q5UpNGLw6qlpyxTrnZb0OajMf6e/NoCEPCq1jGgpR+fYPnnzNQ8kmvswMdXReSjBMHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778130192; c=relaxed/simple;
	bh=2FFI101v+gWcQ2e4ljB7HyCMCw6Gqu5ggVULPtfIC3M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ESMNdV/6zh2v420oadQWoJxEPEHtwWkjzZ84EP4eHX5Hoe4ZhcUrb33a37ks4aCY5ZH6uwGNqSCgncvlvJlZxXxOqkg3bSur45An1iBk5isozO2dEzlynDl0x3fw3SQ9CTi7CBTgNCsvFXKiWSsagM/rnuI5dpYo1zG+3unhGeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HNKtVFZl; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HNKtVFZl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viNL54CMtA/B9aUJi/SGV34fVYuK0O3q1wnsUfkAqfy/rvz/iCM8ImUfpmgmGBQNpNCuZOusOI+Q1OhqDWC1nzMsC3mZu1fr/qiy/dWkQHebIzgkwXmxSjDawNHL5QlZTyuI7YW7ba0fCD96qG41DRySqo9fZQYKiH6TBbI48HBgwIUI1KEnM8rhDkwjgH2vDwkpumHwS1cKt/SMaw4e0gsGyTxkgdX/uCDI8wgg9qzuaSdIryUl7hxER2+dbhS7d13TiqGkSgOL9jdVblC/WviRVxPx7wkbO8AM/khPnbWDGV0l5BuOqh3TbK89gjKO3Xxd3ABSfjsrH7mnR5HCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx6VVyBN3WO4If97PLn6XghpDK5hgePGHrCjERrOMCg=;
 b=vFfFfvipT57ebtiGU1Z7WpKySH0J+SxwUIDFpcMAMn4wePTJn8VBEnJiOmO97lzUJ2KBCwv3H1bNHNZFIpfdd3CCQ74qogA/nSAOUF/y/rj7axZN+NRDbhi0Zk2CFcZWOOLxXBNK+Nipn/Zm2Lg34BhIpv5L8eFoiIzD4PSzsKIdJTkNbkVrLk6TNGtZ24EwdLXvgxZzrkhZZdlxr2m8dHxjj6kHjYbIjjJNt2j9tuEUNGJVRpJrBQS05mowb8VGFZrbzHIfCYdrT1Ui+97r6Cs5WhI93pZrZHGOIX0RlrZmm+ZWaO8fmM9PpDBGsLts+79EpNMLFf/y8uY+aiCcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx6VVyBN3WO4If97PLn6XghpDK5hgePGHrCjERrOMCg=;
 b=HNKtVFZl1Id6p/BJPxAg/ir+oNaVq8qozqjktRPJl3n9qh69YKF6dDlteLWGXWu3oH6B/HynQFhAMU4sN30FxidlU8ARCu8rDUPQI07EWnp6/VD6YtDNpLhcx3avxWk7Zgg3gZQqD9iUZo1wccvpEMQ1kjWUT++B0QEW6kriUhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 05:03:08 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 05:03:08 +0000
Message-ID: <8a7cf3f6-07e4-4d12-a2ac-72de02a03eb9@amd.com>
Date: Thu, 7 May 2026 00:03:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, "Mario Limonciello (AMD)" <superm1@kernel.org>,
 linux-pci@vger.kernel.org
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
 <afuAjeWepSkzO12O@wunner.de> <9cfc10f8-de54-4af9-8436-35ebeef4faf6@amd.com>
 <afwUkP1P-HNfMulV@wunner.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <afwUkP1P-HNfMulV@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:806:22::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 055eb7da-24ea-4ed4-49c4-08deabf5ee3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X3WB742v4IKXc2I/IHRRzLn6KRcj05INBSG7TLGkVuoawk1l4ziOP7kgegwxB+iwtx31ddc23fYwK5SnWODTu7z8r3G0pl0ayE3/YU/xsYHty2kmm7ZTTG9fIX889084v0eyeG6KnGhnbMPY/S9V2dFkLdA0MMfI8GyBpP2ZFk3ouxSRFKS4F8P8ReH7W5WnzT7fpoI0JMAtwV38IMS/xnam4nGLS/DCVNGj+pCzHi26lnBZi70Io/tQmYmPN/nqsziTWPeuFWT6awbXFOlxohvvNykwuQm+GRt4teEb27H4EWhdCNUL+wNl96RzhkW3cJ3kxz91/uV8DoyleqXAjU1JZJIm3RvJFn00tvZjNtcUsgearchiC6A5W+kq9miWZVHKqg8ehD4zhRKLI21Wg8ps5SyZiHyQOxD0K+F+OmrTn+AYxQ9715UQOl4xO9rooeWqVDkz4roOvqZTfBIVgG9oCrGTOtDnBSewPoUdeAy9TTdx6ez081eI1Knt6AUJnROfp4n0ZP5g6/Jukp34uhW8ytw9jrFtoS0DKpqpo0Jt8K6YNDuQE6At8Wr78r65TaSm0TWig027zqjLSGoVWVvRHKun6nDauvhYo0PkV64fX7qYSfBJTlu2aAUYaUer+0YqiWi/uclLlUR2ZpPBXymfghpZQS1bjDRv0addjIid9CLcx0yyUE0BuMnbBak6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRMdTNucytVTGJRRHlBK3duRzhCcXk5azlTb2x3WHE2KzFnVlQvMkNzdnNG?=
 =?utf-8?B?d01aWDc4TEMrM3dKWG1SYThjTWJwclI0Skd1VHhpSzh2b2NmTTJRWGtocTVm?=
 =?utf-8?B?VUpwVVgzOG1paGtrSkxjYXNGTHFUUzV0MTRUWm1JcEhhOHp3bUNBazUveHZt?=
 =?utf-8?B?M2ZpQjBSNmVNUFM3WjUydWlEQW92bnJORFc2KzZLbStCUlRHNTRYMGRML2pt?=
 =?utf-8?B?MGxiNWNBUkdsZ2lnN0NIQXkwY2psUWFuQW9aSXpuSDFZaWp6RXNkZlppVUla?=
 =?utf-8?B?VXJUTHdlSHNOOXJOYTdOcnRoMFE1Ym5PSXFNclVaaDVtWG5pR1pvOVc2VWhK?=
 =?utf-8?B?ZWJHdUpxazJlSUJCL0RRSzNQSWt5cXk0WG9xd0xTZm80QTdBUzdUZEM0SXBL?=
 =?utf-8?B?UTl6bjZTYm1nVmJqS04zNVpjVVM0LzhiRlY2a3BEQ2NpY2lsRE5PeWdoKzFq?=
 =?utf-8?B?Mys5Wm1XQVAwQ0prQzFoRGRUV1dxczg4eWpONkhCTTcvNjhDb2tqQXJaOGtJ?=
 =?utf-8?B?VXdrM0VXSDBqclZhUVB4K1FJQzFvZERBRG1lM25QVTlkTEtFZzhFak9NVmVQ?=
 =?utf-8?B?YzVBeldxTWdrTWd3b283a2dKTEhtRlAvcE5UUlJDcnlmYWhWTEpyNzRzNVpY?=
 =?utf-8?B?WUZhTk81VTJETUdrVEpKZXpSNG84Uml1V045WlpHeG44d2htMzlJWmdlWlcy?=
 =?utf-8?B?cXJZTWtncTc0U0dUZzdhT0hoVlk0TVhhRGVsSnovaWg2MGxicEZMaWNOcWJK?=
 =?utf-8?B?MFl3aXZiREZPWlYreWl2a21ycGg3UEsrdGo1RW0zZncwNWRXem5YZ1FPZStG?=
 =?utf-8?B?azMxZkRJbDE4aC9kTUt5aTZPVTJuK1dNa09YWDllSSthbDdJL1JYNktrUWFN?=
 =?utf-8?B?bjVWWkI4WWtCUEVRaHFzcENXaUxlOWJLS3lROU9sOTQxSDZpcytOc0dQZGhn?=
 =?utf-8?B?RUZkTjVIL0NiK0pheGlZa25vOHZENnpTMXR2MjE5UkJBZ2JOa0ZZQjRWUEpp?=
 =?utf-8?B?Rms2dzRJM3BPc1ZNT2ZYbUZmQkJwOUd3cFcwNU11aG1IcmQzMlZ4dlBNWDdQ?=
 =?utf-8?B?Y1FWczJQaVpOWSsxNWZ0YkJwQUhwc2JtM1FVWWs1a2FXQ1JvSHdxMXV6ck1u?=
 =?utf-8?B?Vi9UTzdzTEVpTWN2dGM2akhyZmtjeFV0Sy9ub0w2ZGhqQ3VpYUNlSVEvVUlD?=
 =?utf-8?B?TGF1eThsSTFvcVoyZVM2U2FmMnBwZXVva1BkSWRGV1BSMEpSQlVTdnBCMW93?=
 =?utf-8?B?bmpSaU1mVVlWVEtjZGNsd0t4SFUyMW8rdWFsNEdYY3l1NGsza2F5VURGQXJR?=
 =?utf-8?B?NVYyVFpRQ29TMWg5VVl3TGhRa0g0cG40cmFvTmROWm5XazdGTzNIUHlnSlJt?=
 =?utf-8?B?Sk9TUkgzeC9FdWdHSGZmMW01M0FiSmZyLzFJU0FZeWZ3R1ZhMnFpM0ZiVDUz?=
 =?utf-8?B?RDdJUXN3bWJLYk1Sd3g0QWFndllPTGNCRmRxN0JNQ1hhbjBRc3NZeHlnMk9h?=
 =?utf-8?B?WGFxSEYxYktKaENVTURvV05rQzlMUi9NbTByRVFZaG03UC9uSUE0aGRMQ25t?=
 =?utf-8?B?VGtLM0lZamZ0dm1BcmtIVWxvc1BVN05QSVM3eFYxWnRoSjYxSk9NdEVvYmtW?=
 =?utf-8?B?Vlc3MTE0R2htOW5MMjdoVGhPQnB2cDRlRmhtOFQyWHZGV0hBZ1V1Y2Y5TWdy?=
 =?utf-8?B?Z2EzdFpLeTRQaVdVU2tZK3NFSytiOHUxcU9XSEtFSTY3aVIxcVBuTGlFRy9i?=
 =?utf-8?B?cEJHM01Ud0IrckkyWmhJUVNTMTFodjA1eS9rdm9UM202LzZqVkJ2M0M3cmd5?=
 =?utf-8?B?bXozTkl5NnpMYUp5eVVxOW13ZDIzV0QyNklrRDMvVXRtTzBVRGk0ZHorUU45?=
 =?utf-8?B?VkFWZUJud2oyV2p6dXBPS2RtZmtLSWpaVGlvdXc5V1d4TTdmMUowc09WMkxS?=
 =?utf-8?B?YVlFQWFLUGYyZ2l5eEMzMmtkNHZlZWY5MEt2cE1IaCswKzVLendaVjZyNUtV?=
 =?utf-8?B?R3ZFV3VLdjFRQkNVSW9ZOVpLalh1czZtbjRuNVE3bjAxVjFySXp4RmMvL2Zk?=
 =?utf-8?B?Z2pNZWpob2NTRm5NanVUbWxtN3F3eitCYk9jVGhLTFVFSU1ZbFB2QXlOeVZ5?=
 =?utf-8?B?MzZmNHorZFRxWWd2VHpOcTVUZlF1c2hsdG9xL2k5RXBXMk8vY0ZqYm9zVlZ6?=
 =?utf-8?B?Q3VsejY2QTVyc3JnSkRtaCtFUGl0dm1vMDFJMk1GYWFnc2VCRGJqZFZISTlZ?=
 =?utf-8?B?TXBuYS9uSnFReE9YcUZ3ejBDdjhkZ0xGK1diWk4yYWRjS1phb2dITmRITEZW?=
 =?utf-8?B?dGZEK3hhaU9NNG9SMFp3d0lGRVVrSHNDZVhTOEV6YXRqUmtiMityZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055eb7da-24ea-4ed4-49c4-08deabf5ee3b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 05:03:08.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpxDFWhie6mHpLG4q40dGIPzpF8APGsVFGjwFtcAnxR4UeAmJHg+j3B2pwB8vaNFxQxAoJL2Y46M8uQrukDB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967



On 5/6/26 23:26, Lukas Wunner wrote:
> On Wed, May 06, 2026 at 02:16:10PM -0500, Mario Limonciello wrote:
>> On 5/6/26 12:55, Lukas Wunner wrote:
>>> Moreover there are products where Presence Detect is hardwired to zero,
>>> see commit 80696f991424 ("PCI: pciehp: Tolerate Presence Detect hardwired
>>> to zero").  So we have to rely on a link change to detect that a new device
>>> has been plugged in after slot poweroff.  That won't work if the link is
>>> disabled.
>>
>> How would you feel about turning off link detect somewhere specific to the
>> shutdown path?
> 
> I *think* shutdown is performed bottom-up in the hierarchy and so
> this might work.  But it's not great to introduce such a change
> for everyone just because a single product needs it.  

Generally speaking I'm not a fan of Linux changing hardware state and 
not cleaning up after itself at shutdown.  This can lead to weird 
behaviors for power consumption, wakeups, or inconsistent init across a 
kexec vs warm reboot vs cold reboot (that BIOS had a chance to swing 
it's hammer).

> It would
> be better to root-cause the issue.  

I'll see if we can figure out what's happening with traces on a USB 
analyzer.  But FWIW it's a Linux only issue :/

> Maybe the vendor is able to
> provide a BIOS update which resolves it?
> 

Given it's Linux only issue; unlikely.
