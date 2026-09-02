Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89230649C
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315673; cv=fail; b=EvR0cLTMoBPA/6p7ak74YPOiRpe3aiIIad7gFNTkyWdgcB2UOXAz1AaBlagCu36/BVPOtDDtV54AVnEUlBW4wG9rHCiLRoDMlOp8qgDH/IuvstQo7DzzcfL/nQiIZzk9HE4Ge/M5hb+JHbe6P1j96Cm6kBlXkPl2ph/qRAc4yrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315673; c=relaxed/simple;
	bh=bC2QwGLLyDhx++DktdR4ykD40Q2lHEQqPvgjmlOCKbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U65O6AuAf9lGj/GTMH0HPTkTl60lKwG8PEM/ETAxGlx5IgZbbQnHeTjbG8+/M2xUBNqaSRgutwI75WWxbrRBD8jnOkVW8ii2ax6ZGCuCDvBg/6qY9B5Cp8hJDHyb5J7RH1DKtzvkkAbcwDtfcRLqMbaj3R9+v+fxpCQd4kJhEhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5AIYXNW2; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5AIYXNW2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmU9tv9rVjYnLCNpXjzzXFUhTyoU1+/hdkamZSfRdgkyBiaTzHfB6BdGZwJ7XMvwOPuXHHXC5cWNVYDvww2+maVlrQi6P6TJ9iFCKCcAwThVU7fzcUzhtca9nZdpJ4emozHoMchR1Z/uJqwzng48KChAk5ALezvvpE2B5w1pvwa1b0HRVS5PD+G6rk8NyQzDFi0S6RYghwQ1iwPHsmfLbmy5zvcJl/A7A6VGxmOfUPuqAH3wi+i5ymWRnCdbZe9Xh+OtJAZPo61gDhbReNnFoEzCOFqVbPGWjDhacBP6P+msjewHdACgQ5QrH8G30qeM0K04UOgrttD3Ay0UnvZdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrfbk9SDAqm4Y2pkC0W3w6FfDlqzlB8wHe4nyN5xpKg=;
 b=NcAB1dNM0ULaE+fgHJEj3DRo+C9lxbW4uFm7xZDrnkrtJjUYBAIed8uxt8L3jUFFxLiHMVKKbUf8EoEO13ZaJMRlaNRuFjtv59lLbU5tPci32IrwUarzECVQo6l3EIC2J5fVHI3aQ5HK3Nz1zoqQTH3qPtsP3xbNeHI4XdvacFOAj/nlP08ufC0q8pJvjk2TPL+u0JfTifzrmLkZ0duFu1iKYlQ8URZSe57Aprbdfl+dolv244TWkNqazCG+RI0qWSBSG7F/qVr/jpkbneOJtCGd/h3tDGogOCJTPVJZ2FYSOZz/acT7No1dVQMYjiCTqZsth1PLzb9TeXdegEGblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrfbk9SDAqm4Y2pkC0W3w6FfDlqzlB8wHe4nyN5xpKg=;
 b=5AIYXNW2srFE7+ysMHHAsjTQeIIDmSQ6ys3e6GwmCi50uZ/bKOp3GeBS4vUn7M/eBnbJeuioDKDYFh/nRP17m3i8gTi2cBKf+3qe36pUXzqaWBpgceyN0f8+sLg3zEjsFODDdoMaW8qvJDDVfPbu5VlyJYU2F5yNayaXXzHSCt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by MN0PR12MB6368.namprd12.prod.outlook.com
 (2603:10b6:208:3d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:21:02 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:21:02 +0000
Message-ID: <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
Date: Wed, 2 Sep 2026 12:20:51 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 ankita@nvidia.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sami Tolvanen <samitolvanen@google.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Saravana Kannan <saravanak@google.com>,
 Will Deacon <will@kernel.org>, "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
 rick.p.edgecombe@intel.com, yilun.xu@intel.com,
 Ankit Agrawal <ankita@nvidia.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050> <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY8P282CA0022.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::21) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fef1839-d8ee-4b61-9240-08df0898d578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|4143699003|11063799006|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1SV3WEciVcjaZ445D0kg1JoV6J0pTc17J9rXZvuJGY3h0FTbl/QZ8vvnQP074ck+D4QLFM9zP1W+YCr2Ub4E33E4PtZxdC0Giml9ymEVm6lAk9LMjRBIw/IpfWlSN9Ji7eNQDr69ZJwAWzyeHsi3zLnEKoLTyCumSoBD4BmzBbEASWw/i0uC1v7UzAQMn3zxJcaC9k06+22dqfvAHMynZbTKNgID/ZsrYrIgkJaUGJBPAq4wZrQKmoujQIpPGtxOku2T7EYjDYHt03LkdrCdMXHma8hyYwhE0DkcUqlJ0mBzklXpnVz88A6VgSHIuU2dgzSb7CYyC0YMrgS37F+20afUxZYoQF+F6HKJF11QJdR8cimRa56cEE9Fm2Em0j5VKpx58Yc+/CwK0Xm6PrFib0Cx/badHk4GnWhMuExoYx1JjhATfwqEJ+NuknZARMu0rWKUrcnd1hDw28CHsXqa1EtaUBkBJMTU7XLtDEr2hYAzRV1X+XSErQdvb+NjALcHtueG0C2++uRIG0dQrvkVsuS/3DSE3WyDgj71XE79cQLK8ymtktpm2+y+i1Hz9ah2NXSGFM18cmEgD/JlRNhJSBD6Gm/nEi1ZpnmyiW34E+Ls104EruLQUaZPlK5uUou5wUemj1KZ/w2gv9EHSUgrmRttNTvFfd6CimE4qT4FlH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRlZUpnZTNwcWxvU2szWkxxL3FDVUQ0UEhHVVlOdUdOdkxDeVZGUTdOdjE2?=
 =?utf-8?B?NFo2djRLZHkzTm9JdVZLMkJkYzB0clIrK29zc0xXM21BeUpnMmY1N2pyTjBi?=
 =?utf-8?B?MVFpdUYzRFZzVGF4QzZHWkNtQmpUbEJNVTBmeDU1T1V3TEJtZmlveHF0QmxI?=
 =?utf-8?B?bHhRMzRvRXAwa24rWThna0t2Mkpadi84bWU5SUtJamZjUFhMQjNiZFFrbHk3?=
 =?utf-8?B?SEFlTVFyUlBwMXBvYk0xelY4SEZXZTYrWS96VnozZVV4bEYyRFEwY2dJcFUx?=
 =?utf-8?B?VjM4TEdjMXJIOG9CYkk2d1dRK25tdktUWnQ3aExtbXhoK1hmQjZydkc2ZlJj?=
 =?utf-8?B?N2cydU1oQjNKcmw1QmVjZnI1QWdGbEcyWGs4MVlCeTZidndMRmRXTHB3dk9M?=
 =?utf-8?B?dmZVZWVMWGQvb2xEeDh1eVgzWEt1TzVRVHNZNWZieEJJNFRXK0NkRnZabVBn?=
 =?utf-8?B?R0tUTURIK1hUTE8wbTFvcFpSVGU1KzRxbkNicWwwZVFJdS9lNDBjMW9UVUl0?=
 =?utf-8?B?bzNzNjlYNXd4NnMxWk9ERjFZbHVBM0YvdXN0UTFIeFdwdFltMXUvdFMxV08y?=
 =?utf-8?B?Zys0U25UMTN1UUY2SU1oUEFMSHZrNzdJWDdGa3BaRy9uUUV3RzU5ZHVBTFhR?=
 =?utf-8?B?a0RVR1YrQ0JJclRYd3JIeEFXWGxicmc1RlVBR0lNRWNPVkVWVGVkOTd5SGlI?=
 =?utf-8?B?K3ErRFhsK1Z3b0ZCSWhSM2ZYajRtTnMwS25Sekw1RlBTNnhDZG5yU2ZwY0JD?=
 =?utf-8?B?YksyY0gxb04rby8xS3A3cUUzaWcyRmpZSlVxTTM5UDVyamhlTFZWUUM5UkxV?=
 =?utf-8?B?Ym9vVys5dXpHQVhXMExXSnc0a3Vrek5IMEM4RTI3YXNVY1JnYVlIbHRTZzFK?=
 =?utf-8?B?VjVmaTJ0N0J0M1Y0YU5rUEJVd1kyZGszWitkYlpmd3VPQnRQQk8yVWNWVlk1?=
 =?utf-8?B?RFR6NmlMVDBCd2FXNms4VjRRMFRXV092V2RoZGNvVWRIWVVWZ3haTmtzcUgy?=
 =?utf-8?B?b0l4STlySW9pUFJmNzVWZHhDT3FCcnpyS08vLzN2L2ZTeUZZY29ENjNxK3Nt?=
 =?utf-8?B?dUdzTEhEQ2FjQTl4dUVSQ0hxc2dYZGNNZmQ4dUpaaUUzYmVHUFFVMWh2SGhu?=
 =?utf-8?B?bFhhWEFneUxHZEszNUF6Z3Q5NGk5d1FpNTVNQ3dya1VOdlg2VUQvWktHb2g4?=
 =?utf-8?B?Vy9hbGtyU3R1aEZkb0FiZUFnQ0phbk85RDZwYWpxUFV5V1JtdlZmb2hBcmkw?=
 =?utf-8?B?TW5ya3NyNDNyNXdKR0xDMXl5U09rV3lwRmpkNmUyamw0R2lNWWpkaUh0L2JS?=
 =?utf-8?B?QkRKZU9aMmdPOEpsMFVLYk81NVFtWVhkRVpEbFBaaHMwQm9QaHdoMEhJSDRQ?=
 =?utf-8?B?N3VXVU1iTHIrQUpLMVlhd251amMwZjJtSllNVU9PM0pVRUZzbFMrOHFTblhT?=
 =?utf-8?B?ZTRlZFkyUWRFM2NQVVpnZHV2b0t6TlFzekpxSHlVSGwwU1R3VmpycmdlS01G?=
 =?utf-8?B?ZEN6NThlaktFSTZQTEs1ektEQ1BrZGFMMHhrZjNGeHJjSlRIaGV6RVBzOFgz?=
 =?utf-8?B?L1Bkbml5T2xjcWZMNXRheUFhUWRuRVBSWjhVUXJObElFWnh5YmhQdDkzNW5j?=
 =?utf-8?B?R2N3Z3g3bXdqMTFTS1hab000WmVsa25nenRmOGJ4bzRmV1gwSGhtbWlYRTQy?=
 =?utf-8?B?OE9nS1YzR25SOFhMK3N0SzNwdWNxVE9DTDJ1bXFrZlR2SlJsb2l5U2hLUU5n?=
 =?utf-8?B?MlhDY3k1ZXFpUXlXVGx5Sm9Na1lKRWRTaFhYeGVRUFJNbmszUThSL1hOWU5F?=
 =?utf-8?B?TWp1STVmSGtMTmVnMEhHR2Vhd3pCQWlmOTU1WUlrN243dTYwM1BzSlcrYWts?=
 =?utf-8?B?ME94aHpiL210VVJpQWpJMXR0cXp0Qis4eVVxd0lXWjN2N3FoR0RIdFEwd09l?=
 =?utf-8?B?VjdCZUFpcGxucTZrdnZaazlsSFRiVDVRWkNlY2hBQmZEVTVoRWRpTTBGRkdv?=
 =?utf-8?B?a2tJcWVqQ0hMT0U2bWFkM3VDbVBBbU5QTm5xSlM2b0ttSUVpZVJmNEJabTBC?=
 =?utf-8?B?dHlWeHdYNXlIVVRoaHdablRHdmxqaHF3ZjFaemlVZDhqN1orOE83NzY0a09k?=
 =?utf-8?B?b3RQRWY4T20vdFlFR0t6QWcvbEk4dFJBdkFSUTFVZ1BTek5yVmVpRDdBZHZh?=
 =?utf-8?B?VU02cXFqMDNvOHZ5amZRb3lvcmtFRDN2dkxETllwb1hsN1IzYUlGK0NiQ2Ny?=
 =?utf-8?B?Q2p2aE9TU0pIUkNScnJTRHFGU01tTmdvN3B0UGljYWtHSHg5QnB1c0JFQUhY?=
 =?utf-8?B?TzRWUFVRRG9hN2t2NTRWbzJhUmxnLzdQRlhYWElUN2VNdDlzbndEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef1839-d8ee-4b61-9240-08df0898d578
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:21:02.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THOx9USPLqICUpCHhdNnf7Zw1rsqHFRyRgfPTpbo7ErAKJBHH6EzYYlTXlDJM4Y7y9BS7nkSDCt/i2YXI5Kr3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368



