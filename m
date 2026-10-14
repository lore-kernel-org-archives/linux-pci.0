Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89230DECE;
	Wed, 14 Oct 2026 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945723; cv=fail; b=F9bM/1IYJ3+48H/TwGHz3wfdHy7L0s7Ko+TTg01zEGrRjRKNXRMuicDvl3VUXxQrJCVzlL91ZwKFQIDWyamOgR+C7zPWu1sCSBgbKwum36JylbJ+986sLlx9PyPQS+OuEUlnawjsspQR52cgmVOPDET1qVYMkiB1sFoCNCSXG90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945723; c=relaxed/simple;
	bh=jlHeyjtCyRHjNjgZ6/P3Q2hK6PZ/2YlwYmFax+RVP/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P4YzR8p3a2qlXASa3YGvruVv0igTVZnTACAgZgArI+yvD85Pqdnby3xccKclPXEYUelHOcyCmAVJfWiYzbICD+LFQrTf3pQ4XIPHKerRm4JlfIz8zOuDNxWrvS7rvSBsmZT4j2LsRA6KV0LsVpuE5i1wZUA9hmOEikyag7lyd4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3lE33qFS; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3lE33qFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDtxFVPQr+9++CJ1SBQstBfTUxz3sAy0reVD5TRIkntBDPZgbDOUqmsBinnHqgG9aSQFY9yaeNYiXwTX5bFUJffXfIIvH82c25fQXUNcHivq6tDcjeJyyZixGXon4ybrfA/wcB5HfxOhwkx2ifqbHdPxhE5NYRvB1yskCMEAaKlV9hzJoUSMyVJ3AtqBSMj2W5m0Jbm0gUHC+cuhWADfktHAPZ0M9Z9vmhVsIRN2As+AFgDHQASEG5UmFZUSzPBtdMOWdVMmVKMLflMsdgEeArmRhoZaDEkwSVBiB0BQbF2c0bHeS6n+YvZjFuSvr/cRmU4ALpEeAG8D4UdbpslHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHEZtAG2jC5GpVN3AmPgqe+YaQEaoGPx9UuqFrp7bk0=;
 b=Rd6LWVOoYCPDGU9lluNcZ1XNfN2i7Op1rxVEAw7IhUktJqb7x+9N1XgXqlOGwexQK/AP7kHvdwKyYFpUBBZEHYf88p0wzIDWIyMPmd5CLJVDJ2oNP3CY0FcRCboybbB2uB1jdgrSFKj5tjGMKlRy+pw1eMqLyqppWiG3hVmUNTyg75Bomm8JAGwD7E9513m32ECAUMNEjMfV+CLyhvVy4Z0cdhs/EGyIZsY7+NTTFSRZrgZoqOcSg6mHCcknHkjBGBKJdkn8u0IBqkevNnTBHfqPFTr5psX/P3FZ8XKjnfZdgA0aQc0gKr7L55KxnVPUcQybpPehWMFdCd5jiEiKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHEZtAG2jC5GpVN3AmPgqe+YaQEaoGPx9UuqFrp7bk0=;
 b=3lE33qFSU4rEbgKJr/oDUPZE3Ea9okYrBvnI7W1a4wCZZtWcDgpw151IMO2LfUp8SZ26wRgbxcNeAEC42lXghYoJ346beqUCt4LNIjKbyNp9Aq2xqarwZeF/j/3oLU/9TOS8NkkRFE1H9wxXFpi1sni0D4bTqC2Yk+wYl7waC38=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 02:41:52 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 02:41:51 +0000
Message-ID: <3f578b9f-cdac-4bdb-8f0a-f5b3a48f6622@amd.com>
Date: Tue, 13 Oct 2026 21:41:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
To: Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
 Bradley Morgan <brads@mainlining.org>, Hans de Goede <hansg@kernel.org>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-acpi@vger.kernel.org
