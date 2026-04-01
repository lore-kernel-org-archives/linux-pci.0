Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D51361DCA;
	Wed,  1 Apr 2026 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086987; cv=fail; b=ABT1UofdowmjZEl/IYRF83PRc26dQ6T/Sdp8+fT2KQrrUPKv9C7Utl6y6ncS+q5Q134T/NOMRDPo8KUSiGX/LL/3Wagf4hIXLhIZeIf4JevTllt2tNUCVf0Or5Ot67sJu9j+T0noLTHTQfnF4GiCRPKvpX9YZ/OW5Hrfo0KmxLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086987; c=relaxed/simple;
	bh=LFoncDVsE37a53u5tI/38sf5tb9u5eGJmRfWkZziGeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jg1nc2f8C/uaohyfxau5dkWsuXTMd6pY43uhdFDvYsFEbbBT1EJhKV+cI2R0obyaa+PEDmGDZC/XmCMysZzFLLz9bFGGsJs0UzJzSPOLVdW7tyeFgHBhnN0yWLQZUuDz9vl6rfMRYnl/NmTyMZbE0zhN/yaOLUEhOn+/aw5VP1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhTz7+lP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhTz7+lP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775086984; x=1806622984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LFoncDVsE37a53u5tI/38sf5tb9u5eGJmRfWkZziGeM=;
  b=PhTz7+lP+uB5QGAKcPfKYW2SA5vsVOfwG9Fyj94iA03DELGNpI8HSEx+
   DyR/7yNufIjiSz6p/dzh9QzUFhSCKpVdxJIh8yRJrEPgyN/TEYckvH6e5
   /feKOBePZZHtigCVl4TeTZ3zbVumtBwqbXz8AeboT1knDka9YpktaSGdj
   /d27A4BNcT2hojZm5qThcUYZhkWzKW3zUvDBakDwFEjP1Cc7YWseFTIrG
   97mygYGicvXU9gZDfNY/pn/dwPFa3jKi60eo+0+dTSDko00Rzldcdkn0+
   9Uh2C+kobSoTfaIM/q0tcZzi3/2rCivGm9FyZZjHWOAyC2CsB2RCyZo5u
   A==;
X-CSE-ConnectionGUID: 1xmtema5TGyxZDfBXjCwBA==
X-CSE-MsgGUID: jp0UTw8vTY+FVVrKZuoSBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="86443308"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86443308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:43:03 -0700
X-CSE-ConnectionGUID: Eqg8stUqRrq2fME2zwUnHg==
X-CSE-MsgGUID: A1qRS5GgRDaFmTnpJnwQcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="222455328"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:43:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:43:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 16:43:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu4CbMY4IiL4rMZUbMTWnQV08YcBb5xqsS55kPeh7J1/ohw99xAdS7srfuuMLCKR0fa3rgE24GI9TrHtHt3ObkWiEpDjQttXzTpb8EYIKXz0xj0E3I8fpfka1IMK7C1+vB6pDFJ2BxErzKrMf2leBxXku92eZ3wqGc7BlB5H6WLb4GMY6vc83LjbWySTWXkDTPTPDSoyYGwN9WPnPKBHCYRIsQRX3LW5KrqVLkKGZtJFtViXziQC6YKa6Fzci/806Z4w4Wii/Scixbt1j+/qz/TkVViKc7GjfLMCweFkj/blq9Y+sJYk7Kk8y/FoxHz7bZTsHx6x78HkG6j6V16sdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFoncDVsE37a53u5tI/38sf5tb9u5eGJmRfWkZziGeM=;
 b=idiuVeALwpNAWD20d8ReXi/nwEtB7JlaoBkWI44mSepVdP3WPNeK6A9KKX/wwFAO5A3W+bb2ywvdki8I7gOV7PiwrxPjzQP+RV8N3QPErNQ7qGyVpAn1Z0ZTINVcSqOC9XFTnIMIRH9uiKZxgastWgORXh/l+ry059fMgxjRBDss78s64Bmt3SPNHHvxxRG8hxpmh3DbUyg31A8ssTkiCSbSIF09pkaPYF4D4PvtQ+dGvjPb0F7LJR4TNNBBMaxk32EL7XBgLEPqEP9t/CSadUrhd6s+WEN80Prpzrhqt5BOAoOwt9l5Rgt4KuinVVlQMuisGGa+kw8lLsIR3f4V5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 23:42:52 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 1 Apr 2026
 23:42:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
