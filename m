Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB3E9580;
	Thu,  3 Sep 2026 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434434; cv=fail; b=r+sIzACQHlAfDrA2871D1Qb6LG9eaxyJKSpOfJDFhghkna0+qE0ixbUVXffPSfE0xvNQbVn6vEKfb+GuZPGftkSUR0KQwKAaACAG5+T5nOYeZflZ74ebbnMvEuYEFf+8DxtPTe+GfWJdw68IhuWIQGajD/umob9CblfNrgPwq3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434434; c=relaxed/simple;
	bh=WEArbjgBCf05MSm1s7M7qT6Y4BzAf1u03UWsU1B36zY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cj3+MhtH2shaS5VhjL8TyszdVEKMPlDVo8S989p85K8jyW+6hJk++70AqzBIO0wVSb9GTuNJQ5prXt5Rz/1y5m3j4YO2+gGCwcHKgba+KPvibSSSmNDEp6aoSBOO2Aql50iL4JTzIyCWvLmfOa77ZCGqdHXM9xexj0JI09Xf2fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7N9TCZK; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7N9TCZK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knNvL56h7PKkjOZ460q1bDHxQXVUJZVXEQTmOmIf5jTja+sLs2p9jblHp/mvIC+gbJW7jJQkZhQsctbxw+OP1roML915cOyQDc433Qk27rTQP9p+OP1YQBBXX7opc8j6GNViia7wyQgqztAOgKRBQxMOMx6FT0WlFjmanwDX77aw5V6m9kBv7K4NM6K/29djFovvoKPyW6w5Mz9JLWN7ZSlgbxS7cb2PO5LfBrOwRDOp/HF11NQFZKQ5lkJowNy1czviiWXEfxNuPPztJIr+ZTg42+4Aff5t8US6fiRapzu+84Pmx/V4pxZyAbY2pvqkgX9xKcF+it1YrQWNnMCZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEArbjgBCf05MSm1s7M7qT6Y4BzAf1u03UWsU1B36zY=;
 b=vDRuPaqWGASujphqCidrbH1vOk1s044IVsbSv7qm3b1+TxkL83ABLLmh1j+bluFaqRpPlM0PPl+6TrVbB7xqG0Pbb+9u6nLYwvsPE98GBtFxwsGf8Ty4/jsW9/Z3N27kCWblSd+gqqHxyLrbkqsnyjQ2560vw+D3ALWlSr7HuE5vlmzNHLOnqDndQ9XpsVovKYJUf9nx6WzMvkRzF/qI6NCgN73lAx7XqpPqLGO4RWu9d+y1d0FcMPFQP27jIn+i+E3fEEvB9pAXBso+SXYgPAeD9AUm62xlQ2V8wgnkVsrzpNr8muGi7SoADo5pq53XVDhv8DCZ4AcDWwDHDnLWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEArbjgBCf05MSm1s7M7qT6Y4BzAf1u03UWsU1B36zY=;
 b=r7N9TCZKOQGxn68DToWY4FcCX2jjQoV9a+H1wT4zXwsQwRQ5rZHb8MGEEZEQTRHhrHRAXEqo2QBO0mtvDGzq0ZzMnfjUNLS5P6kgIUD9Q6cVEgDcuZ6wPox7+gNuXNRvlpOOdbIz0QLP1QJ2qDx6lPiJVLEEVpyPTQFRkh7PHz5qFNMppd7Np/2Z95awSLFAXHT7j7FmM00K+BlrV1USvQCm/dCETKpsTztXyBLuA9WEIgZ4P44F2ozYSaoeilD/sypW8NfiJZP2DGCfsZzdcr1AZOrmpnKc4wjaSw21n+fXnH8ml+kTgom+sqyq6dv1EMawDqZgUXnyWgFKZECkgw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:20:23 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:20:23 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "kbusch@meta.com"
	<kbusch@meta.com>, "michal.winiarski@intel.com" <michal.winiarski@intel.com>,
	Sonang Patel <sonangp@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>
Subject: RE: [RFC PATCH 04/19] vfio/pci: Serialize function reset with
 recovery
Thread-Topic: [RFC PATCH 04/19] vfio/pci: Serialize function reset with
 recovery
