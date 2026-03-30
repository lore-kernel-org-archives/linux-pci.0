Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5323958D;
	Mon, 30 Mar 2026 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913142; cv=fail; b=NwnC+z55uXIuswKvzCeKb/G2vTzX8NUvw6/dYCQqNOIMjvjO3iRzyKNds4jkfzfHj5EBL6GANOkxA5Xum6T0Axq8MvnyS55ikbUHItVUV8vZE9cT6LrHGjD+/IcY97AwsWxdGDsnf9za9OQOMPRo4RD5IvwBAWN4fqKN+R2aedU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913142; c=relaxed/simple;
	bh=nq8ALRRgkvh86zUqrAanLSpQ0+Y2diCfHvpRToz9FQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ch29PQKIquL3wbJFjqWNo+2aYk6Rlyr8cQAA58SPlAOXzgnJopjDL7oG76sg7PtrvhCHfyeYJmKzhiYiklpgIkp35sjgHzCXWc5QzJJcSwt7L+g5tJ2XTw2YR51xJpfqTui1mT6XVvtYrKoV9bNlSXewp9/T/On7+xf3ZBcIe0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNanmdR7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNanmdR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774913141; x=1806449141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nq8ALRRgkvh86zUqrAanLSpQ0+Y2diCfHvpRToz9FQY=;
  b=eNanmdR76Jc8jt8ECE+W3zdBlCa5BHt9VKru1FwV8Suede+66evpYVOA
   SFyNyOmIR78WhkNGZHKj9zRKAMA7gXc5lhD7ailZP1ivbi+PXzFSI893M
   QcxWimQmTL7WVVe5B08I9GsTIwP34fqrFOfKxNSxsS0gm157RUlN+vdq2
   dOD3OTcgiGNWnZIXgEXtjIGAar9vkNs5WNr1dkp0qj0HPvUqqfpcY6Q92
   PImdN1mATAGe6jQ/WNmO1rKJ9epb0Pbtk8CJ3NBwSjK36MPS5p8CHw3Or
   Loztw6Lbq/V6/SjFB9Tyx81iK5940PAiBe6vO9tykGdWtyY2tO2Hchwit
   Q==;
X-CSE-ConnectionGUID: 1eB5OOs1S2G9fHQ7APOsGw==
X-CSE-MsgGUID: XeqqDItTS6iXL84EXeN7cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75804119"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75804119"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:25:39 -0700
X-CSE-ConnectionGUID: eViEgribRKyK3H60kuilSA==
X-CSE-MsgGUID: p+ebrko3TSauSV7HhUQt/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="226071696"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:25:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:25:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 16:25:36 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvUhjFNk8tuNri7ecJibZaoAQqPoX87IV4duWGIboV169CK8+vNm3OHZIN21QHQyZQYoUzAIj5JhY8RQmIwvQWepOF2wFks18dC+EYQFfWcv9XE3IkXJ4Utp5hX6WmZ5ROKMvXMwxe729otW2Z+OTWKnNlcnHOLeCa4fvnGsmwm35XuV5IAsIcYjbaeuyOAcyJDGRM52JCIZKjsQXcdEK4sBzB/TWKQ+GEqLyaBSk0P8Wpz3IKX0rgvd4vfVZYmysSAHMaPe1pkl6m+XkOiQmNabXV5c1QpZCEZUgIBPWYyPthgNusZjhvVXj3MHyntFUiUqzau8BodRWDCRaCP7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq8ALRRgkvh86zUqrAanLSpQ0+Y2diCfHvpRToz9FQY=;
 b=Bf4XcIgy/RYSSkGd7VsO8RTLh9AbCs/btWOQs5Hrr7DxRz3KHzpLVtjVqV5uA0tru8WuHOOIEgtbOkDLSd4T7LuCUwhQl4QWH8o5WPt6iuqhSGgLOHHIG+IrQafK49ia6TcqyE3GBy1C+qJuyA4HUlSGFgT+rQPRtmRhM3pQHLDfYhez+gAxRcrSHN5JCpCzaGUjE1c3lykbLi8NUXKa7Y0hQKh2Z9BGgwXYX3j6X7KD7KL5SN8+Ebx2Z5C2thJdRjPn4Qi8MEwtmJ9Vz03oiniDFi2uRBLoW97Uf3VWHqksHkHYuXZw+p5UjwzjxJh72FEpEQy6v+aoCyArSumxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 23:25:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 23:25:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for new
 TDX Module objects
