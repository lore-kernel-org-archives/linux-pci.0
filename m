Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965B3A1A55;
	Tue, 15 Sep 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470814; cv=fail; b=N1ldf+SGXHfI3f6sSobNq83McV14aNwjLOFBQfsOTyuoUaQxMXSLQwEZkQMy1ZMIA+PXr9DeZgO9MCuLq4CDW5kl9fh+QUveQ/dSCgHmsjmfINTjv9bLmWqHqzRqlc0nDvSNXLiZYVbOnS18orVYCLYnwaWlZ5YNTW9Zs42a6JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470814; c=relaxed/simple;
	bh=cJZQWgAefgMA+W9/IFFK6vrMLatwR3jgMVXDeOacO5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZybKi5SDInuavdIuObYEZKxp3SlvgvFMOgmZ6XfvuQaR87nsgv2Ay4SI/PlEmr9J4iEBMvIr0JWoAFUZWjRtw11q7f9+mRy3HA4umspMIpq7bnZuORvBBXTTKMHejA7F4OtQ+dN0Iw5FCfW4wgDikJFI1/tU+XOAxAAx3XcoKTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LtIsse8w; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LtIsse8w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iU4M6P/cZ9vAY9S3sT23n+B4/nCRFd016IYHveVfDuhUuj2wh6TxZc7YYMopCyTO/YyPA2u2yhPWNz+pP+/ndBiz7snzC5qdTeV2e5uoe1DBpopvZSowVCqkg4giQytAjZm0nKlWo2Weri4haY8ID5gtjaTqj9QmoTTvX/62A1luAFTfDa1aI5rIDqMXhiuuYFbJShZ/+MlyycMa+WBV+J+LMipk+Gc0qvyGl3qiawhZNe5aO1AYWZYJ4qFLpyPxh3Dh2qUNOKu/BLZAFea5z7JIkujZrvl1TOtKQYvsZkJD2rSBsvmSjIvueM96uV+yC7yFRJCJNQ6XYVw+x1Fxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mfzPhlHlVkkFCN79wIfb8twIHHdjKYnuTnttH/EXAs=;
 b=wjjEQYyCHGtHBppPf6B8kiBoKAV6xV4TygiuFzK2Iyryh2Seoa8ORnacoHsM/8DuzrtVtkdf+AG3cosARZmOiTnrwkxy2aFBdToFvczKIFKngdbpH4IRPz33PCg29uNlzgNfZyCdBe0DmlmeG3X/SsOq6RqPFs0Avk+JhA6FqkNDJR5pqNU4ofcZEio3jpOIvyZQ7tETF14orfTgho4p1iug9hJRSTppHiKidY5ezOdtJxI6n38MvQsMhqEtOFi83jyBOuCK7h5uTufgb937rNB/RzHwK/BJAtVZo+STuAimTIcQlyiI6L7BsXGxH8rbj+B1PoW/0/EPysE+NNtEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mfzPhlHlVkkFCN79wIfb8twIHHdjKYnuTnttH/EXAs=;
 b=LtIsse8wHHjJq5ZSbPzF2ohBgIrXGjEOD6lamiMRMo8sChvdKHu8iyqzAwg0PpMyQEADPe/MD1eLUFUnNiwFe02BMSkksbH8PoVC65twvnqPRmwo2HWjt9U+TV8+dJYvdBbyWyt4zfmvHNfbb6RkJlC82McBXndXymUuFLz/GDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 11:13:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:13:15 +0000
