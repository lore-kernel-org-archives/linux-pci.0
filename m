Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013086.outbound.protection.outlook.com [52.103.74.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B593F8891
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061228; cv=fail; b=dSvTdqHEw0cTc+8ZXWw0bL3sF06b+ihQ39yHT6MUf2SETAwXqWBH3+OOabDcUZ0nhKQgRrGdBqx+8B0HN2dHAOW8bn8LGDZ+ZLR4RNjhvMWQULHGb2g8bMWKZdb8Jfp3ettF///+5I2SA2pa0qjQ1IAH+Bl7YnP4qUwnBkrSs3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061228; c=relaxed/simple;
	bh=9XEQT6o5kp1S86GQko/9h+cbVQcU/Cmw/KRsi/xRD8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoxJoepx8MjId+uH2yQl1m5H7oiR+ZCoAevbvpLdfHsnxkadr7jAMkQqnW77ING3QJ5FRqNF1ghI44LHce8ASUxUy9ZAzdno6mPXFSJKrO7Oy/imrGVwvHeV0EF17eWYOYg56B54brFfTYPYsz2aWwhXFqSZXP7Bph3iYCGJ+W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nTdcEaFY; arc=fail smtp.client-ip=52.103.74.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nTdcEaFY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKVYSd/6nxjtcFYvb0rrgVE9EX1ROwMpqw5xcps7xjS9IJmbiZe2PIbbngoQTKGIgnOF46pCXdXMlEYaq1o2nh5ZgVo02ud3WnuQyN7Rx2u6ouO9HQYg+1VwfYahGSsa9jcJMysi333VqkYVLiZK0+OLLwRgxfwuD1McVwkExDHcPFSR2wCoYb5ZJn/Q5BjSZaJ/AGbQVpJbI2J2qKdC1aHzypMMRjrOn0TAEcrsCZhkvTDQHwk1za8OCTDWOxzFmoNWtF10SMSDwqT2Y2IYmR9xVnKSiZJIL/zKpNDBkQWGURtKIFEo5l/SaNulK2lEQ9j1eMBZqr9P3Mxt41ZMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jgdbc39TOU+yB8WUlMiF28JDOzJBVFJqkcOChQF+tA=;
 b=u2SoGskuTWw+b8PLj3Nkm7CExWbIsPESdOzkURDGsgG3YdkvPg7UutaJgGwty6Xt5nYlbFhzJ6ZNeZuq1+NZRHjAQ2GswxrK6M3bcTO3pjro9ItTbbjXBqh8gB9ip0hPDJ3OS5COpkb+zbiczn3InExVHlWE6D37INB7tvzSdTKFiXEj4jaD9TD9huNAUMOasHKRC4PYU8Yx1eNHwu8iMSt1iwr3pOQwl7cgzVJbcriPwk9cASP2aRsQnxFBUd0J4FpoOXFBKmNm4ncUmkx9sspZHjpdhj+G3UtzPusPHZnMFARUHykBcoy65A0oiDaGNe3fQhs4wrEJy7qvOhBnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jgdbc39TOU+yB8WUlMiF28JDOzJBVFJqkcOChQF+tA=;
 b=nTdcEaFY4biRWVDvQCYoQguk3OaTjhUyg+Mnke+GId+EDF//oiKm3IwimbxBmK5v6iuGyU4ewTOAPELZMHqQhbIERphCeWGw2HjJguFkoILms18IkW/BJDTxp4egzxxfZxWxm0YZGawO+9YMnxd1xu3K7V5CO2UKHvBZWRbsKGaa2VjNXjxKH8Cef26rKozhTOQc7uGUtQR3+jHUgQP01mDBwhTYRBlOzR0x/HTU9jJ3xV2bTjLi7+j9aUm1l8A9b4AnT5+TNorSDZ2Tosa8bf953jbX/+ucabrWPkYNYu9vRwKHnCZ4hDPOdzUo+uggkCvGraTjrcqetaZiQ1YRqg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPF7F53943C2.apcprd01.prod.exchangelabs.com
 (2603:1096:408::33b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 07:13:44 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 07:13:44 +0000
Message-ID:
 <SI2PR01MB4393E84FC42451D52C3BED51DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 22 Sep 2026 15:13:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43939FB8FF7F1239925023C4DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260903043916.5B7FA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260903043916.5B7FA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <91b6d856-73f3-4202-96d7-06eb2b478b0d@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPF7F53943C2:EE_
X-MS-Office365-Filtering-Correlation-Id: b7303a5d-8f26-41c8-4eff-08df187908e0
X-MS-Exchange-SLBlob-MailProps:
	AlkLxVwsndm0VyxXF8Qt58maZsxVls0a0RL1COIGqAH0wp+kHQP3mddRSbukttglPPzzMbf8/B9xeQrWtOr8nOBDcrb0v5/i/4P0vzZXxsmZ98eAXT4rSrH+NIDexP57DhDywPspaU/95XTlmOlJZN+Jmz8/pl4l6PYDy51frcjMRhPDJOqRoE59W1zqC/XHidGOIBjNu3JRyhXIFQN3pUoZujHQwyZnS+scd0vXE+TBLQiPCauxjpi5ke/pTXoy6Y8dWnjR26j+pGRsi4MgK1JGa7cbgIlJ15p6eu009lbZHYtFXINuF4/PnRrFBJ3QMlL88vnQ9Xwdi9GTHh1U+TchL3vZz0BmIHw4KXwz0Vz9Zqqqau1i0ya2uRDm4hdEOaIjI/kLXMCtRO54YHb+HvFT6GFwXp6TD6TxTR3G6P9fnzyGW2F+DDq2M0DsB+jANesSYnfTBMO40T6w+7i9P+C/HajNfV5ub8f1Gp4jET8Bw7dv4Dem4p1wYE/NzD/kVZWdoKZCt720rDzlaZUSYkirtFrpoBij2m43ELskqyE2zOX63p6GWdkHx0LhPlFC83DWOPCach7fTq9bh1S86MZQ0/h5zdOeiF+3ZdSqOn3h/Doa+1fCQHkTaEjpkwhRYWdHCf7wGEsOvHyU42qQ+K71scxEBLckcBC8Fu7KRrcJ97Rt4HZZU5aWLeLPLJUTX6tGtfBjfIrYwKaeuq9quJAwFsvVDVz7/lS6WACH278GAFu+lK4jo8wmJJPRn6GxLdI2K8SLtNpyC8kI6mgGji2uFcl0OxQm
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|15080799012|23021999003|7042599007|12121999013|19110799012|8060799015|25010399006|4140399003|41001999006|37011999003|45011099003|440099028|3412199025|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZIak5pQVMrL0lDTFVkTmF5UkZMUFlPRTRzUjFOR3dsMXlHbXA3aVRUY1dQ?=
 =?utf-8?B?VWFKZDk4Zms3Wjg0YlRsNDkwQ1ZvUmNVWm1YUXZpd3IrRUxrR0JPdlRsTHNG?=
 =?utf-8?B?ZVJqMzhoaTBUZXgvTDQ0Q3hSaHBicjA4QzNXcXZ5ZmtEQVdvTVFOamh1UWQ5?=
 =?utf-8?B?SU9QU09uT0RoMFkvOTgrY3dHZ1R1MHl5S1JuZjJpbUtmWHdQQVJPTks5SEFB?=
 =?utf-8?B?NW82MkR3SXVmNXBEaG8xTU5XLzBPZjA2Z2o1ejRacGJFa0hZYkZVR2oxajNQ?=
 =?utf-8?B?OEhLbnhadURNWmVQTzhVanFaLzJUS2hDWFdhT2xLaGl0NW9kVmQyMlFNRWhM?=
 =?utf-8?B?aU00ZmFhNk42aThwaE5KUG5OZ2hBbUp2bzYyWmdacFNaZU13bGJxS05KNU1D?=
 =?utf-8?B?WHpJS1YwQnFuaWlBank3L0hPa2RXajN6blROY1doRFA4QnV1dDBpR0ZZV1NP?=
 =?utf-8?B?cVlxWFd2NmxCT3pZLzZvR0FyRXh3RTJkcmZOUDJaK0MvQ0pTcG9WY3cvWGFw?=
 =?utf-8?B?bWV0eGRESWpkTnh5dTNzZCtiWXRmNEZoc05MMFE5RjZBOEZwd3ZYM3Y2bHpY?=
 =?utf-8?B?SFprRnNTYklxR05iTUh2Y091UW9EdkhBK2YvTGd1NTAyZWhuQ044eThGaENr?=
 =?utf-8?B?VmlwQ2Y2dXJiSXM1dFJYSWhHYzBPL2xqQzZuSmhPOFRCWU5INk51NXZJN0gx?=
 =?utf-8?B?dWNscW9BRlJIbGFmS1ZUejJTUElFTGM2YnJISmJ2R1dHbW4vd24vZ2hUVDVq?=
 =?utf-8?B?cS9hR1VWTmZGa1JCcUJuQ2dvdDZmdHY3ZHJ5NWwxZGxXS2hGTnoyYUM2Nlhj?=
 =?utf-8?B?NU1wTWpMa2txQ1lHSTc1WTE1Z3Z4VlBNVjBiU0trbWV2N2dvTURNWTlwd3Vv?=
 =?utf-8?B?Rmc1bytrZXBHS2tqUkh0dGdERHBjdkJxQXI1aG9TMmtOWTcwK3ZoNWtmdWlI?=
 =?utf-8?B?M2w5UnJvYnAzN3dNT21kdWxZdkZacVZZZXZ6U3JQdGFnWEZYNXNsbitIS3du?=
 =?utf-8?B?WCtmUHRSQTN4SEJTb2txcUV0TVlZQW0wRUN6T3haZGhYdkpGZHh4U0FZMVZz?=
 =?utf-8?B?ZFppMk5CQmdOWnNOL1lrdU91cFRMN296TU44bDE3emdQQkk1ZDBPZzBTVUZU?=
 =?utf-8?B?eUJrVUpicE1EeitXMy9KUTVhZkNFR2ZnKzVYNmlEZUJOdy8wa01hMUtweTd1?=
 =?utf-8?B?ejEraTVreFJ2YmhjWC9WNVRYN0p5aUI5NkRSZFN2WjlTbTZmNzQrRWpGNkFy?=
 =?utf-8?B?bmFNSjZtcXh1STJoOERTVWJCZ0pXS3BPd09EOFB6T1lyc01zbURUWlZlblEw?=
 =?utf-8?B?QTh0aEtPUDBIU0w2My9VRUxRSUgvYk5CclEvendXSHdvOVZwWTM2TEVlb1px?=
 =?utf-8?B?UlhteFlORWpqSWhzQUcrZ1NZbDR3RG1jSldNcm9rbmVRSTV6V2hXUTZUZFdX?=
 =?utf-8?B?VnV6d2RKcEVtRXcwUUIzN3BNRzMxMWdxWnU2Mk5RPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFFIclFJc0RNRkt1VlI0Z0NGWHBDVm5BR2dxMzNRZmVsendDV0hOS0g4dlgx?=
 =?utf-8?B?Y1BMcEJJd0lMR1hXL3pHb0N5dDArTTdqVjRwL1JxNXpNeTJKbnhURW5OTlJn?=
 =?utf-8?B?bGZTMkFTNkp5YTZIQWlyN1d1cXdobXdORkhMVk4rRnp4OHo0cjdSeGpwczc5?=
 =?utf-8?B?SDZpTHo1OXMyaUc2TXRUVlpBVkxBZG5OUFk4dWx1SzZ1TzZTbUttNHRVQUpk?=
 =?utf-8?B?L0s2dEVWbHB5SjBGdDFRcTUyQnJNZ0p5cE1LWkk2cFVSZ0l4S2xtcWNNY3Fw?=
 =?utf-8?B?MDdQeVJrcHRQZFBJVGZYdDdndUFPL1BtMUtRUW5qQ1NRQWVnMXhUQzdlV2p3?=
 =?utf-8?B?aTlrYWtzcFhyOGxzaVR6azNma1FPbzY3aWwzWVNRV2h1S3p4SG15OTg4Q2gw?=
 =?utf-8?B?cjlaYkxGaDU2ZEVKVmxXZHljeEpqRUVrUVRuU0Nyb3lwUUtvNDlET0JidzJG?=
 =?utf-8?B?YnVvem92VXhucS85RVJlckNGbGFoYm0wR25qNjBpVmd1R1VwRFNHSnNxMXUy?=
 =?utf-8?B?eEpsQ052V3E5a1dFU2lOcGtvWmdqdDltWEFpNDkwOFlBYUlzZDhrTDQyZHRQ?=
 =?utf-8?B?SmZzRXRhdWJKZ2ZKOGlsWTg1MzZoV1lyZi96Z2JuVGMrWDc3QjcyTUVPR29z?=
 =?utf-8?B?VEEwbDZacFl5MnZmNnlzY0pMT3lXTlpXdWVuSy9rdUNrdlNTUS9kcVV4bjNm?=
 =?utf-8?B?eG9USGJFR0ZoUmEvajQ0SVViZHM5N28xUFh0MkZIMGp6cEdoN1VDdk9pT3lm?=
 =?utf-8?B?cjFVSFppOFZOejVSbit3VHltQ1FxZk5JRWM2WWNTdHBiSzRhNHcrWUI1aDhZ?=
 =?utf-8?B?YmMwYjlOVEdHSzJDVlN2N0RXVjdTNFFoMUV4N3ZLVWR6UXVMM2U5YzB1c2gr?=
 =?utf-8?B?ejY3YkJaZnVtUGRZMnFRSkZZdFB3YkJ2QzNlbnFBR1hQaUhHY2FvWFFEN21X?=
 =?utf-8?B?YXY5ak9zVzQwMlhscTVCdDIwbysrZkNWU2ZZQ21lV294ZTB4cUd1b21tL2tC?=
 =?utf-8?B?VmpYUXlxRjVPZi9aejk1dWIrRjg4ZE53dzhUd0dwcWt0V3lQemxBQ2VnTFJl?=
 =?utf-8?B?Zm44elRPT3pIUndZODRmcTh1N2g3MVNJcmh4dCsxeUxCZGxwRy9lOVN4d0dV?=
 =?utf-8?B?bkIxZWFwSGxBRVpCVEI4NVIvMUFacWRvaGdYM09XRzhqdFVTSjY1ck1ZTWh5?=
 =?utf-8?B?NXhmRHlrQ3lMQlFLWExOVHJBTTFlRHNSVkkvY0VHUjRMVjJ1WkFUR3NzQlg1?=
 =?utf-8?B?MUt4S2dLN3Erc0Yvd2pkbnp6VXhSdmVrNEExT3VsS0ppejNXdFpzYlR4dnJG?=
 =?utf-8?B?blNOeHNhWm5ucDRHbDdkVjJ3N2ZKNWU2K3ptY2k3Z0ZaRkEzYTNsV1dPK0xW?=
 =?utf-8?B?aXlMNmVhZGJ6NTc1aFVDbW1QMXByd2xUM0FEQzBsM3hvNFlzeUE4R003dndP?=
 =?utf-8?B?ZGNEVVVMcVVJdVZCU3NxS3I2aTZ2UkZEbTkvT25hZFBKbTQ0cENDMEhoVVZh?=
 =?utf-8?B?cldEQ1ZrKzQvWXF6ZEw3TjJKUmtNcmhvYkJaZ1F6U3lubENwbW8yVmVBYTc0?=
 =?utf-8?B?anZBb2ZBYVdOa1llRVpTdDFKWVp1UUVVYTNEd1RlYUJsTXkrN0ZWNDV6YWNq?=
 =?utf-8?B?c1BwQ0k1QS9SZVVnSGhBRWFIODdpMmUxVExNcWx0N2lSZGpPWXRaZVVjS0Rx?=
 =?utf-8?B?ZU5iUUdCVEJaSXh4dzRUZkw2Y2tHWWROUnRodDV0QjU4S0lSejlJVDYwZ2k2?=
 =?utf-8?B?ZHJ5cjdoOVFlOVd4RU96Y2pIVTdFWXdEbkRkbzJhdnZWeUVzTkRpR0U4dnlY?=
 =?utf-8?B?dDhlaDFQWUVDYkd1SnJteHpWU2N1YnYvQTRQMzAzOWVmNE9RNERWT1RRUkJj?=
 =?utf-8?Q?nrMjT6ntVfWu/?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b7303a5d-8f26-41c8-4eff-08df187908e0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:13:43.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF7F53943C2



On 9/3/26 12:39 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unconditional validation of DMAC and UMAC fields rejects valid user ACS configurations on non-ECAP devices and fails to account for kernel-corrected states.
> - [Medium] ACS Enhanced Capability access controls are unconditionally applied to unsupported PCIe port types, writing to reserved bits.
> --
> 
> commit e1302a2bae5cac8f4c54de9a2a416f24d9b8a517
> Author: Wei Wang <wei.w.wang@hotmail.com>
> 
> PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
> 
> The ACS Enhanced Capability introduces several new access controls to
> improve device isolation. These new controls are particularly important
> for device passthrough in virtualization scenarios.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 6cffdbba99d34..50a3b61f9898e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1026,10 +1029,23 @@ static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
>>   		disabled_bits &= valid_ctrl;
>>   	}
>>   
>> +	/*
>> +	 * DMAC/UMAC are 2-bit fields where encoding 0b11 is reserved. The
>> +	 * final value can land on 0b11 not only when the user enables both
>> +	 * bits, but also when they enable one bit, e.g. "1x", while fw_ctrl
>> +	 * already has the other set (e.g. "01").
>> +	 */
>> +	new_ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
>> +	if (FIELD_GET(PCI_ACS_DMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD ||
>> +	    FIELD_GET(PCI_ACS_UMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD) {
>> +		pci_err(dev, "ACS DMAC/UMAC would be set to reserved value\n");
>> +		return;
>> +	}
> 
> [Severity: High]
> Does this unconditional check against reserved DMAC/UMAC values reject valid
> user configurations on non-ECAP devices?
> 
> If a user boots with the config_acs parameter to configure a non-ECAP device,
> but its firmware leaves bits 8:9 or 10:11 as 0b11, this FIELD_GET check detects
> PCI_ACS_MAC_RSVD and aborts the configuration, preventing the user from
> applying basic ACS settings.
> 
> Additionally, for ECAP devices with buggy firmware defaults (0b11), building
> the new control register using caps->fw_ctrl instead of the kernel-corrected
> caps->ctrl revives the invalid firmware state, instantly triggering this
> validation failure and rejecting unrelated user flags.


I don't think this needs a change:

- On non-ECAP devices, bits 7-12 of the ACS Control register are RsvdP (RsvdP when
   the ACS Enhanced Capability bit is clear, and RsvdP before ECAP was introduced),
   so they read as 0 on conforming hardware.
   User-supplied bits in that range are already dropped via valid_ctrl, so the
   check can't fire for these devices.

- For ECAP devices whose firmware writes the reserved 0b11 encoding, the config_acs
   entry is rejected with an error and caps->ctrl is left unchanged (the
   pci_std_enable_acs() default, DMAC = Request Redirect, when ACS is enabled). The
   user can override the field by specifying bits 9:8 / 11:10 explicitly.

- Regarding caps->ctrl v.s. caps->fw_ctrl, building from fw_ctrl is intentional.
   In config_acs, 'x' means "keep the firmware/power-up value". Building from
   caps->ctrl would change that meaning for every bit, not just DMAC/UMAC.

> 
> [ ... ]
> 
>> @@ -1051,6 +1067,20 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>>   	/* Upstream Forwarding */
>>   	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
>>   
>> +	/*
>> +	 * Enable Unclaimed Request Redirect Control, I/O Request Blocking,
>> +	 * and Downstream and Upstream Port Memory Target Access Redirect.
>> +	 */
>> +	if (dev->acs_capabilities & PCI_ACS_ECAP) {
>> +		caps->ctrl |= PCI_ACS_IB;
>> +		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
> 
> [Severity: Medium]
> Can this logic unconditionally apply these access controls to unsupported
> port types?
> 
> If the kernel enumerates a PCIe Endpoint or Upstream Port that has the
> PCI_ACS_ECAP bit set in its ACS capabilities, this unconditionally modifies
> PCI_ACS_DMAC_MASK and sets PCI_ACS_IB.
> 
> Because ECAP controls like DMAC only apply to Root Ports and Downstream Ports,
> applying them to Endpoints or Upstream Ports writes to reserved bits, which
> could risk hardware misbehavior.


I don't think this needs a functional change either.

The spec defines the ACS Enhanced Capability bit as required for Root
Ports and Switch Downstream Ports that support the ACS Enhanced
Capability mechanisms, and those mechanisms are only defined for Root
Ports and Switch Downstream Ports. Endpoints and Upstream Ports are not
expected to advertise PCI_ACS_ECAP, so the capability check alone keeps
these controls to RPs and DSPs, with URRC/UMAC further limited to DSPs.
This matches pci_acs_enabled() in patch 6, which only checks the enhanced
controls on RPs and DSPs.


> 
>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
>> +			caps->ctrl |= PCI_ACS_URRC;
>> +			FIELD_MODIFY(PCI_ACS_UMAC_MASK,
>> +				     &caps->ctrl, PCI_ACS_MAC_RR);
>> +		}
>> +	}
>> +
> 

