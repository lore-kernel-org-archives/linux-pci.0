Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF64418E4;
	Fri,  9 Oct 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526502; cv=fail; b=KBdSe/LhB1upCEbMz2v2+J0tBA3r3QKJgz4zM7vR0J66dx6nHm9sGCvKX9m/eW+gEIxpbuaU9ox0R582kwCtT6rSZU/uFEchS96+hsk5FIRev3G+ANaiTFBUTYHfjFAVB+3BjF/WJh7praBarxrQvuS+8AVHFySv6FHrTvAlaI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526502; c=relaxed/simple;
	bh=+9kFiFoEAHpvUJ2EdiwXikqvEMJIW4MSb/gyL5TWBu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAKvSXl08xWpIwcEcZ0JW0M6+0d+P3UIHiNPTnC5eOX4sUDeMjIBBRGFZo6xqh41/wSeAPEHX11Wz3MfFZqmmjiXZ/08wwmINgD4x6e3pePZfUSa1G8B+d8trkK3khYNrDqQnuGVyNTA7T3XRped6VPHT6E0C/1Bny8fWsAi1nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLp5ULBt; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLp5ULBt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh1yKpqfLzpF08nPOdKGwiy+P6fPdIBIPAFqoXl8yzFyVZ6AYnc9UKKc1MVb7CNSZ6aLRa49EZuKfnHVbr/crUCvVeE06piQ8qNvU3s6dNk2GfnKdtAAN/FIoxlobMoGn50CVtOGIoZovyTV6/vOM1PR/OsMvbVFjwkIM4+6mWvcaIee4Z2zGfwaJfIUFVjr+7RpnQYtA86/SKfpd/7NHJxVPz9RDTXMcKbDQWkx6nx36H1zLr7pckkrCCmZcWkjv95hkHWDeN+PMrih3VRoquoxTh3r140iKoM0M+KuIM6pXVgXpcG7bGC4GQ3Xn5FZfwG4FfG74TyuVsq9vKvn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2X3jS7fwYFDNYRlZI85C1Kyy/u6mv9NDeoIvg5z3M0=;
 b=rnTKKn1tL1QEcZUaYFSH/YvVZQG8r8D7v/5UEVLKFTEzLCzY3WapWsx0ReB/3feDq0NvNFFJBF+uos32Rd9DsacJmKxky4+BTECejKcCckY5qFxeyWM9qUoU3BgoD3EeKnC050QiNG7lqQivGXso4EW1hQXl8IjbbgQa6S8XGeQ6gn8PiJEf8xzVt3osSYIcxj2/X5BjzfAUsfoWsmPa22gbd8PnehtjM8lOAYDSgwmGspCTPduqm1qGVbueSn17a42WVjwRanpqIxnVADobWRTE8TLz1zlFBTKRYQnraYGCnx7of01GKJkrxz/XoGmcUAOyMp9JPp54pILrnmrezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2X3jS7fwYFDNYRlZI85C1Kyy/u6mv9NDeoIvg5z3M0=;
 b=YLp5ULBtti6jUvSqvq2rltRPlGcUliM0esJdmUybaj2k6e6854h+QQawJmTX3yCvToF5zUAkqnzHtGvsvR7ss2/uYcoNPsmNe7zaljubdBfQn0utN+rz0Bq1afyFK3rCwflLdu2gDShafQ2s4crnNd2XGwAzNUfHUt1IlsxUTfDdNuaI7Nq+1nNIgCaUzBM5z/sb8QqQxrm0hNG9q2hXnsB/mYXiKXjK5FnLh9fPsZyJi1taQpR3DphuFPm5ND0+v53nAzjDcOurZnne6gvuTViBqza2LorAPNkf/PM10bwI4aScLdPUga0dYiCQToKs9P6DVjW4Jp/BU8pWO7pehA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:53 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:53 +0000
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
Subject: RE: [PATCH v5 22/27] vfio/cxl: Clear the HDM access gate after a hot
 reset
Thread-Topic: [PATCH v5 22/27] vfio/cxl: Clear the HDM access gate after a hot
 reset
