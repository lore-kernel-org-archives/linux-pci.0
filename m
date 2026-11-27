Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775812;
	b=kNvNwpMAW1Y5GrmiyX08FtgO+V3NFVoFkNptMV9O6d20u2cZEbX1lY23l4pGN9MCfmE7
	 u8ZTRQjKUjnUzZ3nb41Uy/cNVDuncrS0c0BoCeYVv1fN+uwL8vEN3788U5fFSiMlRFTsZ
	 KfcSRrr8mc1dF83J+hPpIBmK4BUs9VH/zvMA3pI2o+PDC4k3ysFY2NKAtZZ3vDi8aPUmy
	 TcwjXwWFG4QkKZSgGzHKplLaQ8mhmraGXFSzuD9kaYywCxPKGf1wqFiPPBI5auuXhakck
	 FjSKeEy8vilUYwDv0MWvL6ugYqEDCVd6bn3HD8IKWuCifBxxeRvYTJJehoEjRLVDrWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775812;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=B5WXsP4uTHrUXmc4RQ5c8bVKL7EiAq86Gjwa4xjFVhg=;
	b=CzdrM1vLXfUaBPhghM9XIUil+y5UM6sGUCYsYKhcwrvJyzxeGusopmPinDEcU408skBh
	 VAPQhFFplP0eUZm0iDBublSdPK0GcO7Klc0dK/M+Xi9s+wcNh+PzxANzQuqYLPMZC9bRg
	 cW28eEYCmMTuWpUXk0shAhDaRGopQGTcVVuPwRagrYkVO22SCGk6LltZCiNO4y75eCP08
	 LQW1LQVAydfHLy99bQPfAV1UreOSvqOgoxodDd86s2Yl0QITFQ0MjOUNHTo/lVbQaJ3nh
	 L8epJAK10KyKgwVBns7lE7DQtuOLSlQhcjRfTa9/tVmiIEaA0p+GkZWA3cDBGMMpv/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TEuJBYKC;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=juJYAsKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC39606A31E;
	Fri, 27 Nov 2026 10:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC39606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TEuJBYKC;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=juJYAsKG
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GIax1146495;
	Fri, 27 Nov 2026 04:36:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=B5WXsP4uTHrUXmc4RQ5c8bVKL7EiAq86Gjwa4xjFV
	hg=; b=TEuJBYKCDuJL2Zc0A21k7GTbbLjqJsB0Ms3cxiGNBYLjbPeLyHZG+/hBj
	l0jEcHvOrmtLHLsth98HHQE6kg30Kep4aVls7SO+K4Y1PJhrLdSwhOJfbdww/gRk
	k1vywRfuvvUy+4xZ75goaXLYiPCAGTM0sIQ9It4eXdBQj+wNfKT0tOyi7ovhcxrU
	1xu9wjXjJ8M+IJfrKkHXDgI4BAMHvM9G28f/x7MSplHi43FL0zBIP+pee2UoU7Pr
	Wlj4EGpnXx27/TCY7g+pxrjxmADGpsyrtjX1rDoNelGEMcOrkjG1vpb4mbz/rTd3
	M0la+v8ib75BO88/WhERES/NltMTA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j72ujsr8c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 04:36:20 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koY9KshLc15LQ2eutm0XxKS7/GdxVRIoGYPsTgo31IQoK8wnNNUQVh1RmV8OIXprD+u9RZaTDgzgwnW0xUCAzDPBn8CLGxWc1rGLNHhxsd2auw0kl8qVwqMuAEFqfC+YRd9DlUz07AromWGD4RSD6TET3je6nm+SdK/n1yjPX84/PM4+43chA749Y/aM+yEcqsgdePuPqz2OARKd0EKOfHG2IrinF90b2IPK6/QgL2rFhBFOSUvMPORpJ0lu+pn1NYbVl/Vh28NKOSzG+LdOf7/uWA4Mcu/LuCitUl2w5PXbHiLjbqSbi+JIqbe4nkzQZsCkNzYF06M1ayLM+OBtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5WXsP4uTHrUXmc4RQ5c8bVKL7EiAq86Gjwa4xjFVhg=;
 b=eCADCCBl0qSUuS6c6l05V/14LPHBBX56ZhNEbr6pLfxfX+CD4f4zMB9MKjxNQSigsx2FDOb/Xez5LxpG5SG9GP0+Bx0gmeRTB1DO395baxs9kjYD12WJjmkMlLzHoaq+SkApbCazOxZYsjhnNpO7EhQcEjkMUXaBYDosPwUxJOnQ2q6bDkijVkaw6TjOqBgRGXncxJoK5eM6m2CFWDVaOkf4pdJDG9ZIcrwi8ODOCvBTcA8+u4x06wFDxQwTH7IYYgSKBnYXaLnuvW8s/ZNLYZtm2i0qRB6cPNco+MFIeYFfG2RuMegZaeSPHW9784soHc74iI1YwYeJw4RBuSQQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5WXsP4uTHrUXmc4RQ5c8bVKL7EiAq86Gjwa4xjFVhg=;
 b=juJYAsKG2jh4TUkV0UJ+IAPdlPr3/j7YXz0sbWU1WR6OuN7I/6AgSaud7AkrWXanKI6puqOo8pqGYwOBop392zr5FGyxBiWXlLoq2FZcKLLBTU6wx2SCx0oM61m2+24KDteMiRWF0Oq7DWWqxbSIIImOPnj/QOFdWfYjiQEETrY=
