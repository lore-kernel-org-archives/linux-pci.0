Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7382288517;
	Fri,  3 Apr 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234902; cv=fail; b=qzkfycaAEuFKENkNvhX79IprJ8s27tFYbWYeYt98JI/4N/IRrkUHtWPLiReMGgJXjAd2EVFFf5TRvEZ55y7DbMsjB9nnXadL9VzG6OIoOoLyWTqhspb+FCtAv6v3+EgQhEYReUzzAYKg8AO2uK00Lb/9GSlPIqPxNX/PHfA6jJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234902; c=relaxed/simple;
	bh=qGTRE4BlwFLygY/h0r/Yb0UbZmeqN32Mn/hjZgYbU+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bo0JGH0r0D75iyrXmOZ09u6DmVP0/BSzcxH82sjKywYY51AMN/6iG76DZYZF7ErYTaxBeVkOOtj4VOLxq8qOKTgPPFPETY2rZaHO7e3Ub9EHBWIAwU8fkmlNMghmPS2pOatS1RoEqOkSb7bZ8XuXXJ7OMpg1DUQaA8SiWfKqJCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jCavx/fN; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jCavx/fN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRtacoi+6kXknqHhR9BPGjNYFr0hUrHmPoBaMlnQaHaw51vnoNYL62RUScMWrQk0G8nP1u9/vMSaECZ5VBqgdFLg2BiMXsRnqE+0vzXv49Uvk5dFOko4jueKLotnaSr05Uin9PRzttnbDntA7kljSR0Y35FaHMnBhSR1BeLfxCHq4wMsUqd5IPfFFMMnqyD0Ypjz0j1r2KIVx2/paOBvTZKn5vxcDMKi7zOdVYml3YTN3gm2296DcbFANeGI66vOYrmO1I3VYDR695LIkPZ/ji6PQaU7EZPpEUh5TzXqECWOclwMrWgS/1hUtApK9sdlZoxQlK5Kt6u2Z+sKq0W3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AQIJxdQtSB7IEsrPMNipHUn1c8YarYn21fRPeDd+zQ=;
 b=JUetHqacUw+y9gmp4qs3oSl09Kgwn9BmFOicGtKHoXivUTmyAazof1J5Bto2M+7Xnw5dJlLfPBKdFbO6us0UubrICk5CiEpgC3YEy2aEu6P2I7peSLKZbmju8DziydbQS5Jj4+dd8xK8wjnghU3vJ2F/WB3E3A3xOefTY7PvANuVrgAHOVZIxYKhUmtnvnSDWdiEHSXBAPQruXWp+UYasPMvJh+zs49+ZwhEnCNBPh1Eyqq8jW4be7qLU1d9vl16/8AidZud/6rEuHUp51nbv1oMJkkTK4XH70aq/pO8o2cRNbJ7UGnnN2ezCVpq2w9lTmh9nIqzOj3JtKESRKyfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AQIJxdQtSB7IEsrPMNipHUn1c8YarYn21fRPeDd+zQ=;
 b=jCavx/fN+E8LJHAyYDFGDfLWil4fwJ7UGCPJ+mjy81ynNoYhc6/kvngS+RH2IsVjIXDGJjJuPbujFXsTjQnJ7XNuvRXSO6n1pFUPYGJPjHFIkb9MpwKZAi8y3SRTBHIl/n7i1wN7IOJNgQI+1uwGizVIlq0DslmSvK5Os8WOU2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 16:48:17 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:48:17 +0000
