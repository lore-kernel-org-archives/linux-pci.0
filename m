Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B76473C74;
	Tue, 28 Jul 2026 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269682; cv=fail; b=bXU6/eOE12iVXbuRC6VqNMPVhqAjnop6CILK+Z2mwcopVSBsYLlxB+Jik8w5XSvOYnXFyhBH82IjdIK9eZVYWNAPYBJVXee37zPBVrB72f0R+4VcuV6vhDTCqwuwbURwTEi7CDD+nBmpUz23eydr58M0cZ/vyRHbx2Cd71Cbnro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269682; c=relaxed/simple;
	bh=5Fv1e6UencetRmi5LoB0gVZU53nNPGQnz83hWqbPcgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMA4oifADUejP4he0rgTQYThntypRedNFNSZYlpYryZW9ZR6sVEgTAYKr5f33kdsb+JNLe360hRxDiqpmhXJ9vT7GFoPmJP5yNNfviGJ6UuHHvFHybeE+f1AZy+vk+UiPAziuVR6/OcyYc55iHUESJk+y1hXql91oIdwoaP5PdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO3Lez3o; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO3Lez3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785269681; x=1816805681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Fv1e6UencetRmi5LoB0gVZU53nNPGQnz83hWqbPcgY=;
  b=gO3Lez3oKeazlSGGav1VL+d9s+FgjqVHXsRhn/j57e90xxNvPaUHCZQL
   JgkG/8l7IlvDC5GD4/iUHknQmqYVLwpJGhjBFqpQyt0aGlJRkXOBAHXiX
   XLFzOSXM1kF99wBkleyLUTO9fH3Ab30nszUyMrSUKBQ2GO7f55Vx6YVeJ
   4/FkWdFIEyM6DKytkcu69XFVvYV5tFGFrwfE4GAO84ix4RDaG4i01nNaf
   i5mCkPZYH6X2yZbepASUR2jn8tF+HcKBKAy7vswJ20DuAk1HCBxGm9pMd
   1Tc5rZlklbgNVF1ZxX07nIO7Tzaxe2eWfMHmSHq+nTXj6E/qk38nd6gug
   g==;
