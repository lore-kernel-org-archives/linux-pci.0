Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85683387348;
	Mon, 24 Aug 2026 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603055; cv=fail; b=f/6Xby61LwH9QFMf+hx2k7s6cKQtBNzPNBOMc38LJx1FhXoFu9cH45wfYHiF/sgPVGhg2sZRaRl5eYazFT5t7s3DqMcheQKpDCKbNxNRcwnJJq9x939Yg5I2nDfB8sTFsF/N0Y8BFM1ko8ZgRuDFaWuMat591rp+ipiyZgXKsuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603055; c=relaxed/simple;
	bh=IGcuc4q8vrYfSaOYvdGaPLuTFdgJXQJ8UgrHb0Fjwy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BtyJw7mzoyo43EaanW2qCynuVCNEL8RHXyBxGOiKvfnRyd2eE99uExpeDwlsQPxnUWSCas1MZY9fPaHqvHlsTZuI/bGR3Am399lpSez3lAy+BxwM+YuG3JambG6OK7B8yr/px7J0JlrvTSXFvbM2EPcCJsNOvy2q8t5NLxoUgaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjY6Qm2A; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjY6Qm2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787603054; x=1819139054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=IGcuc4q8vrYfSaOYvdGaPLuTFdgJXQJ8UgrHb0Fjwy0=;
  b=HjY6Qm2Adgdt3dzeyxS4leH/RGf4Nc1l+i1Q9AlUgSWkUc0YJXcZzOpd
   qTkjxbCTxSuYo8R3RbAMHypzyZCc+1YQBEmR2fiOFLHA97RgehvzAqgKe
   CCtgNA2J5JRK608Aom0WAsbKyCLQvWBONTTynHxW5GEOtry7c2LZ7VVze
   HPklvjCK1Gqj2ZPIIyIzsXIzXYzDc139+Ja6yAbVNQqBiATXCsKcuk6vC
   5szHT36VeF9waibQGS9w0G5QO9ulJPMyopuxCNCs0o6VyHgc4ajx/vnCB
   A0XW1aV6mJPyaJKHb38H+6rZs6q30C0Cv5GRvkWrjcUcrwL9Wj0C+RM4x
   Q==;
