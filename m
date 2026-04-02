Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963E3093D3;
	Thu,  2 Apr 2026 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091978; cv=fail; b=uMCJk/iV4E5zzMuuikMzFYAst6l7f99KRaWUo73Z+/umzft8yJ9hqr/b+AlwOAnsDePu/DBtdwoUEQoX26sQDUYHhDJ/73FfFEeI7wPLb0lJzYChIiOTrv40r0mwwi1W6OxmoX/GWU90g8tYzhCzTOypr9OsXemuTR2zp1+Tpv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091978; c=relaxed/simple;
	bh=MCU8uuH/t3C3O73otISgl+pwu0vKN9QmvsDa/tVr+dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHEar8AnSB6OU+KjdYl7yZnBpapZTTzBI7MGDQYRmwLJAV6IcDnNpOPZxNYXCU+Af9bjfcZmUflxWzGsdmlEc8dnH22gmuzPej0UdZXYd78rUD7aDeBQXwS1pGIA59LL2Akl4xgwN1sSggUZ6FtbVmCyNpFC+ikUtxm/TzGNSVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLw9NgjU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLw9NgjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775091977; x=1806627977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MCU8uuH/t3C3O73otISgl+pwu0vKN9QmvsDa/tVr+dg=;
  b=DLw9NgjU46u7NEPqa53h7Jud0Gs4q0CKn1ZRnL8/rZXKdEFRFd1IyaiZ
   C2uDc11Lx/ijc+KmEA47zqM8NxPSSp7Q/dxNOxOpBSmZwF1aCK6uRq3rG
   un3l7Z/Rdb5geOv4iUSyCYYVK6ZIt1BLlskVN+1BNSY95s9t/ZAXDHLrh
   LzBVRUkq2wfeg92xxFNMAux3ViIj+woN3er4e7vDgWE7wZV4Y29OoI5LL
   vev5V46lk1VMHLh9T8r/mOzhPNHDOj+Poasxu3lvuRHxzs4yr1tixo9gR
   mJZUw49832UyhNDnUqGied0bde4CCA9ilxPxCLl+CbV2HuvNJMAadFENg
   w==;
X-CSE-ConnectionGUID: rcTQkLzdSG+lKBfouPM3vw==
X-CSE-MsgGUID: 0DqOQrU5TJegycrHRtLSNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75181546"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75181546"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 18:06:16 -0700
X-CSE-ConnectionGUID: lBWKt+MgQW6OXHoLcWjK0A==
X-CSE-MsgGUID: AdvCMPaLQ96l3QWz2fxQDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249887046"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 18:06:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 18:06:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 18:06:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 18:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+Dm0KHMeMatQHajKylSHpFE4YKDXaWqawcaHN+D838yeMnwUdoVArTCq0xIT/R5ckJdLRADYnHGnPwt7M7iUtMNE4NaymN68xik0+OKexe3WsWhw5imLSf/UngGgP16fHcgb6/f9qUrkqgG1Q/C+itdkRMchfDti/qGTvSZoGgHpqFBQjROBhZb3+qTEiy6NOdUnSB1L56++wW7Hq6co4+yVNPgqu3dwWILkg/07+AX5m8zVgw7sxxULujIuwDb7DRQp6ynvRCMB1fDefYcRNF+4WySL9j0J6HvvnYcreeTrQN5So3mca6pQSDVgoOGEr5MLh5bagfquzjpKfzx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCU8uuH/t3C3O73otISgl+pwu0vKN9QmvsDa/tVr+dg=;
 b=jLwOjlbSon+732JxOfE7hgK0INOzz7ev1G8/FxWCrenme8wEZGTRwLtt/aWtWBhiOSNepadARD5yqed0zbOCG7AuaxcXttoU2L1xSa98WXYYYYc+UxrG4hbcvU+qPj8I6r5xPSuARagK0+p/NY6OtBEvKb+pt2HGhekiiaSjlEbKmJWUBxOQoNhEs19BHj0AWzboBZag0ltOM2jROa8ZU/kQD1G/VaT4q37ZyonbCnghaZj0EsOJ4+1vHnj9WNngMEvY1farn9v/uoM+zdWzGmqwFK45RVU8Ou1QbsqaYTZt2PGCggXYr0L4svCeCs/c5GVFSG6mgT+I6gJcu7/0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 01:06:06 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Thu, 2 Apr 2026
 01:06:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
