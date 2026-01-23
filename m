Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711732FFFB2;
	Fri, 23 Jan 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174738; cv=fail; b=VQC/waG67zQFG2CDDT3a1E3HqRPEjI7bowDoPBdJUmWoBNAZfIiaoIvHbGQdJKLUYgNDryWTKGsaR+GVpqTyzq52DR6/GOD4p7REQdaanGxlwgVrDfNRYMPdvlwn8kDMJCWMSfuth89GnjCMux/4PpAHa+Qwv8NYa2Y8aEkbDNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174738; c=relaxed/simple;
	bh=e9LOeJt1KBBB+FaQu8SnpPcTf+AXZcuQDGsxPjeNaJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBMZ5mGPgFnqnNUewZ4Sr2Fl9HCUmibME+1gmVz0FMYSh7J7I03OtxReIYaYw8hgiClvPQ42hxk8iOcuKbIX7VjjUpJVNxT4ALGf02EgvEV80rFEQaZ+3/dTeq7BS6NgH7xI7Cnlxh6c7hFn3kB2XzpCE3bxDJxhuT0yKoyQp20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PZM7wHys; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZM7wHys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSZy8DoY+cBLcmBbRwvt98OJJvcdmlpv+wrdF5fSD59OXYBAkm1wrpTsrDB92h/E1ew7LjXWPgeXrWEpwy5CcNgOv9Dy98BFwchB/2T71dK4OvEfop248MMpV7qS4lXFrA9/OVscFpV0+HhEBWVnMkjNfT/IHVz0jbPWLnpkOLme1nLxX99spAQF9JT+69YV4nBrcu6BnH45UIrh5EXact/1hkQ0MPDN2UQhqv6JU+SRUHgUMTs7V2bQFmIEivqy3RO0pzaIojvZhD5u/ZvgHDYzIj6dxKt5sOcDRDBHXT2MhaiqeApebR5UtT4CAtRHflboeqtKPvY6GEfUjtlLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS4robLaCZc+zuVkd2JnP+Roi+Jbx66004keRU8YzWM=;
 b=trS5eEnVpN1a4kP9FeJKQx+RfXomHQykCv2K+1CwV6ZDYsRMwZjwzY1wzeCul30Vt2ow5jQI+3atbmkJTEe5MQ4syHz4Xc+D4ZRuL4RsAhop3rv3uvd3l11mBuvLQZeYz+JpznRf1i4h6roiAW+iAU/lWofD9qshSON2WpPO36kubmQCf7yksTWOzGxWtTfVjJjj5Y+A7IjvLfHrQnCXzZFuaD1QeHBfgpc3WVIN29+RsGx3QsIFi6L/imUtsOfMr9INIPQ3b9afomoRibokiq9j0PWvKcAiLTrUbMmUbvToNr0qQ9Iv79FICwGk7bZh9g00eI/qC6C3urs01q3zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4robLaCZc+zuVkd2JnP+Roi+Jbx66004keRU8YzWM=;
 b=PZM7wHysz3omuL05WVu1IHHZDlYq9jw+NiymKSsYXxIFS+KoUZthAeMgvMH8tUPuKSfiaBhpSD1PYjZvZjIoLm9VKblRk+vX279en1U+fvjsIl1IQlmMcn1zn89wFb35jyzjMk28ny7uOIPYkQYpcn6PWOUGk95sSmtzK1mysXe0iJ3m7DlJqI0dZ5E1IXcz5/d6TVuMOelH/bJzmNE5VYDgfZt/AUcymm6y3M3AOnJjBlPu4ktSbxp0JHtGzaWt3zdDBuNP2ukDSJnF87ollVVpVmdvSBa5sf2rXdNSaIITyY3WDnd0LJFI8k9/uhhTexR6TXnq8ucYPNDAoyuhPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 13:25:34 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 13:25:33 +0000
