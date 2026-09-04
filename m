Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D248383F;
	Fri,  4 Sep 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530956; cv=fail; b=ifJ6g6b37iRfvR1aZqRP/yQljLlI/5fiKERU6exko8K3nrwcW0agIEp7O0bZ4Q9dxQlxeARu4lWNgFPf+8/qow7RGEC8ef/XNU+25jtFdLLtQGc8aZIsII5szIEG0NydKf1X5LvOIHbRBDQdTTkHacR3wWwhRVAjM6z0nPQm+I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530956; c=relaxed/simple;
	bh=BBhMH1CDqfnMMU7Sdtb9529+NxHp4KDjahN6I592HyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMkDmVUhvIBjpfpVCw6crsVJNn57moKgJBDIAfnaeXSxOH2yEujD2UEUn10OhwKIvQyGvNqXxgyBdcyiWdezz1jOU44nDd0JVLdILdzqhzkIHJmNNkcvpbHBCVCSpNwDArjo91SEjpkuc/oIP3li08t0b+u1oyjTLIY/T0q+D4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXTWjTNd; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXTWjTNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcy+enShsYjo1kqSjSkSt1f6K20B7hXHrUvZSsqY9HHFD3bQpA7zqpIqxgGs7Dag9slWf3oskI7Etqm83UYSzLdItNyigef99y0W5Uq6UFeUOvfCp2PLYRh4qkmwdyQBN1OKumIRTrlu2eZ7Y6bUY+sGzMK05IDg3fBT3fT7zLZsKuA8K+nNesX1kvlFsNFpW8/Z1i8evvJZMJaXPHNMz+0m3oE8I77hed4AA8PAxEtlMdsztxrSZFeL+HnMTSbvsXMBZoUte1u3tGJ4qGIx2FopUw2ddZEnINYqMG4cGU632T/Bg2kziZ+5sl2yOuICPXTztORF1NVAVvA+8nuFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB5PNoRYRDKctDwc4aRPQwHxbeWf06vKm0HpL1NI6+A=;
 b=WsPWNVV4ag9/fTAoZHRx2JJ+iInxD1vuNuPFCGKGg/fsPTwObjGlGyHh+CjNGpslZvoF3y9ed1hyJz331Uyh4g+0jXHBKllbaOCjHCijLdy5Ok17DqtZ5AwD5H0TY40Fg6sK5E09PxAMCtMcYmlBr54CyrCSuadVYXrIzK56TtFPdSIh+M5F3mIXMBd6StJGrKxmudmxoX6EGLecaaix9kC3FqTlAPT3/1GFnwMZFHpy2AUwmz94BzRFVcRZEboHRMcXRHor/1O6U4BttVLh2mHMMMGv/Xysz+ld0xQK366PtAhj7p7/S70yIbvrsSAnyY+Ay9E8N/Gq6ySVRaisug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB5PNoRYRDKctDwc4aRPQwHxbeWf06vKm0HpL1NI6+A=;
 b=mXTWjTNdaTE+BefL99rbtf4/JkaryDXYfxIiRphDMjZpOxI9U1yNvN2kpUt1f2gIN4NhjaCT7V7z0oitFKvAlA9pryhXt260KBuuhRRWnvwPatqqIev/YSv7W/K79E77FOGjbGvZhjfCht4UoBs0jlt9hxU46y1cOiR96D3EzFgfSMOdH2wi8Ic8gclO0ap+dbdVHT5n1jF7j+xDFUmSBXMlaJxNfPGnKSAEry+FEGlKNk6BXYVrMtrVzmTgd5cX094h28kHeuOsE6i4hTayBZ+68N4OeWuUC9ZYo5yR5AUU333QiA3Tblg86sVxb6MHW2xoJDTUVe0YlN8O1Hcilg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 4 Sep
 2026 14:09:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:09:08 +0000
