Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57F457E7E;
	Fri,  9 Oct 2026 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526506; cv=fail; b=MNLxebmNxTNOCx56h/YUC9jkyA4wPVRTZT3IserZ0aaG3OHHY9KrhshlaHsZNMpKfGnduRRoLOtcS514kjBLcHHFr9mXo3Gaat3Qwr8gfK2ikkJ8VrrtlS9xawJeJH1ht+jQxPZAiggzQxOfZdn9jqe1J6VhS7rZlcjPRdSc4Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526506; c=relaxed/simple;
	bh=vwsbDIKtRx/FryGgVxbfDwKg2bOPA294306mh4tul/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gnj0trFWdHEs2Vugu6RJ+fuKcei2jtWhg/gbiuGdgJCqaiQZ1QDSrShHnNbhj8xjWQ0AQZpLEBJf0wsbgfksX4Zq4Z1u8LksRqE+XFv6ApFNhyK2V34Q2LnD5WCf8JGb8i6ZhILn6QnYtGCwqZTotx/OpEj/thLM+jIuQ+pJkNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5BUdnUU; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5BUdnUU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W86MJDbkHCe7sHlCH30KSCmN+cJNnwrjHlJGfpBEI3TkWygoUiNuLv4csA1BedjSNXfIDa3WBZdS9v0VZaq4aCMZ/1DdNGg2tyU065JOHGSSJ+dlUtdsp+I6LDNFit9zSvZ2FhTfgTVNR/EZUtbDZPu02xcl6hDjfdv5ra1TEajCdSeNp1TMPovVmD6NEtgHqQmB23btfLi20KLCUXO+tppI++P67VYBABctrZrivgFzpfZdACGy/Ft+09/X/N+wJplVKumKTQQRol5Rk5q4hDyxQnLgDxgshmCKVExS00oFObaMhN8hVbkUct8gqFKp19/Tm43Ernblmf8d9lUOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYAiC7sbcLzkd5IONPOc100XBE37miag5VUa/NTOnk8=;
 b=gLeiGD6N03Cxqhvi5LGZszWPASOP4uq4XBlPsuUoW4YZSs0W+BLndgSBibP+oAmr+zucmo2gRY/O4mJmC6s/JvlEaGunAMErUEkkBc9ZbusOQ94OhyNoVHi8A5Vtn5CjDuGnXGkLT4RZn+xJ/epJNQvfVIEwcOPUpclp8xVguP5gDMGLI9eXHhIeYSscWv6zf+uxXlS6cp4n3KA7JO7qu4VrlQZ8lbYl7tAkJibKIhcN4VVgqKa7KFYCpE50jJnAobRITFbYtmqYBbMEWHA7493nPSVYnp6mxL7J6B18l3HaKt7F771aAc7ueeMPzZLcQQNKR1rCa/K6iWrQRkjjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYAiC7sbcLzkd5IONPOc100XBE37miag5VUa/NTOnk8=;
 b=X5BUdnUUoENqHivK0Rc2yQuy9ZRqIyYGlvrO9/8334KpqmmHunjWBsqOq5Zf3NJkLCalsCe/xcvnADrnZTcDbPLnk4YOqNLEfH2gZmbeH+1WZDgOSb7CPmMxWeMp+ktWTVTfhIOM44RhX7erZXakC9IOmOyHJSjon7VAdpnepLAQ7pNRJD7F6cuBqD18JCjRsYMPPvKqLdyuwYf+0xKKeFWJmdJneV2S2xGlMPUP9tR77nKfgluycFZl2L+dsyvqz5fMa483SIlmEfoA1nOGREhv/27lxpfn0bFvYWDAzjUo+wCz7RYwKTDPphNMKlYcVUnbAIKZ0gRUnjiM3hag2w==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:56 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:56 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset
 points
Thread-Topic: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset
 points
Thread-Index: AQHdRgres5Ma1HVBlU6C3tbUNuoztLbZ47kAgBr0PHA=
Date: Fri, 9 Oct 2026 06:14:56 +0000
Message-ID:
 <IA1PR12MB90306EE62F781EFF5EDF59EBBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-26-mhonap@nvidia.com>
 <20260921201306.49247ac5@shazbot.org>
