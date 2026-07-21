Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013084.outbound.protection.outlook.com [52.103.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFCE31F998
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638210; cv=fail; b=GukqxG5mhmLDo7w4wBr17QclS3MQnnS9suwIz7TBHM5JcM1gbH1k6Kr0W+6EGj86S6qhsfI+G2cJoF3cK0GnNL6LBkhdYKvV0Hbw9e3y2WnepPaYklY/jaMxqIDoVtPeSQrAkgXE4do55MGUIusqr4PYCU77U7ZJX7MpCrROTcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638210; c=relaxed/simple;
	bh=K7BhfIFX/WvvhOfzPts6HB9DA4wUBDx9jy728/bt8CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lji2EBbR76ZDjN78/kUgRDSqVkw3m61kv5ffDANJwtgqUmthGDL7VtjpqCzzL1ZWSpiRHmNhfy+AYOnnWJmnm1DB9EVXDKz/mcgssfxVUdTRDH3EQyv2FreQKQmx366lZGe/r9StkF0uAukXJWqv6vdrtcaZ3htNMv8WtIczTJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BnuqV1Qn; arc=fail smtp.client-ip=52.103.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BnuqV1Qn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0Y2qo4Dv8omu3/GesRDHK+470LVBZFq664y9Wm/TVgXaTGmeijvrUFdQKqK8GyyiTN6qHKGF9OfdGjeOqa3juymR+S1L4h0c4eKSDZpNURoZJDt8HvPdogr0ZdohbK875g/scYRwsdN1lFp8KJD013YsHCqaGH0BltI4EIq6DYIyBj9TmzakhY9d+8zpmeR8fGNdPAkq+eF2L+PTumHlLxdnhps5MNNyD/hzjCVPPD+psytAyfJm4AICMUxN87JYB+P3x+FtuZICClz8Bvk9sMytRAoytlIkCFNGCoesFQbEgnS2rcYGzdSWR2ELgQQ8/7Zz1eyip9HQ4AtG3Gy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7BhfIFX/WvvhOfzPts6HB9DA4wUBDx9jy728/bt8CU=;
 b=NXBIQP21nPoIZYRGxzvxsPb/mjVYXEp+Otm/woNYpu+mSPIrG+mqi0wSE4jApwdgYtYLiB2/v5t66uX1yyfBQcwIXRlylYL4PXVeBlxxOX6lX64zfRgrgZ2iU/nIguJbaPUAygjp2mPDe061rPM5ulbX8QdKyPTnhmcbZufZJ7Yf4yJ9BxADQZk57mWy7PSEObYSRDFcsH1oJifCpzxREoNBny24fNFRwb4/WL1KHqTaLDKFPxd7DC90LgF76E1lpz7q6PG0VV8z+F+yo8GZknrGGGz0zHCd2lAJ6oj5VssNZ8KneBET+LlrZlAvf7p4SJh20LLv3vEf/5VwBzPaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7BhfIFX/WvvhOfzPts6HB9DA4wUBDx9jy728/bt8CU=;
 b=BnuqV1QnuafxRP6l3ZM7fTtXTU0aGkpapMvfRMOSv0R0kwnHP1cLYKh/lSbsiOjE/b/Cyqwl9bKrME0YPwujc7E60sRk+7zU5q4lgZQZYg2moV1ZrSH6e8YUbbCdk4m/+/qkTOvqoB+rDYWdN//CQ8bOZGe9GATNYaIt12DW3OYrCyn9jvWN4Bm1ucHNUMzesZMDMrp2zT3MJ7eHSex7hgTw3i5UrdQeLvTXtYvcOsdj+c9TDVUmcecuCt8RYAM85J9r0ZMXBRPh8MOuYJ+4ZK/ntRQcOIAdACKl0ylx67bUecGo3ZxiWgLVx1RliZHVS9Vo1rgHrbWOdk9jLo08pA==
Received: from SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:485::15)
 by DS4PPFF31B32C29.NAMP221.PROD.OUTLOOK.COM (2603:10b6:f:fc00::ddd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:50:07 +0000
Received: from SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
 ([fe80::6a2e:72ac:9841:e186]) by SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
 ([fe80::6a2e:72ac:9841:e186%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 12:50:07 +0000
From: Lin Mohan <linmhwork@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Ali Alaei <ali.alaei.tabatabaei@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Thread-Topic: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Thread-Index: AQHdGJnKcWiEsmMH2UW8ztntKdAIeLZ37aiA
Date: Tue, 21 Jul 2026 12:50:06 +0000
Message-ID: <E07E8ABD-2443-4F86-9B7A-10B0234B762B@outlook.com>
References: <20260720224745.GA435004@bhelgaas>
In-Reply-To: <20260720224745.GA435004@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P221MB0955:EE_|DS4PPFF31B32C29:EE_
x-ms-office365-filtering-correlation-id: b660386c-b4ea-4980-9bd9-08dee726978a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|15080799012|51005399006|12121999013|25010399006|8062599012|41001999006|19101099003|31061999003|19110799012|3412199025|4302099013|440099028|102099032|40105399003|10035399007|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?em1MNCtFYWFrR2hFTkxHNW5MZkpMSmJUZHgzL2QwNUV6WVBGczBNWGd5S1JR?=
 =?utf-8?B?SFBGeXE2dFBpNHdrT000VG1qc1VZMmN5b1UyTVhSOEI3SXUrN1R0eTB0b2Q1?=
 =?utf-8?B?UGtmQUlaRTVqOUNDUjc0VDNsM3pUVWVmWTRuWFJkTzV0MVh0TWFBWU5IZkxG?=
 =?utf-8?B?eUU1SUxVa253M00wK0NyMnVTR2hXbXFRVjNQNFhnNGliZDREM3J1bVgyV2hV?=
 =?utf-8?B?azFUaDBvY0JBSi9YaVBoSFZXWWJwdXBBRkFmWkJlRUloL0tmQ3huL3lpZTRV?=
 =?utf-8?B?M2xlVVZrTUorU052T1EzTTNCYk5adG81T2tQK21Bc3RSRTE5SVdKWS9IMWQ1?=
 =?utf-8?B?SGFQWXhXR2NjMEdSeHErNTRXaHpycE9CcGoraFZtc3lKVGQxNjBob3NzKzZr?=
 =?utf-8?B?UzlTKyt0LzZNY2I3ajZVZWVNVktlMmRka0hRSTl5SkR5MlRVUTVYL2hIVXU0?=
 =?utf-8?B?UkZpOXZ2WnhZTlJPWHJhUHhlZkhUcFQyUmN6cEhvMER3NjBIWTEyMDhVdUpL?=
 =?utf-8?B?SmZ6QWJOYjA1bDcwaWpjTUhWckRMVHgrR2I4Ykl1VTBxRGhoU3JtMW1LN1lX?=
 =?utf-8?B?c0NIUlFtdkRhbTlCMHlVRVNrUDVwRTJVaVpLQmtLQnZLc24vaktDR1lkWTNZ?=
 =?utf-8?B?STh2Zkh2T1FuY2tzNncvNmdWV1o3M2VXQTFiR0s5TXQ1OUk4MHdRNXQyNXZD?=
 =?utf-8?B?WTN3MElOUWpZOG9USy9UcHBzbTUzbnlweVNmaFh3d1BYWTVCQUY1V28xVE5k?=
 =?utf-8?B?UmdvMC9SQU1tTitoQTJSTzhacGs1eEtqeG5XdzJSNVhxcllkamZzRmtHeDN2?=
 =?utf-8?B?dGwzbmFqVTEya2dxUTVlQy9kVUI5Tks4UkhqMkxSMDc1ZlVGODZreVZFd2Ev?=
 =?utf-8?B?WWVRUVZkTjRTOWd2cS9pcWJjUHFIMGtwdWc3MlkrVStEMlcybjhESXNuWW5P?=
 =?utf-8?B?QjFGSUx3Umw4V01GeWRFaGFraU1qZ1RTRm9OTVdReWZWTjJmY3plc0pEdkda?=
 =?utf-8?B?L0tIWXAxTEx2U0dvc21GTWY5VnJWUWJHa2p2TTRtTTY5dDJEZXQvTXdvUnN6?=
 =?utf-8?B?N3RsOUZOZFkzZ0RYNm9TYnQvT2ZzM1BZdU9MTXlYU2thblFlY2hBNGZucW5i?=
 =?utf-8?B?aFNUcmtwSkZ1UFMyWWtKUEFaTWlQZHhlREt3dk1LSEExNUVZLytzTzg2b0o1?=
 =?utf-8?B?dTYwdU5qZEJaOWJ3UjhlM1ZndmNsRmJORERjalFsTWxYdVUzeEptSkcxS2hk?=
 =?utf-8?B?UHpxVlZiT1FSVFI4QnZoVUUydW1wK3g2emVHZG5zUEVFOXB5ZGhKM2RkZjRw?=
 =?utf-8?B?MTdVRDJucTBzRDNTUHNxdHg1b09vemwzQ2cxVkFwUTVCbXR3ODZDSm5DN2hy?=
 =?utf-8?B?SUIwdnVuZkN3ZnBmSk40OFlIZ256YVdEYmhHQjZ0WmR2dk1ON3pWM1Fhcis5?=
 =?utf-8?B?aW9ja01uQjIzQ0pGajZrSVBVYTljYkxxeTdHbWJPVVhaZXBXTFd3LzdHbnBi?=
 =?utf-8?Q?qznm9c=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmZweEFqZ1oxcjRHclE3TGNrMjl2amhxTC9idWxuMHdXMW9mUkJ5L3Iwaktz?=
 =?utf-8?B?blU1ZytsWTFDUk5vVTNueVdjc0pnVXFwM3FJYTNjcnUzZ2hCdmJ5eTR0Q3Y5?=
 =?utf-8?B?dktualNCN0RZUzJuamZ6bFFiMjFRVUZZUnNoTXBEYlZlbDkzZDVGNlNJSjZl?=
 =?utf-8?B?L1VkYUYxUUlaQ2xDaW1QNnowdHh5QUcrNjliUG4rZUZTUi9sSzlpVmRLSUQ4?=
 =?utf-8?B?LzloaGVpR0ZyMUlDbUNzR0JSQnZYdEV2YTQzSGFpeVZ5cnAvSC9xc0t6NHpW?=
 =?utf-8?B?MjFYVjB1TDJaV3VxdktiMXhUaW1BS3FNNmpwTGZHNTFXK0tLQSt5MGVjeHZ5?=
 =?utf-8?B?RHVhTnlmWEZhSGVvT0dKN0R4Y2luT3JCVjltNW1HSG9lRU9zMmgwUjR0VHpM?=
 =?utf-8?B?Qms2aVlPckVLQkR4dXU5TEpjNXhSRVFQd29KY1hBeVpMRDlQRWF5VTczZDJI?=
 =?utf-8?B?VWcvSjZ1dUtaZERIK25LVmFwdXFTOVZDMlFvMjFMV0VMZElBOUxZMXVSUGp6?=
 =?utf-8?B?alExMkVkMEVwSkROcUVLanZ2R05veDVZUjFaQnVDUXpxdEh0Y2pYelJSQUow?=
 =?utf-8?B?am1QM2YyVWdYNTltbExHQXZRbzFyWXM2cWJQeFFIMUlYSnRzcThyZ2tYOFVG?=
 =?utf-8?B?Q2JQcy9pSkt1bitWVEwyWnE2MXNVdGxGc1BaTUdGOWZHOVFJTGNDQXErVjk2?=
 =?utf-8?B?ZDhpN3VLVHoxanpLRU9VM21jM21tWGNiZFgwcHVTSjk1TUxWbnRYY3JQUkVx?=
 =?utf-8?B?bnd6VTNXNEZ4ZS9hd0xhc2s2bHJ4RWdQSTEyRG5odmk1aDhIeXRKbERpZ0lV?=
 =?utf-8?B?dld4QkJERTd6SDR2bTBDMDAyclJ5TnFMYUZJaHFTQkZBSncraExNeWJpZTM1?=
 =?utf-8?B?VERBYTJRK3kxdWszT2t3VHNBbzRNTVRucyt6Zzl3Wko4ampyUnhTbTJjVWdJ?=
 =?utf-8?B?dGVhUll1cm1YOWF4ZDFJMnErN3Yzb3RwTmdudDdxaHdxUGU2ZHl1d0xzUnFy?=
 =?utf-8?B?RGZkdmk3Y3loTjg4OWxPR0JHOUxHWDlHTFdBclNWSDUrc0V0eG5VSXdtOHMy?=
 =?utf-8?B?alRKV25PZHdLekc0OVBhTERRNGZOL1VocGRRKzRzOWFOTUU5MmI0THVJaXdR?=
 =?utf-8?B?ZENqTTUvZnQrUjdRQ3I1YlJ2MVZ5SVgzVEQ2UFBWY3M2WU1tRzNYVG9Ubkdu?=
 =?utf-8?B?TmF1emd4b1IzU3l5RFNaSHpHRE9yZ0tlb1FQS0E5TUZWTUVGQnNsR2Z5bkwy?=
 =?utf-8?B?WWgyQzkxbDNZS3VXbFlIbVlCU3RKcis5WEpiaWlMZlpKMWJpOElsRndJT0RR?=
 =?utf-8?B?cTlZRXpCZFV6Y2RlbHBVQ2dpb0wxU0hHc1J1T2hXYXlFR3lBcFhlNldCYVN1?=
 =?utf-8?B?aHlzMDAzby9YdDN0QXB2NTdNeTFQdmU0RUdxR0RnbEwwMHFsbExXZVNYSEdG?=
 =?utf-8?B?cVEraTNLNHhFR2FleXBxZmxreDMwRG1aUzZ1d2NqenFZakkyZGlDWlJwWjhn?=
 =?utf-8?B?eGlxR2ZRUmEzQ09JcitBZEVrMzBmWmdvV3F1OUdRdlpiTm12ay81T1FqclV2?=
 =?utf-8?B?WEViSDJORGcwcVMxc0xVMjJBTm1HSEh4c1ZTMEZBTmc1UGJTeGp3WHcvNGor?=
 =?utf-8?B?azRFNzJZL3QxcGN3dVZvQS9BdHJ4NDlYS1lGYUx4WDFUTXB0ZUpaNkhOR3hF?=
 =?utf-8?B?RzdnMkk3U05CQiszVG1HTUdyR2hwbFdIMEQxMW9Md1BLR0cyQ2MxVTZXQ0pt?=
 =?utf-8?B?ZEZ5TTJhUmlrcUczbDBHTDVjdVRjMWEwMmNQNk0razJQa2tRVjJKWDR5S2Zw?=
 =?utf-8?B?Rmh4NE1TKzFhT0FmeGhNNzE1V2Q5NlVtdVVGOVpQZ0Y3d0REd0t5NGJtSHNS?=
 =?utf-8?Q?qIErT3FN/Z322?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <356E0A314A5E8E4AAE00A31AA2633E7B@NAMP221.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b660386c-b4ea-4980-9bd9-08dee726978a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:50:07.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF31B32C29

DQo+IE9uIEp1bCAyMSwgMjAyNiwgYXQgMDY6NDcsIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTdW4sIEp1biAyOCwgMjAyNiBhdCAwNDozNDo1MFBN
ICswMjAwLCBBbGkgQWxhZWkgd3JvdGU6DQo+PiBPbiBJbnRlbCBBcnJvdyBMYWtlLUhYIHN5c3Rl
bXMgKGUuZy4gQ29yZSBVbHRyYSA5IDI3NUhYIG9uIEFjZXIgUHJlZGF0b3INCj4+IFBIMTYtNzMp
LCB0aGUgVk1EIGNvbnRyb2xsZXIgcmVwb3J0cyBCVVNfUkVTVFJJQ1RfQ0ZHID0gMyBpbiB0aGUg
Vk1DT05GSUcNCj4+IHJlZ2lzdGVyLiBUaGUgZXhpc3Rpbmcgc3dpdGNoIHN0YXRlbWVudCBvbmx5
IGhhbmRsZWQgdmFsdWVzIDAsIDEsIGFuZCAyLA0KPj4gY2F1c2luZyB2bWRfZ2V0X2J1c19udW1i
ZXJfc3RhcnQoKSB0byByZXR1cm4gLUVOT0RFViBhbmQgYWJvcnRpbmcgdGhlDQo+PiBlbnRpcmUg
Vk1EIHByb2JlLiBUaGlzIGxlYXZlcyBOVk1lIGRyaXZlcyBiZWhpbmQgdGhlIFZNRCBjb250cm9s
bGVyDQo+PiBpbnZpc2libGUgdG8gdGhlIGtlcm5lbC4NCj4+IA0KPj4gSGFyZHdhcmUgcmVnaXN0
ZXJzIChWTUNBUC9WTUNPTkZJRyBhdCBvZmZzZXRzIDB4NDAvMHg0NCk6DQo+PiAgVk1EIDAwMDA6
MDA6MGUuMCAoODA4NjphZDBiKTogVk1DQVA9MHgwMDBmLCBWTUNPTkZJRz0weDAzYjgNCj4+ICBC
VVNfUkVTVFJJQ1RfQ0ZHKDB4MDNiOCkgPSAoMHgwM2I4ID4+IDgpICYgMHgzID0gMw0KPj4gDQo+
PiBBZGQgY2ZnPTMgYXMgYSBmYWxsdGhyb3VnaCB0byBjZmc9Miwgc2V0dGluZyBidXNuX3N0YXJ0
PTIyNCwgd2hpY2ggaXMNCj4+IHRoZSBjb3JyZWN0IGJ1cyBudW1iZXIgYmFzZSBmb3IgdGhpcyBo
YXJkd2FyZS4NCj4+IA0KPj4gQWxzbyBhZGQgYSBQQ0lfUE9TU0lCTEVfRVJST1IoKSBndWFyZCBh
ZnRlciByZWFkaW5nIFZNQ09ORklHOiBhIGZhaWxlZA0KPj4gY29uZmlnIHNwYWNlIHJlYWQgcmV0
dXJucyAweEZGRkYsIGFuZCBCVVNfUkVTVFJJQ1RfQ0ZHKDB4RkZGRikgPSAzLA0KPj4gc28gd2l0
aG91dCB0aGlzIGd1YXJkIGEgcmVtb3ZlZCBvciBlcnJvcmVkIGRldmljZSB3b3VsZCBmYWxzZWx5
IG1hdGNoDQo+PiB0aGUgbmV3IGNhc2UgMyBpbnN0ZWFkIG9mIGJlaW5nIGNhdWdodCBhcyBhbiBl
cnJvci4NCj4gDQo+IEkgc3VwcG9zZSB0aGlzIHNob3VsZCBmaXgNCj4gaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjExMzYsIHdoaWNoIGlzIGEgcHJvYmxlbQ0K
PiBvbiBhbiBBcnJvdy1MYWtlLVMgc3lzdGVtPyAgSSBiY2MnZCB0aGUgcmVwb3J0ZXIsIGFuZCB3
ZSBjb3VsZCBhZGQgYQ0KPiBSZXBvcnRlZC1ieTogYW5kL29yIENsb3NlczogdGFnIGlmIGFwcHJv
cHJpYXRlLg0KPiANCj4gVGhhdCByZXBvcnQgbWVudGlvbnMgYSA4MDg2OjA5YWIgVk1EIGRldmlj
ZSwgYW5kIGl0IGxvb2tzIGxpa2UgdGhpcw0KPiBwYXRjaCBhZGRyZXNzZXMgYSA4MDg2OmFkMGIg
ZGV2aWNlLiAgSSBzdXBwb3NlIHRoZXJlIGFyZSBsb3RzIG9mIFZNRA0KPiBkZXZpY2VzIElEcyB0
aGF0IGFwcGVhciBpbiBsb3RzIG9mIHN5c3RlbXMgYW5kIGltcGxlbWVudCB0aGlzIGZlYXR1cmUs
DQo+IHdoaWNoIHRoZSBidWd6aWxsYSBzdWdnZXN0cyBpcyBjYWxsZWQgIkR5bmFtaWMgQnVzIE9m
ZnNldCIuDQo+IA0KPiBHaXZlbiB0aGF0IHRoaXMgaXMgYXBwYXJlbnRseSBhIG5ldyBWTUQgbW9k
ZSwgQUZBSUsgdGhlcmUgaXMgbm8gcHVibGljDQo+IGhhcmR3YXJlIHNwZWMgZm9yIHRoaXMsIGFu
ZCB0aGUgcGF0Y2ggZG9lc24ndCBhZGQgYW55IG5ldyBjb2RlIChhbmQgSQ0KPiB3b3VsZCBleHBl
Y3QgYSBuZXcgZmVhdHVyZSB0byByZXF1aXJlIHNvbWUgbmV3IGNvZGUpLCBpdCB3b3VsZCByZWFs
bHkNCj4gYmUgbmljZSB0byBoYXZlIHRoZSBJbnRlbCBWTUQgbWFpbnRhaW5lcnMgY2hpbWUgaW4g
aGVyZS4NCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGkgQWxhZWkgPGFsaS5hbGFlaS50YWJhdGFi
YWVpQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+IC0gTW92ZSBjaGFu
Z2Vsb2cgdG8gYWZ0ZXIgJy0tLScgKHdhcyBpbmNvcnJlY3RseSBpbiBjb21taXQgbWVzc2FnZSBi
b2R5KQ0KPj4gLSBBZGQgbWlzc2luZyBWTUQgbWFpbnRhaW5lcnMgdG8gQ0MgKE5pcm1hbCBQYXRl
bCwgSm9uYXRoYW4gRGVycmljaykNCj4+IA0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IC0gQWRkIFBD
SV9QT1NTSUJMRV9FUlJPUigpIGd1YXJkIGFmdGVyIFZNQ09ORklHIHJlYWQgdG8gcHJldmVudCBh
DQo+PiAgIGZhaWxlZCBjb25maWcgcmVhZCAoMHhGRkZGKSBmcm9tIGZhbHNlbHkgbWF0Y2hpbmcg
Y2FzZSAzDQo+PiANCj4+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA0ICsrKysNCj4+
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5j
DQo+PiBpbmRleCB4eHh4eHh4Li55eXl5eXl5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci92bWQuYw0KPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0K
Pj4gQEAgLTY0MCw2ICs2NDAsOCBAQCBzdGF0aWMgaW50IHZtZF9nZXRfYnVzX251bWJlcl9zdGFy
dChzdHJ1Y3Qgdm1kX2RldiAqdm1kKQ0KPj4gcGNpX3JlYWRfY29uZmlnX3dvcmQoZGV2LCBQQ0lf
UkVHX1ZNQ0FQLCAmcmVnKTsNCj4+IGlmIChCVVNfUkVTVFJJQ1RfQ0FQKHJlZykpIHsNCj4+IHBj
aV9yZWFkX2NvbmZpZ193b3JkKGRldiwgUENJX1JFR19WTUNPTkZJRywgJnJlZyk7DQo+PiArIGlm
IChQQ0lfUE9TU0lCTEVfRVJST1IocmVnKSkNCj4+ICsgcmV0dXJuIC1FTk9ERVY7DQo+PiANCj4+
IHN3aXRjaCAoQlVTX1JFU1RSSUNUX0NGRyhyZWcpKSB7DQo+PiBjYXNlIDA6DQo+PiBAQCAtNjUx
LDYgKzY1Myw3IEBAIHN0YXRpYyBpbnQgdm1kX2dldF9idXNfbnVtYmVyX3N0YXJ0KHN0cnVjdCB2
bWRfZGV2ICp2bWQpDQo+PiBjYXNlIDE6DQo+PiB2bWQtPmJ1c25fc3RhcnQgPSAxMjg7DQo+PiBi
cmVhazsNCj4+ICsgY2FzZSAzOg0KPj4gY2FzZSAyOg0KPj4gdm1kLT5idXNuX3N0YXJ0ID0gMjI0
Ow0KPj4gYnJlYWs7DQo+PiDigJQNCj4+IDIuNDkuMA0KDQoNCkhpIEJqb3JuLA0KDQpJIGFtIExp
biBNb2hhbiwgdGhlIHJlcG9ydGVyIG9mDQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTIyMTEzNy4NCg0KU2luY2UgY29tbWl0IDIyYjQ3YmQ0OWU0NSAoIlBDSTog
dm1kOiBIYW5kbGUgQlVTX1JFU1RSSUNUX0NGRyB2YWx1ZSAzDQpmb3IgQXJyb3cgTGFrZS1IWCIp
IGhhcyBhbHJlYWR5IGJlZW4gbWVyZ2VkLCBjb3VsZCB5b3UgcGxlYXNlIGFkZCB0aGUNCmZvbGxv
d2luZyB0YWdzIGluIGEgZm9sbG93LXVwIGZpeD8NCg0KUmVwb3J0ZWQtYnk6IExpbiBNb2hhbiA8
bGlubWh3b3JrQG91dGxvb2suY29tPg0KQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTIyMTEzNw0KQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5l
bC5vcmcvc2hvd19idWcuY2dpP2lkPTIyMTEzNg0KDQpUaGlzIHBhdGNoIGZpeGVzIHRoZSBzYW1l
IE1vZGUgMyAvIER5bmFtaWMgQnVzIE9mZnNldCBpc3N1ZSBJDQpyZXBvcnRlZCBvbiB0aGUgODA4
NjowOWFiIFZNRCBkZXZpY2UgKEFycm93IExha2UtUykuDQoNClRoYW5rcywNCkxpbiBNb2hhbg==
