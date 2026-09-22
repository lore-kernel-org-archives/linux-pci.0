Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012058.outbound.protection.outlook.com [52.103.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1F559CBC;
	Tue, 22 Sep 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089405; cv=fail; b=H4LhkeLP1skry1e3B3llLPZjHuiVNF1FPL+JjULGDu7zsPr9OK44ru4t2O3AiQLiGcHtZwzScihlbqetmFGsvtFFhEd722hvmX8VLTIlnm95+1MYcQ00E3YSOIltx2k6n4j1Fn8WpFTjOj/eQU+6QWI4DBg4iK/HUYIrTgNctpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089405; c=relaxed/simple;
	bh=qHv/0AM7J2wI71rcq1CHixUXm6RcoQEwlX0cUnVURG4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=feEiYdou8XBXjSd8hR+Odq6/PDDYehA6GFQQfqZgu6m5+27x7YlzplSRzji0NdKSaSkSw6vk9dsn16MAiLNjW4OJO1Hcv69NOQVx93nm9KH2gB+sjOYUYl+BPkG6CY60euMzoA04KWRgWLxxu9fcBLdR2EmWt1yxC8af3GonJuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Ui52K0SU; arc=fail smtp.client-ip=52.103.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Ui52K0SU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHPqDzVcOOia2ej+kpZEkUYovV13NIDP7Wd0aukgLWJev0eFtD3mup3jkyTrmxi44ReIXxeZxbjCQRvvqfiOU7zz6mP35RQL04Gzbk6qF7WeP3jI236+X68qxzFxTvQlmSIkWLny/0c8veE4fdh61RfqXZ7Z8jZ+MIvc4DFTUarsAfWOk593KH1T2hZjv4JVaGBzRuCtywqgCYGQ20GByIfs/btEeu342yRyh2cGB0oUlKz012I+D1SAyOHDZUqOBHulEaWTv0uVpVgtZbjaLTs9BhAKtXlV2UC0dkazWXINaSra1w9QLtUvxmMnGPhSpcCUmgC8Ng/wwnJhNytIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlQMZOZ9RrDWFZnQppaopDroLMhNNIadjDTaTaM5y6I=;
 b=b/F/F9D8PSp+wkybeYOOA+BNw9KZWYR1mhMMhrhXHLXan1fTUJbJt4zaAafP+u+Rbxirc0JBW0kPk2961/ry1RdRo6R41PhTE6Cl0cqrQeeAgD894nK8+EjIFw4GwN7JDtHwc0W8/s4/gXV47zrvlw7EqnQvR8qpaVOtpLVAkKtRexPsUNhnT00QhlGH9+6qdYtNh6dd0VxEE9cE5mF7vm9pU8W0Q7AaceAjZL8qEsbWCBajnyoOpFJjQy8/rkVQ2FKnYUYNzxI9VwYIR7ddr/M+/7wKmX7sf07ZvalCIs6WdEEhQEE4w+eljbFQYrl7myRAFF+ea1igoW4REbJsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlQMZOZ9RrDWFZnQppaopDroLMhNNIadjDTaTaM5y6I=;
 b=Ui52K0SUn/vjb6Pwdy+7q2oqxUBqItxT5CpnOLidye87ewEbcA3V3F1GbiwDnHOlI7deUNc0uJBNujzRGjIKSCJqP/RyF22oJBHrb6BxYJhwlV3NZxJTR3gA1twG/RVx3h/DNF1nR6E6ym0EsKly4rB3L1F8svhaE0oQtdB8/mhyo1wjA59FHe0fqvTWvODwN7eq1j5HyDOfdUrFCnTMxr4FWFx6mhlOqDhlFEdVy/f8RCX3S1z6/vjbiu/Em/YZWE/VAoPdl/l8Golawj79O6bxAvyJltSx3u5ezm+Z0/RHyRKOwT6wN+sVSGEF0A8ZUGgbZ3z8J73Jyt35Ha+40g==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:16 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:16 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	ben@cressey.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v10 0/6] PCI: Add support for ACS Enhanced Capability