Message-ID: <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
Date: Tue, 15 Sep 2026 13:13:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
To: Leon Romanovsky <leon@kernel.org>, Matt Evans <matt@ozlabs.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
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
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org> <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com> <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260915072002.GD13683@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: d5809bf4-3654-4684-065e-08df131a569a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gvZtx1Sh7/l6vBqtMbUG3gUsFEOJTwX2/hbgQ2EN5AqfS8bFHV+xgmDZh7xghfEqy27EwH8mT92s0ocpdOK/UKqkm6YljyLFonSIUYFwch/y6mAAckoF23N3mE4skcNRVcFn23Cen6ztiXs71YCSCljAIKdLYBimaN+T2gzUnC0RLvUK7J/aidrnschg1QV0dWxi0r29Wp+KA2a9D1huwc7ZAm7+4m8bmfTbHEiZpWsKFlg+JwjzXbNL1Wl0SEFE91+qnakXv537yUhOHcA/c3WtrKCrUUZZ7d8hJd3SDke80x0FeXDFaJkGCfd0DO4722CU82LIwac504nUsq6L+TfJ9gKbmUMSeWjvz6DY1nFzLmI2LGRlyqmp/DlZU87tHS86Mctt4zFClM0FxBltxGH7WtJzxry45mkUD3Yc/UlTzu4/E65I5l569M3KVHtwrsNbRjC22mRkDcjsT3CPd+JDAh7iCajB8aVT7SJbC4jUOI5L/Td0Xg1ox2j9seesYJjxW5ZSnIlj7uEbbidkk6mJaYvJJXgQiRJSgFMmUEZDtMZsB4HhvIKtoZncXQwqwa0cFv+gnwFCS4ztHFQR0GveIF8VtE1w2zEzr4V5aIJq6YYXJlRhwCs824HsqCpQoo/IQhkKawpAJpI9Xnb+NiFnN645Mr09noekn4fBeMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXJpL1Q3cUEyOGZQVDFzYkFvV2tIZHRTWEdtdnI4UkJmNFYxUTBiMjBwR096?=
 =?utf-8?B?MEtJZnJHQUdmaWU1cHB1WGVnbVFhMFc0QmFqQ3dHVjNkY0pNQmptZVhtNVVG?=
 =?utf-8?B?anNaLzN3MHV5VW9kbkFsa2lXZVdFUUprOU9vK0pqcytvZGgwdFFHVGcxU3Nq?=
 =?utf-8?B?Q3lVN1VvaG03YSt1VlZVWDIwTS9ZTnFXVDVzTGVQaWVIek9JZjRKUmxFRVpo?=
 =?utf-8?B?VW5OT1NqTVZOVlljc3ZLVEpoR0RHNGE0VlI2OWc0TFJlNndzWXp2eTQvVDFP?=
 =?utf-8?B?RStRSmpkamkybldsUEEvNm55STk4NkVJNG1lazlyOXJOaitVcGl3WFZxSlRT?=
 =?utf-8?B?S1d0NDlrVFNsWVNZZFRQOXpCSHExQ2xyZ29iOEY0ZHNTWC93OEtyQURpYmtL?=
 =?utf-8?B?WHY1MVhWRWdxUHZ4MElYMHVOdUFiTEkxdDN2elN5VFlpV0E1a2VBejdZTXor?=
 =?utf-8?B?ZDhJMS8yYUpWZnBjbkdBWDByMENRaXlqWHI3eVVHaEprWWRWTC9xQnh4WkVn?=
 =?utf-8?B?M3NNRXBEQ3RFdUVTY3MyTEM4Y3kwNW5DWFpyQmdmbVl3U3NjSzh6YnlLM2VV?=
 =?utf-8?B?eGlZb0wyb0NYU24vUjhoR2lLMWx6WWF3emlCVmgzR0NIWkJITW9UTFpCaEVq?=
 =?utf-8?B?ajI4UDh4ZHJsSjZrcUU3TldzOC9nWUR1dXdHaVloRTUwYWJyYzU3VlpJamhH?=
 =?utf-8?B?bjZBaXFaZjdUR3p3V0l5NXJLZDZLb3BlQmFWVWRMZDBVMEtESlkzem13VzRa?=
 =?utf-8?B?SjlYYVdleDMrdGNXUHVkamJjUGVDN3N0TGNLeTMwZzlBZjdCbWZVWUJIbDVs?=
 =?utf-8?B?SndkSUZ5Y2tnMEd5S2pWbXQ0MXRyOUhGMUdSY25MNEM3OHFFR2E4WndzMUpR?=
 =?utf-8?B?WUNhaGljMm1GeFh2MHQ2Q0tONTh3cEFLQVlZSi9SNThRN3lFR3VvUnRqYXlk?=
 =?utf-8?B?b3Fvd05MbnhtWG5qUHlmRWpBSmtzbjcxTWltN1FiOGJLc2w0YyttM0h3UUNh?=
 =?utf-8?B?anNyM2RwSzA5NEhXd0JuV0l0cElLSFMvZ0VTamNYTC9ZN092bXIzUC9tcWVs?=
 =?utf-8?B?eks4WXBDZnU2bFVrL2dPeWE0NWRLbUJobWhDL2RNWFFvZ1Y2c0ZnQ3Bpd2F2?=
 =?utf-8?B?TEI2RmJFaHQ1U0JVTkIyZmlsNW5pUDZBSVpDVmNra0NCSVltVHZrMXUzSnUr?=
 =?utf-8?B?TDcxSkNHUVVrQjZLT1kzcWVrMWhtOGhrTm5QS2lhMXp0bGhhZzVDVFpPd2N4?=
 =?utf-8?B?OGVPQmlnVkttdWt1TnVqb3JuWHlONHhqUElobitvKytOdkRCWFRWMXVuUGsw?=
 =?utf-8?B?MTR4cWJPUi9mU1V4TGZ2bVhNR1FsU0lLMmJnbHNQOW9Xd1ZQbWdiZGlUdTBS?=
 =?utf-8?B?MFhvaTQ0Rmp6Z2dDQWtKSUNKN2FnYmQvUlQyeVc2TmJjSFlrb3E4aXFLRlBx?=
 =?utf-8?B?MWRaVEdHTkdHeGRzeS9IQ1hJYjgwYktDSzBpRmg5TVRKT1hQMldOV0QwSGdM?=
 =?utf-8?B?ZGdpU1I2NGMralAyeVFGc1JjVzg4alM4dWdFTlFkU1l4YW1HSnNTL2N5QnQy?=
 =?utf-8?B?V1J0NE9vOTBuV3VOT2ZrZzA5OVFKcUl4aWRpRUlaV1d6cE5jZjVuYXVsTm91?=
 =?utf-8?B?ZmcxWWlUWEJjMXNxWHFFZFYyRzJ3OFQ0aTlsUGxzUnFnSUEwR253c25Lc2V0?=
 =?utf-8?B?VVZSbDZrSDRqQzRLaUxXeHR6T0hOT0hRUThtcVlwTkpCWURRNXhrbTgwUGVj?=
 =?utf-8?B?cjJnQXB0aFZ3SERFWE5Iem12dzZKWTlGQ2pkYkdSSFBGNUc0U2FzRE02ekQw?=
 =?utf-8?B?UEZBUGw2Z0J3MmdWRVdCTU00cFBhSkdMZzVmZEg4UFR4SG41Y0N3LzVVRlkx?=
 =?utf-8?B?T1hrUDNVK3RXamNpcHQxN3J0aHk4d1VCYzdWYTBNRWRnVVpzUTNrQTZYRVZj?=
 =?utf-8?B?OStYN2U0Qkh5aEY1YURaNnY3MjdKL1UrYWVkWlY4d05QOHcvWkVhL2xCZUJp?=
 =?utf-8?B?OVh0RkF5NjFXSFRuMTI4OW1ydHFEaHlOS2VtMHpLejR4dFdVVGYrRXJ5ejJ5?=
 =?utf-8?B?WHdPVWo3TFVhUGZKQUZKb3QxUTV5NUV1UDkzeUdJVHFRcGJlMjhaUUc2WHNq?=
 =?utf-8?B?RmJETlJCMk40VERKdzhuNnNnY3ZCYy9NYjhxQmx2TmJPTVRBZFlwNnZMTnIv?=
 =?utf-8?B?czRhc3hHN1NMK3VBRjlmUldER1p1Z1FaMlY5d1lyTVdoMWdiRkU5RXBYdEdL?=
 =?utf-8?B?U01OQnYvVks5dkh2NFFqbk5GdTRXZWZDaWoxQVBXMEVkWVR1WU83QXpkYkQv?=
 =?utf-8?Q?vy7vYN+O56w8umM8Vd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5809bf4-3654-4684-065e-08df131a569a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:13:15.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DjmuVrt4kUM+9W3Vl1o97ZGMZFKuKQOBzcWpgYhX19/Zjk0uknt2iscnTPdXvk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

