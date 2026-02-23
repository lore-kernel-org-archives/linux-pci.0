Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13897366DDA;
	Mon, 23 Feb 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871702; cv=fail; b=VaGmjdPJ28hIFdMThFsal2BV8R6YIUR91+jYcx/k/m2qytBGmSzSDIbXjeJPP0QgNhmKE+mucAeXuSH9hPbrlYLPayMDMlIjXW2sNZZZB9L4gbqEbk1R/5iOOUk2VRFKcVvGzXFYsHaEve45VWHQ9YyaXm4ef0cVf4HH8toc/Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871702; c=relaxed/simple;
	bh=WTGUH5syGLPJyE70p+raTg9rQeqV1X/4GZ/86JjLhVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDELkDQt7sgNzdLPwv2IlLZfauaqncsI/k3o9yUt7XrSBU/2wY6j6jUZh6PmEf1+IQSL2Gwj89qHoHe3cJlxK4SShlFJpE1+4NhzomQP/SSz1OL8UJaJWt8PB7PYdnu0zxyhSm53E5SaQSBfjhddRHFsZYvuQHvQyVp4m/4R+cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2/GIqQK; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2/GIqQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1hJ4j/sVnQLRnAhl3VRMAgcaypH8q0gLPEON5ycxS4AVZgXWizLurtwCqvFOz4mvJnBgKKIzujxovYJrzsG9soXkMVAijY20D+FSzNg9ORbZYBekLkiQsF3bZheZAx3JHMaa7WxkOFdACfs/6zgjnAxFL6mu0GtaQ3AJI0/AozeE/W9dhCHxRjgwAqN0f404mXHq0HS2SMcsKqh/6M0RpAXQN5PPDA5TploFtW6Oqg26TbJ2w0HRjjoCMOb/2L45SWkCsy27oJHImrEG/hoI8DrmgaXyRgQfK6mfYjZTpFmvN0cpGPqCzPWkJ7TsxtrUc2zopPc7Kg4/zdYQvhWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7NrlTh1IoTJCZow/+rsFeoX6qdBe/6aZZP5zqW32MA=;
 b=MjjnmqA7cc11M/cfQ/zMrUc42c11Kl5PkkZzVV7ufAzR0UoJNxab0DMEbGt+tOb/7HX9mllz9jIT7n8nyBJN/07qlwGxoIHoTqmvGVxb/sOwb/d7AK6GjllNCXQ7nxgtk4FZYNwF53KJtVNCw5Nr352bdpZHYUp0TuWkAL9zKjGlZpOBbgEqDmHthOupgrEfiEwydtOpmKGNa+YAh/pnDdNjKxJBY01rs+mYpTU3ZE74svpJn31uxtDPYb/H29+pN26Syp9u+OEGkpM8QyRqsclIY5bV8QpBMTNA1R0EZBpf0cIg9gfSITjc1Y+1JygZG1DTPGzbBdt7NvQo6KvNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7NrlTh1IoTJCZow/+rsFeoX6qdBe/6aZZP5zqW32MA=;
 b=F2/GIqQK/5tY57N1cL/f9KJwcD+tzYE64xOfBNNg743hXlOBji7pbgZwaiXD5GtaQvO9wgCTPb5aDUC7iBBD+opjP7UbP065JqkK08YL8j3M3j90e7IvajL0qglx9fhJurQGR6rGjkK7TPGtzFtOFczsF07HKKwYRjrjN3edLSU5vfeXXIEiE/KFNESazdOAmasRfUBkhi9hjlS7xdzvmLXpOo5iZF8R4Cij/aY95JlnKlbMb3LE8btELbAquYtRm0mPJcSWU4s4AocdflnD7HAjQ48kPYjRLZ1182MXgaecWKF6rRNfJSz7HEHa7pbdm4hTVYpBjpEWaws85yXh/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:34:56 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 18:34:56 +0000
