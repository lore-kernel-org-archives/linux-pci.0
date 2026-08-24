Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32B38236E;
	Mon, 24 Aug 2026 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595218; cv=fail; b=MNA358OgTUBNkbf0msC8g9BEXdWI14P2hoyXmF+3APOzGb6trElBf/HkG8NFo85WghoSFzrE9CRPs3wWGletoje7kcm3S+AcwLpt71oV8PcF6S/OYWqaeFnqXZiep+tnPiObKzHCrE1GU10QFFZmCopCnUGeqTC+n+ifMlHpR4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595218; c=relaxed/simple;
	bh=FyWJLBDJSDCgPzlgYhLqJgpnFeCN6u/zEeKQCyAwvik=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=FKtTglOTE+A7JgKiQzMquMSGUet3RZTpzeXlL98Yzh9tVYBKRUIKUtgAayq+N5yAmQx7TH3JoqZv+3iaw2rr5lIDLas65AJrzHqT0x++HQs0ciake64XApuKddqI7o46Wgrn+2vwcn9TwuHfsAQovmmQ6z6D8Dxa9aTWzJ+5Zjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRpE8GS6; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRpE8GS6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvObnw6jkuAfcZ7SGcIeYf9mZScWGFUbUxWypqCIFGnzjpakk2Me2kYJFGxIgQV/QDzogidt+tdDJtAwKCDCz+x8SvLNcoPyjZZG/I0PDhpryNOhAGFvxbXjQ/0D5Hbxbh4haNSvAjU+qxSDLF24j89y/ChdrwEUa3cSxgk+HbFWGGPPq36cOc6MtIsgpB6FlmoDV0/mVD41VD/UMkcgC7z+RUD6BEKYPsT98zYq1C7p0jKrLe8NkaKz2BHCWpzipGU+/Jh83S82u5cFiDFAZIFikzPATu5WoWn7BjN/rCJrwfNBXiXc+lbqh3NsCc3Oafg8Xropilf2k/zWfSxgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+abnrvflMmCFMiOIUEBbLFbDW8AfHmPnDSDqDKeWPM=;
 b=UiMNwlBkSLVhBovP2o+nq5tR1M7Qa8bpDnhNCImQPWQFlXP4prkpfuJ0eA+K77a7RCXkzkMybdx0zN/tfz+4SMHaLiNhs/iEahW6t4CxD+3l4t92yLaEJjGSwBdMkop9Oujv7IKo33PgeSM4IKzEbVppJ2m4nNX/Rmx1cmma348wbFCLClXEzrGnMSWGrM3AGNtBurYOetnNLDqrBncroLEu3fIbeIYZdcuH1cqehcStJvcN7+1p6vDE2r8/7zk/cRA/4AVhI7dN/M6pFsj97A5nzBdqW7hWhZFOMBeb3Dj+qEcJVdsR15wHfQxv21nvmR+pW5lF7DvyFpeAaN/RGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+abnrvflMmCFMiOIUEBbLFbDW8AfHmPnDSDqDKeWPM=;
 b=WRpE8GS6q5S5/j3o4k4XsX4W7lF3MY/bqqPAGg+v1Fn7TnkW9hPjtkIob3L9Hmh1YQ4VDyCUwyu0iXaHwZKmENmZ625A3XtNKqB8WG/+cFgJHL+nDu4DIfG3WvXKrOuWmXVOBPsbJL+J+zdAzzgCwkFQvqGEa0j+/fLVmCOp5lFF/6nFzDTy3lZAg6KDNkF7WfYU33ysjy9/WRUZthjhz8zbKkUNy0Tqqu+tdUWeTZ3F2NwoUDcOzN6iU56MrEGWEpg+E/I3qZW/ddwsSZYKGe4rqvVbDKjxoGVM6W7OQ7NkZC7SfLO67MeKksDTFEKH743oGfnYbcdoRpIaY5F0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:13:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:13:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/5] iommu/amd: Fail probe on ATS configuration
 failure
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>
In-Reply-To: <20260824122347.1588592-5-praan@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-5-praan@google.com>
Date: Mon, 24 Aug 2026 15:13:21 -0300
Message-Id: <178759520118.3131778.16702711454963639659.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fbdf7a-c3a8-45d2-efb0-08df020b63b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R31pkPezfDrz4pWfFgBXoI4Fsot1cVt2TNorI/BPKjg3RtlB6NGzZaQ4su3vKh9K2Hs3KIV6Ez2pdPaoXg9cLtQw13rzEOJGAvKH84ZotChYAqtMHMge7imCMAs9+sZOXyKx3xjdYgNf/BFHXakjKBxPyrISwq8O8DFp4u2bHpEnvkR6g7w8ZoxlremIRiDcZ2Du88nJcvQiX7PDOvrdplYQnRWt86QXetDN6k/1/rcc73PJ4eTfhMQDPURsNW11r00bkECWS+mH7WuUtO7A5sdLG8ZMlCT1kZqWVOKOxWkCx9xNDifbrwgHRapOw5ZFPQL+XWw7qspuqj50J/m/PKp2ezWRHnDHdr+8cBGzS3j3vW8H+hYxUoooowDCs0l/D/EvqCXLJEUwKHHsyvGSfdqi04SkoDlgdbwCCvMONyoEYTgJjNJaN3k4j8vJFMzZI5e+0sdBR5ZF0wZlqDtLkAIMgilJ0Zdr3fgMXgvwP7I7wm7fvOS1XK1x2fRAocD2YM26vUo2+77afq+FHjmHcILWZFhjl67u0mhmkEEsGVrmAzE4/9lr78bSlCCbMOGce34eI0NuHLusymTlyKn1EtjqCpMdlh30Gd9QQM9KwjdjZ2b5dTKAZ7pWEkpeSYYOFxIVq/ChNfX/Xpk1YJrmZYmRIWmzvPXLkhepGsrWF8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXJuZGxFTWdJaEFUdkRTSGhrUDNYTVBMSlVmV3JKRmZzQjBDK2Jwak9IWmJu?=
 =?utf-8?B?cnUvWU4vS1JpM3BYSm50Z2VCQVRYUDV6KzRVYjF5RFFGSTI1eGhaOXFLbUlB?=
 =?utf-8?B?RW5Na2xDTVdjd3lkbEY3eUZacERnckppdXVGV3ZVb0IxSTJvQlY2TURqNmtT?=
 =?utf-8?B?Y0FoWnR6QkNnbEN6eXFsV2NwQmpvREtGbFBSMFRpM24xTC9hMWRoMTBONHpT?=
 =?utf-8?B?dzlsUUp4dmVPUHNRMTFwU2J1UDF2a05Rdkc4WkFFcVU4U2xkbHpGb292VVVN?=
 =?utf-8?B?RWJrYXhjRmwyNjlpcTY1YUJoRWVCUHVWcEM5TitPV3FRRjM5R2VWODY4QUky?=
 =?utf-8?B?aWhmWlhJUGdlcnpEaXh0d0pvaktoSTFBNndrZTg5eERHSHJzakdFM3J6cWkx?=
 =?utf-8?B?bGhXQVZxdm5XS0wwbVdNVFlGVm1UK0tKRlVlNEtoRVRMdm1RWTNhdmFpZE91?=
 =?utf-8?B?Sk1JN0ZYMGgySjEwTzJlanQrTS9idVBQZWtHSS9Lb0Y0ZkpjSkR0S2tQV1kv?=
 =?utf-8?B?SWErVUVQTVRFMzd6SXNtL0dMRFo4K2gyTDY4K3JpNHphUUNzUlQvaEQvVGp3?=
 =?utf-8?B?S2lReVhKOVJnUE9jTERZclUvcWhDUTYvM3RvUUp3UTk2UUViTlExNVA5YjFx?=
 =?utf-8?B?anZWSklkaVZCUHc1TWFIcWVpSzA0dTZ5dU41ZkNSb1F5cXJnN3grYmdsMEVO?=
 =?utf-8?B?L3NORVgvWmlKSis3OUlXbnp5QzFpdGZQVDl5ZnRlRUJIOVNKWk5jQlA2aTBq?=
 =?utf-8?B?NmV4TllleHQzUUxScm5JeTAyb3JtazNWZG9QUjM1TXNmSjcyVmYzbW5KcEdm?=
 =?utf-8?B?VmZkakNGR3h0K1N2TDZIekVaVGxQd1ltQUozcm5iOGQ3Q25LeVhOUXY3UVo2?=
 =?utf-8?B?bDFLclJGSCs4WmNEcGEwcVM5UW4zajZsSkRsRDJ3RkROUEREL1NXQmNOaVh3?=
 =?utf-8?B?WHF3Z2x0MHkxQkc1bk5XMmh5dHFnaXpJUHlqVFJKbGhCVE1ZRlVtZ0lpaVB0?=
 =?utf-8?B?bWZlczBacE5mcmdtNTVROWdCZWcvMWxzb2tlbE5rSjVhcERxYW5ueDBadlY2?=
 =?utf-8?B?MWNHVWRHaGxUVS9ISEZSKzY5K3dzWVRkU1lHMk8rYnRneTJhMTliSVFqVks0?=
 =?utf-8?B?Vk9CRWszZlpDbE1kcFk2RFAvQ3p2VytBaDFqYlB0aEphRU5vV2hrYkNSRW5H?=
 =?utf-8?B?WmVKR1RCY3orWi9QZnkyZStybDNScHJPcFdRNzdMWHhzNVlnU2hCTUdKRkFq?=
 =?utf-8?B?MFNOMWFsUjZnQjdUUzhWb0M1VitJYllyeWVvcnM0NUJDNHR5bGp0S2R4TXZ2?=
 =?utf-8?B?b3VZV2FKVzQ3NFNxOWp4d0RjWXhZSjJOZnFIVk42dXBuZlkzQVRrRktUVE5K?=
 =?utf-8?B?YStTMFZMRHh6MXRMT1lNLzFZU2lWN0xJODMyYmNNSHh6Z2hYMytvR0ovMU0x?=
 =?utf-8?B?VlFhS0ZWVGxmKzRlOTdiK1RteDZqTEQ5SFkxdnd4VW9haS9QMHJ0N3ZDMTlq?=
 =?utf-8?B?cFBpN3pWM3lKNUtvTzZIVFFjbjRiOTl6VWF0bTM0UzNPVVNKbnFlYzFmUFZV?=
 =?utf-8?B?MVhJZmVNSWQvVVBXV1BpVlhzV0xKQi9VTHFwbHdXVDdsbnV5L2trV1BCS2tR?=
 =?utf-8?B?T0NSL0t0NndVQ251U3dwL1BUa1ppak1kS3hsVk02NER0SnZPTFQvVXJaZEtI?=
 =?utf-8?B?R0FDdGFCSUdNTFA0YUwzQjB5b1FRQnR4akxQSDQwVVJIUENFaFhaOHNZc2dj?=
 =?utf-8?B?YlF0UDFEVnlvd2h4NXZEb280M2NEU0ZXTU8wZXFiU3NrbW9sczk3MEI1WENX?=
 =?utf-8?B?OHJyK2lVbUpHSERLYzZub0pHTnBJaFZmRUJ4RGtxamFJODljYkFTeHFKN1F0?=
 =?utf-8?B?dzFZWmg4UXFqdXJILzNCc052R04zSi85b09UR2k1eklWTEQrUnExTjBBWG9I?=
 =?utf-8?B?cmdERDIwbXNVMU0yWGJlTlFxV3FzeHhsQ2c0M1UzU29PSXk0T0hQV0VPeWhC?=
 =?utf-8?B?dlM3c3paUGd2RGpYL2U4WGFuUnBzTFBhbExzZ29wZEhEQng4SGVGQzJGbnhm?=
 =?utf-8?B?U2YwQzR2Zm5qeTdTZ1hjclE2OFY3VWlpU0lrNng4a0lzcXNOMm91YjNrOXBC?=
 =?utf-8?B?cnFDdTY1eXlraThDQVVSSTVpWlZtb1JzcmFiTUJLQ3V3L3RnV1hWTXlyYjBu?=
 =?utf-8?B?QUpaaVRibmVKSVczeEJmWkJLb0dkNEliMVdtd0FweGxoeUlwNEJObmdxV1pN?=
 =?utf-8?B?cnVkM1IxKzFYeE9YWG9xVGl4N1Q3VGxhSC93OXB6ek1pSjdWbWRXT0IxdGZO?=
 =?utf-8?Q?e7qDALKKCYmbfQaCt0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fbdf7a-c3a8-45d2-efb0-08df020b63b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:13:25.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygaN2IQC4NYWD1wf4xbTtroodN4SZhhfFv73HNi2Faf5KpmRqylOfQ+hOBSkut38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

On Mon, 24 Aug 2026 12:23:46 +0000, Pranjal Shrivastava <praan@google.com> wrote:
> Update the driver to call pci_prepare_ats() after checking if
> pci_ats_supported() and fail the probe_device if pci_prepare_ats()
> returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
> a failure in pci_enable_ats().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
