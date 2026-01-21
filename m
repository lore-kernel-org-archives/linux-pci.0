Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3B30FC0E;
	Wed, 21 Jan 2026 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033979; cv=fail; b=MhsB/CKwXZpPbhqA0FhnOLtnfDExDd74Gjl9MixlX6dpFQwOwlh+XipNydzCkeIaDPDDV0wmk1mmbu64fXQWDej+iCqYn5oPYjWy+gz3ZXUqkyIkpZYoTNXArPMHOUhS7LjcP08zOKyNcToSviQeQSJqV2gzuqygR/NXJwdFy8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033979; c=relaxed/simple;
	bh=uODwZwxjOBJhO7r9WnO6Hjjt5S+bHI2FEmqY/EPKzlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lvgtpa7vKWvvVVRe9Xqy/VQmKY7mnjp+WG/jRrwNUQjVV2+2i8nv31vSMzYUAnPtV3gSwq2NXbKwxMSx9Is/OJduF70GHclFOn9aMQM6xss07qYcBn/LNzi2EG5qXNJdjJi0xqmKum5n03d+NaJJXT9Qw9v+dypTVDwY8O77geQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n07eam5D; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n07eam5D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqy0/Ab7AfvCYcUsjeH7hMQr1ATKaCJnoFIueNkQy/wIpk/CAmgtR3HLi6A2dDEBEANOoEynlFA6rE0MJtat2xKocEKQD1JU7eTF6suUu8u7Zto60XDcYLb6zhX7QCiq9ieNSae0qZxq9ZoQ/x6tVSZpigqSGvWWw939/On+1VmyQDLAPqbZPxXugmxms8d/vc36V2NAKVp1Vh3A8fj7RrB46vZ7yjvEbfVY4mmJb7rwSzd3NU173WKMfniAiZtoekbCwptY/nlmy3kemV0jHxbjFaaZ4Sx/DWYd8KNFR7iRGZljydDUY4q3bJ1PjSLChY3ozJu5aa8lGfvV8dLIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IId7x/0J4k+U3dwf/JpjfZtLENPAUyKoTs+Ws2jFeg=;
 b=B+nbbtsMEeEZ8AZPBrTN7oSnavZancWtiP3ledKEaZLf8iG1l5IFKMNlRBQ+pGOE6kHMgJ5KXkFgwZKgtKNOuGJBGJVLqN4lZOqJhh37Mgxn3biCjE5UJ9cBcedBBy3G3p08YsN2ySupIgDZE8TH8OmnP1NH7KG2YPwodJfgXWLEmSi0aKe3pXh3Vde94ue6+QokIb+h9sBGIAU4siXyX1UGkz1rzZb4Lj0L4AGSYNCnoy/ePjLUqdhrE3paUKAnxQYw1elHHFzCXdX4e7NV3PargcU7VoZt30XRDyiXe6hYtfqASFpOpFyaTJZdiD+KEZVrG9mQmDty+7FcyKTeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IId7x/0J4k+U3dwf/JpjfZtLENPAUyKoTs+Ws2jFeg=;
 b=n07eam5Dl9ncHd0I7ylhmKiM+24fmDng2pcHpFhX8o1+wzIOMtjYvidgzI+gfS84Ul78VpHkjtd2qz0X/xZ5yFWCwAK0467SaD9pic8xXLiWE2PYLGFG6/rQyGGHv1nlLQ4nB8eej9Xcy5IRYTgsXZuZLzj8mae2AgtYY31ZDgSfYeC9kNvjNRqGFptncxVhS2uV4AEfDgn27fTpXyonExCcMeboJFRH0XX+0SawRmmNGAV0PReOEmpFmvM4L10IsyxwcUACfB4Xz6AFvH8AFd8biPGFe2KUP03nuJsrcRsejGj+h7ABxav8yrJfHMGATE9in+D+wZvTpFV2UOaGKA==
