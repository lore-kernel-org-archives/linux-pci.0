Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957C1B81D3;
	Wed, 11 Feb 2026 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782461; cv=fail; b=LihVcDxMVHBBSr77Zx6dmmYI2oHqwUsHjqZ/SMCMkTru4NjovP4hrG9CDfy2dSoM9c6EZiuUlfPamRXgoBrzGJ8TTKxwNmMsTMlwB1T4rh8gNybhU4kldexftF8g3aW4aLiGBmZkrVqgXs7HMqLIgGJjpro1w+OJYUsFAIVL8lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782461; c=relaxed/simple;
	bh=FahTClKp79MS4Iz/PEpYUqOg2Rs3m207qvixX9SQVfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayDSoSSEPvPK06QQOjXips64+yGA6pRqpZhoomYeFSjoAoG2Giq6UtuqUklvZcRteX9MVRzCy5bVkJ+whOQ2UcTjx0MDmapwyaOQdShlnyxgEiEsRfNSqopBzSw0kRG8TgScX0xx4q1SMnHTuS1Wj58dT6qyy0XPoNie5N0+5FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FnNnPe7o; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yKMoePfh; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FnNnPe7o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yKMoePfh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770782459; x=1802318459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FahTClKp79MS4Iz/PEpYUqOg2Rs3m207qvixX9SQVfI=;
  b=FnNnPe7ooGNg4h0YXr/sdP5soBpw6iCXaSeKiMy0FQfstRWanLca7DbK
   SFmaujcBiGTjRbNw1gOQsrHZCziBCGxeNT6TjTYsYFp6PjiT/AuwYHIeX
   qwx8/fMznffjafWgAT8soip3QV3Cv/+0bWxSiakvsqlbkh/v7Nl/zi/kL
   +CElI78jLtM5PcDeeouN81iyLuD9nnwSnTnyAEi9MWKHCo6OGEeySJNyI
   Jxn/eX3lphnkCvA3MHGadfT/NwTkWPcjedj47365h07Zx5txAXwjhRhtR
   49m292/plvj8as/NcuxAiTgCatr2bdLMnRPE9rYwK7Y1O1vx9FIU3CdLu
   A==;
X-CSE-ConnectionGUID: gkAOnGR3Qaa64x4cd9cizQ==
X-CSE-MsgGUID: YblG4IcLQseeHCzU0aF5fQ==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="141661786"
Received: from mail-westusazon11012031.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.31])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Feb 2026 12:00:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzfOw4D8M+/uy/rdloe/mkQII9T/vAELrk5DhgC7jN/7/xVx9dXlslIyBhq/BmfWKypjWDwXcn6a1aKJWMkmjCLSt7ULUvi8egsUbnJsKn6enz9vjerldOvyifvdHIou5fO8x7fqriujsB7XxK2f9OOxlgnNid6tQvuCcfyvz9ApjFh4GXq5GARdV8grjQxmRrcvmGV5a/B6CqHDILEW0IB4MK2msVM48gBa1Qq0WfWY7WnRVoycb8XPiUfSkmJZ5ct17FWQSQf4+1JBIWW4RG11aDPN207qiYeCSjLxcz73hTq4hhcCAIV7GPKVmHRSwSB0zXdme5QUxnF8/7RGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FahTClKp79MS4Iz/PEpYUqOg2Rs3m207qvixX9SQVfI=;
 b=t1LjYLO5u7VuKMuDUpHX7QqutxIjIBIHDwyPkSWOLon3mERtdmJgG0rystJS3e/zmchRwQvXEP1IPbN1W9cONE8tJAscTNaGYkFI+IwrCIktQ90zY0UFIaaL72qAx2tSaLmF4xWyupZeCZrpvSPMmwMx4HL7MnTwqb01xQA2XQBbTILPvSXWWgV0jDg/EOC+oqAXpxBLdIgpocy2K0kF4XZZNHX0BZfaW6TPZPxS5THvkpOcZrOEZsqXcjH2S+7LdXFMUoEuLmWU5CMqAOwug3neNSxHbD9SugPKk3u3HpXU+IWEtdqGiFejlx6GTFgJVjaUMCQ/uJsZosIUc2/PtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FahTClKp79MS4Iz/PEpYUqOg2Rs3m207qvixX9SQVfI=;
 b=yKMoePfhK1b0YPPUOEZ78iFMZmh6S6+rRaj+6puIo44wDkI7pHezwAJk6KtZpZZjJV9vini7PeAN3rITwJs7wAe4BZEDvOQ9xOuUn5+3t9PBmXgTdrmOUnKIY0y63EcFrk2u8hlCQ5V2JNL87L+sVSFjC1yTnPY46ZseN/cPqTs=
