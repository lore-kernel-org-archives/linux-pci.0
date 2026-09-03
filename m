Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D75426EB7;
	Thu,  3 Sep 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430575; cv=fail; b=Cm14ltVWRd82NGa+85dZwiLf6kKTP4HlDc3eApQvyA9g4PRb+eRk4cme7as8Z7hNA875OilXJFtIqidOYdr54Hesmj4Oq8akPdWW8aLheoyYSDwQIEFUDJLp3DSCrb8SGyz28+I5cAyYsyYaTRat7kmNMRGW5B9WERXuPNrT26c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430575; c=relaxed/simple;
	bh=6t7fhCUgcWxoorOMOj6XpNAatmZl/IjiOyOPRPb7a84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTk5cfO+NN3++p7M9IthtnZX5M0Kc2DnvAlpKlqeaDYHlkEVO92AepMZLUoTGPzBR2Nw605AOUPqMn5kB5f9JaYQWflr71tVjYCSyyZWXtIu4mS+FjUtsoCrWjUAU6GLmW6DMjzpXougFfqQm3DtzI4eQ6zsydJ7Cxe+V4bNjpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATAWDJ+R; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATAWDJ+R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaaQyWVKGq/rPzy3iIZMMAFDYTdsQosx/NgQz2+XI2ie6J9ZlGGy7K/JgJjODzZTRpQyFC8qwsuXPKo9tuo4pkben0uxwcqygTToGRCAbvH3st/tAThsjsZKKx+amZ2zOC2D+B3xNopNWCyzedPigkyGlVfKpfzxFiGWmP6qpTbdcldA70ReeVZMg7unq0X0CJXzMZ324c5FSBMqKmv2KAl87uqFTZdM6D2xfe/duEUB3kaaghYzn5eiz7U859CXVKbrOal9I3E2jAQ1X3uwtzSpOJ4gksNzRrKMiGtP9AR9ULFDFr1UowuRy2JdpyHXEo6oB2lxAZYc22hPWvJqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ9JnjDF8UkxB1CTuBVTq2+skSDoo6LxJ/PMRrmCwUk=;
 b=idnlYOdX9VX+5xb3zCqI+fKP8vQ40vBGF4VzoOW6e5sMUREewbPxfebSCwKegzPoAY/DA/DjN1ijgI1BfSIDClqsRfLFNvUETeZP5fIFb6swihV38JLyJtnjSIp5uUOd7v1gJ72JSO/pLa9WTVyC7+nzegf2TvxzKBTZJmUfNLOuy+EZfRa/Wa9xsSgbKnkZBXp38GksQ8v6oAXYgt/sC5inoyLDeUXjMnnfgjgme/fmSmyXhX1OGGJv8TQPPGQ4C2nDrtztTGWhsrUfz/THHXfK98l+MDKjkEYayM5zx+jvEurg7qAgR+Hz/5tdiSVb8I/+tnnDJ7LS3T81RsstFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ9JnjDF8UkxB1CTuBVTq2+skSDoo6LxJ/PMRrmCwUk=;
 b=ATAWDJ+R/q7VzEebuHnJ9WyWsQ7uQDoD5diKzvTsGXXmJBxRj45PprSczFoWJAZIsFv5EkWkbW7A+KldUiBian0sIH1TzcJEmueW1HQdc7Fkuca9p9uUcDZcKbKU/lyU3uAf85K8FMygwFKavSCvDCzrmfpoA76Zl3MqvOWfH70hqc/lQ6gk5OzrxlAQa/Xzv+PDNpxfwQLjEbwLK+7pLw6c1w0wnGSZoe2nF4C4RNSmqkTufxQUwgDFQEGmYwkrFA2PTfkLWymZg4/7X6Jan3cxkhTjCarZPBVX9m0kbyhgmnFh6lCTw7fI7T8f1fE90Eq7lS0GHB1tdtobeYBjtg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:15:48 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:15:48 +0000
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
Subject: RE: [PATCH v4 24/27] vfio/cxl: Service a guest-triggered CXL reset
Thread-Topic: [PATCH v4 24/27] vfio/cxl: Service a guest-triggered CXL reset
Thread-Index: AQHdKwf0/VQ16MkpBUOPCmwBTLa1Kra0Ln8AgAiEnXA=
Date: Thu, 3 Sep 2026 10:15:48 +0000
Message-ID:
 <IA1PR12MB90302D588578A23228FD6169BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-25-mhonap@nvidia.com>
 <20260828170930.3bf438eb@shazbot.org>