Thread-Topic: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Thread-Index: AQHcvgciEO9ja9+YTEeNEsKQg5wh6rXK5moAgAAC+ICAAA0lAIAAAi2AgAAE/oA=
Date: Thu, 2 Apr 2026 01:06:05 +0000
Message-ID: <cdf1b042192b9ed501af8b810b392f50e6231e51.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
	 <6a28710b65d1a291213d28a8297477bf0287df7d.camel@intel.com>
	 <8c4dfadaf73ed175a959ab16335a8d90266453b5.camel@intel.com>
	 <847eb26878cb06afb47f4ecdb0bfe8ab7e432e8a.camel@intel.com>
	 <5183437e-bbe8-4453-9b03-9bef2e025c0a@intel.com>
In-Reply-To: <5183437e-bbe8-4453-9b03-9bef2e025c0a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS7PR11MB7738:EE_
x-ms-office365-filtering-correlation-id: 40a4e2a3-9600-4651-2bbe-08de90540465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: mKsbDe0vCaRC8rQ7dp44DBkn2kEK2HRZl+iZz631gKZ0wTpHycBq3oPEtM2y4cZ5tu3TFuVSD/Bd21jF98uiZ4mAEWMB4/TGYYu6C0J0MvvGPcXCkcwoQ97Lwb5DNPdwgXiB/LM5VfwwfZf1VIkfA0VqPGJTQ46x5RcZVLjxcV6crolLTw6REniLiyBgerS/cSnZh10XXjtHkbdF/1ve/+6Ey1BvAvYqIdUstE9oxg9RKkZmx4sFTPvHg2UoAeZ0YwUCKpuVMcIn6Pq9e8ZSv0W22PpPaXvhwNheyLUtfgxC4QqT0ckh2N+0YOtB3oXN5sLT86fEQyVJX0VV+zdeC2LIxkn4pe1t3Qxdgf68FMYGuI2POd6mdJTcqusSxe3cU0lN6nMpfnWKP7Yvrwf5tSMSY1GSYhnMDPvG4YpEAnB6yKcoAowl2teBRDQ7olExRhY1pEQ5sFkzW62v0HisaFrYJ3HN30HzyO7R3zjQ3loycg/AiP6+Ed1oc8WleJ/HRxo7Osn6033BHppcL0Q4aZvEgALj3UeI9LvYEgQ3kDhCxtDTgH8IHzysJt4V+vRXZKS3jUzdGrnsr2qsfu5rnNXGrSFXIvFuy9r8qERz3Efy9IFXxaMHYEtHbI5kQXGmdwsqwTjACKj6b+8klmhpBXlO8JZ7cO2Q1l2Ef1MqBbuP6DtNLnuayRFwO9jM88H0dR1OoCqJeVtmKZ2r5jhU2TSIc0pKztOcRKqC0WpHXEt4Ne1wSzBCEvzUJXHACa+SdhXNhitusrZkmhHoz4mDVmLmNYD4XpDh/D6ngUNpVgw8vtYH24V/CzNCNn6bR/M7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGtSQ2wvMVJlemtKb3BTS0xoZVJybHlLc3QyNDB3TjRwQU85QThPdVZ6aThp?=
 =?utf-8?B?YnpTaUd1VXE0VkJlSmdadjdKdUdiZ0lUaVhpVVRFOVVXeFBQMktHVTJsWlhJ?=
 =?utf-8?B?bWQwVmltbVBzUzA5M3VFbDk4N1hGTktjaUpxc3JaTTJ3VEVTR0ozU1ZWeVY0?=
 =?utf-8?B?aGZXSitnNDhHMk9vaDFMRnNibUJsQVl1TGdoZ0Q0d2FKcUZ0bGtLYmhmSFEw?=
 =?utf-8?B?THBOUlhjaG1IRjdnNXlKNEJnQVNuaVAxVytXTzUvZGgrSldMWDdYZEwvT2tM?=
 =?utf-8?B?ZWk3NEV2WU1JRHZWSmVQN2lESE1vd3BuM3RtcU1LWFZ2MU1ETlF3bFk1MFJu?=
 =?utf-8?B?T1prWmRna013OGgwRzNUcHVId08wUUx0ZTI2SDFjODhwL1RiT0krK0lsQzhw?=
 =?utf-8?B?bkZsbXZnRHo2ZmhoYkV6UFdFVFhpaGJMNElrRjVZaHpscDNHakkrOTBxOUNt?=
 =?utf-8?B?bzlqelExNTJBVDFUVnhWc2hhYytKbVpXdXZLRnZINjNZRVl3U3FmWVpUMkls?=
 =?utf-8?B?b3JtbTJBaDJYSko5SG9EVFhRK0xRRHQ0NjY4TEpDM3BMUHVXUHRVYWw0MmpG?=
 =?utf-8?B?elZsZFV4Ny9GdEFSNDduUEZyczZ3U2pTcVQxcXJuSWpaaXM1OWl1OFpKSm8x?=
 =?utf-8?B?ZFd3MkVRQWdLWWNoOEpHZEg2UUJhbVJVMnhOTWFPMmIyTng4WlVlTFdWOW1p?=
 =?utf-8?B?N0JrQUhsNVN4R3dMQWxPWVZqTmZBdGVxVGlLaC9JN1FNQmgyc0VjVndOaXBY?=
 =?utf-8?B?YjB0R0pLUkc4RmJJTWJSYldDRlZwY2hPdm5NakdZSGdvMlE4ZTlPR3hDMEE0?=
 =?utf-8?B?MWRqQk1qU3p0NVA5OE9TMVdGRlRqWXlFeWxFTkdvQXR1Tkc0L1B5ZlBpTU10?=
 =?utf-8?B?VGFtWndndGUwcW5Cc1RRSk9PNEphS0o4T1VJOFNwbXIycURHdGg5UHQxajli?=
 =?utf-8?B?RzFvTFpkYnlmNmlNZis5M3RPTnB1OEFCV25FRG52bnRKVUZPTVdzeE1EekRS?=
 =?utf-8?B?Nk8vQ3Z4Y2R3Q2ZEbkE3RWtQaStXUnlmMUROM0NvTGRKUU84ODEzSHJyUEE3?=
 =?utf-8?B?SG9GK3MySzRpSklheXFiaDdtMTVGSWJVZ0Q1bmtJK1lsSS9KSE1FcHRRUDJ6?=
 =?utf-8?B?Tk1mZHZXZkMvQ3JMM1hIRlJQOVRnQ3FvdWxFQjBlUWhQZ2JCb2tlOUJBU3Nl?=
 =?utf-8?B?clVsWHZIbVNoaUg2bk8xdm9MVFZuQStod3dadGx5Z2FzMTZMZ210bk00cVFO?=
 =?utf-8?B?MitReHBjK0w4dUR0UVQvVmQ3d0REbk1XUDhqdEE2S25icndWTE1MUnRIWERL?=
 =?utf-8?B?Y3MzWmV6OG5xRzVPTE54VnI4TDVGQlZCNTFKWjVuN0FJZEtZek9VWVFacTNi?=
 =?utf-8?B?NnZIc2JJb3Q2S3F0OHNMM3ZFbjVialFLRzZwdjd0SENsNnNIaFR3OUl1SnU3?=
 =?utf-8?B?aklKczA1VnFjWWg1VFdqY0RhaFdXaXdNbTlncHBSaWJHR0Jpa09NYXkvbTZB?=
 =?utf-8?B?VFZKWVBwTURka21IWmtnd2MwbXE0K0hIK3ZoN0pGUG5wck0rek5xdU5oT016?=
 =?utf-8?B?c1lVenk5SjFXYTM5YlhBTkF6ZEhJVDFpanBUQ2J4MUxYM25BdWdBSXNMMTBs?=
 =?utf-8?B?Z01WNHJoc1Y1WlV0M3hVVE1FMWZqeGp1anRiSC9VOXdMc21Hc0xWQUdPNzNM?=
 =?utf-8?B?Q2l5a2twYnhhbHlKanViT2pxZDBoWkJnOGJwTmkvZmFTVW43MUtIeWxaZW5X?=
 =?utf-8?B?QlNFZUlTSjhQc2RaNm5tZ2U5c0F4OXFrZEIvT0tJZTBscmxJbTZwZ1gvRTc4?=
 =?utf-8?B?SWI1RVVGd2xVc1dUM1J3ZjRwQVhQQ1JiZDBUNEVpMjRISFU5SG5VcEovMlho?=
 =?utf-8?B?RXZTalBvckZrZDVYaGhBUSswQ1d4SGFJL04yekZjY2MrblFEM2REM3FMWjY3?=
 =?utf-8?B?Q1pxdGZXQit5cC84bXpieWFpNWJuNkJhak12a1hybURmRllCbU9sTUJTWlRT?=
 =?utf-8?B?TjJzRlk1dFZBeGRMTFBsMUl0NHRDTTJ1c2Q5TlU2OVZKYVpMdEYybVphK1BB?=
 =?utf-8?B?ZkE3UzUxamozTDNaZm0vYVcreHhGR1ZST09YMnNSd2VaOFhMNHRrNW01VTFW?=
 =?utf-8?B?ZTlJdWMwR1lWZWlDaWJ1eWFVL0hKZ1ovaWtoNmtuaWFvenZ5RVpqUWlHZ2Yz?=
 =?utf-8?B?ak1EdmhlQmNmTkZLNU9KVXA0NHFTMXhmRDgrUnlMOXVxRzNXNUpVL2pjZkNE?=
 =?utf-8?B?OStGRGpJZGhTU1pqdjM1UXdoaFkzb2EvZ0pOUjBYUU5UK081aEhRSnY1ZXJZ?=
 =?utf-8?B?L2N5ZXZRVmJ0Q1I2RGtOOHZ5Ym4vMXhWWXVWM2hyaHN4Q04yTUgxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1E7D059209B3649B53AF6B4737B8A52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t9XSwGDMUFBZOJ9Lwk+RUSEj6/voiLpHS02kqyatO/2/3iZgkl7ZnIWz0fXAT+GT1zzlJo1XwgskYgIl5H5JbSQCrA6DxFEDRsOPyNPBHfLW3D9X056R80fCiiQsGq+keWbZ74dqq1fB2jO4nU17fgSun9jE7lOB1fqK/kq4/iMQKl5yO6Qh+d7QXJeZTdBZrniDUTNPw3Ox3ZmGMfxDqThZRzPSa3kPJq63Qh5I9MtEHPXPEjO1L8PovO48Ttyvyr0wE84K/kwsaZ8VeXluW5Lz7CwCIJ2IShv5xDHmU4spX4E9XT4bFw2tngKUKU3dC5atAcI5gp+1Zkn+KZ5JzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4e2a3-9600-4651-2bbe-08de90540465
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 01:06:05.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WBFpfj7emlScuoVh/KqmyP/X+mLxx62fQwi0fgSuxjF453aYujD8mE/lGXIxVDuo8v+TVgHSRTob1EijYGjLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7738
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDE3OjQ4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNC8xLzI2IDE3OjQwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiAuLi4NCj4gPiBUaGV5IG1pZ2h0
IG5vdCBjYXJlIGFib3V0IGxvc2luZyB+NTBNIG1lbW9yeSwgdGhvdWdoLCBidXQgdGhhdCdzIGEg
ZGlmZmVyZW50DQo+ID4gc3RvcnksIGFuZCBpdCBjb3VsZCBiZSBtb3JlIGluIHRoZSBmdXR1cmUu
DQo+IA0KPiBJZiBhbnlvbmUgX2RvZXNfIGNhcmUgYWJvdXQgNTBNQiBvZiBtZW1vcnksIEkgZXhw
ZWN0IHRoZXknbGwgc3BlYWsgdXAuDQo+IFVudGlsIHRoZXkgZG8sIGNvdWxkIHdlIHBsZWFzZSBl
cnIgb24gdGhlIHNpZGUgb2YgbGVhc3QgY29tcGxleGl0eT8NCg0KWWVhaCBhZ3JlZWQuDQoNCj4g
DQo+IEknbSBub3QgZXZlbiBzdXJlIHRoZSBLY29uZmlnIGlzIHdvcnRoIGl0IHRvIGJlIGhvbmVz
dC4NCg0KSSBhbSBub3Qgc3VyZSBlaXRoZXIuDQoNCk15IG1haW4gY29tbWVudCBpcyB0byBtYWtl
IHRoZSBjb2RlIG1vcmUgZnJpZW5kbHkgdG8gb3B0LWluIG1vcmUgZmVhdHVyZXMsDQphY3R1YWxs
eS4NCg==
