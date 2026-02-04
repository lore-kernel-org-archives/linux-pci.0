Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321E27AC54;
	Wed,  4 Feb 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211315; cv=fail; b=hY+XtgbdfgPmdKDru+9FW5nwG62tkTlR8Qkq8vKxQncloZEUWJthnhSTv01jGWtLXVk6oGL83FwZypK8EGDbUYEcPHaTehqDhvKCNll6+udZjtiOKSpMNWe6r95iACL3eM+/l06F3+joBhGkgcQ/n13Xe41NZoWF7u8XQBhR3FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211315; c=relaxed/simple;
	bh=XjEMkrZQmXMj2IJCaRubrXid0aEe95nah6rrMiIb0us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nue5+ys+XkLziH/lcdrUPWgn495CgpSr7oV7gr+Q7TveXxAylL5WOZd5HfOIidNQ0FLPySBguYrBJTv9HgRa16sggO2VroeMkuHLYoruWrDqps9Vc2YYVNz27DvFgZ48ZqoT1AGKFO9JXbqyz2Lk6eVvDPseMDxpO0qYrbSm7iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMQorKha; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMQorKha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/toQAV96cwMYAKlYgRDLP6Ui+91emNAD60mrv/q2qWM+1vFT0sxwMTL8xjdxWPvzr9bAN6+EMVrp4RiOnbOR4N+etebBBz6Be/mBg5RdT3pamnkzPPpH42D2HWzTsnEo1IABiblo/6AgPjqLDJmjAaDR7Vwr0qZDJoiPdGx25er40YK7TZ48JlFdEKc0ern/c9c7X7BKM32F7OuCxfB5j42LAwWv85rEjX6O5wK4XkTgxagqAbZV0iOp/ISgkxiYZ2JQpsOiQkvbIWyGzv9yFQgiF3Ad6EV4h+AUdhjJmkHLwil150YGJzzLoQgxhXdtAIRtGQ8DwupLp34/SADqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I33FjyILGID1fuRz/BfeikqpE+KDe2vgi5DKEcivL80=;
 b=NKtclrD7v2Z08UA2E93FBBamnRYURZyiqqA5orOqXjX2Uku2Uc6SMlp8DZ0+NJSypfmCKxtmIfrkLgOc6S69KONDErKo6iC84T8CK2GTl52OkfVvvge3N1svosvdgGsiUmzzyp88hOZey4Y6QfwLw6P0f2hA7IU6roMSKsuoLbDFJrvwbKIiJPvmo9bH9myVWpaFnPZ3yvfnglHpoAUviGCa/axS1TGyHAb+cHuEEjvVDQdYL/cgnSzGcb67VT0ixHOL5zJ93EpnfAkSffP8sWo+ujTNSrJQCVuQTvDSUvn+QTEuDW6Ywkd7WehZ9JnEWXda4qivCpO6fjloajg9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I33FjyILGID1fuRz/BfeikqpE+KDe2vgi5DKEcivL80=;
 b=YMQorKhakc4xL8xCRC19w95Q+UFt3fFK2KKtbXBgtT2hl8rARJdlmCJi0j8u87vFv/zxec0atQjNcX06j99GyAf4UI5g4+FvZvqWvuFs+74x2/zz1EqNbtXuCKAq6OCXkHh+/Jj7/sJgn/Ueqe+qw5F+bY3EUQxHgcR+dW5UQdUXlK47CJ7qt82GTRWtP45UHmAIwL5GXMYXXzRhb2O6L4Wixv+uBZ1CTG6zxMYIh1c5E25xp5sUohJ+4gXYaNfHd6KgX4l2oA8FqxFdxSOaMYQjbaIGBdXM0uCV9q/88SxE68pgZ5UR6G2yd8z2deEKPLoZyZk0Pj74W6jLoerwCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 4 Feb
 2026 13:21:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:21:50 +0000
