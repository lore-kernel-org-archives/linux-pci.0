Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9454265606;
	Tue,  7 Apr 2026 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539294; cv=fail; b=YTdgBCRXOMPt0vSuyyWGj31b+6hxzNU37PdWghMETmv0HDSQoxEVpVk029Y1cTTwDkM2CnmtF42MZWd0rCRoRhGSZLCuScBEAaPTeZ6ZnubVy5B+PMgXZ+dNzQvwTFbcDSBnCmZtMyuyuNynHs4rv3ivJ5OIYfxhOqMjVVDhyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539294; c=relaxed/simple;
	bh=3A0aks/GGfQF2wHyZadhDHqWBmIzGqEp2lQytiWQ1PQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VM/8FD4+4OOXJibGSo+nT3D15palkwb1FNQyi7JOj+PjenBnN+nDmyPi6VKn4q8K3TA8QdCAL49lqMacK05j9mAX14n7WFEA/GrhmwZQhVxI+oDSAhXXmHBLt13xX9dLfWP32hdCKTqThAqP07mhaA95czgVPN1KmFO9w4SUNKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=QgmxCKCM; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=vzEIUwe3; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QgmxCKCM";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="vzEIUwe3"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LV7Qw1560008;
	Mon, 6 Apr 2026 22:21:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=3A0aks/GGfQF2wHyZadhDHqWBmIzGqEp2lQytiWQ1PQ=; b=QgmxCKCM4pzf
	czz7zu23id/nmZS3BO5VUpDOe9amf2NqdxGg7RuPwcC4rnyNN4CsYJ0lIGCksVgT
	yqihFrROxeSAoqBV3aERPSqgRoUI1tGHlQ4alMe8K8wz1XuMZHp+QB7kikKZ0a0j
	n1ZABpk9j8om/If8AX6I2O8ZuBVWPFKD9qch/W8HljGK9tFvwtt6ktYWH4/vTxEx
	FYIdq4TLSNW80ItiNrInQ/1+2PrPo4OCrfzmHM/qH+5q2aNDco3kj/d8ZJGu8lST
	aQ5g1CDTZltoKMGqjJpxylG3/JvZTt4+E4BtUyU6RN6Z/4CuKmfG09RaUY30d0Xa
	VbTV9GJ49g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4dcmtkhanq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 22:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwP4Q50hX3aU4nE+4pHTG90DWzcS5Ws0ArIOA1MTAyK7Pka5Vhb3Yh8U9vTe7yqkjbVnbkDvQD89Eb9IqIAO/dIxAIUJuNsFQJFFukhqW6/o3O65Oyx75O0BeKf7KR+AmU1sKQgbibNdMH68HEcpLPxIBdyT3eN2A3I1VpF26pYVg5DxyzOZ9WncjBNa1p0wn65z0f15kA27GjsSD82H9tA41OvzGoaPIiA6x8q/+krpz9w6Y8g6HCezmd90bgcqhvJzsiPbF9+HVIBeoD+Yb68bFKlIYOjO/8vrdU0qB5fMbfhsIXdHYeQoi+X9iQ5OFkZj2RyAjyRTiw5iULvhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A0aks/GGfQF2wHyZadhDHqWBmIzGqEp2lQytiWQ1PQ=;
 b=sDDGLqCgqgK+PEBPM3tWtn+57Yn9JcU+kzB19MibI0q4LUA96BqEQHs2kzI/HB7Dduu8Eq6/ft7o7t59j1DYOhTXpnaHSh7wxFha/Sp589u+Y48AprNqhbiipPw4B0eZ2nQ+rK1/Zi9sH6nJKj/8rfIRQau2oO5pOgjYOuqGstduvu2bRZZpa5da1yXayFRFZWbaS4MsNdlzBs62iav9y5+sfo2YqvLYWsLrX+dhqK2vFtLxT1PUEFiLwVPuD41zzhXdEIAuPI0iUIDOknfUu9L/dLUDwTVvE0X/m1TOe4pGu48O8l7dCvGj6gURtG5zGuqDHg5KDIiUehfQ2+OLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A0aks/GGfQF2wHyZadhDHqWBmIzGqEp2lQytiWQ1PQ=;
 b=vzEIUwe3Lxd+M0v3F6AJGov4FX/tszCltpXjZSDPaA1/IpZZ6ixkQQoE9+r+/+Y5AiH+/mjWQ1cOmJEZHI0qJe6NAzuf4FrMnjRoHbewui3u+EXsO+5lsrI7oAtdSt0+xbB8PODrlBvMgBLDlp0Wrr8ixsOVMebr2uXwLsBTL3n2xR39YmDQ67tQD4Tzsqsma1EHYisym7GQp0fJ7VsIlVlD3y1hF5SZdwkGYTDGia32xkguciq+7bUMDnfst/kGGbtRhkbHEkX2Yp4Iz6maVG/3xDu+4PFc6pTeJpqQ4SOhAYcEESLsnNszxdapzJLREMbFSeY2aJ/73eFhBtyfDw==
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ2PR07MB9782.namprd07.prod.outlook.com (2603:10b6:a03:4f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 05:21:11 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe%7]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 05:21:11 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Add support for device-only configuration
Thread-Topic: [PATCH] usb: cdnsp: Add support for device-only configuration
Thread-Index: AQHcwOUhI/23tYTDOUOAW3Qn/4Y8erXM24OAgABLkkCABCFoAIAB0C9w
Date: Tue, 7 Apr 2026 05:21:11 +0000
Message-ID:
 <PH7PR07MB953888B79B71702A9A7F74F0DD5AA@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20260331-device_only-v1-1-00378b80365c@cadence.com>
 <ac9WnY5C+yTVi0X/@nchen-desktop>
 <PH7PR07MB9538FCAFEBF0072EA5B5B815DD5EA@PH7PR07MB9538.namprd07.prod.outlook.com>
 <adMNBsPYNg497Doa@nchen-desktop>