Received: from CO1PR04MB8300.namprd04.prod.outlook.com (2603:10b6:303:157::22)
 by PH0PR04MB8310.namprd04.prod.outlook.com (2603:10b6:510:10a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 04:00:50 +0000
Received: from CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a]) by CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a%6]) with mapi id 15.20.9611.006; Wed, 11 Feb 2026
 04:00:50 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "tmgross@umich.edu" <tmgross@umich.edu>, "benno.lossin@proton.me"
	<benno.lossin@proton.me>, "alistair@alistair23.me" <alistair@alistair23.me>,
	"gary@garyguo.net" <gary@garyguo.net>, "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "aliceryhl@google.com"
	<aliceryhl@google.com>, "ojeda@kernel.org" <ojeda@kernel.org>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
Thread-Topic: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
Thread-Index: AQHcmwbibsQfrYExmkmPAoNhlCt2SrV83/IA
Date: Wed, 11 Feb 2026 04:00:50 +0000
Message-ID: <3886b3aef238a68ad8d8bef5f8ac1d0c3337e112.camel@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	 <20260211032935.2705841-13-alistair.francis@wdc.com>
In-Reply-To: <20260211032935.2705841-13-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR04MB8300:EE_|PH0PR04MB8310:EE_
x-ms-office365-filtering-correlation-id: d52b6675-3126-4711-e7a3-08de69222511
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTY4aktmL2M1V3BLTEV0bXVLRlZuWjBveDVNem9TRXFSeFdabURSN05BMEpL?=
 =?utf-8?B?aTE4a1JObE5ESUdpVzY0OHJJeXM1RkVucGltQ29kWUJuWVdIWE8wTGtJU0Rm?=
 =?utf-8?B?ekRWVUQxdXdZMUhHTGxVemFUaFBUZElPTlhwTTFVT0hnOXJKTTF1TWQ2WlZN?=
 =?utf-8?B?cEZzTFl3dC9FeTNUVjhxNHZXMmNMOVU4eWZhYTlDT21KNkI4ZllUZnZ0NjNu?=
 =?utf-8?B?QnhqUkNJRVpOR3gyZmhUT2V3bGxNM01ZaDBIRDNjSGw5dThxT1ZBYUN6dUgv?=
 =?utf-8?B?Ym1kL3R6RlVETThzNHI0WVJsd2pTakM1ZFFHSjF0UkNVVTlQUUtiTG1FRW9F?=
 =?utf-8?B?d0RNSEpEQkZ2NDhaaUpXVE5QR3R2ZG4wNnB4d3V1clMvRjlXU2lRZUszSzJR?=
 =?utf-8?B?OXR6dmVkeklnNzJkRFVDeDdqUThrQnhQZmZXVnZ6L1kxUDJjTVo0QkhpUnc4?=
 =?utf-8?B?Y1NiRUIwNnpGVkVBaEN4YVNKNjkyTXVQbkRPeExhWVFhVkNiSTk3Sm1nSzd3?=
 =?utf-8?B?a21oQllNUlp0S1Y4UU0vWVJzRHg2QUIzdU9QdXQrVkhaUTM4c2NTZWlPS3Jj?=
 =?utf-8?B?bGdHWWNTLzVReXJBUGwzMTcyYk1MbGR4VFAxMmcxZ2Z2MEozYk0xL2hTRUN2?=
 =?utf-8?B?bDR3cDlHZVl1SnI2QzJtUFBPT3RVajdRZjZaZHFxZXJzRDVrYkNvc1R1V1Iw?=
 =?utf-8?B?aDJncXZOSXgyYUV4TFUxWjBPYmFiQVlsbFhpV2svdkdkaStTWHhTeVNoU1ox?=
 =?utf-8?B?MmlsUzVQa2dXYm5PKzV2NHlkcWpPYUtoUFIvd3pOSWRzUkw5Y1lKSFo4RGFQ?=
 =?utf-8?B?bmgxenloYkcyZlF1a29aNERCRkY2SGcyY3FWTGxnQXh6a2d4UkZIV0lpSDJx?=
 =?utf-8?B?a1IvQUgyWTF6NzBDdi80S0FxTm1ySlpublVLSU8zVnpuNTBpcnU3RllDTGg2?=
 =?utf-8?B?cVVRNUZGcndyRHpqZ1JvVnJ1RkhJNmRQcGs0dVdyU3ROTTVrTW44WTdHcjFU?=
 =?utf-8?B?eTV5YXpWbHFHMzRWMEt4Y21QY1d3eDBXT3U1dXM2T3pRcWtKTGk1aEhaYVZ0?=
 =?utf-8?B?bmozWmxDbnZmdFdLZHBHN2c5eXRxM3hOSTVpaXBmdEpDUzVBbzlJbUl5Vzg0?=
 =?utf-8?B?RURPNytwS3dCMVc3b2w5VFU0Vkt0dGVZN3pHR1dvZzBJRXE3WDlWSW9BODlH?=
 =?utf-8?B?UHcxK3JoL29yWWpPWHFPR2pzVEwxdVlWTjZwbS9HcXUybG9UQWo5WHd3enVj?=
 =?utf-8?B?cjRNUUZMdEw0MGNaU3cxbWE2MzZkWWxSRHdIZnVMV1FkQ05WbnFDZmZEdzZW?=
 =?utf-8?B?Z2hVOUs0c0dubHlvU2ttbVo2ZEZldWFZSlVnZjZKUW9JNmpTUFVodXdKQU5i?=
 =?utf-8?B?QUJZY0NUdmplTWlOTzFHNDEzQitSdjBZYmh0RkFWd0Z6M2V3cEo4MyttaDVx?=
 =?utf-8?B?eGpDaWJjWVMxMmxlQmNFL0ovakR2OGkzVVdtZXNUSHpncHNnNFhySWNBb2cw?=
 =?utf-8?B?YkFtdnNqRUJNeXZtTysrcjc3UHo3cWNFZ0RyWDErd1hCUGRNYzVTS0JrSXdV?=
 =?utf-8?B?Z0xqTlhVWS9KRjlyMDVqWGJzM05wQjZMN2NmcndsVDhQQkVBVFU1Yk1tWWVD?=
 =?utf-8?B?Mmd1V05SQ0owaVRwdURjSXljMkxuYjJHVTI2cnQ3eTBWd3lSdGI2d0s5c3VT?=
 =?utf-8?B?YlY2QzR6d1BvMVRYZ0drWDNJVGNmTHYvNlkwVHBlYkJvVTA5NEllK1JlSmIr?=
 =?utf-8?B?REprNWM5YkFETjl1ZkQ2VVVoclVhRHQxWFM3ZktSRnNpL3NhZ3lHM1JEYzdk?=
 =?utf-8?B?MHVyNEg5TXFkMlB3bWI0d2pSMDNKV2lJRHJWNFNnOTFWSjNreXZENzVQSnZY?=
 =?utf-8?B?MW8yMFNCNzZSSjhmRTZjY0sxcTR6VmpEMEhIRm5TdWxsbEF3WG5TTjUveGo1?=
 =?utf-8?B?bGlIWCtQM1RENlBiMzFIeUw1c1dtcWRkYWwvampETEhwVTlQWjhuTU1UemtN?=
 =?utf-8?B?cGhzeGtmYnp4Q1BVTDFOcG1tWlJlS3BkMGcrazdZU2h3dHpsODJYN3dsV3Zm?=
 =?utf-8?B?M0Iwb201N1pSVWhBTTNiWE15NEFxbllLRmF6T25vZjZzNkNld09TZ3lBY0cw?=
 =?utf-8?B?SE8xSGdpVGY3WHg4d3JGSUxtT1RkRkNSbm5INEFjY2oxSk45dHF5Umt5TG1C?=
 =?utf-8?Q?+x0D6CSqNiSDRgURZ337m+E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR04MB8300.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTMyNE51S0xtTUZ3c29tdUF1My9kbTllMmJING45aEFkSWxPT0JGRlptN2Y2?=
 =?utf-8?B?L0ZRN2dmbURwVXFsTCt2dDVLZGxzS0Y4YzU2NnFldFdJY2U5YUoxZm1nM29m?=
 =?utf-8?B?T056dGd1YlNrODdsS2FWM1JheEVpU0x5d1lrTVNINFFxVkRyVkNTYkxZYkdL?=
 =?utf-8?B?SkZvaThmM3Jvb0VYMTlLekNUS09zQWJ6QWN6ZFZPMDVWNzVmVFBOaFhBM1Fw?=
 =?utf-8?B?K3RNMkZ4L3dlb0p3TU1FSTdpeWZuSU8yRGpqSXZnbFZXbmNPV1ZtcHJJdUNx?=
 =?utf-8?B?YzRxTmpCMTh1ZE1HalR2eUx2L1ozNGVja1VqdGlrWWIweXBwWHJYK2J6c1Za?=
 =?utf-8?B?c1NXbS8ySzF1OHAxWStkaUVvZ3c1OE40WE5BVnJyMkpXRXdlcjNlMGpJR0FR?=
 =?utf-8?B?V205VnlKc0t2YTBtTGVqdUtIVTNhemdYNW1taXJ2U09lUU8yNmZYS2VsWXdL?=
 =?utf-8?B?NndZQWpieDdIb2M4Y2Vubnd4QXVZNnM3RURYMnQ0ZzBQL1Y0dk1QbE1nVTVO?=
 =?utf-8?B?bFovMjdMYmNIRVhLZ1NqZE9YK1ArYlA2ZmNlUGwrcVFQNm9aa2RUNkFiRzM1?=
 =?utf-8?B?aGlNKy85aURSTCtYUWdoODBqalk2dlpSbFludXVBQ3R0TE1STFV5bW1IWENE?=
 =?utf-8?B?N0Nic2I0WWlvc1NreWVzTGRoNkk5WDl1RUpSMEVXSVF3MWNIUEJXMEpnYTFX?=
 =?utf-8?B?WExVTHd5VmxYMHJ5eGZYcUR0Sk50dURibUIwOUIxTmdCSHJwRkZOYjBOT3RY?=
 =?utf-8?B?a1o3THVTazFwYm0wL1JpZkRjakVjSndMdCtPQlRPWUptaXB4YVUxVFRQcE5M?=
 =?utf-8?B?OHRhZkhxeS8vdllLWG15MnJSQXRhNTlJQWZORi8xRThCbGxXUTNXOVoxZWFM?=
 =?utf-8?B?RWxSR3lLZmxPclB6OU1zZll4NU53N3NkZFVCb051akdUUTdMaW9NVjZWVDd0?=
 =?utf-8?B?NGw3bTlBT0tIamZtcWRTd0JMbGZ2aEVqaW03Q1JVMFkwMHcwcnJ6SFBMNVN6?=
 =?utf-8?B?N2Q1Kzlvek9YMENndmNndDZMS1VpNXpZWmRXMnBoSG1mbTkxSE9IY25pMUUz?=
 =?utf-8?B?K212eFN4TjNaU2V5Uml4N211UDRKaUpiR0YraW80VUE0OUdmS09oekdxbGxa?=
 =?utf-8?B?UHVGK0N6ek12VC9XbERraEtGM1IzaGtwdEVEQkJnMnA5YlpzOGNrckcrUzho?=
 =?utf-8?B?alo3K2ZhUTg5Yi91UGxFL0ZGbDVTemxDYW9aN2o3bUxrRjZ2YUZoR0FrWmxT?=
 =?utf-8?B?OTZ0eVF0aURicHVwMG9CeEkxWU1QTTJTVTZKbEQxZnI2djNHU3o2KzdWV3Jv?=
 =?utf-8?B?dTY1RWVaUWM2SHExbTFINUhhaGlaM1NjM0l5UUMwSVFJM0EwZndJaGpid1Zt?=
 =?utf-8?B?STVwVG83UEh2ZHFmbVlhT0xQMFJhSnhCK3gyZUVWcytERmJxaURUUVJkNTNh?=
 =?utf-8?B?d3MrYWUvanoxSHRSZERpckpIVzBlSDVFam40ZkJmRUU0VVZkSGQxL3VNSEpw?=
 =?utf-8?B?WnZrb1dmWGVpQitlVENOUzBGTDV3Q00xUVhiMFBIVTArU0twZ1NtVjYyRVZD?=
 =?utf-8?B?Tm40WjlNeWo2NlQ1WHlGQjhIa3ZsWUhiOXJRM3E5ckpIRXVwV2w2Ty92dldz?=
 =?utf-8?B?amxkZVBLc0U2NUtZL0t6eHVkUFg1eU9lRXYrY1N6WFVwT2dicHZwZElwRk1y?=
 =?utf-8?B?QkJKN1F1VHhwbVhhRUwzUWVMQ25ZNzg1K0hZczR4eVA4Tjk0WEpDV2tRcE5I?=
 =?utf-8?B?Wm93SFpiK1FWY2JsMkVTZjdoajVINnRtM0dLS2w0ejN2cVNIQitDRkNtYzZz?=
 =?utf-8?B?TXQxcGZTSTN0em5BSXQvZGl6UzRZM3ArMHRqV0owV3JjVUVvb3B6MFEvT05W?=
 =?utf-8?B?NDF3cENWVzNzdEdSR3pTWng1RnNhN0kxM1BTbkFWdElFWFFOa3FCbzdEcXFS?=
 =?utf-8?B?UW1EWi9UT2ZSREN2OW1YWkQ1elFIVXJpeDJSMy9YTG94c3lETVcwOGRBMzRr?=
 =?utf-8?B?clZDY0FuZWpCdUpCUTJhTndBUVZIMGpUTmJOb0I4cmtQZS9UL0IwZGcrT3BQ?=
 =?utf-8?B?c0diT0pJYjBWSVNwZW9iZzNhZ29xeW9hWkxnd3lqc1BCc1JNeVhZVFZOaGtk?=
 =?utf-8?B?Y3FVejl6MUNyd2tCMWM1MHBCNjhBVWkxZjBtSjZrSjJpQlBaeHVDRGhHOGNO?=
 =?utf-8?B?K0tSWC80Zlc3WEZseVJwOWc2QzhneE1IWjZWQXNHUFMwSTNxaDAvb1M4Ynoz?=
 =?utf-8?B?MGNUMWZpcmNhZmVpTG90cERhcVdJZXkvallnQkpHdzRpSy9vYWFSRjhGa0pn?=
 =?utf-8?B?cml4QmFlTWJyMTFqT2UzTDNPTDJJQnVxUXFCVWV4dk5tb3hQUHlINkVETFdz?=
 =?utf-8?Q?ZblZskehif2nwMJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEF700661CE1064DB6605853F3292C51@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UcNBCDlPX1fnlmiLPYSjKz2s9WQEaVRzH4ZMnClQIIDfyk3uqP9dej/tnJSAXUiJpjz2PLsy/I3Z5cZntIwCq9/nYkzxpy371cmSov/7FTcuaYIZz2Y1CyPf0dlbsT7WBBReRq0akh3j0dx8XM1kpgVCfDrIIIR0LP+lGzYe/Lu4P+JM4PSF+mOdqrRTNuOdVgKBc0qyLXmhNR0FtEFl3fNL26O6FFXcIqeXm8jqpVVRK2Spk8K/gA0IhRNCGfQLs1jFFya9e9f7jZGvVk1blB892TZwd+57yswwEspbU5AbHthVMpQfO0BAFMFhXo6IumSyyEPyYTI72FLE4EEvDOMM6UYggd7KILa9Baye01NfPCigdc/R+IjyPFVC2yullT/yJCKUEI08q/2YzJcxoHn4cgBJIJ9hMTvq/pI6uuqtILin3LE1s4tjTvdsUfeDC1Pkm64htpRTKd+MJ5M/NeCaJbC0OBhNT2HpVF/Vc7pp69uGYP3f5xVkw9pu+cyf69cBWUYHqlp4eqFXI8W4aceaijKae3bbftI3US2dYyzOx8TIOKuGwzDCevY2R9xddCPfl5Hl8qt8yJwwfihClnRpuwZepbTtEz7DUdEC6rtlt3di3dLBw9i0YBcXw4Us
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR04MB8300.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52b6675-3126-4711-e7a3-08de69222511
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 04:00:50.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgTa4rYL/rhWtcpkg0+BIhm/cLBtWaCWhf606W79QO0NEXfpXZ11Xm4bStYY0y07g4Tn1aMho55LGk9Dyw/1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8310

