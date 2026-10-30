Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392825;
	b=scHv8F+Ydrh+tkhQCaYHagFE9aTuwoZn0x36hf5V7Zj99+uTlW3Oof5WmzGhwBWC8ku5
	 ccbZTEfT7tdK1XpJ7/R1810dc4ZJqJs3uNKT/Fit8OuxrxPTmcvH2EvBPYHbA+fVYpC/T
	 r1nfl7ISLEcWQV0gHOC6wL7uWtktekdRiNaiPv646wioh4NIWPEwMuHqPc0N/+YVy/GeK
	 u+EuUPiwdIaPEIFsKvI0XPeppc890/5et057Zu2WId3JlpgFo4DE5bhqCVYIuu4wW/1em
	 Cr4HvRVkie8HhX+V0wWDWUGUv8nc/rATfncKaJxVJ3PD39QuO88RGn1iO4Ki3pla1ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392825;
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
	bh=zmlZ7aNxpgn0VjRrI0W6d9MsyiGPJdUvh/G1Mvp2jpk=;
	b=ljFf0NyV/EjGloB62JiXJVhbf88BEC+z2PI86S7xFZukkIxEseNfwI5n4W90/HYN3fkv
	 +IvDu101VVnahQy1UWJZVV4Ek41WCYyJ0iO0gGXARtXwe4XqNs07JCHGJmtuCTmLJfutM
	 XUxsb/w9PfNAoa3cxzzCKiUYQPk9/OYz6EgF08bJ0amPriqsPoxIoYdCU/f63H7ETfwmX
	 pLWJptbWMyQtbDJOntY4UIibwAy5qyGV6kjWr6IPq9mDNaHu2i6rK2IzRnCUHi9E8A93y
	 LUc5TQ1fDvk1op/vOxPT+dzNbeiJx+KQFaNLglEadiG2ov/AkjF/NLYVHSvTC9H2AVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=udCjAtck;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.50
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C6606A31A;
	Fri, 30 Oct 2026 20:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 639C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=udCjAtck
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrgp0p+NfnADOLfki3fZSzDWQHxJVRNXUgZXRbfl7pVuqENTtlpJBb39AvNqh1kHgholLM5MZm1OrCZ+xbV4Mu35Q5xEc3rz/akS413VXxpO8dQI8G+J66yom8nZxr7XZlkccRhw/NdYTRRLWz0+PkZCggDliZ/yC1c+To+qgU81NPQfjwEgVyq5rILDBPulOVjjPclJzJBbS4zCptkDXhObHBjSsYynOXAQ35TuGdKMzHSBt+5ME3F9tmJLoIQTBSehFQoPG7vn1iQZVqXLakw0CQ1bFsI/SSIePyCoH8fgqZf7As+lj7bqqK1eTsqMyCGDzgBY10/ieLUMvfHX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmlZ7aNxpgn0VjRrI0W6d9MsyiGPJdUvh/G1Mvp2jpk=;
 b=wd0mwxGxoHTpc6afve8VzpQ8pJsxHEaa5waNcO2f7StVUVEtcZPi25BaYlm3Kx1Mxz43vPNi/nAIm3E7PcFNpq7eYEgIpcMZrSJmaqt0ynDQ+3SZbLHh6G1se55FbtzxtGrOJxXSwdVzdl3VKx4EsyandWzDn/evfA2v76L+HQGbzhvlwhexkybhy4+qu77NOhn7VQbKyVJspJ9lyqnqeqTMwF7QDiZKZJrb8SJNjQWhCgtlQhi71/iNjUMaChH1ke5YsVgYfFRvSR7KR0ROErWJV3Y6TiA87xiSfxqni7PDmd7VEeu+dJOtDvdluwGOrsLd5x10qR7EES3EmK+6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmlZ7aNxpgn0VjRrI0W6d9MsyiGPJdUvh/G1Mvp2jpk=;
 b=udCjAtckGhk6xtCRuF0hkVrB83LOG1KtnArjDb3NtdtX9sl3mouyY21OzXygn9ipO6QcGAKGZPxfibq/4jb+EvxUowqRbznKUHO8EslxvtOblRMKrFnah+/BAdd14TET3Z1CASE5QxNqDQs8LQ5+njlW6jYtimTYiJWkgaxVEjiR7x80kW8P743iwbvwA7xNrxbbeFLf6XZZjmO1CvnmTE1iucxKlxxfCilvfhhqgiNexuBDy853sym+Xrsj2TxG3h4u0uMhMfWJr5Impdw9zM8PiZA/1Hp8FAIrFSVP7MOZpJAi29IMMJzOtWfi9xoMgUT8gkY9jlmDyBAIbjBBvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 20:40:15 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%4]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 20:40:15 +0000
