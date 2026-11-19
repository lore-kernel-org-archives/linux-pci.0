Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102244;
	b=F042i8C5Cnb9lWHsnRdbyfmRUxeNIFKmFVl8Ef1jxR3ndGVrxG4BRUowfd4Q2ANGiEQs
	 clGpuKwnHGXq2d/Z42rmAWDX7aZdKqB5HP0c7NNYIknKE7ws+uFSThmX7lHJg3oRsJ2x4
	 Q4LNn3Fw/GXQJhf08KG96umEAaNFE1oR0JuX0nbt8ce4jSei9dcIdr2+G5Y9uQtzuqyp2
	 /S82wex+qyL19ZJA0yHbNE3YqA7TT/heLVHoBmPwv6P3DBlYGGWdN/7FDt/VK+/zZOCKM
	 4HyYq+1ppqOXBDMxYz78IhzkM61EpO/W3Swjlw2mywCsw8xIFrNWQycIc4Cf+gseTtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qGTxG4yDvY4fi3aqryS0E9NgEOdTfrWO1a/+NFDB1GU=;
	b=TjyCNFjgrfc1QwYwOBd4/xy4z3Y7oFZHUuoKb+nbODCeNd+lTkM507pJWciEGPe0teVN
	 tL+v5OOAckBTRPCGdm5BaUwcCmsGLSoVYPW5VTjWIvR3zxhrpUV5A4Hj76lSfXR5Wdu7G
	 AGB/1ljyKTdDiTr+wif9sN9VCxkjqURvYxaEtD6MsFMYogOqiC07ydRHISRhrxjbm0LMF
	 AZF2gTLlHozPjj0sVo3Fo7+W8h/Y1ayEUyGw7O124BuJUNtxa/h2o0ywAaqEDb2XkqYi4
	 idutspjyMPitzPyIgbMSR9jNQf5KNgljvAQv/5GZw9TUNuclCN2KWvSx6I0Tp5Msofg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DofbKSk+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.56
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AE606A324;
	Thu, 19 Nov 2026 15:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E1AE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DofbKSk+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD0P+zgCnDok4I00NSJtOGM8uciaddX7J5GoOxGzb2B3xcv/a1qhAQFU+jlE2OPOcaEEN+4E1gj4zDhpv+xXn5p1rO5EL/IGAYMojfYRLG9et9D36kFW8gGmS3plM22ujprrYaas4mAlNPNralQtOVxYn9sDtCxGMOyjR7CrZJQatRJHwJXpNJ6OZG7f/uFGvCUse33EuxYvxq9v7dTzlDiGE7v0/zxuQ8G6w3Uiab8isFdTjC5ZJjqoaw8YBQRjq3NoJ1C88/AX/yNs4dDYDgmT/EhWaeiwkbGcRIMWI2N6nKIzfeRH4JCwFJ6f3V5WQ7rji8v0gQMLKJiPGoy0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGTxG4yDvY4fi3aqryS0E9NgEOdTfrWO1a/+NFDB1GU=;
 b=efTKI+t2pvHpf2JLbDZbo/ui83B2xtsEzmudkOBsbhcFIeyAzoZ+FAs3xh2NvcRJuh9/imNuzl/k8Y2824uwMwt+MXV5WSsXubiQpj0/+UH+EKmD26/KYXirj3xYdY0l874x5Oz0Sf3Q5eAxnIcZnphr248Jo55MRM+CvCYRaLjyZ9y8AtzrRwX/EBK9nKyI8kmwp218fgZYLYvBdbJ/djcdzEUeSBvsUhxT8Rtpl+mqY2iJbel0dU0iOocLo9xneLy5pQA5jLJmGBA/KfD7AvYLwDKeqSzv5EkEWsifWe9KGoz4lpAgT4e8/SyR/kWa2hbWhaFwPSHqblJOXXJkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGTxG4yDvY4fi3aqryS0E9NgEOdTfrWO1a/+NFDB1GU=;
 b=DofbKSk+WbrXbkor7jhEECmtPAXYlYH++LozxxfjuBFTmqhGR4nrYNDiJ7mCtbv5qkgWTdPD7tn3KncxvKZ2iJjp4IbLmKcJFfUnAa66MNbUR19UXL9q6nXcqpW4RMIUY7KoBe0fxDiZKXNTHTOxKTYjsuDdoaO7h+fErdlhAdA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:30:34 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 15:30:33 +0000
