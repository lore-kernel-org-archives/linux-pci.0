Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE692C0323
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094980; cv=fail; b=Dauo27sTt27uvNNObDWShmTCvTQ3CwclGB6YOtAgVKYz6BJGV/EHVS5ixIBrxZkPD0q1pfXL95bNu831RG09+UY1l33p0+8EXLHj1Pg/xtoImlKdJ5JMcA42TXhj4NUuqJJ0jdJQ9yWhz9czjGk72qVxYiOZWq16uoPZ2/2Gtes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094980; c=relaxed/simple;
	bh=KzEQ5SqjUQwLUro0YVDcF/xvvmBQNKas5hOX1iD6x4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUMKurzO3clQlOKCuwuJMs/EyvaHmqJSrH3jIzp5r+fZsF9pXq09aukMM0oJr3jzbKpHe0+MFbJ32qxJrbzzFXE21VPzZ21/MoZDEp+BGRM5dQOc3hWQwiuPcrwMQ4iJOyrgnFtCeqsgtx4QjtcGE+9oL8ekGV0yKltyO6TuhgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WKVf9Rdl; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WKVf9Rdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8CmkDByK5HnQcu78NczMA42qDruF7zfvLKSFsqqoGwDaIPJm2JgbbfqQTBaMW4GiR0mIJ3YxXXuw8ynbrbj2qRUi6GmrECRmaA2I8vo4i8KbUwMRZlwF+N0xxMp69ENtM8aDG1SFNJyY9t15xFJ97Xcm0JwP3HRws5W1MH/Yv+/hxVS2sXZVx8qOuyfyitatT5Vdkhsd+hUGROHAN6fEBP9QmUfcmHLaA81TsuqMQbbQWzZu5bm9FXBLMrwxH26ujs1aWl1CvJhhpXJ+frkHLkLi6gT4UHBzx2xLXbyMd26IfX6SoehrCGDgQjIPsfDkm/KwQILtJTovxIeeYqTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNVZgffyNzptwV2RZoii+FEzPLjjjF1v4Xo/Wtrrbrc=;
 b=xl4j3+53S8VtLYVeHKsGpUHtU4CuXAHSwXx5NoxARDxqW5Jf8L3uch97wPlWZERD2+MtEfrFNyNfE60Pth5ZXpUYv4kbJpnp5oFjgthlyKFug+2Z7bXVALagk5bLsbH/8SQuIrOAnmvYVUhkjclMa/DFi+p/0GaxA6AUpquSZpcrw52BHRaUIkFkie+nPH3puhIC+SNi4nsoEMw7q64jKxvkX9M87ftpvd68NkmDQxOLJ2ZJQNmEM5Qpval8WcpwganGAFXBc28351ZNBGaOQBkMyevMj0ZGyyjI/nv8Zj3CzT4eRPDfZ1kx+wGIXCR0O/OgKTVAhWDdpOzfdYQfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNVZgffyNzptwV2RZoii+FEzPLjjjF1v4Xo/Wtrrbrc=;
 b=WKVf9RdlXfooXRcphM0gpLm3z8aUMHkWZ+cmUUkDs7EpZdPzXj13fKtuK2mv/nHwEYe4sp4W0/bfUzONEcsA+TaiBeEQxC1YgL16tw7zoq53rVbO+Jcf78eOYUeYXzrqU+fDMDdOnXr61MlnuOjuX8HWOe5GQ8sNRCl55DooS9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 19:16:13 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:16:13 +0000
