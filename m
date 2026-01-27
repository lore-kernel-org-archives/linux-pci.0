Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3D1A9F9B;
	Tue, 27 Jan 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537247; cv=fail; b=m1i+ITNlxcfLNZ8EsB4pSs+q07vBKIOjgFllSsRMU6Avb3HKgHI76sjaIDfzRyYOJezNTCNhJYmrzaUOltvYTK+kogKs+CfJKf8VqMp5mN8SOSBxe1psbrjWU5qgWCH2sCi84JCbK2ocVLQU0DwVCknqQu9IfuxHrj6eifOmH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537247; c=relaxed/simple;
	bh=DKFjAuF89MJSJHUFm89vtgbNk3gv9N+YkR9A9d+UICo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tD2+D0Ui4oFMoQeDN5Oy6Wb5ijyBpv+FEyFBpYcAeYP4jFGc3jQOQzoCPlViSOCB9La5b43aIGQk8maNbWZiLiSyT6Q3F18/908n2Y/wQM0C3OWy2csf5+UfX1hDRC+aEyeyJc47kLd4mt8TdbVGUVN5HJProoH9y50blkgU9R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Szh7SFON; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Szh7SFON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itcc5ZXuI1e6HFiMYvSSAGMMWeTDkK3Ov+YZzknT5KW7MzFr4G8xbNKUJEYPsejGsbtjXM0sPv0G4NKv86DPLrJJTBda29AhzBZGmmpwcwhP8t5DN42tsBbOltVUW/h+qEVS3bDbnZke4TG5UoDWECERmspolvUBg3q3EXEEtDOnAVMkqCZaALkjXhUiyUuAHaucBUwpisWjQiVXihu4QQSQQTE0p3MU9sABk6RtGJpEHNNTinkb3GXT00DSwCtTD8W3EDkZpIkcGEbz3PW/M+eGKIcaeZgv26TrBGhduVEsUdBm2+RLWky9p/k1h4+gkafGqjCLFdNw0aAdl4yAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRl1PCa/FiEKzsodS7hmoCy/Q7+zQRlG1G6HUmz5C6o=;
 b=K5MjXUx34X1TPOzU4CvGbU6umDn13vilkDNz8x0TL9CXcZGP98u6Zs67jaiSXlCmcDcECS5X/h3YVVoZ5geR9p2m2pXZG1PRfpo6Bfu2a1enM95OxhURGMr5/CTx/Iz2y4c/hwSKVAe5fEbLDvN36lJf/JT7ZSy24nUd6a+Jx+H+pmTmA/FQvnvHuH7kxygaPbP24szPkqgefVeDM9qtzLH2dDKgm0R/HHX5Yjy6FzU3qPfNXBtz2VFl9L6upa4riVSB+4n3BJtIObPOS7hwgtCWdrguIddAjrHeOnDXmrJIvVZwdimmMxOWBH5gmEVB4RK1+XkYJz6H9fms5xjOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRl1PCa/FiEKzsodS7hmoCy/Q7+zQRlG1G6HUmz5C6o=;
 b=Szh7SFONfG+NP6JSGdigooHRqQ2Eam/GJpMJthVfs5mpbsSOkbbE6rETh/YaMHj/W8/VtV2+ZozPDNMNKwS93ww2wCoGKZQPgrDnRpWIAtETXaPrTNKF6pYXXcrPNlNcF+dQyh318PEdCev6ljSuIckaOQWNYTfFU1zYCmHlWD7m1CPiFvZKKxe2AjhdAyBDNPHF4i7w6fGfcXOPOU9/AMcu0wkamADB2mjpK67ScamyKQGpmiJBIWo4QO1BdTH1hwxH8TaR0znCPKDavU42uasgZ//PnyQgW8sPRKvL7lXACCYcWy0w+L283pVKLTPgNLxQLBxHanPtS7IA7NiN0Q==
