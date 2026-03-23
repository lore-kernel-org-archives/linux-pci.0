Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73F3CA489
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289663; cv=fail; b=O1xrQanWZpa7uXKmCoo3P92RzGRSlV94iz6G9KXUuNwzohY0DVz0Iz8YA3mAyAJVplA4ONuCDHq84XgjR53sAasDbSsEj/KiDLCcQRSPMfXOsZ3Zmr7mUD1bGK+whnaFkRQOxkNIPDXbhVBYw8EyT0KemW8MQe85VeTKaLODaI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289663; c=relaxed/simple;
	bh=bcak6gCb5urPxwv4X/776SO0LNyOERYmyX3D8wosyuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FGAoXVZxfdVoGc/CZMvCy1DVZD2wD+15vtwlqRHEEk15FO8pbC/JP5LqAA8Qrp/28PvjyZqf1oCFhjubNhPAfr2etAIlipKOlWAnHY99tQPGDLYHwPJqEmV43NazylUnKxRjuyoGQ9wefu3vYCcQ4YMIGGcOCDv3cC4CM4Dx/QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzdi6bMy; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzdi6bMy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbErd+GSRu/atXi0H4ofY2JWE/twz9IcqCeQSDWZ8xN/Cv0JcHSsTurLJf95dULFVhnEmoQDhUX5iKVOQBCpXSOxLUNF20QJ2zCDxbLtvlgkwmFzYGfPLqcXs1C1LdxD2mAXR7j9qx82YAzlqcBSGukOj3hA/16f5+0GVsLRXGagMItIhwIgLNiUQ7U4WwSX7wsv4U0rCQD8AQrhV1yNf4Wfz+rXEZWHQ9IfrfPCTfEhdoFceIQRoLKJzlKMrpjn7stCLaPLsJmqCW7anKilMNSMQcfVRL+WkTE8MqY0iUbMLiHHvB6OWKvYMhjKmW8vnLOURs5zUq+u0ad6IgRAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NMz+lgXH47/nf/3GuMomPhHTcwMJjBIbi7cEuEtOMw=;
 b=RtgytfkVqM3YFUCNeNra7zqqBE8lLqknFVJpIGZccQnxDk9Ts9R7s3H3uSK/t1c8k4DIsD+IsajlGy0ekd2Xd1n91SieO7iVhUI14s0I4AqMIvkAw/qR+lzs25aWAsIcFbRwg9Tm85ML8DhlVIojIO2bGhXd+cFLqkt2UXHetafGq7qKQyYoNrqRMxQogAbE4BJk+X4wsb+oKA+Sa/jFJitJHwCaJRyrIZPggdckch+wccQvKicJpMRfMB8yYTcmCYz5L/TuAL0sTi+6KU0JY3WVD/4Ix19HrfipIESWPQfMIBwsymWHtrA0pUR/GbqJDmWxKGkYrO852c11tUUEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NMz+lgXH47/nf/3GuMomPhHTcwMJjBIbi7cEuEtOMw=;
 b=mzdi6bMyNLUl0pc/+OINvrvnVEvaYskXlGAM4tf4dklHXWC4O+Ybv9D19Pol5TtQHZFeUdf/oUmFPnalNvRfSPJMp+jGEyQTl9DIiOdd7+7wz9COLeIRkAbr4aCIinPQJhUFhGLBMCQGA5B7oFrlBG8PvuTEfV9LXS/POHKfnInqkFC5hLbSKqoW8HjNSZOd19a0RAnMAItyJs+Pap+FyINmna23sTuVAP7NvexXSWjmq52V+ODiabqNaG3iIpWFbaiSGSCllHVScE97iCzDbpNanwIPqk4cACUrPUn2seQSv3M+xaPJ8yCDRbmOsw96RR/uB/qigaw0cecMr2dEgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Mon, 23 Mar
 2026 18:14:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 18:14:16 +0000
