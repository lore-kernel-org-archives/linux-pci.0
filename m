Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF882D541B;
	Thu, 22 Jan 2026 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055912; cv=fail; b=Y69dqoHkJ6H5g805a73DfZFRLr1rkVl1sd7+pcqChJUQHqZizJDUO1THqA1dg0trPBCjcJS/E8tz/jFZ3yMoPXbbsRFloBYBLHoQEu5a/15tApgD0egBwhoIqHUdVwLHtnJ6Z6q/8+w6VMTH1Mynr8asrqmxcCqQFYM/ucD9yAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055912; c=relaxed/simple;
	bh=nG8KMzQrZdsYgQtmu6D8kGy5r+M83IJz094tU8zVQqo=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=dtxX+WQuVSN9yLoQmAxA/DBoWgvfCwT3T1jpwqEgbdRAGLh7PnPsY/DF+cEplRoIX0jbTgRbEH43ZF6PVQfNw7+XhK9C4LJS+ypR6W94IBAJG72qWmAFEYIj8VFO6PTzJUKT70mLbP/eyYIXc9wSJGNhHH354tZvCCX1oCQFdgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGYGr+uS; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGYGr+uS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of7JSMiHJBf3vynrUDuShYKusJP3n3hx7m4njxTYX3xuwfGTxfOjVFEgNTiCI+LCqDEmWNysNxDhU1LT+xdoPokAVY9kPwrzcvVEmObRvpGwsn2JzeQC/eRrTg/5gpeO/1FtgA0+T2Ob/hzrlBwGfKd34ERKF2qSE44h/T6ygWD7/MQNArVPGx/eU9Hbq9N7ygFTfw+NwfiK9MajlkLRYl8zd18kzGZ5rOSV04QoP+XaE56QA4Kkr/ZqhRAI4Dc8KPkQXjOPtO0noScW9vGiOSwTJ4sAe1eDYx9cnTAFAyT3ZuQpDG0oK/2kzbE6Cg66SQTygHYdzJv654ndiV5FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhfeHKbvf71gTBBsmQ/4opsHkQUPVPBj48WzRZSLWrE=;
 b=dZku/W3/gKc1b6eXmSXnP1y6eF7yaAGZrOYZ6METeh2TTsmtDUecMzVI+LGT8FY/8LuuVpRhONkT7JH436/qsYZe1mt0ShrfZ6XCvg3h+Dc33ou9naFF13WVTQ/V2h9P1DI9HQhXO8C6/iXlIv2o8eJrBbMYNPQ2jZge8aDrTuxHxC5QpSDck+/jJUgBK2eFWpr9aWWk9LHw+hC100sh/CKLHcuX1+WgTe05jJKiiWbG2+w3LOMvZf5N+tmJP9+nDPJAw/GyQiZ6LTiO010WkYGtkymhA/beRbC1RTS0hFNFnOSaGflgxjkva6TGUBan+2E2dlcfjksGO6YmEp5sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhfeHKbvf71gTBBsmQ/4opsHkQUPVPBj48WzRZSLWrE=;
 b=bGYGr+uSSt1Yyd2zUEzHKOc/TeceMFXz0wrdHSxqT58Mm8IGIWlsOjh8w3FEYdk69J34syWK0h00eYx75i231uHpgqpamzTzn4Engw535H1F7Hq9wtDysLSod/+xhaxDiAjbpj3bXR9w137/IKKkPK31288Iixu+A9H4kmpPqItSiHCXEqEXcEhFkUDwbjDvDqnidFlz5UymWfSw3QOKqWETtXv5/YTeRPJlT0af5qLRHNvGsMtU0PdW+w8xic4co2rH6yw6JfkKMNVtufCM61T0UoofD+DqZy8iqXpwwj6EpDTq78Tg+mRr1UXJkVsKCvo7zeSss2kMNQm4BcOUzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:25:07 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 04:25:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:25:02 +0900
