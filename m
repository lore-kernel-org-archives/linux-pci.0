Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CE156F43;
	Fri,  5 Apr 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305950; cv=fail; b=fCwGKuV67yqUDz7FBvQniPwwlZ/vaXLi5/0n5LUMXepSuGgMdBtoyP34KFhAQqP/XW797HF/qVcPShKkR7wCHWrCfbpqH4GLb6Mc0MRlRYHsB5Bz/JPG/OgM0JBEGAxImd5PCLqVBWqXkpDiZaB0Bygeae8LjcqOBnRJ69t+PRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305950; c=relaxed/simple;
	bh=W+1oksuL4mwzM+BTP5hmf94I71pLacwiC7205rUHQNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBCQRqwmnHgr1NuNl31huvqKA/gtOgVhr8kvS+kCQZjHKNVNK7swZAPp4sCv1YBrDHSZH6TYLQRnC+LFnWV3R/M6aZYR2wux4PwrUMtnf8VxDhfHGtdye+o951cF0/I/C3X3HDTgJM86+WGEdZrEugb0JAA+SS3FBVdj4l8cxiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Zn0/V4wh; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Zn0/V4wh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712305946; x=1743841946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W+1oksuL4mwzM+BTP5hmf94I71pLacwiC7205rUHQNU=;
  b=Zn0/V4whR9UgYYQk1fRStkqr7WtINxCiAXJHH23F0E4IuDGmhTfJ2YkE
   pm9tOsBGdWel2QU9JWNNcRg38k5ChCRA6ZeMAxVel79wbcWXgpfCwoklv
   WKz58wH12XETrg19GxXPsUE6bKhJ7fSyyu45PgGOwuJe3RjbjYuxl3inX
   jKJT6bmg6Waj1FzLVdnbw/XbhtVV1DbgMoQ1Ejs9prNM1h3r05nfqA9uu
   p8DYxIUoVrnJpVeKDU3on+NV4zeef3Kst6S8b2Z3Go76sj98HnYR7mJQB
   4mnaTUVEWX9l1ZI+dkh8TFiX34w0FIlFDbDKGxSn6WjAMTUUdI1jNd03Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="116149721"
