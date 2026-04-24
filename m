Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72835DA4F;
	Fri, 24 Apr 2026 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013362; cv=fail; b=dmcYUMoS2rNSdprlBbNeYvW/KzaMfa+p76AEPbrahtFBNCXzgxkl9k+VPfmClZRrR8wwQgFHfcXCTmSQ8y4vXXcMcr0ngnNYFbh14NR0kap+zbVTRafeJauY7MzgSce/HyCIWDB+N7RGi4ATb3k8gIeWpM516XQMHdVezGVjVIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013362; c=relaxed/simple;
	bh=DU7EYnddrkvoQERLA8tuRPA/eK6TcTfYtF19j4SjabE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pw7Czc7lA6XUDc7IHzsZYNNLZLvgqhggbBr0JOZqd+MKaXyKftxIVu2xOsBkpCTE4s8pB8tZx8V8Q6OgQvUj67YxBP8TJnZkBNU5DAEYlZ0J6FL/OydCV+nX3Mh9iAaRjD4DEXHQU7ZeBajHtY3c9rPceXc8pxEEuOrdkpTNz9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5qOT25B; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5qOT25B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777013361; x=1808549361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DU7EYnddrkvoQERLA8tuRPA/eK6TcTfYtF19j4SjabE=;
  b=j5qOT25BmqjNllqdeFub7lwHZRbq+vAZaDqz5j5qaSeD6A8r6/7B5wfJ
   kHz2b/1RnsHK+yl16OkFIKcJezkNC968MrhkIp5Vv+Hw3IyoDnZmZKBN3
   6XxQ6yfWDFCGRB1zmJBFuRaYlIQHYVEwn3CX3QoIBuViOS4AcsVFKuFI7
   vWL9iOXKIumAvWq43NPW45rPD1lWrgKE49JQbT3m6L+pG9ECzIQOjHB/b
   CGO9Aa539lnJ3EPfHjDhTlazO0tfsuwOyOeub+45jm9OXkMCuHTJbEx44
   ij4kaij4wgSINXGVO+YIWaIffl8+q0HHUNIzYaj3XFSn5tv67G9RJXWcC
   g==;
X-CSE-ConnectionGUID: R6g79iGFS/Ozy9bpzQLbFA==
X-CSE-MsgGUID: HBt36jW5Stmfx127junb+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78009864"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="78009864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:49:21 -0700
X-CSE-ConnectionGUID: tP4yTkP4RHmJuOLq0NWcjw==
X-CSE-MsgGUID: 8gNDmoxuTW6dSp/VGqx9og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237875582"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:49:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:49:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 23:49:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xiep7MrB+nEvk+DnDSaFpZDhNXDja9FNi1GDAiZAtYsOedh5m4SA7bblD2tQZicR99PVsL9HsELA3YCtdamarueISfnWFJrpQ9X7ENs1loQAMbQp0U1P8U5RRxTgmhp4bO+XIPSIPigC2j2ZbXgvAedgpFsQnyU5SAC5iuf2zUbnEgk9YsvxmJt6d/NuXBj59CmLMtHCJwVMXO2PG7wjb8ctY5vqo8gyYP6tHhPNTMoR/dW4q7xEvhcfxjbI+pVVJy5Ke8fRCfk+NClsJmfslfQ5mg7LBOGw7Cm+al18S9ajJvPDo9q4wN7cHWkRGP4c0afKl4+0qnNSGxmSQzNO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCnfoLaoGL6osQIx82zvGuMdWrBLobBTQlFP/zqvrwI=;
 b=lrKQ0GPecEIs8tQDYAkDfDU6Zk3+FrVFhSWv+fZqgAg+MHBETgYp/AOckAdz1oPi1+Lq5/rp5XbV9uRGurOBhelBTWP+F/97QqSoXJjfO2HRDV825bgqs6eRJAwseaQjPfM6/z6/acxgR7ooORgbPpeysvOa0tl8gPkyIRNsV4jovvOdiKHq1Rli+VNHi2jFetlkQnTUmc+rGQxaqdjIHnbPI+2f+mjUlHzcVUl40Gqd6MRBGD1bgiRVL8ZVS8t3PyjdMPjy2G2X/g2QY9wS697W1ZFmo5Or2Y7zRi4kTa5t03GCR3QU8LFGAWOGREpfFqmrCb5i6uOfTbznWO3l/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 06:49:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 06:49:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Thread-Topic: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Thread-Index: AQHcvgd9ANJRNCVJcUiufPiQQD4iRbXWYsNwgBRb8ACAAy4aMA==
Date: Fri, 24 Apr 2026 06:49:09 +0000
Message-ID: <BN9PR11MB52763F59424C6E4AFD7F63988C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-20-yilun.xu@linux.intel.com>
 <BN9PR11MB52767F28E9FF692ACE69F3D78C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aehkFicutMwa2LP+@yilunxu-OptiPlex-7050>
