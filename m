Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295521E9B1A;
	Tue, 17 Mar 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768875; cv=fail; b=obXIYmTLatHQGadWzJG/jFGJtG9Khq+ZROpKbGDaNKhuRao8aBkR/F4to0GcmdjN33MiV7FK8TalA/IJoXEHVq/rz0/IJ1rMjykduRHF0IsEXT2um9o4KhRKowwuoQxTdN3H53yRcOzlNf1zAcYX+dIoK5HiC9e9AdIGDnyabIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768875; c=relaxed/simple;
	bh=79jIghAQEWcSGebqd/+eYJN8xcCmW3/11snWtOrxS/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rimmv53hkSUHEddlxa94BCMvGHIKnRaNJhwibPANf0RaNDo5rQe7v03XYChGbaeB0cjzU13HRxmdXdEVBGxpa/cd+gfarA1G2srVFy2zB3hA2xrBAJYFlpQVe8RK3ntoqaHnH3KFisKRZ80osjU7ujdEDwAo85/GhYd1VD4UPbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=swnRbtoD; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="swnRbtoD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyJjayDf6iMJbc44gcUKh3tkfrR5S27+MRIMj4ozycGcpTWKrH8RkX2Te7GZlBPEoqhJHjn75YXxFhJGU4eEj2ueiHAe1SBFhYeIrGwic5vVmYulCQMXfGpgFBCzRRC2Kmwsu4vPXuLQk5Bz7QlBjl9ff/GZg0imUEOwQemMtuxijiJhrnktPtkHg5hdLiLF8hphAcUJ9AsAhbBvzc0DEZeGip5AG0xIxzeTqupcX/Paib9oa/yHN6qZKnRzYY388c+1F0+kdh3SndpcxjSdWFUIGs8CSdAC1ldnBjGbxwf/yJcH8WksODZ85SXwTdo+5SMHS9MdTNFLTJACk7AhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79jIghAQEWcSGebqd/+eYJN8xcCmW3/11snWtOrxS/8=;
 b=XApgBy59KzcMp+EPU301yky2Y1FBwk1NZn7S4OUY2DjNdSDUUDOth7+XL8h62yPjZXtrSWfo7yYpENImMnSBuezF+lDxhydb/H0dz2yEnW4NkgpY0PRQ+QdHb7T+lALhkiQEgYAms6PmOsvO0n8zm8Ar8LDaFdLc0DSeIHF1bYvjO54Ax1+TPXNLZa+1cX8WnNkyOgdEpuvqux7IRy+1FyZCdwqHKRon5RyN8fJl9fzpiOhPjdvHamtNnmxpk+HfwRkRvFW70xrhii0foqCO4hnrTETIpNbzWYfawvob33hjfziKn/pivQ0c62z8cfd1gj6tYy3EVPo1IoqKFmG38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79jIghAQEWcSGebqd/+eYJN8xcCmW3/11snWtOrxS/8=;
 b=swnRbtoDBWAwjQkxZjXUeIgHtLjcNQ72SS+rDSdecI4Y6Ddc5d1NPpgZZXMis+YN3C2UYL27ocWJ/9+MRc5C3MUOH2WMqlGIsxeQys7lldVGuU7DWk4xcn5nDTG3/dDRF1+GoqXwr9ZMiZZIiz2gLvoKd36+c9zbMlNNHxsQZXbDjW4xcqJWG/FR1Z52Jmf50YJamMSQVLqW6MOluHqhKZNwGBlkmmT0zMZDR/qunYTu5z3cXSmye+1pcmh6g8D8Kx81Xv+HQUczp/Z5HaXEq1R3UELmnNtJ6LoTj2Ox+C2QMQVwajYvM3HRY7xsWLXsawdmCIDo3AoH+b78ay+irg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:34:27 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 17:34:27 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Srirangan Madhavan <smadhavan@nvidia.com>, Sai
 Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
	<vaslot@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krishna Thota
	<kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	"raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH V2] PCI: Hide SBR from reset_methods if masked by CXL
Thread-Topic: [PATCH V2] PCI: Hide SBR from reset_methods if masked by CXL
Thread-Index: AQHcplwNHkxjp5O44ECPHupmS5yR/bWTnF4AgB9/hYA=
Date: Tue, 17 Mar 2026 17:34:27 +0000
Message-ID: <8089c8f9-424a-440d-8a5c-7906a66b0967@nvidia.com>
References: <20260220195259.2397847-1-vidyas@nvidia.com>
 <20260225133801.30231-1-vidyas@nvidia.com>
 <b7c04f27-39a9-41df-af0a-14bc5005518e@intel.com>
