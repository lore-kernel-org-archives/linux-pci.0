Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9614A7CB8;
	Mon, 21 Sep 2026 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998340; cv=fail; b=EaFj2YD5idaflcApg31ZA1xaqpEpQuqLeueSFFs0Gn17Y4BrbqkhlBFdR5fH7wXu71efOLDTqGRvVjmZOzow7yefgZQEWTsYDBbGpLxTnn3QK1pRKSbzCgYwZAWy0+GtlOLM5+CkTAKi08165/7h/9FU+SpMg8cNGtCaKFqdW+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998340; c=relaxed/simple;
	bh=YrmGDe+kyzTiMPCvHHAcgpwrPPtp1wqfFxhU78DsbhI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d82UbmgbgYlIUSryd7KqMKK1Y/THft6RsRh6q4NKYIBMi8RGrmTu4sBNhcPALuzZPZDGcKwUAlyUaMkKv/PAWo5XNbvrlsSxqz7pLPHal/tEl585ziLBiqGf/+4BqIuv4Z0DZbloMVUanEPd3wl1bIEaZnc4HMTga2mYFCUdXag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=etzqVq9P; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="etzqVq9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djnuV1AOadUobG4IksZeGxCS0VCMlch7zv6lAHKMLNdUIZZ42Ysr2iBCHsY03S/cBKSAZxOqZZnXHcmBReZCUySeWhcUFQeOyrDAfcABxp3JbG6W18gzGyQYjq3wFW9OIomGwuctXL43kTPiZhFTsAlzbaAN+I8hgFtOzcHJdJmON3wLRazIQjwGbWoPxtn5ptrFsF0NALO9vgX/amjo2BxDG1h10iX1B7amcNxh+hiKG+vjUy4KUl5Hg5kAzxGY/XRcEeSgtuGp5z5Wq8YMfs2RhdIkphjOtrq0DlIW8s3vZ9/m6WqV8w/y6NOtBA6skCuCNJr9qE8tm2hSQxJipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVLkAE5OwDXEmuXiGiHbczxkiKYrAm2GXVlIezS0eo0=;
 b=Q0pIA8R0sn7/jgfM8Onh+uG8apER+AFPLRmOCkV3jeIGaLmL2Re65drIEVKeaPnxsL0WWTVcjevJEcCkrVLaRRpbgoDobQCaAKFuNO4vkMaYULCCfGR6J6xNDqJrV2fLnRcY6MS6sHnHSZmH8NMJE0TEdQEO7zE5mPPbrtkgXWUlDAWk6pv8J53KeqO49kSplDRbaOv97N2bgflrtrJKdB31pjZ9DaZWYOWDtZO0I/MED5YoK1jvKnJzLK/JSBngRFBR7HXALUKHttIHTNFFaYgzAgowAywnphziV2MHlgwWDs8TFnpeigiP44rNctCJBdImDdsdjV0LheIEHRHHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVLkAE5OwDXEmuXiGiHbczxkiKYrAm2GXVlIezS0eo0=;
 b=etzqVq9P3pLyH86PHjfHZlSDtOe7fMx+kNQ8mDswE+vsatGPT/CjK52wzc06OaZa07O47OWjYK1Wu3OjJgx40m0ojJiRx5tEkihF/xCcJYaLWjrt3bgCTdUO6ig+vxvk3G85IezzAu4cBuc+2BBEHed+YLQ9A4S7x9qwIc1BGbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PHXPR12MB999234.namprd12.prod.outlook.com (2603:10b6:510:3ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:45:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:45:35 +0000
Message-ID: <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
Date: Mon, 21 Sep 2026 15:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
To: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal> <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260921132208.GA1507824@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PHXPR12MB999234:EE_
X-MS-Office365-Filtering-Correlation-Id: 827d43b5-ba3b-4061-6f7d-08df17e69cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	COrQN6sgNWcpRdXYSj+kTOIyZ7vETnaBp6Xxk31IBQ3Sy7M1f9DrM8XxS4w82cVAoW0s2SyBJ4H9BBhUk9n1hRqYUYSFXrfijjeHqn9ov53yIKp97GEdngPRmT3SyGYYzKuXr9E6srPfs2OWWAqAw6dIbTJYCQxaPk+lWiScnLUDfMowpZ8G1HHWFiyrrL6A+E8QQj3Ioe1i2WIrMam4Fhbaum/0gXCQ+dZFsMYVq6HoKCXC/mee7iMxbDh5iMCqD4macYjbZZCatxZVVx/UX+xwaVbKMR2yUHxe8n5h0rDB6YR2vJ51TIh+2lKvtx276B6FG3nZHkuhgRJePK9INIo9rd2+5HmB7t0ZAFz/P19DY5tn9cm6D5U3hBxv4KPWVRVhYJd6P90JPdqgHfrt1/covAGW5hSmsNrPR6NPQ1xNvbe8XzgxaAHYLXApB1QVUJNRnK1aqsV9vsKIzJZ8P3yGqhao5HR5LKGfUpW80Z/x0Mg++692A+LM9pd3AWyDlfuSNGilzTapHhgik+wX8LtNL6p/cmcdLxLPth0ywjs+ObZ5OF+0JO9i+awPbK1e4UXpu5UfVHiTp2/WNtIA9Kj6WUaKb04BlZ77AlyWajxwnMz8wr0NtMRKymLFKV7fEswbFed/2BC/BO0HUFOZHsS0PqBQC82mUUADDieQ0xk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3h3Tmd5c1BNczBtNG5RN29nRys4WDltc0crQndaTEhrT3BNVElTNStrcFZV?=
 =?utf-8?B?YXJXQmZ5RFk5WmlmSEg1Mkd5RDV0ZmdJT3ZheGMrMW5lZmNRWEV5Z2JMRjFG?=
 =?utf-8?B?K1k5VFI1d1l0UkVhWkV3MkJmSEhGQmtVck1UMVkyV0tNemRYK05oVTVYZHR4?=
 =?utf-8?B?QmJVcXhlaXFoRVdwZGlCbVAwUHZUb3A0eVhCWGxrcFpPSkREeWUxSFUwT3J5?=
 =?utf-8?B?UGJTcjN0aStVeklObytlclJ6SWxPQmErVG5WK0RmV1p3enpoOFpFREtHdnVq?=
 =?utf-8?B?bzdoNVVPMEdQQnpla1dUUHVoMERGVFZ2RjV4VCtUZ1l2aWtXVnMwSWJQa0g5?=
 =?utf-8?B?amdaR00xbk1FK2tHQmg0M3RQNEZoRDZQYUxrM2w3RWRyVERTOUN6cnlvQVlr?=
 =?utf-8?B?OTBSYVZ1ZnFINmR3TG1XNURRTWRiMjAzVVlweHoxK2ZnRDRvS2FyaFczMEs4?=
 =?utf-8?B?M2lWRk1TeUQ0ejQ2bFV3bGpZbTdaaXZyWlZEaW1MdkJLaEdEcHljYno2ZXRy?=
 =?utf-8?B?bTdneU1RejY1NUg1WEcwRVV6YkRXOElsaVdtSFlpd1l0bms5d0R1ckxNaU5T?=
 =?utf-8?B?eFlwemtNaVE5di9jbUw5NmRSVUlreXBsMHoxTGxoblpTd3ZyeU1zVXlHZUVM?=
 =?utf-8?B?ZGxOcTc4Rk1sNjlhME9DZURVVndlVUFIODhKTnVHbWszSWhVTUZuSjlGZExz?=
 =?utf-8?B?Ympac1RoczEweFVmSFhQN2xWWTNwQ0ppSEZDdnY2MC9pR1NxRWZSWEUxa0wv?=
 =?utf-8?B?eVlkaklWalNzTnJ2NldxdUcwY0wzV0hVZmpBWmhwSXI5bVRvTDBTZ04wTHVV?=
 =?utf-8?B?SXk5dk8yYjR3SW54bnlzcTdRYTV1TnVJZk0xdzNUOVFMMnA1aHVJVzRaZ3lz?=
 =?utf-8?B?L3UyMGFoWlREYjQ0bUdYSWRISmpTRGpDbXhYcldVYmJCQlFhWXFDMk9rWFJj?=
 =?utf-8?B?a2lWRDBRcVRGaW5NVXZObmVManpkRm1naGxtaDZhbWFqS2NPREh0VzluYlBG?=
 =?utf-8?B?U1BabWdVUzRCendDQzZIcGRLSUYwdmFoOVd5amJGa1hrV1lpc2cxdkJ0NU13?=
 =?utf-8?B?dmxLcU1FSFVabFZzbGhwZkJIWmx6aEl6bTBzM0c5NVMwTVNrSjVXdHdJQnhu?=
 =?utf-8?B?N2psMUlKZGVHNWEyMjBZWU9vY1lHV1FQNStaUy9uNXFHLzIwVE5nTzhQZnZo?=
 =?utf-8?B?aDMrOWxnTXhaL2s4MFh5OGJWQ3BWQ3BUbm5MZnhjemRHOG43cmtuak9XYnBl?=
 =?utf-8?B?M2hEVjNiTzdwZC9HM2RCS2RNeEF3L1RQWlVXT2VIWjZJRVFUVWwrUkZJMTBZ?=
 =?utf-8?B?UHNHTmVoTzVFZFpEL0hWbVpFWFhKQk52ZjRiS3dTaXVpU0NYSGFrSDRldHBl?=
 =?utf-8?B?VFlyOEJoeUhmdzBCb2lWVHVBd1R6enFsQVl3RytDY2dOMXFPcFZBeHVOaGFp?=
 =?utf-8?B?dzVFMHZycEg0amVYZWVGWU1NRktLYU80bzRRdDFNT04yNkFrSmJDN3dhZm5z?=
 =?utf-8?B?bTNVZWZOcE4rWXluQ3FtZDNWdnM5U2JMWllpR2FDMnZlRHVrbExUWi9KQlkx?=
 =?utf-8?B?cHUyLzJ6aXFEazFJQjdnNFFGWDZXV3Q4Z1A0RXltdG4vVEtISWFFeTc4MHJv?=
 =?utf-8?B?ZVZoY3NDMzI0eWhQVFpvT25pUkJUUDJDc1phOUVkb09MZmFpVmxabXg0VW9m?=
 =?utf-8?B?SmduRnlrU1p3MUZFNXVRdGZ0Ym9Ca0ZlS1VkVTNTUTI5akJQczZ4bzRyalR4?=
 =?utf-8?B?VFc0VmVISlgzY0dXZU9pWUF0MVhScThSTVg1WDRTeUtzL2N6b2NJM1ROUUFh?=
 =?utf-8?B?a3RDcTZVSlBPbzU0OTZtTG41TUs5SUE1RFNKV0FBN1FZTFZHQ2lpbmQ3VVFW?=
 =?utf-8?B?TkltOTlJWjQ4dnF2STVua3doditMMCtYQmRaZzg0YjhSMTNQaDZEU09QV0tG?=
 =?utf-8?B?OXNsU0YvZldEYUJEQ1cwQWVQVGpqYWU2V08rYkE5UCtVVjJObHUveGJlNGZq?=
 =?utf-8?B?WEdCTkhHMThpSlFCTkZMd215ZWtLejM5Q1NPTmF3dTJmMWhpa1JoTVpPMTIz?=
 =?utf-8?B?a3dRK0s4RmJsckFwREdWcHVZSDRlK1pxRmZGK1VlZjBOQXRXczNIbmFwbmNU?=
 =?utf-8?B?Q2s5MTZoT1RoYUxERVU3S0Z3R25RV0RVMzlPSGFlQldYUmdXTExYU05OcEZy?=
 =?utf-8?B?T0JEVHc0MlVuQXpSSGc3YU5lRU1ScWZwbCsxS3AwMXc5VXh2a1RPVllDdFdD?=
 =?utf-8?B?WlNiKzRBSys4c1ZVQ0dkL09JNGUvUFMwVTlsWUZTZWFVa0dDSlNSNkFvUUZG?=
 =?utf-8?Q?C28ce6LYUMY67eX+32?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827d43b5-ba3b-4061-6f7d-08df17e69cdc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:45:35.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUyvwWbb0rjwJbiaLYjDok3EEkGQcfR47n7KOso6vsz9EwAhJG8TOadOksFMS5E+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999234

On 9/21/26 15:22, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2026 at 02:08:47PM +0100, Matt Evans wrote:
> 
>> Not quite; the priv->revoked flag tracks temporary periods of
>> inaccessibility.  An example is VFIO resetting a function; the BAR
>> mappings as seen by the CPU and DMABUFs made from the BARs are all made
>> inaccessible before the reset, and made accessible again after the
>> reset.
> 
> From the importer perspective this is a permanent revoke.

Yes, exactly that.

> The right way to view this flow is VFIO permanently revokes the DMABUF
> FD. Then instead of forcing a new FD to be obtained it replaces the
> existing FD with a working one.

Well that is a little bit problematic. It could result in a race when you have multiple importers.

> From an importer perspective it sees the revoke happen and then that's
> it, the dmabuf never does anything further. The importer has to unmap
> and start from scratch, get a FD and map it.

It could also be possible to wait for the reset to finish before giving out a new mapping.

> That VFIO re-used the FD to make a new live export isn't visible to
> the importer at all.
> 
> I think that is where this "temporary revoke" language gets confusing.
> 
> Call it "VFIO reuses the FD to create a new live mapping" is clearer
> than calling it "temporarily revoke" which sounds too much like move.

I would avoid that and just re-create the DMA-buf fd from scratch. The extra overhead is negligible and one way state transmissions are usually much easier to handle.

Christian.

> 
> Jason

