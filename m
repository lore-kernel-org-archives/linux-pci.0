Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885D18A6A8
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579914; cv=fail; b=JzXYEQfNgFGGJ8dvZ4vOFTIlsJc9Q2qwF1vQbEraZrP8zCWUP4qE2IppL/7aWr42GYaSLPoHMe90rV7tUYaCpL78NsMkvBxL5AJC/0a73+z48ge7xulJbv3oXdRuYKz9F/dilUPPwE26OHcO/7LDFYkt4Cy3I5NjfcLIQYy40NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579914; c=relaxed/simple;
	bh=z/l7AD0whTGUJ2r1pMo/NLCtKpkbgRwvnIqn60yN/c4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8LRrgpwN26Fy5jkeQGBqSWjhWFeH0nAB/O1tVZnBdhBonP0A4jpAtWBD6RMdmvGpvUS3Biz6u0J3uFohwnGr8j3RDYiH9rlBfDlVSU95eoDJ3twIluFjYIaKSzVZs2eZIl0N2c43a+Au0P5b7KQaabZQWQCcmWI9n7QcDiuOFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PtcZq1Za; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PtcZq1Za"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJCn32AdHaa5v0RPx/WNOTTiGAYJgZfZ/3TTsUQVuV0cCIZgTnhefO2rMIEno5dsvtwKAgxTk1IGvhfhNyPbNmcoDY89EpVoEE/KEAsJNo/oMMSs4v71v4+i88tSLQREyTAag+KAI8ygJCe/jTbPTJIICbwQoAI0PD50xBqSoSqOjHk5VVhYkKq+xzUqt8gS5tBPIUKM/V/kOimS6ZwuGpdIJlhIPbRYXErEkLT2sqMBGNYLcug45zaST6OD25cTYclFlCRVXjqcbBQ3265qCg70qo5/YyAbCCW9ydiG/wJcI6s4XZgF+AgvVr4MOC5YoLYEiUNAS0AfpBRkgihCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhHlFV4bK93EiVm+jtXfiuU73l5Alqa6WnhWvFiI2gc=;
 b=rUF3v9DaqnRL+UZ8LEPrumnHrILvoZRhBO59ugHk3lyQUtfpqAB9R2VmSi0JFECBisqB9pVfrM5PL0EC+mR7nQnTCp5vNv83dUEqSxCFStABGk3Yq5gZDDv9cSl9pSTgGaa8x3veW/plDb3tgcudUfSzJhKC6IDUmrGezmHK20jpsxqidWye82pT/wHXicv6smfPXQWPqLP0YQgE+BJVCvGuBcyv7r/ULvptYNAVCtu1xc1YPOzY6DePIKWMP9ZF9E7grE15t+k/ZdVCG6GctUTuC8U+ZzOnnAs8i6ymCk6JwJhYrPY2+VmjIuGR/LCN+WF1GBc74d+7DC6T+66okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhHlFV4bK93EiVm+jtXfiuU73l5Alqa6WnhWvFiI2gc=;
 b=PtcZq1ZagRB2BnjsV+wLnMHNHaCD1Hh+BwG8+I704aP1raNtgo+GsLTx2yeOhdMEn/bTjNWpxw4tKnBB7ycGKpbr6MIisF9FwGLyt/ZMUES9Pl4REp/GHnn0O3NzIt0ymEWOlyH1rx/02w2N8uFMzagllGZOfmbZgQ1cMw2Ahdw=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 00:11:48 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 00:11:48 +0000
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
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCAAOUFgIAADS2AgAKVz4CACMDmAIAA4oQAgAAtKPCAAAlpAIAABJCggAARRACACxOBUIAACoiAgAAAudCAACjpAIAACp3Q
Date: Thu, 13 Aug 2026 00:11:48 +0000
Message-ID:
 <BN9PR12MB51462D89963C912121E9D780F7DB2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812205737.GG662699@ziepe.ca>
 <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812232638.GH662699@ziepe.ca>
