Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41D2868B0;
	Wed, 28 Jan 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605919; cv=fail; b=SAMeeV7oqmsTM1srt36X8bJo5kqwKBI+XJkmwaiT1KHxq96lZF4ag80ca9bcwj0pgRExpBilOh++ayGvDrdEZAfhP8RYbnwg15Xf4gM3Rn2zfVyY8JTvZ7VTvvEPbx/zw4jvrhWP9i2fFMJqupUtJRgz+DZUDotrmSj6fD4mD3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605919; c=relaxed/simple;
	bh=wYCbzXRgrrhCJ3lDburAp/NWIsmcTh0mm6YAbHpUm2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMcIqP+egVxtN6A/HIEvmPnteV3dgW4Dx60JgMLfkBsM3Jbnus5G9S4z/83MPot5UO+pw4zzMEk1OPhTB2j3HZ0OuHLyLTkKnbTvyrer5u+5QtLpw2NnHHlZZvBSWKPiRpfqKjvnYLEdPFX4mlK93VDrMf4RI2Rqi/bbnVqL8t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tzeVe60W; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzeVe60W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GN7ZiVCg/yCjlwKQwaVjXOO2SPdpEaxofoxXNGV1PHPSwXRgzcRm7QNqSi3druHCaYYJoLuUR8LrK2GZ3kbY1m+JlZ2tQ78w3vXKEk/hBQNKeh+yvcE6T5pE828E0zF+Dzl0DpMLAzTwTjjm2ecB5yzsoIvI2vvg6z0q0OJhsYXDFIvTN1AP4HWhWfG7MzR4WFd5y6omHINK8t7anYyRf15/pG009tcRc6k9h3qTlbylQOUTo+q47JldvDSLypXlDy/CmzbLlwNB039+IYrfLr3dKy5PyzblloZN9q+/utVUL0Nv1HDmsN96BQtF1QdspLSHzrSi52Zx91W5jqQjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib7FKgwNyIsCnKITa3sMUGFshQAus9ki/XfHJdsCMYM=;
 b=q5UIa+EM5tGSmzWIGMp5c08kl4JuAVNPpBSAF4j9LqSq7eFT/laPBcej2O5NAMbrQXdD8wR4/7plpELAHTNjMewW/0kwM5U8r6rHPWVYlo94j0xMvtm7HUr2bCRT1DDc7GHo8qhHLls+5DOMip0x8WTZ+TLt6kN2ApdYKvFedM1zBKqiP5xPXQ/PMEqunXvDhUJrFDnaqy0lRTG9zA78MqkxY8EjH+PO807E/oE+j92NeK1Ks26AHwNwTmC66FZSUnAeVXVwuRJWUco+Z3Fo4YSESzHq8eQzO0DbbeT0abcAcw/sYI/Njy6VmN9U6jNxGd68xulrX/395jEDEHtpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib7FKgwNyIsCnKITa3sMUGFshQAus9ki/XfHJdsCMYM=;
 b=tzeVe60WLS8qHjsaw3vm7KTiDxZQHO4XK/BtuF7A5MzzxiQiCkzhNzL0jvwbuTPqXIq1VHzm+8tgyHEeBtCXrQ9fmokZ6V8w0/qxySjAk0XVfL1uxs9yio9RNaemdDwczo37V4ronIQxk2P/yBvhaxppdsw42kXos6Hbgxm2Ssot3fX8aBCt3kHGzLtJbdEsvUEWZtayv44l8Y5e0JzU3Kx6DUslO42QCxC40l/hGBbqckQZ6ptC9JiHTGEac2o7MB6BqOpoj5FgzUgSOcftDMVTVX9iv8eMMNbKEnPo7Hmp6kgCSNfEONc1ejKQNtit4d/7yyl8UpZh4zDqJSK+4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 13:11:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 13:11:54 +0000