In-Reply-To: <20260921201306.49247ac5@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: c6dcbfbe-5799-41be-847a-08df25cca403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 Z4i+Tx7T9n1KC8/djOoUW5LNxF2bNyAnIZ7vJhFrwA9/fH8K0iRhWxc2pSubvPQ+4grZHph5gXcexfLRVi2oxQSBloGllTbhQTD7OOnrRO+2MEyMCqfR2hkl/Zl+YXP+bsxyRNcp06RbKFahY6ix4n7DfjOMsKVgjfpQhg56vG9ZNVIQpzr5Noy4ubPaCtLWnukWR10bclc1fwYyO3U/40jjP2fBptA9N762t1S5F07WqzkfILlEKrQqxwWnvA98A6aFns8+027VfbAjepfqggPEZoGmwg9IXWQojTEeSQf/Myo7vOM4dZiuabEwEaOvMM4XT+ZvtgrCsOk6aLkeGsx3NhPewBE9LwlPaxCsbSlHdH5Kq83FdSpT/GQxhQbHwSkpoHAblYHtqN0kWz0yrhzI6mSN7MkrY0MrpKASc+Yq7qLrmv3kt1pRmzzJFtGs1AGJmGsqk+rB5lcGD23uk3WPyjH3CzeerP6lx127aZT7aTs+GtfwWKcmgVNON+ox8sVtdFs2ydrMrCef1Hy8CIcE8PDep9c00CV5i//5d6gKqKjBZIzKCrDIaMuCvgwhCpW/ve62ey+XDZyaZpp3X9kSy1FpBmRmyd51Er80NKfCKpkzFxYUK57Ywcl6dA8JWAs1Z7d60foS0OC7JkmkpeobgIRTdBclmeRRxSMYCpoHxKfS/dhMsVKvRLL5j5tHoU/Fzmngxc/Ju1yy0gLb6yBL6+CFm2XOopi4qQrVdLU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rWHlzI7Jf1OnU+Z90C0c+OGy5MMIiqmFqB0yWfyD0ZnGCFwDo/aDbUX3ECi6?=
 =?us-ascii?Q?Jhq2I33o0BfdlK7P2ZUaGjwzXTPndLpapvffG1GYXz1DrfUSyPXQ7wmEpqqq?=
 =?us-ascii?Q?1YO0pYrlOuPpdjjRWifTKEJuG0rSVwjlKtKLInmB787Aj/r4SKhd8Kt2yNtN?=
 =?us-ascii?Q?c/oCHgJQv0m6k1o5XAYP79kcpPV2ju4AOCNhYhjCdXlmMlbRv1XsPYfX6r0B?=
 =?us-ascii?Q?MbCfj5QlTmkSbU8toSZE+kRtCCE8YKf5yrQFVTSXyHvdTc7LF77a6Nt6UkPb?=
 =?us-ascii?Q?nMRb3uh5fMDnm7s7HszNm4iSKnaHMt/eRcU63KXyiRPVVoIgHh/3de5BrolV?=
 =?us-ascii?Q?crfBcOmSiOdGHNFtdhv+NXCEGArXTN2MHpVXZMATg6MFfgQRI56/HguLLaSa?=
 =?us-ascii?Q?dzbGD255BSo1B29M2TKWp6Lv/IngoCxJ/Pd9XgZ+dW6syrKmSO6lze/vRpGN?=
 =?us-ascii?Q?EkXoOwuC31kS/u8/1EaB5wombdWd/6tgctn3mb6VrAzhLUvRm3w09HZ5B+VL?=
 =?us-ascii?Q?/dU4m/G9jlL6ttW2SC6Eam+FhZtOroYJZUmFo3MAK7wabEYOoFJDuUsqUL2F?=
 =?us-ascii?Q?6hOYQkTYVxdYjXshTnx+alD4zBqSMAPV8gI4TuhvpBLk4xNG/cjpsnGPsanq?=
 =?us-ascii?Q?h4QTBvgw3c+ZPRmLy5E/X4fBTVn341Mt6VbqQLrtTUhJCnmNP2P0SdjQONRy?=
 =?us-ascii?Q?/UAV2G4hDsvRft9U2kKbPFq1teO/3CeyN3bWCM0oJu6kGVDPAUqaRHTRtTXe?=
 =?us-ascii?Q?J0P2Voz6duzHwfIXBcl8tntVb+FfN0mbCnwr7xLABMbYsWeCkbJxeVnM06gD?=
 =?us-ascii?Q?oTgr+7kS7te68Nen/Hcu5fhisY+cW8dNaPPIIin7eZ1ynnMNMpafneH82lzI?=
 =?us-ascii?Q?9mYqt8olF+lj0meeMi3nY2hVRTHyx1wLJXVLF4tHt+Bm4/y6nfd/fThtRLpv?=
 =?us-ascii?Q?l8Q+fthFjHO+nHAV+8tWyzbiMP53SPdUCEHVlXyl1cwsLH2M1dcDgUAY+Zny?=
 =?us-ascii?Q?RDUwz4u4fdBkm8JbvEXckljt6TninoamAQqIeQeJWn60PEM9ykk2dO9W9fZE?=
 =?us-ascii?Q?V95WzouRfBV5Jd/Tf6m6BNbUlQbq+E80p2JOSVxuRgvbxwl4O4N+2ejaqn0z?=
 =?us-ascii?Q?nvhivplC9EpsBCJz7lk41/yetlGSvxxWOvGbxasLrTEcvAznufaWPvKkHcL5?=
 =?us-ascii?Q?yaAfXvZgt6U4DFP5axd1UqAOFOVswMvGYEHdAAZbh0ELWRmZ//I4OPxNgl6U?=
 =?us-ascii?Q?Xowq/5ibRC5cpMeufghS9IsHbtrsIK4KA2tuXyyO8cZbjyVDte1ktapHHw7W?=
 =?us-ascii?Q?Ye7frviu85M0gUomL2ZPqm2/4y3mv42CGo1etWdrHj6ci4qFkF84Wj6g4b5z?=
 =?us-ascii?Q?RRRfEVLRJLtCd0Pk2ddeXb/tKURxba45fzsx5B8kB90Klz4+gm6A8/cb8SsP?=
 =?us-ascii?Q?2apk+FFT3tLpqEc05VqvzaP4aWj55gpH+kItcLg3LvMYn5akfDG452s8H88i?=
 =?us-ascii?Q?KoEBhds0eiL0x07RGHnBoMOe+BuZqk3sR8XdLuEu9bgbVrfE/DdwrZGRXRBg?=
 =?us-ascii?Q?ndXU64MAgMov6Jpja3v2w0AFTemEpc9I70E62LpwlFnLMF1XDcpJ6xI2DAa+?=
 =?us-ascii?Q?uS1QRHpKR0VT4kGbbNz8nRaILRMrt6d5KmpCjeXUjsAwhhHmxZZjz8N51OC8?=
 =?us-ascii?Q?Wd9XBw6FRZG139r6htsDfFW2tdCWm5mdIbi+7v80TBB41vFx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dcbfbe-5799-41be-847a-08df25cca403
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:56.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/e2YQlADzfYeOoqCJXghh6aZUeEuVLHV+L7S7aRwYmmu8Nt3KDNjn1nbmpdDP6rE76cHvksNng9UI0SIQdHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:43 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio res=
et
> points
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:38 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 function must not take an FLR: it resets the coherent
> > CXL.mem state and corrupts the HDM decoder. The PCI core already
> > reflects this, ordering cxl_reset ahead of flr in
> > pci_reset_fn_methods[], so a function reset of a CXL device runs the
> > DVSEC reset sequence rather than FLR.
> >
> > Route the vfio function-reset points (VFIO_DEVICE_RESET and the
> > virtualized PCIe/AF FLR writes) through a CXL reset op that runs
> > cxl_reset_dvsec_sequence(). The sequence resets the function, always
> > clearing device memory, and restores the HDM decoder and PCI config
> > state, so it is a complete replacement for pci_try_reset_function() on
> > a CXL device. The op runs under memory_lock and not the PCI device
> > lock, so
> > cxl_reset_dvsec_sequence() can take the device lock itself.
> >
> > Clear hdm_valid for the duration of the reset so a fault cannot insert
> > a PFN into a decoder that is being torn down, and restore it once the
> > sequence has put the decoder back.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 +++++++++++++++
> >  drivers/vfio/pci/vfio_pci_config.c   | 49 +++++++++++++++---
> >  drivers/vfio/pci/vfio_pci_core.c     | 77 +++++++++++++++++++++++-----
> >  drivers/vfio/pci/vfio_pci_priv.h     |  1 +
> >  include/linux/vfio_pci_core.h        |  4 ++
> >  5 files changed, 152 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 55fa1f86850d..795362aea344 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -632,6 +632,45 @@ static void vfio_cxl_reset_done(struct
> vfio_pci_core_device *vdev)
> >               cxl->hdm_valid =3D false;
> >  }
> >
> > +/*
> > + * Run the CXL DVSEC reset sequence in place of a PCI function reset.
> > +A CXL
> > + * Type-2 function must not take an FLR (it would corrupt CXL.mem),
> > +so the vfio
> > + * reset points route here. The sequence resets the function, always
> > +clearing
> > + * device memory, and restores the HDM decoder. The caller holds
> > +memory_lock,
> > + * and this path does not hold the PCI device lock, so
> > +cxl_reset_dvsec_sequence()
> > + * can take it.
> > + */
> > +static int vfio_cxl_reset(struct vfio_pci_core_device *vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     int ret;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     /* Host CPU access to the HDM range is unsafe until the decoder i=
s back.
> */
> > +     cxl->hdm_valid =3D false;
> > +
> > +     ret =3D cxl_reset_dvsec_sequence(vdev->pdev);
> > +     if (!ret)
> > +             cxl->hdm_valid =3D true;
> > +
> > +     return ret;
>=20
> Success oriented flow:
>=20
>         if (ret)
>                 return ret;
>=20
>         cxl->hdm_valid =3D true;
>=20
>         return 0;
>=20
> But I don't see how the case where hdm_valid remains false is really a va=
lid
> place for the user to land.  We don't really have a "your device is now b=
orked,
> give up" signal to the user.

Okay, I will use the success-oriented flow.

hdm_valid stays false only on a hardware failure: the device reports
Reset Error in Status2 (-EIO), does not finish within the timeout its
DVSEC advertises (-ETIMEDOUT), or the decoder restore fails.
The reset ioctl will return that error.

For the cxl_reset code, it leaves memory decode and
bus mastering disabled when the restore fails, as the host reset path
does. Due to this the HDM window stays closed, with faults returning
SIGBUS and its dma-buf revoked. I will not add a new signal for this case
of failure.

>=20
> > +}
> > +
> > +/*
> > + * The HDM dma-buf may be armed only while the decoder is valid.
> > +After a failed
> > + * reset hdm_valid is clear, so the generic memory-enable re-arm must
> > +skip the
> > + * dma-buf rather than map DMA onto an unrestored decoder.
> > + */
> > +static bool vfio_cxl_hdm_active(struct vfio_pci_core_device *vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     return cxl->hdm_valid;
> > +}
> > +
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .init           =3D vfio_cxl_init_device,
> >       .release        =3D vfio_cxl_release_device,
> > @@ -639,6 +678,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .close_device   =3D vfio_cxl_close_device,
> >       .reset_prepare  =3D vfio_cxl_reset_prepare,
> >       .reset_done     =3D vfio_cxl_reset_done,
> > +     .reset          =3D vfio_cxl_reset,
> > +     .hdm_active     =3D vfio_cxl_hdm_active,
> >       .owner          =3D THIS_MODULE,
> >  };
>=20
> It's vfio_cxl_ops, so it's unique to CXL, but still leaking HDM to vfio-p=
ci-core as
> something it needs to care about is pretty ugly.
> It should be something generic, but also this should be wrapped in some
> abstraction in vfio-pci-core.
>=20