Message-ID: <13979db1-4513-4841-8595-b30e42eb1769@nvidia.com>
Date: Mon, 23 Feb 2026 19:34:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
References: <20260203004810.GA14073@bhelgaas>
 <0cd079ce-b658-4058-9d75-0e79987611de@nvidia.com>
 <20260223173346.GD25740@p1gen4-pw042f0m>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260223173346.GD25740@p1gen4-pw042f0m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d41441-1892-4e3b-39ac-08de730a3df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk85VlhuQ2dBcHhZYnFOWFJEK3NhYUthSEVQSFFWdXZFUHhkTkZZQlllMTB1?=
 =?utf-8?B?MFFnNVE1RitoS0o5RXNXKzFoYUhvRTc2NGFpay9CODZNbEMra3M1M25ZOCti?=
 =?utf-8?B?VjRxMjlSRlNoTTBwcWNXbkp1QWVYanRIQVFES1FSa2UzSWViYjNmMGpESnl2?=
 =?utf-8?B?aHB5UExTODBoOUdUSjJSaW4vWm1rL1ZNNERnUWJJRXgxMW5BRmx5N0FVSlFR?=
 =?utf-8?B?WlFhWU1TZyszVDFWdFFLN1d6Nk9yZHUvemRPc0Z2U3BYS0dHWnptSmx1T0xX?=
 =?utf-8?B?ZGJHWWlmaUZmdjBaQTl6NkpYbEorNE5tdFo0QWIyTjgxNlFJaUpZbUROSUht?=
 =?utf-8?B?dW81VU80MHkvK2p6aUd4aUcyZWIwM3VXemNvN211UWNIMC93WlRXNGdBeGkz?=
 =?utf-8?B?V1VrNEZGYjl2K0s1VExIc3JadWlZQU5saEhsOTdIY29aTVhwNC9zMFhUSlEv?=
 =?utf-8?B?bklNOXJZWDZ5SXlaanZGbmhEU3k5elNzakNHQlp0UElvaFk4V2cwc0g2eTFB?=
 =?utf-8?B?SS9GdGZGZHNhRk80Y29xMHYzRFpxUlYweUM4WkRtdmRIUDhkSjZraVdtYXB0?=
 =?utf-8?B?eG9ZWXBES3A1b0lvWXZvaTUvTHdCOG1FSjZmbThvM0YxSVZnSjdDcmtKSTds?=
 =?utf-8?B?L0RSaFVjZGF4SzNqZTVRbitZU0x1S0lQbExGRmVNcFJkcEhUSkg4RWRGNFk2?=
 =?utf-8?B?SGFFTjZ2b29WdkgxZmhaV29FSzRCOWJjK3J2Wm1TRDkxbng1OXlkSkNUanJN?=
 =?utf-8?B?YVMxSWZmVkZDS2tNT1Z1amVobVlYQXF2TW9mMkxHaEwvV1pLTGZTRjQwUS8v?=
 =?utf-8?B?OWhwNm16SnFUUEhGLzRBZzR5Z25SMmFQNjJKaWpnN2NUTnpOQXVvRlBna3hF?=
 =?utf-8?B?ZFlGSFNBRE85TVN5N0l2MFp2M3paU3hXM1VsNi91TjB5aUV3QjJIYkUyeFA4?=
 =?utf-8?B?b2ZEODdUbE8valJVdnFjUm1EM2hkRmtTaWtkdXo2UEY0WTdNRE5rNlN5RGhG?=
 =?utf-8?B?TzQvakxraFF2eVB1QU5iMzVrZFZERVlrREEzR3FZNkJUaDFmWjRNTmJ6ZC81?=
 =?utf-8?B?SXVnUURSNVpPVlZrTkNXSG1ibzdhdTRIVG9pUjNrNG9VLytWUHkzWExXdjEx?=
 =?utf-8?B?b2owSDIwdWhBOTRDNFJNME1NTU5wZkU3L2hOWitVUEU1M1I1VlgyZ0JFeW9B?=
 =?utf-8?B?Q2c5bFNjT2hiKzNld2hUSnU1K2t6MWR1UGRObjZBYXM5RytWVnlIOURiOC9G?=
 =?utf-8?B?aGZDK2lEOUM2c0xwSHNvOHpjU2J5aGFLY09QdVpEMlpRL1B3ZkFUaFpYaTFL?=
 =?utf-8?B?NzFxaWpjZkVSNkdWbTV0VWlWMVdRb3JPWFNabE02Zjg4L09HY3hBRUE5RUFH?=
 =?utf-8?B?b2VyUElUUzFpaHg1TFNMNjZEbHNYTWdkYkRzSkk0Ykl2UGFWTkhOV1BsWi9B?=
 =?utf-8?B?c2lCbXIxc21JMDFkc3ZUZEx5bE5zci9QcEtuTng4cGlMYzJUU2hlaXgrVzNQ?=
 =?utf-8?B?bm1BS2gyME9XemNHMW1FakRudGhzd3JaOUdXaklFN21xRy8vSDBHSFI2R0k1?=
 =?utf-8?B?MnRhUmVxSWtlMGtaUmZVK2NPbHVLeEMxcDlsTXdXcjdGcGF0aFpWVzZxazVT?=
 =?utf-8?B?SGg1NnptVHJUOGJodXRUWjNDTHVreTQvcmx5UzFteXFFaStFMnZjenVOQWRR?=
 =?utf-8?B?UzNSZUQxYTFPTDhFeTFCeVNNZ3pLem9GbkZJcXNtNW0yT2l3YXM3d1c3T0Q1?=
 =?utf-8?B?UTl0MTcyZ1pXVWRjbVFYRXQrS093V0U5aUo2VEFUeGN3cEFMM0xhVlFrNEF6?=
 =?utf-8?B?a0pJSlZMT0lJUWlSek9vSnVYUjJuS2o5RitVWGZkMTU4aTRhV0lLY1pvSGdv?=
 =?utf-8?B?bHhQU1cwTURyTmxrOGg2Nmhaa2xqTGc0R284OGpvOWR1MExjcFIzNHRvSFRP?=
 =?utf-8?B?UWJQQTF0OVdOTlhkNzZFUGtZMUlRby9GNmRjdG1XdjR4dDl6MWs2dzVCbWZz?=
 =?utf-8?B?VkxlMEdWMWxNdURrMFk4d1Exb1g3YXJvdmdaZ3dUYnhGc2N6QW5nNnNDZ0gv?=
 =?utf-8?B?MlcwNEh4R1hjTXh0NHhORkh0RVF4ZUVDY05nWHZNczRFdm5pNkNqWjVRSklp?=
 =?utf-8?Q?MmKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpBdWkrN2gxdlFVT2dRRG9HL3VoNzhiZXZhNUtJaDBmOUdRODh4Uk9ONnZX?=
 =?utf-8?B?R2xUS2cwWjRWT0RsVVFFZzdUalI2WEJ3YWMxOWhKRTV2SG9rcFFRUUJlSjN0?=
 =?utf-8?B?RGI4MS84TmU5V2kycTBkbStMNHpsNElhWTdvbEFrUEZNOVRpZmR2ZnF5TExL?=
 =?utf-8?B?WURkNnNrNjFXS05DNXhQZWFURGlJKzVDTmNRMDJmWHEwdEtraW5YYmVaN2cv?=
 =?utf-8?B?YXNEeURsK1ZSZW9QSFJ6cFM5elZmRUtXcndQWHVpL3dhdDdmTWxWdXJLSlRJ?=
 =?utf-8?B?amRsVVlBckVWcy9rT1phYTdQeXp0M3hLOVF5cTI0S0orSXRlMk1QcmhjeXlt?=
 =?utf-8?B?REc5MklqR292U3lMTEJEemNIc0Vjek9qUVZBWTJTVFF6RkxDRyt6QjJtL3k1?=
 =?utf-8?B?UDFoeGl3SmRBV1ZtMjZHT3djbGgrNGNGNlAzRkREYVp3UjZUSUV4R1Baai9q?=
 =?utf-8?B?S0tabERIU2RiTnZRWENFTHpmMUF0T3lIYzBORUV0S2F2QytGTG96Z29Fd25X?=
 =?utf-8?B?ZE9kSDAvcHpBTk95bzBIbStaTFBSUHg2eHpUWGxhRG9JQUd5QVNrRlUybnJQ?=
 =?utf-8?B?Y2RqcVJjV2xUa3hMRlpvSFF1emIrRXl5ZzBxSDFDUnZvTThGcWVRSUNDOFhv?=
 =?utf-8?B?RWNMNDIrL0lXWFdvZzk5WTFXNi84K3d1NWFza0l5enhkeGNzaGRRQXdrQVhj?=
 =?utf-8?B?ZWE3RTE2N3lucDhaaDgzNnptQ3I4OTFNZDlheURmRG1pUzBDVWsrT1RoNnBZ?=
 =?utf-8?B?QzdNQkUwQmVFbGZUejVaMzBLYXY3SVQyeGhkQ3lmTVZwNGduRytnSEJ1R1h0?=
 =?utf-8?B?aFgxdW9xYXNrL3FJOG93dTdsMmVHeVJzVmtiaFJkMjlwVkZsZGpsY1ZhZVZ4?=
 =?utf-8?B?dmRrSVlFbDRrdSt3Umw4ZGNybFNtUjBlSlY3dloyaGp4czB1M3g3L1hTdEpa?=
 =?utf-8?B?cXhSZjZXQ2VNQnVZeFJ1NVhxSDZsZklKSGd5WXFRS3l4Y0dlNHNJd1V1VXBZ?=
 =?utf-8?B?ZlVTbWVxc3RKQWd4WUUzU2FSQWNXa1ZkaHF1RHl4N3ZjekVOQlJNZEovcmU2?=
 =?utf-8?B?VnZkd1ZaMlA1VEJlOXYzUE9JZGVxMTQzVzIyVFMwQTBxV1gxdmUvVE82Zlc1?=
 =?utf-8?B?R0tIcjAvMzhpNlhDWGNIUzVPbisreW1YN01GaS9KQ2tHOXlpaHFDUG82bGFL?=
 =?utf-8?B?NnoyTk95WktIWjBtNGtMRGFNS3dSWnZ5dnowa3hpa0oxckN5ZVE5TDUycFZh?=
 =?utf-8?B?bXQ3UHhSbmhoMmNBa0RrYUNCamJxdnpxdmhtQUZRWXRlcTV5V1lDWVFGTnhK?=
 =?utf-8?B?RW44cnJBOUVUVFAxZ1Uzb1RobktXMG9sNXVOc214eFJTdDFCUHZwVXBvSTNG?=
 =?utf-8?B?UEJWbDB3TVV5eCtwQnFwaDZUSTRaUGxBbkhySkJPVG9oRnZqMjRzQ0g4TmxP?=
 =?utf-8?B?dS9pdGJwbm1xRHF5RVF2ZnhDcWxBZFJOeC95QWhONDQ4SXdXc0xGTCt2KzBP?=
 =?utf-8?B?WE91ZjNZeFVuTFpMOFQ1TTh0bkVoMENyV0tiT1cwM0tkUnd4elJ5YWFtNWha?=
 =?utf-8?B?cDhXTnZidjZYM001dkZUbjdTL1FCcWIzWE9hcW9sSXNmWTJiTmUxZFhlNHJM?=
 =?utf-8?B?TDNJcE5DalJEc3cwZDdsREplM3RKZjBTR3NBa09kakQ3cG5VS2ZEbWNDdXNj?=
 =?utf-8?B?cTA4V0dDcXlzQUxBZnlYeGczT3VNUk5meG8xOXNJd1ZmY3ZHNm43SncxbGhF?=
 =?utf-8?B?NWFIVXBQcitRcTViSGU4QjhvcEEzNEdRUHBMdDg4c0tpcTNnVFlrcmh3aDcz?=
 =?utf-8?B?VmVSTUhkblByZFdONWN0eGNHOW9wQnI1SUhXK2RGTlVXRklXQjlOcHV4MUNZ?=
 =?utf-8?B?c3QrbFNRYnF5M2t3alJFU0VWT3lEd2YwVXc3SnFCNHZaT2NhNnlFVDByTHZX?=
 =?utf-8?B?ODFRejBKcFFtR1JaMm16YzdJZUZmL09OdXZNTWdwczdIUW52ZGgyTFEzZE9t?=
 =?utf-8?B?c2tndzBVdVI4RTkxQjJ6NFFlMTBlK3NNZyt5amNVMEpIRzVReHhLNitmTkNp?=
 =?utf-8?B?S2RlZ0VhTVJJRVlVNEdBNktGRCtnZVdiN2JlanZFS2licDRMRnp1S2hLTVk1?=
 =?utf-8?B?RFlJbHN4cjVoUXdlNUNtdGZMZmVobE5teW1DL2dqdVMxTm5RTUpld2UwSUN4?=
 =?utf-8?B?SEN2Z0VpR1NvYWttVmN5RE5LZjl1WHVhY2Z6SGVBVFRNRnV4WFhBQ1A4UWtN?=
 =?utf-8?B?akhmdVFiNFhjQ2haSXdiZ2NzRk5qQjhKblk5Vm1hZWxielJQUUdPY0pHQWhu?=
 =?utf-8?B?SWI3Qm15eVpjcWZGK1dZMHZrbmY3ajRCa2xqMTVXSElDVjFHV2JHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d41441-1892-4e3b-39ac-08de730a3df6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:34:56.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mwjlaxAu5PcBxqIuaFMQPs1V5PQqByUYMAhqjg3BMGR7nsgc7JfuYCx2XXd5dLvbvRqHft9TMR/biQrk+hMKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253



