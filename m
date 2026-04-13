Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B47397685;
	Mon, 13 Apr 2026 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066222; cv=fail; b=H9xZ6vu4YH54++uVx0IXD7RYqwBppt9h30YwGovFh+T7RAT5OX82IzTm65PZQSOM5Ber/Oj1mBT/+Ty+OI247Ob4b7nG8LR5raycQ7SqIXHzk7bDoausoBPmlPH5xZTLbl6Opq8Xoj++GoZIpqwGe3ylKu95bpCRlOYbebWvQgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066222; c=relaxed/simple;
	bh=Ux833cK5karvpwU49FrtX9JkCwZSlfu+1b/kyIFLdCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMsqK0SJ6w+bSjzOuqgCInFn1TVOs61GMz/YkTjAcB5El82gc7G3DZ9UATM42fik7HvKBn849mtaJszsKxHsKFkNt9G8p7uNdYu9lBPPMw0TTTxa/s9JokmKyU4kSYFpMtwM8pznVUyUv2j0aXnWh9THQdkjvmEKjoyVxau2wS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyAMyF3T; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyAMyF3T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV5EAJHsS2Lpmukl69ctURlKRCj77j6ACPlHQi9Bpb24SaUf00GWWDj9HcyVI2mNrtHyHlevEvCZvDzKAgAxzPgmwIXIY4A0MhJ6kFuWcO3Fn/EkjpmAERw/E5lo5XLDQlj7deoJQp/KGmyA0Dcxk09hA+OFtv79QFbSi1MaLIDWnYaroIUi7fjO1DreybCktBRLf14FhoHKn+lMkue7FAj4HVsFD8XFG/5x5M34CwsRjZaXFbAyY2ST16yXCmTAWHTfx9SLFPLU4U5apEBqE7llK3ilG4HmUXvu2xCGDRI6yrMb95Xwo0/OOKlOSs6/Xxxo97mYcJqTHiwNPj2qbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux833cK5karvpwU49FrtX9JkCwZSlfu+1b/kyIFLdCs=;
 b=e4w2Yg0BEn8nhEpBZLKbcfpCaIEYWhyWvvDDqA0uQdHtYtGqVFuIcQ5ltWkXxhC6dU7hlsedI5VJw8GEZ2o2CzqpQgvJq4A5PzN9ypGEE8ZCLaFR0SegP4vDk+z/rNN43vfmn5UJBmJQLnXB3JB/aQp3hLktpKL1DjdIaSSLyhxnbvEAY35nWq3B8V1bjKGrUhLdP0ZouNptrssDH7yH77ZFn73pUHXJkp2eg6OHeY+UlHLslrfrM75ZIcghTb9JPBBtFhJLvT7vJZuoClgvOLjwTwfH0dLa84UF4UjTPftKRoKEPl96YXNFk03NMLgeCQFsVeWbQ/mRT8AKlDpq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux833cK5karvpwU49FrtX9JkCwZSlfu+1b/kyIFLdCs=;
 b=tyAMyF3To2+xJ30rF+FsK3BDAWaN3RdreUYj66IgPSXra2zx/b01gHHAEd7IVm411Vs8es8l/r8zd6GiFQ39G3VhNY4hULXOUJlmxi9cE9YnqMgeELs4kl5tYIAJqJTht4zu1vOcTGRnyNkNIsdWnRVJ90SNX5LCsG7w5eSWBoeduJpfzakEio9UEomj6ij+DVoqwU+OQwUaXJkKgDptuzfwo59ITKEktV9BuPXvqhZkoZFeTSunVbbudpViH6bEIgPQBFNLeAOcfurpKnpNsSBlDozzNKUN0DdjQWRowpPoz8tCl/G4Ip440BFmTHSYr48c8aVKCpAUAQ6Vq/RjKg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 07:43:38 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:43:38 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex@shazbot.org"
	<alex@shazbot.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHcyCX5R9EjDesPzEu4UOJxNZ8MubXXt++AgATptdM=
Date: Mon, 13 Apr 2026 07:43:38 +0000
Message-ID:
 <SA1PR12MB7199195994DA825B132F626BB0242@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260409133651.92580-1-ankita@nvidia.com>
 <BL1PR11MB5271507CC920E4F039A350E78C592@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To:
 <BL1PR11MB5271507CC920E4F039A350E78C592@BL1PR11MB5271.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|SN7PR12MB6789:EE_
