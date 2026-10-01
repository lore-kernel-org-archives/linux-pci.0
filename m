Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01A446BEA
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852358; cv=fail; b=q8yPO32UCQYrMOcKXNNISRiQYxONJQtjkGTSr0UbJwZbhWLcUYpJ5t0OrBO9jAxQS143PAIcSOXATHoS53td3RgBP52xu9XWGQVJzr+k9iLnJD0ChTLq6QW3cfV2WRsxzZF6aUP6xTI0NMrhq+c5ji6IjnFktK5PmRhfdsjtOrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852358; c=relaxed/simple;
	bh=5g8OSbAGfTKg0eIvZj2+hcJm3U4gGVuNTnNoVMxzsw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yof5YRFCztIaYY9UOS8DpoTFecaLc5HLXC2NqpInY9DNOH6e4B19HfJXh73KuI+DMisnBhwjPdSEksyiTLQZpJe5jLNemmFL63WmQLoJo3RzXsQSKlh7DrOAGseHdhvZF1UehJMDltRJXVetBDewxtwi9wKklAur4NGkAyOjIEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWEsE5Vk; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWEsE5Vk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPLZLTn1gWEn725d8SWPpZ7pmjEsCE/ujZLdUoZ7OtEPLKwUkXlVxcPjUAb3L/j8agcn1E3UVfDGkg39ThCb7iQdAlEgtH+qxZgKych/gLDHbs80t1vs5Q1FsuLW3FI1lZF3OdHWvaQR3Avqgk2KznFF9b60EHl02UC8P7GnVgKPkOo+h10XhQtyB7B55mgo2yLeSTpu/jb5MMSjCoBaAsmM28kWgeIkflARIT8potGwABQVzoFti7xAknFvJNVFtDfSpnwg4uj5FQ7ir0kguZItFmlsEvgupN8+RWhPHp3FZOm6DsZL+W5NGWcikCd5VzLlbD7bsD5kuHSowOrpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5g8OSbAGfTKg0eIvZj2+hcJm3U4gGVuNTnNoVMxzsw0=;
 b=JAvEnCOVNwQqWtTRXGaAiJpAlX/aeqQHWBFCf/VyKwxUV19/LtgJBMIYntxAf2mFl9FwhgkHyUWeW8wZoffLEfwcwB+207t8GFSOPw5dvYwLZKC92T2tIOi9MBXPQZpgGHRzyJBKTNzZxYJvqFjL4WH3PXvkZYIb/SUfwtW22L16qG2IQsdXWqqZrolTV/J934W10G7rSc5nINvnyOxw7zI31WeaDOd3LgK16NzmHiVBTUV/ZpVyZoyEfLeQYarpUBHkWSNLdYfAuaaBZh+AXqA5ET+/T/tjqVY8Lj9FAWADk5JoyY7g1FDJdHxe8vPoTRrxpSbhZtKzBdV2OXFo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g8OSbAGfTKg0eIvZj2+hcJm3U4gGVuNTnNoVMxzsw0=;
 b=JWEsE5VkPPbYjpeQXGhqDifuN3wDtXtuTzDSq5wdU4DvMpk5/ZAsInZCkKP1M01iZiTKHzJ+PXn9fTotClhv6Tg0dYtUIdvgQn+0ve7AsLaWH69MSFULu3YQH1Lm5kTQ76pa0N9IQe2T60rzOMFDEuKFqbOphBVTFBsu/ng3OIkuxsRjT3AzwyVRkQlFpfREgbps4zMLeWRk2e6xSWEOU606Xdv4L+clOVpAvSejtT6hnl1XnJ/M+MpM7baHmVt3GY92RVqmCO5jQEV+NVAHMY1RDnGQQlKNaxTAgbIDk5BJ5uHWlbKY0y/GADTACQaFjGzbtiQUZWwCJ3+U2uiZ2A==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 10:59:12 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 10:59:12 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Alexey Kardashevskiy <aik@amd.com>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
	<bhelgaas@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Cedric Xing
	<cedric.xing@intel.com>, Jonathan Corbet <corbet@lwn.net>, Eric Biggers
	<ebiggers@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Jonathan Cameron
	<jic23@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Kai Huang
	<kai.huang@intel.com>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, Lukas Wunner
	<lukas@wunner.de>, Luis Chamberlain <mcgrof@kernel.org>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>, "Fontenot, Nathan"
	<Nathan.Fontenot@amd.com>, Fang Peter <peter.fang@intel.com>, Petr Pavlu
	<petr.pavlu@suse.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Sami
 Tolvanen <samitolvanen@google.com>, Saravana Kannan <saravanak@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Will Deacon
	<will@kernel.org>, "yilun.xu@intel.com" <yilun.xu@intel.com>, Kevin Tian
	<kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH] coco/tsm: Update maintainership