In-Reply-To: <20260828170930.3bf438eb@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 3130e72e-64c0-4adc-6587-08df09a4534e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 eubHMNCW9OvjLpt2bBX9cYt/w6VBgEtHjxoCgLM44pb6Ba/s+CcHpDhjmQirSgh4mWQ64Ku6/+rK/WnQ08YTpP9LvaHzPNuQhKM+boBk69I7bznFTY6f3Hh8xGjWhSdYxWl5L5hoOdTtzgL28nsoJJs/YuikcsRvuPvwMS3wh6C9JNfsVL1ken/ikExxqjZJ8DLgftNmYXWWxgwIqN6PSqbyAQNDtpkMXd6teCL6zw/dXLBkGZ0Sd/0U5aeeD/E5kK1ozKzRmHE4gstwhFAHXbLM3fWwBXRZgW4tlUeqWioBkdCLNyptnChwqrLoFVatCJLZSk3VhJKmOURtiKohluNAPYWnAhwyhz6yKeGfxEshoqukgV8h7Ka90KZoH/fZDLfks+wW+lf6lLkb3DWxL6l8HAjFVGYVBZzBjNr2cMezY2UPrlZcUwSsqFpGFS1oX2yCcovQOJh4g2PZgY9ZAW5nJYJKjGdrgcavgSXH6fKfEEOVaYFCCHuiBpqFOodr835oepgn5Ma6J1honnu2BkNN87NC4aX15TYg+rBkmOjLLjutkzvU7J49iQs6learCTSwfpnW1PCRfrjEzWaSEPmGpuAnz34ZUuWIlwCnLwqpXiLjtDaprPSP2ypySLxSM0i+EiEQNqC0VfzZ05SUIsn5sxkjrymttjbRtaaU8LyGiSoSAXmRHI9qs5ZMVX+4JGy+vuiie0E5gm/7Rciy6S7UkAXCNvja0T0LkT4lWD0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pY3B1z2uK2HX3yatL05dzqA/g9oyt+dj/lSSJFsh2nyMpAatcBG/TYQWofio?=
 =?us-ascii?Q?I6czy8lV2aIkPmfBVjudq0cyaOA7qj0eeNsSNN+TC/5fyadQpV5t94yDlepR?=
 =?us-ascii?Q?g+N7gEQE6KsMHADUn0oY0UhBee24izfBttxCH6i9jwQv5u8bvulKo1d16uvl?=
 =?us-ascii?Q?0EFCBIfq/Pd1AzaCtReUGwlrrgHoOsT4SZ6aFPYYsKeGimt27cK376Q60c0p?=
 =?us-ascii?Q?fCgCza7Fg7ZIxEvy5hjAVCDubmbfsr7wKOMvTOX+qoO7UUka7XTVYtsBARis?=
 =?us-ascii?Q?tBbflECHxX5x5dhqX57iu1ejHtOAHUzW6Hb/FAbkz6DPfkDEWihq3wx9DYyo?=
 =?us-ascii?Q?oIkAN1ZcRx318GrMDX9w3T/IfsdC9xMhha9EaSjnLJYWMPos9MWn/RciyMoD?=
 =?us-ascii?Q?UIFC4sSPZyoZ/J6PicySzSSnZBS84ECkowj+ScEVNDdhTEvgfgghTfZBO0Yq?=
 =?us-ascii?Q?ywMajmbk0mRjpOSffxIkY3913tc9jzDAX62qKiKTGlZy+Ly00mjucasw/dxV?=
 =?us-ascii?Q?6yMwrvE6TULX3Ely7hNKNuVD58tzVuK3BXKqcub32u82P0rBtLzW4VLFGWQD?=
 =?us-ascii?Q?LM8Jf8n+eFMjjv2j8X/iuVcLf/1wVAPmuhxecRshdamuA7q9s7qzEGjoU1yD?=
 =?us-ascii?Q?iKFoRTiKt/EgKLDONu5JWJmFnPg5ILJ3W0vICTA6a5V5MVhlauJYFzovba8J?=
 =?us-ascii?Q?atiqwAEZhvClJ/5jQXfsJgm0YNexE/QhY2R+Lq1Ypyz6PwGnnpJCnJTkMVhG?=
 =?us-ascii?Q?2J21C8HHQzWyOuNOhWDHP+JJuoe4l82tsw5aIURvaV7HlpqyhBUxZPFQZTqQ?=
 =?us-ascii?Q?ZbN1vj5QIR4RAPWg7ahDmfPsNBn0ZRvyK6opHyFgHTIwpAph7l700pCqh4dC?=
 =?us-ascii?Q?4helWSy83SpOdVB/b2Aii7JGcFPg24Hkh1bDpx+zPMJb4I1yfO8VwmVZT8Sk?=
 =?us-ascii?Q?JGCethhqsgp1DX5Y/WWv5AGAielTRgb5wfM155673zIzGnSWOehlt/4wc7mu?=
 =?us-ascii?Q?GHD3r8A6fFHxOILoB7chzJ5F9YesPxSn0Qx47FtAIH6KO2/qkMlZWZdO8UXJ?=
 =?us-ascii?Q?jxWt8TUz1MolJxDekJqAcCdneHGPsiPnmPIqJNgTqe0OpJV8FdKEgHwilDPO?=
 =?us-ascii?Q?MwltOlOVSxwZZ9rLeCX9hUQrybu/V8PCfu7DpsKVCoNeGZfwoAAmNhgiYVCb?=
 =?us-ascii?Q?uPy9YxwJVe9oNSCCtlu23vRCiBIEMu7ZlBi33ceElAEp/OojCF4vfIgsW7UK?=
 =?us-ascii?Q?IHgucvCneIj5ESg6IaTymKb9yZ52vU6uMO/GVLKDtgmUmr9k4LDMldCimSc7?=
 =?us-ascii?Q?u6guy2KcEqnzStjwtcb0ATcLdWlDLaZLJZrHUhO7e4aZKXFp0GEjPKY8TJCm?=
 =?us-ascii?Q?jAemkaEBbJVejxGJm9UXloK3oA9izAsWy7/nsu2JeTBIsPScoMl14RJrxnx2?=
 =?us-ascii?Q?DCKtaEpG6Rady16SEAZ/PTD87EpFMNo+pPK7TJOArxisTAb9QRXEB4+FibOf?=
 =?us-ascii?Q?jtizZWzfwcuMJF9uCdD66kZGNGHz8QYMd6DICTWYp/msmeytRNCLAYo2IUa7?=
 =?us-ascii?Q?IajIDxpNQU5YADMNoRiY7n13FpKPlETWW+w/SlJ3K9cyJRjzF2VTdhPfZE3o?=
 =?us-ascii?Q?wbW4P8K2TFN17JG0oNNbgHU29E13Qi7Qrm/nbcjMMAxuK7DoBkLkpdOF9ctE?=
 =?us-ascii?Q?JdMS/NNtrrrbFz/OvM4aTS5HfRTlRSL8BXkh/bG95WdNz2Ff?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3130e72e-64c0-4adc-6587-08df09a4534e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:15:48.6681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xc+1gkDAjyTD4vipb9vPDtvRtP2HjSVvSbFwB394mX1PHi55WDRsD0gQO1nAa3OKlwLZeu+dXle/fJANSD37VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, August 29, 2026 4:40 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v4 24/27] vfio/cxl: Service a guest-triggered CXL res=