x-ms-office365-filtering-correlation-id: 9bba2dce-a08c-4792-1dd9-08de99305ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 jdo2g3vqeee+9wKn0f1UB4MOTZb9L70AvjzartoUv8opALJtpG2gnFlnxATeePA2VOKyymM595um/kXRwVaiuEcXbuH6Dfqa/QPXWpR1KGMwxBWAoIcgOslAw7Jy14w/a2OpimgqO8zjW08cEDrmrHBXD07m8yN3+cBjdi18Qb7Gbm1x3iWXTLOpa7dThVwlffJq2UuRCl1zRMeG4pj51yhznfUYs8aXFSNJokqMydmsWqhlMn58N4ADAntdm7JP4NClOgETf32Pz+SWUTvDp9N6IJVZzy96ZCywFM3LfvgTXBFMT2GfYUUwdgGv0/gUufRt7L1agLCCOZt2f6EgN0rR6fTJDDQMXt16CasZDldQPYFsT8Xmf0zUE/BkcPZyB5R7nvN0LxnDe5ZggIONepqmczBSg7Bl2xSlRCbQqy9NNSYDkkt1UIbAQMzUTi6xJS5MyoJNgRxWnd4Pif4yNrvxCjNnN5J4T8hxkGBN+eDZsTXMkyhQ3UNs1saFctkNnuK3n/K6Q7SW26lgRnd9xLHokJwx59Euuj0QFFw6PlTc6kPGFW/7Hsq2rlKZHcklvAoh98BRP/F/IZc8nngoBudj3udMzoBzb8IXS76wWlCSEM1H4+JLmK7X4m86jvXgarj3+t8X3Tw+C8b4RPqmA4wZJCDOtDcfaNcGLhQPLYspGHw/cQT5Pmf2qNvv6rj3AZ6s9E9oUT390+j2y4TQcfVkn/ShZ6c5CSNIu8i1RYpPthuQ6wqEySmzrHYKoH3hyq/AMfu/VHrsPPBcQZQ62JPXNVwZvpzuAMFpvec60fg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0bobWjJD/8q4415GjdUkCvczauoTtNEwC+BywhiKNRs+3Lt/ajq2mxHpqx?=
 =?iso-8859-1?Q?yvOHtFG/TyMxDniBOb9uY5fukg2nttM/HLoRpZQhxGkfYZuwMMbFajDbof?=
 =?iso-8859-1?Q?DeITkrB65PDApuiRe2/qV/QeYXqefKnmFbkwS+36vl/OfDigDT1FpDe67Y?=
 =?iso-8859-1?Q?DFECMfUx8YEKP2oDq2sjP2076951N6VqNCfHpEHY3AgKwPy9WE2dLQRELO?=
 =?iso-8859-1?Q?HUpeezZW7T6SGdTfCfyjXYGMbqEPknORgTJShv7S+mB4n00oV1IWMsPiMu?=
 =?iso-8859-1?Q?zzP1Fr1vWULGMcVotomytOq7QyyljSIgaLb6Oak7dfSHVNXQUy/LgINjZV?=
 =?iso-8859-1?Q?LHLhAj6f6MvCGbNjZ5WJSssvAYC8kw1BsL41UXB+YYf7s1OzIEcZ+lgLgl?=
 =?iso-8859-1?Q?4K9Idy5CGG0yNIpckjHdJ1tcAjzenKafXsWu0GnoIph0NOBzMBx0EaXtf2?=
 =?iso-8859-1?Q?aeKAcx2ApbCWvw2SI2X72MTAmvNmpp7Q9amFPcYgO/HopoozxBbJes2G2H?=
 =?iso-8859-1?Q?jfP8whFLvSq6LDJDhc2BPcbT1/PORB4FAUR0GK8bNuU57S+aT7k3cwKyYy?=
 =?iso-8859-1?Q?ejEZsJferniNbc9b3e8M1Q1UzyUqJFdLsIRWjOy4Sl75sIj3wmYRxs4tZU?=
 =?iso-8859-1?Q?pL5tdzcgjYWYgw9jbN2dOnAt/aWmDPwa9u2OaYeVDhQQCAGoMvYyfQRM+M?=
 =?iso-8859-1?Q?lGLA7xgg92NAxJn20P6mwhDsKIHhUhLzWHGtfrtNqhVKvzjAnrS1If+Mlo?=
 =?iso-8859-1?Q?XYHl8iEGhDmSf0jk4E8KwEyJdHC/f7oTlvFBXDr5+kw4RRMnMFU7m50WOY?=
 =?iso-8859-1?Q?aKXsuvYXLEFkNu3UertvSaW/aq9UAJFKlu45sNIO+Ms3WaoEzrENRen2OB?=
 =?iso-8859-1?Q?FTl2XcdbAYaxNSJY5Ihp2jFogL5AqU1kVWf2N2yf1JYg42J+EXj2np2Pm+?=
 =?iso-8859-1?Q?2ANPht4tESYLnpRgyOBpQz8lWBKoFDideE8TmFIp/n3SPZZODXy5pjKfYG?=
 =?iso-8859-1?Q?zaTxjS0ZWlsucRXRQu/KYJLbN3aSfOhKYfpQwgPZbJTjzKqw7jj8CokiTQ?=
 =?iso-8859-1?Q?/MylK/XCJpTJHw8mtl+nLYycaKP81Whv8P+I56c9pXpvUQXnRQzJDKFBOn?=
 =?iso-8859-1?Q?QtjlO+c36NaYf8OGa0Myn0kdbTE+s8j+MEldQQh4zq4PaQ2pGam49kPsZD?=
 =?iso-8859-1?Q?/dfiPTDX1XvGWsLMiT2xWLZ4TKaMLBWdoGDx4kN+W0veNvyhp9gT1pgPak?=
 =?iso-8859-1?Q?+lceEa1ma8BOJPuP+aFF1ba5gWJn8vtyaXa5pIjacPy0A/UFv/QGky22fh?=
 =?iso-8859-1?Q?zjDAVnE3ciN2eSLbBAHc9elT+YLA7L821nq6PUjh1K5IleuOCcOghVK/gI?=
 =?iso-8859-1?Q?l5rXtxo2lcT5+eZctpQzu9PkQivDKB9vtXixd1QJpY1HuHNSmuu0GW5bOT?=
 =?iso-8859-1?Q?UT4BfmDN7cjSBQ8N/L2aYHkrrUY3LDluNFn0SSlKQ1wSuRvlTnvrXowTPt?=
 =?iso-8859-1?Q?2dEBAm4EO6KbeWWkP5OK2CCdzoRGkC3xItssYfgIQHHA2zI2a+TKDOCvWX?=
 =?iso-8859-1?Q?pWINErBepj81bnsPJ4K+YwQgBl+po5SqBlsU8DZtdA21DhSojO0soFqtDb?=
 =?iso-8859-1?Q?NOJ2P8LyGu4CaHwpng7isnIbaHzPWq1fbZyenHaPL5L5ey3AqsWfuH8Pel?=
 =?iso-8859-1?Q?Q7fbjgbEsLw8w1z27B4Jk6IbInL0zOrs4yJZ5tsYRDOs8nZjPTCu3H4a2o?=
 =?iso-8859-1?Q?oY7ibcLqpbTvo3tTv69cd7/66xS1zqfLkDmuL/wC7+O/7IckEx4g5iq6Gu?=
 =?iso-8859-1?Q?I9iFtCywBiUPndVTarmSpdHiUfLXWfxRMJBs60EyFfIslk2Jecdl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bba2dce-a08c-4792-1dd9-08de99305ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:43:38.0287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KjXFtJE9T7r8f2dGEYxH+9cY/DP3D9QVgo7oyF83A00bR8Kb6A/RG4TSVp2bE5H0I0fqVv6V0fFDCvZyRX4Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

