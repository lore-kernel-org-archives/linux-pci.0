Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AD2472B6;
	Tue, 14 Apr 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164952; cv=fail; b=gn5IGbsX0oZxHQgf2BxpYtZ8t7DonKD2l9KQyyqbAjJuqnNQtokBBCjUyZA4trDn0hhG/tLbyvfzO47ZEHwftoSN5Kh6uppFpUcCT6Yw8f+tch6MKHMxL62rkpG6FhWT3NfXUqojhuCZ50iC0ggqxpcXEYZmPJe3HGdlOgokXJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164952; c=relaxed/simple;
	bh=ISE2+5eowPdsss7hRKR/xtzkZvbux11lSHcgQzp6fFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cei+D9mEGssVM7822cY33Oo+0oZgEYXTSn1VSwjmoIhppceBGCMgAoe2ZLuEUq60Y5pKmPEeh9H701lWJc/0P3Rhw+ZXLeU5ezUXl4Mz9/ZLYXiFZyQ1h2zW6bYBafeEH7wSHQ5roPeVZVoN5yJt8/i4iqqFtwG+7u2pPNJ5ZGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT0BNrAt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT0BNrAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776164951; x=1807700951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ISE2+5eowPdsss7hRKR/xtzkZvbux11lSHcgQzp6fFY=;
  b=dT0BNrAtdct520/e68XyjNlORjb1TUugmqDfy1lUFNkF8E2DYZ0O19XX
   R2IEoW8Qk6NIcpmbcLvS0PSuihHfuYEYUA6l05KKlyEfbfTho+EhJOyb3
   gfGPYEXN8G5DhT3v/JTgrdRVpWbrMwNtxOgO2uhSF8sLePk3BOHIs9TzI
   N0gFizkBEpL3WFVgnMWoyP+xtoGkpDQkc1HSVFgHiqq8NOp/8carkHs/b
   Z6RsewW9e/Zo+BhHQFudzCGVeNqB+sl3bOrEmbybSVuq4eOtb4R60/4fD
   oooQwxSkumy52IlnzJzamvgxPYmhhJVRTT9zLDO517wLPlgKt+l7mMksk
   Q==;
X-CSE-ConnectionGUID: TjZTWNSxSBah9nqKn8MLzA==
X-CSE-MsgGUID: mvBdKDoUTjGL3E9SGM0AkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76151100"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76151100"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:09:10 -0700
X-CSE-ConnectionGUID: K9hDugYLSuCoZDLBJVLsjw==
X-CSE-MsgGUID: r6oJsEdKRMuHJ2w1Lhvjkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234997356"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:09:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:09:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:09:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbakXGplvnOdNCkhNRogw7TNKkbH/X43iSBfswGs040M8+4oHYzKw8Nh0zex7AIeeOt+2/aRFJMK8iJbsg4Z/zcXsQF1/XmSVjZ0GBMc0YgE5mTqAwrhVVDerEM3nFHx9Vj7RJsRQTEOxCU3COrkFcRYmv1PY2faA1ZYl3sVZAw8AupRRq2rvGRWRqDwejSmNkYE7IGSUlXPnadpO/Dxw6YLfyzKYwNeMKKV4UjV666BpkwtM6cZzCZzXxJW91wMwUT0vN50pO/2nf4GqsUdD3Qh6Yse3uciPUgm8MWtgZIgwbfgXtSrXgcRxT3nX7C/ITohTqrW5Y2gBSsvLSZ7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQCpUU4Yj0UoxxGnLjWEAmvS5OgQJY5M0GYomfgoK68=;
 b=n2e8lGxHvcpzZRoGukC3IUfXYoBU0CVuYZv91EFJfJ1urR0abvxE6kxkPVNZswVgBQ2esl/zprup16wMdS8S6o7sh/id7RBcZsNvWo0TboQqvST1vtnDAQC7gPKQy8fCa41+H1OsZWwstJSi+JKhmucqrMQfh9YTE5+ZEG3TWnOWrwIi7DjirXvAYu4iPsFAKVA6Kpavl8R/oioDfhGP3FxL57DZm8Cac8VI5tMsaavaDi/FvJPm+waoKo5+XWUktfl2qSzxO/Oy5idorDKffN3MQEmXKUCeKsvPqjahOuetVDPv3tBTEfe/7aRMmtLzsIM/fCaNUsmfhKQ8WPY3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 11:09:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 14 Apr 2026
 11:09:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Bhat, Jay" <jay.bhat@intel.com>, "Barrera,
 Ivan D" <ivan.d.barrera@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "decot@google.com" <decot@google.com>,
	"willemb@google.com" <willemb@google.com>, "sheenamo@google.com"
	<sheenamo@google.com>, "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
