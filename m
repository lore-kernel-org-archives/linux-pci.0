Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89852DF153;
	Thu, 22 Jan 2026 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112339; cv=fail; b=kBOpVOPzKUBtgZnFW1sh/fOW5uoiFYrtAEFMjIYivMI18NyDHGeh4Ey0Mf4T0JiQKJyJNjSFhkUZKyXqvJtsk517WMTHo0pOhC8LQXMwfTIBk4W6rjFRiYJ+unULjSp8fea3/2W1wyKhY7etXqfaXQ15YeO30ETUa566sRDDioU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112339; c=relaxed/simple;
	bh=QU5SVZrv76HnehBAejM+aZCHV5d42JrnUMJCjSdn0xI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d+uhAVkapHr76rTlCshIEsCyjzz4Nvd5nx1sSWB2oGuuq6+D3LCv046k7V/Ofc0cqNhCeV5CitkK9B0CrqiOXZAkPtN1mUpv8ABTXRXG+GRQYNF/tsG7I9TKkDGC8M2HEhvblirzSgoVWXGXWmaJ2Fa42V2B6VLAF0hMVRLHxoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n5R3MZ57; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n5R3MZ57"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4Bz02S0HVn8qSiNfcTs8JRI8/x6PGpK3x1nq9NcFyUgeGzoqFybGRHq3jWDcTkaY9MoAi9rs6t/0KmdOWRyhP1c4arYcaNcKs7Qnqi92njty+t4VnAqVSUoZCfE28mOR8ZZet61VYcQDYVnTu6jCskUUmiq6PMM8gzsgS78MtL+SfjDpspNxgmfQ4WwXEvIaD68WMg2wQjaLZ88mFcnNmdS3OxNVYHbgeCu5WPJtqvrPTF0WbwEhBpEg8ERHhKekmKltvo1/fi50v//cGWbI0PrFbQOFjlubF+o4YILrxaQvEgKwMuERAF86ALyEFzL7cjfywRuZ1VmlronDLvGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vPru4/CPESCv57eNq6YOa8bUcm5eCJvCc7UrZpR4g4=;
 b=pKucxMpw7SJOs8ktMq5+zlahZLjzSd13KCMZgTUhn1hpKBuKF7hz8tl+iXG5RCCdWcifhXIqDsDNpwZzxTYYcrVIwnIGMW3ZR9F2X8nMHvpqzUeSiTpu8/REnc0cdupeCBjXvN8cGVXpCdF0uyfrPfaKw+W89iHktY0BQEpqaP33rSMz7R37oa8fL2zSiOedOV0b8ys4gFIlFubIGNNUtSbIMi48jK4bjGd3aoYuQZB8L+YRS9s1vA9SXIXdrtpzfb6M/FWztNjLhJDV65HVAMaNnrmjZHfBN4qdwyO11gkvLJFENCCYa9SZst/iR/lDpJiTf23NXo35+d3j2Rf+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vPru4/CPESCv57eNq6YOa8bUcm5eCJvCc7UrZpR4g4=;
 b=n5R3MZ57ZmRPJ4yLtPfUT08YAobv429upSeed0FKnVk9YRvlDUZrh3HUoQMTv3EwISZx2D72kL/aFbva6qzER6AA+R+04FIVC/9h5mnL8onb3SkpSDkKof/oxFYIJ2vHWXSzvgMCkEkvwKaqsEha0T5eN/AVA0Ovdkk9wBwj0e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 20:05:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 20:05:18 +0000
Message-ID: <a7260b8d-7654-4e85-bc35-da23c55b3ba7@amd.com>
Date: Thu, 22 Jan 2026 14:05:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/34] PCI/AER: Move CXL RCH error handling to
 aer_cxl_rch.c