In-Reply-To: <20260812232638.GH662699@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T00:04:37.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|IA1PR12MB8336:EE_
x-ms-office365-filtering-correlation-id: 036b2b56-45fd-4141-81ca-08def8cf7801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 f7wLFrQp4W6QHMcvZXdx8adZTSdhojJPsWYP62ogLjxfqBBIvXwymHDzp5gZiki18bFHOodxpZs8dKgFSWEfTp+JmraaTWrIgm2gNiLFBhFuF7g6b5AaK+QbxC51pjbQKjs3P0Hz/KFs4e12XetNvf3PnLC+FJ9nOHXGxYhWQtHKGqv33ZCZjM2UqSh9kkjOk48Rr/HdsXIh9aLuetge/SotbZ/jUAL8LS7DJxIvVr4z1ZQBdTDF0mZFBw0yWDFuCqSyTGB2VZafxVLnrV5XFwrmD3Y8+sF348+0eKPuvsscQefg16zyqYXXD1/qBdqRsMSMSDifzaQ4QTdSrIPLQy7qtf/2K032q3hzru5ypV0T0rOJknJnCZ7pEj5uZH48gr4b+bca+h74XjTHgXzzwpGaZlSii2oTeJljuWGTangd3gQM5JxF7cdvlx7UPfuaPBPsa4efaMQxnoDJ8yMLge3O83GaS87TRDA6XRG8D7JZRfwFDZxSNgpF6oMLvEZCRK4iUq9te0+8VBI51fwj6iKJNDH+XoZSGDQG+nupdiboDzYFE447TmvA/RwtJEEJvW+StEAW7hKTTVidj8JuOpp4sJic3h+/FzCQBAur4D4hkwvmCaeaCDMOxaYyiMJxEhCi4w1RMmZrucG0rMSSjzmSIznPmbeU4PQJdLRngfHH0aDsP0vljAQ76WnTyExHinwRIjZSOVXxWa2xfqEXk9uZ67cCEwm2Jc9bmHmDRpg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nqpInGTysZQDrkOSo8RexfV5qHc3obCZYG7XektYliw5Nuf+ybLC4YBQ7Dh0?=
 =?us-ascii?Q?64vRP6Rhg4LFG7sp3HW7sQDo9P8ploeTmgxMsJXgDVNCMUDxzyZuT2+uVubo?=
 =?us-ascii?Q?sjGRmfNyrgaM4iy03R6WIBM4/qz9CfG/8e6XdlOH4/hNlOvKB94UyY0ievby?=
 =?us-ascii?Q?1/68GppvoXgLll6TZIHQIXoCydQmLzDlAwohkr6WIn2DRiz8bi363S1vj89b?=
 =?us-ascii?Q?u3h3/KZOGBBohzv4hLVH6Hs0tVbYLIonefC49KduMdpvspk3fNywTwjyTOkH?=
 =?us-ascii?Q?7r69Xr8Vf8+Qo2hDv7AcfFtwOWhxQDhd611d/jYPeUGYEPvPyWjagT5NGSJG?=
 =?us-ascii?Q?S9AQbHrrssDo4bKTJ6xoGsjI1nWIZkC0nwnu7NciECEWpvGL5a/0/7nB1ncZ?=
 =?us-ascii?Q?ILErhlRK8o56moK5mVPOilEw+gJ8rFrTM0ieFkMZ5CiRqfAG1MUBhKlDHFiY?=
 =?us-ascii?Q?GOnizaKj8zAFM14tp49Hsbv+Mi5Bdd3ebg6p85vYuhX4zJa+MzxT8OZYxRfw?=
 =?us-ascii?Q?uPwsfUwW+gvJn1n+QBtHyAvB7axMJjnpPNkCTZ4ldcGsjfNEyCLZiFLJPB92?=
 =?us-ascii?Q?bkdfNMuJKBTxQDqL2NnbVTJvGhxk33LTZCWQChm8Qn38fgCahQsEumvfRAow?=
 =?us-ascii?Q?f1kfYfSn6+D39i69aPzJsCb5TRURKhAykEzh7hmwrMeH7akJ7gYRH665dgPd?=
 =?us-ascii?Q?Z0khpMW5vqkgB3UwiFg71IprsDY4GdAoHcBcyEluuhRe5IuiAQ986rZmnlTF?=
 =?us-ascii?Q?Kn9MQxW9+xPpYAAezdYcEkwJb2jHg5fISo/+sbXUl0j8fNov/Kl1Bti5fh7p?=
 =?us-ascii?Q?STz9TblyxNBcc3SIsix5CaIDuI54wqKHqpObKp7LPOR2TQf/X8agJabG8Nuh?=
 =?us-ascii?Q?a0tDenNgJQYLbz8W1y0gT+oUYJi5ji11AhdECRu8dtTBXKN3zmoiATRUG0mj?=
 =?us-ascii?Q?vlRKVQo1oBzKOsQjsQTw2TOqA5fPS+Vwpxh/mK8832FtmJMsjkNzVDHkMwog?=
 =?us-ascii?Q?M0M1TayJBIuzSf3YN1m5cN0Np43cTaPlhpi0/I9jWuHtjAn8/dpa/Q8MbIcL?=
 =?us-ascii?Q?LB0Pq0SeFpsoDe711svuy7RWTgCqUpnOCR1OvwPyy4fRYxhkkVFQN11yXxNc?=
 =?us-ascii?Q?KRgj+9Oy/8L7kNIZkhYglQpqAbtDcSSQLZqXKJZ4xXB0bs1hZdHhC+4H5cyU?=
 =?us-ascii?Q?gDmC3HMgt40LsqoTJfVpPH3JfsXVOxQni+YxB2ILNiDGQ6HXnLE+y3FQKk9K?=
 =?us-ascii?Q?1jnWWfRB2uEaLWmXJN2aNwt5MNAkXxL+GxYSGuc/fzc93LQlqReex94+7IkB?=
 =?us-ascii?Q?LFMwdJY0cwqrM3xQWHsoAo02lJEsdj2YI+95DHq3tEOO75q7brgbU3W9ShhC?=
 =?us-ascii?Q?ZB9ZchZkvpe/L2x+cfRq6gQqZEADN723v5s3bYiBcP8INU1AEQtIzkkrVy7L?=
 =?us-ascii?Q?9XPdcY0XrCsDPBb2UC9KtkQXgJtIb+yfxtcAl+Fx1StDFeyuigcGOQhqBxqD?=
 =?us-ascii?Q?9rzDMRAZ+PuQn8NawK7UL5cmdhaDNkUtqJiru3v1CTXU0RLgNOy6KxcCbN6c?=
 =?us-ascii?Q?1TGFx8oY/2mM46dvYnvuCq+C1RiZPTB/h9SBs4CTiUq1QJpbIax1fMi38p28?=
 =?us-ascii?Q?CZKAr6A7Ovaa7z3yE6omT3wokv80gGp9b3bac6cyaUdJBRVgdDHRs65z1G7f?=
 =?us-ascii?Q?0USKuE/p2XAERg50i+iWrB4BgFPb8zol/H7xgtoIpMftj/ZG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 036b2b56-45fd-4141-81ca-08def8cf7801
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 00:11:48.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PWMZpcnywKO4Qgy/GGwWKYBhf5p5s1/PFwzgvtRmNEhaV/q0eLwVrnSmfzLECH5IQbUa/3vJ4zev7nyRZHjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336

