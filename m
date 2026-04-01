Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DC26299;
	Wed,  1 Apr 2026 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079384; cv=fail; b=L4AI5crGah/oWJHXV80c/cEElsZ1jvobU2QRMpBNOqhgZ1b+23USZhD3YbHIhSREPSUUGkQozOjfX6MRbLkOYeG3ajy1L6xDD9Vs8FZH4hHA0hq51SaEhyR1sAJcAEtAQkNMESTURcdGaJeqipPrYlUVf6W3se5mWdaEIweuPvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079384; c=relaxed/simple;
	bh=wLFVhvz734Vegxju/iIad99uP7PvDT6WkWwK7AxNtYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNnK7NkiFor2/TzCvto0ayUZ67ntpeoEKPPSLYth6MBrCfjoTITWG1GBq02WCr8Ya1YXeFDPH0Nhkn5R89uH9LcvJmQXzRhCLm0MGgDE6cmLKE8iHFdLUNN+/RslRcK/evLKsKQkBxd1Ag6ZFwKNDT3k3x8loaceXQdc8aAp8zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gjb3SjXI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gjb3SjXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775079383; x=1806615383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wLFVhvz734Vegxju/iIad99uP7PvDT6WkWwK7AxNtYo=;
  b=Gjb3SjXIqA/wslJxAqsLTeJwuQqmgSzLGjT3Sc5JZKmQmoOgw3K7Nb2J
   /M++r22fjqcG7tbWZvxQTMPqswtdiChp0tjsL/GhczExQxSL2U5vsuOTl
   aSmIGA+RMgz8BvSzugPpYru4Ovo7HIhSJbsSjx7XM+hSnxwcOirgE1y4n
   iIMutljBI7Vw54DLuCE81DGNrUnpe8HD/nB6cdJcxygT0ORt087KA4FqS
   iYx2wkzqYLNgFnsX0SxOg//qtJm+mxJfXAHd/x7Dm+s6xhKF4jnsJl0TI
   RMfCB+OlVPPXieaSxZk6gJt7LkgnfqH+cHG1epOzJ1w17/x1eNOQwE6Ju
   Q==;
