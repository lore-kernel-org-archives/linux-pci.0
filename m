Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0533DEF9;
	Thu, 22 Jan 2026 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048280; cv=fail; b=hVbGTcvzRR0EmgJRdda4vfUzuOAkrFS1mSrt/4A9CS45XIZcNuj9k8uGu59hkRmRlpgPHChaX9L5nZuQZnsLQMz/todLeck9sYIgR2R1ZeMXdJaEm1yGHcJLb8pskIK8tiscGD/TgJNrva1NnKwRsyiVvC6OLbRTEKTTbHjuGiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048280; c=relaxed/simple;
	bh=GaFZ0DVNfTFhQuHqw+etE8tY6oBw5xoOcc7YLq/SBlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5fcjVaEJjw98m+7aGFURfQJFJbio04Cz4KdFpv1WlgzKM7nifTdP1BW5Mv1AhmExpoRTDgFNh5mgun+CnixxKxjQUaAXRE5+3erCQO6bF53Giy9zK0cbF3uC5el64ojSbVFM5g8Es7WRPd8QCkVD8k8+z5RVU/8nQKyzROtO/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/B5fQ5w; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/B5fQ5w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJR7xIQvezI5hTRvZuh2kDweg8bO713VoOWmkJRW2gxT/LBxY0bAiDzHsCKrNOSga6uzY3sibpPfN7TfmQsgGFKilX3esCfa3Zd7Bjgafoaz/tQibjurLxNmDvFtmCCn/QB+cYtI98+amzbTazdfUMhQosWvg4hu0qelQ1Dh/hrfRwx+GeOfZZXbJu98/ELy20sk2lI3mdhuj4V/Hplu5drgE24JteB8+gxtDE0ndMucoefoFJgBSZIpy5pMh3ChiTRlqSnd0hZMWGgr8oX258WyccSfHsr0/9i/C13jro58uWMqhwfQxjn1q4wgDVr8/UaTQqxg0st7x05jv2HXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaFZ0DVNfTFhQuHqw+etE8tY6oBw5xoOcc7YLq/SBlU=;
 b=BYrTw6f+mnIXx9KgRZn8onNEvciUbBGsJ7/vkkGVMZUKAni4L4tX+xKCoUaWPZZbc98SV8ePq5StoTuM7jgTRajJhtUa7V5TeRyftbB0+XlvhpBmwCCdvZRb04bjc+VDXxkvqkRKi4odpSiZQnoB0HN5izZ1198Go/TSUV5A5EjTmKoNPDZiQWPcNM07WrrHqxOvjyawSD4U1YcyaCFmMTCISTynMfpDb6BnwyUTWqFySBvCNbdvYSfpuFBatZET0tlaFqIfMftxNLTOyBml4xjPeQxK9RqSkhv9TTmDFETgkuVRBJfp8/sxldO9SRezU0eeN63Gb3DFauR8nw24jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaFZ0DVNfTFhQuHqw+etE8tY6oBw5xoOcc7YLq/SBlU=;
 b=j/B5fQ5w704DJC3dwy1t0BoJoVRhvkF/WWm7f1fbr+hJiZeRIV/Iios/imrlZlMPXtJBm7mcfw73LMwugDssTKEREZdTvhuH/PH0cuim13hAZMKYIr1exanMHKD7tlaObERNJh5xFMazONq8FJLCiBzerCP4VLpaU/6TF2DWelLs+OiIWfH3w2xI4hKSDvdX3hmJdAAoV0BMiNjIFK7j6hT33zSQYCaOiqP5f5XQH92wH3CnKXanNlUy9+zzBGdT8Z2+l6hpcDlZrydEYada9omrAdOsx9sDi0XJClD8ZvOsk0wAYudw0eAcXPP/bnBOfiNgLERSsPS2VCtyPRhyLA==
