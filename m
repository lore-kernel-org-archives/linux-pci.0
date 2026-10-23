Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792761230;
	b=mi1DJ63/5vJRfvgODRT3DgzJYedQLmpCnvaEzZw2uM1GpEAEY1NSoFNwa/3TIaOuFWvq
	 V8emTQTUU01cKl4gukug6iKoIKXR7jWrE8vUGfyx2a4DqRNl4khJlnyjnVGVmgebVS/ph
	 Vbzr46+q1s3TAvc+SL/53elP48DFRzS2liBMJjOZzDZWghBUhK0nQWLSA8ZM6K0jlC32i
	 AN9Xr1BOVHnoLiUYy1Vb2jd3ld3eImlAu0rHuHmxfHn/BEJ8XU3Axt/f/uW9anwJsnh7V
	 mB4etwCae+qttLl/b7O/uGV/usqSwMfGDPqvgw56YLhjFHZkvDN5cTqwyzvVdqu9onQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761230;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bT7hFGfyUtBDFaBerQtlbyD5gE+98mAiKi6cGNcl9xE=;
	b=aaOJi6VWqC0RUsg90PRQOStqQE7vYTA52NNk+Y6Xt1U2mqQhNc7JlprubLA5Pnhv4ftF
	 K6XkIcAfIYVbForkh0u2HWj8T4WbUaJbGKyr2VfTo/2l0N7N5bjlAG/kf0ZA87PA7d+Ja
	 duVyOsNl4dO+oR4Q6rqfW0+pKTU0JcNoekt3ujvE55PF+ZGmTDX6CaVx/f5Xt0qwQZp1E
	 VRov0PyTh3vQQxrjQDVpj+JERC+qnntM0zktslEDWXdo9Kd2Kp/ecvwuM5eQjq1zcjWm0
	 DWCIix54OZKK5b4nRM4GE/e85sSFSiRd6/8G9aMVSTD3OEvzYwc2bThrAFuZg3JGSTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d1biOfEP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.67
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA782606A31A;
	Fri, 23 Oct 2026 13:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA782606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d1biOfEP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH/2HldUZwLWA/r6fAdO4IMmq43Z6rsJVVo42CjSIfLGl1GAk4xAdY9dNNBfz+IpSKohPeFoNdjv+c/RoV3n/ZXgCXsz/vseG8t7mMSPdWYfKfFTrI8MxAs9bGGm0+dSpwcwK6o/eFnV7lb6Q7Tmcki5Qwx7PI4TrKgsDT37m/HYOUIj2TSAu9Jhdp7jz57azU4T8MNR/EiOagGi8ya5345solnd0gq6igq3b1v70BiX/5q4fwSKobaaNPg/gGb8B0i5VEDaCtq64ZQJesENoMzjCbJVQLeLTS1fOycVPCkBfze9yBCUWSxvZPQwqC2xVyjuhNXdr1sAg0oCZPIpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT7hFGfyUtBDFaBerQtlbyD5gE+98mAiKi6cGNcl9xE=;
 b=SyFSGxihgxpMTQ+UOHsI8mZ6AAIJTHk9VHRbWvZapfqNSi+OThxeDz8cfItIRYhHp/EC2yeaapFU4oN6/asCd3in/oAy9lupHeGlQovqMyLgUTHvXABcm3FSKj3XJ566BaxYIs4i13tAppKr5u+FOgQZex/rk3Ku3II78l4dABOW372d9krcDZgaFFCBfyaz/sB3FG8jpMJiveLDgE6v9s7wStW3Uzoy7W2tSbftf19koNU601Pmyj3AuUVeCOF6j7XZrARIxsy5GgJo1JnDo1IzB5SoyZ1nb1XSLKxGbca5wLNC6MN3mQtrpxtOYXUG9h4o+pzOo1SxXgey2As4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT7hFGfyUtBDFaBerQtlbyD5gE+98mAiKi6cGNcl9xE=;
 b=d1biOfEP2Vg7PSliEpIzZo+3oUe4nT5XSMG9ng9tA8a17x7PUWoB88o17FGubWMDnB3aO6e7sDoyy9MWxkNfJd8VAKDhj/GuFju+v3EqeYNxeW446i+GWI3o0IXWMGsslfJzs0gdB49ZYBlbA3vL2sgjo+PVpnM1bnNP/KCPUOw=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Fri, 23 Oct
 2026 13:13:44 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 13:13:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Bjorn Helgaas
	<helgaas@kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
