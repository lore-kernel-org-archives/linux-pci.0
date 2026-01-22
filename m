Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559438886E;
	Thu, 22 Jan 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111060; cv=fail; b=TUoyvR8lNqgX7b43+G+ZbFBml45+NSB/TJO9zrAxD4y79WMduswC1mC1+ZxYKMccbuz1vStGXKJVAaRQpT0mwsOHCItio3vj3bsFnpzhysmj9AbBTcdvVKvghOgvQBBhGXRfCvNckeS7PyiemrNLGhXsq8ClvK8HC9BbZZf2YQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111060; c=relaxed/simple;
	bh=HmLK4b1LugfydVaxj3JTVHcjRjBQ0r6rRYJ5d0dGbY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y046Sd1r9CNe/JWHK1UPRJ5aJA/lS+al/WJM+MFwTQMQQmmJjOfBw4Oqgl3+ZP4r0fMHGSA9QHm6qwd4c08uKMZL79lJtDnf5CIk1zAA80K8jP0PU9pxYuV9+j/i+jHDCzfNeMmnGoxS4TXPch9gCv5SzUs7rWdlVMEqRqVB8bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TULA89xv; arc=fail smtp.client-ip=40.107.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TULA89xv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLJUcu6mJXTdTymmBG8r1hFP6eEveOfAjrOQCNyc8rJuLqBITIoTonzZFg6r3rpMbQYl/xtw62uUI/ACc+1VTlCUuTjiYfc+rQwZPP+x1dS2EdUJPGUDGucmdEHwoKqjrTucr3LlPxeeqG9IABanKoRt3eNSRh1a9dDtVtq5utj5hX+zUBOGZ175jIT+Qo80utu/JjspU4RYEZLxW2deLZmQRbF4rGVfQDoFalHcx/G/4ToNCgvT5gPdqJfJPoiwd0sfY3eEV4gLhObXRMM71MifpmIhcgea1a7WdhKAvNmw87MHBABIwtktQXyaMzDglJjXocVqIJMyCLcP1L8/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3tUgyKHjzNuW9Tn+rGRVrsfWlA9avLRKhBckncfBh4=;
 b=xA458CvNkBK5vLpLwoq654J6deXIX4n9C6w4ULtLkHoGbAAnMLMbFqTvvU88H40cx6sELqdtntF3wcFITHDOSxmXTTHJUKoe85G/WyUpy9MQ0K4y040MFEfFXpqlRmJQG7cJIF1kSgSI7+CmcxXDb5cTpxo0dGZT8XeDPHZZHYLAztuDirauIU5cU6lDruuDeP2mMxu3JtJ4FeGZz47as21RGdxD52h5Xx7S4SvhOpMENMNltaYcQ1Ae6h6YfRsolzwEK0M2ZkCYxaRiYbbPcPXSOhM9zYpylYQCOBnKHyfX2Akl+qx3JzDQ8FPQrtl/hUcTMGIM4faPFX0VJwv5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3tUgyKHjzNuW9Tn+rGRVrsfWlA9avLRKhBckncfBh4=;
 b=TULA89xvgyVnhfaBhoJAkSgwqP9ekzWUjczX70JItIO7BvqVADVno2ZgaY0GwJHFBicoI2N9gYubYOAgmtwaHghhzaAEBumknB49EujXmAeV4Xi0U/xpv3qcSjtPNeRroCbkvOS6teWCOiuyiv0/0ISn2sz0vundZADymAN+jzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 19:44:02 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 19:44:02 +0000
