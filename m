Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FF2D46A1;
	Wed, 20 May 2026 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244522; cv=fail; b=cq3JB/MR3fcwy2pjIpPQ8TB6Ae2kjqAyopji5bfnbfYQcxVnXbU6WYgYgNRCAA8l2wEX75aNAgKJrMIdU6R4jW8TW7eVrn5PUz+u05owng9GhuWuPzQ3rDmdPtQ+8incY42Oy4Y+QqHcbgTKn6RyCdaaK/5Pf9LTiKYk800TID4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244522; c=relaxed/simple;
	bh=BtdlHN878eSu2mKYV0wt+ZGj+PXrxMT/4XbmCZTSHdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqMF9X+TkeogvzNypVCaku1rhz6hIG21yB3Ir/nN3vCWKNa1YULpXgk0lYVdCmVz17ONc0icEh2Xiwa9NKghBm1RGgjsJxqSXE7rnr0mfxaC2bU5zaU/Ggv9mhlYDSd5Bl+o5bGBTcKhxaEtcvfpGQ34i2ijODfjKMJRIB7zRfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Ymv7ZIfX; dkim=fail (0-bit key) header.d=cadence.com header.i=@cadence.com header.b=D77RAjKr reason="key not found in DNS"; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ymv7ZIfX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cadence.com header.i=@cadence.com header.b="D77RAjKr"
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JN4hW22478852;
	Tue, 19 May 2026 19:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=VokhthK/zkzDiqz57SLWSGOXqOVvRj6yMsNXpxZ6OBA=; b=Ymv7ZIfXc/Hv
	byAby3mvbWExdkAxJAor861OKW9f8J01uQHwNPntGtYrp5pIWfcSjr3lwCpnNgOC
	ilezt3b0wy5LnJjhibelp2m7gTRtwkTkMfc9gs5uytOMwnYsnJ/CM/LDLdXq8boa
	JNGgBbZl34qFMaA636jn/Vdyk6R4bcSbXagSO/24mdyxG10muPC2j7eRmoBomPdu
	grQNV/hMFyXcMXE1+lYa3PoOaBj0VtW9Om12KWeM36KSjCKNvINTptQ2HAc597Hn
	H9sCPRENLHL6ZPuxEL/crfsLDwKfpWTI+bmUchsYXg5/1LKvuC8+/hGWCD+N5Yqk
	fB2lv9qz3w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4e8e6wq0dy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShsmmpnkEa7+TBIh9s3JLlK/R8f/a6yI/pwkuhlsUO8Qu9Bb06NAxxBByDzC/gYlGDaXvNcoEVro4BQtoDSZ77w43pzzLw1rK6FtyRrc/AUdd9X/U7qUl9wXEni1fwxubTCqPvf21WUi6EMpTejWe2WPywXM7jpynjohRcAbtY8PqMnrMeCb9E7Wwr7ZTvQveO+DAm9brRePTyVK8VMWltjWd+P6J7/7aSV0KalXWNYdKG82s1K6zRxva3JJ0VSX2SyvQLQLiScORIzRQLsU8mgEAqP4P1aQSgggaI7q+UgpsxddkMl5pQRtpzFoySeydY2Uhakz5wCC16TjXPkr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VokhthK/zkzDiqz57SLWSGOXqOVvRj6yMsNXpxZ6OBA=;
 b=gVUeNlbxAxo18N4Gdccrim81WWGvtWVLR6lfBHHQShNusAHQNaDtYiGqlB6hEzQPRv1WRagxz42RTihJz4VigBPvzlQ67SC9ydIqC9/Wdoe/YdsZk+RisCiDF3sL2EdNCGqW5fPExVd1sn9co26PW12hOO0aGNGVGHvI3upGzHKBM2OnQg9FxgYPG5gwNCy8bZb7KQCz+4gvrJxAYRnukDLpZp9GgcAnAHPXjbkqe7KAxFv3tV54Pau8BgXk+wOWPs4qQ1WNjpJ1HUA+FZxQsfVp5n2YL6Ev+1dJ4zhsenpp3yuiMIDwLHTXMqEG+AVKjtr1LBV6n+k+7A2mpUlgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VokhthK/zkzDiqz57SLWSGOXqOVvRj6yMsNXpxZ6OBA=;
 b=D77RAjKrA40wzjfrdY7nhdWfKrFmW9V6vxBwlGOtScUqv6csuVwjNxAbi1RLMadpZNIIs4iuRsAzKPNNhPIDgAjbdmkgMYxnLO7qyUDqYULy9YZWfBF8rKdKr4TjwsQEl3ixQvIrmS3Pp4piIsonhBJz24niSiE1089JfiAOt7vjPZMLoz9ojpnsUoIBCMlqphih76/wVTCaF5t9j41iVO6/sAoiF56JqznNNcSnL3irljVbusBObBj4f0WPwZsf1CqW4e1ifERsZV0reqZW2Y9XQPxCAIgeSHnDJqsJDz0R0ItPNtLt1QV9zyQUlDyt4ZdTmwScO0KpENQDcCfbZQ==
