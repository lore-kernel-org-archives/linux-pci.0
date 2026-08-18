Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72E26AE5;
	Tue, 18 Aug 2026 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036851; cv=fail; b=ozA+i+IYA7xlHrV3taGi1XR605nG6xqlOPBdO5pfSkY3skOPvOQWtHNpRd6nD9F+9bHCfPyrQ0VytKuWw9ACjt83ySYX/qhpZIKhJ5+b438YIYcErCb35OFg/636JFOO9OHGOSBeouqCMiLsxubIycmcr8guas2IQEM6dbRc5mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036851; c=relaxed/simple;
	bh=60NdMKT1ITYCB4d0umA3SjsPa0BUudDrdmtUPWTEZRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gLKxINgSU7lj/MN19yNmzPjqls5AzCDnwq0pV3Y9plxiPm4Uls2RrAM+P/zZZiKQ1XEeACx9d2qH5Y4JvoMGiWvILNHha7/CsR0EFql09wcAJdJS0Z2CltednnI2f3/NWMYKUoRM2hOuYlpmJvRfa+X6OrKuRNe5y73NkHO1nvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT0UHzLp; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT0UHzLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787036850; x=1818572850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=60NdMKT1ITYCB4d0umA3SjsPa0BUudDrdmtUPWTEZRo=;
  b=cT0UHzLpoPfandZswY0NTtguheO+OtDpnyXHlJJ3URszhjplbifLKC86
   0yOWfD/DQSW2lguFAsr+DNvjWh51hbZJebQv/SlorlQh21jmI5Z3eIuw4
   ErKfu3uRMxVDBV9bos3xOVUoHGReGD47rbCHLDK2ymAGFwlJPbUNUKUxY
   JMVWv884BWCt7tjPfjmyLWSUk/i5zKsPKSj11JgImVpdvR04R5+GIGbTm
   qIXW7y0/D9nUPTjoh8RQVMODG3WdRrhOFnQtAaQ7drDIAx2StX9L9ZYFK
   AaSKtbcBQ5xsfPdHwQzpCHotP+W8ZjiuqrXz5GHET6QRrOo2dVLQNe7nm
   Q==;
X-CSE-ConnectionGUID: bNB+OiMNSUqj4SaOUJRscA==
X-CSE-MsgGUID: lLQARxOsRUCeHdqLM8EUZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87376902"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87376902"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:07:29 -0700
X-CSE-ConnectionGUID: VrKl6N1ESASYOyP1g6lZvw==
X-CSE-MsgGUID: ZviMymSRRDqpRGtrhBExCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="260924371"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:07:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 00:07:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 00:07:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 00:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2YAI1GwPma02AnyfnuPLzo9nsNaTAu6e4tIf45sGBxFXlskPxpkLwI7xCFVulYEQO/dKuDsi+sItUJmraJ3QPTIQEQiWug4OPktsEJPQ/1Xd8k2slVjw5XaQdubCCQfygjGKiPeMYbRM2AuXX2RUUOeD9gv8wch35nVMSmOXtnVX9X2cn0akXZIniFwke6yRJjtKfmlddujXWsvi/m1M+ExQ9fTawsnwawGWkRjHL8nwo27/bMyyTqxG2ed4if7mEgYSVcr1DlEy7KAaT5J46VuvMj3VJo/LdjhBgH8MBAPdLFZtdrRJTBdDeq6dsDFNtut3F97bVg8IyoCSZ0zHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5QROqATSI10VyppUgb55mJStFNM4PyzNvYD12GgVfg=;
 b=b9jouUMKIlfyl2WPtYj68lmtSIvjWpAp6PwCP3ovptQ2MPtmJ4JN4wnLTMr9WkqMK1ZBCTvUud+visLaHFx30cV8cZkmYS5TO+zTMylK13WLCYL1jogxbib+W63whnJ0tALw/wTnPCPpY7FIMFO2sG/YQb5WhNOA7WP5wIAv8o9mD7K3yoKwHmae8qrR08zA+5tDvQvsPvTbCv1nLgez/GnJFFTGe2/q4dwDJbp3rH1/clr8xSL7jeBDAUoAC9oZZ86SHEo8O1oxC97uEYAXG7Beh0bcsv4mPXMNkz5KBnuTCAdzn/jRVjbP/nkj63pPAIdCg3SxTR4yaA5vLWX1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:07:20 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 07:07:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson
	<alex.williamson@nvidia.com>
CC: Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci
	<linux-pci@vger.kernel.org>