Thread-Topic: [PATCH] coco/tsm: Update maintainership
Thread-Index: AQHdUGn/havQaFXnqkaBs9dnBf0zhLbnbD+AgAEZli0=
Date: Thu, 1 Oct 2026 10:59:12 +0000
Message-ID:
 <SAWPR12MB999267D1EF00DFCEE416F0C6B8B08A2@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
 <db704e6a-f43c-426a-99c8-c5b8298510a6@intel.com>
In-Reply-To: <db704e6a-f43c-426a-99c8-c5b8298510a6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|BL1PR12MB5732:EE_
x-ms-office365-filtering-correlation-id: 2409365f-64e6-4459-f2dc-08df1fab06ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 DfzcjhXVljGfQBj8bLztPJ/IJt9LrGoia28/MXIi6fE/wYD5ndItTmMUuWbL8KYXtW3zLcW0C+VRutYyZOlifpbfFLRc/WiMpK0VnKEi2ZfcmpIjMtm68rD8c1sVr4nCpp3EWaMCcXSXVrShvHNXncuRpY5BupmADJi+5mGRQSLiGQwO25fnJ/oo+dCNfkfZ3N9iG8FlOyHvz1x/6kySZep8fzim+s10LHCxg4mSK7TlmsV7mlSUqmyecytT/6Y9ds/WeDzknoOeVTBgDvkAjHu7eTzrZURG8F2SWsW2lI3uovKDkhgELBQsx3NReGNvNSMLvZnTH0roVhZ2nfprx1prCVU2VTHuQgvSFp+6R4b66t+Gt6wgaLjlWSIYnyCWsgrcga0wn759negK5w+Gaej9mnhaMw3HBa/qGjbgBu47e534YsAK4iM7Kq/iLhLyx7GL3ZlORVfeJPKnFfPe/+RExty8X0O15yMJWF8JvfxanA08jvc8uexLOe0Y48AH7Sx8qecTUOdOBVGm5auvXr1mrBbnTC0zZBtkU1dv82UOCVFQHmrewIu1gQVm2An+JF1F6iwQ004R4277rkO6BcqVQsBXUMc043lTRJh1h4MIlzAp1mcM1rAcVr7JLns22cACd2tc84G9oY64e1WdgLVVTlIjZsXnfcVnc/sGiDhu2N8o3LiU52VWuqn21el7HAg28FYZhNLR6i8Wwc3qVhhU8lNECe+Ty3CWhgA57x4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qXVJiRmDuv99ykqkteSnRC6XZeiu/DpVgUzeRc59wghdnvnIdeMCLzbu8F?=
 =?iso-8859-1?Q?qsZw7qQfgLY0TxezRSWEddMJFwZIG+kIFJB5tIJUAyI7mDgY0PUvYpxm8h?=
 =?iso-8859-1?Q?yLuTue2n9Deh4VdD1NkafEIaAuNMuJ8Pb/x6QzEBeRpRo2WyGIPMnGUKio?=
 =?iso-8859-1?Q?C3D6frzZytMPaKMvgkImL20w1rF0pX+Pqmq3uJ10Ohtj92MHELmqUsndER?=
 =?iso-8859-1?Q?m8JVCUZjbSawdW6k+nRVuBNHatZT8/37qRkYf0xL+qwfT8ruGbAtj8b2/7?=
 =?iso-8859-1?Q?5g/LEjTdaZtyPSOQY2Jq/4udCccB9Cnv17RMB2ItAnVDQLqBef/N1GTfWm?=
 =?iso-8859-1?Q?V42zac7KTZywxHc0PS573C9Ctus+06BX6mD/xljIAQyXf3Ch40eug5k9Kd?=
 =?iso-8859-1?Q?vZ+rEcYIunbO7s4JmheIWSY6AEfeGHEGt2yxcepulG+7Exjac9uCyIUiv6?=
 =?iso-8859-1?Q?qCsqIeV5plB31im/mUDlDvdZnnHiveWuN8hahPv5AYT0sfbEXRUnIwTHGB?=
 =?iso-8859-1?Q?OqgKMqcwmIdU8aPfNA1Y4VZXmIjKpZTavz9F1YdFcW8LAv4nnPeXZ/GWPg?=
 =?iso-8859-1?Q?wsxk4TQhloFzpXB4EqN3jyBDtSUJXgG2+KtZ/TmUIPhAhwiI5Dk1qJr3rq?=
 =?iso-8859-1?Q?BNTLXNIK09Jqze3xOZlubRORv/TOhybnHGNwi6YRNAx3+gYBFqxrwW+rfc?=
 =?iso-8859-1?Q?iHqs19L77HWpOYZsnBIXU0/86CRVeq2n24+cqM9qB5aA0jhHAGLXOr5z1C?=
 =?iso-8859-1?Q?VjtIhzjX7x3eUzqiKYN29eqwfzXwJb7cPt+23TJXpteN3aSnEtZaY0p3KD?=
 =?iso-8859-1?Q?w8lyXXnKswk/9qjoml68o3O6DOpvwaK6sdNhCeUQt/FMcuW+7mmXlNt7gb?=
 =?iso-8859-1?Q?wCwCsjshk7Ewn7u8xca1DLSSKCE8gDZ2RNkqrPqSlWyVzLrNUpI9pqyi6h?=
 =?iso-8859-1?Q?Ow90q6nqLUx4o61yxCgXDJ4WUjfm2fMiIDE+K674eMewO+e6a4+fsrhh4d?=
 =?iso-8859-1?Q?0tozjVzjiO3GCfeIiQHUEbi43NRI2qqB3JLIocH/Y24VsCcQf+J+w4hnjq?=
 =?iso-8859-1?Q?K+iZnrLuRdvVWo64W68R8MbdTkigW3Cg2e+yvaYPVkYK9rMQfi9kBD+ZC6?=
 =?iso-8859-1?Q?UdT54Xg+opCcIwB1kviG/xI/OjfwsE/fkhWcSNR7PruzI80gPZXVe3jKyE?=
 =?iso-8859-1?Q?FlZn/jZWiCFXSLhB6WhD6EWSSHFVmB7i8VKS7XjLgJlCVrL1UYlIt/S0Iy?=
 =?iso-8859-1?Q?Xvd30n9uz15li6UzByWKCgX8WecjVdTICUpBihnRh0si+wXyn0btUGfc3j?=
 =?iso-8859-1?Q?VPnCQtKebDJ45zNy+EeR0MI+NVpQXfJjRVZ1p6zJbiuPTnv77TnEg9GKH1?=
 =?iso-8859-1?Q?tpymOuFJFl2m1i9AQ+LUwVMENXaIEvyc1NTbhDIgh6Q1zezdFeM776AMDX?=
 =?iso-8859-1?Q?g43c3m0fh2r5YvWzCi4b0SoJHqPVZ8yR3j1ORv3KqgyqEe72Whs0CRvEJF?=
 =?iso-8859-1?Q?CLkrodzfTcKlApojpdU6aoD2uTNSQau/2Wq11UResr3WZ7UbRvY3nHKmP5?=
 =?iso-8859-1?Q?pBPOshoaXQvlMCNjmZv0XrTLUGXeT1sEXIas6OEii3oREr/jH6Xr7+Ro/k?=
 =?iso-8859-1?Q?wsLXaM3frAWwRnUk1VoJkXdh/M2gO9fvjG2lCq2fSJyR3xjuJw6ZG0c0gZ?=
 =?iso-8859-1?Q?oUVkW3tp55z3NeOhHDopb171tVViu7yuoQey1Kl80Sy1YbG4I2TMsUisU/?=
 =?iso-8859-1?Q?pe8fcFPg26uh1kQHgTtanOTcI7bBlF0kydPOU62oCHeEPA?=
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2409365f-64e6-4459-f2dc-08df1fab06ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 10:59:12.5799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5/Koc0ItuKdjlYOdfc5gQTlKkXNm2dGP4sUxMpFcfOVsShZLXqLQeAvDoT0uSCR4zPzoYxrAVmKQO9GHc8lRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

On 9/29/26 4:26 PM, Jason Gunthorpe wrote:=0A=
> With Dan's passing Aneesh and Jason have volunteered to take this on, wit=
h=0A=
> the support of their employers.=0A=
> =0A=
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>=0A=
> ---=0A=
>=A0 CREDITS=A0=A0=A0=A0 | 9 +++++++++=0A=
>=A0 MAINTAINERS | 3 ++-=0A=
>=A0 2 files changed, 11 insertions(+), 1 deletion(-)=0A=
> =0A=
=0A=
Thanks Jason!=0A=
Acked-by: Ankit Agrawal <ankita@nvidia.com>=