Thread-Topic: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
Thread-Index: AQHcy70clylJ6BBLYkyAicYeVjavabXeZlxg
Date: Tue, 14 Apr 2026 11:09:05 +0000
Message-ID: <IA3PR11MB8986C6EC840268F14C44B28CE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-3-emil.s.tantilov@intel.com>
In-Reply-To: <20260414031631.2107-3-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB8123:EE_
x-ms-office365-filtering-correlation-id: 7fe1638d-c3f6-4ee5-957b-08de9a163e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18096099003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 0wX77jYnKHziedv90cKNJFrHcUV20VdQ0qp9jMWnVzB/RV+DKrbEWAxtDDWpVRAJrn1FylMORFAGsv5TW7HRTeeKmwvH2sNeSpKKQ+LjbVtarXEzh7BiJt/l7+jxXd/wnR2fbPIh3QJuiSmAEjdFJyuIwxX18FMPZ73Wr9SGkQf7pmah6z5IMkxt4HLe2z2fSs9m9ttU1U7wg9Z5Uyv1mwDTsUP3yK+atVsLnfzzj8vyqqPZu3cx7GsyI4mFUvIdgd+uzWouDJuYDdE31rAQcIlIXAh9zFd/9SldpDlZn4484XXCA+tGRTiLYTnGoNyaTNb60u6kic3lIq8PUjax6DJbwLdJv1DAySIregKTCwE6+wvcEFFxjgmDCj3XapuCZ6OKn9mofBE+SVANJGDvf6WOdllrDjxtYlZPjGZ7g42mxiVE4HP7laFI6KX7RW+m2SshBjpgxMK+EvJmXgkZEyEPghXOmXTf3jvGjwUy9BYzWgzkNathL9OkDIfq9VlYTGZPOlPKFH+wrXYkmQccPsuZQ0Ujlo2G/6+fby2wCVWWjYwzz4G7yAfJVhYNRwNdpp1nrW0AloaojdCimWEesZR0Myi08ez0yARhVxOdADQCVDIm7QYzR+MPx8lxgWTqK8UcWGbzYFTztZjOn5+d/FJakxlRyfV0/zdC2ywGNpVe4TsYSNp9dS2Hk2Qqt/huUOllbZiI1nPFVAxJJCUd22DIumI5QvktYHNmqp1d6HKACKgLagz+xamaBTASyCil0r1S6qFUPpGsFJ6G5ml3go24PfHa34zDIOWzhiFPgnI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18096099003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j73izR0R0cLdj8wZb/k2W2l+uZQp2QLGbn7W+e4KV7PZ+OPf1jkXsSLZjK+K?=
 =?us-ascii?Q?RM0g0lt8/rtvCi21FkKJqfG4NcBaEJCUub7fLyZ26m86X67pbqbtPCkKUKMD?=
 =?us-ascii?Q?Zse8k97yFPrqhmaTNuIfjcYhlEjE+k53PtAmd5eP1JXj6Wq2o9opF2oucLOU?=
 =?us-ascii?Q?s6Jjn7Mm5HA0niH1D4asCw7Ii7rrb9GvCQZd3d9stWlwaa3wK3c6Eh4Amgl+?=
 =?us-ascii?Q?0o8ki1+ZIZ0d7mRK/A9sBxxQZSMHGRRVelHG76GodLWxTElokOes32vtk50j?=
 =?us-ascii?Q?Yn1CQwqedGK/LdCPeTn2IJwfTOF3fzNDesp+UkcYYCHfGXs0+j2pz5IIAqdv?=
 =?us-ascii?Q?1Ix6SLCtQMD2X/V/IkAJVYygSwSSjByP+9hhOxwCxaNF+AKTIF1opDyGvZp9?=
 =?us-ascii?Q?EDc52UmQzGlERLdYvNrWuN3N3iM96HoNxI2Az3hcT7ammGIBbyINzVH5cGUk?=
 =?us-ascii?Q?7WzF0VuGmfJnCSID6DHVqyqHTvr62BsYM5AxELL7Dvrxf/rVF+etk7MT5kwi?=
 =?us-ascii?Q?6TIXPXZ+9vVz+cqb7/cOk5AqkrqRigae/mHzHKlobXL8oA5gWdBgMxXNV4wY?=
 =?us-ascii?Q?MI8MH86iT1IjDnWPvdfbU1ohLWfeGzAWvhjhrBtnsxm2owsvo3BnYybQcPK9?=
 =?us-ascii?Q?3V1ZoNNZovb2+coIEmxDnmEg6hSSmKW5U4CgKjJsRdQ4tlPjndcEh5MFJv2L?=
 =?us-ascii?Q?r4EEnFnH5X4OFwKa7mgsciusN+UAaPNiimhcZkv1ZM/F2dtYlw/FA9B9vb3N?=
 =?us-ascii?Q?3g2A3alF9WMctDVQ5HuKjZyjdNzqUs3WseZ+q8ys+SpyMuCYjZ7uYINCWzJw?=
 =?us-ascii?Q?nw3di6fbC4kSO+47hYACNZ7YBKbG5RX/K5U09BwOivGJhnVyXgsXDl5qDoU9?=
 =?us-ascii?Q?hFiqe9NBTO3EeJwM/rQAd802JvP0I9BqPDIqzWg7PrDDqV0hcEKnByn6lqZE?=
 =?us-ascii?Q?IeD+q7tcsxxB7xDNW+BeueEQEF+0RICMdn4VxbuAo4yO7nKgGUTO5+bDXm7M?=
 =?us-ascii?Q?FHtiLmjJbHZk+HlhBBMl054KKeq7cpIp/TKIIY4e/wFvpFKI1k/YYP5veMPY?=
 =?us-ascii?Q?2sdpZGIvRDKjyxbDEemkjZJu7yAnTim7lR0sFFXWVrOqbS9UyZRqXq6oVbmA?=
 =?us-ascii?Q?HCwrNEf4LYZ6FLxLbrYfqVnjG7tijOND9k7FYAw1bWaJA2umVEXNnfUOGFGX?=
 =?us-ascii?Q?HTAGJ3LoXgAdRiqt7MJcg0/lZ59AqORTyy9HTA/1b0WWPJwwbwHHn+LwPkxB?=
 =?us-ascii?Q?MmMHeaijzwU+BHhaZRgxK0Q0OKPkAJ9dlyfnqKtZv02itCtL2DLLGWvy3iaH?=
 =?us-ascii?Q?47Gdc6+MfarIdWanG0nQWVZrtLYp2ZJRCtD3miaPOkjybYFAzvPw1YzjfFkW?=
 =?us-ascii?Q?k+1I7ei6ABBjKdEkgtVU3R/qdUy/yah7Ik/9j7XHBI8sle3Lhlhcw9jbfDHc?=
 =?us-ascii?Q?rgqdStFnB6pQmWJ573YGjDx/gorh9Id23eJUi+h1W7T7usbQtxLS0/TaUydz?=
 =?us-ascii?Q?Us0ZjSSjjwkU6+Qc3s1zO9xQJSNtOT179Qtwt0x+VU6gitAhoV5q5Ogcl3EW?=
 =?us-ascii?Q?gmqM/lKcusmq6sMQflsfUy0LsiUrLz78kFGQdSbKECBWyOXSzy6kZhQxKIpx?=
 =?us-ascii?Q?uDapBCVP9SVW1OWYOWoQxuDT1zk8YrH/eAwDee86b3ffAaGRK2mzHEeir17h?=
 =?us-ascii?Q?lIjeBM8zgiwBHjdr/Yxr7n9dxq+Bpplzik7OJBLprN0sw8/jG2g7Hujr8t0f?=
 =?us-ascii?Q?XLq8f3pGSR4Eaol2cH/gEBeUfcQ0qsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W/O1birO3ltyvieHbUIwjwte42v+JNdRsY5Ao17Tt/rmb2ST0UVu+4dXToUcQRkhtrMeAaD523I16doKa2Y84PSLsoIQEp1/I1164tsrOpxbAkitIoceaytORQmHe5yMH7pnj5YhFhMefbtnB9ipykak+aTVG2paTm6W6hxN1/+8Q82LBKwxiWMimh/y10PyL4tYFVc9qivBPo1/OBqy72kKK4ORBEwOv7wyYlTrj71qjC4Ie9V0MXCnK82iWQ3wXal/1jzVIwoB6F8cocJEtOmCWNR0kEUp7gdpYiLf3z3yWQ4u4gyK4/Q354EaOHr7IEjO/6dIxHKE9Zz9vYllaw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe1638d-c3f6-4ee5-957b-08de9a163e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:09:05.6525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: as5qwu2xerxpJvG2hZX1C28HfUP6X0kyFe4qESo+WDo1NWOiP/rqE5dNfO4/E1Y4ILfGZZKB3YBMgJNkPDuER2HFycRnYRid4ZGTX+xf7jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Sent: Tuesday, April 14, 2026 5:17 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Bhat, Jay <jay.bhat@intel.com>;