In-Reply-To: <b7c04f27-39a9-41df-af0a-14bc5005518e@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BL3PR12MB6596:EE_
x-ms-office365-filtering-correlation-id: aaf0bc1f-08a3-4239-80fe-08de844b7062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 z/XDbh31Qch8iwfAm+3K4uVaVg4c4wMe1Oj8TgWaSY0IjNKuPf8h+27IjjzN/o2s6g4vvGt/zbV4QcToNXsMYRkD7KkLdcFvlEuH94gpvRhGUwNwWXRl4YHiqUF0T9et++eT3jYxf1lFK4tr0S2A5P+aW4mIirXTYTJkr51rsa1GRUqfdX9tSVg/jVgCWprt23X+QYij9JxQzhss+4+QhvAQqAblttF7ihr07vlt1mo27veZ+s3dj0pQizkmWOZA6mGHBqXEZXDTsvoYD0gaL/34tW5/axzLlWm+vPdctxdFEi3FIaxomwanBrzAzeyy4HHx9SAifQbSW0Efj0wsEhwA71YLkVJZsQpNLNqd84N/cJLCpO4IAh7EVNtgbs0Y/8uCYwO39v6egVxIueA2MLCwtyO0uuEf8eMymUJduOPjeo3GGKog4EnaHICHwSZ/80kul1FfeXAA52LmSS2i/dRYMIWtt8QfNmAKv6g0jq34PDIyWs3B2UFsAlguby2ilZT0E2Iyk02Zanu3jxtQktpOihl7obEfOQC+iwMAe9bVxBy2Syw7U/MLM6xaEc0C0snBH6gl5H1/Sju1VsfAn1gTX4BLVJxKGvZ8d+f7WqjJh2UMNjgelbEC4/NQJhAQda9KwV9kQayHEBYDLM198+IxcWrGUuSC6HsgfOc9ADnVE1VDrbJTRXqSg4cG5TiQmCmUkuxVnRnq5/FlDjMCECalsJfh7jPtSELUDe6/g65UGrAi7/yxb/76c5/6b82KD9UyA4ptj58sesv+zXIWV5n9c7TiwrfuqFtMiAEJHLc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFluVURTSUtPOHpSQUhPbForWmlXeU1uVGV2QnlsaHdhNldrL3hoSUNWUzJ0?=
 =?utf-8?B?alNxVTdzcUlLNGZUNjQ3SUp2ZGxrZXV5MDV4d25kVGsrVVFMNVBYNC9rY3B5?=
 =?utf-8?B?djZuSDBoK25Rd2pBTjBrMWhaR0llR0VUMDJzaHcxRUJFNTN6RlJoWmNkeDQ5?=
 =?utf-8?B?YU0wQ3h5bGtZS1pzTDR0OVNFQlZldnRvaFhBZDhIVjhxY1RTYU0xYmhOT2VG?=
 =?utf-8?B?aHNzVkQ0SFRWUTNrZWxtQkM3Wko2dGQranhyS1ZTQWpsd2gycVh2dzc4UzVT?=
 =?utf-8?B?SE4vQkFsakZ4NFUvYk5SUGtsc2JUaGVHbndRYVIxNU9kNmpKYWxkd01UdUFo?=
 =?utf-8?B?aHRxanhLOGdYaW11S3ZFcURsRUJrZ3pvMnk1Q3VyQWY0VzJTZU1ITUZ3VEND?=
 =?utf-8?B?T3VXSTAwTERjdENSWklBN0NScVpiVGxXeUE0bXlDMys1K3A1RTQ0TWdyMWIy?=
 =?utf-8?B?VzF4bVFPWVhFbDB1ME9HMkR2TWJDUndMRyt5L0hkaTJNdFE5cFQxKzdseGd4?=
 =?utf-8?B?Yk5SaDdwTStXRXFXbmlnMEhTcmlXMG15SnZwSmMvZ3Y2c0hnWFovZUVYblQ5?=
 =?utf-8?B?VTY3cGNCbzBlQ1lKZ2pVZzhUSTlxZGdXWVdreFdWVDdQbzF5d1RkeHVuakFo?=
 =?utf-8?B?U2tWNHB5U1dTQmR5Z3hUNGJKaE0veE5mMTRyQldnRXlOMXR6NE13ZGYxNFB3?=
 =?utf-8?B?NjJ3RzAvalNUV0U0ODhJcVVFOWNaZ3A4Q3BlOXNKUTU4TGFMc3YxdzRSZytJ?=
 =?utf-8?B?QTFSSnJvd2toVkdtVi91MHlvbkQrSmVheXVqR2E1N0J3NG03L2VadmFNSURT?=
 =?utf-8?B?WG1LRC8rTTdDazNzMk1saExOeGdSbUkvTWVCQ2M0RlRwUGxkcjlhelIwc2FV?=
 =?utf-8?B?QllDMXRHSExJeFQzcFprUG9qTHdQNWJhOThWRUhWZnAxYXJub3JvOTQ1alB0?=
 =?utf-8?B?KzRMMFVNQ1lPZWZML2lmV2JYTW9jdXg1VFdYbjJjRWl2MnpIc1FRbHFiM1pW?=
 =?utf-8?B?N1kyeXFMRVZ6a3g5TUFPYWhOS3pHRlBHN2ttMnVPUVdoSkZCaVFVN2ZHTVEy?=
 =?utf-8?B?T09Za0xHNnNjelU0V2tvbzZKOStHM1lXSEJTdnlaRzRtOHBRNDdwRjhpcFl5?=
 =?utf-8?B?R2xZT2dmamw5cWF4ZmQva1duc0R1SjU1TTdwcDJQTVI5ZFJMOEhzUktQUUNN?=
 =?utf-8?B?dG16SjgyaU1XWHpLcUpBNk9mTWo2KzRWb1JHYStSOVovZUNrUlVodGZreDZQ?=
 =?utf-8?B?cnZETGNrTURlT0ZRV0dPRTRaMDFoV0NhdnpkRzRMd2FNcWV6RHhxQmNGczQz?=
 =?utf-8?B?SmRGN3hhZGhhYWxsZDliTmIvUFFFa21sWURsNmQyYzNEUGNnVjh1dm1kdnNN?=
 =?utf-8?B?T25zclU5bzh4S1FVMUZhTnFrZms1ZFdYUm5ydUwrVXhRQzFpVTdjQ1pGOFhF?=
 =?utf-8?B?RXREYllTRUxLazRyUXpHSlZhR2Vpb2NJb29oYXJzWHhZdnkvNDRGS1YwVktP?=
 =?utf-8?B?MC9NQitYU2VSajJhS2J4MTFwMjg3clRPVWhBTjkzMjNXenJ4ZU9wdGNiTlpy?=
 =?utf-8?B?OEt0WjBKL3paTTZZTlZ4WGJ1TlpWZ3dRYUhycTgxNGtZTS9RcE9pT1pkcTla?=
 =?utf-8?B?akpXZmtNZmNCVHdXNkpIeWhJNkNXQ0oxc0ZYclVKV2VCMDlLeW9zZmptUnNL?=
 =?utf-8?B?ZU9kZVJGMWhKSktQbDI0Tnd4M2FSYmc5NjZpRmY3YWxneGhPWEpyMXdwTGZV?=
 =?utf-8?B?NmdFMkcxaE4wMURudVlROFlXWUFad2hScDhuQ2FsdENtMk9YZUU3MFZCY040?=
 =?utf-8?B?RVJ6eFF3YjN6Z0UrQmliQytIeHJrdnZwT0J3TjRjSGZhQTF5eG1zS0lHNHMr?=
 =?utf-8?B?U3JwOWI2OFU4ZnRZMWZESDlnMk83Slk4Q25XREVPZXlmY1BGZjNTaExaSnA0?=
 =?utf-8?B?TjY4U2xydTcvdklTdGcvTjU5ZzNIc0d2U25DaVRpY09iK2NIV3c5OTlwSWhl?=
 =?utf-8?B?aXoxYk1XWjhYblREZjQzWVJiWXBQU0l2clByYkl3alhuQVhXc0E3ZERTK3JX?=
 =?utf-8?B?WkVCbVBQbWNqK2lFNEQrM21DaXVaNktsdWJEZU9LbWc0T3lub09HaFhRdEdV?=
 =?utf-8?B?d0NCR3ZKbEhYd2szOFVDRTZuZE4zbTBsdVc2VW5POHJSRkdkZFR6a01OOTFk?=
 =?utf-8?B?bUI5R21lbGJPZE5SV2gwdXNKVHJPZ3ZkN1U5MXJ5bGFzckw0TEVNdXRvSDJs?=
 =?utf-8?B?SDRHaUxUZk94Ny9SYm9BTndPWk8xN0ZnYkFiZEFraW9FRDhxKzd2b1J1ZDls?=
 =?utf-8?B?dTRWazFlWGZEWDl4ekpVNUlBTDd0Y3daYlFrbHJlNlY0S0hzQUxSdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <090C80F113C9FD4F9D51B94CB5757362@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf0bc1f-08a3-4239-80fe-08de844b7062
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:34:27.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/EAx360CItAyGz4BBbVq4zMPxSqwXR7XdYwmEYbmlnSTgG1sBuaEk36N7NT2+qC7AF5xyPgt+eAdrFxlRZkgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596