Date: Wed, 4 Feb 2026 09:21:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260204132149.GG3931454@nvidia.com>
References: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aYJDf7fWIxH1017J@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYJDf7fWIxH1017J@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bab914e-ef08-4141-e0b6-08de63f05aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZvrL9IoZl0ycqgDg90E0VzSIfSP/DhcHuBFE8VbBK9GLxnBYOvvmEl5HB9VI?=
 =?us-ascii?Q?pUzKj/4N5FjS0wF1vL7PaLPOrQCgE5gtw22S1JF+Bs2/0Dan6/Dow7ScJGiF?=
 =?us-ascii?Q?lwv9wPR9spKZz1GtxOetZkQH59TvCcZwcfFI6wukyLyjyUk4kLcFSCUCBh+3?=
 =?us-ascii?Q?3N4m4e1n5gskU/ut6BGaMIxJsTPEojN6ZNF/t9MRzEF6+e/CcNyyjMiOzSyu?=
 =?us-ascii?Q?aNGfOy41IAPjmNHxtcKRt4+IAbdiHZ2fpmeTkudSu6V2Fr8osIC3uoYWyDY3?=
 =?us-ascii?Q?Pi6gJq66FloqPwuR8JIq13OvwwTHv8FB/cZTFt6Xind72VbY6YHXsbDc9HZT?=
 =?us-ascii?Q?g+VGiFHqiDFIl+JFlZHKk5a7a+IUTRcBcDkHPWOmMc/xBWMxQ/cIDCtB9O44?=
 =?us-ascii?Q?0L8Fwoz57sydfgzIRN0OZPaY0k6rV9xmbH4QmnEzSsnPCcU9P+3klT0eBRhM?=
 =?us-ascii?Q?KwHGWtwa3uiApKPNhfIBOTG/MMblFPlvBHHsNjykdk/voRzQ/VXy2//b98tP?=
 =?us-ascii?Q?tDt/kkPBwkQ62477hzPNXTYOylhAeNhq5w15XAejh5sUpwSpNJOtRBvZwZMG?=
 =?us-ascii?Q?c6QbLiYHOzuzvwwRYm/fE6bMSiieCZlGfuLXFwwU3PqHr5W6tRYxw/9o58+0?=
 =?us-ascii?Q?GUke0i5L/ZpsZzSW2hkHNDJJ6jE9E+urohW5AmXIkS7bj9jqriKItduev4je?=
 =?us-ascii?Q?4bEt1a7d49KKQOeiwm0QNMIRsdnvhqezObvkd6hJUvTD+FbjgER6YHY+0TGP?=
 =?us-ascii?Q?E108sblM2vPQMgk8FpSgLwR2er/VbrelfCYUwBOr/3VsQmeh28ZQ+K8f3Uks?=
 =?us-ascii?Q?GKM8I15RTT1XsTMvsyalCvohbGaJFqtk8iXPR/dWbJjH3qN1ctLH3s92yYQO?=
 =?us-ascii?Q?7tI+IyaYE7xmmE9QDJiyGmod2V7pBwXM6jmRBthUZUSXkb/hEfRG6S1WpPM6?=
 =?us-ascii?Q?jivqbzZUTlIlpKI0MYQ2zaw+kAfH5i/HPYeZwdhTFyCWYaxSW63agpkXOEFR?=
 =?us-ascii?Q?xG3nhnFV1+0WSiwdUx9wgL9ojIsKpZSAikSCqWI+t71MwHNigFhxvec6EJi4?=
 =?us-ascii?Q?B49wisHq3xnOr8l0JBbWA57xR06Vh20bXms5SWkvd0LhQPQpMRGgOJpcZPi7?=
 =?us-ascii?Q?6Qf4o0KMkM8BvWAr4iqKA0ALBQi+bo3Z59lMtvK4yrpbr4cy6mVMBN5jRmWe?=
 =?us-ascii?Q?v5P3+LbUc3P4AXbWzBdwh7IQHEWAjx3U3XlRKQBm2mRYCb4eCBHEpY4DEqbR?=
 =?us-ascii?Q?pUtFYBJ2+hZo4cPn9mJ08Q7owiEQMhxjMvAG1+Id2SgIAFXGuJicgt8Qxlfp?=
 =?us-ascii?Q?tBxe2f4siQrnQRBYrvw7Zh4Z46F8loeYDEoibiZjTUcam7zzb5UK1mkNDG0Q?=
 =?us-ascii?Q?EX8AIWN7/lcFSXfxY+8XuVySEDU8DdddAyzBVWliVDNarnzvUcTONEYcEizP?=
 =?us-ascii?Q?hdxTvRrLmZLQ4yJcOdPXmtF8GmFmRVJijlFHvNmjMwSr+xDyotywAV3B4a9Q?=
 =?us-ascii?Q?nD6rm+WuVg9xosVjJbNZrG1M5tJ9L61C9jhhwrwsnM6UV26tLdxfNCKGx5Rt?=
 =?us-ascii?Q?SrSzXehtaJ7y2kleW2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NDbVNtVFnHcoXEtzcn4tsGuCt7G7LqoZONp9ZFxJ31XDOxdKUeqorI5I2JCJ?=
 =?us-ascii?Q?zn9HK997DOLdRJaaUtI1u+kPFAgVPpznYlmuf39XM8DPTJe2rRHmskgzRC9Z?=
 =?us-ascii?Q?c0vsfdEpD/XS2hHYanYekRikMql9asqnbYpYqB3jGBxHALw6vDqCHzkFMyt2?=
 =?us-ascii?Q?spFcqWeEdS4kCBwpuVcPvWj+SdiIONs2sSOMk6uZ4lqcosGNTYidPAoX1W5X?=
 =?us-ascii?Q?OpARFRA/e3vbhG6dx39DUnAZYOq7k8Ev2M5KL8Fyg4ekc/fFb499HyZYxN9n?=
 =?us-ascii?Q?WudaKXddBA8bV5EgR8gBLiNZ2jIYHPlmWVyBjwQkYxm1Y04FUKMboXuf5p7h?=
 =?us-ascii?Q?0Zcbp7QE6HblqMvJzcofi+/pVMsfYDNCx/Oo3gGfAFxGfeccavQgxuRnpubo?=
 =?us-ascii?Q?BA7LNjMDLt/TAqXCCqUuli6jgHW+fuv5+XIE+o79/i9V5NxPJql1sloQqA4T?=
 =?us-ascii?Q?5780Blvm2q8cCWTrPbOAQFIO6/fQounDlc6JGk0FrrJNhnyblUUCNDQ68y/j?=
 =?us-ascii?Q?N+XDnDikQChQddpaaN80PIMetUamEIZB4c9aP5TsWOMBgbrHOTxjU7+hSd8N?=
 =?us-ascii?Q?2Fn6epo/3suDcpnOdkOnzp3hO2KOk6D8fJ9wVZv9VvQ7E44KqzIRuGmiVAA7?=
 =?us-ascii?Q?ZKy0Sxi3QsUprhKnv2CYESekzJx7fVVGOnM+xEoI6Fry8A9EpqyHfsFiRZ0H?=
 =?us-ascii?Q?1puWshK8rB8qFGXAHAByiw3hbtLo91WMmHT1rNOt9Yb79OKXBeZjfoBmZyrc?=
 =?us-ascii?Q?T/PJkRtzytYp5KBORp11drHZbQ3993nAHBsn5D+3E2+fOMGxjBLsiBaB2d/n?=
 =?us-ascii?Q?nLzBRXg/oM+l7Uay8/WsvyY8DCEclC/d/+jxkNPGLJ5N0choCY6kLTcLnsj6?=
 =?us-ascii?Q?6bgBSN6hOsL8+lhOYPlj5QePxhAMg7+m8ubw6DP4YItxH05MBRRhjDmZHUaj?=
 =?us-ascii?Q?OzbiWKZ46tR6bnRNOR400hy9JdWqoCaiVUEeort0PGUgAcSVdBs4e05W/yrT?=
 =?us-ascii?Q?hMTQ9EG97k1M1GAfNbiFCfq2qa1Gl3NsP/lfaegKYGTnXq1Ssb4XZc3bsgVs?=
 =?us-ascii?Q?b4/VUVSRr4LM2p/Dh8tG/qBWIpfZiRMzz14QHNTWTOU9vEmTFGbOXEnqievV?=
 =?us-ascii?Q?yDMWsBISt4/DH0XV8yudojtLh8bbHj8ZCFilwUnfmycLrhTXc4l9KSuo9PeY?=
 =?us-ascii?Q?LndRMulnyjTq0iKJHPzMjkDmnQstX8f9kUWt6hYa2RGSxdUaBK9GEG/CI2iT?=
 =?us-ascii?Q?Q9Qt+rkwrNXsg09WBwDbRSuhibTVs6h5wXVNTKkfo/MyFr+JDU/cF17ZSgQv?=
 =?us-ascii?Q?as34QcwYmJPimvFFvf+WxQcCCUnT3LGVuDfgb1wbL7t+lF38Vd9zusof3IGp?=
 =?us-ascii?Q?GT60bi0ZTzEMpRENAWW/+73+P6wXb/afQYplnBI0jTzRPRHfXBtoCPUWwG7j?=
 =?us-ascii?Q?NvZGgjG0c8rakCH6+Z2ADtUThqdcZQ6LylPnsRcCWBxk9gb0EIy88QnSGvx4?=
 =?us-ascii?Q?qUq2KtM73oxhKxhT9Pl9AGzoUNa5dnZjCleT4izNloFSiQOpsGLBrYO+RlMX?=
 =?us-ascii?Q?Q2ljntFqrW5xcuAjWFRGLAUgkjersE/Xd5J+vy777caf6QGfMcA2AEq2iBvG?=
 =?us-ascii?Q?nQOBFiMCYLzRty5vBLk2+KM4mvKQ3/hwzQMO9eozS7E6Ox3F1AcWT4wAP49K?=
 =?us-ascii?Q?+XXid3bF0jL24bm+n+YnkUJe7Ze8/eEncEtynybB8b0n1YjDGIVF3y+HV/ZJ?=
 =?us-ascii?Q?y0khg1HVYg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bab914e-ef08-4141-e0b6-08de63f05aee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:21:50.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orSmle8XI8EN1/oPf3XQ6qOH+IzlA7pmBJ2A9mWN8LCKCFxFvw8K4Qs01/bHbilP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

