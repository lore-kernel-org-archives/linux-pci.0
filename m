Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162575;
	b=BimnfTtBL5ZGcg6hDZkCKhghGpmA73ybk8ggVO9IM9ALou6h+XmjSJTyIHKlHM1zOxEU
	 EvXmZY4mFC8TXJrE+wXM7le+URYqk2rdL/6X5w/fCCpU4tqX3HsYx9HI7O1njeGi9fy8k
	 FPqYqukoqxT4muglEZJhx0bjrBLGp8NsxmehUuIC3HrfMlk+GzUoOgtJ2JSGE/atJ6iTR
	 BlhBI1ixKNCfhef+5J+Mngn/K/MHwLgo9HDVtFo/IlvAo0Lk4Yx+8h2f40CFvbJWHzZ2Q
	 JgdRpUyeFg9K0hL40kC4vCGUh+U+cmqUfYf2MjM4zLSual4NR0agOzoEjKjMaQSxhtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162575;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=4FHsSJb2yp4jjpPXtplnfP6dHftXBjr/mz0TFs9/S2U=;
	b=06nuK44O78WnA6nw/mk998riKAix+Q8+0FsjCWWGVqWT94aA7xdAhjCWnoQtOYa5bZ8a
	 Pt0EvvFLJEQVV2d00Ps3yn+cG8TDWc31CFPeitMnKEClRTMR2SZXLxLeyvPn4M8AcYxv3
	 SAKCWWeyh1cAq2ipl8OtSkl4rswKMOPO+XfGvQSQ3Onwf21QrjHfdZ08EZSRBgaFy4DzN
	 G7qkyYRFmi540C8w7kEaGUMRGiNZ7fjjilK4Zi4Fo7DpXDgsT37QxpiOVx8wrZxxBZtR/
	 vU0f9pfSCACPo7BxmYWQs0lgB0dHDkoUWoL8J2hn75lRMj73oY/G2QTLjd0k8Obv8QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZITY4HjS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.21
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CC606A326;
	Fri, 20 Nov 2026 08:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E39CC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZITY4HjS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arHey7lbGOzGY0tx3pZsZk3RTYWSr0Z4Ms8dexky+aH1Htu3ZZR6e3rbViafaPkZYkLCI108ezLm2AVmPQVRm30nUuiTcJw78lHvjW8DH0jj5PWkWa0sDFOq1SWgwef3G1799fD0Aoh1oxXsH/hz3d892IJEaLURkcJkHMhMVnXFWv+AOMvPumJuc1we+hgN2L4vsyDJPKDaJU7RkLfeo+LwkTExkhh5jQ5vDiTWKkSYaWTwx1TpUdKf5XZqk8ugsg6MIwod1k4iH6dGRQGdYNcQEb9Q3qMXGrE9h1DZliJgBcNKt5mYd2bsleB09QmobA5nD/acSg+MvWDbeGz/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FHsSJb2yp4jjpPXtplnfP6dHftXBjr/mz0TFs9/S2U=;
 b=B4JjLY1G2pb+abbhg05+V2P7vDbUa1e0GucP8/GHp9T+O98KxopCFqSoHzub2EAol5JUzoojlCWljIK20BYswBsh0s1qwbRP8QyZ6ZEVPBggShZZqerTFrbVSYaCGg5DTfoG6W+HDBzrfCnS4ZgMOaJH31OnxQJT8Y8KqQ0UP6O4OVvaWG9mThXLMXIq8TSySDXUlaHc2Y/8y24HXfB+siPc3sqFPzV4mNpwUPgSuEfbs0kqHtL0m9ANizCm4gc93i3AQ7bMD0gVMI7FZazM2iHVgO89xNwUS6WgY5KBFUEcmef7oHvHY94A+3rGMqRitIMH6mTDeywVNIyHWy786Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FHsSJb2yp4jjpPXtplnfP6dHftXBjr/mz0TFs9/S2U=;
 b=ZITY4HjSsEuEnyo04TFpPL2rxcsuXYD1tU9TP1k3E/C7UbRoPLNCvJ82aHyx3OBwbkM1gCCA2k8q/MdkIgBFCJMmSaWnFiBin6FER5fIZ4yEhG0Wx09A2mBQNUjM/UVCU6QUFYVFbUh1K6TWRRpP0Mds0O7HjW+L46n2txjkZ3TwZpFMcFyHQGPF6woHlY9Nrs7Ndejd56hKUwjFOrU9WUJLvCi1GXd6XgV27ayD9fcW4aBzWYJi7MVOeR39xEmh6OCogKnugOmwzdYhNAXgIKXt98y1QKkNkDtx4ulGG/QzeaGgiRLaS2jO7qVi6oB3GxX/67LhQRa4X3WVSZBrsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MN6PR12MB8489.namprd12.prod.outlook.com
 (2603:10b6:208:474::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:16:08 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:16:08 +0000
Message-ID: <1c5b291c-25f1-4936-8601-0660e3627b8e@nvidia.com>
Date: Fri, 20 Nov 2026 00:16:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/19] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <avyOoQjiD7Uh_3rE@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <avyOoQjiD7Uh_3rE@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: ce56094c-2f65-4b14-a610-08df46de8790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|261009223027099003|18002099003|22082099003|3023799007|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|56012099006|261022113327099003|4143699003|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Wb22Tffy6MbnLxztDim3yCgCB4r9BEDrqahWGWdVS999R66UCdg5qtfAyTTOqmIOZzm8cEHaSF9gIj+8TsLqDqrDWKuW8OoeERBODgWIo8RvrA/SomxHp8X9zY9+BpqM8d/az7p9o0dAVjPHov0lumd2F6PZpE3oQMqDfrnAwKdh+eMHmiq0plqts0/jWBKGxYfBlgFv+weoltIwAHG6OZJbk8btRpP/MbimB1rFhhE/MPSOv6ZXcmaG9nwJN/t5RJg6Z3AU74SPb2+7lc0pJKC6MR4qqmzn80esBnrgoyZ1GIjcMBOAH01nkI8ap1yK+FVMJSqKee0hG2f9n5ecpTHXgOtMZ80+pCpjwjJVNYiiDwo96JcCa1mPJRxULwijE8m9FLEA/TELtN6QEmGM2OeELYUanMtFlsyVPTDMs1sd1lLm8YLOtR/pPCNMv69eSLEbiGk01dIsASGDRwq7fdnWS8Kj+CZTlhO3ll01BCBWnE/cmRGSW3iPM9MzQacj88oP7hQadtAAvGujhrEv8V9cl35QKZMzKi3YgptuTJobboF8UNyUEWDxK64OXQIv6piyZHpnh4x9dDG8xFaM8FjOHITdlX742zLOTTEpvnDBeFlsoEVD0Sq7EGLnVkAJfO1OheaSbIwAZiWMMc7RPr84UX1CEOMgvoqiD43jCZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(56012099006)(261022113327099003)(4143699003)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFZLck5nZWhTMVRYZGpqdjA2eHlyZTdNenJFRHhKTjVxbnpPU3VrbGZEYXRD?=
 =?utf-8?B?eTRaSm92a21sMWk2YUhQRklFN3R2N0ZkSEdLM1d4dUh4Ylk4WFRnb24vdmZP?=
 =?utf-8?B?bWtYWEtQVSsyZ3hzc2NBUGQ3NlFvcExRNk9UYlNFSlNZdlBLL05BNzFyQ2FW?=
 =?utf-8?B?OHFrUTNnMGhlV0t4cTJleTIzWDk3NWIzcitGaTQ0cDhCSmRtSDNyU25TbTNr?=
 =?utf-8?B?RlJyNHluWkpiU1RWVkVRblFIQkxtd2lBLzVpeE8wMHRjTkZ4U0RxMThzVUhG?=
 =?utf-8?B?WFZoZkNJdkhVSFQ2Tm15Zkh4ZlYzb2pyVUxOVTVJT1lsR0xkUjdiOFpsYnVS?=
 =?utf-8?B?R0x5MGNwUE1FUm5zdlFKaWNqUjY4MDFTL3lxbytNU2xvSFBKcnRUSEIrZ0Nr?=
 =?utf-8?B?MlorL0d5R0huV0JnMDBvWEM2b3c5STZYTGx2TDlZaEZvejNJb2lFK1dtMXNW?=
 =?utf-8?B?eFB6ZmZMKy9vakZwcDZFWHJmT3M0MHN4YWZ0T3NqbU12N0NyMnNzNnQ0K3V1?=
 =?utf-8?B?RVpTeDFLMVFHbjFwMjZqYkkrZVk1Rko4QzBIUFJGN3h6QTdRZE0zOU5ycW12?=
 =?utf-8?B?REpzYStzTzVnVTV6S1pwZWNhOUF5UFlvZEpMOXQ0VFlXUEFWN2dPN2dXRlYv?=
 =?utf-8?B?VmV2bHU1ZXd1bVowejFxdEc4eTEraXQwVVVWV2tJdlkvMU9LU083RDJKZ0RZ?=
 =?utf-8?B?b1JEZnk1N29GbnowLzhzcWhmQ0JDRXVuUnZ2VCtVRGdqeitPTHlHYXBmb3J3?=
 =?utf-8?B?N3JmWjVVWUFqaUdXRWJDUDdpSE9WandiK2tQMEg5VXpqTTI3czNzUWQ5OVJo?=
 =?utf-8?B?NjdBSVRMQkxGSnRpRG9vZHdsY0ZGYUc3VUoyblR6V21MRVNHdUxRSmlxdVhO?=
 =?utf-8?B?Rml2bmpJazdkM0VhYVFrM0trTHMzL1Fka0lCV2pjdThObVBHTzJaQ0sxckZC?=
 =?utf-8?B?Q2UrT2ZnZVpjc3pOYkZnRmlHMk85dHVqMWNKbHVyMWtTL09kMTN6K1QvekJr?=
 =?utf-8?B?eUtsWENyYStQSVlWVWxXUG9WODNwKzZSQ09HWDZDenRUanU2NjAvN3VpUDNH?=
 =?utf-8?B?OWxVTml3Z2lGeTRYT3A4bkNhQzJYVldIanArai9rZlloSDlKZW1pMDkzTjFW?=
 =?utf-8?B?WkhxcGNYNi9yUUJZN09iVzBGTWZZeFp5MTIvczJyTDBBOTBnTmZrZjZqUE44?=
 =?utf-8?B?ekdMTlZ5dFZWdjgwdEJGaitiYzRBajJ5dWlLSE5nWlUxczdIMXRIRGx6eXpi?=
 =?utf-8?B?M212Um9ZWlVzczBvdGFLSmJxbjhxcDBXQzNNL01VT2VBYkhsUzBUclQzUUNk?=
 =?utf-8?B?dHd2M3BCTFM1RlpiRjZhcDJpQlQxT0paRElEc1FrUlpYV3U1ZElwM2V1YlN5?=
 =?utf-8?B?WHNBVGNSY3FGQ29jK0VIaHVBbS9aTHg4Mi9JNWFMMFlVWnVKY1YwMjRZeTNQ?=
 =?utf-8?B?QmZOM1M5ckNkYm91WkxyV0hreDFjdFdvSGpIU0lMTGd5M0VkTUFOdWJDSUFa?=
 =?utf-8?B?R3BHSi9oOEp1SjBwMUVnenpza3R2blVsQzhtNHdIOTBqWE0zYXlwMlBLNjBL?=
 =?utf-8?B?U0ZGT1o1d2RKMWY3RWtUc3RodlZGbUtyT3JrOHJsbjZhYVdYeUs2eDhXYVVr?=
 =?utf-8?B?TVh0RjVQTjlyK2dpSTZpNERwdHRLMXozRDgrNGpzckF0bVhCZVlWM1VoVUUx?=
 =?utf-8?B?MmNYL1dIM29vbUtkUUpKQm1jbzRlNTlWbzFMUFJTQ3lRY2RjUHQzN2cyOFM3?=
 =?utf-8?B?RE5vSldqVTZ2Um5KbDRpZGQ0eFZRcTNvem4rZGhhZ2REU3VTaGI3aTA4TU5a?=
 =?utf-8?B?L0s3SUp6TUoyOGVmdWNSV2tZTEszeGhBcTlNWThqUlk0Y1Q1M3pRQjV4VTRQ?=
 =?utf-8?B?RHlkNWNqcnRDV2thTXZYTFd2RFVYNGtFeFNJTFMyR1MwNFl1YWVRZUF1THkx?=
 =?utf-8?B?MHZOUGZ1VkZqUElTbHVRTnNSWEpGSVFVeTNjeVArYittSFBpRytNTC8rL25O?=
 =?utf-8?B?Y2ZjTHVkb2xQdVRXaC9Wdktic1d5SVhQeDVlU0VvRDQ4T2FTcWU4VG1YdFBj?=
 =?utf-8?B?ejJ6SC9RWVNEcHN5NFp4SndUR0E3aS94NnM0WXBDQm5hOHBGeGdYaHQzZjZ3?=
 =?utf-8?B?UVBEait0clRIRzErKzBOWmM1dXBQc0lKZEhOTkVSdkRmOCtWdlJvTWFpa1RP?=
 =?utf-8?B?aHJBRG1FdWxpWXVSU05nd1pkRlhIUUo4TzZMOVd4Q1dlcWNuTE51b2tzYWlT?=
 =?utf-8?B?UlMvY05tK2hndndNY1h2SHhTYzJIbXk5aUwxQzk5aVVxMVhWN01KTnZ2a3RX?=
 =?utf-8?B?MmIxeUR6anEvK1BtR1JJc2ZabFBTd2N4VXJDMXNhWHZwUTBnOTZOQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce56094c-2f65-4b14-a610-08df46de8790
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:16:08.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf6c2UHbAG2bHn0OEDFAeNDkGFI/Hux5b0922FuhQMUzbo+EyAoUxw+R4Agn34zdunRqZAvTtZatJ6XSaOfF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489

