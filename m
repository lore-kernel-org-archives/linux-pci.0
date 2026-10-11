Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424B28690;
	Sun, 11 Oct 2026 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687278; cv=fail; b=Gy5JtHJV2Z1LBsQ37N8BOd/Z7zS2EpDvfUKLD0dLqSrRNSj1TD+utTn6RqYKzWKANBCyb3l0E5eOIDmNg/RJqMQLD0zkdBpGKkC7dFBZPh7e/P4zM4Qi+jCoiB3NgaYdLDkEQoP10WgKTB4udP9pOHcllOLM6ynOhPfrNUf+cKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687278; c=relaxed/simple;
	bh=AFVQMguJAXsgqTjivy0nBKZAh8wvCBf2YKPMtKNp0no=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F96we5OVHERWEaBXZI52O4jn7dR/8989FzXYOwUHnRpIiswPBNh+Av3+yMZgh1NSzKNL3orajihuYKZsg83i+bnxkDy0lUgN/zmZlCqmRpph3q89qziOHW83bdRau8lNz82e4my1pMH82QBOCz69aHVJRhYYM3RdO8Il9FUq4qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gaazjVyQ; arc=fail smtp.client-ip=40.107.209.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gaazjVyQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfkmFqDB5c+BprdMLDOUOfYeQ2Fi/bnGH89OMBnLVP5jWZlEnjZCTEeNcB+MYDzzZPuwUW+KMgM/15qsx2EASUBDaYJJk+ptUDsCJ52/tuXxnaXhHSpDKxFKOSGq/dl37tC9RQMtxbYU0ejh5ugGShfYkq5l5WwckIw05IOby0qBSE1lfY3YDiysOvov6YAxXbcIXe9A0Oyx4BGXsLxmi+leDrmO4WuJyFT8QpvZ/sn+gd7WhltQleQAglPRvHmnX6FuGe6VxO1j1llSmIghF3whgvlOr2Do6EMGhW39ijQJ5IeEP+wY/7oNeBNBermsGnXNj9W0sGCiyxmzP2tI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgfHSDsA570Qm00Gct9l8Atzc3Qho9E9vO4XzU9IOTA=;
 b=pgRMOKhEhVFJ60IZ0hKRACtuLoL5Zrvm/hpJcbY9XtWM2LuxbcVKTaZEISyvfznFtt1IajoS+Hz3TZr6iy2BbPh1nDRi06EFkp3vei3QEfJofRF30SHQjvxKfvsFShC7Ho5zi28tCdiSNvw5zoQ8jq6usUtBwMrT62dAFhhRoqhnKAWbutBwEfKJ/91YT7s4f/YwTKRJRFUjNRJpuZGbVlKVhL90vcGgA0JiLyWOCtdjrPj/rQlVpQhAa+z6mZ3pdr62CkGBYY/Ys4k8myu6fB+H0Y7Gqscrm4ZyAUmo/4fDAQH0aPDruFReYnebQJu2A9PMBGbUmAiIJONuM2hFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgfHSDsA570Qm00Gct9l8Atzc3Qho9E9vO4XzU9IOTA=;
 b=gaazjVyQh5F/N75luIQWP1qQwJnn/YM8ejny0wFAy9zHTHLPJ/yKeDMGHJPNFfRS/yjCLTwYxeD3GsxYlelcyo33YnoUkbZDmG7JNzC4Ur4mokDRdHJaMhjsUCr/HTnwmDPavEj4/2ur9cjHHnKVh4JL8MejCgbvySWZmkYXxQzMMr1ha0ms8/BcJLQW96bLp06bDOFytkcLw1kjiut7I15T1UjkPhS1rbi5t1VTpil/kqnnLF5Q5aKBLrB3bdVHK/aL/+nOufbMq1aI6NFAfArO7nboQPEHE55s4Yfk1H2JMh8LpV00wZi9T+z7ByVMwFD99Btl2qWx6anaQuKM9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:54:34 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:54:34 +0000
