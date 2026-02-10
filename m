Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2832ABF7;
	Tue, 10 Feb 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743318; cv=fail; b=A2F8BAYb7BkiOH5BBaZDy1paVMDQ2dq4G7Wg64v+8tnb7qNSs2Me3gjItgwQfWDCl4kZcYKhWIHP7i7Gg6ZJIz0gMMzjnEeRkVuGYPIZBnK/f7SGOAZf7BMfa7OoRIiHo5lXF8C7sWGdPOBZRl1VYfM9ZFS9Rvz/GxyL6ZPujZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743318; c=relaxed/simple;
	bh=+1h7BXLfCLIL7SEOjOdeWS/QJYYYWunPL1Vl+F+aM7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZFxrQHDrynnyn5x64ghi2au8KcVRJ1Z65MS7xzWsBvPTutDSEZ2qOMudgynwu9Sda+XM0reM/m0jDqdB84JpH5dJYVfotmOHddGjpXUm9syHss4LOQtGOK7Hg/eBDT8+7YRwTfEs5lfKTUdrVhqFSmy9weNkHk1rsvcQVPwdqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OsfiYBtZ; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OsfiYBtZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQQKgwv+a+mkMTubaCJHUcSLGj+TVl3hm+B7GAK8g66fCT5Vw+GPRLKOH9mEKEXZZ5WXKqALAXvc4ldCX1HqG5wEXDjm2wB1lQydNXFHS61lqMZ0gXmNFhOfMJ7owjDBbE9uwhXU2NaG/x6W0crswjpvvdAF9de4v5QfL41Y4i8t3KTS3WGYXD6vRbOAaXqbKmixmINL0YpNwIuzhGLDOj1odPn1Fv0dnE7yy0CYsSR8JnIWOkk2/iFEUr+MwGaKAqfhHyM/sQIo3tYGDk69Y+mMy0JkfPpwL81Uz2bkuTx+dPn9zY433vJpgkrYuo7No456ovhcd8w+1X6E5TZNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTdQXl42n9CJvmucDc4ax0YKl6Z3lMi/My+peOZ2WGk=;
 b=pkGiZ4uZcxfZ89Z5vaBVIdotApgvX+n5u4Cxs6yaBSrDynIO5Ks6ZlkFd/hK4YqYPMkm7fA028bz0ys0kVG8MCwkBPEAcPfFK0RScm1zCFgExjLyi6YDHSs1vhBYXpq2ijf24YuNKzGoIqqKCKlbC3+CfRAB5CdAJXjGhsRA8hvB79qP/0q+1bqoESwojdBjtDP/34ikW48tnoOdJxsj95DP1LhMA0l5lCIyIR7GfccGuI1SnpYEtROrHk/gOh1+vjDDC/v4nrHsb0pyQyo5RE+0hTWGH3PXyBDHDJ53r+jTQJJmWCGRfFo7ORyDGZKikrAJ2NYTudLx5ZCX+auMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTdQXl42n9CJvmucDc4ax0YKl6Z3lMi/My+peOZ2WGk=;
 b=OsfiYBtZvKo4KKN46f2IGANSgmnLPYUXz67Lz4uEX09N5Df11qnHIEuCUjmFVsu8GvMbmvPhurB5QWJkbJ+9H9IYMN5yhlf157/GzOzHPY+bOLEMQRoNO5vaGgZnDf04u7f8vGyE8GaOpMgJwpp04yfVbU3QsMSI1GubCdu7HbMhqigQN5FvT/wV9jIfdcIrQ3LLcjnHa2iBo57bFPtM9+rhfZzjKtjdQFzRoa5rbtT6V0+gpkTHAu0cdL13btLE8/98xuIxB9rBxyEj+VjO/vvgDOLcBIsbrnmOZWtOJEU0mCLFXfUxw8ECMFV+5OA0mOwM+GoGSvYTUmSuywmlLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 17:08:30 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:08:30 +0000
