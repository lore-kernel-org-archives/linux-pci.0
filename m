Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590012147E6;
	Mon,  2 Feb 2026 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770006895; cv=fail; b=N0RxQXDnIoXzGPvaQSNWpD+ljOP/j9mtqCql/c8YqttQ1KBwXjlFZEVMUF85ON0Oqyu9jhNddYuHqc1k/Lo+ftfvXfVYDbZ8qAL69EbD4yg5jeOh0/6LXTTA1k8RLFQlSN94+LhTgKfMgzB5hvQwJzFmliLYMXKubIXBSeEX/bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770006895; c=relaxed/simple;
	bh=6t/eQUay1NDmODzJA9gFkGK0kLigPkGoHZy8b3LfLWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dulPw+WI1jAUCff+GyIBEosjgISXYJWIsbtYtCtGizBqiL/6CV14u2/y3wGV+ksIgqa++R3HZTJZC7bzBCzH4z7L9DhBwMmIl/VC37DAHRowpUATevBOPER9IS6vhR9bXkoUbUAYBocZLYD9n2EJPkA9Z7/D5M8kcMaRnLIcDac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAbMN56m; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAbMN56m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDmbhnE05noPX5kUOdzCLyhwLaHpCflZoUlWcQ0zSnc+BIQFwd8d7j1QGUCIS3BVM+W/IOi+ZsMAGx152dqzNR9exv26PcM2BCtLTeUMJFj4w9VZTbmFORQjDkFhvXMSB/KOTYws/6p0GRdanBNXHFy8kv9ofRQVn7VT7MUFqj26EvoeZdDm9eajw/6FRtWJAWpalo8uKYlNlQHo/k1EZ3t68DoTDeZbrr2221+JYNbJI9gB+r57h+BibXePxNx+NaaC5L0iiGH+iCg9zlYWsUxDmzW8Dic3Jp9vpjUxBqxsmYED/fkRBNnomj3kBpaVBNvomi8opJC323BhNdD9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc+JChuMWNKwbCzSNPfPXnMYGttRNOsBP0uNWgKQFqg=;
 b=IAdSNLTsur95E4yNW2+28a266lLYSWRYO5PloiS4yq98aFYuvrwAEDx3nm3cS00JgmnUiQY98Rr8fOo5Yl2pyS5k16XsIfWQ4J3Uj4ujr5lye+sHgJDxfA34AUJfboVcnJH2OtrR1Zri4wSqTL6oFeoi2SNfjCTDkv52a2ustzVE+Ndzxe64s2/oYIz4YTysKDHmpSzNBt1Q+pIH+3sYdCofcNKbMU3Jbtcn+SFzjJcHAyKpS5ZmWKZSzsrTq8Riiz+NcdsE5bt9F+LrlnkofOwDQRy7QVGQw5K26SepiSr+siLmWjWuW4k3KUxQlh33/lhrAB/BrS3PiuqdlcIosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc+JChuMWNKwbCzSNPfPXnMYGttRNOsBP0uNWgKQFqg=;
 b=HAbMN56mggmv6rnJ0ubQ6soMs4AuwS5jOzmrQ1MylhejiN8PxuLfLaEwApy/asgfKKSTJX5oaJvYR3aMMJaKo5BMJZkuelioKGN+EsTMihbLF/S+gmYenm24Tm/g0EjMg+lKI4ZOlX8Y0BH3aX4D+POPqOGWb8EQcQvL21RBAQBUDXveg84tgFLibe4qiXULBz+Wju9meqXYqAs0FZw1/pS1tkS+cgfz7xDkQvB7MU++XX6H1v9jeO8ibW56XGN0rxT1VEsmn+JIx7vawvTNeqBAFnPJ6/pEvbhquPegN5gWgpFjYPzB+dxBEqTXVJiWoz7lheXHJ2dnBqj/uvERrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 04:34:47 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 04:34:47 +0000
Message-ID: <591a5dbf-323d-494e-8f21-c2814a9880cd@nvidia.com>
Date: Mon, 2 Feb 2026 10:04:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/22] dt-bindings: PCI: tegra194: Add monitor clock
 support
