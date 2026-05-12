Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A54657DB;
	Tue, 12 May 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566605; cv=fail; b=LGyEIEzZASCvsju6ueGZ8y0IBCX8/NCXAfvPjH8Iu6Bdtw0mJf+mppZ6rUpV0VAOe8p5Gwc1wPph8sGAWb0hY1pJdpivX8eDT1eTP2x2l90ETPuGAwEFGNK2mx/54NOToE4glz5aPo0op/2vLAz7oqTFKG/TrEhTyRlJhwsBHzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566605; c=relaxed/simple;
	bh=eAOqAiR9g3ZfFNA0TCPFd5/M8iCJKjAbZrFJ7mu35mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eI0ePhj5H0AompMlcJPkt1XtZBWR6wfip5M0YxHBaik6HbXMHrNEktTPcXN+5nX10041J+5nWeivX8rBAs4+vbGoa9WgDb0TbWkLLfKD/hPJJL1Ip28PZ/7XbH1KsPQTY1rGXm0nRH8/6l3pP1/1EWfN3xxvTI1bFdts5/LP5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=gwMgtPVm; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=zQ9Aq6tK; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gwMgtPVm";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="zQ9Aq6tK"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C1hSUm1932457;
	Mon, 11 May 2026 23:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=4Gz9TXBjAZS8QTR16KOzvvUalP5yfHJO6qcONA8WOc0=; b=gwMgtPVmbYLw
	89VTD/dfACy5iqliVzmGk9AYVu6fyM30OMoWV0YVbznceiLrZxFYe8CtHQLklmxe
	ug6NBH3dGqgROFmhKFaAHW+rj1lJTQeGESV1E4EeQWscHPW4/MbDYias36TV/zMB
	TbBqKbZRBLNZg/kWJMYqytBdKTTTnK8U8/QmOaKSO/h4VhQidJR0KoWNLjHOFkMT
	A/TwlJ+a6uBGggbclBPcxqxdRb9/6q/AHRuMqf5AhsQBOeWmo/i7HScHKgPjXCfX
	N0KSp3r5UZjcTVq23sQe4wGYoqbtamQA/F+nFOB/6rSwC+i+n8P7/Kq6xy6ualTK
	2DT4JQx4vQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4e3nw6t4n2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 23:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkLkgFJ8uLKBQsO7gKOutd0TYRSVN7w0q5jb4IgsIJD7Dzufr1OCTJsqvcSpFklOdo+F9jG95gPz6nXOJb89b/+gh9TTu5lCjGDILTTkS7gxvHHmGtBFlvxmNU7HbF854oxhBKOu5Da5NHt+UoZXR3phhJe354WtMZNDGe5kdd2X/axRXVRYyutAyVQNfg1gMv0iWZSOeitMwrMdX09StmbIntoeYrKp2iqSqq+q5XlNiC5VkeeClebyvsndyI/vrWWUVUnjAo0Jdu/Rgnuagpk1mL+IWF6rN7S8ZsCY7CsaqLFuXsq/SlwK9B0NaLI6pLxKd7flCr1xCP0THsGtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Gz9TXBjAZS8QTR16KOzvvUalP5yfHJO6qcONA8WOc0=;
 b=tQuXcomKvYgGHRaJ0CCm0mgaoytCNntYM78CU53x5uY8l6/c0YXIbaKaBXfwd7dt/pZ+yfElTQhI0UeeaRr7t4yao9qFi514KBmDzGriaj8SyvnV8WVIe3fBRTSRPuepS2ZWsO1IE4Dood1/gAQfxO5tkVS0xbA80fFTSMwytyr+8fuHLal8C4caJYIu5nnZT7jjlIpXxoPCFQoEzJX7wrZ/YRhOxkZH+F+s8aJjd/wfm4DqgF7/hfff+e9NrU9eNMmzC5BpYXx5DnnYBJOx0xCeqsO84pYxFn1O6g3hislOMviOweamOCBMhKI5sJHFMwATZFovdw3TqD5VoscVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gz9TXBjAZS8QTR16KOzvvUalP5yfHJO6qcONA8WOc0=;
 b=zQ9Aq6tKkFlmfFcCJdVMgxucPSQ1ReDCvz7nzzFUGUES+I295qOi4L6l9AQUXDFrZCxcg2XHCykE/v/d3T/5lw8UV9B3rCrGHo+mQv0CK3RXJTnT+rwWNddb66P61urAKNbRDOeV5vNLExzP7Jke7jocMU8TxMfQZ2REdugowIT+yJd7rLx3NAlSbjVNsy9Lfk9Xa0R4tYXEoY9wzExDDxblrW8q5HBYBKp8WqJ2c6ZKYBS0I1ZVfjz6UyEeIeD4LXGpQ8x4sdNDVFzjbGTRv+GsixT5pjNeEug4A1EzKh3cG8iQwcAoXnyM82gsSRqza7879dqBisDxz1VaavT0Wg==
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by IA1PR07MB11605.namprd07.prod.outlook.com (2603:10b6:208:59f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Tue, 12 May
 2026 06:16:15 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:16:14 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Peter Chen <peter.chen@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3] usb: cdnsp: Add support for device-only configuration
Thread-Topic: [PATCH v3] usb: cdnsp: Add support for device-only configuration
Thread-Index: AQHc3tA7khmSlPRP10aynj5gM8QRpLYENDeAgAW7lwA=
Date: Tue, 12 May 2026 06:16:14 +0000
Message-ID:
 <PH7PR07MB95387990CD79E876AE0E376FDD392@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20260508-no_drd_config-v3-1-0614f5044721@cadence.com>
 <20260508144241.GC85390@bhelgaas>
In-Reply-To: <20260508144241.GC85390@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|IA1PR07MB11605:EE_
x-ms-office365-filtering-correlation-id: 63d2741b-879f-4e7b-e8f2-08deafedf89f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 eBVUA9eTblCGr/C60/cfK6LMrXI+hIj7sImb5GdLUGfDfHCH+EwFp8J42y+s9d3p9bVmx+dS54o8w6zkwgNdsfZzOCK8i6JhvV5viGk0SQRMdkxw2ORIDbXA4j/qvrBamKSjuDs2zeaaVcLmU/DSQpOONTDSOmBfx4QOGZGcBra5fXXz1V2+1TZQcMOdgKSPIqj9mieewJvCC2j6ySZxbdlh9DFIDGmNuXIHYX8JDvo/ANeoRo7Yz9wdd9h4ph7Yy0Z0axP3IF4haXYhcQClFQcsD9UFhUUzYIJuNYXh/aArGQDjP+DSnGG0lmHCMNfAs9BFK4DSJpK4oTGINYv9BvPlu8+4P7Jz7qkDZhRJEIHH+lk+MgH9UaSCyQk+163BsOnEGrFaDqeBxoQyIlgZHbNfVFMfJglUa6KndHkSJyu38p1NR+b8kyW5uM8CQnYM85CKVvrcOimdR2ZM+iOESAKrqmOLj/pEI0qmWSPHO/Fi/MNNL01xCiGyXrQLMnS31heSrl+GA6wkUcaxJXCTK6g8qXoykYZcKMMcfaK6vaC6b+isgj1+7K1B6RFy/aYQeDXsBtNYpjhGQuFZjah/+aNg1eNkcRNnmp8jR8EcvhJqUJQ/jgGsxi3VLtR07KFkJZIkmyUac97SJWufJVeXMa7nV1pwNS2XEdAJoQXbEQaHCf8Wpu51KLLAUrn82kvLTupLCdsZ1sENQp5SsjMFIA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oeL/bX7ridnt+t0qNhfzLrgbRyIOQnYztIlw34uQ2YyHjbEtjxE9eCTasvpW?=
 =?us-ascii?Q?oGT9Htp8qLDttEC67wE77e9iNDO/Uzox5rvYuveLjpONkDwcLCLhqxN8yLag?=
 =?us-ascii?Q?0yywDOGijQsrfcDogxlDj+7JmWsO8MbeAZI2Y3bXGL8LCGq6DX6sRTVDJIN3?=
 =?us-ascii?Q?VfmtMNB6CHnEt/x1OZs2d4D2qM4f0oqXwu7v5nA+3ofYa0iJoxjRPlvp+j+z?=
 =?us-ascii?Q?uUHrRWeA7FwmvTZOFzJWIEtUImrI+sFP6qSmzzCEC60ztYjZVURZujaAVKgg?=
 =?us-ascii?Q?WlD0TD6v3hobPwxi2Ythqq45jTKhR4lcuDNN/u7JDCr0UrvJtzi0OVqcaU3A?=
 =?us-ascii?Q?HsCzNZfm8OGIoLrCs2PF6tSTjQjYbyeIByj3+IhGyDgYqQ/QngvTuJsPrhOb?=
 =?us-ascii?Q?Wh8hftUJmno2tqgiBhu1cEO2L0BLdmjKX2m+pEJtUJ1WYGGZ3mI7a/VzsVfk?=
 =?us-ascii?Q?dQsPv73GXBCzl2/zcpCjasabHMxj1dOJezNzUlIrVUQlo5iljkcHRtd+GXxx?=
 =?us-ascii?Q?3B5WUir7P5wt5aD30Sx6KgE5ypkEBciNV6SQ7GO4RLYSE5djoaKvPeIU0IG+?=
 =?us-ascii?Q?Su3EnV6QezAXINX8mhx1TRhFIOAmLIW+OQwjys0x2HJrfn82I3Cyq/Qv7EYE?=
 =?us-ascii?Q?Mzj1P5+/hbheaDGgc9WXTDo4+femyUze3PC+75EG1ipIGpqke7p5r5Mwz9Yt?=
 =?us-ascii?Q?dFCymunjfWVGtTIYH9jEBapON+nYOE+33UCR0auzkeun7RmADUNKdXtbyIpw?=
 =?us-ascii?Q?+YMRMy5m+OYHA1GzmJYdfnH8PD48Lm3shHwF3eqcyz3nhkMFQZXhITKOMfQA?=
 =?us-ascii?Q?fcG2I39QW3nfeCLK5h3ewF5grdKA8rQceoVO40hOlntuoCffVRP/HEwgreQL?=
 =?us-ascii?Q?8r1XRvwq7k809hptMZ6VBD2iL+6Vhzg8zWPM995DV7rIZGJMAFt5vPZQ258i?=
 =?us-ascii?Q?Y11UdrxqnZTyOHuueyq0svW6rKMeIi0WRQ5GW/c/2eHxjcWFUaOY+moONZjH?=
 =?us-ascii?Q?mBHJ/HoKazR54TeMczEr6psk2hjlx1UAidXB0Iwj3aykA9QHiqMdizarnYEn?=
 =?us-ascii?Q?Fv29XyQHJ9oFAwx31MZ9odr//3Omw6zIKs40J8oYgz/NCx3Wm/HItHIOJhWx?=
 =?us-ascii?Q?+TdEFk1mv8AZ1vBsKg1CPTOKTBBKAz7ZscYw7pWIJKVIEyipBNimDWIAi444?=
 =?us-ascii?Q?GLSR43y+TpW94O7t2x69ArhwJ5jIa9VZvHIAPY/Z0tllPeZVcLnREKPjyVzx?=
 =?us-ascii?Q?q5FerPTLZ5TQNqMc5kp90JjQSEV89DZ/oUoAQ0ck/RVoy5lRpT7E3GAE4a1Y?=
 =?us-ascii?Q?+yQHkhDA4UPTPryPQ/q9ucgYB5EfDSp8hul1VQsqlBz50CNDsLXefYUMzqhg?=
 =?us-ascii?Q?WFPU+ptYu/XuPJdskHif2N8iJjg8XGtOYP35s81K10BXTrT9uoYl9UoR+ZsN?=
 =?us-ascii?Q?Fvd4PYaGznYIJG117A6avPwg70n4PIlspu4Y4BYAY0psePrC1Xd5KoiiJ8/1?=
 =?us-ascii?Q?jPAdWqmoFRibVzSFKhmmX03lgwBueF1KZUIatb2T09lcXUbdyzztuHjHnrI5?=
 =?us-ascii?Q?iZ6nQDzthukNd5WXE2wa9OYgobwZ2qzZ5KJghx7/ZY9SxYC7pHJDOuoj8C7u?=
 =?us-ascii?Q?I09mLy00RgE7BSovwJGJFPDRQLR3l0ESMnyXAZqoOP5qQig3hFN1weopjv2k?=
 =?us-ascii?Q?6pcc07hsfa5wLCEcdsgR88yRSOG8df2PMWj3occdIVYNuU3J0VZPfMFt5J7o?=
 =?us-ascii?Q?SXIvN97pEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DJM55KIHZ96KctYXj1PlgazQ2M7MvG0LHjcco/yEIkgVVehIq631BsELvR0K1nTdwcXRP2/JT/OfmVA0U+Fc9I4RigSHg8lFBV2vn6ryE5cQSIWGOCSnKlqZ5w5mb1nJyzIvVUSD8DqkM9MrR8ED0i6pC+MWotaFh5mtMaBw6SXIP4QHDHCIysH0jOISWPufJTu4dp1Nruh0X9wPbc1TkrqqC/VxbNZCOgxCuylMq1u3qbkKpUKFPv/4U9OBIDfk737eQfxKApfUiWXUyJGNa4KHZoTWndXWVJy3gC8tw5dyESVdyY425cG/nmU1nPiw5546qpXTQoufTXvcBsa7AQ==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d2741b-879f-4e7b-e8f2-08deafedf89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:16:14.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGEvwYCQ7bXXLP9A4kl3KH3hWQcpq4sI0H8H7H7x6aCAn1baVEQtgsmcyw+2iKKz5qRZkPEqS+T3cIIL5otbt0xPgDpbSLBqNIUqfBxbpKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR07MB11605
X-Proofpoint-GUID: vXUvlOCOl6EMCEWGsDdGiW6AubuuLRPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1NyBTYWx0ZWRfX81/uAvWaF0K8
 s9WGNIUXb+It7/3BvLqa1spxCNgib6Im4P9SmE8uLZkrtvXontyokdG20QcancyZwXEAYqk/aRW
 GHAlM1+wQzjq+i/Hh/8yMh7e0vjYX+maH49yRNsa40dAXN4AbOsfbGgs7bROac+xCFAsIYWH1Ct
 EdbJ38W3z32CO1j2LBxq/m9niZT1TvtsAdU8UFCnqzv758aFN1pIwmOzQIqOsjefv2t+IJxxfaG
 y+OZMTJNXj8ZSfJ6RtqJEw5VG8WaSFAYWqumjH0/QiyZ0TD+NFw7qYIB0mm1ynGBwa02zYVlzdO
 HqDFJq0KJ7LxmqFKAxSGctoUzLMkqq93HwB3EassRGEVTbh8K1qS/cJn+dK9MtmNeoPJ+1ES+//
 TQB+lenldSHk18x/qZ6HcC6MLsP6ERdULcYewwjbZVfN+wPdvSKiEdS5VJL8e2+4scz3vwM2lCU
 6GILnqk+rmwWi+I6QbQ==
X-Authority-Analysis: v=2.4 cv=Yow/gYYX c=1 sm=1 tr=0 ts=6a02c5b1 cx=c_pps
 a=AQ8jqBFaYtg5UXnSSWtk/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=uherdBYGAAAA:8
 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=1XWaLZrsAAAA:8 a=EPu3sM6_wX8Dz0J9X44A:9
 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: vXUvlOCOl6EMCEWGsDdGiW6AubuuLRPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1011
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120057

>
>On Fri, May 08, 2026 at 12:06:39PM +0200, Pawel Laszczak via B4 Relay wrot=
e:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> This patch introduces support for the Cadence USBSSP (cdnsp)
>> controller in hardware configurations where the Dual-Role Device (DRD)
>> register block is not implemented or is inaccessible.
>>
>> In such cases, the driver cannot rely on the DRD logic to manage roles
>> and must operate exclusively in a fixed peripheral/host mode.
>>
>> The change in BAR indexing (from BAR 2 to BAR 1) is a direct
>> consequence of the 32-bit addressing used in this specific
>> DRD-disabled hardware layout, compared to the 64-bit addressing
>> used in DRD-enabled configurations.
>>
>> Tested on a PCI platform with a hardware configuration that lacks
>> DRD support. Platform-side changes are included to support the PCI
>> glue layer's property injection to handle this specific layout.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci_ids.h
>
>I did ack this
>(https://urldefense.com/v3/__https://lore.kernel.org/linux-
>pci/20260331181209.GA148250@bhelgaas/__;!!EHscmS1ygiU1lA!FuLlHX77O5
>UQAo4VHUkfgZidHZN93lMxhVIR_vVAG4bwI0IoUUHK7pB-CiNE7-
>PxraJZow0ZH7Q5BGk$ ) but I
>wish I had added a note about why.  Usually we don't add things to
>pci_ids.h unless they're used by more than one driver.  This (slightly)
>simplifies backporting things.
>
>Fine as-is, but if you respin for other reasons, you could consider moving
>it to cdnsp-pci.c.
>
>> +++ b/include/linux/pci_ids.h
>
> *      Do not add new entries to this file unless the definitions
> *      are shared between multiple drivers.
> */
>
>> +#define PCI_DEVICE_ID_CDNS_UDC_USBSSP	0x0400
>
>Looks like this #define could go in cdnsp-pci.c, since that's the only
>place it's used.

Hi Bjorn,
thank you for the feedback. I'll move the PCI_DEVICE_ID_CDNS_UDC_USBSSP
definition to cdnsp-pci.c in the next version (v4) to keep pci_ids.h clean.

Best regards,
Pawel
