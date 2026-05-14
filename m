Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F129408;
	Thu, 14 May 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722802; cv=fail; b=bSI3wVEP22AlkrRjjwg5iS6eZM+D/mneRec0BmBGYttTxBDDq++AzyI8mIOkE0obBrTzippfS2WVVCwSufQxhfBAZ8DNHykmo+CbodIu1hvtS7Ifq8jKcm3Vydb3D/ZzR6xyHsvlQDHujJqkmZAlPJ6V4abFX0SiSSlppvnX+aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722802; c=relaxed/simple;
	bh=GaqXKSbaPP9dMNzUSkd9zRODXWq0yp42xB2IVFwU12I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJ1Zvl7iA9JFzEca/Y9DpWAfyepmOvfx4tQzqB89GWXWX0dg8v+4WOh1EC+jiuBgY3do4YKKhXX3b+eej7R7j3EDTg9+1Tp/eMl+YyVYI7Uw4VySOFxzYgrJ2gqtMJeWWWPb+OeRiMcH53YPgl53VwCikH1TT7eBuAvmsYzQkT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=L65gOP60; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=5NDuCAQV; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="L65gOP60";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="5NDuCAQV"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DMT6dm3459008;
	Wed, 13 May 2026 18:39:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=GaqXKSbaPP9dMNzUSkd9zRODXWq0yp42xB2IVFwU12I=; b=L65gOP60paPm
	VwBUSR6RgpLhcsjoSdV7qRuTZzNOMje1nL7abPZZobpvJZFuIt8gAJzfK3kJ/m2A
	ADdtZxQsuSFKpPAxqEqJSUIfR0DvMMvA2fPHM+SvXF0HDeN8yUbIzIJ2xKutfWdA
	eLQOg0IIJnkPISSC2hNtY0Xc8uLu0idl8bezDCH6ewXQv95Nx+NSl6dueJv1Kiwk
	iqhVcPI/4hPufTzDhrLLt5caAZxdLX57RCcLEx5E+Cdefc3Xp6LMSwQDhDPcU0kk
	A0Gem9Yn96G84uFoEgoZaTHalyT0LoyhXLuDVpLcoPfZRU7NhQlXYJH1K5ZV1jdC
	LiXSi8urRQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4e4uw72edd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 18:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsu0B5lP/K4K7uPBxvj3cFdWG4s007lAc8BrvT+9uGgirCvUZxsrgvQkQK0PU7C4K9UBY1rY9ggB38l2xLNKw92Ns55Rw38N5/S13OU8BK/Ufj39GPjedXFzsQn1E7gZqqHAFsXx9zsrzgdgSdjEu8Osr5VMKm+J6EHMQHZ/HfZbXZq04fhrcPuNw8Uu0RBK/qZNDFthwrxmwARLqFyNrDKbOodqzC+dfgAsSDvLwACx4p8WLDwKgOwr2mfwpNMn50bdFHsBCj7tJdTFeD7rKPZbKcv5uQYAW2PB1rLNJxu9QDKFmg0B6yDwWjRvjfAwjsit9i1t7ueOZUwGnRf/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaqXKSbaPP9dMNzUSkd9zRODXWq0yp42xB2IVFwU12I=;
 b=wFSolZQbq7xUfgbGqhq9NrXUbU0LqA+/dNA1/PpxAcpq59LhAD7/qt10f9p9UKdWmTR8KS9BCir24OpPIpOJFJyVmaZdH4nSF5EJ+3m3LZd/da2drxJyHgHx0dlqUWSIcYd5DYc2JrVbwx1DHa+oSr08HHbb+Q/xRJPEBHYZba6uNKfc3irRBpSL53FRkAwiK9GOYsfK5j79YB01WCI3U8r91xJo5v6sB3ijAQLtBnms6Hpi59rhjfYatM+qh3Oav0zfrCMh6VQKCoEUcweJTlDU5oII3qBxDEXugijvEMxdJXkJKelKuqy6cUyUYbuA9Rnh4Zx8v2XfmxwQmAhh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaqXKSbaPP9dMNzUSkd9zRODXWq0yp42xB2IVFwU12I=;
 b=5NDuCAQVHMXBGTUMxu514FmPrNDWDVhtBO5ZfDYKS9p5efCQabbthvmvnfekVU1eQFM6eVv8jP3FAkZLBDp8d5v2Y1y7c22DQ6XUwKKVNJMtwVSgh8eSzNbdnbx2wrZC2GHnLILXuBpP+qrVPUI9okTq9UDruuwOdRtnAN9zhwyXRYDPu9Z6K2FSb1L1q8FYS0u7Y5MJEEkoowxVe3ctwyn0xKb6s2QqdanfsilR2gSySSSKlJOylFP8UGLTvREsg4zc06NzScpvFUOd0kxHlCEQ+CJwbzlKn38STXMnGY9si2BcqHUiPFJT9ulvVUnDHOogwfEPL0t3wRR6Qk82fA==
Received: from DM6PR07MB6716.namprd07.prod.outlook.com (2603:10b6:5:1c9::16)
 by SJ2PR07MB9808.namprd07.prod.outlook.com (2603:10b6:a03:502::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Thu, 14 May
 2026 01:39:40 +0000
Received: from DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175]) by DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 01:39:39 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Hans Zhang <18255117159@163.com>, Aksh Garg <a-garg7@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: RE: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Thread-Topic: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Thread-Index:
 AQHc3pyNnZNz+XuLFk2tyTbjytxOIrYLdCMAgAAMzDCAACh1AIAABeuAgAArNICAAAmmgIAA4sbg
Date: Thu, 14 May 2026 01:39:39 +0000
Message-ID:
 <DM6PR07MB671631B20C59B8760D728A3EA2072@DM6PR07MB6716.namprd07.prod.outlook.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
 <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
 <c0bd820d-9716-4109-9d5e-7e72e0716cf1@163.com>
 <31b5f0ad-70a5-4397-8740-6808d0266a7e@ti.com>
 <329f790d-303e-42a5-874f-8eeb616352d7@163.com>
In-Reply-To: <329f790d-303e-42a5-874f-8eeb616352d7@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6716:EE_|SJ2PR07MB9808:EE_
x-ms-office365-filtering-correlation-id: d2ccaa0e-1d6c-48d7-ecf4-08deb159a9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|11063799003|4143699003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 2U+e5ZFH1BElRU/PhOmeq3EyZdEzCMN5dez6DEYUtzfAKlr+qdrbx3LTX2LbrVYCabd/kS5xNhlbs9ryfs/Pa2N9Fwht/uBeMhFwQH9oCVQMjDpDEEQhfqwz8y8n+bVSPPW4jIte1+Om5K4MYsv8I2ah/ykeD8A5eVatnwDc3z43ObynQogC7vF6L895DNRz1f+IwXNM7M4PG5Z+ZZ0ZKe7AuVcWXY1PlDbZ+LuYmPmIQULzq5L85jfdZsAcfHCoOwpcDsUpu7KjsuRGfddPt3kjnURuGtjDfuhFqfSX17iexWTxRe8FVEwo4YJ1IA2lq/TQjDx2GSmYgicm67U8zQ9I+86MAkAsn+9u/K3SXDiZ+jttLz7NstY+W4Al0KgdAL22G2K4bB9l49Jf8dSU2Shw4ojX03CJBsNCf57mePPD/X4PkolQjsyTBhiBz/ssWq2rvMGW91IGmE7b0yvc2VMi0Cb2wzbTfGYDh9kTIQOG2MxHgHbGAJS/7FAZVD7Zi75UOnDGO6NaJdr8V84QqVLKyxP3cSz1XGh9gCxdmqN/QwtXHkAJT2R6PogFjNHAuUbNNzSDrGZ7KFP/FTT5SPn3q6OYQ0weDvVxB5zUv3qdlB8ktinvTH40omNG5aGd33loI5lwXenqzuDft2vbNeJISl57b2TWwMXgyaCS0IxVC+Awsil0h07Tpp2+g5aMcYuRRGs3XSNA0DWSRBbSnygrIkzyFRcQs2hd1tSuPm5sWRAhDg1qmI/JBVsqAsIz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6716.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0orWVpGbHNQZ2djTWVYamtPV1V3bVBITFdxUWVqNDRxUEtLRTNDWitWc25M?=
 =?utf-8?B?V0QxZzNaQWpiWTZyRWZjb2VvTjZQYk02Q3ZqY1RYd0U5UytWcHRxRnpyUzlR?=
 =?utf-8?B?OFVITmlqNDdMeVhOZkV1bU10RFN6bXliTFVIZ29mVjRZRnZUT3o1aEhuNnM5?=
 =?utf-8?B?UnI4Y3ErS3FsNDNiQ3FWV2lQMnBkKzQvWFVZUjlLWGFJTXhmNkkyZG1SbXlp?=
 =?utf-8?B?YURKK3dkU2JtRFpsQm54RGR1MEY2L3E4RmNVb21IMmQ1aVFCU1lMc1FtSzZu?=
 =?utf-8?B?YWZOMVpHL3VVa083dnYyanI2WkVFeTAvSVZtN2NTemgwQzdwbkZQTDRPNTlB?=
 =?utf-8?B?aXpmZDMwbWFWcXR4cGRxNmxEVkV4dGlqMXNHdmh5cVBHQUpqUHpwMllqSDYx?=
 =?utf-8?B?bWMyVGIycWk2Z3NDSENnQzZjV2ZManVSYWdxeTNrMG5iWFdKc3FreldoKzFG?=
 =?utf-8?B?Q29pekYvMHY1UmZBdmw1ZGdqYWx0K0l0V0NoemU3YzhRdWFKem9ZYkhGK2Ni?=
 =?utf-8?B?MUpUT3J1cDRCVTdXU21Oc0VwcHdySTRvMEtoRnFOMTJ0VG9KSCtDY1RhbUNB?=
 =?utf-8?B?UWZnOTIyZHpKUERiN0RjQnZvazhtZDU5R1RtRzkySnJ4bFlkVWFCdDJJWHBT?=
 =?utf-8?B?K2hqRG9RSVMzdHUwSURROEpiTGhHcThiaWtEK2ZOelpickp1SnRyNVJ4R2dr?=
 =?utf-8?B?ZEtRbWlSRnB2UjMwTTBpait1N2xuRGtGbjZXUHNmT3EyOTQ2UHRRQnZwMFp2?=
 =?utf-8?B?SmNISi9sM055U2RFdGlUZTFnM2dsb1B0dkhDYlA2MUowaHF2RmZ6OHdaSWtk?=
 =?utf-8?B?QU1KMUJZQ3ZQZlJWdXVkdTkxOW1nTk4rSVRGbDlzZERraEJpNDBBM0pkU1BD?=
 =?utf-8?B?WEc5ck9BVW9mSmxoYXZ0Tmk4VlJLY3FIUzNIWko1d2dia1FIRFh1Q1IwNnkz?=
 =?utf-8?B?Z3Q1UlA5SjNTMUYrT09RRk5xVXVybDNwYjQxS21SSm1EV2J6bXM0K3MzeFFv?=
 =?utf-8?B?TzZqdlVNRjBJWElMY2JqMlIzNnpnWHM1amZYWXAwbXFQVitKcWp4bk55enBS?=
 =?utf-8?B?SWY2NFFxRUZqOHZPVzZYTm1TTDVhVkR1NGIvMFIyWGdiSFNjT3dYSXhDY1Zt?=
 =?utf-8?B?TlVQMnUrMlNMaDUzVjFoVWhucHV1MVVYWVI3ZjV6VEFrK2U5SmFINGdHZHU3?=
 =?utf-8?B?dlRUM1FCVWdxTk80cFl3WFJ5bjZGS2ZpMEIza0xpeTFuM2cvemVzbC9UdzBJ?=
 =?utf-8?B?R1NqcWRuM0dzcU9Qb3pUUTFyeDdmclBGblByODY3bVRqTkpsVnJKYkRJQVZZ?=
 =?utf-8?B?TGNqK3B0K2ZBbGtTY1htZ0RjNUdCTlZUYnhqSzRaYk96eC9xQWFNcUNxbmdG?=
 =?utf-8?B?WWdpOHIxVExMQzR4QXg0RXBWUkRYdW5BYWlUb2JaUTAvMjJwTlZ6NkFLVUVs?=
 =?utf-8?B?QVBBWldFOG9iTnhyS2FMMDE2V0xINm40N01NVzVIOExPSGx1UUxNOE9rMGtj?=
 =?utf-8?B?OGI1SEdxbzBnZFBJRE5UeUYvYlV4SFFoVjRoK3hsdExYTWhYUUM0bHdSUWYz?=
 =?utf-8?B?ckI2bm96cG8rVUpibFdKekhEZHZJd1JzeXErNmxJQmlXTXArOGExRkNGTnpk?=
 =?utf-8?B?dzNzMnVUQ0d3T0Q2SXZORDNDcXZ0SkpIT29jRmxaM0ZaUURMMVdGcHRFYUpB?=
 =?utf-8?B?b2s0UjBJNUUxNEZKNGlkYTFCbTBuUE1UcGNXNFh3TEZwYjZDWkErU1hWaElL?=
 =?utf-8?B?NW9zV2FUbmttdVJBbjhUZVpWOThmNC8wQXA4dlZUMW5KNFdVdUdsd0hOQVo0?=
 =?utf-8?B?ZnVlbUdlUEpaemVMT3J5cFZNdlA1K3NXSm9LTzV0aUlPY05TcEg1eWtMNkRU?=
 =?utf-8?B?WVJzekxNYm9Zd04rVUlkVVYrUkNRdUFmUU9aMnI2dk94ZWM3RWlJMnV4cEZj?=
 =?utf-8?B?bXg0TEwwc3VEUkg1UzY0K0RtTnNNL1VMMW1pWk1DU3BqVUVxZjhuN3BRK09i?=
 =?utf-8?B?QTBOeG1zVUNYajk0RG9ua2tEWnhjUlJ6OEt4dUpjMldOMXBjb0hUVXV6OVht?=
 =?utf-8?B?bXRXNUdqYS9EbFNiRmdpZHllT1BmZnBCaW9TRnFtQUoxekdLR0JFU0Z4UUhD?=
 =?utf-8?B?QVB6T0E2R3ZtZmhKRmhjRkxUTHZvUENabXhEOVhVZkpYc0pES2Q4Rm9NRkJ6?=
 =?utf-8?B?WS9iRFRWUGpZZFRUWllIT1MrWjlGSWM3STJpclBEM3pRZTk2SUxiWlI2V1Bl?=
 =?utf-8?B?dUVmNjdVM2lFRGNQY1hPM3A2TkJkaWw1NVNmZktsUkJKWUdUMms2LzJ6dzZM?=
 =?utf-8?B?WjFOZkh2eEE2NE8wZkphbVlLQUEwaGFDOUZsMTFYMC92c2hpN3VJZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HgyN1fJCmMuupGKL4x3wK0eYajiHDXOD35MpSZBVfesILCjc8uMgtLMn/lbM+GHY3UQD6cZ8vOmFsaUrrLDYTxALtQfcRYMfs3LoWvSOmWLIjQfm4ZETY6HWU5Gtf6gwnghkcyJaRA0MC8sXdcNvDcRdqibfs0iFHga08NJ1ezpQay3C3hu9JXMr4dpNf240lZp1Sjq6123BmZToZw+EAXRc3+EDm9FAD1cuGCydxT4C1abYRx7nTxubkZ8uVLqwc9LXlBhHCG5xiSK8Pn4ZgRZ7VurIcOkOwTm6g3G/KwlN3WCG5sOQde3rYEamITX0+jFZl7Quvc6KZ4x+79CtTg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6716.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ccaa0e-1d6c-48d7-ecf4-08deb159a9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 01:39:39.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iMpvpEib63I/kwQ0J9W0wnQyeUyLJOEaDn9ve5btRdM7cCKo7JG7gfdtOGA0gR2Vf1KQAjpJY0UetnqNEjMftJQXbhxO8XGR0Z2Fv7DSiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR07MB9808
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxNCBTYWx0ZWRfX4I/JrhZ3L13k
 td3whGF4RBZ26JantWaIGngBNB5FNYq8PfQ3dPSxaNNq3lBVaafLXirAE6EomR4HhGdf0cW+vRG
 lBbRtRuPcy7QjmBp+cClSLL3nZs46oryyFcpMZlSgkI9LvRLfwySQYM1yMwr5afY1rPLSxDTRbM
 Qs/8YW8Z8w8qPu3af+R8lzYB2pPL7IMCeZA7DEwYJMAGrlSXYE4PQXGUO19y0VTodurW8Erdfiy
 mGFwKC1rFc9uizvfDhLdJKhZ5tvVrts21jhYlah04/qJRmzam445H3pAAN1z0Ednt9SywkaS26w
 wrFhhDGB6ytcjD7aBJbNnDKksLktCdjLA3aYafD092HtjsF7ExZGe4LrVZscfltFxG0cIg+q9zk
 /5v/vAyEWS/ERc0CMhCEBtQaGKnj0yHaAt8PtRB/QoqesIy20xOd7lCT/XtJqsMTEhsO0saaDS4
 FXgbNqJG8sX1G2kz1wQ==
