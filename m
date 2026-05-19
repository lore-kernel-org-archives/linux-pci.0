Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE33546D0;
	Tue, 19 May 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206084; cv=fail; b=IOO3Y4y0vi56fDIV7l4y+IsouwdkqNhAZjjCYiIbjV+OCgN/rs9Pt68eW/PjitUv25J6Ubiej/kVdRneLWR5scyNpyFxpjFmbV85LPZw9W9yAhFaB3IWQ8Ntj4yjIoxVya8BB2/Ak9YUubZI6lLM5ZxA08GMBpQy0F3FANTnEEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206084; c=relaxed/simple;
	bh=iBJppzXQf9/oE2Xn7GtrHtqOCkz5dA8dNJHB7saFxk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sy5kTEIoWDEvVWdZxikPMOp0C98DtDRnz+sxTjGu9k8OXjsd7lPSn8fBcwkps1a6rRgDgPH+Ma5QfhU3+drASVBe5JnZ3BmDEo/VCEdeM1Af07PJPYMPOL45Jj5FEtKwSLI3xeBgcurVdVsrd8Q/rTOX751ZYw0Hyiv1CqFDc7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MedfUbOX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MedfUbOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779206083; x=1810742083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iBJppzXQf9/oE2Xn7GtrHtqOCkz5dA8dNJHB7saFxk4=;
  b=MedfUbOXFDO8IhQGPOQIm2/6uDw9forZKZU5cdHAyn9x2Lwt8cB17KmV
   cQOOajmtXnvOb4Rd0wPIzstPwsPX2Bn/TEGvLtO3G1c3Nz8LJMeIypBJP
   Ym6Q3lN0Ge5j09PDcbd/MoWkVuoGgiaUgA5DvtiQAgBSgsvHfps3lyqIM
   1xRCriKgU3WDXlkwWIL35KKCnCduS08Ywc2Fid5ZozNFWuI8qxyaKEsyq
   AfjmQEd4hxmXnarJt5NPWOOl76czOTKOHxuUw7D6dair92EEXJ+Rv2rPM
   BBULY7UvR1G9iZ0GdomiD8x4TAOlLsgWBkhVktqR+F/0eBFAMuDB5iUE5
   Q==;
X-CSE-ConnectionGUID: xLCFH9FpRamANDlXBnVdMQ==
X-CSE-MsgGUID: zwAhEIoPRRSctKW4LJEKQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90667473"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90667473"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:54:42 -0700
X-CSE-ConnectionGUID: At3YG6ZzT/CUHPK2DOWQOg==
X-CSE-MsgGUID: Gul1fVctRpOgRiRDh1ilXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="238811829"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:54:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:54:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 08:54:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORzwJ5yox/9UflexhJvcDARx6mkffUwxyO9JAQnWy0efu5w3erTqkgQfQeFicqeWOkbzzy2hYCTG0Vpk79kQLFkEtx6kWdjW1uNjPoO1XOpE9PgblTca0t30sm4h8TppelbvAprKtjoFt7TWYA278E4r7rAYBvW2AUrRv8X01dVx+9QrxQ8lO75+PeJVvf0ZOO4wk8qnz1ZsOmtlakaKkylDQ9AbLJBW65R2kICFvNeWCUW21q3wlatESzoU2hBiN1HwzWIdCeTFWG47l8P3oAh/EqqwHeib4xqw0d6hR+pFe+52lbmh4tnblNO/Ofu6kZP3ZmORQZYYXhf9qubeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBJppzXQf9/oE2Xn7GtrHtqOCkz5dA8dNJHB7saFxk4=;
 b=Po+dB1JGOzvkpeKb+DWx+jClEdpD5gROz3YHuE+PAKBFjB7rDbehQ2uzrU7mgPvqUfxVpIJNKySO9OJctc5wjyR66Sj5v4fROTf/qpisp2XoNoB5pwQfQvf0/0aEPMWE26zul0N0iISuMeP1o5tHyvzBYtVC5eXINQn0qnD9sPCvQqOH3KIIbS5bkpPO36DgTZsT6A9k8xg37JAAPrphoq/df7eiGDT0AxvATvKhKHgnCospE7CLDkpmjXaRxDphbXWhHc1wJRJKlT5QbO6YUbqwpkGIFb4eKNd35AOykYT5c141X7x+mRCdRWVMe21R+9w8foeryZU60q/mr/hpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ5PPF04AA7285F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::806) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 15:54:36 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%5]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 15:54:36 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Bhat, Jay" <jay.bhat@intel.com>, "Barrera,
 Ivan D" <ivan.d.barrera@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "decot@google.com" <decot@google.com>,
	"willemb@google.com" <willemb@google.com>, "sheenamo@google.com"
	<sheenamo@google.com>, "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/2] idpf: remove conditonal
 MBX deinit from idpf_vc_core_deinit()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/2] idpf: remove
 conditonal MBX deinit from idpf_vc_core_deinit()
