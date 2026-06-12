Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7729343D86;
	Fri, 12 Jun 2026 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237018; cv=fail; b=GnqwZGKqiuNjHBGWLE10UTf9v3u17QEzHhfMIKR5NqevGNNi9dTnl/LAOwkXgnDoPPROSy0r7Fwrh8aSTk6TdB3ARi7TaMY9uEYx5W55SkhJYi5mrFh3Z1wEXf3oR4wIlC9LIwizsfkZxPq5A2dvsvYdkx3Q2RlXVc8jkiMBQss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237018; c=relaxed/simple;
	bh=yyEkmoohp3n25/yg+IE6rxQifdQzqqCMv7htsFMtzXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gt2vqKpzcsB1ODI4vdTiQApLNX9Mt5a6Hgc5PrzgIxZHzQKoGkQwYf4i5ggGpL/LV06Q47W2yKlkZAqgwKsQk/FBHzZRs76t3nCZKhNqyMJBbWmsOzKkSNu+3J2ToO5P0nM3+pF/exuoejdgTXGTLoVmo7PpgEyKTBTaf0oG8Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mn10PCBU; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mn10PCBU"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3AOeG071008;
	Thu, 11 Jun 2026 21:03:28 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020118.outbound.protection.outlook.com [52.101.61.118])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vwv86-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 21:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLIiTbnSxRYrjsLRwGgQJmJfAaLAzMfOoB6qDFh4wZVC56hYjcPSwuqwLBetqIs0CIIZ6wy3uXl4NBudbHZPtjk3PHv0C2wzaSw+ztquLCqrpRehTUcIFIZamI3AQlnuCAe3i9pPgIOrwapm1BnpZGvgYBxOu9W48ZbhCopi/GzvE60TwKMlDs4hmW6xRG4i6CewdMobPG6A1qCe5Eks0e4SDgvT58rEDRpFsybEcMc79iMGTXKry3K4LDPs3/tDfU2RCDVoG6/zU+/Lf2Joq6ZJ5hSIZn/DPhNc+GVjb8ldov3nIOb9RP2tbBBd3TzZmsz520+lu5SxruKyp0qsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyEkmoohp3n25/yg+IE6rxQifdQzqqCMv7htsFMtzXY=;
 b=Ra195VPR72+XGHLworc6duKFX/wxfhzbCdgevZ/KZnBih/TW2d36cFjy54hE5mjw/1YJGbKpHn9YYKUN85XxQuOXJn1t+ef738cLJPYDlmkbrT+UbESHSQQ0oCnXYmqfuZVllfh79qGFLc8uC2+rGJFz3KpWpSvYpNEGEKsCeFRRIQ5H/54Qo/dvmeHDmVmks1U71lkhVWVCnOFWXxVR346/WNcgxEbCu9F2YhKbRMFayokGQyuxODrjCTDjnY4/xt5Fvg02FSQkELrV95MMZAaof1wkXU+EcsyOi/8S39JYPeZvWbNrSajRDL2PT1n1BcnlZjhGH3xgUztMhOmuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyEkmoohp3n25/yg+IE6rxQifdQzqqCMv7htsFMtzXY=;
 b=mn10PCBUMBC9RBN1V7s0tA9/DuFWjTP9zboPhwBBZm0llV+tAefmTWtIe5JbE6jM32PyOfKH6purh9DE5RPsHF3+A5YZeQv5c4WYL+KtLgfAfuw6bym17oAduN50ObEH84dSMWw+UYrE7dfeugVlXhapjP9zPUsXMPQhoIX+0SI=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by SN4PR18MB988514.namprd18.prod.outlook.com (2603:10b6:806:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 04:03:25 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::48b4:4ff8:d5f4:a49a]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::48b4:4ff8:d5f4:a49a%5]) with mapi id 15.21.0092.011; Fri, 12 Jun 2026
 04:03:25 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "bjorn@helgaas.com" <bjorn@helgaas.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "will@kernel.org" <will@kernel.org>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>