In-Reply-To: <adMNBsPYNg497Doa@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ2PR07MB9782:EE_
x-ms-office365-filtering-correlation-id: 7f1ece50-80d9-4332-68b9-08de94657b78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 OEBzFXjL1jP/S0YNmvNzgou0AzJa7332jsR0tCEgwUZttOqG/mBpIMgkPPyrgq1o6Y3lKXSdT46xWjfvohqKHNY8uTmouBQ5Zyaw/hv5BPEqQGD3EdjN1d6BG5bC/nPCMHk4e1BhObTPdBLovih84cCFLNw1k3WUMmcy1d3ZsPht63N3v4mHlqdlp9ktiXuTi35fA42hIHwYqTXZmhK+19avQuuI2CbUYUlRlWHgQ18BJYhd2Zhy4Tc+pcYN22m1bnaKL/WN7PtuemB0LPZ+qt5QdaWclzBjkx6F75rloA1YAe/83xn41eApYtN5UjXf5wTxiO87Y16yCaSpZe/O0C+tSOTDz5VuBX/RatZEsyPLk0oYry4eTcAC0tPKDOhlskAZkFk/BPzP4LCJ+KaVcFu7NNoiLnq5YPKR9KRC5Y6OhifwMeFXebYofd2LPqrJcSy5k9pg5lU7b1YJZDg1P0nrNXRwQl+9L8es3Ix2WfM7xI7rfCrGe4NVuhiAtgP+3bM9r+Z7hgUW+KifaBaHNxqhStAECC7OieJ1GmlcU9nwraqZgF8N5ZE9XJD9mytpdtIn6s43k1SeBUBiFLMwaQUcGU8h/jf6L9ZN7inpIcnBGrtV5vW6chWmOM8QLntizhY7hNyr20GrKnG3j5z/LIDuUqKHmA+6FjYwWwXumsPlJxMLP40mRm8JkQfRdC0dIuX8FgmPA/yarzVaOM2U+Z0PFNm2utuYmoafL1CoXokHX2B/2Y/r3Fg1OrgFgV5wg7iX8Jgdus93VKSMhqKR6DSWa6IEXd+UzLXvUJ939YM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFRFVUpIczArVUR6K0lJdVhJYlB6c3h6QXhkZDV6REFWQTI5UTlRL1p6ZDBz?=
 =?utf-8?B?MUFBckc3WG5lelBRdlpLOG9ZR1JVZGNVTnA4akY5Uy9XZG52MmIxSDh6K2w5?=
 =?utf-8?B?TkIxKzl2ZTJoRVg0cUdQdVl1RE10QjMyaWNuV29lVGhwczNXdDNKWkRFMGls?=
 =?utf-8?B?eWcyRnRFNHIyVUQwSnFhNVdxZU13aGM4Z21HdDNJWDJHVEdHMlFFSU5vdUVO?=
 =?utf-8?B?aE9uclNDZU5Nay9KTXJrN3RqV3l4WkwyZy8yUGxST0RrRjlGc2ZHZG56YmIr?=
 =?utf-8?B?Z3RrdjhiUUF0c29HeHJDVEQ1ZmtCSmU5a1JiQ0N3TWt2NjV1NDNuQXAvRHkw?=
 =?utf-8?B?Mm8zdk5DLzlUeEhTaWJZdGptQlVvcUZQN0xheHdCZk5mejJ3SnQ3UmJLY0JT?=
 =?utf-8?B?MFRtNjBqZDQxcjBFdlNIMXJMamg2SVRWOEE2ZU1aSGFMczM4YUg0RG9CSlYz?=
 =?utf-8?B?UEZkSDRVczQ4U01keWxSVjZPVFp3OFRZK0VMVFVPR0V6ZXpIN043K3Bwc3Qr?=
 =?utf-8?B?Q1VmL2RiaURhVStyc2t5NU9LeEFEVjZ2aDhWaTNuVFMycko3blRhWG9zMVg1?=
 =?utf-8?B?ZGdObnc4MHNtWDhtSDZxODAxOC9VYTZTckVmaUlPcjY5N2F2aDduWFl4VHRy?=
 =?utf-8?B?bGkvSlFwRGZGTEFJNy9CMGxiVjFPVmV1SVMyL1ZaQ3JCZ0oxUC9IejZINTlF?=
 =?utf-8?B?Q0NidmNaOFJ4QkFzQ0VFZ3YzVGs5S2JXV3RSNVVMTnRzbEp2dkR6VDJZcmFa?=
 =?utf-8?B?QThmdTZjTmplNnFxTXk5MjhnZWdMVmowaGt6dHY4eXFyODBsRVdDc3BjN2ZX?=
 =?utf-8?B?UjcwWjNycDNqd3BOR3NnNlRBdmhmR2dVdVpEdmVOeFZ3K3Z3VGVmTDZPSW1R?=
 =?utf-8?B?ZmN1V2tzeUNhS1Exa3gvR21sdFlyc2FmUzdjRXoxbUJpN0ZoZS9OSnNvWmdk?=
 =?utf-8?B?ZURTZnJpNUJ2RnpIYVpUQlFJMHoxNGtrSW9GUWFPV0p6Zk5uNHFZTngvNkc2?=
 =?utf-8?B?TUFMZDV5SXFZUkpsb3NrWW43cm1DVlU1N01LalQ4SWxNZFduZzBjTmtlZld6?=
 =?utf-8?B?ckh5NjAzejZjeVBnS3FNVXhpYlV2MVFyRFZrNm85MU9QTzZ3M1BIQVlSRzU4?=
 =?utf-8?B?UGJ2NTkzYnVYUGhmMVJSN2poTHlMazRKOUZCekZqb1BXTDdXRUZhc0luY2d1?=
 =?utf-8?B?ZU9pTkgzeWVMUFQ3Qk5lMVJVVUY3WlpMYVBlRzFUMExCandWVHBpMk41aXpJ?=
 =?utf-8?B?d1hFaDRxNGcvN1IyY0FCR1BCY1BLU0luVDc4SjBpNkFHUU4vZzg4cWJSQnF6?=
 =?utf-8?B?OFZVa1hNdUx1Tm1YcjhjMFlhckEwT0k0b1RZZThoVy9OaldsczBKbVVBYThK?=
 =?utf-8?B?UUtJMjNCSFZrUXM2aEZXWkpzQ2t1YkVUSEt5K04xblQyZGVzZ3FYRGZpME1a?=
 =?utf-8?B?cElZbEd5ZDVOaWNwMWREeVl2b2Jsbk1LUjhBWTBQc3ZKVldwR0RyYzlpMmRy?=
 =?utf-8?B?eU00NlJDZTJHbzY1U0U4UDRLMmhGUmdBZ2FwL3VKVzdCNHlBM1M5MkptUkYx?=
 =?utf-8?B?NUZxSG83T1MxY0VUQ3JaZVR4ZnE4dGR1b25TZUFwVi9GNzhacFlwTThFTlRB?=
 =?utf-8?B?VDVLdlNoT0d1UVJKS1pBaGN5bUl3amRRZTJVTmJ1aDhQVWVocThQWThDRlZy?=
 =?utf-8?B?VmRXMEFNT3phS3REMmk1dyswaEtRbXR4dVcyUE92YmNMbmQvZXRLRUFTRnRT?=
 =?utf-8?B?eGtVM3hxYkM3ZC9vcXE2d0Q5L3RwVEh3TC90d1R1N3VNWXRRdFVvL004dCt6?=
 =?utf-8?B?VWQ1dGJucy8zSkZsbzBXcnQ1NWkvRFJuZ0l6dlo0VUEvMGNjWmQzRmV6Skgw?=
 =?utf-8?B?bGF4cUVyK3cxZTA1cGdTeE5yYnBWWVdpZGxONXJsN09mUmVxRE9aeEdnUS9G?=
 =?utf-8?B?U1Y2U1p4bWZ5NEFCaDNiZXlhZks1TnYrVEQ1SHFGS1U4WFdMSUNnVm9mV0FC?=
 =?utf-8?B?ZUpFd0d4ZDE3VzV2anZCOUY2VGNrS0ltNWtBZG1KQmV0V0JvWFlWbkwybHZZ?=
 =?utf-8?B?ZkdxbXRZWWd6R2U2Qkx3WlVKN1BzNTJEaW1jZ0dZOWZQWTRua2R6NWdmUUhG?=
 =?utf-8?B?UkJBbzVHamkwTElpSVVkSGZJMHRtQXZXL2s0eUpZUXZnZGozdjR6Vzl6STVN?=
 =?utf-8?B?RitqRGNINlBwTnU2ZGs3MDk4Q0dsMlpqS0RQOXpWbGlPeG56Mlg2VnZJNnla?=
 =?utf-8?B?ZzR3eXRwa000dE8waWVpSjZjMytKYWROMENpamtOOGllaXZOY1BKWS9Eazdz?=
 =?utf-8?B?MjRVWkNwZENkS2F0ZzQ4TDlFVlBaWWs0STZGd3ZrS3MvMzlFeUd4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nfF2Kh2qY1ut45yuzkaY+8idemUtOeVlOJAAFUCKePANFpBRfVsgm2/BvOdeUJlh1NSw4dG5cncJZY40rJweX2xNTDMooXzKukkmkC8E12JEnMHJZuvBjyBH7p6WkwEjSAkvAsUvaDGMCHI1IPEzbWmeqmlcYOXzv/a4LXUmy/VvxzQGBuT3xDVLxJtBU2gOGt3vvAoyR1SQ/7WCZqZ1lrl3DIMgEenR2T8i/tDVYQU2mDe2xGPYDPGxX12+b33t1pIAojgnvhZFt3sBtDEWBvB/1rOuTNxeerccEWKOSLdlKdC92FvhtgX8w7Y0Y4CZEyTj2FruGK3o5BwHLkgm4Q==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1ece50-80d9-4332-68b9-08de94657b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 05:21:11.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRdqTVuTdLfcObS7//Z+LctFABT7cI7lZCttMVJ0b8JmYV8g0RmBt5QKon/pXzyEWAG/lITXHSbUhksItM9DeQ6JRAuNL4qdaw3jYgtknVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR07MB9782