Date: Tue, 22 Sep 2026 23:02:52 +0800
Message-ID:
 <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7f6908-dac2-4cb9-fd41-08df18baa059
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3j4EGtrWC76yZtYjXYOkK33lm0MEsaMBswB8VgOUK8Uwz85+FtXEmhhec2XEhCiWC2p009wj/xjTE3Ih3CWWr2YI5sy3FUFgAYJu+UYmTR4O0gTlQRryW7jgqFpqwdxv8hfRXWNTxrdF9IROg1E/E1Z9A4M3NJGbduWXUTUt1ItEBmOHUKDY7MDxL77ko262Tm+IxMri3xZPzQns6yYJ1N0yXTvRXth7HlqlUsMcaqjZ104ffuzGxe9DdAa90JuKfyCQrzKMJfVQvGvL6kFVCsB62KLY1XofyTyP2+WFW4vYn7RzBsap/9K8Rufxx8ZDzxTAMC6KhFxnNITrYDKz6mCbTsopwGig/OyKJtyqo3kaAImVOjtAYXZyCBmmBAxNtA3TGlBjygFsBUHU5spStO8mK+UQmKHN7pvqJTChC8VYdhedu1YqNWQWhKka5ym/d4CLZyZFo1rog1foduwzGe302UVgKhsw3VLo58FNaMJRX1bLpAh7nPo4rdXSgKF5enwZtesJFSOK+DNRqCSMywsGt1hph+VqdjwHE5/pwNF62kx7XnjSzdj+uQjJicrPQpR4aHq5kCLLHdhgRgWvhqF4f+KyfyF6kYCUuXjFwnAHWJX1uESnhCxF7NepgT4Qlvz2yz7vJeLxPWD5RCCK7nqEhnheuefPsFg/d9fLW4Fdd6qKlzGGPIwnMjffmTgzR+0HL9IQ8OGKC6ZDoZyzJEbF3885bFWQDo2OX5XaRy/Bju22L4iAo2C0DxIRxFMYUA9rUTSdXBwfh7yF0VcJsYEsDsv0pnSMDA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|17081999003|8060799015|6090799003|5062599005|5072599009|41001999006|51005399006|7042599007|4140399003|12121999013|37011999003|15080799012|10092599007|25010399006|23021999003|3412199025|440099028|4302099013|40105399003|1602099012|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1ozU2hJWXdJY1dTcVNtd2YxeUxWUlNJbFhmT1ZMenczT0tlV1lSR3VVZ25v?=
 =?utf-8?B?MzhEc1hlVzE0dWtEejB2MEtDOXQzMDRtTm9WRkh2cit4SDdBZmlDUWZTU2Qy?=
 =?utf-8?B?USs3dFF6dW45b2pSNGdRT0VubzhIOE45b3g3TDkvQUhVOXhuNDh1Q1ZLZzhR?=
 =?utf-8?B?OTJzUnBhMkR4Z0E3UlRFc0x0b2plaTJUWUJaQ04vT0lTYmZMQXVIRk1ENXBl?=
 =?utf-8?B?MjBaa1NSTk9Gdis3cW9DU3JDODRRb3FTcldBazVrQ3FKWlBmdmF4SkNsS1FW?=
 =?utf-8?B?bFhoRTErU28yVjJFKzBQUHRndytoZGg2OGE1a3VaT25HTkdNNnpJZkpkODBn?=
 =?utf-8?B?Q3JTaWpDcUk0eGVSbzNkSUIvd0NTdE5GWHd6NXNFcWVydCtUV2RZM1Q2ZkVY?=
 =?utf-8?B?d3JWOGdJSnZBWCtTVUcyUmJmYnFTYjJwNER3OC9zVzhSOGZHdHRoSFc4Y0lw?=
 =?utf-8?B?ZVZ2K2pyeThBdkFrdzJMa3VOY0xLL1ByL3I2cjZEUjVhS3RSTElEQzdQOGly?=
 =?utf-8?B?ZHNtZUNxZXdvSUZGSDk4WnlkQlM0R2Z0T1lrbXR3akR3eVhpekVQc1ErV09N?=
 =?utf-8?B?dzN2NnpuTjVuVXFtcXdxa1ZZYkhEZXgxdHRGaWVaeVJTc2lJdGVJTEs1TTlJ?=
 =?utf-8?B?bzhLNDRobU1USmcrTVhlbGNZazdpYURaUDFLVlo5ZkFrU281T29IRjdFUzVz?=
 =?utf-8?B?ZDM5NS9DNEJPZTlnbEdkOTdvWEdSWVZUUEppd2Y3YnpXa3l2L0w2Nk85VVdN?=
 =?utf-8?B?OE9vTVdzb2tkbEl3MHhzbjRwUkFnN0IweTRubmVRREtGQVQ4ME5DZVprUzNv?=
 =?utf-8?B?WWRSNVhoRTVkT3dHL2JTMVRka1dwZlNUVjNvY0J4Tkw4ODZJcFRQTitqZzZD?=
 =?utf-8?B?d2ZBbG42Mkt4UWIwQis0R1Jpd25jcVdKNXFaMzBQOGt4aE1zMzdVRnJSajRj?=
 =?utf-8?B?eEYzZUhYU2xwZ0ZHS3RPU3VvU2liaXVtK1k5RU1NVS81STkrcyttOCtSYzI3?=
 =?utf-8?B?MVcvemJyNjBHU3ZRUmdLNFdyNVZETHZsUWltYnowUi80N0RBbmZud1ZxMWN4?=
 =?utf-8?B?Qi85cGNkY3YvN29pcVg1RG9FN3I2WTNJNlF5MkV2K0JuY2QxeXRFZTZWQ2k0?=
 =?utf-8?B?OVhDZi9kOU5KRVB0eW5LZkZoYUo2Q0VBeHpRaWlvcjVTb1dnc2F2Zlh1STc4?=
 =?utf-8?B?OTNSM3loQXZJTXBQZWx0aEllYmFDa3NkbDlabjRSYWFiVnRkTDh3Ti9UVlI1?=
 =?utf-8?B?NEljaExuOEJ1MktaTnBsWlhRaCs3UHpaV3NLWFFZeHRRVUdoWkJTZmhJL0Za?=
 =?utf-8?B?Unhhb2dsUjhPaTN6RldwRDM3VDQzckM2Vy81TGVaYzhNQWdNeHdsc25FRDBx?=
 =?utf-8?B?bC93MmwzbHdQVW1veFE3ZEExRkVzM1JUa2xaWTJVTkp6MmJDV1ZOUjhHNmpy?=
 =?utf-8?B?MU4yWTBWWlA1S0JwWERsKzVvUmwxbkdZbXJjeUFSZ3JxblJSREFQM1N0bGlL?=
 =?utf-8?B?bGFJUEE1RWVlZHBDaDVlK3NUWkpIcUNXOVNNTWJYS1dQd1g4SEgxTDl0bHR1?=
 =?utf-8?B?V0VRSDVKL2xnMWpBSy9DL0NOMDVUMU9QakFtOXowRDM1VHRON2NSYkYrUmxi?=
 =?utf-8?B?V0NWUDIwVDdOQ0xQVXpNaUtsRlR6N3BGRFlVSGZvdFJnVWJua3VKVnlwVzJO?=
 =?utf-8?Q?y/pvM9tJEm8g6I0s7opA?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnVmSWdkYVRDMzFWUFM5eUV0NTlmc0tpVlQySlVGL0wveTMvazlMT3M2OHR3?=
 =?utf-8?B?TFdKSVMyZEkzRGpLZGMwbmpCVFk2bENiWjBkQ2tJM0p4OUIrZnFYYWM2d2lY?=
 =?utf-8?B?SWxZZHRUTXlhZlVhKytrZGpQNHAxMDQ0d2pTblRHWWFTWGFXckkySW1kd3lm?=
 =?utf-8?B?NlEzSzZpaTlkL2V6STlFOS85allpUllqay9kOUs1VzUzcEMxY0pBUWVBV1Zz?=
 =?utf-8?B?aGVqUlA0RUhpb0pkS3NhdjFVOEcxdEhjbWhTZHYydENTS1FmdHgxRmZTWnov?=
 =?utf-8?B?L3J2RmdNeUxaNklMRDF4MzNwR2hnNmdIQ2QvRk9KV1VMNGQ3MXlrRU44RWNV?=
 =?utf-8?B?TVdKWm9mZEkzc1hXbjcwZFUvSHdoSkNMLy9kbFZMbzhPektxMWwvdGc0OVV2?=
 =?utf-8?B?MGRUWnJjS0pMaFdIS2lKVmdMOHpnM2hCUGJXNUZWY0VWd2FWZlYwQ1JXM3RC?=
 =?utf-8?B?MytNbmt5VjVKTVBMSlVObHVYTC9wdVFDU0liN3JkN1pwNG9NSEwzSmNkeUQ4?=
 =?utf-8?B?WlB5Vmlxb2R3RnliSVFRZ0xJVHFNUFY2SHNRWHJyU1VvWDFieU9jTEJ0KzJD?=
 =?utf-8?B?OC9OSjA0cVhEVG0yellZcURnd3B4NHd1TVNuZjZIRERZNXlRRzZvVkZhVlEw?=
 =?utf-8?B?aTJZRldqYkt4TkN2SW9JZWtjK2c3UGIxcWZjaVIzQkRUS24rRmdaVzg2ZFh5?=
 =?utf-8?B?US9oZ1lDbHRSSnVqajRVQ1JycElMT3lFM2hIQUVZeWwzN3Bwdk9XWlFtQzF1?=
 =?utf-8?B?NWNXQ1d4dHFXVWRsY2xCM1lkMExleWV6aGhXdnAya2RSK1g4ZzFlaFRUOEM2?=
 =?utf-8?B?NVlaMGhteUFGaW5rNjVySitSejVBUU5ZUTFNN3p1Z2F6cWpWSmdFbHZZdk05?=
 =?utf-8?B?ck85dWRKVFl0bjRxYzRYaU91UUpMVi81TElLdnByZDFGOUhnZDB2WlUxeDY4?=
 =?utf-8?B?RVdIYmdFZlZsRXIxcDdxeFdBMGRWYUFzdVFoTDNFR3R0ZFQ3Wk56ZmFWb2l0?=
 =?utf-8?B?SjdXZGlKVmZtYnN2OC8vMk8rdVJ2RWdDOVZwcE5SdElzcTJQUXBDY1h3dWxh?=
 =?utf-8?B?SFR1L2RDV3JYOFRrYU5lUG5FODhRMEFDYXBFclRERHhNcEZ3WkVpWUh0QlZI?=
 =?utf-8?B?WFRuMDlVakZRUXVmZWIvMWdPZzlmMTh3REtGM3BzbzdldS94OXJWaHVwUXhw?=
 =?utf-8?B?Z2Rsei93TWQ1WXBzdzlCNG1UOGphdDhBb3B2a3U3aXhzc1ZTckZETXJITVo5?=
 =?utf-8?B?dmJqblJqVmpqK2lkaDE1QXdQQ2t3YmExbnFIN3NjZnZHWG1HZmVkZGF0cUVq?=
 =?utf-8?B?WE1KeU9LdC9NTFZpeEM5RHNoSkhTamRxSHA5Z01UODFZQWQ0bU5EQmh5c0lt?=
 =?utf-8?B?clFpaisvQ3FsOWdDS1o3TUJNZ1dXY0tCMVhsSFRSZEFMaVlPWWFjM2FucDM1?=
 =?utf-8?B?d2N0QnhwS2xHaHZWRnhXYTFCRmVtNnQzSzNQbUpDRW9JTys5TFNpNWN4K2FC?=
 =?utf-8?B?OE5VVk9KbHU0TmNkYll0eFVOV0liQkIxQVYvbkt3ZUhCeGZ0dWxXaHlaMmFP?=
 =?utf-8?B?K1F6eXhReE5MS2xmTXY1WW5UN1UxQXB5SzZZQXBGV1I0dmM1QURMOFV1RXpV?=
 =?utf-8?B?bFEydGdCZEQ4S25rTFBIRllvRUFvNnFveEhNL0t4MEVMaE1xZnNSTFNmM3Qz?=
 =?utf-8?B?U0pvUnh5cmJTMEdNSHZwTnkrNGFHSTRuNWtyV1pPSHU1Z1F3eHBJRlVXT1ZE?=
 =?utf-8?B?V0hVWlA1cVJyM3ZObWllckR4SXpxYXhYYmxSZHl1eGppc0dnM1YwR0NhZmEr?=
 =?utf-8?B?aEZJMXdBY2p4UTU3eEtpY0xJVllEdkl0TnBOSXBiZ1RCbmxrcno5alJ3K1lz?=
 =?utf-8?Q?I9qNa+gItZNG5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7f6908-dac2-4cb9-fd41-08df18baa059
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:15.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