Agreed. I will drop this in v6.

> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index 9a020a768055..8a5a737efa31 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -630,7 +630,14 @@ static int vfio_basic_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               *virt_cmd &=3D cpu_to_le16(~mask);
> >               *virt_cmd |=3D cpu_to_le16(new_cmd & mask);
> >
> > -             if (__vfio_pci_memory_enabled(vdev))
> > +             /*
> > +              * Re-arm the dma-bufs on memory-enable, but keep a CXL d=
evice's
> > +              * HDM dma-buf revoked while the decoder is unrestored (a=
 failed
> > +              * reset leaves hdm_valid clear); re-arming would map DMA=
 onto a
> > +              * decoder the fault path still gates. Plain vfio-pci is =
unchanged.
> > +              */
> > +             if (__vfio_pci_memory_enabled(vdev) &&
> > +                 (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
>=20
> HDM space and BAR MMIO space are governed by different things, how can
> we combine them here to say that dmabufs are invalid until both are activ=
e?
> That's not how the hardware works.  Does the HDM need a separate address
> space of dmabufs to toggle independently?

Okay. In v6 each vfio dma-buf records the region it was exported from.
vfio_pci_dma_buf_move() keeps moving the BAR dma-bufs on memory enable
changes, as upstream, and a new export revokes or re-arms the dma-bufs
of one device-specific region. vfio-cxl calls it around reset, bus
reset and low power.

I will revert the memory enable paths in vfio_pci_config.c back
to their upstream forms.


>=20
> >                       vfio_pci_dma_buf_move(vdev, false);
> >               up_write(&vdev->memory_lock);
> >       }
> > @@ -720,7 +727,8 @@ static void vfio_lock_and_set_power_state(struct
> vfio_pci_core_device *vdev,
> >       }
> >
> >       vfio_pci_set_power_state(vdev, state);
> > -     if (__vfio_pci_memory_enabled(vdev))
> > +     if (__vfio_pci_memory_enabled(vdev) &&
> > +         (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
> >               vfio_pci_dma_buf_move(vdev, false);
> >       up_write(&vdev->memory_lock);
> >  }
> > @@ -910,8 +918,14 @@ static int vfio_exp_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> > -                     pci_try_reset_function(vdev->pdev);
> > -                     if (__vfio_pci_memory_enabled(vdev))
> > +                     ret =3D vfio_pci_reset_function(vdev);
> > +                     /*
> > +                      * Keep the HDM dma-buf revoked if a CXL reset
> > +                      * failed; re-arming would map DMA onto an
> > +                      * unrestored decoder. Mirrors the reset ioctl.
> > +                      */
>=20
> We don't have granularity of "the HDM dma-buf".

Okay; the per-dma-buf region index above will add this part.

>=20
> > +                     if (__vfio_pci_memory_enabled(vdev) &&
> > +                         (!vdev->cxl_ops || !ret))
> >                               vfio_pci_dma_buf_move(vdev, false);
> >                       up_write(&vdev->memory_lock);
> >               }
> > @@ -995,8 +1009,14 @@ static int vfio_af_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_T=
P)) {
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> > -                     pci_try_reset_function(vdev->pdev);
> > -                     if (__vfio_pci_memory_enabled(vdev))
> > +                     ret =3D vfio_pci_reset_function(vdev);
> > +                     /*
> > +                      * Keep the HDM dma-buf revoked if a CXL reset
> > +                      * failed; re-arming would map DMA onto an
> > +                      * unrestored decoder. Mirrors the reset ioctl.
> > +                      */
>=20
> Same.
>=20
> > +                     if (__vfio_pci_memory_enabled(vdev) &&
> > +                         (!vdev->cxl_ops || !ret))
> >                               vfio_pci_dma_buf_move(vdev, false);
> >                       up_write(&vdev->memory_lock);
> >               }
> > @@ -1781,9 +1801,22 @@ static int vfio_cxl_dvsec_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               status2 |=3D PCI_DVSEC_CXL_CACHE_INV;
> >       }
> >       if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> > +             int ret =3D 0;
> > +
> >               ctrl2 &=3D ~PCI_DVSEC_CXL_INIT_CXL_RST;
> > -             status2 &=3D ~PCI_DVSEC_CXL_RST_ERR;
> > -             status2 |=3D PCI_DVSEC_CXL_RST_DONE;
> > +
> > +             if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +                     vfio_pci_zap_and_down_write_memory_lock(vdev);
> > +                     vfio_pci_dma_buf_move(vdev, true);
> > +                     ret =3D vfio_pci_reset_function(vdev);
> > +                     if (__vfio_pci_memory_enabled(vdev) &&
> > +                         (!vdev->cxl_ops || !ret))
> > +                             vfio_pci_dma_buf_move(vdev, false);
> > +                     up_write(&vdev->memory_lock);
> > +             }
>=20
> Isn't this branch deterministic?  IIRC, we only install this handler when=
 vdev-