et
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:28 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > When the guest sets Initiate_CXL_Reset in the CXL DVSEC, run the reset
> > on its behalf. The bit is not forwarded to hardware; the CXL core
> > drives the state machine through cxl_reset_dvsec_sequence(). The
> > memory_lock, mapping revoke and dma-buf quiesce are core-internal, so
> > the core exposes a wrapper that runs them around the CXL-specific work.
> >
> > A CXL reset can clear config like an FLR, so the sequence is bracketed
> > by
> > pci_save_state() and pci_restore_state(), with Bus Master dropped for
> > the window and kept dropped if a step failed, so the function cannot
> > DMA over decoders that were not restored. The guest owns
> > Mem_Clr_Enable, read from the shadow, and the outcome is stamped into
> STATUS2 for it to poll.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 167 ++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_config.c   |   4 +-
> >  drivers/vfio/pci/vfio_pci_core.c     | 215 +++++++++++++++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h     |   2 +
> >  include/linux/vfio_pci_core.h        |   3 +
> >  5 files changed, 374 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index f45eaa60bad2..b3eaefa03479 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/cleanup.h>
> >  #include <linux/memory-failure.h>
> > +#include <linux/memregion.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > @@ -761,6 +762,16 @@ static u16 vfio_cxl_dvsec16(struct vfio_cxl_state
> *cxl, u32 off)
> >       return (dw >> (8 * (off % sizeof(u32)))) & 0xffff;  }
> >
> > +/* Write a 16-bit DVSEC field into the shadow; the field must not
> > +straddle a dword. */ static void vfio_cxl_dvsec_write16(struct
> > +vfio_cxl_state *cxl, u32 off, u16 val) {
> > +     u32 shift =3D 8 * (off % sizeof(u32));
> > +     u32 idx =3D off / sizeof(u32);
> > +
> > +     cxl->dvsec_shadow[idx] &=3D ~(0xffffU << shift);
> > +     cxl->dvsec_shadow[idx] |=3D (u32)val << shift; }
> > +
> >  /*
> >   * Apply the CXL r4.0 8.1.3 write class for the 16-bit DVSEC register =
at @off.
> >   * Control is programmable, Status is write-1-to-clear, and
> > Capability, Lock and @@ -815,12 +826,14 @@ static int
> vfio_cxl_config_write(struct vfio_pci_core_device *vdev, int pos,
> >       int boff =3D (pos - cxl->dvsec) % sizeof(u32);
> >       u32 off =3D idx * sizeof(u32);
> >       __le32 le_wval =3D 0, le_wmask =3D 0;
> > +     u16 before, after, lo, hi;
> >       u32 old, wval, wmask;
> > -     u16 lo, hi;
> >
> >       if (pos < cxl->dvsec || pos >=3D cxl->dvsec + cxl->dvsec_len)
> >               return -ENODEV;
> >
> > +     before =3D vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2);
> > +
> >       /*
> >        * Place the guest bytes and a matching byte mask at the write of=
fset,
> >        * then let the per-field class decide what actually lands in the=
 shadow.
> > @@ -836,9 +849,159 @@ static int vfio_cxl_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >       hi =3D vfio_cxl_dvsec_field(off + 2, old >> 16, wval >> 16, wmask=
 >> 16);
> >       cxl->dvsec_shadow[idx] =3D lo | ((u32)hi << 16);
> >
> > +     /*
> > +      * A 0->1 write of Initiate_CXL_Reset asks for a CXL reset. It is=
 not
> > +      * forwarded to hardware; cxl_reset_dvsec_sequence() drives the s=
tate
> > +      * machine, and the outcome comes back through STATUS2.
> > +      */
> > +     after =3D vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2);
> > +     if (!(before & PCI_DVSEC_CXL_INIT_CXL_RST) &&
> > +         (after & PCI_DVSEC_CXL_INIT_CXL_RST) &&
> > +         cxl_reset_capable(vdev->pdev))
> > +             vfio_pci_core_cxl_reset(vdev);
> > +
> >       return count;
> >  }
> >
> > +static int vfio_cxl_reset(struct vfio_pci_core_device *vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     struct pci_saved_state *saved_state;
> > +     bool mem_clr;
> > +     u16 ctrl2, status2, cmd;
> > +     int ret;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     /*
> > +      * The host cxl_reset PCI method cannot run for a vfio-owned devi=
ce: it
> > +      * requests the HDM range that this driver already holds exclusiv=
ely, so
> > +      * it always fails busy. Drive the DVSEC reset directly here. Rep=
ort
> > +      * not-capable so the core reset path can fall back to a standard=
 PCI
> > +      * reset for a device with no CXL reset, such as a multifunction =
device.
> > +      */
> > +     if (!cxl_reset_capable(pdev))
> > +             return -ENOTTY;
> > +
> > +     /*
> > +      * Mem_Clr_En comes from the guest shadow CTRL2 while the device =
is
> open.
> > +      * The core reset path also drives this reset at VM power on and =
off with
> > +      * no shadow present, so read it from the live DVSEC then.
> > +      */
> > +     if (cxl->dvsec_shadow)
> > +             ctrl2 =3D vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2);
> > +     else
> > +             pci_read_config_word(pdev, cxl->dvsec + PCI_DVSEC_CXL_CTR=
L2,
> > +                                  &ctrl2);
> > +     mem_clr =3D ctrl2 & PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> > +
> > +     /*
> > +      * Mem_Clr is guest-controlled (Mem_Clr_En in the DVSEC CTRL2), s=
o
> honor it
> > +      * and pass it to cxl_reset_dvsec_sequence(). It zeroes the devic=
e
> memory,
> > +      * but that sequence does not write back host CPU caches over the=
 HDM
> range
> > +      * the way the host cxl_reset method does. The range is mapped wr=
ite-
> back,
> > +      * so a dirty host line could survive the clear and overwrite it;=
 invalidate
> > +      * it first when the platform can.
> > +      *
> > +      * When cpu_cache_has_invalidate_memregion() is false proceed rat=
her
> > +      * than abort. Unlike native CXL region invalidation, which the h=
ost
> > +      * manages and must fail safe, the host CPU never writes passthro=
ugh
> > +      * HDM range: the guest owns it through its stage-2 mapping, so t=
here
> > +      * are no dirty host lines for the clear to lose.
> > +      * Warn once so the case is visible rather than silent.
> > +      */
> > +     if (mem_clr) {
> > +             if (cpu_cache_has_invalidate_memregion()) {
> > +                     ret =3D cpu_cache_invalidate_memregion(cxl->hpa_r=
ange.start,
> > +                                                          range_len(&c=
xl->hpa_range));
> > +                     if (ret) {
> > +                             pci_err(pdev, "vfio-cxl: reset: CPU cache=
 invalidate failed
> (%d), aborting reset\n",
> > +                                     ret);
> > +                             return ret;
> > +                     }
> > +             } else {
> > +                     pci_warn_once(pdev, "vfio-cxl: reset: no CPU cach=
e invalidation
> available; proceeding with Mem_Clr (host does not cache the HDM range)\n"=
);
> > +             }
> > +     }
> > +
> > +     /*
> > +      * A CXL reset can clear config like an FLR, so save state and dr=
op Bus
> > +      * Master for the reset window; the function masters the bus agai=
n only
> > +      * once the decoders are restored.
> > +      *
> > +      * Sample the guest's Bus Master intent from live config before t=
he reset
> > +      * perturbs it, so it can be reapplied after the decoder is known=
 good with
> > +      * no window in which pci_restore_state() leaves Bus Master enabl=
ed.
> > +      */
> > +     pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +
> > +     saved_state =3D pci_store_saved_state(pdev);
> > +     if (!saved_state && pdev->state_saved) {
> > +             pci_err(pdev, "vfio-cxl: reset: saved-state stash failed =
(-ENOMEM),
> aborting reset\n");
> > +             return -ENOMEM;
> > +     }
> > +     if (saved_state)
> > +             pci_save_state(pdev);
> > +     pci_clear_master(pdev);
> > +     ret =3D cxl_reset_dvsec_sequence(pdev, mem_clr);
> > +     pci_restore_state(pdev);
> > +     pci_clear_master(pdev);
> > +     /*
> > +      * pci_restore_state() reinstated the guest's PCI_COMMAND, which =
may
> have
> > +      * re-enabled Bus Master while the reset outcome, and thus decode=
r
> > +      * validity, is not yet known. The pci_clear_master() above is it=
s
> > +      * immediate next statement, so there is no window in which a fai=
led
> reset
> > +      * could DMA over decoders that were not restored.
> > +      */
> > +     if (saved_state)
> > +             pci_load_and_free_saved_state(pdev, &saved_state);
> > +     /*
> > +      * Re-enable Bus Master only for a clean reset or -EBUSY (the res=
et never
> > +      * ran, so the firmware-committed decoder is intact), and only if=
 the guest
> > +      * had it enabled (sampled before the reset).
> > +      */
> > +     if ((!ret || ret =3D=3D -EBUSY) && (cmd & PCI_COMMAND_MASTER))
> > +             pci_set_master(pdev);
> > +
> > +     vfio_cxl_post_reset(vdev);
> > +
> > +     /*
> > +      * A clean reset restored the decoder, and -EBUSY means the reset=
 never
> > +      * ran so the firmware-committed decoder is intact: both are know=
n-
> good.
> > +      * Any other error may have left the decoder unrestored, so close=
 the
> gate
> > +      * until the next open or restore. Faults cannot race this: the c=
aller
> > +      * holds memory_lock for write across the whole reset.
> > +      */
> > +     if (cxl->hdm_shadow) {
> > +             if (!ret || ret =3D=3D -EBUSY)
> > +                     cxl->hdm_valid =3D true;
> > +             else
> > +                     cxl->hdm_valid =3D false;
> > +     }
> > +
> > +     /*
> > +      * The guest-facing DVSEC bookkeeping only applies while the devi=
ce is
> > +      * open. Initiate_CXL_Reset self-clears in hardware; mirror that =
and
> > +      * stamp the outcome onto a fresh hardware STATUS2 read for the p=
olling
> > +      * guest. A contended -EBUSY reports as an error so the guest can=
 reissue
> > +      * rather than poll a result that never comes.
> > +      */
> > +     if (cxl->dvsec_shadow) {
> > +             vfio_cxl_dvsec_write16(cxl, PCI_DVSEC_CXL_CTRL2,
> > +                                    vfio_cxl_dvsec16(cxl, PCI_DVSEC_CX=
L_CTRL2) &
> > +                                    ~PCI_DVSEC_CXL_INIT_CXL_RST);
> > +
> > +             pci_read_config_word(pdev, cxl->dvsec + PCI_DVSEC_CXL_STA=
TUS2,
> > +                                  &status2);
> > +             status2 &=3D ~(PCI_DVSEC_CXL_RST_DONE |
> PCI_DVSEC_CXL_RST_ERR);
> > +             status2 |=3D ret ? PCI_DVSEC_CXL_RST_ERR :
> PCI_DVSEC_CXL_RST_DONE;
> > +             vfio_cxl_dvsec_write16(cxl, PCI_DVSEC_CXL_STATUS2, status=
2);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .init_device    =3D vfio_cxl_init_device,
> >       .release_device =3D vfio_cxl_release_device, @@ -849,6 +1012,7 @@
> > static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .zap            =3D vfio_cxl_zap,
> >       .post_reset     =3D vfio_cxl_post_reset,
> >       .pm_restore     =3D vfio_cxl_pm_restore,
> > +     .reset          =3D vfio_cxl_reset,
> >       .owner          =3D THIS_MODULE,
> >  };
> >
> > @@ -869,3 +1033,4 @@ MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("VFIO
> > support for CXL Type-2 devices");  MODULE_ALIAS("vfio-cxl");
> > MODULE_IMPORT_NS("CXL");
> > +MODULE_IMPORT_NS("DEVMEM");
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index 01d808546a4c..f6509824988c 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -910,7 +910,7 @@ static int vfio_exp_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> > -                     pci_try_reset_function(vdev->pdev);
> > +                     vfio_pci_reset_function(vdev);
> >                       vfio_pci_cxl_post_reset(vdev);
> >                       if (__vfio_pci_memory_enabled(vdev))
> >                               vfio_pci_dma_buf_move(vdev, false); @@
> > -996,7 +996,7 @@ static int vfio_af_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_T=
P)) {
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> > -                     pci_try_reset_function(vdev->pdev);
> > +                     vfio_pci_reset_function(vdev);
> >                       vfio_pci_cxl_post_reset(vdev);
> >                       if (__vfio_pci_memory_enabled(vdev))
> >                               vfio_pci_dma_buf_move(vdev, false); diff
> > --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index fc8235c8b4fc..0fed8e00bc1d 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -635,8 +635,26 @@ int vfio_pci_core_enable(struct
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
> > +             down_write(&vdev->memory_lock);
> > +             ret =3D vdev->cxl_ops->reset(vdev);
> > +             up_write(&vdev->memory_lock);
> > +     } else {
> > +             ret =3D pci_try_reset_function(pdev);
> > +     }
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
> >               goto out_disable_device;
> >
> >       vdev->reset_works =3D !ret;
> > @@ -824,16 +842,30 @@ void vfio_pci_core_disable(struct
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
> We basically have the function below that would clean this up, but we're =
open
> coding it still...

For all suggestions in this file, I will move the CXL reset into
.reset_prepare/.reset_done error-handler callbacks instead of open-coding i=
t at
the reset sites and use the existing helpers.

>=20
> >               }
> > -             if (bridge)
> > -                     pci_dev_unlock(bridge);
> >       }
> >
> >  out_restore_state:
> > @@ -1441,6 +1473,20 @@ static int vfio_pci_ioctl_set_irqs(struct
> vfio_pci_core_device *vdev,
> >       return ret;
> >  }
> >
> > +/*
> > + * Reset a function the way a guest asked for. A CXL Type-2 device
> > +resets
> > + * through its DVSEC sequence: the host cxl_reset method would
> > +collide
> > + * with the exclusive HDM range this driver holds and fail busy.
> > +Everything else
> > + * takes a standard PCI function reset. The caller holds memory_lock,
> > +which the
> > + * DVSEC sequence requires.
> > + */
> > +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev) {
> > +     if (vdev->cxl_ops && vdev->cxl_ops->reset)
> > +             return vdev->cxl_ops->reset(vdev);
> > +     return pci_try_reset_function(vdev->pdev);
> > +}
>=20
> "Reset a function the way a guest asked for", but we're actually replacin=
g FLR
> with a CXL reset.  That's not what the user (please don't assume a VM use=
 case