Received: from LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:07:21 +0000
Received: from LV8PR12MB9182.namprd12.prod.outlook.com
 ([fe80::656b:e9c5:c58c:49e7]) by LV8PR12MB9182.namprd12.prod.outlook.com
 ([fe80::656b:e9c5:c58c:49e7%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 18:07:21 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Alex Williamson
	<alex@shazbot.org>, Srirangan Madhavan <smadhavan@nvidia.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Thread-Topic: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Thread-Index: AQHcilvcahaWvJ6o6EiFA7xz91FaAbVmQK6AgAAH/ICAAAZTLg==
Date: Tue, 27 Jan 2026 18:07:21 +0000
Message-ID:
 <LV8PR12MB9182DEE18D9F83194A6E0034BD90A@LV8PR12MB9182.namprd12.prod.outlook.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260127093343.67715d5e@shazbot.org>
 <6978ef9919421_1d3310036@dwillia2-mobl4.notmuch>
In-Reply-To: <6978ef9919421_1d3310036@dwillia2-mobl4.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9182:EE_|LV8PR12MB9271:EE_
x-ms-office365-filtering-correlation-id: dadc4a1b-0229-4c72-c627-08de5dceeabf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nP2hO0kVt07LZTVUGtTqWfYfbxYNh7JDAbY9SYCI07i8zuUw78SVb3u9Oe?=
 =?iso-8859-1?Q?uqJf3PN+ARdmojYcHM6/cmb4yOCWn+aUtZvGfy3J0aQLrENwzVQK8AcF6d?=
 =?iso-8859-1?Q?6eM7kmEBRZdB4YQ7cF4OFqVV/rlra4UUBWH+To8m+9eLmI13y/zHKrvKcH?=
 =?iso-8859-1?Q?RXqcxK0RfeM2arO6AU34C0HBA1Op6v5VPBS3k9/ojnNHCrci6FOCx4WuQS?=
 =?iso-8859-1?Q?Ywaz3BAs0/m9CSXdqt+50Unz/KjOhc0Z9p1fU03T2RbJehPxIVDbOUMTT/?=
 =?iso-8859-1?Q?tjY+e79xfmi0jB8qYxiZJnpPjottBlEPon3PJGjG87pqgYg1P6P/nUkF6e?=
 =?iso-8859-1?Q?/W+pJXx8MP058wPdsFwSK9pvsTUm6YBYBMS5ms2g3LmGmk2Hr5eI970znj?=
 =?iso-8859-1?Q?7Fmb/9LH67bzS8BfczDrDrFg2agZzbCu6L6lwOfM5fjmdwXG6/TW3EN9NE?=
 =?iso-8859-1?Q?UdubPqe9VnUGuKhM7YRluQin7DMfX5u0la9WmZIUHERYhYA+8htg1gmU7/?=
 =?iso-8859-1?Q?3jGec+tuNZpt3r2956Cqe782WYDzvEQ3+rYDOnDgVA0HcbSPThj2i4VJ2D?=
 =?iso-8859-1?Q?33ogPAeRet9n3EPgQUJAWDLgKwIQhMBq5c6Cpc8YTgCBXyDlrVVZUiZiTD?=
 =?iso-8859-1?Q?qdD83gPX0lUmTBlUI5zTc06kE/snW73EIPl1gMxnGAw2W8/jTtQyV2wAfJ?=
 =?iso-8859-1?Q?dGAhK0LdScpm9+ND+2ZmaukC3WrQ0G2+yGDjMjc6tSM17P8q648622idFf?=
 =?iso-8859-1?Q?WYSuNV9Dty+m6i+VqqGtjLNkqsAW12qAKe/nXi8Ab+B+/kDFLA9paMxpUO?=
 =?iso-8859-1?Q?sVq50wgjXc2dgqjiGbLKXQnO2OLyOTFREdumtLfW5TQDm7DC+2CuDszH/b?=
 =?iso-8859-1?Q?6gc9XuRZklfODfi1SNwnsJRknGwYXgNqiP7SZsv3prOWELqHVjpYTKHIY4?=
 =?iso-8859-1?Q?VXNcPJ3IdUJFv2BOpRXuOinps3xcZUv47wOPJDOc0rWs73YVxO5n/9LyQf?=
 =?iso-8859-1?Q?N4nPZlmZDow1uki2sg3KgdaA9Vul+czcwsoefs9qkgzNkGcWRqaCkCBEAz?=
 =?iso-8859-1?Q?tSZKTrXu0cr60tf+CLZ/AidPmBZbtkaQOCbYRtaXrSoP8EZ+OksGcPiRuI?=
 =?iso-8859-1?Q?dgf1ATF9fqWboOKPhCcsZOjeOp/uSftkYs0baaKkrE+nZ34gaRk25Npnys?=
 =?iso-8859-1?Q?1O6aKKYS4ICdbZ4OMSIR/M1g2Z52x0G5KIpJ781au7HCO/jucO+8AWiEhs?=
 =?iso-8859-1?Q?U6KdCoB5GlXeewSeoymkQ30Xq7Cqkreaj/x0oaSm7VLZuu1O3LGgJKf1z3?=
 =?iso-8859-1?Q?E7fuSPtLZJ1cPPAOeaDIQyrWSkZ8biboMGXUr28D0f1gQ6hX287teN18sV?=
 =?iso-8859-1?Q?XcXTqwwDLye3oPbsUvrDu1vhyLrYsvU6eEOr2Sm6Urznl5uCA+/w5zltur?=
 =?iso-8859-1?Q?5Y3PqLv9Fgf9RJZutw/fQbdFDHkh4TnolNNU2HsscGX1gYuDP2ZRdaU4qc?=
 =?iso-8859-1?Q?3+6XpGrQaeRpE5bKrj8DFwEF/ri8IWA0RpXL86GhBY8FUkBpcBo+HNPlM8?=
 =?iso-8859-1?Q?+Llt8OPrW5wgtga9MFXA+dJts+WQJK+oZIi8JoXN+/DUtOzOrnoJNgUd6U?=
 =?iso-8859-1?Q?hX9sc/eGrdUVEeEijKlCRnEIOvzkFK3eDLYADPKwE3zBfwcPd5NaLShux9?=
 =?iso-8859-1?Q?P8ChzOAmbetMU7D4+FM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9182.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RYkpELA8yZsfSNPqTcz7QHcd9H/N18eAIdv6gghoH0tIvaj/aXKbmv7g3J?=
 =?iso-8859-1?Q?qKpaWprnGL3wVeOl6rAN8NADCq7+/Ss/QZ2NL6QYOlpPjVSqnsrQXap2Ho?=
 =?iso-8859-1?Q?zNnMJ+35Pd7L7slllvGTdXm6gm44O0JFxq0sPxBXhqR+5y680x7Ncr+NtU?=
 =?iso-8859-1?Q?MHoGB8ypG5wI5HaDG7vESRVEuJutLuZVkSuQt02U+ZaC9nViMUrtB2pBvR?=
 =?iso-8859-1?Q?e0x/69oXyuXF1WnZ4V+/asNkio4Z5rCeMhT+ivMOTwCgxj8ysBcok+i3zN?=
 =?iso-8859-1?Q?KmvwxJVND93hGmw/m84ZZNmsKMaMLqTSXV6UVnPkF4VBRnzt1tEt0ulM3S?=
 =?iso-8859-1?Q?uMIi9tdH+BBf8amSjfQO5UP8VPnpi+sZl/dtpQYFRXYOXc+uynieSnzoQr?=
 =?iso-8859-1?Q?VCPRdHvw0Q5E2JAF0QECgYpDmqvH+LTJOFJxYtpEEcM03hwKpSpoKOtFmm?=
 =?iso-8859-1?Q?ixvxBkATnuHEIFHCxnRpn1s90iL7sH/0Qccs0S/XAJJyHTDHM/CvlQAm1A?=
 =?iso-8859-1?Q?4fKKjPEXROMZ+7GWrbUg628jsQkThzNpg9fLplE4hOaVMAw+pYf604VW3C?=
 =?iso-8859-1?Q?urZeCKG5/ojA195pfVJsiian9L3/hwUSCmeWsahzeDYscB2OJXuWSrkM0+?=
 =?iso-8859-1?Q?JMiIsh2BONato5N3KCBCEaSNCvfri03sGcWGng5YtgAD7hOdYi5Cevm0QG?=
 =?iso-8859-1?Q?nVRjjWr/4vDtms6Dp+HxkCYdCIqb3vDCT38iu6Pv1JN4+0Ucv7WGx44hL/?=
 =?iso-8859-1?Q?vIrcIRZrnH2Zba7ac87lKiHTacVZbWrJ1B7N/C6bddgoxdExXkAw4S1p/2?=
 =?iso-8859-1?Q?z+T6Fb245AK6lNqvd1bNbt/nXM414L1fRksC7SJteivqoEntEC+x5S/Z6j?=
 =?iso-8859-1?Q?n6Wox77SetgltUstKVTwxjR6FF99QF9fh0tNYhqOvNV3EtE5uJhiIMxh3y?=
 =?iso-8859-1?Q?l+v2cRKcGaZ5c4+iGjddBn8QYyNOgFmOHkq+UurfiPDoxu+1RJbwwonerm?=
 =?iso-8859-1?Q?BsmyqksJFi3No2wXdo5bCkPFAbqKLdom+nKe3XXunn8ZzE03xM3NUO73K5?=
 =?iso-8859-1?Q?2BEY9mAjyFvpWMJWvY01khz9Ml78L50FkW5vI8s5VDQ4WdkGQ7pw43Z1FP?=
 =?iso-8859-1?Q?VBYyJQEudl9TkUQIG7hNe+ZXMgBUXJevO/1+YkPZzMIqnNYDC/OV0QdkGd?=
 =?iso-8859-1?Q?/d5ugEz39C0FNS2KSIUefuqHRwVKQ7oBKmi5c0K0/c7QFmDrRpqOHuV5QC?=
 =?iso-8859-1?Q?Z95uICIE8izS5suifREsredF3+aI817pVAZLlbaEmUUAh5W1LMvtyQ68Uq?=
 =?iso-8859-1?Q?0NXmkHqq7sQuwEbiNAyL/d0DHonZP4eukR2rBCh0gvR493UwUSAlGLcpOm?=
 =?iso-8859-1?Q?gLDFUWVE866IAmxi/WP5ASHwcgdPeuJaz8itEuoCHbXKEji1mXuzGClGjE?=
 =?iso-8859-1?Q?nPmWl2MUW4WkOxe+TOAwVDmtsWtQTpt52lZZH7NYwydbc7zYX/2+wk5xEJ?=
 =?iso-8859-1?Q?hbDbm++CYRGIKnPmVl0ue/LIp2sBs5szNzv//8zjwkA2cT2Kdo8Pb8wLvB?=
 =?iso-8859-1?Q?IIcOyWcyQfaWYo3cjXlfJN8KvErJncM+KcTRHyJaJrELVML9waFxoypyh0?=
 =?iso-8859-1?Q?9PGka8KhhEdhThoXPtSAqZlJLMg+V46M7NF/irFjVHgDLot6rSDPFtrCK8?=
 =?iso-8859-1?Q?fqVzKa+zLw7FQ4Aky3Sjl7cgvFqzU/zXPjQKDUsNL/B1DBzhsGjkVlK+nL?=
 =?iso-8859-1?Q?ukYtzLUSvupKUklDDvcA8X1hZ7wEqjQsva7NqhCJ8aVFc6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc4a1b-0229-4c72-c627-08de5dceeabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 18:07:21.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUKiQlQeVSBe6udBYzy69I28wTfuZpbbI9+PR4WBnsEPOUYIuEqx+KTBNJgyiyZgmoj9bghrb0+oYgvYjcthMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

Hi Dan,=0A=
=0A=
=0A=
________________________________________=0A=
From: dan.j.williams@intel.com <dan.j.williams@intel.com>=0A=
Sent: Tuesday, January 27, 2026 11:02 AM=0A=
To: Alex Williamson; Srirangan Madhavan=0A=
Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com; a=
lison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com; d=
an.j.williams@intel.com; bhelgaas@google.com; ming.li@zohomail.com; rrichte=
r@amd.com; Smita.KoralahalliChannabasappa@amd.com; huaisheng.ye@intel.com; =
linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; Vishal Aslot; Vikram =
Sethi; Shanker Donthineni; Vidya Sagar; Matt Ochs; Jason Sequeira=0A=
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices=0A=
=0A=
=0A=
>Once the protocol error handling series has landed there is a potential=0A=
>to extend that with CXL Reset recovery. However, that needs a clear=0A=
>error model defined as to which resets have a chance of recovering=0A=
>*system* operation when CXL.cache/mem fails. In Terry's series, panic /=0A=
>reboot is the recovery, not reset.=0A=
=0A=
It's not just about CXL protocol error handling though. Type2 Device passth=
rough will be a common usecase for CXL reset (entire device is assigned to =
VM) across different VM assignment.=0A=
The cache and mem of the device must be cleared via CXL reset for full devi=
ce passthrough in addition to the PCIe/CXL.IO reset. Another usecase is whe=
n the device is reconfigured either in baremetal or in VM for passthrough u=
secase. Such usecases often require a reset of the device, and it's cache, =
mem and not a narrow "memregion" reset, so I'm not in favor of exposing it =
via CXL.mem sysfs entries. IMO, device sysfs attribute reset method is appr=
opriate for type2 devices.=0A=
Finally, there is the error usecase, which in the common case is as simple =
as an uncorrected ECC error in the HDM. While not strictly necessary, it is=
 common practice to reset the device in such cases, to recover the bad page=
/row via PPR on device reset. You want reset of the memory controller as pa=
rt of the CXL reset here, FLR is not enough.=0A=
Regarding scope, and "recoverability", we have significant experience with =
recovering "pre-CXL" coherent GB200 devices for device errors: memory ECC o=
r other, by killing the application using device memory, unloading driver, =
resetting the device, and reloading driver. The CXL protocol error series c=
an use CXL reset series, but I don't see that this series needs to wait for=
 protocol error handling to be merged.  =0A=
=0A=
Thanks,=0A=
Vikram=
