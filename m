Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960637CD5C;
	Tue,  9 Jun 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986533; cv=fail; b=OfXerkJ4gRweUJSz4neeackDaY9yInvFrVJ6yXKZyfhi413ZcUoZsn36GaSnKD0v+T5rBZiDutgxvOceCTcRbDJoDlzN4uXCfcTDwG7hXCyKLWqHy28XLvORdzI21vDazeDp++M/xDA2lwEfREMgMqbhJSqAq03HyfACZlO7FDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986533; c=relaxed/simple;
	bh=VROdwfZ0Oh0ogWPfca5V0UVcVz5C5vuHgId6pHIrc64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TdPGTOL/BtANloDvkH1DXgrIvDuqiYJedokB9bjXtBjRl0UYw0eCOCtJz3xTnsh6TdEVjlFfojH1rggkQMhznQorABA0qMkQLWWH42zS9xv6dU7DcACEtT0xFr2IXiMqtMjFfN1zhMLi7Mf5Z3FG65+rY1zdp2lmplT3RJtW/EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=dh02ol2/; dkim=fail (0-bit key) header.d=cadence.com header.i=@cadence.com header.b=JQsqihIY reason="key not found in DNS"; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dh02ol2/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cadence.com header.i=@cadence.com header.b="JQsqihIY"
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593xgda543881;
	Mon, 8 Jun 2026 22:36:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=VROdwfZ0Oh0ogWPfca5V0UVcVz5C5vuHgId6pHIrc64=; b=dh02ol2/D6tJ
	SUkG87t0Eq2P5x5E1WTHRYqP/l9S0rK0CAjeXJXVU5oJJy++5P9CQr0uaCONv5UC
	TitNLRRiUiEjRpvQ4sH4O4nQGvglN3Ahg312eWGBPT9mlGaxGzxlL7Nwk4jk6934
	i2X7M6QAsuHCH2BDJxFLvAH2GXslU770RnjGokjNCI/NKhw9SwfW22ooVrvU3NxC
	B53nv4QBFl7maJo2BWp9aukOKZCMj5SkhRZgVNtw+fXQ2GY/hA9wAiMs4+aNbd6R
	96OQQ3gtGiwL2fbmj9nU+GVeVRv8UPWfzvNd58ou/dLahraVkZM8LS3zraoAJG1x
	BzkFinxuRg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4enxcx5289-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 22:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjShfh2dy7qPozII1NZfka7TuPpJ5qs0Nb8qpYMPUnYhyf0p9NWW0zLs7gIQIHvf+MTeGZB6C1rQK+1KWxvICul3Rz97PwQQ+prp1TH3MHy9rGewa/RphYFodBxr/a/V6HP/KMkWaVUFYpKK4eQijo/njWIQ/QRNLzLpOu9rLLksZGbBl5Jjx1KlxKhaDGy3eMcJbSMSdenilQP+6YAb9bXQtEHHp7hGJMjDNrzjAi2y4AD4lY4bhJvtG5MB3MuVv0oTahOyTHg0Jaexia4E2YnBi9HUDXhP0gt/pDwXtnGdg9zylRAx8rOhHD4bWNQGfdnZBGbkiwJ1OCnmU0gWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VROdwfZ0Oh0ogWPfca5V0UVcVz5C5vuHgId6pHIrc64=;
 b=abbR6V9d9UFggHHZ42bv1Wbj0dYPStEhPfwfgMOEHAgX6V1TlOlbZqkfQDnCEseHjnRC8wumN1kO4E7kGPNYGfUF45KyvZq17m/2fzHAoX895DYj2871dg+mj5WA5uxFpn400MyPDkgd9WM2idfRjYkxgSy9b4R++nepQH3s3S99fdtkHAEFDk3iccVWftjKUa4QRlJv7oBEKWt/UdNNmr1asWYAr/iYQQQ+yB81q8J+k4YuSmSHC3NFqgszyBuxl4A4m+aFGshJ4R2KIq67ae958AMyawk1z1RuryJ4REhxU0uF8AR8aM4pYOPfN3jAXWxL9bM7FqNOqNiNknx9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VROdwfZ0Oh0ogWPfca5V0UVcVz5C5vuHgId6pHIrc64=;
 b=JQsqihIYyXhIRc/EXNL5uTCHt6DKelfSkYQJoAsrNNoKGWDQEGg3avoCrx2PvKxDJqHu+MSKqjSUawwouTnrxirJ/QK4ZIT/OCt6meynz7tTQNlQKThiudyan6Uz/v1qVgOekBAOhEnlXyJd/gUiZ/q+s5/ZjiTzmQTwmM+y7ROtxvSDWRGR3jgBQLy58G8db6tJez0eQwBQU02hi+Bp5ooAzt3g6Wz2eLjsh/KPXzp4Fc6zVPpmNpt3q1nJbH8H8G8HpCPfdjURyq862ICRXR09teOIeyBdy4XS7Gboz8TssQQxZJeWR0ey/seA/fGqp1zcXxRY8erRnZ9sIMSo6A==
