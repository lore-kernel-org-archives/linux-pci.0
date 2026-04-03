Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076431E856;
	Fri,  3 Apr 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246581; cv=fail; b=ZeKEfupWW5Q/v5sfdIgh6+KMBcz9wIngxQmzWuUb1OtuZbv7AHuXkL/kI+8bd+W3wXpCLJ9mXC+NciCQ0e2TdrBxtuMpeSkuEd6D1xsUEUZDFnAVhC6xfK3s9xUx12QUqmJAm8DGBybMSpHEjIlu4LGCjQooKavKQcQj2hxRtcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246581; c=relaxed/simple;
	bh=TchWfam7ShHpY9cX5rY+xCwgLHsJitMiQCRBFAJd5Jk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dnuuzx8z0o34K6iuOTMYhJDw2zWennOm5JCwy1jdW0GNlGHQeu5g4A2rO0WumMIm0t4xhdM9XGpKk3mhmve4louzvyxh65zsBPTXcKhDguuSg9AkrjBD+WwCxalyIsRgDKnU/eAEC0FXiA5sLlj393lhK9EA3iXqAd1PgHVmdC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uIXkqQdm; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uIXkqQdm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti3koZrSoVWpizmov0y4fOo4wMdKcmdSdbcOvMkRgm6GbClIuEtOEG5N0vQZ1cpR3O0cz8gfO3RQf0E3sfVrqpD87svpYQhLlxu4vjn4R+t9Q7lwybAYHpWx/H11ki+XHMXWpfk5nvQGItFO1kIDpRBGdPf9ZuVqFDHyOwrk2b0+Ml2i+/+nJ0QXlLM/rlNOECLKQ2+9v3z6URCIbQ8YCicOcBNV0Sc1qkxAijmJuQ4QpgJp1HEcSxGAJajgmRFmY+Y1SxhmtXsnmV0lZ1ncauD3PV+A7dj6bEvUgq5CdK7/WqbJuN0pkNRswTHJptC9zzzbjBYoMtzM7ldMkTrBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgo+qxewyLJSO7im+7hZHc6YWq7D1DrL3dFlA+UGTXc=;
 b=Jdmyu2rLQ8fD1JLtBmq66QG0IZYduQsnpZ0ysjMk+9py/xrlTa8QjL2nrRL/wo4kcpXD8z10Jxqd9OtItR32vV17eG4VFFeOEVbttllVgb43hqhOdj5JffdJ63cnV8sL8CQqPvhXJdg2SN5ttLU1i5GsJwx0c6A37vOBacEpAzBeumjyFGEL1i35ZGIxVDme6wxX3SWuTDdu3P9/TUX4P0cfehwkJ+CtFHitdVw1gdMedtUkZ77vuqblPRWxChxC8sIf1CGQ4M2byYonZAy8cApfKkPDfasiWUQTVz8PPgp4fZRCucoKsx/1zW1nUVuIRQTdSf907Nk7ffDAjw4o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgo+qxewyLJSO7im+7hZHc6YWq7D1DrL3dFlA+UGTXc=;
 b=uIXkqQdm1R5kE6t3uEupXnmvLXzC6MFl9vxd9YrWdmhn1dn73ldAOrhsH7v8pObc5JKpEUtkAIhGWCWZo1clnCFrlZeNB27UiHPxGsRVYfSal9AFuFdNeVozvo8wP0QIJQcLM6v5E55ZGaT5GZ4WtvLmz+qgC25swHzZ7saHj4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 20:02:57 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 20:02:55 +0000