> in vfio kernel code) ask for.

okay, I will drop the VM/guest framing. This is the device's reset method
replacing FLR for a CXL Type-2 function; I will describe it as such and not
assume a VM caller in kernel comments.

>=20
> > +
> >  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >                               void __user *arg)  { @@ -1463,7 +1509,7
> > @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >       vfio_pci_set_power_state(vdev, PCI_D0);
> >
> >       vfio_pci_dma_buf_move(vdev, true);
> > -     ret =3D pci_try_reset_function(vdev->pdev);
> > +     ret =3D vfio_pci_reset_function(vdev);
> >       vfio_pci_cxl_post_reset(vdev);
> >       if (__vfio_pci_memory_enabled(vdev))
> >               vfio_pci_dma_buf_move(vdev, false); @@ -2736,6 +2782,21
> > @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_se=
t,
> >               goto err_unlock;
> >       }
> >
> > +     /*
> > +      * A multifunction CXL Type-2 device cannot be bus reset: its DVS=
EC
> > +      * reset acts per function, so a shared secondary bus reset would=
 reset
> > +      * sibling functions out from under their own state. Reject it, m=
atching
> > +      * the cxl_reset bus method. A single-function device is quiesced=
 through
> > +      * its DVSEC sequence just before the reset below.
> > +      */
> > +     list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_lis=
t) {
> > +             if (vdev->cxl_ops && vdev->cxl_ops->reset &&
> > +                 vdev->pdev->multifunction) {
> > +                     ret =3D -ENOTTY;
> > +                     goto err_unlock;
> > +             }
> > +     }
>=20
> What?  The whole purpose of the hot reset is to handle bus resets affecti=
ng
> multiple devices.  Affecting sibling functions is part of the scope agree=
ment of
> this interface.  This is what the dev_set does.