This patchset improves the core ACS implementation and adds support for
the Access Control Services (ACS) Enhanced Capability, introduced with
PCIe Gen 5.

Improvements to the core ACS implementation include:
- Validating ACS enable flags against device-specific capabilities rather
  than generic kernel masks. This ensures only supported features are
  enabled while safely ignoring attempts to disable unsupported bits.

- Consolidating delimiter parsing into pci_dev_str_match() so duplicated
  logic in callers can be removed.

- Refactoring ACS parameter handling by splitting the intertwined
  disable_acs_redir and config_acs param logic into dedicated functions.
  This improves maintainability and robustness while optimizing parsing
  with better validation and readability.

- Updating the config_acs kernel parameter documentation to include an
  example of multi-device configuration with distinct settings and
  advising users to quote the parameter to avoid bootloader parsing
  issues with the semicolon separator.

Support for the ACS Enhanced Capability is built on top of this improved
implementation. This capability provides additional access control
features that improve device isolation — particularly important in
virtualization scenarios where devices are passed through to different
virtual machines (VMs). Strong isolation is critical to ensure security
between devices assigned to different VMs and the host.

In Linux, device grouping assumes that devices in separate IOMMU groups
are properly isolated. To uphold this assumption, the enhanced ACS
controls are enabled by default on hardware that supports the PCI_ACS_ECAP
capability. As with other basic ACS access controls, these new controls
can be configured via the config_acs= boot parameter.