Thread-Topic: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
Thread-Index: AQHdYJv+d1Cm4hPWU0O2wr0yUWedjLcLHubQ
Date: Fri, 23 Oct 2026 13:13:43 +0000
Message-ID:
 <BN9PR12MB51466890FC618C99BA48B2A7F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
 <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>
In-Reply-To: <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-23T13:11:53.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|BN3PR12MB9572:EE_
x-ms-office365-filtering-correlation-id: c85ff519-369a-4a3e-84db-08df310776e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|261021121427099003|18002099003|10067099003|3023799007|261022113327099003|22082099003|56012099006|4143699003|11063799006|261009223027099003|261022105027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info:
 Cnto8nRbqMb0kq0/uYas03TGF2TZdbvxNkXxRvVl27d6Ha7VWnyq0JX1WHnahrNBVyjZhujxX7weTEbIFqZNJcakIIO8oqrE3Ty2Xh5OyIR3ixk9E0JU6zgehq1ZG5+qnfmrRC+8yh9pyzCIfwg0cQ+/etWhTfIzFej0LlT0Nn9vclqKaMRiTWn7TNpPiUyKHPWTuAlN2L7H/A+iLHCZ0DVN+l/kbAphPZwWirEbrwCmIMCEF5y3NX7cmtbUNAqyjZizun8EJg4Kr7K28S+PPjUVPNxB3V3GytHHpoyJP3JgQ6kx6/+1AA2ju+CUCQYCBxbEpuCec1gZBja7KTROLVzIubYyBeRdddGt2Z8RCGGm+7ri6dedRimKe6vnIckDWFqs5wB4j24wnr72oHD4RP9O0UfBaL+1HVN1EfxWggUl9aprfLpkSiM1skMlx7vaI/65lsocUDXyWwuQaNsTLLEJibW5PgmNmbB7DmkBb/jD5ByuIPQKIIXy5ebg0NZWLfxEcIldmAMy9VwqdeqReNWAbdhP6Wfb6z6L0VMBcmP1Byy8HJZmnF+KWBvrFx3VdDIwxWWcLpOcnSUiPIafqklqXGbKMBfCOj2qdLtgEhS6It5SwF+grsEd9LaLmuYZtJRjVHdceO/TTc0mDXJpeMj6HKV99Ra5qPjHxPmxNbgg+WoemZmciunBiX7ZU1gjohAfUCY5fG/0C0Oolv6lRg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021121427099003)(18002099003)(10067099003)(3023799007)(261022113327099003)(22082099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clo5Zk14VTRuS1pXZVFwSEg0eDF3RStaUFRYRS80Y0JVbGhLR0NIYUFlMEpQ?=
 =?utf-8?B?dGJKWVRTQlpYcUtyUTdLaFpseG8xbU5TVldGa0NNeUdrcmhCakVvWng5REF0?=
 =?utf-8?B?bXNBelE3ZFpmanhhSGd6bitlVnVSNERLUWtxcjFtVy9qR296OVV5UzFLaWdw?=
 =?utf-8?B?V2xEc1VTMDlQeVNWenFYcVlZbktaSlBPUUI2WDFscGxrRytOQ1FPTFNrS2Z5?=
 =?utf-8?B?RkE0Y3QzQVhWbHQyemNTL0dwZFpxN1lWUkRLMTJ5VXlCZ25vL1VxNVZwTW16?=
 =?utf-8?B?Q3k1aWo0SlhpQk5UZGhTMWZ1YnFxSVM2M1BCa0FDTzY3NDUxVEx5YndiWElC?=
 =?utf-8?B?eFIvMnp4MUg0Q002RzFMQit2dFJzVHFCQXVHNXF1T2s3QmE3NS9HeUY0Um5Z?=
 =?utf-8?B?bXJLRnFOUHlKL05xOE5SR094UUZXdkwyeTc2UjVZdjliaXdkSUg1eFI4eUtD?=
 =?utf-8?B?ZGFaa3U2Zm5ldGdBWWgvU2ZCUzVGVVdoK1U4Z1lMT1JlN3dERG0vRVpaOWo2?=
 =?utf-8?B?ZWNwVmpMcDVFSGpqZXJCc3VhU0xPalJYdlBPQ1k0Rm1penlncktSbnhTeGRj?=
 =?utf-8?B?bzlBcmo0QW1OMENlV3FHeUJSQWtkZU81SFAzbWx2KzYzd2lJYjRoMnUzNFhU?=
 =?utf-8?B?bnJ6dzA3MGxqVEZraENRTFJXTWozZGJHZWl0Z3l6UDBxU0VuOU1ZWGplOXRU?=
 =?utf-8?B?NjdLaFhjakxZMmUxdzdjeDhCWER6QTI3eWpFak5udnR2WmFZZVEyVDVOOThZ?=
 =?utf-8?B?UjkrWjFUY0NnRzlMdXJiTGprbmlqb01mY1pMWVYzanhqNXFaMzIzcUhtRkE5?=
 =?utf-8?B?RVRsY28rVWd0NFV0a0hTRHcxaVhIbkNaRFBtUmlrL3puU0R1aFAvWS9nN2ox?=
 =?utf-8?B?UXFOSGlodXdodVFVUEJ2dEkxY0xCSTZyaDFad1FqZEJjaVhWWjFTeE55TE5F?=
 =?utf-8?B?Ymh4MTFnYTNNZEtXcDd4d29yREg4aDlhcGl1L1FRUkFuYnB0K0YwejJPNDZv?=
 =?utf-8?B?MllBN0tFTlhvUjc1REpNR05oOGQwTy85SDFxdUlsK2ZSMUQ2azRMVWg3Wm9X?=
 =?utf-8?B?eFV6dHBiSFRQblBONFhnNEtXSm11SnR0dllDRVV5NHZOVkg5eFRla1FSeHR2?=
 =?utf-8?B?Ri9mZUpadEd6a0ppanJHUE9qRmErOWNZY3NpWnJFSHhOVEJ1WjZpTWdwWVpq?=
 =?utf-8?B?VU9oMnBmL3o4MzllL0NKRk0vRWUvM0NSY21QbEkxZGwvRFo3M1VIQms4UUFo?=
 =?utf-8?B?bXB0eStjY1l3WFJVaUpLT2djM0oxNVo3MWxjWWZVSjNObXBjdTBWdHAvdTI3?=
 =?utf-8?B?Z3h3RktJS3oxeThCN0dIMzhBaFFTMWM0MnVOVFl1SDQ3eExheFhYZk5udCs2?=
 =?utf-8?B?aVJ1bzRUWkdHeFByVGg0WFVtYUxmdkZPNUJ5WWFPNVZiaVNSSXZNR1MvSXho?=
 =?utf-8?B?RzBvMzNrNytYeXN3VThEb2Q3c0M4Qk5BNTRmQy9zNzVkanIzMHVmVWxNV3VB?=
 =?utf-8?B?eThrVGR5SXVwbVJERmRpSjN4NG9Fbmcwemc4NXJYYXdwM2dxVkV4VXpESmZs?=
 =?utf-8?B?b3ZiVHdQdHl6WG85QUpKSHN6UFBCT1JjZWhsMCswL0JTOG0wSUFJTTFrNE4r?=
 =?utf-8?B?SjBKWi91UTZXRkU3eUgzTlJRTC9TTjNOa1FWc3J5OC8rbC90VVliWnoybWlF?=
 =?utf-8?B?dURkeDJ1T2tvQXBjelJFOFlYSjFjRzIxZ1VEckNNaW5teDIyQytwWlo5L2da?=
 =?utf-8?B?ZEh4dWFuM1dQcFJGUndtcURFc0dQdU1RVkNJMkcyMEdmUGZRNjIycFo4T1Yw?=
 =?utf-8?B?Y3Y0aFlnY1ExTGVCSk1UaXFaWlNRdHZLa2IrZGd0ZUw1QkkzVUhSYlliNkZJ?=
 =?utf-8?B?b2NrSld3ZEJueGF3NWErTEUrYytQU3VtZ2h0cHdlQkJ0N1N1NFRxazNXWkc1?=
 =?utf-8?B?MExGRUNxRnV2UFhuYS9yQVdlQ2l6alI2L2k5SWFuNEdLZGVHSm5OWjVzZlk5?=
 =?utf-8?B?MkE5cVVadDJmSnJpc2R0RWllczlTczhuSVVFU3ZTMHg2UEZTaktKaVprVzF1?=
 =?utf-8?B?Zll6WkNrWWVkY0YwRVNETTU2QmNWR083NnBlT3dWZkxxRTdsc2xLUE1aZkY0?=
 =?utf-8?B?dzIraWp5aUpreHNLcjkzeEtKWDd0SnJGYjN2M3ZuQnZIWjdZaUxZaDVLWW8y?=
 =?utf-8?B?UDJIVmVidExKSVlPcExYNWNQT00rdzdZRHVWdHdaemhqc2FOK1hzMlBTcUJN?=
 =?utf-8?B?S0pBY3RWR3VQakNObkp4bnJQMjdrMkh3Mmx4QlB0YTVBVUdwKzZxSllzdlFy?=
 =?utf-8?Q?3SrGqtDlM3g8mwrVZc?=
Content-Type: text/plain; charset="utf-8"
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ff519-369a-4a3e-84db-08df310776e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 13:13:43.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUjFsRIgIm/KMdhMHLOOIh5ukzXjfpWZhGxMKjnIVScwyV9llWxgInMzcl+RHkklK+5UNJ6OiCNoz3rMUJ7wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDIwLCAyMDI2IDEwOjA1IEFNDQo+IFRvOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBD
YzogT3ogVGlyYW0gPG96QHNoaWZ0LWNvbXB1dGluZy5kZT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpbW9u
Y2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU3ViamVjdDog
W1BBVENIIHYyIDEvM10gUENJOiBQcmVzZXJ2ZSB0aGUgaW5pdGlhbCBidXMgbnVtYmVyIGluIHBj
aV9kZXYNCj4NCj4gQnJpZGdlcyB0aGF0IG5lZWQgYnVzIHJlYXNzaWdubWVudCBhcmUgc2Nhbm5l
ZCBpbiB0d28gcGFzc2VzLiBTYXZlIHRoZQ0KPiBmaXJtd2FyZSBzZWNvbmRhcnkgYnVzIG51bWJl
ciBkdXJpbmcgdGhlIGZpcnN0IHBhc3MsIGJlZm9yZSB0aGUgYnJpZGdlIGlzDQo+IGRpc2FibGVk
LCBhbmQgY2FycnkgaXQgdG8gdGhlIGJ1cyBjcmVhdGVkIGluIHRoZSBzZWNvbmQgcGFzcy4gSW5p
dGlhbGl6ZSBwY2lfZGV2DQo+IGZyb20gdGhpcyBwcmVzZXJ2ZWQgYnVzIG51bWJlciBzbyBkcml2
ZXJzIGNhbiBtYXRjaCBmaXJtd2FyZSByZWNvcmRzIGFmdGVyDQo+IFBDSSBidXMgcmVudW1iZXJp
bmcuDQo+DQo+IEhhbmRsZSBwY2lfYWxsb2NfZGV2KE5VTEwpIGFzIHdlbGw7IHNvbWUgaW4tdHJl
ZSBjYWxsZXJzIHVzZSBpdCB0byBhbGxvY2F0ZSBhDQo+IHN0YW5kYWxvbmUgcGNpX2Rldi4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFt
ZC5jb20+DQoNCkxvb2tzIGdvb2QgdG8gbWUuICBQYXRjaCAxIGlzOg0KQWNrZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KUGF0Y2hlcyAyLCAzOg0KUmV2
aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KSSBk
b24ndCBoYXZlIGEgcHJlZmVyZW5jZSB3aGljaCB0cmVlIHRoZXNlIGdvIHRocm91Z2gsIGFzc3Vt
aW5nIEJqb3JuIGlzIG9rIHdpdGggdGhlIFBDSSBjaGFuZ2UuDQoNCkFsZXgNCg0KPiAtLS0NCj4g
IGRyaXZlcnMvcGNpL3Byb2JlLmMgfCA5ICsrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9wY2ku
aCB8IDMgKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jIGluZGV4
DQo+IDI3MDA4ZTJlYTVhZmMuLjRlY2U0YjcwY2RjMTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGNpL3Byb2JlLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiBAQCAtMTAxMiw2ICsx
MDEyLDcgQEAgc3RhdGljIGludCBwY2lfcmVnaXN0ZXJfaG9zdF9icmlkZ2Uoc3RydWN0DQo+IHBj
aV9ob3N0X2JyaWRnZSAqYnJpZGdlKQ0KPiAgICAgICBidXMtPnN5c2RhdGEgPSBicmlkZ2UtPnN5
c2RhdGE7DQo+ICAgICAgIGJ1cy0+b3BzID0gYnJpZGdlLT5vcHM7DQo+ICAgICAgIGJ1cy0+bnVt
YmVyID0gYnVzLT5idXNuX3Jlcy5zdGFydCA9IGJyaWRnZS0+YnVzbnI7DQo+ICsgICAgIGJ1cy0+
aW5pdGlhbF9idXNfbnVtYmVyID0gYnVzLT5udW1iZXI7DQo+ICAjaWZkZWYgQ09ORklHX1BDSV9E
T01BSU5TX0dFTkVSSUMNCj4gICAgICAgaWYgKGJyaWRnZS0+ZG9tYWluX25yID09IFBDSV9ET01B
SU5fTlJfTk9UX1NFVCkNCj4gICAgICAgICAgICAgICBidXMtPmRvbWFpbl9uciA9IHBjaV9idXNf
ZmluZF9kb21haW5fbnIoYnVzLCBwYXJlbnQpOyBAQCAtDQo+IDEyMzIsNiArMTIzMyw3IEBAIHN0
YXRpYyBzdHJ1Y3QgcGNpX2J1cyAqcGNpX2FsbG9jX2NoaWxkX2J1cyhzdHJ1Y3QgcGNpX2J1cw0K
PiAqcGFyZW50LA0KPg0KPiAgICAgICAvKiBTZXQgdXAgdGhlIHByaW1hcnksIHNlY29uZGFyeSBh
bmQgc3Vib3JkaW5hdGUgYnVzIG51bWJlcnMgKi8NCj4gICAgICAgY2hpbGQtPm51bWJlciA9IGNo
aWxkLT5idXNuX3Jlcy5zdGFydCA9IGJ1c25yOw0KPiArICAgICBjaGlsZC0+aW5pdGlhbF9idXNf
bnVtYmVyID0gYnVzbnI7DQo+ICAgICAgIGNoaWxkLT5wcmltYXJ5ID0gcGFyZW50LT5idXNuX3Jl
cy5zdGFydDsNCj4gICAgICAgY2hpbGQtPmJ1c25fcmVzLmVuZCA9IDB4ZmY7DQo+DQo+IEBAIC0x
NDcwLDYgKzE0NzIsNyBAQCBzdGF0aWMgaW50IHBjaV9zY2FuX2JyaWRnZV9leHRlbmQoc3RydWN0
IHBjaV9idXMNCj4gKmJ1cywgc3RydWN0IHBjaV9kZXYgKmRldiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgIGNoaWxkID0gcGNpX2FkZF9uZXdfYnVzKGJ1cywgZGV2LCBzZWNvbmRhcnkpOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKCFjaGlsZCkNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBvdXQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICBjaGlsZC0+aW5pdGlh
bF9idXNfbnVtYmVyID0gc2Vjb25kYXJ5Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgY2hpbGQt
PnByaW1hcnkgPSBwcmltYXJ5Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgcGNpX2J1c19pbnNl
cnRfYnVzbl9yZXMoY2hpbGQsIHNlY29uZGFyeSwNCj4gc3Vib3JkaW5hdGUpOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgY2hpbGQtPmJyaWRnZV9jdGwgPSBiY3RsOw0KPiBAQCAtMTQ5MSw2ICsx
NDk0LDggQEAgc3RhdGljIGludCBwY2lfc2Nhbl9icmlkZ2VfZXh0ZW5kKHN0cnVjdCBwY2lfYnVz
DQo+ICpidXMsIHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+ICAgICAgICAgICAgICAgICogZG8gaW4g
dGhlIHNlY29uZCBwYXNzLg0KPiAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgIGlm
ICghcGFzcykgew0KPiArICAgICAgICAgICAgICAgICAgICAgaWYgKCFkZXYtPmluaXRpYWxfc2Vj
b25kYXJ5X2J1c19udW1iZXIpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+
aW5pdGlhbF9zZWNvbmRhcnlfYnVzX251bWJlciA9DQo+IHNlY29uZGFyeTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgIGlmIChwY2liaW9zX2Fzc2lnbl9hbGxfYnVzc2VzKCkgfHwgYnJva2VuKQ0K
Pg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiBAQCAtMTUyNiw2ICsxNTMx
LDkgQEAgc3RhdGljIGludCBwY2lfc2Nhbl9icmlkZ2VfZXh0ZW5kKHN0cnVjdCBwY2lfYnVzDQo+
ICpidXMsIHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICBjaGls
ZCA9IHBjaV9hZGRfbmV3X2J1cyhidXMsIGRldiwgbmV4dF9idXNucik7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoIWNoaWxkKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIG91dDsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChkZXYtPmluaXRpYWxfc2Vjb25k
YXJ5X2J1c19udW1iZXIpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoaWxkLT5p
bml0aWFsX2J1c19udW1iZXIgPQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRldi0+aW5pdGlhbF9zZWNvbmRhcnlfYnVzX251bWJlcjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgIHBjaV9idXNfaW5zZXJ0X2J1c25fcmVzKGNoaWxkLCBuZXh0X2J1c25yLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVzLT5idXNuX3Jlcy5l
bmQpOw0KPiAgICAgICAgICAgICAgIH0NCj4gQEAgLTI1MDgsNiArMjUxNiw3IEBAIHN0cnVjdCBw
Y2lfZGV2ICpwY2lfYWxsb2NfZGV2KHN0cnVjdCBwY2lfYnVzICpidXMpDQo+ICAgICAgIElOSVRf
TElTVF9IRUFEKCZkZXYtPmJ1c19saXN0KTsNCj4gICAgICAgZGV2LT5kZXYudHlwZSA9ICZwY2lf
ZGV2X3R5cGU7DQo+ICAgICAgIGRldi0+YnVzID0gcGNpX2J1c19nZXQoYnVzKTsNCj4gKyAgICAg
ZGV2LT5pbml0aWFsX2J1c19udW1iZXIgPSBidXMgPyBidXMtPmluaXRpYWxfYnVzX251bWJlciA6
IDA7DQo+ICAgICAgIGRldi0+ZHJpdmVyX2V4Y2x1c2l2ZV9yZXNvdXJjZSA9IChzdHJ1Y3QgcmVz
b3VyY2UpIHsNCj4gICAgICAgICAgICAgICAubmFtZSA9ICJQQ0kgRXhjbHVzaXZlIiwNCj4gICAg
ICAgICAgICAgICAuc3RhcnQgPSAwLA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2ku
aCBiL2luY2x1ZGUvbGludXgvcGNpLmggaW5kZXgNCj4gNWZmY2Y1Y2U4Yzk2Ni4uZjZiMzc3ZGNm
N2ExNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wY2kuaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L3BjaS5oDQo+IEBAIC0zNjMsNiArMzYzLDggQEAgc3RydWN0IHBjaV9kZXYgew0KPiAg
ICAgICBzdHJ1Y3QgcGNpX3Nsb3QgKnNsb3Q7ICAgICAgICAgIC8qIFBoeXNpY2FsIHNsb3QgdGhp
cyBkZXZpY2UgaXMgaW4gKi8NCj4NCj4gICAgICAgdW5zaWduZWQgaW50ICAgIGRldmZuOyAgICAg
ICAgICAvKiBFbmNvZGVkIGRldmljZSAmIGZ1bmN0aW9uIGluZGV4ICovDQo+ICsgICAgIHU4ICAg
ICAgICAgICAgICBpbml0aWFsX2J1c19udW1iZXI7ICAgICAvKiBCdXMgbnVtYmVyIHdoZW4gZGV2
aWNlDQo+IHdhcyBkaXNjb3ZlcmVkICovDQo+ICsgICAgIHU4ICAgICAgICAgICAgICBpbml0aWFs
X3NlY29uZGFyeV9idXNfbnVtYmVyOyAgIC8qIEJ1cyBudW1iZXIgYmVoaW5kDQo+IHRoaXMgYnJp
ZGdlICovDQo+ICAgICAgIHVuc2lnbmVkIHNob3J0ICB2ZW5kb3I7DQo+ICAgICAgIHVuc2lnbmVk
IHNob3J0ICBkZXZpY2U7DQo+ICAgICAgIHVuc2lnbmVkIHNob3J0ICBzdWJzeXN0ZW1fdmVuZG9y
Ow0KPiBAQCAtNzI0LDYgKzcyNiw3IEBAIHN0cnVjdCBwY2lfYnVzIHsNCj4gICAgICAgc3RydWN0
IHByb2NfZGlyX2VudHJ5ICpwcm9jZGlyOyAvKiBEaXJlY3RvcnkgZW50cnkgaW4gL3Byb2MvYnVz
L3BjaSAqLw0KPg0KPiAgICAgICB1bnNpZ25lZCBjaGFyICAgbnVtYmVyOyAgICAgICAgIC8qIEJ1
cyBudW1iZXIgKi8NCj4gKyAgICAgdW5zaWduZWQgY2hhciAgIGluaXRpYWxfYnVzX251bWJlcjsg
ICAgIC8qIEJ1cyBudW1iZXIgYmVmb3JlDQo+IHJlYXNzaWdubWVudCAqLw0KPiAgICAgICB1bnNp
Z25lZCBjaGFyICAgcHJpbWFyeTsgICAgICAgIC8qIE51bWJlciBvZiBwcmltYXJ5IGJyaWRnZSAq
Lw0KPiAgICAgICB1bnNpZ25lZCBjaGFyICAgbWF4X2J1c19zcGVlZDsgIC8qIGVudW0gcGNpX2J1
c19zcGVlZCAqLw0KPiAgICAgICB1bnNpZ25lZCBjaGFyICAgY3VyX2J1c19zcGVlZDsgIC8qIGVu
dW0gcGNpX2J1c19zcGVlZCAqLw0KPg0KPiAtLQ0KPiAyLjQzLjANCg0K
