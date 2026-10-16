Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780046EC98;
	Fri, 16 Oct 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143174; cv=fail; b=WTlTY0LlteBhrBJHQp6QLPTfR5FQgEGQXw1hP5R6hwcAwsmvo3RPU0NpySAUVP/2GnnTjLCld/weLcYV2CoEqUjtfbqiZf2/RUDWBwJim+jbVW3dv4QB+eHaDVnKfzI7D1NfDYITYu0W+MULe12scsXupCYZ7QyFS1ybM3O8oD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143174; c=relaxed/simple;
	bh=iuLb3bsSPeSnF24ekv7HkEi4M1GQaGOZKuGFv6RHNEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bC3isWTohyllV85vDypRFmEo7MAdxNPVvMGXspq3huG6DB+10JnM6G9mWm526nd86BogoCxMLdmY5Oh/HnEBiGl0sV10OkAwqsZW/A+Z9kDkYyjI1BPGyYT4Xf/FRiIn18bbkHauM7NbfEFRF7LumYdwMt3FWunwyeWTtMCcZ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFM+irrB; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFM+irrB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRmYZg8OBPBbed1+wY5OcofsNSETQiggkFLqrTCdpcXllB2ak/c7ks0+tAh0/bMYgeL+fuxf3WVDz6vDk0dFnc26eJzlpW9qd6l63LRdizqI7lTKn/7cap5WtZ4XokcpLAPRrNPI2KarQFyg2gP72u4rC3RZqT930NeXa1Fiq8/t/rSMzr8hX5Bjs2EfTZCbRGwic2ImmwfKSWmZJaPGDDWP/WwoUWVbybz2fHGA+rPRK/GuB8nCvUIYCxYRf8Qye0edJewGzxd9K0eYnYojuEH/OnIWiVh4CWQ4XWgx7IRv3qEgo9oDP6Fhg1oky6Od2J7rGGKsixjPAnECIBejAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHlgLzGmzQZwQpqCpk94oROsztnZ3B1pqTeKGqDbtAI=;
 b=eBxmxZfXLIvKbXEWyH/XL7TLrzV6cbfzAP/2RZyQZ7ryUza/BjO7+vOqWrULD8YGc0k7LVQp3C6A/iwV2erkjCJGJXoqefi4nvDuVyOf0g+f0uPjQ609Uy8JHrwdBRbtDO7tqwlrAeBYpCD4QA+9q/kXDaYDiPJkiA79QCx08W9J6/GBv/bn+J3HE63edm7w45lf1sjOXkOTfNR27VyAbtSiLHnHXsdkMiILZRpMqPJQrhSO+IQNigeAXjrIGCNAevUEEpfkVImCX45u4tdPWRHG3GSze+HIA+oSKtb0uGlTlHK/rlaE6VmZSAUtnPQZ8BQKvIVCcl/gSl3/V0z0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHlgLzGmzQZwQpqCpk94oROsztnZ3B1pqTeKGqDbtAI=;
 b=hFM+irrBbWDjdChOlKIHai0yOunvUrou8M4CgU9Jd/gwgf3T7zz5YwosQy0+d5yMIz/WudOXKzkvt4MmVGQCuZcG6uIahlPC0Z8Rdntk/J4CBO4p0+BTz3ppE3YuEmdkO/z5CQoTVmIXsGX4CBR2jbFaYvGsSUwIZtmaxp6+GmCBVTdUp0v9XoueqMmL5kHJ8ACol2v51mHG7g0cYQfbfMva2112l9HCEo9kVqYVw3hjze2y/+DolEK5I8QxMdoUMjZn1jwjcfBHNK9TU4y2Pexq3K2cFQ42IduXIYULYdnNVr9laNeDBBzeg68HjpEFVO6K0V3PJm75Imze0wQWnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Fri, 16 Oct 2026 09:32:46 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 09:32:46 +0000