Support for checking the enhanced ACS controls on Root and Downstream
Ports has been added to pci_acs_enabled(). On devices that support
PCI_ACS_ECAP, these controls must be properly enabled. To maintain
compatibility with legacy devices that lack PCI_ACS_ECAP support,
pci_acs_enabled() simply skips the check.

v9->v10 changes:
Patch 1:
  - Replace GENMASK_U16(6, 0) with PCI_ACS_BASIC_CTRL_MASK, built from the
    individual PCI_ACS_* control bits, for readability. (Ilpo Järvinen)
  - Report ignored unsupported ACS bits with pci_warn() instead of
    pci_dbg(), so users can see that part of their config_acs= request
    had no effect (previously, bits above 6 were reported with
    pci_err()).
Patch 3:
  - Simplify pci_dev_str_match() by computing the vendor/device match
    result directly and dropping the goto labels; no change in
    behavior.
  - Reword the commit message: trailing characters after a BDF were
    already rejected by pci_dev_str_match_path(), so the stricter check
    only affects the pci:<vendor>:<device> form.
Patch 4:
  - Drop the unneeded "ret = 0" initializer and the else-after-return
    in pci_dev_match_disable_acs_redir().
Patch 5:
  - Replace GENMASK_U16(12, 7) with PCI_ACS_ECAP_CTRL_MASK for
    readability. (Ilpo Järvinen)
  v9 link: https://lore.kernel.org/all/SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/