X-CSE-ConnectionGUID: 6jcxG8PMS4SMlXgPe669uA==
X-CSE-MsgGUID: kGwhrXkbTjun22PGwQSWUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99412362"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="xml'?rels'?docx'72,48?scan'72,48,208,217,72,48";a="99412362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 13:24:13 -0700
X-CSE-ConnectionGUID: MrZhl5uET2WBvQY6tUFl1A==
X-CSE-MsgGUID: B+3RV9+FQue/NHuLwL5ONQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="xml'?rels'?docx'72,48?scan'72,48,208,217,72,48";a="267144072"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 13:24:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 13:24:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 13:24:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 13:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1axdKsKW4lc6ykyRBINP3bn5eACqAsGh4sBFScxRji7CB+uBEKtc8GtxqrBgwtwmpsQXwNROT0axDBgJSm7nFLF2Kt8zMuGl2Sz/ilPjiQawrI1OvotkDrVttr/bce7nRmcoW2Og3rjHwn6HmDNsjVy5rEm0FIHGoN7+n6PuSWKBN2yFKy8905AorQNHGuhoEp0bi1ymgf6PCZ0o8ECqljzWn3/RoHM9mZy1tQNxsu+MustwdSnFL8AJp/AdaYDvjVO/Vvc0dHAz9K+2+sedIYZAgZp89AKKHMREOFPDcpy7ZoHpekLIQ5K/HkjM2PXJxmj6QP/iPd7DJCy4ItAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDhEONP8tUzoZG8bqP4kILADpgwUHT4dPh/wW29Hcws=;
 b=Cxw3qH36yFHEgupITtbannSI++3bh0Kmbb4l0zDEu2mf9elsE/4uMu2yA1A3aWBOnqdW5nMaMW0B43EtIFYR4IFt/Y18uNO71s0yi57vb31ExA+n815NcWls1YEVb2/R0HvSGokIrFZo/GOsKYPCdgBHntiSpW3zweEisj3mzFLYZsJghENIpr4jKRZmtGAgPULzikk2dQzovNFOC+SD2RafkleJfzbcQHtw3EoADHJtm/OAALLdEQtwp53+RApGjPQCIP7Gv0d6Qe7Un5dkS9aXG/SmQTU2JlEl18cxoGne7T2A6XjqtwTHZQyP30ccX7lV6ZpHNXbt7GREC0t9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB9474.namprd11.prod.outlook.com (2603:10b6:8:265::13)
 by DS6PR11MB816619.namprd11.prod.outlook.com (2603:10b6:8:528::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 20:24:09 +0000
Received: from DS7PR11MB9474.namprd11.prod.outlook.com
 ([fe80::2b8f:e81a:868c:c65e]) by DS7PR11MB9474.namprd11.prod.outlook.com
 ([fe80::2b8f:e81a:868c:c65e%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 20:24:09 +0000
From: "Natu, Mahesh" <mahesh.natu@intel.com>
To: "Schofield, Alison" <alison.schofield@intel.com>, Leon Romanovsky
	<leon@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability and
 performance
Thread-Topic: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability and
 performance
Thread-Index: AQHdKpOI24fklf36HEKSTG791hgJibattXwAgAACTto=
Date: Mon, 24 Aug 2026 20:24:09 +0000
Message-ID: <DS7PR11MB9474DB02653FC660A0E6201EF5A02@DS7PR11MB9474.namprd11.prod.outlook.com>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <aoymZhOaSCG_Tsmj@aschofie-mobl2.lan>
In-Reply-To: <aoymZhOaSCG_Tsmj@aschofie-mobl2.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB9474:EE_|DS6PR11MB816619:EE_
x-ms-office365-filtering-correlation-id: b61c5d59-8171-45f2-c50e-08df021da78c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|6049299003|376014|7416014|10067099003|56012099006|6133799003|22082099003|18002099003|8096899003|11063799006|4143699003|13003099007|38070700021|4013099003|4053099003;
x-microsoft-antispam-message-info: h6ySQ644TrvRdboOn+TWRbQ3y5yuZCMi+wEwJWw6aRcQtWgx4UtU6luSvbNsnrOpPvDAPo5JXtXa3BHHRZRDKN6haFbxMhtiqu8BRs1LGC9IZRae2wP0yNiW/C+L/Dx5K6PvJlw3TXs1orQJ+1Z2rWOaNncq+mbcrFM8EB8xoclnUspjQOsB1HmnRrtgRiyHUrB80A8ZQdGTu7u0gfzKOmoUFgmufDa1HhiQ5qJ5Y+NSzswul7Arf/vCJSrsCip0NJcCe6wo5uhO0VXUfSZRsfvoK5BvNJpFMCn0GDEOvQWpOktkN2N8pM3ShPneAFTeXiPjuxPKLCLEAJ9tj7ka9YGFqoBOMLibERXIinzF/f68RGyYKwxESfKcdAN/lbKFSxO9bc49re9mvGKtH341/XV36bmwEJE62DmP4ngolTpUw4YZj9HrO1e1e0A9wOLA5fuAXzc4/t7TNUjTva41HmakmQSDGr5KYXeTqhhtEHIHKSY/YKx8JZ2liu5+pK+ilcoWUP5/gfddo+RP0fWg+O/+RXF6WDDtI22ZybuRpdlC9ddemNdcBSmU7poZT6eUTU8/twXpvj32zSIWM7v0HiyjQphwQuWo6ITgSXiJAj3VaduH/3ow47UfYmeG9hbUDN/Ozw7tqY3IxPefMa8JOPoYJuxs/7saj6dvc2d5HlQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB9474.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(6049299003)(376014)(7416014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(8096899003)(11063799006)(4143699003)(13003099007)(38070700021)(4013099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tNd5ceYlfVawWYlgEHZ2RpeN8bSXe3/6g3DCSH4eQLULSiNFkFOpVbw7ToLg?=
 =?us-ascii?Q?c69b4JhauqQ0phbvOA4E2WXiuNMn6llbHbL7+NIMSzhwnc5Ub3DPOoDrHnOT?=
 =?us-ascii?Q?kko1m274wi8suoffER+3SunWDu56WIMMIg2bAEi1ECRxyrQpvRThWr3dzVR0?=
 =?us-ascii?Q?3hnVXEZR0wb6A23PKzVvGKgu+MdiChoY/G+wvSnDP3J5nz/EYeC5nnImAaON?=
 =?us-ascii?Q?+oPCXmC+QdmW88W8pOAzoZR//fLZvBmY/4ikk5ocjOElw+xrfxEHR3fhq8Im?=
 =?us-ascii?Q?xaqJamAl/6rwa7ItVNZ1YU1kn92s24aMUoZjILmDvegg5UfwHl3FPEVLkq40?=
 =?us-ascii?Q?2smQ74txCbr7ucG2tBbnNoWbigi3Rv3U0miEVWe545G5xI1cR/9+lVOewlQD?=
 =?us-ascii?Q?JaV2Do5y8q9hzqkhBPEGyh8Iw0/nJXK1AAQmSSrG5o3rFmXRTV2nse6CvBzL?=
 =?us-ascii?Q?o2MkpZf0e81ef2tulKKF9f4XSHHji2gomifTixm1wPyS7LbXVeMZDyk52Dlo?=
 =?us-ascii?Q?Bwg5/aQxPlIzsW1uez6E9gB+VwbpzfDtGDLLPjoQJwRohmI3ELBenwolx/Wc?=
 =?us-ascii?Q?IF8yD0/sMUwMWrDidH5uSETogsV2Zal0RetMk7AwQTkS/5xg/RxcoERin4zT?=
 =?us-ascii?Q?DDiUKN7tWiOoAk8bizi1IbRFOr8xh3+3t6Zhl/v4f3OfKDNTfWzCqYz/U3HF?=
 =?us-ascii?Q?wGFyTXvb8ehv9O+N9Lgm7LcIEgEJ9iYyWOd+G5dnJp3EEC/YifQLFDjto75m?=
 =?us-ascii?Q?7DwzJ7h8qpqo9Z1JqbHpc2aB8N40ymPfBq1Pgy/mcIY4OfmXL+5p8PK6BYco?=
 =?us-ascii?Q?2OJn0eSt+9GGwNmW1zCnc3Opxq/DLgggTZ8JFLnOGrdjcAA9zawaD8eRj880?=
 =?us-ascii?Q?w09Cqej3elmzOkJXYXEH0iCKVWdbku6svgAeNDw0NXBdszZWxKq+IS9CJcEI?=
 =?us-ascii?Q?uswYwiuxeYZ5aCagCNKFMYC0ECDc7JJeBmxaPJKmLZCZ/c9U4Sq25jy2RW8m?=
 =?us-ascii?Q?lJHC+FRYxW6wnYn+YxYjWMuLzGx01NtTfiiFPQTFZsravi4EuGgwFcymPC4O?=
 =?us-ascii?Q?8Shz/cKjBz8C9hwWsy2r1MZbimGaaepbQEQwiTJreV15pxYB005MXrtjgOMZ?=
 =?us-ascii?Q?to9YTve+cywyGBxB7HEqfsQSgLBc9zKYiog/CeLtNTkUhbsOx1kmA81zXdf5?=
 =?us-ascii?Q?/PmN9oBFQqdQvPGVJoSNJo7DKjuPImAZxgKo+KTrcp0xqMh+NfHBsohwE3Yb?=
 =?us-ascii?Q?BaNibAGnjUCUydfWamhu5vq7HAq/PP5UOTji1K6ey53IQ7aFnt3EgEdSFUTK?=
 =?us-ascii?Q?wrkEUjFrpqqGJoC7V0uqN1MWybSyKrVcKbqDRperlEErEVP3opNLieoLxWEB?=
 =?us-ascii?Q?v269J8NQIpwdPcI0kLe+a5yyKpean/sc83Xq6ynJxvlf36qtbu0Ky5oaXMue?=
 =?us-ascii?Q?NIcAr17+bNhprvwWuxA7h/ELPtxe4DhjQNXRKwPwE6LU6gYRrVZwQ3djw2O/?=
 =?us-ascii?Q?3WO/24qu9Z+ASBsVOphQD/DpO9cgY5FifJ4vUJ/1o0hNP965BmO2860B3do3?=
 =?us-ascii?Q?yEfOTFe9wecaE3p3GJuYzc4ndulWpriD6ZTbNDZxlhUnxn1wqv71QWMos8gN?=
 =?us-ascii?Q?RMzuzvjM5lMzKaGdWjEbvuvSFF2Vm2tlDdw1YqXSkUDqRmxD7S9LUcGVdvNR?=
 =?us-ascii?Q?PIHfkoVO476U1S+YzmOBE56q/C1zd4Oyj3OtfnwovXNTs17q1dbUkOhg4SGb?=
 =?us-ascii?Q?biJmKo3x5g=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RZS/T1ErBTRHVhfV56O/IXpR6tQM5GV1r5L5lKPyfIpGkiAjUx9w49y13ppeyOrNJO+ABIe1VnTX4bdmnYln1tZ36PgSM7CAqugsKSlQQZfcKRvSb6re75olSwYfowQfYH1TQqgpcVc8LHC5PDXyRoaQW7jwciBM6Q/LFI4udOV5IrtfFOh3PMiGP3s+FjfzjC7SqbOXPDuA8gj/cPtZyoUTS5g3rsn1lJ1jDjLm4x8+eRwRJxNjgobJhUlKBxjhsg7zcB1XknADJbbAoQOJCLY5YZ1Rq+Q4lxLsLbb2/tR4wCZ87OjK3f3PBCWLi4Fu+QJmWX69kdB2u2Ed+bN7Zg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9474.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61c5d59-8171-45f2-c50e-08df021da78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 20:24:09.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTTnefA/A2ZMrK+SDn4R2OHDtIFHoiMOx/73u5KBIW2nxdcFAFySudfT97woMlUQ28Fk+utIsoE2rF+xFFDMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB816619
X-OriginatorOrg: intel.com

--_004_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_
Content-Type: multipart/alternative;
	boundary="_000_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_"

--_000_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

attached


Thank you,

Mahesh



________________________________
From: Schofield, Alison <alison.schofield@intel.com>
Sent: Monday, August 24, 2026 1:15 PM
To: Leon Romanovsky <leon@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Sak=
et Dumbre <saket.dumbre@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; Lo=
gan Gunthorpe <logang@deltatee.com>; linux-acpi@vger.kernel.org <linux-acpi=
@vger.kernel.org>; acpica-devel@lists.linux.dev <acpica-devel@lists.linux.d=
ev>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci=
@vger.kernel.org <linux-pci@vger.kernel.org>; Lukas Wunner <lukas@wunner.de=
>; Natu, Mahesh <mahesh.natu@intel.com>
Subject: Re: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability and per=
formance

On Wed, Aug 12, 2026 at 10:47:37PM +0300, Leon Romanovsky wrote:
> Linux derives P2PDMA reachability from visible PCI topology, ACS
> configuration, and a host-bridge whitelist. It cannot describe conditiona=
l
> or slower cross-host-bridge paths; passthrough can hide the physical peer
> relationships.
>
> This RFC series implements the proposed ACPI HMAT Type 3 extension below.

Hi Leon,

Is there an ECN document for review alongside this?
I get that the table below is a snapshot of the expected change, but
would appreciate the long version to read.

Please add linux-cxl to CC list on future postings.

-- Alison


> Directional Generic Port matrices describe reachability, ordering, latenc=
y,
> and bandwidth. Linux uses ordered paths to authorize P2PDMA and their
> latency/bandwidth to rank providers. A VMM could translate these matrices
> into guest domains; that is outside this series.
>
>   HMAT Type 3 structure
>
>   Field               Offset       Bytes  Meaning
>   ---------------------------------------------------------------
>   Type:                    0           2  value 3
>   Length:                  4           4  entire structure
>   Flags:                   8           1  traffic classes
>   Data-type:               9           1  metric selector
>   Initiators:             12           4  Generic Port count (s)
>   Targets:                16           4  Generic Port count (t)
>   Base-unit:              24           8  ps or MB/s; non-zero
>   Initiator-PDs:          32         4*s  proximity-domain list
>   Target-PDs:         32+4*s         4*t  proximity-domain list
>   Matrix:         32+4*(s+t)       2*s*t  directional Entry[i][j]
>   Reserved: bytes 2-3, 10-11, and 20-23
>
>   Flags: encoding
>     bit 0  non-UIO
>     bit 1  UIO
>
>   Metrics: selector
>     0/1/2  access/read/write latency
>     3/4/5  access/read/write bandwidth
>
>   Direction: Initiator PD[i] -- Entry[i][j] metric --> Target PD[j]
>
> ----------------------------------------------------------------------
> Based on [PATCH v3 00/17] PCI/P2PDMA: Fix ACS egress control handling
> https://lore.kernel.org/all/20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia=
.com/
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Leon Romanovsky (7):
>       ACPICA: Define PCIe P2P latency and bandwidth information
>       ACPI: HMAT: Make PCIe P2P paths available to consumers
>       PCI/P2PDMA: Authorize HMAT-described cross-host-bridge P2P
>       PCI/P2PDMA: Prefer providers with better HMAT performance
>       ACPI: HMAT: Add KUnit tests for PCIe P2P matrix semantics
>       PCI/P2PDMA: Add KUnit tests for HMAT policy boundaries
>       PCI/P2PDMA: Add KUnit tests for HMAT provider ranking
>
>  drivers/acpi/numa/Kconfig     |  13 ++
>  drivers/acpi/numa/Makefile    |   1 +
>  drivers/acpi/numa/hmat.c      | 245 +++++++++++++++++++++-
>  drivers/acpi/numa/hmat_test.c | 223 ++++++++++++++++++++
>  drivers/acpi/numa/hmat_test.h |  17 ++
>  drivers/pci/Kconfig           |  14 ++
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/p2pdma.c          | 300 ++++++++++++++++++++------
>  drivers/pci/p2pdma_test.c     | 477 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/pci/pci.h             |  23 ++
>  include/acpi/actbl1.h         |  27 ++-
>  include/linux/acpi.h          |  26 +++
>  12 files changed, 1298 insertions(+), 69 deletions(-)
> ---
> base-commit: bc5261fca94dd94ab557cc0852ce465d9c3ab8b0
> change-id: 20260715-hmat-p2p-eb4971a9d731
>
> Best regards,
> --
> Leon Romanovsky <leonro@nvidia.com>
>

--_000_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
attached</div>
<div id=3D"Signature" class=3D"elementToProof">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin: 0in; font-family: Aptos, sans-serif; font-size: 12pt;">=
<span style=3D"font-family: Arial, sans-serif;">Thank you,</span></p>
<p style=3D"margin: 0in; font-family: Aptos, sans-serif; font-size: 12pt;">=
<span style=3D"font-family: &quot;Bradley Hand ITC&quot;;">Mahesh</span></p=
>
<p style=3D"margin: 0in; font-family: Aptos, sans-serif; font-size: 12pt;">=
<span style=3D"font-family: &quot;Bradley Hand ITC&quot;;">&nbsp;</span></p=
>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Schofield, Alison &lt=
;alison.schofield@intel.com&gt;<br>
<b>Sent:</b> Monday, August 24, 2026 1:15 PM<br>
<b>To:</b> Leon Romanovsky &lt;leon@kernel.org&gt;<br>
<b>Cc:</b> Rafael J. Wysocki &lt;rafael@kernel.org&gt;; Len Brown &lt;lenb@=
kernel.org&gt;; Saket Dumbre &lt;saket.dumbre@intel.com&gt;; Bjorn Helgaas =
&lt;bhelgaas@google.com&gt;; Logan Gunthorpe &lt;logang@deltatee.com&gt;; l=
inux-acpi@vger.kernel.org &lt;linux-acpi@vger.kernel.org&gt;; acpica-devel@=
lists.linux.dev
 &lt;acpica-devel@lists.linux.dev&gt;; linux-kernel@vger.kernel.org &lt;lin=
ux-kernel@vger.kernel.org&gt;; linux-pci@vger.kernel.org &lt;linux-pci@vger=
.kernel.org&gt;; Lukas Wunner &lt;lukas@wunner.de&gt;; Natu, Mahesh &lt;mah=
esh.natu@intel.com&gt;<br>
<b>Subject:</b> Re: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability =
and performance</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Aug 12, 2026 at 10:47:37PM +0300, Leon Rom=
anovsky wrote:<br>
&gt; Linux derives P2PDMA reachability from visible PCI topology, ACS<br>
&gt; configuration, and a host-bridge whitelist. It cannot describe conditi=
onal<br>
&gt; or slower cross-host-bridge paths; passthrough can hide the physical p=
eer<br>
&gt; relationships.<br>
&gt; <br>
&gt; This RFC series implements the proposed ACPI HMAT Type 3 extension bel=
ow.<br>
<br>
Hi Leon,<br>
<br>
Is there an ECN document for review alongside this?<br>
I get that the table below is a snapshot of the expected change, but<br>
would appreciate the long version to read.<br>
<br>
Please add linux-cxl to CC list on future postings.<br>
<br>
-- Alison<br>
<br>
<br>
&gt; Directional Generic Port matrices describe reachability, ordering, lat=
ency,<br>
&gt; and bandwidth. Linux uses ordered paths to authorize P2PDMA and their<=
br>
&gt; latency/bandwidth to rank providers. A VMM could translate these matri=
ces<br>
&gt; into guest domains; that is outside this series.<br>
&gt; <br>
&gt;&nbsp;&nbsp; HMAT Type 3 structure<br>
&gt; <br>
&gt;&nbsp;&nbsp; Field&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Bytes&nbsp; Meaning<br>
&gt;&nbsp;&nbsp; ----------------------------------------------------------=
-----<br>
&gt;&nbsp;&nbsp; Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; value 3<br>
&gt;&nbsp;&nbsp; Length:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp; entire structure<br>
&gt;&nbsp;&nbsp; Flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; traffic classes<br>
&gt;&nbsp;&nbsp; Data-type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; metric selector<br>
&gt;&nbsp;&nbsp; Initiators:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 4&nbsp; Generic Port count (s)<br>
&gt;&nbsp;&nbsp; Targets:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp; Generic Port count (t)<br>
&gt;&nbsp;&nbsp; Base-unit:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 8&nbsp; ps or MB/s; non-zero<br>
&gt;&nbsp;&nbsp; Initiator-PDs:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4*s&nbsp; pro=
ximity-domain list<br>
&gt;&nbsp;&nbsp; Target-PDs:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 32+4*s&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4*t&nbsp; proximit=
y-domain list<br>
&gt;&nbsp;&nbsp; Matrix:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32=
+4*(s+t)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2*s*t&nbsp; directional Entry[=
i][j]<br>
&gt;&nbsp;&nbsp; Reserved: bytes 2-3, 10-11, and 20-23<br>
&gt; <br>
&gt;&nbsp;&nbsp; Flags: encoding<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; bit 0&nbsp; non-UIO<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; bit 1&nbsp; UIO<br>
&gt; <br>
&gt;&nbsp;&nbsp; Metrics: selector<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 0/1/2&nbsp; access/read/write latency<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 3/4/5&nbsp; access/read/write bandwidth<br>
&gt; <br>
&gt;&nbsp;&nbsp; Direction: Initiator PD[i] -- Entry[i][j] metric --&gt; Ta=
rget PD[j]<br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; Based on [PATCH v3 00/17] PCI/P2PDMA: Fix ACS egress control handling<=
br>
&gt; <a href=3D"https://lore.kernel.org/all/20260811-fix-p2p-acs-v3-0-efc48=
8ee7c03@nvidia.com/">
https://lore.kernel.org/all/20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.c=
om/</a><br>
&gt; <br>
&gt; Signed-off-by: Leon Romanovsky &lt;leonro@nvidia.com&gt;<br>
&gt; ---<br>
&gt; Leon Romanovsky (7):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPICA: Define PCIe P2P latency an=
d bandwidth information<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI: HMAT: Make PCIe P2P paths av=
ailable to consumers<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI/P2PDMA: Authorize HMAT-describ=
ed cross-host-bridge P2P<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI/P2PDMA: Prefer providers with =
better HMAT performance<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI: HMAT: Add KUnit tests for PC=
Ie P2P matrix semantics<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI/P2PDMA: Add KUnit tests for HM=
AT policy boundaries<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI/P2PDMA: Add KUnit tests for HM=
AT provider ranking<br>
&gt; <br>
&gt;&nbsp; drivers/acpi/numa/Kconfig&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 13 ++<=
br>
&gt;&nbsp; drivers/acpi/numa/Makefile&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<b=
r>
&gt;&nbsp; drivers/acpi/numa/hmat.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 245 +++=
++++++++++++++++++-<br>
&gt;&nbsp; drivers/acpi/numa/hmat_test.c | 223 ++++++++++++++++++++<br>
&gt;&nbsp; drivers/acpi/numa/hmat_test.h |&nbsp; 17 ++<br>
&gt;&nbsp; drivers/pci/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 14 ++<br>
&gt;&nbsp; drivers/pci/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; drivers/pci/p2pdma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 300 ++++++++++++++++++++------<br>
&gt;&nbsp; drivers/pci/p2pdma_test.c&nbsp;&nbsp;&nbsp;&nbsp; | 477 ++++++++=
++++++++++++++++++++++++++++++++++<br>
&gt;&nbsp; drivers/pci/pci.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 ++<br>
&gt;&nbsp; include/acpi/actbl1.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 27 ++-<br>
&gt;&nbsp; include/linux/acpi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 26 +++<br>
&gt;&nbsp; 12 files changed, 1298 insertions(+), 69 deletions(-)<br>
&gt; ---<br>
&gt; base-commit: bc5261fca94dd94ab557cc0852ce465d9c3ab8b0<br>
&gt; change-id: 20260715-hmat-p2p-eb4971a9d731<br>
&gt; <br>
&gt; Best regards,<br>
&gt; --&nbsp; <br>
&gt; Leon Romanovsky &lt;leonro@nvidia.com&gt;<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_--

--_004_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_
Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document;
	name="HMAT Extensions for PCIe P2P - external.docx"
Content-Description: HMAT Extensions for PCIe P2P - external.docx
Content-Disposition: attachment;
	filename="HMAT Extensions for PCIe P2P - external.docx"; size=23351;
	creation-date="Wed, 19 Aug 2026 17:21:56 GMT";
	modification-date="Mon, 24 Aug 2026 20:23:59 GMT"
Content-Transfer-Encoding: base64

UEsDBBQABgAIAAAAIQCnF/KVhAEAABcGAAATAAgCW0NvbnRlbnRfVHlwZXNdLnhtbCCiBAIooAAC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC0
lNtKw0AQhu8F3yHsrTRbvRCRpr3wAIInsD7AdHfSBvfE7tS2b++khyDSNqLtTWAz8///N5swvcHc
muwTY6q8K8R53hUZOuV15caFeB/ed65ElgicBuMdFmKBSQz6pye94SJgyljtUiEmROFayqQmaCHl
PqDjSumjBeJjHMsA6gPGKC+63UupvCN01KHaQ/R7t1jC1FB2N+fXK5KIJonsZtVYZxUCQjCVAuK6
/HT6R0pnnZCzctmTJlVIZ9wg5NaEurI7YK174auJlcbsFSI9g+UuOfNRS+3V1LIy32+zhdOXZaWw
0dduIXqFKfGdW5M3FQuV2/Dv5HBTO8LIysODNNatEIkWBtPhCVa+7fFIxIJjAKydWxFmOHo7GsU3
81aQknOHMDJ4eIzGuhWCeA3g6nn+b46lzb5I7nyNPiReK/EPY2/2Rq3u8MABI1X7/7omka3/PR/W
K0mj/n32ExJoIJCPMELz4Er/Cwi7Cc6VAf6k5bpoao8mUS7Xev8LAAD//wMAUEsDBBQABgAIAAAA
IQD7mWVHHwEAAOACAAALAAgCX3JlbHMvLnJlbHMgogQCKKAAAgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAArJLBSgMxEIbvgu8Qcu/OdhUR6bYX
ERYUROoDjMnsNrjJhCRq+/am0qIr7dJDj/nnn3++GTJbrG0vPilEw66W06KUgpxibVxXy9flw+RW
ipjQaezZUS03FOVifnkxe6EeU26KK+OjyCku1nKVkr8DiGpFFmPBnlyutBwspvwMHXhU79gRVGV5
A+FvhpwPMkWjaxkafSXFcuPplGxuW6PontWHJZcOjABaJ3Ka9MSH3B+SyduIJYaOUi01q+csR0Dv
ixwt4TBRdTrR8W3BUkKNCUFxoHGerWMMaHrOEw0dvzRfHDTonTxGc32ExhoVOHKbCsV2NyYDVCWU
1T8G1WOMJht+tB7fqB/e5Wl/vMdtrXEt74lg8C/n3wAAAP//AwBQSwMEFAAGAAgAAAAhAMVws2j0
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

--_004_DS7PR11MB9474DB02653FC660A0E6201EF5A02DS7PR11MB9474namp_--