Received: from CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 02:17:54 +0000
Received: from CY5PR12MB6226.namprd12.prod.outlook.com
 ([fe80::469c:f8fd:4a3d:290d]) by CY5PR12MB6226.namprd12.prod.outlook.com
 ([fe80::469c:f8fd:4a3d:290d%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 02:17:54 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Vishal Aslot <vaslot@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Matt Ochs <mochs@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>
Subject: Re: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
Thread-Topic: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
Thread-Index: AQHcilvmmzNyOZxBskaRenXZjDooArVdMZaA//++NoA=
Date: Thu, 22 Jan 2026 02:17:54 +0000
Message-ID: <C109CA60-D346-4EFE-8BC3-C3204C8DED94@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-7-smadhavan@nvidia.com>
 <8b974b31-3ac7-4158-bb25-497a254296bb@intel.com>
In-Reply-To: <8b974b31-3ac7-4158-bb25-497a254296bb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6226:EE_|IA1PR12MB7734:EE_
x-ms-office365-filtering-correlation-id: 2151e1f6-792c-4213-f404-08de595c737b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?blVJTmR2K0xDcGFScTFKQnAyamhHTlVibW9zT0hlQSs3a0dteVdBWlhmVlZB?=
 =?utf-8?B?TEtjakZ3Z01kMmlvbGRIQmoxTVcxYWs5T3F2Ujg4ZUNSN3A2eUN4UGVFM0x1?=
 =?utf-8?B?MlVibHNMN0ZSc3F5NGxBUjhyZnpCTmVhMzlxanNlanZaMm01ejRCVWhNNzBD?=
 =?utf-8?B?N3JWM0E2aEVsM0luQlduNlpCU1h5UmpXdnJWbzM0cGJzOUVDRjhrUnRmT0hr?=
 =?utf-8?B?bFRWMHJRcXRzWHNscGNzdHA0OGgxeGpSeVZIS0U2Rk5IVEZSdHZHWlNoVlh4?=
 =?utf-8?B?R1NRQkVQYVNlVFBiMVlhNVYxZ1V1MnZnOFVmYis2M3hnV2JST1FkYm1HRkhV?=
 =?utf-8?B?OS8rVlU5bmU3NkZuWXZhaDYwT1I0TFEwbmJQNWdXMjdzOGVyLzNDL0RkRFhV?=
 =?utf-8?B?bjRhb1BXQ09HVzVBbnRVMFJtNGN0bnFVeDVpanZuU0lzc3BjK0R5Ylc5TGFE?=
 =?utf-8?B?a3plWFRYY0VSaXJvOXNFQ3RGREg5ZEJhYkFzejA1U1g3cVJsc2tUZnBLWC9x?=
 =?utf-8?B?VnA4enBjZy9MQWplL2txYklBMkowWm9JNmVNdDNoNU9KMHh5T3JtYU1USzQr?=
 =?utf-8?B?WnlxUElHUXJYMGhUK2dsdU5NVmxCeTFpRlowby9ZOHpTblBQNVRsZ0xHTzd1?=
 =?utf-8?B?MStkN1pSWG1va0ZwWU5pUG9oV3dzbm9NWWt1TW1LU09TZXlHdmdHd3pUbTB6?=
 =?utf-8?B?MmpwVkowRWIvLzl0VFcxdkN1WjZubXR1cDNiTVJlY2RTOVNObFlZWlpra29B?=
 =?utf-8?B?cmxtT3F3YWYwckdQTlFvOHpuT1crdGFRQjhoWkNuMFQ5d3d0ckczdkVZa2hV?=
 =?utf-8?B?QXU4ZG5sOHY4bWhUWFVZckJQWDVVTlRvVUZvN21nQkJvREJTNWUzWUZIRGRa?=
 =?utf-8?B?bHJRMGw0aXQ0cFZwMk9maEpHQ25CdmY2VnFSYWZpTkdobEFWWUoyd3FPQWdk?=
 =?utf-8?B?S28xR2dmQUQrNDZTdVVOc0FqbnRLOXROOGtBSXlkM1hTa3ZZemFZNmNiUGI2?=
 =?utf-8?B?M3l4WFhEbm9ZTXVlSHdMUjZqOVVOYzJ6Q05ldlVyTjdKYlhEc0QzZ21Zeith?=
 =?utf-8?B?OHJudGl2c2tmODRvRHc4Y0xnSDJRb3NPTEtaRHY2aTloZG12UTMzUlNNTFU2?=
 =?utf-8?B?cGk2Y2p5Nlg0ZHNmYis4N3VtSHhGUjFCWGNqaU9qNXhHblgxaFNlR2RTMmlp?=
 =?utf-8?B?Wk93eTdZRjVCRFJjNHdzdEZsT3pIVWtkTEJXWmE5NFdZREdNQXdMeDdRY2d0?=
 =?utf-8?B?bkUvU2JQbnNSckRHTGMzTTJoNm9MQXJiMmdHTGpRQVhkTEg3ZGxPS2tDd1hm?=
 =?utf-8?B?VGUrSExFUW5GQXpDKzNQbExjSjVVak92ZGRmU3NRazR3djFPUG5vUjdwUkJs?=
 =?utf-8?B?bjFrckU2YzFpaTNUNEhGb1NhNzdTSGJLMzZmL0tGZEJLV09VeG9MYytsU1dM?=
 =?utf-8?B?Y1JOb0JVTHNtdE1xQmFtbTU0bDRHQlNUNEJzaWhodk1IMmZ6U011RTFXeVNl?=
 =?utf-8?B?MGd4MWlYWE1kRzBQY0pXajIwRUpIaUZnWHZYcWJ6VTJ3RCtEN3ZuNDBhM09u?=
 =?utf-8?B?S3pIaEFYeEdvdndPdC9wQWp2NUlYckFxMm5tcmxoMlFPejJ2YnR2N2JNcW5Q?=
 =?utf-8?B?alVuY2ZHUlNSd21pWVQ1WTJEZGllS2dpNy92Mkw5T1NtRm84S0xlWUFQbHhE?=
 =?utf-8?B?QVBXUGlydGpiTXA3RHJobDVtZFp5T3FDdFFTRW4xQ0VlREpsSi9GRWJHYkFE?=
 =?utf-8?B?NC9DeWsxWFpIZ2xJalloVUlQSHBhbW9yM3BxSzlkTVhGQWhXSGUzbWlpWkds?=
 =?utf-8?B?UmRza3p5TlN0bGZVRDBrQVpyOHJPNnZiejc3a1IrLzNhNkxIU2s1WVJLV3Ji?=
 =?utf-8?B?UUNLdEY5dmNURWZjbVV3dGgxblZtZlBNa0FkRGtJVTRVeFppQ0Y1cGRQa2ZN?=
 =?utf-8?B?MWpoOGROV0ViUzR5YkJKS0pRaUZWRWxQTEJDblBQcDVTNkFYem8zeWkrMHBK?=
 =?utf-8?B?Qis0U2lWNkZWNlpXeHZJMkN3MDJVZUhQdUpFbDYxcmhLdzhlMENDdEVaYVdM?=
 =?utf-8?B?OTBvbWQ5VEZiMmxiUTF5cHVWOEJmcVloV3hBRmFrUytuODV3MVlSdDVWOEZm?=
 =?utf-8?B?TEY2RXEyRHdLNUl4cVZSNVdJQVoxTC81VXBqazZVbWR5azg2ZDNva01ZNWRo?=
 =?utf-8?Q?sShLTtSE4CE0CVE8F6H0L4kZYcvxIId/PLGh88dLudtH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWNSaGpUc2s3b3JkUXE4a0JSUzlKdFVlSDV1THlaRjJwZ2d5aFFmaTR0NEFv?=
 =?utf-8?B?c1l2alZMaXYxS0ZGeHZ4ODFmYXRjL09DeVMwOXFWRnkzb3ZKOGhVRlpwdnpZ?=
 =?utf-8?B?Ylg5dmJtWVlhYWxkMzlHdk9Ua1dKMkV4akRibG9SWmY3enV6MytDUTkvc2Jx?=
 =?utf-8?B?eVl6UnloMCtRMk4wTDRhdUdUVEFMRDhhQ2FPWEMvOGkrSDlLYVpHYlRiQklB?=
 =?utf-8?B?TEltM2FmOGpRdHRDRG9SOUNRVjFQRjZvaUZTUXBScUJYcEpuVG9ZVHVCYWFj?=
 =?utf-8?B?SUdFbWZvUkZtb01XRGwvZzlaZ1dUOWt5SWdhelllRmVoTUQrdFVrYnhmQ3pz?=
 =?utf-8?B?L3NDVTRpQXlkd0xBUFJOKzd3UUpmVnFTcUhwVFdiM1pjYUxmM1VJdERyK3dj?=
 =?utf-8?B?SG9rVnJCNlJpVVMxQlREUEFCTmZPL0o0RWZDT0t3Q3lnRDdZZmFaTnBKL0pU?=
 =?utf-8?B?UW1lS2plMitRS2x6UUI2bjA5bFJDd05OQVByMW9Fb2picWVNbmU2QTJGemRM?=
 =?utf-8?B?eHl1emhDMmlsc1dueVlrdVhPeGczMEszR25QVGozU2gzNnQ5c1ZLOVJvdnV1?=
 =?utf-8?B?aWgwVWhnTDlWenNnbDRqK0hqeHRoNllvT0N5RUptSVNkUURZWnp2OU1zYnpV?=
 =?utf-8?B?d2pJN0Q5ZXhsd1RMZENETHNta3BtZUM5NG1udGxSZis1Y2FlbVZOSUVLeE1h?=
 =?utf-8?B?R2YwVG1kZWpIdWdaeWxKZjZ5VXZrUWtqNjBOT1BJWnMySm9WTkltVTVJK3pO?=
 =?utf-8?B?Ulg4dUMra2hzL2owVjRpTEtTQk92cm5sbm9HRTlocjRkWC9TR0xMQjRBOWE2?=
 =?utf-8?B?YWNBc3Z2L2x4MGVWeE9jQU5teGxlR2o5S2VNOG1yTEdnT1Y3RTkwWk1TRHVh?=
 =?utf-8?B?NkI0OStlSGhMMENyRHljUHJNekk1TWhrSXZQSk9PWkQ5VXNaT0NZYnBHd3Ny?=
 =?utf-8?B?SW9hMjZ2dW1RTkpYRmMvc0JjM1dWUkkwaHpYT2pSSzQ5aGcwQmViQ0wvSEI2?=
 =?utf-8?B?SEU2aUprUjBnT0ppOXJLc05JdDdqMG1rdzVCZTlpRGJnRTFQZER5bTI2TTRL?=
 =?utf-8?B?aHN6MGJYdHpjcERxVkFDek13VTUwMnFkaTBmVWFXeExKMmlKNHdXYVNwc3RN?=
 =?utf-8?B?Uy91dmxiUlRjcWFlZ0VBUVlXQ2xSZTIxYlFqcDV2bzdlam1QTmxNVlhJV3hl?=
 =?utf-8?B?cDVtRk0xSEw4OEFoQ0sxWldRb0pBODUrYUEwODczNnQ3MlVWdjYySG03cjh3?=
 =?utf-8?B?VHExU3krb0V1YjdSc1B3RkJIaVQxbmRJbTZLcmdQTm1UOHg2WUxOZ0dGcWRw?=
 =?utf-8?B?eTVpd0drb09Oc2pWQjVkY3hvSDdLQ3hKaVNublBYd0NhbGhnKzRjZUpwOHpI?=
 =?utf-8?B?NnNhT3NUVjZuTHBkTUFGa0JRaC9SZy9LNUdBRnpyTEtWRDlGRWw5V0tqYzNH?=
 =?utf-8?B?S3NscytlZkM5ZkVaR0piUzVhb0lMVXQ2WEFhY240M05QeGtmbFB5L1lTZnBG?=
 =?utf-8?B?OEtFOHJod0pGMDFwb0FJYU1xOFBrOUNhRjB4UWJFL2ZLNC9ic2NkcGloejJJ?=
 =?utf-8?B?ZTM2b1hqZzFkbHhyREM5YWNLSWIwTkJ1ZmhjMFJIL0kzeDArT3Mzb2prMFlQ?=
 =?utf-8?B?bWl6OXFWbm1FODl6NDk3dmpDWktKKzlKdVg1MzZ1ZWUwSlNKM1NTd0ljN1JB?=
 =?utf-8?B?Y1UyVUU5ZmFCSUIzS0wvRjlrNlRkSXdlenVWSlQrblU1WnZaQ3NMNjJieUNZ?=
 =?utf-8?B?dTdLbS9wMVdXNEdUaklkeGVVUTlCWCtGaDFTbU5jQlkxYXRGaUlrb3R2V3l5?=
 =?utf-8?B?UVUrMWNxUUdRWGxpeUQwV1JwcHVTWXhhZXkrNTlRdlFqQ1RzQlNXTW51SGJa?=
 =?utf-8?B?cUlpZi9zckt5cEFROVRPUXUxQ0dZYUhKQ0lZaTY1ckRiVjYyci9kQ2E4MzF0?=
 =?utf-8?B?NWg1WUtua2pJVGF3aU1KZ3ZMNVBVTTI0RFVSMDd3Zy9DZ0NMZ1NiK290aDEy?=
 =?utf-8?B?bVlKeWlRQzdoRXVLbkdZRWpwREg3TFdiR1hDWlB6QUFlcmV0NTNnTGlBR2dm?=
 =?utf-8?B?WXVBS3dZcmdWcXRXT1VOMHE0QUhXMDNlTkExekFrUGtRV1lhYTlrUmFkMjdU?=
 =?utf-8?B?RkVvWXo4RWdUYUdFOXBkYWx1akF3RmpldUdweDBITDcwVEkvb1FYR0prNWp1?=
 =?utf-8?B?MVptYjM2ajNnRmZEVElxY09XMUp1YU8zZEpvYzlwTGl0V0FoUVRIMUROU2NN?=
 =?utf-8?B?cTE5ejNxTjJtUTRDcGlIdjdnc1dKbU1hRklVN1BhTlpjNnhyejYyU2duWTc2?=
 =?utf-8?B?aFJyNjZJNjQyaXB5dnhCSit6bTZNSE5NWEF6MDQ2bGIrMGxMRFNRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <799F8E6B4877184AA5A5BE4F80E046EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2151e1f6-792c-4213-f404-08de595c737b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 02:17:54.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywtgNyu1WeDmxUBOXJDOv0V91308R2puz6HrsKTa0ltEb9BzjS/yp/9dtFvAijpHe1EmuK0p0bHREL3JbBVGsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

DQoNCu+7v09uIDEvMjEvMjYsIDI6MTQgUE0sICJEYXZlIEppYW5nIiA8ZGF2ZS5qaWFuZ0BpbnRl
bC5jb20gPG1haWx0bzpkYXZlLmppYW5nQGludGVsLmNvbT4+IHdyb3RlOg0KDQoNCj4+IFdpcmUg
Q1hMIHJlc2V0IHByZXBhcmF0aW9uIGFuZCBjbGVhbnVwIGludG8gdGhlIFBDSSBDWEwgcmVzZXQg
cGF0aC4NCj4+IFRoZSBmbG93IG5vdyB2YWxpZGF0ZXMvb2ZmbGluZXMgcmVnaW9ucywgcGVyZm9y
bXMgdGVhcmRvd24gYW5kIGNhY2hlDQo+PiBmbHVzaGVzLCB0aGVuIHJlbGVhc2VzIHRoZSBsb2Nr
IG9uIGNvbXBsZXRpb24gb3IgZXJyb3IuIFRoaXMga2VlcHMgdGhlDQo+PiBjb21tb24gcmVzZXRf
cHJlcGFyZSBmbG93IGludGFjdCB3aGlsZSBhZGRpbmcgY3hsX3Jlc2V0LXNwZWNpZmljIHF1aWVz
Y2UgbG9naWMuDQo+DQo+IENhbiB0aGlzIGJlIG1vdmVkIHRvIHRoZSAtPnJlc2V0X3ByZXBhcmUo
KSBjYWxsYmFjayBvZiAncGNpX2Vycm9yX2hhbmRsZXJzJyByYXRoZXIgdGhhbiBkaXJlY3RseSB3
aXJlIGl0IGludG8gUENJIGNvcmUgY29kZT8gSSBkb24ndCB0aGluayB3ZSB3YW50IGJ1aWxkIGEN
Cj4gZGVwZW5kZW5jeSBvZiBjeGwgY29yZSB0byB0aGUgUENJIGNvcmUuDQoNCkkgdW5kZXJzdGFu
ZCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBpcyBub3QgaWRlYWwuIEJ1dCBJIG9wdGVkIG5v
dCB0byBpbnNlcnQgdGhlIGNhbGwgaW50byAtPnJlc2V0X3ByZXBhcmUoKSBhcyBwY2lfZXJyb3Jf
aGFuZGxlciB3b3VsZCBiZSBpbnZva2VkIGZvciBhbGwgdGhlIG90aGVyIHJlc2V0IG1ldGhvZHMg
KGN4bF9idXMsIEZMUiwgZXRjKS4NCldvdWxkIGl0IGJlIG9rYXkgdG8gaW5jbHVkZSB0aGUgc2Ft
ZSByZXNldCBwcmVwYXJlIHN0ZXBzIChpLmUgcmVnaW9uIHRlYXJkb3duLCBjYWNoZSBmbHVzaCwg
ZXRjKSBpbiB0aGUgY29tbW9uIHJlc2V0IHByZXBhcmU/IA0KDQpUaGFuayB5b3UuDQoNCg==
