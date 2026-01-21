Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8933064F;
	Wed, 21 Jan 2026 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962263; cv=fail; b=IBYEy6fa63KKJCEaP2Ycr0Ey3bvJ7Ak2LVXvO4V3MZk3OEFQkNrKdAi1H8OZs+dhFQ9x7y9pfCkcKuKqXfS0RKAbDeTFHgwN9xpGrffnHBIx42Q6v4G8LrBc/C+mxoLpYpLQw8fbrOXluw7C7iyANU1ykCrhWCQn37HGrFId3AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962263; c=relaxed/simple;
	bh=tAAlF5HMEoTFVslmlR2Nvo31rZm5x6+fGgc//bp03HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oiaW5PM+34XwQ6tY5Nq6H56Nstit+UAzWolOGo4JJIKPBiPSAZSERpxOVn2WJUnCXSo9fSWgHKJyo1T9QTamInvmOWl+wN8y2rurIDqjErA60HLeApir2x2olwBKWRzBhtDaMLbdlP8COeJ8uQ52yhW77lM7QG2ZnTTKK5nWiK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ivlrdqiA; arc=fail smtp.client-ip=52.101.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ivlrdqiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xacAR49oOlaNaEwFaqH3KYePBXB4mFQpQhGL2WXC/2dnNvtwZ3zayYg14V1wqkC0ltdxg7beXepihD4zaDe1Kc3Wug3sYdLEAmaR0RNJ0b7K4/OxYyDnTLJ9RGozWCtuSPRcHa/frpwgJWrKlty1EYGrtmo7o6sBo6Hbs8tBZpv4BfRc15nNwJ4k1Njupe7CH+sL2Lq0dENPgfbg3V+hJBVmxyQDyYdO/hOB6tEW/5tRG9QFICK1u69fXQi3Aa6EVB8ZU5OVVClrY2iaDtDFpLh53FD9n8hE7QULV/C0NRhu5r3lf5QfrcxO2pIb0WnH/QSwhzrRHpV9vrn3but8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAAlF5HMEoTFVslmlR2Nvo31rZm5x6+fGgc//bp03HA=;
 b=J6jFbjDbn7DivCnqNRH2K2GxufM0UHQtmITAsZO6k545GesBhKaSQItx7338hTq0SBoIbZVKsnOka2kPK96mGLrJnKuFLHAKu5ieFBz4hg+z6tu6L0wxWc84dL8YtCsNwf37FfPTSwpXN0wN7wZofrQ/lmMdnW6BFXyFT+9CjWjzquc191p0fav4fEVMTbjy7x5YczB5EHdrp48xamliXTNISfErZUnEkS1Kbl94mMgRQbe+m3GsYrehB6kXlbhlRXdBg5Kzp9MGVq/H9s2TNbQnEpUObzZEBs9iqmrRAlNKDtguk4CxNRyeCCVNkGtjGYC03EeFtLs4pkwyPOMywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAAlF5HMEoTFVslmlR2Nvo31rZm5x6+fGgc//bp03HA=;
 b=ivlrdqiA4fHjJR6ZlnU5UjLSBepZ9diTH/EIf9Ceg2wQ1mysfC0wstAcPoxC14eZ2D8UJ5rF9MDyddnYqmoW4zZa7FjiGIPekVSuJJTmkMCSSjDMVQNd9swvXIoLmfOOKKTdmrM3gGJ87tXZG1+Yt6Xzdi3ZBnURkw4dH3HsB9Hjqk58RGzNkyme/cIhzGrjzcdltYd246saKEjdM9TtnpU5C6fT521lqXzjlnR/fQdSyBHFHfs8HfJ71QySIEXx3ckLYotLHRWG3oNbiMu29ruHpNYn+S69pOWgYj/oVRoeHEQSPJENK9qUHr902M9hQ5u1femDOHlrAK38UNiNkg==
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 02:24:18 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 02:24:18 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Thread-Topic: [PATCH v6 08/11] PCI: dwc: Invoke post_init in
 dw_pcie_resume_noirq()