Sorry, this was incorrect understanding from my side. My reject was
function-scoped reasoning misapplied to a bus reset. A secondary bus reset =
IS
meant to affect sibling functions. I will drop the multifunction veto from =
both the
bus-reset paths and let the dev_set handle it.

I will quiesce the CXL function in .reset_prepare (disable caching, write b=
ack and
invalidate, drop bus master, revoke the HDM mapping) and rely on the CXL co=
re's
post-bus-reset HDM restore (cxl_restore_hdm_after_pci_reset) rather than ve=
toing
the reset.

The only multifunction reject I keep is on the function-scoped CXL reset (t=
he
guest DVSEC reset and the cxl_reset method), which is the same single-funct=
ion
scope Srirangan's series v11 rejects.

>=20
> > +
> >       /*
> >        * Some of the devices in the dev_set can be in the runtime suspe=
nded
> >        * state. Increment the usage count for all the devices in the
> > dev_set @@ -2817,11 +2878,57 @@ static int
> vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> >       list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_lis=
t)
> >               vfio_pci_set_power_state(vdev, PCI_D0);
> >
> > +     /*
> > +      * Quiesce each CXL Type-2 device through its DVSEC sequence befo=
re
> the
> > +      * secondary bus reset: the bus reset alone does not write back t=
he
> > +      * device cache or tear down the HDM decoders. memory_lock is hel=
d. If
> a
> > +      * quiesce fails, abort before the bus reset: resetting an unquie=
sced CXL
> > +      * device risks data loss or a fabric error. Every device is lock=
ed here,
> > +      * so unwind from the last one.
> > +      */
> > +     list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_lis=
t) {
> > +             if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +                     ret =3D vdev->cxl_ops->reset(vdev);
> > +                     if (ret) {
> > +                             pci_warn(vdev->pdev, "vfio-cxl: hot reset=
: DVSEC quiesce
> failed (%d), aborting before bus reset\n",
> > +                                      ret);
> > +                             vdev =3D list_last_entry(&dev_set->device=
_list,
> > +                                                    struct vfio_pci_co=
re_device,
> > +                                                    vdev.dev_set_list)=
;
> > +                             goto err_undo;
> > +                     }
> > +             }
> > +     }
>=20
> Does writing back the device cache affect data beyond the scope of the us=
er
> that owns the device?  Preventing fabric errors that might escalate to sy=
stem
> errors is a concern.  Losing data that the device might be caching outsid=
e the
> scope of the user data is a concern.
> Preventing user data loss because they reset a device holding their own d=
ata is
> not a concern.