Thread-Topic: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Thread-Index: AQHcvgciEO9ja9+YTEeNEsKQg5wh6rXK5moA
Date: Wed, 1 Apr 2026 23:42:52 +0000
Message-ID: <6a28710b65d1a291213d28a8297477bf0287df7d.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-9-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB6351:EE_
x-ms-office365-filtering-correlation-id: 7c2b4b4c-e1c2-4b01-a2c8-08de9048644b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: c+v0+hTbsbGc++4PpbiLhsfvR6yyQiLGuJbWGDsrCwGsxLFHQ0YPw5RGtvL0EN+KmPcilJQ2uQQWT8LCPD/MZ0KkcZxYSxRM532QbA5IKCLf7vwBiY8aF83ffak35EAGXSXutNy3LJfypon0am5zVxPGRqa6MNlNm7jxemUeXIpaVFISS+PlvcGrE1+hipSo69V0C6/3VwKVykeAMtlcLFRl80M7mpwFj6pq6NwyCDt1QEkwTHi5Sgktgaz4S3lKvAxquO5lIZX6wLBR+70P2eroSId0UpP+b68tXHZevj3dV6lqkI+RtbWt5vztfVduj7s6htYphmOLdmyiDhE7hsis5QQjd0D18j3wNArmUImzvaBF72OML+jhuDM4jzFhL6y+t/iaf8ZfN2Bc0XqH4aUh4o42XMt/hzITMBkwjuIKQ5E3GwuFlu3hpidPB4goBuXD4O+lxWX/UgQitzo6MCRmIVaLWLlymMoDA5Yozuq8UzezVyxPoeWX1v+1JjIRCPlx2gRYo+ATXyrO1eeL85W/B5nDhQ3hEzwwYTzgBqaejdKe6NmlfG8sc6cFcNiDo1btyHGujp9h/NMmh6C+3zk+42634oDA2kergkZk6pYf411LT2QArojI7nNa76Oj0/BpftSORJxtcd/1BDEwW/0G2pVm2D5ve6gZkZfuk6L5aafn33pUNOVhMom9kQsl8GSEmj8G+73K6IOt/mBqrPXCKvshIqyW4V/ZjWFrZJsbHshiAz5dyNms6kIozRbjObt09xo3lBT2B4PzPv+g+6WuHDDyE5+uBB0W5HIWno4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VUbElMY2IzakhxZHcrckVHT0dXYW1rdTdiN0lrMHBVL1NOTFRWbmpoMDRY?=
 =?utf-8?B?cEc5MUNVdEZEV00ybVdNS0FTcnZyOUMwRTlRRXFXUktaa2JxUDYvdGhHemJY?=
 =?utf-8?B?bDJ3b1pWa0lrNmhzZXdwU0pudWk0ZXFXU0s4VForWUkwSm9nVS9lVVBKbnNO?=
 =?utf-8?B?a2dsTjZKcVE2b1hadVFHVENHZmRGMnhOaDJ5OGNvVzZMWkUxSFdVejNjVHdT?=
 =?utf-8?B?dEpXblBjNU5qcko2RW95cyt1akk1N2x5bFVFYUt0MHZUN1ZhdjI3MDVLNXlK?=
 =?utf-8?B?QUJpNCtOSEFZQS9YRStPRHFaNFBXMGRUQTZ6bllnLzhkSU9WZitVS3N4OTg0?=
 =?utf-8?B?OFhXQnU4RkFUc0RRay9qWFIwK1pHUHVETGo2TGUyQy8yeGc1TnZyQnRlU1Zl?=
 =?utf-8?B?UUNLeFMwN2dnb01wYW0wd1pUbER1OXd4K0dkWnBJRUtUNVZhL3BIa0hwRlox?=
 =?utf-8?B?TXhja25KU3k1bCtnMUZMSzRlcU1zRjlyb3lpV3dneU9WTllPdTdwZ2ZlY09a?=
 =?utf-8?B?Q0NrVk9QZTFrSzRSQ0syd1N5djlPRU91MUpSVU1DTkhqRWxaeGJTS1VBck9L?=
 =?utf-8?B?cEZ3YUpIbkc3Y2cyZ2FqK0grL2xZVGw1M0JqdE84bkJpWEZsOWpwZjVXQk1H?=
 =?utf-8?B?dGErOW5VNGk4U2UzUVJNT1lVNFNtQWNtOGoxc2k5c0hHSFJuNUdNMzVNUWhV?=
 =?utf-8?B?L0M0c2RuZzhpZkxIcnpraFlZRFBlTjlQOTllNkNBV241a0k0QjJ3emN0U3Y1?=
 =?utf-8?B?U1loSWZPUzBZL2JUS1VvQVgxRmkvU1N3M1Zzc2d3U2JXN2ExQUJZVTM0RTF0?=
 =?utf-8?B?ajM2dlVWRXQ2ZWZPZityV1ppN1BXM1NwM3NjVHZ4WEZQNUJMWldVMFpMYzVV?=
 =?utf-8?B?N0IvTHVrd2NBd0pML2hYZ3V6SjVsS2pDMmFlWkFCUGFVWGFpNGY1S3llN0Zp?=
 =?utf-8?B?MXdwVWZmTkx1bmNiWXg2LzVnQ2xzNWR6L1BZVGx4amlSYjlzR2tHSnd1NDlW?=
 =?utf-8?B?YmNYenZsNjNzSDVaeUFMSjNCSldyZ1FncXgzclV0NFFuSWo4NVJFZ09YZGt3?=
 =?utf-8?B?S1JRb01pbzFkYTU1eEdqUzY2emQrWitQVWE3aThsNVRZOTl6TkNlemdqVnl3?=
 =?utf-8?B?Q09zcVppdGNUMUdiakc2cDB3bVZ6SzVaK09CSGJzZEJyci9ycjU2aElLU3Bl?=
 =?utf-8?B?R0o4R3U3eU54am4ySFhjNzdpZ25pZEI1K3ZlTmdWM2ZmTFUzcmlqbEp1Tnla?=
 =?utf-8?B?SjBYdzZyVU5iS2kvVXlzRmVjbTl6ZWIvOEN4Rm16dzVNc2YvNUhnZmxFQTNa?=
 =?utf-8?B?bW41MHVnQjlNbTFXSFd0S21tODAxR2d0dlB0TWdSa0U1Ui82N1BXZ1NOWWZm?=
 =?utf-8?B?eE9nV1AralZxUXdwOWVweWJ3RDk1SWtqOGx1QVZEOU5EYlZDaW9MSWRjUlhk?=
 =?utf-8?B?Y09RdFJYQVV3bnp6eGZiU1NiWFdZS1RjK1hJZlZjSW4wa1A2dXRKcFZwWGFV?=
 =?utf-8?B?S255ODVyMFlBbHJZa094d2F5MlV6K0VpK3JLSU91bVlud0JhQW1KcUV0TjJU?=
 =?utf-8?B?UzBERVJqbEZLWmxQTHN2cmJjbGZHczlOYzVlT1MwYWYvRDhxZ05LSnhNREZk?=
 =?utf-8?B?YjQ3WVRFNmFweFBQQlNKSVVTbVVJTi9sWXN4Rm5XeVJJWGN0TkxsNCsyN0NG?=
 =?utf-8?B?RWZKeXgxZmZTYnZOVXAzY0tIc0VKd2xocEtmdzBSeEh4bmJvdStkd2h2SXNS?=
 =?utf-8?B?UTUzS0lGdm9HakdOZHg1QWRkZHo2YVJCcDQ0RWNFNlRSRlNyemljOVZERXRl?=
 =?utf-8?B?UkZOM1hRampaUTh2TTRkMFFTRWhhRU9sdXdOaGVQd01oZWZ1TWwwY0FIMVU4?=
 =?utf-8?B?cTJHSWZ6cG8rbGxpVEtDc3FQem5lQ1Vrd0RuS1RhR3RUUUdhUmpmZzhGN2xL?=
 =?utf-8?B?M0lYTXF1U0FDR0JHZGhyNTR2S0M1U3VCMzVFVkdVUlNjZXNhSFQ4bktUZUlP?=
 =?utf-8?B?ck12UDZuSVN1RTZkd1JmVW50ZWF2ak9NU0Y4VEVySGVERzhEUXZQQ0g2MlFo?=
 =?utf-8?B?dVNtdXN6bjBDdzV4ZmRiRGNhOVE2eVE2NSs0OGx2a3k3NUVIYVNpMXJ0eTBs?=
 =?utf-8?B?NStrdU55TXFVaGh1Nm42M2h6VHhZbEVUYVM0RDltY0diS2Zldk5xZGp0MXBU?=
 =?utf-8?B?YzBDTis3R0hydlIvVDVsMUZqOGRDelBQTXFKNFFmWE1aeDlCMEpCb3B1amlP?=
 =?utf-8?B?STJpdzJXeXZnMWNCbm1wSW1KaUFhSnFpVVhWeW13MDIreUpVUE1ZTG1SYWlx?=
 =?utf-8?B?THV4TEltbTZab2hQTkdQbm8xZWt5b2NvVEUxZkVGTXpDSlpIVzh5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9124E7206E4D2A4B901CE68AE4135842@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PkuqiK0kdKAdEZjeI+zeXU19A/lBPevzGbt2E//bbctQBmYwtFANum8jHOdKezGIaqSQd/qgJJcaYMiRES9co0b/JLxeCJbguGYslaO6BR+L5uIZuCYnjaJILhsIs7OGQpmBZlbj5zC1oOAUH8+F+T2ecL2zzkBNAF3SmB5m9vg8B+jAqLgUAuUA7ZKD6dxw9ch8Ta0IdTar2ZqPTXwI1/VDSbbDvsTe/AdpMBX0ruqz2NLDPJN3AoMATs8qVItqOWpr+PW720E46sCDy3BeDiD3pUREvzpP8japs1n9+2SLYIclaV4EAY9w8xp8annQzJRqB4eWoQnwM0GAhcki+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2b4b4c-e1c2-4b01-a2c8-08de9048644b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 23:42:52.6875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2w+X/KWmvtguwjLDNrAwFEwJz1w1iXX+BUlYq2YWg0sS/8Ta8+H/a6PcQ4TlTuyhb4yUbq2X1zRabzUhEWVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

