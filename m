Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAB2EEE79;
	Sun, 11 Oct 2026 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687197; cv=fail; b=T52Cg+6+AyDsHGWfeGmYZCuYt+IljcLGp0wiz/7ltkotiQHERcUlYxzT80g/Vfp8Gib4L04RWndaae1zFtHSdDDZnoLJLMi6j2gUfruC5scJ8ymcEMdyxvQDGYshQcNOxFdZ+m3CYvI8Fa9VVb1eWhSTWUCaj0bSvK+9BXGv0Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687197; c=relaxed/simple;
	bh=heDphwA9mFOUUkY4VZ+r1a+1wgqYdnOmv0Frt21AXRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MC9eNl7pYH/kjaZxxki4+pihFFILlhOMIJ/y+i+wFDBi8PVEhqsGxQFeDvAEVpmNEoIVMwwo07UqVzY8lfmu7wi88WIGUv81qMnMryH5KLnwC6iHlfheyXAK9lmBl21X691XvlY9F9Jeh/4EKiqqZpjycFFV8AhenJIqWJpUMSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cxd/L/UR; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cxd/L/UR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUhTlWYf0lQqlX7AZk/VLl9L/qen+ND9IXbUwcnP9no8jbR+G2IvTx4WYFIDZvqHq7XRp2EzoNSLUd7cKORSXuJGcfb96MS2JOAkyOCkybmc4OUii5c60PvHkp3W813rtwbeWY6gEqrqbLvOEPNpss3vRjaqVf2E8KnUs/6S9/iFTThw20LjimfTibLxwqK1jCVVid9hOlPyzix0ed/XSqx7IXaeESUiQy0TvY9lpXk65CMlzhtlXZ3Mi4bizh4uzowsn7DnrZlmtd0HQjSHlTdCEoSV6fcBH1d3xbIdkgwB9Ye3YuTuJPqzo1yUoP7FranS+XCA83HmV4kTLHkEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcU5LfQ/ldwlcKxk5tvzE25VkKS/JZWRqG4BQjJAEQg=;
 b=STHQy4wJ0Bi59JRR6qM+pBwof8Us96zOOpDDK4JCY/90gDm0U0nS1L0rHBhagXl97x78pnN3ONPYn1GuUnFHDRJINwNYLiytwVCoX7RYZ5CloZ5iJOg8zcS9YuTcBkxU2lqx4KepHn81FHu664O+451QFj9ADoEgHFKE0wr0cwse0JVNimTDRHUTuRpjScjj9bfagMDlia4DH1ZuGwBboHasIu0ogbXXhge/xp6w0qg0+U7dtd4UgM1uXFlQJJgq8OSfAAi61/2zfBdfgyLiskOfSb4SMx9E7IEIApiEWmDYuwhKo9AElyKThZxz79fUWK1GSAd1BMpaxZkpVhD9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcU5LfQ/ldwlcKxk5tvzE25VkKS/JZWRqG4BQjJAEQg=;
 b=Cxd/L/URlBgY+1/YYhtvN4nuKvQCXxiQBpDlMl5oxmg8CU040fVAD4ij0jdolu8RGBCxFsIxVeJDqE6XvXcLMEk3dIWoRygC590/Vd5lNteIzhCk39D92W7NhObar8+Uxqn2KTkbLtiywXvjxJweBVpS4N7zJhP0Mfidg4e3ZM+q1BZxeLYOJBJ1dtk8gXcMMNKEBzqQHk0AFZvl5tN5h8BiYIZDze46CoU0itQ1d/n5SQ5WMw+LSUCh3G7SFpzwf1XWvvfznMWyMPoVMxu7UQNhTcIAUO6pUqaNMzxMOhrZcOZztYKqpbcXcYTthAX8GeKUfIoSHd4aFuo2yZUxFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:52:36 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:52:36 +0000