Message-ID: <5cf8f937-acc8-475e-ba0c-6be00defbb53@amd.com>
Date: Thu, 19 Nov 2026 09:30:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Fix amdgpu detection of pci=realloc
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:806:f2::34) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 43508cbd-7cc9-4938-a244-08df46520cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022115727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HF9NMoLw+YukjeS3UN6dMRstEdECEPCJWnDSYCY7fSHqJUzj3EuwzICnEs4B/6pBHhzdkz0jvbfdnSO0TNGru7P3bv1ensiG2qaP3juWQelNqryu6ibv4FhEzSlqa31NQ6hmJWn0qeOtJCB718Gb7LoJyHIOVItSEDHrx9cvfbsmJsLf+AinT2j2LLuDAPM+9vE2y8ZShMA3EF6DaVVTwn5VGFe7DydU9oDzpSO1uGKntLsqAtFYjUom8H4pHGHAeZfFaq3RpRnb7CxDLFal5q63Ep2cM1pNNl6JjTknxtZnL7KHPgEjUMOTG34iQQHwrVeqZlllaj/mLT8/HSzhXbLiAm6zVVSR7Q2Up2yblyzuvkVwYOhFZezDkSaX59P8Hw4vLR3ygXYXICviMGNEPVPW8CMOjo0xvuEH6futtZ1Yc8EGCMlcneHs3O+8FGnazJuGnf6MqyyKczt4ivhiS3hU1aaK7BgK4PjWXRqxQwTPfKOdPp7CIhLLDXi2jmEz1O6nT04Nce0px1cLZkgPH7H/dIyXi5xQieqebL0HFbRS0QJliQ+aqjP5LCaIxCbjvOU9iptEKu3yhu9BT1gAJj0QtK4aRBmBzGhsqIfrqekyh/LTQpWR/0MKjiC1TUd/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022115727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2U4SjNzR2NockJvMWdEd3NVYXJQYU81azlqUUUwUXVLeHkyb2F5ZCtyQ20v?=
 =?utf-8?B?OThIQWtYeXIxRjRncUR5elF2SGZLdDRIVks5bGVlVjVDdnk0Z0hzWWFVTzZz?=
 =?utf-8?B?UUNVcFBOaW5MVW5Za2hwclpxdWlybThNTld4R1BKZndSbkZ2RjIzdWl0SzRT?=
 =?utf-8?B?aUpjQ1VGTXNheElNQ2t5dkh3MzM1amJ2OXRwdXVXc1FScUlKOGo2L1FhcHlQ?=
 =?utf-8?B?UzBHSGtkbFd5UnZUMm9GNlFrcVM3ZnZHVys2bi93MDhNakJXTmdnUjlML3Vw?=
 =?utf-8?B?bjJRMCtaeVZvTEYrQThyRVJWTHI1TkJweG0vbUROWVYzV0dmRjIwVDlyZHVy?=
 =?utf-8?B?Zk1UVkZiNDRFdEQwSVNtUE0wUjQwekF5c1NqQU45WnhOYXlYbktuNWJkKzFk?=
 =?utf-8?B?djBLZmxqNUIzb3lXUlJzSzhMYjRvY2YrVjkzUEJQaTg1UURacFRKK2xyR0ox?=
 =?utf-8?B?Z09PTVpEeXBLZ1ovVGk0TWNUalRuVG5iaHowbmhZZnV2SGk4Y2l2eWdpL2oy?=
 =?utf-8?B?TW85YXYya1Bzcjh1aE9BNU05SXRmY3pXaHg4NVlBcE9zUFBHM0ROa3VrU2xK?=
 =?utf-8?B?dnMxZ0ZGNWdib3I4VGdVakJ2OVRhbFlhOGtuVml0dW1XTUpaNXlvQXJzVW8y?=
 =?utf-8?B?bnYvTFIzSXNPdVR6Z1BtbXdNUnVpdFYwMWtSaVAraTB5bjJsMGJVbVJ2NERh?=
 =?utf-8?B?SDBrbFpvQ21YUWp5U1ZtUVJseTU5bWJHMVZDb2VPU0NQcXpYdVVlMU1mSlZy?=
 =?utf-8?B?SWQ3YXYwU25UaW8vd0w2SUl1NkR0OWVFZXVYbnkvMWkzL2VRODFzK2V1bUZG?=
 =?utf-8?B?cjhhVWlHRkdQaEh1aDNsQ3lCZ3d6VE5UQlk3bFRYYktXVGx5azJyS25wZnR5?=
 =?utf-8?B?YmpzalRpcU5pSmp5L0FQeUI2NzV3Q0VERWxvZ2ZKT3cvYlJORDdYdS9xaHZv?=
 =?utf-8?B?dHhBdEgvaVJHbWxsYVZ1Qy94cHRZKzRKZUVodmJ3RXZ0cW5CNVdQTDQ3NVZz?=
 =?utf-8?B?aEhIS3lhcGVhSjlCdUJ1TGNhaXpSbG1JODlOSSs0d0RGMUNuVkFkODVYc0J5?=
 =?utf-8?B?L0Qwb3VUVDlINW4vdmtrZ2QyUDloYnBQcEMwSGR5ZnB2Nk1aWXh6NUc2d0Zq?=
 =?utf-8?B?dFB5L2lReEIyM2g0bDN3Qm5wK1JoRFdsNGwxdHYyeTYrQTFzMEJxQUNxWVh6?=
 =?utf-8?B?RlpkTUhyN2RPakJxeS9vTWJkc1FacWhQNGFIRzkzRWliaWZNRUlxWUtRdkUx?=
 =?utf-8?B?bUQwNGwxZzZUSmJZOWRxdkVLTVJCamFzcGp3Y2tKd3FKM2VpTEN5Q2xDMmV1?=
 =?utf-8?B?WHl6OEQ2dGx1eUhCRzdYTEFib3Q4MlptSTNjcW9VR2NmMkIzcEFHSXd0N3JD?=
 =?utf-8?B?Q3lDL1JHQ0ZscWlSYkE4elcvV3ZqTGNmQTE1ZnlNN0NHYzgwdGlJYlBVaGI2?=
 =?utf-8?B?OU5CSFQ3TlBVVXhreE9WR3Y1YWp5dHV2b0I1ZzBGc0FlU0FYWGJKV0NDenpV?=
 =?utf-8?B?dHdlaE1PVm1QQmlKN2RVc1JZT0FHeWxyVGNrMXBhbklIY3RHRWdNQ3JlK3E2?=
 =?utf-8?B?eld0UEJrb0ZyY1JERFNCMnVGeHd6dHNUZkJESm5VdzRhVkJXcDE1Y1BmeUtm?=
 =?utf-8?B?c2tJb2xCclRYZFppZUhrTzlBWTZ2VTVkdGdIdElpZXo4Z0kxaGVsd3ZpNXJq?=
 =?utf-8?B?ektmbTNWYXFSeWRyWkczaElMTDNocjFhaVhmQlBZeW1acHBDSk9ab1RhZlV4?=
 =?utf-8?B?NVdaYjhWdDNJNU1wQWg4T05BVUhMM1BrNERrcDRwTTEyWVQ0VmFiSm1Dc21F?=
 =?utf-8?B?US81cGhCNjhBd3pIN0tXc1hUM3JiL2srMkxKNjN5TTRiZDhkUmIzbFBTcTl2?=
 =?utf-8?B?ZFhWckRXcTJ6RW1GeURKMjBXNlU2TE1wa1FjbmNycGNLODJUM2h6SlZiZE1o?=
 =?utf-8?B?dUZaN0FVVmdkVXNaOXJGZFM4ejIxN0NLWDM3elB4WDhiVzI4SFoyeG1RSjFX?=
 =?utf-8?B?SXYvbVM4NDlIaGltazd6NXVMMFBrMWVQdUxnUk5qOTZRNExtTjJ3VUJlL0ZP?=
 =?utf-8?B?SmVuOWx0Q1pmb0tFRWMrUW9STDRGT0hnQkN1ekpqTWt5VFdBYlkyallPWkpI?=
 =?utf-8?B?QUdrQmxYYnFyWXg2bWYweVNoRC9oOVZyaVVUSGxDb2M1WTQwRWluOC80bUZM?=
 =?utf-8?B?d3Rtb1lsSC9vRmFtY3dwQVNLWHRzUHN6ekhiWGQ2ZDZMY1Rhb051ZWtjd2pC?=
 =?utf-8?B?dHRFNVZKWCtLaWhmam5LaXBscCtKUjFLZEZKUWF5aHFvTjRGODdGQXMyK1k1?=
 =?utf-8?Q?9MsPvfYHM2hjbbGVpX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43508cbd-7cc9-4938-a244-08df46520cb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:30:32.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCs2sj/wUJfKiovraQBt/f6Guk9T7sEwfTB92xCDELB+yzBxG/gNmJk55Dml7NHKCfq5aALEmyJ8i0GnKJosQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142