On 11/17/26 9:28 AM, Alison Schofield wrote:
>> Hi folks,
>>
>> This series adds CXL Reset for Type 2 devices through the existing PCI
>> reset_method and reset sysfs attributes. It disables CXL.cache, performs
>> supported cache writeback, initiates CXL Reset with Memory Clear, and
>> restores cached HDM decoder and CXL Device DVSEC state before PCI use
>> resumes. Active HDM ranges are reserved and CPU caches invalidated before
>> and after reset. The method remains limited to eligible single-function
>> devices with both CXL.cache and CXL.mem enabled. CXL bus reset restores
>> the same cached state and flushes the host and device caches around the
>> reset.
>>
>> The reset sequence follows the CXL 4.0 specification [4], including
>> CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
>> ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
>> define the completion timeout encodings and reset access restrictions.
>>
>> The userspace ABI is the existing PCI reset interface:
>>
>>      /sys/bus/pci/devices/.../reset_method
>>      /sys/bus/pci/devices/.../reset
>>
>> Userspace selects "cxl_reset" in reset_method and triggers the reset
>> through reset. Following Dan's v6 feedback, this uses the PCI interface
>> instead of adding a memdev-specific sysfs ABI.
>>
>> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
>> callback when provided and disables PCI I/O, memory decoding, and bus
>> mastering. The CXL path reserves affected HDM ranges exclusively and
>> blocks IOMMU translations where applicable. It does not offline memory
>> or revoke mappings: userspace is expected to offline CXL.mem users before
>> reset. The reservation enforces this for claimed ranges by failing the
>> reset while a conflicting resource is claimed [9].
>>
>> The global region lock is held from snapshot through restoration. Memory
>> Clear completion is awaited for the timeout the device advertises, up to
>> 100 seconds, so the lock can be held for that long plus cache flushes.
> Hi Srirangan,
> 
> Thanks for all the followups on review feedback. I think you answer some
> of my question above, 'For sysfs reset...' Could you explain the intended
> use cases for this reset method? Like why and when would userspace issue
> a CXL reset. In particular, is reset intended to be available before endpoint
> and region discovery have completed?
> 

