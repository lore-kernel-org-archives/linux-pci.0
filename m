Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795042063;
	b=DpRsAOub5Ykyu91zCQRqjHtg3jvMGIbHMYMl4FXhm1O96A0XoiSbpuEksW0QlK+xg31n
	 ZhmJ7jo7InZ2evX2OdLOQBIwx5DC+FgRxMpdfAI98DaDbk/z5ccvuSegBPozAacOkg/kQ
	 rC8YTaPbQMOIPIxE9ujwwPrQDhmu91j+4fJZxkBipWhMM3th3uFFBiaPCwmdn4XO0lJmk
	 CC4zMMPcPbWrpsP7Ml+cDtKD6R4Iz7SAb2K3GUUJUFg+GJ/VI4YbqNMwTJXQ1uSF3w7C2
	 S3m76NhcuSI4PHWsRtUznqJzkxVRCOLGM+wLTNyJUWVdf3jHFaQVkJZaxLPyzpj5NXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042063;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4ve9spr0wrJI/SLzVSfv2ku9lb/+h126sQSfIv9JxVo=;
	b=GzDIdz067PtIHFQ+dCFFjiXcbHYS7BOUMie6SoOoVPRXVFPnaAXg9gjaRFTSox7uxfVE
	 wn9cQ0caNUihLIIHf6DeOk4ciLeFjkiUJa7pLWDd+YIgbBeCuL2L1iVaE/I0kKvru5PRI
	 kiIvf0RBxHOzZBWtlpWcqT/Ls8Fc0EzKFR9fIrHwTFHNee45N0nFKf4ZX9jStH2TzwC59
	 MlL4AhzQmYW9wfj2qQ2rZzA15gzCbcx/36gvyc4+uI8ybUOPe1qJ4Awhx1pSMbwCQ0VLD
	 x3DGwjsqBSJYVVuU3ueF+WJdXIQH+V8k54niUJBh7ClaveOXQkALQRdhc97/z9pp/Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KiTruNPO;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=X2ShAAX4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08070606A320
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08070606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KiTruNPO;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=X2ShAAX4
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795042063; x=1826578063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ve9spr0wrJI/SLzVSfv2ku9lb/+h126sQSfIv9JxVo=;
  b=KiTruNPOvJJ7di35A1+Qo6aD70sY9NvnP+Rn0/ghlNwYXdWHdJdydGbF
   pUD8ThQh9Z5AP3vuYm3TI8lLJzo1mUjmJzKrYpmcGDg74O8e8WBKbwn++
   dJlPRDj2WxRbWgVQMCnY6ckc/x4wCpKZkBmArKdzyGRlx09Q9GuW6pdyT
   bPvrBGGjvUIz+vZ8pSUeLrgHnPOevvp/fS2klJJoxstmBLBoCoiDb1N9Q
   dywrpXi2/1n+0cwlT6yzgD0uG/p5jHylm+Pvp7lLm5X9N/OB83TzKPKO6
   ihMzUEDJ7THpdsoNk3KZKom2uHRk+A7IcrzpxDFVorNY57jMvCQVSV78p
   g==;
X-CSE-ConnectionGUID: 1zG4ZMc6TV2GeOYEoYmgTA==
X-CSE-MsgGUID: kl2a9jh5Q+WxT43gn4RTsA==
X-IronPort-AV: E=Sophos;i="6.27,219,1786982400"; 
   d="scan'208";a="156985507"
Received: from mail-westus2azon11012027.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2026 06:47:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4SD6dx+hs2l7GUb6fDmWyDoRAoJWs56uKFh4sZKnr2VN4JnP0AsS/MvMZIE35DWiogDlTVrnrspF/GLxK0Hz77XtKPyCCZNr/I8pIvLEdyTUTXqzBceqJy5bzMDSXfWHg2csHcWAIM4kbrBhL+k1/ZV8YYHYl8SNyJ1q2PJC6CsdnEy3UQXZ0MMR7HIy+vkj6SWeMRrMaIzJufVasWauazRj4HUDG6PayflJjZe68T5KNN0inwJslyH7eJin1AcpHs6PIdpCRL1pQxtymPHr6kSaJ0MS4lMP3ARBb+0ACIhjH38/A0DwImJ8MQYDvfZHPnE2gK0F4tn9tFfFwBt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ve9spr0wrJI/SLzVSfv2ku9lb/+h126sQSfIv9JxVo=;
 b=HPYEAjfh1FJcHaNSaHybK+d1yBon9/LK2G9jXYcZMGXycNBH4pxTBghjV5iPN0NY0YS5XN3gBhK93vfrBvUeXWawC6Rnqye0RM0U7sH5SzU1duoIYV7s7otgqVx+ZUHZa53F1NbRmJ0EljUjlFRMLbgwCirtl8ddp2/Tas3dkzlqqWQvbYEcKkQ8R6YMafD5IO+gA0jjQJYKqG6CLFjdgI7AiyZE4r2Hb7XkosK1MU1ymj+Vym/0qfPOYLd0lpUtl+pz88pFEYa3W/EOK2wW5rrdNpoe7Egm0a1dMYtQAO0EwNdj5CEn690TEedR5nFjT23sANCc+yTSn44PYMlMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ve9spr0wrJI/SLzVSfv2ku9lb/+h126sQSfIv9JxVo=;
 b=X2ShAAX4CEkLLUwONU6D0YCejWQYsr7pRGE78RDZQ+jbaBorVGgOVxlogiw1Yx2gPrkhG5Uk8uIFx+qSR1H8THEExQWe+XmQ3HHiC/atCGfb5B43vbTd+6X2iLov1L3NispLiyT69j7ioH56trmLPLdmkawly+8hCDP4sLxs0O4=
