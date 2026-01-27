Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012048.outbound.protection.outlook.com [52.103.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688731DDF3;
	Tue, 27 Jan 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769490550; cv=fail; b=bOjwaY0eAIwPupI22nRndUn1qLt+TXIAq28S9jkB6N1y/H5skNkOs/NrMqecsf9wrZ/YL7yFOn6NMD3zEiKTOQh8OcrlNqU67LsGF0xjsTxrGwO+v4aBDBhiOG6ZTWJxFHNMAR7HmSzWa69nW60FA+dn5WtYglxo/i9dgZ6bQSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769490550; c=relaxed/simple;
	bh=Un+xx8s+1rJ/hR1+GkX+yW8BkZ5JNNARzLA54zf0Jg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lvhgkangDbT5VGDoMJSwIHamLK/YSv1opQIwmTlFkviwUstNrQPAHstsp18h/93wH01VdzsINPi8DMYTInwLwMpNNyltA0xazp1hPZO8r6nUWEskDDQCzEVQLyq3IE5XjVUOOzoZhfvlEmSzl+aqH2q9Gbkc6ZjFKdeZIzja5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DL0x8+oE; arc=fail smtp.client-ip=52.103.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DL0x8+oE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIoQDSlxkTvLZ2upNQ5AxZcEetnSMs+42ScogRYNk1HrPRukmztZrjF7mdtN0mLeVtxyqwm91xBP68raJ83Wufc98u1W/M9lys5Clcp7nNjHe77YUvd0UDG//InJUZJRlGH62YskUXQswEriZdCErooBXL++9HBFV130pQBDHF0VJajkA3j00LhHYWiQGpvO1a7HU3BEaoEltMKtuAKAtKE8PSNc6RHVwaai8X/zRIWsKXwW/wpc5+BvnrYMs6i2AM7rOQ6L0lPCLgfk9HuVcV48xYoV/UgiGnLBF9zSpyGRECI5G2nTSWczRuwew527ccD53yA4yN2Q+dziYtL3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyB/TLmExaFWVp8Iiiyx+GVlyS5LIDVHeXSUDndetO8=;
 b=xh9A3d1n6onxtoCRJP3T6oNUlINRM7j8Gj6KhBfmTvmIlsjWZdkEf5Sw0IxobdrLQGHK66sHDtyasX+OWHKRUslrcjCI4NJgOmb88JPqBEgaiRDVubISTcgSL3VIZLipuutaummmfc7nCjwkkOZYwLAekLcBHTaUkouBonBQTdM6u0ungcfokxP2V0F8Y1loOxJFYZ+/1QqjmyiKRYSJcUpJJ145eijSCoLGxgqlBIXBbEefRppBXGjpqvfGZDvwHNfJYqosW2a+xpXdHeeZDCUmoawZiufrnlngD4FiAe4efYk2u9DmkRN7aFWRmuOVkciCq3EuM6agd8tCBn2LGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyB/TLmExaFWVp8Iiiyx+GVlyS5LIDVHeXSUDndetO8=;
 b=DL0x8+oE5zdT2+B1wnVsGEisSr7vEnJTIQlVYYVdvU5pjFaT+DrGD8J4Uw91ElNab61C/ETp4WdTHsuzpVQtIOg1tcSuXhP0ztLI3Mx1BKf+i9q3TDZ5sQGY4ZJd+98nl2/B0jSLjMFnEcHgp5JtR4MTFIbqyBTluWSBk/FguG4cSp9Ecv9UtTaC/CYtuQVhNbhACddf/5sTPKMa7nQpJlzZzP/FfhfBuij6DRPasZ9Ub0SycQZqn8lAhkVGbGEoBZFzhR9HvCBYITol99hdi4aQCzhjxBavHwaKt4iQ1M3AcAd6xnwAn7RqzF+cAEpcL4TveImDodSjzzz20DZLag==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4301.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 05:09:05 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 05:09:05 +0000
Message-ID:
 <SI2PR01MB4393772BA4AEF5ABF04E8F3FDC90A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 27 Jan 2026 13:07:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393ADC9C367C4A6F8032A02DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260123145113.GA1134360@nvidia.com>
 <SI2PR01MB4393D4D3E28FC1E22E3DF3CDDC93A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260126180140.GR1134360@nvidia.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260126180140.GR1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <d08de353-0c15-4d66-acf0-db73a4c07143@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 39581ef4-5f02-49b4-6e13-08de5d623121
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/Jq3lTA987BsoE/3rVxwshR9w6D5UwrLWni5msD9oxetzk4jWEsV8UVtJ7YvdjAhd5QmcfF2eJa3DbccwVLJACHSKaEYBDVsETfcFZvlifrKMKRzk0pbxzEakM0Op0ZCVtce0H+aSi4OZwFiWp3Q/4j7Wi6rx1beNZV88+uDT6Hpvq5BSsxtqJfqn59g3UrCY+Q85OVw+rLAcYLI5cCOvyCjE7JBXy5CDz5ITpmCEeg4LbRUgb9dp3D1cc52fx/GSkg53px3YoDBsbE5WTQbrFWPIxxr2o/fsPLT68sLH0nRN0vSlFN6Y8xpMdvAnPDiVKrYGw9h2VKQL6Gh6gGYnXBqCKHtMBHOgM4DczT/UlVEEzM8mtAGsCj9SK+lq8olOIIuu23TacA/T8h9hhfS4DT4gBDd0U0fb2jeEYd3FLAXRXrJv8fHcKCmscu842J9XTSQayxxLQDDxUXYBX05wModfFZ0FmQ2y9RgYC2w0mUqCGO+qWkmGpr7r+SUx8V7t25238rvHi6PWZtecGKGBcj5gpUiMKiOZCq2vF8CsoaL6wVFtmqp/6myeBVmSHGGlTNzTfPb7SE88BG2G0pHcI3bOqH2aqAuKQg5IxLOHpcVEG48mE1trveJ0IcoX+mn4E+1vbhKUwRk959okpDfQAaCnJqYqklF2Tbivp+mw2GyUDxVdXc+rx4jm9Yo/q0UjmNwqshYD+jiMMKIRSOpSKUZ/g3DOOsDgVtXV4XwFKIQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|37102599003|19110799012|15080799012|51005399006|8060799015|5072599009|41001999006|6090799003|461199028|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHVQQTZ2NkxiaC8wZ1lSUzk1bnVVV082d0hNYVBZNG9icGI1dHhtUFo4Vnl2?=
 =?utf-8?B?bXhqbWladWkvMndmQTU4SDNFTjVXQW4wR1llSGVvRHV4OTZGak1KSVRWVFpB?=
 =?utf-8?B?R3JWZU5zcjFTc3ZZbUV1SFlxMzV5ODFkNC80QjMvaUFmbitPYmFuWTVUNm5N?=
 =?utf-8?B?ZlZjSUsvSXh4ZjRQL1BYMS81NExnRHluOUpjMmNzT1BCMG96bVEydThraXdH?=
 =?utf-8?B?citDbm43dWUwUm5JOVoyKy9CLzBhcGhjZld0a3IxNFk3dFNNclM3b0RYUXU1?=
 =?utf-8?B?WUdKbVVNeDUyVTE2czl3WWJscjVUMVVXZ1VNbFNJcnJFQ0RQS3ZSSmc5d3hQ?=
 =?utf-8?B?Ukpmam1aUHJUZnFUUm03K0NwNkx5RnQySWhGQTVKQ2lFdHJXZWF1R29Tc09m?=
 =?utf-8?B?aENiTU5yaElnQjZsR1hTdExzNytiYWYxZGZQYkhkeHUxMml3WTZYcFJ6UXZV?=
 =?utf-8?B?bGpXNStLVEdxMERDWUx5TkgyT0RRMzdGZ0dSUGptTHd1RERkUXI4RlQwOHE2?=
 =?utf-8?B?bU5EdkZEV1Z2UTBsbThicm10Zm1JUjJqeC9oRmdmT3ltcC9xUzhybW1lNzJL?=
 =?utf-8?B?ZHp3ejBLQXFET0tpZWNScGE5MndGQnJDQzBZODRkVzVHU25WMExERDdJRjJD?=
 =?utf-8?B?Y3dTUFVOL2QwV2VzYXowUG9pZnV1d01yWW9sc3VtWVhjSUxTeHpCZDlLalJw?=
 =?utf-8?B?NERFZmpnZXJLcnJyVWZPMnJ4eXFaMWZkQmFuQmJKZFBDRHlKUlRDVlRYbzdx?=
 =?utf-8?B?M3lrVlhuRy9Ccmo0SGR6NkVjL0g0azlZNWx6TEFPNXZTVTlUbzllSlhUQUJV?=
 =?utf-8?B?M0J3Qmk4emxPTGhEdHg4UzRpRWo4UlJKR2lEbCtHbENNYVNEVDEyZzVWMVZU?=
 =?utf-8?B?N0VGZWQxTElzdXNDL1k3NHNJZG5vazh2SDlXK3MzckRSYzZGK1NOWGpCUVFM?=
 =?utf-8?B?RG10Sno1MFFsZWgzN0c3UGxyZC9GcEN3cCttUGRXV1E0VE85WHljOUJJclF0?=
 =?utf-8?B?Mk8wdFpjYThrY2RhejFCZ2VyeXh3USttK2xUcHoyYnpUbG8yL0tldVhjQ2Z2?=
 =?utf-8?B?bmZBZzVJbEV0VjVjQis4TFVSM2x3UkNPcmpkbUZadm4xRFBUelh6dGdLY3Jx?=
 =?utf-8?B?ZktXNS9PRTE3V0tJSys1YWs2UGZVWlhBSlBBOEo4aDhiN0ROcGUzR2tXN0FJ?=
 =?utf-8?B?UzJtZEdMOHpvcHFsSExTOWM1U0FXMWVHeTZRbTdYdGNTZ294NFBLd3lrd2VD?=
 =?utf-8?B?NHBxRUM1dys4clhlRjlFRDRvdTNoUE8ydTZWdW5naStmNUtwYk5oSmdWVEVU?=
 =?utf-8?B?Z1Zza3gxUWU2QWo2dkhHbVRjRllkRmltSThyUmNPdzZ1QWZFOVNuM2RpS294?=
 =?utf-8?B?T0h2Mnh0UEZYd1NnLzZDQTIrcU5LNHY0VVYrL05naDZ5MWxNbHdzeU9XVCtk?=
 =?utf-8?B?OU5IcDM2NUlYNlN0NEludlIrblA5OW4zdmlydTFCSjUrOUJTeUZad2pCM0FI?=
 =?utf-8?B?d2lJOEdad1paQWIzYysxczZpdGpFOXk2RCs0VEkvKzVsZEU2ZnpxanB4TERs?=
 =?utf-8?B?RnNJZERBYTdFTDRDbFpiS0IxQ2NpcENQQ0I5azBjM0JJVE4yd2x3N2pWalJS?=
 =?utf-8?B?dUtpdzgzeWIyWWlqWit0MEhkMzNtem01a1AxVC94dG1HaktVcFUrckVwT28x?=
 =?utf-8?B?ais5T0JuMW0zN3dTNDExd3ZBeFhNM3ZMUkphdnN2dEN6b1NoSzRaS25RPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1JwUW5rWmJEb1BCMWZ4NGdudVJxSWp5cEgwdndwem9oQXBZaklhRWxqeXlS?=
 =?utf-8?B?NWR5TDVMcWZQSHpXNFFIVHdURXhmaGRMcy9HM0h5WTgvYmFXRHVrc0lUcWlV?=
 =?utf-8?B?RTNHL001VldtQjZJNEdIa1pFL1F6Q0RiN1ZLbUVYQ1ZBd29wWmE0bWxWb09T?=
 =?utf-8?B?d2s5RmpRUVhST3RjSXp2dStRRVVXSStnMnEyK2Z4Rk5Rd0l5dnQ5QjRNRGZQ?=
 =?utf-8?B?S2MyTnNNN283UEUxd3EydnZuWXN6OFlwUlNySndOUGd6YXI4dnF1ejFHYmov?=
 =?utf-8?B?NnhpRjcrZ1FoMEdMZHRWUWV3SDZHdVZDbUUyLzVuSWdkMC9RT1ZJYWNMK2Vy?=
 =?utf-8?B?bW1pUVVnVWxVT3cydDZXSkl2NUExaFR3K211OFR2VmFkYmUwMFAySlJ1MFRE?=
 =?utf-8?B?ZU82eEptemp5QWRYWHR2b1ZpN1ZIZDhweVo5S1g1bTB4ay9rUmU5ZlFlcFhu?=
 =?utf-8?B?SEVVWUJnV1JxRzVhcFM4K01zZmUvdnlVam1neUVocU91akRDUE1WOWhHTzhR?=
 =?utf-8?B?N0RBM1ZnTzBYN2M1MURpYm9panlNU3RQQjVFaGZCallyalByTk5JNGZYcUpp?=
 =?utf-8?B?R09CVk9mUWROLzZjU0ZiWHZXSmFWSnFMQ0ptS0hXYWJwbXkrZmtIYVo4Q2sr?=
 =?utf-8?B?dmM0RFJJYmE0WXAwYnZFckRFTUxOTk0vTnMyY2dnSHNyT2F5eThWb0w0MDRE?=
 =?utf-8?B?UWZwc1N4OUxmaFlaS01lSTR6MEMxcUU2ai91T21RY1RkSVBXM25MM3JNSmJI?=
 =?utf-8?B?K1d4WHpIaCsxSlBlcFFJdWtiN2tFTFN6VnpXcUZlbWUxRVFlUEFrUlMrMXpU?=
 =?utf-8?B?RWNmajBocjdVREJzbW83emtvNG1OVW9PVk9NMmNRc2VLbUJpQ1ZsdEpMTktN?=
 =?utf-8?B?RHcvbVk5UWJnNS9YZzVCdk8yZm1LUGpleURlVHRUSjBSeHJZdU0yb2JsQnV1?=
 =?utf-8?B?R3pXdU9peXpJRHR2dGFqRjNETk5SSFNtaXlzOFdycHlwZGM5aEh1MkFsdkRB?=
 =?utf-8?B?bHM4OVBseTY5YVkxZlMzN1FSNzl4Mzg0V1N3QnIrQ1RXMVdsSW1sSGxDQ2dK?=
 =?utf-8?B?VDh0SCsySWI2VGtFVzNIeTlKa1EvMCt0RUxIdFVuUkN4V1BMSlg1NkthTG8w?=
 =?utf-8?B?WDRxa3ZMeTdGVlRKSnFGbnFVYStoNFNyRjZhS3Vxc05CZlpIejg5Nm5HNEhN?=
 =?utf-8?B?bHRHdGNNbktCVnk1S2w0QXNhSnhvOGdjMnVEZktxdVh5cXBnTURUZUdOMzBY?=
 =?utf-8?B?dUFzNU5vVE0wK25EaDVSQjFDMU5UelU3NlBmOTdPYzZGYmdVMWFtZWRQL29T?=
 =?utf-8?B?NDF3YXgwaGpPRTRuejZVUlBRc09QUVVid1NoMGxXYS9kcDFDbkVWS3IrUTV6?=
 =?utf-8?B?aTRMWlhYblFyUjFvU3BORVhyS25TSFh5YlJDekxKSFMxdVdtNVBUSmgyV3Vj?=
 =?utf-8?B?aUZEcFQxK0lsQTZQUW5ZZUNnRkNSZkwyVFlDY3FPejZla3UyUFNvNmUyUm5U?=
 =?utf-8?B?SVFnUnJtbHNOb09nN084VGhKcDlKOXE1Sy9oYmFqSlRHSVZld3MvZ3JtWUUv?=
 =?utf-8?B?SSt6RStPajZ0Q2lIVkdNYTkvNlVWdzVweUZSekJuTVVsYW1ZMzRXOXNlQ09k?=
 =?utf-8?B?OUowSzJWZzl3STAyQWxwQ2Mvb1hQRm1VWmxmU0xDRURIVmVkZEVxMXMyRzFI?=
 =?utf-8?B?b2toZVEyd1Y5cGtpNzRSVERsUHdZNWJTTW9yNmh4c3IvTWw5dDlkUXZUR3Zy?=
 =?utf-8?B?SnVOb2RIRXpPZytoeDhCMGtGZU1VbXZKaE5yL041SlFsUW9hckhFVWhldlpa?=
 =?utf-8?B?U0hEcy90ZjdyREFneHpnRXZ5NGpwdVRJVHVGNzZWT1RnakNVek9DRURFQ05w?=
 =?utf-8?Q?mvM+yRQlsivzV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 39581ef4-5f02-49b4-6e13-08de5d623121
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 05:09:05.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4301

On 1/27/26 2:01 AM, Jason Gunthorpe wrote:
> On Mon, Jan 26, 2026 at 05:10:18PM +0800, Wei Wang wrote:
>> On 1/23/26 10:51 PM, Jason Gunthorpe wrote:
>>> On Fri, Jan 23, 2026 at 09:49:43AM +0800, Wei Wang wrote:
>>>> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
>>>> isolation. On devices that support the PCI_ACS_ECAP capability, the
>>>> controls are required to be enabled properly:
>>>> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>>>>     upstream I/O requests.
>>>> - ACS DSP and USP Memory Target Access Control needs to be set with
>>>>     Request Redirect or Request Blocking to ensure the Downstream and
>>>>     and Upstream Port memory resource ranges are not accessed by upstream
>>>>     memory requests.
>>>> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>>>>     areas that lies within a Switch's Upstream Port memory apertures but not
>>>>     within any Downstream Port memory apertures get redirected.
>>>>
>>>> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
>>>> support, pci_acs_enabled() skips checking for the capability and logs a
>>>> warning to indicate that isolation may be incomplete.
>>>
>>> That's every existing system, please don't do that.
>>>
>>> The issue with ECAP is the way PCI SIG re-defined what Linux has been
>>> doing forever as unsafe.
>>
>> My viewpoint is that there are known bugs with the legacy ACS defined in
>> PCIe Gen 4, and PCIe Gen 5 attempts to address them through new controls in
>> the Enhanced Capability (ECAP). From the Linux perspective, we just need to
>> adapt accordingly to ensure 'better' isolation.
> 
> No, there are not "bugs", there is a gap where a very rare and narrow
> HW configuration was not specified. The vast majority of systems don't
> even hit this gap, and when they do switches that are safe and secure
> to use with Linux do the right thing..
> 
>> The warning is intended to raise awareness for users, so they can make
>> informed decisions about continuing with this setup.
> 
> Then print warnings only in known bad cases by detecting the holes and
> evaluating the quirks database if the device malfunctions. That's
> hard, so I would just skip the print..

OK, I'll drop the warning.