Hi Alison,

I am looking at these types of use cases: a VMM handing a Type 2
accelerator from one guest to another (the vfio-cxl series), where we
need the device's memory cleared and its CXL state reset and restored,
which FLR doesn't give us. Or an admin or a tool resetting a hung or
errored device through reset_method and reset, without taking down the
whole link. In those cases we need the CXL reset. The CXL 4.0 spec says
FLRs do not affect the CXL.cache and CXL.mem protocols, and that errors
in CXL.cache and CXL.mem logic cannot be recovered by an FLR.

My understanding is that it is intended to be available at enumeration,
before endpoint and region discovery. I can fix the gaps in the address
caching mechanism to make it work.

cxl_reset is listed at device add, like the other reset methods. It can
execute once the HDM cache exists, which is right after enumeration.

> I see how the series saves state for restoration after reset. I don't see
> what ensures discovery has progressed far enough for reset to be safe.
> 

Nothing as of v17. Normalized Addressing is recorded after the HDM cache is
filled, so an early reset can treat a range that isn't a HPA as one.

What I'm thinking of for v18 is a check that doesn't wait for the flag:
also reject an enabled decoder whose range isn't inside a platform CXL
window (the "CXL Window" resources cxl_acpi registers). Until cxl_acpi
has registered them nothing matches, so the reset is refused. The flag
check stays as it is.