On Tue, Feb 03, 2026 at 10:50:39AM -0800, Nicolin Chen wrote:
> On Tue, Feb 03, 2026 at 01:55:40PM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> > > Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> > > allowed in general if require_direct=true. I assume this case can be
> > > an exception since there's no point in allowing a device that has no
> > > driver yet to access any reserved region?
> > 
> > If require_direct is set then we have to disable this mechanism..
> > 
> > I'm not sure exactly what to do about this as the require_direct comes
> > from the hypervisor in a CC VM and we probably don't want to give the
> > hypervisor this kind of escape hatch.
> > 
> > Perhaps we need to lock off to failure on CC VMs if this ever
> > happens..
> > 
> > But baremetal should just keep working how it always worked in this
> > case..
> 
> OK. I will put a note in the patch, since it would literally skip
> any VM case at this moment.
> 
> I just realized a corner case, as iommu_probe_device() may attach
> the device to group->domain if it's set:
> https://lore.kernel.org/all/9-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/
> 
> I am not sure about the use case, but I assume we should skip the
> blocking_domain as well in this case?
> 
> Then, this makes the condition be:
> +	if (!dev->driver && !group->domain && !dev->iommu->require_direct) {
> +               ret = __iommu_group_alloc_blocking_domain(group);
> +               if (ret)
> +                       goto err_remove_gdev;
> +               group->domain = group->blocking_domain;
> +	}

Just to be clear this is some other project "DMA boot security" and
IDK if we need to do it until the CC patches land for user space
device binding policy, or someone seriously implements DRTM..

Jason