> Barrera, Ivan D <ivan.d.barrera@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> linux-pci@vger.kernel.org; Chittim, Madhu <madhu.chittim@intel.com>;
> decot@google.com; willemb@google.com; sheenamo@google.com;
> lukas@wunner.de
> Subject: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
>=20
> Add callbacks to handle PCI errors and FLR reset. When preparing to
> handle reset on the bus, the driver must stop all operations that can
> lead to MMIO access in order to prevent HW errors. To accomplish this
> introduce helper
> idpf_reset_prepare() that gets called prior to FLR or when PCI error
> is detected. Upon resume the recovery is done through the existing
> reset path by starting the event task.
>=20
> The following callbacks are implemented:
> .reset_prepare runs the first portion of the generic reset path
> leading up to the part where we wait for the reset to complete.
> .reset_done/resume runs the recovery part of the reset handling.
> .error_detected is the callback dealing with PCI errors, similar to
> the prepare call, we stop all operations, prior to attempting a
> recovery.
> .slot_reset is the callback attempting to restore the device, provided
> a PCI reset was initiated by the AER driver.
>=20
> Whereas previously the init logic guaranteed netdevs during reset, the
> addition of idpf_detach_and_close() to the PCI callbacks flow makes it
> possible for the function to be called without netdevs. Add check to
> avoid NULL pointer dereference in that case.
>=20
> Co-developed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Jay Bhat <jay.bhat@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h      |   3 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |  13 ++-
> drivers/net/ethernet/intel/idpf/idpf_main.c | 112 ++++++++++++++++++++
>  3 files changed, 126 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 1d0e32e47e87..164d2f3e233a 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -88,6 +88,7 @@ enum idpf_state {
>   * @IDPF_REMOVE_IN_PROG: Driver remove in progress
>   * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
>   * @IDPF_VC_CORE_INIT: virtchnl core has been init
> + * @IDPF_PCI_CB_RESET: Reset via the PCI callbacks
>   * @IDPF_FLAGS_NBITS: Must be last
>   */
>  enum idpf_flags {
> @@ -97,6 +98,7 @@ enum idpf_flags {
>  	IDPF_REMOVE_IN_PROG,
>  	IDPF_MB_INTR_MODE,
>  	IDPF_VC_CORE_INIT,

...

> +/**
> + * idpf_pci_err_resume - Resume operations after PCI error recovery
> + * @pdev: PCI device struct
> + */
> +static void idpf_pci_err_resume(struct pci_dev *pdev) {
> +	struct idpf_adapter *adapter =3D pci_get_drvdata(pdev);
> +
> +	/* Force a PFR when resuming from PCI error. */
> +	if (test_and_set_bit(IDPF_PCI_CB_RESET, adapter->flags))
> +		adapter->dev_ops.reg_ops.trigger_reset(adapter,
> IDPF_HR_FUNC_RESET);
You say "Force a PFR", but PFR is only triggered on the AER path, not on th=
e FLR path.

Everything else looks fine
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> +
> +	queue_delayed_work(adapter->vc_event_wq,
> +			   &adapter->vc_event_task,
> +			   msecs_to_jiffies(300));
> +}

...

>  };
>  module_pci_driver(idpf_driver);
> --
> 2.37.3