Thread-Index: AQHdRgrIda2JmoN/KEiScVadC5IVMbbZ48SAgBryXTA=
Date: Fri, 9 Oct 2026 06:14:53 +0000
Message-ID:
 <IA1PR12MB9030AC5722D9FC88BBC8B1B1BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-23-mhonap@nvidia.com>
 <20260921201315.6e237710@shazbot.org>
In-Reply-To: <20260921201315.6e237710@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 66817b36-8216-49e1-4a92-08df25cca23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|5023799004|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 IfjufuHlJEBVdY/YwUXYWQKUI165R4qQDPITQvs1Vph6714x4+AfYEHRS3QklMXApbj4oZaN4JRwZnFnbrEU3gEUIPtnL4ak5v2h+D0ciWb2I7ZIE92ytUdRfBBaHneAOu3vAo3kdfMVHv7rheJdqGIRf3vP42wpgDzwSYuMjtHQVmU0tBIK6ZqFPdkiv4J8G46B13G0HxPaB5jTmoSyYwFlha86Y7rnPVTW7poY9BSxuLxdm4j4MAZyAmzlYaDhxzuJkHbo6257H6RLlhK/Vk6Bki7zRvnTVH4R+RSm/XUK71c8HxZ7hvg54L7wZ9wpMm1sB6urenaxdtJyKFnF8u/6tCl+bQjkjlA6XwToCpM3+PUIBdmoK591kSVX5W/UnQbAPC7oDYS5DLwCyPP8NUC8htLQFztABI3O+xbx4rJraef90EAoy2UH76fwYkeRmVZJRp98GfCfurBsLazJ0RK2zP1rBE1ljgtT9r/X+ulu9/wCj0bAqtvYlM47Z/fRzIRFkRgNv+8R96qzwzcfCvrZOfnXi8Qqj+wpkjyDZLuSEimP4bAul1b/cLE0NLauk1NBPzxoPqUVUrXSXL/ETGIMhQ4Vfh+zQorNxU/nx16paNw5jVFbnLrkCew72iTCp9JJLI9Gki92FMizmEBjmK/WT3N3AIJnwd267pzd79+zQd36OI7r6aJ2ut17LOVVUL5fHGNhBvKVHQit4vmfaxfoEmToBIam6wy65jl6WZg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q69FU3v6KH8tRJxnhVga+tMTEBHk2eOqGrjI4FY1XQnkWd7nRZ52o6+xGKjA?=
 =?us-ascii?Q?7T5jsKSEUKUtizjKheSxJPtFd8mbfZijHC1IjiVgFeg4E4jDdN/tyhpBZ2oW?=
 =?us-ascii?Q?PYlKAS3duKeODR5RNULemssaqztJDRaGU4dxMwMu4x66Tzb7rRe4Y9z1QtiH?=
 =?us-ascii?Q?kLdSacqeAD6nTGPtbxVeV0uyCESrhipo3IyfWOmQ9B5s+zvSDR2YL/hcPkX5?=
 =?us-ascii?Q?kVXBa6Z8Hsj1lfE1GldHRw7msK+OL1jTTt0t4hloVX9luyw2DCrM1CFbrDvm?=
 =?us-ascii?Q?8Pcy7BmIEJ3LJuKUwkIo2l2rT+BXQDPxrMihc0ERWkQJPmVNuWwVmx333O81?=
 =?us-ascii?Q?j5zDXAGBGNMfCjZiOF5tpwIPII0Bcndw0SKr5WjdbyoYvI9RxmXhEMLUrwYW?=
 =?us-ascii?Q?L+F1Yi/CPX1wuCYVgNKQCNZww8803aKmN2LOtb4f30JwbjBiHIw5XaG3LqjE?=
 =?us-ascii?Q?tYGUNlO0yHltsl5Sb7J5ULPxju5NR8ux7iOhF2NhHMsY394urzsTeKb/ObNX?=
 =?us-ascii?Q?q8VZXnDvQ/pHkr+cQEarVIBghus6Ym4vz9nQ+GWkDvzXPKU8BEXc8rWGWTNc?=
 =?us-ascii?Q?7YxV0j29/W9xaG6x/IE4bfirAeul7CduQHj5c8EGoKkoLx73Ui4/pPHX2DoX?=
 =?us-ascii?Q?z0G3EetXValJsdParRNKiJMIsTqsWe6hHCX9CQlRkOLHtcKe47CK5Z5SzuB0?=
 =?us-ascii?Q?fd2wV0VZWVDYmGKUlN4Qs+h7GTfH6OoLXgBd64LUfJPyy8W8zdxANIlgwBu2?=
 =?us-ascii?Q?T2wO2fvReJJYaehZebNPwGboVY5XdUOAeoDUlrJCD+3zlSQTD4gupc/ZnjHS?=
 =?us-ascii?Q?xGXBnI+AQRMJzsrwJ48meOFLs/BD1DkTtLhN5ERqp6NfHLIbnrHf/5DeZ7ZN?=
 =?us-ascii?Q?ez2BxX9O7kKtaLnEBis8I435CFnO2iHV47Dc2fMPNF+Vu14usPEKft5UQLye?=
 =?us-ascii?Q?ck4ekWDikrFPX+hzjLNzqwAnoSlWHxPK+CcnBlMOKdWslNeuQYYjErAbaAl4?=
 =?us-ascii?Q?KHIxe8l6OBvlRjb8U96mxlzhs2GvADwrEb1zRO2G2tP3bA3o8LyVqUdTN9zk?=
 =?us-ascii?Q?MYJWOknGbT5XNXKScRDUlysGIbLtZyWd/QODBs1ZtjH1kIwB3xm3+nRRKJHA?=
 =?us-ascii?Q?nmRnbyWlQHLJgsT85x+3cuHbmz/qm97E5OxmELK60OdW8FYWcBhT9mWJGz/p?=
 =?us-ascii?Q?NA/qo+w1mzU+GFzYMrX1ipMSRs+b4cM+kAL/AaxeI2fCPDaSHBCD1Jr2oTLa?=
 =?us-ascii?Q?I3Wb+iDDfIDhPrUTHQSGE5UQlLlhub22lAPyKum6DUkyfLyCKMazM28zn6RX?=
 =?us-ascii?Q?zRin+YaAAc7eTdHyWfb7IUYjcf9kwLPrAkuQs8IIBtr/7lcHXrArhXpNtv6h?=
 =?us-ascii?Q?4mUr+5r14rCcPyVwhln4uk1z+H2lzV6sAIukE0Ole8N9dpfr+nnNZ9w6Z2VU?=
 =?us-ascii?Q?NO5M9FImz94f3doCVzOUJ3t9wo73RIo/Nf3EzxJVL7mNRgN1214sRAMa13Fu?=
 =?us-ascii?Q?OD+yN3tsVoBsPPBrMJQtn7ms/sgH46u/nzP3TrDTHdAjJBFpDbfNxUQeyGlG?=
 =?us-ascii?Q?UO/30SVaSRCccPRtTbeeLpOAar0LLuEyiZqIw52wrhPUO4f5+utnmwIrGAd2?=
 =?us-ascii?Q?EHbj7u1iRSaODsbUSN+qk+e183OOYYFGdvI2I0PRyTChQcF62svpnfRgkt3y?=
 =?us-ascii?Q?bjOn6HIqtILikB8+LstYXX67ftnuBWEbTK4vL03i0k6zwyY+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66817b36-8216-49e1-4a92-08df25cca23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:53.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bBrIhswsXqOqIy3yk6g/TxpRDrPCUbrx3epm6frXJw+9qZWDEEaO544AwaPOfK6c5jMeYhLINETWMW+k84Yyw==
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
> Subject: Re: [PATCH v5 22/27] vfio/cxl: Clear the HDM access gate after a=
 hot