Received: from DM6PR07MB6716.namprd07.prod.outlook.com (2603:10b6:5:1c9::16)
 by SA1PR07MB9961.namprd07.prod.outlook.com (2603:10b6:806:3a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:34:58 +0000
Received: from DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175]) by DM6PR07MB6716.namprd07.prod.outlook.com
 ([fe80::2e20:ee0a:1b4:1175%3]) with mapi id 15.21.0025.012; Wed, 20 May 2026
 02:34:57 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Hans Zhang <18255117159@163.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "mani@kernel.org"
	<mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "a-garg7@ti.com" <a-garg7@ti.com>,
        "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
Thread-Topic: [PATCH v6 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
Thread-Index: AQHc54wfNWhkpqTnNEelCjPz/MtdK7YWMs8w
Date: Wed, 20 May 2026 02:34:57 +0000
Message-ID:
 <DM6PR07MB6716A1B312BB85439C399D56A2012@DM6PR07MB6716.namprd07.prod.outlook.com>
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-4-18255117159@163.com>
In-Reply-To: <20260519123609.1595280-4-18255117159@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6716:EE_|SA1PR07MB9961:EE_
x-ms-office365-filtering-correlation-id: b5e0ac77-3a3a-431f-b081-08deb618622b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|4143699003|56012099003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info:
 UpBFpRAw6eG467gVTVwTX7Stk3avq7Uk750OGLRnsHMh6CrpDUs288vFJ8o6tCzeUfx62jOu6c6P+X6r2wQtaMj43OrISI5xeiwRgR89ZOKBjtC+UAr5WO3YRWaVfatpdB2+2SfSDYJtvfPGEgqEJGQEp0KRWh/X8o8eT+RYmpgEijSibrlMo+agg84G8UUzlb6BypJJ3Nf7RBSNBTzmpDlcYV9dXr0vBgNqht3SAmVk5bg5xOtBmeL7ng/rbzPJNIubHZgy8JOU7c1wCBildlzPqE5biV+jqC9IRKC37vWJpkmnL81rsVM7ODqrn80yUHT+Q+MMLmxbOmZSz30EudO6IvZB1DY/9ktMSa1T6As51xL6bB5fh3mluL8Zq/VW12pxO9Pox3VP1caMzhwmUx5NUVuZiiPOO+JsuvxnuopRPMp4ZS/SQzHuSROPFApq+nfbL1Nmvcnkcf1k2xLzpo4zs4fH9D97t9QmvFuAbYjkKRyBEB17QMg278tuGOni6H3eOthrMtR7tWmKi9AFScU5xp/ptn9Y7XQ6156Ou9ZtJXnx1wz+arYP+I5C+qu6nrTRgTGFNFt6xno7hDdheSstex9ZFNhW5r4OhL+MFXTT1thBN8qkY4PGQgLs3yxUZj92Uaii8yUGBruSUnMvkK6bG8TjJBXlaZexTCu50NXu9Z+qnXzSRUb6RqFEdV6+IOhYDYQ17HiHsCnC74Tm6VDpSUBVPAOoVtY5faxMPVo0NrGpo2AWSjCDssRpAujX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6716.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?at5t8N4Zz30WLbpv1O5uYq922MdQSqvzDEk1cIw6mHuWsxdYADfwbzuSmoze?=
 =?us-ascii?Q?G8Iy44yGhGs0BFYIwUaqsPE00d4OW8K75bgrep0FwiGOTm5wYkSXlttg8Fza?=
 =?us-ascii?Q?PGNo2ld/xyTSKB9l6iB44lKsvM9XiHskowrNZbRyC9VN7y9D6h9NLWh32DNt?=
 =?us-ascii?Q?qjw46BsPw/RcHiCN9pxoG1rKpWTc6demB+ZDguQ688tKVdOrYiGxZ0Jg3zbK?=
 =?us-ascii?Q?G96yEwBmms6HswR3t2JGapWZQq1YlAVgHm+/Bom5CJuuUMlvXHUMwkTZWlKA?=
 =?us-ascii?Q?hSknSWBW4BiaQXSxxhAKo6sySOtTmj/usB7pz388IZg8inNa5w8S0lb/qtxb?=
 =?us-ascii?Q?3xYoaSOhenyBmC5W2EDkgx9FxrzX29abh/+p8tO+782yTrDrsDxBHn4uNyGl?=
 =?us-ascii?Q?X/Dc3a5IGXZFjHPdYu7MjmYxrCZVGJvbRQitZIsPoxCDSHMZRmzp3bnkzAYh?=
 =?us-ascii?Q?Hw02HXJ9TaSb3cwTHBbQNdlC614AH54GUeQI8b3KyHDJ7SDqLb6Ko55Vfnu7?=
 =?us-ascii?Q?c/Zqx9P/VLpj+ohgDmiJdF1jA7yYD45tBA1pADYaxTLhVHr3vypzwkv57nfP?=
 =?us-ascii?Q?7Otaw9M5Ay8Yeee3FhvHaJV4XmOMpx6QP3VCE9JZOZ/hy+zBCvqKZYu1KLrJ?=
 =?us-ascii?Q?NvXuQkkK1p2Bq/50ZgMJp/Sn1USLHHiIWiohQub/VI9PIdwT10s04tMf4EN+?=
 =?us-ascii?Q?VjsAQP91RXTwq5cw2m86Qvu6UjBsdSHwOcDrUS93nmloKszeHGWArpNMnTmo?=
 =?us-ascii?Q?8yib9urGItdFKoAIrNUKaoPnsEouEtKWpye5VFLlhP0BC5PJdN/M8i0kqvQg?=
 =?us-ascii?Q?uHpe9nytppEtzuDWqJyXW0WKZ/qB2WUu9Wundd04dbxBrjMjM4QNshclMbKo?=
 =?us-ascii?Q?/3qulZ/IDsYpp9deCMorzNKuxgB5p7zaBj9/YiV2xwaTgjmVWLz1FAWW3XnS?=
 =?us-ascii?Q?NnFaP0TkjObVnAnDfemaUTzKQmR+pQSLrXE2htdXNNbJLctk9C0F0qgnq2Ge?=
 =?us-ascii?Q?GrHQXET0e+BPcZKdNqgpz8V0U+8kQ2dKc5XvFtthywfvq4LJTBxTUBDH8NNP?=
 =?us-ascii?Q?poouCU6uFEVDoCY6TXs29+gxsUWBktjy81pWZTN5I/r6TGGH0clRhoDIz8UA?=
 =?us-ascii?Q?USQCz1CTF0+E7okTb2hXJ9Ep/Lh8B3LJnf+Tk++6U9SF9gnaAtqtnkXNY1fZ?=
 =?us-ascii?Q?/D2NSsrcBXGNNpEXLofMsMEmtfeh2g5nJsFzVbKMBNa9n0L7i2mBhkODtkDd?=
 =?us-ascii?Q?AKdPCN+3I/rftq69TF/YBxYtb5SoR+WFW8A1Uq5mUhyoVs+iyy5t+nSfGtBp?=
 =?us-ascii?Q?OnAZ9lBPbU+f8NK7bEjg8S/h0t/K/+B03zdebxNA+JiZ5oi16RXrHofnFDbp?=
 =?us-ascii?Q?ScCtXAoE00Ns51vbNE9XRdHk6JlW/FyQbLLBoa3R6qaJhri2O7gwR1P8hfXW?=
 =?us-ascii?Q?bRxmeQJ8Y+sxWIHEcW1lFdiLV0p6KwhQU3wWO8yX1Rjbt5FiM2wxAxMqq5Dr?=
 =?us-ascii?Q?DgKzn3hYAgDjaCZ2oBWDtLTsHlYiNtnFRG83Z2SCMFL2Dk59zVIv/4odrzMy?=
 =?us-ascii?Q?hKzB4vm5eoE5B+vC+YVVleHmzsx4luEZ4NQb3Y73M1cLeC/uN/+WuL0nEzdp?=
 =?us-ascii?Q?OvTgzJh7TTeUKKvqu+eP1QV78Q30vVEt9Vb2No+RqlQfsVPRgGC7X65re3zM?=
 =?us-ascii?Q?mHkFD7ROL7fJmbrepMfnPXCvNUAR1DA+rka9pJcyD9iJk3sZYnbcWWrIZkqs?=
 =?us-ascii?Q?i8EGBV0YcQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	K+cXpGjr6tHPAaNNc0zHY6BrTfFW4VXexpUmqadsUIZ3O+UWZzH1hVwCdRD4KSCKPZHbx1oOm07N8/rRCqusSi+uDTnHntFAMu43k9LOVw9oJ2DvjYeImbDETj0JrrUhr5Jco6Uxd3+NdvZczU4tKK5IOTU5KkoAFIX/i0QZrgwwgp4RvNZRCti1+C9fDdJ4KTguoPI5l8HtdiR/ehVKr4o/6GibTL+H03EZ2EGt0CV9jRut5KNZ7hKgutirWjOr5/UeGTH03kO4YhJC2KjGuyweMqzoSaSVoAgfocsaNjkp3fPfByXE+XXhU84lw3FvSmniWGTDuMXLZZg4ubYAUA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6716.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e0ac77-3a3a-431f-b081-08deb618622b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 02:34:57.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ax+B4XIV7XkgIfYpQfjN6DgnXmH+4oJy8L8qwdGP3IEatPD/KEgjIijR9V0gxWvKbCe+dP89MaZiZMBKbV+HPIprNgH0xRd+YP9HppW2z1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9961
X-Proofpoint-ORIG-GUID: 7moHNVwyTI9FZILy8mIVKIOxuWDCJNEz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAyMSBTYWx0ZWRfX9C1m647pBG36
 R0b+kZpVtgDWyZ/wkuQqYQRiV+1j1HUMwjyuJLtOKZh4uu0da47npph+HImqDLIjFrHiPF/jxR8
 SsudRX3V+tV2ynz3y3pLS9gI03dp7+XUa+NCGWneP2D3zC9/Z54yjoQ/1OhDBkThcEHW28ZpAM7
 0k6Eimk3lawZKPXbn8scKr76nV2ksFPmU4I7ldk2s2tWMWSZ0stlUuj96rrgG+Bm/0uzIEHJCkb
 Tq0Bn4i/1sBilnK0Pzp+uu/h4/12SWUHgzLP8n06qXRGRrBTDB7kfKUplINQsPYFGDqdJBq7iRP
 AUNHzLBu6jTMaKePddTAeXqt9kXcE5zZNH3gaOfDlfmEZj60X1WCNOWB+Kd0BWa4IQdzsh1Pc0w
 mTORgfD1r9itwnTf7kDMJzV/ll0u0jgQ/dU+fFhIFSKUDyeNS+FgpyYWNjOyuTO3U8VXbWkNd3J
 +DM+DUoAa2TP1eSHjHQ==
X-Authority-Analysis: v=2.4 cv=RfWgzVtv c=1 sm=1 tr=0 ts=6a0d1dd5 cx=c_pps
 a=ixAZ6W2pdOuc7GYTaWtIWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=tuMieXAyK57eGGFK7xkD:22 a=Byx-y9mGAAAA:8
 a=G9UUgTLdtTQ6131T-j8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 7moHNVwyTI9FZILy8mIVKIOxuWDCJNEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200021

>EXTERNAL MAIL
>
>
>Extend debugfs support to LGA-based Cadence PCIe controllers. The
>'ltssm_status' file now works for both HPA and LGA IP by selecting the
>appropriate register access based on the 'is_hpa' flag.
>
>Signed-off-by: Hans Zhang <18255117159@163.com>
>---
> .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
> .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
> .../controller/cadence/pcie-cadence-host.c    |  9 ++-
> drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
> 4 files changed, 112 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>index 97c5deef2b1a..0a308f95e9f6 100644
>--- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>+++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>@@ -13,6 +13,58 @@
>
> #define CDNS_DEBUGFS_BUF_MAX		128

Where is CDNS_DEBUGFS_BUF_MAX used for ?

>
>+static const char *cdns_pcie_lga_ltssm_status_string(enum
>cdns_pcie_lga_ltssm ltssm)
>+{
>+	const char *str;
>+
>+	switch (ltssm) {
>+#define CDNS_PCIE_LGA_LTSSM_NAME(n) case n: str =3D #n; break
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_DETECT_QUI
>ET);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_DETECT_ACTI
>VE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_POLLING_AC
>TIVE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_POLLING_CO
>MPLIANCE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_POLLING_CO
>NFIGURATION);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURAT
>ION_LINKWIDTH_START);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURAT
>ION_LINKWIDTH_ACCEPT);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURAT
>ION_LANENUM_ACCEPT);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURAT
>ION_LANENUM_WAIT);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURAT
>ION_COMPLETE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURAT
>ION_IDLE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_R
>CVRLOCK);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_S
>PEED);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_R
>CVRCFG);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_I
>DLE);
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L0);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RX_L0S_ENTR
>Y);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RX_L0S_IDLE)
>;
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RX_L0S_FTS);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_TX_L0S_ENTR
>Y);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_TX_L0S_IDLE)
>;
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_TX_L0S_FTS);
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L1_ENTRY);
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L1_IDLE);
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L2_IDLE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L2_TRANSMI
>TWAKE);
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_DISABLED);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_E
>NTRY_MASTER);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_A
>CTIVE_MASTER);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_E
>XIT_MASTER);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_E
>NTRY_SLAVE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_A
>CTIVE_SLAVE);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_E
>XIT_SLAVE);
>+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_HOT_RESET);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_E
>QUALIZATION_PHASE_0);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_E
>QUALIZATION_PHASE_1);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_E
>QUALIZATION_PHASE_2);
>+
>	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_E
>QUALIZATION_PHASE_3);
>+	default:
>+		str =3D "CDNS_PCIE_LGA_LTSSM_UNKNOWN";
>+		break;
>+	}
>+
>+	return str + strlen("CDNS_PCIE_LGA_LTSSM_");
>+}
>+
> static const char *cdns_pcie_hpa_ltssm_status_string(enum
>cdns_pcie_hpa_ltssm ltssm)
> {
> 	const char *str;
>@@ -158,6 +210,7 @@ static const char
>*cdns_pcie_hpa_ltssm_status_string(enum cdns_pcie_hpa_ltssm lt
> static int ltssm_status_show(struct seq_file *s, void *v)
> {
> 	struct cdns_pcie *pci =3D s->private;
>+	enum cdns_pcie_lga_ltssm lga_ltssm;
> 	enum cdns_pcie_hpa_ltssm hpa_ltssm;
> 	const char *str_ltssm;
> 	u32 val;
>@@ -168,11 +221,13 @@ static int ltssm_status_show(struct seq_file *s, voi=
d
>*v)
> 		hpa_ltssm =3D
>FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, val);
> 		str_ltssm =3D cdns_pcie_hpa_ltssm_status_string(hpa_ltssm);
> 	} else {
>-		/* TODO: LGA IP*/
>-		return 0;
>+		val =3D cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
>+		lga_ltssm =3D
>FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, val);
>+		str_ltssm =3D cdns_pcie_lga_ltssm_status_string(lga_ltssm);
> 	}
>
>-	seq_printf(s, "%s (0x%02x)\n", str_ltssm, hpa_ltssm);
>+	seq_printf(s, "%s (0x%02x)\n", str_ltssm,
>+		   pci->is_hpa ? hpa_ltssm : lga_ltssm);
>
> 	return 0;
> }
>diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>index c0e1194a936b..370b19f4d38f 100644
>--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>@@ -655,6 +655,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> 	struct device *dev =3D ep->pcie.dev;
> 	struct pci_epc *epc =3D to_pci_epc(dev);
>
>+	cdns_pcie_debugfs_deinit(&ep->pcie);
> 	pci_epc_deinit_notify(epc);
> 	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
> 			      SZ_128K);
>@@ -761,6 +762,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>
> 	pci_epc_init_notify(epc);
>
>+	cdns_pcie_debugfs_init(pcie);
>+
> 	return 0;
>
>  free_epc_mem:
>diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
>b/drivers/pci/controller/cadence/pcie-cadence-host.c
>index 0bc9e6e90e0e..8105bb625eb7 100644
>--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>@@ -364,6 +364,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
> {
> 	struct pci_host_bridge *bridge;
>
>+	cdns_pcie_debugfs_deinit(&rc->pcie);
> 	bridge =3D pci_host_bridge_from_priv(rc);
> 	pci_stop_root_bus(bridge->bus);
> 	pci_remove_root_bus(bridge->bus);
>@@ -423,7 +424,13 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> 	if (!bridge->ops)
> 		bridge->ops =3D &cdns_pcie_host_ops;
>
>-	return pci_host_probe(bridge);
>+	ret =3D pci_host_probe(bridge);
>+	if (ret)
>+		return ret;
>+
>+	cdns_pcie_debugfs_init(pcie);
>+
>+	return 0;
> }
> EXPORT_SYMBOL_GPL(cdns_pcie_host_setup);
>
>diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
>b/drivers/pci/controller/cadence/pcie-cadence.h
>index 2320319af83b..8bc6564c65b9 100644
>--- a/drivers/pci/controller/cadence/pcie-cadence.h
>+++ b/drivers/pci/controller/cadence/pcie-cadence.h
>@@ -14,6 +14,7 @@
> #include "pcie-cadence-lga-regs.h"
> #include "pcie-cadence-hpa-regs.h"
>
>+#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
> #define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
>
> enum cdns_pcie_rp_bar {
>@@ -44,6 +45,48 @@ enum cdns_pcie_reg_bank {
> 	REG_BANKS_MAX,
> };
>
>+enum cdns_pcie_lga_ltssm {
>+	CDNS_PCIE_LGA_LTSSM_DETECT_QUIET			=3D 0x00,
>+	CDNS_PCIE_LGA_LTSSM_DETECT_ACTIVE			=3D 0x01,
>+	CDNS_PCIE_LGA_LTSSM_POLLING_ACTIVE			=3D 0x02,
>+	CDNS_PCIE_LGA_LTSSM_POLLING_COMPLIANCE
>	=3D 0x03,
>+	CDNS_PCIE_LGA_LTSSM_POLLING_CONFIGURATION		=3D 0x04,
>+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LINKWIDTH_START	=3D 0x05,
>+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LINKWIDTH_ACCEPT
>	=3D 0x06,
>+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LANENUM_ACCEPT	=3D 0x07,
>+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LANENUM_WAIT
>	=3D 0x08,
>+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_COMPLETE		=3D 0x09,
>+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_IDLE
>	=3D 0x0A,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_RCVRLOCK			=3D 0x0B,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_SPEED			=3D 0x0C,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_RCVRCFG			=3D 0x0D,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_IDLE			=3D 0x0E,
>+	CDNS_PCIE_LGA_LTSSM_L0					=3D 0x10,
>+	CDNS_PCIE_LGA_LTSSM_RX_L0S_ENTRY			=3D 0x11,
>+	CDNS_PCIE_LGA_LTSSM_RX_L0S_IDLE				=3D 0x12,
>+	CDNS_PCIE_LGA_LTSSM_RX_L0S_FTS				=3D 0x13,
>+	CDNS_PCIE_LGA_LTSSM_TX_L0S_ENTRY			=3D 0x14,
>+	CDNS_PCIE_LGA_LTSSM_TX_L0S_IDLE				=3D 0x15,
>+	CDNS_PCIE_LGA_LTSSM_TX_L0S_FTS				=3D 0x16,
>+	CDNS_PCIE_LGA_LTSSM_L1_ENTRY				=3D 0x17,
>+	CDNS_PCIE_LGA_LTSSM_L1_IDLE				=3D 0x18,
>+	CDNS_PCIE_LGA_LTSSM_L2_IDLE				=3D 0x19,
>+	CDNS_PCIE_LGA_LTSSM_L2_TRANSMITWAKE			=3D 0x1A,
>+	CDNS_PCIE_LGA_LTSSM_DISABLED				=3D 0x20,
>+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ENTRY_MASTER		=3D 0x21,
>+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ACTIVE_MASTER		=3D 0x22,
>+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_EXIT_MASTER		=3D 0x23,
>+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ENTRY_SLAVE		=3D 0x24,
>+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ACTIVE_SLAVE		=3D 0x25,
>+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_EXIT_SLAVE
>	=3D 0x26,
>+	CDNS_PCIE_LGA_LTSSM_HOT_RESET				=3D 0x27,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_0	=3D 0x28,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_1	=3D 0x29,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_2	=3D 0x2A,
>+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_3	=3D 0x2B,
>+	CDNS_PCIE_LGA_LTSSM_UNKNOWN				=3D
>0xFFFFFFFF,
>+};
>+
> enum cdns_pcie_hpa_ltssm {
> 	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET		=3D 0,
> 	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET_ENTRY		=3D 1,
>--
>2.43.0