Message-ID: <39aa7a50-ad54-450a-8d46-cdf1ceb36e63@nvidia.com>
Date: Sat, 10 Oct 2026 19:54:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/16] cxl: Share CXL port upstream PCI device lookup
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-3-smadhavan@nvidia.com>
 <4d2c765a-0d77-49f9-8e6e-4d80137df513@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <4d2c765a-0d77-49f9-8e6e-4d80137df513@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c550c33-8356-4157-7d99-08df2742fb52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|921020|261009223027099003|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aaJSLc5b8+rmhpMQRyDiI8EnETurdiEiBMNVN0uLTVBNJ1VtScw71Ui4plIApbmFZhVdW0CBoe1+cd1zDaFyD0JWM8K5T7G8YuObif9WR234g0yhlGyUVynIwAX079C5OpODSSSr+iIhS0gzAUWBrDgdwvEmFC81xHoZAmGo9g1UG60Mgw8nL0HpiUspz30nWM7uuGcPe862YN2bHOCHYhTZVkn4jWv/rCYpmhjLbhvyXKhh6DVWFH6pt1l1ln6fZKESzCUp7KGFgwBFBA1EvHNmJwAEJOOtsgSk5m88e8Ed6ism/e8hmdU/pCXMBUagr+F+gxKfqfWP5IzDubcrRFn5Tc/u/6i3Bm5uKQqM0GqQs6MXf9tsVmq1UNp+WE5qi+375YJGlKu7VnX9ekNPvpnJfdWuYWVwWZZsfkcp1IpdGIzsp7NHM/deGtC+JkyefQTVmOpy9tnViKXEhSGFBalnAqnux5m/cPIWcXSGk7lEMsdhDON9HpTnektLlwLiwyX8/9R5nxEsjO5f53l++Znvlvvp0vOZbngT1j66Hpe1vdDRFAUAWZFeyAXPnEDebzV98O45tD7RIIDHbCbkazznmq7JfmtYw3dirU84o/OYrjxOjKYLRNtUW0+UxE+ugp+WRzIygY/da3OjVG1lQg4Ja3Ejp/Yz7FehJMCGRZQBaRgTawN/9l6fBXnZKulvc4y4xpHgtA27DJWYV1kmmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(921020)(261009223027099003)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1htd2NBTVVVV2o5UHRWYmp6VDR1aUJxdXJQZ3Z5ZlpCTHBEeTQyaUFyR1ZX?=
 =?utf-8?B?THE1WnhtYko5ZWl0dEprRzV1V2twZjRLNm9CZ2ZZaVZZd0ZFWVFLbW16dVYz?=
 =?utf-8?B?MG5zcGppVkQ0SzI4bHpWSFhlVWVtMGIzdVhoZ0ZrQVptT29uMktEdTdhc1Bs?=
 =?utf-8?B?TW1IeDRxeWVCZGxqaG5NbXBMUXd6SGRRRmF2WVY1Z0NNSzRwTktseGlmNUpl?=
 =?utf-8?B?TUlTN1d0QkgxalRnVmJNbXJSMk8xVzI3VUxhSXY2NGp6RUFPczF1MHM0Sm1z?=
 =?utf-8?B?VEo1Ti9SUm9xdURCVXViclFoYk1VbVN3VlBWWGR2aEhlVGVwMmhFMUZCTkM5?=
 =?utf-8?B?czZ4ZEhOZW10SmY1Q2RIcGJRM2hEVEFxQ0ZTK1B6YUlVUHZnQ2pTVm9qQm8w?=
 =?utf-8?B?cjFQRHBzV3YxV2cxc1FYZXBwN2ttRnR1aStoWlk4eklHd00wVzg4L2FlSUdp?=
 =?utf-8?B?NWJoQk9LWlN5NTJIUnFEK3JFSklHbkhxZjV2V0M1NTZ2bkFWRjU0SmxBbi85?=
 =?utf-8?B?eDFvbzIreGFlYUpIbnNzSGx2V1ZzWFZQTWpqaHBzd0RENm44Y3pEd2NKYytR?=
 =?utf-8?B?U2FZYk81a2xONmcwemFLMDNOQWxqMzdXR3p5NjA5L0tlaVBiZU9qbXoxSEtX?=
 =?utf-8?B?a0QzZEhSa0hUOUFWUlVEbkpWMHlQMDFmOTgrVldjVWg4QmVFdVdhdDU5UHVH?=
 =?utf-8?B?WGZUelNRMnlYdHlManY0WXROSWFFOWVuTkNsRlpDTFlFNWFQMGErQWZvN1hC?=
 =?utf-8?B?TTdjSzJjNjRnbE0rVWlMUlBDY0Q0SXVVNVJPbEluZERmWXdqRlo0aFNEMlc5?=
 =?utf-8?B?LzFmb1dtWVVPVENXYVhMc1Y2dnZCS3BjRWs1ckNuM1lZR0hwdmpRUmphKy9q?=
 =?utf-8?B?U1VwQTJ1K1lDckZjRm55SmdZWDZoamtoUnhSSitwbVVNek4vbTZnN3FUTGVO?=
 =?utf-8?B?blZPUUNzQUpoQmtudTBjVDhzUUIwRzIzeWRzVkVPVjlIWU5FSkZXNzlsNFVF?=
 =?utf-8?B?QTJZbytnNFFCY3lPZU1jQTVhRzYxc05DRUNJRkJ5QS9YeEJVc2dpSVNqczhx?=
 =?utf-8?B?NVFTNUhhT0RmeWMwWk5iTmxMZWNZeFVraDFEVFhlWU0wU3Vuc3loa2ZZR0lF?=
 =?utf-8?B?ZElGN1VlUEQxTWZvWWgrMk9nYjVDNzN2VjBjNWlvdTNwYmsyTFBpZ2FQS3Bj?=
 =?utf-8?B?eHRONUpBb252V0lxTUltV1RzaFlCa2xTRTJtRzRKaGN0aFErUWppaGUzN2hj?=
 =?utf-8?B?dzVMY0pCY3BaZjNNQXNUcmFtdStxRnR0YzBMRkFVQ3RPbkppSU8wam5lSTV5?=
 =?utf-8?B?aTlDTUVJZkhOT1RqNWRNUFB1TVdjRTYvcGNsYW16OVozWlRyTE0rRjZxMkJq?=
 =?utf-8?B?T3ZvcjZ2czNVMWpOVU42YXJaZ3JycCtRSjRCVzRRWUtjajg5cC93QjJZcFpw?=
 =?utf-8?B?RUprODhkSGM4QmYwQVd6MnE4ZTEyc0tEZnZ2MXJxMmI1U2NUU3AvSUM5UWZt?=
 =?utf-8?B?YnBkT1BKK3liZ3NzMDRIL1h5MFh4MXo2ZVhFTmN4dlR4LzJRL0NudEUwbVIy?=
 =?utf-8?B?YTlTc05TUWRoakg5emNuSlMzeENwSHhYV09LS1BDVHVlbWV6RHRhZHIyaDg1?=
 =?utf-8?B?MTVFeFBFdkY5cmhOcW5aZTdCVWcyamg1eGxLNjlRdHlMU1NsTGJaNm1aS2Vt?=
 =?utf-8?B?QkgwN2hNRHkvTloxQ2lBNWhXc1NUMng2TFhKMERTam5SZzkyaGlydU5NK0l3?=
 =?utf-8?B?Y1pJbkhaNUEvdzJBdVBjNGdyMzZrSEFNZFFLZ3NjWTdEd1Zvc3o0cm1GZnhC?=
 =?utf-8?B?bjhVdG9nTjBZbHkzd1dhNk9YVXZ0cjZvd29KVklxZ3FoWTQ1VUhHSGFVL0lD?=
 =?utf-8?B?YWI3K2xkQUNWK3BpbUFXMHVpMVhpWjg1Z2dkY3hDWWNRY3RKRW9yUlNncGg3?=
 =?utf-8?B?Tml0K3RWdTJMdHNXUFhDNzQ1c1pXc1FJbFFlWjNlTzhuUUx3QXRRNU5YemRq?=
 =?utf-8?B?cXFEMVd6U0dPSVZacnpObjFTeFFBNlo1NXlsSFRFWkhNV3JsSTJ2cUE5d28r?=
 =?utf-8?B?L2k4UytDczZVdkhzaUhhQlhlTkF3UVZaWG5qWjdseDI2Z2lnTXp4dVVKcFVG?=
 =?utf-8?B?dFNTWTBpejBkYlZZOXYvb003WlM0OHA4Zy93ZG91ZjdLcWtqNWxuL1RQMysy?=
 =?utf-8?B?Mk9XRXBWRGV1d05WSlZlejJWWXVSZ1gzRHEyVDhKdHk5aVpVdG1uRUU2STN6?=
 =?utf-8?B?Y1dKSEF4d2tkeTJxZjZpckhxY0hJaFpEWkQ2a285U1lncFQzWkMzUWkveDZ4?=
 =?utf-8?B?bkRZSGROM2kwMDJjOHRzaUpLVkp4aFZKOUJmNDB3ODJxbHZaemh5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c550c33-8356-4157-7d99-08df2742fb52
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:54:34.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPsyhqDoM1eXek+fwG5fs2u8k/UKBmhVQd5LHEoAU3nut0yvthukXZa+8XImyJKJxA8Fh6kOiBnttTgiKCXgCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On 10/7/26 5:22 AM, Li Ming wrote:
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
> pci.h provides a __free() based cleanup function for pci_dev_put().
> 
> I think you can use "struct pci_dev *pdev __free(pci_dev_put) =
> cxl_port_get_uport_pci_dev(port);" and drop all pci_dev_put() below.

Thank you! I've included this in v14.

-- 
Regards,
Srirangan
