Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED342BEA3;
	Thu, 16 Jul 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213777; cv=fail; b=bGTs0ZlFgA5KBd8XW6xJ/jrp7yHQnl05ZxMX7oDow7AGsIbq0xpPObfrN6PKt4oAWJ54aWByDYGJMvJxyFbfIPqheZ70SoZ2Udtdud4UdTnQVergKbG+aaF3uPP7IfQ4zTrgXNPt3iYJleCvDfOO/mWTNqhOMvbRKa0nT8WMcGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213777; c=relaxed/simple;
	bh=k4czRKbMIowcQhLxEb+bxMFXis5AlwhwBggokMkU9TQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=aw2dEU+bnbVRfM1DWTiOx/3kI3gCYB9gMTowAI3SsxpjhXOKjdhs+v6h9UlieCKVPFD8HJXkY1/Go9uGPhJNGDfuOXnfGD571jFjcDnOWnvpX4QJiOej91+rPa7I9dNiUI9VpqGsxQyQ5RUGt7uhd/SpG2vYtPmGbdi3KkZNpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WzcC6YLH; arc=fail smtp.client-ip=52.101.56.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WzcC6YLH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1DQwZBFhV5YBM7E0u2w3FB5BdEidt6vs2SOl8hZXMLq8V2AByYnbJlY4f9lOKmTzVOC0MxkDQuJqMTQh00oCdfTcH6WFQ5N475R7eB86G0ntSEV5D/38UrG9hT+ja6ILe/vcnXjUXiSAZkEvqRw/iKyY10bgtijagI62WrcZWc6akOAuuAHEPSYmDN3545X33V0MnmDM0+20yA+2xnqq00H85Gceh4qpNsLWuQo0ZZ54QZpQm8r0Tr1h5ZOaMH/j6FGOmzmqkJamtWT2VRo+OwqDExTPNC7c9EzjMwNRypqwwtk2QvNY4bT4yc42rsT1IwY1iYHAY04KIJZDwHbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCAclAQZL/0N8ioKaFF7OJbVPN4rrczjTLUGPXxY/bA=;
 b=ico1h9LaHB1NBp5Rse3BKwDWuZcxukJjs5adZ47KPDLwV8kKU/ydsC/r0XA0GorYnfZLuAX7STO+Xk2UVhgwFwSwRF2PyKxZXzjTGEK56VC/PYAKsA/5ZpshJAFIupz8mOgump6pQHFwGnY4xz9dlJSnVWHLKAbjPMe2JdPKPuH8Lz+ZotTrRQ3pySWrsLt3+WXWOhws+EZQWfjdbBiRLbNK8sG4Cq2wQhG2PPfLXouQuYcQ8pF6d0y5ItncQf7QKXW1cQRQm1cgN6UFHMQETWBx6S4I8OpLg5ReZJykDts+bIS2ssYLYwZzH8LXFmSOdpf7XS8HwZIw+iyWSrx24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCAclAQZL/0N8ioKaFF7OJbVPN4rrczjTLUGPXxY/bA=;
 b=WzcC6YLHfBcgDxGoryCfRWf1i8jEJodgZTy5yYYxEs56I6Vqt4xeuzUJClGQ3ov8Y4FFPZrZKj78xhF1uW0ONf7E7iruV159KEtWBBq6O4Kr6c20f0Mw8as20uE9C1V1tjdK77XTzrn1AIL8N4GWCkIot/Q+ZowEDcYvowCU86jSGRrvVFsNKTv52/nSfuwZryYZZ2v0aNWAFpFPewL5yR7beZl20SCzPb+CVWjQInqdE7NkOBPhjHMpf22/13bAEIOITc7Xzspfa44dhLDrNDLqNK9c+Alcr73sJXdTyWKQ8U+k2PCYNmma0EClA5/heBdFz9xoXeLSkTxy0bHmaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CHXPR12MB999243.namprd12.prod.outlook.com (2603:10b6:610:2fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 14:56:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 14:56:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 07:56:06 -0700
Message-Id: <DK02ZSVH8H43.W1NXXI0GNYGR@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David Laight"
 <david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] rust: pci: add sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260709150206.1046839-1-zhiw@nvidia.com>
 <20260709150206.1046839-3-zhiw@nvidia.com>
 <DJUEWLO5YJFE.3BKHFV0J9K3TA@kernel.org>