VGhpcyBpcyBjb29sISBzb21lIG1pbm9yIGNvbW1lbnRzIGlubGluZS4KCj4gwqAKPiDCoC8vLyBU
aGUgY3VycmVudCBTUERNIHNlc3Npb24gc3RhdGUgZm9yIGEgZGV2aWNlLiBCYXNlZCBvbiB0aGUK
PiDCoC8vLyBDIGBzdHJ1Y3Qgc3BkbV9zdGF0ZWAuCj4gQEAgLTYxLDcgKzY0LDcgQEAgcHViKGNy
YXRlKSBmbiBuZXcoCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYW5zcG9ydF9zeiwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2V5cmluZywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdmFsaWRhdGUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmVyc2lvbjogMHgxMCwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXJzaW9uOiBTUERNX01JTl9WRVIsCj4gwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gwqDCoMKgwqAgfQo+IMKgCj4gQEAgLTIxNyw0ICsyMjAsNTMgQEAgcHViKGNy
YXRlKSBmbiBzcGRtX2V4Y2hhbmdlKAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBPayhsZW5ndGgp
Cj4gwqDCoMKgwqAgfQo+ICsKPiArwqDCoMKgIC8vLyBOZWdvaWF0ZSBhIHN1cHBvcnRlZCBTUERN
IHZlcnNpb24gYW5kIHN0b3JlIHRoZSBpbmZvcm1hdGlvbgoKdHlwbzogcy9OZWdvaWF0ZS9OZWdv
dGlhdGUKCj4gK8KgwqDCoCAvLy8gaW4gdGhlIGBTcGRtU3RhdGVgLgo+ICvCoMKgwqAgcHViKGNy
YXRlKSBmbiBnZXRfdmVyc2lvbigmbXV0IHNlbGYpIC0+IFJlc3VsdDwoKSwgRXJyb3I+IHsKPiAr
wqDCoMKgwqDCoMKgwqAgbGV0IG11dCByZXF1ZXN0ID0gR2V0VmVyc2lvblJlcTo6ZGVmYXVsdCgp
Owo+ICvCoMKgwqDCoMKgwqDCoCByZXF1ZXN0LnZlcnNpb24gPSBzZWxmLnZlcnNpb247Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoCAvLyBTQUZFVFk6IGByZXF1ZXN0YCBpcyByZXByKEMpIGFuZCBwYWNr
ZWQsIHNvIHdlIGNhbgo+IGNvbnZlcnQgaXQgdG8gYSBzbGljZQo+ICvCoMKgwqDCoMKgwqDCoCBs
ZXQgcmVxdWVzdF9idWYgPSB1bnNhZmUgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb21f
cmF3X3BhcnRzX211dCgKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZtdXQgcmVx
dWVzdCBhcyAqbXV0IF8gYXMgKm11dCB1OCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvcmU6Om1lbTo6c2l6ZV9vZjo6PEdldFZlcnNpb25SZXE+KCksCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKQo+ICvCoMKgwqDCoMKgwqDCoCB9Owo+ICsKPiArwqDCoMKgwqDCoMKgwqAg
bGV0IG11dCByZXNwb25zZV92ZWM6IEtWZWM8dTg+ID0KPiBLVmVjOjp3aXRoX2NhcGFjaXR5KFNQ
RE1fR0VUX1ZFUlNJT05fTEVOLCBHRlBfS0VSTkVMKT87Cj4gK8KgwqDCoMKgwqDCoMKgIC8vIFNB
RkVUWTogYHJlcXVlc3RgIGlzIHJlcHIoQykgYW5kIHBhY2tlZCwgc28gd2UgY2FuCj4gY29udmVy
dCBpdCB0byBhIHNsaWNlCgpUaGUgU0FGRVRZIGNvbW1lbnQgaGVyZSByZWZlcnMgdG8gYHJlcXVl
c3RgIHdoZW4gc2V0dGluZyB1cCB0aGUKcmVzcG9uc2UgYnVmZmVyLCBzZWVtcyB1bm5lZWRlZD8K
CldpbGZyZWQK