References: <81b4f4bf-b721-4b5b-8ddf-d040865f02b2@amd.com>
 <20261013224010.GA1589480@bhelgaas>
 <20261014004321.GBas7QKRYgjdcIPLHb@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261014004321.GBas7QKRYgjdcIPLHb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5236e1-77bf-4a1a-718b-08df299cb382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mizByEjNuH6G7NEpLlXfrPywPjjpuY/yoj+3bHCjoBXOJub3mqCjy4D3ekwO1SUsiBX6ewilXTwgIvKzVx3MFi2RNcD0PV2QiKl+sH+4dh/q66D5Mo1fJzG+9nAPYwO4VO76qbiZuS9IXTSEmNYwJ89GxtnQwaPbvOgtfXEe4POtdhhViRAg6cukYMiegGPDw+XV1IlxCxFMVQooMVZDZC0HJiT2BqbccMYCjiV2Ld3V/b+H+D1QNeKApFIBqNzp1XVF0I8a8SxKjtmBDvTTANEKNzZO2LDBfeuuIQHM4aN9pUKAhV0y43NLdeDE6/HzCNzb4mjgTgFnyiX3QcZRTkuH950IzlVrI+g2Xwii0Uf90AJQJBAzVL6aekGCnWZhsGxeIEC2yyWym9dbaHCh6JLdwZHuPm8zWOMnqQfQ0JC99cw7BltPmleJNFuzeBXyNZKi4oYSRbbSYK55vB95fWJzU5a7FwMJcUW1+yj7+p1XDCeP9VL3Z9O4zthX+BXRAHlSb2fKsSc9qt7K+5LqFvClq2OAC3ImcvPCEPQmBPo7bbVRA2RAufCKdrgQR85ryoxuM8y5ZbFf6KSXVFPl5Sci95+QgHx6ygahNT9n0oadJIQ5j4tdoehdocf8rcF8Po0xQEAIsHN+TYBbzwSH+TA65RZeE5MLe+7fVCusKms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDlNZ2dDMWFCZXBDZERjUmdJbjVXUUJNRmMwdTVZbmxCL3d6VXo5Uk9RQ3h0?=
 =?utf-8?B?cWR4RkoyMnBjT1FzZm9GK3ZVNWFBWDN0dDdwV1RwOTNLOVpVVjNiY1A3Kzk4?=
 =?utf-8?B?dGU0bW02RmhONlhFMS92bHpMU3VpTzZGcWRqS1BRTmRWQytIYm4rajRML1BY?=
 =?utf-8?B?UHRUK1BkT3piODNidDM2NzZPR2xMcEVrNlovL2xqcXkybmJSL1NLNjBhZmw0?=
 =?utf-8?B?QzdMQkNXdXFKaXlrK1ZubG9pMzFnekNGWkZrSVlXK0UxQW9ONU9zbjNLTFEx?=
 =?utf-8?B?eHl1b0Nkb2F1a3JvQ0JXSHNmNXFSd0o4aTBPRTlKVVUxV2k3c0twNENMVFdq?=
 =?utf-8?B?UGVKZm9EUXRNbEFyWDg2djJWM21kaXE4VnJyWGF2eEhzT1BQb09uS251ZU9K?=
 =?utf-8?B?cG5WdUFKTkJ4NXRMT3FCeTVRRVFrc1RGUUhoek13QzRaVDNFelpobHVBUXhJ?=
 =?utf-8?B?TWtFbmkxR3hPVEIrbUl2VnMyTFl5eTVJdGZlakxMcDc1Vk9RSHR2WTJUQVJp?=
 =?utf-8?B?Mm1ZSWtidVloYThvNXo1VlliekUzMmF6Q1VXUnVJTXplcE95d1JYTWJCa0ZY?=
 =?utf-8?B?eFNFQnFuaVNlcG43N3k5MjBvOHFlV28yNmlDTUxFZHBZam1MeitJaHdIVGdt?=
 =?utf-8?B?a1FpSDh6cTFSM2d6WUFnM2loS2JUaTNEWmZ2dkV3NkFVTnJ1Z3ZEUGxITWo4?=
 =?utf-8?B?SE5ZVFRTOTdMT2tkNW5XdFBzNmNQeHdMUmxlRGVFVXlhRCtITDZiYklmaUxS?=
 =?utf-8?B?MisvZWltclNuWEFaSmV1eTY2N2xSRjl2dnJLaU9mVFNtSi9GTTFhZnQxTEox?=
 =?utf-8?B?LzJYT2tyRWdadVlBdXYvMDhDYzFlVENmM01XS1RLOE5mbWdoQ1I1U25WaVhx?=
 =?utf-8?B?QThxKy9nbUl1QjZjTUk3WTNRakxIOFVIU3p2S0pTTjdNcEFiOGxsa1E2eits?=
 =?utf-8?B?YmkrWmFzbjNlVU03RVRZUXBlQkw2M0NSUFNKQjBNaEVvNzN6K2hXSnIvZDZu?=
 =?utf-8?B?SFlaRldaK1R0Y0hUQzlreVpsY0k5MmVRcGRMNHUzNEl6eUtKOFlwWXZhbWhW?=
 =?utf-8?B?R1JRS3BkTkRtTHRZZUloMHVFQ0FGVEUwN2hSSjVhRHh2ZzJMNldmMkZINUhK?=
 =?utf-8?B?MG9rRUxYYUZXSGdiYmt3VnBvenFlRG9pUjV5NEhtUmxJdVRpSytnSnZLTktP?=
 =?utf-8?B?cTF5enNwUW9DeWpLSkhMMW1aR0JnczRRMktLNG5qdSt6RlhqT3haNXE0ZjIx?=
 =?utf-8?B?RjN1VFdua1FLMzJTVEZpbHFzcHJyNy9VTFkzVE9RQXU0WlhMbUJTV0g1WVdX?=
 =?utf-8?B?elhBSDJqc3VrNWh1UUNKVzVDRzVRTkxFcWsxQmVucnRUNGF3ZjltQlorOXh3?=
 =?utf-8?B?SlV3VENwWHQ3VytOeE1KcERRVWJOWTJDQWxSQ3NHUWR2TUxNV1NHYjBJVnM0?=
 =?utf-8?B?UGVNeUhrTHh5SjlMQTRaR3ZNd25CT1NnS1FsWGtZMDdxUGhIK0k3UDVlMURB?=
 =?utf-8?B?azRWTmZUOTU5WThOWUhrR205R2RnWldxa0xpRC9jazZJOVZTMDNDb0lCWVJ3?=
 =?utf-8?B?N0huV2phNjljRHVXODlDMENUZC9vOW9qdmpFbXNPNGsvR3laeUZPOTA5ait0?=
 =?utf-8?B?Y3FRWHl0UC9HVTFzbTFJREcwamhXQkFJTFo0V0lyNlRMc3RWdStEeTNpOVk3?=
 =?utf-8?B?bzlBZzNHeUxYT05JaG14eEZvdnNUSXJrd0R3Q1puSHZVWXlIMUZRMTg2SEdZ?=
 =?utf-8?B?dnZ0QWt3SDh0eU9lVGxvdDZYZERYMDBIcDcyN1g4S00weldJYno5Vm9ZdXNP?=
 =?utf-8?B?bzFVMm92aE1hY05jejlaVEhXd2NmcVdGa0JuTHdlN0RHKytTQVAyTzlpNWox?=
 =?utf-8?B?UDBuWVBxZ2toWnd1VTF0V0NtV0FHMFhRZGVGU21hVUlXSE9sNHNObHVIQUIw?=
 =?utf-8?B?ckJmMkRqZWw5RE9BcmZURS9Ocmk1QXhuUWlvU3VjbU9FdnV1TGhuYy82RkRX?=
 =?utf-8?B?OFppRGcrNHl0WWRYWElwZUZ1TmRmQ3c5Wk80YkJnK25nbmxEZGUzdldOa0hV?=
 =?utf-8?B?RUZ2bVNBWEpPRkw0VW1KWXhra3A4dmZzMEtrTi9Sd3NzZnIwdTFGVGJYK2lV?=
 =?utf-8?B?dFUzejc2dzdTQXMyTDBnMEduOVk4bHdwMXVwNndUSVhkK3hMTWRIaVJIOFcy?=
 =?utf-8?B?MWFLR1BoTTZvR3BLMDhSZ251elMzeEhhcEZpQWNuYVhtM2llNzdmVWd6Q2Zw?=
 =?utf-8?B?WTBvVzRMSGNBYldYOURWelpteXJ6ai9sQys5M0lST0dMOFkvSWhoMXB1YUVr?=
 =?utf-8?B?bk1pQ0IybzhVS2VJQ2lRZW0rZzJIR3JCdHFDWkxEN3pVUjhvdlhhZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5236e1-77bf-4a1a-718b-08df299cb382
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 02:41:51.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ0UnoQqEHObzrJCtzL9ImjgHMELpzXJWsr29dAQrY7SG1UBtTDlHUX95Cglux6wPdaOcerSWJHKYlqLUtq18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953



On 10/13/26 19:43, Borislav Petkov wrote:
> On Tue, Oct 13, 2026 at 05:40:10PM -0500, Bjorn Helgaas wrote:
>> But I'm frankly terrified to touch it because I'm skeptical that two
>> more quirks are enough.  I just expect that whatever strategy BIOS
>> uses to build these maps is likely to be used on many models.  I do
> 
> Do we have an explanation why BIOS is doing that shit?
> 
> Mario?

If I was to guess; because Windows allocates MMIO space differently it 
hasn't been a problem.

Which begs the question; does Ilpo's series improve things enough that 
we wouldn't have these problems either?

Maybe we should just tail my patches on Ilpos' series and then land them 
linux-next the very beginning of next cycle and beg everyone who was 
affected to test linux-next.

> 
> Btw, Mario, you should replace "Genoa" with "Zen4" everywhere so that it is
> more clear to people.
> 
> Thx.
> 

Ack; if I send mine out on their own I'll adjust.