Received: from DM6PR07MB6716.namprd07.prod.outlook.com (2603:10b6:5:1c9::16)
 by CH3PPFEE87D8166.namprd07.prod.outlook.com (2603:10b6:61f:fc00::217) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 05:36:49 +0000
Received: from DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175]) by DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 05:36:49 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Aksh Garg <a-garg7@ti.com>
CC: "vigneshr@ti.com" <vigneshr@ti.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "unicorn_wang@outlook.com"
	<unicorn_wang@outlook.com>,
        "me@ziyao.cc" <me@ziyao.cc>,
        "18255117159@163.com" <18255117159@163.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "danishanwar@ti.com" <danishanwar@ti.com>
Subject: RE: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
Thread-Topic: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
Thread-Index: AQHc9LuqjkCh13AaZkK5AxTbwTQ2ILY1mpoAgAAMvgCAAAwuAIAABthw
Date: Tue, 9 Jun 2026 05:36:49 +0000
Message-ID:
 <DM6PR07MB6716C332466460978CBD8641A21D2@DM6PR07MB6716.namprd07.prod.outlook.com>
References: <20260605071922.1724499-1-a-garg7@ti.com>
 <19ded2fa-4560-4b38-975c-6b490328e992@ti.com>
 <1362dccd-24b0-4b44-8e45-75cba81180ae@ti.com>
 <bb190834-121f-4b71-ad12-bd2d5fcacd44@ti.com>