Message-ID: <9cfc10f8-de54-4af9-8436-35ebeef4faf6@amd.com>
Date: Wed, 6 May 2026 14:16:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, "Mario Limonciello (AMD)" <superm1@kernel.org>,
 linux-pci@vger.kernel.org
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
 <afuAjeWepSkzO12O@wunner.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <afuAjeWepSkzO12O@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::28) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b7c247-90f5-4cf2-26fc-08deaba3f041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YpTOM/UUFsotjD+vbG0xh18QpN8GWLMuvbzWstk3zNRkr9Hkb2SeMeTJguYx4yNS2xBnOU/I10TY81AdWys7TYs04LSpoKCjtVXUgt+mForzo8rlIiPiQHK4K+yUgF1ATfPTBZAzQ4UrRF5wtqOXPDB4JuASdqD2AE2srrUGI0DiUUGn9BnrEyJ7qGPWY5t4J5cjVu7o7Vz8V1APKlb2x7CbqZcOHjYO4+clcSErLAWZYR4+jXFcNAJ/3VDGM/AdbIJV/vDhdNfREjjlHIQ0yLA4gX75GERR2MBRBbuP5nIzKd8jqXSosEn6kfbIP49bsSvT7KPRPb89omxL705SFPw+lyxVkJswZKTyZ0Xt9pM73wM369F6szNhrlQUm0pE1CpxsvgmSrWerzFdMrPKKfvHzkW1rtTseJG1qsWygzrIOaQzz4NUjHuRFMt6IQUjppP4NIO0wt4q6Smse8Mq7fTGfQlFEqFplb9p+Xzm7zrq+rs3+NIY2daCkpeblfefvWP987/8WlMamd/yG2tu525vwxOpVgi86Nwj6CosgFjYFX7pKFYPDu0j7KhOXG3CbgKUIlvG9e3kNb+pCB/hCIeNnzqG2wW4X+7c+rct+nDucQifKh/PLpAFHBcKy2/N7SzmRRNlLR7qCtv8UbJD0xafuldEnEulnuGJH5iI51S+yh9YZ/zTMbSwjvqceLyw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUpyRTJ3MzRvd3NBVFFRY0VhMFZZZEJaaWRaWDBnQmJmaGdCWTNCMmJnUG53?=
 =?utf-8?B?K1k2R05vbGtXNWNORXdPaDJNaTV0V1l4MGlGdExDeGl1RlBNRmh3N2tsWDRm?=
 =?utf-8?B?TzllK05STFMzK041a0tVZnhKZDNybENZd0R0UHVSYk1VM2ZkYlMyNHB1TzB1?=
 =?utf-8?B?c3ZsRmZhTVdJQjQrZ0xBSk8wRVVHcEJraEs1REhBVXlZVTN4OGdtdkJFL3ps?=
 =?utf-8?B?VXQzcGlyem5GMTY4N3V3c0syVXJFUjRhcS8rRzVTWGdZV1p5M0dubGNVTEJh?=
 =?utf-8?B?dXJnYXNFcmxqd2pSWG9jZE1iSHNPb0g2YjE0KzhYRW1iek51eDBOTHJtKzZx?=
 =?utf-8?B?T2pPUW9oVyszL1FwVGpJSjU5bElJcU9hT1pVeDNBV05YM1dwOHZ6b0tCY0gz?=
 =?utf-8?B?MHQwMmRzVEpaSDY4NmJhbXRwZDlpclI3eHlmbTZFWjFBOHUyanVYQ0J4QThZ?=
 =?utf-8?B?amdETVFxRXh4YzlzTDBwRmp2ZkMxaVkrUWUrRE5Ecithb1RycDd6SzA3KzFG?=
 =?utf-8?B?SlFMYnQ3RTZ5aGZVVjdLcERwVndmYkdnZFpSTnI4ekJjYmdGTGdmSll2bjhw?=
 =?utf-8?B?OXF3TURsZ0IrTWJQVm0rN0hsVmEwSUFkQlo5RENjZzJXbzIwUi9uVVFMUm9Y?=
 =?utf-8?B?anR6Qm1KRkdaeWZGV0VJck9QV0sxSjBObGZZeEhoQ1hnWW5UYzRiYmxzZSt6?=
 =?utf-8?B?ejRVRk0rUnk1bXVFZ0s1NUVISmswUWJGNWs3ZU1STVBQeUN0dDVaNlpJTDA4?=
 =?utf-8?B?dnU2WTJldUxic0tBaURWTGc5UkFKOS96Q1kyTDl1SGVQUExXZTFUVzBGOFJV?=
 =?utf-8?B?TmhOS3k5aTZTTnI1allMZHZoaFdLUFhRSlJSOGM4cFhKMzlZVzFhS0wvSklt?=
 =?utf-8?B?NHVsVFhERjVMQWdCaloxVnpIblJDTFNMVGFPckJLR3lSLytXT3BFM0RWSDBC?=
 =?utf-8?B?Mk5hVys0V2FDZXZDcTJlWWRZblBkQzVHaTdZeHh3K0ROR0hycnRhT01MUkxl?=
 =?utf-8?B?YnZhT2FSRzhiUVpvc2lLd29GSlNQQjVYVzQwK3NHRVZJc20vMVZ6Tm5wMUVk?=
 =?utf-8?B?WDlraktDMlRKT1lLMjY1OXhRSS85cmNDbmNpZE96aDRBeUVlRk5Ucm41VEl0?=
 =?utf-8?B?WU1SUm52UUFqK1loNjhLMkVSdytiSzAzR2dySzdCQVlEK0FaNG1vWVM4UGIv?=
 =?utf-8?B?L2lVRVcwOFZnOVBremhXSEFPK08zV1NramdpRW0vUlJFYWV2RTg4UFVyMk5I?=
 =?utf-8?B?R3JzRWx6OUQxWnJVS3RjM1Qwdll6a2JDdnk4SUg1ajFNU29CZEJyUmx4ZGc0?=
 =?utf-8?B?ZHpuaHZLQk9hb3RIQitiNkZqNEI1c2RrQXg2YkY3ZkE3WUkrL09DL1h3emxq?=
 =?utf-8?B?TWpZbUw4VGUveWNqdVJhWFkyR2lURW5NUktNUGRJL0w2R1lrQURtekRFd0FB?=
 =?utf-8?B?RFJ1Qnp1cTNSTTFrYUdHVU5uNkZ6ZmRYL1BFVDhkR0VPZ3c2Z2NaaFZXNVZG?=
 =?utf-8?B?NUZWZFpSaTF1Wk1iV01mbUlWcVEwWFp1b0lzQ3hMQ0tFa21aNlhzSmZHRHE0?=
 =?utf-8?B?b0NEclVkSzJrQk5TenZQMk45WWl5YUxMNXJHS2xtejJpd2xKWUNtY3hTWkhI?=
 =?utf-8?B?bHpyRWQ1SnVVTU1OaEhKTEQ4QUQ5Si9LUHo4UXRmdHozN1RtZUprNnQ5SjlE?=
 =?utf-8?B?RHBoMWVPRjNJUDJoYkRWc3pJZ0I1SHl0Y2pQaDUzdTlZeWpYQ2RaYWJIVko1?=
 =?utf-8?B?c21temw5R3ozdDFicjBHd0tKOG1uc0hNN0gyRFRBNE8vTE0xWU9Eb0o4TytY?=
 =?utf-8?B?aFhtbExjRzhySVhjdlliNTdQejhLcjNMZVBabFdYNXo5bkxQT3BUa0FRTlNy?=
 =?utf-8?B?YzJmdmh2bmNLWmFSdkVxZCs5VUZZL0xmWFZqUWtROWUzNEpFKzU1ZmtDampp?=
 =?utf-8?B?SEIyZERoQ0tlczhzVWpQTDFkR21hZHNta0RjTXdNR1pldllVLzJCMVBmcUVh?=
 =?utf-8?B?d3FDcFJJVG5BWDBnUlp6dE4yYi8xRkUxMkJPRDB5Q2tvaTAranZnRCtFdkNo?=
 =?utf-8?B?c0s3ek9zLzRsdjcwcGMySjRZVytTeWgzTm1pUDdsdDd3cEs1YlJtVmxZRVEv?=
 =?utf-8?B?ditiS3RZRzljeEJhQi81VEhoNkcyaFgxaUloNWY3b2tySVc3Y1RQckthb0tH?=
 =?utf-8?B?RHREZkJCZThiWmtTWC9aOEJ2UFM4TjVudElSNldONWc5dFIxbDgwN21ocENi?=
 =?utf-8?B?MHN2WG9XekJXOVVHNGh4TWtZS3E4Rkx5NVdoeDd2S2x6NS8xYlV0cmp4K0Fp?=
 =?utf-8?Q?k0zseTnM+zy17G3mJh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b7c247-90f5-4cf2-26fc-08deaba3f041
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 19:16:13.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rL3nogtdX5z31ArDllOVUnaSxNVDi8Oa3nc9q30pLdZFDJKjca+Lifx1L4gcOZQVOv6hz5JZnJ2wtSkw52epA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279