v8->v9 changes:
Patch 1:
  - strip unsupported bits from both mask and flags rather than aborting
    the entire configuration. This aligns with the existing command-line
    configurations to have the supported bits applied at least (Sashiko)
Patch 4:
  - Preserve pre-refactor behavior for the empty-bitstring form, e.g.
   "@0000:01:00.0" in config_acs, which resets caps->ctrl to caps->fw_ctrl
    for the matched device (undoing pci_std_enable_acs()). Also restore the
   "ACS Flags missing" pci_err() diagnostic on a missing '@' delimiter.
   (Sashiko)
  - Two other comments from Sashiko were marked as non-critical and
    pre-existing; left unchanged for now to preserve the current behavior.
Patch 5:
  - Enable Unclaimed Request Redirect Control and Upstream Port Memory
    Target Access Redirect for Downstream Port only (PCI_ACS_ECAP is set
    in pci_acs_enabled() for root port and downstream port).(Sashiko)
  v8 Link: https://lore.kernel.org/all/SI2PR01MB43932642FC4DD3D075983B1FDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v7->v8 changes:
Patch 1:
  - Validate against dev->acs_capabilities & GENMASK_U16(6, 0) rather than
    the raw dev->acs_capabilities, as the latter may contain fields (like
    the egress control vector size) that do not correspond to bits in the
    ACS control register. (Sashiko-bot)
  - Gate the new capability check on !acs_mask so it only fires for the
    config_acs parameter path. This avoids breaking legacy
    disable_acs_redir behavior. (Sashiko-bot)
  - Validate both enable and disable bits (the full mask), not just flags.
    Reverts the v7 narrowing to enable-only.
Patch 2:
  - Remove the leading '-' characters in the documentation examples to
    prevent copy-paste confusion for users. (Randy)
  - Recommend using double quotes instead of single quotes for multiple
    devices to avoid potential shell-escaping issues where single quotes
    might be treated as literal characters. (Sashiko-bot)