Message-ID: <d0994dad-4506-4b5a-b44d-3bb68aae4517@amd.com>
Date: Fri, 3 Apr 2026 15:02:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Joyful Lee <joy@joyfullee.me>, Bjorn Helgaas <helgaas@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>
 <20260403180422.GA341023@bhelgaas>
 <CADj6jrg4YWx+iR0o=JSh23uP0Mb2Mvs-ngCJXGUAwCCUQGHM4A@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jrg4YWx+iR0o=JSh23uP0Mb2Mvs-ngCJXGUAwCCUQGHM4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:806:28::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d32ef4c-0e93-489e-96fc-08de91bbfecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CkOnAtxTLHdoODC4AGsKl1/x1aRLiTNjohnjTkgffd6dJ5R5uQbpCvM5byBagoPpSxKpz0CYAKgnGi16KDUgnzpgq4o2YfXEUBLRSauHyCz4OIWuYHQZHxOmP8lcctmm7QPBOA1gtjFkOBfO/H5J3WJMrcIdXq5lgt2ghv+8eN9mCvTPFbDFDCXcuTOBon/25agJOjmx4CuqMj0SNfgtS8mPapLYEgjxvI+ReEuAkehjoxpb1jsStkPoH32EHEuGG/uB1VvZDdLtld4wzsHMR3PAVwJ6UnlpybjRItfDoGV/sFlh1kBxDhRnTChYfZvrhvYaidQw0T4t6z/lHWA6plWLWK3UQgaTKdNFIx6FZpwIEObVaECPATYS3q/101cOAGTfSQJKtCoe7O8cFXuqZkN3NSnQZcXXS7mc557o6p5qXc0P2DytN7zBmqZZZbO8+rzv/xF84A+80Gftqd2YD7JMwjFQ3QODV08JVhFsLiqWbSd64DFuKiiq9i6kNb77XhP5JrQE37FB5ocLQwgesYg3gTsVO5+4JRRS3EwDoOEoOLxMtu2u5ymf/biowDltAYRgiQbjEU1ctDmbrbwtPnkwVlO7QK1f2g8a9KEeyc3ZCnQBnglkaqegUw5B60SUYWssnf/3fLUrcKsI61zbXcYGEbMWz7EnMYzWr2Yo76rE6536klESHo4fxm01UruJXr2EWTKiSXvBCr7FarHOaMoOxl85hbuPO7iIxzxQNxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVoa3lZR0l5S2dkSVFBdEt4QkRUUFFSWlkvaFl5WE0zditLNEhRZjY3V2xy?=
 =?utf-8?B?eVQvOTlRYXZFL08vaGNMQlRZOWdaTTV4TUhnb3NqYXpWaUlNZ3JqSlpGR0J0?=
 =?utf-8?B?UmI0cDgvZWxPOVViMnB1T2ZEeHZLai9wM3FGcm5hS3ROT0ZsT0dlalovOUdj?=
 =?utf-8?B?ODV1bVFnOHVyMHNjSUwzOUJQc25YbExCM3UvVzFUeTYrak92UUFubmlPaDVi?=
 =?utf-8?B?NFZKNmE0WHJicDZYTG1qdWFKMElBQ3I0eVJaTnlncmtxZ01BUG85S1hZY0Jw?=
 =?utf-8?B?alUxeTZBbWYxb3ptc0tPVmdrdGdaNy8zcEVvL2p5am40Nlp3cWt2OU1mK0M0?=
 =?utf-8?B?WHBlZXZTTWZTZWJyTkF1WEovYTNTLzVvK3ErbkwxUGZudjRUU2MrOFBjYkwz?=
 =?utf-8?B?SlpCSVZGcHhKZnlXbEFDRWY3dFJuOU9YSTNhaFUrbThOOUpQYnRvTjhBOXdI?=
 =?utf-8?B?YlZQTnN4clhBL0cyRCs0MS9JVHBEaENhcW11aHg3eURESlAvWDdWM0JOclR4?=
 =?utf-8?B?VldGZXFPTUxSQVR2RThHbXNJS25KeURwS2R6M1dXZFlRS2VGWWNaWENaTi9J?=
 =?utf-8?B?QmdsZW5Yc20wLzVhdEhyR2ZTQ1FJbkxnQUxzamM1T2VpS1ROQURPVmFiQWh3?=
 =?utf-8?B?Ui92bFFhVXVtb1c1ZjE4bEZFQkNWWU1LS0V2Q3hNWWxwbFV5MVVoR3FRTE9G?=
 =?utf-8?B?TUp3SWI1WjEvTjFNMFM4cGk5N2NmRDV1Z0tpZXBNQTZIL0RvRUc5eG9TZnRW?=
 =?utf-8?B?bVdSNUNnMHFYRnhuS1JTSVRsTElFeDhxSHJ3Z1VHOUFMaHAyRkgwYldoaFpy?=
 =?utf-8?B?QkdnS1RCeDdsLzRXRVlvM1hFSldzcENvQjRFVjlpMVFsa05VMmVMY3drWFI3?=
 =?utf-8?B?T0tlblVYSzYvVER2Q0xxdHcwcHM5QXlXNWF2WjExWEtJV1Z0aG11TWhCVklW?=
 =?utf-8?B?NnVTYndtM2U2SmJtT3FtcVhoc2t6VEZ4dC9ldFlCN3JsdThuYld6aXJsVnd3?=
 =?utf-8?B?RXJaZFFScm12S3RxdlZvaWNZN1NqUXVRbERVdCtPbG9wZ25pYk91ZzhrdGtI?=
 =?utf-8?B?SEs0aDAyWVJMekxkTFpMejR3V1F0WVh1YjR2QWlQL21mT2owSFB4TFhlQTNK?=
 =?utf-8?B?MnI3d3BURFRjT0ExRGl4M0gzRkxsYkpyb1JsWFQvV1JLOVorUFh5YVN4d2lB?=
 =?utf-8?B?cEhucjB3aHJhV2JwMTJNRENVZThJanVvcTFBckFaUDU4ejcreVUyWFZ6WUh2?=
 =?utf-8?B?NmhwSllYYk1oRzl4V1R3TDRCbDVLNVRvTml2dFl4N2NqV2JvSUFxZS9uU1lv?=
 =?utf-8?B?cmJQenB0aWpqL1pWaUgwR1lNNnVNY3JqK01FZ2NLdi9Ed0hyOVpRSmtqTGJu?=
 =?utf-8?B?Tm05T1RiL1Q3aWRjN1Nlb21KUldYYlNpZ1dEZlpHdjcvN1BmUXF3TW1DeVY4?=
 =?utf-8?B?cUM2YWhEMlVUQVRzQWNlaGR1WmZRenN0S3hMSm16ekpzMk1FcmN0dFlPYXdq?=
 =?utf-8?B?dVVJZ1ZVTzIxRk42akFqcFdIVEM3VUczcHB3ZkVMbXBTMXVTSXhSTkVkbDVY?=
 =?utf-8?B?SVgzMERacTBWamhsbHBBb2g1dndWbnVjN0dUT08vWTcxdm5UOWtHRDA0Sis0?=
 =?utf-8?B?bk1Ldy9xdEE5Uk9ta0UyTlQxeDZ2a09jcXBHMmNteldCL2NoT0xTL3BEU3VW?=
 =?utf-8?B?MDVIVjZBaUl4NStFU0RKSkRSOFpvenRPR0lGN3JVRWxJYXpoNVNJTFFSRnpL?=
 =?utf-8?B?ZlB3TUNIZWhocjlDMGFzRXdHcWF2bmFuSDZQc3REb2ZmRE5VdHJlcll4WStu?=
 =?utf-8?B?Rm0vTkZIRWZLbkdkaWFRWDhZZzc4dWtxSEZibEdxdFlkdktoejhiMWpQQWVh?=
 =?utf-8?B?b0dQRFVwd1UvTDJsUitKaWZYaVJpdVBTNjl2OXlycVN3UDhkOFErVWZxSko0?=
 =?utf-8?B?MEFLL0JJTkNwSE10TTFIVit0bWlFd0pEWDhhbGRGU1BxYUdWM0ZLVU5LVDl0?=
 =?utf-8?B?WWxvUmUzNXlick1wK1VUZ0djakNGRGVaSThwSmRvSVpTMHMzSjZCaVBLL3NU?=
 =?utf-8?B?OXRHaFc3ZzBtRTdkR091LzhsV2o5MnFjdHEwRlp6WVNjRG1WNG5iaHQ2TTFJ?=
 =?utf-8?B?WU4xdVlrR3hqRUtWTlhHTHhCdWlHY1Q1ZmZOL3JhYXp3U1AvakxjZ3B2QjJj?=
 =?utf-8?B?OEpHZkgzb0swTXhJNGplcFk0dXV6UXJHN3A2cnBMNWt2aWNNZnUyeGVOVGU1?=
 =?utf-8?B?dTdiczRyMjhlVHljekJtempUVUtLRS9UeUg1bnlKQjJSU2l4MFBwK0U4UWFN?=
 =?utf-8?B?YzJXWHd4bWtvd1l0OFJRRFJ5eUpDZHNQb1hRTzRJTkpWT3hoamlEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d32ef4c-0e93-489e-96fc-08de91bbfecb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 20:02:55.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHpQFwpklpQiFKUH5xfz1Ydigcfzzd7IVAxU3MDPmofA+zkxbD8hiQXZ9aO1801Wwf5E5XVXcN+gh5cA2VhC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

On 4/3/26 2:07 PM, Joyful Lee wrote:
> On Fri, Apr 3, 2026 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> I don't know what pciehp is doing that avoids this issue.
>> Understanding that seems like the first step in avoiding or fixing the
>> problem.
>>
>> Joyful, could you collect a dmesg log with pciehp enabled and with
>> this kernel parameter (the quotes are a required part of the
>> parameter):
>>
>>    dyndbg="file drivers/pci/* +p"
> 
> Certainly. I already went back to the 6.18 stable branch and enabled the nvidia
> drivers, but this is still representative of the "working" state.

Can you do the exact same on the same branch/commit but without pciehp 
enabled?  It will make comparison of all the impacts (not just this root 
port) a lot easier.