In-Reply-To: <aehkFicutMwa2LP+@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8594:EE_
x-ms-office365-filtering-correlation-id: 15ca09fd-3c4c-4266-8758-08dea1cd9655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: 9+vz6ZqIBv5Z6rV5R/KrU/tOY9q9In+Ss0fzua0FWx5wDBWMIr7nQ7Mz8p7+sd+Aii9YTnoHVe2PCynwipua4f+v4NdjUiJU0adhCeNj2oBoEY5bIBzkcrA2PF2p9JMsXc4MX0c8/FLksg1dXed05kG1ZE7KiHNPaiawwmIMZ4tvwwS0+0OGgs+w5KiRh3118/JHI1F/o8zXyxJAAu4W4Li5IpX3vV0FKg1BlUEkh94jAJN2Op99atM/MLG3uHe6Yy/e9J1qjtgZEGY2JJLdSF5LURRcvFyYGte2l6F8q1xto80B1trKdC5OYxFZKnDvfBtLELDPXfJKWEtiJX6g1uyzvNyRDRExekSC0wc0IwGAIKNvB+1UG9kSOCZX8u4eyoPNIs7ILMBIRwbN3iQ7FfXiJyodHw7Df/poxTL+RH+pzmKO2YrKj78mqS1WFLEMMdmFZFEb+IEx0A4HIsPelxMiHx3/o+5hb3lYAIj55Wm+qReecZJd3A0QuzM2YQipRPrFNkJDVZqj3iDVEBhv/vfW5W3yWInFt51BjV5VF58a20AUqUnW97RWyV9tFdGxAlkAijJaDYLBLNG12AvVNNJwKxfZo6s1q64+JlCzurp18JfugQy9kH04+oy5kjZM+UuUnTomVqZ+S06IKgBrIXUZLaB+yoChKTiNsmsoG4vIH0UMrMNnTkGXXXOiWY+yvPv6YwnlTBlTPWBfzRAnjTJ3/BOrjh5WIZggTWMj4JZmx9f86tCPxX2SfeGPjenPs3H0oPfwfusq3RidVYFWytETdkPWZm9FYTUMPSEavZQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?83KsKvnGqa5g/7DLpt3M+JpnMnywRtgx0a44HBsM8yD/VLncOJmp9Mpr+ZqD?=
 =?us-ascii?Q?AFRKZEwaIEAkjZJFoJbV5z3g22oUUJWT0I1EH8xm1hoKlVSHwsk6aVi1owx5?=
 =?us-ascii?Q?Huj/RCHqVDdnGOWw7k5QziyYRe46G8Pwp9DUyOLt4psei49+MQRX9IXQpUHK?=
 =?us-ascii?Q?mMmRgkmImq02/VIRecctHvs1oQkKygGJJrEoWqKjcjnh2XKeX601/4nD16T3?=
 =?us-ascii?Q?40SP+9BfVXITtX/GWzHM079CgXAbUTnRPSNtDe2HNBPX14UZrpi+wEsZraZq?=
 =?us-ascii?Q?pCsi7KQDQRji999DlORisWdMGrbCdrdBted7eG6UlcJo5MD+YU0Gb4f/EQJp?=
 =?us-ascii?Q?9S7rp2ONbZd2bi/+P3tmOBvwpQ148cMpdCWl6jnPYlzjlfDa0v8MS0GFH1qG?=
 =?us-ascii?Q?jCUGf+oADG95E4tDm3dUUHcbPRnXouOwxa7GUv1bUF2WW2hx9kn5zFkVwfQX?=
 =?us-ascii?Q?GX5rjJEflb76mg77nvsRsysoE7sScSAgSgB0IMCIY1B4d0n/OmPSAoUjbEEM?=
 =?us-ascii?Q?rlGl78QCVoM2pq/o10DUsd1RwZRYVwuJqyEpGM13mEu/EYczACkHT8JYAvqG?=
 =?us-ascii?Q?T2tcb8hrSBJH53qd67AaW8532FaOuBJVOzb+VTBYZMyps7F/D3MyvgIIqTt0?=
 =?us-ascii?Q?DpPJImFtgW047bNDZdW6PjKfOmBnc+kn/e0DueCq9aaEg1hxtDlvqXr5y3Oh?=
 =?us-ascii?Q?rJgmoBByDkGvxSTGzAnyrgMtjepgxZO/YFv3J/s2NSyxPI4r+QP7Xaj90cDV?=
 =?us-ascii?Q?JTR6iUz0XEk/sgvQcxi/xDg6HDEU5rR590VztBZ5FBsUP0t6F+MisDog9YH0?=
 =?us-ascii?Q?KUljttAMhQUJW3PAIeV3WUL/ssTzhzMXyUReA9R3ADeJ2kFM4p8pnBHQ2Dhz?=
 =?us-ascii?Q?KBFtaLiB675QmLNYh5p9yTARAhEL5Tp/1qJ0IOdjx9LsNvsp8IdXZFuGTOVO?=
 =?us-ascii?Q?8u3c/Z1kfk+KbXBw1BtkihVL5Omn357YpbwvrCMcW+8H+akH+bZ2JC4wYwCH?=
 =?us-ascii?Q?/XH6yls/XJ6CbsXQYJNL46NqNOs43+jwXsGZT90BDnI6SUstJeyQGzQD5AG7?=
 =?us-ascii?Q?xJW89Y8/hWrLHgGFBg9JE1agpwyk9w4USLxl86T2Ldi9Abb3fvDprSLCNlPZ?=
 =?us-ascii?Q?QlVEL4TFuBJJxz/PubxhQC+2Uxo6U2Ch12V4X5Ty5Bz5keQ6R3RCC2HZj92P?=
 =?us-ascii?Q?9g5s4EL6gIRtC7WatJG6bGZ0d3whQWX7Mke0NrzCUIr2+918hrzmlpv0LTGp?=
 =?us-ascii?Q?JGKayUQ8TcPT51BDmVz8idAWyUiGc5b+sZAuzILfWR6gR96hI3807O8kQglK?=
 =?us-ascii?Q?heSsIc9VtxzX99PP5B4Dxg6rUcBcgeJnjgMQ21JxAHnz4GfDvePNSXyzXmC5?=
 =?us-ascii?Q?0Zt60hO7d9M+hy8Gb5jis8W+Zyraw5gjYyP63nC53UPaeG8gfYh93P0S3DoQ?=
 =?us-ascii?Q?/e391riTT/zcAGU9mZerAO8tnJZycExlS2NvGXxxg9ZqOVMnxsOK5ZUQJgNw?=
 =?us-ascii?Q?A90XEKF+1B6ILyjvSY8S1ynruAUM0wTdARr9uyR36cbGwQdCUvZIBO+qTPgH?=
 =?us-ascii?Q?DU8VMNInMxLM45ywElz98Cw/hz/uTCdOTY/qh4wc48TInTXI0WuTSOg0d6QM?=
 =?us-ascii?Q?yAZSxw/XdItB8GWrcrAl0OGbr7dZPk/6xHZRqP9rWFp2+5oGn+4rmmWGSL6r?=
 =?us-ascii?Q?wj4j+iug5mKMbhO4Y9WPmmVSBpznKaPPvK/ecUuk7lAu8e+G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OGPIpw76Q9wKFN9DJcJdrN4b3PgrrvYGet1BkD5sJx2NeHI6MUY/nj5ydipXPrTkFGL8pfcg8tK/eIppWd03/npm5YkM/7+x63Mt4xZoVKRWn46gFicI0om9yDFfo+c76OMH5uKwk8WW/g64SmwJgZxGkfp0VmLCi0MUu6e+BTDFq/Qe4KlA2GZFYG9TN2jskb5BJC76j0zoXXk+yyC6C8DDpc3hvKqQ7pAu5Xmr5NGsC5LCufyJ1pgRHBW5wlj4brXGnwkTM7LTw3zni2464/xTTZsHSGZdB/gzKeQaA0nqS1WQRiBxv0CprkHBkLG0u3xaPEaAq6VlOcMslqYp2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ca09fd-3c4c-4266-8758-08dea1cd9655
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:49:09.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TheqCPy63fTHpHxnWxnUsP/DnESgOpaCJ3Cq9rmAmJnyP1e9DhPEFYJBzVnV9d/GGtAstUW7DLsAkYNDJBPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, April 22, 2026 2:01 PM
>=20
> > Here we need more words to explain the strategy here.
> >
> > The comment says "When IOMMU is *enabled*...", but the code here
> > just checks the static capability. It's probably a design choice that y=
ou
> > don't want to add complexity on recycling DIDs when TDX connect
> > is actually enabled, but it's worth a note here.
>=20
> Yes, that's the rationale. I'll add it to comments.