In-Reply-To: <DJUEWLO5YJFE.3BKHFV0J9K3TA@kernel.org>
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CHXPR12MB999243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdb5058-e73c-4519-e5f6-08dee34a6022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v5q48CYe/1TRvyNCBVX+FnXrokBTClumXgscFmYt+DJJGmRx9GHIeuekS6KnzK0ztPnS5lvyVBdopt9KPLNb2qG5H36F+eGQWIY7jcBikE+RdlUsuCYP1Bj0chmbkb7mQOt7lxypwe5MkU4A8xpoyXqjZw0WECe6Ok+Y4MZcGySTKnFHoT6kzugCy0nA5/f5SO/ot33e7cVOWZ2pALIEE8hL2BIl4152cYJhN2guraNMCB8d/AAx3fJME07XOFEFtFsTc7BCGUDAJa5tFsC9BE8oXrGy9STkgNNJp9C/AGZtLKw10qsNiJyW2zgDRkX7mmb9MPRdFEkHr1vX0YdzCenBH94aq2O2IdjKAEmt7XbNv0Qc2DmEBnIVnM2jMa/UAL2ynATQrMlmSTQ1L3qx+c0YGppee+PxTnArmDXHK/1uuyJcj1QNI3XFTHquHRf90a1n2gCNwC9dKYgttlyuS3INjtVP6G7t7zLF+hBEDqrz8QECNycEetCi0O8R7CSwMwRinQoA89ReA/YDxD7Yth662Msd5dnfjfRHQ20Is0HTwd936aTnqCt53f2yZB9iwGK/LbypQpK0LT0bHkqdI/DnAQFa1yH2JwSHbX/Np2x7heYC4Zkxlcb4kgjMixIYCFitViz/yXRb8bamvxBpQE7EUOrn6yWDTrY2XXnxtYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VisvZFVRZU55NjlrdVd3YldiVDRWUERmYjhUdm1Gdms1MnYxVm1ZcXJTdGIv?=
 =?utf-8?B?Z2w0RjI2ODh3NmhUQkpQMGFBenUwcWgyUGtBRDMvMDA1QWt2am5kQi9HMmRB?=
 =?utf-8?B?RmhxVHNVREJZM1FmTHpoa25oRjZ4TmNsdE41Tjg5LzNxRVVkR0srQzVneVpV?=
 =?utf-8?B?NWhlYyt1elpNb25yTUI5ZjU0Q3RRSEFqNGNqOEt3WFNvKzdWc1BjOXlPMGZD?=
 =?utf-8?B?UXdVei9UQ3VJMTRoeXpJOWRHSTVUZ01welJMaFQzUjhseTZxMjVaUFVOeUoz?=
 =?utf-8?B?NXVLZXR1TFdGeU5qYzF4cXdWS2p3dllGd1hSS0RHd05Hd3UvdkludjkwVXV3?=
 =?utf-8?B?U1dxT1QyV3Z3UDI0RkxWTTd5MW9KK1o1TmxLNWRTd1JzeWtSQTJRVGtSclMy?=
 =?utf-8?B?L3BlNmpXU0FSZDRYVEVJWW5rRFFuaUJaMXhUemhVeStiZ0dYcDk1M3BtQkZG?=
 =?utf-8?B?L0d6MDc0VG1NMVRyb245OTgrRHhXTnFKeVdmQkkrRStUYWx4bjh1djJJN2t2?=
 =?utf-8?B?OGpZZTJMTTdvZXVIRU52ME9xTDA0VnFra2VsYlhIaFRnZ3BJRTNIcjVzTzM4?=
 =?utf-8?B?QkMxK3V4NndKQnpJLzRPQkQrYnBDa1hjVHN4M0IyQTZJYmpqc0pFNCtpNmYv?=
 =?utf-8?B?ejg4SjVudnh6Q0kzdWJhQ0FqYzBBV05DSkhPbm1jM1BiQzNFYmJuRmVIWHBo?=
 =?utf-8?B?UmYzRERPSGFOMlRGYXA2cE5VQURObG5DdzRWcHp2WnlUdksyODdyNk1OVE04?=
 =?utf-8?B?OWZ1dzJJVEhzWlJ4QzdSbUJ1UlRtcExEK1JTcmZYWHlNb0ttZ25pOHZjY0Fa?=
 =?utf-8?B?Rll4UGtHeGlKdzk5ZWdkY1czZWZHRVJ1Uk9DYUxGelp2WnovUnB6RkREbkxw?=
 =?utf-8?B?UnlHUncvNWd3R1lUNXpad2NrZEFranVxNVdhRmh6RkwvbXdBdTI0VWM2di9E?=
 =?utf-8?B?azdUL3BuNGFFa1JPYjgyaTV0ekxHKzhBaUxkMFRleGtRR1o2VXU5ZkU0MWNB?=
 =?utf-8?B?OVBITnpkd1A1dStsZ1pUM1ZuNndveitHSU05NjZPN2xPV3FubTA3dzNCMEk0?=
 =?utf-8?B?RmVPc0gyS3FTcWRFNS8wOVh1aEFDbmNCc0NlaU5TdUF0TUdET0E0UDhQSDN3?=
 =?utf-8?B?NFR2Rmg0R0g1NjNNVmtML2Rod1AzS1lZM1ZZWVZTNEM1SGhRbEFySnVWUEsx?=
 =?utf-8?B?VmhxMGMzV01KMmJYS1JxQmN0eGhhanVRZ1N6ajl2NU1PTkRVNHNHYTdjTWp0?=
 =?utf-8?B?QVB5SHNkKzA3djdWVGQxMmtkOXhNTHMxQ2Z6djlEK1RjOUYrYVNDUllaSUR1?=
 =?utf-8?B?REZzekNwd213Q3htUHJYRTM1c2RNczB1dk1FUDlCUnFzcW5xM210YVZZU3VZ?=
 =?utf-8?B?NFVUYVYwRStMck1jT0hqaGVEcjBpUjFSV2I3TXRZdU5JU2p0Q2lCOXVWbjNB?=
 =?utf-8?B?SXJaNkh4N3NYYnh2WThYVmpHZ3ZKQVZURWgwc3Y2RzR2UzNMdUkyQkRKZW9r?=
 =?utf-8?B?ZEJRcCtXRXBYRndpT09XaXMxQ2tYRklMWmQ2OGpQWWRtMk91cVpPY0RpZzlw?=
 =?utf-8?B?ektkbzB6Z2t6VTRGbE9Vbzg5VUQvcHZGVHBCWktEMEFhSUhqRm9XamQ1UGtU?=
 =?utf-8?B?ajJ5SW9lZEF0eU05bGVzZlh4SFFFdUNoRlhLeEZ0WkNVVmJVcVY2VU51b1lL?=
 =?utf-8?B?bFdZNENiRmVVc01JNFhMd2hDM2UwWU5XK3dFU3QwYmk1L2pKNHBsdDROcmFO?=
 =?utf-8?B?TmhrYUNUdDkxckJUaFlGQ3gwT2pMQTVkTVlMZVp6aVNwQ3VCZEUzS1BYUGwx?=
 =?utf-8?B?M0FIZGloQmI4cFQzMDlpVS9uOUswWEh3Q0lNOUdxdDF0b29XakduVzFlN2w4?=
 =?utf-8?B?L1VIbXhUdml0MkdQMFdkZmZLU1RwWUtjUFhETmxzNTUrRC9QUkRTbmc0cFVP?=
 =?utf-8?B?dFVIKzNQcXZjcFlDOHUzcHF3TDhhYkN3d0V0V0VKTVg3T2FaNklzYmJRd3o0?=
 =?utf-8?B?dHFGd2VkTk94RDlrK2Y0Ukt3THN3ZHJQQXdWR21Tcks4ZkJzbStuU3pMbzJa?=
 =?utf-8?B?WmJTK2o5cWZDa2hmYnZmYTVVZUloLzZDajVvcStraU9Gekh6aldtWlNXcm9X?=
 =?utf-8?B?MUNoYkRVRk8yd3BXSkpOWXZ1TmdtL1l1ZEdHeVZVdngxSmszVjdWZnl6ODZD?=
 =?utf-8?B?eXVoVTVjVFFYVDhTRW5qUUZ6RzkvcWhsUmF5RzNIZWNmWVY2MjBSQkROeU0x?=
 =?utf-8?B?RE5qcE5nL0tDZDA2bWhEWlBDbDhuVWp0Q003MzIwTzROTkc3L3ZnclVYUGFm?=
 =?utf-8?B?WmppSDRwblVJRHp2LzJ2Qll5Q0JUbUJ0aDFZTGE5eU1IN053Z1VFdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb5058-e73c-4519-e5f6-08dee34a6022
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:56:11.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c63PO+c2T4f6PeBM7frELIrUW/L9mhXTz+EaqardiCFAlUE4bbmuOx0TR5ihBw0CpPctkJGQccg+jipbU8JIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243

On Thu Jul 9, 2026 at 4:00 PM PDT, Danilo Krummrich wrote:
> On Thu Jul 9, 2026 at 5:02 PM CEST, Zhi Wang wrote:
>> +    /// Returns the total number of VFs, or [`None`] if SR-IOV is not a=
vailable.
>> +    #[inline]
>> +    pub fn sriov_get_totalvfs(&self) -> Option<NonZero<u16>> {
>> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_=
dev`.
>> +        let total_vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(sel=
f.as_raw()) };
>> +
>> +        // CAST: The C function returns `unsigned int`, but the value o=
riginates
>> +        // from TotalVFs/driver_max_VFs (which are defined as `u16`), s=
o this cast
>> +        // cannot truncate.
>> +        NonZero::new(total_vfs as u16)
>> +    }
>>  }
>> =20
>>  impl<'a> Device<device::Core<'a>> {
>
> It is not a problem yet, but sriov_get_totalvfs() should go into the
> Device<Core> impl above.
>
> Once we also have sriov_set_totalvfs() this would otherwise be a potentia=
l data
> race.

With the above addressed,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