Message-ID: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>
Date: Fri, 3 Apr 2026 11:48:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Joyful Lee <joy@joyfullee.me>
Cc: platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com>
 <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
 <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
 <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
 <CADj6jrh2AT6vvQqujB5UN5tfcQ-qdDKjV_7fK18zsqkHpFTMzw@mail.gmail.com>
 <867b2fa7-a8a4-44ad-aee8-fbb9d0555072@amd.com>
 <CADj6jriuyztRnB60awqyhO-hu18mZ+UmpMsY+_qnSYPkcGqDSA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jriuyztRnB60awqyhO-hu18mZ+UmpMsY+_qnSYPkcGqDSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:6e::30) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e19c232-c2d0-4c9e-4f3f-08de91a0cdf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BzicMPgOyCMYnT1KpA7GZwJNrKKbSBgPewQDoiZwGmfBH0/3cEwMSh0Zr4kpz5btJRLF55QO0J0BVU0VsRAukL8s+9j+wuleqFehmw+TFKsTTPbzy3CIJ3jSswKCw1uFRRixsOaS7XKS+iQt+MXWGQu8fZgYFLtHZ560iKc9NVYtK6Mz1ZWk/G4eSjtEVO4JqduaYn4lTXr6RuSjpYplGyFH18l2k9UOI5HEYLp7GzWIwvt3+NVQmPlGsNWsNlub3KXrvKTmifpvzzf0uAtTlRfr6kCdSZAOWW6fDP52vNGwY89d58twfBQsUF1AVbY+e3ydg0fBjXLYXcIviMUNck8cIif3ziMcd2lA5pglCkO7mGrA1KjkOx/mHG+LmtijNuQMO3omEozhTbhx0FDAGJhu3a14SnZ7yZjS+pqMhNUBgKxxos8BGaFkdKz9wchIsRRNMkji0gV3UhriwJW0iBbU0sPk1zkBREJhqFvBLi9MK7oZ8MuaV92et8pvyZT7JdhvLO1xPBDFOspCui3e2Oh41JCUUqKZe+cW2XDX2mo6rwqOzlsGUZvF8SakbsPrOpGcTB3TMsCx9ghOHuRMDadMdVpH/eHPLlhYEuggPI/cE97/Y3EeLow2tJ3D2Kh7dcfymgq+WESmNYaBnd/KmI8Cp7kISKHRatuiF9imiNBGZTKITkBoIbXipf+f/u5DH76D/u/Rl1KhkcFSbHtmpqzGoHYrvfmufLB04zp9Sn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDhUTjU5VlkrMVlWRWt5dUh3TFFpcHBVYncwWHhrQVVadU9TcFZ2U0hobks0?=
 =?utf-8?B?OWV1UDdYSVhCYUNSWE1IdkZMcTNCak1mVlExaFdwajNyVkx1SGw2WUoyb0Ex?=
 =?utf-8?B?L1Q4UUNkemhGblQxVzllTUs0M1R3T3lGcEZ6aGZtTW1tQitoMXdCdldZNW5o?=
 =?utf-8?B?UjUyU0o0dkFKM2ZTbGI3QmJ3Y04vYThGUWo3UERWdktOMktUNDZXaE1HNXFl?=
 =?utf-8?B?VjFWREtncDRDbVRqb0RxeVhIeHZJMkJrS01pdlNtSFVGb2RlbTRCS1kwLzhT?=
 =?utf-8?B?THJKZk9FUzQ2MWxsem9zZHVVUXF0djdjbDgvUkc0YlB3ajMyTTlRbWpnakNK?=
 =?utf-8?B?cVJkM1BOZ1RRY2VnOTJ2cHZvcnBBREV4aUJKcVdkTWJ2bnZmbkpwTklQMVov?=
 =?utf-8?B?UmVyem1NYisrdHNiQy9oN00ySWo3WExuNVZZVHZhMFBNUWgrWURZL0Q5bmhV?=
 =?utf-8?B?MVNmeUFMYXArRUtaK291RmpDZGl5OHcvNmZDSlczdmJ6aWZ2YXNYMHc3SzRY?=
 =?utf-8?B?cXNldExjQVpvVEdGTno0eC9vTExrR1lLdGwyTWowdDVrWTdZNFpvVkp2aTJ3?=
 =?utf-8?B?bTNPY2hGdVpWbXA5RFp3cUg3dE9vZUJ1MlRWcW5WUmdxVXQvMm9pd0pXd0tt?=
 =?utf-8?B?T3Evc0dDSFBoU1grbDBXUTVkYmpYL01hMktSUWdnYjV0UU1KUlF5eHFWNVFB?=
 =?utf-8?B?YklsNUQzb3ZQSWtZcGVmTmw3V3hDMWkzVmlXWkVRZ25qMy9jMHdRcjhVeDRw?=
 =?utf-8?B?TlhYM1JkMS9ldjlhRmdVdUlTNlNHU0tadDN4OEFObU9GWlZDK2JkTm8ya2hS?=
 =?utf-8?B?bVNkaC8vUFRIQmNraGpIZDJ4RlZxSzdSM0FFeEp1Q1VuaXZsVDdKNFBTTDBl?=
 =?utf-8?B?L2RuYkkzQWFad1B2d3d6YzIyekJ3QlQ2Y3ZkOG43c0p4NjA0V0h3cmZscGNm?=
 =?utf-8?B?Q3lzc3NOcEswVlgxaHd3dFlwS2k4V3RpSkd1eXRiNFRMVzJYNzhGelJCeUtQ?=
 =?utf-8?B?NHVDTThXbTlPRHE2SnZkM25BNnBkMFdGZjZ2RWEyaW85empDVDVxWlFnb3FX?=
 =?utf-8?B?Q2x3Y2lxZXp3dE5KcENhMnRvWnRUZHNENzdUaVV0T29JRzIzKzd1K3RxK0Vm?=
 =?utf-8?B?R3BVZ2dqYXQyZEZLU2lBbkQ2TjBpUnR5bkwreHMxS2FJUmQ2NkwzK1FDYm1a?=
 =?utf-8?B?b3ZObkIxNjRlNEE2NlZHQUluZ3A1VStaOVJLZFd5cTlKdlUvaDBtU0xJYUdK?=
 =?utf-8?B?VVZMaVM1WW9IYkFxazhHOW4wa3ZlSm9KTEVUVmhwQnBQOENkOUxkZG0xbjdN?=
 =?utf-8?B?dzVmNUVOTjhnd054MS9xTUpyYThiYXVmNnc1RVc1SHdKN3VTOFYyeXRLbFNp?=
 =?utf-8?B?ckYwdk4xcTlBUDlaSkppOWVCTTVsOTllcHBhT3kyNTBLdjJwWnpYNHJXSFJC?=
 =?utf-8?B?RWptSGUyb2g4eUZUcVRCQ3lEYmVXL3NkS1had21pYXJzcDVnQnJaMjFkdlgy?=
 =?utf-8?B?SnpxZy9HQ0t3WXBUWTQ0TWkzUTFkUWhTTjI0QUdFTkFqL2c2RzllNi9TR2xn?=
 =?utf-8?B?L0pDdEVFelJJZUIwNVdVV1laZURodXJtLytSNG1yQ3BNT29CL0JmQ05wd3Ur?=
 =?utf-8?B?a0pYSUVQKzk1U0Y3SERmdmcwUzRWbXhmS2ZyWm5UcWEvdWplcnhJN05CVEpD?=
 =?utf-8?B?b2R3cGhtUXB3bkhNODY0ZGpSNG5KRnQ4dmFXd1JoVERqRnU3aTBtV2RvMFpO?=
 =?utf-8?B?TlFwWHRINXRObTluMmhvSmt0QVFhaUtvZlVVaks3bEs2bzFqSWszcWFDZlRE?=
 =?utf-8?B?aE1VdDdLNDA2WEw2T255U0ZCbTZCVE9EWDV4NWtVLzhYZWlvbU1tUG1Ramoz?=
 =?utf-8?B?Y2dPRHA1NkN1MEpVNTFPUEY4WDcxTDV5S2daQWI2UW1obkdOMUdrSTAwamhw?=
 =?utf-8?B?WW9VN1p4QUEvYkhBeVUwZ2x1eFNaQzNVWFo3VWYrODRjMmpwYk1IS21xeGNL?=
 =?utf-8?B?YjA4ZTY5eC9CWERIRlNXemk5QzdNbGRkVUs4dVRGbFZKOStxQ3FhWjU4c0Vh?=
 =?utf-8?B?RzZNM0NjSldvamZDcTkyNStiQnZJTzErempvS1NaZXk1Sk1waUxGMU9QN09C?=
 =?utf-8?B?Z0c5czB3cDd0eWpaYjlqTXpKOUh5cnAwY2Q1SUJielpRK1JubDN6dTE5QWRK?=
 =?utf-8?B?YVZPY21JVlE2NlJpUDk3RXhqeVlYMS85NTRSbVpYQmkvSkM0QWUrbHJ0djZj?=
 =?utf-8?B?VWxCVkk1QkFRUU1KT1J2OCtmTlVUSHpIZk0wSVlkdW1oOWp0Ni9rQ2lQN2xW?=
 =?utf-8?B?MURXbEVNWmJncGZSMHZEc0thYkg5QkUxWmlCblJRdW1mY1FuODRjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e19c232-c2d0-4c9e-4f3f-08de91a0cdf7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 16:48:17.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdptLQsT2u2aZ7tvFA1nQaPmgrwej4fLB0SouBFSFFAumOwnoajJoPFjF+AiRNr8fZx1evLmyAKQ8Z6s+/WlGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

On 4/3/26 11:19 AM, Joyful Lee wrote:
> On Fri, Apr 3, 2026 at 10:25 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> That's really unfortunate to hear.  If I was in your shoes - If not
>> solved by the end of the return period I would return the machine and
>> purchase one from a vendor that has been testing, fixing BIOS issues and
>> supporting Linux.
>>
>> I'm not going to pick favorites, but Dell, Framework, HP, and Lenovo all
>> have offerings that they do this.
>>
>> By chance does the BIOS offer access to "AMD PBS" or "AMD CBS" menus?
>> If so, there may be an option nestled in there for dGPU D3 behavior.
> 
> I got it working. My kernel, which I build up from defconfig, was
> missing CONFIG_HOTPLUG_PCI_PCIE. It makes sense, but I wish there was
> more evidence that pointed me to this option. At least we can close the
> loop here in case anyone else runs into this problem. As a side benefit,
> enabling this option also got the dGPU to enter D3cold where before the
> lowest it would get is D3hot.
> 
> Thanks again,
> Joy

That's great news!  I'll add a check to flag this in amd-debug-tools too 
to help anyone else in the future.

Thanks,