Date: Fri, 4 Sep 2026 11:09:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	praan@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com, harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <20260904140906.GR4157646@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
 <178846311316.1308030.6266899352044838554.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178846311316.1308030.6266899352044838554.b4-review@b4>
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d17cf78-614b-4bc2-818f-08df0a8e162b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|4143699003|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jgP+TP2CRuHlPHYRvYenuT2HJBzNm49qC+348+fHeGKqiXBlUMzcefNd2oInJ1Jwudybd65lJVYX4U64TmHt7OwIrCqUAjKzutjWelti/XvG4So34PjX7CrXYIncmnrcjxMWOetUJBW2Im6a/MQHq6yfr15fZIu01BnbaUCdh/QTDCEKtqWvaRJpQwFpncL5MsMEFwTsrVcl3sY6CLpcKdeLFhTEXe7Qv950ex5ienuOG8TMcJurAMvHH7aYTTLJwY9CJVusqbbc3vCvOTgIxhqDVuOZLD2GHoyACRJC8ISmCeJJDOF9DZK9pFeoE9T+sVIRrN+RyHvnej4CL65xW6mBKpHB2JwLoV0dy+rXrRDEiqxGAX9i6I4nubKHLq7ppBwIX7JCoj9eryZY3G2s8DIK+Qm3Q8bSXZp26/REsgpZbZ6MKQXa/niOG//7beaNMFu6Lutb7K8Z2lnCLHc2/OKdxk6/DryZCtbEWRPidfN7ffd0dEV3w9py01Sq9SEDcF65pH5cx/oj4RTzYxUyTQ3li7BRkp2LF4aOekCNTAsOwmMJAksp1CwKZkojGweb4Olk0tWsU7f6ayVFdpWbK24EHMQmZgLm1qPfohor2F6ZmM0VVWq8cpKoL44hNgcwYs0UzgAr1FhBkuSDzTbEjp6kQ2ZvYmzvgeo4hICfreY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0NdgczW2ApjnZV44XU56hd8t1iu7h6Dt05qUQjqyrFhngLyOTvvtlw+cfdN?=
 =?us-ascii?Q?0OOItbd8SUt209HjV2z0TtI/54EI2jaz7eo8YihhJv7A6IIMg5pHg0e9QgoR?=
 =?us-ascii?Q?1UYGY8uJFQu5MFrfFyNwLkavTmHe0RyLObuGqsq+wYE5JtHWVH0ArtE1fLB4?=
 =?us-ascii?Q?arbQ9OvHrZo/rEZBGmp7F4v3DJm2j90QCWbA66Tb3GC6+5G6IF+WTOQJqYj2?=
 =?us-ascii?Q?iT/0v0VfQXtzaiZ97gF/B4GXDdC0UcNyZywj6VF7KuLDeRhi7riz7b9g5Jim?=
 =?us-ascii?Q?DSKVHWJ/LilANvXGXNCFWdbMzYiWqcFHOiewi9JSMlbV7EBDszXFiC/e0DWQ?=
 =?us-ascii?Q?qPtn99j7JBeUWfF/KnaDoMM3ip0MnCK6+qOUuI9dnzaElkmWybWLZ/0Mnbfb?=
 =?us-ascii?Q?40zxfE/TgPWdYOyAdwoKJ/fJbReKaKuvaTQRlXunowZOgQ8tH03ZxjUm52EU?=
 =?us-ascii?Q?7d8Oi94vBKivQnyBP/oPrjUHQDB62MFgdSo7YUSsy9p36NWj2guQnVNvExPm?=
 =?us-ascii?Q?K8qG3t4GWUZEf5iMc4i8RJ1VbdJXxppjMs9r203AordIyiKXrHVVNT8UyHp/?=
 =?us-ascii?Q?C7kAwUDYscLkxNt3pEDI0rwhAXQNubw5AYaUqVoWkYI0jjO1EE7QS9ZF1yeO?=
 =?us-ascii?Q?rnkPINV7+dCBXDMy7joZJ/IuL8cQDX73oSa+5SVCvs1iCMdiZsSKYSQFNLFd?=
 =?us-ascii?Q?sFnY9hya3YExvA0xAfeuNLgX93h4wkic5gqdGXGMCx6Y2W1vdCDnxgLPyzvO?=
 =?us-ascii?Q?c2e9BbsP3r6QTsEx08qJDluZXzhI56JuepxoUZTIvloT2Dc3XsfpQRKPW6BK?=
 =?us-ascii?Q?zxvpueV4T8VmAcGwW/28twAjYNKa/Ba14eVVdWrgNDJ7+EwznS4KQkRDGUE8?=
 =?us-ascii?Q?HSMB9YAgPeAm4YPVtg4QNl9KaIozy3ATZhtdn/uMdOloKsbJfCNWsUm99l2n?=
 =?us-ascii?Q?9mPWDRO5fD251jB2oNQeOuptcmlVQG47JLg+ycx5EFN+lIp0ETThl07XYFWY?=
 =?us-ascii?Q?BqDByLmYE8glx5iyOmYfp/7guafMhE+vR7JZ7MYJoJZdVCP879fzprmtjY76?=
 =?us-ascii?Q?9A2G14l9zoJQG6uJU9XkEcUWr5+rDZt6lhdW4gXMqSk0Bv3O4snQx0D5ktW1?=
 =?us-ascii?Q?hr8EkCgMx3fg/1HRoUWzUi76+OhVVQ9mfXkzM7Bq4gQy/r6rwEXECtdcZ5yA?=
 =?us-ascii?Q?jqs7owylTS58AKcn9uIVc3NSenH7js422UCEoKH8NFTx/wWjqh34oLsGNZhe?=
 =?us-ascii?Q?yjSNaUy/KLFHfQYEwfPcNtQg9P4vKyDFZ80GjkqwHMhez5H1/gw4z85lfV8g?=
 =?us-ascii?Q?zfBD3J8l9NhvtQeGMkpHdZZzQQdnRyUGBDexSWXPWE2FmNNzvXojic/Q/1ZX?=
 =?us-ascii?Q?omV+Zk2hR5IaTyjn2BC0XLfMPYXUcEBvROifQiwFNIviiKwDFJAsHlPHCOMH?=
 =?us-ascii?Q?45d9rvqS/HqyKpP58EvwVEc1Vlq40XesQVAC7bsrro8erCwtgWymG125Wv14?=
 =?us-ascii?Q?0A6kWN5jUpqfI5Jvt+gks3y5XJGjiHytx7WoMyBcJakO8lJEsof39a1ELBF4?=
 =?us-ascii?Q?ILkSbYXRURkbhjsJqO6yBjffcZTbI5iiHp72kM/+/i2r3HMwxqikWmWNXMKv?=
 =?us-ascii?Q?LhCCdJzhgjPlEN9VCabb6JYo0xgcaa0J7/UjV1r2+HbyyE2npSE0nc+c+klm?=
 =?us-ascii?Q?yPDtLussENO0fSSoXcn2hLrTyOrO7y1WOMLsrsPqXM7xRlE5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d17cf78-614b-4bc2-818f-08df0a8e162b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 14:09:08.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b0wcRDJhpPVVpfAXckMlVN44WuHDW0MLZ5+fCXDXDy+1EH8MrLriOy4H+ecckCb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > Also run the drain for every stall-capable master, even when the departing
> > attachment did not enable IOPF: such a stall event has to be aborted while
> > it still resolves to the old attach handle, 

That isn't the model for fault handling. The fault is delivered
unpredictably into either old or new domain. It doesn't matter which
one.

Domains have to conclude their fault proceessing before they are
destroyed, and attach to the a non-fault domain has to conclude faults
before completing the attach.

But there is no requirement to deliver faults to any particular thing.

> > could pick it up right after the handle swap, mistakenly resuming it as if
> > it were a valid page fault against a new domain.
> 
> Useful perhaps to call out if this has been seen in real systems or
> not. I agree with the analysis but would rather hope drivers are
> well behaved in ensuring all traffic is done, adn this is hardeninging
> / handling of naught hardware activity (all good if so!)

There is a firm API contract on the iommu drivers, they cannot
propogate faults at unexpected times because the consumers cannot deal
with it.

We don't reason about well behaved drivers at this level because vfio
cannot be trusted to be well behaved. So any nonsense vfio can trigger
has to be handled without crashing the kernel.

Jason
