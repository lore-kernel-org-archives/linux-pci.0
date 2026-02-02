Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DB361674;
	Mon,  2 Feb 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034852; cv=fail; b=AtbVcYyq0opWcRr4sqmnzmOcbo/KU8uGcVxe5wZFqF1qnVc6zl5+0ujvfNwjYX4ka+qSnstTNn9onxug48uxxQVsf5U2gw+S9nc0KO3vxOXt4vLDxBnDObWi9RZlwiD0NkWNfPSTPDZtTlgH31JkPONZBw8gmV/Y8HMCLvF1+I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034852; c=relaxed/simple;
	bh=Bj9kA8qLlR5PexjbaPQCVo/XcZ4N2DGiQwoy2N84GVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMgNsoo6zcThMUIWDxLhEFIPNMrYFyFVu2Hgf3ZtexrggC5gtFJbP0T0t81snhdSRE9imnMlxj4o2fPwuDGa7tiSwkQaYZ9LDRq+iZ1aKPRHkhsRMAiWjAUcwrS/CmPz+fTIuJmETk1csd1hTBExEhKXZO4Lf6a0g1EFrdm+9iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AZ+LGYr4; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AZ+LGYr4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCaBo+KpvYmx9s0kKOTyoWNYNiOY/i2Ogbz5P4S5UWn4LnKI8ybISIfZziqnS7bojzQDbeyW9QdYHVYzmeswEH0ev/xGXvT36SzBOin8/RcinWIuytcdsirFcmpJWXR5HDSgl9IeQ+tGPAg2lTxvgXYxBRx25HHLcWbKKFYotoJyTIyAz/QsjegML1cesYl9bu+eIxiOJnrD3JF+PvZMm2A9AuyHo86Op7YxjkMDISPx5+MB8gzPpBZOaRlZRBu2vQCJ/g9/kBD4mLrj8ISwz1OmK8fiDOukBLIhZ3vW1v/URKd1fUahJyOSLz8Z9y8lzArFL8zfGXFuHnPKxpEm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDzsZ6leQitIUUQD/vJY6XHuUZ5m3qeNGEMU9oMjGzs=;
 b=lsA9CeDXRg8vW9q9VYM0zzUG2IjuL8ZixEFWjqHtZIR+QNMkzJg80CWmcXcOLrZrG8DR9aKP5ZXWT8ECKY/Hj6RYDy+Xuvq2ga3RRBeSN5dFrTs9NjKULLzLf9hysdsILNC//KZUuAm5VE7QgNHUwu2BTruFND1KNbCTxFM7raiIEVISz77fWZoKeHXrakL/Ye0LAxcbyPubPzueo07i7hVy2MUgv0haeKKLqaY8AVVcWjyLzSJeVUb6T+4AD4WtcCapR51sVGSKW9BzVrN8yRrVmAdQ3q7lAnmH9BZ6HD7Qz8UTkQKPGao3XvgPPjNJ3fFCmvtMURbc97byr/m4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDzsZ6leQitIUUQD/vJY6XHuUZ5m3qeNGEMU9oMjGzs=;
 b=AZ+LGYr4FPfGGm3chNBnnR+Fdg7Ksd3kibQs1MpAXjs7mXxJ94xnC3GpQgOiRQlu4nx9mU/AvfBbihz9t/1scA9M9QxPvdTcCXUSpk9Y3L2c2HbCwBvc8PwH78OiRjoJLfkq4Gjg7jjg9xPxjOyjUtzGcNk1ZlupXCfl00Xumk+y9skeXWNhi3XOFXzSlFPDp0SYmyuR78wEnq0adHEFFz66CRzvqxORmRztttL+WfJvJsTb8gJTpWBdwocb4GjIAp9IJ5diV+dJMhSITER3eWAb9AJaPbjXAF7K2bUQlBbwUeayzyproT5diG03lwvSjBQBfYUA/w3lXUqY4xdNEQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPF3728B70F7.apcprd01.prod.exchangelabs.com
 (2603:1096:408::318) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 12:20:46 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:20:46 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v3 1/2] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Mon,  2 Feb 2026 19:33:34 +0800
Message-ID:
 <SI2PR01MB4393E1496C7B1DDE7DBDBFC2DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260202113335.3096675-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPF3728B70F7:EE_
