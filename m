Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0902E091B;
	Thu, 16 Jul 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218359; cv=fail; b=fMcVwnqZmI1kpbZe0vxBamd97NH5W8hUFNMKR786HXyGiVnRj5OixLfmXoTNIedS+mZ1NEKs4FKuQDDPmL8XdOOqCRmNpizQ0dR0a9AZm/0oUoP/7FwNTpzycYlnI8rPvMjTGyadifV2dfwGJEYfT1viJBGwYDE448nvcbwmz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218359; c=relaxed/simple;
	bh=0VUcLLKqvI5hTmvoQ+iL7Cd7OuF/jZWzs+ulPJIdlQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMyQYicNQk4mV14WaAZiZssRP3vqP28tyVsb4xoZjlFbbxNad35PQyimUY7VqtXQpIbcPR4fk1a4OnZCqdGv/1sgtcSwAZjJhV4UbZ3A+YaOq9YBH+9DFa/hzPGfORSVTmu1CvgfhXmnOxVGM9JNYp0TQNsdKGr9KXX1eiD9OrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqOwxQmt; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqOwxQmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784218353; x=1815754353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0VUcLLKqvI5hTmvoQ+iL7Cd7OuF/jZWzs+ulPJIdlQ8=;
  b=DqOwxQmt2qpzHt6y6ej+e9OKY/WjRZqNEde+f/W4H62Ax2Ap4psdu5Ut
   A3R2ZfZwk16cAP991VMwcYiEgAzGERqPpixnbURjrUgruT+ejeFhfhDPP
   D9heS3O6eCzKKXGi+jkWm8BmyuFlUdS7JO9sgoFK99VSq4QKXxgtz2rbJ
   eLjssaWlBFFo9C0dXE2KR98ufSVhQph4tgsfxNl1MZVHoSc0lipulc7Xr
   DzRYLdt/gm8XfT4Ud6o+Breo0LBYQ8C4DkpTBRfyuc3c+PXU+2LI1CBl2
   QuUxUMtN/jRIpWR7ntZwB9Llmp9PO73BuN2ZY6zQhQtJpCsFPkmfi8mki
   A==;
X-CSE-ConnectionGUID: PRsqof/1Q3+DunbQ+3CrFw==
X-CSE-MsgGUID: 8VexRlHDTRiSBj2DTBq7NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="72416599"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="72416599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 09:12:32 -0700
X-CSE-ConnectionGUID: QYQ4wENNSy+QGUmdz1QBQw==
X-CSE-MsgGUID: VxDtXJvzQf2dIp/FH6WlYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="252112291"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 09:12:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 09:12:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 09:12:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 09:12:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqOJF3rzVlcIozwEI0adieAmz91SODk20n8I5Aom8TVkwL7yQErkHHNx3zJsn0zRvueOTETmM2LldEktC1Li6WdZYYwkRyHGSNCVsFJ9TY0/k8g4rtTPuxXnkFXIWVi2bQPHEbhGJsy3lc9UDF8zUohULnAM3iLoS4p3otGrPWpGlpqxEiaj+rkVHZDZ8MOawfbsOTOxQXOIyV+ByGkCE5BD2C2Wj9Ob+DkrmsyBBAApCSArF7QbwBxPESzABYDQucXe6XJvciylZ60psibMZzbpNL93a0oSkqaMoz7ri0RXJg4OJfEkv/4jggcLPkZdhVZuxGC4tCc/Ohfg1sPPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VUcLLKqvI5hTmvoQ+iL7Cd7OuF/jZWzs+ulPJIdlQ8=;
 b=awqC5JoFei41MDGZMWi3HH/0jyJxu7KsRLpLLVcsd6RkIp1cA/+Xqzwld8sp0AMaae+j1eRPCuPW6u+/LamkHnxNt3QXq/kwgf6kqDXpwgdF7+lEsHI4czOUu20Rqhzef54yYq+TdVvhlfJbMEqgSRZRbJK/1khUWNeGGDAdhMcdqVp+XmbcJFfIzxmJ82X1m8i98JoYmIKYJXjQggfD+jiebSRzczauzJGyRFxVO3TnBSsVa5oN0zbDmw6oJOmLQLDaqWZ9+o6+3sgGjHio/+4q6ZiorguXfriyWsB5hQIeCvToic6ejekNk2Ce72UIHemX6KKJAnIYJ6W43u4JfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 16:12:21 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 16:12:21 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 2/2] idpf: implement pci
 error handlers
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 2/2] idpf: implement pci
 error handlers
Thread-Index: AQHdCObdb3dnfohhNUqHdGr/i8It8rZwaP0A
Date: Thu, 16 Jul 2026 16:12:20 +0000
Message-ID: <SJ1PR11MB62970F5BDCF78402EA8EDF9D9BC72@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260630231854.11536-1-emil.s.tantilov@intel.com>
 <20260630231854.11536-3-emil.s.tantilov@intel.com>