Thread-Index: AQHcPYCbqB/mIx6Ah0yPq33H8etE97VJVn8AgAA8pLCAAOrjAIARuIaAgAA+2uA=
Date: Wed, 21 Jan 2026 02:24:17 +0000
Message-ID:
 <DU2PR04MB8840F6A7D6AF2E834E46376A8C96A@DU2PR04MB8840.eurprd04.prod.outlook.com>
References: <20260109152750.GA544801@bhelgaas>
 <20260120220441.GA1170239@bhelgaas>
In-Reply-To: <20260120220441.GA1170239@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8840:EE_|DU0PR04MB9252:EE_
x-ms-office365-filtering-correlation-id: cea19595-9698-4f28-6c65-08de58942de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?M1V6bjVPRU5NdHJkR1N6UldiZUw2Z0xFYVpZUitsOGhmYWtZWEVFLzkzMkNP?=
 =?gb2312?B?M0FZQkFjTWYyUzAyU2pQdDY4c3ZHQTJ3aGVUUkc1Sm0ycmFybysxakpVY05D?=
 =?gb2312?B?ZmJBR2IwSnBWYVNlNXRPYnVJb3RJeEU1U1pURVBVQWpKaWgvc3I2ZGVqbWU2?=
 =?gb2312?B?SzV2WG1oNXZuamtZbktXZU1aWHFRSmU1a1NiUWFMdFBUeG53Q1VyRDUxZGp0?=
 =?gb2312?B?N2lNaWtYQ2xDbmxhNUM5MkFXRnpydWNmN21qeDF5MXJ6OGU0VU15K2FTODJk?=
 =?gb2312?B?dEI1bTVlTkw5YkszQ0hibnY4VEZRdzlTeTVLS0J4LzBJSEhPVlVHNThOY0k0?=
 =?gb2312?B?YzNUcThSQUZkSjNBYnRDMTA1ZUtOcHRyOEdLVko4OXRVNlVWU0Z4UUxSblZF?=
 =?gb2312?B?WlNNR3NJN0NzSWVJM0VoM0tld2haTzhDbHAvcjA2SzFWQUxJdUVEWmNyNEtO?=
 =?gb2312?B?ckYzVzg4Sm5pNUgyeXhjTE1IQ0U4TEJabHMvb1ZvRUFCaFF1NTJlNndOUXRk?=
 =?gb2312?B?KzU3QzlySEdYUDFOd3AzT2ducFBNNERLYUJWL0hWWnFqeFJlendDQVIwcUVt?=
 =?gb2312?B?L2dSWnpOUlByVjBBUncwaU0zMFFJc2kwWjVaQ0dFdTFhY3pjYWdmODN4bEdT?=
 =?gb2312?B?RzV5OHdRNCszSmNnTm1pWE1pZlMxYTN2YkFrL0xvOEV0SWhiRisrSW9zYUpJ?=
 =?gb2312?B?UzIrd21sV0o1eHc1ckJlNFRhT2wxVHlOMUJZQk83cy9LR2RadGhpcTlNTWl4?=
 =?gb2312?B?dnpHeUFISk1HUUh5RjFVYmZzczgzMXJlbGZ0ZDM2Tml4MFJuVTJLSGpaZU9r?=
 =?gb2312?B?Q1NDS0ExTkFkNjZFUjBIaWxQUmpOSVF3TUNqR29zQUFSTlpaTFZyQW9xQjA5?=
 =?gb2312?B?b1J2L09xLzRvMjNLS2VGN2RJQ0NnTWNjNkU1QjdjeWIzRkQ3b21Hek1rMjBn?=
 =?gb2312?B?dG9ubEJqS3JPVHUyc3NUSnVnK3N3QWVXSjlSVWZRRmtmdWRna0tSUXpyQko1?=
 =?gb2312?B?eWVTTzRLWHRYanZuOVZEN3JyTDZjaFdjQk5ycHZ5bko0dUFGbk01aHV3VUxD?=
 =?gb2312?B?ZnhQcFRPUUJFZlBKenpNQ2JaMUN4UnZBU1ZzRFkyaWRkdHFFNFZiZ01vK2NJ?=
 =?gb2312?B?Qnd4aFlSd1Bxc09IdXAxaG0wdDVGQ05SRHYwdldiNjROVHlPLzIzUGJNRjdn?=
 =?gb2312?B?MnErUGQzVHgwUXdSalZLMllqOWVTMW0xeVZWUlBQdTFvTmlOV0ZWY1RJeVNr?=
 =?gb2312?B?USt1NkFERlVkcm05ZEJzUGZiQmpsMlp0V2dKMlkxU09RT0hLZy9UaTJxc21x?=
 =?gb2312?B?d3BLVkNIMXB3elM3UUlDaXhFSkRyUGZQY3FMRGxQWStSK1hjY0swWFFJb3NE?=
 =?gb2312?B?Wm9Yam9TL0gvSzB3LzJ0VHFBZ2tkazU3RWRHc2dFOTBxT0MvSUtGdzZoMmRz?=
 =?gb2312?B?TEY4SXdpYTVpa01QUFc5Q2ZIMllPMTluNkxVSW5JSXBoQ0J0QmxTalFTZUl5?=
 =?gb2312?B?UVRHelN5cjQwVWxjbWRneXE3RENrQjJUd01QM1dQNUlFR0h5NVd6R21YbHFF?=
 =?gb2312?B?WDlITThLNUxZL0lMMEpreXdzSThHeWw0dEEvcW8yS1RncFFTU0orQUtKMFNj?=
 =?gb2312?B?bkZFTithTUV2cHIwM28yQmVaRmZpQm1FcDJBaEJSN3hhNVgxUW5OT2wvbUc2?=
 =?gb2312?B?YlVBYlRqOU9JdFIwV09idmlod1VjWXUvdjFjdWFJdTFJWlY0eUVZcXpWZVUz?=
 =?gb2312?B?NEtuNnlxLzRJMkhEVnZLN2d5Wk9kWGxCTk1lODl0VlZ1YzJrR0xEcnFpWWlS?=
 =?gb2312?B?V3NiNDc3U2l6bmZGRXpMcnJxWUNuK0Q1Vms3QXZDZGZRRUVUNTZTZ1FUN3RM?=
 =?gb2312?B?TTJrV2d3MjY1VmpDTkhEMlQyM1dYTnFkZ0lJTFUyam55eWgrSi9iQUlGOE1M?=
 =?gb2312?B?eXVNRE4wMjBuVzB5aUZCYkxoWGphc2V2TjIvZWRjRXRLOUJTUHJNTXZ5MFV2?=
 =?gb2312?B?MGgrVHVUQis4eDVSUlRVWTY5R2pMZERCb0YrV2ZyaEFjYVZXTWhCVFRyY21T?=
 =?gb2312?B?OEZCc1g1c1JZT0Y5UStuQ01mYkRPaFhEa3Y4ZnhLQWRHRDQ4ZHMyVktZejYy?=
 =?gb2312?Q?rqfM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?L2JpbWVaQllMSXNwbzgyTGhUWEhnWmN5bXdXRWx1TGpZYXVXQ1R2WndoeUdh?=
 =?gb2312?B?Mm5uTGd4dnQ4cDBscnAyanNnTU9MVk1sMThiS2pBQjRJV0wyZW1BeUdodGZt?=
 =?gb2312?B?V0IrRlhKVFNla25MS1dneGNVa0ZrbVFJN3JUdXBUcHA5VStRall2Qk9MMWlR?=
 =?gb2312?B?RFNJdm1EdHRJcnV1cDJmUW9nYm1hVGVYamM4eGdzK1hXejUrbWZyVU5tUGFN?=
 =?gb2312?B?MW1OZWdpZUZSTjYxRklGQWRvUFZ3emY0dzZYZEhaSkdMcjd3a1IyM2pzMUtm?=
 =?gb2312?B?aFZyZjdXTmxyN3ZtTm1CdkdmOGVzT1hDZ3JXbFV5ZHpoa1lidDZiU1gxeWh6?=
 =?gb2312?B?OFpEcU94TzVXa0UrNHJnTFR3UVUwL0pRV0pPOVdoUFNQaTA2bFVwY3I4OTQw?=
 =?gb2312?B?Ujc0UERQd214ZkxFQUVRY280SSs5dXdZWmU0cENZQ0tBWEdBZ1NWV1dOYnRh?=
 =?gb2312?B?ZXJhNWVJTHZITnNYeElSUnJoM0xMckNVbkpLaE1JNVZoNG5HQTRjOWkxSndp?=
 =?gb2312?B?L0s5Tk5qQVRUZEFKKzQ1MzNvQTNSblF1OHJRM2JCcXlYQVBXZERxczFGd21W?=
 =?gb2312?B?S00xUFRDVzdwT0kxOWM2akNKMTFYWlozbEEvcFh5TjZQMXZWRXB2SWNqS1lP?=
 =?gb2312?B?dUt4NWc1U0xwTkVkTTVnSkx3K0xxRG1wZHgwcW10ckwxTGx2Wjg4SEFJRmMx?=
 =?gb2312?B?a1RZTDVVUzRZTWV1YmtmTUZXTDlYZHoyWkVlZS9ha1lWUnB2MEc4OFlTNmx2?=
 =?gb2312?B?ZkN5emF5QW5mV09tYitOcFhSY2ZWUFJWdlgwVERiL1N5b3NHMzFQR3pHTUZI?=
 =?gb2312?B?UVdxS0pISGZDTzY3Q05hV2pwK2hLRzZaV0FVVnlOZnAyNW5GaXlWODlkVUdw?=
 =?gb2312?B?cktCbXA1UDNLTU5ORlBuUXpkYnlNb2FZVm50N0x5eG9oZTUzWnQvSHR1OFhk?=
 =?gb2312?B?akdVMU5RZFE4VENEWC9HbThWczNTYk5sVmlpelFidjh4YUlVb0xBdG4yV05H?=
 =?gb2312?B?RVViVmk1QmxvWXk1bnlvVXFrayt6Qm13OWl3d0JkYW8rUnRSMnBkcVQwTzRH?=
 =?gb2312?B?bUhHeFdFUUVpM01oenJUZGVXNXpORnYrZEJLZGFJSEZ4TkkrcVJ2Z3RpYk5Z?=
 =?gb2312?B?aVFMeWhUc1NTTjFUakZOZUYyR1JEVGhIYjhnVFlpbkFkNFJoaWJVMStwN3V2?=
 =?gb2312?B?VVhaNVdTM0pQUzVqcURDeWdXZG1QUUJ2WXpNTW5zT2Nsc2txd01lbUhaQXZR?=
 =?gb2312?B?VG14djJTdjFGSUMvcndVM0UrNVFkSWNMbXBtb3l3MEFKNnc5dEdLZk5WV05C?=
 =?gb2312?B?djdscEM5US9MQjdPa0kyTjQvTENQVi9nZDVLRytyci83ZExsbzlOQWF5bDk4?=
 =?gb2312?B?MVdiTXUvdURHSE9WN2k5Z2VKM2NkdXlUZHJaRVhCQjY4MXNVVUVuSHJuVFdu?=
 =?gb2312?B?T29XQXFMTklRUjRPUE9xalg4ZzNKUjNNRW51U3B4U2hMSzFFVnVVcmxEUGhW?=
 =?gb2312?B?OWhSeWFRYSswQmhPeGhkKy9lQXRFSU1ITG1kQ0oyYmNkUnFXZDgwZDROZHRH?=
 =?gb2312?B?SDdTNmdSZ2owdVpUT2lCTTdCL1lweWdZUlpQS28vL3VSck4vMDE4Um11S0po?=
 =?gb2312?B?aUZkdktuWWUydHhJUndPNVNHbzNnR0FLTFNWY3I0WEhhaS8wM01sRmRUOVN1?=
 =?gb2312?B?aTU3dUEzcGlYc1hId1VXeUk2VVVzWEtIRldsSGhtSm1mWlJIY2NCRmM5UmxX?=
 =?gb2312?B?a1FuQm9rSmZPSzFwRnMyRVp0N0tURGJWQTB2V25tTGU5dDlLTXdBTnhjdU1s?=
 =?gb2312?B?dm9RbXV6QXA5OU0xUGdyeUt6V3BUeWxnOWx2bmJVUUZmNlpqWmV5U2t6dldQ?=
 =?gb2312?B?dlo5ekNFRnQ4NEE1aTM2OGR4a2l5T3ZCUEFjSGNmRW5ZWFdNOFFFdC8yeUxS?=
 =?gb2312?B?S0tDdTZ2cStSejRIY25DWUd0ejk5NG5sNm9ZRnI1cnozbkNoNm11TlhNU2cy?=
 =?gb2312?B?L3kyNlZvRElqSFlpL3FocjBUWTdWVlhWS0d4bnVDMkpFcThoNFVyVzJqblE2?=
 =?gb2312?B?SnlLTmtpMFhmZWptTllCRGsrREFvSnRvWjkyVGRPV3QwVGFmd1ZoNTBFbmIz?=
 =?gb2312?B?V1gvZTU0Rm1oWUsvU29PZWdFQnZmMVFpZ0R4Tlh4aElpeEpUcU5CNE5UcldP?=
 =?gb2312?B?SHVKNXZmc09SeVRhSmRZYWIrbHBPVTJ1T0V1MmtTd3BsQ3dUajdyYW5Qd1Vn?=
 =?gb2312?B?OTdvRE9VdWt1NGJSSlBOOXRXYmMrMDVBdTVJdXNJZUt3MXBadFhqQ3hRM3hl?=
 =?gb2312?Q?d5MiMXYM91TXYRiMbz?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea19595-9698-4f28-6c65-08de58942de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 02:24:18.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmQWb2cDPjpQ6G0lq/vtXmReNt/mVxaevd1MlHtATK4xiczb8VtQxbTxpWIYfHG2jzt9T1O9CC4jwgqpBaXaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jHUwjIxyNUgNjowNQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0K
PiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9y
ZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA4LzEx
XSBQQ0k6IGR3YzogSW52b2tlIHBvc3RfaW5pdCBpbg0KPiBkd19wY2llX3Jlc3VtZV9ub2lycSgp
DQo+DQo+IE9uIEZyaSwgSmFuIDA5LCAyMDI2IGF0IDA5OjI3OjUwQU0gLTA2MDAsIEJqb3JuIEhl
bGdhYXMgd3JvdGU6DQo+ID4gLi4uDQo+DQo+ID4gVGhlIGN1cnJlbnQgY29tbWl0IGxvZyBmb3Ig
dGhpcyBwYXRjaCBpcyB0aGlzOg0KPiA+DQo+ID4gICBTb21lIFNvQ3MgbGlrZSBpLk1YOTUgcmVx
dWlyZSBlbmFibGluZyBSRUZDTEsgYWZ0ZXIgcmVzdW1pbmcgZnJvbQ0KPiBzdXNwZW5kDQo+ID4g
ICBpbiB0aGVpciBwb3N0X2luaXQgY2FsbGJhY2suIFNvIGludm9rZSB0aGUgY2FsbGJhY2sgYXQg
dGhlIGVuZCBvZg0KPiA+ICAgZHdfcGNpZV9yZXN1bWVfbm9pcnEoKSBpZiBhdmFpbGFibGUuDQo+
ID4NCj4gPiBXaGVuIC5wb3N0X2luaXQoKSBpcyBjYWxsZWQsIHRoZSBsaW5rIGlzIGFscmVhZHkg
dXAgYW5kIFBDSWUgZGV2aWNlcw0KPiA+IGhhdmUgYWxyZWFkeSBiZWVuIGVudW1lcmF0ZWQuICBJ
IHRoaW5rIFJFRkNMSyBpcyByZXF1aXJlZCBmb3IgdGhlIGxpbmsNCj4gPiB0byBjb21lIHVwLCBz
byBpdCBkb2Vzbid0IHNvdW5kIHJpZ2h0IHRvIG1lIHRoYXQgLnBvc3RfaW5pdCgpIHdvdWxkIGJl
DQo+ID4gKmVuYWJsaW5nKiBSRUZDTEsuDQo+DQo+IFRoaXMgbmV2ZXIgZ290IHJlc29sdmVkLg0K
Pg0KPiBodHRwczovL2dpdC5rZXJuZWwvDQo+IC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtl
cm5lbCUyRmdpdCUyRnBjaSUyRnBjaS5naXQlMkZjb21taXQlMkYNCj4gJTNGaCUzRGNvbnRyb2xs
ZXIlMkZkd2MtaW14NiUyNmlkJTNEMTk5YzE4MjIxNjIyJmRhdGE9MDUlN0MwMiU3DQo+IENob25n
eGluZy56aHUlNDBueHAuY29tJTdDYjI3N2Y0OTdhODc1NDU2ODAwMmUwOGRlNTg2ZmViNDQlN0M2
ODZlDQo+IGExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzOTA0NTQzNDg3
MjIyODEyMiU3Q1Vuaw0KPiBub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlk
V1VzSWxZaU9pSXdMakF1TURBd01DSXMNCj4gSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJD
SXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0DQo+IGE9bXMySmtoWVhCVzlZWFJh
RkdvVUlGJTJCUGdwUkN1V0dENkYyJTJGTkRoJTJGMVBVZyUzRCZyZXNlcg0KPiB2ZWQ9MA0KPiBz
YXlzIGlteF9wY2llX2hvc3RfcG9zdF9pbml0KCkgZW5hYmxlcyBSRUZDTEsgYnkgYXBwbHlpbmcg
dGhlDQo+IElNWF9QQ0lFX0ZMQUdfOEdUX0VDTl9FUlIwNTE1ODYgd29ya2Fyb3VuZC4NCj4NCj4g
SSBkb24ndCB0aGluayB0aGF0IGNvbW1pdCBsb2cgaXMgY29ycmVjdC4gIENhbiB5b3UgcGxlYXNl
IHN1cHBseSBzb21lIGNvcnJlY3QNCj4gdGV4dCBmb3IgdGhhdCBjb21taXQ/DQpIaSBCam9ybjoN
CkhvdyBhYm91dCB0aGUgZm9sbG93aW5nIG9uZT8NCiINCkF0IHRoZSBiZWdpbiBvZiB0aGUgZHdf
cGNpZV9yZXN1bWVfbm9pcnEoKSwgUkVGQ0xLIG9mIGkuTVg5NSBQQ0llIHdvdWxkIGJlDQpvdmVy
cmlkZGVuIHRvIGFjdGl2ZSBsb3cgdG8gbWFrZSBzdXJlIHRoZSBSRUZDTEsgaXMgcmVhZHkgYmVm
b3JlIFJDIGNvbnRyb2xsZXINCmlzIGluaXRpYWxpemVkLiBBZnRlciB0aGUgaW5pdGlhbGl6YXRp
b24gb2YgUkMgY29udHJvbGxlciBpcyBkb25lIGFuZCBQQ0llDQpsaW5rIGlzIHVwLCBpbnZva2Ug
dGhlIHBvc3RfaW5pdCBjYWxsYmFjayBpZiBhdmFpbGFibGUgdG8gY2xlYXIgdGhlIENMS1JFUSMN
CnNpZ25hbCBvdmVycmlkZSBhY3RpdmUgbG93IHNldHRpbmdzIGlmIHRoZSBzdXBwb3J0LWNsa3Jl
cXMgcHJvcGVydHkgaXMgVFJVRS4NCg0KSXQgcGF2ZXMgdGhlIHdheSB0byBzdXBwb3J0IHRoZSBD
TEtSRVEjIHRvZ2dsaW5nIG1hbmRhdG9yeSByZXF1aXJlZCBieSBMMVNTLg0KIg0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQoNCj4NCj4gQmpvcm4NCg==