On 23.02.26 18:33, Benjamin Block wrote:
> On Mon, Feb 23, 2026 at 03:10:35PM +0100, Dragos Tatulea wrote:
>> After pulling in these commits in our internal tree we can see the
>> lockdep splat from below in many internal tests. We are still trying to
>> find an easy repro for this. We had to internally revert both of them.
>>
>> I noticed some similar discussion in another thread [1] but there it
>> seems that these changes are actually fixing the issue which is not
>> the case for us.
>>
>> ------------[ cut here ]------------
>> WARNING: drivers/pci/remove.c:130 at pci_stop_and_remove_bus_device+0x39/0x40, CPU#2: modprobe/12956
>> Modules linked in: mlx5_core(-) act_tunnel_key vxlan dummy act_mirred act_gact cls_flower act_police act_ct nf_flow_table [...]
>> CPU: 2 UID: 0 PID: 12956 Comm: modprobe Not tainted 6.19.0net_next_e834b5e #1 PREEMPT 
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:pci_stop_and_remove_bus_device+0x39/0x40
>> Code: [...]
>> RSP: 0018:ffff888164c9fd10 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff888188ff2000 RCX: 0000000000000001
>> RDX: 0000000000000046 RSI: ffffffff8307e068 RDI: ffff88816bf4c9c0
>> RBP: ffff888188ff2000 R08: 00000000000000f4 R09: ffff88816bf4c080
>> R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
>> R13: ffff888164c9fd27 R14: 0000000000000002 R15: 0000000000000000
>> FS:  00007f52364bd740(0000) GS:ffff8885a9019000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00005622dbf749d8 CR3: 0000000169132004 CR4: 0000000000372eb0
>> Call Trace:
>>  <TASK>
>>  pci_iov_remove_virtfn+0xbd/0x120
>>  sriov_disable+0x30/0xe0
>>  mlx5_sriov_disable+0x50/0xa0 [mlx5_core]
>>  remove_one+0x68/0xe0 [mlx5_core]
>>  pci_device_remove+0x39/0xa0
>>  device_release_driver_internal+0x1e4/0x240
>>  driver_detach+0x47/0x90
>>  bus_remove_driver+0x84/0x110
>>  pci_unregister_driver+0x3b/0x90
> 
> This looks pretty much like what Ionut is trying to fix in
> v1: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/T/
> v2: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/T/
> 
> Maybe try giving those patches a spin. I think one easy way to hit this sort
> of thing is to try unbinding a PF that has 1 or more VFs attached to it from
> some device driver. The "trick" is that SR-IOV has to be active.
Thanks or the pointer. Will try it.

Thanks,
Dragos
