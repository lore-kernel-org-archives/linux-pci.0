Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29538E8C7
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785953530; cv=fail; b=mR1IUkomi7OWS8O0hf5wBTHua8AfdXjq+afyroyJO4TdF3R/yFofDZH/wdcz99gRng2ElsVvgxo/8vXGsz8PESKZlma0i/7nDVzk1dOikeM7qnjw3ozzJMwB0qOsvezwh2xO5Fs+lMuoT6rjvFEFaJctCMSUztd9mx8bGqE+H0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785953530; c=relaxed/simple;
	bh=hldtvvj54tEJTzlg1cuzNiRu+Hs47PrsLDenJkPfP5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ev/bsLlRxombAvS/UdntAh5dZd0moYUZe5vbb/z9qa/nP2LW/S/78kEZ4f2NLOEBV+djuVi8SWInW5fG6x7jsxxR2cr8Ey2zHVrc0jRlB6kCq6HVfGECkcYUfYwWFR79z8yEjDglvruVGXqy/m+pxvN0N+Us+ftH0Uus40EdqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SUKrXDbB; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SUKrXDbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeetEQ3LwPU55GM8fnHZDzWTALta2MKeY19HP4UUKl+f696A83hECzKr7cDzcCk5slNw40xPq31vL5sc1pVKGrLHVNyDe65Na+BIBw1jXD7XfKKsKfgzB9igY47ofXLgEvaRE7xJaEiC+NdKh5FCnaDexXpWHcAVP6gx0KBnP0LAu6BFR64im9avIvW2pV7HkcNcvuf4RpFiL7UBYgeTrP54T+PRL4j3RRBAz8t/ckxPGVfLUpmKC4mv2b4++MarrZ8V1lj5j5g4M/TXrw+GvJQvv9ZLJSX+2jqBFurK91FydJGhbCj30ohF/p/tcNxr6+LIX2mp/lRiQhSYI2AmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfv/g9b1CaxzeUQIZZSRqWIV13/IPwNnomtZbaBNQdA=;
 b=J+QQKagPOKWma9qb0s2lRDSCsjqEMrDh8p1IlKc/GFGpwggIw9KtkU/dTpxP+0BX28QlRcHFALnC5sYKDrhq9fFZAR0WYLLevi+cCwpdigylmtivFwNfx8BKWPwEgdCtsgEHItvsw7w2eU7kw27XC1X+mvp91hxdjRkjyN7kKd0cdazePgjrQEOUuW24Jp2CxELG0Q3nB/bZQRekyKrpcX34hsl1CRd0dz+m3X3tFYZD+PHO11NXtIK06C3AFG64oxKeTPH3Qvs1KG85uhsP5YHnn+O1rng1WAaTxFQcRuuE7lAspv0abX0OIl4VmHzW7zhPRo4rF5tnHFbt27gYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfv/g9b1CaxzeUQIZZSRqWIV13/IPwNnomtZbaBNQdA=;
 b=SUKrXDbBI49UjTZ0OQ39L0orDxhB1nVHb5yaV8azshcQnvskh7LJLO7d9tYo/+ZgB9ji8FsDry9UnepmayhQSoG0p2kjtpRMHnFlVADUbJfBz2J4TNo5soWXzGjX9BXuFsR5nXX7aP6KyjtT4h2dEdo2dnwIytzscd10O5ylKdw=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 18:12:05 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 18:12:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Suthikulpanit, Suravee"
	<Suravee.Suthikulpanit@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: RE: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Thread-Topic: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
 only