Date: Wed, 28 Jan 2026 09:11:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
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
Message-ID: <20260128131153.GW1134360@nvidia.com>
References: <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <BN9PR11MB52760F8EE835B4D06BAF0C248C91A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760F8EE835B4D06BAF0C248C91A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL6PEPF00013DF6.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:a) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 35957043-eb24-4f3a-0557-08de5e6ecef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQr0IqVf+V/gUBPDKhc5njKh9GF2cSKjkWRLJLt1ry5ferGfQ6C/loczDaCD?=
 =?us-ascii?Q?Iys0AwiLL8Zk8bMO/Ycw19EA4+qGVPjFsB8ZJx6Vn78Sw7sAks/VzQ1/jixc?=
 =?us-ascii?Q?sbhOqtqFaEemFtJKgbCiwXGBix0V3EwoSwM8BI+jXEy8LuhruoyUdN9Fs1hr?=
 =?us-ascii?Q?ejzfgF995h0uGtbiQ9yHtSKdH+i3jPVbIDwwoeHoo+DFTpQI67ijMLv6ZJo4?=
 =?us-ascii?Q?VgMCDfohRBS4Rx2cANH1ETL2yWQGICAs23SgWPMcFbJVNIN5TwHxrB7jDlaa?=
 =?us-ascii?Q?8OzNcA9E/zNi8Ex4KwmrCsidsRZngU/KqUetxLt800somuWsriD7cpPlP2QU?=
 =?us-ascii?Q?QpHV4ppREbo67d2+E6vWwqvLNEbQvE2L4pihpbY71JkqlaJpodAwrG43aq66?=
 =?us-ascii?Q?66Vbet84i9FcgO3IZg76PtiLg3Z986eZW7tmk8I/YwuNqQ/odvH18mFWhl2C?=
 =?us-ascii?Q?PXMuiEcKiaFCoTsr9kxAfTGrYiM9g3X3EsO4e/vF7KbUKn8hTL9UtceQIF5K?=
 =?us-ascii?Q?jPRd5c/zPGKXbuKhYE5N8Vrdd47XSZoUn1vNOTLlGeQMEmz8vVbNHcZortPK?=
 =?us-ascii?Q?why16qRVa/SmVPGWNHFPTQ0hSTdsW+SWIMFwefeJFv3XAz3AGfQq7lruNq29?=
 =?us-ascii?Q?9zma6UUZH/ydDOiJx2RVeqrwEchAIipPbFYdGwmrv1JrRL9wprrp/cDOCa51?=
 =?us-ascii?Q?Wu1CqdYMSxfaq3QruPMStAFS7dvqW3xOG6i85niVZfiCTPbDayc8Nn7Y9BV8?=
 =?us-ascii?Q?YownM8orGO9SCDnQPICGMaQ4+7iR2faojsyUV7oNgGjhhQSayBiNR4Gt93F9?=
 =?us-ascii?Q?5hknQCTCiMb1ppnOEg1DFJV76Xy/oOODQ6jv0kNHbhdI7eUJgM8f/Z5LfK93?=
 =?us-ascii?Q?7Hw3kz5rrOg5JBTv9/riQhAA3UatI3xkNs5jxQvKeGLTcxgwxvnSbMMzJDid?=
 =?us-ascii?Q?kOPX7fwNk5pz/4EoTz3R6djg0uhF9OTTT5bnTzfRDkIrs4bk//WK9w9r6S8R?=
 =?us-ascii?Q?67XrU86hqvxiF1EGRSp2Dyj2qjKKtpF0rl3MlWkrATEhbZ0H3uqlIHWBPMr2?=
 =?us-ascii?Q?bbjy25zRdFvr3bbbJkF5BT+/85L76ZTI+C2L92hij8H0jma+RcNGVANbf6OF?=
 =?us-ascii?Q?rUm8wTWvieiZLzxA9vQ6wUh+g7S7Sj9dZ8vL9z7N0AgPT9fqlgP979mM+cZW?=
 =?us-ascii?Q?mjQX8a8PWZieHafL+PainsQyu600aLlv/SMX/vNvXriOU7sQrdAtlHie4QX5?=
 =?us-ascii?Q?eumbplecX25SN8cA01Vb6lk85ewo8N5CPFxQXIJ2iPAD2t7n7IKY1TmKzXcZ?=
 =?us-ascii?Q?hMetgg1BDk/Q+cK5wlsRRVGXjBoBYQEc4fo5Oc7JMsmfJVpmGHGKdVzlmNlE?=
 =?us-ascii?Q?ZEoU8XaSAX86AeGsWaIFMxhg82L1u/VWiQqRcGQjkvQgu1sDj054xv0iGY3t?=
 =?us-ascii?Q?lVsSzR+Bxp+SdFkFn7KKnFS0GEFwYg5vzs6VSvvAE+QWdOZOCHixDmPz21Wq?=
 =?us-ascii?Q?v7nCaK/bTib3kO25DjNyYyJP/pwoeLmXoCq/qrTfF7SHYa1beAM0PDi6N9On?=
 =?us-ascii?Q?+/8vvQRnt+eoRR09xpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCUfM25OjRONmj5lk17PIGenjbITrUUN3/CgyFv61PULRM1j6rgMLXaYMLwP?=
 =?us-ascii?Q?fRJfpuRcPBeLLqPBlMzDHFkH167ZCC5sbgTzbhA2eZz8+1pOUdNU+BiIFPmQ?=
 =?us-ascii?Q?5tpYJWpK65KJEQqJuKHGF3QbSjby+6mo4qVKyQQUhVI6AUmx8w6xMCrxwiH6?=
 =?us-ascii?Q?+adzvH87RDyuUejN23gmQePjFf/Ur81pBZgx0QXV7Z/DBNxMnFYYVW0SrFF/?=
 =?us-ascii?Q?vVnKJJL+1PXY6tbxQtAvUY/0dDCp96r8Y/ydspmbBso82ivAjprShH/LxAVv?=
 =?us-ascii?Q?dnE66vDcP+YobwiqU2sO1LJ7NMhVV4BuW4l8XG263oj8CziOPm5qMK8mbNPM?=
 =?us-ascii?Q?aMhegyxl3/otkTIxkpEh+SP2IABpCD3oRBF7P1GuKwTx+lsHTTnzdy6Ed2/n?=
 =?us-ascii?Q?a1FrSLxOa6EzQLfSGCFRdMzCnboNs2UrdARYoP+7HiPfx6N/RtMIOc/voIXc?=
 =?us-ascii?Q?B8F9ejuwwVZ7TtCIj7ZzTeUxFe/pWXIh0fzGVPbLK92bUkYVz0obYcawBUIx?=
 =?us-ascii?Q?o0rFtcpdm88yb7pv0frv6AaBLrm+cZd2CCj9BPN7huKrciwkTFCUfTXwXNKk?=
 =?us-ascii?Q?CScP+kvkumz9z+9bVerREDd6JO8ZG8f31qRMg6dfM4M2t305Lh9T/z1jujlB?=
 =?us-ascii?Q?cu/5EwtHC+Odv865QRIIMDwHz6qMrFxv4GpnpgwMUSOgl860Xg61d4D7C8I9?=
 =?us-ascii?Q?0duAAkMZNieJ7EAZeo1uu0ki5ibMSqUGeiEk+w+MMhV72efS2dW4GGXdS38U?=
 =?us-ascii?Q?WVL2FpZz3DHMrsuy5F1ufwzKQz4wLblSM6wfSLHJdlzPAblVP9BtuPrADfuS?=
 =?us-ascii?Q?aPh2d2AWFPYvR/DDKfgPxV0iE1nWdPoWdh3Kulsrf7CQT/Yc2XRKVIm/lVIc?=
 =?us-ascii?Q?JFzpkgYvxOVKyIT3TyA1dnkGgMg/k9cOfkBpDwsh6wOBYLO5fgnps2srzter?=
 =?us-ascii?Q?9MFCVIPjNWVfqT9kWWv5ydKvcL88GH3pHnDuqHu2coK4JShU/XkIN7EXUbr/?=
 =?us-ascii?Q?JS+odjHsu8aCvr8Bbv+hdcTM5XTLu/arCK1Hi7JuuS2NawRkwDTp1pTWJK5i?=
 =?us-ascii?Q?CTI0N8pU8ONyTHGurRS48WCXXUDfI/9D2kpK9tOP91zDa1Evcf5PqirvgnCW?=
 =?us-ascii?Q?LcRjmdP0frWIOgfrnKsiU90046KJB1z17smT6Vm3noCJPGCQuyEWLWJHzTXO?=
 =?us-ascii?Q?UsM4Eq1OqZ0i03iOktNCsrI4Wb7XzqZgvsEXejPrsLB5ROUpVJvd87sUvRtA?=
 =?us-ascii?Q?11fl3uZLbksuoVxKTjvJ1lj4trPsW4rInKlnj2UiTnxQ1VJTnYL+QfKcK1fr?=
 =?us-ascii?Q?//7JlaOT2Gem0e1e3+DfWMQIC4l5sTboeabW5L8ENjPajCRlWqkr7KiT6S63?=
 =?us-ascii?Q?42tq9f3x658lR1BRNNbFAD4rEc2cnE6dwdUUzs4Pvnx/VyDOSy7t4BiZE570?=
 =?us-ascii?Q?2pP5so+myk2XbrAU880NEYiEJAfJlFO4GEAtRn/zXSL2UoIDk2bf7BLCTaHU?=
 =?us-ascii?Q?rqLhk2rEAprGWzSc+6dtuAyR7a5dCyXumw3o2VNjm3PWLO2AJgAG43sYYIXH?=
 =?us-ascii?Q?FhHAL8OTCdikTzgf68iQlhlr1SERUaD+BwI0XawrHe04bI3eMP2k1IKw4uk/?=
 =?us-ascii?Q?u5hv7ZnFHnH6lHFgaGqTgzypFCph2Zr5yiaQxyykyi89JWLhkLRimkPXx28U?=
 =?us-ascii?Q?xrEv1TO65Ln4flHOYWvmVdaGdQxEsxQ32dwOJJP7bLZBkaB4DFcN9bFf9aZS?=
 =?us-ascii?Q?5t89bHanZw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35957043-eb24-4f3a-0557-08de5e6ecef6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:11:54.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KLN0XJ5wWbARn6JFj2jBImBBTir0JshF4NsGRkwKNwhl7NHPyfRL+nO1+rPNwQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