Date: Mon, 23 Mar 2026 15:14:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260323181413.GP7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL1PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a567c10-29e7-4735-8907-08de8907fe0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j/JWyFlUGymryc0+neM3MXkchX/Whw1eCmf3nGiYZxxQA4hsSkX5eakcE9PAGaE/IbBntFEn8qU3SIM7j6GklhvUvr6DmPiK/w4a0J5KuBRcgM3rz924ysu0mggsKC/Ek7ELKp4XzHXq1322MMTxMOrUFeFpL/c1V8y6iOpuv8NOKSAzFsYQtKV4IA7nOKd+KXQXBrABsk12+FQQuOhXyTRK0Uzu/ygoY63W1/Z9ep8nqaH2mB46NT4u2RuSPShoMYrWBwQgsU/WHnIDe0FrXDYoNMmnI8qh+MreSnTTYGiB3gPO7n3REni4X+xkmuwmuxNtzLMkUxX+mN8T2670B+rbdLPw1q8kQxece3kw0n8QTwG9m2zr6VElEbry2/IKsYGRxhMA53BMUF0DABHfRcM2KwKbzV9Ix0K2fupPcU0EfkStKFU3QW4cK1rxRtvp40iL3nt/yg+C1HN6GkwxdZ8w2xKcaLzhnYnuAbZnwB3Du+0mvZpjQvbAuMov/fMcxhWxpLszRwFqEitUbVETGX3m4jqjUNxUvFUdlcUyk9dxUQUwQcmFV4GwjPGZI1pCyOh/vV4q0rgEY6DzUFnakeC5YCZOavJNZvOge6rzgQf/FwZae/Ktuj7YII2aLPw5U/5cCJaWruHxRpIT3LFNSQmExR6aLMIfAd9UcJigoF5kUejm1d1JBdHf7R65Dz/9VxdWlJBEtDVY/oIugObqAqXkIyIiMK3oopafdvxMll0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWqHzJmZ/w9BnmnKJVMBPbzu33WdvD4p/SFtquIgXLig/z9c2WZ59dttgnNd?=
 =?us-ascii?Q?rSDovy9kmE4sj5tSWQviAXzhbBcvhN1Jv5bD+7b/fieiMyAGmYtIOcztb1Xc?=
 =?us-ascii?Q?W1qypKr+S3rKUfrVKmWNstWt47L2pBBX9BG3O6oJ4uCLznd8emnK0Pq90hCE?=
 =?us-ascii?Q?QMmhw8R1DWiOUz+2cvyuAtImMNSCgIyGUVzkOaBzuFk6hVwnD0rrNkplkqCp?=
 =?us-ascii?Q?F1eMLkj0pPPmjijeH67gJWiMaOtKyCycfkqH17tLNHZgxErnj7G1valbWNJA?=
 =?us-ascii?Q?/X3zziaDjiQ8VzEDZvkMPIVrC7NOmM0mAe8W8/mTnJUn22ZIdTu/EtsKcZIe?=
 =?us-ascii?Q?yKsKpP7TNyx2B8xNCi5DSYM/hZ36QJ3YWqKAjEIEfzsnfZ8hA0j5oEqkBnxw?=
 =?us-ascii?Q?z0FRRsh26OL9vhCWdGU5ZTDUHe6pQaI3q7ksYkdfmJ0M81nR/SqhTVa5p1v3?=
 =?us-ascii?Q?Uj2gZ2bdaj//DFCgu8sNqhKbJWOKntHZI232dQA8iRfUPb7iZds0PpoadYtW?=
 =?us-ascii?Q?WL7MgvHNM2is2BrOmqn8QO36ZeqxjaLspWlaBrRKZzCGPTeQ8YKD5njACyDJ?=
 =?us-ascii?Q?FncSVH47m9a/Jk/yLTAkqXq5ngNjCIv8TQSu8sQOZQUh6FwH07XIVpVSOVWX?=
 =?us-ascii?Q?7D/tibGGBGRq/VXH2eUDzKWVQ0buvxpHj7UK58e0os4aSI0WsTOl0HQBx3CH?=
 =?us-ascii?Q?HaPMW3ZgAL/Mydg5rt/ErQ4bL5btaDVZCbvPc7bve0AHYu0SDbAA8+q2Rnii?=
 =?us-ascii?Q?3ALHMrEGqEpDwAGREnsbsNIF4ToHHLOyhRXRHTJbOLTbCJmpod+7mpunG9V4?=
 =?us-ascii?Q?ELXWT01cDgj7feJYZBnVF3LoIDvJQyDH824kNLjzs0/pf/99npiJ7fAvut1b?=
 =?us-ascii?Q?ZaGwTXbq85VUfNsNuNmVAv1qalt3o5JAFhEzDkEXZGGsJbwvfR9P/HQabh/s?=
 =?us-ascii?Q?xBEFBqBmWWPNywQVQ0Xbbo6VZE8ZgpgKcf3HHF8M9Mhyj7XIiYT3v0iIuu74?=
 =?us-ascii?Q?tVmhyTZo8lQVuYgpJY6SyUuQrNiLLLQja/lSlmpOhLTa7wtElx0VTcpZmlZE?=
 =?us-ascii?Q?Te7m70lSesnNTtmDHAazmilE8cVvrrg7WMrzXQqI6awLiPetW/uL6lk4zJML?=
 =?us-ascii?Q?4MV9Y/GOnASGdUdFn/dw5ts7g4NCZfbM9dhEFyw4nJ2WRxhPo4wtCldOChQl?=
 =?us-ascii?Q?N/lwEgyRLJnFa1vXebrIpMor3+dq4rMfF/G/S1jt0VsRvAM362aD9SdppqqA?=
 =?us-ascii?Q?YEsbRyxUgW4NJ1fMWonO3aKLCnm4LspSh8fZd27DJdFZ03t/8BrWDXV+FznD?=
 =?us-ascii?Q?WcLi9PKjy9zlsk/HhDUgWz0kjdSm62vsqeZuC4afY+aTnbAROmsJvwgv0nwX?=
 =?us-ascii?Q?NUrIj2NgZYRoiqBOVwR8GE63aYRfGb6SRCMeqp8QH7+mudjMoJsaPOfEHvw2?=
 =?us-ascii?Q?Cy+rxweHhf1hFg2yA+rVAzF/3zIm+XDtJhyhvMQQSAVY9m19p5AwyRuE7wDO?=
 =?us-ascii?Q?EFCcO3qWaW3lO5y6O7KFsShO/ZgF7mQ95mFClAYqZm3EzbMs97SZNCJVEcox?=
 =?us-ascii?Q?/zgG68nWioAsCEn0ZAZQEuau9eMdxwpDte8SguscTJUqPySzlqN2Ozf1IQO3?=
 =?us-ascii?Q?byCqzHnRpgZcAnn4V47YrBrn28JVmVzXbHr2QSJZD2cXUiXOxK7oukMTemyX?=
 =?us-ascii?Q?f5qQNWHQi0yGa2MrPt6Ox9L3TANAi5qKThEmuyALg7dk9tyb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a567c10-29e7-4735-8907-08de8907fe0a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:14:15.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thOI1tvwcILoKP5nsuuddEfjQ7NPnZBZuKemSZL1tUhFUVfE7Com2nRIbteA2Zf8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