Message-Id: <DFUTZA4N567I.3S2CCXS3FR95L@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 4/5] rust: pci: add config space read/write support
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-5-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-5-zhiw@nvidia.com>
X-ClientProxiedBy: TYCP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::12) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b16eb8-886b-4473-188b-08de596e385c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzdlQ1NRYTRPTUI2UFJCZ0w5bXdyRXRBSEVXWGpCNDBMMFFYeW9mUlJTMUNa?=
 =?utf-8?B?bStBU0h5YnlwN212WGlRVSswdlkyd0NWZGo2dlpveEp0UnpDMk4zN1lhSjN3?=
 =?utf-8?B?REFFeGpiS3NDbmt4cjVMamZuUnZnRktyb2JtZ1NkeW4xa29uUnh6Z1ZVYUE3?=
 =?utf-8?B?TmFIZS9ZWU9BNkQyS1I1Ynh0bWtXaUlTVW5yS3FLdUdDdnhOenBjVTd0VXR1?=
 =?utf-8?B?Z3g4QXdtY09ib0o4RFp5QlhwTXlQeHdiS3RvRWx6cUhMeFNHOFZ6MW1IZTFY?=
 =?utf-8?B?QW9uQ001QjUrRXdyZk4xclhsOVhZcU9BcXBCMGpvbGluUC9mbG0yUzU5QU0y?=
 =?utf-8?B?UDB6anphWFdpaDNIaURGdDJORHlKZ3JmYytlenl5ZVVUcmMyNHJFQkc4SUNs?=
 =?utf-8?B?ZytqU3JnVmZsR0ZtMFc0RWViVXJ5ZGk1Mnl2cWEwdktSQnNVZjJ6VU9laUhW?=
 =?utf-8?B?eEtYR3JZOG9oSkQ2eEZTWWxURXorWGVaeFNMMGRyYWJaUmV3eDRWS1ZvVFFX?=
 =?utf-8?B?S1hLQWJJaTJHN2RHNkdRUG9SdWZ3ZGhYTFRzSnU5V05NS2ladWU5ZnRMN2dz?=
 =?utf-8?B?TmhJcEFnYmN4TmdMSG5oZC85dHVtWjBVZGIrSVVsRjZYdDQ4bGRlQmx5Y2w5?=
 =?utf-8?B?QzZFSnFyZEFLaVMrUWVnYURtSGY3dExoMWR4V1lQSDFqcFRnaDNuWGg5Yi92?=
 =?utf-8?B?S3JIeC9jYWY3RjRDRy9raFlEWG11ZFpaNHBzeXZBV3prNjFvdVErcHJaNnhU?=
 =?utf-8?B?YTBobzN5bWRsdlJwZ2tOaUQxaXpOYjdJV1B2QmVwTXdPNmljeUhrS2wrNVNV?=
 =?utf-8?B?ZldrU01tUUFVcW55cGVxOXNoVFNrMHNVZTdUM2RhMVMxbllmVVhLbzk3UkJk?=
 =?utf-8?B?L1JUZ21XT2Eyd3ZQVTNrWWZtTlN5bXZMMjFoRkx6RThscTc1Y2ZqbUhoQ21M?=
 =?utf-8?B?UU16Zml6QjBGbXVjZEhCcUtkSnhQT0lwbXFCRitOcVpsUzB5QUhEbjFLZ1do?=
 =?utf-8?B?bWY1d2szU2lDeVNNWFdQRDBSTHpHRFFyVUZmRTRTL0hUYUk3WDZIVm0yVCth?=
 =?utf-8?B?TS9Zb3UzN0prdjd3STBweEpyYTUvcTZRN2k5Y1hWejV2VUdRVHY0akFzaG16?=
 =?utf-8?B?eExGS0hUYU9SOHBLNmlGV1NHSGxObnFlSXo1cms0MW1Tell0b28xOWdnWkdQ?=
 =?utf-8?B?SldaOE10WFRuSjhGcytmVDFqZFluUlR0OUZzQjlnZUlESlI3TGhGV2h4THlj?=
 =?utf-8?B?cEJGTHJGa3diRGtxc1Iwb2xmNzBhWUwyNWJQSnZ3VTRvR0F4MHI3ODJiUnpR?=
 =?utf-8?B?QXpWSTZ3TGU3WEk0VWl4RjJNWmRZQ2UwT1d6NlhnUkhiYy9Pd2pVVzhIekZQ?=
 =?utf-8?B?T3N0UFNQRXo0YkhoaTVuMG1LVytpOWdhQmlqeVlBeFpScGpXMjlCWGoraFBn?=
 =?utf-8?B?bituSGxOTVdINlRaMG1JdjVBNmJSUDFLZUNYQXorMmdBM0VQUmdhUG1FMWJD?=
 =?utf-8?B?N1pwM3VORHl0K1ZuVmY3ZnpkM3I3akh5T01SUmFaNkU2YU1jb2tIb1lnTjFn?=
 =?utf-8?B?YytialBCZzkyT096K3IwMWVEd2lHUHExMFhiSG5GdWZ2d2Q0VFFIanJyQ3Y1?=
 =?utf-8?B?N2V0Y21icWlQTWtCb2F1KzNLUXVSU0FhUDEvZUp4dng4SVNnYkIxY1MwTUZ3?=
 =?utf-8?B?SGJpVVY5MGd2cGxmcWZlZGxjd0R3VnhKaXhiR2t5N2VCU3JWcll5ak4yS2Uy?=
 =?utf-8?B?NHhJOU9NcnRLRGRiNDdXZ3ZuYTlTeXIwNmNqbUtGczR2N3BVODBKTnMxSXY2?=
 =?utf-8?B?RXA0aHR3Tm0rNUkvMmMrZFJFd2pER3FZMG9saW1kV0o1dnNnNjREMndzNVRs?=
 =?utf-8?B?Y29lVFVBSk45OUh3L3pvdHF2ZThGY1Z1Qm1jUzhtM0tMcmNacml1R1hDVlJr?=
 =?utf-8?B?aGVES2dEM2Z3L3lwV05qaVhIWlBzMW5FVmlETkpwc3RITGlBZTNzbTRheDZX?=
 =?utf-8?B?dy93UnF5YkNzZThtWFk2d1BkN05zRWRiZlJQa2FTWDVOdXU1S0FJWmN2cGht?=
 =?utf-8?B?Uk5YZjJQU0JwZUZMZDVGNk41ZG1EWGs5YkRRd1hQQUxFOWFSR2x6bUdNUENN?=
 =?utf-8?Q?I7Pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUFoZTFpWnk2VUE2Z0tWMFZ3aEtUV213ZUVhcjJpbDcvMlM2Z1htY2ZKeUxW?=
 =?utf-8?B?RnFoWk8vOWV4TGFGWjF3WFkxSW9IWEZpRjZBSWl2amV0VjY1bW4vdzA5Q2tj?=
 =?utf-8?B?NnFZU1EwVDRQVXFUdFRKMjVsVlcxaGwzeU1MQmpDbW9kS2hsaHREMWNUN3JC?=
 =?utf-8?B?eHdLZXBnQzYxcEczQUlXNC8wczR1Tkk4eDVWNU5KMWRGTzdESWd5MTR2YWwv?=
 =?utf-8?B?V0I0cml0WE00cDl3akVMd2R0ZzIrWndKcWkzRnFxOW0rWHM1YlZwdTk5U3l3?=
 =?utf-8?B?REc4aDZlRys5M1FPaEE5ZEV4ejAyK0l6VWJVQ2xza1EwTHJGY0RrVERMWlpR?=
 =?utf-8?B?NHlFTDVVRklMcTk4bnZrYUxzTHVDZFhocWRGOVd6cytxQS9mdmVrUmprL2Zr?=
 =?utf-8?B?aFdjQ2xFQzJpUUo1OEt2RS9OSlhxSCs5OTFaa2gxbUN1bk9lS1FYRE9xWWFL?=
 =?utf-8?B?c0pLUW04Q2lvR3VnN0RwM25GMVpUWGFmRTByK09DQlYrbUtKSVdUOGEyUEVO?=
 =?utf-8?B?bm9vL0JGMG9aSHlLdk9tUEpVTmI0bUhBOW5UM1pzM1h3bWtPMCs0KzJZSWY2?=
 =?utf-8?B?MUd4ZTdBU2N5ZFZEY2NLYTNaMk9jOTM5d3NvY2F1djNZdGgyamluWjlMUmFj?=
 =?utf-8?B?dHRyeStlYVRGdUJxdGIyZDQxYnZtby81N0hXU3NCeS9PVUZvZnBmNTlOdTRU?=
 =?utf-8?B?Zk8yU2h4Z0ppRTFzTEhWdFllQTJEVk81TEQxMnNGYVlNRndmdWRXL0FlTG5l?=
 =?utf-8?B?TnUyQyszZ1hncDhBbitXeG0vOENaalNLV2lrUjk3ckhGbG1mTWJoZEhaVTUz?=
 =?utf-8?B?eTBaZm5jcWg3ZExCc1lHVTM2dkZzRm1oWk1UQzhva2xscmpQSXBkQUU0bVhZ?=
 =?utf-8?B?TFdOUVhQakE3cW1VbjFGQTJxdUhsOVpDclRxeUJuQUlDb0hicWMyYjdXL3lV?=
 =?utf-8?B?UEc3cjhFejB6aENyanI1b0drbE1ucEpob21kUUN6TlBKVUpLMmt6dnJyUUpR?=
 =?utf-8?B?NkNTdWRycWJ0dUlZb2lsZFVEbFZkOUYvV1JTcTBxMWpRV1JlZmhtRzF3OG5p?=
 =?utf-8?B?LzJTcEx3VGtaUGltVDUzQzQ3eHlGclU0ZWdKUndkUkpDNjhrSC9ITnR1Sjlx?=
 =?utf-8?B?NmZHWHhocnpVK05TaDNIMjdIS0diTVhZcjQ1MDA5STNlblpPN25uZTFPV3Ur?=
 =?utf-8?B?TXljaCtwb2t4S3ozT0JyVmJ5YmtpUVhZcEgvZDd2RlpBMnNacXVxYUp0bjBY?=
 =?utf-8?B?aDdmVnZZd3hRTVNUQkFhVUVXVVQ4WE5EZHl5ME1mNGpGai9SYWx0UkwrOU5V?=
 =?utf-8?B?cE9INUJ4bXlxVFdqZkQrT0ZzbFpRRmlEcEx6bUgxQXg5SFhFd2xneVB0cE9J?=
 =?utf-8?B?TTcvVVNoY0hCZDZKUlg4eVphczR3dDRiVlRuaWZuMldzNmZ4QlRoWFNuRFpQ?=
 =?utf-8?B?a3VGY1g5a1VMVFcvbGVqcUcxczdkVzJnZnJuR1Q0ZEVmemZ5V0hKWW01N3Zp?=
 =?utf-8?B?N2xtUnQ2YVZYVjVOTCtDcFFuR1lxcHRuNmt3NkYrN05aWERVS09Pd1pkbnhN?=
 =?utf-8?B?MlRyYlJLZWd2M1VSZ0M0bFVFZzZhWXpzWmdHazJGZWYyKytqSnNwaktIYysz?=
 =?utf-8?B?QWJqZ2ZJNWFtZHk2RW13bWFVaXRVY0NhZTRnd1FQQkZLbWUxRzhReG84ZG5T?=
 =?utf-8?B?RG5yMW9pSll2dUtoMW8xUEVzY0NqRXkrbGVGU2l5S21kK3lES3dpeGZWQzNW?=
 =?utf-8?B?RnFVTW0wWHNPaHFLYzRUR1kwa1lseXBvWDlvRU5WQmtuZWxnUDY0UlNmQnpu?=
 =?utf-8?B?U0ZrRFJVR3haMUIxd05RNEFabjFncTNTc2VWZVdIUURoVFVJWUVMbDRKbmxB?=
 =?utf-8?B?WTllZTMwaS80Qm8zaUxjLy9wSWtieU1TaHliYTl1ZjBLdmpLSExiSE5zbUtO?=
 =?utf-8?B?MVdhTGMrMUo1K3BDTlB1RGZtYkg2dW53cnRMRnhNWEpuSVlTZVNZZ1Bhd0NT?=
 =?utf-8?B?b05hVmMyamtLNmZRTTVxQ3JoSk9oRDZmNVF3TW1JZi9MTi9PQm41dFZoK0Fx?=
 =?utf-8?B?RG8wQmEyK3NVOFhPOERReEcwMDJkUEQzSHgwVHFOM1Zld2hXMHpTTXBaQS80?=
 =?utf-8?B?ZFVISnpTSC9yZFJVS3hxamczMUlKU0VXeXN3cDNib3FxeEpKOTBUZjVrQ25i?=
 =?utf-8?B?TFpDL28xWVdlZHhhY0t2Ny9JWk8vWVpsckdmbmp2M0U2Sk1vM1piZC9UQnQ3?=
 =?utf-8?B?YTNydE5kcnJtUm5VUDZvMDArTzl6NmxhM1ZzYlZKeTFlUDhWZ0hHMnFyNkJ0?=
 =?utf-8?B?enUxcEtDVnpuTW9Wc3V0bjBvNTY0Vk4rNmMySkdDYVpISGxWV21DbUtHaW5i?=
 =?utf-8?Q?K2eeZhCgZ5Uy+PZ4BVuYQi5BU9rdxAjVn3JY3JVUUN855?=
X-MS-Exchange-AntiSpam-MessageData-1: Vtns+a2Hs5CceQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b16eb8-886b-4473-188b-08de596e385c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:25:07.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWrnuuDJ+VMeI+f+o9js4SFnFuo0fEi+kLybw40R2Lx7uiBd1g+9HuCecnjcxNy9kyP365ctNkZ2WFvA8lXLvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
<snip>
> +    /// Return an initialized normal (256-byte) config space object.
> +    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a, Normal>>=
 {
> +        Ok(ConfigSpace {
> +            pdev: self,
> +            _marker: PhantomData,
> +        })
> +    }
> +
> +    /// Return an initialized extended (4096-byte) config space object.
> +    pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a,=
 Extended>> {
> +        Ok(ConfigSpace {
> +            pdev: self,
> +            _marker: PhantomData,
> +        })
> +    }

Why are we returning a `Result` given that none of these methods can
ever fail? I mentioned that in earlier revisions too [1], but it looks
like we should invoke `cfg_size` to validate the size first, lest we
return a `ConfigSpace` that is larger than what is actually supported.

[1] https://lore.kernel.org/all/DEHUBNKNSNXH.14A4OGQKY5KZR@nvidia.com/#t