On 9/15/26 09:20, Leon Romanovsky wrote:
> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
>> Hi Leon,
>>
>> On 14/09/2026 12:54, Leon Romanovsky wrote:
>>> On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
>>>> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
>>>>> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
>>>>>> Expand the VFIO DMABUF revocation state to three states:
>>>>>> Not revoked, temporarily revoked, and permanently revoked.
>>>>>
>>>>> The thing is that "temporarily revoked" is actually the standard
>>>>> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
>>>>> for VFIO.
>>>>
>>>> I think temporarily revokes here means it is revoked from a dmabuf
>>>> perspective
>>>
>>> My guess is that this is more of a "change owner" operation than a
>>> revoke operation.
>>>
>>> The main issue here is that we have to guess the semantics instead of
>>> having a properly named and documented operation.
>>
>> Apologies if the cover letter for the series and patch commit message (which
>> cover this) are unclear about the motivations and semantics.  On the commit
>> message, can you suggest clarifications:
>>
>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
>> ranges previously delegated to a subordinate client process: by
>> revoking, the driver process can ensure that the loaned resources are
>> made inaccessible when the client is deemed "done".  The original
>> DMABUF is defunct, and BAR resources can then be safely re-exported
>> for use by new clients."
>>
>> Given what I'll explain below, do give suggestions please.  There is more
>> context in the cover letter (the volume of which I didn't think appropriate
>> for the commit message).
> 
> 1. Do not mix "driver" and "client" in the same description. For a
> non-native English speaker, "driver" has a very specific meaning in the
> context of the Linux kernel.

In the context of DMA-buf it has also proven vital to clearly use the terms importer and exporter to describe the different roles a driver can have.

I can't count how often there was confusion because people (me included) just used "driver" and it wasn't clear which role was meant.

> 
> 2. Explain the lifecycle in the commit message, and why "revoke", which
> is effectively what the importer does, is not sufficient.
> 
> 3. The more you put in the cover letter, the less likely people are to
> read it.
> 
> 4. Commit messages should describe the patches themselves, since they
> are what remains visible in the git log, unlike the cover letter.
> 
> 5. I would call what you describe as "temporarily revoke" is actually "reclaim".

+1

Regards,
Christian.

> 
> Thanks