X-CSE-ConnectionGUID: UzoT36kUTCyVIvzrZDLpcw==
X-CSE-MsgGUID: z+me0OlFSQSmXHyYyMvPjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="73405688"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="73405688"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 13:14:40 -0700
X-CSE-ConnectionGUID: MNgONgvUSZeVCzrSXtOpkg==
X-CSE-MsgGUID: FtFmv83OSVu+Af5iNEFiaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258025066"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 13:14:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 13:14:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 13:14:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 13:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3JdPm+jgDUccLmAoFkqoqCYZ/MsGyxhHkVm6L0H7ksja0m20PpTH6RmdJqOjXZMCeDQUfBSfeYQ6FopvlGI+lKwMPNT+itR7bxLOwpwswkHPP1MmjEJqgcR2n81rZDe2MRGFG05BejVb8HlYbuDo7zJhW4NOguR9Ap31siN2/hETsyWAawrdrbompR1o663eyHCBsGvCpDlaMcZzqgI6lPUihjzK3JNeurn/KxpqkrQE6cv7+RoqYIHXbdVv8KwbXOMbrEUHtpK0fHpb64PEJIDjZdljZ9XjYA1se6Msjo6cxB26m1OeKa29z7qsnYQVTRXFH5OpsNtHcHYsKqS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fv1e6UencetRmi5LoB0gVZU53nNPGQnz83hWqbPcgY=;
 b=q1qTpLRPEhTIMp7ucPwb3q7zd1Vvn8pU/ikWoVINWXj0B1Y7672SB197aFVf5IbcDrR3QVUG9PjuFQdLBcPTN098CyhepOpB5p0W6FVTEC1HRoVQyv0lxURUCYDmLnTHqz4Sno2ri2VMBTpS0n3v5bC1xW9d68ToXWsCjdx8oC/YYJj9XKhKETiXD+2Z9QWE1kmyqEk/uy0LgJQDNOPpG2FF6pmk9j5nosP9rnFOhUhEne66zN6tGmvCGjrF7ERe4cnW4Aqi4a1KbtWSxM4DuU8pijywjbTUY8YhoOqkbUwh6m8dfjiODu8bHz2adtWESQDm5hLfMnH4ioMzxjfByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by DS4PPF0084F97E3.namprd11.prod.outlook.com (2603:10b6:f:fc02::4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 20:14:36 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 20:14:36 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>, "nika@nikableh.moe"
	<nika@nikableh.moe>
CC: "markpearson@lenovo.com" <markpearson@lenovo.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo
 IdeaPad Pro 5 14IAH10
Thread-Topic: [PATCH] x86/PCI: Disable D3cold on Intel BE200 Wi-Fi on Lenovo
 IdeaPad Pro 5 14IAH10
Thread-Index: AQHdHsyNBIEVAHBMRUG55asmEcpU7baDXdGA
Date: Tue, 28 Jul 2026 20:14:36 +0000
Message-ID: <ec2bc0c14bc036a5e81da6e1fab67a20efe53699.camel@intel.com>
References: <20260728200559.GA1391432@bhelgaas>
In-Reply-To: <20260728200559.GA1391432@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|DS4PPF0084F97E3:EE_
x-ms-office365-filtering-correlation-id: fa0cbb01-1f2a-4452-96d0-08deece4d876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Wgy/irzEFaeFBbtXRIaXiM/dCvojOkAgfz4jkJ0duiW6pI51GHgWhfkV1Dwavak7jQcEoHAuytKFyArd+1uQeloFx97GzE5HlRUKDfbVQ3SKbR1r+196H0Wob5fo0CqR1I0JLyRvwAuf541cjAOpLPDN1csEH86gvd8u+GOfApivjKm2f8Al0i2U46y9yubheCAbylDSDHzsFa41IbsdD53z7QmTrEOH7yxRK9ijCgN0H6H+Mb12FX792vgd57AoyoILxP2K2qOSmutT8XdMNU3yFzrmNvlbyRMeqP6jr9buSX6WOVy3aTqYasjKA+5t9U16uG52GwxMCVY3Nbt6+hBcnQw1f/4oB8uSeQ8hn5P/RePnv5QSo4KUXRzBpdGVj+YUpe/Aha+YMabF8pBqmYvknawZVFXUPmN7r7SE6o/rLJ7vNVQjSXKxjhGDf7zd3J+IZoGvZ2g5p73Pfp1zIqIofX8MWqXOuUT34ElxMAouKN+dXqPz1wXzF8gdaFSVM3zmXti5/Y1i7nQnIWY0fbwPsrNgAlBl8LMwYZ1wFNQEwryfc2N2veGpIGRGbqoiMgah8Z+HFJzDxEhSAqQeWclyGz/9soxNYqnsZM6AUloxc9+2QVXK4UQuVNRytdfOcTqZH08AqQGT8PFO8hznvlOsBmDOme/RJOtQe+ojGprmvLJId+snS/tqHSA0hXgOlQwmpT54wO9LIEmVEP5wb+WX1DwfFSffDT389eRHL6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzlKNkt3ZER2MlJxaUVnN1V2c3JsdXRHME5PRWRUUXg1TDVnTlV1TzB0NHlF?=
 =?utf-8?B?cSsrR3BIdkVneEY4bHVMY1FFMkV2aFRya0NZM01ubUxScVdvbVBOdXNQNVhm?=
 =?utf-8?B?S2RqMktpejZ2Vmt1d3lNaVFUYVBYQis2dDRqdWhTUDJteFUwR3pJWS9tUU5G?=
 =?utf-8?B?ajg5NXgzYWY3OHJpWGZtVHpHeit3K1lOSVNDd01EUURjL0ZxSG5ha2p4RWJ4?=
 =?utf-8?B?SmFVbmdYV2hwdlVLT2pUZmdGNDZLdXlSMHNLR2E4d2ZhYm80WjVzanNVcXl5?=
 =?utf-8?B?a1V3elpxTFh4UUdWekNpNXZITUVhRUVNMzFNZEdEU0NXbVJXWU1ORk9HcTZX?=
 =?utf-8?B?dm5zcENyOUxtK1JpbVhhaUpXSWplenAwTXQxSForY0lSQUNmb21MS1M5K3J1?=
 =?utf-8?B?MWFPaUV3UkN5T3ZzWVA4WWo4dW9CMERydkpmYzI4Q3VYZUNJRFVra2toV1Jy?=
 =?utf-8?B?bnhFOUJ1cHhpdzdycXArRGxwRjhkdUZjN3VZOFNoMVdGeXBYRTVZUU53ekRI?=
 =?utf-8?B?OXRNeVgySEZ6ZEV0NXVUaHBlNkRZeDZTSlh6ZzhlWHdHUG5EYUt5KzNVcDRF?=
 =?utf-8?B?cW5hN0ZQVDFtVzdJczZBaW5qYkRFUXQzQ25sNGNNeVNiTmZYRndTM281OUEr?=
 =?utf-8?B?WXdBSW95ZHRGVmJGWDRrNHZJTkpVTXZTZmNMZ2pWM2F3NUY0WUNxQ0NNd0E2?=
 =?utf-8?B?TFFDVTNIRmxoOUI4dDZZL1E2S1pwUlNaUFhMcE1nZUZuY1Blc1lHYjlZRXlj?=
 =?utf-8?B?QlRrMXBWY0NIdDVYU3ErdzFnZ2tSM1FsRk1kT3MwV2FyOFpzMlNRQnc5WnlP?=
 =?utf-8?B?NGlxdmhkTkErbDZBMVZRKzNuamNxbFRKYVpTVVdMT3pCRGp6MGR0aXlGeDd4?=
 =?utf-8?B?bXdrUHU2alVTc3FiTThxVHVmcWhQZ1l4ZnN3aGhHSTVBbEVFY2I1OFk4c3Nm?=
 =?utf-8?B?d1ozRWh0UnFta2FYbGZXMkVLT24ybXlEck4wWHB3SWVCb2ZHVW1hL0l4Rk8w?=
 =?utf-8?B?RjlwaUx3MTdrZjFWMnRUM2NIVHV2aFZXTlNzdGVjZ1AxRjJSQ3BrRGVzNmNl?=
 =?utf-8?B?QVRiT1RFTjRLWFZZYWg0cEJ5WGNLUURwWFdEdlAzUjgraWtRS1BacHdtS1pS?=
 =?utf-8?B?MkxJZkRRL3BHSUtkOG9Nd1loV0tScExPVlNWbE9KSXRneU9WdVFYZmloeTh4?=
 =?utf-8?B?TGNJNkRsN2xOWEQ3NXlHeFJyTFNLQ3lQRXphNnNMZlVMaXVwRFdSUmtYa1Uw?=
 =?utf-8?B?aHVka0FqU2l5M3ZnTkRFSFY1YTJWUHVXdVl6eUhrWHhRZVoxeCtzMjduVVFl?=
 =?utf-8?B?MXdmaGVsNW5MbjVhOXVNV2tkbDJ3cHo2UVJsditwcFVwdmRMYk8xWWcyRFNl?=
 =?utf-8?B?Yk9NZUVKYk4yNS9UK0piWURQR1gyZkRuZ3BOVmJrYVZwTVlvVDZLVjVWcjFk?=
 =?utf-8?B?Zk9EWXRKRkdSa0dhdlcwanMrZld4SjNmU0NqK0ROUXArcGlKaGFCZTVrSWpI?=
 =?utf-8?B?STdMVk0xQ3pHSmoxOW5rQXJOZ3VBWTRVd3lQKzdUV0YybVZKNG1Vc0l3Wnlo?=
 =?utf-8?B?QjBKZFZ5QjFPSUVnUXk5WXJCL0ZhZzZxeHVYRkhaQXl1UkNHaHBvSm9mWms4?=
 =?utf-8?B?VnJmSWFUQ0phaXZhanpmQkFweEpESDJjcFlrK0lmU3BKU2REbnY1eDJRZjZ6?=
 =?utf-8?B?em1SdXpHKzYvQVE0Y2tGd0pVbjFWR2RqSnF2bWJtcDd0RllmZEl2c1I3ai9V?=
 =?utf-8?B?aEhtTnZtZ2d0QjVuZzdveFFRRnp0K0JEdHllVC9JUGlFR2VCMmlqZFI5YjZy?=
 =?utf-8?B?MUxma1RCT0xYdlZlNGE3VE5QY3d4N09nZnp5Y1N5dDlLN0tKWE13ckpqaXNy?=
 =?utf-8?B?SWhmZDd3T0p4cDFYaEsyYk1Fd2VSSTNvMUptQ2gyVHhIcVlia1pLY0dVTUdl?=
 =?utf-8?B?UGN3WWhYaFlQRkd6ZGZwQjZhZklteFVBWGVQZzBEMTRZZ1RiaUFnQTVEaHEw?=
 =?utf-8?B?MFBSRk9uYjhjaG50ajlrTEs3UnJ4WWFQQUEzMWZQS0RHaWVUdEkzSFEvWHRn?=
 =?utf-8?B?aDZFTHRTUkdiNHpOZjVaRFh5NkFMV1dzNnljYi82YmxFaGJZMXk5TFVqMVpM?=
 =?utf-8?B?NUZzeHFjN2k3YXdxS1JTWUd6dHZmczB5V2NjZXZ2WXJHNXFhallwQXpsbW45?=
 =?utf-8?B?eHJudk81a1ZWc004RWFoSDliMDVqeHc1bll1TE0rV1hUTEdIZkNtN0FkWGpH?=
 =?utf-8?B?RGxIdlkxdktnRm9XSjY1Y1Zoa29iZ0dDYUNzc0pqNWhCWWtSclY3Vk1YM3Mw?=
 =?utf-8?B?WWgreUNmbi9rN3ZHUEJhZzlXWTRoY0VXUGRIbFQwR3pFSmF4U3RablBmS0V6?=
 =?utf-8?Q?irBzlo/MidPwFGdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13C61CCF2B231544A78B77C898F894E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U0R4wR+poOhMZ+hLn57+uP2PKlRfWhNValgSeUc1O9lNcKbyAMPT86D6lv9MfMrQF9FPi0pRtd1rDptdKOoryL2es71tasT2boybgRdrT5V5WiT6JspRO1mUcgdnY2OZvTQhDCN/cO4Vt7j1qGm0gd/gAbRr8VN5jfTi+4W6XOPboni1bBchTx/Gn4qI2P8fL+flB34bXLNGDpMWajkEtHgLXCuU/ojN06e3wp+drHhGWmNPRpxRxAgbZLnSferZcfp1Z6tGEUdFsVTQJISnQqikvK0XdAHzc2CblBCZKjGksfjyeL5j7q72FrVKJDNOVMYr3CS5n9PFwdUc9mwHuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0cbb01-1f2a-4452-96d0-08deece4d876
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 20:14:36.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnHYPUUTjONOaYv4Y40MhQvPpMNTmIMbflbSmkDV6GVIt0rEMlL7vhtASVLi0QcRB4Tf6mSG9Wf57ZKAOYhbKgz2UQ+gzWqO2g7aFF0f3aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0084F97E3
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE1OjA1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIEVtbWFudWVsLCBNYXJrXQ0KPiANCj4gT24gV2VkLCBKdWwgMjIsIDIwMjYgYXQgMDQ6
MTM6MTVBTSArMDIwMCwgTmlrYSBLcmFzbm92YSB3cm90ZToNCj4gPiBPbiB0aGUgTGVub3ZvIElk
ZWFQYWQgUHJvIDUgMTRJQUgxMCwgdGhlIEludGVsIEJFMjAwIFdpLUZpDQo+ID4gKDgwODY6Mjcy
YiwNCj4gPiBpd2x3aWZpKSBmYWlscyB0byBwb3dlciBiYWNrIG9uIGZyb20gRDNjb2xkIGFmdGVy
IGEgc3VzcGVuZC10by1pZGxlDQo+ID4gKHMyaWRsZSkgY3ljbGUuwqAgT24gcmVzdW1lIHRoZSBw
bGF0Zm9ybSByZXBvcnRzIGEgc3VjY2Vzc2Z1bCBBQ1BJDQo+ID4gRDANCj4gPiB0cmFuc2l0aW9u
LCBidXQgdGhlIGRldmljZSBpcyBsZWZ0IHVucG93ZXJlZDogY29uZmlnIHNwYWNlIHJlYWRzDQo+
ID4gYmFjaw0KPiA+IGFzIDB4ZmZmZmZmZmYsIHRoZSBmaXJtd2FyZSByZXNldCB0aW1lcyBvdXQs
IGFuZCB0aGUgd2lwaHkgZmFpbHMgdG8NCj4gPiByZXN1bWU6DQo+ID4gDQo+ID4gwqAgaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IHBvd2VyIHN0YXRlIGNoYW5nZWQgYnkgQUNQSSB0byBEMA0KPiA+IMKg
IGl3bHdpZmkgMDAwMDowMTowMC4wOiByZXN0b3JlIGNvbmZpZyAweDJjOiAweGZmZmZmZmZmIC0+
DQo+ID4gMHgwMGY0ODA4Ng0KPiA+IMKgIGllZWU4MDIxMSBwaHkwOiBQTTogZmFpbGVkIHRvIHJl
c3VtZSBhc3luYzogZXJyb3IgLTExMA0KDQpXZSB0cnkgdG8gYXZvaWQgcmVzZXR0aW5nIHRoZSBm
aXJtd2FyZSBkdXJpbmcgc3VzcGVuZCAvIHJlc3VtZS4gT3V0IG9mDQpjdXJpb3NpdHksIGNhbiB5
b3UgdHJ5IHRvIHJlc2V0IGl0Pw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYw0KYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jDQppbmRleCAyNWY2NDI5OWRhMWQuLmRmY2QzYWQ2MGJk
OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21h
YzgwMjExLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21h
YzgwMjExLmMNCkBAIC04MDYsNyArODA2LDcgQEAgdm9pZCBpd2xfbWxkX21hYzgwMjExX3N0b3Ao
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQpib29sIHN1c3BlbmQpDQogICAgICAgIC8qIGlmIHRo
ZSBzdXNwZW5kIGZsb3cgZmFpbHMgdGhlIGZ3IGlzIGluIGVycm9yLiBTdG9wIGl0IGhlcmUsDQph
bmQgaXQNCiAgICAgICAgICogd2lsbCBiZSBzdGFydGVkIHVwb24gd2FrZXVwDQogICAgICAgICAq
Lw0KLSAgICAgICBpZiAoIXN1c3BlbmQgfHwNCisgICAgICAgaWYgKCFzdXNwZW5kIHx8IHRydWUg
fHwNCiAgICAgICAgICAgIChJU19FTkFCTEVEKENPTkZJR19QTV9TTEVFUCkgJiYNCml3bF9tbGRf
bm9fd293bGFuX3N1c3BlbmQobWxkKSkpDQogICAgICAgICAgICAgICAgaXdsX21sZF9zdG9wX2Z3
KG1sZCk7DQogDQoNCkFub3RoZXIgdGhpbmcuLiBEb2VzIFdpbmRvd3MgcnVuIHRoZSBzYW1lIHN1
c3BlbmQgLyByZXN1bWUgc2VxdWVuY2U/DQpJdCBhbHNvIHVzZXMgRDNjb2xkPyBJJ2QgZXhwZWN0
IExlbm92byB0byBydW4gdGhvcm91Z2ggdmFsaWRhdGlvbiBvbg0KdGhvc2UgZmxvd3Mgb24gV2lu
ZG93cyBhbmQgcmVwb3J0IHBvc3NpYmxlIGJ1Z3MgdG8gdXMuIEkga25vdyB0aGF0IHRoZQ0KV2lu
ZG93cyBkcml2ZXIgZG9lcyBrZWVwIHRoZSBmaXJtd2FyZSBydW5uaW5nLg0KDQo+ID4gDQo+ID4g
VGhlIGRldmljZSBzdGF5cyB1bnVzYWJsZSB1bnRpbCBhIGZ1bGwgcG93ZXIgY3ljbGU7IGFuIGl3
bHdpZmkNCj4gPiBtb2R1bGUNCj4gPiByZWxvYWQgYW5kIGEgUENJIHJlbW92ZS9yZXNjYW4gZG8g
bm90IHJlY292ZXIgaXQsIGNvbmZpcm1pbmcgdGhlDQo+ID4gZGV2aWNlDQo+ID4gaXMgZ2VudWlu
ZWx5IHVucG93ZXJlZCByYXRoZXIgdGhhbiBpbiBhIGJhZCBzb2Z0d2FyZSBzdGF0ZS4NCj4gDQo+
IEkgZ3Vlc3MgdGhpcyBtZWFucyAibHNwY2kgLXhzMDE6MDAuMCIgYWZ0ZXIgcmVzdW1lIHNob3dz
IGFsbCAweGZmPw0KPiANCj4gPiBTZXR0aW5nIHRoZSBkZXZpY2UncyBkM2NvbGRfYWxsb3dlZCB0
byAwIGtlZXBzIGl0IGluIEQzaG90IGFjcm9zcw0KPiA+IHN1c3BlbmQgYW5kIHJlc3VtZXMgcmVs
aWFibHksIHNvIHRoZSBwbGF0Zm9ybSBkb2VzIG5vdCBjb3JyZWN0bHkNCj4gPiByZXN0b3JlDQo+
ID4gcG93ZXIgdG8gdGhlIE0uMiBXaS1GaSBzbG90IG9uIHRoZSBzMmlkbGUgcmVzdW1lIHBhdGgu
wqAgVGhpcw0KPiA+IG1pcnJvcnMgdGhlDQo+ID4gdW50ZXN0ZWQtdmVuZG9yLXRyYW5zaXRpb24g
cGF0dGVybiBhbHJlYWR5IGhhbmRsZWQgZm9yIHRoZSBBc3VzDQo+ID4gQjE0MDANCj4gPiBOVk1l
IChzZWUgYXN1c19kaXNhYmxlX252bWVfZDNjb2xkKTogdGhlIHJlZmVyZW5jZSBPUyBkb2VzIG5v
dA0KPiA+IGFwcGVhciB0bw0KPiA+IGV4ZXJjaXNlIHRoZSBEM2NvbGQtPkQwIHBhdGgsIHNvIGl0
IGlzIGxlZnQgdW50ZXN0ZWQuDQo+ID4gDQo+ID4gQWRkIGEgRE1JLW1hdGNoZWQgZml4dXAgdGhh
dCBmb3JiaWRzIEQzY29sZCBmb3IgdGhlIEJFMjAwIG9uIHRoaXMNCj4gPiBtb2RlbC4NCj4gPiBN
YXRjaCBvbiB0aGUgcHJvZHVjdCByYXRoZXIgdGhhbiB0aGUgQklPUyB2ZXJzaW9uIHNvIHRoZSB3
b3JrYXJvdW5kDQo+ID4gc3Vydml2ZXMgQklPUyB1cGRhdGVzIHRoYXQgZG8gbm90IGFkZHJlc3Mg
dGhlIGlzc3VlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pa2EgS3Jhc25vdmEgPG5pa2FA
bmlrYWJsZWgubW9lPg0KPiA+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC04DQo+
ID4gLS0tDQo+ID4gDQo+ID4gTm90IHN1cmUgYXJjaC94ODYvcGNpL2ZpeHVwLmMgaXMgdGhlIHJp
Z2h0IGhvbWUgdmVyc3VzIGEgUENJIHF1aXJrDQo+ID4gaW4NCj4gPiBkcml2ZXJzL3BjaS9xdWly
a3MuYzsgd291bGQgYmUgaGFwcHkgdG8gbW92ZSBpdC4NCj4gPiANCj4gPiBUaGUgbGF0ZXN0IEJJ
T1MgZnJvbSBMZW5vdm8gZm9yIHRoaXMgbW9kZWwgKFFMQ04zNVdXLCAyMDI1LTEyLTIzKQ0KPiA+
IGlzDQo+ID4gaW5zdGFsbGVkIGFuZCB0aGUgZmFpbHVyZSBpcyBzdGlsbCBwcmVzZW50LCBzbyB0
aGVyZSBpcyBjdXJyZW50bHkNCj4gPiBubw0KPiA+IGZpcm13YXJlLWxldmVsIGZpeC4NCj4gPiAN
Cj4gPiBUZXN0ZWQgb24gdGhlIGFmZmVjdGVkIG1hY2hpbmU6IHdpdGggdGhpcyBwYXRjaCBhcHBs
aWVkIGFuZCBteQ0KPiA+IGxvY2FsDQo+ID4gZDNjb2xkX2FsbG93ZWQ9MCB1ZGV2IHdvcmthcm91
bmQgcmVtb3ZlZCwgdGhlIEJFMjAwIHJlc3VtZXMgZnJvbQ0KPiA+IHMyaWRsZQ0KPiA+IGFjcm9z
cyByZXBlYXRlZCBzdXNwZW5kL3Jlc3VtZSBjeWNsZXMgd2l0aCBubyBpd2x3aWZpIGVycm9ycy4N
Cj4gPiANCj4gPiDCoGFyY2gveDg2L3BjaS9maXh1cC5jIHwgMzMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9wY2kvZml4dXAuYyBiL2FyY2gveDg2L3Bj
aS9maXh1cC5jDQo+ID4gaW5kZXggYjMwMWM2YzhkZjc1Li4zMTE3ZjMxMzkzMGUgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC94ODYvcGNpL2ZpeHVwLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9wY2kvZml4
dXAuYw0KPiA+IEBAIC05OTUsNiArOTk1LDM5IEBAIHN0YXRpYyB2b2lkIGFzdXNfZGlzYWJsZV9u
dm1lX2QzY29sZChzdHJ1Y3QNCj4gPiBwY2lfZGV2ICpwZGV2KQ0KPiA+IMKgfQ0KPiA+IMKgREVD
TEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHg5YTA5LA0KPiA+IGFz
dXNfZGlzYWJsZV9udm1lX2QzY29sZCk7DQo+ID4gwqANCj4gPiArLyoNCj4gPiArICogRGlzYWJs
ZSBEM2NvbGQgb24gdGhlIEludGVsIEJFMjAwIFdpLUZpIG9uIExlbm92byBJZGVhUGFkIFBybyA1
DQo+ID4gMTRJQUgxMA0KPiA+ICsgKg0KPiA+ICsgKiBPbiB0aGlzIHBsYXRmb3JtIHRoZSBCRTIw
MCAoODA4NjoyNzJiKSBmYWlscyB0byBwb3dlciBiYWNrIG9uDQo+ID4gZnJvbSBEM2NvbGQNCj4g
PiArICogYWZ0ZXIgYW4gczJpZGxlIGN5Y2xlOiBhbGwgY29uZmlnIGFuZCBDU1IgcmVhZHMgcmV0
dXJuDQo+ID4gMHhmZmZmZmZmZiwgdGhlDQo+ID4gKyAqIGRyaXZlcidzIGZpcm13YXJlIHJlc2V0
IHRpbWVzIG91dCAoInRpbWVvdXQgd2FpdGluZyBmb3IgRlcNCj4gPiByZXNldCBBQ0sNCj4gPiAr
ICogKGludGFfaHc9MHhmZmZmZmZmZikiKSBhbmQgcmUtcHJvYmUgZmFpbHMgd2l0aCAtRUlPLsKg
IEEgbW9kdWxlDQo+ID4gcmVsb2FkIGFuZCBhDQo+ID4gKyAqIFBDSSByZW1vdmUvcmVzY2FuIGNh
bm5vdCByZXZpdmUgdGhlIGRldmljZTsgb25seSBhIGZ1bGwNCj4gPiBwbGF0Zm9ybSBwb3dlciBj
eWNsZQ0KPiA+ICsgKiBkb2VzLsKgIFRoaXMgbG9va3MgbGlrZSBhbiB1bnRlc3RlZCB0cmFuc2l0
aW9uIGJ5IHRoZSB2ZW5kb3I6DQo+ID4gdGhlIHJlZmVyZW5jZQ0KPiA+ICsgKiBPUyBkb2VzIG5v
dCBhcHBlYXIgdG8gZXhlcmNpc2UgdGhlIEQzY29sZC0+RDAgcGF0aC4NCj4gPiArICoNCj4gPiAr
ICogRm9yYmlkZGluZyBEM2NvbGQga2VlcHMgdGhlIGNhcmQgaW4gRDNob3QgYWNyb3NzIHN1c3Bl
bmQsIHdoaWNoDQo+ID4gcmVzdW1lcw0KPiA+ICsgKiByZWxpYWJseSBhdCB0aGUgY29zdCBvZiBh
IHNtYWxsIGFtb3VudCBvZiBwb3dlciB3aGlsZQ0KPiA+IHN1c3BlbmRlZC7CoCBNYXRjaCBvbg0K
PiA+ICsgKiB0aGUgcHJvZHVjdCBvbmx5IChub3QgdGhlIEJJT1MgdmVyc2lvbikgc28gdGhlIHdv
cmthcm91bmQNCj4gPiBzdXJ2aXZlcyBCSU9TDQo+ID4gKyAqIHVwZGF0ZXMgdGhhdCBkbyBub3Qg
YWRkcmVzcyB0aGUgaXNzdWUuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRt
aV9zeXN0ZW1faWQNCj4gPiBsZW5vdm9fYmUyMDBfYnJva2VuX2QzY29sZF90YWJsZVtdID0gew0K
PiA+ICsJew0KPiA+ICsJCS5tYXRjaGVzID0gew0KPiA+ICsJCQkJRE1JX01BVENIKERNSV9TWVNf
VkVORE9SLA0KPiA+ICJMRU5PVk8iKSwNCj4gPiArCQkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9W
RVJTSU9OLA0KPiA+ICJJZGVhUGFkIFBybyA1IDE0SUFIMTAiKSwNCj4gPiArCQl9LA0KPiA+ICsJ
fSwNCj4gPiArCXt9DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBsZW5vdm9fZGlz
YWJsZV9iZTIwMF9kM2NvbGQoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gK3sNCj4gPiArCWlm
IChkbWlfY2hlY2tfc3lzdGVtKGxlbm92b19iZTIwMF9icm9rZW5fZDNjb2xkX3RhYmxlKSA+DQo+
ID4gMCkNCj4gPiArCQlwY2lfZDNjb2xkX2Rpc2FibGUocGRldik7DQo+ID4gK30NCj4gPiArREVD
TEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgyNzJiLA0KPiA+IGxl
bm92b19kaXNhYmxlX2JlMjAwX2QzY29sZCk7DQo+ID4gKw0KPiA+IMKgI2lmZGVmIENPTkZJR19T
VVNQRU5EDQo+ID4gwqAvKg0KPiA+IMKgICogUm9vdCBQb3J0cyBvbiBzb21lIEFNRCBTb0NzIGFk
dmVydGlzZSBQTUVfU3VwcG9ydCBmb3IgRDNob3QgYW5kDQo+ID4gRDNjb2xkLCBidXQNCj4gPiAt
LSANCj4gPiAyLjU0LjANCj4gPiANCg==