Message-ID: <39f1416c-32aa-4392-a62b-00b9167b2fad@nvidia.com>
Date: Tue, 10 Feb 2026 17:08:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [V5,02/13] PCI: tegra194: Refactor LTSSM state polling on
 surprise down
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
 <20260208180746.2024338-3-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260208180746.2024338-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: b783243f-7584-4c77-57eb-08de68c7037b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjRueWd2aDdVRUdXTmRhZHJxcUxycEhGN2Y0NU1DUlk4WmhIOVJFSWEyS2RR?=
 =?utf-8?B?Um9RT0s0aGw2TzBmb0JySi93U2ZvWld3bmRhMmZTYWo3OHZsUThSTXordnIx?=
 =?utf-8?B?b2dkeHNab25ZUVVrZEw0RkQ2djRiY09VQ0NpUHA4T2FZa0Y4dnhnS1E0OE9Q?=
 =?utf-8?B?OWtpSzQ1V05TbGs0V0ZIME9KRit3MWo4b21pRURtYS9tK1kyWEdWUUxtTUNQ?=
 =?utf-8?B?TXFnSEtacUZhb2cxK09UdmIzOW1sZjE0bUZLVUtpR0IrcFdZWnNrb3dkN2hl?=
 =?utf-8?B?YXVEZGtsRUtKb2NmemxVMUIyS2QyWXNFalVXSXZQZkRCQXN6bnVkQUU0bG5j?=
 =?utf-8?B?UmJ6YWhXSjhEbFMyUW1USHMycnk4QWZpUzE4Y3o1QkNQQzlzY2R6NHBzeksz?=
 =?utf-8?B?L3MxQ1R0UTZ3ZTAwWkxLWXVManNYZ3lHNVY5dTIvTWMyQkdjMythZTlNU0RC?=
 =?utf-8?B?dnU5MDNvYzlLS2xzWGVFSjRvcUJzZnRiVEVDbFVwODhVTTllc0JMcnV6Zits?=
 =?utf-8?B?bmY5UW1ZUjVDT0dVNUJ0aHRKZWwvN3lySGMyWkwrOHoxVUprNGtDd2MrV1RS?=
 =?utf-8?B?ODltL3A5RFpXYU15c3lUU0gySmpRT0NlYVBnazljQjF2dW5oZzIrRmNpRUtQ?=
 =?utf-8?B?NUVmQWJpTVp5ckwwTk9HeUhKSkZjTjlMOVZESzBLVTZiSmkrL0tybjM0V0Q1?=
 =?utf-8?B?N1JJMWNTcVNHVEhiRFJPQlV1LzB4dGkvKyt4cEJJVkVqTWp6VnVxak9QeHJx?=
 =?utf-8?B?dFgvQ1loa1hCdG42TWF4bnFLUnArazlWQTNBL2RnOGk3ZVp1bGQ5SjUycXJK?=
 =?utf-8?B?dktSUVhQOW8xWjZYa3RkNG50akJId3JQYitkNnRTMlBZOFpzYVhXbTdDS09x?=
 =?utf-8?B?anZCZGRIOWQ3NEdqYmNIN2Fwc0V1dWI3MUw4blpDNUpZejZqUWJxclJETCtw?=
 =?utf-8?B?a3J3c2hWaXdRK3V1UUNRWmdRQUVLQVdROTBoczZNdWxRb2hpdTBqUDgzc1RE?=
 =?utf-8?B?RHlFdE9FS05ja1RtZWVydzJ1VjdSMlFuOVgwaFNkaHQ5Vjl5RjBHUFNycFZ0?=
 =?utf-8?B?RmlUYXAyZzhiWUdYZGcrRXVCczlZbXZvK0pJK3Z6NGtJZ3JQbDNiYmdDS0lN?=
 =?utf-8?B?U3loaWp0TnFUUzBTMTdZUFRoK0NTR21rZXczdFlDSUtZcWZadjVEZUhsVlJB?=
 =?utf-8?B?Y3k1NytRbUUySUh5cXlGTDBUSTdUMkpuVjNNZnhpL3lvRGVPY2tyS1ZsUy80?=
 =?utf-8?B?bFdTdEZzRStoSjk5ZnJlU2p6N0l4Y0RXR2ZvWXFDaHFXdjZGT1E0S3M0dTFF?=
 =?utf-8?B?bkFIWWpwSURVK0UzNFh0VEgvTk1GMlN1ejA1YkhqMGV5ZXdjNXBaZXhiclhY?=
 =?utf-8?B?K2VDMjBjQ1RnbW40YlFJdEl3YjFqU01DanlQc1hQRzkyVkRmSDkvZk1TRWpa?=
 =?utf-8?B?eks4MHhBcjBZWGlOUDdSSmxLUW0yRXpGM1gyNUl2c1F1WmdHMWpCQ1VhVFJw?=
 =?utf-8?B?RlVxZnhYdm5lWU9qdzd4L01EOHd5d3E2WkdpNGIrRktMYUxsbjBJYmRXUGcr?=
 =?utf-8?B?NEpTeEQ0cDZlM21CYW8vZFJadmszMngvaGtDVHhySkxDd1N3TWFMNFZ0amZo?=
 =?utf-8?B?UFRTMmpFeVBsQ1pqeU51SVhWaVVzOE50SDB6Qi8vYkRSOHJUUWtrZGZBdFNh?=
 =?utf-8?B?QlQvZ3VnRlNkRzVwdEhoemhUbnVsNGVGcnZiZzM3SHMxUXBqL281cnA3MDhv?=
 =?utf-8?B?TEsvNWp1aU03bUU3NGtXRXp0YlhvNCtFc2NzbFMyZUJHSFJLRG1MNVpqMzBy?=
 =?utf-8?B?bWpJd2o1TWtta1RMREZiWVR3R2RrS1pVZjBzWGNSWkdrbW50TFRib1hMUU9q?=
 =?utf-8?B?cHFHeTYzaEp4eDYxVGg2eEFHeVRhdVJ1R2JydnZac2hYM3RRT3dwOXhzWWF1?=
 =?utf-8?B?Zld4RW5GdEhCZTFzRkl1VWgwNEFNKy9sSTlUVnpSdGVqNzRKM3RHZUtickY5?=
 =?utf-8?B?Q0p6Skx0SUpqeGFrMWV6NGR1c0YyTU9abmI1bThQbjM5WFkvOHk0cVdOVUhC?=
 =?utf-8?B?SUljL1JUS0ZQVm10YmR4M05YOGZQUnA0alhWZUhWZnBHVmZFQWR4aitZdUMy?=
 =?utf-8?B?eXA0eUV5ZkQxWTFCTi81d0JiRi9WWWNwd0NuUTdEdUI3YTV0Skd5OXF5d0VE?=
 =?utf-8?B?eEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWJpdHZ3bi9xWm44NDUwTzVsMHJqQ3lHY0VyckQ0N2ppNzZ3ak5CUmpnVm5o?=
 =?utf-8?B?VlBkc2R0aUQwZituWTFpTnQwZGMzMWNLMlNQdVY2eTFha1RRMEZtLzlCK2Qr?=
 =?utf-8?B?YWJQNTRibmd2VldCd3hHUkNpbllFUTVlVzREeE82aXN1NHJNRVVjSVAyS3Ir?=
 =?utf-8?B?ZEppMitmRER4RFZwdW1JeGxKQ24vSHNQc0M1VktoRWhYQlBoYUs1WmtnYzNk?=
 =?utf-8?B?SS9EOEZ2dDRKWFpuR0VvdktUZVc1SlV5UHVQMUJQR2lGcDEzZzNLbE1MSUsx?=
 =?utf-8?B?VHFUMnFZaENibUpYMllvMnd6Y0FQLzZZQm9lUnJ2WnZ0OXRTcFYxSlVqUjRw?=
 =?utf-8?B?d1F3a21ZYTlxbnFwTnVScUFWQTZWbjZKS3JQcmtvcmJ5ckNQOFltN20vS1Yv?=
 =?utf-8?B?U3g2dVNtbXFaSmpjRjFxekcwd1hML2VNOGlpQkhhaWxaNHlRQjMvOVcwQUpp?=
 =?utf-8?B?VzZQWVI4TFZkaUdSWFgvZjlycUlqeWRIdWE1czdYKzlFMUVKd2VGM2I1U3Bv?=
 =?utf-8?B?TURBM1Z3cXdGTDd5d1RySmc3Ti9lUHBsY0wxQlR4WUNTanhEcHZ1V1J3YXpn?=
 =?utf-8?B?cVRnb3dsMnNnVStEQ0hudjBtcjNiWDdjS0F2YnF1M1VjaFRCd01BeUpGQnJR?=
 =?utf-8?B?bXczMUovbDJzSUIrRjZLZ1FFZllxVi81aDU2RUZFc0FheWZibHBEc0lMTXdT?=
 =?utf-8?B?WlE0Z0JlSDFOOWxIWGVvVkhQZzM0Z2kreFRCSDNsVTVCL3F5WnlKQklZby9n?=
 =?utf-8?B?d0hSTmkxRldtemNxbEhGemNtS3RWMkRsdnJHZTVoK2lYZWljbGJPdnBPZ1Ew?=
 =?utf-8?B?YnZ0YndBYkdKQ2ZPWFNXTmI5dERDNUZ0SWpzdkNtK2ZadVN0Rm9FaHB3QnFa?=
 =?utf-8?B?eVBhRGwwU2JqemxWZ1VHblVjdWMybXVsNnA5UnNUT2dVUlVSU0NjN2l2WHN4?=
 =?utf-8?B?ZVJkdVZGZ3N5V2w5L0s3V3I0VG9OWnNsUGdHMjZLZ2R0eW9Ya1JodlkvYmtw?=
 =?utf-8?B?ZTNpdkhmNXQveXdNVWs3NW9NZVNmR2crQTVlOGJHOWIxZlErTm10cDZ4Wis0?=
 =?utf-8?B?bUljYjd4WkhNUUZPYlUzVDJwTVVMVis3SXBMdGVINUJlcDJ3R0lQcWFlWmsr?=
 =?utf-8?B?UldMUjNtQ0loVjh1Ui80SExBbWZBdDE4cDErYnlQZlFmY29BdlN2MWNTNFFo?=
 =?utf-8?B?dC9kWU9NN1hLK2gwMExaVDY0a3JqYjk3WkJsZ2d0bFhNMlZKcVpQRnFqdllR?=
 =?utf-8?B?eGlNK1BlWEtrTWRSQ050aTdGRm1lWWlTejFLeXZCbmpPenBiZURsOUp2UEdP?=
 =?utf-8?B?NmpiOE96QjBZd1daK1YrNzBPSXpRTmhMSmxkVUxrclVCbWpuZDJvZThwNUp2?=
 =?utf-8?B?L1B3ZEFyTmUrMVp5WitONmVyT25haHNQYkY1cEZ0K2dXRkgxa3p5Z1VOS0tB?=
 =?utf-8?B?WjIxUjgyLzFCbHNVYnVPMlJueFhKZnVKSFpobkpsSFNNZHA3dGRYem5ReEFO?=
 =?utf-8?B?SGkzMTlQTWhTaURtaHZ3YXJRSkd5SDV3bVpJUTNRMThyVjU5MG5IWTBlZTdB?=
 =?utf-8?B?TjB3K05VaWJuVFdpTjV1MWlFdFZUR24vQmthNjJaL3FaU2s3Qk5QNldLK0ww?=
 =?utf-8?B?Y1U0QVRnMXRZcUd1bkh6d2lzWnBjTDk5a3ZMK3BxUHZvb3cyb1NXLzU5NFhL?=
 =?utf-8?B?L1U0ZkV2NmJrVnRhc0p1YkFzWkMwVXRlWlJiRC8xRUZTd0tObElrNDNmVVFR?=
 =?utf-8?B?T3JBYXVZU0VQSlg4NkxvbDdXVDk1MldzNDlzY0dnZ1NNTW56TWRMTldCWmt3?=
 =?utf-8?B?a1lrQ3JyVUVTN0paZGVpS01jVnNFTDNTcDlIR1I4ZnltMnVRZ1o1dlBZQllR?=
 =?utf-8?B?aTg3Z2Q1RE9OMjNJQlpwM3ZycWVTQmpKMk5vYlMrbWxidW5aWFBNc28xZ2ZS?=
 =?utf-8?B?K05mbUJSWG5CMDNGZkZkclQyVThNRFZqamllaGxGd2VlTmlWU0RuUDlraSto?=
 =?utf-8?B?TUwvY3N5cUU5RE5qcFlMd2NxKzZtNGVIK1l1aVgxbHliSnNvQStMMEsyMFI2?=
 =?utf-8?B?bmFxMkFPYVV1NDdLMXJDaUNEY3NoSFVYKzhuRE45clZyR3RvbE02MVdJc2RU?=
 =?utf-8?B?Vm8zWXRPUVdybkVxZ0dJSFNlTlVtWW5vZ0w4YUl1d3JDQWVKOE5QbzZwb0lS?=
 =?utf-8?B?RWNhdTBDMTJkNldPdmRoL2s1M2p2ZHNFQzQ3SmcvV1JrM05Rcml1b1MzcUdE?=
 =?utf-8?B?RktVYTNlOWxTcUVJWjJIcWFId0hDbG1iOWpvdTlXeTN3VFNoMGo0WUVEbTJ2?=
 =?utf-8?B?QjhPNmpjL3ZPb1hPbXJoaDBKbXFmc1J6d1lITlNJU1pBQk1meHdudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b783243f-7584-4c77-57eb-08de68c7037b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:08:30.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT5RCAqJ1x54jTbebOTP6qv1cNc+c1pWx48NS0V4E8SnB9m2UT2D3xTIklcfSrmBU3tcuGudDK+VJZTGV8H+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799