Message-ID: <2bf71813-0e9b-4cb2-bf2c-44081b000bb5@amd.com>
Date: Thu, 22 Jan 2026 13:43:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/34] PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260122185847.GA36294@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260122185847.GA36294@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:806:23::24) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 91efd03a-a421-4d0b-3047-08de59ee97f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU9ORG9icTd6VWZMVTlIMGxvNFFiYTZic09HbHE3a0liSzh0NmVFM2RkYjBo?=
 =?utf-8?B?R3RXd0o5TkFXWkJjK1FwNHVDME5SZE5LbDdTNUlrME1iQmw4UjE2RWJOTkx4?=
 =?utf-8?B?RFpWRlpWYnVRZ2wzcGNpRkovUkdlVDhuNjFFSDBuMHRucnBuaUR0OXdnSW1u?=
 =?utf-8?B?OS9Zdy9KeGttRW5lRGx0V0dhNWdlNU1aUWlEeEpiMWN1TEJudGxjUUJtczB6?=
 =?utf-8?B?M2dYWll5UmIzSW5Idi81cHpua1AyN3lKc3FJcGNXUHNEZDlVMFg3c3IvNFl2?=
 =?utf-8?B?WDJ4Vy9TekFLRFhEMjRWQUpaSEtWd2tQU3hVR2t5aTJOdk43YmVVUEM3RG1L?=
 =?utf-8?B?N3BUU2JpelhqK0VGa2JvR0daWEU0Vm1pZkxxL3plZkJuMzl5N09CMVpyTUN5?=
 =?utf-8?B?N0JvNUpHWG8rS1RGTVZqL0ZibEludlJnSU9iY0ZHYnZwTXF5Uml2bFp3Qjh6?=
 =?utf-8?B?bjdvMlpXV2wxMFkvRytzeVNKa09sRDk0WHZXcUY4eUpsSGxXcU82ZUZmUDAx?=
 =?utf-8?B?MHNibFdXaHo0VlhScG0vUlFKa1RCWTByNENRc0lZOXF3OCtTSEt5T1hNSkZV?=
 =?utf-8?B?V1JaWVQ1WlUzWktFKzF0ekxIZTg4MUtMTHZjOFNKK1lKUjRVZWllNEREb2lu?=
 =?utf-8?B?bEczU3hlaXAybFE2TkNIako3NkhOUW1jK29Sc3lrMDhzVG8rb3JobmZaazdE?=
 =?utf-8?B?R0FFeGxvV1RuSGQrUFJaSXdxM2tGY3ZrOVJBd2NjQktBUVFYZDRTTUxnMUZt?=
 =?utf-8?B?NVhzcHdvYjhUY3AwUzl5aFZxTnJCaGV6YnQ5dkpBL21vM3VKTEpHdzM2Wnlq?=
 =?utf-8?B?TjZtTmdDRXFYWThTZVZpRURUcUg2dWt2RFU5bFA5a2M0VUxHUjZOc0RjbHFr?=
 =?utf-8?B?WkV0a2hvMWVpL3YwZjF6clZoSm9KN0tHcFNUK1RlVXJaMkR3bHJSWSt5M2lv?=
 =?utf-8?B?RGtLcnlJTC9lT1psUFJvK1pvbjlPT0oyUm1BT1dJK2wxOHhoMkpPM2lSY2VO?=
 =?utf-8?B?YVpUSmZBR3loTzE0aDRtWXdJbnp6OWdnQUVUYnMxbE9LOEdKbTUxZi82WDdq?=
 =?utf-8?B?ejJ5YWhCVTF0a3NRSFZacHpCTGZBRkc3bXVpZy9sZVBNMytTejQ4MWMySW1I?=
 =?utf-8?B?dGhkbWxoeUR2TW8xQ3YrUDB3R2RoNFFTTkhEU2xpOGZIUlBNemY5eU1xTzJx?=
 =?utf-8?B?akxuNm5QL2NlQnVBSkY0dzhlc3JaMGVWOXBtWGJLR3NxRVg5UXNhUkNKT2Nx?=
 =?utf-8?B?OW5GR1I4NGJzN0sxR1VFb1RDMGFic1dTa2ROWFFYTmZZWkZqMTZ0T1FMeFg2?=
 =?utf-8?B?Q1Z6bzFqbi90cExHNGNKYy9RbThtcFVnWHFsRmx2SHBPYmM1Ty9CNktYQ3FI?=
 =?utf-8?B?ZTUydEtXTWZuNHNQMjBwWi9obmY5NkxQRDNhb3BISDdNUElwcnJ3REFQeEFq?=
 =?utf-8?B?L0dFNWFzSGRndjBCTWRTbFFWL0c5MXpkNEFYcXVia2tnTXRpWllkTkxzbFhZ?=
 =?utf-8?B?V2taYkkrdzBDcWRONGtqazNRazBoSmJZUUptbDB5YXc3eDZJeTNPcVRkMkJh?=
 =?utf-8?B?SUZBZHV6RzRIY1NPand1WHl6MWp0ek52RE5zNktzMUhQU2lkMWJqclpUeUJH?=
 =?utf-8?B?bXF1eDlsZThLM2ZIWkhPZm0xOFpHVlp2cDQvRW9ZVTBMSDc2MFNoVnl1dXdw?=
 =?utf-8?B?eERnWmV1TWpCQkhPcDFRM2FLWTZRQ1FNeEExdVNlN3cya29MTlZoYkQyMlEv?=
 =?utf-8?B?MWlITEN4Qms0eWJNL1hreWpCVEFLbi8wQUFRaVdLcEYvWWYwa010VTkxTm00?=
 =?utf-8?B?Ynkwc3IxcC9UcE5oNVJ0bUthTCsrdms1NGpBeHpBaG1XeUdwSFFDbkI1REFo?=
 =?utf-8?B?Y0YxU3FheWdnaGRhSjhTcG1zTlhteTRBM0ZmYS9wdDZqOTdyUmN6Mmo0cUt2?=
 =?utf-8?B?SGhtMTZjTjZ3RE1SeHNtc2R1a0NRcDg3aTV4aU9mNEpXZ3FPNXF3bmZ3YTc1?=
 =?utf-8?B?SklsV3lpSjVLRFNta2EyUk8vcGpVMkhpWk9uWFFUSXBUUmlqQi9LcFZaOGJO?=
 =?utf-8?B?VVFaSUZTVXpERnlxTm4zcTdTYnF0UENtQTFMcEdUUTB2NDAwNWttaUZ6TDJP?=
 =?utf-8?Q?oW/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0V3MmJPMTJCVUZFVUhLTWxuNk1IYk9VSnRKbHZKVW5iYVFybWNxOUtDRHRK?=
 =?utf-8?B?dXprNUMxU2tkVWJDajJteTg5ZUI1Z0gzNTNROU1jVGpLZlN6WXhWUG8vZWhI?=
 =?utf-8?B?UkdKT2QycjloRUdSQ1lTQWZrQnRWSHJScGp1T05VMDkwS2FCRDNaZU43c1By?=
 =?utf-8?B?MERqT1ppeGpJdUxDeC9sK0FQZENFRGZTUFh1QUtDTHRYczJMSHEza3NmcHJE?=
 =?utf-8?B?azdZblVWZTVvS0p0MU9vb0UxRFJ5NjdrYXl1dzdOV0w4dmlXVFYxUUJQYnZI?=
 =?utf-8?B?VWNCbjcvT05lQVVxNFhCTkRkQzQzYVhyNEo1Q1YrRE9VcUZBS1BTZGFQd1dB?=
 =?utf-8?B?dHpkc2pCU0JJWThlNlBZbUNmNWpRWlg5aG0vdG14Q3pjbmF1d3VJaVBVQjVt?=
 =?utf-8?B?OGwzTSsvL3JKejN4SlU1bnlEQ05FN1Eva045aDFjT0kvUVZZSllKaVVwMk45?=
 =?utf-8?B?d0hjb3BXcmFqNWdHNUw4c0VWQVUyMklBYkI5ZDdGUU1OcVdhQ0kyNGh6UXZW?=
 =?utf-8?B?SklQV056bjU2Y2pMSDBrTHl0VWxseTMxWGtMRThGN0JVR3M3OTBRWUZqUk8x?=
 =?utf-8?B?VG5FVENDZHk3R3ZnbTE1RWVYalZnN0pEaTkyVXZKUkVOL21VaWF5a1BXc200?=
 =?utf-8?B?aGhJYjRiaDVkWU0yME1NS1pQN0Vrazd6VFZtUDJlbS9WUG5kd2ViOHR1ZE1Y?=
 =?utf-8?B?anFPaHFzRVphWi9UaG5WQ3lxcFBiMlE0dWl1QnB6elNNaUFmODFld25Namcz?=
 =?utf-8?B?elIvZXB4Qkdzd2RzVS90a1dTOW9HRjlMZFpHd3QwcXlIRlJvTDF3c1ErUkFS?=
 =?utf-8?B?TjV0SmhiMXVuTHZmVFo4ckMzWmV6ZHVkbWJzMmNTM0IyWFEzR1MveHdHVXp4?=
 =?utf-8?B?V2dhYXAvVUFReHY4NWpUUldkdzErZjcreHdBQ2xVRFB4SkppdG5uSTFDZFVC?=
 =?utf-8?B?WFpBSCtHVDNvUWwvcFNENExTTGNIelkzOEc5ZC90aDQrMUpyQkNGMEIvRVhS?=
 =?utf-8?B?YlJVWEtpOE9ZbVg2citsUFo0aVl3TzdFWllWNExTNE44WTRCMTg3NXdFeVpX?=
 =?utf-8?B?Uk00ajEwRG01R0JTUUdpMUMxUCtYa3l2L0c0OUJUNlAvODA0dUd5SWthTU9q?=
 =?utf-8?B?OXZqRUpkS2w0M1ZvYXNkN2Y1T2RWcjVtR3dQVktvNENXYVBqZjZJQWY4aEk1?=
 =?utf-8?B?RkVycGdoMUkzVVpIalU0SFhyby93SGhxS2g5Vm4wNEJNcnoxbGNHM3ViMmtJ?=
 =?utf-8?B?UmNkYlR3ZU1xcXBZOVA4eU1lSDNZdG9DTTM2T2c3YkluRDhEc0svbkw5Y0NN?=
 =?utf-8?B?RENGelpGWk1jOXhaZVFXOFZrbmplS28wdHhidnB5aytBdkhWOXZYQklUWE9I?=
 =?utf-8?B?VFAwaE5iOE5iY09kcWoxSGkwVHNqRTR5QnpiNStDbmY5RUx2T01xVHdXZ2dG?=
 =?utf-8?B?RTFGY0RCRExkcm42Zk1JcXYxVHlXNUdCRUhmeXNSWEdpak5Remo0QWFWaWxj?=
 =?utf-8?B?UHFxODEzdC9FenN5bzFmZm5Dc0kzdWtzTDhvZ1BJOTNXanNaSHFGandCZlVD?=
 =?utf-8?B?NkdNYnltQTRHUmRkakp4UTJiM0ZEUnc5UE9aMVNzVkxCU2JtTnhSOXlqQlpq?=
 =?utf-8?B?UlRWeWdrOThzYUpjeS9YeUZ1QkJTOVovMEFjUGw0NUVVMFhwN0g5ZWNDc3VK?=
 =?utf-8?B?THM2a3FveHNCSEt5ZEpSbzVub1NMaU41TUpTb1JlVklmZ3dpNUNrVlQwYXh6?=
 =?utf-8?B?MUY4b25DV0tOZWd4NGtxbFA0b2pZcEpTQjNkREJhMjJLNnhyQy9mZHhQZkF2?=
 =?utf-8?B?ejRPMGhWMThmN1lCci9iUy94Nk5pTFFyVnRwaDZGSTlaclpITHRvL0tsVEcr?=
 =?utf-8?B?eWNWQWJ2aEJBUmNJU0VobXFYek9oK0xmeldvT3ZtM2NPZVdrYU52N3dTVzcx?=
 =?utf-8?B?M2VvSXVXK2lISFN3MGVrZXZ6eGlXTzRCNm4rM2NBdXRqTlhJYXlRcWthQnpj?=
 =?utf-8?B?Tm9tdEVnM3ZJUnRqRTd5Sk1pS2pVT2IrMUxFcnRUdzQ3RU8yL2pJaWR2eVZy?=
 =?utf-8?B?R2dDUTVBVmJBOU9YZVNhT3JiUnM3VUt0MGdTUFR1WUJrTFI0NlZybUtUMWdG?=
 =?utf-8?B?WjlHNk1KVVBHdC9ibDJ1eGxRRlA2VDcxcmtxMXBaUW9HNm1tSUV6dFdzUndG?=
 =?utf-8?B?Q3BTdnoweEtVbjBXeHk5WG1GVkJnbTBHUEIwV3JTY0RTeDFlQjdIRzZjZGMv?=
 =?utf-8?B?aUhCeEdjcitGSXJXZDhMcmVraG9SY3NkZTZySzV3OGQ5MklpNldrYlNoaHJY?=
 =?utf-8?B?djBCOWpBN21IcDAyaThTejBOWERmWkQ4eEZnQkRNVGdQSHkwU2Ftdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91efd03a-a421-4d0b-3047-08de59ee97f3
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 19:44:02.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMLuM3uWpo+X0myP85sAp+fp7CK0ZbBZGfrbEonnj905YBRC7N+O8D+xL6mBgCJNiaW3X0llSzhD+m/WOsNCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