> reset
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:35 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The HDM memory fault inserts a PFN only when the decoder is in a
> > known-good state (cxl->hdm_valid), so the host CPU never faults the
> > coherent range into a disabled decoder.
> >
> > VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset rather
> > than the CXL reset sequence, so nothing restores the decoder in the
> > reset_done handler. A secondary bus reset only reaches a CXL endpoint
> > when the upstream port has SBR unmasked (CXL r3.1 sec 8.1.5.2); in
> > that case the reset decommits the decoder, so clear cxl->hdm_valid to
> > keep a later fault from inserting a PFN into a dead decoder.
> >
> > A subsequent VFIO_DEVICE_RESET runs the CXL reset sequence and
> > restores it, and a masked SBR is a no-op that leaves the decoder intact=
.
> >
> > vfio_cxl_sbr_unmasked() mirrors the cxl_sbr_masked() check the PCI
> > core uses (drivers/pci/pci.c) for its own CXL bus reset.
>=20
> This all sounds very broken.  If a hot reset is masked, it should fail, n=
ot silently
> do nothing.  If a hot reset is unmasked, we can't just invent that the us=
er
> needs to follow it with a reset ioctl, and the decoder is dead for the re=
mainder
> of their session otherwise.
>=20
> So on one hand, we have a reset we can't use because it doesn't do anythi=
ng,
> and on the other we have a reset that we can't use because in doing
> something it makes the device effectively unrecoverable, without some
> assumption to perform a reset ioctl.
>=20
> Are bus resets just not supported on CXL devices through vfio-pci?
> Thanks,