Message-ID: <73ad252e-98ce-4ecf-b767-aa8ae7802d62@nvidia.com>
Date: Fri, 16 Oct 2026 15:02:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] PCI: tegra194: Do not skip no-link Root Port remove
 cleanup
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-5-mmaddireddy@nvidia.com>
 <179198766519.63727.17783665861059106121.b4-reply@b4>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <179198766519.63727.17783665861059106121.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::12) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a079e9-d814-496a-0ec4-08df2b686fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|4143699003|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8whzaDw0uio1GEqBEJtdN3CFLjSD0kubVfCur4+/w3eKTbKmO4SPI3Kd1fLc93DaAaee9nvq90vS1V8JG/m5znj6pKPeIUPfD6EjW+g6jq4MAsnzkY9AfZKDVY0H9UL/6NFafT4YKvmJKj9n7Hpnejct0YyI6cnriApAdX4cHY+vWfFwUNuGaQbbrray0Gciv/n7ygXKXUvCccjiwcVvfavSZxhdMclveh0hmIAJAWkMaJgSjMWQ3i46qMOqbZRQjwM/jtoE4SdiB57T63GJbUthj5+fc8JHcdWRsoriMIkDndFQ7PHCwV5O61oa85AOG/SI1cJt4EH+e7yPEeNhOUm9divVL9hF7DGdOWHXMeUsOuF320rIi+Zsn1uoeOahSCT4uMcg8Zh4YSpfnDxEiwVkegeTYH4v2cnMkc6bRg/okZAdxR+B9+zDTzTuNuPwQWK6hvOc3ycivQwU2/BD8k4uD2z1Ci8M9Kzi/GROcF+b5kXuATUrTycwRhL6CeDvIvT0BOtZm/jQ+11TUySABkH9zC/1wAZowC4PFQymF7f9cDSF+aGPdFbNJ01uW132DA4MCiUenoTZrXgpRUkvUHIETJjCogjvU0i4iREPrwaoCvz35C0+LEMsqUSmtEC1u9vPEkCnjRv7aI4RT140WiHiZt4rquX5PBHmqBJABCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUMrK1ladlpWbHoyRmVJVTR2ZmtBQnM4RTZ5c2ZIR3NPSktBVklwcDU4WlNK?=
 =?utf-8?B?RDVkeVJ5WHU5aHZtUmIvRU5Ydmc1R0VhK1FzT0tZVndnVGRVKzBZRDd1bzdq?=
 =?utf-8?B?UWloVEpmVWF0bFVhd0xRQUhqdU04czJLOGtDRU5Hb3ZEMy9uUHBRZEFCMHZ2?=
 =?utf-8?B?M21iTkpqT2thaDFwZTUxa2FUN2RoTFlxWTUzQkRrNlR4ZGtXVGJhRzc4UHhQ?=
 =?utf-8?B?b2RiTE9GYmJBWHpGMGxjOWozNmxsd0cxckwwMjliNjRvdkdvN0hDU09XWTVl?=
 =?utf-8?B?dXZtV1hPeDN5SmZmTFNVaWxVWkw4a2xIdWYrLzBBamtMR1E2Qndubk5qc3Az?=
 =?utf-8?B?K1lXL0plSUdoUWNKRVRZTTFEdXNtQzd3S0FselY5eFFqMzRJWVNVdkNPKzBo?=
 =?utf-8?B?N21PeWMvYUhUbHJWYlUvdGhSOStncHF4THhndXB3MFhqRE1uTGRSNmFsTnZq?=
 =?utf-8?B?cVpNb3R6TmRoQWF3a1JmZklubEVXdmhnN21wNTRDWTJXMENnQTNLYUlqcDQ0?=
 =?utf-8?B?UUZyV0crcHBra2xiNlVRcGRVYlg0bE05UFB3L2ZkWkF3aElkM0JSaTFuUnpE?=
 =?utf-8?B?QTdPSHN5dS9HVm96MFV2ODVSQk44WFNqTUJibzFaWU0rcGJXTForaFE5S3hm?=
 =?utf-8?B?YUM3WUx1OGJyeExjNFMyMXJ4N2xmOWgyaUZwUG5kNmxLblR3bFdYRkpsVzIr?=
 =?utf-8?B?em9wOTB5RkdhZFVNdUJscHlWamZkTU9EbDJQTGIvNytxbnZsSHJETWhlTklD?=
 =?utf-8?B?d0x1SGdoUmRSbFlaSjFtOXBCQ0NUclZ0QlR2MzFMVGdSZEtRcHVmdktUSGtw?=
 =?utf-8?B?WkxBL2FPTXpiR1d1dVNRMmNrdnIxYnNSQXJDWG5LcUtoM2dGTG9ZUk9Zei9T?=
 =?utf-8?B?WU5JTDZ5QmJnTEVFdXRQUFBOS0tJNVZYOEZzZ0NwNmZZRHZrT3NRSVpHOTJC?=
 =?utf-8?B?L3JuSmcwYmpKNzZEYUxqOTViUzlncHZZdGJjMUE0RkNreENGdHdTekNrVUR6?=
 =?utf-8?B?Uy9sMEU1ZjZCNi9NdHJFL0wyUUdCblRqQWF4OGFtVC9CemhVbEtNa0tZbXZZ?=
 =?utf-8?B?VndGc21Fb1lLRGdROHJ5ZnREV0c2dWYzbnNod1NUTVMwSW9jR1hNeE1pN0Z0?=
 =?utf-8?B?Z3B3L05LOUNQS3dWbjB4YlBrbWdUN1V1Tlk1Y2QwaFdaZU5ZblFMcG1seG5G?=
 =?utf-8?B?VWUvVkNqMVVGN2NXc1JkTnlmZnBVb3FtTTkzTDc3ejZldFRtQnpyTEJENkxB?=
 =?utf-8?B?Vkl6QWFic0psWVU3ZFJoanVnbnJqYlRRa3F3SFloSkZPM1grakZWZ2xaU1U2?=
 =?utf-8?B?MU5YeDdoYzBFT24weTBVYjVBQ3hCVUtTVGJKMUJtaEZZczdnc2ZoTXRkZ3dl?=
 =?utf-8?B?TzdYNnNpMENlZU1tSjBkNHV1SzlieVJzQXRtcnl0cnhEcTR3cEFvay81eFR3?=
 =?utf-8?B?RitGRjF3Wi9ySFlzNXYrbXErT29nVGNlenFmcmVDaUJrTDl2RDJNbUc0R0Y4?=
 =?utf-8?B?NWtTMVhNR2RySXhJM2g3b29zZEs5R0VkU0JaWnF3NjJvOHg1Tzd4c1JhNFRr?=
 =?utf-8?B?Z0NGd0tCckd4NmN5a3hOK2laby94NENvT21VK0pudkdiU09sRGhXSlluWm1p?=
 =?utf-8?B?WlVxdVpoUThnckVxVUFKZEN6SkQybEhhNUw4Si96V1AwKzNicEVGa01LK0s3?=
 =?utf-8?B?SEJJTHFaQmlqV2dSVW90NmNPcXhPaGlLcTJ2bVRvYXprdDdPRHRNZHo0WTVs?=
 =?utf-8?B?djRWNndTakVXczlBR2YxOXpFaWRRcVhzbE16QXN6M2twR2Z6dmthemJGdHB3?=
 =?utf-8?B?Ly9NVHltSC92VnlpWG12SHNnZVN4MHNmS2tPM0QzK3FKQkhYOFR5WGY1SElj?=
 =?utf-8?B?UGlSUkNJNERIQ014VkE4OVJqb2xCNHdveUVZd0VFbGhjenNlQWtScGpNOTdZ?=
 =?utf-8?B?TDFXQXIySCthb0tEa05lSUdXd214Rkl6ZHRaaWliSDljQUhaSkFZcmR4OUhm?=
 =?utf-8?B?djNBUFlpeFlIWUg5cWEvL2ZuODRMUVpLaUU0dEZHUmliOGVsL0UwVENMeWJS?=
 =?utf-8?B?MWFUN1Y2Qk1FTWZrQnBPTGdMMWl6TUsxdERDVHA2Mmg2Y0tway9WY2hja0VL?=
 =?utf-8?B?MEo5bVFWUHVaUXN2OVhXUitmZ1NaV29WR0pKMlZHeVJjUU0xallrMjZOci9B?=
 =?utf-8?B?MFBaV0xkZ21EUTY3WHczVjNhUE8rRElnbWhTMUZGSFExWUxvRVVWNEVaTzd0?=
 =?utf-8?B?Tk5aSFQwNUJBdEFIVEM3MDFnMUJVaVJkTVdNcmZnWjdJNm1zNW4waDVIanZu?=
 =?utf-8?B?Vms5bHUrWU5DdXludFB4emtEWGl6NnhQVWlWa2VFVUx4L0xMNElFdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a079e9-d814-496a-0ec4-08df2b686fd8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:32:46.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQmLYVjOOnCohmyRSZr85nKkzmR3p6yHpuw7p5UW/90OCfZTgU8H64upnUhbgXKzhXfnymL+hURol32XCRZMgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638



On 14/10/26 7:51 pm, Manivannan Sadhasivam wrote:
> On 2026-09-23 12:52 +0530, Manikanta Maddireddy wrote:
>> tegra_pcie_config_rp() deinitializes the controller and disables runtime PM
>> when link training fails, then probe treats -ENOMEDIUM as success so the
>> driver can remain bound without a link.
>>
> 
> What is the use of keeping the driver then? If the controller is deinitialized,
> the it can't do hotplug either.
> 
> This patch is fine though.
> 
> - Mani


This behaviour dates back to the original Tegra194 driver review. Bjorn 
recommended decoupling host-bridge probe success from downstream link 
state, so Root Ports remain accessible for enumeration/debugging and 
possible hotplug. However, as you point out, deinitializing the 
controller defeats those benefits. The existing no-link policy deserves 
a separate review; this patch only fixes the cleanup skipped when 
removing that already-bound driver.

Ref: https://lkml.indiana.edu/1907.2/06835.html

- Manikanta

-- 
nvpublic