In-Reply-To: <bb190834-121f-4b71-ad12-bd2d5fcacd44@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6716:EE_|CH3PPFEE87D8166:EE_
x-ms-office365-filtering-correlation-id: 3d1669bd-e253-48b4-dc9c-08dec5e91a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 k16OTsCD9XSoD601AbjK/ftMwNkL5pcIPLghiotv3TH3O4wDPUrh5jqgEChqalsgiJTgUM/YkOAVGcRtMfcGKl2u1kZcGOWMs+RJYMYb9+3CbFE4vtkxtcbXDbxwWHMgS9ezqM4Ioei9dcFrGj9tMq14naLkHjs/R3cm5h4q9hoH7Yhrra2RuvYI2xPCZnHaSwvMeN98dw/BGOJUCK0U2zbOHQLmtDEue4DNxWdz5vOacweAvVsKc4WZyBZYh3dZLxepiT44w19yqTNBRmP095I0DOIaBSZDc/+Jswr42QbcdQ1tXthHaIJDrYwI9+zEEEIsEcQDNgsWvIieS0DfYHIHqHDXIjUS9vE05zQhB6OUgBLv4P//DhbeWlzEWs/WHU3maohinyHWUYelZTh1dJtsyeeC9be4OGx9E9skbTATUtvNFZGDklMkeKYwmVPapyMwBk1IgytKAjTgifRE7bdiJXsblv+M16xE925g91NPH6EB+8GI0G98w0t0xz8FmG+crsbR/LhGavg7MLDJhM8p88Gb4d/qwTykIF9zZ4jnVyv99cig11DgC/IxXvI9PVgHO/AIIpMcwjwtwpqtGWA91Nyyp1dV72YOpyEzGyIQbtMyWPXv7FFiHNz5lqCyRdKvlw2erKvdyKYKWsQfW2QTZGDmEF1Dw4FrtoxTNXi4t26u7palrL74nTXx9HRBKjeDm4BWfgmFT/RS3L2O3vonb4CGsDnO9+4sqNs6AXLFcwH+Olf6c9gP0WXwp7Cg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6716.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SG1GTXVsdmpsSHhhNExWMUFySldERUdicklncEtVSzVMTDVwQXNiT3hTOXFH?=
 =?utf-8?B?MlBrV2RBRUN3eXhaM2V2RXFwZkRaZW1EcG9CbXBxby91NkVzM2NQekltUHVV?=
 =?utf-8?B?NEVVdTNqMzhWakY1dU5vNXdtMDJrN2Nrd2ppUEVQdEI5Ujlsd2YyV05Wb0Z4?=
 =?utf-8?B?Q3lFV3l1V2pEcjd1Q2JSYXNTcHFmY1ZrWDlrR2E1T3gzYjB3aWZScUlEenJv?=
 =?utf-8?B?bWtacm5BdjFFd2VOYVhDVzNiRkU2anRRc2VRUXI5NUU4a1J3NXNoZnJGd1V5?=
 =?utf-8?B?VjdrZWtKSnBMSldDYnk2enlEZmMzQTkrWitRN1Vtc2R6L3psd29ZNm9LajRn?=
 =?utf-8?B?NGQzSFdwVktKdTkweEg0RXBkdkY1bW1seG5mRjZkQ1p2ZEdmRnNadmtENnJZ?=
 =?utf-8?B?TE5QTElQUWFTOU16QlR5V0l2dUdqTXMwaGQzdHZUTitLN3RNS3ZWeWwrMVNZ?=
 =?utf-8?B?V0RTam0zWklEU3RNbHg1L3BGNGFGd0xEekVjMDFBZmcwdEdXTnZhT0U3UUR0?=
 =?utf-8?B?WlhieHdBMG5uZ3RWSm81dkQxRndyTHJtVnl6amVPTE84NlJXTUtMSHhpbGF5?=
 =?utf-8?B?ZG9CRytTYTVsamFjbE5QWnZ1TGZXZjhkWllyTmliNVQ4T2dVMlBSK3RwWWJE?=
 =?utf-8?B?MjhjVEtWR2QyN3VHNWQvVWplekdmNXd6YUN1LzFwemN6UFRMN21QWHg4TFhk?=
 =?utf-8?B?S3k2VXRYT3Jkcmt5UytZajZLQml5M20vVjhGT1NHZDJvbGRTTVNVUVp3bTdY?=
 =?utf-8?B?Vk9NK3VYQ3czSk1JVkw4UkJ6RWgxbVhHNlpJWk1UajlVNlgzTEhaSkpYbXA1?=
 =?utf-8?B?U2RPKytFajhHZlZkTXBjaitqMVkyK0NDcmVpUWI0N3NIOG9pMml4TjlGSkUr?=
 =?utf-8?B?bGllRlR0TFJpeG8rNXpmcGdneEs3eTA5cFRFWml0cFdCQkxqOG83cGo3cDBV?=
 =?utf-8?B?Yk11dk0vQkxEcUJyRHVzbTZDaUluOU9aYWpFM0pWMURyWHU2aEtCVGxFNWNn?=
 =?utf-8?B?d0JGUU9PalluZjlJd1FSdHBmWS9mclJsZzM2cTVueTgyV2JDMlp5U254cGVG?=
 =?utf-8?B?T0hLcUE4TDYzeTdiNmxtRzZrc2c0U1IzMzJ6TGNoRGgzd0FSMk5nRUZJZmVn?=
 =?utf-8?B?cEtyTlIyRGtQNlQ1cWhaa2JwelFBdjRNdVRQdE9kbXlXNGpwRzBMYSszU3p1?=
 =?utf-8?B?Q2dUaUxubXVMdW1Ba3diUUxsenAxNXpaeURZcERrNlRFaDh0Qi95UjJFWGV5?=
 =?utf-8?B?ZGhDc1cvbFpDeDlqVXE0SWJIcnN0dUlDcEswVm5LRFAwNnBzYTRrUmlPUDRW?=
 =?utf-8?B?SHZBS2pKVDRQUE05RjY5eENaNmcyVldFQ0tQUmUwaXhlTE1MWm5yQVlHV2pQ?=
 =?utf-8?B?M0VEVFgyR3NiQ2t6WmxSekJBcXpkbno5UnlYSm5OVHJQRDkzL0NxT3FxWEg5?=
 =?utf-8?B?eGZ6SjRKZmNsSy85blp5VmZIZGR1dDN4ZnlETGJzVHB2VUU0cGpoVy95SUF4?=
 =?utf-8?B?Y2RiNVIwRUl2QkFRZ3ZTSU05ZmlNaFNyamxJWHh2bnNmeGdIcDZ0dG9OVmFT?=
 =?utf-8?B?NUZHUlVsdHo4M0llUzN6RWQrMlBzWWxWQ0Q4aFBGbXNsZHNsNHhOTERBQ2s4?=
 =?utf-8?B?L0hMTy9kRkkrTmVrVU5YdFYyWDkvMmMraFYrNllSa0loOFU4Ulk4RmdsMzIv?=
 =?utf-8?B?OXZqU3NhWEgrM1N3R0lZQjdueHBQdmo5TTNoMHgrVGg1SHoxQ0RPNFRuZTV6?=
 =?utf-8?B?SmhHc2Juamc4bkxvTlhHdFRuazg4UFY5R2hWN3lmYm9sbng5UEp5VWxITWNK?=
 =?utf-8?B?MVNxVTNtbUdhMmF2aC9GSWFMbE8xeFR6MDhyaXhMei9HOERhVndpd3ZJanZH?=
 =?utf-8?B?c05rdENFR3lRZjJ4ZFk2ZHJrVXVhMElTWlY2ZjREemtERzZyVnJ6ODhjdTZT?=
 =?utf-8?B?SlJyZ05QdUVOOXBmanlhM1R1U0RqSitUZ3hNU01qZnlsbW9XREZqd1NBT1Rz?=
 =?utf-8?B?STJEVlgwZnY4QldzU0x4Yjl2eVNjK1Z4VTJlY3BoQmk5ajIyR2dTc3pTcXo1?=
 =?utf-8?B?NUlLOEJPeW5hQzR2ZEVNaURPTUhrTlpMVGNnUmllMDV3TW9BcFcwQnphdUl2?=
 =?utf-8?B?MFN2SWFVNEovb0VreExGaDZyS1RVcDVZWjhBbHV4OXdKbWtzbkJNTHUwNlBO?=
 =?utf-8?B?a2NkRlZ1L2p3OVNrZkZHbEhsUkpkTVVqZEMxNEZlY0ZVTXhrU3dnL1VtYkNJ?=
 =?utf-8?B?ZE1XUEpWKzZjOCtHNFNHTXM5QXA2SnpNdHpoZ2t1cDN6OW9PaUpmK1FSUm9J?=
 =?utf-8?B?ZHNDUjQvTnBKSVlTTFJPV1JFUXdMbEJudDBhRDU3bmdNWEhoOGszQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VXFppTXX/aZHFllY5UnGWs8lmEdgnH4b61tQceiLB0Bw4Ej/jdw8Q9aPIDO7r6GSSWN22Cv3O2Yr0pnagHOrDAbHwHjSJ0Ynyk+qoFOuQ5pwikqoBUTNrfxDF2Q7lN4KdE6y5CcbwKKLohtuTZqeARzLKuTUDTBqb3bcNmRyk/QS35i7mMJiB4TCEK3QUFadtyu2VK+7cBGgNe5giAWVdav410bA8HFkDw75FXb9diDQn8SWWaguXiM+zmJQsULtfMUelFGnvJE04rB8NvjIfgSiD5iIcr35SCMXfVZkIArFC3KN2RKPuywQMe3xGCnEopDzhzf30mK322wWC18C6Q==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6716.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1669bd-e253-48b4-dc9c-08dec5e91a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 05:36:49.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whSUfxyL8ZV6Ql0ATgUPkw4o93rTnm8TwcxZUhh6Gs9r7OniTibdW0Nv2VBuDEYZ6ouK4fNBYavh38HWhgiLA++C9mHuAV3hmOUmk4L9NL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PPFEE87D8166