Subject: RE: Re: Re: [PATCH v2] PCI: host-common: Request bus reassignment
 when not probe-only
Thread-Topic: Re: Re: [PATCH v2] PCI: host-common: Request bus reassignment
 when not probe-only
Thread-Index: AQHc3QKBrc74cXnvwkeJkqw+7UbM0rY6hMUA
Date: Fri, 12 Jun 2026 04:03:25 +0000
Message-ID:
 <MN0PR18MB584758C9286C78B6EE947FE7D3182@MN0PR18MB5847.namprd18.prod.outlook.com>
References: <20260414081730.3864372-1-rkannoth@marvell.com>
 <20260504224955.GA669929@bhelgaas>
 <MN0PR18MB5847809DF7EB9A3ECA4A4159D33E2@MN0PR18MB5847.namprd18.prod.outlook.com>
 <CABhMZUW5Y3g86_ki8MfcqX9Qj63TxqQR=m74c8sBm-puZGEvUg@mail.gmail.com>
 <MN0PR18MB5847913D9E15805B85A0AAD2D33F2@MN0PR18MB5847.namprd18.prod.outlook.com>
In-Reply-To:
 <MN0PR18MB5847913D9E15805B85A0AAD2D33F2@MN0PR18MB5847.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|SN4PR18MB988514:EE_