Message-ID: <3edbf9bd-4542-40d3-888c-470e793a46c0@nvidia.com>
Date: Fri, 23 Jan 2026 13:25:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
 <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0257.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::10) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b8a71-78d3-4bbb-bc26-08de5a82e326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NSsxc2UvcFR3b1hVQUg5TU9ReFlJNUJkcW5qNG1tK3gzQ2JrRk1UcTAxVTVm?=
 =?utf-8?B?dTlnZGhBeXl6OWZqbWVKbmdIYWtUeFhEY1ZvbmJVRDgreWZZRDF2bDRJeFNN?=
 =?utf-8?B?RzIzVzFJT1lsMXFrR2dFVm0rRXlrN2FSRDJFNmM3Q0ttSUN0NVFzU3hqOWFZ?=
 =?utf-8?B?WHVBNDR0eGZYK1I1RDE4VjN4UFlOZ1V4T0R6djJ5c0hEVmtMdEQ3NkhBRDlq?=
 =?utf-8?B?MEFtYnRmb212KzBMbFpVajQ0VjZIZll0cmpMWnpNby9GTVpjU0N6bVBVdEJO?=
 =?utf-8?B?ZHNteFUzSm01bTZqeG5QTndTZ3NwWkhzNGFyZUdoQWtQRGpra3owNGttQU9l?=
 =?utf-8?B?MTBaakxQazNJMkJ0eVZ0TkNQZ3N1QXJYMU5MSkZDSXJ5c3RIQUxZVjc2cHdF?=
 =?utf-8?B?dVVTVHVlcHJJTDJoeUNDWFg3OWNQZTNYb1dMSFJPWTgxTUU1QStvZlB3VWs0?=
 =?utf-8?B?T28zajJhb05mSXZJelVIUmdFb1hIZ0d2eGlsMHE2QU42UkprK3dBU2dmUXBt?=
 =?utf-8?B?aUQxTTFXeTloRTdJS2hmbkxZUW9lZFBnRlJhTEF4Y0x0NG5BNVQwV2V6RXdx?=
 =?utf-8?B?cUVQTFZkbUdGMSt4amhCN3RYWndtU2FuT213a0ZNNmV4M25BUmNDM0Z0MFl3?=
 =?utf-8?B?Q2RVVmVrUU5pZEVzNnlBc2hJdjZsTFZCVkx5UW1lUmZRV0RmdHlleEJ4NzJT?=
 =?utf-8?B?UytoOEk4bXlnVDUvOEpFaEtlMmhHRkVxcllpUG1naGJQaVcwV2h1Yk9ZWEUr?=
 =?utf-8?B?ODVxblo2OEZuVkticGNKcHIwME9MbzNMaTgvcVZhcC94RjdQRWxyT25rRWdO?=
 =?utf-8?B?NXA1a0YybFNPNSs2Z2QyV1prNkVpcVd2T3lncENKWnAxUWJOOUVGRVNBcHpr?=
 =?utf-8?B?dUR3SmpwbUIyRnVUb0xkYVlZSlUreS9RVmRkYlFlS2JpeXJLTDcrTlAzVmFC?=
 =?utf-8?B?ZG4ybFBGdWhYbEJnMjRJcjBBUDRDbGFzdE40K0RPT3pQRlFJVVNldzFSVlVk?=
 =?utf-8?B?eGFCSHBRdnBhaWlnejI3dS9xWFIrL3FacHRRN0UyeTRYdW1NWlpvdU9RQUVu?=
 =?utf-8?B?cWhpR2c1VG5SbW90RXpzY2dLSFZFRWo0WUttUGx5bFZxWUx6MGpVSUVxRUNx?=
 =?utf-8?B?UTRaQzdtME1iY1E0REJad3U0WXo2YVR2SzhnMlZZVWhrbkZDcG5zNHUvK29x?=
 =?utf-8?B?VmxVWjJhS3Vka2IyazJpUmRISDFHNWEzNHkwcDhqdnV2UjRDS0xSMGIvVzIy?=
 =?utf-8?B?aDFMaWc0QXh5dmlJRW50ZzgxSnI0TTJ1U1kwZHljU0xaYkxSZ3Z5QURpZUt4?=
 =?utf-8?B?L3RtTytha2RZZFFzaFhndlYwTVdxbzZEZnR2SDZBSlBUVHNEdDh2ejRKYTJ6?=
 =?utf-8?B?U3d6bXhZdnVja0ZUck9WaStlaE8reElPZUdVa0hmclp4eUhScHlhdllDYVZG?=
 =?utf-8?B?enA0NW42Z215clAvZXBIVTEzeCtYRTl5OVFieGZ1MDUvK2hldSthUmVMbGls?=
 =?utf-8?B?Y3FzSFlxV3pJaml0MWdXbVVGNVkvMWd1NUNrU2dqSWE2Q0hobU5OcVBXNlhr?=
 =?utf-8?B?Y2hzUnhZTWVrVVUyMytWYmkveWNaZWtXYmovNkpsQlVBZmh0TWFiSFJzcVN2?=
 =?utf-8?B?bVI4bEgrMHFsdnRGbzJyZnhlbzVpdHNHTGE4bHZIOVB3ZjdJRXRsbFFDYjZm?=
 =?utf-8?B?QjdZUmdJQllJWlpxWmZNZXdiTytYMG9sYkVoN20weWR1YkJYaVlHaEJLMVFI?=
 =?utf-8?B?dFdsL1AzVEltaVRkbEJFcXFyUnI0b3lrKzhxUkU3bEJJM1BFZUlpc2FMTUVK?=
 =?utf-8?B?WFBPUHUxbmR6MUpCVG1yeWtIdmdiNnBTYi9MSmQ1V1FJcFIvNFVaa3dzTCtZ?=
 =?utf-8?B?c2NESmVnQkJhZEk0YitIR3YrNkZoZE1rSXhmNVR3bmdYMlFDS05aelRvc3lJ?=
 =?utf-8?B?a0JLT01xK0pxTXdXRm92cE0zd2F3a3k3S01jSFhuakIvOWY2TFlvMit2eG1u?=
 =?utf-8?B?Q2lRVkdEWVZ5enJGbjRYbjFIc0tDenA3WUVTdjFCSUNsRDM4VDFabEtnMzE0?=
 =?utf-8?B?QVhoZURoR2M2Y1lKdVF3c0hGN1JJeTlmL1ovQ3BGWHRKelVUWTZqb1huTElx?=
 =?utf-8?Q?kg8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0RnNTI4b2k4Q0xBeE5WYXdxWDhnNE9lK3E2NVEraXoyc1pWdlVkZkxNWXdP?=
 =?utf-8?B?V0kxWms5ell1Tis1VmhNa3d5M3VFTUFyZDgyYTNBcUZueWMyM1c1SnJ3VnMx?=
 =?utf-8?B?RkVGbVM0NFpsN1hUd2R4dDMrRVJSR211aGxVUDBsVnVucG53NzVxdHVDek5N?=
 =?utf-8?B?a3ArYWpBTE9IUng3eS9sRUFWeExDemZ3bGZKS1ZySHZVRE1SM1d1cXBiMmxk?=
 =?utf-8?B?MkRMcVd6ZW9XLzdjYmRJWGh4N00yaVd0ZTg2Z1JDKytUYTA2ZExNVDNYSmlO?=
 =?utf-8?B?eEpZQnRnc0ZDcHhlb1RlU1BXdjlWZk83UitrSk5WTVgvNkJWN0xhYXVDSXNj?=
 =?utf-8?B?a0dWSkhYeEdiM3dNNXJpSzdZSkdOSVlIZnNoK2pXaVFnZkd0YnJoQXlPK0lB?=
 =?utf-8?B?UkRsSC9DTWxIb2gwcHhiWURMRUxjdGZvYytuZXNyb0VJL0hDdTJMM3JYNmlU?=
 =?utf-8?B?eWtSZG1rSXREcnJTa1dDdjJhbEVBSk1SWmV2Z2lQR2tOdHdVSkJPTmxHNHJQ?=
 =?utf-8?B?VW0zd0RWeVNZWVlOSzZFdzdzb01wdGszamhDWEFnbXQ5WmMyOWpNVFEwbit5?=
 =?utf-8?B?bXIweEFITmcxdkJXUnQ3bVorVzNNdFp3NXNBN1pmM1VYTVdYd2VxTjRiWUZv?=
 =?utf-8?B?ZGRjb3k0ZWt4VDZSbjNoL0lxQWhudXgxS2NxRHRWZk1xQm01OTZWWmlXeTE4?=
 =?utf-8?B?dC9tZEhiU3VjTlhRbmVHT3JsNnNJY0FmNmlYS3loSFQ2bnZndmpVZWhGM1Rh?=
 =?utf-8?B?aFI1ZHJRL0p5Qkt6eENtaXZKUlRRTGRSemhOZXoraTd3QzRCcGlyVjFtNnZJ?=
 =?utf-8?B?UVM4ZTNRaXBuL0J3NTJoeGpMdXhpTG01Ly94Z3VyZHJpa2ZyMU0rY20vSVdz?=
 =?utf-8?B?VDRWSGNGNzgrbSsweGZ1NThkRmVzWE1ocmhGbGEvcHpzR3c5UzQzSi9KSVdq?=
 =?utf-8?B?WXpHZS9SbG5oU0NQSGF2YU1rbWJneWR2TU1ONFpVbWVGc1RBdWg0YXBTWUJF?=
 =?utf-8?B?WVg2YlhDN2cybEVZTnNNWDVXMlJGenYybk1DL2pQRE03ckxoK3BwSXJUOU82?=
 =?utf-8?B?Qk93NVV6bjJGYzZ3K0pBcHAzRkdrWVpZV3kyaU9RZlJCUUJMV0JGWnBiVllt?=
 =?utf-8?B?T3VMODgzUzc4M0VHNXNKZXJELyt1SnMzUmJqVjg0emI4ZE5teXBzOXhoMlpn?=
 =?utf-8?B?amI2RTN6QVdSN2N0cUVJenM2QmNneWNWNFAyUmwvVkxyNHlQSlpCZWo4WmtQ?=
 =?utf-8?B?bEFwUEs5WWtiR2hrSWpnR1RxeDhORVhrVEw4TGY3SWd2dGpWV0lOK0pIOTVz?=
 =?utf-8?B?TnZYb1ZVak9nNlNZMHRqVWRjWVc3UkRudEQxQWV5NjUweWRHRDJVdHU5WjFL?=
 =?utf-8?B?Mjl3Mk1GZ3lCYkYxM015UG9rNkdNaFBhMCtQRmd3QUFZNTRva1BzYlU2TEVW?=
 =?utf-8?B?NWM0QzFweGJ5cUQ1b0IySmRab3RPQ00ySmoxNWJKcmMyeUJrZkg5cnpQT0Yz?=
 =?utf-8?B?cGNhR1pUNEVqeWg1OXlwMGlqQmtVRHdxUUNCNHZMbG9wOHN1alpTcTVRSmtQ?=
 =?utf-8?B?elExbW9oMklLVWNId0RzNDZEc3JGcitqam5mWkhhOTlVUXk2NGxMZGVqYzRo?=
 =?utf-8?B?dVpCeFg4ODIxaFk4YVBBN0xtdVcvbnFZckN4TUR0LzA4bGpyTUZHUkxGV1Ux?=
 =?utf-8?B?OWhINWtWMlVQSStDSmNHT3hzQ1BkZHg2MTJtV3FqOGJ2b1ZlVVd3TE1BQUZC?=
 =?utf-8?B?OXR1NVBkNjJBNFF5bDFaanNPb0VQQU1TNTQ5RXh1TkFFeXczc3U1bE1SYzlq?=
 =?utf-8?B?M1JpaUVQOEJ2QzBxczJ2WXdGeCt0QlBsK1FKQzRXTXR2N3YyeVY0bk5wV0FW?=
 =?utf-8?B?M1hpcnVBckRpTFdaUjczRDBkazdIVmpYUXdxQUc3K2tpVGovWkxFanpCV25W?=
 =?utf-8?B?MmxEN2R6TjJLVWoxM1Q4cC9ZOVVNcGMvQmx5L3dVTmJVcjhrVnQ3MHhMdUJ0?=
 =?utf-8?B?elVoK3NYQW4zN29FVnp3cHB6MFhCOGtQZGY2QWsvMVVNYXkyS2w4TlUwVEEv?=
 =?utf-8?B?aW1xdzN5Ri9sNSsvOUxkOWIxNGpqSWQxdjZwWGlqS2pJL3FNN1JmVXgwYkpY?=
 =?utf-8?B?aUJXVXlzT1p6dVRVam1ZUm9COGU5dVNLUHpOSmxpR3l6VWNTR2dsUlQzOXpn?=
 =?utf-8?B?SU5MSmR0M1FpS2FGVnJGMXVEeS9EM2ZGcGlmY2FUbTJXNi9pRXdTaHBwS1JI?=
 =?utf-8?B?MVhtQngyUlFYVXZPWUR3VmE2a2gxRkdxT24zVWxxTERkaVJ2ejNpVFdUeFVS?=
 =?utf-8?B?N0FNLzFQTCtDM1JEVExrYnBFdjVVdXhxRUlabHBzRmxkaTduMGtwelA4WEg0?=
 =?utf-8?Q?/lstzG31PTP7KLvPMi7yUi7q/euOjEM2USMXel2t7V53M?=
