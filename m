Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C82480978;
	Tue, 19 May 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185055; cv=fail; b=eC0cTwehXS+0kGM3C7DXKCU3xFGGV/K3MvQeWlYVlj0ry56s8npxTpfbWGr8kJpfclsM3DAlJeVX4PNOJk5wRyWk87kC51XzcG3IrBsGxzrkgAUXqZ0Xi2FHibu8ranCmpD6qZARAA6cg5qQnLA/PTvisYcpw8J78wq3/X4+aCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185055; c=relaxed/simple;
	bh=g4Hukdxnusd1YJv2nDMSxcesvFFWAE/hGsKCUJRka2w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kkOpNeQZV1MwW9fq9kuuR1Stw3ufumMxs/fh2oAe8Ov+6gVLc5RVakCD0AY14JghIpLsteIY3Jv7vsKR6cVR28fF3gEsW2dPE7jQgbQeVwtnFn1Nt5DCXrTmQj93CnX8Nq7PvQZ9bY8j31adCbKeB2kxeeUAMRO/d/ZKkhu97bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2mqFKkG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2mqFKkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779185054; x=1810721054;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=g4Hukdxnusd1YJv2nDMSxcesvFFWAE/hGsKCUJRka2w=;
  b=P2mqFKkGIbOI7F/iG05DbVTd3kPPuuyVtz9cB2kasFfa6GHs7q30lXht
   DonvjgP7Jfu9amH8J5goUodd6cOdjByFmmevfbeRBXez6lFUEAE+7K1q6
   nJ+AQXINh2pR1NOqnllh1RyLkfpPIi4zpAdu3UncV6IxLzQbwhJWpwOyJ
   /BqP7ldmc02s4EqSpeQTbUjhIDtszZpk515A5Emnhf8iv1MKLpjz5p1ec
   HD0glUXl/Qig3mz6uNAY/CuslPBM3u/2PPZ7fFuAT4VGlBewFfOKh8oJ9
   UWoRkhe0fdmKRT28ZBjGBAP2wFX3wQssj3fPHN95Zz4CRU2hGOySFdSos
   A==;
X-CSE-ConnectionGUID: /1LH/NaaQamtEGK9GN8Saw==
X-CSE-MsgGUID: /mWme057Qr2slPTFt12Yjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80110066"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80110066"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:04:13 -0700
X-CSE-ConnectionGUID: lXyPvL4+RxeCuTQHff2C8g==
X-CSE-MsgGUID: C6KGfI83QzCX+vnJAgIMbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="238733298"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:04:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:04:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 03:04:12 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaVW3OSykN0IGIcOgLotdcKk/uQdKWrVXOEQzDjG8/wyzKfjqCujDaVC6lo6+CCh1SPDodpZS3cE9U/v87iaA+JWhx2wggi110vRn4fmdCqxH9EZ0Uzcwcx51wZqvJL65E+syzHsQrpMNboLAd6VSjtXg3+PDBaI4qwZCHAa1wxdPRLGFniTrnz07blVwFRN96XbQXBYj5rO6YjdoZf/lIUv0lgJcejCtnt6UBAltBM45ZFy0Ni1W2DZAbW2UD69Y1Uzq13THxDPJTzQ+g0XJAkgkIfptkxnHzmykWxq5kRLw5RjmDRZDVD5X9vKQmZuCXP5AC6gd7b0FlRAIWhOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMoVdlK0zux7tKlXLMUlVXV9wwUEnXkMRQwCD+iCBxI=;
 b=GHKvIcs4O1C+FRMKXglPOfU7bMb6n1ONiTI1RM+AULaCUNZa221A8Qp7Ato+aQqruf1YHFSFWrd79jXQlspAEd6o2/EGoLLlUoPemZTyvZ4uUxkWv89HuNgSmmyfR1r0SLw6aIgIEFM3iJ6ZpUtuhpntntsl2mmX8pFohyf8n8je4hcPfSQ6hTxfSkIJBT5kJdpHvAzkREiMYOC1rOracq8bY7Wy/yhF5et7cUb/oGGjKNuSOC1WjsZEjno2H5eMw0I6o781SVvlevpCJ4uTXo03ckpuhb7bE5cwrWOD/DqajCmO0Gx76LskT7Y8xsehpUf5RZGl28y7fZwCFRlJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:04:04 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 10:04:04 +0000
Date: Tue, 19 May 2026 12:03:49 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <phasta@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Phani R Burra <phani.r.burra@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 02/14] libie: add PCI device initialization
 helpers to libie