Message-ID: <fe4b26ba-9854-4375-8caa-9d1b77f9e745@nvidia.com>
Date: Fri, 30 Oct 2026 16:40:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Rust VFIO PCI support and NVIDIA vGPU driver
To: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: alex@shazbot.org, jgg@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
 ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, boqun@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
 kwilczynski@kernel.org, dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: a51e5a4b-3250-4b0f-efbb-08df36c600b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	vKwloajxgMDQVTYMd3VGDql/ybHQzJgvGnoF8GS9tYAQyVu8nNgY5HvTXt3tzgW+5zyRvrsgFRzGyq/KhNmg9BZYo8Zb7IED/60QypdKnOG/Xx4paQGvr2+type53dscW+NoZbbsjoovOlLJ+2W0m+BJxdWaDiZMcynvRbLxw3mYp1UQWibAJgzhWlVCzhRqL01f80A6AoZZweQx2qYzuyIyK2/D8+Hwruq/pZQqnEWvH5U387zkqv/JxkApALSz5HoSqNrvdiFctGlkaKAzVctx/h+CQlGyfRZ9NISLT1JcidKg7kYKZLtfB/EKPa8L1GQ+tO5bTYb/uDemyU1qdRJdTsMVW7aD+fomow3SEGj0kjCktWiBDm6FStU9HGjvLreqnFUrUQ1lcIHFdqCAjD8j/dEhqdCqKRt9Xv5XyY1iIko8b0/kFBqcouNkRuHk9ay4PwOvv1zqNxouhWJxF5ERYExZO3DLUZgaQTRlWXQuzkABuBtBjMRsdtspc8LfA648lPJx9HtM4eTpObUNdyM0/RUp/m93y+if6JQHeGUling5/bb+XF6MsayP3CRUErZtCY5nY9l976TtXdFX/QoS3F+N7PjJwoQN42Nqk5HVc9K84eQNxSs3f1rYLrjBi8qQ3XvIRh/9fFJZ6CcUHNjnwH+BVyLWUwGNJYBYqzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0Z3QlJrMFhUQzJ2ZWFuV2k4WTlEZC9Gd212UUh1TFRIYzNDN3RaaEE3MFYz?=
 =?utf-8?B?SVFVOXNsU3RKcm82c0I4NHNPeXlJTnZnbnBONHNSRnJBOVNxaWFDVVR4RHQv?=
 =?utf-8?B?RTgzQnBDQTljYlhGczEydjdzQ2dPbXVRN09ZZ1lPZVpIRTB3K2MyQnNZTjdR?=
 =?utf-8?B?czQ0MjExQVBuYjlzbGVKTFovRmRqb1lzTE5WUlI4VHhoT2tNTEJ1QTFYNm05?=
 =?utf-8?B?OEVCWnVZRzJLM0x1NzVaWWRzWDFuQTN1N28yMWtreTRLR2xRbXp5VFZUTHZx?=
 =?utf-8?B?dlJlV2J0TzdvTVpic040RnphVGZ2K21NOFFCc2d0aURwS2tLRHVTVnhRL3dX?=
 =?utf-8?B?RDhVaHRMUFlIaFBLMFcwNUlaQm15RGdKKzdjM3NQZ3JLS3ZWdFRDVDFHbUR4?=
 =?utf-8?B?WThWK0RhNzh6bHRGVnNuOE80VTd6VnlDV2NVWCtvNTZRR1ZHb3hURkYybXZV?=
 =?utf-8?B?ZFlUQk1MZ2Z5MUJqem5pYzBaelZBWURWYXBzTXIrY2tGVm5GK2RHOUhXUVQv?=
 =?utf-8?B?NTF6eHBIa1NObTBFNVhZdVFod0FwRWFnNGpJUFAyM21EKzhNcEhNLzZmTHlu?=
 =?utf-8?B?SGxmSUdRTnZiOGVpa1VQZVozWmMxdHZuRExVU2dmOGwyYVpOeFUzQjMrUVNJ?=
 =?utf-8?B?WkQxRnJQeS9wYUxTYkpZd3F6NUZ3eUZPVHorWjFqU2h5a1JXbVF1dnpGMUtO?=
 =?utf-8?B?VmFkSy9GWU83ZEtqZHdlTXBjSCs2cDNldUNiaXBkQlNWckhUV2NYc0NVQW9m?=
 =?utf-8?B?aEQzWnliRGxYTWtLV2YwTWZieTZrRXhHMmV1blNQbzhJSTVobU9FTno4Ynpn?=
 =?utf-8?B?R2YxSmt6ZUhjYnhhNld0czM0aGg3VWpHc1ZibzdMODAyck9tZlgrL3JCNy8z?=
 =?utf-8?B?OWNyMWtRR0MyUHI1dmpJSjMrcmgxRjg0RXA4a3o3RE8xRHpYTitxNEY5dGhx?=
 =?utf-8?B?TGlObkVpZ2UxNVhQM3EvYldkUEt6VGx0bkJtVXVsbHFrditkNThYMkVscXJN?=
 =?utf-8?B?WFJnaHlaZjVwUnFQQnN2RUJtcUF2di90TDBScmdpQkd2TjRGZXFhYVgrNUVX?=
 =?utf-8?B?b3g5TDZjY2hxTjIrWUk5TTkxU05ZNnJwREI3d0c1S2xGWEhkTnlURHhvd1BW?=
 =?utf-8?B?T2Q4dS9QOWFvcGRnM1FDTDJqUVlNK3FXN0JnOTRKTk9aa05vc25OTVI1MlEz?=
 =?utf-8?B?bVFqNjlWRE0xM0VNUXZicDIwV2dWbHk4aDRLWjgvTDFiWVQ4aEpSLzNFdlMy?=
 =?utf-8?B?RUlIaVIrVmpHTUdkVUZOMmppcUZETndCcGxkdmh4VzY0WDNrU01pUXUxT3hF?=
 =?utf-8?B?RU5xNXM4dDE5cUpvUnhONEE2TS83ak44MWFSbjgzejNWVGc2dU1KOVpwbmRZ?=
 =?utf-8?B?T2NNWlNsWEwyUmpuNEh1b29JWlNncGxtaHVqVC8zYzZTYm9mdHBZUWJnUUpn?=
 =?utf-8?B?WlNqVG9oWXJkc3FCQ05XZ2pnNXEzakNFblM4dmlVVCtMVGwyQjdocEc5enU2?=
 =?utf-8?B?NEVQa0JEUnFNcmUrblhiOHRHWFhiRGlGdnUweVVBUU5FNnkyclFreFUzbTZj?=
 =?utf-8?B?Z2JwZnhKeVZrS3IyOUNVaDVOZFRnditrTGNQRHplQWNKa3Faa3ZTRWlSeEph?=
 =?utf-8?B?N2VsUW0vZHJVTy82ZHVJK3RUWUROMUh5dHpMTk4wbm5CRjBhS0ltT05ndnIv?=
 =?utf-8?B?RGlwMlBTSVpKUmdUcGtDZ1ViM2lwM2YrWjdnL09XN2hheHR0ZzlPWERYcmhH?=
 =?utf-8?B?eXcvRmNLcXdhRzMwa1VnV0dLanlJOUk2VHVKTHU5clBDR3NOdk84SmRMM1k5?=
 =?utf-8?B?OWhyc3dQVmlITExMcURQS3NhL0JpYTRFanRWZm1rUVpmb3lucjRSUXRuQ0JH?=
 =?utf-8?B?MHVFMTJJdjBwRnBHYjFqSW4xcVI0M0VJQ2JQYlRCQWJPa2lZQzBrWThGdUU5?=
 =?utf-8?B?Sks1cFIwNWpSbS84dUNPMTdydUljQTZsQ0lUajVsSzRVTDBZdGhTTkN2bG9W?=
 =?utf-8?B?WklaT290bW5jQ0FPa1hXaGlFME1IVmJDSDdvbUdlZnoyd2o0NVN6V0RWMTRW?=
 =?utf-8?B?dmg1cldWejZJVVdNOEhSVTRUM1pEUWFNTGFIUmVNdjhZYXNVWEJMSGo0NU5T?=
 =?utf-8?B?QkJrVFRoUlNxT3lhaUExekQyWk8zVG9rWDNpakxNdnRpdVNhYzR6Y3dVdkF1?=
 =?utf-8?B?ZHE5RzBSRTZyMWVpODFZSHphS0NSTFlyM2VQZDhLSUVDVS9mS0dDazN1SHVP?=
 =?utf-8?B?cWxUbk1qQmpIM1MwNU1NWEdINStVTmhsNk5DR1N3dnVJTlhmMTdoNnNLcFpD?=
 =?utf-8?B?Y2Y5TEZNRTBBbXBIQUNLSmZZaklYekJSMVc2VHJONm5JVVZzTHpyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51e5a4b-3250-4b0f-efbb-08df36c600b5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:40:15.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi+EE1UKU8H1iyAtdNerniF9Xj52GgpNjwLW4Tkuj4/EKseZ10g2ypRg0ntzw25ftAhp5QaObET5S8/5uwPRxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Hi All,

Following up on this series, I will resolve Gary's documentation comment on patch 1 in the next revision.

Could I get some feedback on the changes in this v2 series?

Thanks,
Simon