To: Markus Elfring <Markus.Elfring@web.de>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org, Alejandro Lucero Palau <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Li Ming <ming.li@zohomail.com>,
 Pradeep Vinesh Reddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Robert Richter <rrichter@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260114182055.46029-12-terry.bowman@amd.com>
 <bfdd40ff-43e5-4a84-a98d-522d4178626a@web.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <bfdd40ff-43e5-4a84-a98d-522d4178626a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:806:127::27) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: c66eabfb-e335-47de-15a0-08de59f190d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RytCRlhlZE12VXFDVHU5QWtYaUZQMXgvNWhsMHQ1TS9wN0FNdDRLY0N3Lzh1?=
 =?utf-8?B?N3pQeUQvdlEzRU1sR2NVbVhIazNXT0JSbjBSOC9pcUZpWmt5Y0FER3lsK0xy?=
 =?utf-8?B?TEFHV2o5QmkzSW1sckgwTlpUSVlvcktqeVJGbmpaeXYyOGQrVUVhL08rVXNE?=
 =?utf-8?B?QmM5MHYrYXZ6eGdha3c5T3BLMHNYWlhySzVYcGxUZGIrR21wK0h2MEhNdUsz?=
 =?utf-8?B?TnFQdXNoNjZlRWlaOTZsM1Q5MkdScXRSVFpNRTBSU3BtNVVqSElITXpWN3p4?=
 =?utf-8?B?UVRkYjJRU3hvZnpNNmZUdXdaWVZJQnVqRTVtV2xibUVmT21FdGNQanFFeWNV?=
 =?utf-8?B?YXpQQnJNaURmdlc3MmVrV0RkOTdyblRMQ2xub0hocEMyQjN5VU1zeVZkdlNR?=
 =?utf-8?B?cktoUVVIeVd4bC8zVnFqZUpYZTFpaXdWSXByNlVMeXZBcW5CelBaMUs2WWla?=
 =?utf-8?B?RmlsRGw1RktSdEVqU2hrdkMwcFQ3eGVhOVN6MDBDZWdQako0SkxBOGQzSzRt?=
 =?utf-8?B?L05zL1g4c2I0aU1ob1A4Sm5hb09oSy9SUlZaSmVYRHM2dzBBeVNyaXFsZUMw?=
 =?utf-8?B?RTdpVWhpWk1BMW8zRDlYaUhOaTlXbTBDQ0RnRWpTZTR2Z21oZkpPWWdsT2Nv?=
 =?utf-8?B?a3RmNjZxL3lVNDJnVFhRQmowSFhYUjY0T1JwdWowNjAzZFlRZXFjcFNQTGlp?=
 =?utf-8?B?MmNzc3pHZlJCUVJxR2FtS09qK2RDeDdCWkZBMnZ5NVNYRjhVcjNFR2JkaVJX?=
 =?utf-8?B?SFdsbEpHWUtBZXZxaTJnaWowRk5HU0U0Q1ZyWk1sL2UxZk5yRmpJeWJhY093?=
 =?utf-8?B?Tlk2K0RYOTZlcXZ5OWcvbW1iVzZFWnFlcmFNdmg0eGk5VkNyci9SanQwaUR5?=
 =?utf-8?B?eWdqK054d3RESUxNbm5lZkNaRmJyNGZ4bkNENy91ZjhIcis4cVNXVDFxcUhC?=
 =?utf-8?B?VXY2QWZsTDQ5UWEydE9qbUxxRnFnWHo1U09IQ2JWcVhkMVA4dXE2TTBZeFNq?=
 =?utf-8?B?U1dqcE1nK1FzY3NvemxxcktJWVVQU1J2QUdyenJDUmdDSWduM2d5VzdJUjJG?=
 =?utf-8?B?bXBwV1owZmp2eC92VDhNWHZoTTBkV1d4VG9CSVFHaC81eFdkTjAra3I5TllI?=
 =?utf-8?B?K09xUjZRL3VDaXZ6eHlHUzZqUEpaQXY2dE0wR0gxdGdqWjFtQ2lXWER0MTJ1?=
 =?utf-8?B?VHhHbi92eTJYeHluN2lQNGVETjdpMFFmSS9sQnJ3V2RGRTh5VnpldGRvcE4y?=
 =?utf-8?B?NWFEVXRmenRIUllQekMxdUxiOUJVSG5OemxkRGQyZGZ0T0dyVU94KzZXNDJM?=
 =?utf-8?B?bkh6WVBqSTJ4NUJabXEzRmdiUWx0dnJEZENQMXBLU010b2NFb1hNS0RvdUd0?=
 =?utf-8?B?V2g4WTgxcGR1K0JYR0Y4Zk5sWS93UWxlQlBRaTRreXFpOUVaa0JtQUJJamZl?=
 =?utf-8?B?S3lRT1VKMitpZzlpTVE3QjVkTmk4dkd3MXcrZjlOMTB1QjZkZWwxamR2Qzk1?=
 =?utf-8?B?Rnh1MVhtcldudFV3MlBqMzRMOWl6MzlzcCt1ZGo5NjVDMjIvb0gzcEJ0UFFG?=
 =?utf-8?B?L1Arb3pLUXRGdXFGcUo4blVUQ0krQkY5T3Q3bEF0S0NqZnlBNXpSL0M0TTFq?=
 =?utf-8?B?N2NQYWVSVUZlWVFCYkoxT1YxYVF6SklNci9SR2hIUFZuSEdJSUxjVDQzdVky?=
 =?utf-8?B?aDdOZUtsaGNyL1NSa0t1THkwUUFINWNWcmNkTjM4blVsVjJtVFEreXovMDlC?=
 =?utf-8?B?RVgrWTduN3hvYzQzcmlMUXVpWG1XUlN5c1B4SWU0ZCtlYkY0cldYWkFJSzAy?=
 =?utf-8?B?a0tFTnNVMzh5SzFEZDdRUXRQYmN6aG5OY1c2c2FEbXMrRnlrdDVYTVJscHZl?=
 =?utf-8?B?aWUvdjBWTHc4KzhkQ2gwSG9pU1pxNHJhUWZuRXRLazcrSGxDb0dIc096a3VK?=
 =?utf-8?B?aTd6ajRjN1hGcUFnSHpmT0UxQVNqYzk1UklVZml4OGNlc29HTGFOL1dnenlT?=
 =?utf-8?B?RkhDazIvS1hmSHlzMDY4bHZDSXV1N2pwLzJ3Zm9WOWdkM3J3VnBza3JhOGt1?=
 =?utf-8?B?OGtlNWJiL1p5UVVIQzhpTVczUkZVV25mUWFPS1QrZ0E3SWFhc3pXaTdaR3ZS?=
 =?utf-8?B?Tkk3Q2xMZVdmdnV6aE91b0NiU1VkY2h6Ty9BeTNIaEtydGRjRnVjNzd4QVN0?=
 =?utf-8?Q?IBVTHTMXwvQXHtJLUCXzhgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGJtNFVob08zejZnVFh2U3J1aE56U1FvY0IwQlZyUEozVFprUUtOVlMvTXhv?=
 =?utf-8?B?Ni9vNElQS000SjdEWXpRRUhYRnA2WVZEbER6YjFGem9kYzNYMUtadXhJRTN5?=
 =?utf-8?B?VVhXQkNZRGtXalhPUmRsOWhybWIrUncyQXNGOVRpQW5qaTY4MndKdFR3aGlh?=
 =?utf-8?B?a2hUR3UzQUxzUFY0MVRqOHpBVnRzVm8zNnpNdk5nKzhJY1l5eEdkOVhZQy9K?=
 =?utf-8?B?LzYxcDZIQXBzNGhUWExoL1R5aEVYUCttKzR6NDJjTjVjbTdUMUh6cStYVHR5?=
 =?utf-8?B?Zyt1OUtkR0MrZ014U3dkUVcxMVdvejNZa29IRHh1TGhxaE9IY0pLQkEySGlm?=
 =?utf-8?B?WVRJQklKOXRyU3NmZ000TDE5TkJabDM4eW4wS2h1QW0vVDI4TEZVdjdoWkd6?=
 =?utf-8?B?L0FoNkxnZjJvWnYrTklrclZFd2RTMXVZN1BZa3ZwMWkyb29PbHF3aHpsSklz?=
 =?utf-8?B?ZHE3WkRRek96K2lHSU5ENnlsZWl5aklsUVNxSGcwTm11ZFA2VUtoNFBIQnd3?=
 =?utf-8?B?aHJnMWJuemhDamd1Yzd5aGdqQnhtQmk3MFYwcldHS2FTblRLcGgxbnBJZ3hS?=
 =?utf-8?B?Y2VDUWl0elhPZmRsU1pneVR0a3cvSHp0bCtOaFo1cFQ5emdsWXhpbCtlQm9J?=
 =?utf-8?B?bVBML1dvblVDSFdWOUM0bnU1T3d3ckhaMXZqYlhiOEk2bm9UQXA2dnZ2N3Ji?=
 =?utf-8?B?N2luMHFPdGR2M3FmdGFYSENkaFl5OEZ3dEZkc0FmTjEwL0pOYTBESnFwSVJR?=
 =?utf-8?B?SmV3cDZBTFh4MlNpdnR1SFRaZnFFRHBJVDRmUWNSdEp0Rnh6WE1VYVRpbnJp?=
 =?utf-8?B?Rkx5b0YwNlY0emM5NXRiZWc4Qkh2aERpWi9DTUFJSTRETXZ2dm9LTlppaWZo?=
 =?utf-8?B?Nkk3NkkraE83cGZveFhjcXVla1FCc3Ywd2RUbjZVQW44RlJGRkRHUEdQM0ZF?=
 =?utf-8?B?clBwYmc0elJkMnNWV0FaNU53WStNTHFsQTdGVlBHN3NubkVhQjdBTlluaDFk?=
 =?utf-8?B?WTM4bVRvWGhlMWdkYjFBajVpYmNJanZYZ0F4V3E0MkVjYkhEbTZHRGxQZ01S?=
 =?utf-8?B?RzdBWTdxOEM2am9WZGNzajlNdmRqaDI4VXJYL1Q2WHpyaWZHdUNuVHFDZ25s?=
 =?utf-8?B?WU1WMlNWbWdHVTZuK2tPSFdoNVRzMURQcjliR2I1NVVjbXF2Z1d0cWVXaHVO?=
 =?utf-8?B?Q29vQjdiNmgwKzluSDN2dElpWDIxOERNaHpycTB5N0tuUWl0eUlhSWZHeGMx?=
 =?utf-8?B?OStyMmNEa21KOXlVWjBxL0E2SGlsSFdjWEpwN0UvL0JGL2RsclE5cnpNcEpI?=
 =?utf-8?B?bWdLTFQ2cFErTXlIK051RDl3VXRMNS80eUpuMVNmY1JueGdGbEl1K2Zvek9Z?=
 =?utf-8?B?WVdOVXJzMEhqc3VKa1FTN1YyM0JNYk5lRWRvTjZYZDJreS9IQmg2TDVnWkZM?=
 =?utf-8?B?eFlEVW40KzVyaGxlK1ZwdjJ4b1hWclpwRXVyWnZIdVZCWW1MRUZCQ2h0MWlL?=
 =?utf-8?B?Q3g1dWFlOHorSkkvL3lmWVZUVE8xNEd5b1NseVovd3hRV2NlWTV2UTN6bFFh?=
 =?utf-8?B?QVVSTTFDbTJnWmlxWitnSzQ1NUNSS2tnalZzT0VpTHdzdXJwNm9tNnZuNncv?=
 =?utf-8?B?QTRraFhZbW5KWDZhelRMQXJMbzFlbzdwS2VOdDNZZWhGdkdTRE5ocUFVSVda?=
 =?utf-8?B?OU50UEJBemFvcFJMV2FUR2xxOHFEVlMwQWFSbWRXZkhUYjhnZkE1dDdyMkts?=
 =?utf-8?B?WlpxbWpJbXZlTlgrZ0hzRzJNdHBtaHR6U2dXZDJoZG1IMXRZQ0FxWS9wdDg5?=
 =?utf-8?B?UG1ibDdzWHlGQWJQNEZieURxTkR6WmZYcENqOExQVmszWTRPNS85Q1R6ZkFu?=
 =?utf-8?B?SWVwRWRJbjl6d1QwTEllZU5sV2cvNFpaQkxoMkNLeTZsREc3MXkwK0toMzhR?=
 =?utf-8?B?amRFZWM1aU1DaVFDN01TZUNja2pGRC96Mk9JenZ6TTFFU1E1ejlrR3BkdzNX?=
 =?utf-8?B?d2owdy95MzVYSVkxRloveGNxN3ZrazZyTGdjY1AwczlHN2VZMnE5WGd3Q1Bl?=
 =?utf-8?B?SG5uOVQ3L2w5SmdPVlV6ZXJqdFdzL3Q0cUhJL3FPRXdOWkozYXRpVmRXZEo2?=
 =?utf-8?B?eDRSTTc1eW5pUTJrVjBEdnpKSmZlMVUvMm53T1dVbzhwOVlZNmtHaUZ0WVhy?=
 =?utf-8?B?ampGNzMrSDExc2pmS1diSFVSZTM1QW1oaXp6bGVXODZ5cWVtRmpIUlJzaDEw?=
 =?utf-8?B?WkZ0Q2NDS3hJdEptTW0wODgzQTNIeitmdEpjVXVxMDJjOWxvVlVWeWxEYTZn?=
 =?utf-8?B?ZitkV2QvcUV4dDU4Qk4yU0l0N1hoOXRBc1kvcjJOUXdFVWpxSUl1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66eabfb-e335-47de-15a0-08de59f190d2
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:05:18.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+TqDwGoKTuSqOw7SbTDJAdF45MnSnn3OW4xfuzthZU/PLXwVsXHk9sW5qHIW8wEu57vyr9As8bL8QupKUpj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

On 1/22/2026 11:23 AM, Markus Elfring wrote:
> …
>> +++ b/drivers/accel/thames/thames_gem.c
>> @@ -0,0 +1,353 @@
> …
>> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> +{
> …
>> +	device_lock(&dev->dev);
>> +
>> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> …
>> +out:
>> +	device_unlock(&dev->dev);
>> +	return 0;
>> +}
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(device)(&dev->dev);”?
> https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/device.h#L913
> 
> Regards,
> Markus

Hi Markus,

This patch was a move (leaving the lock/unlock calls intact). I change 
the lock/unlock to guard() in the following patch, after the move:

PCI/AER: Use guard() in cxl_rch_handle_error_iter()                             

-Terry