X-MS-Office365-Filtering-Correlation-Id: 31178737-d73d-405e-cdc8-08de62557e12
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SR9Vkfig/MaAzXlhzbKBcZ8RPFGKqIqmcuUyNxKQrIkfaZADqMnMxOruWYbbsaa6Auk8G9YYs5/sd9aFv0+Y2dLGerP421fLKtbW8L5/OdHsWrCtu0bkjy4pAJcC2bRo9zPbk8/t1F3Me/imp0dzzFfsEmgwhO/lxMdOECYdA/F/r1qayV2VU/7vb0nOhVxMzxhjmPK4Abqh2KtJYYWhEfUd1yjnj6ldiC+zTQpyOe3Djt/d5wHh8Q3lN2ruspUGUTbrZgwOeNoUVdLGbtL9uUmMEkFjOEQJiFjOrtcn46Nemg9+Xod4zmM1CkBajf19wN/reRNvulL4lhhtV3vgDtCOi1C/38+iSKfaojpzRWG3Je+1tMikoz7dS+6jMGKIbcgxdpNkQQsA3FJN/2Vlje1umY3HKYxEHofA4VBKRLEbiVKziW00VgRMtAHNBeiyeVZflCY562tnPPjeI5VN/q6l6KDn3HkW6AaNCby3Fw+QGpjoNspk9p/F1rEFYRya9fXupCI4fUYmmcdnsexVBgVaIeCBVy0bOF9kzZCoDWp+wTsJHfQaMavHeDIA3i0he8WbYvCyZtaThNVwOBiCK/6XdQrqWidcTHBK7CWhmw87RHfpr+46kRMwFsYSFg0A9HGELgRakEq7c0+KMrP9224/u2Vhzzh6X1j6OlFtGUtuBwHGv5oE5GjpEy38eB92HG0f3qqTqj+at8foAn4JPzykDc2SVs5sHCDhbCi20kgU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|5072599009|461199028|19110799012|41001999006|37102599003|12121999013|8060799015|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk8vTzRLQ21LcEEvMEprclRWR2RuT25LMXk1MXZxS2lZaGo0Rk5GUXVrWnNj?=
 =?utf-8?B?Y0R0aFdVc1o1cXNSelltQ2dPakNjNkxsQlFCdndweERVQWs3Q25QeEQ1UFc0?=
 =?utf-8?B?a1NyVE42YTV0VE1sU01jUzBoVXJwR0huZ1RyODBXQ3l3ZzhxZVFDMnJuRllk?=
 =?utf-8?B?ak1DZWtHMTVtSGROYnY0ZzRRV2V5dG5kZVNpZkd2eHJTc3oxRUNnbjRFb3hB?=
 =?utf-8?B?WGxNWW9qei9CbjMyMncyZUxVUHZYTGJlcTdTelZwbzhoVmFKS1VRR0R3M2pM?=
 =?utf-8?B?ZWJPUWFsMi9TY3NodHZnVElVa29xWmpKREZNWENsMGpRSzlXTzFYZHpJOFBO?=
 =?utf-8?B?dFo1SEMwVHhTV3lseXJKeFROb0txY1NtMXd1a0I2d1FRbmlkeHFSZ0xMM2Fa?=
 =?utf-8?B?Uk5oR0xCY2NvbjMwaFltekdYY3dEUy9NbFBjbjBLMmVLVEpQU1FnUWlIUVQy?=
 =?utf-8?B?SnRFU3plYnhzd1NOQkJDQlVydXhBRmFwZXhkc3U4LzdPVHZoNEd3L3ZjdHBX?=
 =?utf-8?B?N0Z1VTZsWk1xaXJhblhDd3NhUXMyckpzNVo0Nk1IbWV4RFZBaGx6OTJoV0hu?=
 =?utf-8?B?TU5kT2Y3K3hZVnlqc1FQWFM0Yk02THRxOEMzendCamxmUzRsc3pvWE50SjJh?=
 =?utf-8?B?ZTExR2dCN280TmFrSXpWazJSb0cvdzFDR1phbnFVNkQ0d3owYTNCRVRrN3Rj?=
 =?utf-8?B?SCt0b0NkU1J2UmJHekxnL1c5RURhU1VBclZlcTdVZThITnR0bUEwS0lOZ0Jo?=
 =?utf-8?B?YVRIV296MjBITlp2VDRaVG5hMFBSV3ZqU1NhR1Z2ZHN1UGEvMnlQTUNqeUlv?=
 =?utf-8?B?SjhCV3R5M20yczgyMTdCNHVCOHEyZlB5UjZUMDJhV1BvVFY4ZmpkbkdHOEFl?=
 =?utf-8?B?cTRhMk9ObTFBdWpWNmVtK3BMbW5id011cGMvUERlM0dTaHJ3aHljSDhzaEJl?=
 =?utf-8?B?c2Z4Y3phQWtYb2YvMnd0a1dxMjd2MkZNSExMOUJ1YTBFWUxGbWo5RlpSQm0r?=
 =?utf-8?B?SFMzQU9QNStNakJOd281RmtGNTA3NXRYUTh4eW1SVmYzVk5NZG1YMmFxSHUx?=
 =?utf-8?B?RTU2Y0g0SWl2V29OWHlkbW1ySDNKVEdodFM4a2ptOTRMNlI4b3FOQUhhTWtP?=
 =?utf-8?B?ejdXYmNDRkJ0ckorN3Q1ZEkrVXpxa0dKcUFicTloZjJ4bHB0MlVma05QQi84?=
 =?utf-8?B?M1A4YldCNld5Nm9WcnQ5K3R4NUV6WllUbmhDWENYYlcxcnlXVGdoeENncHNr?=
 =?utf-8?B?VGp6aVRISTFoT1YrQVU0cWl5a0pQQjRRVUVuNk1seEY0MkZ6V21zankzK1R0?=
 =?utf-8?B?WTlmbGtuZ2Z0b1lib3B0SGxJY21zODJuSmZtQTY1Z2dwYURvaHY0dmtYdHQ4?=
 =?utf-8?B?ZlVoSUlyN0VBc3djTXZibWdzRFNJUUJ3bVZ0MjN3Wm1WdVY0S2U2SS9DTVM3?=
 =?utf-8?B?VTI3MDlJTmhQR21NdlIyTDVzeVU0VFdhWHdpMlBBWDJPVEloUHB1RXRwMlhC?=
 =?utf-8?B?YTI1V2p6L1JsS3grVm9DaG9EYVd0SXJsWGxZMitkZnc3cUVQWlR1MG9xc0Vj?=
 =?utf-8?B?dWR4VytLYUV2Vm5TZ1MvWmh3ZjcxUFA0UGdZY3NocGdJWk93MnpUV2VaSWlK?=
 =?utf-8?B?SEc1VjVqTnQxTFlYN3NFZStFY3l6ZHExZkJ6YUQ3ak5yUTdodkc1R0dFTXN5?=
 =?utf-8?B?dFE3U1E2UEtndFAydUZuU0kyNkUrUkJYQW55TkJKdXorZlcreGtYa1o0WjBy?=
 =?utf-8?B?dmJuL3RVemdlQ0EwclFUai9Db0dYQzJMNHlxeXhKa05tTnliSityVmV6VzFn?=
 =?utf-8?B?eUluR2puNTh0Yy9nbmMwUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExWaWMwazhZRnorREt6a2xPRGZDRjVDQlpQWWtEN0tYa0VvQzJZSWhqYTgz?=
 =?utf-8?B?TUhRWllsQmI2VHFsMzE5aXk4R3d0V1pFUDBZTU1VTU1RYlJxa0JGVHVNN3VM?=
 =?utf-8?B?RFViRVhhak5BUGRYVmI4cmNRQW5oQ3dCc0xuNmtGTXZBaDZuRk4xWDFDaVJO?=
 =?utf-8?B?NHdkREZBaFpFcHNQMHlnaWlMbnM2TXE4c3FHRXdVVlU0b0xuOC8rUXRQdDJ6?=
 =?utf-8?B?UTRtbXBzOVZobVBZY0I1aWp1emJZVUs1bllUTGxodVpKSjdiemRVTHR3WlRM?=
 =?utf-8?B?N09ocWtwZzB0RnlySEwrbFpScEJEK1RzaGx6c0NrS3k1dGtyYnhHVGlPbHlw?=
 =?utf-8?B?N0NWN2RhY0tCenROcW9CY2N5M0JBdVVaQkd0eis1bnV5MTJ0QWdkY0dqcm03?=
 =?utf-8?B?TVJmZVVNR2kxYk9Kcis0NXhZNTVvYVh1Y3RIVXcyUlo5OHJzWnNvV0U3MWhk?=
 =?utf-8?B?WHNKYjltNUxINVJsTlhQRTlDN2dsMmhYNDNpRVhqdTg5M0pTTnR3YXhrTFFk?=
 =?utf-8?B?a2YrTk5DMTNYTmhaa3pMUDRkOW0xTGRTWDlaM29pRE44SGlwQ2ZaRFNJYW41?=
 =?utf-8?B?Nm84K0tmMU5UMkdJNmtZaEJoUkRGdjNFNFZrdy9LV0lHQVdrL2ZrWmFIVTJO?=
 =?utf-8?B?aE1XSXdHTE43d29EMGJETDN5RmRWVXpjM010T0hQcmR4Q1dGM2Q0VXVFWnIx?=
 =?utf-8?B?UUc3Y0Z3dXVrOWY5TWpSL3c0cklPOGttcWRYRkJKd3NnZklyc2xxVWJSdmJ2?=
 =?utf-8?B?ZTZ5eE4zTC9KUlRnZ0JISlFaajRQOWoyYVJBNzFMbEwvMHpZQWhNaCt0NFZz?=
 =?utf-8?B?bHYycmVBV25uSCtXMjFvZDIwTTRMSTdDNm9henJCOExza0g5QVphY3c3cEw1?=
 =?utf-8?B?QzlVOWhUMWNOTzA2SW9INkRTdStiTmVEbW4rYUpMai9wUVFDTXpIL3hVMkd3?=
 =?utf-8?B?NDlEMHFkd0NKRGtuNy9VUDk2YnNtb1duVVJhcERiZUVpNm0xdGtFWnB0YVVn?=
 =?utf-8?B?a25VdU0zbUFXR0lsOVpROXVKM3hlVWcyVjBrbktVZUFMcXZFNmpkWjJ5MTkx?=
 =?utf-8?B?ekV4QStkK0pobUNYLzVqWXV3bGlnYjBIVE5YMUFXMHRtdGRWa3VxcWlSdHMr?=
 =?utf-8?B?Yi9VRnErMzJ6QTBkUUVIclhCTko0d1VPVWdqbWhrYVQ1NlZ4UUhzenZMU1FF?=
 =?utf-8?B?MUZWWmNocXlGM1Q1Y285OUt6RVZMaDVwcUp0M2VYcjQyY1FjNCsvQUlBb0Na?=
 =?utf-8?B?R20vR0YzVXhkakQ5NlBIMmVIc0xFNU9lemxXZjF0QXR4RHArb2xLRmg0N1B3?=
 =?utf-8?B?SXlLMWJid040dDhodi9rK3k0U1BtQVpnejR1SHU2UXYwbUJNZXo5dEpYSExQ?=
 =?utf-8?B?YVBqOGNpQTFhaWJwL21TRndRQzVOVTRCemRUbXdHTkFlak50elBJQ0w5ZTRS?=
 =?utf-8?B?QUhkK3Z0YWVaQ0s4bGZRS0xoemJEcFJmZTdDb1dOVlRiaC9laVVqbzRDMG5N?=
 =?utf-8?B?QWpsK2twOTl0ZXVDZldIMkdaL2wybmlXZE8zMDZEdlpISTNRTDM1WFNRTVU5?=
 =?utf-8?B?ZDduVy9BUnU3VHNzdTA2NVkybk5WUFdEdHNoSzdwMnNhSE5kYnJYLzlnNTR5?=
 =?utf-8?B?ajNoQ0x2UkNLR2xTU3d6c01OaDY5QXVxZnN3SVhyK05lbldCdU5HZXVSeTJr?=
 =?utf-8?B?TkZCUFRzOFVlWkF3RW5TdXdhTlJ2VFUrZHV3RXZRS3RpTDI2R3lpSjJjcUx0?=
 =?utf-8?B?bzFGZmEzOXFrQllRVnlxNGdSZG0vS0FDOVFvUG5PM0IxWmt1ZEMyRlZIaEhF?=
 =?utf-8?B?MFk0cWpDQmtvWG53Q3Mxbjc4VTNPeStRVzY4ZG44cFJzNmVyaHJrSlZYWFZM?=
 =?utf-8?Q?oJhDPlvuno7sI?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 31178737-d73d-405e-cdc8-08de62557e12
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:20:46.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF3728B70F7