On 11/11/26 10:43, Mario Limonciello wrote:
> amdgpu needs to know the bus number the platform assigned a device to
> be able to match firmware images against the right device.
> 
> This was previously adjusted to be a soft filter due to
> commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
> soft filter") where if everything but the number matched to take a device.
> 
> This however fails when there are two identical devices.  Instead save the
> initial bus number to the PCI device structure and then match that.
> 
> Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
> Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes in v6:
> - Capture the firmware secondary bus number when reading bridge windows and
>    ignore unconfigured values so rescans cannot replace it with runtime data
>    (Sashiko).
> - No change needed in the VFCT consumers; they continue to read the cached
>    value from the upstream bridge.
> - Link to v5: https://patch.msgid.link/20261110-vfct-regression-v5-0-f49fae981bf3@amd.com
> 
> Changes in v5:
> - Record the firmware secondary bus number only on the bridge struct pci_dev,
>    guard it with a validity bit, and keep it across rescans (Bjorn, Lijo).
> - Drop pci_bus::number_initial and have amdgpu/radeon read the saved bridge
>    number when matching VFCT entries.
> 
> Changes in v4:
> - Retain secondary bus bus number for a bridge across rescans, and the child bus is initialized
>    from it during allocation, before registration callbacks run. (Sashiko)
> - Rename variable to clarify it's for bridges (Lijo)
> - Link to v3: https://patch.msgid.link/20261026-vfct-regression-v3-0-fe9586ed6978@amd.com
> 
> Changes in v3:
> - Preserve the firmware bus number across bridge renumbering, capturing the
>    secondary bus number before pci_scan_bridge_extend() clears it.
> - Adjust member name in all patches
> - Add tags
> - Link to v2: https://patch.msgid.link/20261020-vfct-regression-v2-0-d2394d11450a@amd.com
> 
> Changes in v2:
> - pci_alloc_dev(NULL) remains safe.
> - For buses behind a reassigned bridge, the PCI core now saves the firmware secondary bus
>    number before clearing the bridge configuration and carries it into the newly allocated bus.
>    Devices discovered there inherit that original number.
> - Add changes for radeon too.
> - Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com
> 
> ---
> Mario Limonciello (3):
>        PCI: Cache bridge firmware secondary bus number
>        drm/amdgpu: Match VFCT using initial PCI bus number
>        drm/radeon: Match VFCT using initial PCI bus number
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
>   drivers/gpu/drm/radeon/radeon_bios.c     | 25 +++++++++++--------------
>   drivers/pci/probe.c                      | 16 ++++++++++++++--
>   include/linux/pci.h                      |  4 ++++
>   4 files changed, 39 insertions(+), 29 deletions(-)
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261019-vfct-regression-2142fc52852a
> 
> Best regards,
> --
> Mario Limonciello <mario.limonciello@amd.com>

<ping on this series>