On Wed, Jan 28, 2026 at 12:57:59AM +0000, Tian, Kevin wrote:
> > > - Intel: ATS is enabled when a device is probed by intel-iommu driver
> > >   (incompatible with the suggested flow)
> > 
> > This is definately not a good choice :)
> > 
> > IMHO it is security required that the IOMMU driver block Translated
> > requests while a BLOCKED domain is attached, and while the IOMMU is
> > refusing ATS then device's ATS enable should be disabled.
> 
> It was made that way by commit 5518f239aff1 ("iommu/vt-d: Move
> scalable mode ATS enablement to probe path "). The old policy was
> same as AMD side, and changed to current way so domain change 
> in RID won't affect the ATS requirement for PASIDs.

That's a legimiate thing, but always on is a heavy handed solution.

The driver should track what is going on with the PASID and enable ATS
if required.

Which also solves this:

> there is one scenario, e.g. VFIO allows domains attached to RID and
> PASIDs being changed independently. It's a sane situation to have
> userspace change RID domain via attach/detach/re-attach, while
> PASID domains are still active. 'detach' will attach RID to a BLOCKED
> domain, then disabling ATS in that window may break PASIDs.
 
> How does ARM address this scenario? Is it more suitable to have
> a new interface specific for driver bind/unbind to enable/disable
> ATS instead of toggling it based on BLOCKED?

And is what SMMUv3 is doing already. With an IDENTITY translation on
the RID it starts out with ATS disabled and switches to IDENTITY with
ATS enabled when the first PASID appears. Switches back when the PASID
goes away.

Jason
