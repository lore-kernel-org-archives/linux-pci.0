Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EBB4204E;
	Tue,  3 Feb 2026 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138050; cv=fail; b=RnDyPHMGt0AH75ER0NAxwoqGA0eNBNE1e1ouzwX5J0Ue9G4nQS/SqKGnl8sTiaUkvIjDxRXvZJzqtaJbA7nfdawmP7YlazX9eIiRUF7wpHWc/n2Rq+diJVVqJ51MC8nokk4f1JJwokpeXSLbP8LegBNi9uoLtLOdS37GWvKW8IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138050; c=relaxed/simple;
	bh=EyPas9gHdhIIjBpmaOa8TZ7MYpCGIMEifafZg2wfGLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isCNXG2+W7vRxOrf5ChR1Gq3T2rVs2c+FbaXw+Q/UJCQoEDcVFI5SFI1/RdkRDP+5cQOzOvTtbH3QjrvITBFubuwgBp3yZmLLlpon2fRZDOh+d2ZOMti8dfSeJtM+j/glr0MrI0eETr3y15k8gGAc4cWUHlj46UXFwqmC1KncOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KEMgbKJm; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEMgbKJm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJcTEbVGmeADNumDE5wRL2qKDhHJf+vaoSlMCuVoxQlliTI8K8ubEArgZqY6MKY3FJRRhUMb3cTquPVeNplOwyJbr3gYTUjHLKR2wvMuEJnPK2V2ZR5P3R3L02rOKv+/qSjCXv5dTTKyAWj8tMhrOOl/ecSwAqEt6fFIri1altYFYNGZEViNdDvidGyW4U8H9uxeXdtQBdGRk7evo9yeLHnr6wXcbaso+GsKXRya/C9Gmd3CThPf4skcYgeJVoTDrcK1vFC5IL4JXhpT5eV438XWlY5ci20VLK0ks7rTw2HEqmWOyWJ84GaWory1B0EMamzOsFLvhjTjMVbgIquK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PipOAcL7fIrhyq/KcHm8jeCK3X3fu9AveCcbJmG3N/o=;
 b=rs0XJo6Wh9mUoZDh142aiImc3+sUz67J4eJPt4BnbvB5AqcL9eXD492gimsTbj5s01Sc7jz+avVpKqgQYkAmlfGRU2s5ETtQL0UQUxVhhERgiKvDVS6WF6F/Y8kSe2o6hcg7xnuE0ejYRdVUhsJ1zZnDeApBLaLpTAF7UOKZRn5X46hZEQjZp9/Mqq+OMT98eCbEu87JgSevTXccgo9QcP+3yHmefz0rYnov21gzboGVeEMKgo8ur4tcI04D/jcrS/mrFqUU8GRVN7IS6s+wsc1koSw6yBQHjXhWPFMl/0QnE68qWLGvvkMGL9q3O9Zj6oATEVuNrcE4a9qHY35NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PipOAcL7fIrhyq/KcHm8jeCK3X3fu9AveCcbJmG3N/o=;
 b=KEMgbKJmi71NDxcEZEHPhcdm5LUJlt99/MTSeNHFIeZBwhQwO1g/l2VolZlGs6sSCC3AnpPjL0WL9LZ4ENsijf2Sb5bAyjwWzv979qxIUtnOit+UB0OWJT9J9TD1t55s4kfnBhrA4OGb5tvzhtXey3ndbqGrUpLEqUdrQwZBOeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 17:00:45 +0000