Okay, I will reframe the justification around the real concerns, containing=
 fabric
errors and not losing device-cached data outside the resetting user's scope=
.

>=20
> > +
> >       ret =3D pci_reset_bus(pdev);
> >
> > -     /* Re-sample decoder state for any CXL device the bus reset touch=
ed. */
> > -     list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_lis=
t)
> > -             vfio_pci_cxl_post_reset(vdev);
> > +     /*
> > +      * pci_reset_bus() restored each device's PCI_COMMAND, which can =
re-
> enable
> > +      * Bus Master, but the secondary bus reset cleared the physical H=
DM
> decoder
> > +      * that the CXL quiesce above restored. Until it is restored a CX=
L device
> > +      * could DMA over cleared decode, so for each CXL device drop Bus
> Master,
> > +      * restore and re-sample the decoder, then re-enable Bus Master t=
o the
> > +      * guest's intent only once the decoder is known good. Re-samplin=
g alone
> > +      * would leave hdm_valid true over a cleared decoder. Keep the fi=
rst
> restore
> > +      * error so a failed restore is reported instead of the bus reset=
's success.
> > +      */
> > +     list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_lis=
t) {
> > +             u16 cmd;
> > +             int rret;
> > +
> > +             if (!(vdev->cxl_ops && vdev->cxl_ops->reset))
> > +                     continue;
> > +
> > +             pci_read_config_word(vdev->pdev, PCI_COMMAND, &cmd);
> > +             pci_clear_master(vdev->pdev);
> > +             rret =3D vfio_pci_cxl_pm_restore(vdev);
> > +             if (rret) {
> > +                     if (!ret)
> > +                             ret =3D rret;
> > +             } else if (cmd & PCI_COMMAND_MASTER) {
> > +                     pci_set_master(vdev->pdev);
> > +             }
> > +     }
>=20
> More open coded calls that should be handled via .reset_done.