T24gMjUvMDIvMjYgMjI6MDQsIERhdmUgSmlhbmcgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMi8y
NS8yNiA2OjM4IEFNLCBWaWR5YSBTYWdhciB3cm90ZToNCj4+IFRoZSBDWEwgc3BlY2lmaWNhdGlv
biAoZS5nLiwgQ1hMIHIzLjEgdjEuMCwgc2VjIDguMS41LjIpIGRlZmluZXMNCj4+IHRoZSAiVW5t
YXNrIFNCUiIgYml0IGluIHRoZSBQb3J0IENvbnRyb2wgRXh0ZW5zaW9ucyBSZWdpc3Rlci4NCj4+
IFdoZW4gdGhpcyBiaXQgaXMgMCAoZGVmYXVsdCksIGFzc2VydGluZyB0aGUgU2Vjb25kYXJ5IEJ1
cyBSZXNldCAoU0JSKSBiaXQNCj4+IGluIHRoZSBCcmlkZ2UgQ29udHJvbCByZWdpc3RlciBoYXMg
bm8gZWZmZWN0IG9uIHRoZSBkb3duc3RyZWFtIGJ1cy4NCj4+DQo+PiBDdXJyZW50bHksIHRoZSBM
aW51eCBQQ0kgY29yZSBjaGVja3MgdGhpcyBjb25kaXRpb24gaW4NCj4+IHBjaV9yZXNldF9idXNf
ZnVuY3Rpb24oKS4gSWYgU0JSIGlzIG1hc2tlZCwgaXQgcmV0dXJucyAtRU5PVFRZIGR1cmluZyB0
aGUNCj4+IGV4ZWN1dGlvbiBvZiB0aGUgcmVzZXQuIEhvd2V2ZXIsIGR1cmluZyB0aGUgcHJvYmUg
cGhhc2UgKHdoZW4gcHJvYmU9dHJ1ZSksDQo+PiB0aGUgZnVuY3Rpb24gY3VycmVudGx5IHJldHVy
bnMgMC4gVGhpcyAwIHJldHVybiB2YWx1ZSBpbmNvcnJlY3RseSBzaWduYWxzDQo+PiB0byB0aGUg
UENJIHN1YnN5c3RlbSB0aGF0IFNCUiBpcyBhIHZpYWJsZSByZXNldCBtZXRob2QgZm9yIHRoZSBk
ZXZpY2UuDQo+Pg0KPj4gQXMgYSByZXN1bHQsICdidXMnIGlzIGxpc3RlZCBpbiB0aGUgZGV2aWNl
J3MNCj4+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLy4uLi9yZXNldF9tZXRob2RzIGF0dHJpYnV0ZSwg
ZXZlbiB0aG91Z2ggdGhlIGhhcmR3YXJlDQo+PiBpcyBpbmNhcGFibGUgb2YgcGVyZm9ybWluZyBp
dC4gSWYgYSB1c2VyIGF0dGVtcHRzIHRvIHdyaXRlIGJ1cyB0byByZXNldA0KPj4gbWV0aG9kIG9y
IHRyaWdnZXJzIGEgcmVzZXQgdGhhdCBmYWxscyBiYWNrIHRvIFNCUiwgdGhlIG9wZXJhdGlvbiBm
YWlscw0KPj4gd2l0aDogImJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBJbmFwcHJvcHJpYXRlIGlv
Y3RsIGZvciBkZXZpY2UiIGVycm9yLg0KPj4NCj4+IFRoaXMgcGF0Y2ggbW9kaWZpZXMgcGNpX3Jl
c2V0X2J1c19mdW5jdGlvbigpIHRvIHJldHVybiAtRU5PVFRZIGltbWVkaWF0ZWx5DQo+PiBpZiBj
eGxfc2JyX21hc2tlZCgpIGlzIHRydWUsIHJlZ2FyZGxlc3Mgb2YgdGhlIHByb2JlIGFyZ3VtZW50
LiBUaGlzDQo+PiBlbnN1cmVzIHRoYXQgJ2J1cycgaXMgbm90IGFkdmVydGlzZWQgaW4gcmVzZXRf
bWV0aG9kcyB3aGVuIHRoZSBoYXJkd2FyZQ0KPj4gcHJldmVudHMgaXQsIGltcHJvdmluZyBjbGFy
aXR5IGZvciB1c2VycyBhbmQgYWxpZ25pbmcgdGhlIHN5c2ZzIGNhcGFiaWxpdHkNCj4+IHJlcG9y
dCB3aXRoIGFjdHVhbCBoYXJkd2FyZSBiZWhhdmlvci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogRGF2ZSBK
aWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IA0KPj4gLS0tDQo+PiB2MjoNCj4+ICogQmVm
b3JlIGRlY2lkaW5nIHRvIGhpZGUgJ2J1cycgcmVzZXQgbWV0aG9kLCBhZGQgYW4gZXh0cmEgY2hl
Y2sgdG8gbWFrZSBzdXJlDQo+PiAgIHRoYXQgdGhlIGxpbmsgaXMgaW5kZWVkIG9wZXJhdGluZyBp
biB0aGUgQ1hMIG1vZGUgYW5kIG5vdCBpbiBQQ0llIG1vZGUgYXMNCj4+ICAgdGhlIHNwZWMgY2xl
YXJseSBzYXlzIHRoYXQgYSAnMCcgaW4gJ1VubWFzayBTQlInIGRvZXNuJ3QgaGF2ZSBhbnkgZWZm
ZWN0IGlmDQo+PiAgIHRoZSBsaW5rIGlzIG5vdCBvcGVyYXRpbmcgaW4gdGhlIENYTCBtb2RlLg0K
Pj4NCj4+ICBkcml2ZXJzL3BjaS9wY2kuYyB8IDYgKy0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+PiBpbmRleCBmMzI0NDYzMGJmZDAu
LmExNzY1NjZiYTU2ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaS5jDQo+PiArKysg
Yi9kcml2ZXJzL3BjaS9wY2kuYw0KPj4gQEAgLTQ5MTUsMTIgKzQ5MTUsOCBAQCBzdGF0aWMgaW50
IHBjaV9yZXNldF9idXNfZnVuY3Rpb24oc3RydWN0IHBjaV9kZXYgKmRldiwgYm9vbCBwcm9iZSkN
Cj4+ICAgICAgICAqIElmICJkZXYiIGlzIGJlbG93IGEgQ1hMIHBvcnQgdGhhdCBoYXMgU0JSIGNv
bnRyb2wgbWFza2VkLCBTQlINCj4+ICAgICAgICAqIHdvbid0IGRvIGFueXRoaW5nLCBzbyByZXR1
cm4gZXJyb3IuDQo+PiAgICAgICAgKi8NCj4+IC0gICAgIGlmIChicmlkZ2UgJiYgY3hsX3Nicl9t
YXNrZWQoYnJpZGdlKSkgew0KPj4gLSAgICAgICAgICAgICBpZiAocHJvYmUpDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAtDQo+PiArICAgICBpZiAoYnJpZGdlICYmIGJy
aWRnZS0+aXNfY3hsICYmIGN4bF9zYnJfbWFza2VkKGJyaWRnZSkpDQo+PiAgICAgICAgICAgICAg
IHJldHVybiAtRU5PVFRZOw0KPj4gLSAgICAgfQ0KPj4NCj4+ICAgICAgIHJjID0gcGNpX2Rldl9y
ZXNldF9pb21tdV9wcmVwYXJlKGRldik7DQo+PiAgICAgICBpZiAocmMpIHsNCj4gDQoNCkJqb3Ju
LA0KRG8geW91IGhhdmUgYW55IGNvbW1lbnRzIGZvciB0aGlzIHBhdGNoPw0K