Received: from PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:19:30 +0000
Received: from PH7PR12MB9175.namprd12.prod.outlook.com
 ([fe80::499e:de78:1a03:d802]) by PH7PR12MB9175.namprd12.prod.outlook.com
 ([fe80::499e:de78:1a03:d802%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 22:19:24 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, Vikram Sethi
	<vsethi@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Vidya Sagar
	<vidyas@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>, Souvik Chakravarty <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Thread-Topic: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Thread-Index: AQHcilvrWYzw6a5xv0eiHOznw6RvDLVcexGAgAC2Er4=
Date: Wed, 21 Jan 2026 22:19:23 +0000
Message-ID:
 <PH7PR12MB9175061A992EAEFD94A1DCDEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-8-smadhavan@nvidia.com>
 <20260121112005.00001e80@huawei.com>
In-Reply-To: <20260121112005.00001e80@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB9175:EE_|IA0PR12MB7604:EE_
x-ms-office365-filtering-correlation-id: 33281067-e5f6-4758-d374-08de593b21f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?a/4SdsJJKrNY7BUgSRxAjJNJ6I+QaMDC2+73RTi4K7mvZeCC+lBY+HnQ?=
 =?Windows-1252?Q?yyviLwrCQut5A4an2czZDYHFtTS2nLjqL5830R9zvYRBT8pL3vzyuIA4?=
 =?Windows-1252?Q?AzSx6GniM008ckUQalfrI/aRTEV9NE7G6QQ9Jibt7SzwmfnXIag07GHq?=
 =?Windows-1252?Q?FAAVDGaK29GFakT1OeyauqU6NdzgZVgBLTY16Ut0LdEf6Rh6VWjGITTQ?=
 =?Windows-1252?Q?2i8Cnh1VKamd/FqjHGVgPgbLBNvCNnLxXibjIMJhG7jli+VmuIREpuJ5?=
 =?Windows-1252?Q?vNSesZ8ygGgFEtyj9D7Y/eLID/rejd3swflvhwGDuiTSQVW+gioPim2a?=
 =?Windows-1252?Q?15X3atAF9LtDEbhJwVdiwbjbv7U2Hg+iREmt5kvJQwxgXNhX4fBm+4zX?=
 =?Windows-1252?Q?TVPx+vIxXE1LHbjbRjhht4Oxkt31Noe4R7pH5cfAUEnZL4x8kofLbDPu?=
 =?Windows-1252?Q?rakShA0u72i2urWECq0zikq6+tP+My9p36sQRBphDRfVj7DzN1SLYlg7?=
 =?Windows-1252?Q?MrQu/4u9gE4fso5wGTDYf/PsTY1i1n694jW9I4ra/+BZ1Sko99QdIC45?=
 =?Windows-1252?Q?eK3vYIh23jk4Mnf3z18OA07hWDFmgBZokJx+/NGS7pYtdDrKtXY8HK/X?=
 =?Windows-1252?Q?fkknqb7oA3x3RnOzmfji39/foSOj+l1wOD6g9iEe8il2W9PMbAIDmF1s?=
 =?Windows-1252?Q?1ux6rww3jHCP5xheC0VtJVe+4VnvJNhLrXLTAuobMOq2/WQMYKzqn1mx?=
 =?Windows-1252?Q?RXN0qCF171orp+9kYAlUKeE4/L77luYp6/I0scv+YuQMgknVwtQfR99O?=
 =?Windows-1252?Q?ktfhEu5fUWlY35kdwwrBB7slPMmcS3Uy+wllXHFTQ1Pkv5hUa7TCiOnk?=
 =?Windows-1252?Q?mBDyCAo5yW/tEd3c/tJO/LJaXT8tKutPQ7XjIPUpJh6KJHo3QWyvtzar?=
 =?Windows-1252?Q?lWjMlIM5uZaUNmhTWG+2O66Y8Kw3Cg73H9mRzooipTGJPimvZ/lyGHOI?=
 =?Windows-1252?Q?eCj6f2mW2EMbhzjVfa3bbHwk1fLN6YCXebR0E4nICemC1adNezkBqRa5?=
 =?Windows-1252?Q?bi1nqw+7EKIzElde8ZKaHxWL3unI0l5Sc3qP+/0ANlcQ/mR0kx6Ized5?=
 =?Windows-1252?Q?6sW7ORYxu+RO6oYgHJsah9OfV8RF9Yyv7sxMX7qKD3uieLCtByGDAcsf?=
 =?Windows-1252?Q?eHWDMQez6H17kQEKMoLdVS8DBanyVbabfDAVafUpvPlimanP53gHWCeb?=
 =?Windows-1252?Q?Fq+cMSuo8wz6H5SSmYQ01XhVEXZR/71u/jtyQ/cmUJ/ss2Nr0MRrNMrW?=
 =?Windows-1252?Q?gJWCHApktwHZFwuMeM/5k6yK4oTYRvedptGe+E/nYUqHAS+vLk8Oc3eg?=
 =?Windows-1252?Q?kmlC3nGjBrpWHQj5dzWj2Vii/7xksqODxHr1feP6gEOMAz9NHZ7kY1qF?=
 =?Windows-1252?Q?HNf7sgrX24cTddTwY+gFF1l7KKTSXxutYTUaK4hKNtthccA4Wb9/L/NC?=
 =?Windows-1252?Q?r2OeOsNC668npFXcZ+VRK/5jLbXZ+ov9HygZc6FSeRhNvEtMNKT6Z/EJ?=
 =?Windows-1252?Q?O0NrtpTOxnGktX7JU2n3I0lxQBllyK+Z+4XAbM3Al5FLNP8zdeKe3R3Z?=
 =?Windows-1252?Q?6fpeok6duq+r1rqPV/WNuXHNnIK1qTBlP6/Ba+DEjAep7osxZcsFzFWy?=
 =?Windows-1252?Q?E/yqiRzlcX9vT0KwYQ9IY1Ujg+fZrk0SokvbtAH2J+1zjGc68Jf4L3mc?=
 =?Windows-1252?Q?2i1YSltTLO2rEouyHms=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9175.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?+MLHIUEThVRHJaIjqXJb+OlflYKWcON7D4eRSVRvypBJX/JJ2SGxxxgY?=
 =?Windows-1252?Q?X1AmMmwlAC3o1euIBHdu8X9YtI8furtNKxNMNLkvvJ0duLulTL01pIWv?=
 =?Windows-1252?Q?wpGBcld2jBZifzB7AebYAfEBRluzs2bK8uv8hzm4gP7ttxR3s6477NDQ?=
 =?Windows-1252?Q?/Dxy9PRTXABVqSYmjlUYKE43BDEMS37bc9SlV0TkkKL5Nfgtk0jj+ScO?=
 =?Windows-1252?Q?ZNec4sMdj6xy4Z59sLHVnwn4yFUb1Ak3TwYi0X1Q/h0WLwDgMp+jPVPE?=
 =?Windows-1252?Q?wvqG7cZEDwkk7JjH41KPA9erOpdLmUIuxfQv3iRgtfViryfirzyeVi7u?=
 =?Windows-1252?Q?HP1f61b8qS6CnNYrQ0xf9BcbHtq9ZaeT3ZNd/dg7UxFp8XTSlXa60wJl?=
 =?Windows-1252?Q?fn6m2S8xrGheyquAaRutqxMIe14earHGd+Qew81vyYP7nnsiG9k5w/OA?=
 =?Windows-1252?Q?OX4cZLKg8QyQx3BiaLpt/qs7KxKI/drONq+hbu7BNX7o+qlBl2QPQF5T?=
 =?Windows-1252?Q?rzD9vQtiS0L/04vDns/3eQwMDlAXoJI9WKeui4d7co034xQX4at+kB6m?=
 =?Windows-1252?Q?ACBPUMlP/fVbxCGpFViTa3/gUSQCvyXxS26EO7Ewh9WNIRAXZW28grHm?=
 =?Windows-1252?Q?yNYxvk9ElJJTjqRGtJfPwD3tJyX+Wa/Di7Z7TpCLZQR1BtmBSSj/NKPy?=
 =?Windows-1252?Q?QDwpiLc2e7eT1Lf6NwJ5zfQAE7+lg6jQnVckVsaBt/YZFQfVTLhgG367?=
 =?Windows-1252?Q?Uv944+2e1CvpJp4X5xpJ+JKxrzoWojtNWjnzE6dqo874lmOBQvfrST26?=
 =?Windows-1252?Q?rf9ae/YX/vloPQGX+o+IAjiCVgPlA7sORKK/cJNoom7rZ7TM+bpRrtws?=
 =?Windows-1252?Q?q3Uh1H103OjcxUUM5UHSZKigQJwGeZ8OzOy/W1HTTeGhe/G7drG2DFXk?=
 =?Windows-1252?Q?CwmnB56DfE8vWys1WHRvMmFH4qrA5G9P2/e/qFiHnJi+I+m+zkjTmWn9?=
 =?Windows-1252?Q?v123SF0qPPvEroYV8wjuLVYiusJDl16M9A0sz1n64GAqIXLRpjYdI6BI?=
 =?Windows-1252?Q?eGY95h1hWbLa2iEE3lX6UdnUt9GIi98cV2RM3PAm2Yfl7OZkLpK2XAp5?=
 =?Windows-1252?Q?iSM0mG3DY1wM9YFfTuApfiWjjuAzAFVqV+vT2SnHqX1/HTil9H5K3b6x?=
 =?Windows-1252?Q?EXMkOP3b4bzJM2ovu1Cwq9UEfF7tDgkqigGxVfMoW9rWiJhV0YZLbg3j?=
 =?Windows-1252?Q?s5JtkqidYBiW+kXWn/DQFYHXMz80N3sgV3HNdJN0s/Au0KELYhd6JNX0?=
 =?Windows-1252?Q?Jl7w6VqJYmYYsu0HOVdCZ6nPkZPD2hOmobf7cYmdHdFehad7yG2JoswN?=
 =?Windows-1252?Q?abXgMha06gHHjX/1iNGhFOgBc/sQ1uHd5rg8ZQ7zP/s/BuXaaIRJVkXw?=
 =?Windows-1252?Q?vla1e7CP6dPz98r5pVaKIhrmgwmqpnijSkbYgGLqznmSBgJoljbblUZ9?=
 =?Windows-1252?Q?mUk/lMwy+sq0pM3t8Bblx1eh9r4yVfhKWNvRmwgls2ldmqoUHZLlZijJ?=
 =?Windows-1252?Q?RT06Zr8SEGaFGOC5raE9LX34qOwCrZo+O6gHVxSgje+0qJs0tvwmAnvT?=
 =?Windows-1252?Q?f3btRPFEYWXqRJQoBLwxZXq+ZA8AdQYPUg4WKe0jXW1dYt+nKwFdvAZ5?=
 =?Windows-1252?Q?Loaklw8uznALKmRqLNb1WdcuceedRxdUu52ybY1etbf2s7jhHPv380Yv?=
 =?Windows-1252?Q?mRX7QyDZBtxkQpLWBjsX0uc0wdglSZxrr5QKOLpEaX/E2zVEyeHWkr8Z?=
 =?Windows-1252?Q?Y6Bu01FvO0ZpGnUmdmj2Xnt9RUv6eaQqqPl0IGoOSwoqXSSw?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33281067-e5f6-4758-d374-08de593b21f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 22:19:23.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9dmpYmZXqEGWAY2od4u1tOIEmpVFnwYT6oAGmU79zagiXfuxKwWfNQob0dUF2Fvd8ZEZG7TFrTukkDI+C1n3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604

=0A=
Hi Jonathan,=0A=
=0A=
=0A=
________________________________________=0A=
From: Jonathan Cameron <jonathan.cameron@huawei.com>=0A=
Sent: Wednesday, January 21, 2026 5:20 AM=0A=
To: Srirangan Madhavan=0A=
Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com; vi=
shal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com; bhel=
gaas@google.com; ming.li@zohomail.com; rrichter@amd.com; Smita.KoralahalliC=
hannabasappa@amd.com; huaisheng.ye@intel.com; linux-cxl@vger.kernel.org; li=
nux-pci@vger.kernel.org; Vishal Aslot; Vikram Sethi; Shanker Donthineni; Vi=
dya Sagar; Matt Ochs; Jason Sequeira=0A=
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function =
reset=0A=
=0A=
=0A=
On Tue, 20 Jan 2026 22:26:07 +0000=0A=
smadhavan@nvidia.com wrote:=0A=
=0A=
>> From: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
>>=0A=
>> Flush host CPU caches for mapped HDM ranges after teardown and prepare=
=0A=
>> sibling Type 2 functions on multi-function devices. The host cache=0A=
>> maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+=0A=
=0A=
>That's not sufficient in general on arm64.  It might flush far enough=0A=
>or there might be buffers beyond the point of coherence that are not=0A=
>flushed.=0A=
=0A=
>Until there are clarifications from Arm we need something like the=0A=
>agents in drivers/cache to do equivalent of wbinvd_on_all_cpus()=0A=
>(be it on a PA range to making a tiny bit less horrible)=0A=
=0A=
>Or we need an opt in list for platforms where a flush to PoC is enough.=0A=
=0A=
>Needs to some sort of arch_ call as well, not hidden in the cxl driver.=0A=
=0A=
Yes, and in fact it cannot be a cache flush by VA while PTE mappings to the=
 memory are valid, as the core can prefetch the lines back right away, and =
later evictions post device reset can cause device errors as the device sno=
op filter isn=92t aware of host having any lines.=0A=
=0A=
The only way to do this correctly is via a SMC call to Arm Trusted Firmware=
 to handle in a SOC specific way (after the memory has been offlined and re=
moved from the PTEs), since there is no architectural way to flush by PA (s=
et/way isn=92t usable in the kernel). There was a SMC call defined for this=
 in the PSCI spec 2 years ago, but was removed for some reason. I had a dis=
cussion with some ARM folks maintaining the PSCI and SMCCC specifications a=
nd the direction was to bring the SMC call back in SMCCC specification. Lik=
e you say, that can be a separate patch series. Adding Souvik for SMCCC spe=
cification details once it is available.  =0A=
=0A=
Thanks=0A=
=0A=