Message-ID: <242a50c2-dcb1-4f68-8715-a5a27fd2be57@nvidia.com>
Date: Sat, 10 Oct 2026 19:52:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/16] cxl: Refresh cached PCI HDM decoder settings
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-10-smadhavan@nvidia.com>
 <48d34fdc-d891-4175-81df-2217068176dd@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <48d34fdc-d891-4175-81df-2217068176dd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:303:dd::30) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e33c5c-8472-4f8b-fde8-08df2742b49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|921020|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QNXym7i0piolk0kf4rjfMIeEV49YIVHkma9Tlh87cz1DGa9B/pR7ktE6YI3FFiP1xAe46kja/pjsfXD52ZyaRMrMUtBSIduDPSCcrowsx+uKtshkwaTp5AOKc7ZvKR3H3kh4Uf2cG1HjiYALmBjUWNi1HuNw56+HAyc4bK9XxzZLExTWIvQ6kXvNKV/N6pCM0o0OxXa5hl6TqgI/GQGfw2DMrbyf9K3OJ65s4OyrM0pZvadHC6oXqW2++Vo7Y7vu9XwDduxl5Xy9qMffql/YrO98LZtK8azahZY5HmXjNZAXyiGvH4TQ7lxjufMAodKXt3eNd8tuSKMDFvnfwb4B0A4eLbJAB9rUusVBZ6ShcqeUwMy0BA4ZuevlTOFG296hkamLIfYWVtFYpJnyVJtBoNC4anGwOCVqgNIQ30aM9ypl6vWaJqQPzzvTu3hZOscxYxd++6lU5V/B2IwmX4Fo1akdQU7uSiOfNoXAwEpiMLu2oILNqrzLU2bM6I1msSRiq+YfrnBCe2Mc7m4y+DL1Sve3Sg/ugHTaQEepLkxGZ7v/uciaib5nc/AZktIqxjuft+saajzFTJtHwDoW8remr1It8zOo3eqQ+hMoXmgMcq6QhB5Wf4sZ3/vYyCxiSf51vwX2MywcALwlor6hHfSAraEcZiYM/cRzc5FChlrfkajyc+AUTz/NVtjMICSzxbppPbM+Uat0dHhCsIzFJU2cjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(921020)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDRyY2pOZUdEQVptMld1dmVrazkvZ1VaUFZRYmdRMVo5dFhEa3lOSGVqcU5u?=
 =?utf-8?B?amVLWGJpTFlERXU2KzFST3BKaWNFeTgwRk1iZnZaSzVWdXBiak4xVEpRZWZx?=
 =?utf-8?B?ZTZOWGNOWGRmTFZjMzh4WDladWs3VDZJaU82OE1GeUdQNHZRU2dWYU9La1hH?=
 =?utf-8?B?dGFjWjdZTWtDNkNnbWVPNllxbWZUcTF2ZkFibVdxZEVFL2Q2THVSRTRDZ3N1?=
 =?utf-8?B?d2lBTGM5eXEvS0xneUhwd2xPM3dHQ204S0xENnVESmVDVEJNaGN2eHA2NVdT?=
 =?utf-8?B?emxOL3lVTnNYRjJKMkpBS0VQc0dYcDJ3dWJUWjIrVUVYNDN4d0dkNk5pcGlp?=
 =?utf-8?B?V0p6R0orUytieUFycWVaTG54SVVXVUZQZXhiWjd6K1QzYXo0bktjY0FhZ01q?=
 =?utf-8?B?NjNWZUZMRmJDMHVidDBrb2prVzJVTm5IRnZjbmJ6TkFzZ0x5OEtsb1dXTU1r?=
 =?utf-8?B?Z2JHYUJ6ZG9OaGxQSWlwWndBSWwyaXl2TnFLMkovRjRFWk43NktkTkpTN1dW?=
 =?utf-8?B?dllmcDlwdkdQRnpUZUFmSFVTd2g2bUo5MHU0YjhzWGc5RkZ2MjdtYm9oN28z?=
 =?utf-8?B?MVhXTTVWVjRiN1lOOUZEeXEveitvVE1yUUQvMVYzRlVtQ1JPeHJ3WXhiTmpy?=
 =?utf-8?B?UG9PMVB2TjR2UjRxR2JMRzVuNFgrS2FNWWVJUWJxRlRRMWdhZEh5YW1JakYw?=
 =?utf-8?B?YVFycXp5R1A1RFlld3UwY2JzZ2Jxc2ZRcGJQd2dwN2IwckNnaVc0Q2ZLcDhx?=
 =?utf-8?B?VkwyV0xRWE01UklZdnlMVUpnVTc3dUhodDgzamQ0Y1VUMW9ROEFaUzZXYy9v?=
 =?utf-8?B?WCszUnB0YTZsaGxUOWxvenpHdG9CKzh2UGFGZzQxYkQxeDE0Rjd6c2V5Q0hS?=
 =?utf-8?B?bFpJa2N6aUNXS1dCU0lJRzlkWXZyeDlpQU1QTXlobVRBUlpPQitPNHBtSDZl?=
 =?utf-8?B?YWZEeUsrc1M1d3AzTnpmZXdpWVYvMXI1a1YzY2hMdWpqY3VuaTNMYjJMQmRT?=
 =?utf-8?B?Tkd5emk0eGVRT0ZKdzhSdFdZY1o4VUNtcFFidDRHNytLWFFlZlJGU1dXYkF2?=
 =?utf-8?B?ak5WSHBXVi9RNUNnZUV5WXBvUHBmTUVxZnBpUkxFS2ZKUURORmxUeWMvRW84?=
 =?utf-8?B?dnVJNmZFOGc1MzlPeTNjUXZVd3B1d3RzclZ4SHI4c05zZFcweEpoZnhab0Mz?=
 =?utf-8?B?eTQ1bWlFdzRBN3gydzZwMUFSQVZkeVdkVkpFTi9BR0trVURzWmYrc0Y2YU9P?=
 =?utf-8?B?YU9keWFPbWJieWQ1OTJDcUw3S211QWxDc0c0Z2p5M0FmSmxlVEtFSHlwSnBL?=
 =?utf-8?B?bk02bllBcVVOYTMwY1A2S2I5K3BKNzFnTGxkM3QraU1iN211c0NTSG9CL0Vx?=
 =?utf-8?B?ckxCQkhESWZndnNRL1VvVkN3L0IxTVhad0FMZmRraytkNDNEUldrNGM2bXVI?=
 =?utf-8?B?eHB4cnRDWW0zUjhKZHR1bnBUZUJ1b1podFRlSlhodGNwRE1rT3RtNGNzN0ZC?=
 =?utf-8?B?cW5oWHQxbjMyWlkwWHdHeEkvNFVicHcrRGVWMk9Va3Q1aWpKUWtpWjBUZ0ly?=
 =?utf-8?B?MmxwUFdzT01IZE9tVTVqamRiekJCeVVGNkNFbWtaNytRK09Md3hyUW1nd2xR?=
 =?utf-8?B?YU1CUldEOTF5UmVld1JXRFNpV29SYi8wVnZCdDhTTlhFUkluTHpscjU5SVRS?=
 =?utf-8?B?T2pUc2lWeVpkQ2pnOWkzR2k2YVNlcXNHdGpOTVZ3UWRvaVpvMGFIZkhnNnA3?=
 =?utf-8?B?WmNVVWZjdXpTL0JDYmRLSkdQbDBJM2RaOS9WS0M0dTQ3cm5yeGhmMkRDSGRj?=
 =?utf-8?B?cTNSVnVCR0tHTkFlY3I4TGF5NlpaeklOYkd1MGxzbS82WDlXVENvNzd0VjNk?=
 =?utf-8?B?NXFGUXljOFJUOVY0TkdYd0lWT1NvUmV4bjU1bTh2Ym13eGpIUEU5UVVmMFI1?=
 =?utf-8?B?aUpwTXN5WWFZWFN0V2E5aENTcy9KUzUvV2F6QWZud2JQSnZTS1ZsMXpOSjcw?=
 =?utf-8?B?L3BFb0pMbW1xQnFrcTVsVGZVaDNQMkk5bGQyM1g1YktnUG9nVldwMktpbCs4?=
 =?utf-8?B?Q3hDZ2JmOTFzRXJJVzd1SG1ud3h3eFBlR09QY2xRSlNHdlpXWlVUalVqZnEr?=
 =?utf-8?B?YzRodXllc2pCbCtpN3dsTnJ3a2p2YmhQbHZkRUxWSHord0Z4NlRrWTJFaEJT?=
 =?utf-8?B?R1ZrQ285UnFMaTNSSVMzQ1dCQkJJUXVQOEFMd1NOMUhOcEs5Ylc2aUs2RkFL?=
 =?utf-8?B?WVc0TjFhWFVvZGhvbmxkLzRxeWJIbTkwSWtSMmplUXMyYk1ESnZGUFZzWmVh?=
 =?utf-8?B?cDh4YlQ2ajBHdUkrL2pWZ0FaVjRPajRDdDJLamUxZnh2SDhwNlFVZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e33c5c-8472-4f8b-fde8-08df2742b49e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:52:36.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6TscU7cZkL69FCwcbSGrTJJZ1u1NJixI2fg9LdkdtKyupHt+Bl32Fu05MXi3NrwAyJ7xkrX4mnx10HvAvIsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On 10/2/26 4:57 PM, Dave Jiang wrote:
> As an aside, can you please do me a favor and run cxl_test for your series? Having it passing all regression tests is one of the requirements for us to accept CXL patches. We will help you fix any issues crop up if you need it. Of course adding new regression tests for reset to test the new core functions would be awesome and much appreciated.

Hi Dave,

I test on a arm target (not qemu) all ndctl CXL regression tests passed 
with a 4K kernel, with a separate ndctl test log-collection race fix.

Patch 16 in v15 adds some cxl_hdm_unpack_decoder() checks covering range 
boundaries and overflow, zero-size and uncommitted decoders etc.

I'll add tests for cache refresh, reset restoration etc. in follow-up 
changes. It looks like they might need additional support changes.

-- 
Regards,
Srirangan