In-Reply-To: <20260630231854.11536-3-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ2PR11MB7647:EE_
x-ms-office365-filtering-correlation-id: 5eca9f8a-e185-45fa-89f6-08dee35503d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|4143699003|56012099006|11063799006|22082099003|10067099003|38070700021;
x-microsoft-antispam-message-info: djc430ZKn92IrlbtFyPxOTgMdjqUeOnkOQ5nIMk6VxD6it5ztu3KDkI0SoVs99jFVi/UbgIZirrGCPgF8PJxducFHUbvewszok2bx03uTYzra6Of7HW5YCy8maqcJkxtX42N8HNKNPA5pxwTvE6pxcoIb9DRGmUiHITzh6PQb4qv8s2CKukThwWS5sfsmNeDjxm3EDpdo86RQ0ccae5WWuo3FNSlDkMRKPd4iq0Fm8qiLm2+CryyGT9tDmYADelTIxh2cR44VYGbLtdtslX+LFCIGBVggAUybU+LxDMxPehIoDhYy1Ke0uJPXlutg2qkETHZ4sGw1KyG8biUlSY0dBD9rSIQ6+yyWg9t12E7Q0QX8ybXqdS15U5OfQ9BQiznXJYJlxtkYh9EM01QrK8+N1dW4aLhSDA5TZ9hicFIyeCBXa2ZYpc9gq5U0TL2rfg2Hl98JKLbkuDfjeXnHymUzXzOtKd3iNXVGIvTWszkGlX00rKPEYND3XqkZIy035dw0Fis6IQPci+KvzcjlbFhPq5PBJ4V2oj4akLBwkUhEW7OHgTnRVgC8tVs8Jh+vrsfs8+LGBFumQiMopq0y9Ry3W+d/BFMg0fmi5MEq3YRLmwHhPyHvfuzDMluEW7a5v8hVc0hJNKZI1qJYIiOhnvKxEUI8GYajwI0aaAQHz0DVhLF4LnooG46+TqjCyAG8etPL9q6qAIuZy23YaJwF4RCGpw4e3IpsTbVB3ZXLrBETuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZedGx4EBoOsThrAK0vzQNPcBKa7ur+9CTHj2CbVeQT+tux4c+3gvZ+183ZrE?=
 =?us-ascii?Q?Fu5zxHGwAzyhX7ZjKONtFUGqvisrmv3O9OE+RCKOXIqq7QZwi3GuybQr22dI?=
 =?us-ascii?Q?AH4fC7ZjLxf96WvQY0CX7wtX8mvab/nhIahsLVxLC2oBWiryAWYr4GH3LzCm?=
 =?us-ascii?Q?0QPiOuMr9FuhDamYn1gWvqLDC1s0WCDU9SIEnN6Ixq9nnyWJZ2cLTpnpg0Ef?=
 =?us-ascii?Q?RhA3KV41dVK51mDzJjnydgujPxiKIYj051+IlafwbXZaaox4t8eKMty9DIkX?=
 =?us-ascii?Q?QalFDznArZsQ/2UNdMM5MUhLagu93gyG5VeJ+PsVy3enZb1uKwuMQMiEDQot?=
 =?us-ascii?Q?ROxXqVUmL06z8+bwXW6zSOb9eiEHYcg8pwbNGVzP4SQcHMNtFicsLHHX1gxa?=
 =?us-ascii?Q?o6oqDvbgxgO0YVaM256r+cmMh8/YqnJQlTcnObXb5DLDgPsaZwr75WMSGCQ4?=
 =?us-ascii?Q?YsF/9aBambxYEV+mV/2vuZMH/S0w8ZIny0wicap+twqP5uV30D0FdwUxooGl?=
 =?us-ascii?Q?Mj4dWDetK3rQRTKIg3NdcbUR93IzlLO9rD6As4KxY2IQ+ue4F9gd4fMKTfSH?=
 =?us-ascii?Q?0zp25xiX71vELK/dfH1+XUO8i+WSq4f4cpvaWut2kHwqR2D04vv7iV+wVbDd?=
 =?us-ascii?Q?UlIHyA7ldnrHtT9MjcJTMHPx+H67ysfxVAijh72SyRmTEdjzPOwv5srEQ25u?=
 =?us-ascii?Q?aEvMr04vYl8tat6aDdyMWFMbIJ7+gS8IEedRdvMo4VITnJirG5zrA7wNP7wZ?=
 =?us-ascii?Q?yHgkhVxTkgMsqz0aX2ucCK/7Fh2NZc3LblwjbMVq2CO37xpzBthK78wnENX5?=
 =?us-ascii?Q?Z6WSljeM+UHofqzhVBdK3ms2YEimn0CJsgwIt0kF+Ba/uwvXkBMEhd58DMSq?=
 =?us-ascii?Q?79DAp6OeCbd01lyBPhy6K23wVrUUnMWQkdRArvawoH0qkt4VNwzA2yzpYg8b?=
 =?us-ascii?Q?BNAs9sXa4JcsLdn0Dv/vsqcm0lz4DoWvYJznXijEl5d9GjlnH+hUM31T6iHK?=
 =?us-ascii?Q?ZVhzOcX755KLNmwNEdHz9adp4FOT92PM42+uT4ygvXtXzCS2afaXCbMW7a5l?=
 =?us-ascii?Q?PCARR8/knHLWU0206/94aUAkxUIzi8aCH/NIjwpB/FTJWDW6Rwgxxisjpk9A?=
 =?us-ascii?Q?r6tYK5/u43az+mK3b/AD4z73eH3EQGFJK1HLCGs5yLFVpLr289ZftvzqvBI1?=
 =?us-ascii?Q?2IFmUdNFp76l15IYYLC71T4NejsUfpExh2KKvis2XTQvp3S9uR8fxlvp+bNa?=
 =?us-ascii?Q?rNmWo9iaFyv/b0RQzE2iODFStKJ/xWVb/Om/6MACvaOufeH5qePWH7jxLA2r?=
 =?us-ascii?Q?vfdH4477ARAb3oQe4SEXuFYSIzcv/XfdFtut0wHMtVy12dtHjUr9YDaAHiB7?=
 =?us-ascii?Q?aiAieuLNQzMC2rcI/MJFSNe2ufYwlVKT5hguo1EHnAqQeMwhiyrMITnNUjFO?=
 =?us-ascii?Q?GDCtfgKk0Lg9X1hVH91kDLhIxBtO6xAntRi7rEN46YAemi4ZXZMzroOBJVua?=
 =?us-ascii?Q?GR6I5CFBgYX+rXPd1mjnXIUG4AQZSImKowz68jWYHD6YSVlReECjTMYQkkgr?=
 =?us-ascii?Q?xkLHN3GcI9BiXaIvLiJtdLLSLo6N8qyxX7RjtL5Ay2300qjp2LBkk2ZMZY9T?=
 =?us-ascii?Q?cIQeRMKl6li9vIFOpJEzhptkUAsvDj/FTKo5YbqgpGCdHCo0vR5Mu6UbhetJ?=
 =?us-ascii?Q?FxFN5owz/VlLODKAoEhUqORQ2YsxUZUhx85yfavpRk4DO+SQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cF4agDFubStrn1STi9/bxcVwSr5dSCk0hKIiHrAak1GVXmJ62cLfKEnJ1ReQLX2p/wF3Sfw/UYk21zDUB3T+VwHMEZaQGuZ1DQRyiBijorzRNP/TkB/bLVAPF9y0CEw+gJ/8u+5PKri6xvg0Ydcz5MpwynpkQbsHCWbDNs77QhcKdO2giaPYnzqiv1qUn9fAC0smMQo/R5gGxzBy6iOO3PdkILWzZxWWUGGr0NH0ofRUHERUTVw6DAUm2jkeYYrMjGRwS97i2bl+LlToavIGmSKmNpZxzebmCjKcXgCWn0CqxnZZgLQMZ2W2qHGw+wfpy7ho5GwnzwLMUKBVPsqc5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca9f8a-e185-45fa-89f6-08dee35503d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 16:12:20.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQeHdXb855heJA5MyKR+Tyqt/lYrdfqKffaHELgSmR34OcPyCaaM3OD77EQfQxIdoahaWCmemnfrJpwrpA0R/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Tuesday, June 30, 2026 4:19 PM
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 2/2] idpf: implement pci er=
ror
> handlers
>=20
> Add callbacks to handle PCI errors and FLR reset. When preparing to handl=
e
> reset on the bus, the driver must stop all operations that can lead to MM=
IO
> access in order to prevent HW errors. To accomplish this, introduce helpe=
r
> idpf_reset_prepare() that gets called prior to FLR or when PCI error is
> detected. Upon resume the recovery is done through the existing reset pat=
h
> by starting the event task.
>=20
> The following callbacks are implemented:
> .reset_prepare runs the first portion of the generic reset path leading u=
p to the
> part where we wait for the reset to complete.
> .reset_done/resume runs the recovery part of the reset handling.
> .error_detected is the callback dealing with PCI errors, similar to the p=
repare
> call, we stop all operations, prior to attempting a recovery.
> .slot_reset is the callback attempting to restore the device, provided a =
PCI reset
> was initiated due to an error on the bus.
>=20
> Whereas previously the init logic guaranteed netdevs during reset, the
> addition of idpf_detach_and_close() to the PCI callbacks flow makes it po=
ssible
> for the function to be called without netdevs. Add check to avoid NULL po=
inter
> dereference in that case.
>=20
> Co-developed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Jay Bhat <jay.bhat@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> 2.37.3

Tested-by: Samuel Salin <Samuel.salin@intel.com>