X-Proofpoint-ORIG-GUID: u3_ax9onRMq4mTEiociOLy5vDSxUMsUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0OSBTYWx0ZWRfX5GZRdW5Lmsz+
 0dOd8ZgjObppp3FfKgVaj9NKPixCCjyp5dywStsoiDGpsKS55L7/SpaeU0azevvmYOgVVJYGuDm
 k0VZIITpBhxNx5xmQiusl7+maLBHLEzZchp8qI0kubgOBXpXWZ5nQxb509VlGLVrxoUp/txem4N
 egiJWophBjTy2sOQH2oothgi1W4gLFlLyPT+QMzLt5LZRrHbrRyOvyVHWkUyMojKWd+aV4XfJs0
 Ob9iZXPe9L8kYxsQcviqX4aAPJ3R45oqsvVCOUBF3rRc5rqy3danB1hbUggEgjREHpsgq4GvmVz
 KasDs4MOMdPMfh5/xWNC3Gfr4MpQn9iwSU2VHF0vEoKFXClm4QWLjaBAYtAz80jyWE+BbF+O7Kq
 S2/StCjKA5JbNr+l7iEMIlVPzoRlR7FOvdrbnDWjUCCE8NdLAcAoEoKAt1FiwgAZ7MmonOCL8jL
 bGo8RqUaB5k8gfb8o+Q==
