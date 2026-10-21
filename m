Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792590002;
	b=r0aCYhBVZG7BaWdPygA5NiBdHEBd5I0GZLnEDD92+iD8M08Y1+t9hF6e7LxP2RAZjwJV
	 HDS5GB9TbZqOcWQ5a1cv3tOzCu3ecpMcrr/Smv4c+/InMxbqt7MgscCCPi89JOQrvBjr6
	 HnBD7kCOjIO3kyvSlFvAg+AxeKzYW3alUQCMONE0NpBZQlQQmofxZLp68EOwrxCKmt3px
	 o4XfSiBEamzn4EEOy7OXj+uF44VjM/V0bYi8594WMhOGUuExZ/z+B1NKGtqaBpLaWvhZ6
	 i1BCDaiOonlnkDJ+x0veFPXhD2V05w/SOE/hBzq2k5dM+UdxAhAOKZqylP8O7BBIGiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590002;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/6FM7QolNfHrrPK8nvEjjXkbVjguY4vVbCJlAeDVT3Y=;
	b=yjLn2jaz0cfdcC/zwoD+yEXInDpLINWqHkh6KmJlKbvga1pVUkeSYE3PlLcVidaQSQvA
	 tOwQLQFdfBmk5cm2SskC8w8jWDJti4YA8pnnWG4Dg7yPKJCacm7sY+a4ST537/CIKu+0G
	 2flJ5G1lzWSKL935kQ2ylWJReVUn9obYVN3ZX+ENMQjm1v4mJc58u2rcWAVa0UVNXxnbw
	 bIlQYfF8i2FN6n3I3zHhEl3DLe6RsCgls71HCspgLzhccs6IcM9nRH0GZ6BVi8btCfcpt
	 qMDXeGqaEiegfe4UeBoC+7DYuRboMbDZCTd2tIZo3+wuWE/GJ4W91uXxd4HZIxLQwNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ao4L+vtX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.33
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A0606A319;
	Wed, 21 Oct 2026 13:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1A0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ao4L+vtX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivkUHr3ua/ao1WrUjTHl4MvCmh4eOthrSX5bUEpqxGSUpCuI657ZkQOagZc8p5Cld5SVznb8Y7znBsKvUTsOyft5W5EyN6e+xU/XOCVMKXdqDdH3ch10GBq5oS9WlTAjmjtYwn52QMYvBW6nZyabpLN11r8ed7zdEpMCk2wUDYwiIiyApRoG/ho6MP60Eg4zg/bNB5CbWMFodoVU9vPPCYX/lDmChFRA7GkDRyr9LfHTiljYUHRmMaMh2PILflnKxOvELrCBkoF0teXy16SJnwf4byW2CVRWEez3Gcb9RfyOtv1Q2DW90clBpX01sPT+36zVie/dVRgekGUos60+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6FM7QolNfHrrPK8nvEjjXkbVjguY4vVbCJlAeDVT3Y=;
 b=OlOl/e4sz9C18UriFzKsEcS5z1ZKARbxRF66ppgCeUFtQLUvx50Wli4Go0rVcWrAk/VAk1POfCUSl8NuJZeLjUaLuwCYPL2hTsoXLAX9HiK9WeDiANvL8RCegkDNdWHWFFAXBcD6PqM/n52yx5CcLnNCQCELVQGZyA7ZdwDxahXEpkyf31qnTRYc6MwF4vvsrj3s/WRwEjHB/3Kownl+AqYc7UIzupTp30ygBWyNQh8csTIZR5SVZ3fEhgggOOE6ct7YNrICpMJKPTKqdheklCbI0ZDIiqBjr6KNJqx9h5RmFy7Qq0ub9bs0j6l4kvwxTmAUwL0Mp7TsI+Fmkp8kNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6FM7QolNfHrrPK8nvEjjXkbVjguY4vVbCJlAeDVT3Y=;
 b=Ao4L+vtXvgQqwP56nB2RmcG9tmjebnXzrUhh0KYCYwYbc2bvmJ53AlBwEoPLrC0578zPjaxsn/b8qEP6OQnVvayMhlTA+SejZ9RnUE4xPvv+uznmgOZoHDnnuGALMDMzNqKY6ao8cjmFaoCtDFtSStu7S7Vmi9dMMTnavWP12C4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:39:54 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 13:39:54 +0000
