Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA528635D;
	Tue, 20 Jan 2026 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948418; cv=fail; b=AwRblr0jvVwupKXD6QThTkdbdfKhmw3Lgxmsu87J6cc23SiEHNN+PyaDwIDkhgoRUFqHwMZWhQNewCSxMiDmyovIs3fW/4bflyGx+NTMHB5xjjK/g1ZmFW0sojy8pEjk1Ufpi7I6N0w2Z4kcdisAQEgsFWb2nPcZS52mO24Fssk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948418; c=relaxed/simple;
	bh=8LrrlbSxFoEq5ksD5yNv38jjmfTcZeVBhVpMucGQcQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4JlGHW8R15jicwYDi4P20K2fWJZ5rkwl+WEyy/gtEdpXEHc9CaYxexIYlX/E7zzDB24yqjhSHD6+4GjjanUdrtPpsQnOjNK0SA0VR+eBYH5bK+OXP0AO/obB3RFq7mAakxnRsYWjllFtK8vW9eq1GNZJbzBh1tqMxs6LM80nKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1QsPvnZ; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1QsPvnZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O25dhlv+FGEdxorIiCEpfOAmQdMj8j93TW5ro3EGTY/P28zhyUx/Iu1x+CGcS2h24SAS3sb/Pkdi83gcpgXd0lPyag1s2/lHZ6rKd3HMgfzMQE6Lke/EQoE8HxmOMenK98Xa6BQeWcekWbxvSZGBzOeOfcVJo4iq3hH0AW9LTov3LN/l+ac1BHxZD1jPwCmdc1IYDRZAF9vDVz7RbFcFFSOvTIql+Wt/UU+lE4zTdcc9g7J/ls1sf7ps2y/qKd0RJCkNTF0vnVUXjeE03YnfeZTkIuXrIoBpdHDdBa8aH2YpwOCMU3vFyB/gAdQ+uLJ5s9McCWF+yKzV5namtbiEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LrrlbSxFoEq5ksD5yNv38jjmfTcZeVBhVpMucGQcQY=;
 b=mKCTttiv2BMgv2abW346/6lYKuGSd0B00951Ej2pTXfBxpXeq8Y+rcibOUKvfwOVOr3bHQNUeXCdKbrRaF1gumIeDAZ+8zDLuzJGQk4hy/VkyyCWexRP9px2WGNrCuKoPGB90B9ua8KPkns4Xwo9nFWwKrDIkt6p47oC5kFNep3ApdpklCgofwVe5KZVVolBdlzMfJku6+IXpqWMP80a+A2oLE771jC4v0aP7BOTqKWLFOBjsLe+E1x1vFoT1h93D9KOvWOVgnDtOBEaNMERvhgDPeehlXhC0Ya8QQ5aFj6+6ck+7rjlxR8AMVva/xMhu1XDOiNTBjTu1eF39Ib0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LrrlbSxFoEq5ksD5yNv38jjmfTcZeVBhVpMucGQcQY=;
 b=s1QsPvnZ4XQv2o7rNzrI4Pp7SSUsntAt2PdQxWsCR/2n1giofdYRplkZo0O0qG2epvLfWnthDTxNlg24ZndNv07sQ8fJkICqqViS5hUuuoGSMlbbjb+HdQCARUaKRBLJhI10e2PH0hOJPJhMtbnU5DkD1c1/qSEeXa6ZB+IhXjRTlI8cmGCLS0Ku59xWuJwAgn4263GuYOGxlMsod5wx7tog4v5UV2O038bvh7ysBItzBbboVQqJVOouJlj2CmLC54qoJss5EGi31CI3BqUhHP5LQHnqEzoVQqiqFFuCyhLA/64IGWPiGknY2RKH5aFD7ZQcrLn5FSa4eePk/pzayQ==