Subject: RE: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Thread-Topic: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Thread-Index: AQHdKhaLIPqzZKXYkk25YA55eR/alLacoQ+AgAD/qoCABJAJAIABKvgQ
Date: Tue, 18 Aug 2026 07:07:20 +0000
Message-ID: <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com> <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
In-Reply-To: <20260817121810.GC933791@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA1PR11MB7917:EE_
x-ms-office365-filtering-correlation-id: f81d6f52-e1d3-49e8-dca4-08defcf758af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: QvD4QKVGPQkpkFz9gG7ZTjaoMx9Ov51EEEYv5Gbf6uy2fYVozX+ik/iSc8L81i2ZpxrSKxYicu+GCQjbqnPtXsXqcFNtLltLnO3TmovBTMN4WgMplpmlEyMdX8ue8CrsLZqY4sZBR5HCndOt4Zflqyp3vbHXLMQWRcOlk0/TCp1ry64C+9kBTa89TCQzxjteUT7UAGmoZqWtQdmzEhlIGptpyiLLihEVyQaKeP/wvSjYb/BW41bai2F+4IUaMYW8SHaBa0RWSwFd6e4jVYHiTlVIkSpbyHK3rv+h8SDscgJcmbztA1ogUe1S9ikYu4swGsT9vSGsQAKOiGMH+LCRjyLRaKWrtSr8IkSYQ7P1XSXuMRMRFJ0AEcZFY1VR33bYygvBcHqEFsKkh9c6mLUT2MoimWlg75XCLFrZxnAzXCVHK4eXB0tWGr75UKXCEei3uOU6BVO/Y6wbKKWyyt1fWZgS8/m0bGlkOmhUL7GTntOIaHF8aSXpwez2BmCj3X/WbgK/PUda/6GoLDLS7vE56RDlOPJpu2ZctPsQiVeVFfbeC1bR6c2fvLIjrdoSLo+39cRFLKpFVVExMyVuRcaDKY3GzdZYenWf3zTb7bPESIqKDHlyPXk3pHCQ/wHYLjrIxC4S/Ki8vlPQ0lfxso1lEr0XWyI2oBfEeEOVIpT9uigIhcOH6oEvSdAzURMR+qi2H+ttY/6bJk+ErQwGqkscp6kA3HKLhEEVMiwiabyxTKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hs2kl8CZbUumusqAAOLVR5u90z1GOF/51JwueP63w731oFF/BDYXFYSfZGny?=
 =?us-ascii?Q?gZ9cQYdS4iv04vic3vV4sBeXLrBs+6VeAS/swMgY/MFuQR1/UG5S1FhqZIoA?=
 =?us-ascii?Q?cS/rmM6d9TqM/I8FTVxTCCjHOmcg0ms1zOTl/jEDj1HMNwXPhhSkMFajcWJL?=
 =?us-ascii?Q?rVVqgkEXaX/+mh8eFjW/TPhZYvnpzZXnbdSdYM5/ePhcbeYKrzJ5lPtL7Csk?=
 =?us-ascii?Q?Xz8TInCLnzrxqKUhDS1JwU2wtCIEt1LV5/giB5SId+//2ztik3bPkgOhpUhj?=
 =?us-ascii?Q?xjpQExD0hbsPV+3KMp1JtaApDdGQDLkJks0J8rJZY/v6mrA9WB8SsBBAaTwf?=
 =?us-ascii?Q?wHCj10F6mIwmwg1zwGYypHcKZO3QplzHQ1o8q1UqVSBKDHWn5mIy3vvPr8er?=
 =?us-ascii?Q?WxZA2iuppDYXIwkW1f/2k3L972W2N98ugjOrYLkn7AL1vrmkjA/wJyfzZx6D?=
 =?us-ascii?Q?7Bfh3I1SFlBd/7hdVP8sGQHd046mjzId+EbdALa9j2hUMCHPpZ5p1jkKUMQY?=
 =?us-ascii?Q?URLp/6DPsEwJzaQSu2EuMFO731AmZ51rOSpXW2KJGZ4udkph1970vroxzYWL?=
 =?us-ascii?Q?FM0CRG33ikDKxV+/ZxWlp5uawCvjUk5aj2kocpE1XZJF0fOIFMAIk+QhoYO0?=
 =?us-ascii?Q?Ci9T4M2y7tY9HlaqiohvBuNgScslrmpSE213s++5TN4q8tJ59Zf08vkcvYIH?=
 =?us-ascii?Q?ASWr9IB3IuPU3i0hkzSk2XTNotOahf0goo2Cvmt5fmmhriqyebk0reyNMg1h?=
 =?us-ascii?Q?hWmMRzRB4r54AfwQWp4whDx9KuZN4/U9LV/cB3aehWHOBs5Gfm29W3Fvh3t6?=
 =?us-ascii?Q?wsm3n+tTBcaZt/nZmjrbM33SwyD31lMEo8ux8Fqe9aXBrI4DCdy5+/x2KZot?=
 =?us-ascii?Q?TKLEcMVdUTZlFRPET9x1YUPrIj7E0+WMXENXZVSfu+GSq6zVtx0LnkbNa2U5?=
 =?us-ascii?Q?zRGYpUncUccGTsQF8LVea1dt61E4pv1cGpXJRyDABA0dKdHPdLKQuIAMDL8Z?=
 =?us-ascii?Q?Yan4tSbUAZhT7EVpHLx+5D0EQMxwgd53/sGQPWkrmcE0WgjR01t5/gskI7VT?=
 =?us-ascii?Q?qUWdCy4EsvtkSzdwY54am4L0jC4QbYCYD5oiVeQJWn/h+GrmDACUM8557EFy?=
 =?us-ascii?Q?KmBubn92p4Tjwv/3tYDRWSB+1FrVjNVrCrDVKOXbL5b2aI/mgwFt3BvqXl+0?=
 =?us-ascii?Q?Jdg98QU5CguwnwSWadMS5Z5BAtbG2uTKvjrJ24tVEOZzvpvD/j2JWWvf9QsY?=
 =?us-ascii?Q?i4n7DKy+GhaLltVnEIxqKDKEVaghHa3Znnzh8V58sdcaCH0n1HdB26Q7n+Pb?=
 =?us-ascii?Q?tLZF+z0NBZr7ItZmlH4ETdHSvnqZWRG7UJ1PclrouF++K/1+qiYApzRz3gsG?=
 =?us-ascii?Q?3UEtWF66L4QmrMbr3jA3gRPVRm/0TjwPa51muK4GPowhpv8wfK+9g9YOK3Qe?=
 =?us-ascii?Q?fAx+Hq20Z43tONMAk22JTKn5osKm0Nqmo18FgVyChbNQtPmCCDyxAA50ttHl?=
 =?us-ascii?Q?utcu+JzxqkOA0eQKVgeidN1zbb8uIHNguc4YcfrtV4zemUkoBMlbWDdwaFh/?=
 =?us-ascii?Q?3cur3H6r6y9JiSRxwgruDXXdCreyjSdHFQEx1KMh93PO1kCOA0N/wnKedE4G?=
 =?us-ascii?Q?F1yT/oIsFmassiy6bjHtY6JmZuEshYXNaek3mDohT4DbVbXOtg1+yTfuDcb4?=
 =?us-ascii?Q?DCWvMyXvf4MHIMNOB24calkt8XXQJnzgRiw01y+KdRzi0p0+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: serdlkX3xzHJ4gT6mMhAOvCg2zMiMkuqAa6JGKZlpJdnHOh/1cGE8+OCFDNiW6c4X3vxQy6po3Q4yL4l3EfGT+5+4M24L29ILUnMOlZi5B/6SpH5LKxI1iNn3NTlen8nlqfPRSAGxzuM2uqZVCPO8aE1U+Lcz7XdgEd3SFA3goaDCH4ej2lNuy/RG2gcVW5bjGVb9DSr89WiBj/G6FnBMN2ImY8MEqWzrQGiIdapNfae84woyKS+TzNXmY+ExN7KbTR2FL6bN+zf7v0vtJ7NF/PZa2qXnVzi2rP9cBP3kwaauGlsoXZsJqDGoUehBMyfrqFQ29m8IccEphzMNyVC3w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d6f52-e1d3-49e8-dca4-08defcf758af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 07:07:20.7910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBRYbfd06RcKNFIphsXSXnSzQkun17tFiJukhkWagNpQCikM8dPrMsApgo8g1VUgbsTzfk57gIyThkQ14Vstwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, August 17, 2026 8:18 PM
