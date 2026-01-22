Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB742DFF4;
	Thu, 22 Jan 2026 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055923; cv=fail; b=kYJVku5chLdML6bIxf1AaguN4aocT2uFZD4aJxGaf+VvREL6GjhkhM9oqFnNx5l26Gy3rac7mU/kfnxCmvD7tFXpaodT+ycUM0y8SCIDxFLhdlDEQFsoCDgLnedaAyWE9V1X/wqx3O88CK8j5MoPUhBQ8ozwirJ/voBYmb6WFd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055923; c=relaxed/simple;
	bh=clPpvJ0NY2gjIHWVuBATbZ1n8FGBIx91mCuOVl348bs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=cITfmOczqiciLzyDFXffQ0YYaWtdUNbC44nmpEKUrp9439wrAg4joZ90IWZqb/Ukl+UX0lI9tuObXLAHyqZxfS0BlYwIEfQ/v/S598YrPTBybnikXx9GU2ZiT8abzFNkWG5Y64GSeM4WecjO/X8dTBbmIfRwn8YVhGnFIwnB0pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bb9I/1VP; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bb9I/1VP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap0h1JvAzjbnVRvFE0qqWBKxXQKkN6SWCUFskfJmYgcAg1Clo+foMCGJhGMWBwK1Mz+/7bsaTZlUOhR8kt/MqfvulBHnKA789yDix0nrgEAsRJidwKr96CNi8IGV3dCXqPQnfWk0JtTdJhRo8TSPT9Gqt8d63bbDBtB/1rRb/OiCz04B7VPutLitafEno+IPhsaCwrRUE+OopIp7hikPa9z4sQBtdRVpilcixDzF6+q7ptXSgRyXMXpg7g4AdlmPjqLyqVy68igWrD/I/X/zzBxSSM2q1L2mDo7bQc7RBneB2c00npJZ+muL1i3r4ATzf2BJBXEwnDceq1FBKj3X0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clPpvJ0NY2gjIHWVuBATbZ1n8FGBIx91mCuOVl348bs=;
 b=jmTzF2gxamOIWhdu9PSVxnUt+ri0m6C+yWg4xKpy8326z8DuUO+bzdtD4MH/KeIFDqQrvTlQeDX3+94mEd7tS8sdr2HbpMULLtIf/RPw++qmvOn4mnxwYoauG5HsPpFf6gPJcvPRtUm2Xd2BIagFuXFzPKKwA4DPVHgqi3AKytPoTpnyOHHLbI5LtE0kK5RDXDKnZhKuFSd3Gfvuu42f0mNUwuRSgA1XnNjUYvkioZ61wt+0aHzzEi2FAL+9udOgOblCbIQLfWg1oqER1RkAOoZN63tdMOGWHI5AkWHh1GWBdgzTO4OP8y/D0jIWoiZmvetLrcvqOyDG97oLjuHtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clPpvJ0NY2gjIHWVuBATbZ1n8FGBIx91mCuOVl348bs=;
 b=bb9I/1VPrpRcQEolVne0iCRU+WVay0fhcoekhryDoT1C4O7PEWvCrGCVms6whfYbB0pbi7w89gC3VZgEe8H8Q/EFBNp1I7SZ0xZnWqbC/Nx/8hyHwWeIqDNiDP4gAfgydlUwq55bU4veu3+JRGznvfRDQQqvrDYHd08rr0FObGQv6hwGYsI2EHpx5325bFpCIEm3y0MSMpjhBMrk4yQITr2oAB6uWptBi+8/UoIibcF5NKfsqT81JG2pg1oCUpiMOVW6Zf8ldIM4yqXsXfwUFxfnv9UFXHcXyrggv8Xshi1ExOApnF+lZQcVBLgwPNs3IO/S4g8QZwYz4qy2k+zKkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:25:17 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 04:25:17 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:25:13 +0900