Both cxl_reset and cxl_bus reach it through cxl_reset_cache_prepare():

   cxl_reset_cache_prepare()
     cxl_hdm_quiesce_prepare()
       cxl_hdm_ranges_collect()   per enabled, non-zero-size decoder:
           NORMALIZED flag set        -> -EOPNOTSUPP   (today)
           range not in a CXL window  -> -EOPNOTSUPP   (new)
           cxl_hdm_range_add()
       cxl_hdm_ranges_request()   reserve the ranges
       cxl_hdm_ranges_invalidate()  flush host caches

So a reset on a range we can't validate is refused before anything is
reserved or flushed. Does this sounds like a good idea?

> I also see DaveJ's cxl_bus deadlock report. My concern is related but
> separate. Even without a deadlock, a reset could hold the global region lock
> for up to 100 seconds plus cache maintenance and restoration, blocking
> discovery and region assembly on unrelated devices. Understanding the intended
> usage would help assess whether that disruption is acceptable. Note that my
> simple concern is a user issuing those cxl_reset's on repeat and blocking CXL
> bringup. Yeah, that's a bad user, but is there any protection against that?
> 
> Adding specific questions on patches 11, 13, and 16
> 

I rechecked the code for avoiding the global lock. For v18, I think I can reduce 
both resets to take the lock briefly twice instead:

   prepare:     lock -> snapshot, reserve ranges, set reset_pending -> unlock
   do reset:    no region lock
   restore:     lock -> re-read the cache, restore, clear reset_pending -> unlock

While reset_pending is set, cxl_decoder_commit() on that device returns
-EBUSY.

This way, the long lock is not held and remaining is scoped to the device being 
reset: only commits of that device's decoders return -EBUSY during the reset, so 
a region that includes it can't commit until the reset is done. The two brief 
windows are still global. I couldn't find a norrower option.

I posted the same proposal with some more details in reply to DaveJ
https://lore.kernel.org/linux-cxl/20261105185917.2667656-1-smadhavan@nvidia.com/T/#mcea903d781c011fe22abf76ddd16d4f78a3c14f3
Please let me know if this could work.

> -- Alison

-- 
Regards,
Srirangan