Okay, I will resolve this.

>=20
> >
> >       vdev =3D list_last_entry(&dev_set->device_list,
> >                              struct vfio_pci_core_device,
> > vdev.dev_set_list); @@ -2876,6 +2983,16 @@ static void
> vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
> >       if (!pdev)
> >               return;
> >
> > +     /*
> > +      * A multifunction CXL Type-2 device cannot be bus reset (its DVS=
EC
> > +      * reset is per function), so skip the automatic reset rather tha=
n reset
> > +      * sibling functions out from under their state.
> > +      */
> > +     list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list=
)
> > +             if (cur->cxl_ops && cur->cxl_ops->reset &&
> > +                 cur->pdev->multifunction)
> > +                     return;
> > +
>=20
> Nope.

Okay, I will handle it as per above bus-reset reply.

>=20
> >       /*
> >        * Some of the devices in the bus can be in the runtime suspended
> >        * state. Increment the usage count for all the devices in the
> > dev_set @@ -2884,9 +3001,56 @@ static void
> vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
> >       if (vfio_pci_dev_set_pm_runtime_get(dev_set))
> >               return;
> >
> > +     /*
> > +      * Quiesce each CXL Type-2 device through its DVSEC sequence befo=
re
> the
> > +      * bus reset, which alone does not write back the device cache or=
 tear
> > +      * down the HDM decoders. Take memory_lock and zap the HDM
> window as the
> > +      * explicit hot reset does. On lock contention or a failed quiesc=
e, skip
> > +      * the bus reset and leave needs_reset set for a later retry.
> > +      */
> > +     list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list=
) {
> > +             if (!(cur->cxl_ops && cur->cxl_ops->reset))
> > +                     continue;
> > +             if (!down_write_trylock(&cur->memory_lock))
> > +                     goto unwind;
> > +             vfio_pci_cxl_zap(cur);
> > +             if (cur->cxl_ops->reset(cur)) {
> > +                     up_write(&cur->memory_lock);
> > +                     goto unwind;
> > +             }
> > +     }
>=20
> .reset_prepare?