X-Proofpoint-ORIG-GUID: yj4MGRSl3wXJ8sHiRcXbkboy_OtyKkHV
X-Proofpoint-GUID: yj4MGRSl3wXJ8sHiRcXbkboy_OtyKkHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OCBTYWx0ZWRfX+NHBgKPxWerE
 fRxE/m+7zKzuzOGO09XIgCSeQcgtr/zeT3R43Jf/UywFY+COQDARTL11CIK6RwjjggSXxoD7jp+
 8/FCrAT8FLVOXlZHnSaLqkUr/YomH2/60j0T2y7Px05HwDxHBnZ1w97VH9a0XD+IpmjzIIh8Lyk
 gbdOW7ORkOeQT+QYrgMai7N/k4XOxi4axQIrOakcDrEU0yMD424mG05uWnvLA3a9BoFy0OJCQeC
 176zOd0hBExQv5NRqPpr/EODPradVgfrNHGeCj60xbDQ8qrCBhnt9s6XV4qe3VYrUZ67/b+QsZa
 tnO3Mi334BbW4sWwBO8j8jTyWhr1Wut10gBUHjsMQ3wd3eqgN2sJduYjJhNsn8swCFJNOEydAt5
 bhSLcF3xMJr9p5MJ597hgf9kcGqQbqYP8VmMuVUs7JLZpgzGqDGU+/N2Zru6rXp5Sr89dX5EJda
 yJw7kji4YiHDE8P3y3Q==