Thread-Index:
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCAAOUFgIAADS2AgAKVz4CACMDmAIAA4oQAgAAtKPCAAAlpAIAABJCg
Date: Wed, 5 Aug 2026 18:12:05 +0000
Message-ID:
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
In-Reply-To: <20260805175308.GD28508@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-05T18:09:52.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA5PPF9176ED2F1:EE_
x-ms-office365-filtering-correlation-id: 9307b261-8374-46ad-0d05-08def31d0e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|4143699003|5023799004|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 +2evWL2MCgCxNh4kDf9gd87pTsFv7aZWbASFeUO6Va6FnlzXa2zWiENGrL5L822u0fsotHlFbm67n9wAI2GpAtgD11IYjcruUO6S5WZkCb69UfuXn1fAQco+MyfB3hxHiE4RffjkE8Pnvj78fx5NI7E6e6DqesmGR8UqZG2rxXG7JLVfJPATmz4/tw/MscozFYDSb8pwHkiuEr+xfT7uGIW0pzNPCEo7V/OPvjCLffbT1FSnNkAf5/1P7IqgG1dgOHmLI1eXze8nN6KdVI2sB4p1IS7hzPsUXv8GOXRjapQqZGpmFdMnuryKgXuLmd0GvzkpDvRzD0d135MXWe9KqaqswQ+evVjP0F0b8T/mtAIwZYvthrJ739kAbwG7GDJ720nA0Cvk/0CrZmd1kVgZPD5sBL+Kpgbwqn3SNfmPe+PlsMbVqejT6dMA+zsaHPqvuPt76AWzEjwsE/EIA5avlzpDk9G5MP9EEEKdZbWWVEWxfdU0Aas133W+De4XwuvxWfDV6NExHxKN3glOZeKjk96IoKWfOsHmLw8IScsRknYSS3NMIvO56pNItv53qZDoPwF7LRYk6Z0F0FSYQKUKDyWAHgG7T6eqX9wGeWJIawfb8xgSQAm65ROFlhiE3iFCMRvmADhC5NHUEm2ZY8IVYkxtWdi7sPXScG5tNl7tDggbXRWNSkdHv3IxUERcv2ayV8kn+kl/BnlGAAawmE3tHkSjsFrbh9/rpmT5iqUWNSw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0sxY0Nmu7SKOCnmxQSa1rvRQgP/l5vtGY4WH3biKFHVmHjH2hHppCT31hEF5?=
 =?us-ascii?Q?N9iB7tpaAO9bR133BpFdSO/GV9TwcQRRrZ8lVA/iFrBzaH7wEn4zxMbPj2Ry?=
 =?us-ascii?Q?V701snQC0eO7RVsFBzkQZkkoCYvneAXESb4jsKt7LgKIb78MQpupU3A83tgj?=
 =?us-ascii?Q?H3TvYfIsVf5uVja5aLDaTxvku+ffNmGyYfAR75lQxfgJ3Tw5JzWGm9eGh12l?=
 =?us-ascii?Q?VIVFbZvd8yo9Sl8eTV0kUNe6g6NWvT5+hUWs6egbsHoXc+EoHlx7pY9WSBKK?=
 =?us-ascii?Q?DjZsbq3qMBPygJzsCbhJRVAIXiAhHc7Y4dEBqlV42phi+1XTQzmlDo549pq4?=
 =?us-ascii?Q?58mklZkp5bHW1LYYULotLSKXWEk+dt7mJ+Hm1EEjwkx/mPsTv+ja3i4W6nCd?=
 =?us-ascii?Q?LupYFX7To42dsESOM+2BmRZnvjP28NnY8ISd0WEfGJ3v8STOhXLpD15ZI6kj?=
 =?us-ascii?Q?z6b1awVEg3TGjfPCxmSt6BM4UoXNU6dU6eZrxQiLVgkCNm+cMWUc6gas0au9?=
 =?us-ascii?Q?FrrHLn9QJqP9mqjdlcdlHuz44DOQKPwvULZiu0uz0DpJqAu36Ybbz9VnWo4v?=
 =?us-ascii?Q?ERUf/g2UBM7Ka8AEz5QwhDKVpEyQBPduY4hTO+C+uT1yzdSFWaU541ciu4qc?=
 =?us-ascii?Q?9uqUdEthQ8cMAOMeCA1OYFa4AvxgIkK82qmvORubWFkGbGLw10nhmhD//ii5?=
 =?us-ascii?Q?0xVORzGT3Kau59357sa666CeXRquqNf4/jqRwSmPQwLcorUy1L1ybdfrqOof?=
 =?us-ascii?Q?1CO8X17E2qf/KpePqLdsqsbLkRKqGOmsNc6ROPTFLte16VRxp+a+vgmAWJ1E?=
 =?us-ascii?Q?I9PTJg7RUwgiRaimKz2WgF5u7+mGzgW+B9Xy1iu95v9shGmjuiBKknePfdyW?=
 =?us-ascii?Q?qLRaOeQkAXyIAq3dVZo87elYkPoPFKbrmc49h21JIwE3XyEPcclRM3ykSHi8?=
 =?us-ascii?Q?KJKEodgKX8+CUrJh1U6Y3vcjFhXGTOvDkI/MtaUWLroJ9/m2v1AEpDd401jN?=
 =?us-ascii?Q?GfYXhkPzfU/h7ia+sA+2U6WDj8RFG2yLzUUGAPvN/tfiJSoxyRYculHo8rkX?=
 =?us-ascii?Q?P9LOR0GngP5Y0BB543oo6nxLd4UptNL85dy4Xnet5aF08XEZaGaT+5H5Aa86?=
 =?us-ascii?Q?LMywid8WhZG6lI9NKDvqMFnzmqZNye7UOz7eQ7+Cwcei16uQ9rxCRShGa7vw?=
 =?us-ascii?Q?D1/uw7pa45kyoY7BqUHOWXDvSwMu0mE6cMX7lv5K4QVA83vasHLdGvn7qbxG?=
 =?us-ascii?Q?PA389c3C3PqW+oeHTdOWq+4XZVPz/2beNykAw9naeVlz4MnvidXaz+4oFltP?=
 =?us-ascii?Q?FCK6Bc5v0O09yASGoJbgA3V8qP/Wcl2GPishcD4R4lq1jiNJvv9lbkdX8PaQ?=
 =?us-ascii?Q?UssjU365EYEK0aXytzqJwIygxISzL0jMB6+ZykT7LnV5AAlH8ts0Xby4cv0n?=
 =?us-ascii?Q?c1+iA1GJLB5E8lPwv2ReMN+YtyYb1ngds6LnMKq5Xn26fL3Z89tZOPRjfGI7?=
 =?us-ascii?Q?yFYwq5TTs0xeLJJBodhr4f0FJxUrAaHWQvypN9lK5pp1TPdjWDljX99BxJyO?=
 =?us-ascii?Q?Hjz2zm2JVTtTZv+xwC50TH17Ll6IgxpFWp9EkKGT7HJ1tIvJOl8SiO+cCl16?=
 =?us-ascii?Q?3bmp9b0TrKne1Q+rbGeltUerW+QZQd33WjJaIHHhQDE3o7NZIj/D7Hz9Xu/+?=
 =?us-ascii?Q?Cqmjy36GBZSQGdVLwwEtf7Cact9uwHXkZnW3APebfEc8Ppu/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9307b261-8374-46ad-0d05-08def31d0e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 18:12:05.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzkJICVKHvhp9Gn/x0UwWmWZjOkLNuiNbD1qC3gN1pKnLICH7sl47qJ5ra1a5M6YvyQZksA7mAnBajx+B9OR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1

Public

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 5, 2026 1:53 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> iommu@lists.linux.dev; joro@8bytes.org; linux-pci@vger.kernel.org;
> will@kernel.org; robin.murphy@arm.com; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; bhelgaas@google.com; Longia,
> Amandeep Kaur <AmandeepKaur.Longia@amd.com>
> Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
> only
>
> On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:
>
> > IIRC, they supported SME, but it wasn't usable due to other
> > limitations (e.g., the requirement for identity mappings due to the
> > display hw bug and the latency impact of encryption for displays in
> > system memory).  Do you could effectively pick either SME or displays.
>
> IMHO the GPU driver should fail if it cannot work because it can't reach =
the
> IOVA space requried for SME ...
>
> I don't think this should be a iommu problem to deal with

That means no display for the user which is a not a good user experience. M=
ost users of systems with integrated graphics would probably prefer display=
s over SME.

Alex