DQo+ICBzdGF0aWMgaW50IGNvbmZpZ190ZHhfbW9kdWxlKHN0cnVjdCB0ZG1yX2luZm9fbGlzdCAq
dGRtcl9saXN0LCB1NjQgZ2xvYmFsX2tleWlkKQ0KPiAgew0KPiAgCXN0cnVjdCB0ZHhfbW9kdWxl
X2FyZ3MgYXJncyA9IHt9Ow0KPiArCXU2NCBzZWFtY2FsbF9mbiA9IFRESF9TWVNfQ09ORklHX1Yw
Ow0KPiAgCXU2NCAqdGRtcl9wYV9hcnJheTsNCj4gIAlzaXplX3QgYXJyYXlfc3o7DQo+ICAJaW50
IGksIHJldDsNCj4gQEAgLTEzNzcsNyArMTM3OCwxNSBAQCBzdGF0aWMgaW50IGNvbmZpZ190ZHhf
bW9kdWxlKHN0cnVjdCB0ZG1yX2luZm9fbGlzdCAqdGRtcl9saXN0LCB1NjQgZ2xvYmFsX2tleWlk
KQ0KPiAgCWFyZ3MucmN4ID0gX19wYSh0ZG1yX3BhX2FycmF5KTsNCj4gIAlhcmdzLnJkeCA9IHRk
bXJfbGlzdC0+bnJfY29uc3VtZWRfdGRtcnM7DQo+ICAJYXJncy5yOCA9IGdsb2JhbF9rZXlpZDsN
Cj4gLQlyZXQgPSBzZWFtY2FsbF9wcmVycihUREhfU1lTX0NPTkZJRywgJmFyZ3MpOw0KPiArDQo+
ICsJaWYgKHRkeF9zeXNpbmZvLmZlYXR1cmVzLnRkeF9mZWF0dXJlczAgJiBURFhfRkVBVFVSRVMw
X1REWENPTk5FQ1QpIHsNCj4gKwkJYXJncy5yOSB8PSBURFhfRkVBVFVSRVMwX1REWENPTk5FQ1Q7
DQo+ICsJCWFyZ3MucjExID0ga3RpbWVfZ2V0X3JlYWxfc2Vjb25kcygpOw0KPiArCQkvKiBUaGVz
ZSBwYXJhbWV0ZXJzIHJlcXVpcmVzIHZlcnNpb24gPj0gMSAqLw0KPiArCQlzZWFtY2FsbF9mbiA9
IFRESF9TWVNfQ09ORklHOw0KPiArCX0NCj4gKw0KPiArCXJldCA9IHNlYW1jYWxsX3ByZXJyKHNl
YW1jYWxsX2ZuLCAmYXJncyk7DQo+ICANCj4gIAkvKiBGcmVlIHRoZSBhcnJheSBhcyBpdCBpcyBu
b3QgcmVxdWlyZWQgYW55bW9yZS4gKi8NCj4gIAlrZnJlZSh0ZG1yX3BhX2FycmF5KTsNCj4gQEAg
LTE1MzcsNiArMTU0NiwxMSBAQCBzdGF0aWMgaW50IGluaXRfdGR4X21vZHVsZSh2b2lkKQ0KPiAg
CWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2ZyZWVfcGFtdHM7DQo+ICANCj4gKwkvKiBjb25maWd1
cmF0aW9uIHRvIHRkeCBtb2R1bGUgbWF5IGNoYW5nZSB0ZHhfc3lzaW5mbywgdXBkYXRlIGl0ICov
DQo+ICsJcmV0ID0gZ2V0X3RkeF9zeXNfaW5mbygmdGR4X3N5c2luZm8pOw0KPiArCWlmIChyZXQp
DQo+ICsJCWdvdG8gZXJyX3Jlc2V0X3BhbXRzOw0KPiArDQo+ICAJLyogQ29uZmlnIHRoZSBrZXkg
b2YgZ2xvYmFsIEtleUlEIG9uIGFsbCBwYWNrYWdlcyAqLw0KPiAgCXJldCA9IGNvbmZpZ19nbG9i
YWxfa2V5aWQoKTsNCj4gIAlpZiAocmV0KQ0KDQpNYXliZSBhIG1vcmUgZ2VuZXJpYyBjb21tZW50
Og0KDQpJIGRvbid0IHF1aXRlIGxpa2UgaGFyZC1jb2Rpbmcgb3B0LWluIFREWF9GRUFUVVJFUzBf
VERYQ09OTkVDVCBpbnNpZGUNCmNvbmZpZ190ZHhfbW9kdWxlKCksIGVzcGVjaWFsbHkgY3VycmVu
dGx5IHdlIGp1c3QgdW5jb25kaXRpb25hbGx5IG9wdCBpdCBpbg0KaWYgdGhlIG1vZHVsZSBzdXBw
b3J0IHRoaXMgZmVhdHVyZS4NCg0KSW5pdGlhbGl6aW5nIFREWCBDb25uZWN0IChhbmQgb3RoZXIg
ZmVhdHVyZXMgdmlhIFREWCBNb2R1bGUgRXh0ZW5zaW9ucykNCmNvbnN1bWVzIG1vcmUgbWVtb3J5
LiAgSXQgd291bGQgYmUgYmV0dGVyIGlmIHdlIGNhbiBjaG9vc2UgdG8gb3B0LWluIHdoZW4NCnRo
ZSBrZXJuZWwgaGFzIGVuYWJsZWQgVERYIENvbm5lY3QgKG9yIGFueSBvdGhlciBmZWF0dXJlIHZp
YSBURFggbW9kdWxlDQpFeHRlbnNpb25zKSBpbiB0aGUgS2NvbmZpZy4NCg0KVW5mb3J0dW5hdGVs
eSB3ZSBuZWVkIHRvIG9wdC1pbiBhbGwgdGhlc2UgZmVhdHVyZXMgdG9nZXRoZXIgZHVyaW5nIG1v
ZHVsZQ0KaW5pdGlhbGl6YXRpb24sIHNvIHdlIGNhbm5vdCBtYWtlIHRkeF9lbmFibGUoKSB0byBh
Y2NlcHQgdGhlIGFkZGl0aW9uYWwNCmZlYXR1cmVzIHRvIGVuYWJsZSwgYW5kIGluIGVhY2ggaW4t
a2VybmVsIFREWCB1c2VyLCBjYWxsIHRkeF9lbmFibGUoKSB3aXRoDQp0aGUgbmV3IGZlYXR1cmUg
dGhhdCB0aGF0IFREWCB1c2VyIGNvbmNlcm5zLg0KDQpCdXQgSSB0aGluayBpdCBtYWtlcyBzZW5z
ZSB0byBoYXZlIGEgZGVkaWNhdGVkIHBsYWNlIHRvIGNhbGN1bGF0ZSBhbGwgb3B0LWluDQpmZWF0
dXJlcy4gIEUuZy4sIGFzc3VtaW5nIHdlIGV2ZW50dWFsbHkgYXJlIGdvaW5nIHRvIHN1cHBvcnQg
VERYIENvbm5lY3QgYW5kDQpsaXZlIG1pZ3JhdGlvbjoNCg0Kc3RhdGljIHU2NCBnZXRfZXh0X2Zl
YXR1cmVzX3RkeF9jb25uZWN0KHN0cnVjdCB0ZHhfc3lzX2luZm8gKiBzeXNpbmZvKQ0Kew0KCWlm
ICghSVNfRU5BQkxFRChURFhfQ09OTkVDVCkpDQoJCXJldHVybiAwOw0KDQoJcmV0dXJuIHN5c2lu
Zm8tPmZlYXR1cmVzLnRkeF9mZWF0dXJlczAgJiBURFhfRkVBVFVSRVMwX1REWENPTk5FQ1QgPw0K
CQlURFhfRkVBVFVSRVMwX1REWENPTk5FQ1QgOiAwOw0KfQ0KDQpzdGF0aWMgdTY0IGdldF9leHRf
ZmVhdHVyZXNfbGl2ZV9taWdyYXRpb24oc3RydWN0IHRkeF9zeXNfaW5mbyAqc3lzaW5mbykNCnsN
Cgl1NjQgbWlnX2ZlYXR1cmVzID0gVERYX0ZFQVRVUkVTMF9OUlggfCBURFhfRkVBVFVSRVMwX05P
Tl9CTE9DS0lORzsNCg0KCWlmICghSVNfRU5BQkxFRChURFhfTElWRV9NSUdSQVRJT04pKQ0KCQly
ZXR1cm4gMDsNCg0KCXJldHVybiBzeXNpbmZvLT5mZWF0dXJlcy50ZHhfZmVhdHVyZXMwICYgbWln
X2ZlYXR1cmVzOw0KfQ0KDQpzdGF0aWMgdTY0IGNhbGN1bGF0ZV9leHRfZmVhdHVyZXMoc3RydWN0
IHRkeF9zeXNfaW5mbyAqc3lzaW5mbykNCnsNCgl1NjQgZXh0X2ZlYXR1cmVzID0gMDsNCg0KCWV4
dF9mZWF0dXJlcyB8PSBnZXRfZXh0X2ZlYXR1cmVzX3RkeF9jb25uZWN0KHN5c2luZm8pOw0KDQoJ
ZXh0X2ZlYXR1cmVzIHw9IGdldF9leHRfZmVhdHVyZXNfbGl2ZV9taWdyYXRpb24oc3lzaW5mbyk7
DQoNCglyZXR1cm4gZXh0X2ZlYXR1cmVzOw0KfQ0KDQppbnQgaW5pdF90ZHhfbW9kdWxlKCkNCnsN
Cgl1NjQgZXh0X2ZlYXR1cmVzID0gY2FsY3VsYXRlX2V4dF9mZWF0dXJlcygmdGR4X3N5c2luZm8p
Ow0KDQoJcmV0ID0gY29uZmlnX3RkeF9tb2R1bGUoJnRkeF90ZG1yX2xpc3QsICZ0ZHhfZ2xvYmFs
X2tleWlkLA0KCQkJCWV4dF9mZWF0dXJlcyk7DQoNCgkvKiBkbyBvdGhlciBpbml0aWFsaXphdGlv
bnMgbGlrZSBUREguU1lTLktFWS5DT05GSUcgKi8NCgkuLi4NCgkvKg0KCSAqIFREWCBNb2R1bGUg
RXh0ZW5zaW9uIGZlYXR1cmVzIG11c3QgYmUgaW5pdGlhbGl6ZWQNCgkgKiBhZnRlciBUREguU1lT
LktFWS5DT05GSUcuDQoJICovDQoJaWYgKGV4dF9mZWF0dXJlcykNCgkJcmV0ID0gaW5pdF90ZHhf
ZXh0KCk7CQ0KDQoJLi4uDQp9DQoNCk9uZSBuYXN0eSB0aGluZyBpcyBwZXIgcHVibGljIHNwZWMg
UjExIG9mIFRESC5TWVMuQ09ORklHIG5lZWRzIHRvIGJlIFJUQyBpZg0KVERYX0NPTk5FQ1QgaXMg
b24sIHNvIHdlIHN0aWxsIG5lZWQgc29tZSBzcGVjaWFsIGhhbmRpbmcgaW4NCmNvbmZpZ190ZHhf
bW9kdWxlKCk6DQoNCglpZiAoZXh0X2ZlYXR1cmVzICYgVERYX1JGRUFVUkVTMF9URFhDT05ORUNU
KQ0KCQlhcmdzLnIxMSA9IGt0aW1lX2dldF9yZWFsX3NlY29uZHMoKTsNCg0KQnV0IEkgdGhpbmsg
dGhpcyBpcyBhY2NlcHRhYmxlLg0K