On 1/22/2026 12:58 PM, Bjorn Helgaas wrote:
> On Wed, Jan 14, 2026 at 12:20:22PM -0600, Terry Bowman wrote:
>> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
>> accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
> 
> I'm looking a little bit askance at adding things to
> uapi/linux/pci_regs.h and then renaming them.  I know it's OCD to
> worry about that momentary blip, but changes in uapi potentially break
> userspace.
> 
> Maybe we could rename them first, then move them to pci_regs.h?
> 
> Either way:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Ok, I'll update the naming before moving.

Thanks for reviewing.

-Terry

>> The CXL DVSEC definitions will be renamed and reformatted to fit better
>> with existing defines.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>
>> ----
>>
>> Changes in v13->v14:
>> - Add Jonathan's and Dan's review-by
>> - Update commit title prefix (Bjorn)
>> - Revert format fix for cxl_sbr_masked() (Jonathan)
>> - Update 'Compute Express Link' comment block (Jonathan)
>> - Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
>>   used (Jonathan)
>> - Removed stray change (Bjorn)
>>
>> Changes in v12->v13:
>> - Add Dave Jiang's reviewed-by
>> - Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
>>   message. (Jonathan)
>>
>> Changes in v11 -> v12:
>> - Change formatting to be same as existing definitions
>> - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
>>
>> Changes in v10 -> v11:
>> - New commit
>> ---
>>  drivers/cxl/cxlpci.h          | 53 -----------------------------
>>  include/uapi/linux/pci_regs.h | 64 ++++++++++++++++++++++++++++++++---
>>  2 files changed, 59 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 1d526bea8431..cdb7cf3dbcb4 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -7,59 +7,6 @@
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> -/*
>> - * See section 8.1 Configuration Space Registers in the CXL 2.0
>> - * Specification. Names are taken straight from the specification with "CXL" and
>> - * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>> - */
>> -#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>> -
>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE					0
>> -#define   CXL_DVSEC_CAP_OFFSET		0xA
>> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> -
>> -#define CXL_DVSEC_RANGE_MAX		2
>> -
>> -/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>> -#define CXL_DVSEC_FUNCTION_MAP					2
>> -
>> -/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
>> -#define CXL_DVSEC_PORT_EXTENSIONS				3
>> -
>> -/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
>> -#define CXL_DVSEC_PORT_GPF					4
>> -#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
>> -#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
>> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
>> -
>> -/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>> -#define CXL_DVSEC_DEVICE_GPF					5
>> -
>> -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
>> -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
>> -
>> -/* CXL 2.0 8.1.9: Register Locator DVSEC */
>> -#define CXL_DVSEC_REG_LOCATOR					8
>> -#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
>> -#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
>> -#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>> -#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>> -
>>  /*
>>   * NOTE: Currently all the functions which are enabled for CXL require their
>>   * vectors to be in the first 16.  Use this as the default max.
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 3add74ae2594..6c4b6f19b18e 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1253,11 +1253,6 @@
>>  #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
>>  #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> -#define PCI_DVSEC_CXL_PORT				3
>> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> -
>>  /* Integrity and Data Encryption Extended Capability */
>>  #define PCI_IDE_CAP			0x04
>>  #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
>> @@ -1338,4 +1333,63 @@
>>  #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
>>  #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
>>  
>> +/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> +#define PCI_DVSEC_CXL_PORT				3
>> +#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>> +#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> +
>> +/*
>> + * Compute Express Link (CXL r3.2, sec 8.1)
>> + *
>> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
>> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
>> + * registers on downstream link-up events.
>> + */
>> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
>> +
>> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE				0
>> +#define  CXL_DVSEC_CAP_OFFSET				0xA
>> +#define   CXL_DVSEC_MEM_CAPABLE				_BITUL(2)
>> +#define   CXL_DVSEC_HDM_COUNT_MASK			__GENMASK(5, 4)
>> +#define  CXL_DVSEC_CTRL_OFFSET				0xC
>> +#define   CXL_DVSEC_MEM_ENABLE				_BITUL(2)
>> +#define  CXL_DVSEC_RANGE_SIZE_HIGH(i)			(0x18 + (i * 0x10))
>> +#define  CXL_DVSEC_RANGE_SIZE_LOW(i)			(0x1C + (i * 0x10))
>> +#define   CXL_DVSEC_MEM_INFO_VALID			_BITUL(0)
>> +#define   CXL_DVSEC_MEM_ACTIVE				_BITUL(1)
>> +#define   CXL_DVSEC_MEM_SIZE_LOW_MASK			__GENMASK(31, 28)
>> +#define  CXL_DVSEC_RANGE_BASE_HIGH(i)			(0x20 + (i * 0x10))
>> +#define  CXL_DVSEC_RANGE_BASE_LOW(i)			(0x24 + (i * 0x10))
>> +#define   CXL_DVSEC_MEM_BASE_LOW_MASK			__GENMASK(31, 28)
>> +
>> +#define CXL_DVSEC_RANGE_MAX				2
>> +
>> +/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
>> +#define CXL_DVSEC_FUNCTION_MAP				2
>> +
>> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
>> +#define CXL_DVSEC_PORT					3
>> +#define   CXL_DVSEC_PORT_CTL				0x0c
>> +#define    CXL_DVSEC_PORT_CTL_UNMASK_SBR		0x00000001
>> +
>> +/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
>> +#define CXL_DVSEC_PORT_GPF				4
>> +#define  CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET	0x0C
>> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK	__GENMASK(3, 0)
>> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK	__GENMASK(11, 8)
>> +#define  CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET	0xE
>> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK	__GENMASK(3, 0)
>> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK	__GENMASK(11, 8)
>> +
>> +/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
>> +#define CXL_DVSEC_DEVICE_GPF				5
>> +
>> +/* CXL 3.2 8.1.9: Register Locator DVSEC */
>> +#define CXL_DVSEC_REG_LOCATOR				8
>> +#define  CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET		0xC
>> +#define   CXL_DVSEC_REG_LOCATOR_BIR_MASK		__GENMASK(2, 0)
>> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
>> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK	__GENMASK(31, 16)
>> +
>>  #endif /* LINUX_PCI_REGS_H */
>> -- 
>> 2.34.1
>>