Received: from CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 22:33:22 +0000
Received: from CY5PR12MB6226.namprd12.prod.outlook.com
 ([fe80::469c:f8fd:4a3d:290d]) by CY5PR12MB6226.namprd12.prod.outlook.com
 ([fe80::469c:f8fd:4a3d:290d%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 22:33:22 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, Vikram Sethi
	<vsethi@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Vidya Sagar
	<vidyas@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v3 0/10] CXL reset support for Type 2 devices
Thread-Topic: [PATCH v3 0/10] CXL reset support for Type 2 devices
Thread-Index: AQHcholUpzYGTLanm0ObQ2mvQ0DuarVYhp2AgAMlyt0=
Date: Tue, 20 Jan 2026 22:33:22 +0000
Message-ID:
 <CY5PR12MB62260D968D632960E1422B95C389A@CY5PR12MB6226.namprd12.prod.outlook.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
 <aW1ercZMyqh2Ej5F@aschofie-mobl2.lan>
In-Reply-To: <aW1ercZMyqh2Ej5F@aschofie-mobl2.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6226:EE_|BN5PR12MB9463:EE_
x-ms-office365-filtering-correlation-id: ec40ffe3-09b5-4360-ec2c-08de5873eb39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WityVjV5bXk0UENyVWUwWjlSOStEcXdjL0ZTcU5wSk9uaGpKb2lBbTJCL1Yv?=
 =?utf-8?B?bjhuZWg0RURmNG5CRDVKVjIvYWczeTVhSmdYYzJNbCtaM0ZZbXhxcWx3YmJm?=
 =?utf-8?B?a0lBenIyUlBaZzcwVFlZZllQRHBBV3JKL1BVMzdkR3ZNc0F3R0dqdnJrWHly?=
 =?utf-8?B?ak95QTVxNW5QNGJUU0gyZlMycjYvTitCMzRCVFJTSmdqZUdUQnJMZXNKdE54?=
 =?utf-8?B?Nm1FVFV1V0R3MWZLRU4yVzhldEZTSVBhVG5wcU5zVnpSRlNoQmZON1FMNWJy?=
 =?utf-8?B?RnYramxTQlJhNkxPUFg1OXlHMHBqNDZ6cTRVdGZPSDA1QjRvaUllTUF3WnRw?=
 =?utf-8?B?RmhKeDREY1NnTHpBTkxxQ25KRjFMdG13KzhaREhwOEhMc2FFUnVvL1NRZW03?=
 =?utf-8?B?Smx6eTZuUUxXcC9LMjNJcEphMFo2YW9iVU8yNFF1dXZLRXh6RWUzYUhVQTB3?=
 =?utf-8?B?K2ZUeFdidDhIWUxjaFluSWNINnZHcXYzQ2VwUmd6WWJJTE40YnVKNWx5UDNB?=
 =?utf-8?B?Wk4vNlpkWnIwVFlnbkZDWFpFSmJhMFNheFZ5WlJnVXRUVEEwVkhZYmt5b3RB?=
 =?utf-8?B?b3ZwcTA2bWttU3QxZDEyWXB5RVZEWjIrUENtRnFZWkNpcmxDYUxoRTQyOThw?=
 =?utf-8?B?cVJUQTV5eXBabXVsVWp0V2pWWlBjWGRhSHoybitjV2JvZG9lSzMzVFp5SEs1?=
 =?utf-8?B?UU1tMTRETEFQYk8wZkxOdDFra1R2TzdCVW1ZSjg0aVNBR2l6VTJMQVFMQmIv?=
 =?utf-8?B?dWwyKzRsakkyaXlUVTdRNmZOa216SmhSRnRiRDNDcU95NkdWd0NodE5mcVFI?=
 =?utf-8?B?VU1PNnBtbXkzNWdEeVY0Yi9zUmlGRHM1WktTOTE3TFFTYkJRWjRkdVQ0eis4?=
 =?utf-8?B?Wkh0MEhIRDhadjgrWUVtdVlITzBCTDM3a2lKOTVSOHVTcVlGYU8rSjR5Ynhm?=
 =?utf-8?B?aEQzaDVEcndPNnhPYndjekovQTVrR3I3ZXRYMFU3U29vclhvTFM1WFNuN2NB?=
 =?utf-8?B?QWdBcnZkbWNUQytnWHFvRVdObkVKeUNaNng3OHdIL0p4SjU0UmhuTUxnaklC?=
 =?utf-8?B?ZjYyS3A3V3N1M1N6SFpGZ2JaVnc2ZzNvMFVWSjFobVYrSzFKUlZJL1JuMi9U?=
 =?utf-8?B?YXN0QlgwSGJZeHVnM0gybkNZRk41UGkzT2hnOGU0WFp4MHZMTWNodXRKRk9t?=
 =?utf-8?B?eDhxKzdLTTRaNUF2ZktQb1BVTmgrVXl3VEtsNzBDdnJJb1EzajNNYTlDTk5C?=
 =?utf-8?B?T2QrZUNvd3FQUUQyQ1dMVzc2VjE5QURmNXJxc1huSGJEUHJtUUEyUngvMDhJ?=
 =?utf-8?B?OHBBMmpmaG05T2pNSGczTEZjZzFmMU9iaTlzQWlkdi8vZEVETGRpTm1aSCty?=
 =?utf-8?B?MHI3WGRDeThzYm54TFNCcUNSOWh6RHJVK0RVa2kxZWdZdmE2RkpFaEhWam1J?=
 =?utf-8?B?MWE4S3pZVzIvNEJFNlBDUWtuMjcvY3V6dzN0elZJWndKSFRYanhoZlBJRVdM?=
 =?utf-8?B?SUVmalFodytkSDdzNC9EeHg1WG1NRzZWQTlLckY0NW8vcWRob25HdGs0cXoy?=
 =?utf-8?B?bURsK0lhM295TkROVWZXMU1ZQi9xU2pXTmZYdEsvNG9WMDFXZUR0K09GT01G?=
 =?utf-8?B?OEJCcHA4OFpNcUtUbUVFazFSWHBVcndISXJuZ0tGSUR6WTVIOTNNck5rbTJV?=
 =?utf-8?B?VUYzczNoajUyRDVUZ1JMMlpIdVBIZDRtZWlyR1djKzRZTndyUHE4WnAvSVIw?=
 =?utf-8?B?TU42U2c0OEU2angyV201cFBpbE5aWXhSVEZ1SmdZOEhhZ3FQeEtlWWJSVEpE?=
 =?utf-8?B?MTRqaXowZ3N5WDVlZ0dBZHNDWTFxVG5PbTJ2R1ZOY1JNRlZTT21MQ1R2amZ4?=
 =?utf-8?B?cGQzcTJSalBIZnp3NitHdjNVV3BxYzB0Wnd3dytCYm5TT2RXRFl2ZHF3OGRL?=
 =?utf-8?B?RlZZdFh1cTdwU2Y4NS82eHBjeFhzZmFsdnRFc1h2S1V0VHBCR1MwUHpQcjgz?=
 =?utf-8?B?dGp5ekhyZ29BMG40UWFJUTdUWWFVZklIcURoS1lxV3dSOHZlSXdHdkMvcHR2?=
 =?utf-8?B?UHNlNXV5T3ZWVXpaZ2ZFMWROY2RQcHpsV3pVQWc1dE4xc1Z4aXpaam1HZmhG?=
 =?utf-8?B?SVc5RkRMbnNzS21FcjNLa21mdjFuTlhVLzZjaWx1MDZtRUYwR1V2MHRPemdo?=
 =?utf-8?Q?q1aS/Pv1XGiMaX+tG8KXc78=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWk5TkRwZUNubHNJK0VkWnRueWc3YlBlMlVhZkE4OWNoeEh4RkVwOFdaQkVC?=
 =?utf-8?B?Ump0Tm5uSjZVZWphakVUSWtJZHJyeFVSN0RlL25Ud1RHY0xNbll1NFRsVjhZ?=
 =?utf-8?B?RnpkZk9wTWJHbmdaZFcxUlZXNDRadGJXWGJ4NVdqNzNneXNOTGdJWEN4S3Q1?=
 =?utf-8?B?SU8rYlExU0VDdE00RUZ6VTJHb1pxNldtM1RnZGE2UzltajJtMXd0bEQ5dkpQ?=
 =?utf-8?B?K2hCV0dWcXVDT1FiNGZTMkdaZTV2WTBwR09RZWFGR2ZQQ01tbmpXd1dsMUJs?=
 =?utf-8?B?MXhZdll4OXZXUEdUekYxL094ZTlVZ1R1Zk14dFNwd2ZGeWF1bjdxVFNmSGJQ?=
 =?utf-8?B?dENaY2hIMWwySThUZlBpR3hLaXpmYkFhYlJRNkppT1RralhXblZmc0ZLMTc2?=
 =?utf-8?B?Tnd1MFFHRTlQK2hEazM4WE1Vdk5OWkYwVTRySytTUURXQU0ySUkwRlBKYVcy?=
 =?utf-8?B?TUlUUFd6U0tkT0ZtM1F2eDFTRHlvUTNkL2RvWVZKdHBkeE9ObW9nZy9GbW9C?=
 =?utf-8?B?bUNNbklZREt0UTFsSDlFbXRXelZ6enV3c3c3cGhYVlV0TjhDSldZakM4NTZx?=
 =?utf-8?B?cnpEejV1SHR0cTc1MUFydjJ0V2lQZWVtMUVpQjlNNldXZUppV0VrT2oyOU0z?=
 =?utf-8?B?cHBiMlNsYlRibTFmbFFiZnd4Ny9JcU9XUFdCQnJUSHUvamJXNkl2T0Vyclhh?=
 =?utf-8?B?VzliVUM5VC9pUUlFMjEzeUdtU2lhblNRdHZNZGNkQWRNTnBwUzcyaWN2S1Vr?=
 =?utf-8?B?Nnlwc3ViQ1lZQWZtNldQMUFUUjBYOFczR3d1KzZtd2VQb1A3V1I0SitMR1hj?=
 =?utf-8?B?aGhSNG5SRi9raW03bTg0RDlhSHR1cUVDb05YWm9WNVlqWjFKdFRMbXh6VVhi?=
 =?utf-8?B?VU9oVlliSkxLNCtvZ0RjSTZNbWU1cTNLYk13bG5sbmRIcEJWb2N1Ymg1NHhv?=
 =?utf-8?B?ZU1sVUNTVkJsZmhGS1Y5U3VveGZVSjkzZVd4a3dkZlVuR1dPcXJPclhFR2V5?=
 =?utf-8?B?Ym5lUm1GSHREM1pKR29MMmpwWlpJbEY4bUNaV2NwTEtFV25nVHcwbklFY082?=
 =?utf-8?B?QnNvR0xFdmhwQjNVN1ROT3VmSGN1UmFFZHlzMmNPcm9BQnBZak02Vk5PU1pO?=
 =?utf-8?B?MHFyVTZpTk1RUjJyd2FjRWZESkgyT1IwZmZ4SE1PejVFQU1xT0NXV3ZobVhF?=
 =?utf-8?B?NG1MNE12MXZhWlVCa0pFcWtKbDNoWXl0a1BoaC9RUHFVejNjOG41QlByTXdZ?=
 =?utf-8?B?Qkp4NitDOFdjMVBtRDdMNjBpeWJOekFlTW9rWjRqbkNSN2M5LzlMU3JsYnho?=
 =?utf-8?B?MS8wMWVJTHY4M0JkQmtmTHZnb3U0TzFFUFFnQkhOam5LeDBCMXJxU3lMTHBH?=
 =?utf-8?B?aVlsUkcxNi9DTFZNKzBmV3lKbVZnaldDN3N5OTM5cU9SZVJZSGRRaUhZclFw?=
 =?utf-8?B?ejVLR29HRlUvcHVuZWFDd3RlN3Y1YVVNTDY0UnozbTRwZ2JVbWxnRmZpeVR1?=
 =?utf-8?B?N2l1dHY3WkJ5ZlFudjQ5em82NWRsV2FrODZNYkpscW5BWk5JdndqUlhCenly?=
 =?utf-8?B?Y2xXanlTZnVPbHBPMVNzVVFDT1l3dTJCMjVud3ZXVnVWMjc5T2V2a3FzWjND?=
 =?utf-8?B?WU9pL1NsMVBDVm11Qm9iL1dyb1R1SExWZU83TW9QUW9WT0xsZXJscEIxSjhF?=
 =?utf-8?B?bnFRRmVkSGIwWkFYdVZRSkxDTDFCaFdRZXN6Q3NLT2NPY3pub1hKaUFPejdP?=
 =?utf-8?B?bWJ4blR4OFhyVXl2YTdmTktuV096dEJBM2FVbEhFT0hNcDJiRWNwWUM4N01T?=
 =?utf-8?B?cmh2YXA0WVdsL0FIcFIzMHB3cDNSM2JwR20xVHZIWFAwTjZqN3drenNOTHRu?=
 =?utf-8?B?MXlWclp4aDEyalJXR1AxRDJQSHRmbVZKNU1TQ3QwWUdtQzNxUkVtYzdsWlFw?=
 =?utf-8?B?WDJ2YVNaZmpQM0dFRHpjcUg4azNXb0VFaDdyNVpUZmh3czloenhSMjFYMzRs?=
 =?utf-8?B?MThrTy84c1lCWXF1OG1mRlJVL0xBejRmQnVZbVE0aGN0cGVhWlV3dzQ1bUtK?=
 =?utf-8?B?SDR6Zjh2bE9iVUtPZjBKWlBRbmtWd0plaHppMTdSNTR1TlpoTFlWSmFjc0Vh?=
 =?utf-8?B?U3JXc0NEaThjeTl3WVlrazBPalZMbnhXeFJFQk4vb01hRGdic2xwMnZjRFhu?=
 =?utf-8?B?RU9LOHkxb1JIeDdvMFptRDkrdTZZNFl0NHMwcnlYVnpUTmNmYUlpY0REUFdu?=
 =?utf-8?B?a3ErQTIxVTdXVTJ5bTJvMzJ4UER4WDM4RFRZZnlhTFVyR2N1Yk4vSndBWEl6?=
 =?utf-8?Q?zjawe+fDiOZCBk4RL6?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec40ffe3-09b5-4360-ec2c-08de5873eb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 22:33:22.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfShosRSj576+UTvMJ+ufyvT5aEaEUUBdPXjYKFqNW0mHjU/r9MAm+n/aOGCYR8SKdHozmxF8+2A1BBnd14kEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463

SGkgQWxpc29uLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBoZWFkc+KAkXVwLiBJ4oCZdmUgcmVzcHVu
IHRoZSBzZXJpZXMgYXMgdjQgYW5kIHJlYmFzZWQgaXQgb24gcGNpL25leHQgYXMgbWVudGlvbmVk
IGJ5IHRoZSB0ZXN0Ym90LiBUaGUgdjQgY2hhbmdlcyBhcmUgbGltaXRlZCB0byBidWlsZOKAkWZp
eGVzIGZyb20gdGhlIGJvdCByZXBvcnQgKyBSZXBvcnRlZOKAkWJ5L0Nsb3NlcyBvbiB0aGUgcmVz
ZXQgbWV0aG9kIHBhdGNoLiBBbmQgdGhlIHJlcHJvZHVjZSBzdGVwcyBmcm9tIHRlc3Rib3QgY2xl
YXIgbG9jYWxseSBmb3IgbWUgbm93Lg0KDQpJbiB2NCAmIHYzICwg4oCccmVzZXQgcHJlcGFyZSBh
bmQgcmVnaW9uIHRlYXJkb3du4oCdIGlzIHBhdGNoIDUgKG5vdCA4KS4gSWYgeW91IHN0aWxsIHNl
ZSBhIGJ1aWxkIGZhaWx1cmUgYXQgdGhhdCBwb2ludCwgY291bGQgeW91IHNoYXJlIHRoZSBleGFj
dCBlcnJvci9sb2cgYW5kIHRoZSB0cmVlL2NvbmZpZyB5b3XigJlyZSB1c2luZz8gSeKAmWxsIHRh
a2UgYSBsb29rIHJpZ2h0IGF3YXkuDQoNClRoYW5rcywNClNyaXJhbmdhbg0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBBbGlzb24gU2Nob2ZpZWxkIDxh
bGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NClNlbnQ6IFN1bmRheSwgSmFudWFyeSAxOCwgMjAy
NiAyOjI5IFBNDQpUbzogU3JpcmFuZ2FuIE1hZGhhdmFuDQpDYzogZGF2ZUBzdGdvbGFicy5uZXQ7
IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207IHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsgZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBtaW5nLmxpQHpvaG9tYWlsLmNvbTsgcnJp
Y2h0ZXJAYW1kLmNvbTsgU21pdGEuS29yYWxhaGFsbGlDaGFubmFiYXNhcHBhQGFtZC5jb207IGh1
YWlzaGVuZy55ZUBpbnRlbC5jb207IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IFZpc2hhbCBBc2xvdDsgVmlrcmFtIFNldGhpOyBTaGFua2VyIERv
bnRoaW5lbmk7IFZpZHlhIFNhZ2FyOyBNYXR0IE9jaHM7IEphc29uIFNlcXVlaXJhDQpTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDAvMTBdIENYTCByZXNldCBzdXBwb3J0IGZvciBUeXBlIDIgZGV2aWNl
cw0KDQpFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KDQoNCk9uIEZyaSwgSmFuIDE2LCAyMDI2IGF0IDAxOjQxOjM2QU0gKzAwMDAsIHNtYWRo
YXZhbkBudmlkaWEuY29tIHdyb3RlOg0KPiBGcm9tOiBTcmlyYW5nYW4gTWFkaGF2YW4gPHNtYWRo
YXZhbkBudmlkaWEuY29tPg0KPg0KPiBIaSBmb2xrcyENCj4NCj4gVGhpcyBwYXRjaCBzZXJpZXMg
aW50cm9kdWNlcyBzdXBwb3J0IGZvciB0aGUgQ1hMIFJlc2V0IG1ldGhvZCBmb3IgQ1hMDQo+IGRl
dmljZXMsIGltcGxlbWVudGluZyB0aGUgcmVzZXQgcHJvY2VkdXJlIG91dGxpbmVkIGluIENYTCBT
cGVjIFsxXSB2My4yLA0KPiBTZWN0aW9ucyA5LjYgYW5kIDkuNy4NCg0KSGksDQoNClNlZW1zIHNv
bWV0aGluZyBpcyBtaXNzaW5nIGZyb20gdGhlIHNldCBvciBhIGRlcGVuZGVuY3kgbm90IG5vdGVk
Lg0KSXQgc3RvcHMgY29tcGlsaW5nIGF0IFBhdGNoIDggY3hsOiBhZGQgcmVzZXQgcHJlcGFyZSBh
bmQgcmVnaW9uIHRlYXJkb3duDQoNCi0tIEFsaXNvbg0K
