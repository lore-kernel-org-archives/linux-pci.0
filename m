Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE403CFF7F;
	Mon, 30 Mar 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876181; cv=fail; b=sPQRWrZE4NDY60ITdivVUsDbgoTNqFHJl2wiR4XkBHReDUd/TTl1iu7/Y+jihU7d4eZL0+dsvg1I7EPC3wRHcMvhoS8C3dkXUHbu6xZTkcTtaiJEwIipZl9mO/jvW+cswhr2NcFUdWKjGPuuCMJjRu6AOLEvBYXqXedqAUNp5HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876181; c=relaxed/simple;
	bh=WbnTzT/PQqRW/rwrrnjJMeDbY4NlrFb7DJgXl2iYDyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVnHY8WHt0aqp78YzeIJE/Xe/cBZQToLERnfpqdgKcm6vsGNTHJnHH+Z+cLpLcRZFAcTLy537vFQgIBO8rsa9TEr74U/tfrz6C41zkgtHXhtUmjE5vRnDrhgup778fxsASJEQ9kUyyxqC55wzIk0zmwrAiLzVI+M4ZjTJXEpDfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dO7UnRnZ; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dO7UnRnZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl9vLCU9iF6Vrl5bUdW75yyBu+mdUYE/9Csi3g1N0l4va4av0kU0o4+4ikBe6M1K9B/0w+1nfPCiyvSSc83E/F9iCElBGBKw5cRHL/vIe0gOBNSH5ULdKn5fmKc0Zzz4gYOQeERMIps+g0ika4NhXk4K7icbBk630u1QTuUmZvxoGsOvj7uk+LkUucWQIbRi+kmJGRXQWy+qn825v53HXozyc/vsuMAqEn7cmlDnOYH8g/duYFDIhER21wxtBtz50PGJk6X4/8ZGzy/bjYh3WzWVGPjoNmXgG4J5FF4mtqKO4Ihwq1MjHi8yBdFqELWUbkH47v3aHhP3u/iT4GCnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gESBleSiu68LlYgYa9dseiXR19eWHc7foTZItGc94ls=;
 b=fWHNZsKiVC8hWWZ8IfLYptRGDzzF3OPsNLglRzZ6s0dUeAVrfdKyk9hH9uM2eXBSKNUW6GPip1ln2rInytjb5dAZbkz6V6EGou1+XyH6lLLCH+icqJmZzZtFEze1DN4rX/Q9j/ax2TCt2TGs1Jv4xu3/MmfVGLbojJDnVTxi46QNqNpyuakWXSUrOzaW2KR0PV1FGBkqCFQhIP3qDfSfl4d0L+kS83iLkfTZ1FC4n3P+ncEcvFi26fY5bGfddQ1iZU6CVAzaUnVMZ5KIe6wpgQKDoIAOi51u59dJ7Mi3nxUl4xvQz7d+gb5Xpfw3RY5M7IE4cRQbhb6Bq9Onz7ZqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gESBleSiu68LlYgYa9dseiXR19eWHc7foTZItGc94ls=;
 b=dO7UnRnZMv2fg2XjA82z/5Q+lDH9QRDCiqSvRSH/T2psXP1vz/s9xowDaFIdcQzAY2N5XP6VYDBWrUWxil59n6CxE90y/B/DONVZWtsTJ6xMvQouWt71LME8o7oh40Myv7BQSPtET4XR58AqYDqztkcVV0qnzBHHvEeaL2p938Lcfr8gvLIHJbzsLnr8ZtligeQPXZVML9tg8QGyMHx0TE71BJxYnNRIv1kuqgj00jKYsHvetJd+1CUKcwwxGfE9nrLJifeHTtVaC88IKKu1NOVVUkYzuFQZc7ZgBQ4p+cSBh1PnjPbhlUn7FeGeCkvFLH6ZuS4vLSM5dCJpxcGohQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 30 Mar
 2026 13:09:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:09:33 +0000
Date: Mon, 30 Mar 2026 10:09:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/6] PCI: Validate ACS enable flags against
 device-specific ACS capabilities