btw halving the DID space permanently on any platforms supporting
TDX connect doesn't sound a good design. It may break usages which
already uses more than 50% of the DID space but have no business
to do with TDX connect.

It makes more sense to cut it down in-fly when tdx connect is initialized.
If the higher half DIDs have been used then fail TDX connect. otherwise
adjust the max domain id.

>=20
> >
> > btw in patch23 commit msg:
> >
> > "
> > There is no dedicated way to enumerate which IOMMU devices support
> > trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
> > devices and tell their trusted capability by the return value.
> > "
> >
> > which implies that ecap_tdxc() alone doesn't really report the capabili=
ty?
>=20
> Ah, good catch. Let me explain:
>=20
> ecap_tdxc does report the capability. This bit is special cause both
> trusted part & untrusted part access it.
>=20
> For IOMMU driver (which now handles the untrusted part), it can directly
> query to this bit and decide what to do.
>=20
> But for tdx-host driver which handles the trusted part, it shouldn't
> speculate into the IOMMU for capability enumeration. TDX Module has more
> concerns about trusted capability, including the related I/O stack

I guess "more concerns" means that there are more conditions for
TDX module to look at beyond ecap_tdxc(), so it's not appropriate
for tdx-host driver to check ecap alone.

> capabilities e.g. SPDM/IDE cap...  So in patch23 I actually mean we
> don't have an enumeration SEAMCALL for trusted capability, I will
> refactor that message:
>=20
>     There is no dedicated *SEAMCALL* to enumerate which IOMMU devices
> support
>     trusted operations...
>=20
> >
> > anyway all of those need a better explanation here...