AMD General

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 12, 2026 7:27 PM
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
> On Wed, Aug 12, 2026 at 09:03:58PM +0000, Deucher, Alexander wrote:
> > > Sure, but the end result is the GPU and SME are inherently
> > > incompatible, we can't really fix it.
> > >
> > > What's wrong with blowing up at boot with a clear message that Linux
> > > must have SME disabled on this HW printed to the UEFI console?
> >
> > It's not very user friendly, plus it would break working systems.
>
> Huh? You've explained that SME doesn't work with these GPUs? How are
> there any working systems with SME turned on already running Linux?

No one noticed it because the IOMMU driver used to default to 1:1 mapping f=
or all AMD GPUs that supported ATS and PRI for compatibility with ROCm at t=
he time back when the amd IOMMU was the only one that supported SVA.  Same =
reason we didn't notice the IOMMU problems with the display hardware.  Linu=
x defaulted to 1:1 and windows didn't use the IOMMU.

>
> >  I'm not sure the average user would know what to do.
>
> Turn off SME in the bios? Doesn't it default to off?

I don't remember.  I suspect it defaulted to on.

>
> >  You aren't likely to want SME in the first place on one of these
> > laptops.  Why not flip the logic and print a clear message that if
> > the user wants SME they have to explicitly enable it via the kernel
> > command line.
>
> That seems like it would be API breaking for server users that do want SM=
E

Only disable it by default for these specific platforms with the old iGPUs.

Alex