>> +static inline unsigned long nvgrace_gpu_cxl_mem_active_timeout_ms(u8=0A=
>> timeout)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 return 1000UL << (2 * min_t(u8, timeout, 4));=0A=
>> +}=0A=
>=0A=
> this is local to this file and simple. it's ok to remove the 'nvgrace_gpu=
_'=0A=
> prefix so the caller line is shorter. Later it may be moved to cxl header=
=0A=
> file if other callers exist.=0A=
=0A=
Ack, will fix.=0A=
=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 struct pci_dev *pdev =3D nvdev->core_device.pdev;=0A=
>> +=A0=A0=A0=A0 int pcie_dvsec =3D nvdev->cxl_dvsec;=0A=
>=0A=
> s/pcie_dvsec/cxl_dvsec/=0A=
=0A=
Ack.=0A=
=0A=
>> =0A=
>> -=A0=A0=A0=A0 ret =3D nvgrace_gpu_wait_device_ready(io);=0A=
>> +=A0=A0=A0=A0 ret =3D nvgrace_gpu_wait_device_ready(nvdev, io);=0A=
>> =0A=
>>=A0=A0=A0=A0=A0=A0=A0 pci_iounmap(pdev, io);=0A=
>=0A=
> bar0 mapping is not required in the new method.=0A=
=0A=
True, will address that.=0A=
=0A=