On 08/02/2026 18:07, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> On surprise down, LTSSM state transits from L0 -> Recovery.RcvrLock ->
> Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect. Recovery.RcvrLock
> and Recovery.RcvrSpeed transit times are 24 msec and 48 msec respectively.
> So, the total time taken to transit from L0 to detect state is ~96 msec.
> Hence, increase the poll time to 120 msec.
> 
> Disable the LTSSM state after it transits to detect to avoid LTSSM
> toggling between polling and detect states.
> 
> tegra_pcie_dw_pme_turnoff() function is called in non-atomic context
> only, so use the non-atomic poll function.
> 
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")

Two fixes tags here, we should only have one.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V5:
> * None
> 
> V4:
> * None
> 
> V3:
> * None
> 
> V2:
> * None
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 55 +++++++++++++---------
>   1 file changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 96d38571a7e7..4ac6b1cea13f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -137,7 +137,11 @@
>   #define APPL_DEBUG_PM_LINKST_IN_L0		0x11
>   #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
>   #define APPL_DEBUG_LTSSM_STATE_SHIFT		3
> -#define LTSSM_STATE_PRE_DETECT			5
> +#define LTSSM_STATE_DETECT_QUIET		0x00
> +#define LTSSM_STATE_DETECT_ACT			0x08
> +#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
> +#define LTSSM_STATE_DETECT_WAIT			0x30
> +#define LTSSM_STATE_L2_IDLE			0xa8
>   
>   #define APPL_RADM_STATUS			0xE4
>   #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
> @@ -201,7 +205,8 @@
>   #define PME_ACK_DELAY		100   /* 100 us */
>   #define PME_ACK_TIMEOUT		10000 /* 10 ms */
>   
> -#define LTSSM_TIMEOUT 50000	/* 50ms */
> +#define LTSSM_DELAY		10000	/* 10 ms */
> +#define LTSSM_TIMEOUT		120000	/* 120 ms */
>   
>   #define GEN3_GEN4_EQ_PRESET_INIT	5
>   
> @@ -1591,23 +1596,22 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>   		data &= ~APPL_PINMUX_PEX_RST;
>   		appl_writel(pcie, data, APPL_PINMUX);
>   
> +		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
> +			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
> +			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
> +			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
> +			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
> +			LTSSM_DELAY, LTSSM_TIMEOUT);
> +		if (err)
> +			dev_info(pcie->dev, "Link didn't go to detect state\n");
> +
>   		/*
> -		 * Some cards do not go to detect state even after de-asserting
> -		 * PERST#. So, de-assert LTSSM to bring link to detect state.
> +		 * Deassert LTSSM state to stop the state toggling between
> +		 * polling and detect.
>   		 */
>   		data = readl(pcie->appl_base + APPL_CTRL);
>   		data &= ~APPL_CTRL_LTSSM_EN;
>   		writel(data, pcie->appl_base + APPL_CTRL);
> -
> -		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
> -						data,
> -						((data &
> -						APPL_DEBUG_LTSSM_STATE_MASK) >>
> -						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
> -						LTSSM_STATE_PRE_DETECT,
> -						1, LTSSM_TIMEOUT);
> -		if (err)
> -			dev_info(pcie->dev, "Link didn't go to detect state\n");
>   	}
>   	/*
>   	 * DBI registers may not be accessible after this as PLL-E would be
> @@ -1681,19 +1685,24 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>   	if (pcie->ep_state == EP_STATE_DISABLED)
>   		return;
>   
> -	/* Disable LTSSM */
> +	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
> +		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
> +		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
> +		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
> +		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
> +		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
> +		LTSSM_DELAY, LTSSM_TIMEOUT);
> +	if (ret)
> +		dev_err(pcie->dev, "LTSSM state: 0x%x timeout: %d\n", val, ret);
> +
> +	/*
> +	 * Deassert LTSSM state to stop the state toggling between
> +	 * polling and detect.
> +	 */
>   	val = appl_readl(pcie, APPL_CTRL);
>   	val &= ~APPL_CTRL_LTSSM_EN;
>   	appl_writel(pcie, val, APPL_CTRL);
>   
> -	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
> -				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
> -				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
> -				 LTSSM_STATE_PRE_DETECT,
> -				 1, LTSSM_TIMEOUT);
> -	if (ret)
> -		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
> -
>   	reset_control_assert(pcie->core_rst);
>   
>   	tegra_pcie_disable_phy(pcie);

-- 
nvpublic