>=20
> On Fri, Aug 14, 2026 at 08:37:37AM -0600, Alex Williamson wrote:
>=20
> > Devices are only ever opened into a user owned domain, the IOMMU
> > context switch happens before this and regardless of the reset.  Close
> > also disables bus-master regardless of reset, so there's no risk of
> > ongoing DMA if the device is placed into an identity domain between
> > close and re-open.
>=20
> I've been told by HW people that bus-master isn't actually a strong
> fence for stopping DMA on most real HW. More of a 'dma will eventually
> stop' kind of thing.
>=20
> It does reliably prevent DMA during the post-FLR phase only.
>=20
> If the device hasn't been reset it should be kept on a blocking
> domain.
>=20
> > PF, I think there are arguments both that the user implicitly opted in
> > to the best-effort reset, as well as a use case that allows the PF
> > driver to fail and re-open the PF demands this behavior.
>=20
> I really think we cannot alow a device to be returned back to the
> kernel without a reset. VFIO should be keeping things attached to a
> blocking domain as long as the driver is bound. It should force a
> reset during unbinding as well if the device FD was ever closed
> without a reset..
>=20

hmm so we have several resetting categories:

1) reset a hanging PF or for administrative purpose (sysfs, vfio
   open/close etc.)

This series avoids uncoordinated disruptive impact on associated VFs
by rejecting the request. User can reinitiate the resetting request
after disabling SR-IOV.

2) resetting a erroneous PF in the AER path

The link to the PF is down. pci_{slot|bus}_reset() is called by pci core
to recover the error condition. VFs are impacted inevitably as the
cmd to disable sriov may not reach the PF at all.

Not sure any enhancement can be done to relax disruptive on
associated VFs, but so far this series doesn't change this path.

3) resetting a PF due to ad-hoc FW error

e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
reports broken PCI. Sounds a similar condition to AER.

but as it calls pci_reset_function() this series causes a regression
in case of active VFs. Is it desired?

4) Jason's suggestion to force a reset upon unbinding

sounds reasonable and clean as long as reset is done post disabling
sriov, which is the 1st action in vfio_pci_core_unregister_device(). Then
it's just a normal reset w/o concerning any active VFs.