Thread-Index: AQHdOqEtnto9Gs/eQ0eLUWLKAhsOxra8tINQ
Date: Thu, 3 Sep 2026 11:20:23 +0000
Message-ID:
 <SJ0PR12MB8614B214DCA333166CD516E6ABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-5-skolothumtho@nvidia.com>
 <3ceaf230-c06e-479e-80c5-8517dbc1710a@intel.com>
In-Reply-To: <3ceaf230-c06e-479e-80c5-8517dbc1710a@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|CH1PR12MB9575:EE_
x-ms-office365-filtering-correlation-id: 05b99b44-65c5-4159-6c00-08df09ad58c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /pMXeBDpLRSmN/qdmjU6kzMyp4MTuGeTD7ooc1Vg9cR0BTIG/5/fdSCM4uaWkaaYD5dPQCmfxiwFurcPJ40/s0JSWVhHdj+qXHzbh4g1qYPBZmrdBEUN/kjOKCyyjmUzQSjjuXxVG3BJmmQewCahoJM4pQ2kAWNOTNNDBs7kfM/hi9J3tAm664uTP41hPEJ2G2edojCDDmOGh32YRnuA66WgTMmEvkrLH+EVCJ84SpiFbxr5scZN5Hm7wLgVzBrMyp/JvMbkOGRY9itIvG6p0kybMYHfZ0S0VFgWHRysfdblG1l+Y4YxdEKemoyKIvu3sZc6yMoh0tNk6xAaUk4YOJFUmq5M2F30xSk39behKFsqAIQcp6NgV6yaiqqZGGtJCwfxTmKIcaoZy3F88IgrBh5Oea2YqDlO2+/nLdTHWVd0e9sIxrnOCPztbpkl95JM8Kq14yfvp98+4297kjfmxxH/asTvm4Gc1lkUSuRIRv906WcVuQis5DWQuQgn4qXc2zY9jxFrcQChqGuc8hNdiIaWPevCrl6ZOMga0NEWHFbODyM/cX5e3LLEdHhxisOCLsn47/5SJdk1J7dEEjimo0b/kn7KR6Ds8vK+O+he35rH7Y1SL5HtC3b7GRuxhA313dTTrWSYqHRGHacI32CMpPe/zXtdYiT//f5yy/9ecnWCxMfpvWzni4OwY5yTSlA/64/fRq0SIw57flBfkRIZqf8M47h1Jzer0I5wLnNsWfI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHNmL05xQnNKTE1OQmovcHVmL2kxdHg4SVBEZkYrQWNIZjFSVUlMOVpuM1dK?=
 =?utf-8?B?NFBhcU10d2FVQlFzMi9BTllpNFhTT3BqaURlL2V4NitBRkJnVzh3OFdqdmVB?=
 =?utf-8?B?VzI0Mnp4NVhnUXY4SmtQenZUV3BsaEJXY0JnaU1YNlVtUWFGSW1peDZnYjll?=
 =?utf-8?B?cExHY08zMUVkbXd1Z0NjSGVXbURmL2ZmaW9JcUxTbnFLY24rUjd4dUhBY0F0?=
 =?utf-8?B?REJkWU14WkJON1RxUml5YUMxK3JUY2huVzcxS3N2WTVRQ21NY1kwaEh2T0hh?=
 =?utf-8?B?Z1RKWHE4a1NtMGpRbjVsbzVXazNtYXZMaUdpdDVsMi9ZWC9rRFVOcC84dUZm?=
 =?utf-8?B?bVgzL2s4R3hCY3NPUEpoM1VJT2syTVRMR0tlTy9EOER3a2lSTE9DbTFPa2Fu?=
 =?utf-8?B?NWkzYi9LSDV3amsvTHV0cDhBWWhTNC9EM3hFdGhocWdrVXJZdGQ2c3c2bHNN?=
 =?utf-8?B?RGlTRW44VFowbTdMUlNPWEk0cng4SXE5eVV5dmhiS3I5NFB2Vk9jZkRidjNi?=
 =?utf-8?B?ODN1Y3p4dFRiQUgwblpnUTJ6V1E3MGUvRitLRHF1ZFdvV2luKzhJMlFTdFdu?=
 =?utf-8?B?Q28relBaZVFNT0NUc29ER3hnUFVuc09ka1A1U3lqZ0xvM0NDbDN3RzV0Rk5J?=
 =?utf-8?B?eXNGaW15SmswTE9sRE4yUGZtQzBtZzVEWFJoQ1M5YzN1ZEhldldkc09uYnpM?=
 =?utf-8?B?WDdYVzdTUjZZTXI5MEljN2hCMGV4WTRwc1BoZTBtaFYvcktEdk5OamlYaURk?=
 =?utf-8?B?NjlxNWJRWkoxN0JVTFBhYUpIT3YwVHZ2SmlGZUpWREtYUFZaeURyeUJVd3Nu?=
 =?utf-8?B?Z0V2eGw3aFJteGQySkhOUVZUTGRxQ1hzVDZXdTFuKzd6NE5qMS9RMlE4czZi?=
 =?utf-8?B?MDByZlZlRmE0eWZDNFRGNXN0MHAvc0VYbTI4NlBqRVFLWHM1b1I5WHQ3SU9v?=
 =?utf-8?B?eW8zTjdWcXA5eG1rN0hVSDkvdCt6K3A4Tjh4OFpHUFdrK3pjS1lqL05lTnlC?=
 =?utf-8?B?R2tBMDY1ODRPb3lvUnR1cDZTTThUQ0dadmppcUdGT3FyWXJaaHU1cmp3akdM?=
 =?utf-8?B?SHF6cVVZZTN1RDNtN0ErN2FoTXhFZkE2ZjFDaG9FRUlVZm5rbk5nK0FxTHl4?=
 =?utf-8?B?cnpqdW1TdmpkTGVFRnRJSWIyRVJycWRnUU55R09tYjZZQ0dsZXNlNVRRb2gx?=
 =?utf-8?B?RG1TTFZtVFhFbnlxYldPOWZQMzNETVMzWURyVFJUZWJaMXdXS1JLYUh3MWp2?=
 =?utf-8?B?Mm51Znl2ZGsvdHVKMzNXMzNFSEN3emNkODV0ZzhzWlBySlh0Mk8zVzJqV0RH?=
 =?utf-8?B?ZjJBd3JMUkRSUjdnUElFY1dWZ01VQUFNMjBmWFI3UC9jTFNxZGhwM0VSekFH?=
 =?utf-8?B?b3hjQlY3UnVZMUFRMnlyak5nUkZ5Wm00VFZjdjFiOStxcWN0NjJjWDRVSm5J?=
 =?utf-8?B?cTVlYmc1UHNYKytTVVRKSm9neTFMRFZzUjRnUElxK1VEdTV3RDBTRXM2M09C?=
 =?utf-8?B?QzYwWjdYd3RWci9NUmltMkppL3UxMDg3YzVPUTdMSFdOajBzWUlGS3YxMW5X?=
 =?utf-8?B?NWh3ZXFEdmxWRzdMSlp1Y3YwOWMxRUIrVis0UDlUR2c4NDlnak15N1d4TUVo?=
 =?utf-8?B?bkdjNDBBTUtLYk1lS05LR3hyRXZRWC9zeHpOTVBPeXV3RGtwVzJWNU1CZHpp?=
 =?utf-8?B?YzhpS3dMTFdzeE5YcU5LSmIzTThZSktqZ3M3dkFEcVI3MlJVTmlvUG9CWC9O?=
 =?utf-8?B?eHZTa2lCNUk3ZUxUWkZ1Um93S1FYNmhnd3dEYWJhczMremttVEEwZXpWYUVN?=
 =?utf-8?B?YzczS1JLSEY4dXZ1cHhyVUxEZlJOYVRNVW5IUFk1L2JFTUV4S1AzamtVazVB?=
 =?utf-8?B?K0dXVzFKWWtnbFJDMmxmY3R6VnRHc3JuNEkwZS9ZWWM0UDN1a0o5ZkdIU2hB?=
 =?utf-8?B?OVgrdEVXQ0xYenpiR0IwRUxpaWNXWWkwenc3NWNEZXp3bTVDTVZ3QTA1emNE?=
 =?utf-8?B?MmtoSFJKbUZzcDhCOXJhYW5QNHlJWmRJYUcvMFYyN2tHLzhyVHR2aExENEZP?=
 =?utf-8?B?Q3M3eFkwMldHeURlQWJQL0FWMDRIaGFUUWFhQm81dGVXYndyTDh1OXFWOUw4?=
 =?utf-8?B?ZmptTllldWdHZUxHeVQ5VHdRM0lhK3RYM1pwZSt4UGVwNTQzWkh1Nkp3cmVM?=
 =?utf-8?B?bnUyZWpEQktsbXNBMEJJYzcwV250R3dHdHlxeEduY1BYM3JJREFnUldpRjZ4?=
 =?utf-8?B?RkVoSmNheW9hdTNIQUVmdVAvN0RNS29BRkhPZHg3Y0hjZlBvWTRoYlBENVF0?=
 =?utf-8?B?UTlBNkZxTnE3QXZxUGRDV2I5b0xJMURmaUg1MnhjSzRnS0FiN3NrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b99b44-65c5-4159-6c00-08df09ad58c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 11:20:23.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBJVjESFRm62/DYSW5Q1vL/cwl0XjeKEySpCVBcsHAjzcNcDwtGkFSdLqvQV1xX+WOioYQA8HoWztz6jYzd78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSyBWIFAsIFNhdHlhbmFy
YXlhbmEgPHNhdHlhbmFyYXlhbmEuay52LnBAaW50ZWwuY29tPg0KPiBTZW50OiAwMiBTZXB0ZW1i
ZXIgMjAyNiAwNzowNg0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhv
QG52aWRpYS5jb20+Ow0KPiBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBhbGV4QHNoYXpib3Qu
b3JnOyBqZ2dAemllcGUuY2E7IGtldmluLnRpYW5AaW50ZWwuY29tOw0KPiBrYnVzY2hAbWV0YS5j
b207IG1pY2hhbC53aW5pYXJza2lAaW50ZWwuY29tOyBTb25hbmcgUGF0ZWwNCj4gPHNvbmFuZ3BA
bnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMN
Cj4gPG1vY2hzQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDA0LzE5XSB2
ZmlvL3BjaTogU2VyaWFsaXplIGZ1bmN0aW9uIHJlc2V0IHdpdGggcmVjb3ZlcnkNCg0KWy4uLl0N
Cj4gPiAraW50IHZmaW9fcGNpX3RyeV9yZXNldF9mdW5jdGlvbihzdHJ1Y3QgdmZpb19wY2lfY29y
ZV9kZXZpY2UgKnZkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBy
ZXNldF9wb3dlcl9zdGF0ZSkNCj4gPiAgIHsNCj4gPiArICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRl
diA9IHZkZXYtPnBkZXY7DQo+ID4gKyAgICAgYm9vbCBlbmFibGVkID0gZmFsc2U7DQo+ID4gKyAg
ICAgYm9vbCBzdXBwb3J0ZWQgPSB2ZGV2LT5wY2lfcmVjb3Zlcnlfc3VwcG9ydGVkOw0KPiANCj4g
Q2FuIHdlIHVzZSBhIGhlbHBlciBmdW5jdGlvbiB0byBnZXQgcGNpIHJlY292ZXJ5IGlzIHN1cHBv
cnRlZCBvciBub3Q/DQo+IA0KPiBNYWludGFpbmFiaWxpdHkgd2lsbCBiZSBlYXN5IHdpdGggaGVs
cGVyIGZ1bmN0aW9uIHRoYW4gZGlyZWN0IGFzc2lnbm1lbnQuDQoNCk9rLiBNYXliZSB3ZSBjYW4g
YWRkIHNvbWV0aGluZyBzaW1pbGFyIHRvIHZmaW9fZGV2aWNlX2NkZXZfb3BlbmVkKCkNCmFuZCBJ
IGRvbuKAmXQgdGhpbmsgdGhhdCBsb2NhbCAic3VwcG9ydGVkIiBpcyByZXF1aXJlZCBoZXJlLg0K
DQpUaGFua3MsDQpTaGFtZWVyDQoNCg0K