> >cxl_ops and that ops always registers a reset function.

Yes. v6 will make the .reset mandatory: registration refuses ops without it=
,
and I can remove the checks.

>=20
> > +
> > +             status2 &=3D ~(PCI_DVSEC_CXL_RST_DONE |
> PCI_DVSEC_CXL_RST_ERR);
> > +             status2 |=3D ret ? PCI_DVSEC_CXL_RST_ERR :
> > + PCI_DVSEC_CXL_RST_DONE;
> >       }
> >
> >       *pctrl2 =3D cpu_to_le16(ctrl2);
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index f02a5240aa71..8bd4db7afefe 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -643,8 +643,27 @@ int vfio_pci_core_enable(struct
> vfio_pci_core_device *vdev)
> >               goto out_power;
> >
> >       /* If reset fails because of the device lock, fail this path enti=
rely */
> > -     ret =3D pci_try_reset_function(pdev);
> > -     if (ret =3D=3D -EAGAIN)
> > +     if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +             /*
> > +              * VM power-on resets a CXL Type-2 device through its DVS=
EC
> > +              * sequence. vconfig is not built yet here, so take memor=
y_lock
> > +              * and call the op directly rather than the wrapper.
> > +              */
>=20
> B does not follow from A: what's vconfig got to do with taking memory_loc=
k
> here?