The ACS Enhanced Capability introduces several new access controls to
improve device isolation. These new controls are particularly important
for device passthrough in virtualization scenarios.

For example, a DMA transaction from a device may target a guest physical
address that lies within the memory aperture of the switch's upstream
port, but not within any memory aperture or BAR space of a downstream
port. In such cases, the switch would generate an Unsupported Request (UR)
response to the device, which is undesirable. Enabling Unclaimed Request
Redirect Control ensures that these DMA requests are forwarded upstream
instead of being rejected.

The ACS DSP and USP Memory Target Access Control and ACS I/O Request
Blocking features similarly enhance device isolation. Device grouping in
Linux assumes that devices are properly isolated. Therefore, enable these
controls by default if PCI_ACS_ECAP is supported by the hardware. As with
other basic ACS access controls, these new controls can be configured via
the config_acs= boot parameter.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
 drivers/pci/pci.c                             | 13 ++++++++++-
 include/uapi/linux/pci_regs.h                 |  7 ++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6b3460701910..07ca2b18248c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5276,13 +5276,22 @@ Kernel parameters
 				flags.
 
 				ACS Flags is defined as follows:
-				  bit-0 : ACS Source Validation
-				  bit-1 : ACS Translation Blocking
-				  bit-2 : ACS P2P Request Redirect
-				  bit-3 : ACS P2P Completion Redirect
-				  bit-4 : ACS Upstream Forwarding
-				  bit-5 : ACS P2P Egress Control
-				  bit-6 : ACS Direct Translated P2P
+				  bit-0     : ACS Source Validation
+				  bit-1     : ACS Translation Blocking
+				  bit-2     : ACS P2P Request Redirect
+				  bit-3     : ACS P2P Completion Redirect
+				  bit-4     : ACS Upstream Forwarding
+				  bit-5     : ACS P2P Egress Control
+				  bit-6     : ACS Direct Translated P2P
+				  bit-7     : ACS I/O Request Blocking
+				  bit-9:8   : ACS DSP Memory Target Access Ctrl
+				      00    : Direct Request access enabled
+				      01    : Request blocking enabled
+				      10    : Request redirect enabled
+				      11    : Reserved
+				  bit-11:10 : ACS USP Memory Target Access Ctrl
+				              Same encoding as bit-9:8
+				  bit-12    : ACS Unclaimed Request Redirect Ctrl
 				Each bit can be marked as:
 				  '0' – force disabled
 				  '1' – force enabled
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 15440857ff35..08d45907d73e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -942,7 +942,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		}
 
 		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
-			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
+			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_IB |
+			    PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR |
+			    PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR |
+			    PCI_ACS_URRC)) {
 			pci_err(dev, "Invalid ACS flags specified\n");
 			return;
 		}
@@ -1002,6 +1005,14 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
+	/*
+	 * Downstream and Upstream Port Memory Target Access Redirect,
+	 * Redirect Unclaimed Request Redirect Control
+	 */
+	if (caps->cap & PCI_ACS_ECAP)
+		caps->ctrl |= PCI_ACS_DMAC_RR | PCI_ACS_UMAC_RR |
+			      PCI_ACS_URRC | PCI_ACS_IB;
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (caps->cap & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ec1c54b5a310..593ef522d2ba 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,6 +1024,12 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
+#define  PCI_ACS_DMAC_RB	0x0100  /* DSP Memory Target Access Blocking */
+#define  PCI_ACS_DMAC_RR	0x0200  /* DSP Memory Target Access Redirect */
+#define  PCI_ACS_UMAC_RB	0x0400  /* USP Memory Target Access Blocking */
+#define  PCI_ACS_UMAC_RR	0x0800  /* USP Memory Target Access Redirect */
+#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
-- 
2.51.0