On 2/9/26 12:12, Xu Yilun wrote:
> On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
>> On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
>>
>>> Glad to see you all here to make progress! Intel can also help on this.
>>> Can we have a meeting to discuss on these topics? As Alexey mentioned,
>>> previously we had a bi-weekly call, perhaps use that for our first
>>> meeting? Or what time works best for everyone?
>>
>> I prefer we defer such community discussions till September, that
>> seems appropriate given some dates I've seen.
> 
> Hi Ankit & Jason,
> 
> Do we have a plan to schedule a meeting to discuss next steps?
> 
> If so, we can figure out a specific time on the Discord channel.
> https://discord.gg/KKqC438c


So I've been trying to find a time slot. Say, keep it on Thursdays (USA) (kinda short notice), bi-weekly, we can do:

Scenario A:
Seattle (PDT, UTC-7)		07:00 – 08:00	Day 1
Atlantic Time (ADT, UTC-3)	11:00 – 12:00	Day 1
Berlin (CEST, UTC+2)		16:00 – 17:00	Day 1
India (IST, UTC+5:30)		19:30 – 20:30	Day 1
China (CST, UTC+8)		22:00 – 23:00	Day 1
Sydney (AEST, UTC+10)		00:00 – 01:00	Day 2 (I can do it once in 2 weeks)