This is a mistake in the comment added here. I will update this in v6.

>=20
> > +             down_write(&vdev->memory_lock);
> > +             ret =3D vdev->cxl_ops->reset(vdev);
> > +             up_write(&vdev->memory_lock);
> > +     } else {
> > +             ret =3D pci_try_reset_function(pdev);
> > +     }
> > +
> > +     /*
> > +      * -EAGAIN means the reset could not run. For a CXL device any re=
set
> > +      * error must also fail the open: a failed DVSEC reset can leave =
the HDM
> > +      * decoder cleared or unrestored, and continuing would expose the=
 HDM
> > +      * region for host access through a decoder in an unknown state.
> > +      */
> > +     if (ret =3D=3D -EAGAIN ||
> > +         (vdev->cxl_ops && vdev->cxl_ops->reset && ret))
>=20
> This suggests to me that our abstraction is lacking.

With the HDM window closed after any failed reset, the enable path
will not need a CXL case. It fails the open only on -EAGAIN, as upstream, a=
nd
a device whose reset failed at open keeps its HDM window closed until a
reset succeeds.

>=20
> >               goto out_disable_device;
> >
> >       vdev->reset_works =3D !ret;
> > @@ -845,16 +864,30 @@ void vfio_pci_core_disable(struct
> vfio_pci_core_device *vdev)
> >        * overwrite the previously restored configuration information.
> >        */
> >       if (vdev->reset_works) {
> > -             bridge =3D pci_upstream_bridge(pdev);
> > -             if (bridge && !pci_dev_trylock(bridge))
> > -                     goto out_restore_state;
> > -             if (pci_dev_trylock(pdev)) {
> > -                     if (!__pci_reset_function_locked(pdev))
> > +             if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +                     /*
> > +                      * VM power-off resets a CXL Type-2 device throug=
h its
> > +                      * DVSEC sequence. The sequence takes its own dev=
ice lock,
> > +                      * so run it outside the lock below.
> > +                      * vconfig is already freed here, so call the op =
directly
> > +                      * under memory_lock rather than the wrapper.
>=20
> Again, the comment doesn't actually justify the behavior.  In the previou=
s,
> vconfig is not setup, so take the lock, here vconfig is already freed, so=
 take the
> lock... meaningless.
>=20
> Also, are we dropping the try-lock semantics?  How's that justified?

Sorry for the churn; No, I am not dropping the try-lock semantics.
cxl_reset_dvsec_sequence() takes the device lock with pci_dev_trylock(); it=
 returned
-EBUSY whereas pci_try_reset_function() returns -EAGAIN.

In v6, I will return -EAGAIN so callers see one errno for contention.

>=20
> > +                      */
> > +                     down_write(&vdev->memory_lock);
> > +                     if (!vdev->cxl_ops->reset(vdev))
> >                               vdev->needs_reset =3D false;
> > -                     pci_dev_unlock(pdev);
> > +                     up_write(&vdev->memory_lock);
> > +             } else {
> > +                     bridge =3D pci_upstream_bridge(pdev);
> > +                     if (bridge && !pci_dev_trylock(bridge))
> > +                             goto out_restore_state;
> > +                     if (pci_dev_trylock(pdev)) {
> > +                             if (!__pci_reset_function_locked(pdev))
> > +                                     vdev->needs_reset =3D false;
> > +                             pci_dev_unlock(pdev);
> > +                     }
> > +                     if (bridge)
> > +                             pci_dev_unlock(bridge);
>=20
> Abstraction leaves a lot to be desired here.

I will refactor this part for correct upstream shape.

>=20
> >               }
> > -             if (bridge)
> > -                     pci_dev_unlock(bridge);
> >       }
> >
> >  out_restore_state:
> > @@ -1592,6 +1625,20 @@ static int vfio_pci_ioctl_set_irqs(struct
> vfio_pci_core_device *vdev,
> >       return ret;
> >  }
> >
> > +/*
> > + * Reset the function. A CXL device runs the CXL DVSEC reset sequence
> > +in place
> > + * of a PCI function reset: it replaces FLR (which would corrupt
> > +CXL.mem),
> > + * always clears device memory, and restores the HDM decoder. Callers
> > +hold
> > + * memory_lock for write.
> > + */
> > +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev) {
> > +     if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
> > +             return pci_try_reset_function(vdev->pdev);
> > +
> > +     return vdev->cxl_ops->reset(vdev);
>=20
> This is all inverted logic and I don't understand why we're trying to lea=
ve the
> reset op optional, make it mandatory:
>=20
>         if (vdev->cxl_ops)
>                 return vdev->cxl_ops->reset(vdev);
>=20
>         return pci_try_reset_function(vdev->pdev);
>=20
> But we're again losing the try semantics on the cxl path(?) and naming of=
 the
> wrapper drops the try semantics as well.

Agreed. I will rename this to vfio_pci_try_reset_function(), and CXL path w=
ill keep the trylock.

>=20
> > +}
> > +
> >  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >                               void __user *arg)  { @@ -1614,8 +1661,14
> > @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >       vfio_pci_set_power_state(vdev, PCI_D0);
> >
> >       vfio_pci_dma_buf_move(vdev, true);
> > -     ret =3D pci_try_reset_function(vdev->pdev);
> > -     if (__vfio_pci_memory_enabled(vdev))
> > +     ret =3D vfio_pci_reset_function(vdev);
> > +     /*
> > +      * Re-arm the dma-bufs on success. A CXL device whose reset faile=
d
> leaves
> > +      * the HDM decoder unrestored and hdm_valid clear, so re-arming i=
ts
> HDM
> > +      * dma-buf would map device DMA onto a decoder the fault path sti=
ll
> gates;
> > +      * keep it revoked until a reset succeeds. Plain vfio-pci is unch=
anged.
> > +      */
> > +     if (__vfio_pci_memory_enabled(vdev) && (!vdev->cxl_ops || !ret))
> >               vfio_pci_dma_buf_move(vdev, false);
>=20
> I don't think we're doing dmabufs correctly for CXL, I don't see how they=
're the
> same address space, or TBH, how we can have a reset fail so catastrophica=
lly.
> Thanks,
>=20

In v6 I will separate them as described above.
A failed reset will leave the HDM window closed until a later reset succeed=
s.

> Alex
>=20
> >       up_write(&vdev->memory_lock);
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index c268c99aea82..e1ef21806a2f 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -78,6 +78,7 @@ int vfio_pci_set_power_state(struct
> vfio_pci_core_device *vdev,
> >                            pci_power_t state);
> >
> >  void vfio_pci_zap_and_down_write_memory_lock(struct
> > vfio_pci_core_device *vdev);
> > +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev);  void vfio_pci_memory_unlock_and_restore(struct
> vfio_pci_core_device *vdev,
> >                                       u16 cmd); diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > 39a28cc6ae8c..231679dead45 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -74,6 +74,10 @@ struct vfio_cxl_ops {
> >       void    (*close_device)(struct vfio_pci_core_device *vdev);
> >       void    (*reset_prepare)(struct vfio_pci_core_device *vdev);
> >       void    (*reset_done)(struct vfio_pci_core_device *vdev);
> > +     /* Run the CXL reset (always clears CXL.mem) in place of FLR */
> > +     int     (*reset)(struct vfio_pci_core_device *vdev);
> > +     /* True while the HDM range is valid and its dma-buf may be armed=
 */
> > +     bool    (*hdm_active)(struct vfio_pci_core_device *vdev);
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };

