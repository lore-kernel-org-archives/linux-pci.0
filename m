Received: from refb.tmes.trendmicro.com (refb.tmes.trendmicro.com [18.208.22.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CD3CBE69
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.208.22.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420991; cv=fail; b=SmAGddgUfmaK5+7KMvxU0bLAcqZnRZFZNT5lLowT2cWgPkQ3Zhd2ft+0t/AqTcuPkc3s5LDMkY3qOQfsvTb5pDeGIze0pQxQSKVziGeMK9shuwr2ewDFTFOkjjANcdAigWr/fwuo9x+dcIW1Ct24jUzki/AVDPdP6bV5kDz9F/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420991; c=relaxed/simple;
	bh=jmZgHKyqOCgIJ2FPXUpensn8Td8dy5bveJlnCiI7FWg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kGDDveagp1c2eK4EXcB4EUSrhpm3fYT5U8NyxjQBW8KI6Po+KII1EQvcrs+0V8/6JSPyZEoY8NgdLk5PPZceWLyWEVlvgGaeLPVR1az/IAly59daQfQjf1fjbVfBUDIL2KkZVTMEgobSSW4gBhjylVgVeRJnx8zvuJObcY5n1c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nus.edu.sg; spf=pass smtp.mailfrom=nus.edu.sg; dkim=pass (2048-bit key) header.d=nus.edu.sg header.i=@nus.edu.sg header.b=L0rq7zQw; arc=fail smtp.client-ip=18.208.22.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nus.edu.sg header.i=@nus.edu.sg header.b="L0rq7zQw"
Received: from 40.93.129.120_.trendmicro.com (unknown [192.168.19.154])
	by refb.tmes.trendmicro.com (Postfix) with ESMTPS id 9683910CABDAA
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 10:43:04 +0000 (UTC)
Received: from 40.93.129.120_.trendmicro.com (unknown [192.168.195.35])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id 705CF10001120;
	Tue, 07 Jul 2026 10:42:58 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1783420977.347000
X-TM-MAIL-UUID: ffa3c836-ae2c-4820-b81d-d4c672b31104
Received: from SI4PR04CU002.outbound.protection.outlook.com (unknown [40.93.129.120])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id 54CF2C00043D;
	Tue, 07 Jul 2026 10:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBb5bsShYbW/MVSx2U/bLzIXLGR2rTU4akUjjCmER/yf/BQTKrX+tY1CFWWn/WRgyjVGoxvFw4S8pm9ZkeQXdKMha6WI/ZuNvfREALa1sRkw+Ewg8nvzQJNJnM1Knr71OCPzCT3UBPQ855Wfua3+5ybWWGLv+bWN4ET0T5A0LxHu1wzAKgnODqhGXCBSwmobwci452lieNHbk7cwNzd8i+0Lp1Fo1znwq1u0A2k5LUfqrDVS+CNyCgb2k1XyFHj2RaM+c7eJ4uVuNgd+30UX+TD6tAU5gcoQA+KpONLtGLftBlbKmC37pqCr01ssx8RB9LqIUZ8cvRKihYcU97Sjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmZgHKyqOCgIJ2FPXUpensn8Td8dy5bveJlnCiI7FWg=;
 b=MtMdnqjgvcAA199WwaV4P+OYvS8isEax+tHUb87fz295RagjdQtqydQz8GCbVDCJSBwIcBuWswfM7Rlmmy7YdkAoJa1PI6f8cDZ/IwJ06DOvEkN8vnajhvFMw0V+GqzzxVp6azfTy+pL3G4U9GGJo9fOSn3UhcmGiWo2PojqKo93wI9fGrB0CUjVsKAMuoyBg3mm2cURnykA7XtbO8We2JxAhDIveLcOxHPq2K4MBBnHcVS4tzoDjFyUUPEmq/h+vZyOtgt/Q+zeJUEN49BVirZxRWul+qt0oa8Mqa8lt4unXIEzE/sBJM1J2dhhzCnr+Huc/ieVdbg5il6XINQpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nus.edu.sg; dmarc=pass action=none header.from=nus.edu.sg;
 dkim=pass header.d=nus.edu.sg; arc=none
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 (2603:1096:820:a9::10) by KUZPR06MB8250.apcprd06.prod.outlook.com
 (2603:1096:d10:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 10:42:53 +0000
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0]) by KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 10:42:53 +0000
From: Flavien Solt <flavien@nus.edu.sg>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
Subject: CXL TSP+DCD: does trusted range re-use rebind to a device extent
 across release/re-add?
Thread-Topic: CXL TSP+DCD: does trusted range re-use rebind to a device extent
 across release/re-add?
Thread-Index: AQHdDfzH9n+RL8xphEyUbgFRQ3kqFQ==
Date: Tue, 7 Jul 2026 10:42:53 +0000
Message-ID:
 <KL1PR0601MB487404AA7884AE88D81CCCC38DF02@KL1PR0601MB4874.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nus.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4874:EE_|KUZPR06MB8250:EE_
x-ms-office365-filtering-correlation-id: c692aa83-fef0-404f-e4b9-08dedc147ff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|786006|23010399003|7093399015|41320700013|366016|1800799024|5023799004|56012099006|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 5uMjZjTW74br8s8zll1ZKl9NJ9/etE7e2shANJ+dMzw5DUkJ9xfC/bBncTRNLyJgDFw6b1OnvIhhyxvy5Vn5J4k9MopYU830v+jbv3o1hzwXx3ipT3jw1XUFOB3Lhmtv11Wtj4f+Su6EApoVwJ5MLjUDShaiPOIYinqy0jhqKfzrK6Rfsb99a8dmp92roq7sMO3n8aodIJUSH3uExyyodDvPY32S77njGsgXG1meaxmi+c2cZCl9MSRxRkYTljGFkIE0QTTpWQyq1hd1gRHzDaI03dT2OCBJoQfbHAFviJY0HwYRNJ1WGrWjt9nkIBDWRpMaLmN9k1+HP+Y+VOyOmBYSLcV9Y6DVU1uD5ETfmf6lB2HQ/TD2/WB2HxYY6eUUM6QRsAe0YeueFilMygjBqj6MGwAPthu0ou5YAxksdRGQ0PsjHbZ6Vydr/2MB7AzCM+daAFg/ldMYbRtdProgmIQuXXR9pZACA1TLE3y1OnHh6VSAnn1mLIdicUg/he5SaM9McOblFUahuWxO3IdPGpyPpNxq7e/49gAncY4XYvJyLeKqRWC03d7kipM1ptD99FOE5DlNDDujJ2SLBIGZvqFsr3YOw/XvVUftCdclh7+uwJP3K0O8nhw0XWJGJOj9mi8k3KAN30aDrYRa/lczyY6GN9x0hZMxm/h2m+tbnlHio56833VeMGnqTNcdndYA1XoE/OoYMGNn7dzlugklSg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4874.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(786006)(23010399003)(7093399015)(41320700013)(366016)(1800799024)(5023799004)(56012099006)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UqCFtGoVWSnbSlukAZ0FEHRl9GhoAm8IM1+uep2OODetPUJ4KawgZ7QEvS?=
 =?iso-8859-1?Q?9WPDlunSmrDwZdaFHdhdX0HBBlwtCODyaA6zCiB6qDRBeLcm5qG3MEtE/8?=
 =?iso-8859-1?Q?R9W6Rm1xAyni/qTlN299bR4OzRt8IHAV0pG9ms+yBvz015WZpSE1ze6uwm?=
 =?iso-8859-1?Q?7gDJWGuynn7uVaw7p4ZtOTpqjowFJdpxJ+OKqt6EvKEYdm0pe4AmeZvYW6?=
 =?iso-8859-1?Q?2KkNC6pnI8hGLOAEkJWZMxJ0v8fFQqYAxwISiUkMCIDMZY9/fdwgG9mwTg?=
 =?iso-8859-1?Q?XMhDti20tPFb7DUn2CGOvc+DMBIN6SU2eXMLUtPGrzWC+edYGB5uqJoHjq?=
 =?iso-8859-1?Q?BzXdC6UTvdWdIzr5ae6qf84RI/dSMEHVh71PFMEfzn9J0YOaVHerZj6MW9?=
 =?iso-8859-1?Q?ESf1e5CHMlgWdX63PRriyK38TnFvQeBqbZ9qYeE5PV0EyQBb38Q174DuWq?=
 =?iso-8859-1?Q?Kgbmj8/7LEkeIdZ4Q8cq1xYS3grggGgTjpBoW0by2/ilYQV8n++175j6v+?=
 =?iso-8859-1?Q?VUzL7RLKrLJxC5JVcBiHQflyTxa3HV5540i/rJIcMVm46cs3sGZTsZAuEf?=
 =?iso-8859-1?Q?WyAsLNxAbEvbpCvfJF68zVhiS6QKk1CGrIz6CJC9AEEBhYZVakTO0E9e4f?=
 =?iso-8859-1?Q?a6REEAKlK8fPjoCvDtcCut1F/NuglLahx85McEW42PgJfVxUZs4ikPunMe?=
 =?iso-8859-1?Q?b5LDTh0x7197EvpBJGj6/eaZ38eWTVx+hB0CkjYI8pmoRkufZIAqjiI2d/?=
 =?iso-8859-1?Q?AfZjyVQ6MB7Ih4oJDiqUzdUM7gMiDz/HUIugT3Wh3dcyxzsAnRA9IGbTmH?=
 =?iso-8859-1?Q?djAA5SC13+lIyi3C1ZqjF1oQgzYY25CMjBQ16SOh5RNRl7bBv0LYBAxh+x?=
 =?iso-8859-1?Q?EtEz+fi3rpbxHT7U/fiKQEhxmAXgMtMrWaALxuL+M6JFhXMzDLQsRShnXK?=
 =?iso-8859-1?Q?K8cLdUAVHtSd5r1Pqvqbip1rhFNhGXprw61hOg2lvXNBiAdffKVHa8FOWb?=
 =?iso-8859-1?Q?0J3Iojil8qp1N5WxlBTgy8jnTSUb+UbDsHwySQB9E2DcvWFe/jB6zGfaV+?=
 =?iso-8859-1?Q?M0C1M0mkJBzdzI38LOa3EkDeToksHT1KfcJNBr1vkvXll5OWlarRxXTYPN?=
 =?iso-8859-1?Q?wDct9TO8CaJ1xxGFfWcwjssDAjfvEhbJJSIq8AwSog3JvadoEnrrMdN2H8?=
 =?iso-8859-1?Q?DAq2zrtUOQ/qBa9T/AUpzkIf4XV8QYvWUOA2XBHgaiK4e5MQ8w0P25YXYL?=
 =?iso-8859-1?Q?l98yQ4AQgV62dnnBWSQZFalxPC1w8ZcF6ILYHZqw2LkEQ6x57cUuPXAimY?=
 =?iso-8859-1?Q?a2K6eI1eF0dBNHMqWUPwfu+gjN+/2Zk7wHk5qUItYKXusMj7PK0K4PgQB4?=
 =?iso-8859-1?Q?QH8qHoKLrAKCQIYM7BjczPvN8F5t/uLSBV+yLqVM5pa0nBZ3FZSXoXBsPF?=
 =?iso-8859-1?Q?6sStE9QnSsiBZj176LGkqaY+gYWX6/sA2VJUW/qtfyZ6Ue1aaA3tC6lNh4?=
 =?iso-8859-1?Q?4UPVssry1WQIzzW95Wo/22uuKn5659oY0k3HuZkYyhP/OyM2KY762VfASd?=
 =?iso-8859-1?Q?CJahDIaXF9a62rKSsYep/s/nEmWrx+XGeHNMkPRjaYSh0wPSNS8aBjGneU?=
 =?iso-8859-1?Q?spAquF1iBY3c0eJTOZoaU21cXSeXFdOAbudfIkHnMPFYaDCmnE1cthZW+h?=
 =?iso-8859-1?Q?k5A+z7pMKZpgxqsKHPdqKFyxik7j7CiR164OkcaB4pQuwss9hOqoUBL9EB?=
 =?iso-8859-1?Q?VKtEiulbAh/bvRx3kp/r8WRI6vCR7JgIagVjGmzuRRHVO1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZxC0bpxJsCgwUQ9b32d80n9lwOt6KMIFekyEQAw7kN0shPTEOwqBCvQx/vB1FWFXyWYYoLLpsvQrI1IyYC8aBVhJhZOo6KI1REVC5bufvNbRm1G+EATfoSPwV+jvkNZlCnnqo7j5Zju2UcKZWcyQoaR25AgfMb6vipd8sWF+DbfNtCz17k63YfCd14/m7XodOmeO2SIybbMQo/ZSUAe+Oqk0e0b5pznLSkAnYyC7DkpYl9KnIimOoACMbB3/uL+5QECH0c17Q1+c0tAmKKP31XPD0KBL1JHp/EqynBVGfZsCEAtRQgMUS2yokxQExixSNNZnpt+7UmvbQP+YG4fk+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H/uCK25KXJIakj5neC1ngczwOGSjDx7IOnGJHYdq4zqWphZhAOOVBV0anCs0M14w78GFVvu2OGXC/QbMZ/2kCLt02eBEusNd5M8WMuqQHUQl0aEDDxPO1JusOrsxNbudivt66huPREnctwJGuopGjN/QaJGpFKhy8ynRf7SURqKxSADABOyQ6y0Aa3KdEUJ12ATVmS88OjfeG9m54Njfqy55zVRyweGZRLPM4MAJt19QzNyTu3KiRfng1B9veRQCpNLXLhTvLLzGbEF8OyxKFOpw8nkWBBGPsRTBXFUQiuiQEbw/eCM1cMkFapAiZlFmc0kYQerAyQ1bjKIlE4w9O5bcSlds5UNrIypfa/DrNDa3gt2E5ZLQuA9/a+vduv7xETJfWCtVyFO9PsbCW7hPS03IiSTbFJ2yhlmMzgE5RB3vB+Vi9y1ZIkdtuV0bsgibTMXvViBfMvEwdG6NBUFfaooE8yi0znHh8rm8OfvjcqcjtN59kMlYwHfVCCdcypGX3B/+kWJvEhRFpBPBp/phTt/isOosetbKCavpN7MPamSxgOF1fCwASVELR/qkxjfAf6e/w+BbxaV2ecmA8xNNWJl1NprcCoBdg0rlIkK7kqeUtl0k+OK5gIREXk1geaCjA2FMd7dyxqf/vZ4ejLXCEw==
X-OriginatorOrg: nus.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4874.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c692aa83-fef0-404f-e4b9-08dedc147ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 10:42:53.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRzDhP9mDavVmWmonKsnbYG92p7oVfQBiFR1SRvH0A0XlDmEBCwspWHES1gRMxdRd0vPDkPCdUA5kBLS5E5GhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8250
X-TM-AS-ERS: 40.93.129.120-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30052.006
X-TMASE-Result: 10--81.748400-10.000000
X-TMASE-MatchedRID: NSd3QfEGrTiBbasXMi9E94n73EnA6dC3rLOkuQxDQBZD46E3q/SPM5Oc
	szpOw40QBbk1xVSi5Pn9bBzY6qiugPPUgQI/1D7xiu6u4shZ+fGN6kzcoCcAvmsnZphRmxS3z38
	nwWqu4frwSddLjGYQQZHb0Kr3TSeK5mb3a2q7PeFzoxCmHXb7+ufShpTpYz77IFY7RMz3nVsJZ8
	bKkznFdrLQdaJm0KODh5y24Qu+R5Qnrqyl2eNlUOEiVS/f0x5EEdHOXagG0U/8kcj4obJOBgB9L
	axL4RMsNO3lmu/8dbM5XtDPLCLGNjSAJS4xTOq0H7WbjGX5tkn4cCTiPcX39JOCyMF3fA3/6LQg
	o7rb0xRpQ+UGwjI9ClC/OUUBB87ulWpefyTqwh5OdzD1yHlzdNAE3sJ15JZfuyfOXvV6ruX408l
	VR+/ljHQTNJrlmZo3XS+aEkPp2FDwaMIXsaQmMEI9AEPfED/do4NJa7SjFsrxf20B5UzKOYmRx7
	OV7pazLQGfvzJ0+VViyuQOZndK/bpcTKsMs1ZRW62kZbnrZYTpAuB7xNymfQ==
X-TMASE-XGENCLOUD: dac98002-acdd-40bb-bad1-76fad818c33d-0-0-200-0
X-TM-Deliver-Signature: 4680607EA03EF0731BEFD4A2E932891D
X-TM-Addin-Auth: 6vH60DMyt+hp+P1qqA64S2sEwU464tzaOwSP97Tctux2sLT3/ILvV88XlzA
	hYC86KntuGqd77IbIJcTHPEmrGXb6AEC8XYribN74K8kw4/qakLl4US1rdcbNP7ey3bcTpH1p9o
	UA+BRPT3/JBvRCRZ0JMDMxWwWnEe84lMgU1C9K5XQz9F8iVYmrLztYfJFY9gyYO6qxa2QGpm23E
	C4JTn3ZdPNyiZuyXmv3WV6MCTK7BMlxMvoFTsrJex1OybFqP6E1XsL00sUFfsqfFQwDZqy40xs/
	t0+Y1/tDgqJgrJ+424XydS2IttKwkNtV0WcMXwD9lb3ValZ8HuFDPy+9nCDKxHkhGoTp67MPegM
	2ZGQ=.l/mSv/tTkVJdkkeRCe/XHrRYM4fbkuh84VwQ9L/kicXOCiAA3lmvK0MHjyvk43ZPzlamX
	LXAcUMTLMcBKcTO7lJbmQJhTB+MlEa9idsqLNJYP3xAqTVDIM2noX4N8yavErIV9Nw94pluoep9
	1lkuCWwyith1QIIydLMiIaIcgD5UvRcXoIhAZJekqQlkyzAMa0OD2IecLIruyzqpHS45qanH/5a
	PSQxwZFvXujzyKR+hAJ+q0w4lkZyDeoZmFQQRZtY/7yo7diM099HA0gEsc+gwet16DQBDgLGsco
	Csn32QAv6eDN48l+00KtPnsNniqYL4WTTLL16/zClDRA6cIA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nus.edu.sg;
	s=TM-DKIM-20240902111054; t=1783420978;
	bh=jmZgHKyqOCgIJ2FPXUpensn8Td8dy5bveJlnCiI7FWg=; l=2868;
	h=From:To:Date;
	b=L0rq7zQwLIttmgTKVnG2e9TALdW5nWd1881FcrKSbwigLxLHB9AOQ1ZazF+/aJm56
	 8Oy5JwFVE25UvZHlvXs2ri2ip11pn8KlEXJdSMut+vTaplfVyQWliX1lJ28foJWcf9
	 MnVwaR88ukHyQrKVmgwTIEYprpkx6Drtr/Z/TNgm76TrE3txFJFvmajNEwWVliAZ3F
	 r2nKK9gHWNvdIOasvO659UQaLEkJSgc5BDYSfFG7vHD26yk788cTj/TiLYFQPrL6fJ
	 I1IL0Sy1nYMT7b2Bk3aWG61bWUJqKibCbkga41VjWjhW9+45+PIrurzu5z+d077dPv
	 Uc/BFjlJy1zoA==

Hi all,

I raised the host side of this on linux-cxl recently while this is the conf=
idential-computing half of it. In the CoCo model, the Fabric Manager and th=
e fabric sit outside the TVM's TCB, hence a release/re-add that swaps the b=
acking behind a host range either has to be prevented, or the guest's trust=
 in that range shouldn't survive it. What I can't tell from the specs or th=
e current kernel is which of those the architecture intends.

Under Dynamic Capacity, an FM can release an extent and add a different one=
 at the same host physical address. r3.2 =A711.5.4.10 already has the targe=
t clear memory and reset TE State on add, so residue and cross-host disclos=
ure are covered. My question is specifically about identity. After a releas=
e and re-add, the range the TVM accepted looks the same and the TDI stays i=
n RUN (a DCD reassignment isn't a TDISP configuration-space change). But th=
e device-internal extent, the fabric tag and also the grant lifetime behind=
 that range have all changed. A correct TE-State reset tells you the memory=
 is fresh and private. It doesn't tell you the range is still backed by the=
 same extent and grant the guest started with.

So I'm wondering where is that change of backing supposed to get caught? Th=
e trusted device interface the kernel binds doesn't seem to carry any DPA-e=
xtent or grant identity, which leaves nothing on the host side to compare a=
 re-add against. Is that deliberate, with the binding meant to live in the =
target's TE-State reset plus the SPDM device evidence? Or is the missing pi=
ece a host/TSM-held binding of a range to a specific extent and grant epoch=
? Put another way, should a DCD release/re-add of a trusted range trigger a=
ny TSP/TDISP re-validation, or is the TVM supposed to keep trusting the ran=
ge across it? It feels like the in-place version of the cross-device migrat=
ion trust question that came up at Plumbers last year.

One related corner: forced release (Table 7-71) reclaims without host coope=
ration. Does the TE-State reset have to be atomic with a forced release and=
 observable across it, or can a re-add race it?

I've got a small QEMU repro, for what it's worth, with an attested device's=
 DCD-backed range gets force-released and re-added with physically differen=
t backing and the guest then reads different bytes at the same address with=
 nothing re-validated. That also touches the forced-release race above. Add=
ress equality clearly isn't extent or grant identity.

Thanks,
Flavien

________________________________

Important: This email is confidential and may be privileged. If you are not=
 the intended recipient, please delete it and notify us immediately; you sh=
ould not copy or use it for any purpose, nor disclose its contents to any o=
ther person. Thank you.