Message-ID: <agw1hWoriXhQ7vK3@soc-5CG4396X81.clients.intel.com>
References: <20260518215441.GA640516@bhelgaas>
 <7a477885c58709f287f6c1440fb7e31331227d10.camel@mailbox.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a477885c58709f287f6c1440fb7e31331227d10.camel@mailbox.org>
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BY1PR11MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: c9119180-d464-4c2e-64b4-08deb58df418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|56012099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6C4lUNFXvnFOVFRxhahMnzjwTLsXz18moIkbig9RbxFv9Amc/lbAkiyvH3IDXQECdlIpXR5VorBKT+RhVscSY0h7pOoodPR46YPeJlOfNdE8w56kzZEbnLEKN+aDqXfzCYlE0Vtd6QUSzqoGEr71nZRQqaB3Fn8mTV1xZ9QrWSPaS3ZvZtxC+3Hgh2JOp4gwv1r89pRYO/ty71TQQrC3PEse0qg51DTbgOfltsvWXNpJAc9Tawj6iHpppdEEXUJy2LwNM2yfKtuN5zk7JoSohV6KbPkPWfo5c95C/Au4BLj7akYh8CYmN/g1fAY3Haka/HEI8R8Z7X0JcR7UGMlXVu94sPR+RDK70QWKxulfpt8NOqVXjQSD9+JwDr4CwOMGqxRDdErZ2GmBvxCUqpvrhjDEfdGzCeTSie73u2cQ13TrRrhbY5H8qHL2vBp5FCDx1VMTtkmhOFvdm0RX+gJ1wI6G7robFlzuqjWyeLWaCBYyBTS9KRZh0TCd3WjxZREqqUU79RwSgifnIedCA05K0ZhUUPUr5qqx+TCTHMy1xlSoJVzYQsU4GYJ6YGLcR4tdXvzNPfW+meRiFaRxAjHjn39Yz3S5GX1as9EH+eYgnPB+csGDgPDJu1mlgWMQw2FZSb0vYkEHbKySZHBRZDjikP/+O2xGYzo2Ee6qHarMw5HY/NRFtHk3BuoBoybJhnyp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(56012099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?93YuGE+8zocMh9oRNDS9Ykvywaua4SW1dLpM2HRJ17jDBnPA46fLxyBpnD?=
 =?iso-8859-1?Q?Qp4OKt5UHV1qWlFf/Tal680ruiSEvhwq0D45JfbWz5ABzPVgnhO9Il2o4w?=
 =?iso-8859-1?Q?5hrlGnnTxPk+olncGFf8DmK/W9wcrc9jWVbQWQSAKKb6KWhDDXJrhUJ080?=
 =?iso-8859-1?Q?+wpxtydekfF3bx0SgB32Y3TXU8iRrK6o5GUYGasixCv95z02OBvVcwBxYj?=
 =?iso-8859-1?Q?blcS/kur89QXVGmr1IChCMobiDVlmKc17UESaCktEbmhsQ5ee6JCzNV4s+?=
 =?iso-8859-1?Q?WUM9lJ0L4EKxUT3gsqS57wPOq2+k8Cjr6vGrWvE7M6bgF84qisz50KhmGG?=
 =?iso-8859-1?Q?GRmAlatRnVtMsyQUTaziBbgedy5ilcLUfOnhC4uMl4OrosLASjZ9gkOQo0?=
 =?iso-8859-1?Q?CpBbCmsGLy6Px+CJ7Emg0ckga94X9pbczW8QQbQHcWNHdjyiVdPUUULn0n?=
 =?iso-8859-1?Q?/OdK7BcV4DvTzUb+JxDx7Wm3DVeZIdFWWiLVAZLmCOfYF+GfmgbMrlQFtS?=
 =?iso-8859-1?Q?LrfDJS2wc3LwlDM5uC9D2jpNdafVEkzvqTW9VAkM7c8qqkOayxQIwK1Gy7?=
 =?iso-8859-1?Q?2iIlQ+vxiXJqIn9WORTdt+ECc5Ug40eJSAomhlwh1fahvsLtDkzxDBT/IC?=
 =?iso-8859-1?Q?hWRmI4mzRTEJVquFgzBguC9JFXam8igryw0Ym17FOvpD1zMyBjgVAFmj2n?=
 =?iso-8859-1?Q?kG14eLmU/IBjMp3qQy58RaMtU+RMr4m/ZxBJEIqH8PtDP4febDFqcz70VJ?=
 =?iso-8859-1?Q?V2EX24SMMxVLP2HZ8H88H10zi6FgEJhO3Vj62YNq/juaFcrcxEvVTVcWwd?=
 =?iso-8859-1?Q?GL6NaAjplNaSFgAz19Tpb2qv3l0kcjWvj3Aw3+Qdg+zz679xZdSA3e9l/U?=
 =?iso-8859-1?Q?Zia73MROmwwkGh0g2VbxIKp4lVANiCn4K1jEaXvbgsu2kW1C1SWFztm07Q?=
 =?iso-8859-1?Q?4QIDAP3v2XfJfWPDfaSJO1IrXwgEEEAB0/wMRaSbTbIZ1CxmrOtWwegNcH?=
 =?iso-8859-1?Q?UYXjJ7IASTjsdVV3vPE9wlLVZZ/Az+MrDplk1+SNBTDMIbkoGTQoKGS1Ab?=
 =?iso-8859-1?Q?wGLgKTRLPDprhbH5awwhgaszpl5TQfBjGeRPt2Gho1uPJRS3uv3arEKsQ1?=
 =?iso-8859-1?Q?ygeGn6SxgC7ttJO0gIJ2d8uws9TiWQTqGc14CiRxNJgkUZFhiwTTrrSKUE?=
 =?iso-8859-1?Q?BfEkcF2dwxVlcLHyO4ctyltKKmZDmpFlvcpe2nFVCnao730eC24++iuD4C?=
 =?iso-8859-1?Q?394bOFwvfACPwR3otxwBaZCl3wm15AEl/vWF8/fztniYfi+PJcovtRscUU?=
 =?iso-8859-1?Q?8Va0UJWxvugBY3/pTiMZLAZz8nKBcebt5mI+WvFUNvF8+BkcmGDlgI2f7u?=
 =?iso-8859-1?Q?iXLyJEXcGAYTrMr1iFNU0jhaNJyL45BqCPa9vKLbrnxEv+Fvq74fB4Tjl7?=
 =?iso-8859-1?Q?Nw3Wkc1b+8RCboj5AVy1Ht+qSMgWqxWm4wxQf8aS5HaNnRZBvPxin6KC8u?=
 =?iso-8859-1?Q?vok/jZA2ssjtib92jMbE0QLwXVGMd12Bo1VaV/KLxtoWhSJia906ly+P1C?=
 =?iso-8859-1?Q?qpgLk037jeXhSrLDMGHuVlCJIbDq9xtWwJWyZRFGd8aN7Suoi9lRTi2nis?=
 =?iso-8859-1?Q?E+m7Q6NgN/gxCEUMbSAQ0dKQlanRqeOSSTpA5tKYsfTqY2j7iW0+xaryzM?=
 =?iso-8859-1?Q?4YKTMuISU6dVyTV9sKK9nFWEB9Ll/Rm8Yw5sDHoQ9A6BRXEEXUnb+BKQ0P?=
 =?iso-8859-1?Q?wc2z34PLqHlmOYxigZnV/UeD5qflNgYxi65V6/Gfu3uxw+YgBQm5ksBcrV?=
 =?iso-8859-1?Q?DWhBjhrijP/SRYIf5X/tG8IPWyOFf2nCl2Q4KkIQLTakq+aYndtI+i8XnY?=
 =?iso-8859-1?Q?1k?=
X-MS-Exchange-AntiSpam-MessageData-1: L7/TjX2WgAdMDzxUnu7BJCsvBGjv0x10aIY=
X-Exchange-RoutingPolicyChecked: jqZUSrSG+6FVA6P1MYE1flrL1bHAkV4ldU9aTsV01IaT5oHHeH4EQcRgvr9UCIoZ/T77LKhQFWK/wVR24PRFgJq/CI0GAmBAlTU0XQxpySipJwj+rO99zA0T/d2gndNdgTmqkm2ccaLzgz0s+87ct7Mksb/RAg5kGX7Do+IG5DCU1AuibsUv/aFTMtUHqqdOmpceCG1XOnXgckXAlsnouzPggFRDOn5LwjLz5dvmztpFVCoir8oIJBn4oSbtCM700luJj0dUvBYxvMCPn0KX4HGM515TZQHj6906TvwK7LBRqGUJ+QFFhoCFfXbgM73Kp+5pQJV/VqbKuVTGlFDRMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9119180-d464-4c2e-64b4-08deb58df418
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:04:04.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+OOshhdNi69+xCs0toqBcf8ptEUu4Qe+Hhk67tEaW/2lvIgcwq3iuhJES+v1gdr6GsGV9WJ+pMORnHbRWmKPvrNnAx/0OpvbgiWqLdAI+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 10:20:27AM +0200, Philipp Stanner wrote:
> On Mon, 2026-05-18 at 16:54 -0500, Bjorn Helgaas wrote:
> > [+cc Philipp]
> > 
> > On Fri, May 15, 2026 at 03:44:26PM -0700, Tony Nguyen wrote:
> > > From: Phani R Burra <phani.r.burra@intel.com>
> > > 
> > > Add support functions for drivers to configure PCI functionality and access
> > > MMIO space.
> > 
> > This looks kind of like what pcim_iomap_range() does, i.e., a way to
> > ioremap (BAR-idx, offset, size) pieces of PCI BARs.  That sounds like
> > useful functionality.

I agree that pci_iomap_range() could simplify the implementation a little bit. 
But libie_pci API is still needed for ixd and idpf.

I guess commit message lacks clarity. Apart from mapping separate ranges, 
libie_pci also adds a list which is intended to be tranversed by a driver, e.g. 
to pass certain IO mappings to the auxbus devices. Such list is also traversed 
by the libie_pci_get_mmio_addr() helper. And there is also some input 
validation, because ranges are received from a very customizable FW. So a lot of 
driver-specific convenience stuff.

> > 
> > Is there something Intel-specific or even ethernet-specific about
> > this?  If devm_* and pcim_* don't do what you need, maybe they should
> > be extended or this could be made generic so any drivers could use it?
> >
> > This looks like a mix of managed (pcim_enable_device(),
> > pcim_request_region()), and unmanaged (ioremap(), iounmap()) things.
> > I haven't looked at how all this is used, but it's pretty easy to get
> > things wrong when mixing models.
> >

The mix of managed-unmanaged things is because of static and non-static regions. 
Static regions do have a device lifetime. Dynamic are theoretically only valid 
between hard resets (e.g. from idpf_vc_core_init() and idpf_vc_core_deinit), so 
a nice thing to do in such case is to unmap them before the reset.

I settled on a "mixed" model, because this way libie_pci_init_dev() can befefit 
from managed APIs, but region management part can stay much more flexible.

I do not think making this generic makes sense, it is rather tailored to the 
requirements of idpf (data plane) + ixd (control plane) generation of intel 
ethernet devices. I you have some examples that could use the same logic, I 
could take a look.

For context:
Libie was generally created as a way to just reduce code duplication between 
intel ethernet drivers. And we had a lot of code duplication. So this library is 
mostly things that would be otherwise copy-pasted.
 
> > > +++ b/drivers/net/ethernet/intel/libie/pci.c
> > > @@ -0,0 +1,208 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2025 Intel Corporation */
> > > +
> > > +#include <linux/intel/libie/pci.h>
> > > +
> > > +/**
> > > + * libie_find_mmio_region - find MMIO region containing a range
> > > + * @mmio_list: list that contains MMIO region info
> > > + * @offset: range start offset
> > > + * @size: range size
> > > + * @bar_idx: BAR index containing the range to search
> > > + *
> > > + * Return: pointer to a MMIO region overlapping with the range in any way or
> > > + *	   NULL if no such region is mapped.

[...]

> > > +
> > > +	if (offset + size > pci_resource_len(pdev, bar_idx))
> > > +		return false;
> > > +
> > > +	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> > > +				    bar_idx);
> > > +	if (mr) {
> > > +		pci_warn(pdev,
> > > +			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
> > > +			 bar_idx, (unsigned long long)mr->offset,
> > > +			 (unsigned long long)mr->size,
> > > +			 (unsigned long long)offset, (unsigned long long)size);
> > > +		return mr->offset <= offset &&
> > > +		       mr->offset + mr->size >= offset + size;
> > > +	}
> > > +
> > > +	pa = pci_resource_start(pdev, bar_idx) + offset;
> > > +	va = ioremap(pa, size);
> 
> I agree with Bjorn, this certainly looks like something that can be
> covered by shared PCI infrastructure?
>

I terms of address calculation I agree that pci_iomap_range() could help shrink 
the code a little bit.

> > > +	if (!va) {
> > > +		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
> > > +		return false;
> > > +	}
> > > +
> > > +	mr = kvzalloc_obj(*mr);
> > > +	if (!mr) {
> > > +		iounmap(va);
> > > +		return false;
> > > +	}
> > > +
> > > +	mr->addr = va;
> > > +	mr->offset = offset;
> > > +	mr->size = size;
> > > +	mr->bar_idx = bar_idx;
> > > +
> > > +	list_add_tail(&mr->list, &mmio_info->mmio_list);
> > > +
> > > +	return true;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(__libie_pci_map_mmio_region, "LIBIE_PCI");
> > > +
> > > +/**
> > > + * libie_pci_unmap_fltr_regs - unmap selected PCI device MMIO regions
> > > + * @mmio_info: contains list of MMIO regions to unmap
> > > + * @fltr: returns true, if region is to be unmapped
> > > + */
> > > +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> > > +			       bool (*fltr)(struct libie_mmio_info *mmio_info,
> > > +					    struct libie_pci_mmio_region *reg))
> > > +{
> > > +	struct libie_pci_mmio_region *mr, *tmp;
> > > +
> > > +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> > > +		if (!fltr(mmio_info, mr))
> > > +			continue;
> > > +		iounmap(mr->addr);
> > > +		list_del(&mr->list);
> > > +		kvfree(mr);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_fltr_regs, "LIBIE_PCI");
> > > +
> > > +/**
> > > + * libie_pci_unmap_all_mmio_regions - unmap all PCI device MMIO regions
> > > + * @mmio_info: contains list of MMIO regions to unmap
> > > + */
> > > +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info)
> > > +{
> > > +	struct libie_pci_mmio_region *mr, *tmp;
> > > +
> > > +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> > > +		iounmap(mr->addr);
> > > +		list_del(&mr->list);
> > > +		kvfree(mr);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_all_mmio_regions, "LIBIE_PCI");
> > > +
> > > +/**
> > > + * libie_pci_init_dev - enable and reserve PCI regions of the device
> > > + * @pdev: PCI device information
> > > + *
> > > + * Return: %0 on success, -%errno on failure.
> > > + */
> > > +int libie_pci_init_dev(struct pci_dev *pdev)
> > > +{
> > > +	int err;
> > > +
> > > +	err = pcim_enable_device(pdev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> > > +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> > > +			err = pcim_request_region(pdev, bar, pci_name(pdev));
> 
> So mappings are handled manually, and region requests automatically
> through devres?
> 
> In case you can use (or add) a pcim_iomap_region() function for that,
> you would get consistent automatic devres management.
> 
> 
> Greetings,
> P.
> 
> > > +			if (err)
> > > +				return err;
> > > +		}
> > > +
> > > +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	pci_set_master(pdev);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(libie_pci_init_dev, "LIBIE_PCI");
> > > +
> > > +MODULE_DESCRIPTION("Common Ethernet PCI library");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libie/pci.h
> > > new file mode 100644
> > > index 000000000000..effd072c55c8
> > > --- /dev/null
> > > +++ b/include/linux/intel/libie/pci.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright (C) 2025 Intel Corporation */
> > > +
> > > +#ifndef __LIBIE_PCI_H
> > > +#define __LIBIE_PCI_H
> > > +
> > > +#include <linux/pci.h>
> > > +
> > > +/**
> > > + * struct libie_pci_mmio_region - structure for MMIO region info
> > > + * @list: used to add a MMIO region to the list of MMIO regions in
> > > + *	  libie_mmio_info
> > > + * @addr: virtual address of MMIO region start
> > > + * @offset: start offset of the MMIO region
> > > + * @size: size of the MMIO region
> > > + * @bar_idx: BAR index to which the MMIO region belongs to
> > > + */
> > > +struct libie_pci_mmio_region {
> > > +	struct list_head	list;
> > > +	void __iomem		*addr;
> > > +	resource_size_t		offset;
> > > +	resource_size_t		size;
> > > +	u16			bar_idx;
> > > +};
> > > +
> > > +/**
> > > + * struct libie_mmio_info - contains list of MMIO regions
> > > + * @pdev: PCI device pointer
> > > + * @mmio_list: list of MMIO regions
> > > + */
> > > +struct libie_mmio_info {
> > > +	struct pci_dev		*pdev;
> > > +	struct list_head	mmio_list;
> > > +};
> > > +
> > > +#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
> > > +	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
> > > +				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> > > +
> > > +#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
> > > +	__libie_pci_get_mmio_addr(mmio_info, offset,			\
> > > +				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> > > +
> > > +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> > > +				 resource_size_t offset, resource_size_t size,
> > > +				 int num_args, ...);
> > > +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> > > +					resource_size_t offset,
> > > +					int num_args, ...);
> > > +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
> > > +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> > > +			       bool (*fltr)(struct libie_mmio_info *mmio_info,
> > > +					    struct libie_pci_mmio_region *reg));
> > > +int libie_pci_init_dev(struct pci_dev *pdev);
> > > +
> > > +#endif /* __LIBIE_PCI_H */
> > > -- 
> > > 2.47.1
> > > 
> 