X-IronPort-AV: E=Sophos;i="6.07,181,1708354800"; 
   d="scan'208";a="116149721"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:31:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Clk2FSsQ93xn2oSU8DNviCC8PM79R3U0MYOrG3QLOoDtcmFWSDsKXnRs7rYVanxER5hzASdrr2riE2kZKL5dBLGf9gnNcuufm5hRueSKWPzpksLzNtjysv58E6l3tb40GR4K21vj9lHtYvWzcnYcijTQ+bhgURurdOkiNpqO/WYcfOizRFc6NRxAwrjEMh6/M4IyNaj6nYdC2uqDnKfJYP9snVt3z1dAix06pUAuK4LQGPCFRx76o6HUvSEo9Xl/2NGG5UI4OojRHlc0v3RNI3sfd+tETiGA42P+qDrSAZ4HG+wV1VZG9RoOWXo1GbrtezU9AEGYkIY4tXTtvjNqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9loyDeqfQe68XIvHYYkuyCOgQTHIMh4Ys/Aee5k6EI=;
 b=A9JWL76eEOA5KdcbHOV2E6WGl+yeezUbRVAECePDZANVVhk+bk/77psMvfFVtA1iKQ2efqc3NBlI5dRrYGQ7PP0eEq38GWymmibhvFcN3nkTMfF5phoGCt9CF+3a4G4WtuUqd8t5ORdOTspcNqmha8eKSFfMfmvuhiaKkiUOBbxNqUOYjoEgsX9/PQy4OmKg+R2jClcy2bLzuuZIbNa8jn2QMqT/RGb2PevylcIqxTlg8mEYjWyQa2DuqnDS9wgpkPmOBtodWJpNYd3XQJLHy/4fCksV8Pgmttg9JFXdbDgghiGSTkLPPjYCC9rkGYVIAmaK8GES7xVa7ojQEVjfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYWPR01MB9887.jpnprd01.prod.outlook.com (2603:1096:400:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 08:31:10 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:31:10 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Thread-Topic: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Thread-Index: AQHadFPBx8nrp1zF/UK8IxmlbTRGybFKhXmAgACiphCAC0FrgIADC5ww
Date: Fri, 5 Apr 2024 08:31:09 +0000
Message-ID:
 <OSAPR01MB7182F74119B93BB6D944C1B1BA032@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=b90f59c5-1030-4ab2-a67b-dc4b5044fa84;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-27T08:38:29Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYWPR01MB9887:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uWAFTbp55VctbMjw7cPEVfv9AZ/scg7SasbR6zYbl3M0b6AHIAyx9Jq6ES3QF2W9c0rA37iXvfk8KZ+R1Y5zXN6up32AiFBqSKrIQvYLdBcIRsHYwFkh5iie8v9DuSsTst5PIqiFNX5doW5ISrRrFWVszKCqaRCsTtAtcKqU9nR6uOcY5t6SRPVxUgPljKU1/N/onGE/wONQDpt5+0EBPcWqSgqF+ENt0lWiHkmZbda3CrLtm0LhpPSLrkm3kJXPpaDtZFsPxwyUiLdczTUFB6Pj8+Ven89ekB9rtF9GWO3RJCRCsJMFeH4ImVa/8zm8KHuApADdFoOlysfOv7xl9GlPp2I+lgpuMW/LIpQtFfgo6czihMeDX3hVCrmkvbHNHNcSVcQFPO4kfr0jknhgI1mI3oCC6bO8rcx+EZUKB2AFxC1JNTUmCfBnzjrFqo5yqKH5Q/kUwyfpoEYqUOOpcX7Bg5sMUd8TVG5QTQbT3dmrBPfm93Ld7tHj38jwwsJ8YiTwcY0hSZBFMm2KRemmOdv6veZRse2gxHguo9ICKV2nZPs2wcWgJumHdF1PlHTFWWQtwZjCkoBGspY8ALyyxrEs9aXPzeMo8f51Ix7JXWuYbdscjEvne2KYgeumvr21BwQVEDxmirhDPam/mRO7bPzD1KXdZmu4kfYMK3W7FN/AnRzJEZXJAhUCUxMAqa5hdFmMCMUvwGy6p4St25yfhA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UDNsOVRDTHpWOFdlMnZZcm40TnpKbjcrMjVmeHVjclRQM1FzdzJFWEpm?=
 =?iso-2022-jp?B?WFV0cHlocFhmblo1NzI1dmdNL3R4NHNxNk5va084QVFxZkR5b3RpekJ6?=
 =?iso-2022-jp?B?SHpjdDhMZW1MNVJTWG41M3hyUitybUVMVHUzY1hQaDM0Z0NyZ0RISkI1?=
 =?iso-2022-jp?B?c21sMzM0MFVLWjhVTXRuRXNnRWNvR1ByUWRvQVNjSnJoRUJ3aVFiZmtj?=
 =?iso-2022-jp?B?WU5GUmFpcndkeU9YaG1nTUpkeFVldmcwWUplblQzUjdxSEZ3WkRsZjNu?=
 =?iso-2022-jp?B?Y2V1dzdCUkNHOGpiODFEZ1ljYW9URXN0blVsa1hiYUt5QWZWYnB0ZGN3?=
 =?iso-2022-jp?B?ZTNseHFQSUpUZVdtVEl6VlJhNTVWS3VKZnJ0WVJydkp4Tm1BbmVVYTBh?=
 =?iso-2022-jp?B?a2piVGVCbjRUTEtpRytJcjE5eDBmcE5jOHJ3THJ2S29kcGJ3TWtZRDl6?=
 =?iso-2022-jp?B?L20xT2YrUFFaQzN5bk5hT2x4K3lraWFxODladFFZSExyOEdyWlg1V0NH?=
 =?iso-2022-jp?B?NzE3Ly91M0p6K2lhS1FyOTl6eExEWVhZVVZKMnhwcEUzUnFVeTN6dmxp?=
 =?iso-2022-jp?B?U3R5OFgwMTJaTHd0d0svakt5MzdPTWhaWjhQNk1zRHdBSGFnMVZDTGJG?=
 =?iso-2022-jp?B?ZjZDSW5OdU0vZWdYQWdwRjkyZzA1b0pPbW1YYnBJSWhLVmdVM0lwbTZQ?=
 =?iso-2022-jp?B?WVhsV2dqWTN6OFdjTXFTdXdZKzVVNnZIZWRiNGZQSm5kRGNZSUR4ZXRU?=
 =?iso-2022-jp?B?Y3NHT1RGTVBJUW1LbDVNc0h6NklNMDU1M1Mxb01HMEoxS0R6ZnowWjgr?=
 =?iso-2022-jp?B?Z0xNNlFYTk9tb205N3QxUXhzclhCM3F0MWQ0RnVjYkZKM3NGR0FwU0Ro?=
 =?iso-2022-jp?B?Z05IR0dpQkVlTFNLVnljbnpxcDcwRFJXWHBlZXZPN3JsTDdDSGRNZnFk?=
 =?iso-2022-jp?B?d3JsNG1lbjQyT01NZjZTbUhOUllBem5xWHBQdFVINitNd014bkc0SStr?=
 =?iso-2022-jp?B?c3BUalU5RVVmVEdkUEs5d2tsNVg1RHRqZmhhU1VuQXYyaXVybUd6TU1C?=
 =?iso-2022-jp?B?YVVLaGdDdXNhVGNzbEF4ZFliZ0xEN3QzTU1nWGcxbU0xMTZJZ09FWXVY?=
 =?iso-2022-jp?B?VDZleUFPZTRUYVlnUk5zWU9oV2UrM1c3REdQUW5CYXBQOXpwcWxNRVNB?=
 =?iso-2022-jp?B?RW44NHlJSk5mM2RMMkJqQWhhUzBNZEM2bzNiU1Ard1hOMDdIWGZpR3d0?=
 =?iso-2022-jp?B?dCtqYTVaL0ZCZFk3SUlHT2daMVdSVGJuVTJUSGRiSTUzT3dNTHFuU3Ny?=
 =?iso-2022-jp?B?cWU0VS9GTmlhZS9ocUFvZWVIL0ZneUh3RnNralpvSHNuTlVYQ1FBVVo0?=
 =?iso-2022-jp?B?TXlsUUJhOG95WU8yTVk3NE1XN3lrVGhiak5uYnRvWHBUNTZPaUc0TEhT?=
 =?iso-2022-jp?B?U1h5SGh2MDh1NnlESlZaeFpzTXgzVFlNUnhSaDJuOWd5dVBWcW1GZTVK?=
 =?iso-2022-jp?B?dkxUVEEwRFFCdURKUlFaWDZSRWIxQkRudU1jMjRXS1ZDK1dCMGI4UFhz?=
 =?iso-2022-jp?B?OEhHMlRKMGFVR2s0Nk5SYndQaFdzV1FReC8vQVZQWWdLc05uSmlwblFK?=
 =?iso-2022-jp?B?ZVUzVVNBTGxOb3RkRkRLVkZzbGIwYmd1YlFxQ3pHMThPTnpScXpoUCsx?=
 =?iso-2022-jp?B?NUYySEt4Y2NHYW9YMlVFbStwSGVqWXF5Zm11Y0VCbG1OdUdseWtHZ21l?=
 =?iso-2022-jp?B?T3grSHZVSUJpLzJKajRXOEFMbjdnaVNoOUU4cm1ZbjFyRXhvbzhZcnpE?=
 =?iso-2022-jp?B?bXBncTRJVlZGQ1NMa0NRUmJ4QjA1THRsVnhsVmtValZRV3RReENNVnJE?=
 =?iso-2022-jp?B?TGhsQ2ZOKzdzellMQTQ2Vkw4OFFzcUpzbHdTeGJueWdneVJTd1o1UU1r?=
 =?iso-2022-jp?B?ampHNS9wYXdBbE5kRG10VU5SUVdwaVJybzFrQ2xtd3ZYSG4wZzg1c1lS?=
 =?iso-2022-jp?B?TXliYStodnV1S1l5QXVnTnhLM1psUzJROVJnRlQ1RlY5Y0FhdGFuck9R?=
 =?iso-2022-jp?B?c2JRL1VaSnpFbExnbk8veEI4dWZlRXRmc2lMd2ZhQytFTjBLL1NsM3o1?=
 =?iso-2022-jp?B?dmh5MVRtQk5IVG9WUWRWMmdNeWRYRDZhS1BUeFRYM3Rpb1F5eUJaUFVU?=
 =?iso-2022-jp?B?NFhrUVZjbm1YYTM4TFdNOXBJZU8zbmJTQzNOOU0ybjlRSWZFa2hxZkdC?=
 =?iso-2022-jp?B?eERlVWpxQlJEbUZLZ0luYnBqS0h5eEhIRFV3cEhOZXlCWXR5VXRORGJu?=
 =?iso-2022-jp?B?ZzhaQzRWMnJxVFkyN01pbVF4OHdHUG1EcWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IY3y5X1aiqaaCYpNt2W9Be4WvM8x1nj142bPsVrlvthE+JEQURlwI8f0+8Iq20/EBhq+ZRC3h6vmKR6rUGXwEDWqACe5NbqggQo+uhsPTQ/iOTQoognHNG5IF2sXiAZF/MGc5PGoIV9m/e12InOyJ+cpJmh8mBxt9XPvBMASdSGFM5QcEN64jGi2kxF5xEWMm3vI5KadlK5kW8i5cRZQKGpCB6QR8v73vUFRpi5vZvqimRozKdZ/mFJFxjNMwgNCyRA4c7LVrV09MmsvTNGhVy/lGW8qJ/jDv4mYTTWQNzxFmZ461i+uiwUfsTCf1hsRsPW2GQEEUY3udqY839Efu+N+E96DA631I08Pf8jGCXWzvbfbS00XI5iNoOzKjW4Z8BBTxalmTWUZ2WyPXm3Po8xLGqJMIlE3jGGokG1Q8mP/1mVzlX3tJ0M0bYZimkd+BSyJwaFXy2Vl6mN+0MGX0P9vXzsMHX0kg/sR1E/zeONJ8UIfWwSamZPiLi2q/BPPqWgl3bW+LTNH098yZhxc4W6fVCF5ng6WHkaIgCuYiNkqAalCg9lvpb6JOf0YG/hBaHnZxdj0Kf9w0R++PGtWZj+E9JcC5eEsC0R7+uE3ck6NzMG4/Eky61DiK7LWXJYc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045861c9-efc1-4360-b49c-08dc554abef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 08:31:09.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOr48tIV0PhAu9uas8utslRSrTLCgguacTTptzGL4zpXqagnFLIKWXLRKEed1RpGNud+PcaR/84/iTv9f373hzsVWfW+tJEZj3rRQsk5STE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9887


Kobayashi,Daisuke wrote:
> > Dan Williams wrote:
> > > Kobayashi,Daisuke wrote:
> > > > +static struct attribute_group cxl_rcd_group =3D {
> > > > +		.attrs =3D cxl_rcd_attrs,
> > > > +		.is_visible =3D cxl_rcd_visible,
> > > > +};
> > > > +
> > > > +__ATTRIBUTE_GROUPS(cxl_rcd);
> > > > +
> > > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct
> > > > pci_device_id *id)  {
> > > >  	struct pci_host_bridge *host_bridge =3D
> > > > pci_find_host_bridge(pdev->bus); @@ -806,6 +995,9 @@ static int
> > > cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  	if (IS_ERR(mds))
> > > >  		return PTR_ERR(mds);
> > > >  	cxlds =3D &mds->cxlds;
> > > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> > > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> > > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
> > >
> > > No need to manually call device_create_file() when the attribute grou=
p is
> > > already registered below. I am surprised you did not get duplicate sy=
sfs file
> > > warnings when registering these files twice.
> > >
> >
> > Thank you for pointing it out. Remove these calls.
> >
> If you are aware of the cause, I would appreciate your insight.
> In my environment, when I removed this device_create_file(),
> the file was not generated in sysfs. Therefore, I have not been
> able to remove this manual procedure at the moment. Is there a
> possibility that simply registering with
> struct pci_driver.driver.groups will not generate a sysfs file?
>=20

I would like to report on some additional findings.
The process of registering cxl_rcd_groups to struct pci_driver.driver.dev_g=
roups seems
to not generate a file in sysfs when looking at the contents of the module_=
pci_driver() macro.

For this feature, I think it would be best to output the values to a direct=
ory
of /sys/bus/pci/devices/<pci-addr>/. To output to this directory, the attri=
bute would
need to be registered to pci_dev.dev.
My current understanding is that the best way to do this would be to regist=
er the attribute
with device_add_groups(&pdev->dev, cxl_rcd_groups) on probe and remove the =
files with
device_remove_groups(&pdev->dev, cxl_rcd_groups) on remove.
I have attached the code below. Is my usage of probe/remove correct? If so,
I will update and resubmit the patch with the following code.

 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id =
*id)
 {
        struct pci_host_bridge *host_bridge =3D pci_find_host_bridge(pdev->=
bus);
@@ -812,6 +885,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *id)
        if (IS_ERR(mds))
                return PTR_ERR(mds);
        cxlds =3D &mds->cxlds;
+       rc =3D device_add_groups(&pdev->dev, cxl_rcd_groups);
+       if (rc)
+               dev_warn(&pdev->dev, "Couldn't make rcd_groups (%d)\n", rc)=
;
        pci_set_drvdata(pdev, cxlds);
=20
        cxlds->rcd =3D is_cxl_restricted(pdev);
@@ -964,10 +1040,18 @@ static const struct pci_error_handlers cxl_error_han=
dlers =3D {
        .cor_error_detected     =3D cxl_cor_error_detected,
 };
=20
+static void cxl_pci_remove(struct pci_dev *pdev)
+{
+       if (is_cxl_restricted(pdev))
+               device_remove_groups(&pdev->dev, cxl_rcd_groups);
+}
+
 static struct pci_driver cxl_pci_driver =3D {
        .name                   =3D KBUILD_MODNAME,
        .id_table               =3D cxl_mem_pci_tbl,
        .probe                  =3D cxl_pci_probe,
+       .remove                 =3D cxl_pci_remove,
        .err_handler            =3D &cxl_error_handlers,
        .driver =3D {
                .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
--

