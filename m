Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012063.outbound.protection.outlook.com [52.103.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113833B6C7;
	Wed, 21 Jan 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987159; cv=fail; b=soUeAK425BSdOdiO2+3G41+ohoBzMwGqAky1jyvanFibUlxS4z23j6j53lSI12T+j4I6kOVUW+65bVLQLqGFaBGLhiew+bAQBgC9PdEjOKQI3MM2lWEBe0n8fK13wrLZgZBiiROfI/cTI9jkfNZvHpR7oUTHoGzHMkgmNOm9pbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987159; c=relaxed/simple;
	bh=jBH9/IRqlI9PivP/UB8W1+F2eHhpk2eOWz7fkdPS87Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J/pTFOIuwPfUba805edZtiUm6Z6mEyant7tZXX+G7Gwb3YjLjxw9s6UKb8NaCpNllwlWV/Ngcf5cBIHqyGYydlWB2EH+P4OarkcvFKGo6Fe3d7ljwSa7rh2tGHWmo+DujeeYk7nUTPBswQy3sc13QDSa+IT3UMinb7RGYj83KlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dTbzkPnb; arc=fail smtp.client-ip=52.103.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dTbzkPnb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuUniYH9oFR5oElfdn5XpPgQKxYxuIZHmMjcoZdGGFkrafFjg01WCx1L8122jH4Rwdjjx4jHSdyt7iH5H4HR3V6a3K8Wx42Oj39SaE/c9Syfaax6Suq12hZISrZREqjhLF7h/CJ6Avnl4100b681C9Rk/DClkmVZe+n/XihOiC142tP07bxuJFoMGSQz/uRzuJcrykF7H+c7YnpYYcJIq5ZJBfGgzgGCnVlt38SAq9LhdDXYvDfDfxT+GxSuYW06HcdKupBrU6eoT3i03xTlM34XBEwTgTHcjE/mcn8ElBPm3L5oQXneJVET00jhw6hEic72G6SyYtlU6H79STeZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo0rgE59IJnyBDbSQhM5n7Fh1rGwulixhaKklLzP0Mg=;
 b=YxN23JmuR+uMpQXu+zHNsOULFUTNvxU4IiX6KqaQDiZ8mJQAedfCJPZ1yLctmTS4dJ62KEuiNXsB2BbEGSbzYkhNpARY/jpXqM1nJCNvx1zH8cJbuDxkGkWFz7L0u/HYOs49feNQiMH86oKxKQYCPu5vKJD7d6bzA78IG2CW7m3EK4CDJdW4qfg1vaDQdtF/kEwjTp7Ul8Wo5yQLJXa5j1hbe2WMSdKq9fSHIqASh/lDhaVajB1GDmUfQzWTFkfP2eQL8cYaB/kNsVsgVOGkC8ltlioGeLaOGY5+9DiKJJ9iudCHRVpx6H9L7tE4TqiZnnIT8t79BD/efugj7FLnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo0rgE59IJnyBDbSQhM5n7Fh1rGwulixhaKklLzP0Mg=;
 b=dTbzkPnbnRfadIecuw7BacUqqFv3EEm7TmuNgDcBnoTf1OYxWGv59WuYKVh8PIgCQVESrJOC31N/jDUyBKZjLZ22P4GTMyHS1PercKpvWXGFYGUVirP3j2sOln+uQBI2RrRtn2OlhyeFcYCmyrnq1z1PXnDNwIJYf0Xan8JTWe20yKcOUTv42OkAsMV7HpoNcEFU87Gi9ay8nyqa608idemZbRQV7eDQaGvceTHcilyLUDPyldBRFz79wlPFBi58YQVjYQrpjTz0aLxwpDKpq5PDBhEKYuTLL1201NA7mw5q4A/Cu3zULdOhvwZTVcV2melMdHQxu4FQykOWpU3KfQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY0PR0101MB4095.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:19:14 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:19:14 +0000
Message-ID:
 <SI2PR01MB4393709A1FFDD137DEBFA883DC96A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Wed, 21 Jan 2026 17:18:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add support for ACS Enhanced Capability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260120164112.GD1134360@nvidia.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260120164112.GD1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0073.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <e5a502b8-05dd-4be1-9465-4bdcf0c32c3d@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY0PR0101MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2951f349-0c46-4c8f-9f0a-08de58ce2425
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayGKAlIIivN7fIKgPET+ZtPoCKVzlPuMzSdI+Rt9WL4dY8+XscpPtDVhxKZm8ZfCdaujgOlcfLyYYZ3GEFfzCWSX/fEeA0ogDRMRkE+l2slxOMdi7NXlF3RhK7vwuGfA8wxCloBlyFGYmmW2tB11arifrc1QrYtyuVK9ta2c+t8wFl5lviMFwo0jQtpO8cO4aSCTDPZ1QGOn1iDlkJp8Ku/8KStnwu/vRxgO86Arr0UjWK244sLyx3zw18KfvgXGi1uGhzYMGZFXIjAK877YPIJKsr7LDsbF07nTahRgP9mm2+/wpJBjfT0FfikNwsVO9SaWRasMy06p0mgLuhS7akWjRAD6AN+bvaB9Pvus/kMIEeiMVnsEmSmGxE2dOF0sqIS6jqSuSSFLkiEaL11KM9yiCMqAZlCFFx0whdAPTI5e8koZGp9XwhkJFhGwr5YIdTbUQvCfbO+1Z6ar95+RaVnR/AZwcd9CRN+nKQ8sL4HRNLnIixYddqKZLHwXsDi2FK2XsCyc+NVsl/DdAGcSgv2cYgE5bgr0YjOSFnpQyVwH6e1Ky+17mbz47KBGljVWUKTRyxoCVxnWyHrMUjgZipi1/bSU6ntEHf72rG95OsjYhVOematnpIHFOjMT4K1dnIkauuXhZKZV7hWJIIeFpbNxrKKEOsSTAq6MC9Q+W00rplPUU33vgWyz879I8mbtkih3K5ukWp2kc3R8U26k9xOvco7B47Ajf6Q=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|5072599009|6090799003|51005399006|12121999013|37102599003|23021999003|15080799012|41001999006|461199028|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3pwRXgwNTBPRWxjRWZEYnBxdXRwOW5nRjcvNENSTXZSRHRHWTJBOGpUdWQx?=
 =?utf-8?B?blJKTGRHZ0krNkNBV2pLam9zckxNZUFBVmYvSy9weE9leVJoeDZCY2E3bnFY?=
 =?utf-8?B?R1VJRE9oUlZyclBLU3YycWZORFRiTWlzc0IxR2RYNkhnNEM5WU1nVTFwTzRH?=
 =?utf-8?B?MXRERkpKbVdxR053b25FU3dKUER6cGg4ZjZHWmxPZkJNM1BLV0Q5L2NPU2hi?=
 =?utf-8?B?UEpPOXBDWVNLMFZmSTc3blZ6bFJHRzNFSkczQ1AvNk8xM2djZzNydkJuZVRS?=
 =?utf-8?B?YXU3RFVuZ0xBWGMybkMrSVJuUG1VMFNYcWZPQjlvYTRUNnR6MG5EZG5kbU8y?=
 =?utf-8?B?QVlqUTZmWFYwWlNNbWtOc1RRMUxwZG5nTzRHT1d2aFRCSHZNOFQ1djdmNG1Y?=
 =?utf-8?B?V2RQUGZjM0NVSlZocHYvcXhzbWI0ZElKMktLRVYxZnRLd3ZINUZCN1NCT1BC?=
 =?utf-8?B?U29la1BqYkhld0ZFS282ZTlTT2FkUlgrbmxOM3RSbC9Xb29TZUdaMWlpWW50?=
 =?utf-8?B?UGdQTG5URUZ5OSs1UFg4WU1ZMjFqV0NZbkVURzgwY3BnejV5cGsyUEJ4N2VI?=
 =?utf-8?B?T1VMZkhTSzVDZWVKak9LQjk0SzluRGVDTHl5UTdSenE5aU0wSHhZQnN2TEJS?=
 =?utf-8?B?TkIzNGliR1Z6ajZFMWloWHZpNi85Uk9CRGVTRldjSXp1NVhKcG01Z3dOMGVs?=
 =?utf-8?B?NVdiaDNuaUtMK2hjUGhQeGNaVVJlbFg2NWRoVFJHRzhDRzFzaTFhR0Q0WlVi?=
 =?utf-8?B?VVpaeGIwZzVTbXdzL1g2K3VORzFrUGtEWk5SVUJQYTdtd1I3ODFhMW43WXVV?=
 =?utf-8?B?amdhNXJCK1drR1RBbEp3ekt3clYvdUtXSldrZVA4T2pNdHRLcHZES0ZqMVJq?=
 =?utf-8?B?YVRzTFdlQTEySTdCQXBxcGk4ZDlWdGJFRng4MEd3NTZvOTlCRGxGcWZxWnI1?=
 =?utf-8?B?N0FhNzc5WGNXMnRUSlI2eExNNkd2bmdsZXdoYXkxbE5tNVJlREFqek1hb3FX?=
 =?utf-8?B?Z2xkRlFKdDhia2RaVnRtS042bG1HYUxOdW9tV1Q5aVpDd3lEOVJ1V3BWTitB?=
 =?utf-8?B?SnJ3dWtJR1ZLQmNXMmo2UHdLbzBoSTRkOFJ2dDQvYml0Qi9pbCtMVWpPNEFX?=
 =?utf-8?B?M2VyVXhGK1FsOXJpdURDMElNL0UvNTFjc1l5L2lOWnRZV00zZDgwNU03WHNE?=
 =?utf-8?B?azdxU3FLcG5PaThUUjRHODZONXNDRUpwRldYd05QYVVEU1Q3WUkycUdFSmlo?=
 =?utf-8?B?VUxjODBwWW1vRWdNVXNMNVhGVmZFQmt4UXRORk5rZ3BVaWFma0ttK1UzMDg5?=
 =?utf-8?B?VjFwa0JORHovRnpWSE9HcXJGREZzVmRvZUJhR2NlRlFVYTFoRE91WWZrNk4z?=
 =?utf-8?B?dlZJTVdqVm9mOExSZnREZks5c21MaXQxR1lqdVBSbGZTajQ3anpiTnh5V1ZK?=
 =?utf-8?B?Q0ZRM0J4a2l5VEg2cjFpc0NLSndZckhzQkJqOFB5Z3JjSzdCeFNhMWFVd1JE?=
 =?utf-8?B?ejRGQ0oxa2FTalVkZjNMMWMrMldxem0valFGd2ZZNktDcEVQaWtjaVM2SnBS?=
 =?utf-8?B?SUVRKzhiOFRwZFQxMERGdzJFZmNmaCtpRi9XaUxkWTl2Z0N3OGFUdkNKdGlN?=
 =?utf-8?B?Y0dqVWhORWcwY3p4b2hDWjZDM1JQeG9QK0N6QUhpTXRsWDhxLzYwRlpLUWVC?=
 =?utf-8?B?b2RNYXhLSWd1WjdLaEVlWHhYRDBpTTl3ai96blRIZEpobU9VNWlQSmVhZkJj?=
 =?utf-8?Q?VQpI2T8UYS53ut9pOU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hmak11TmJqT2FpbEpWTjhHN0VDTDR6eU4vajBUVjVxUHp4dk14ZHMxV1hz?=
 =?utf-8?B?RVJuU1dWUmp4WVZ2MkEvcTVwWkdlZ2drRDgrSWJlemVBZG5YVnRNWkJZU1NZ?=
 =?utf-8?B?aVhJUTJqL0VQc3dVbWRENldOWGlNeUp2MHBYeS9zTVhhSXljRHduRmlRSGxu?=
 =?utf-8?B?c3daZWRGS0Vaei9XdTlrSE93TkJBcWsxenlpZTlZRW9zNnlkd1lSR0I5bDNa?=
 =?utf-8?B?ejkvNExmRWJtNkxpSFIwQ2wrb3Rwem8xSGpwa2x0bnUwY21RbG9kbHJGWjFB?=
 =?utf-8?B?Tmc3blA3dlJhY0NHbW5yTG5vQWNtaWVzOFcxajZBaCtEWVBzbXhZcXMrWHEw?=
 =?utf-8?B?WEZDaVNtV2d1aTBVY0FhZFY0Si9RMHg5MEpwVDNaeTNmU0dpWUFDWjdGU2xi?=
 =?utf-8?B?NVZtZmpUMm8wRHhoYnloUGtNbFNQdURGT3FhaEplRHVFVGU3dkkva3A5SjBV?=
 =?utf-8?B?TGNtQ2xWSnVFZFI2UlF4dlZlRG15WGgrRlFwbkJRWEE5bDVPVEw2YXFwbWNh?=
 =?utf-8?B?c0pQdXcwZjlTYktqWnlhSEo3ck5aWERHUzJIYzNZYjhFdjlwMnFZaGo2LzVL?=
 =?utf-8?B?YUtSZ25WZ25qU3o5UkZMbWh5QU9nWFQ2WkE5ZW8rRWZjYWdHRlFUaFdkeEtH?=
 =?utf-8?B?YjQyMDUzK1JmRjZ2Z2djbVViY1NuK3JmdHVVTXZVY1l2WUtUSEFuZXBuL1lz?=
 =?utf-8?B?MEl6T0RsSDRtelpHL0U4RGlsUGlSbGhjYmZOd25RNXoxb1M5aEJsMVVVcWdF?=
 =?utf-8?B?SW9kR2d5N3VRWm50L2JOSDBtS2Zlb3NEOXRoeTJsN3BsZnlicnQ4USswTkRJ?=
 =?utf-8?B?NURZOUw0Z2E1cGZRZG53UHRrREUrZEFPaS9uazhGVlYwaC80V3hYUVJZWTYw?=
 =?utf-8?B?T3Jpd0o2R0tlb0l1c0FTUUg0RlM1UDR5MFNZSlAvZktuTm5SNGFxaDhGSHRK?=
 =?utf-8?B?VkhhcjFCaWsrM0N2aVFWSTh4eTM5ZWVJVHFFRmVEditmZjVVQVRia1ZXaDhK?=
 =?utf-8?B?dkNLYTNCOEswaWZvOS8wNFFkUHdBNVF2bzJwVlM3anI0WnExT3E4SE1JaTJY?=
 =?utf-8?B?VzJkTnFTY3ljdm1sTnREU0RuMUpMQnRrdDZGSEgyS0k4WUFEVTdqRnBta1lK?=
 =?utf-8?B?MlgraHVWaDNVRzhGN2xuOTFyL2hraWhuM1ZGTVVLazdvZ0VSMDZBdlZBUE0y?=
 =?utf-8?B?NlkycFcxdzk1SHFoNVlJbUUxOWxncG03K3YxUkp0R0JuOG52M0I2WDE1MFJm?=
 =?utf-8?B?L2pSdEQrSmp6akZKazNRUG1rR0pQY3NkNThtRnNyeUVCQWtMWm1aQW5NOFdI?=
 =?utf-8?B?cmF6Y2xIT3JuQ2xXTXkzYTRlWWcwVEo3QmtTbjBmUHphZ3RwalQxNjRqelcr?=
 =?utf-8?B?Zlh5S21FbC81TXdDb2JPVVZ0eFp4QjNVZWhrdzRvY3ZISDBBVWZtYTNqb2NQ?=
 =?utf-8?B?YllGZXd5cTYrT3hNUVI4cThOQVZ0WXlMY0xoVnJuTE9JQ0xLS0xQa2tIZ2th?=
 =?utf-8?B?Z3F4eG9RZ0tXK1JtRjVucEdBb0txWG9VbUNRYTl5VEFWV2ZaZW5jWmRKdDJE?=
 =?utf-8?B?cUdpQWJKbjBTQS9idGYveGIyOHMxK21IVEtLNW56RVpDVkJFUmtvY1I0cTBS?=
 =?utf-8?B?bU10cVhNZ0EwS3BYNXRQNUs1UU9BL293dmNPcnVPQ0tIN01ndnpQVU9WTmRs?=
 =?utf-8?B?NzNsMkNRdTFrWGFpY1RqMFNEekRwM05Gem5BdHZJVHc2bDZDSkpNdDB6WGd6?=
 =?utf-8?B?N2J3aG1mUVIySTJDdTZmampZL25tNnJKNmMxK0pnUXgraTlVMmx6TVYzdysv?=
 =?utf-8?B?TGR0aVlnTER1aE51M05ic1p4a3k4UXVreWxPbG80WU80bDVvRzVkZUp4VkRW?=
 =?utf-8?Q?yLprwM5Bj3cw1?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2951f349-0c46-4c8f-9f0a-08de58ce2425
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:19:13.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4095

On 1/21/26 12:41 AM, Jason Gunthorpe wrote:
> On Tue, Jan 20, 2026 at 02:11:30AM +0800, Wei Wang wrote:
>> Add support for the ACS (Access Control Services) Enhanced Capability,
>> introduced with PCIe Gen 5. These new configuration options can be
>> controlled via the config_acs= boot parameter.
>>
>> By default, the ACS Unclaimed Request Redirect Control (URRC) bit is
>> enabled if supported by the hardware (i.e., if the ACS Enhanced Capability
>> is present). This setting is particularly important for device passthrough
>> in virtualization scenarios.
> 
> The memory target access bits should be set to request redirect as
> well. Linux's grouping logic effectively has assumed the enabled behavior
> forever.
> 
Yes, sounds good, thanks.
I think the REQ_ACS_FLAGS also needs to include the check.