To: Rob Herring <robh@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-18-mmaddireddy@nvidia.com>
 <20260129164000.GA1237815-robh@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: nvpublic
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260129164000.GA1237815-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 2776df9d-c52b-47f1-44ce-08de621464fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0pJbVZ5cjk2M3lFMy9MUTJsaDQrL0dwdlpqajAxbGdDdURqditoNXZCQTY3?=
 =?utf-8?B?MEl4T0kza1Z6SDJSMUxTcUlRb3BNMm9zR2RPZzR2RGJlOUprbWtxUVdvZTFm?=
 =?utf-8?B?QmdNbzR1alFiUGJEcXdhbjltdzZXQU8vcWx6MFppTlo3YUloMlFBRlp5UTJa?=
 =?utf-8?B?TFFJcGNRRmpOTnUwVW9hV0luNWJuSlI1R2hJV3FpNTU2S0lWTTZiVzNRMXc4?=
 =?utf-8?B?ZlBZUTRrbmpZZC9rRzdWM2tQNWJ5OHluQXBDY2trNXFPRE12NnZLQmxkSTZa?=
 =?utf-8?B?Ry82dWNMWFFmNjdpN3FkU3hlRi90ODg2L3VTNGsvL2sxcjgzcDljN2piMUt0?=
 =?utf-8?B?VkVUaW1BVWdWb3FtYjM4UHVxZGwzZHNSMXhJRS9EaWd3ZjBUbjlVTWR4QzNi?=
 =?utf-8?B?bVBDTHlyOFdsZEhvRVZsLzRxcVNrbGh3S2kvUE1BZGxSdStnYkVGU0h0TU92?=
 =?utf-8?B?NWNJMlpJQWJhaVk3K2JiK05wVnBjSjd0R1lRVHNndFArVDE0RTBrR3RHemth?=
 =?utf-8?B?ZlJpUVV0ZmI1L1hFOVZUZ1BOK0REZHl2SFNXSHpFZWZyYitIdDJJUTk0WkRm?=
 =?utf-8?B?TjMxcDdyY09XVlNHQVZLcThwSDVTQWhrM0s3bDFKT1RpYnhhU0xxakVxYVB4?=
 =?utf-8?B?SHpCYnNRQ0I3QmZKTC9mTW95MHhsT1JFOHFSMlpxWUJKN29PTWxqdmRzN1pD?=
 =?utf-8?B?eXB3eEZ0d3NUS0xOVEJSaG81MzlqblRkYlB4K0s1UnJDaW5MRmd2ZzZVV245?=
 =?utf-8?B?cEVDUG9CRGV0SVNZcFhhTi9YT0NNdk9jakl3MHZYY0t4OXcyQ0ZYMkE0NUpu?=
 =?utf-8?B?UGJ3SW1kOHRMWmVCeVd3aDQ2MURtUFA4SmVyL0I3UWV5Z1pTNTlEcWk2dkw2?=
 =?utf-8?B?Rm5wRG5TMzFKdDFiRnBwTVZkYXA3d1BwbVBXazlXTHREZnhqZTg3RGNyN01J?=
 =?utf-8?B?bm4zUVJ2WXlPUTlEckFnZFAwaW53ZU9nQm5TOGdNMmpuVWVJKzRIYUdDcHVW?=
 =?utf-8?B?YkdNamNaMlBqT2ZDeHFvcjg4RjUxS2dmMXUvbGdjVTJ0VWJnQjRhMnlTVzh5?=
 =?utf-8?B?dnZIWjVaeC8xZkVkNUdZcFJ3MzQ5Nlp5VXo4QlByTHpEMHM1U1FoMGNRVnE1?=
 =?utf-8?B?a1gxWForMkRTeXpoTUxDY1BtY3g2RHhaWFpjUndJVDh4d2tEVlZ3SFZ4M0FF?=
 =?utf-8?B?Rm5NK1hYZ054NlV4VGd5WmJCd00vUUlpblhzajZFVldDQTFxVUJXelAwOFo1?=
 =?utf-8?B?Unc4eXRoVUIrKys2Vkd6YU02d3FZbXRWc1BCNndpV3pqMDZOdDJrKys5MDZs?=
 =?utf-8?B?S21KMGxZNW8zdXpKUnhrWmt3a1l4RnlZK0pjQ2hoc01ob2dpUDJFY2xMdk55?=
 =?utf-8?B?L0tnTDNKV0xQRlppTkszYUREakUzankzSWdxNytSQmw4VUpJMjlweHh0dmdJ?=
 =?utf-8?B?V2NDOGtTcmM0OVN3N1ZnVWwyWDJjN2VZM1lmN3J2S0FWRDdtRGlJM2xPdDI0?=
 =?utf-8?B?cUhWVVR2Rm1lRTlKbzRkZFBUb215K1ZsZS94TzRhZG1WMHViUmpKY3k5U0ZR?=
 =?utf-8?B?NHFaL1RXY0JTbFFMZEhQdVFqTkdwdUVmQzIxc1kzWDFncFVsYVg1c3hlckZS?=
 =?utf-8?B?emlKRjNuaTNOVGJ4ZVgyZnhsUnRWMDBjR2tJWkFpdUUrUlhPTjBtTjdDWjVL?=
 =?utf-8?B?Z0ZTTExHdkZsN2VFdHE5Y3d1cDJDbm9ueFBlc2x1bC8zNU5lSzRlRVErZDJR?=
 =?utf-8?B?ek1Vbld3TnNmNG4zRWREVURqcm8yK1pFdFNkcjE4dXdCaURmcWdYU2RVYXpP?=
 =?utf-8?B?d0hzNjFqOGl5VFFsSFlQU01uTWVEVE9DdGNrMGxObTllZEF0clVhZ2ZNdm9h?=
 =?utf-8?B?YjlyVDk5aUg0ZjlEbVpQd0N4aVRZZHpqMkJ0bVgydzcwVTJXbm11Q1BDRFhx?=
 =?utf-8?B?UlZ3TlNNNnB1dFpwdVBXZExCQ0Ryd3N2SXZ4dmI5cjFpcHZmVGswWUxWcGR4?=
 =?utf-8?B?TE1LL0QvYnZmbEVGSk52ZHg1TzM5ekFlaFFka21sSDYxb2dHWWdNVWIrVmNN?=
 =?utf-8?B?Znp5OVRoQ2JGOXA2QVhweFA5VncrRzFhWVJZYitINjQxS25KY2RjNlFmZ2pW?=
 =?utf-8?Q?vogM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJKeHhUTGJEYW9PODRDYU1iN0RPQjFTbEIyMVkvUUlDYStYOHcwNys0TVFH?=
 =?utf-8?B?bG9oVVJvNHc3QmVWNSs4MytNS09ieXQvWFlDUFJTMjdEaTIzaE83dmtQdC9O?=
 =?utf-8?B?R0ZjWXlhU0hJb0Q4ZVpTSFd1bmNXMHNXTVVmWEZWQTNteW1KRXl6c2gzdDBI?=
 =?utf-8?B?ajIwQVZTdVhhK1hDREtVbVFiN1dwRURUS1drb0JKNG52WjZtR2pEU1VRTTVF?=
 =?utf-8?B?V0gvb1V1Q2lnOUZNcy81SG03ZUNsbUk4SHMrWHd3anAycWdMQkx2T0FOeXJU?=
 =?utf-8?B?emtUTW9DS0ZwbE5CQW5XQlI5VUxuUWdWTlkrRlk4ODNuU1cwUGNaNjR1SThG?=
 =?utf-8?B?OVdjd3hieVBKSm1UTnZMSEF4RmZJVnBiM3pRTzVsQ3hQMy85MGhKYU9YNHB6?=
 =?utf-8?B?MnYxQ2IxOGVidExCb09hZzRxSjdnRWJVRTh0S1lTbjA3OEVzOUZyRElVMStu?=
 =?utf-8?B?Vnkvcm0vdFF5bE1hdjVqMzBRZXdrdXZ4UDdIY292dlNZUW8wTWdzMkE0Tzhy?=
 =?utf-8?B?d3NQbzRlRWEweFIvYkRPd2UzTmc0ZThNc0FTMWphRVRLelR4NHE4bHB6eHAw?=
 =?utf-8?B?VjJVL0ZxMWtvU1RXUUpraTBaWmJaUlZQL2Q0eWFmL3pFdHE3blVxaGVyZDJn?=
 =?utf-8?B?WkhGQ2xFb2d3dFRlMDR3Wm5kakxYdFdWTTBMS1RXY1A0QnBDMWdSdWZaS2Qr?=
 =?utf-8?B?WTNPUXhFYzNsdDhqTjVSZGtwclpWQklYeFhjTHoxa0hjbnlYTjRDSXB5WVJL?=
 =?utf-8?B?bVZxbjJYenNyZElPK1p3V0ttSGd4VUx4dzBxSXplRVlibzN0K3NxbVFMWW41?=
 =?utf-8?B?Mk5MRUpYemY4ejk2bGhlS3Z4SG5Ed2U1b2dxTldTZk9lcG9zbGM4VGVSeUgx?=
 =?utf-8?B?R0FXckRqaXpYL2IvZjU0NEhEcU9XdHVkSG1JV3lvc0ZWTHRqb0J5TEJhYWFo?=
 =?utf-8?B?V1RFK29aZlkxZWx1UDNLamdhZmVOdjI4SmY5Q2w1My9POUtuOFBMRzBPV2Vx?=
 =?utf-8?B?dDN3Z01mb1BCM3NtTGZlZWFOUStpTi9ydFdSOWhEZS9ETmZ6c2ppeTNOWGJy?=
 =?utf-8?B?U1NEb2s1aU5XK1RZU2lxb0MyTlZrUUh4L0F6WndMVnhkRUFVRGRlTS9TZDNu?=
 =?utf-8?B?eHYrYVJOSzRFOFYrcUZ0UHpObWZrYlRVdjBxYWJSd3hndVdCcFNzdnM5d1Uw?=
 =?utf-8?B?eWdRT0dBOFJEamxTV2IxNTZYL2o0ZXhrVDhlZUEvM2t5OWZvZ0t2ZkhkY296?=
 =?utf-8?B?dENvRE1nVVNaejBWRG9sOHp4L2ZTdmFoYnNZS043aXorWGt2VkNraHgwWDNn?=
 =?utf-8?B?REt1WTlsN2tOSnljZlNpYUFXSDVwalBXWjd5Z2dHSWNPTURXN1FKRHJlRWsz?=
 =?utf-8?B?QzBsVkV3UWJZbkcveDJOM3I0aVJmYVFGeDloTmMzclYvSXlkdTRWdEU0dkVU?=
 =?utf-8?B?bEZaSHRSR0grb2o4bVMzTXBZcWFOVnplakJpeWNzWG82cTdOWXJRVWdXd1I4?=
 =?utf-8?B?YjJIZmVKN3RMdld6bWFPWklKMjZSQVZwZTJHa091eFpVR1R4SzdkTVhxSExx?=
 =?utf-8?B?OUxWWkE3VW1ad1dHVE1VQVQ4OEpWb2tnVkM1U0thOWg5U0lwa0x0eS8xdjdE?=
 =?utf-8?B?SEJMN0k4QzQ0UDhoYUk1Zm1QdzUzblR2UVBPSGViVkJhN2NBaE03bURjWjRI?=
 =?utf-8?B?WWRLSGt3bUd1ZXk5VUNvQ3hhcmF5UDBqTEtZejFleFFQdEVzY3V1aFlKL09L?=
 =?utf-8?B?MUYvcWNyRlIxS2trYjJDeHg5M09ma0wraFJNL0xBQmwxQ2wvN2ZQNkl1Mk9Y?=
 =?utf-8?B?OE10VkNLVlRacVAvMXY1UHZhN2RrOC9DNGZxUy9CY2poM1M0L3NHRE1uRWVI?=
 =?utf-8?B?TXluS3RaOEhhd21sd2h1SWtoOHNwL3o4NjJkVkJqVEdxSzhheUJMZlJCY2VM?=
 =?utf-8?B?T2hibFFSOG1vY0Foa2MrbUJHSmVjWEt1Mm9jZllsdHpzd25DZUZhZ3kwWXoy?=
 =?utf-8?B?cjdlYVJrNU1RT3JhbXZYNWRDN1pyT0h4elY3dW84TG4wYVEwbUV0dEk0b3lt?=
 =?utf-8?B?ZnVpTU8rNTNKcW90UEgyajVmKzdGRFBJblFYdlNlOWZwd214cmY5Q3ZESDE1?=
 =?utf-8?B?YXNmaVYraURVRjRVK1RYSGtZV1BOaW5wYVlyanNnM05ZMW8yRGtmdGxQNzZU?=
 =?utf-8?B?b0dzeitUeDR2QlFXWGx3cEczQ1JIMVlrSUlJd0NsOGVTanVNWnk0UjBLVUVO?=
 =?utf-8?B?dEQ5VlNnYkZhbU9uOGRsb3lxU0xNVmRBaFFDdEpuekQ5c05zeStDZHVZYzlY?=
 =?utf-8?B?QW55ajRuT3JrZy8vdnFoRFllbXNzQjNGSGcyY2x5Vzg5MSsyL1ZyUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2776df9d-c52b-47f1-44ce-08de621464fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 04:34:47.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y345l+rcS28oNxk+Shq4DUTDZqQfLvZ6Z+vrXRVvX+C+SafT9J2mifLc/nU+X5epCjFSYHPc+16oso7k4xbbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719


On 29/01/26 10:10 pm, Rob Herring wrote:
> On Mon, Jan 26, 2026 at 01:15:14PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Tegra supports PCIe core clock monitoring for any rate changes that may be
>> happening because of the link speed changes. This is useful in tracking
>> any changes in the core clock that are not initiated by the software.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V4:
>> * None
>>
>> V3:
>> * This is a new patch in this series
>>
>>   .../devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml    | 6 +++++-
>>   .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml       | 6 +++++-
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> index 6d6052a2748f..ca5da919c347 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> @@ -55,12 +55,16 @@ properties:
>>         - const: intr
>>   
>>     clocks:
>> +    minItems: 1
>>       items:
>> -      - description: module clock
>> +      - description: module's core clock
>> +      - description: module's monitor clock
> Drop "module's"
I will fix it in next version.
>
>>   
>>     clock-names:
>> +    minItems: 1
>>       items:
>>         - const: core
>> +      - const: core_m
> I would use "module" unless this corresponds to h/w documentation.
>
> Otherwise,
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thank you for quick review.

HW register to enable the clock is core_m, so I am using same name.