On Fri, Mar 13, 2026 at 06:32:27PM -0700, Dan Williams wrote:

> The problem is that for all the buses that do not currently have a
> "device authorization" concept only userspace can decide that a device
> should skip bind by default. For that, I propose module autoprobe policy
> [1]. Not yet convinced the kernel needs its own per-device "no bind"
> policy.

I think it is just part of the broader definition of the level that
extends into the iommu and so on. It makes sense to have this kind of
no-binding security level, IMHO.

> > The DMA API just wants a flag in the struct device that says if the
> > device can access encrypted memory or only decrypted.
> 
> You mean separate "trusted to access private" and "currently enabled to
> access private" properties? I am trying to think of a situation where
> "dev->trust >= 3" and a flag saying "disable bouncing for encrypted
> memory" would ever disagree.

I'm steering the trust level toward more of an acceptance criteria.
If the trust level is you have access to private memory but the device
can't actually do that then fail the trust level change.

Same for the reverse, if the trust level says no private memory and the
device is T=1 then fail the trust level change.

> That bit though has lock-to-run consistency expectations. So if the
> kernel does not yet fully trust the device by time the relying party is
> satisfied, and the uAPI to transition the device into the TCB (level 3)
> is driver-core generic it raises TOCTOU issues in my mind. The
> driver-core would need to ask the bus "user now trusts this device, do
> you?".

Huh? No, there is no concept of trust in the kernel. The userspace
setting level 3 is "I now ack that this device is trusted", there is
no further trust cross check. If TSM side says it is in RUN/T=1 then
we are done.

If we fall out of RUN then the level auto-resets back to 0 and
userspace has to go around and fix it again. (ignoring driver RAS)

> Aneesh and I are currently debating on Discord whether the kernel needs
> to protect against guest userspace confusing itself. 

Userspace that controls acceptance must be part of the TCB or the
whole model is fully broken. If your guest userspace is so security
broken it can accept devices it doesn't mean to then just forget it.

> However, to Aneesh's point we could protect against that with a
> transactional uAPI like netlink that can express "trust if and only if
> the device has not been relocked before final accept" by passing a
> cookie obtained at lock to accept. That would be awkward to coordinate
> with driver-core generic uAPI for trust.

You could, but why make it so complicated? The whole LOCKED/RUN thing
is already supposed to deal with TOCTOU, doesn't it? The CSP cannot
trick a device to fall out of LOCKED an the re-enter LOCKED without
the VM knowing.

The VM attacking itself on something as security critical as device
accepance can't be in scope :\

> > This way nothing is coupled and the kernel can offer all kinds of
> > different uAPI for device verification. Userspaces picks the
> > appropriate one and acks it with the level change.
> 
> Thunderbolt already has authorized uAPI. I expect adding dev->trust
> support to thunderbolt is more related to ATS privilege and private
> memory privilege.

It brings it into the whole 'measure the device and then decide what
to do with it' framework. The trust level is still the generic ack
that the device is allowed the participate in the system with whatever
level of security.

Jason