On 5/6/26 12:55, Lukas Wunner wrote:
> On Wed, May 06, 2026 at 11:43:50AM -0500, Mario Limonciello wrote:
>> When a hotplug slot is removed, pciehp still leaves both the slot and link
>> active. If a device is still physically connected, platform firmware
>> may continue to poll the link. On some systems with Thunderbolt 3 devices
>> connected this prevents the system from shutting down until the device is
>> disconnected.
> 
> "On some systems" is a little vague.  Which ones?  What is platform firmware
> doing there exactly, is this something in AML?

In this case it was a Strix Halo OEM design that I don't have visiblity 
a layer lower.

But issue is specific to Thunderbolt 3 devices, doesn't happen with USB4 
devices with an active PCIe tunnel for some reason.

This doesn't reproduce on the reference designs we tried.

I /might/ be able to get some traces though from a USB4 analyzer with 
OEM design.

> 
>> To fix this add code to pciehp_power_off_slot() to reverse the init
>> sequence from pciehp_power_on_slot() (power on, then enable link becomes
>> disable link, then power off).
> 
> Unfortunately it's not as easy as that.  You're essentially reverting
> commit b1811d2455f3 ("PCI: pciehp: Don't disable the link permanently
> during removal"), so you'll regress those products for which the commit
> deliberately removed link disablement on slot poweroff.

Thanks for that pointer.  Unfortuantely the Link: tag for the discussion 
is HTTP 403.

> 
> Moreover there are products where Presence Detect is hardwired to zero,
> see commit 80696f991424 ("PCI: pciehp: Tolerate Presence Detect hardwired
> to zero").  So we have to rely on a link change to detect that a new device
> has been plugged in after slot poweroff.  That won't work if the link is
> disabled.
> 

How would you feel about turning off link detect somewhere specific to 
the shutdown path?