X-Authority-Analysis: v=2.4 cv=aK3Ab79m c=1 sm=1 tr=0 ts=6a27a675 cx=c_pps
 a=3tfckwpITFtzIurveUQz+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=tuMieXAyK57eGGFK7xkD:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Br2UW1UjAAAA:8 a=UqCG9HQmAAAA:8
 a=Byx-y9mGAAAA:8 a=JfrnYn6hAAAA:8 a=81giWaI05OSr239xgXoA:9 a=QEXdDO2ut3YA:10
 a=WmXOPjafLNExVIMTj843:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: u3_ax9onRMq4mTEiociOLy5vDSxUMsUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090049

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNpZGRoYXJ0aCBWYWRhcGFs
bGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDksIDIwMjYgMTA6
NDIgQU0NCj5UbzogQWtzaCBHYXJnIDxhLWdhcmc3QHRpLmNvbT4NCj5DYzogcy12YWRhcGFsbGlA
dGkuY29tOyB2aWduZXNockB0aS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj5rd2lsY3p5
bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj5iaGVs
Z2Fhc0Bnb29nbGUuY29tOyBNYW5pa2FuZGFuIEthcnVuYWthcmFuIFBpbGxhaQ0KPjxtcGlsbGFp
QGNhZGVuY2UuY29tPjsgdW5pY29ybl93YW5nQG91dGxvb2suY29tOyBtZUB6aXlhby5jYzsNCj4x
ODI1NTExNzE1OUAxNjMuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
DQo+a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGRhbmlzaGFud2FyQHRpLmNvbQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogY2FkZW5j
ZTogc2tpcCB0aGUgbGluayBwb2xsaW5nIHdoZW4gZW5kcG9pbnQgbm90DQo+Y29ubmVjdGVkDQo+
DQo+RVhURVJOQUwgTUFJTA0KPg0KPg0KPk9uIDA5LzA2LzI2IDA5OjU4LCBBa3NoIEdhcmcgd3Jv
dGU6DQo+Pg0KPj4NCj4+IE9uIDA5LzA2LzI2IDA5OjEyLCBTaWRkaGFydGggVmFkYXBhbGxpIHdy
b3RlOg0KPj4+IE9uIDA1LzA2LzI2IDEyOjQ5LCBBa3NoIEdhcmcgd3JvdGU6DQo+Pj4+IGNkbnNf
cGNpZV9ob3N0X3dhaXRfZm9yX2xpbmsoKSBwb2xscyBvbiBsaW5rLXVwIGZvciAxMCByZXRyaWVz
IHdpdGggYQ0KPj4+PiBkZWxheSBvZiA5MC0xMDBtcyBlYWNoICh+MSBzZWNvbmQpLiBBIGNhbGwg
dG8gY2Ruc19wY2llX2hvc3RfbGlua19zZXR1cCgpDQo+Pj4+IGR1cmluZyB0aGUgcmVzdW1lIG9w
ZXJhdGlvbiBibG9ja3MgdGhlIHJlc3VtZSBvcGVyYXRpb24gdW5uZWNlc3NhcmlseQ0KPmZvcg0K
Pj4+PiB+MXMgZXZlbiB3aGVuIG5vIGVuZHBvaW50IGRldmljZSBpcyBjb25uZWN0ZWQuDQo+Pj4+
DQo+Pj4+IEFkZCBza2lwX2xpbmtfcG9sbGluZyBmbGFnIHRvIHRyYWNrIGxpbmsgc3RhdGUgYWNy
b3NzIHN1c3BlbmQvcmVzdW1lDQo+Pj4+IGN5Y2xlcy4gSWYgbGluayB3YXMgZG93biBiZWZvcmUg
c3VzcGVuZCwgc2tpcCB0aGUgZXhwZW5zaXZlIHBvbGxpbmcNCj4+Pj4gaW4gcmVzdW1lIHNpbmNl
IG5vIGVuZHBvaW50IHdhcyBwcmVzZW50Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBa3No
IEdhcmcgPGEtZ2FyZzdAdGkuY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqAgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9jYWRlbmNlL3BjaS1qNzIxZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNSAr
KysrKw0KPj4+PiDCoCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNl
LWhvc3QtaHBhLmMgfCAzICsrKw0KPj4+PiDCoCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVu
Y2UvcGNpZS1jYWRlbmNlLWhvc3QuY8KgwqDCoMKgIHwgMyArKysNCj4+Pj4gwqAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5owqDCoMKgwqDCoMKgwqDCoMKgIHwg
MyArKysNCj4+Pj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpLWo3MjFl
LmMgYi9kcml2ZXJzL3BjaS8NCj4+Pj4gY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIxZS5jDQo+
Pj4+IGluZGV4IGJmZGZlOThkNWFiYS4uODQ5ZWI4YmI5ZTQ1IDEwMDY0NA0KPj4+PiAtLS0gYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpLWo3MjFlLmMNCj4+Pj4gKysrIGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIxZS5jDQo+Pj4+IEBAIC02ODYsNiAr
Njg2LDExIEBAIHN0YXRpYyBpbnQgajcyMWVfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZp
Y2UNCj4+Pj4gKmRldikNCj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgajcyMWVfcGNpZSAqcGNpZSA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4+PiDCoMKgwqDCoMKgIGlmIChwY2llLT5tb2RlID09
IFBDSV9NT0RFX1JDKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgY2Ruc19wY2llX3Jj
ICpyYyA9IGNkbnNfcGNpZV90b19yYyhwY2llLT5jZG5zX3BjaWUpOw0KPj4+PiArDQo+Pj4+ICvC
oMKgwqDCoMKgwqDCoCAvKiBJZiBsaW5rIGlzIGRvd24gYmVmb3JlIHN1c3BlbmQsIHNraXAgcG9s
bGluZyBpbiByZXN1bWUgKi8NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJjLT5za2lwX2xpbmtfcG9s
bGluZyA9ICFqNzIxZV9wY2llX2xpbmtfdXAocGNpZS0+Y2Ruc19wY2llKTsNCj4+Pj4gKw0KPj4+
DQo+Pj4gUGxlYXNlIGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW86DQo+Pj4gMS4gRW5k
cG9pbnQgZGV2aWNlIGlzIG5vdCBjb25uZWN0ZWQgaW5pdGlhbGx5IGFuZCB3ZSBzdXNwZW5kIHdp
dGgNCj4+PiAnc2tpcF9saW5rX3BvbGxpbmcnIHNldCB0byB0cnVlLg0KPj4+IDIuIFdlIHJlc3Vt
ZSBhbmQgc2tpcCBsaW5rIHBvbGxpbmcuDQo+Pj4gMy4gQW4gRW5kcG9pbnQgZGV2aWNlIGlzIGNv
bm5lY3RlZCB0byB0aGUgUENJZSBDb25uZWN0b3IgYSB3aGlsZSBsYXRlci4NCj4+PiA0LiBXZSBw
ZXJmb3JtIGEgYnVzIHJlc2NhbiwgYnV0IHdpdGggc2tpcF9saW5rX3BvbGxpbmcgc3RpbGwgc2V0
IChpbg0KPj4+IHJlc3VtZSksIHdvdWxkbid0IHdlIHNraXAgcG9sbGluZyBmb3IgdGhlIGxpbmsg
dG8gYmUgdXA/DQo+Pj4NCj4+PiBTaG91bGRuJ3QgJ3NraXBfbGlua19wb2xsaW5nJyBiZSBzZXQg
dG8gZmFsc2Ugb24gcmVzdW1lLCBhZnRlciB3ZSBza2lwDQo+Pj4gdGhlIHBvbGxpbmcgaW5pdGlh
bGx5LCBpbiBvcmRlciB0byBhbGxvdyB3YWl0aW5nIGZvciBhIGxpbmsgdXAgZm9yIGENCj4+PiBu
ZXdseSBjb25uZWN0ZWQgZGV2aWNlPyBBbHRob3VnaCB0aGlzIG1heSBub3QgYmUgZG9uZSBpbiBw
cmFjdGljZSBhbmQgdGhlDQo+Pj4gRW5kcG9pbnQgZGV2aWNlIG1heSBhbHdheXMgYmUgbGVmdCBj
b25uZWN0ZWQgZnJvbSB0aGUgc3RhcnQsIEkgYW0NCj4+PiB3b25kZXJpbmcgaWYgd2Ugc2hvdWxk
IGNsZWFyICdza2lwX2xpbmtfcG9sbGluZycgb24gcmVzdW1lIHRvIGFjY291bnQgZm9yDQo+Pj4g
dGhlIGFmb3JlbWVudGlvbmVkIHNjZW5hcmlvLiBMZXQgbWUga25vdyBpZiBJIGFtIG92ZXJsb29r
aW5nIHNvbWV0aGluZw0KPmhlcmUuDQo+Pg0KPj4gVGhpcyBwYXRoIGlzIG5vdCB1c2VkIGR1cmlu
ZyBidXMgcmVzY2FuLiBUaGlzIGltcGxpZXMgdGhhdCBkdXJpbmcgdGhlDQo+PiByZXNjYW4sIHdl
IGRvIG5vdCBjYWxsIGNkbnNfcGNpZV9ob3N0X2xpbmtfc2V0dXAoKSBvcg0KPj4gY2Ruc19wY2ll
X2hwYV9ob3N0X2xpbmtfc2V0dXAoKS4NCj5UaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcuDQo+DQo+
UmV2aWV3ZWQtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4N
Cg0KTG9va3MgZ29vZCB0byBtZQ0KDQoNCj5SZWdhcmRzLA0KPlNpZGRoYXJ0aC4NCg==
