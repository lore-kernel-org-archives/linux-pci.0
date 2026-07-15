Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99492335064
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106298; cv=fail; b=GnY10rzBmSOOvorxb+WEeiuUNzHqRdtu+k2PkKR2nMmaB77dCOUPrQYSmLk6yHLGTdZ3EnH98nUeS3KXIZVR1F8fULa7bS42ZCBHRG5u6bxD9IsvdRifKup3V180E1pxGy5GMFa5kg5X/efCSUJECGeMjLbp5N0qlIsPkdUeLnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106298; c=relaxed/simple;
	bh=1hpfV5XcVcT8oC2a3wdc1IGVB2Qit9aiblxeuub/Jcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTAN3wKi6QwQTp/ryVIsUmpysdMYkafAIQh4FhP6cMBQc61hMoAI6dKfE0iFgRtm9GphiITelRBhH6wguNU9qaPa2X6GYkFJq8i+F7yoh3hXZj0jMU3uJHJ45X/d7vmuBZ7VVhaZzs8aDsX5T/Jwm4PJix7pb7oKdrBE8kSKHDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t5NVh0S3; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t5NVh0S3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxbLo8WtpxQkYpdFMH2nXrz/Iude5OjU+abbqBJheeP0bwLSPt/dHPpJAt3CNZ/JZdBopU03CfESRf3u70nn3cFFp0H05yq2FFZH5AlMlYgdk8iwbbqOeWfev9G3tKn+WJ5NSoPTGLsmLu//hopq7bakXGE/e5JH+QcFpedyzNPodmg1j+qk9YMUogLhggRMLKPdgwDCjze9c5g7p0bxB5eXjNrGlDTNeaoG8JH5LOpMJpAVklu3xj3Sv/2XdOfuMSup62+1X+5DxbldJEsNdm7eqhLdxn+EsGtx2+4/FTnuV+lFqcGjiIBLep+7K96IltAE0ANgAdZ5X/5JzSmapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPHHpAziTS0HMIm1cnPUXH7B+7vy8UN1kIcjWXtz2V0=;
 b=uBOICatd2sbfoolZGstbH3p8wtXnc1tbVveLHg3vYYahs4QRTxUCB09+905TEljCxpOXIUERWNiKPbsjlfXv5hF9rap04rCEFdTJ/09HbhIXomX+NRuAKifBzt6iC+Kr8+1HLMd+h3hm+QAFba131B2FmFigEf3wUAlhyECyZjXlMr4sIn/xXU4JBjLusXRTiOnhr8ocIR/cq5MqogXmpoXLGJv9Ylm06/f2cs7oc5L8OIkAQBZQrLiW+ngYzj2JVv9vQCDZUaOOXlAGq2QyWwsZBKv3fFbtcrBqbOXW1hJVB+PUVvGJaBTQizNwQ9/il4mO4WNrxhSHjoeDtRQNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPHHpAziTS0HMIm1cnPUXH7B+7vy8UN1kIcjWXtz2V0=;
 b=t5NVh0S366D/CeJGeVJ7EJrTQy5xilLxdDSQyn8TK5FvNK+o9KWScF6fI1jxPdxvCLf8cBSZEEE3neJ9u2MZWIzlmkCrdCYmB+f25K7HtdIuxhYa3mFCioFXNk0lIDKctGVviuUq3Zsf1taKgIwainfSPWzdkFZXo8MAJRPj4D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by MW6PR12MB8951.namprd12.prod.outlook.com
 (2603:10b6:303:244::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Wed, 15 Jul
 2026 09:04:53 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:04:52 +0000
Message-ID: <0cc44c9e-fc2a-4c95-a574-de833117f6dc@amd.com>
Date: Wed, 15 Jul 2026 19:04:44 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
To: Jason Gunthorpe <jgg@ziepe.ca>, "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, ankita@nvidia.com,
 Aaron Tomlin <atomlin@atomlin.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sami Tolvanen <samitolvanen@google.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Saravana Kannan <saravanak@google.com>,
 Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260706125140.GB107792@ziepe.ca>
 <6a4c163072c60_174db6100c4@djbw-dev.notmuch>
 <20260707124321.GF118978@ziepe.ca>
 <6a4d95fcc92c2_2f05d5100f7@djbw-dev.notmuch>
 <20260708143153.GH118978@ziepe.ca>
 <6a4f0b35683b4_353c8910011@djbw-dev.notmuch>
 <20260709133601.GJ118978@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260709133601.GJ118978@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0069.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::7) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c50ec3b-782e-4dba-fabe-08dee25021ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|6133799003|21046099003|11063799006|56012099006|18002099003|3023799007|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	8l4jFKksxr+Pl20e0NqFnQADVAZ4I17j/0cd1yj9j7XOmZ6QeTFdcTLv/AFB/48FX5My/Mx21BkVv+iaDnjIVUYSejPYP5Jw7TuTu4u4dgS8FRu2YHpXEtmZfer/sVltnmZUs0znZZORDqujQ116VWzeikdYXDymZb4O/+8ra0Y6elJBm4JsuRUN8jGnCIvUlnc1NBtAITM9jv1OtY1VUoMBMfQ6AULvu0+hFoCbJBg5oPahvAqoTvjEVsbV1B8SdtOJaDEY3sudvEb/PZoY//h68S6ZFjyE610bWfyj5Wbbz5dRYogYahrF8OVPseoQyg7JZeVTeraPzGUnQOkiTsV0NZ7Q2c3lM36cpykNeNuehWLf2bFPaxM1IgxUpc9YG4JLn/oN703+zKUkZFZGtFJnDeDrHtqV+UF6iZ0uL82PdWz07DD0EQPUOHVGY4aoc+XFs8tB8rF2E5wkF6EcmPr/NOELTfgETGI/0sPB8R/A72PU9MgKnOxZHSXTkHYdTVW/xvzUFc3M3rwtL6NA6oy7lsR0CoQmdhyaYuyTYOnWRRdiHPyfSVAFXwX1ytywuIga/0tB3tQwrIIXQgZSxEsF0Ul/v8GnWLR1K6F1JBSrbBkANl+51HHtQMPvMyrtCvRgMwltBrODP5RkqC61Aj8Z8HEooShKP/HS2stm9W0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(6133799003)(21046099003)(11063799006)(56012099006)(18002099003)(3023799007)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnZXbVlEV2sxUmJGZllRNVBVckg2UG82ajNxTUI2Tll0TmQvK0NrOWhZc3l4?=
 =?utf-8?B?REhhaUZCSlpoUmgxV2pyOGo3Yzd4TEJhRFZiZExXZGplZkVabEhnaUtncEow?=
 =?utf-8?B?aG9ENWNVOEhFa3VOVG1rWEg2bWxpekhJclZXdm5BV0pUZmFjdUdWY1JWOG1R?=
 =?utf-8?B?NFlxdWN2clN4MjRNZWVLWlI2dWxmUDZ0YSt0MGNpUXB4TzdQVzhYT3pRcDJp?=
 =?utf-8?B?TWZQdEFPL0oyeHIxRjB3aWRGckNPQ2loSWRxcjR0clE4N0drMVkzcXY5dDJO?=
 =?utf-8?B?UE1vTkJ0VGxXV2tNQVFqTE5xV3Ywak5Qb1dhd1RycDloZEhnSXNkb29xNUdo?=
 =?utf-8?B?bXNOcWpqOVErcFo2NVlPTWFhWjNxcEw5eVdDRXNPMmFmaVgyZW0wYm1EQmpz?=
 =?utf-8?B?U2ZJUEhpODVrd3h1M1pVaTc1UHRSYnl2bzZXWE9mckp0THY2OEtVZTFNdzc1?=
 =?utf-8?B?cS9DcGpiZ1FEbmIvbTJpKy9nUnVta1Bvd2VjQlVBTDFhQVlSdC9FRGduUHVl?=
 =?utf-8?B?T2JPL2hDdWJwQTVRVS9XZWI2YkVEUDZrcnNtR01FS2V0dWJpb2hqZ1VHa204?=
 =?utf-8?B?RGM1TWNBTTExTEZDWFdKV3dMQjdlZ0ZNMy9Ta01lOVFZOVZGcHZ5MEVoS1NJ?=
 =?utf-8?B?ZzN5Z2RidlQwRVBXOWFtYU5ScGE5V2drVzVocjBhVllxL09yZm9ITWwrOWk1?=
 =?utf-8?B?TDVKNVo2WHlLSW1JQjczU1RCdjEwWGF5OWh5MjFoVDJncjRSQnZsc280QkZU?=
 =?utf-8?B?aXo3a3c3ekhSMi9YNk40OVd1VzNhS3pTMzVROWw2UFlxRy9GUjdQUExmTmw1?=
 =?utf-8?B?VmVJRFFBVXhDNENLTTFpQlBzTGZRc0dRb0JMWDNDVTU0aHU5K3NRdnJFTGJ1?=
 =?utf-8?B?eDFhOS85V1k4UmEyczVDZ0kvNVJscXY5QmxXbFNpQ0hJM0l0a3VQaUNEL1dV?=
 =?utf-8?B?U3g2TlhxRWYwVEpVZ1hhS21xMDlKUjJ6ZmhIcVVMbzg0Wi9na3BmU2Q5NXJn?=
 =?utf-8?B?RTVRWCtUS1YzTUd2ZGozcmU0Snl3NENPQ2R2WFhVUzlJUXZlVkszMVN2Rm1r?=
 =?utf-8?B?YzJQN0RiSThhR3dPaXJTUXdZUGo1OGNHVEtSRFlRVTl2cHRqYXFXM0xRMDVK?=
 =?utf-8?B?Q1J4eFgwdEhCdHc1UVZITTdyY25PemM1NFFqL3dTbVo5VFc0VGRPUDIrejNU?=
 =?utf-8?B?VU41RmJQOEIwM04yWlY1R3d2QWJNN2h6NVFrS2JzVE12c0xFWnBON1lFUmNp?=
 =?utf-8?B?a295TnZFbmttMkdCSE52ekNMSnMxSEo1Y1djMURBUjlwVDA1TVFlWmVmbjVD?=
 =?utf-8?B?NEVzcDFjS0FmczYwTzNrb1I2SVRpaFVpcDk1cHVESXhMaWhEcTk4cm5namxR?=
 =?utf-8?B?WWFXMENFSXN6NmFIM0hHVWd2d3J4eWd0OUMzTG9DUHR5aFQ5TTV5SkNEbmc5?=
 =?utf-8?B?ZHZYU3dwTWlHZVJTVW1VbVNwcDVPOWx0cTJ1T0dhd0huNERCL1JVemc2SitW?=
 =?utf-8?B?NUpxNXVoZExZZXlxYzMxMWRjNzFGdWJsUXpUME5UUXYxdlpkeHhRdlpPQkVl?=
 =?utf-8?B?SmhQaUpnL0pBVmt3aUQ0S2ZqM0ZwZGZ6TW9JaVF4dGhlVzNVTlFQZ2tsTnRS?=
 =?utf-8?B?Q2lXeWI3NG5GbVdhd2lGZ1VuVFlPNDNMakx2eWJLOFBHOEZOQTQ5cXRhS3Vl?=
 =?utf-8?B?Nk90b3NDWGhBV0dCeVlrNWYwdGJhVVh5SEVvWStlZGdiVjRhRUFJREhsYzZh?=
 =?utf-8?B?SldJbVJoUGlzQUlyYXVDRy9GNkpidmMycTRHMCtzdEoxTDFGNnRLWThzY28z?=
 =?utf-8?B?K0JMUXBIU3U5SkowakRaYlZLK1U5NUYrUm44cUp1OC9PVUVEdzk2bmNBSG4w?=
 =?utf-8?B?NzFDMkhNS3UyUzV4TXUvaklsZUk2c3BwemVBYXZud09UTW52VjdKZGh6c3Rt?=
 =?utf-8?B?a2llRDNwR2pWOVZRRUt4OUZNNVNVc3EvWTM5Sk44TnFWTWVhRGxGV1RFU0g5?=
 =?utf-8?B?S3dBUDdIdWxLQmQ4eHJvQStUUzlwekZWQzFMMnBvejA1NmFlb0xlaXh0blFz?=
 =?utf-8?B?TCtpTjZkRW4zbjVpYk11WVBxc2h4SjBjWDJvYnJCUTdRQnVqcEZoVkN1OWxH?=
 =?utf-8?B?WkY3ZVZkb2hndzE0N0sxV2YwaDY2OENwRFRYTWJCdVlrZmw2Y2xaN1RZenRy?=
 =?utf-8?B?eVp6emxGQ08wMTBTQ3dqalZSamZadnVHL2xLMExOek5jOTJFeHVnaTVyQ0k4?=
 =?utf-8?B?ZHJnV2lWeGV1eklhQmNiMWszcGluYVY2NW5xblBmZXlMTEhZcGNQUW1RWHBa?=
 =?utf-8?B?Tlg5eTZLNTdiUTFicXY3Y0lnZGlNcmhIcXVmU3d1SmFMeDg1RVVYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c50ec3b-782e-4dba-fabe-08dee25021ef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:04:52.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgtFVSBZl3jNStv8gC7vNBt01lbqkW6ba6x2Ek0nKPxK/aODzKYD+sf3R7q2tM5ZTPzSF12mOwAMQQb3AFL2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

On 9/7/26 23:36, Jason Gunthorpe wrote:
> On Wed, Jul 08, 2026 at 07:45:09PM -0700, Dan Williams (nvidia) wrote:
>>> force_dma_unencrypted() does not *prevent* device access to private
>>> memory and provides no security properties on its own. It's only
>>> purpose is to inform the DMA API what the HW restrictions are for
>>> doing DMA.
>>
>> Right, to be clear, this mode's security properties come from never
>> asking the TSM to enable private DMA while the device is in RUN.
> 
> Ok, that's a twist I hadn't thought about. I don't see a reason to
> support a driver probed with RUN but T=1 DMA disabled by the TSM.

afaik you cannot have RUN and T=0 DMA at the same time. You can though have C=0 (i.e. IOMMU <-> memory in the plain).


> Still, if we do this, I think having the TSM deal with it is probably
> better than making a cross product of the trust level, something like:
> 
>   echo only-shared-dma > $pdev/tsm/accept
> 
> So maybe accept should be tweaked:
> 
>   echo full > $pdev/tsm/accept
> 
> ? It doesn't matter much

I configure my hw to allow "accept" (== T=1 for DMA and MMIO) but still only allow unencrypted guest memory for DMA (set vTOM to 0 to say "all unencrypted) if the driver was loaded with "trust" other than "full" (and this series does not call the enable_dma() hook if not "full", Dan is changing it though) so the module parameter works...

>>>> echo 1 > $pdev/tsm/accept
>>>
>>> And now it is RUN. So I don't see the issue with enabling DMA at the
>>> same time as gonig to RUN? (though defering it to driver probe would
>>> be a very nice touch as well)
>>
>> It requires "accept" to consider the trust level. E.g. what does it mean
>> to do something like change requirements after accept?
> 
>> echo full $pdev/trust
>> echo 1 > $pdev/tsm/accept
>> echo adversary > $pdev/trust
> 
>> In that scenario this now adversary device may have been allowed to
>> operate without an enforcing vIOMMU, and needs to unlock the device to
>> correct that.
> 
> If accept enables DMA then it is up to userspace to ensure all policy
> objectives are met before accepting, not after.
> 
> I think the statement kernel makes to userspace is the moment it
> writes trust or accept the kernel is free to take action on it. ie
> don't write a trust or accept until you mean it.
> 
>>>> There are also buses and paravisors that may know that private-DMA is
>>>> enabled for a device by construction. In that case it is also a "trusted
>>>> to access" signal, and not a "required to access" signal.
>>>
>>> In this case they wire force_dma_unencrypted()=false.
>>
>> Yeah, I just need a scheme where modular bus providers do not end up
>> compromising the private / unexported method of changing the flag that
>> force_dma_unencrypted() consumes.
> 
> Yeah, the bus and TSM really have to control this property, it is like
> the other DMA attributes (eg dma seg boundary, etc)
> 
>>> At least if we omit the double check it can be fairly easy to add in
>>> later if it really was needed for some time of use reason.
>>
>> As long as IOMMU presence can be enumerated prior to acceptance, T=1
>> always includes private DMA, and the T=1 status is tracked independent
>> of the trust level then yes, the cross product can be avoided.
> 
> Ok. iommu has to be setup the moment the struct device is created, it
> can't add on later. I *think* the iommu related sysfs ordering is done
> properly before any uevents, but I haven't validated that.
> 
>> 'struct device' grows some "request" policy for trust and T=1 that can
>> be changed by modules etc. 'struct device_private' grows the operational
>> trust level stable under device_lock() and a new flag to reflect T=1.
> 
> I guess
>   - The active trust level should be RO visible to the driver, iommu, etc
>     It should be stable under a bound driver
> 
>   - The "dma require unencrypted" property needs to RO visible to the
>     DMA API and stable under a bound driver. This would input where
>     force_dma_unecrpyted() is in the flow [the name should align with
>     all the other per-device DMA API specific properties like seg
>     limit, boundary, mask, etc]
> 
>   - The requested trust policy should be internal to the driver core and
>     be converted to the active trust level right before probe
> 
>   - We should have ways to enable/disable all DMA before/after probe,

"echo 1 > unlock" should do that (but also stops encrypted MMIO) or we want a finer knob?

>     including both TSM and IOMMU approaches
> Broadly all busses get some way to convert the requested trust policy
> to the active trust level (eg by mixing in ACPI, etc, etc)
> 
> All busses get some way to set the "dma require unencrypted" property
> 
> IOMMU and drivers should be sensitive to the trust level
> 
> TSM is sensitive to accept, not the trust level

This makes the module's "trust" parameter useless, right?


> Userspace must ensure any security policy is met before accepting or
> binding.
> 
> ??
> 
> Jason

-- 
Alexey