Thread-Index: AQHcy70ggLGwa3y8vUGkes7bb4oehbYVt38w
Date: Tue, 19 May 2026 15:54:36 +0000
Message-ID: <SJ1PR11MB6297BE1148BA0C71DE418E069B002@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-2-emil.s.tantilov@intel.com>
In-Reply-To: <20260414031631.2107-2-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ5PPF04AA7285F:EE_
x-ms-office365-filtering-correlation-id: 42142930-dfaa-4564-ab25-08deb5beed36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003|4143699003|11063799006;
x-microsoft-antispam-message-info: 3+uBLY0MQ5W7XYR4TkIFXDeSFgreESOy3al10CBa0JHJ3+imIUXJwlg/ZMLQ+ut7Ssuho1YBDLjrU3Y95XBq3ykqyxvuyKa0LNDToqgdpUYSTw0ozLFqUkxJjuZ2y615AI/6AzGz2LUx4oEWwq2MIhahPNO9MvMXWkI25WV97dfgSclz40tUsubqNfEwI6jOPvhMKkYu4rGg+Tz2AcPq+AQYyfICAYrZIjZ8vYqfYz153sg4WdKORH8EusmEpVBRXTGhftC8mK9puYKcoJQw2zp+TYOvBMjhAf17M26/D2eb16e8Btc+DeojCmrOpKxmyOu1Tx1qfSZa/TyrnMJoinNdCHnsWxu710BM9Hwp4qUikwjjvMrZYCEKRi+XG+fzNHus6RxpmCu2HePuoOKvLM225LzT7Sq3QoPqx/0RGOfsG7DDVzNZh8thm3u9ARSXuFkOhf1knHGAvwTqwpEdOTr1wkhrN0iOo8ne1YZyi6yg7fHIzJR2JJJKXWVSmgIgXeaSNQuMa/xBf+Fxj7tnW3wXgjxmVJLVXe77XoM9Ivk2zb7dmFMMaxnDpyvWD4FMG33inygUvz2o41numdgV2Nq06hpJDBT+MY8YSInp8PySyJaGqUYtod3HHpu21ra/lWuARB4O1GZ6URJT+EI5eYNNexRLwKb3P+M7MiOm0EFdQwzPkaHcDKKWiwcbNOHtiQPTPuu9ST0CW5MZYOi/gQlW8X3eTU3wzzHMZaBZaBFWlTgwlqr/LNWWcKaEbQcV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xdHjou4yrx1wA8rzVNtdUWGahDw21LMsRUMmYx/5mIxJLVHvi0VY4TEZS1jF?=
 =?us-ascii?Q?PEfTr9sUAI9AIIlfpBff099x6kw7rdH2WsBpMpxmkL+rhA9SRxHPH1URZjhR?=
 =?us-ascii?Q?zdksYPs9cHzU/bYeiKLQNpH7J4Mupt44xK44PC/0Cybn1SfCyCu1xdt93MLm?=
 =?us-ascii?Q?Ww0myD445YasnGAMqaHvyBVj0ogqVS/HTQW+Fz2xQxbz6YSZHZQfaZrDA9vq?=
 =?us-ascii?Q?x7TGDnsOJYizQD+Wvhyp62An7WPc26aqtBl36016rqjQzmHpPXdyGLFr9diT?=
 =?us-ascii?Q?hEct7lLy+vkMVhnT5LMK+6AFXx6ELOMlQuWEurnJ3UqoAfilt5dMe3yoFqBN?=
 =?us-ascii?Q?kdvYCle0yLwju33fnULEVKsjqjjJPz9TsHTW352/ZdPhlYkfAe2qqyhaVWFB?=
 =?us-ascii?Q?jX+lCC+RpoAxwUw9mnPAhV89YvWFIifiIms82nKymAD6rIKTchCj3NHTaLQn?=
 =?us-ascii?Q?C9k7JM3wBTcBbQawwpZh8fmyNPcD5awE5Irtbp3wFDiKrECAz3jMiAkd54wO?=
 =?us-ascii?Q?T9xMfxYF6vz4CReF+lDVSlMGBe0SrAaK/Jdu8lDOWTKZ0gwkb+i0fW2CErg4?=
 =?us-ascii?Q?pKYRJUh+09I1uQMrBtTlTziw2D/LxSo4AsKNniiAaAEq3j0lyMSVynHnAeqt?=
 =?us-ascii?Q?/JMGfhLcnUrESPEWAVgJr74WoCRXsQW17aPGpXW9p0eBSwI+BMo94Lvj2jZd?=
 =?us-ascii?Q?xMtX/GMlUPweFTSgok+9m+/cJqhKjtx6a7oyhgvS16yRgq+d3mJDcqxZL0Fr?=
 =?us-ascii?Q?p8vJmo8YDQrjMMaVET6i/mhFDdKmLnAtkCi+8DapsR3YkZi/Wkv8jxiCezRY?=
 =?us-ascii?Q?hprR5gmDAKwPudwoFl9rDfIX6kIS+SAKMJguruurgO0tHo+Yshha0nW5B3tO?=
 =?us-ascii?Q?tIU/0GimJT14qc3LIlOOcMYe3quwXvfMHMOtun6VhC8mgcf7lb3rcsQI4qkA?=
 =?us-ascii?Q?PRc4/tgOtz1jGy2M/2zYzVfZL4C2OnKh6Pyp6n3+a03kOiUyFliH5ShL75Gf?=
 =?us-ascii?Q?THn4WzpKdg7e83F0bpHpHcvk3IDxldoQMnX+HZm7NFLOE3r/A8AZ7KZHv72G?=
 =?us-ascii?Q?CYDBr9RLEv2SMIwYrUNAhm7Q8AkBXFYrmzBFgSv0q7J1C42s1tdT9oTaKE1e?=
 =?us-ascii?Q?NjoCiJ71V2mf9LZmRhK6mOovPNY4VDMvmBvAEvopT8eAhmgt55nCdbQ63VF1?=
 =?us-ascii?Q?muRKkn3tiHDpED2D7nqRWAR/IrZRBkxmzm5zRphpk37dXC9xHlcGJOYhEWW0?=
 =?us-ascii?Q?HWqPQAfbX+LPffFstkLcIlTLYjG+8EgHuLJS4ZdkfAzBSfU80eXnPD96eRcM?=
 =?us-ascii?Q?KU461S59nqRbWgXrDMnsQqmA+LqkTDKcSe5GaIU2NNW2eN6AxJ5gSERsTTgP?=
 =?us-ascii?Q?0CF+Ak9tP/nK8eXspfBi4aCIgF3kUr6AKxWG0HfxUh6slkcgcWP9vZjBY9a5?=
 =?us-ascii?Q?jrr3Vw9kfPLjH2higGywA5wsqGeVKaZ68RHc8cfTpPN0Xp+nCyc8X8SDClFm?=
 =?us-ascii?Q?1m6a/cbjtNAQu/BiE7wsKF/11BFGQ3F+xfd/lAyA2t3QWHyAhPG/xf5YJq+b?=
 =?us-ascii?Q?xR3WuF35Nj3iGRLG9xFCQpkkYyLJiVjkQOfP8+fY+UQQWvd2ikDRgRAKAvpC?=
 =?us-ascii?Q?9oZdLdNzrQyN1/QD/xvAzjygZyh+DeZXDotzUxBVxpf8PF3OB5qwC9Xab+kJ?=
 =?us-ascii?Q?rek7pecWv9GEcWPdORJ0vM2VF9MZqLIOgZuxTJ0OujUjxr4p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: INmi6aGpeYC5w9kr284kpreqcx+VusE40j/gJwrA8sfYzw1kCCgZ/qwjAl83R816F2hSRguOYRxrhyOk3okaueuqjnD4sxPeJs0eKSCcKeLOfG7Rvt+hJRlCvDr8AViXnXyG4BXkYd8evMu0g5rRwZ2yLExJS2qgBZnZbOgcpql/fK0S/6F2yompbOGB1Xa4J4t4dPP9Efp7FRhE+Te2jBVu5Jo3PfpCp6Py0i5z+b1Wnzn/I5hPD+Aat1sBf8bPkHUKwQtNnclz8ufdqtgmnjBxcQAfMeJ9+EhUSo8GHqQgskZJVrHw2qZ9V/oM21B+D12gftnhMMF6oYz67oB2FA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42142930-dfaa-4564-ab25-08deb5beed36
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 15:54:36.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcZowIx2TgPOXIH+0ifI8NHDuIpK9OBBH9xUIuKkk6j/ICSK6f0cEQSAiLToJ+18kjtnmSHrmyt1tQ9zO5IiIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04AA7285F
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Monday, April 13, 2026 8:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Bhat, Jay <jay.bhat@intel.com>; Barrera,
> Ivan D <ivan.d.barrera@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> linux-pci@vger.kernel.org; Chittim, Madhu <madhu.chittim@intel.com>;
> decot@google.com; willemb@google.com; sheenamo@google.com;
> lukas@wunner.de
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/2] idpf: remove conditona=
l
> MBX deinit from idpf_vc_core_deinit()
>=20
> Previously it was assumed that idpf_vc_core_deinit() is always being call=
ed
> during reset handling, with remove being an exception. Ideally the driver
> needs to communicate the changes to FW in all instances where the MBX is
> not already disabled. Remove the remove_in_prog check from
> idpf_vc_core_deinit() as the MBX was already disabled while handling the
> reset via libie_ctlq_xn_shutdown() by the service task. This is also need=
ed by
> the following patch, introducing PCI callbacks support.
>=20
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Jay Bhat <jay.bhat@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> ---
> 2.37.3

Tested-by: Samuel Salin <Samuel.salin@intel.com>