Received: from IA3PR04MB9680.namprd04.prod.outlook.com (2603:10b6:208:510::12)
 by PH0PR04MB7432.namprd04.prod.outlook.com (2603:10b6:510:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:47:34 +0000
Received: from IA3PR04MB9680.namprd04.prod.outlook.com
 ([fe80::380:1453:ea86:e64f]) by IA3PR04MB9680.namprd04.prod.outlook.com
 ([fe80::380:1453:ea86:e64f%7]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 22:47:34 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "chewi@gentoo.org" <chewi@gentoo.org>, "cassel@kernel.org"
	<cassel@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: PCI: dw-rockchip: Unable to boot Quartz64 Model B from NVMe since
 reset changes
Thread-Topic: PCI: dw-rockchip: Unable to boot Quartz64 Model B from NVMe
 since reset changes
Thread-Index: AQHdd3Za9kSCHdFgJkmPVJ4E1G/DKrc0CdcAgABgI4CAAASygA==
Date: Wed, 18 Nov 2026 22:47:33 +0000
Message-ID: <000b6952e6ee4718d316ae0e8c78bc6e7d630116.camel@wdc.com>
References: <08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org>
		 <av3WcJyt_tRXNj2l@ryzen>
	 <a112657de590aefc2b306ebc9e6771cbaa76ae82.camel@gentoo.org>
In-Reply-To: <a112657de590aefc2b306ebc9e6771cbaa76ae82.camel@gentoo.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR04MB9680:EE_|PH0PR04MB7432:EE_
x-ms-office365-filtering-correlation-id: 05a7d4f0-d25e-406f-c117-08df45c5efa1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003;
x-microsoft-antispam-message-info:
 o955sKmBHMzOi31EVMxoExCa0tf5U1K5fo5mhk40SElBQYq8xiJZXB0fOG/vCJRc+ODPpTjp+HnX6s7m14JUeMF7lgG2CmyDg88uLRQ0b3rBZsbIQ1lGv2CekNlyVcoblXEUgTdIzUZ6HAleCiZA1FZBq52SF5b1UHUIjJEYwuCSv2pFRhOMb4HDKoCWlHCYFRwa6rn0ExGLQcz079O8oh0MuCRYpwBS/jC/wJse313K3CYCtnlmp1DhbpAt4HT/tu+Io81ZApEr72bzLzki/7QWWkoTZlPNpJUt/FV9PZroqUYJl7FLqPU4V64QVP6tEmWtJyG/Z2WpSHu7yIxw7/eo/xSHaIeSfAKZ/WoBJyrADFJhB29TRjQR2611NSPDMfulG+9MT6ldIypcn4Y8oYfdnXNKaCLtNYu0oTT570FQS7jHL0Ska/gP6yp+plKLjCxAVBJjGmN1GdnY2kOw7tngyOZL44s4/hsAOPx56k8+FbYN+EzSktGsucahu1byMdxbYQGwvz8heIlY46jZlJXbcDnLb6I2wRXjdoapojqz56v9CV0LL6SN8psWY88T4maEw5w6HNLnEATjlrWfCgeuenJnnN4AtL5D9f/RmGrOsxphrlLYGPPvJZO2xun2vqBTmNkDvyxIUyoRkZGpc3MhBOxJDVB8YnMp3RNF8Wk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR04MB9680.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXhvbCtVV2VzMnVMWlhqMmNOM3k1c2Y4NEdxRUVCaFIxUDl4cm1ibXFPM0Fs?=
 =?utf-8?B?Q25abXRoa3duTWh6SEVlbWoyRmJkOStaV1E1ekg2V1ZjMk9LWk9lSTM5OFg5?=
 =?utf-8?B?U1pXQlU5WnBYUWc4UndpeUpHaTJoZE9Gc3VDKzlKUFlwVG1WckpmWnkzWTA3?=
 =?utf-8?B?N0VnWEpOSVkvSFh5K1V1eDRPdDVJNmVkdVlpa2lZQ2k0WU92aC94SXRHd1ky?=
 =?utf-8?B?RnJUT1VxZERCcFI4SjJrMTVMU2NHQ2hOcEt5bGJ6R0g5Q3g3ZVp5bDdBbHJa?=
 =?utf-8?B?VXcwMytiNlJJYkZvVHJUVENodnRKSjRpRjdFUDhieWY4WnFXMDdTQkhZOHEx?=
 =?utf-8?B?c0RkTW9UZnlhT2RObEFXQnB5NEtpVWZsbmJhNEprdU1rWWNodHBHb2JrTG9w?=
 =?utf-8?B?SExpaTRmWXppc0NBM3FOeC9mMktRbU1oMlM1eW5mQUlibDFWQ0FrWVdtM0d0?=
 =?utf-8?B?YUZHbFQvdURuaGZwcENHUEhFKzlYYVBSM2ZIMEJsUUtWREo3RHNYN2ZwU05E?=
 =?utf-8?B?Qmd6K215QUpkd2c0TVVxSWtPRXg5dXBHQXY3U1RyTGRISXRGbElUeVBHNmYy?=
 =?utf-8?B?T1hLc0F6N1ZNRDltRGJBWXd4c0JMZVkrUEIvYStSOEpxSTZaWFpyUmw1QlFl?=
 =?utf-8?B?RG1kaUwwZ0JjeTFxZnhmVEtaVFU1YmVIVkxEa3pLb1RYL2dYWnRrMEF5LzI5?=
 =?utf-8?B?VHA1ZDJUUUI2UkpxMnVsQTVucEZlbHJkT2psZkpnaGRHWTI3K0UrYkVDSnVU?=
 =?utf-8?B?dGpraVhNbGNtNXE2WllDVm5WY1B4VFJNUFVSWE04dkNqaTM0WkNSOGI2ZEVn?=
 =?utf-8?B?ZUNtYXZ0SHFNOElCOW9QRE9iS1VGamZMSHdXeVU5MThFWHp0RG9KRk5ScytC?=
 =?utf-8?B?UzRsRVJnYnNoWUZKWTBXOG9STTRJeDV5SEdUY3N5L2lyb2Z2dTQvWENhTXZE?=
 =?utf-8?B?UVl0Wk54b3dFMENKRHYyMHRrWUlUS2FjNGI1ZVdlQ1BnSERwZGZjREpkYUVC?=
 =?utf-8?B?RnoxRUUyWEdLY1M0d3J4c2RXMEhkbk1HQkRKdnZXNnp1MEVvK3IvK2ZWUGhm?=
 =?utf-8?B?T1QxQVA0NDZYSnY5ZWgyYnNPL2pGWkQvRmZ1YUxBZ1VwKzZGK1VwVXFFdy9r?=
 =?utf-8?B?YlpRWW9RS0txNWRvdkQ4M1VPSHFURG92SXFsVWpuQUZpQXpPcnNweGo0dkJj?=
 =?utf-8?B?OFIzZW9PTDk5bDZUTEVUZzcxWWQxSEdhWThlMzBxbE42dXRiTk9VN0ZJZS84?=
 =?utf-8?B?U2o1dVlXN0dhakZpbHBFaitzbDhnVUp2TCsya2NSWVR0T0w0Zi9PbDhKYWxI?=
 =?utf-8?B?MmZhRnB0cTlpZHVYUGR1MEZYNmJ5aWQxeHF2T0traGVNYnhNUW5BamZlREw3?=
 =?utf-8?B?M3VZUGhEOVdVSGNZRUo0RWw2Y0tvZXF4eGlUcDdKWVhxOEpsMEhhSUg3ckZP?=
 =?utf-8?B?cEpWa254UVRYekNlUm1ZcGRSVDJ2N0YzdXBsSll3M21UcUpvTm1HZ2MrUUJ3?=
 =?utf-8?B?dGhUZURLSFJISFBOa0o5dFYwQm9GZEJ1WXpXbWYvanY4dU1QWCtLTGpaSzRp?=
 =?utf-8?B?VFZpMTVYbURGQ3h2RU8vVFBTZmszNzlwamdHWXNSbzJVVVkxVEVFcnRUSHRv?=
 =?utf-8?B?bURnQ0s5VEMvVjBCOU12eDBTMlR3a1JHUUs2ZHRVcFhPUXRSOGRpbDFtQnEw?=
 =?utf-8?B?dDlYL0JkYS8yUVhHa2dmVVJYQlJnQi9uYWNXd3kxeEh1Rm1UUHd3T2pXSjRV?=
 =?utf-8?B?TWFYcXh4NU9KUFYyUGYyVElRMnNkQmp1UWRkWk9qWStDT1ViNVNQMURSSFc4?=
 =?utf-8?B?dUpJUVJMRUxpK3M1VTVPZFNWaXFhNEYxNGllTFp6aFRmaHFXNDR4NlpKTjJU?=
 =?utf-8?B?RmV5QjMwb1NsaTNzQ3Z5ZzdFZndzSy9YcHpJcDd5NExwMjRNSmp2Si9iYXhM?=
 =?utf-8?B?Yjd2UkhiQm9Bb1R0OVl4KzF6NWxIdmxRVUZqSUtqVjB6dDN5WVNnckVpeEk1?=
 =?utf-8?B?TFVxYndFNUFWMWU0cTk5L1JBWitVc0E5b1RyU3ZTS09EaVZkdGVqM2YyWVJY?=
 =?utf-8?B?WFRjM3hWTmh4SHQrcW5KNDRJTTdUaWxFZFczb1BaYlBaZW5LZEFPZEM5Q2lK?=
 =?utf-8?B?WXBOUEZMT1J1eWJoM3g3VjN2TEhlNzU4ZXVRQTc4RU5UUUhDZjNDemJyL1Y0?=
 =?utf-8?B?Sld2VjNTSWhKM0Jad282TnBvcyt4ZGdKSXlxSFFndHdLOGpqTktuZmNRR2U2?=
 =?utf-8?B?RzBzSmdFd3VPZ1p6Ni9kMTNSWExPM2lucll1aFlDM2haZDE4Q0ZtMmdOeUtk?=
 =?utf-8?B?RUtwbE45NHNDblJabWJqR1MzY21CTWZMS2VhUDA2Y2NHbzJ1Y1JNU21ZUkM3?=
 =?utf-8?Q?cYSC8hkPesmUTTMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DD703089010634392422FCBA4BB1444@namprd04.prod.outlook.com>
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
	FubXNYEeNPI+Xa0hwV0h6xB5aoxd/k6PSA5tMk4xoqBIpoymf7oE4h0pdI89ZpIRkb5eaR16OV1tinTcgwBGhVpVAm3TUSJ1oqtA9i6SqkroyrrJsG0T/osnjZ/Stjf+9M3BXRIM9XU8e2fM9IBeNlC8q4/PuQS22s0OQaG9PAWueLPGYy7J9CmG0iw6YFA1s+oSH5z8Nu2ROal9X9cm7mXR6a6g7nGpheDpGi5ZteRBS6fCc4/aVuSPlPRJkI71FJT4HVG5CnvIGWFO6PhDMe7eG7K0mvlvfyvkylWG/ChjMGb0tsvbGZxo6s7KX/pLxwCC+HGaQmMcDv7c7C7h2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TqLCV2sHVWyKmxgDcX3nevT1/KpIH4oMeUb76r+CM83EvYc+xo4MEU6d3VzHRudIpsdTQdd8yiRybpV0vo4wCfg4S4eEFIFvQP8d6ARgRlHbFy7UiuAVGb8b3jdN/l/9hM9+2iaq/9tdmE9jwaC8sbmMN+QZCNaXt9yDb3/vFHiFtzmb0WrMEaoyKVB1w6RZCrLLXUeZUS3s/SDX6Z9jwPvc//pT+fK8kBgDbwNlDhhTSIcVxvxL3uSCxg/uxLIpoNX+fK9unqGydKq8uG1YczeqRmH/DFUH4M8akXdUHq2KShkCcokZ1U7Bt5weKScWlGFbvx0FLr3gDUYrCkCIXfjNq1SaKNWWw7EvmxOcNgPy6Nv4BPI9p/AqLJGWj5sz6r2lWZIQTjj+6S2zUCR4qpXtagnZh8RcoaklYxLPnRIrS4skHTI0JPHcMzbGperv4rCzG9k87FXj1LxtWBo1mYhE3Vj+f1wJjyxUV1bd6LHAHGaGyZNQ4yZZxsp5vhWw3KrFsiRRCKZ3w4y5PEOv+Rf/dFXLyqdvF58NLEbO3sGL9kqfyS4G1oOd/xCY9NTc9JUSedxa0/vJZLO/bIASlNNo1nH8GHj1K3pVfa7df5GMo3nC7kRwmFmQsvphvwnK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR04MB9680.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a7d4f0-d25e-406f-c117-08df45c5efa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 22:47:34.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CC3ht86yO8qSbCJlOm3aCrOcuIv+LWlkD+wQexXTFFtk54RQbP0UFDLW1Sbm8h1FWstiNywvh7Tgxb8mqX8KSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7432

T24gV2VkLCAyMDI2LTExLTE4IGF0IDIyOjMwICswMDAwLCBKYW1lcyBMZSBDdWlyb3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyNi0xMS0xOCBhdCAxNzo0NiArMDEwMCwgTmlrbGFzIENhc3NlbCB3cm90
ZToNCj4gPiBIZWxsbyBKYW1lcywNCj4gPiANCj4gPiBPbiBXZWQsIE5vdiAxOCwgMjAyNiBhdCAw
NDowMzoxMVBNICswMDAwLCBKYW1lcyBMZSBDdWlyb3Qgd3JvdGU6DQo+ID4gPiBIZWxsbyBXaWxm
cmVkLA0KPiA+ID4gDQo+ID4gPiBVbmZvcnR1bmF0ZWx5LCBzaW5jZSB5b3VyIGNvbW1pdCAiUENJ
OiBkdy1yb2NrY2hpcDogSW1wbGVtZW50DQo+ID4gPiAucmVzZXRfcm9vdF9wb3J0KCkgYW5kIHVz
ZSBmb3IgbGluayBkb3duIiAoYjM3NmIzZmY5Y2IwNTI3KSwgSQ0KPiA+ID4gaGF2ZSBiZWVuDQo+
ID4gPiBiYXNpY2FsbHkgdW5hYmxlIHRvIGJvb3QgbXkgUXVhcnR6NjQgTW9kZWwgQiBmcm9tIE5W
TWUuIFNvbWV0aW1lcw0KPiA+ID4gaWYgSSB3YWl0DQo+ID4gPiBsb25nIGVub3VnaCwgaXQgd2ls
bCBldmVudHVhbGx5IHdvcmssIGFsYmVpdCB2ZXJ5IHNsb3dseS4gSWYgSQ0KPiA+ID4gcmV2ZXJ0
IHRoaXMNCj4gPiA+IChhbmQgNGU5ZjY5ZDA4MjUzKSBhZ2FpbnN0IDcuMy41LCB0aGVuIGl0IGJv
b3RzIG5vcm1hbGx5LiBIZXJlIGlzDQo+ID4gPiB0aGUgcmVsZXZhbnQNCj4gPiA+IG91dHB1dC4N
Cj4gPiANCj4gPiBUaGVyZSBhcmUgc29tZSBkd2Mtcm9ja2NoaXAgZml4ZXMgcXVldWVkIG9uIHRo
ZSBmb2xsb3dpbmcgYnJhbmNoOg0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3BjaS9wY2kuZ2l0L2xvZy8/aD1jb250cm9sbGVyL2R3Yy1yb2NrY2hp
cA0KPiA+IA0KPiA+IEl0IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIHNlZSBpZiB1c2luZyB0aGlz
IGJyYW5jaCBtYWtlcyBhDQo+ID4gZGlmZmVybmNlLg0KPiA+IA0KPiA+IA0KPiA+IEtpbmQgcmVn
YXJkcywNCj4gPiBOaWtsYXMNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIEkgcmVi
YXNlZCB0aGVzZSBhZ2FpbnN0IDcuMy41ICh3aXRoDQo+IDg1MjAzYzgzMWE4KSwNCj4gYnV0IHNh
ZGx5IGl0IG1hZGUgbm8gZGlmZmVyZW5jZS4NCg0KDQpIZXkgSmFtZXMsDQoNClRoaXMgaXMgb2Rk
ISBsb29rcyBsaWtlIHdlIGFyZSBpbiBhIEFFUiBsb29wLCB3aGljaCBpcyBpbml0aWFsbHkNCnRy
aWdnZXJlZCBieSBhIGxpbmsgZG93bi9yZXNldC4NCg0KSGF2ZSB5b3UgdHJpZWQgYm9vdGluZyB3
aXRoIHBjaWVfYXNwbT1vZmY/IEFueSBsdWNrPyBPdGhlcndpc2UsIG1heWJlDQp3ZSBhcmVuJ3Qg
aGFuZGxpbmcgdGhlIGludGVycnVwdHMgYXB0bHkuLi4NCg0KV2lsZnJlZA0K