Patch 3:
  - Move the error reporting back to the callers so that caller context
    is included in the dmesg output. (Krzysztof)
  - In pci_dev_str_match(): enforce stricter boundary checks on successful
    matches (see Patch 3 commit log for full details).
Patch 4:
  - Move the pci_info logging for ACS modifications up to pci_enable_acs()
    so it prints for both disable_acs_redir and config_acs modifications.
    Introduction of kernel_default_ctrl so the print only fires when a
    cmdline param diverges from pci_std_enable_acs()'s output (not on
    every pci_std_enable_acs() modification). (Sashiko-bot)
  - Drop max_shift; bound the parse loop by the u16 width (16) and rely on
    the existing invalid_bits & ~valid_ctrl check to report out-of-range
    bits with their bitmask, which is more informative than reporting the
    parse position.
  - Drop the -ENODEV "no more entries" signal. *endptr is now advanced
    past the delimiter so callers terminate the loop naturally via
    while (*p).
Patch 5:
  - In pci_param_config_acs(): when ECAP is supported by the device add
    the ECAP control bits (GENMASK_U16(12, 7)) to valid_ctrl.
  - Validate DMAC/UMAC reserved encoding against the prospective ctrl
    value rather than enabled_bits alone, so the case where the user
    enables one bit while fw_ctrl already has the other set is also
    caught.
Patch 6:
  - In pci_acs_ecap_enabled(): Add a defensive NULL check for the upstream
    port before dereferencing it. While standard downstream ports should
    always have an upstream port, this guards against kernel panics in
    malformed topologies. (Sashiko-bot)
  - Remove the redundant pdev->acs_capabilities & PCI_ACS_ECAP condition
    in pci_acs_flags_enabled(). The preceding bitwise operation
    (acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC))
    already guarantees that acs_flags will only contain the PCI_ACS_ECAP
    bit if the device actually supports it.
  v7 Link: https://lore.kernel.org/all/SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v6->v7 changes:
 - Rebased onto next-20260505 (based on v7.1-rc2)
 - Picked up Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
 - No functional changes
 v6 Link: https://lore.kernel.org/all/SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com/

v5->v6 changes:
- Patch 3: In pci_dev_str_match(), explicitly set `ret = 0` when no
  matching string is found. This resolves a smatch warning that `ret`
  returned from sscanf() may be 2 or 4 even though no matching string
  is found later comparison.
  v5 Link: https://lore.kernel.org/all/SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v4->v5 changes:
- Added significant refactoring of the core ACS implementation (Patches
  1-4) to improve validation, safety, and readability;
- For USP and DSP Memory Target Access Control, added masks and enum
  values for the encodings and explicitly rejected the reserved encoding
  (0b11);
- In pci_acs_ecap_enabled(), removed the use of 'is_dsp' variable.
  v4 Link: https://lore.kernel.org/all/SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v3->v4 changes:
- In pci_acs_ecap_enabled(): Check the pcie type for
  PCI_EXP_TYPE_DOWNSTREAM explicitly.
  v3 Link: https://lore.kernel.org/all/SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v2->v3 changes:
- Drop the warning when a device has no support for the enhanced
  capability.
  v2 Link: https://lore.kernel.org/all/SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v1->v2 changes:
- Enabled all enhanced ACS controls by default, rather than just Unclaimed
  Request Redirect (which addressed the primary issue we encountered);
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.
  v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Thanks to Jason Gunthorpe, Jonathan Cameron, Dan Carpenter,
Krzysztof Wilczyński, Randy Dunlap and Ilpo Järvinen for reviewing
the patchset.

Patches on github: https://github.com/wei-w-wang/linux/tree/v10-acs-enhanced-cap-and-refactor

Wei Wang (6):
  PCI: Validate ACS control bits against device-specific ACS
    capabilities
  Documentation/kernel-parameters: Add multi-device config_acs example
  PCI: Consolidate delimiter handling into pci_dev_str_match()
  PCI: Refactor disable_acs_redir and config_acs param handling
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         |  30 +-
 drivers/pci/pci.c                             | 327 ++++++++++++------
 include/uapi/linux/pci_regs.h                 |  13 +
 3 files changed, 266 insertions(+), 104 deletions(-)


base-commit: a8c591ed6b672915e0be57843f943a2a723aff40
-- 
2.51.0