x-ms-office365-filtering-correlation-id: 3963cf94-6254-47dc-a653-08dec8378d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|13003099007|22082099003|18002099003|38070700021|11063799006|5023799004|56012099006|4143699003|4133799003;
x-microsoft-antispam-message-info:
 K19ZxY+RB5SJP2GHJegf7iqBIkTl7ECzvAB/oGqV7uSNq0jz54CQxLraGcSDuRBLCsw4DQWxSzYCOAI10/+pY5EevUB0rRGjs41V192jlsF3ttvjBo6k6Nh3/aAxMuScmj5F1fBK2ZC7wnvpiEmuuXPwz8BPLYufEcVEaJCQXT6LwxrC13K6W1oCeVGvMyAqHpcSrvnKXr9+kT0ZPC+0/hI3hCY3LOzLbGvZDmScOln7KPvX6+pcUWxSfmWhPd2DDR+VA5ajYy4IfnppkP1nOCS/N+Mj8i48dUDPR8NVnVYP/DCATq1BcGQolw8lwQJF9MWy/rKPGeXROoQD+ncu6QXRl8L5bihpQzupxtfUABkPKnSEsXDd5i5M5ijJ5sPLinvQmjLCojTQ06n0YGZ3zKz941tOYfLZin6GOM9BJfsmwsKcHAunggH4mUCHqey8O2Icji8+j6SjpSVgS40mhIRP23SAlAfgLlhRGbVCE8IxYMRnFp3Aie1rz635GVYMezakkSkff1iQK7iPtP7jHBFEODflfZaugjLcQ5xjzdvWNma78+7nzp2w5sWYe4ZjEsYmeUAUscgWjlMexsja4wTpMoBVcKsclBKhiQ7nCi6BOojZ/A/OsxuNblbDwi5clQXuElPgkFqUdwHynSFpcoujV+03Ru8A7KepBPHhusDhTguqweQvUiHfIVO91U4N
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(13003099007)(22082099003)(18002099003)(38070700021)(11063799006)(5023799004)(56012099006)(4143699003)(4133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zkt6emJHd2E5enVIMUx1bWdtbTVKY2lJN3RaYmEvYUdaamZUSzRnODJxTHY4?=
 =?utf-8?B?U1g5Kzc0MndJa0o3c3VybDMyMkF3R1dhSFd3c0ZaU3F3NlEwMHNaR1hocldN?=
 =?utf-8?B?YnhDN2dnOVlXN0xkNFdlNUdlT1NmcjkydmFvQzdYQjNwaFVKbi92ZytOcm1W?=
 =?utf-8?B?NzlsaUJ1Sk1QZWszNDU0TEQ4cjVyY0VWSTZHNFV2TWxuMkc2RS9HeTBXbC9B?=
 =?utf-8?B?d3dYR0xvRm1pK1hwWDRSeVYzeXR5MXM0czJtOG1ldzBHVzlQUFB1SkJEbVl0?=
 =?utf-8?B?N0VqOXB6VjBPVXB3bFhSdTk3L2VxbVhLbXdIQUQ5T3NIQWRrZXBRREVaTVM5?=
 =?utf-8?B?MFFMZ21XcjRORTFRS0xyZjhOOHdGZnlXb3NTdVRPRERqa3c2dUdRTXBLMXYw?=
 =?utf-8?B?TWthb05pdTg5QzhiZmtMM0YxZU4rcWh6SUYxQW40TnJoVFVNL1QvUGJhejFt?=
 =?utf-8?B?d0ZlNHJ0S3YzNXdoakVURTVZQ3lMQWovaFFGT2FQa21RMk5QS3V2aGMyV0ha?=
 =?utf-8?B?aFA1dXJmZVFadzZnMXZ4ZTBhS2s5cTY4bmVWamw5L2hZWFJ3TDVRTDVtVXoz?=
 =?utf-8?B?VkJnQmFER2JoODB6cENzSXhRQlZZZmg1eGtueEJ0a2dXKzVZZVhoQmhxY2JJ?=
 =?utf-8?B?c1hRSCtnNXFFZkczUHl4SXE2L3g4VFhMWC9lNEszaUF3WGRvVjhpSHVaMXVZ?=
 =?utf-8?B?LzFyWGxkYUpubHpQSmRxdXVDSzhIenhiaXlnK3duamdlK3k0a3dTcnk2K3BW?=
 =?utf-8?B?aTROZnd3L0kxR0QyeVg2SEt3c2NHSHhyb294V09jTjdsY0FaSFdUbGsvT3pw?=
 =?utf-8?B?b1FxeCsybTZIZ0tUV1Mya1FwYXRDNE1vdkdjRzJVYUxFdTY3aGlEd2xOUnlI?=
 =?utf-8?B?d25YeHdWc01VS3poeU9lVUpWZDdGcU9DYkoxbzF3d3UycGwwaDlHcUV0eTBO?=
 =?utf-8?B?eTFtY2hPaTBaeWI5ZGhoenBQUGdYUWYvZk9CSGdFUEVxd0ZLVUg1TFJ4YUhX?=
 =?utf-8?B?SDJhNjB2WkM1dTlBNjg2WGtQa2RtdDFsekkyNWU5WlhLSE9PRU9HY1VlbW4y?=
 =?utf-8?B?d2FzTUNZS01hRWJuQzBLV2pMK3g5NXFUemN0Q0phZnIvVTF0RldOL3JLVFBF?=
 =?utf-8?B?TkdpTS9Za1dhbmRoZHdZYmhGakVleFQzMnRhQ1JPS3BkdDlGQ2ZLZ01HVWRT?=
 =?utf-8?B?RjVoQjh1bllSSjJ0MEZHSkJySy9wdHkrRGJubnhYbGtBSFJFL0d4alVUbUtK?=
 =?utf-8?B?aExrQUcyaGYzUW5Jc1J3eU81YTBwd09aUlFXNFRvRUE3V1ZSbW5YRE5jMDZN?=
 =?utf-8?B?ZnFWa3Vlb09pak56R0xjbFBzYldYVHR4YytNWWl0dDBVM0hsQTdVcC9zZlp2?=
 =?utf-8?B?d2Y0WWtqTnNvakF4S1pQbjlZL3ZZei81NGJ6T2Jha1krOEs0emJ1MGtJRUpB?=
 =?utf-8?B?bHRaOEVSSWpHOHhmRlN4K0hNdHlQZ1lVdTBKNENvZkx4RHQ3Qk5EU2huUmhQ?=
 =?utf-8?B?SFBGeTdoSWF4Y2owaXRJa3ZtTVVwWWY3eDgrTmJZMGZhb2VTdEFWenM3N3lx?=
 =?utf-8?B?aWRYRk1OeUtaQnE1UWMxT0lNZXkwMTlHaHF6VytKNzN0aE04dS9KL1Jyc0xJ?=
 =?utf-8?B?RldUWnowQU9Xdlp2dDYySzVLUnkrWGg2OFdUOWFUbDU5ZDN1bFNGeDlkN3pF?=
 =?utf-8?B?bUVzVE8vNkMwQzRoTlQ0MEZQSkdOc0t2dHBNV1lEdFB5VDM1Vm9yTFArUThB?=
 =?utf-8?B?Y2dOZSs1c01HUVEwcEZsbElWMlB1YjY3d1g0ais1R1BoQnB3b2hiY1ZwM2lN?=
 =?utf-8?B?aDhlSm9mc291THFkRklMMkhUNTJwUXJHUFdaYkdXL2NJOEFSdDR3OWJIUXNL?=
 =?utf-8?B?K2F5YXd4SHRkWUZnT2QycXd0OGtwY3dEbUJwdXRFUmVDR2JrT082K3I3b0Vi?=
 =?utf-8?B?dVk2bVhhSkltNjA1Y2ZaSjVVenFnSzNmYktidmY0aTFxcDJuZGV1Vkgrd3JJ?=
 =?utf-8?B?ZTRzcXBxVXIwTlRtLzZvY0NLQXo3OTFtQlIyNnE4dUFBNjVVN2Z2REV1TnVo?=
 =?utf-8?B?L2FCcHB3ZFNEcFA5ZUZGT0habnl0LzFzQzNEdEw1T2NqRzBxSklRRXA0Nldo?=
 =?utf-8?B?SmRvYzBUUDZubysvMVRUZU54QllpQVZaVU9CM2xNbUNiR2o0MTRmNVB6dE1O?=
 =?utf-8?B?SGE5aitUa252THRZYnltV3FTSWFVYWVMcWFZcFI1ZTNkZXk1SG9vaXZ3bElY?=
 =?utf-8?B?U211a0FoUllaUzQ0R1JrcENwZndCZE5vNjZSQnN3d0paWHVDcGtMNVZNd0g4?=
 =?utf-8?B?cWJVRmJEMG9SdFNDaThkc0NKYzVCdVpNTEh0ZUd0aks0aDhmVUdoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Fx0F+e3XrhhjB+JnqaaX3GlvaiytoveuB7YpM8I8HBTXI9eNPjkzq2bQUXHFDnxrQtC2F3UfI8gYghhoe7gxKNsdLWRgLYa5w5lez5ZYJOORfw7cwlSdCjOx7EgLgEBvsaGuMCuXLg56MaxVlKO61c+FYJL7+1dLKaHswDpVxErmxvpEt/s5v/U0lTaIJpUJKzri6NCCQq0xRPjLHq0kVm321NuYfBla4AeXHnSSkh/D/FHASL4FSsKi3zwqgfdCdG5VM51dTQqD7KshrY+xpKZyMkX0M0iTTMvU/slMIZDsRNK1tXuTuGIsQ7X3qxxDa+sZkb8PxnAisl1YuMptXg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3963cf94-6254-47dc-a653-08dec8378d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 04:03:25.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7Rt6jnaJjdMfObB1rnHQOL+rUsxu6y8PG6Zmnyp7BXkssFWpSB/FKsqQk6EvyDzz0lHNBvBifFE6ZcHSCFtkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB988514
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAzMiBTYWx0ZWRfXy/xSANAs2IoD
 AowVupmB1RCn/9Smwr5Yb7Mz0/oOmikElUtrxIuzlOOEM3jmqPjb4D1yPJ/JBD5BzLk9v7NblNf
 igmcOyYrzy7C6jAfUVuyaRDMvWYQo3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAzMiBTYWx0ZWRfX69Iw1pCYS8ss
 +Ln2eQ9xgdLSgwExJPk7PSik+gtoAUC75KBTYK0VuiYyTMYMQZjBJYOE/liGGqoh6UqTfx/dIlA
 dn+lWPpuJ6pCacTe9oYu9rmPkYjQ51Crt7xrccFrNMCStgnq+ITnf8fBn3dgybMkr/tKkBMhBpp
 mBQpN0Ihc61V+Im8SCgFGcI2fKQNuCFIFIPdpHTX+S1DC4H3/j5Tftjtr4nTqjf8MrHfmt6bJtU
 NCT0DgxBsVuYZ45vAfGdZH2FErQnb0IaGmQ7RSxtFbt1fs+MOYoPSQeLgZSukUrSzjBTQ0NCasN
 sUIaDAE6HBVVt0aCw5blE6s8c7CNTP4c/JPPf/lYOqvL49qSz1n2g8L8tRpU2vLS6X1Inx8M9n7
 tuhvFBdlsN4Q3t/izenNpzyL5koCgHKayN3L5pLEDo+Zfo8H/xe5qRyLREqJr/H9suunN/8qhLn
 OYKtDWRm6Tz372Scp1g==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2b850f cx=c_pps
 a=fMm6ob6OrxBSxP8bamoiPg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=TjLpVNZhDvUs67CzpaoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3AxKVII0akWhJzJ4aeiIWEJ9Q9mR7nv1
X-Proofpoint-GUID: 3AxKVII0akWhJzJ4aeiIWEJ9Q9mR7nv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01

DQo+ID5Gcm9tOiBCam9ybiBIZWxnYWFzIDxiam9ybi5oZWxnYWFzQGdtYWlsLmNvbT4NCj4gPlNl
bnQ6IFR1ZXNkYXksIE1heSA1LCAyMDI2IDg6NTUgUE0NCj4gDQo+ID5JIGRvbid0IGhhdmUgYWNj
ZXNzIHRvIHRoYXQgYnVnIHJlcG9ydC4gIElmIHRoZXJlJ3Mgbm90aGluZyBzZWNyZXQgaW4NCj4g
Pml0LCBjYW4geW91IG1ha2UgaXQgcHVibGljPw0KPiBBcG9sb2dpZXMgZm9yIHRoZSBhY2Nlc3Mg
aXNzdWUuIEkgYW0gc3RpbGwgZmFtaWxpYXJpemluZyBteXNlbGYgd2l0aCB0aGUNCj4gcGxhdGZv
cm0ncyBwcml2YWN5IHNldHRpbmdzLCBidXQgSSBjZXJ0YWlubHkgaW50ZW5kZWQgZm9yIHRoaXMg
dG8gYmUgYSBwdWJsaWMNCj4gcmVwb3J0Lg0KPiBJJ2xsIGV4cGxvcmUgdGhlIHNldHRpbmdzIG5v
dyB0byBtYWtlIGl0IGdlbmVyaWMvcHVibGljIGFuZCB3aWxsIGdldCBiYWNrIHRvIHlvdQ0KPiAN
Cj4gPkkgYXNzdW1lIHRoaXMgaXMgdGhlIHNhbWUgaXNzdWUgeW91IG1lbnRpb25lZCBhdA0KPiA+
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3Jl
Lmtlcm5lbC5vcmdfYWwNCj4gPmxfYWJrcW0tNUZMQ2Q5ekFNOGNXLTQwcmthbm5vdGgtMkRPcHRp
UGxleC0yRDcwOTBfLQ0KPiAzRiZkPUR3SUZhUSZjPW5LaldlYw0KPiA+MmI2UjBtT3lQYXo3eHRm
USZyPWFla2NzeUJDSDAwX0xld3JFRGNRQnpzUnc4S0NwVVIwdlpiX2F1VEhrNA0KPiBNJm09eUg3
RWVCDQo+ID5lOUh3UmxsRDhLLQ0KPiA+UEZOUzJDTUZTbGNhQkhVNm8zRFlhMXhuZEp2d1ZTSEk0
YVBXaTk4dURLUFJJSkkmcz1CSzRfTnZtWGENCj4gPnF5c3prTVZIV0FQVGE5TWVhWC0yNkthM3hU
Nk5LU1h3RlEmZT0NCj4gWWVzLiBJIGJlbGlldmUsIHdlIGNhbiBpZ25vcmUgQnVnemlsbGEgcmVw
b3J0IGFzIHBlcg0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjE5L2FkbWlu
LWd1aWRlL3JlcG9ydGluZy1idWdzLmh0bWwgPw0KPiAiT25jZSB5b3Uga25vdyB0aGUgc3Vic3lz
dGVtIHRoYXQgaXMgY2F1c2luZyB0aGUgaXNzdWUsIHlvdSBzaG91bGQgc2VuZCBhDQo+IGJ1ZyBy
ZXBvcnQuIFNvbWUgbWFpbnRhaW5lcnMgcHJlZmVyIGJ1Z3MgdG8gYmUgcmVwb3J0ZWQgdmlhIGJ1
Z3ppbGxhDQo+IChodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcpLCB3aGlsZSBvdGhlcnMgcHJl
ZmVyIHRoYXQgYnVncyBiZSByZXBvcnRlZCB2aWEgdGhlDQo+IHN1YnN5c3RlbSBtYWlsaW5nIGxp
c3QuIg0KPiANCj4gPllvdXIgZW1haWwgcmVzcG9uc2Ugd2FzIEhUTUwsIHNvIHRoZSBtYWlsaW5n
IGxpc3RzIHJlamVjdGVkIGl0LCB3aGljaA0KPiA+aXMgd2h5IHlvdXIgcmVzcG9uc2UgZG9lc24n
dCBhcHBlYXIgaGVyZToNCj4gPmh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91
cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsDQo+ID5sXzIwMjYwNDE0MDgxNzMwLjM4
NjQzNzItMkQxLTJEcmthbm5vdGgtNDBtYXJ2ZWxsLmNvbV90Xy0NCj4gMjN1JmQ9RHdJRmFRJmMN
Cj4gPj1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9YWVrY3N5QkNIMDBfTGV3ckVEY1FCenNSdzhL
Q3BVUjB2WmINCj4gX2F1VEhrNE0mbQ0KPiA+PXlIN0VlQmU5SHdSbGxEOEstDQo+ID5QRk5TMkNN
RlNsY2FCSFU2bzNEWWExeG5kSnZ3VlNISTRhUFdpOTh1REtQUklKSSZzPTdYDQo+ID5mM2lrVVBa
cFRqYm5YM0IwemltcHNIRk1nSng4Z3VSa3lHQWw3R1h6OCZlPQ0KPiBTb3JyeSBhYm91dCB0aGF0
LiBNeSBtYWlsIGNsaWVudCAoT3V0bG9vaykgZGVmYXVsdGVkIHRvIEhUTUwgZm9ybWF0dGluZy4g
V2lsbA0KPiBiZSBtb3JlIGNhcmVmdWwgaW4gZnV0dXJlLg0KS2luZGx5IGFkdmlzZSBpZiB0aGVy
ZSBhcmUgYW55IG91dHN0YW5kaW5nIGFjdGlvbiBpdGVtcyByZXF1aXJlZCBmcm9tIG15IHNpZGUu
IEkgc2VlIHRoYXQgdGhlIHBhdGNoIGlzIG5vdCBhdmFpbGFibGUgaW4gbmV0LW5leHQgeWV0DQog
b3IgYmFja3BvcnRlZCB0byBzdGFibGUgdmVyc2lvbnMuIEkgd2FudCB0byBlbnN1cmUgSSBoYXZl
bid0IG1pc3NlZCBhIHN0ZXAsIHNvIHBsZWFzZSBleGN1c2UgbXkgaW1wYXRpZW5jZSBpZiBpdCBp
cyBzaW1wbHkgYSBtYXR0ZXIgDQpvZiB0aGUgdXN1YWwgcmVsZWFzZSBjeWNsZS4NCg==