Message-ID: <20260330130932.GO310919@nvidia.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB43991B1D3735DAFEB73DA37DDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR01MB43991B1D3735DAFEB73DA37DDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 990af9aa-b8c7-465e-43d8-08de8e5d95f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jRtEPakb9lKt1YjLjqgSnS/NrdRl0oaKM6zgoDSzfA+uLGgp4zD+ufXhEfOIXteDr3vt9Z9ySzAft9TA3Rbh+OQQ/Tt9O/o3aaUExsDv+vSoA1ZL41FYzwHQ2wZvMArHgxbXaq1PAumUUs21XMKICL3SZ8Yd0LbSn/NlIjeLl/kh0LMqOce1+jUy0P51ld8olcn2m4rfsxkoCzPdqQ6oBHz0/EzljtQQy//jEkhpMWMzYNTmcljmCN35mD9MA5DiQEu/engQWfWzxVDwkeYxvaCCpEEhUjafUFs5BmoXrK/pfLtH5BrbprwhFIhjRbt5yrMrgW9l6FUoxZS9ALTIv1z5Q8c1FZZ8iUzNRcrkhVrlnyhyDwMNvgH3z8lHUgkOFA5inztcGYDQp9RiQNby47A7cC4EGcow914KAqAbOwqI6AMFYtn9Doa+eOvE+CL7KrjiPfDjc1PK1s9Iya3v76U0l1ew1dGzSpxSLonR3kAMj2wnpv0sTOHMINxLSjjWjKosZqf3qpw5mdw/iqgjOwfmX3QLV0ORdfC5HBFyx0Klq2M05O9xtD824poW+EmQcJZNUL8BHudB0Rv+JPAK+JCWuPO9vocNLu19QrZFbZcgYRvr7Xg6bcECv8JnQlwofv45wzeIDGrCLjv1+OpzSizes/SNTwGyesuVsr+tdb1IzCvLJqbZeEPs6mHAtiX+/pmfuJL8wFd0YBt5qbdncXxsgfde3XSKZG4KsccbzZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eLRnMEl2R9x4tEQzKpWlDWGfQYkJyd/RqjWCa6r8aMd2aUV70zDf+KEMh2o?=
 =?us-ascii?Q?HWb7oQ3cqQ3FTrINKt5S+OLMJu80jdlwSHn0cr0VRnhpy4J9RMSoQ8r2j6X+?=
 =?us-ascii?Q?TF6xcKsIts2BkyrpLvfZX4r11Etw6b0sKsGZM8awfjoj0lWUcwAOHNZISe1W?=
 =?us-ascii?Q?fOjI2J2637Exem1K33HzdKbO4sEIVU8XHzb6r5Y9yiodfJkE1rU+e8N+9ft7?=
 =?us-ascii?Q?V4TgdmuObvzrzgIr9/07wx1bgz37CajqZqaxdcwJwpqW6o3MdUaiOiODHguC?=
 =?us-ascii?Q?ofjp79asy5HXt6vFlNQ8W5id0dlB7DMync7xRkxio19smXKn1Dr+KAlLQ0+R?=
 =?us-ascii?Q?JlDIsDBcUHyNUindNOUR1/hEeZu0raw3zrPMmGzrWirt0KR64fqMekNVNYR8?=
 =?us-ascii?Q?f0o8f51UYmlGyWoMwe+RniDb0Msrxkjkn6ym4pR1DcPnaEg1Uuyt+FoSufsG?=
 =?us-ascii?Q?5bxIuSDKfwYDxR2Ebqd0Rg7Li+CwIQVJzC4PGafWX9dUBXV7CFJ9IPVOSBQP?=
 =?us-ascii?Q?5k3t5ujy4oVC2OEoptuZseoXviNwIKwfl9r9+NZci67/1XA1xkmct4wWrYGb?=
 =?us-ascii?Q?yzb5ApgzG04dwsp2eYRqhrYi6L+SqpuYCUdsRppflRQBlZpqCQ1sKuNZrBtA?=
 =?us-ascii?Q?ogZ10adSvoqvxxezXWR44RUmFuxmtzRwsFtGsYP4rokhgH4qGa655mIi9q9B?=
 =?us-ascii?Q?7PHBrwKrag8doVgQaO95kFytvjB3Rd5MzSHlc9UzuGXC8IOaWeBqVZKuiMmX?=
 =?us-ascii?Q?VU+HHWT7U70xUhoc3oPbqKNfgcKJcVApso/pgZg9tKmIJp8xkciuwN255xFd?=
 =?us-ascii?Q?lx2R7xVDm5IO+mn+BsHoWGDf+TYVdq9YQTOQUX0bC+ixHMH0prCMo6PUCkvE?=
 =?us-ascii?Q?emZ57JMMhNQMdS5bDifMDClcpExJKKJtAdqft+G53Xvbdx1oONhvaJPb/lYI?=
 =?us-ascii?Q?6vTYeN0jbTeTcuS/OcTdD1Mf4AIicmZKQ9VtBgOpiplNyipICRcHYdXSOXlZ?=
 =?us-ascii?Q?qFwTdflsbcxFpt1qC4Yh7U+G4U+imXXn7gPWoXNX68tdz7j4NrJMBBBaJZcO?=
 =?us-ascii?Q?71hJaQ3KsaAhJNNYacJrmff7wABB0yUy0fcDnD5GDWSz2fd3OsifgvK3Lt1Y?=
 =?us-ascii?Q?ZW7R99wY1/Vor+BTWKqX+uhIn/YVvdXt4weiaVDkPVHsqXwEx738zPXn+oe6?=
 =?us-ascii?Q?MGaxCebO6tzcuyzFkU+eTZRhhQwdZXDvJJMVTiDQQt+4EOdDtaZW4O3DVPdN?=
 =?us-ascii?Q?388SW5qBFh3L3/hzQfl2SGvJDTYarTGuNGJRSjquiDFPZwA46fbtpV+3G2yy?=
 =?us-ascii?Q?3wm/sB34iX8JLYk7STEUU89XHjaDw8UzKHQ/e13XZzhP2uoCHyWTR0TAd3Ex?=
 =?us-ascii?Q?m6TynGGBIfxk9aR3Yxw6go0MOFCw8ocr5qyJSvcKczkEO2L94iUGt2P+5r8f?=
 =?us-ascii?Q?5xZ13ytRLaOjV2ROaYLnFYJXzEQEXMOmo5/GfA2tTMNqxSXPZLhOJWZMP8OI?=
 =?us-ascii?Q?gYqSG4vV5ud2jmWA9RqRe+3iQdeVv/JsEdXQanQH5PckbZC12K5hUlFPCD05?=
 =?us-ascii?Q?4iL+rv86aoCDVx9Qvz9AB3XrheWcGb9DcuHF+S9tuBS7mztTuEmcNd3+NDT6?=
 =?us-ascii?Q?f/Z8HqvJiFh/4flGhf9XlYyp+bkCgU1tZerashaCZ8rrFh2kUAst5p6gUZjk?=
 =?us-ascii?Q?eUbfkgisVd7h19jCQs4w04alw+cOZkBufuBXWG7JdWxIAwQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990af9aa-b8c7-465e-43d8-08de8e5d95f6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:09:33.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4+vRoqmWeO3ibvl5gBZOGs+axqjlG4Aunoi6IifNT0QQSbJJWFIJRY1WYFlPkTV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA

On Thu, Mar 12, 2026 at 05:06:32PM +0800, Wei Wang wrote:
> The ACS flag validation used the kernel's full set of ACS control bits,
> which allowed users to request ACS features that the device does not
> support. These unsupported bits would be silently ignored by hardware.
> Validate the requested enable flags against dev->acs_capabilities so
> that only device-supported ACS bits are accepted. Accordingly, move the
> check after the device is matched, since the enable bits apply only to
> the matched device.
> 
> Also change the validation to apply only to bits being enabled, since
> attempting to disable unsupported features does not cause functional
> issues.
> 
> Finally, improve the error message to report which invalid bits were
> requested.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/pci/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