Message-ID: <24cb6ea3-eaee-4682-afda-dabc7f347fc2@amd.com>
Date: Wed, 21 Oct 2026 08:39:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-acpi@vger.kernel.org
References: <20261013224010.GA1589480@bhelgaas>
 <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org>
 <b9f0ac77-079c-2383-a572-73ad649af0c8@linux.intel.com>
 <69e5be12-b107-bd7c-8cd0-1db29319bf6b@linux.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <69e5be12-b107-bd7c-8cd0-1db29319bf6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::8) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: b224ed41-f5a5-42ca-336f-08df2f78ca3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|4143699003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	M1ZNVVUIjRm81UZ5mCvw5qMHhRgb0PeP6ZK31E9UiX+KB37MPA3MlnDfLowWF+Rd+eH8ukTo0kTugcr7ATXkLoFuiBxH69Fypi7nhkgNHXTzv9ECI0yF8HethG4exb+mSTiOe2VmgVEnzWtYrk5SyGuNUNWoqeDvy+fN/L18lu9qYPHCUqyWok8qsQYfRjM1GVq791FPKJb0+u+bMOq7ZVTSZtUCNivcVCbqdNoeW2bMUz+rD4sRcw7zEcpARQ4+tA48fDiPapTutNdNS4CyEe6k4GAu+RqairDB1hirvQLNiXZqNcdBQsVgURezVeHk6O6C1Af/tTP/y1jbWi1DHYyRWu9HzY2HTLTnXPW+lfOFP6l2NuBzjLelPFu7Pgu8xau+d3u350roUwo7RjXx716xLcjDFitImW3ToakZbJo+ipsjas0GAT70KgUx14kiuV1jqwhq0RgJCg6g4kz4SJZbJD7QoAQBpYPlXjaiMSbzsOBJGw4qj+Kd4390pJkRdEqImZ8u8jDNYFjdcfhxJ9KngiK5sOSOF4WxzwJG/41yTX/Ju4e1h5kDwS9hwqyxxHq7mDJ7IgpLaaiCYQgWWZDE1yc6v/1dbrwXpozHaA3TnYa6+aiRB36jJZc8sjrq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnU2dnY4Rlo5M1Vlc0pPZjRnMXQxZzJXR1h1TW5BTng5ZnV2U1R6UUZncllh?=
 =?utf-8?B?TGExVnVmdnVzalJVVzdJblRkQzNoeThxS2lzNjBreEliNjlIKzNQbGNGSUJQ?=
 =?utf-8?B?M1VzMVBOcXlIbmx3SDRvaHFvSmJzNTliblBJTDRCNndNbFVrQk9LTC9xQ3ZT?=
 =?utf-8?B?YnF1c3gzQmczUWwrRmg2N1FTVERkeWwzTmxJeDU5QXJDbEJUelhjb0ExVnpv?=
 =?utf-8?B?N0dlL3VPZXF3ZkZiS3J1V2RDaDRWN3U5dENGblA3eVRoVHdJVWVHeFJGMVdF?=
 =?utf-8?B?NVg5YXJTSWxXMEs0akpQSGs2K08vRFd2WjFRRHh0a3FBb3hpN2RrUmtpNVlv?=
 =?utf-8?B?SGZPRVA5bldzYW9LNE5MK2pjUHMyN2IyWkRTYytVdnlRdno2SWtNd1dKR0ph?=
 =?utf-8?B?M3JqUmFsN3NMWlByRktKeWxLL2tJc3dTYnNkb2dOS2M5R1VkbTMvVmwrM3BQ?=
 =?utf-8?B?bHRIbkxFNkk2OHFrd1ErNlR4R0ZXWENLUUFNTXB3TkZTcnBTM2hIMVM0SVVz?=
 =?utf-8?B?OURWYlRtU1psNzlUdE5hMU1OUEZ1TGJIQVl4akxLSTFzUVNJcFFHVnIrK0pz?=
 =?utf-8?B?am9qeWR0Nm43bEtya09rRTJvWkNnRHp3QjdieFhMd003TGJrcDZ2aFVyT3dW?=
 =?utf-8?B?SFhGTTI0b1NZekRyZUdNNWVUMnZRYWthOXNuK0d0VHF6TjhYdUN2THI3ZXVC?=
 =?utf-8?B?SngxZlhDd2pSN09ObGNSTUh2QURXb2NMcEg0TEV6cmZEUWNKSThadUpKcHlF?=
 =?utf-8?B?NzVKWlNrTHhibEhhVkZXMEh0L0FvakNDMHJTajNNZll0WDhqaFNXdFhZYjg0?=
 =?utf-8?B?L1orQkJZUzk4TGtsZ3ZxRFJBZFVTb2FwV1hJUmJsNFJiQXRQdjF4VWE4ZnNu?=
 =?utf-8?B?WVBxRUFXNHlkckpNbTAxQ1ZWdEZHK1hydGRoeS9TYnJWSmpsTWdIM3p5dWty?=
 =?utf-8?B?aGtmWUdpSCtYY2hSRU41amtWZ2VaQnZJTmliSWVjZDQyd25CNWFoRkdjMm1T?=
 =?utf-8?B?dHdRcG9WWTlWQjlzcHhwZkdua3EraWcwUHpTK1NWdXZwZVpOSmgrQlFBTFJh?=
 =?utf-8?B?ZE93S3ZqY0VLUktiSENVQVJDekxvU2hXNnU2ZGx4bTcwbE1ORjRpQ0VlUmFp?=
 =?utf-8?B?eUZURkh5V1JMZTBsWHFhYm9vZmNvSjhLY3NhNmM4c00xZ2lDaDVEUEk1N2Uw?=
 =?utf-8?B?M2JDOGZkM1pBaVFmMzhOSlVXK0FaYW9KWllScTRYSi9obHB4cmYwek1LTXlB?=
 =?utf-8?B?Y3ZMZENDbEZNNGxYN2dCdXl0V1FSVGFUNWRHTVNkbURGTkFkbzdzQVpWcXlF?=
 =?utf-8?B?MENFbFdXZ3dHWTJ1dU5xS0JmYjh4eUhNcDlTc000enRYWXZ3dWRsVXlQditN?=
 =?utf-8?B?dGJqajJ0aWFlYnJLNlZVdzVyeFRSQUp5SjMvUGQ3WEJIUFptS1c5SEI5eW53?=
 =?utf-8?B?cGkyWjZURkZxNFNOUkdMZ0JobktVaEltS3hQL1BWWUl4elZoREtlN0xqQ3di?=
 =?utf-8?B?OUpsRnRQUnFzb1B2bTNBU2ZIckVWQ2ZBaGx1TVVmYkk4Y0RNb3pxNXlwYUlq?=
 =?utf-8?B?TjVXTWlLOCtrSFF2YURLY2tHaXl0RlJtUUQ2MlpaM0hmbDg3VHRjdEJUQytn?=
 =?utf-8?B?Tk5NMDFGOTFOOTliWStnaWhiQXFMYkNlSjdxeUJqS0p0bUp0ZDNjZG1Nekgx?=
 =?utf-8?B?ZmFTQVI0bkRnYlhyWVFEaEthYzBSclNCaEZob043ZUVsZS9ZUUMwM1BQQ2lp?=
 =?utf-8?B?cUZCM1lQUDlwakxXdmpoZm9xTFlWZEMrbmxxenFrc0NhZXZUNG9penBTTjRR?=
 =?utf-8?B?TEZmV3ROWEhsRUMvWmRkT05mMlZmRzVsUFN3bDROMVN3V3Vqd2x1L0N1NnhJ?=
 =?utf-8?B?RVZ4aVg4SW5KUnpPYjBYeXAyTUExRWs4WStRai9DbHg2N1NkS3FiTDlnUWty?=
 =?utf-8?B?bUFtdStab2pDRjl3WkE3TnNTaHJ5MEc2a3JOaTRDeXE1M2QrWXZYS1FYU0tq?=
 =?utf-8?B?UjF2SmdHSzlBNTVtZUlBUDh4WTYvUzlNdlRYYnYzZ2M0a0ZTZEdNSW56eHlX?=
 =?utf-8?B?M3BSeFMrNVArV29YcUw1SW83L0w2UllLSnErUnhRdFp2d2dFeFlMZkJIR3Rj?=
 =?utf-8?B?c1RDRlZVaXdNbWRsL04xMHpiT2JHc1Z3RHpRQ1hBUEs4SUtsM2hidGNFZzRt?=
 =?utf-8?B?WmRmeEhvLy9pRzFDa3FYV3RRZUJqOERPaVl6a05kRmcxQ2VIdnlhU0V5SnVF?=
 =?utf-8?B?dzAyZVVicktlRzIvZXpTb3IxVndpbjdTaCtvRHVUUXYwd1R3UHluM1oyc1FD?=
 =?utf-8?Q?vTeK40CMVDTPwzsipY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b224ed41-f5a5-42ca-336f-08df2f78ca3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:39:54.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9VvBDIOpcSiue+0c1GuTYndjKo+qZqmnsSN5sYfV8pPuZiLF2vFTD8mVd5B65yPTbj6kVPFes0IyADLwd5xxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776



On 10/21/26 07:56, Ilpo Järvinen wrote:
> Hi all,
> 
> I've sent v4 of this series to address a few comments sashiko had for
> b3 [1]. v4 does not contain my version of the quirk as it seemed least
> likely to be selected among the proposed solutions and the decision is
> largely independent from rest of the resource placement series.
> 
> [1] https://lore.kernel.org/linux-pci/20261021124956.4250-1-ilpo.jarvinen@linux.intel.com/
> 

 From your perspective is v4 applied on top of 7.3 a good test for 
people?  I'm unsure how closely it relies on pci.git/next.

It all cleanly applies and builds (result here):

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/genoa-mess 


If that's a good test in your view I'm fine starting up a thread with 
all the previous folks complaining to get testing of your changes with 
the revert and quirks.

If you think it's too dependent on pci.git/next we can wait until 
7.4-rc1 to start this thread.