Received: from DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e]) by DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 17:00:45 +0000
Message-ID: <59fb1a00-a9cb-482a-b8be-3982c515cd85@amd.com>
Date: Tue, 3 Feb 2026 11:00:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/9] PCI/AER: Dequeue forwarded CXL error
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-5-terry.bowman@amd.com>
 <20260203152609.00004b41@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260203152609.00004b41@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:806:122::21) To DS2PR12MB9749.namprd12.prod.outlook.com
 (2603:10b6:8:2b9::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9749:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2132eb-c5da-42f8-3341-08de6345c566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm9UQ2sycEVpYWJOM3VoQUZTYkpyZ3EySnNOdSs4VnZIU0RvTkJwb1BMWkt1?=
 =?utf-8?B?MHJHanRvbTNFbVFaSVV1TDhnYjQvNndtK08rdmhLV1pQd09qT2ZRb0hTb1lz?=
 =?utf-8?B?L1hCYXRreUo3cHVDYWFzRkJvUGJubk5heDZRZnNUMGh5SWRjMkVQd3UzNFI4?=
 =?utf-8?B?R2ZNR1JHRVRpeVRKMmFhTVhCYkNLVUZRNEVlNlFkTXhIbklVUm94WDlkUlNQ?=
 =?utf-8?B?dkpZWXNTY3NFTmw5RUoyeit0NmdVYlVEQmlSZ05saWx3UHdBLytRN1NVakw5?=
 =?utf-8?B?aHlBWVRkVWRlYUVqRDMzUXVqQjk5OTJuTVRIOVRwQUZrZUxPV1ZkUFJWamkv?=
 =?utf-8?B?NVhGaG9IanZBd2ZUVFRPU3ZZN3YvRHcybTFWYkkwRjIxZ0ZOd0pXcjBtbXNH?=
 =?utf-8?B?MTlqT001ZzRUcGVGOS9hbWZlTDJNMjYvelZJcGM5UFgrZmlLcmVpdVl0Zm9C?=
 =?utf-8?B?bUtCMEJoU0lnVzdDUlJpY3FCQ1RFbVdPZWNoaEpMZHI3S1B6ak1jSDlucmhX?=
 =?utf-8?B?aWdyc25WUlc1NXNOMThmRTJHNTdDUldvRERHY251czlIRGE0RFJzcjdFcWQ5?=
 =?utf-8?B?bW54LzhJc0YrZkVXcEF1cVRsajkrbVp2cnJCbnpaSldQMnB4cmp3OW0xdGZj?=
 =?utf-8?B?TlNydi9PeTVkQzdwV0h1eGx0T1JPWkdmRDgxRFFTVC9QRTJyQ3ErWG5MNVRj?=
 =?utf-8?B?Y3B6azRpRS80LzhzL0wyK0NsbGVsczZKR01rVW83YUMzZmtrdW1MZXRpVFFx?=
 =?utf-8?B?ZHBkZzRDU2VRRHIzRnR0MmlpVG5QUktnNDRKYUoxZFZXUWFEWmkreXRnSWFG?=
 =?utf-8?B?NWlGTXUyYkd0VWVxWjRmTk1uRnVNVElPME5GWVp5c2h4alprZlc1MC9OZmNT?=
 =?utf-8?B?RVNKekxlZ2k0ekdKWnYrZDc4L3EvNXhEbklWeFJkVWRnd3FyRmxjSm5CeXZ3?=
 =?utf-8?B?TXNxT29kSG9lMUJVOTI0U2U4TFprZmhocG5hQ0ZSdGNKUlB4UHJWdHgyUjFh?=
 =?utf-8?B?NU1zQVV0YzVuZGl0RFlQbUhWenExTnVlZ2hLQ0tsN3M3azFJVk0yUnl5VW44?=
 =?utf-8?B?WWdDM085NVR5T2c0SHUydFZIdXlWLyswM2VHWnVpakUxczJoRDduWi9HRHFI?=
 =?utf-8?B?MHFoZVJQUTJPcDFDV3ZFWjdNcGdGbHhRKzhmTUxISUl0VEdVNHhqcjhKUjNs?=
 =?utf-8?B?MUFLSzRRLzNiWFkvWmR6Q3ZVVmJJNHVicVozNko5R09MdWRjMmg2Z29jRVA2?=
 =?utf-8?B?MlN1aVBJeHlKVlI5eklhck14NHRoZUZ4WnRvak44cEY0aithK0VRWHh0bXQy?=
 =?utf-8?B?dmhNZDIyN3hDVkExdWszRHVlNHllUldIUzBkQ1dYWUdHR0FJaGhoeWhrR0F0?=
 =?utf-8?B?MENjTjgvajdIZWYzN2tYVFdOS1p0SGZ1OVAwRm92amtuc0JwTDJ3bHF4cm1j?=
 =?utf-8?B?N2lKeGtobmVHVWM0ckhnMFNIR2NNbllCM1FFUEFHTW5ZdGFsUWlveDYyV2R3?=
 =?utf-8?B?T0FwcWFsOUhORTlYZXFYK29NcEg4WUFGYk4xT0lnTXo4MURFN2hUbHo1K05x?=
 =?utf-8?B?ZGtaejJwY25rY2NBMFVHdG9mbGNBTlhubHZVTFFiRUN1eThiOWI3dTlkWlNi?=
 =?utf-8?B?dDdpbklHZDBkQWtiZTd1bHZSaUR3VU84WG51SXNETGJuR2FZblBRempqUncv?=
 =?utf-8?B?T1lZZ0M5VU4vNHFrTWRsS2l3Z3VEeHZjT2sxL1hIMGVuK1RSSXNoQVhtZjZr?=
 =?utf-8?B?NDc3aFlBNnkxdXV4c1o2TU0vNG53UE1BR25oNldBV3dlejd3V3U0eFViYTVW?=
 =?utf-8?B?dEphMlVlWklSMThQeFJKTHNMb3hkeDR4U3dRYXhtOEg0UmFwcFRFQkpXVUJh?=
 =?utf-8?B?WSt5b3lhdFpNYVRQajBtZzIwaHowL2Nuemhyak1paVM4ZlNRaWRaOVdud1VS?=
 =?utf-8?B?aGY2M2pvd0xFaHdpWTlvNHlTYVk2N0hSaWVDajRvSnVqWkxkdjVPZTV5ZnU5?=
 =?utf-8?B?MVhsL0lzM2dFTm4vbnF1SHFVVEFBQlpXcnJEbmpzUnZTem4zelg0cmxaUnJI?=
 =?utf-8?B?TE1XSDN6RkRxMHU4WWd3UnplWmlJSldhRTVrbGdGZ242TCtzNWQ2R2xWMHVl?=
 =?utf-8?Q?Dcio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9749.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aURoOHJnZjVNY1AwYmpZVU5xQ3VTYTZJYml3NTJJdi9kWEdINjdMR2F3Zlo3?=
 =?utf-8?B?QlVuK0VJWkNUcFV4cDFRcnRtbG02M2JORTJmVk5iaVlOQTFKUFBRbExHTTJu?=
 =?utf-8?B?UW9nR0RLRkdnenQzZWFMZXpqZEFvQ1RCczBYZ3o2SStGSU1LeG9uM2cxdFN6?=
 =?utf-8?B?NjFvazcwWERSRmVzK1Z5blBLSTBtOXZyWUhhaDE5eklVWUNwdmo4SlJQQlRv?=
 =?utf-8?B?UE4ySWhJcENsc25RYzhQZ3Q3Z2RBSG02ajVuR0pVbGNNQ2gxK2R5YVZjbm1M?=
 =?utf-8?B?MnlncEpPTTBXK2tWSVh1YlFKcmE5cXhId1I2ak5jYXlHMWpwWnZjeHR0MXNm?=
 =?utf-8?B?UXlqU2hSU2ZacE9lOWZxTEdyV3VOL01ZdEQxMmM2aGVyNkhTYTdnMDNPZ3RU?=
 =?utf-8?B?SkY5bTl1bEpOdUVQSDF3Wlgwb2lvZ1M1NElUTFlTY1VKK0V6VURhUmYrQlVh?=
 =?utf-8?B?eTVYUzBSU3BxY3ZwZENTalpiVTNVNGo5ZXh3ekN2ekVhZU1JblBoM2Fhb0xJ?=
 =?utf-8?B?bUphNjUwK1UybWZ2cDBmd0tNTEpLS0ZjOGJvcWZkZy9PQy9ZQ2VvU3ZpUWNp?=
 =?utf-8?B?ZHdjZnh1QkZDaW9HZi9ZdDRQVXJXbnVWWm1qSzgxSHI0bnZMb1Y1bWtJTDFX?=
 =?utf-8?B?cGNLcnNIOFVDbnZzRzFUNXF1cmZudTFTOFNmN2pSckY0aDUzaEMrNkpaa0VI?=
 =?utf-8?B?YWVoWHRQL0hsMjlkVDZJam1PUXNpZi9jam40Q2kyYmNtcFVST0lZNkxndU9C?=
 =?utf-8?B?aWVhWHprUVJGaTZxaDVDYWNqOVM3NklBdE8wazhDL1JGZm5Qb2s4ZVYvVlpy?=
 =?utf-8?B?UzN5MC9XQVBRakVkaTYzbzV1TFV1ckcxMno3elRWOUk3V3RBTUR3TFpiaVQr?=
 =?utf-8?B?ZzBjRTZYVGp5YytzZXZKSEM0cjVVcTZWdkNkbDhoVWZJajcyaGNlTisvczdL?=
 =?utf-8?B?ZUJ0UTZvZUFYRjQ2L0VZck12QktEVGFtODFDQnk2cW52TDdta2NPNGZ2RHJH?=
 =?utf-8?B?VWg4eTNZRWV0M04yNHNIdUdHOCtLRDNMelJrQ2NpUXh2cTBtUzdXWDVJVExX?=
 =?utf-8?B?ZzB5ZlRRMWJHR2FpZS80RFV4U3B2ODRSQnBhZTh6R2MyWXJBTDhKb2pOSVpx?=
 =?utf-8?B?a0VkZlFZTUVvaHNFTHZhd0toUkhxSnY1cnUrU2NMUnB3OENER0d6TFAreWQw?=
 =?utf-8?B?K3ZlaGl6R3ppRHVIRDZ2MGV2TlZJOUVCUTdyWU5nTFd5U3N5TS8xRDRHTFVC?=
 =?utf-8?B?d0w4VW5nSU55MzkwNDB4ZUYvUTgwaDFwQXdBVGx3S1cwRmlVQ1FsV2lkZm9K?=
 =?utf-8?B?RjNWQ3hBNmtyMHowYVdVMUNpQjdKeXl6ZGpDaHVhRDZSWVFadGdmbmFJOXAx?=
 =?utf-8?B?VEhvTlhtcnFzQ2VwMmg1QnJZYytDcVhPSHJCS0JtTVNoUktZc3l5cUQ1U01z?=
 =?utf-8?B?L3JUNnlYdngxN2swRFI4ZWo0eEcrRzc4ei8vcjF0ZGNQRXo3V0pjMVJSMHZD?=
 =?utf-8?B?VVBtUzdEZ2VTU2NldGdxeCtDTCtVZ2dHZjZKTHRvQVc4bHg3bFM4ek96K1pH?=
 =?utf-8?B?OWd4RE5JRWhFM204VldTM1R3NkUyZDdOOVF2WGNMYnVSbGhHL1ZML2JkOWNG?=
 =?utf-8?B?M084bUZNVkJJUzJBbzh0ZGtDYmhWUmVBWlUwUzZpUkpXN3BnRERaaGI1Rk1L?=
 =?utf-8?B?TTR6TkhDNVJESmdyOVpBZGJXTWxjR2liSEtNdytENSttL2RZaS82WE4yM0RJ?=
 =?utf-8?B?WXJ4RW1VNDAxYWJ0RmRlUHBCWlF5L29ad2p2STVidUJCb1hRaUpUcEpNcllN?=
 =?utf-8?B?aTZuSUlyaGJ5bzM3WjVCalBGcFNzM1VKYy9YOXFWekVuaE0wT2VmVXR1RTdX?=
 =?utf-8?B?STVScWo0OWdlREdOSmJNcEhqOVB0amx4TkE3TU91cDU4NEFldVpubG9lK3NO?=
 =?utf-8?B?TGkzTGVzZ0FhUzVxZ1Z1cGE2ODMrV09LTytBZit3MjdzMkFZUXBJUGsxeStu?=
 =?utf-8?B?OGpXZFdBajFZemJlUjhvaGtzVHJ5WTdSVDdpdTV2ZjFscnB3SjdZT2pHUFVC?=
 =?utf-8?B?UllZN0s4REliSTlnTHZTZW41SVBmdDYwc0tFMzJTZVJNd1hTUlZPNWVFTVB6?=
 =?utf-8?B?ZDFjSS9wSXpOTUpqRlAvMTdJSFhiN1FJOUsrZGMxQ0lCaVh2N2ErWDVYcFpG?=
 =?utf-8?B?d2RKOEZBSDlIVTVvYWNGWEpranNwK2pDUzgxbUFCM3dCd1RHTVlaeWJNd2w1?=
 =?utf-8?B?MVowUmFtRlVFbmRQZHlLTUo4d2VDakV0UnlXeFZQNHY2dGFzRENjNTlTeW91?=
 =?utf-8?B?Rml0OHBWUUtUZDczVzNCMjN2UVBMNzlOMmVYQ0Q5S255NXc2SEplQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2132eb-c5da-42f8-3341-08de6345c566
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9749.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:00:45.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HS0oOenk8MS76JMc78ytye/L06bnhJT6+SV+xxdVpSIaeXK747kQc2ANA1hrl0Zp8HT0czDWxMJJTMryx6W4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

On 2/3/2026 9:26 AM, Jonathan Cameron wrote:
> On Mon, 2 Feb 2026 20:52:39 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER driver now forwards CXL protocol errors to the CXL driver via a
>> kfifo. The CXL driver must consume these work items and initiate protocol
>> error handling while ensuring the device's RAS mappings remain valid
>> throughout processing.
>>
>> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
>> AER service driver. Lock the parent CXL Port device to ensure the CXL
>> device's RAS registers are accessible during handling. Add pdev reference-put
>> to match reference-get in AER driver. This will ensure pdev access after
>> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
>>
>> Update is_cxl_error() to recognize CXL Port devices with errors.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are some small functional changes to existing paths (maybe)
> that I think need explanations in this commit message.
> 
> Otherwise, one suggests small simplification.
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 74df561ed32e..a6c0bc6d7203 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> -int cxl_ras_init(void)
>> -{
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> -}
>> -
>> -void cxl_ras_exit(void)
>> -{
>> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> -	cancel_work_sync(&cxl_cper_prot_err_work);
>> -}
>> -
>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  {
>>  	struct cxl_register_map *map = &dport->reg_map;
>> @@ -185,6 +174,50 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>>  
>> +/*
>> + * get_cxl_port - Return the parent CXL Port of a PCI device
>> + * @pdev: PCI device whose parent CXL Port is being queried
>> + *
>> + * Looks up and returns the parent CXL Port associated with @pdev. On
>> + * success, the returned port has its reference count incremented and must
>> + * be released by the caller. Returns NULL if no associated CXL port is
>> + * found.
>> + *
>> + * Return: Pointer to the parent &struct cxl_port or NULL on failure
>> + */
>> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>> +{
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> 
> Can you pass NULL for dport?  Looks like it to me as that ultimately ends
> up in match_port_by_dport() and 
> if (ctx->dport)
> 	*ctx->dport = dport;
> 
> where with this as null means ctx->dport == NULL.
> 

Yes.


>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	{
>> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port;
>> +	}
>> +	}
>> +
>> +	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
>> +			   pci_name(pdev), pci_pcie_type(pdev));
>> +	return NULL;
>> +}
> 
> 
>> +int cxl_ras_init(void)
>> +{
>> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
>> +		pr_err("Failed to initialize CXL RAS CPER\n");
> 
> Why introduce a new error print?  I don't particularly mind
> but wasn't obvious to me why one has become appropriate and why only
> for the first call here.
> 

This was introduced before v10. 

RAS initialization failure should not fail cxl_core probe.

OSfirst AER support was added in this series in this file next to CPER. 
CPER initialization can fail and OSFirst can not is the reason for only 
one log. 

When I look at this block of code I'm drawn to the return value. It looks 
like it should be a void function. Thoughts?

- Terry


> More importantly - if this failed it would previously have resulted
> in cxl_core_init() failing and things getting torn down.
> 
>> +
>> +	cxl_register_proto_err_work(&cxl_proto_err_work);
>> +
>> +	return 0;
>> +}
>> +
>> +void cxl_ras_exit(void)
>> +{
>> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>> +	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_proto_err_work();
>> +	cancel_work_sync(&cxl_proto_err_work);
>> +}
> 
> 