Scenario B:
Seattle (PDT, UTC-7)		18:00 – 19:00	Day 1
Atlantic Time (ADT, UTC-3)	22:00 – 23:00	Day 1
Berlin (CEST, UTC+2)		03:00 – 04:00	Day 2
India (IST, UTC+5:30)		06:30 – 07:30	Day 2
China (CST, UTC+8)		09:00 – 10:00	Day 2
Sydney (AEST, UTC+10)		11:00 – 12:00	Day 2

Scenario C (which is the current schedule):
Seattle (PDT, UTC-7)		20:00 – 21:00	Thursday, Sep 3
Atlantic Time Zone (ADT, UTC-3)	00:00 – 01:00	Friday, Sep 4
Berlin (CEST, UTC+2)		05:00 – 06:00	Day 2
India (IST, UTC+5:30)		08:30 – 09:30	Friday, Sep 4
China (CST, UTC+8)		11:00 – 12:00	Friday, Sep 4
Sydney (AEST, UTC+10)		13:00 – 14:00	Friday, Sep 4

The link is:
https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be

but if we want to change the time - who do we contact? Or set up a new call (again, how)?

Please, comment. I find these calls pretty productive syncups. So far we were not having Europe in these calls.

Alternatively, wait until the LPC in a month but I suspect not everybody is going to be there.

-- 
Alexey