Received: from CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21)
 by DS0PR10MB6993.namprd10.prod.outlook.com (2603:10b6:8:153::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 10:36:18 +0000
Received: from CH3PR10MB6715.namprd10.prod.outlook.com
 ([fe80::870a:d279:e9:91cc]) by CH3PR10MB6715.namprd10.prod.outlook.com
 ([fe80::870a:d279:e9:91cc%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 10:36:17 +0000
From: "Garg, Aksh" <a-garg7@ti.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>,
        "Raghavendra, Vignesh"
	<vigneshr@ti.com>,
        "Vadapalli, Siddharth" <s-vadapalli@ti.com>,
        Manivannan
 Sadhasivam <mani@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: j721e: Properly check the error of a syscon lookup
Thread-Topic: [PATCH] PCI: j721e: Properly check the error of a syscon lookup
Thread-Index: AQHdflcoESKWM/w0oUaFihMTuQ0EFLdBuZQA
Date: Fri, 27 Nov 2026 10:36:17 +0000
Message-ID: <bbeeaa27-6210-4b44-b7d7-8f7fd1a1ae08@ti.com>
References: <20261127101915.1348807-1-a.s.protopopov@gmail.com>
In-Reply-To: <20261127101915.1348807-1-a.s.protopopov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB6715:EE_|DS0PR10MB6993:EE_
x-ms-office365-filtering-correlation-id: a8912711-83f7-484c-c1ef-08df4c724517
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|921020|261009223327099003|261009221227099003|10067099003|261102123227099003|261021121427099003|56012099006|261009220027099003|261009223027099003|261009221727099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info:
 B66bYgSPu8vtO+wb5bBbi1L3G1BJTnPowXbUHBoFXNZPZfmLFhg3Br+GGwuYbiVerzCTMBnKdUXgL4t9w2vUtWJKu5vsd4H38tvTfbQyaeGLQ62p6Jtml/IKgumKrHSMBMlyGOD0atFt3nv2ruBuH/r1HwRJEkcOUJxR28qnnSKZQSWTAL0D7EvCtdpRypnF1LujWs4OH/cns6IXo/h/KsEmXjh3N4Q4qWJkISSOpejG/Ys4jMJYc0OgpX4tMLHuCLs5YMTqCYw+zWZ6ZN20W7yOhsUlYw74h3mFRA4mVMHR5I7X8Vc88sMn4t+k3OSLys5bQsx/rif1R3/3ZQqgRec83kEycCVCEQQRYyZb7BRONk/yDUrj0SOak4sKSMY8u6ZB8pMfQHqHsTna8usmwWqcMvRGx3rQOnkYoORZuVk2ULBl2/ubM9Zr/d14MqjwUT67fZMldXhgDwY64W0eO9FKs1VM/TtwRvPnSu1UUEoifyuRQv0uqlE0qHt/RoKMC72lBsq0r6P0kfwLf7NjGDch/TLncYDGviom8O11fShOq8/709IKULRpCqTb7VIHISfstaOCXqL5kh1TWvcfv52NXtmZc+cnGFSUN0u7kPZX5svQni6ufyH4sSg9E76rbNVmwE60ctrpH52KsKOt7t811uFNwcuUJAy/PKcEC6Ds80xiyxwsYVNlrzSmSuIH+/v8tipRMrhISS6cRL7xYD3EB7w0KtDUoiZjXucP3tYXkGz0AYU++LjrAF7T0YkP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(921020)(261009223327099003)(261009221227099003)(10067099003)(261102123227099003)(261021121427099003)(56012099006)(261009220027099003)(261009223027099003)(261009221727099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFh3Qk1BN2RZK0FET0JFUjk1RitwaEFOUVd4aDVudUJRd2FuRW90bVdhajBK?=
 =?utf-8?B?ZDRZOEJDYTdFZW9rMUZMQ0lBMTEwVllMeEJDcTlIZGtRK3ArOEtYbU9ZdTZB?=
 =?utf-8?B?Mi9HQXJVK3htdEU2UVVnZjJUYW1sWG40dnhlZWlROVhaOXJuV1F1WFFWVG5I?=
 =?utf-8?B?S3dvbzJQang4RGx6a1k4ak54ejQzbHR4MVFTTXZqamJIMllrclFlN2xHZ2Yr?=
 =?utf-8?B?ZVlsWncyUmZDVmRxVk1pMWdaakhUVGhJTkc5OUdVb01nbWNYM0h2NGRjVmJp?=
 =?utf-8?B?OFk5ZUhscUZsSTBac2lpOFpOZDhaaHRrazVOblkwbE9JYVFWTzRxVXN5Szcw?=
 =?utf-8?B?T3NOQVQrY0lzd1ZSTlRlNlRkK05BT09oZmF4bFFMTkI5eUlsMzZ3dDluOTBM?=
 =?utf-8?B?anFXeEk1SVNyNUNmVmNNRmVoLytITUhkZXhZMGg0c05NRlRQSEhnblZjMjFX?=
 =?utf-8?B?VnU2cHNGaWpnTThKNlZpMSttOEhlTWRpSnhMWng5SVYwNVBFRjhpdkVsLytq?=
 =?utf-8?B?S1FSb1h3Zzg4bGJ6TFpIenJraGNnVktRMnVVQUJkbEgvNGZRcG9sR3Y2QjU2?=
 =?utf-8?B?VGhTNjJWdFROcVZabmR1VGp6SGFNNENIejczZmFjcm83UVVIbHlPUDRPYjBh?=
 =?utf-8?B?KzFSYW1KRHVySDFBU0NUSXRybzlSU1ZhajNzZUF0MnZmdll1bFJFNml2OThs?=
 =?utf-8?B?Q1RMbXlpUmZKdUR3Sm5waUtCM0U0YkVPOHUwc3RGVUN3MHI0UWxhSTZNZFVw?=
 =?utf-8?B?eEhtWkpYdkw2TVJicFNxSzlWanpKbXB2U3lIN0ppUEMrQ3RBMnM5aXJyN0ZR?=
 =?utf-8?B?TE8xN05hM0dxMXBtS2wxNkRQL0ZlTWdxTk9zaytrQ2xaZngvRTF6VkpYblN1?=
 =?utf-8?B?Uk9DUG4zYTIzYkJrTk52TDMvQTdsemFtYjErcnp1QWtYV2Rob0ZNQUFWTXp4?=
 =?utf-8?B?WHJsK3lIVG9PTTU2bC83SlB6TGNUa21IYUF5ZG54NFo2N0taVzFXWCtvd1ZO?=
 =?utf-8?B?L2hKa0g0ZXZQallkYXpEbjFkM0lGMVFYVzhnaTNtYnA1bTdaaGpzR2hYTXlj?=
 =?utf-8?B?Y1ZTdlNrQklUQjNEcFo0TVUyOGk4RVRTM3VNd0FKbzhuLzlGTDd5eVlURm41?=
 =?utf-8?B?eGliM1diRDRkMlJjMWZUYTJvNng2ZFNYWWV3dSt3cUdEWGdhWEQzKzAwaXpE?=
 =?utf-8?B?ZU9UQVQ1VHM1SnFHdlFuTzIzV1E3eGpycVhyYmlTZld5SkQzMlpqM2pCOVo3?=
 =?utf-8?B?dTRKWWZqRS9CelVOM1l5dHdwQmJxSHRQZXhJVEttQ0JQRDRibXpKMC81Z3Mz?=
 =?utf-8?B?SXZwOXpGcy9uV1BZd050aWZWMFFDS1Z6TUsrUTFYZVorNmRFeGhrbUZTWWlY?=
 =?utf-8?B?UHlGNmRUVmF1d0dUS2tFL1FIdmZzNEx2QkFjUjNRTCtPYnQvdiszcjNYRk9Z?=
 =?utf-8?B?NmYzUjI1Z0ZKTVlyT2wrMUViZ3VtVmRnd0RSbmJMblhzSmNqSmQ3QWp3SjlK?=
 =?utf-8?B?UGNkcjIyT0Qzd3V0MXRCK3I5VTJaa2pxakUvVzFTbGJxV0tUSnBoeC91VzNU?=
 =?utf-8?B?ZkJVWksvQnZLajlBNXVVWExyVno4dCs2TXVMNjdUbnZycFEwRjZ5Yk5GNlFG?=
 =?utf-8?B?anUzYUlPWjBMWFlKbjlDKzhsYXA3aWJTQ1dBVnl0STVETDl3U3lZU0NUOFdj?=
 =?utf-8?B?UVlqRGt0d05aV0lEWWREVXRnRCthU2lob3ZlMFhWdjZXSFBjNExIZGpDaDBp?=
 =?utf-8?B?MnlRdEY1bnJEbVVJQkwvWVZCcTBuVHFSWkJJcVEvVkt2UzUzYmpCSnJjeXIx?=
 =?utf-8?B?b05TcW8rb1loSnp6TE4xaDJhQUVKR1c5UUpGSytNc05KTHIwKzFMdUdXYXYx?=
 =?utf-8?B?T21oaFMvRDVwNjZnWWZ4cjVESDR3bDJqR2x5TjFUMklaS2ptOWxrVEdXcndq?=
 =?utf-8?B?UU5wTDI4RG9IdzBZQUVNajFia2haOFBuU0tobVM5Y25hSTFSME5GcWZBMlZJ?=
 =?utf-8?B?S3A5K0h1TzBWQmIwUldhOEcxTm1IbkZ2MHFMc09haDNtVXZTeHZtYVI0MkE3?=
 =?utf-8?B?L1RuUStWS1czQnhya0tYOTMzTlEybnpwR0ZEbGx1b2MxWXFRZERFU0NLaXVt?=
 =?utf-8?B?bmcyWkQwUWY1QjA4b21scVdsRnZ1UjRRVWNEVVJnZURuNFNXNkgwVDVPRklC?=
 =?utf-8?B?K3pmLy9MRFlSQXowZWRFNldzZFcyVlFkSGQwZjI0eDlKczFoQUxNMTRNMFpw?=
 =?utf-8?B?MnpIN1pSSUYvU1BiR1lCUldzSUlZSTV6alZzTjZNZlh0NDYzZXFzbkNTYmhP?=
 =?utf-8?Q?vsYEA7kcIvI1V7w0en?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <444636A5B7233D42A98A0A8A8420ECE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dhFEvcCsgs4UrZ2QqmCwEh2EHpH7/ocLx+cK0MqtnBgo+Uj8U/IV22uxjkVTC+gj0/COHc9FHMLF2UMhjJhhENjkEValGQOGcCPwllYBc1Yd7e+0jvezTpCvirw3L6L25Cu5n8FE3fAPTEATj89zb807iSBcEzwC92aCO/uKf1TpbJnajs0dLUVsOd6/tlTpntmG8mbZGkkqyLRXF5BnJlsvkT/fvNBnZ/e3bTlBUI23xGR6wKvgjOp4a5sG7G9C+twPfntpGa/3CjPUhk1z6mTQtRg38X02IlrYdviTv2qBPZgZBYjFpznwNeS7svwJ/ez574CKKJnBoQUO3VlXJg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8912711-83f7-484c-c1ef-08df4c724517
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 10:36:17.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaRcD/j5Qd3DLEdZxFJe427kwQ7YPBpwlNK5OR5tCkFthAPMUmumrl+nHsHaI6Xd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6993
X-Proofpoint-GUID: mZqC1t9NleH6O15P5WMSpxdfvj42B5gX
X-Authority-Analysis: v=2.4 cv=N/y8hG9B c=1 sm=1 tr=0 ts=6b095d24 cx=c_pps
 a=B/siD3iED6DfpLjspPGgKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=pGLkceISAAAA:8
 a=sozttTNsAAAA:8 a=UOWCLTSfebwrPlwA0HkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MiBTYWx0ZWRfX6tMk74ymi3vR
 AQAllIIaHM372DEJYs3WKWITcwjsjSa2fBE4Lsa7yesCLp20dHrpjx2zLuQJ5uG+X53CuxLu8ID
 vOlSJt2olblrNOj2TBLPqMOwGFS6rOtpCvZkJt7Dlvm/N9lCa25q1E89vexxMpybG7vGMq2El/c
 q0vfQrGJrYx47th9HOINSKZ18H4uYhbGNTFBc3pNPuBdjrZDqDH/qOHlHaLUNBnA8RnoinpBjGP
 TR9PyoVmj2CSzT56p8MpgeGSoO0LJy34g3LwjOZoUd5eWpYMGuEt/70haKCyaApdGrvxaQisUuZ
 mXhfy27ocQpnGV5wyM9z4XZlkI+vce1QS0ccnnpUnue1Z9rT+QdHoMG6Hv9kReq3i+yRiuhR0uK
 YOEsOaGqsHZCE5rv9GzcBxDK3YRVAqCezAqFyZIM5TsDJXgGEBmqAeNSCsCFEBnevONrIFt1uBY
 6wyZc8gqfx+bmOBAvPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MiBTYWx0ZWRfX97vNXA/riSUp
 RvUZVi2RyA3+1vqhjyrVL+XBs7Thc8/4NTJiN0mfCMZcghQ/1z1dd5udMvB1SBfg2vcFnRO7Num
 GP0Le14cbUTwhH/kv/JbSd7Y/dmwM2w=
X-Proofpoint-ORIG-GUID: mZqC1t9NleH6O15P5WMSpxdfvj42B5gX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270042

T24gMjcvMTEvMjYgMTU6NDksIEFudG9uIFByb3RvcG9wb3Ygd3JvdGU6DQo+IFRoZSBzeXNjb25f
cmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlX29wdGlvbmFsKCkgZnVuY3Rpb24gcmV0dXJucyBOVUxM
DQo+IG9ubHkgd2hlbiB0aGUgcHJvcGVydHkgaXMgbWlzc2luZyAoLUVOT0RFVikuIE9uIG90aGVy
IGVycm9ycyBpdCByZXR1cm5zDQo+IGFuIGVycm9yIHBvaW50ZXIuIFRoZSBqNzIxZV9wY2llX2N0
cmxfaW5pdCgpIGZ1bmN0aW9uIGNoZWNrcyBvbmx5IGZvcg0KPiBOVUxMIGFuZCBwYXNzZXMgYW4g
ZXJyb3IgcG9pbnRlciB0byBqNzIxZV9lbmFibGVfYWNzcGNpZV9yZWZjbGsoKSwNCj4gd2hpY2gg
dXNlcyBpdCBhcyBhIHJlZ21hcC4gUHJvcGFnYXRlIHRoZSBlcnJvciBpbnN0ZWFkLg0KPiANCj4g
Rml4ZXM6IDgyYzRiZTQxNjhlMiAoIlBDSTogajcyMWU6IEVuYWJsZSBBQ1NQQ0lFIFJlZmNsayBp
ZiAidGksc3lzY29uLWFjc3BjaWUtcHJveHktY3RybCIgZXhpc3RzIikNCj4gU2lnbmVkLW9mZi1i
eTogQW50b24gUHJvdG9wb3BvdiA8YS5zLnByb3RvcG9wb3ZAZ21haWwuY29tPg0KPiAtLS0NCg0K
UmV2aWV3ZWQtYnk6IEFrc2ggR2FyZyA8YS1nYXJnN0B0aS5jb20+DQoNClJlZ2FyZHMsDQpBa3No
IEdhcmcNCg0KPiANCj4gKEFjY2lkZW50YWxseSBidW1wZWQgaW50byB0aGlzIHdoaWxlIHdvcmtp
bmcgb24gQlBGIHN0dWZmLikNCj4gDQo+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNl
L3BjaS1qNzIxZS5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpLWo3
MjFlLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpLWo3MjFlLmMNCj4gaW5k
ZXggODIyNjAyODM2YjEyLi5mZGFlNTFlMzY4ZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvY2FkZW5jZS9wY2ktajcyMWUuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2NhZGVuY2UvcGNpLWo3MjFlLmMNCj4gQEAgLTMzNCw2ICszMzQsOCBAQCBzdGF0aWMg
aW50IGo3MjFlX3BjaWVfY3RybF9pbml0KHN0cnVjdCBqNzIxZV9wY2llICpwY2llKQ0KPiAgIAkJ
CQkJCSJ0aSxzeXNjb24tYWNzcGNpZS1wcm94eS1jdHJsIik7DQo+ICAgCWlmICghc3lzY29uKQ0K
PiAgIAkJcmV0dXJuIDA7DQo+ICsJaWYgKElTX0VSUihzeXNjb24pKQ0KPiArCQlyZXR1cm4gUFRS
X0VSUihzeXNjb24pOw0KPiAgIA0KPiAgIAlyZXR1cm4gajcyMWVfZW5hYmxlX2Fjc3BjaWVfcmVm
Y2xrKHBjaWUsIHN5c2Nvbik7DQo+ICAgfQ0KDQo=