I will try to handle both these cases in v6 correctly:

1. Masked
with Unmask SBR clear in the port's CXL DVSEC, the SBR does nothing to the
device (CXL r3.1 sec 8.1.5.2). The PCI core already refuses pci_reset_bus_f=
unction()
in that case. I will add the same check to the bus and slot reset paths and=
 their probes, so
VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and VFIO_DEVICE_PCI_HOT_RESET fail for t=
he
device instead of doing nothing. A VMM will then use VFIO_DEVICE_RESET, whi=
ch runs the
CXL reset. I will add the PCI core change in its own patch.

2. Unmasked
The reset clears the decoder, so vfio-cxl's reset_done restores it with the=
 same cxl-core
helper the PCI core's cxl_bus reset method calls after its SBR, and reopens=
 the HDM gate. If the
restore fails, the hot reset ioctl returns the error. No follow-up  VFIO_DE=
VICE_RESET is needed.

>=20
> Alex
>=20
>=20
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 38
> > ++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 37e8a3b54cfb..395b4a5b0956 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -514,8 +514,46 @@ static void vfio_cxl_reset_prepare(struct
> > vfio_pci_core_device *vdev)  {  }
> >
> > +/*
> > + * A secondary bus reset only reaches a CXL endpoint when the
> > +upstream port
> > + * has SBR unmasked (CXL r3.1 sec 8.1.5.2); otherwise the Bridge
> > +Control SBR
> > + * bit is ignored and the decoder is left intact. Mirrors the
> > +cxl_sbr_masked()
> > + * check the PCI core uses for its own CXL bus reset.
> > + */
> > +static bool vfio_cxl_sbr_unmasked(struct pci_dev *pdev) {
> > +     struct pci_dev *bridge =3D pci_upstream_bridge(pdev);
> > +     u16 dvsec, ctl;
> > +
> > +     if (!bridge)
> > +             return false;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(bridge, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_PORT);
> > +     if (!dvsec)
> > +             return false;
> > +
> > +     if (pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> &ctl))
> > +             return false;
> > +
> > +     return ctl & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
> > +}
> > +
> >  static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)  {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +     /*
> > +      * VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset, =
not
> the
> > +      * CXL-aware cxl_reset_bus_function(), so nothing restores the HD=
M
> > +      * decoder here. When the upstream port has SBR unmasked the rese=
t
> > +      * decommits the decoder; gate host access to the HDM range so a =
later
> > +      * fault cannot insert a PFN into a dead decoder. A VFIO_DEVICE_R=
ESET
> > +      * then runs the CXL reset sequence and restores it. A masked SBR=
 is a
> > +      * no-op and leaves the decoder intact.
> > +      */
> > +     if (vfio_cxl_sbr_unmasked(vdev->pdev))
> > +             cxl->hdm_valid =3D false;
> >  }
> >
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {

