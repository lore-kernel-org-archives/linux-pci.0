Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007438E5E9
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214361; cv=fail; b=b2UbwCKOp/eGRYkdIAOu1aK5fbiy/8qezeViJJyS9EL7ZRuqP4fLaooZFQXvve9mUay8K+DsbROGVfmemwNWHWMA1Qz0yHZYAUjXPm9m155HOL5DDW0XiwXSfHaOLTlDnPEoKBX2hSE5B878vNxdxaDknM71v1k/UIz3Zz9qzQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214361; c=relaxed/simple;
	bh=tNwvM9uPE0SW5wy+t5EsJ6Kg4dfyWWIU1GHTOyxkxFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+ALTAkncWokNbFeCsvcwGnGUuVqAzEs0wrak73FIp2SmbojbZswcQH/xWEZqF72kuNol0f2JiiOWiTvfPDyYDXVCJYzaIJKi69IyQWUB0QlyII1MEXfLKVDAuEF51jy+sKH7FEBX1aVrURjOOE0la3Yg3aK4P5lYC/p32xjnYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bnGmfz8z; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bnGmfz8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSmA0tE9kV1vyHa/gpGVBk+WPMOqdy3fk5hwb39AL8sifpT/Tyaig5joyTTC61XeGRjGkcXPI4cuMIQe4Bh684xXlEcdzF+idRrAlOeBuXwK0Fg1QJoSziKdE1+BBgVWb0r/HK2bNL44vy4AAzcegkoZRrTtCf4XmAu3fWO0KdNwgpBwDxN1I28PL4kRGoGsBiX9f+Y9lQA1v1P90xJ1qs/h7zbpPt6IcZtr4drD1VJbIrHdA+uqX2dMqbxZ+L4p3R5PJeqrfazDm3/ySo856k77sy9AlhqbsU+CGDIZgZOXQRS2k9J8NP/nUKkEoBpocBxd35/zDexpQUiBOnPXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTggFyHQU4tzgbkCMosP2GEH17REoHroJOm9o75vAcA=;
 b=i1El7nzSJmR9e0LjhpMZkoALXIY5EsKwXWY2aTBw32HKezDUs+WxELj/N2uOI1ZAwV8x6CHjZ7Y1NWi9ST3RqOqLsyQNWDCPk1tpKyNVkBJH2yBMARH/rUF8T0EbUa1DURnYoujZdJatYzwmXjQM8vODvyEaun9vsXUkpy42l26iB8clUkuff0C0/+O9FPIScrYeilfQPROnp8OxDRKKFIr/v5yywsPMoVKk6oOkfQw9wl2IZrpRKFTCA3qb8eJP3KEpS33Xz9KinJvQfujDoDpmAiBtaDxS2z+g7FeUWX602AowEVK9YEl/VOm4Oa0s/cupqOrOxpgJdCn/RqtSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTggFyHQU4tzgbkCMosP2GEH17REoHroJOm9o75vAcA=;
 b=bnGmfz8zo1dbCh2aIwBRbGKqQkM9xmSAaN+Kfr8tDkTFQ+PZWmfA87Cr+nMcjaz3CudUdEfppnO8lpqQzeNAx7vh5WNegr7lQI513BcCYdxU0i7VWJvft246d55yjhrbL8FWcjfrW328y5eeIvGP+bN6WDAT1eWJDzGsleMLrbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Tue, 28 Jul 2026 04:52:33 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Tue, 28 Jul 2026
 04:52:32 +0000
Message-ID: <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
Date: Tue, 28 Jul 2026 10:22:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com> <amOBkJ4BaZ4qnkpc@ziepe.ca>
 <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e80a10-b341-48b6-1550-08deec6408e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ejkkl+AEJWFIt3hODkjWfffyA/h3HUKu4Ol1ldeZmg6tAFU1bAP0SaZXGUCHOHLyozBNK+YXvvVEGujxMAZNkb53H3jK21r8O30HsQieNaLTR9HCPNlDbLRWxuDEgYO2Se3hbG5GkkIAHwgNb5BovO013hami8aQlI3X3jgycgrfyCjg2l85nITgAKuOwlpyS8svDJQLAp1zy4P7WEthrJrRmQ5l3dADL+YN3sue95z1fHgCcbMiP1JEo+rvYdfkIdCY8/+86crR63hxDFbdwFKo3PEdgIaisZheej3lnVvLDr/SdhLtorJQlY7IMPj0A9BERuhiG25MlCWDkBAkak1Ie361oU4j8wmfWjIuAOm+UPB6lhHtHz+ZkyWKpIbCcpzqUHohkiysHnc/wgeKNk+0Q3uThn+bh4VSGhPZokIi4QllQHjrXTzdLuOr+BrDWzFdPOAfHU60rKJXPd8+e2JF4UvdOhgueZNozG57sCTRp9NriRThAP37YtQP1DVL+OYjK9V0Jh+Tshc+XlfnNZZYAfnzmkcve/rYVo/yW56jGAKq2jFOscgCKTTwPxKFXacjtjw0SyMhffbMN32h/71P2YkYr6uLXnIrXb39yPjG3/U0H2ouSzn0V6DA6zCF93bqOvWZcTAX8J2qzfbM8EOYe/5ny8kTsGzKzUvKH7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFDOWFrY0UxaVNaa1hibC9tcnhQcW9BcDhGSGhZNEdOcUpEOTF2ZWl4WEtN?=
 =?utf-8?B?VHk3SE5QeUptcms4Tm8wK0NKRFg2bmY4RS9TNld6dm9CRlRWUzRtTW1NUDFM?=
 =?utf-8?B?RVFTZDJpRDlFTjBjaE1rWEhESndQOXNiY1Mrc2RLN0VMNTl4aFRSNS9aVFEv?=
 =?utf-8?B?aXc3MGt1WDVSN24yQWVvYitzbE1vNGJ2bWt0VnJORVZtMEZmeTF0QlR4ME83?=
 =?utf-8?B?OVJkZk14Mm5oYW1YemZxaVhBTVl2YkRIRkFaU09CMHI3Si8yMHpUZzBHZ0JE?=
 =?utf-8?B?SXFJTG4wb2UrbDZXZFg3c211QS9rczdTd3h4dTJ4Q3l1MkxnQUhzVzlhVGFX?=
 =?utf-8?B?c1FLdUNLeEtqbWFsTmFQOW5xQkpKTjJON3FvVnRmTzJCOXpQNlBxeTNidUk3?=
 =?utf-8?B?TGc4RzBacFpXT2ZtMWV5ZUNPd3B2emxCdi9GZ09QVGR2RWVwaTJ1Z1pPdXBy?=
 =?utf-8?B?SytCUUNCTkFqczRDZDNXMnJrcFlSUjBpSit3MSt0Z2xHcnMxZFoyUGFaTGJ5?=
 =?utf-8?B?cE80UjNuVUlKaUFYd2VLelZ5MWJBYkZFZk9SRkx6WEdzL0d4VUt1YjIwYWhp?=
 =?utf-8?B?enVIMlQ1L09ZT05mT3Z0dzVNNHBLb2kxZnVHVFlrSnluWm9QVW9mdXd4bEFE?=
 =?utf-8?B?MVF3alNMRW1GNWs4UEhLblpNMzd3QkVGWUFZNEgrWUVmdnY0ZEE1Sk50elEr?=
 =?utf-8?B?aXlCc09UbGpFei9NME1sOGFML3JXYkxrK0FXdWF5ZFVmL1JhTXNlMkc5c0VU?=
 =?utf-8?B?dWtQandzMFdqbldlQ3d0NUoyeVJ3bGQ2SGZDMjJJTC85bjBScnJLWitocWFq?=
 =?utf-8?B?c05KcnZaU2t0STFwZWtDekFmY2t1OWsxbExDSkY3ZXYxL3YyRTMvNUszcVcz?=
 =?utf-8?B?ekFzbmI3OU1uM1Z4QnU1azR0Z2tPRkhwOTZsUGhXMWVIL2dFL2dOdDdBNnlr?=
 =?utf-8?B?T09NckhKM0l1NnNZUlgzdk9odXN6QWdxOXVzMTlCUGY4WldpQnRSUVNBYm9I?=
 =?utf-8?B?Ni9haW5lalh0NzNYaVRKN2tYUTZmeXFNZzdZS1c5dlVPS0RNN0RUek9FVFM5?=
 =?utf-8?B?ZGg4V2U4SWV0RWZmdWJta0FhVHNGQlBSaHZlUnFVZXRwSmtXYnlTTWZ5KzM3?=
 =?utf-8?B?YkNiTHhoODJ3TEdRMmJhdjFjVEJqOTZIZDJ1ZDA2TFRjUXFsNjQwUklFOWhB?=
 =?utf-8?B?aGVQeG1SQitlRzhOdTVIK0p3ZWtxYVR1dnJtTk9MNFNraUMwTUt0UzNKZmE1?=
 =?utf-8?B?R2c3OWZSTlFRTTRUTVBmc1IxRERFMFpBbjZ3UFNNSjh3UHVGRTV4aFQya1Vl?=
 =?utf-8?B?TkQ4eU1XbWFjRTNVVjl3MUlhVXhqbGNmLzE5MUZYVEovenc5YUVZVktrMHlN?=
 =?utf-8?B?eFpsNU1oWGpBQkc0OVR1OTlOQnRXS1JNYW5VbnBWVHE3cHB1MndKeGQvSWtI?=
 =?utf-8?B?K2N4OU9xVCtnVTJmRnUybGZ4V1BSbkEwTW1BeG9FTk1CWlNjVER4QngxNFEr?=
 =?utf-8?B?aGdud0FUN3dLUmhzbng5eVY0R01TeUhOKzF1YVpMTXhhSDA2WDAvdHZvUHB6?=
 =?utf-8?B?cUt2UXQydE8wRXo3SUdzaVdobExidERDSFRsajNQVHVsajZPRG9mUFpVUlZW?=
 =?utf-8?B?OFpmZE96cjk1ZmlTQzBIaHhNeUFvVFFGOWdXRTVvWXlocmVwZzRySlpWTGtp?=
 =?utf-8?B?L3JoWTVVeTIzZ2ZKNVBSSGVETG5ORDlscE13a05ETURKS0NjNkJEV2VLdTh4?=
 =?utf-8?B?RDVJUks2aUZrb3ptSzZ2dzV0TGc1T1YyeVQzQXhBSlRUL3JjVDBsRVJOVWJD?=
 =?utf-8?B?S3cyRDV1TTNaYzF5UEcvRTRodG1hYUs0a0pmbWoxWDJwY1JMSE5IQUNRaWVU?=
 =?utf-8?B?VUpVYTh1dGVVWFhKUTdlcDB6VjNVZjZ5UFErZkhFYVRZZXNYMVdnM3N2UENZ?=
 =?utf-8?B?NjBQVi8rdzh4bTlZZktDN0hpZkpROEU5YURiL2NUeGZ5eW5MRWJmeFY0d2tN?=
 =?utf-8?B?WXp1RlFSYTZMTUxQeENQeGVNZWQ0YkZXd1lwQkNWL21QMENETnBCaXhsd3Rt?=
 =?utf-8?B?U0xTdFZ4cjh2NzVjYlNicURVVE12OFBiczRjcFdjUjYrb2FKMGtJUEFYOHo4?=
 =?utf-8?B?WEU4ZlpjMCtSRDE3VW9KVE1vNmtDdEExbzVXUS9Eb3QwMzdObTVYTG94VkF2?=
 =?utf-8?B?TGxRNll3N29xVk4zY0Y5SG9hREFHSW1WaWV3ZXhoMFJLYXcwQzR3bnJKbFF3?=
 =?utf-8?B?dzVTR1lzUWtNdm5jUEFyWk5HWnNKdEJnajUvSWxkQ0FPeWwvRW42RjBUcERN?=
 =?utf-8?B?WVNGNkRKbVpLOUh3S25IWC8xZmQ1VTVKYW93RENJZjhiZVpUTHhiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e80a10-b341-48b6-1550-08deec6408e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 04:52:32.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+xCUWbbLkam8b8OBUpd89uPpINC16pVyYIMv5TI8Us/Bcxcbvoe5CTyizO+yAfR0ODZgejyoyFrQSg3IQnVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

Mario,


On 7/27/2026 8:15 PM, Mario Limonciello wrote:
> 
> 
> On 7/26/26 23:19, Vasant Hegde wrote:
>>
>>

.../...

>>>
>>> I think this can probably be dropped now? There is no intersection of
>>> this old broken embedded GPU and a CPU that supports CC right?
>>
>>
>> I did consider dropping these two checks, but I was not entirely sure. So I kept
>> as is for now. Once these series settles and I can go with next step of dropping
>> these two checks.
>>
>> @Alex, @Mario, Any suggestions ?
>>
> 
> The background comes from this series:
> 
> https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/


Thanks for old link. So it looks like we are good to drop SME check?

Also is it safe to assume SNP is not enabled on these platform and drop that
check? Anyway SNP requirement (which doesn't support identity mapping) and APU
requirement (needs identity mapping) is conflicting.


-Vasant