X-Authority-Analysis: v=2.4 cv=FccHAp+6 c=1 sm=1 tr=0 ts=6a0527e0 cx=c_pps
 a=HPJBkY93y09GhBhYB2jcmw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=PxpEU8WjU02z4L8h0j4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 26VakcOVdL-tEaRxgjPZWgL4WR1W8JqM
X-Proofpoint-GUID: 26VakcOVdL-tEaRxgjPZWgL4WR1W8JqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140014

DQoNCj4NCj4NCj4NCj4NCj5PbiA1LzEzLzI2IDE5OjMwLCBBa3NoIEdhcmcgd3JvdGU6DQo+Pg0K
Pj4NCj4+IE9uIDEzLzA1LzI2IDE0OjI1LCBIYW5zIFpoYW5nIHdyb3RlOg0KPj4+DQo+Pj4NCj4+
PiBPbiA1LzEzLzI2IDE2OjM0LCBBa3NoIEdhcmcgd3JvdGU6DQo+Pj4NCj4+Pj4+Pg0KPj4+Pj4N
Cj4+Pj4+IFRoZSBhYm92ZSBMVFNTTSBzdGF0ZXMgYXJlIGludGVybmFsIExUU1NNIGVuY29kaW5n
IHN0YXRlcyBhbmQgbWF5DQo+Pj4+PiBub3QgYmUgYXZhaWxhYmxlIGZvciBzb2Z0d2FyZSB0byB1
c2UuDQo+Pj4+PiBUaGUgTFRTU00gc3RhdGVzIGluIHRoZSBkb2N1bWVudCBwb2ludGVkIGJ5IEFr
c2ggKFRJIFNvYykgYXJlIHRoZQ0KPj4+Pj4gc3RhdGVzwqAgYXZhaWxhYmxlIGluIGFsbCBjYWRl
bmNlIGNvbnRyb2xsZXJzLg0KPj4+Pg0KPj4+PiBJcyB0aGlzIHRydWUgZm9yIEhQQSBJUHMgYXMg
d2VsbD8gVGhlIHRlc3QgcGVyZm9ybWVkIGJ5IEhhbnM6DQo+Pj4+IHJvb3RAb3JhbmdlcGk2cGx1
czp+IyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvY2Ruc19wY2llX2EwKi9sdHNzKg0KPj4+PiBMMF9T
VEFURSAoMHgyOSkNCj4+Pj4gTDBfU1RBVEUgKDB4MjkpDQo+Pj4+IEwwX1NUQVRFICgweDI5KQ0K
Pj4+Pg0KPj4+PiBUaGlzIGltcGxpZXMgdGhhdCB0aGUgTDBfU1RBVEUgTFRTU00gc3RhdGUgaXMg
bWFwcGVkIHRvIDB4MjkgKDQxKSB0aGVyZSwNCj4+Pj4gd2hpY2ggYWNjb3JkaW5nIHRvIHlvdXIg
cmVzcG9uc2UgaXMgaW50ZXJuYWwgTFRTU00gZW5jb2RpbmcsIGFuZCBoZW5jZQ0KPj4+PiB0aGUg
cmVnaXN0ZXIgcmVhZCBzaG91bGQgaGF2ZSByZXN1bHRlZCBpbiAweDEwIGluc3RlYWQgb2YgMHgy
OS4NCj4+Pj4NCj4+Pg0KPj4+IEhpIEFrc2gsDQo+Pj4NCj4+Pg0KPj4+IEZvciBIUEEsIG15IHZp
ZXcgaXMgc2ltaWxhciB0byB0aGF0IG9mIERXQyAtIGl0IHJlcXVpcmVzIGEgY29tbW9uDQo+Pj4g
aW50ZXJuYWwgTFRTU00gc3RhdGUuIEZvciBlYWNoIG9mIGl0cyBvd24gUm9vdCBQb3J0IGRyaXZl
cnMsIGENCj4+PiBjYWxsYmFjayBjYW4gYmUgdXNlZCB0byBpbXBsZW1lbnQgdGhlIHJlYWRpbmcg
b2YgTFRTU00uIFRoaXMgcGFydCBjYW4NCj4+PiBiZSByZWZlcnJlZCB0byBhcyB0aGUgaW1wbGVt
ZW50YXRpb24gb2YgdGhlIGZ1bmN0aW9uIGluIERXQy4NCj4+Pg0KPj4+DQo+Pj4gc3RhdGljIGlu
bGluZSBlbnVtIGR3X3BjaWVfbHRzc20gZHdfcGNpZV9nZXRfbHRzc20oc3RydWN0IGR3X3BjaWUg
KnBjaSkNCj4+PiB7DQo+Pj4gwqDCoMKgwqDCoHUzMiB2YWw7DQo+Pj4NCj4+PiDCoMKgwqDCoMKg
aWYgKHBjaS0+b3BzICYmIHBjaS0+b3BzLT5nZXRfbHRzc20pDQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gcGNpLT5vcHMtPmdldF9sdHNzbShwY2kpOw0KPj4+DQo+Pj4gwqDCoMKgwqDCoHZh
bCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9QT1JUX0RFQlVHMCk7DQo+Pj4NCj4+PiDC
oMKgwqDCoMKgcmV0dXJuIChlbnVtDQo+ZHdfcGNpZV9sdHNzbSlGSUVMRF9HRVQoUE9SVF9MT0dJ
Q19MVFNTTV9TVEFURV9NQVNLLA0KPj4+IHZhbCk7DQo+Pj4gfQ0KPj4+DQo+Pj4NCj4+PiBzdGF0
aWMgaW50IGx0c3NtX3N0YXR1c19zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdikNCj4+
PiB7DQo+Pj4gwqDCoMKgwqDCoHN0cnVjdCBkd19wY2llICpwY2kgPSBzLT5wcml2YXRlOw0KPj4+
IMKgwqDCoMKgwqBlbnVtIGR3X3BjaWVfbHRzc20gdmFsOw0KPj4+DQo+Pj4gwqDCoMKgwqDCoHZh
bCA9IGR3X3BjaWVfZ2V0X2x0c3NtKHBjaSk7DQo+Pj4gwqDCoMKgwqDCoHNlcV9wcmludGYocywg
IiVzICgweCUwMngpXG4iLCBkd19wY2llX2x0c3NtX3N0YXR1c19zdHJpbmcodmFsKSwNCj4+PiB2
YWwpOw0KPj4+DQo+Pj4gwqDCoMKgwqDCoHJldHVybiAwOw0KPj4+IH0NCj4+Pg0KPj4+DQo+Pj4N
Cj4+PiBGb3IgZXhhbXBsZSwgaXQgY2FuIGJlIG1vZGlmaWVkIGFzIGZvbGxvd3MuIE9mIGNvdXJz
ZSwgdGhlIGZ1bmN0aW9uDQo+Pj4gbmFtZSB3aWxsIHN0YXJ0IHdpdGggImNkbnMiLg0KPj4+DQo+
Pj4gRm9yIExHQSBJUCwgY3VycmVudGx5IHdlIHdpbGwgYWxsb3cgZWFjaCBSb290IFBvcnQgZHJp
dmVyIHRvIGltcGxlbWVudA0KPj4+IHRoZSBjb3JyZXNwb25kaW5nIG9wczo6Z2V0X2x0c3NtKCkg
YnkgaXRzZWxmLg0KPj4+DQo+Pj4gc3RhdGljIGludCBsdHNzbV9zdGF0dXNfc2hvdyhzdHJ1Y3Qg
c2VxX2ZpbGUgKnMsIHZvaWQgKnYpDQo+Pj4gew0KPj4+IMKgwqDCoMKgwqBzdHJ1Y3QgZHdfcGNp
ZSAqcGNpID0gcy0+cHJpdmF0ZTsNCj4+PiDCoMKgwqDCoMKgZW51bSBkd19wY2llX2x0c3NtIHZh
bDsNCj4+Pg0KPj4+IMKgwqDCoMKgwqBpZiAocGNpLT5vcHMgJiYgcGNpLT5vcHMtPmdldF9sdHNz
bSkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHBjaS0+b3BzLT5nZXRfbHRzc20ocGNpKTsN
Cj4+PiDCoMKgwqDCoMKgZWxzZQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgdmFsID0gZHdfcGNpZV9n
ZXRfbHRzc20ocGNpKTsNCj4+PiDCoMKgwqDCoMKgc2VxX3ByaW50ZihzLCAiJXMgKDB4JTAyeClc
biIsIGR3X3BjaWVfbHRzc21fc3RhdHVzX3N0cmluZyh2YWwpLA0KPj4+IHZhbCk7DQo+Pj4NCj4+
PiDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+Pj4gfQ0KPj4+DQo+Pg0KPj4gVGhlIHByb2Nlc3MgYWJv
dmUgdGVsbHMgaG93IHRvIHJlYWQgdGhlIHJlZ2lzdGVyIGFuZCBnZXQgdGhlIExUU1NNDQo+PiBz
dGF0ZSB2YWx1ZXMuIEhvd2V2ZXIsIG15IGNvbmNlcm4gaXMgd2hldGhlciB3ZSByZXF1aXJlIGRp
ZmZlcmVudCBMVFNTTQ0KPj4gc3RhdGUgZW5jb2RpbmcgaW4geW91ciBkZWJ1Z2ZzIHBhdGNoLCBv
bmUgZm9yIExHQSwgYW5kIG90aGVyIGZvciBIUEEuDQo+PiBUaGlzIGlzIGJlY2F1c2UgdGhlIEww
X3N0YXRlIHNlZW1zIHRvIGhhdmUgZGlmZmVyZW50IHZhbHVlcyBpbiB0aGUgTFRTU00NCj4+IGZp
ZWxkcyBvZiBkaWZmZXJlbnQgSVBzLiBPbiBMR0EsIHRoZSBMMF9zdGF0ZSBzZWVtcyB0byBoYXZl
IHZhbHVlIGFzDQo+PiAweDEwIGluIHRoZSByZWdpc3RlciAoYXMgY2FuIGJlIHNlZW4gaW4gdGhl
IEo3MjAwIFRSTSkuIE9uIEhQQSwgdGhlDQo+PiBMMF9zdGF0ZSBzZWVtcyB0byBoYXZlIHZhbHVl
IG9mIDB4MjkgaW4gdGhlIHJlZ2lzdGVyIChhcyBjYW4gYmUgc2VlbiBpbg0KPj4geW91ciB0ZXN0
IGxvZ3MgaW4gdGhlIGNvdmVyIGxldHRlcikuIEhlbmNlLCBpZiB3ZSB3YW50IHRvIHByaW50IHRo
ZQ0KPj4gTFRTU00gc3RhdGUgc3RyaW5nIGluIHRoZSBkZWJ1Z2ZzLCB0aGVuIGZvciBMR0EgSVBz
LCAweDEwIHZhbHVlIHNob3VsZA0KPj4gcHJpbnQgTDBfU1RBVEUsIGFuZCBmb3IgSFBBIElQcywg
MHg0MSB2YWx1ZSBzaG91bGQgcHJpbnQgTDBfc3RhdGUuDQo+Pg0KPg0KPkhpIEFrc2gsDQo+DQo+
WWVzLCBkaWZmZXJlbnQgY29kZXMgd2lsbCBiZSB1c2VkLiBUaGUgcmVhc29uIGZvciB0aGlzIHdh
cyBiZWNhdXNlIG9mDQo+dGhlIHJlc3VsdCBJIG9idGFpbmVkIGZyb20gY29uc3VsdGluZyBNYW5p
a2FuZGFuLiBUaGlzIHRpbWUsIGl0IHdhcyBhDQo+cHJvYmxlbSBpZGVudGlmaWVkIGJ5IFNhc2hp
a28ncyByZXZpZXcuIFNvLCB3ZSBuZWVkIHRvIGFzayB5b3UgYW5kDQo+TWFuaWthbmRhbiB0byBj
b25maXJtIHRoaXMgTFRTU00gY29kZSBhZ2Fpbi4NCj4NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+SGFu
cw0KDQpUaGUgTFRTU00gY29kZXMgYXJlIHRoZSBzYW1lIGFjcm9zcyBIUEEgYW5kIExHQS4gWW91
IGhhdmUgdG8gcmVmZXIgdG8gIkV4dGVybmFsIExUU1NNIHN0YXRlIGVuY29kaW5nIiB0YWJsZSBp
bg0KdGhlIHNwZWNpZmljYXRpb24gZ2l2ZW4gYnkgY2FkZW5jZS4NCg0K