Thread-Topic: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Thread-Index: AQHcvgX616NCzLrQvU64gEOMZ9C2QrXDKlAAgAO4zwCAANm3AA==
Date: Mon, 30 Mar 2026 23:25:08 +0000
Message-ID: <23b92a154c859450d106de6c9badbe284e3aa19f.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
	 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
	 <acpPsPivfllpWfv1@yilunxu-OptiPlex-7050>
In-Reply-To: <acpPsPivfllpWfv1@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB6518:EE_
x-ms-office365-filtering-correlation-id: 4661ce29-ae24-4772-773d-08de8eb394f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wgbMaCxNumtOesnr7EmNvKsAW1ZfnTWAjdktMQ1TVdM7p/I54HUlDmoTwh9XT4Haow86+Lm7rt2eHsNn4OEIDPIzzP508fOUtJ4ioRaZAn409ElkFWhv4ZPuXN8rZh/FgNoBd3tywXQqBEY08RIL0/fW8IzQxOF56ME7TapDd31ULyno82+ZcbOqJqJ46wHl6PfRZX+PJnc36azJxKr9uGtPpRepLXc7l9oJWQpmzTTjx5+2OgR2FHWyzL9btt/jaX/QWMTqBhVkGmtZN5a/kJUpC4kOJuYdLE6LXMJKCdVKl9Tx7x8Yu1iYCl4YoeFVLMrPoCCZOVsqjUH7c/XtMHbajSYtJGqwlVdznc8Z+4tSx0b0/5M6DSMpUL0WWCXB4OAm1VizuI2dVJrY4cb+pdxGvJtTr19QADWY4Y9OMsuJG/Vp6BtlkPc8dEqvpr6eTjUg/X95U4KSH2lByedbpqsOvBUOcx6ArNgTWCa7m+AbAj6qPzaxI3DTwTii4WaMVOlsezPlbY7SI63WKnIptnfOQzQY10RfnQngKMLr81EtuEFgXoVGmNwdZM/lOtPE2OtQQ2rmOS9+awYvGuM0OYMx9fV66O4liuIP/22X8e1ukYBkJ1oUhQ0tAIsIPJJ4U9I1dCx4zJCnj3pNox8N2fTAp9L2vfWKcBzO4PYzHOU6fIb0ioDDPP0mwRkDYuBge2T+1e5jD5cctBdfGrXel+nSRCu/O7fVK99LVHTan1so9mgbvi0/YO7PfCnnS07cbjMJ6+VAGum5OjirW68CRb00WgeEe/r0frN29s84Sdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NLU3pmWTNadHBDRVZ2ZjJnZFdlMDg4cngxOWhpVVJ2YWszNVJZcHNiTmhC?=
 =?utf-8?B?OFBBeXVyK1ByZlF6Nkltd0thUkZsWk0xa09vdlp1ZUpWdm9XSTJLTldmRW1Z?=
 =?utf-8?B?bDN2K2NvbE9yMmZYOE1FdkNOZ1pIaWtsNzlOWlJCTDNEMTVJRzUxOWNjM3BT?=
 =?utf-8?B?Z09wWWVvRitra1ZxRDROTkl4cDFoTS9Gd0RVcWphcWlvOFN0QTA3VWRja1M0?=
 =?utf-8?B?cmRuYmlEcUFTbTk3ZVRDZVNySzhTUzl3aHVUZ1kwcDlWV3p0YjZITGRqWE5p?=
 =?utf-8?B?aExRakd5cW9UY1FRUkJHM0RrSWQxMnhDU1ViN1pHcFFjeEkzc1lMbHowem1D?=
 =?utf-8?B?VXdFWFBINVpWd0pLNE82OU8xbk5Yem9ERExEdXEvaGtXcy85Q3BwQlRJSzB6?=
 =?utf-8?B?NFZSenZ1T2plUlRQTFpuZnNlT2ZFTTk4TTdMNzh3UUg0SjB1QVdDTXJCYVlz?=
 =?utf-8?B?RTZUVmlwZDVIVkw0YVMzOU1aaEYxb2k4NzdibTA5UU1xdDBpNWR0WmM0czdD?=
 =?utf-8?B?TS9lcGVSdmxyaURTY1pyQUVhN1JQNUs1YzZ1c2NuQzZMaTVWRXBQS2x1V05M?=
 =?utf-8?B?ZG93YlZRZW1tYy9zZjNESGhPNGRDNG9HK1ZxZEFlU1k4Ris3YmlLdURtVmR3?=
 =?utf-8?B?ZjQ3WGs1bHhVSW5EaUtyWUV4MEEybkRkcVNVNHgxTzZ0UGlWQXF2NGVVZkh1?=
 =?utf-8?B?UDhWeFdRdGRZQ2FmMXJsYjhhVm1kcTV1WCtlcFZIT3BIRWQzTmJtdFI0VGNj?=
 =?utf-8?B?OEM2eUZla20xZ2xjQlFIRDZZUXJrK2d6eXpvM2ZJOEQrbWx1NWM3aDVrelBa?=
 =?utf-8?B?SXNDWENjSU4rRU5MYS94c05zayswQjlnREVyMWdMdFdkZlJ1UTVpU2p4d1cy?=
 =?utf-8?B?dHlQa3R4TU1NOThINWIveXZnb3lHUFl6dGJIcS9BUW03Q25pNkQ0U1JpSXFY?=
 =?utf-8?B?bkl4YVEyTnpjQUY3UXZOV1pzelY1b1lDTUNIWWxkelU3UWpXZUYzRysvY2tt?=
 =?utf-8?B?c2c4YWY0aDNQbjc1UkpMMmVEd05LbDdqd1lxNnRISjB1dTBscmVmOW5VWjcy?=
 =?utf-8?B?V21nUFNCd1VMZEY0M2ptTDZUWk5yUDNVK3ZXWnlIZ2ZmdVJORGNnSDgzd3RL?=
 =?utf-8?B?L0FCQ2xNek02cklTWHFCcHE4YnhyR0ZMVkVBbE9NR0FSOFRtYlh3RTdzV0J3?=
 =?utf-8?B?ZVpjQllHNmk2SzdxVThiWFFpdTQxOTdLcXp2Y0h0Z3ZjT3YvR0gwcW9qUUNw?=
 =?utf-8?B?QTBXS3RHQXBkVGF6bU5VbEh2UFhwb3RWT0xBVjU3Tytzalg1MXN4cnE4cG9Z?=
 =?utf-8?B?QUdkUkJTaVF1MkNlTDRjbTVDa3FsbndxOE9aWUZtTUl4WDQyUmNaU3E5Nlc3?=
 =?utf-8?B?SnN6NmJndWtqSG9qUytQc05SalRBZXEzeFVwWWNBeWVHNS81VUM3T3dOOENm?=
 =?utf-8?B?ZFl6M0VYUllaTFQwYjRPWE5JYWhYdU51NUhVTVRDa21jVlR1RlM4SndIYzVr?=
 =?utf-8?B?a1pmRGRnekN6MzVwaFdVQTNQbmhXLytTTlNrc3RhSmlqYWVBb2JwR1lGRThs?=
 =?utf-8?B?OFVzbThWYklWMHNTZGZpUnM3R0pVdWxndzREbTVsbnlIZ1ZrdEtZSGNCUDNQ?=
 =?utf-8?B?RGdvemdGeThoQXdaRWxrNURWQ0swc2NCaVE2N3E3bVBuWjk2L0JSbjdnRnoz?=
 =?utf-8?B?RlcvV2M3eDFmTkhiclZyWHFqdDI1MkFGWXpIQzVYMzF6WTVjTjU1VTN0bnpn?=
 =?utf-8?B?WDZEWVJMM1F1VnhkUW1VTFF1NWIyTTVQaExydWJkZ3BvcHdUSVE3NDVjZmkx?=
 =?utf-8?B?VnRWcnVkS1diQzF3alFGS3Uvd2x0WTV5UFZrWWFLRURZVVhSV3NiRHRUNWUz?=
 =?utf-8?B?dmVwYWFiekYvcFFWVmZvY1lGVSsrbHhPM2JDWUwrenR6eHp0eENhVDN6WitM?=
 =?utf-8?B?N2NwV0ZCaXlScXliRWF2YjgrUHFlUnY5OGpEV05xbUtEZG53NFUxSUF6aEZK?=
 =?utf-8?B?eDBKSWtERXIzMm05OXFiS3BEbC9PL005dUthV21KbU9WeW9ScFJjSmVPdGdV?=
 =?utf-8?B?bEUySVNiRHExR0NVZW5zN3kzTnZ4M3ZYWk5pU2t3a2VVdTVodlFIZEVNdVM5?=
 =?utf-8?B?T3IyRktGQ054dmdNSGF6TEFOUGZ1c2IzaEtpOXI4U016NXYrdFJONWFGanhN?=
 =?utf-8?B?TjQvT0h6UTFNck01S2d5MVZ0ZjcwaUo3SS9EOFNYbCtqNnZLTVhRSFNBMXdQ?=
 =?utf-8?B?ZHd0QXk3ZDBSMHgzYnFPSzdCZXV0V05mdVNrRTdYaytEamFEWU13Z1lCeHNh?=
 =?utf-8?B?QWlvSDBhTm1uQWR3bTV6VEkxWmE1UytZUGtsZUJXMDhNbVRjdFVtSGt3UDRV?=
 =?utf-8?Q?VFVkB3HB+byzFlpI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5397E1883B096B4F905AF33240D4C828@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QNrtAZvLPAYridixhEcMsXLM7ZJ58qesy3F8Ux0WFlRG9sEygLRjFdZYcL8lARtsr1ieWuvN3XhU75HnCxdTRqH6hOoswXDXVKbBLwfHitq3guGwsttvGzZkeILGWF5ilpK0ln+nzZrpxcxqM1oP5YDBKSA2A77CR9je7jqI3CsoVWuoVnOJXfGn6FkwkKqeIZgixaq5exzo0uhGI/qcVLp98bZBEhcHYQne6dHUJ/qAYUOPtfArmKUwS+B65Oag5V6QiangkaIwkDpe9SmI+anrXmgjOc2cS2BoVn74adsn4+w8udDSgPeanMcC32c20HYSWg4VdciGxg5rAhcrrg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4661ce29-ae24-4772-773d-08de8eb394f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 23:25:08.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4nK9oybOA9QS8dsSdDjXFcM/NDyxPmAjzhoFUvvG5VkJ32eWqK5d/XmqPFqrpZXDPOtYkeEe+RdowVKL7wJHSEdGUKP+WHlyDmgQ+rtHZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE4OjI1ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBP
biBTYXQsIDIwMjYtMDMtMjggYXQgMDA6MDEgKzA4MDAsIFh1IFlpbHVuIHdyb3RlOg0KPiA+ID4g
QWRkIHN0cnVjdCB0ZHhfcGFnZV9hcnJheSBkZWZpbml0aW9uIGZvciBuZXcgVERYIE1vZHVsZSBv
YmplY3QNCj4gPiA+IHR5cGVzIC0gSFBBX0FSUkFZX1QgYW5kIEhQQV9MSVNUX0lORk8uwqANCj4g
PiANCj4gPiBUaGlzIGlzIHVuZm9ydHVuYXRlLiBJIHNlZSB5b3UgYWdyZWUgaW4gdGhlIGNvbW1l
bnRzLg0KPiANCj4gWWVzLCBiYXNpY2FsbHkgdGhleSBhcmUgZGVmaW5pbmcgdGhlIHNhbWUgY29u
Y2VwdCwgYmVoYXZlIG1vc3RseSB0aGUgc2FtZQ0KPiBidXQgc29tZSBkaWZmZXJlbmNlcy4uLg0K
PiANCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhleSBhcmUgdXNlZCBhcyBpbnB1dC9vdXRwdXQNCj4g
PiA+IHBhcmFtZXRlcnMgaW4gbmV3bHkgZGVmaW5lZCBTRUFNQ0FMTHMuIEFsc28gZGVmaW5lIHNv
bWUgaGVscGVycyB0bw0KPiA+ID4gYWxsb2NhdGUsIHNldHVwIGFuZCBmcmVlIHRkeF9wYWdlX2Fy
cmF5Lg0KPiA+ID4gDQo+ID4gPiBIUEFfQVJSQVlfVCBhbmQgSFBBX0xJU1RfSU5GTyBhcmUgc2lt
aWxhciBpbiBtb3N0IGFzcGVjdHMuIFRoZXkgYm90aA0KPiA+ID4gcmVwcmVzZW50IGEgbGlzdCBv
ZiBwYWdlcyBmb3IgVERYIE1vZHVsZSBhY2Nlc3NpbmcuIFRoZXJlIGFyZSBzZXZlcmFsDQo+ID4g
PiB1c2UgY2FzZXMgZm9yIHRoZXNlIDIgc3RydWN0dXJlczoNCj4gPiA+IA0KPiA+ID4gwqAtIEFz
IFNFQU1DQUxMIGlucHV0cy4gVGhleSBhcmUgY2xhaW1lZCBieSBURFggTW9kdWxlIGFzIGNvbnRy
b2wgcGFnZXMuDQo+ID4gPiDCoMKgwqBDb250cm9sIHBhZ2VzIGFyZSBwcml2YXRlIHBhZ2VzIGZv
ciBURFggTW9kdWxlIHRvIGhvbGQgaXRzIGludGVybmFsDQo+ID4gPiDCoMKgwqBjb250cm9sIHN0
cnVjdHVyZXMgb3IgcHJpdmF0ZSBkYXRhLiBURFIsIFREQ1MsIFREVlBSLi4uIGFyZSBleGlzdGlu
Zw0KPiA+ID4gwqDCoMKgY29udHJvbCBwYWdlcywganVzdCBub3QgYWRkZWQgdmlhIHRkeF9wYWdl
X2FycmF5Lg0KPiA+ID4gwqAtIEFzIFNFQU1DQUxMIG91dHB1dHMuIFRoZXkgd2VyZSBURFggTW9k
dWxlIGNvbnRyb2wgcGFnZXMgYW5kIG5vdyBhcmUNCj4gPiA+IMKgwqDCoHJlbGVhc2VkLg0KPiA+
ID4gwqAtIEFzIFNFQU1DQUxMIGlucHV0cy4gVGhleSBhcmUganVzdCB0ZW1wb3JhcnkgYnVmZmVy
cyBmb3IgZXhjaGFuZ2luZw0KPiA+ID4gwqDCoMKgZGF0YSBibG9icyBpbiBvbmUgU0VBTUNBTEwu
IFREWCBNb2R1bGUgd2lsbCBub3QgaG9sZCB0aGVtIGZvciBsb25nDQo+ID4gPiDCoMKgwqB0aW1l
Lg0KPiA+IA0KPiA+IFRoaXMgaXMga2luZCBvZiB2ZXJib3NlIGZvciB3aGF0IGl0IHNlZW1zIHRv
IGJlIHRyeWluZyB0byBzYXkuIEl0J3MganVzdA0KPiA+IHRoYXQNCj4gDQo+IEkgYXNzdW1lIGlm
IHlvdSBmZWVsIHRoZSBleHBsYW5hdGlvbiBvZiAid2hhdCBpcyBjb250cm9sIHBhZ2UiIGlzIG9m
Zg0KPiB0cmFjay4gSSBhZGRlZCBpdCBjYXVzZSB0aGUgdGVybSBmaXJzdGx5IGFwcGVhcnMgaW4g
eDg2IChvbmx5IGluIEtWTQ0KPiBURFggcHJldmlvdXNseSksIGFuZCBwZW9wbGUgYXNrIHRoZSBk
ZWZpbml0aW9uOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NmY2ZiMTYwLWZj
ZDItNGE3NS05NjM5LTVmN2YwODk0ZDE0YkBpbnRlbC5jb20vDQoNCkkgbWVhbnQgaXQgbW9yZSBn
ZW5lcmFsbHkuDQoNCj4gDQo+ID4gdGhlc2UgdHlwZXMgY2FuIGJlIGlucHV0IG9yIG91dHB1dCBw
YXJhbXMuIFRoZSBURFggbW9kdWxlIGNvdWxkIGhvbGQgb24gdG8NCj4gPiB0aGUNCj4gPiBwYWdl
cyBmb3IgYSBsb25nIHRpbWUsIG9yIGp1c3QgdHJhbnNpZW50bHkuDQo+IA0KPiBNbS4uIEknbSB0
cnlpbmcgdG8gcmFtcCB1cCBvbiB0aGUga2VybmVsIEFQSSBsZXZlbCBmbG93Og0KPiANCj4gRm9y
IGNvbnRyb2wgcGFnZXMsIGl0IHdvdWxkIGJlIGhvbGQgYnkgVERYIE1vZHVsZSBsb25nIHRpbWUs
IHNvIGhvc3QNCj4gaW5wdXRzIHRoZSBwYWdlIGFycmF5LCBsYXRlciBURFggTW9kdWxlIG91dHB1
dHMgdGhlIHBhZ2UgYXJyYXkgYmFjay4NCj4gSG9zdCBuZWVkIHRvIHZlcmlmeSB0aGUgb3V0cHV0
cy4NCj4gDQo+IEZvciBzaGFyZWQgcGFnZXMsIFREWCBNb2R1bGUncyBhY2Nlc3NpbmcgaXMgdHJh
bnNpZW50IGluIG9uZSBTRUFNQ0FMTCwNCj4gc28gb25seSBhcyBpbnB1dCwgVERYIE1vZHVsZSBu
ZXZlciBuZWVkcyB0byBvdXRwdXQgdGhlIGFycmF5Lg0KPiANCj4gSSB0aGluayB0aGUgdmVyYm9z
ZW5lc3MgbWFrZXMgdGhlIGZvbGxvd2luZyBwc2V1ZG8gY29kZSBlYXNpZXIgdG8NCj4gdW5kZXJz
dGFuZC4NCj4gDQo+ID4gRm9yIHRoYXQgbGF0dGVyIHBhcnQgSSB0aGluayB5b3UgYXJlDQo+ID4g
dHJ5aW5nIHRvIHNheSBzb21ldGltZXMgdGhleSBuZWVkIGZsdXNoaW5nIGFuZCBzb21ldGltZXMg
dGhleSBkb24ndD8NCj4gDQo+IFllYWguDQo+IGNvbnRyb2wgcGFnZXMgPT4gbG9uZyB0ZXJtID0+
IGhvc3QgdmVyaWZpZXMgYW5kIHJlbGVhc2VzID0+IGZsdXNoIG9uIHJlbGVhc2UNCj4gc2hhcmVk
IHBhZ2VzID0+IHRyYW5zaWVudCA9PiBubyB2ZXJpZnkgYW5kIHJlbGVhc2VzID0+IG5vIGZsdXNo
DQo+IA0KPiBNYXliZSBJIHNob3VsZCBtZW50aW9uIHRoZSBmbHVzaGluZyBpcyBhbHJlYWR5IGNv
dmVyZWQgYnkgcmVsZWFzaW5nDQo+IGtBUEkuDQoNCkkgaGVhcjoNCiAxLiBMb25nIHRpbWUgdnMg
c2hvcnQgdGltZQ0KIDIuIEFjY2Vzc2VkIGFzIHByaXZhdGUgdnMgInNoYXJlZCINCg0KSSB0aGlu
ayAoMikgaXMgdGhlIGltcG9ydGFudCBwb2ludCwgcmlnaHQ/IFdoeSBkb2VzICgxKSBtYXR0ZXI/
DQoNCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhlIDIgc3RydWN0dXJlcyBib3RoIG5lZWQgYSAncm9v
dCBwYWdlJyB3aGljaCBjb250YWlucyBhIGxpc3Qgb2YgSFBBcy4NCj4gPiA+IFRoZXkgY29sbGFw
c2UgdGhlIEhQQSBvZiB0aGUgcm9vdCBwYWdlIGFuZCB0aGUgbnVtYmVyIG9mIHZhbGlkIEhQQXMN
Cj4gPiA+IGludG8gYSA2NCBiaXQgcmF3IHZhbHVlIGZvciBTRUFNQ0FMTCBwYXJhbWV0ZXJzLiBU
aGUgcm9vdCBwYWdlIGlzDQo+ID4gPiBhbHdheXMgYSBtZWRpdW0gZm9yIHBhc3NpbmcgZGF0YSBw
YWdlcywgVERYIE1vZHVsZSBuZXZlciBrZWVwcyB0aGUNCj4gPiA+IHJvb3QgcGFnZS4NCj4gPiA+
IA0KPiA+ID4gQSBtYWluIGRpZmZlcmVuY2UgaXMgSFBBX0FSUkFZX1QgcmVxdWlyZXMgc2luZ2xl
dG9uIG1vZGUgd2hlbg0KPiA+ID4gY29udGFpbmluZyBqdXN0IDEgZnVuY3Rpb25hbCBwYWdlIChw
YWdlMCkuIEluIHRoaXMgbW9kZSB0aGUgcm9vdCBwYWdlIGlzDQo+ID4gPiBub3QgbmVlZGVkIGFu
ZCB0aGUgSFBBIGZpZWxkIG9mIHRoZSByYXcgdmFsdWUgZGlyZWN0bHkgcG9pbnRzIHRvIHRoZQ0K
PiA+ID4gcGFnZTAuIEJ1dCBpbiB0aGlzIHBhdGNoLCByb290IHBhZ2UgaXMgYWx3YXlzIGFsbG9j
YXRlZCBmb3IgdXNlcg0KPiA+ID4gZnJpZW5kbHkga0FQSXMuDQo+ID4gDQo+ID4gInNpbmdsZXRv
biBtb2RlIj8gV2hhdCBpcyBpdD8gSWYgaXQncyB0aGUgY2FzZSBvZiBub3QgbmVlZGluZyBwb3B1
bGF0ZSBsb29wLA0KPiA+IGl0DQo+IA0KPiBJdCBpcyB0aGUgU0VBTUNBTEwgbGV2ZWwgZGV0YWls
IGZvciBIUEFfQVJSQVlfVC4gSXQgaXMgbGl0ZXJhbGx5IGFzDQo+IGV4cGxhaW5lZCBhYm92ZSAt
IHRoZSBIUEEgZmllbGQgc2hvdWxkIGJlIGZpbGxlZCBieSBwYWdlMCwgbm90IHJvb3QgcGFnZS4N
Cj4gDQo+ID4gcHJvYmFibHkgZGVzZXJ2ZXMgbW9yZSBleHBsYW5hdGlvbi4gSSdtIG5vdCBzdXJl
LCBidXQgdGhlIHBvcHVsYXRlIGxvb3ANCj4gPiBzZWVtcyB0bw0KPiA+IGRyaXZlIGEgbG90IG9m
IHRoZSBzdHJ1Y3QgZGVzaWduPw0KPiANCj4gVGhlIGNhbGxlciBpcyBub3QgYXdhcmUgb2Ygc2lu
Z2xldG9uIG1vZGUuIEFjdHVhbGx5LCBJJ20gdHJ5aW5nIHRvIG1ha2UNCj4gdGhlIHRkeF9wYWdl
X2FycmF5IGluZGVwZW5kZW50IG9mIEhQQV9BUlJBWV9UIG9yIEhQQV9MSVNUX0lORk8gZGV0YWls
cw0KPiB3aGVuIGFsbG9jYXRpbmcvcG9wdWxhdGluZywgcm9vdCBwYWdlIGlzIHN0aWxsIHBvcHVs
YXRlZCBldmVuIG5vdCBuZWVkZWQNCj4gZm9yIHNpbmdsZXRvbiBtb2RlLiBUaGUgZGlmZmVyZW5j
ZXMgb25seSBoYXBwZW4gd2hlbiBjb2xsYXBpbmcgdGhlIHN0cnVjdA0KPiBpbnRvIHU2NCBTRUFN
Q0FMTCBwYXJhbWV0ZXJzLg0KDQpJdCBzZWVtcyB0ZHhfcGFnZV9hcnJheSBjb21iaW5lcyB0d28g
Y29uY2VwdHMuIEFuIGFycmF5IG9mIHBhZ2VzLCBhbmQgdGhlIG1ldGhvZA0KdGhhdCB0aGUgcGFn
ZXMgZ2V0IGhhbmRlZCB0byB0aGUgVERYIG1vZHVsZS4gV2hhdCBpZiB3ZSBicm9rZSBhcGFydCB0
aGVzZQ0KY29uY2VwdHM/DQoNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IEFub3RoZXIgc21hbGwg
ZGlmZmVyZW5jZSBpcyBIUEFfTElTVF9JTkZPIGNvbnRhaW5zIGEgJ2ZpcnN0IGVudHJ5JyBmaWVs
ZA0KPiA+ID4gd2hpY2ggY291bGQgYmUgZmlsbGVkIGJ5IFREWCBNb2R1bGUuIFRoaXMgc2ltcGxp
ZmllcyBob3N0IGJ5IHByb3ZpZGluZw0KPiA+ID4gdGhlIHNhbWUgc3RydWN0dXJlIHdoZW4gcmUt
aW52b2tlIHRoZSBpbnRlcnJ1cHRlZCBTRUFNQ0FMTC4gTm8gbmVlZCBmb3INCj4gPiA+IGhvc3Qg
dG8gdG91Y2ggdGhpcyBmaWVsZC4NCj4gPiANCj4gPiBOb3QgY2xlYXIgd2hhdCB0aGlzIGlzIHRh
bGtpbmcgYWJvdXQuIEJ1dCBJJ20gc3RhcnRpbmcgdG8gd29uZGVyIGlmIHdlDQo+ID4gc2hvdWxk
IGJlDQo+ID4gc28gYm9sZCB0byBjbGFpbSB0aGF0IHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRo
ZSB0eXBlcyByZWFsbHkgc2ltcGxpZnkgdGhlDQo+ID4gaG9zdC4gDQo+IA0KPiBJJ20gdGFsa2lu
ZyBhYm91dCBhbm90aGVyIFNFQU1DQUxMIGxldmVsIGRldGFpbC4gU29tZXRpbWVzIFREWCBNb2R1
bGUNCj4gZ290IGludGVycnVwdGVkIGluIHRoZSBtaWRkbGUgb2YgcGFnZSBhcnJheSBwcm9jZXNz
aW5nLCBpdCBuZWVkcyBhbg0KPiBhbmNob3IgdG8gcmVzdW1pbmcgZnJvbSB3aGVyZSBpdCBzdG9w
cywgVERYIE1vZHVsZSByZWNvcmQgdGhlIGFuY2hvcg0KPiBpbiB0aGUgJ2ZpcnN0IGVudHJ5Jy4N
Cj4gDQo+IEJ5IGlsbHVzdHJhdGluZyB0aGVzZSBTRUFNQ0FMTCBsZXZlbCBkaWZmZXJlbmNlcywg
SSB3YW50IHRvIGV4cGxhaW4NCj4gdGhleSBkb24ndCBpbXBhY3QgdGhlIGdlbmVyYWwgU1cgZmxv
dyBhbmQga0FQSSBjYXJlcyBhYm91dCB0aGVtDQo+IGludGVybmFsbHkuDQo+IA0KPiBZZXMgaW4g
UE9DIGNvZGUgd2UgZG8gd3JpdGUgZGVkaWNhdGVkIGNvZGUgZm9yIGVhY2ggdHlwZSwgYnV0IGl0
IGVuZHMgdXANCj4gd2l0aCBwbGVudHkgb2Ygc2ltaWxhciBsb2dpY3Mgb24gY2FsbGVyIHNpZGUg
YWJvdXQgcm9vdCBwYWdlDQo+IG1hbmlwdWxhdGlvbi4gQnkgbm93LCB0aGUgZGlmZmVyZW5jZXMg
YXJlIG5vdCBtdWNoLCBidXQgSSB0aGluayB3ZQ0KPiBzaG91bGQgbm90IHdyaXRlIGNvcGllcyBm
b3IgZXZlcnkgdHlwZSwgd2Ugc2hvdWxkIHN0b3AgbmV3IHR5cGVzLg0KDQpIbW0sIGRvZXNuJ3Qg
aXQgc2VlbSBsaWtlIHRoaXMgaXMgcXVpY2tseSBiZWNvbWluZyBjb21wbGljYXRlZCB0aG91Z2gs
IHRvDQpjb21iaW5lIGFsbCB0aGUgZGlmZmVyZW50IHR5cGVzIHRvZ2V0aGVyPyBBbmQgaXQgc2Vl
bXMgdGhlcmUgYXJlIG1vcmUgY29taW5nDQp0aGF0IHBlb3BsZSB3YW50IHRvIGFkZCB0byB0aGlz
Lg0KDQo+IA0KPiBQbGVhc2UgYWxsb3cgbWUgdG8gc3RvcCBoZXJlLCB3aWxsIGNvbnRpbnVlIGxh
dGVyLi4uDQo+IA0KPiBUaGFua3MuIA0KDQo=