Message-Id: <DFUTZFEPBWQ3.3QHSVNU3L8SP5@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 1/5] rust: devres: style for imports
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-2-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5c64c8-4177-4255-48f5-08de596e3ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjBnVnNMVnJ0dm9Eem02WSszTGtKVDRDTHZJTmpldyt5Yk5kNnBnaXhidjRJ?=
 =?utf-8?B?YzRJQXVpNFFNcERDY1U2RzJPQXFIS2o1Q3M5QU10UHBUQ285M3doVTY4UDZB?=
 =?utf-8?B?NTJEeGhFUndwT2ZFTzlJVDhwNHpodm9HZkJVU3huNFBCakovaStkWEVBcXNE?=
 =?utf-8?B?enZsdndoSDFFSWZIUEJzZUZXd1pSNExmMkxHcDRsRXhnT1U0OXF3R3FCSWFK?=
 =?utf-8?B?YkNOSVBOOFdZRGg5VXhwbnFqdjB4TUlQcUpsbUhUKy9XK0FzdVNMRlJuZFRX?=
 =?utf-8?B?L2VSRE1KdU9TQnNtQ1pLT1dSbmk4T05IT2s5ZFcyMGJVbnplYXAvREpXL3JE?=
 =?utf-8?B?RndQend4T1RoTC9BSFZUYk5aSGR0cjg3UHRMNjNjdlkrNVpJb0JsSXoxaWpn?=
 =?utf-8?B?am1IVmxlVU1ORHFvV3NoSmF2N09NTnpRYThIVzVpd0F2K29JeHpkSEhqdVNB?=
 =?utf-8?B?aE43Rm5WNEZ5UXdTakIwcmhLdHROMWJScDNRNjQvTU9veWlOMUNXa2F5MXpE?=
 =?utf-8?B?ZTBiQ1N3NWV4WVZaVytvS2cxa2FPV2ZOU2VlUzNNblhpWlJyZ1lpVS9yOXBq?=
 =?utf-8?B?YjdCOTBUNHhMSjBKRFUwVEJYN2VST3ltTHpsM3JqZUVzb21TcTl0SnNmNzlw?=
 =?utf-8?B?cDZReFpybWZqYnZ0QUliY2FzZUdGMFk2Z3IyeVFnTHdtUTVLRDNocTdTdjZ0?=
 =?utf-8?B?UHpZVEtubDhQNzl2bEJ6ZFZsTEhCeWFEczBtZmt4VVRVYnJXL1N2alRUMFRW?=
 =?utf-8?B?OTYrTE1uSHJqcExTQm1zRHhhdFJMbG1hYk5nV3VVdXYvYnhTRmFUWHp2YUxi?=
 =?utf-8?B?S0xJYmMvZzZHc2VsN0hMWU8yM3p4QldXMC9JQzhNWjhJTjBQUmpyVXcrWUNU?=
 =?utf-8?B?RjBzZkxYVXZCVDBQMEhFTUdwbHl3eVFFNGhkYm1lV1dKcE0yVmEyMnBNekp6?=
 =?utf-8?B?ZW9wRWl3ZENqV3NKdlphZG1jK3o3Q3ZZQnJacDNCaE1ObjVKdXRjWi9nek1F?=
 =?utf-8?B?OHZtTFp2TE1kWk1LK0cxSUF0czNVOTRxUWRhWVUwNlZaOEhIcDBMUmU3RHpJ?=
 =?utf-8?B?dUh4MmNrN3ZGRjlKcFU0N2k1eENhRGxvcmsyZmdZYkpHQUY4Q1NSeEo3UGEz?=
 =?utf-8?B?bmVuNlJYeDVMSklhL0hvODBvQ081ZmRUNk4xQ3ZLYVA4YWdicEZ6eXRsSkEy?=
 =?utf-8?B?VEQ2RENrdmpTeWRRYTB1WjlNV2dncS8wTWZOOWg0SUlDV3NCbGFOeU9ETDdm?=
 =?utf-8?B?cERyRjBtdlNpWnJBcHRRY3RQamVMSWxyem5ha0RIQm8rcmxPM0duYnZLVC93?=
 =?utf-8?B?MXg3UXdna3ZUNDNvckpZVjdia1d0WFAzZlVOWEVENHBCMjdiUjVYVEQxejA2?=
 =?utf-8?B?aDIvMVdHdjU3TktkQU1wclNtNUFkUU84UXJwalkvaEJvcWVwSFFJSmdxN0RT?=
 =?utf-8?B?NzFUWXRYL3hZWm94Q3U5ZExheXFCTlgxTkNzNHI0WkJ3QjM1cGx4SlZLemdj?=
 =?utf-8?B?YVBxcXR4ZzRuWnhqY3B5K3lhV0VjYUNGVW1uOE9tWkZaams5VGh4UkN2eGkv?=
 =?utf-8?B?Z3BMYnpzL3FCZEJJaW4rVzIrcGRoMXVIaklPZ25scVZrWS9wdGhBYm5NcnNI?=
 =?utf-8?B?UVNTeldnbVJIbVhVWHF1SGVZb1hLc2FoZXJ1VTZCZWFoQmlQY3dMandpSmZu?=
 =?utf-8?B?TW5JYjcrUUhRa0tzdkh6OUx5K01NZ2tZQUZ5eG5lTGovWDJtb054aTlxZ0s2?=
 =?utf-8?B?K1FwK1F1UGFRSFpBUEhmYlpRWC9RT3ZOSy83c0d6SHk5TmlheE1EdEpDMHdH?=
 =?utf-8?B?WWJ2WXE4L003bWtCQmNKdU5OV294R0FQVXBWTDRXY1greFp3MXNia3dsQUdn?=
 =?utf-8?B?TEpQVmRIM0FZREZacXBneDJLWjdadllyOE9jY3AxM1dRRUdXZ3BETTVyRXRx?=
 =?utf-8?B?Z3NTYUlPOTRYU242WGJEMlpMMzZHcWRjMk40b3BPZERBRk9aT3ZJNTdBdWZW?=
 =?utf-8?B?TzJrZ3FSb2hDQUF2K0llRUd4TyszK1Rab29zQ3RWKzB0OGtBa2hUa2ZrVnVm?=
 =?utf-8?B?SUdlak1EQVpqYkFEYTd4bng2UWxRWXVyYU91Q2YvNnkvd0tSTk1pczhpb1Q0?=
 =?utf-8?Q?GEL4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zit2ZU1lblR4RUt4cVdmMlcwRWhiL0lydHY4cHJ6SVhuV0FZWkN0dUxwcUpp?=
 =?utf-8?B?TkZVYkQ3RFdFaEZ6aUhWNEJrbTZvd3p3bEZhSzAvMzEwYlNKcy9rR0NBNlZr?=
 =?utf-8?B?cHJEbU4vUCtZVU0wSGdOYWpjOW1FWE4xaU5Ya1hyek1MY3Z3cmJhbFhFNENT?=
 =?utf-8?B?MVJtbGxVTXZnV2c5TnNDcUpPTkVNc0RBSE0ycm9zdWdJbGhVYnNYZEgySVcy?=
 =?utf-8?B?UTRsR0ZBM3FoU1Z4V1RGMmxjd0pKdjlaZkNoRDVpU1Z6QlNhK1VPbEZwM21W?=
 =?utf-8?B?V2hhelgvMzhSRGpCU2Foc2ZBejdabFNUZW9iZEZNM2RvRzY3VXBTRzBBb0VW?=
 =?utf-8?B?ZERXK0lmWG53RnZ0QVdTbkJUeVJROUVwR3NBNGhmZ3gzVFEzVXRZZzlxVUhj?=
 =?utf-8?B?TW5pd01uRW9rbGxsNHhLOEQwUzJZbGxvVkpoc1NEN2V2bHk5NUJpOHA3UGtH?=
 =?utf-8?B?SFcrTXIwdStCYThXRkFleWUwOStZY3FmRzBOdFZCcm1IUlFTMkFzRmM5bFhO?=
 =?utf-8?B?Zjk2bHRGb0VNTWZpemJHOG56YzBLc0pYMjNKTzdZK3gyNFcrRlRZYzNaaTYv?=
 =?utf-8?B?M1RSSk05TTIyUGF1YnhTUk9uR1BqdjY3MnB4TnNGa1I3ek9xd2lnc2FWdW5C?=
 =?utf-8?B?azNZTWV4elNFZk5JdlZBQ0J5dEgzazgxSHRCSWJWTDRpUzRWYk5iZzdUbEVx?=
 =?utf-8?B?V21uK0xxU2h5MHVBT3FmcGJQS3JYeEZSZXpqdlJmZXpaOFhsZ3hweVVjVnd4?=
 =?utf-8?B?SlQ0ZjA3dkdocHoySElrWGJ3dFNtM00vdmhTc01DNmplSEZTdVFoWGtNbGJk?=
 =?utf-8?B?QzRvbGVZM08rdVJSWlJ3djRuSmpjUW9tY2R2TUs4QXoySUhHQjRocC9YZ1Jh?=
 =?utf-8?B?dzVJK1ZYeG11S3B3L2VzYkg5cmFETmwzaVU4enBmZDVKbFUxaC8rdlBEaVN4?=
 =?utf-8?B?b1VUWVZxTEhlMzhuUFFDak1wMCsxcS9ObjRpbkhnMDIwbzNWUHFYYW8wUkp4?=
 =?utf-8?B?T2M4QUM4RGdkZzlCVm9qWUV0YjhqVkZJZ056bjRWQU1SaXdRa1lXaVNMMXJP?=
 =?utf-8?B?WjZyZ2prZUJOcENzZFhCVnI1Q0dHbHdUVSs1T1A0L2hBSnlWVGhCZmdpUnhU?=
 =?utf-8?B?Vnk1SUMzR3IyY1lyaWFsNDRCZXBOQnhUVExlYklPR1owWTBPNkNaeTZ4U2NZ?=
 =?utf-8?B?QTRMQVFrYUZDWjhMUFA1eTZQZi9oNDBOWUVub0k1QmgxSFBKT0xHVGdhZTAv?=
 =?utf-8?B?NXRra0VTV1JxeFk3Ui9MVnVxelRvZ2ljZXNCVEZxODgyaC9UNHRXaUhGZE9Z?=
 =?utf-8?B?dlk5Q3BwVGpkOEVxd2puT0tuMURJSVBwU3QybHVJY01sVGlMaTA4dkxOWjI2?=
 =?utf-8?B?NW5PRUwvbGRBcWxNT1V4eUZPWWZBTVdGcFZuVS9SSGpmYnFURWIvMWljM0V6?=
 =?utf-8?B?NHh3YkI3a0xScHdpUFdPYWtUdDJnMDBLRVpiTHhaVk96R1QrNUFDdjRYYnpL?=
 =?utf-8?B?cTNvajZBUGltdC80MVMyT0s0SzNTcGZId3hpajAzcDA5Mkl5UEFqQlFXTEpt?=
 =?utf-8?B?S25ETnhtYWNia1g3enN3QU1UZThIa0wxNnVIb2xZY2JnakVCTC9FSzhmMWdx?=
 =?utf-8?B?MWZDUzFLQ3dvb1VNSHBXd3ByMHR1Ly8zOUtiamt3S3llVGhldGJkMVV5Q3Ni?=
 =?utf-8?B?TUZhUU9oYkZGa20rZWdiNG9zNjB6RXRpY3RzTW1rZlAyR1k5SEhHdUd5N2Fi?=
 =?utf-8?B?SURYQVEzLzY4LzdmNWt2V1M0Rm9vWFcyYVk4bWJ6WENRaDAvelNTeHBadjBr?=
 =?utf-8?B?ZisrU25KSXNoZmhIRW5CQzBPZExGSmp1bGR2NVlrNUd2cWI4UGtqY2tKQU5o?=
 =?utf-8?B?S0ZNM2Jxc2MvNS9kSTlUVDNVeTdDMHdHb1hQMTlkSTI5a0Rud2RQQm5XQlRm?=
 =?utf-8?B?RUNUbVBXeWVLSVZTYUU0MWU0WEtoaXBTQTY3N2oyZG5vbjQ3QkRZVHFJWWxm?=
 =?utf-8?B?dmY0ZmJtbFIxOXZNSTRQT1hvS2F5S0I5Rnh2V0Jyc3VCSU9Jb1hraHhpc3g1?=
 =?utf-8?B?THh3eGpBOC9aR3h3K0ZGejZHOGZEVVFZViswanJIVzBZeXFvTTdNTnl3aHF5?=
 =?utf-8?B?eG85Y3VwWUFsNjhXN29UdE9vQlN0eElmbjk3WGtiTTFPeHBsVUsxQUZlcmxk?=
 =?utf-8?B?R0tHbnV1dG5tQUgvYTZCZm52SzJJbC8zV2paRG9HUkNFZUhkME4vNVpyQysr?=
 =?utf-8?B?TlFMT0lPTGFLVFREcDBMaytzMDhzRFNaUlc5WDZzQnJwVDFRWWMyMVJqUTFL?=
 =?utf-8?B?LzlHejJQbjhUenVJY1JtVzVRdmlXSVlQTGE2Z3RPdTQ3SlJlVlp4QmlPTmRa?=
 =?utf-8?Q?jASBCqbqjssIlfayekTAPXIdiZ6xUg+V4R0wwdbX6Kz+l?=
X-MS-Exchange-AntiSpam-MessageData-1: WfHswpA76f3KiQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5c64c8-4177-4255-48f5-08de596e3ef1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:25:17.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz4g0TtIjhkaHvAoKaxj4MerbR5ils3oWc81miE9tqI6Hr1J8jyG6e7UEynJPOLNku08SDU2g/lfnSQLObLLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
> Convert all imports in the devres to use "kernel vertical" style.
>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