Okay, I will resolve this.

>=20
> > +
> >       if (!pci_reset_bus(pdev))
> >               reset_done =3D true;
> >
> > +     list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list=
) {
> > +             u16 cmd;
> > +
> > +             if (!(cur->cxl_ops && cur->cxl_ops->reset))
> > +                     continue;
> > +             /*
> > +              * pci_reset_bus() restored PCI_COMMAND, which can re-ena=
ble Bus
> > +              * Master, but the bus reset cleared the physical HDM dec=
oder. Drop
> > +              * Bus Master, restore and re-sample the decoder, then re=
-enable Bus
> > +              * Master to the guest's intent once the decoder is known=
 good.
> > +              * Re-sampling alone would leave hdm_valid true over a cl=
eared
> > +              * decoder.
> > +              */
> > +             pci_read_config_word(cur->pdev, PCI_COMMAND, &cmd);
> > +             pci_clear_master(cur->pdev);
> > +             if (!vfio_pci_cxl_pm_restore(cur) && (cmd &
> PCI_COMMAND_MASTER))
> > +                     pci_set_master(cur->pdev);
> > +             up_write(&cur->memory_lock);
> > +     }
>=20
> .reset_done?  Thanks,
>=20
> Alex

Okay, I will resolve this.

Manish

>=20
> > +     goto out;
> > +
> > +unwind:
> > +     list_for_each_entry_continue_reverse(cur, &dev_set->device_list,
> > +                                          vdev.dev_set_list)
> > +             if (cur->cxl_ops && cur->cxl_ops->reset)
> > +                     up_write(&cur->memory_lock);
> > +
> > +out:
> >       list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list=
) {
> >               if (reset_done)
> >                       cur->needs_reset =3D false; @@ -2919,6 +3083,29 @=
@
> > void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
> > }  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> >
> > +/*
> > + * Drive a guest-requested CXL reset. The memory_lock, mapping revoke
> > +and
> > + * dma-buf quiesce are core-internal, so vfio-cxl calls in here to
> > +run them
> > + * around its DVSEC reset sequence.
> > + */
> > +int vfio_pci_core_cxl_reset(struct vfio_pci_core_device *vdev) {
> > +     int ret;
> > +
> > +     if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
> > +             return -ENOTTY;
> > +
> > +     vfio_pci_zap_and_down_write_memory_lock(vdev);
> > +     vfio_pci_dma_buf_move(vdev, true);
> > +     ret =3D vdev->cxl_ops->reset(vdev);
> > +     if (__vfio_pci_memory_enabled(vdev))
> > +             vfio_pci_dma_buf_move(vdev, false);
> > +     up_write(&vdev->memory_lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_cxl_reset);
> > +
> >  static void vfio_pci_core_cleanup(void)  {
> >       vfio_pci_uninit_perm_bits();
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index 46e67573d264..8055099cab03 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -102,6 +102,8 @@ static inline int vfio_pci_cxl_pm_restore(struct
> vfio_pci_core_device *vdev)
> >       return 0;
> >  }
> >
> > +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
> > +
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev);  void vfio_pci_memory_unlock_and_restore(struct
> vfio_pci_core_device *vdev,
> >                                       u16 cmd); diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > c438d968dc59..18e206a35d8c 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -82,6 +82,8 @@ struct vfio_cxl_ops {
> >       void    (*post_reset)(struct vfio_pci_core_device *vdev);
> >       /* Restore the HDM decoder after a D3hot->D0 soft reset */
> >       int     (*pm_restore)(struct vfio_pci_core_device *vdev);
> > +     /* Run the CXL reset sequence; the core holds memory_lock across =
it */
> > +     int     (*reset)(struct vfio_pci_core_device *vdev);
> >
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> > @@ -89,6 +91,7 @@ struct vfio_cxl_ops {
> >
> >  int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
> > void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
> > +int vfio_pci_core_cxl_reset(struct vfio_pci_core_device *vdev);
> >
> >  #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
> >  int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,