X-CSE-ConnectionGUID: /5tAXjFtTY64XFs1ODtjbQ==
X-CSE-MsgGUID: z5UBH8O/RLCPF+qCOfL+sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76098535"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76098535"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 14:36:23 -0700
X-CSE-ConnectionGUID: SODjnGvmTEq6wLiTnSYB5g==
X-CSE-MsgGUID: BSDw2t/FTk+jSWvmXwxKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221943862"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 14:36:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 14:36:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 14:36:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 14:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHD4g9RsPQLWWjO7LSW1dP6qJL8XNJrsJq9d9jnp1+SkpH8SdzFrQEZEx6fZLtd0DQNvr4/wuIK1LyX46G17TOJ+Xl31FkzTcqu642IeUdC0RCCug4S7+L3Q0mcFMUwC2JjfHz62ON1k57ndDFalCtLZ3l/Rd7W0AmJVOlYAN2Q2J3skZWFtDOz2wFBsVm/KuqFT9DSwZdCcMP8TNstGWlkaYoqQUpQ7qJEalanr80FGAqLYYGBPeeYrQxbh93gCNr3o6KcFzp09OI9KKYmxUV46FpSkKDyakSAOe1wFoOyK/wG4g7jpa5mVx32GZPo97x/wjiRuq7vVglZVkuJLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLFVhvz734Vegxju/iIad99uP7PvDT6WkWwK7AxNtYo=;
 b=gsaLihhAH728NFV42bni0g0IhuWIaRF7xoboNKeI2Ss1QkC2N5NgkCAid3f0fYo1zL/MwDUFuPBxav9resjiwy5un/Xgo8wK6lMptANuDLyHviPhWy4ulJk0LCF9H/Rh3h0Hljn6zPxRx/4OmHVZKt8XR1jkDk9hT/Okwg+FpGiI0RPHvqtlygT6s1xc7/X/aihRjL4tskTsX6pkX8XdpenkYb0h8lgFj5nMAqeTql0j90QFdDF2103ZYEkJ46qTHsXKU5tZTwDLWbT4oiRZKxcF0jAxuWpA2FrfvKSCBsqJem6ltj8kopCp9oKWEZyIe9yjz3jC4UZf+8JMzwLqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA3PR11MB9208.namprd11.prod.outlook.com (2603:10b6:208:57c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Wed, 1 Apr
 2026 21:36:19 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 1 Apr 2026
 21:36:18 +0000
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
Subject: Re: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX
 Module Extensions/Connect
Thread-Topic: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX
 Module Extensions/Connect
Thread-Index: AQHcvgcU66KACC6fSUypXn6NY5rJC7XKwxUA
Date: Wed, 1 Apr 2026 21:36:18 +0000
Message-ID: <123290f2bd1fb9c98bf494650c5912a3bf080114.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-7-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-7-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA3PR11MB9208:EE_
x-ms-office365-filtering-correlation-id: 54256155-903b-4cdc-00d9-08de9036b5f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: FQO4MvDdjoVyn1jl8OBI9IBr9k3wtjN77JFEHzXYgeoWLaAom6pOyJFiZCgEMZshrxBbiz1tfoW7FzF8kQsFe3VCIC7rtzif9I+IBxvgG8nDB/LirwOrOVBPFkpU72DMtJ+dJYh+Y+qj1S9ixbCyhDBiJDoJCXnuqyQqrjSPvih6UW0EY9RJTefsPN4VtmIPcu0tKyaQdzlxSdTU+BwfJrWKymYuHyr5HsLU8RGp02gEekGzfL68Nr5xAhPgZrA883mrPZAYSL8h+/4Xb15zimYmVkpsZHcc4moEPRbg0+yx6A/lOw3PgrmPZgyRYh+x+uwqOeo/0Ml9sA7tfb4Q5U47BAgr/p6IXd9AXs7VY0f2eiyRfD93S2TgKTv614xCgA0tgX1+AbVFYUuEO6RBwQZMyF3D8gkrdQYaVTSQA8Cz0n5GGQFuxK+mia8oyxt1H2NNFWVC991RRv7HLMsDlHzjZSwshoZLBPDoy2NwndW6tbq/icHKnhWGlWaysp4pr7nJHEVIpXtooBDhPQVaXkU9Pnz1r4HUtk5RxnA4eAspgCSyEDgR0lUuyRIqY5ItRO4i3ND5VjLgkMkgE3uwmxrQ531xXezhUVhRYExa67YCe5U3LnNtBjrx9ksVMClCpVcDg5wRzKkmiC3jb+1xdbW7I0+aODwMV1nspQeUKx/Jfcf7OGaZcBMj7eCK+4iBGsts6xB1WE/Dyda91GwivzvbIP2TQxtGEwnP/XzkfQsDmKewCLXnK5PasJR6d+IuHwPWWPWuMxyy3YCg1jO2TdctEIpSZswkR2hFj8w0T8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STN0WE1pUUlRWmc4MVAwK2NxOWdzbURqeXB0RjBtZElNWFJkczJNemhqMmhN?=
 =?utf-8?B?RkJKaW8vb21ZUUZLOGtndEZkRmNMbVV4dHpWSEhYbHJqMTJTT0Rwd1c4eTBM?=
 =?utf-8?B?WFR5dEEwdnVvOG5QcFhGZU83UjhBSGhkTXVjdlROeGZEK3BlNUxoWFJZOGJG?=
 =?utf-8?B?THdPTUo4NnFXczlHa0p5K1dmV2NXQ01CWVVhMWNqRTVrcVJJUlM0SmsxdXlI?=
 =?utf-8?B?Rm9iRWJhaVg1R0dYRzJFbXlvclNEM1hyS0RKME9neFNleE9HNnB1VENvc1ha?=
 =?utf-8?B?cVN5eFhHaWJRbDYzODM1cEkyM1QwRE5NTlhYc2JxV3N2dEYvU3Fwc0ZQeWhG?=
 =?utf-8?B?R2E5c25wTVFjL0QwMnV0Q1VQcTErd2dIRGtIUzB0WHJMdTdldnJIZHM2Z29I?=
 =?utf-8?B?YmJ0Nyt1OC9rRmtoQTR3bXZQUWdNcXE2NlJUd09ORVhoN05ibCtJOGxhUnZm?=
 =?utf-8?B?TFJGd1hhbjB4T0hNTWQ5R2FMcjNLcXp0cWQ4cTcxTW9WczNCZmNpRmFHdzZt?=
 =?utf-8?B?ZGVkK21WbWQvdVlhOTIydkx4K0o0U1Q5SkNCOUVPZ2o0VytLN3pvV3g5NUhp?=
 =?utf-8?B?WWIzTmQ4QkJ4ZjJ2eVFaMG5QcGhxWElmWis4SVhDWG4wOHQ0ZWZ4WVhWWWJT?=
 =?utf-8?B?dUE1bzBvR2NjSExBeWZzTDVEWlpSYzFzNURLR0VvUW1CL25XNkxVY09vcFhU?=
 =?utf-8?B?SmtrMHBIcWhHbWtCaWVnVWVWSTU0WDJGa2hBUmhYVzVPd0hVbGFGWXlJTG9o?=
 =?utf-8?B?Zy9aSWIzSGdxL2tpUCtOM0JpUDdoS0c2UFVXNlNmNG5jR3hvZkwyYWlhMzB6?=
 =?utf-8?B?MW5xRmFNclJmVHFaMm1xMDIzZ2preHZybU1YeEdiM2lQNUNSSFF3TUZhakto?=
 =?utf-8?B?dFZwN01wOEc2VzlKamhrUmhkYVp1SE80czJJQU9yVERCbWg1dTZjY2EvcXU0?=
 =?utf-8?B?NThJZWxpSXdwNEVYZms5UEFqaHhoVkloUUNDOUhLek5ybUcvTDZ3c0lTemVU?=
 =?utf-8?B?L2F2V0hIaFlsVDJGTEtIQVlZbTdRMkM1eGpBSlZ1R1N5NVBZV28wRk1INUlD?=
 =?utf-8?B?YWJIdk1wVlFkTStpQ0Vody9PYjVjSkhJUmNMVXY4S3VEQlNWMHY3SzRTRUJ3?=
 =?utf-8?B?bVdreWQzL2xkQ3E4ald0Zm9vbUtKZUpuOVgwYjNkaTdxVWN6a1FnZkFjQkF5?=
 =?utf-8?B?TzZrZTlRZHNwTDFrZllMbUM0aWtUTHQ3ckRKTFQrdUV3bTZlbnE3T3Fab1pj?=
 =?utf-8?B?YVlud3QrVVdkajZKYU9lOXNISEszSmQraVFoZlpCUllKOE03UmNpNDBqazVM?=
 =?utf-8?B?OURxa3ZFRks3MHNrZmtZN3JlaVZOZmZPSTFoK3k3enV3N04wRlFscDBnY05E?=
 =?utf-8?B?bTZiS0hsL1ptMDl1ZDBMYi9XeTJFd2dkaXJqeDNuWmNOVjdsUVVNTmVXcTZr?=
 =?utf-8?B?dU9uQnJZaUdhR3FQdERkZktGMis3eW5nUEt3OTlEakZHNk9KK1dXbFFtM0Jx?=
 =?utf-8?B?VXN3WEJLZlVkQTlzZWFoRWs2dFQ5aWlEY3F5VWZjdzRzOFN0ME53aytWdzh2?=
 =?utf-8?B?SDEwQlNtcXJqcnMrRXRJZERmdmtqcVZUanE0QVpwNlFaRjdjTFBoUjBZdnZh?=
 =?utf-8?B?Wi84UUwrRnlkRGxjMkVTWG9VanhxUEhJb1dxL0VabzV4NVFPRjNrTFErYVlH?=
 =?utf-8?B?WVI2VlIzTmd6MFkzTGtYOWxBZ3RTUTdaTGFWM3FhbFIreUxmUG9ZYzV1cTAr?=
 =?utf-8?B?eU04UEtaU2tmZHp6OXBsZmR0OC82RTMvWVZUc3ZtRmVpMTlKQ3RvV1NJaE9G?=
 =?utf-8?B?bDVlSGR5WGFWc3RtWk1TdlczTU5VS1lnaFRPdDdVa05STXNWV2ptUWRHQWsw?=
 =?utf-8?B?K1AzZHo1WGhwbCtzUldaSlJCaGNYaElBbDh0TGV4ZGdqY0xHSzIxRmcvUzlt?=
 =?utf-8?B?Y0ZtYVFhSXlFbWVpQTBWbzlJTnVCb0l6TGZncGh3WjFYQXg1OGs5d3Vwa0g3?=
 =?utf-8?B?RFEySTJCQnk4Y2xvcXJyaGpid0NNUUZkeUR4bzRBNGpRS3hMMlpsSFlWS3Ez?=
 =?utf-8?B?QXNlMktRTUpkNW1HYUsvODZaK1AraWVQbms2ampKVDgvcTBNUE5YVTJ5UTgv?=
 =?utf-8?B?cEU4dUUxS2N4cm5SdDdvRTVIODZKakhpMVZIcUFsRzRLQWRIUmZBU3RrNlVs?=
 =?utf-8?B?SFBKU2ZoL3U2UndQWjRFcWhsQjRNc1dha1VqL2oyTzAyVUNPU2EydW92TUdi?=
 =?utf-8?B?emlJQUE5SmZkSDhuTDZTUlQ0aEZNNXFZZjRxcFpNdnk5Q09Od09wcTA2a1Ru?=
 =?utf-8?B?aGIyc2lQQStpOXlVYTJjeityaitEV0gxZHliQ0I2R0ZWM0FuNUJiQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB1C402F59DB1C45A694A5D156C9C61D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yu3g5eUxdQe/Ku3H1aIKiy6bgjZ98R5MNs2/Fb4qpVA/4Vixix5fCq03t5aYuBKe/wcszMcvJDpCD8XF1awjkttyurjfrZND3O/h2As+GIfz1SAFoMmeXd0B0SZrWzjg/GgzxbQqSnKLee0AuOiyoMVs0Gh7IdLgexLy97KS+MpGXe0aQHCsHHS2XsDl5j1TVbWeQgvihofnc5cAzU6NUJgzuZdVFB8Pg+m3zQwsJQ9V2yQkUogRn6k13Vv1IV9iwhcwyS+QRL2uhW5GAGUGJszMfyewF+aUF8B/+Z61kJMXcQSGq1wlXlYjUXpnkWhM689oAOJLNtVeocGRMXmjMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54256155-903b-4cdc-00d9-08de9036b5f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 21:36:18.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loU34MSqz2foAXiFhhpE4yuDwnu2C0pMQkocVRUcCuBn/eNWUIDHz6CXV5c/hBSiKd26UTVLBJTk9jBKC6J/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9208
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQWRk
IHJlYWRpbmcgb2YgdGhlIGdsb2JhbCBtZXRhZGF0YSBmb3IgVERYIE1vZHVsZSBFeHRlbnNpb25z
ICYgVERYDQo+IENvbm5lY3QuIEFkZCB0aGVtIGluIGEgYmF0Y2ggYXMgVERYIENvbm5lY3QgaXMg
Y3VycmVudGx5IHRoZSBvbmx5IHVzZXINCj4gb2YgVERYIE1vZHVsZSBFeHRlbnNpb25zIGFuZCBu
byB3YXkgdG8gaW5pdGlhbGl6ZSBURFggTW9kdWxlIEV4dGVuc2lvbnMNCj4gd2l0aG91dCBmaXJz
dGx5IGVuYWJsaW5nIFREWCBDb25uZWN0Lg0KPiANCj4gVERYIE1vZHVsZSBFeHRlbnNpb25zICYg
VERYIENvbm5lY3QgYXJlIG9wdGlvbmFsIGZlYXR1cmVzIGVudW1lcmF0ZWQgYnkNCj4gVERYX0ZF
QVRVUkVTMC4gQ2hlY2sgdGhlIFREWF9GRUFUVVJFUzAgYmVmb3JlIHJlYWRpbmcgdGhlc2UgbWV0
YWRhdGEgdG8NCj4gYXZvaWQgZmFpbGluZyB0aGUgd2hvbGUgVERYIGluaXRpYWxpemF0aW9uLg0K
DQpNYXliZSBpdCdzIGJldHRlciB0byBzcGxpdCB0aGlzIHBhdGNoIGludG8gdHdvLCBvbmUgdG8g
cmVhZCBnZW5lcmljICJURFgNCk1vZHVsZSBFeHRlbnNpb24iIHJlbGF0ZWQgZ2xvYmFsIG1ldGFk
YXRhLCBhbmQgdGhlIG90aGVyIHRvIHJlYWQgVERYIENvbm5lY3QNCnNwZWNpZmljIG9uZXM/DQoN
ClRoZXkgYXJlIGxvZ2ljYWxseSB0d28gc2VwYXJhdGUgdGhpbmdzIGFueXdheS4gIEFuZCB0aGVy
ZSBhcmUgb3RoZXIgZmVhdHVyZXMNCmFsc28gbmVlZCB0byBlbmFibGUgVERYIE1vZHVsZSBFeHRl
bnNpb25zIChlLmcuLCBOUlggZm9yIG1pZ3JhdGlvbiksIGFuZCB3ZQ0KY2FuIGp1c3QgcmV1c2Ug
dGhlIGdlbmVyaWMgbWV0YWRhdGEgcGF0Y2ggZnJvbSB0aGlzIHNlcmllcy4NCg==