X-MS-Exchange-AntiSpam-MessageData-1: CFu129G6ctLbig==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b8a71-78d3-4bbb-bc26-08de5a82e326
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 13:25:33.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMqaADqV6bQytlCBNe0IEnrnTKlcYXtmXUueecxDbU8qJtHjBIYwpnRBOcasoXpozbzojxbnktVmdsR4UMb+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418



On 22/01/2026 23:31, Radu Rendec wrote:

...

> Thanks very much for running the test and for the logs. The good news
> is good ol' printk debugging seems to be working, and the last message
> in the log is indeed related to dw-pci irq affinity control, which is
> what the patch touches. So we're on to something. The bad news is I
> can't yet figure out what's wrong.
> 
> The CPUs are taken offline one by one, starting with CPU 7. The code in
> question runs on the dying CPU, and with hardware interrupts disabled
> on all CPUs. The (simplified) call stack looks like this:
> 
> irq_migrate_all_off_this_cpu
>    for_each_active_irq
>      migrate_one_irq
>        irq_do_set_affinity
>          irq_chip_redirect_set_affinity (via chip->irq_set_affinity)
> 
> The debug patch I gave you adds:
>   * a printk to irq_chip_redirect_set_affinity (which is very small)
>   * a printk at the beginning of migrate_one_irq
> 
> Also, the call to irq_do_set_affinity is almost the last thing that
> happens in migrate_one_irq, and that for_each_active_irq loop is quite
> small too. So, there isn't much happening between the printk in
> irq_chip_redirect_set_affinity for the msi irq (which we do see in the
> log) and the printk in migrate_one_irq for the next irq (which we don't
> see).
> 
> My first thought is to add more printk's between those two and narrow
> down the spot where it gets stuck.
> 
> I think the fastest way to debug it is if I can test myself. I tried to
> reproduce the issue on a Jetson AGX Orin, and I couldn't. By the way,
> how often does it hang? e.g., out of say 10 suspend attempts, how many
> fail?

For Jetson AGX Xavier it fails on the first suspend attempt.

> I do have access to a Jetson Xavier NX (in theory) but it looks like
> there's a lab issue with that board, which hopefully gets sorted out
> tomorrow. If I can't get a hold of that board (or can't reproduce the
> problem on it), I may ask you to try a few other things. In any case,
> I'll update this thread again either tomorrow or (more likely) early
> next week.

Weirdly I don't see this with Jetson Xavier NX. However, could be worth 
trying but you may wish to revert this change [0] because it is causing 
other issues for Jetson Xavier NX.

Jon

[0] 
https://lore.kernel.org/linux-tegra/e32b0819-2c29-4c83-83d5-e28dc4b2b01f@nvidia.com/


-- 
nvpublic