X-Authority-Analysis: v=2.4 cv=B9KJFutM c=1 sm=1 tr=0 ts=69d4944a cx=c_pps
 a=WwHAhc24fKszT02xmrP0gg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=Br2UW1UjAAAA:8
 a=HOdmW1LoGxqYk44FqhIA:9 a=QEXdDO2ut3YA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070048

Pg0KPg0KPk9uIDI2LTA0LTAzIDEwOjMzOjUyLCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4+ID4+
DQo+PiA+PiArCWlmIChjZG5zLT5ub19kcmQpIHsNCj4+ID4+ICsJCWNkbnMtPnZlcnNpb24gID0g
Q0ROU1BfQ09OVFJPTExFUl9WMjsNCj4+ID4+ICsJCWNkbnMtPmRyX21vZGUgPSBVU0JfRFJfTU9E
RV9QRVJJUEhFUkFMOw0KPj4gPg0KPj4gPldpdGggIm5vX2RyZCIsIGFyZSBjb25maWd1cmF0aW9u
cyBmaXhlZCwgbm8gb3RoZXIgb3B0aW9ucz8NCj4+DQo+PiBZZXMsIG5vIG90aGVyIG9wdGlvbi4N
Cj4NCj5JcyBpdCBwb3NzaWJsZSBmb3IgaG9zdC1vbmx5IGNvbmZpZ3VyYXRpb25zPw0KDQpUaGVv
cmV0aWNhbGx5LCB5ZXMsIGJ1dCBmb3IgYSBob3N0LW9ubHkgY29uZmlndXJhdGlvbiwgd2Ugd291
bGQgdHlwaWNhbGx5DQp1c2UgdGhlIGRlZmF1bHQgeEhDSSBkcml2ZXIgaW5zdGVhZC4gU2luY2Ug
dGhlcmUgaXNuJ3QgYSBzZXBhcmF0ZQ0Kc3RhbmRhbG9uZSBkcml2ZXIgZm9yIGRldmljZS1vbmx5
IG1vZGUgaW4gdGhpcyBJUCwgdXNpbmcgbm9fZHJkDQp0byBmb3JjZSBwZXJpcGhlcmFsIG1vZGUg
bWFrZXMgdGhlIG1vc3Qgc2Vuc2UgaGVyZS4NCg0KUGF3ZWwNCg0KPlBldGVyDQo+DQo+Pg0KPj4g
UGF3ZWwNCj4+DQo+PiA+DQo+PiA+PiArCQlyZXR1cm4gMDsNCj4+ID4+ICsJfQ0KPj4gPj4gKw0K
Pj4gPj4gIAlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGNkbnMtPmRldiwgJmNkbnMtPm90
Z19yZXMpOw0KPj4gPj4gIAlpZiAoSVNfRVJSKHJlZ3MpKQ0KPj4gPj4gIAkJcmV0dXJuIFBUUl9F
UlIocmVncyk7DQo+PiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2lfaWRzLmggYi9p
bmNsdWRlL2xpbnV4L3BjaV9pZHMuaCBpbmRleA0KPj4gPj4gNDA2YWJmNjI5YmUyLi5hOTMxZmIy
MDE0MDIgMTAwNjQ0DQo+PiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaA0KPj4gPj4g
KysrIGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgNCj4+ID4+IEBAIC0yNDI0LDYgKzI0MjQsNyBA
QA0KPj4gPj4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9DRE5TX1VTQlNTCTB4MDEwMA0KPj4gPj4g
ICNkZWZpbmUgUENJX0RFVklDRV9JRF9DRE5TX1VTQgkJMHgwMTIwDQo+PiA+PiAgI2RlZmluZSBQ
Q0lfREVWSUNFX0lEX0NETlNfVVNCU1NQCTB4MDIwMA0KPj4gPj4gKyNkZWZpbmUgUENJX0RFVklD
RV9JRF9DRE5TX1VEQ19VU0JTU1AJMHgwNDAwDQo+PiA+Pg0KPj4gPj4gICNkZWZpbmUgUENJX1ZF
TkRPUl9JRF9BUkVDQQkJMHgxN2QzDQo+PiA+PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX0FSRUNB
XzExMTAJMHgxMTEwDQo+PiA+Pg0KPj4gPj4gLS0tDQo+PiA+PiBiYXNlLWNvbW1pdDogNTE5NmYy
Yzk4MzQwMjk3ZTFmZGQzNjU1NTI4NWU5OTFjZWRkZjc3Ng0KPj4gPj4gY2hhbmdlLWlkOiAyMDI2
MDMzMS1kZXZpY2Vfb25seS0xOTJkNTM5NDMwYjUNCj4+ID4+DQo+PiA+PiBCZXN0IHJlZ2FyZHMs
DQo+PiA+PiAtLQ0KPj4gPj4gUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+
ID4+DQo+PiA+Pg0KPj4gPg0KPj4gPi0tDQo+PiA+DQo+PiA+QmVzdCByZWdhcmRzLA0KPj4gPlBl
dGVyDQo+DQo+LS0NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+UGV0ZXINCg==
