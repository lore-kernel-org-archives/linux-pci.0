Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F33A3515FA;
	Mon,  3 Aug 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756501; cv=fail; b=e5Ctah0AzWvVfVUNFSm+gS/g6ZautQWkeM2agKZ/66aK3rhBtcOFC28t6McIqEHxNtaJb3nsI5DrbmVjELIoTZZS6/5xpw3IzowVa74YaNMA1buIUUi20EU1D7hh7R9JSzRTZ6DJ6TB0to/hTQM9/isyaksuMAgTVWjJwDamoFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756501; c=relaxed/simple;
	bh=qCoJwdw66iJ4LJ5362JS+WFJgJxU5QDfEFSn95mKH6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWugtZ4uOBDw3N/FrUqSX4V9Ki8rlygIPRiEhCYbl7g1+M64jA6banyDXR5BHvNxdBunCzOsPThp1fu175Od47q6xXfNSBLDmr0YvxFZw5cR8jaM4QnHEhRRNx78AuN2NJQM1bUB988XySArkZsxNxlHPMwhUGqULxnYqrf+gZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WRrPfPZo; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WRrPfPZo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyEXen8s1HdR2xk5Oeaf4PXLoYxSzYRCGajDD5WNpgpySivtlls9ql9qEbLpVUWNlUSwgSqaunIUkCrsIVbRQ01x3iH9uCi6TCGRDSlz8Pw98p7JQo44hqkFDVwOj9P9HVsak9AoQp/6I21Irt7KIhihxgkpyonMWzTlw+pSpC84abQtzhKf6MJacZGZbZCISpNfM9TZWYKBM6opZOsC0NDyNKyzLZCyAy8CijbbSASa3W3gGk8TJ6NVprJftiRrVDok1GCBQDQMro475AlKbkxanv30DyBz0TvbfhPbYMRwV6FtlgQCGIeQLiU1009HAKJg2SoF3A5U2hur+Utdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQTn2asL/JGvnorl7I26pMM7axjMxRsaf4RpqImL8w4=;
 b=VM6unb4RlCFGi6wnBQSmgfVpvbLbIFdCpSxeEhD26Y5H+OMtm0ijE9HhfvwvjQnoaCN7E/JdZ+xPBqUKzivwa1S1iUr6mz+O5zmNGNoznFwE+7nbwZnTc38GudF65EXAWNjyDyRw44qWhQyGkxkGQjgDCdNPEuo/4s44qTqqMa4jIJoPtgVYsS8X7ioGvMjn83I03cnh5RkK42D+2tetoBWbj0AjyHcLZ5UAfseEw4rO7pBGtMR/2fWNpwhjVKaFzSiT+E6w/6nPXB9FAa7ZOiUQaAAfSKGvKfsPvk+sbMeENQCGjBCOr/Qbm9pn6MPGt5kgqsHV1SaKmXcpBa9M9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQTn2asL/JGvnorl7I26pMM7axjMxRsaf4RpqImL8w4=;
 b=WRrPfPZoyNdEWDA5opBecFAa4kV9XvPUImjZJlbz7L6qKTYGi9weAmvZ5LlUsWTmR8nHMIvPRBRRhZ0Aj5qptuzr6d9Qy/4Q4MIkZCJpm0Zu3sAF+R+Hzt4Ar+ZX9hmRuk+IRL/IykH9rOoT3Ahcwe5UHUFONPMkmNmiR8I/Gzk=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 11:28:16 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 11:28:16 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "Sanwal, Pranav" <Pranav.sanwal@amd.com>
Subject: RE: [PATCH v2 2/2] pci: AMD: Add CPM6 host controller support to AMD
 MDB PCIe driver
Thread-Topic: [PATCH v2 2/2] pci: AMD: Add CPM6 host controller support to AMD
 MDB PCIe driver
Thread-Index: AQHdHs6qGIM3e0/Wh0Su6T2ZdJj5f7aDguEAgAipZ1A=
Date: Mon, 3 Aug 2026 11:28:16 +0000
Message-ID:
 <IA4PR12MB9810D1085E98AD602AABEA3DCDD52@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260728202044.1785986-3-sai.krishna.musham@amd.com>
 <20260728222718.GA1404656@bhelgaas>
In-Reply-To: <20260728222718.GA1404656@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-03T10:43:47.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|SA1PR12MB9545:EE_
x-ms-office365-filtering-correlation-id: 9b77c9df-a3d9-4f9e-0ea0-08def1524fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 65vRlHEBJDGgJRUMFoNqCIT2M3p4fwtIO2MUxF5LDQ2uwrHIagZg3/Q/c9cuJ6lVJHtESp4qnnvpb9WY7JM5/6UZ9KzbxQNCUTXRBTHUfiDXR396io1c9amQWsEq1CKxVYgRtYSWmyGyqV/zUG+pcwH2E+oTrEGRj3kpmwnjYS7VUEjFz56/jwCWCHfamHdmw2HmY6wMVTkx9u8SDVa+yFsZ/aEUheV/0ciNDnvBK+OMdLoFS69O7c6t3lb4zaOLBTQmbUevkKsIOJLaj2qYYMlSQ5euymyL5BSUeiaGVW3b3Ursrml0DRd9BJ/k98+LQZ4FXN8uBv3IF9e5VyfEjgHb9KWOsuqAsQAqQAn3bfLKDrQXvviFNud6lkqNp3k+GCBq2ePnNHcMXXJXYbeNYg1dUDEMXbk25uRzlpgwDHlveZ6d+CObdGfTSo5uMc4vLrN6uFS90Ue5uHgNEDStgfVep/JmvpStsI7GiMRL1cq2rmV+bsDPAZnrkCtBat/djyAoR+VeVk7MtY+xFL4vIJS0accPqcG8gq1GtfmuacpUOTaLeQtQEYzzbywqC6a88hZGK9JgRuOLMmustRq+d8VZcjxV0iyPcAVndl4eZ1qc0zGleMqjY0fj4iNW1RInpXHDuy/t0PrAViAY+yXIGemDvmC+Vcpxp/1uum8QmVADsW/iAFLZfePeFsAk5t64SP/Ce2YauZr1ezjVlpWqNAK3kWkhmr0+GGqKcMZM8B8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7hl0Kyf77Hkweic8dlG5JXq0C9NlSAywIemxwW+aP+vlePQbxYJyi79HwOXb?=
 =?us-ascii?Q?CXbuUL52+er9XOxyQxknqrKr4JCAMekMTMQ7MmsyJ5FGC2ay3D21qyhCPdQZ?=
 =?us-ascii?Q?6jHGWtTxGlpq/3QBeJNMQ6/1mzp+btzO/MklmmA8BN80KGpN6rKbLz56b1nS?=
 =?us-ascii?Q?QrqEoJaxCbpKRiqOm1Y9Cbyv3/aP9EpmVE6HLC8wk3qFmCSohMSVEKoxFfVU?=
 =?us-ascii?Q?O03keyV4wMCKzwFKwOiJ0D7g+WvajNScUTEliW9nHnNdIzU3TPR/mTXse1Ep?=
 =?us-ascii?Q?He8JUHr9knyZd7g6ukmaYwgbq+azCW/ACF17m4PPU4KTWeEjHuPyoGlRX5Gt?=
 =?us-ascii?Q?JqDUz9cCXLWpG6YVCdfr4DdTiBc1CfL1xvKGDAHRpFYW93ygmh+eEHUK9Heg?=
 =?us-ascii?Q?mFdWulG4At4Rtc91kQTp5Bd7F+Y+MzdgfFYOdk3wHOVHRypuExTzuI73TqXM?=
 =?us-ascii?Q?1lC156o5qZEnv0tSgm/ZrUHxlyotZ/f8lWzFksWOxB2k9O1uislVZ6VrZb/R?=
 =?us-ascii?Q?Un0fvXHl4oLza/8IOL6j0Ld3W/wSMeiCg+pUzN+g9ltKt8QssEHgYwYn94Ss?=
 =?us-ascii?Q?Ktii31bQyGqFv28J8i+ORkRmBpxHvUqSAUaBN0qBQ6crUXL10BQUB9m9m/GQ?=
 =?us-ascii?Q?PagMA3XhXwYEpXxRY+2WAtRoDYF2RYnFw3sgDc08xy46sx6ipizqi9/rxAHt?=
 =?us-ascii?Q?35w3Ee26sRyFIHDn/ftryd4ii8X+Y4luIUgKY6C/lQYQ5vbEpeQAKSVxveK+?=
 =?us-ascii?Q?QvV/B4TYC4B4cnb7wnDUoX3h5bym9rydxXl2Yl0GuVuBZ0MzzZDjfU/vYSFQ?=
 =?us-ascii?Q?QMsu7NOX6mh9kLFE84a+3oYLZ2ilo54/qShsfWWLdeLgyiIM67ny9nbhQID+?=
 =?us-ascii?Q?vlCUNQePwSKVdryvDmBeF2vM6guYz7CNOdUyCgD39tH/rmx7veOep5L9cx7X?=
 =?us-ascii?Q?SsIoQlj0Nygg04E3jbUHa13S0+Rv1ggFb0SqYNJttnLvI/2z/NyLbDvWHx2M?=
 =?us-ascii?Q?/LDTzqqjDKLr92lYlLZznR+tvjW6EuFXipqnyUNyzgKxAtaYavAwKtmfrjZm?=
 =?us-ascii?Q?0QcnNH6ZkK62vO9O6DgcNspuKzc6l6ZV9G5HyFl75pvlFkfkro/CcZ3+qsw5?=
 =?us-ascii?Q?rhBzvbARuCsc9erxpyZPI6hkKwXjeM/H4+rE262oP4MgxlsoH4FMxLpoMHn5?=
 =?us-ascii?Q?0c6mNz+zXNzQTu0r2sksXAfPH4/dcXXPGkTYopqOcEgKW3Mfaeatyz0jzgxR?=
 =?us-ascii?Q?tUztNY6kteyjLMWvPYVIMJ2+7oZeFxLu9N6e5KWf/funvqqSywdO0lACsGGh?=
 =?us-ascii?Q?1plI5VfkU4HJDfqZ2aJ+ZKLduuVMWzJINj8FThTqXuceX6uZ8KQfk74Ytbcr?=
 =?us-ascii?Q?hLwDEqM6abnCHlAsnJFwUpa9EVb9vd9WKV1c/cAYjf2aVmQWarV6MDMBbpUb?=
 =?us-ascii?Q?3NoV/aRJ3rZcyCQ2IT8WvHt6vO9ZSlbVbQozK+ZT9vGslHk8oz5HRtMSzfGd?=
 =?us-ascii?Q?f8dvYNdtln0gtaCCtQ10hYJQ2F2sAvShHSxjCkUN8ofmUsVioYailbe9tCDj?=
 =?us-ascii?Q?HaktG0b7hWjTLhS3QirOHYRdxuTnzOi3kZvI4y7TRZ5iAXAnCmME/ag+qOoE?=
 =?us-ascii?Q?PUk6dF92xdZBocegNeyvPIABfEV9/r1K6Lonq36V7JpPHwjzjWqvdmv8AEpM?=
 =?us-ascii?Q?HUHvrmZNJt/A611NELxA5qfei32j4iFvJUdG+T5x3sb0pmmO?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77c9df-a3d9-4f9e-0ea0-08def1524fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 11:28:16.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYdFoC6K26PB08hcHlv5YnBcH/5go3d5OIWjNPRKtcmScamwqSFKOKDR1Ufx/Mf/wMoDbfRus+vnhKE0C3A6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

Public

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, July 29, 2026 3:57 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> mani@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; cassel@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>; Sanwal, Pranav
> <Pranav.sanwal@amd.com>
> Subject: Re: [PATCH v2 2/2] pci: AMD: Add CPM6 host controller support to
> AMD MDB PCIe driver
>
> Replace subject with something like this to match history:
>
>   PCI: amd-mdb: Add CPM6 host controller support
>

I renamed subject to match history and will send in next patch.

> On Wed, Jul 29, 2026 at 01:50:44AM +0530, Sai Krishna Musham wrote:
> > Extend the AMD MDB PCIe driver to support AMD Versal2 CPM6 variants
> > (amd,versal2-cpm6-host and amd,versal2-cpm6-host1). Like MDB5, CPM6 is
> > based on the Synopsys DesignWare PCIe controller and reuses the existin=
g
> > DesignWare host support; only the interrupt architecture differs:
> > - The per-controller interrupt registers (MISC_EVENT, PCIE_ERR) are in =
a
> >   dedicated "intr" region instead of the shared SLCR
> > - The aggregation layer (MERGED, PS_MISC) is shared and sticky; it
> >   requires an explicit W1C-clear after servicing to prevent IRQ storms
> > - The completion timeout is reported via PCIE_ERR instead of MISC_EVENT
> >
> > Add variant-specific register layout and implement aggregator clearing
> > that, after every interrupt pass, clears this host's contribution from
> > the MERGED register and the corresponding bit in the PS_MISC severity
> > register.
>
> I don't know if it's worth it, but I think this part could be split
> into a preparatory patch that just reworks the MDB5 support, e.g.,
> moves the _IC stuff, adds the register layout pointers and mdb5_host,
> sets up pcie->variant and tests it for "=3D=3D MDB5", etc.
>
> Some of the generic things Sashiko pointed out could also be fixed in
> separate preparatory patches where they would be easier to backport to
> kernels where only MDB5 support is needed.
>
> Then this patch would be purely CPM6-related things.
>

Sure, since there is no functional change. I will split this in v4:
  1. MDB5 rework: move the _IC tables, add the register-layout pointers +
     mdb5_host, and route register access through pcie->variant.
  2. Pre-existing MDB5 fixes Sashiko flagged, as standalone backportable
     patches.
  3. CPM6-only additions.

> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > Changes in v2:
> > - Add CPM6 host controller interrupt support.
> >
> > v1 https://lore.kernel.org/all/20260402180006.486229-3-
> sai.krishna.musham@amd.com/
> > ---
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 351 +++++++++++++++++++---
> >  1 file changed, 305 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > index dee295f281a3..dbf36ce9902c 100644
> > --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > @@ -21,6 +21,23 @@
> >  #include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> > +/*
> > + * On CPM6 the per-controller PCIe interrupt registers (MISC_EVENT and
> > + * PCIE_ERR) live in a dedicated region ("intr"), separate from the CP=
M
> SLCR
> > + * region ("slcr") that holds the MERGED and PS severity registers the=
y feed
> > + * into. Each has a sticky W1C STATUS, a read-only MASK, and write-1
> > + * ENABLE/DISABLE register.
> > + */
> > +#define AMD_CPM6_PCIE_ERR_STATUS           0x500
> > +#define AMD_CPM6_PCIE_ERR_MASK                     0x504
> > +#define AMD_CPM6_PCIE_ERR_ENABLE           0x508
> > +#define AMD_CPM6_PCIE_ERR_DISABLE          0x50C
> > +
> > +#define AMD_CPM6_MISC_EVENT_STATUS         0x514
> > +#define AMD_CPM6_MISC_EVENT_MASK           0x518
> > +#define AMD_CPM6_MISC_EVENT_ENABLE         0x51C
> > +#define AMD_CPM6_MISC_EVENT_DISABLE                0x520
> > +
> >  #define AMD_MDB_TLP_IR_STATUS_MISC         0x4C0
> >  #define AMD_MDB_TLP_IR_MASK_MISC           0x4C4
> >  #define AMD_MDB_TLP_IR_ENABLE_MISC         0x4C8
> > @@ -30,7 +47,22 @@
> >
> >  #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)   BIT((x) * 2)
> >
> > -/* Interrupt registers definitions. */
> > +#define AMD_CPM6_MERGED_STATUS                     0x648
> > +
> > +/* MERGED input bits for the MISC_EVENT/PCIE_ERR sources this driver
> handles. */
> > +#define AMD_CPM6_MERGED_PCIE_ERR_HOST0             13
> > +#define AMD_CPM6_MERGED_MISC_EVENT_HOST0   14
> > +#define AMD_CPM6_MERGED_PCIE_ERR_HOST1             16
> > +#define AMD_CPM6_MERGED_MISC_EVENT_HOST1   17
> > +
> > +/*
> > + * The PS_MISC severity register feeds the misc/OR GIC line. The MERGE=
D
> > + * aggregator appears as bit 21 within it.
> > + */
> > +#define AMD_CPM6_PS_MISC_IR_STATUS         0x340
> > +#define AMD_CPM6_PS_IR_MERGED              BIT(21)
> > +
> > +/* MDB5 interrupt register definitions. */
> >  #define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT             15
> >  #define AMD_MDB_PCIE_INTR_INTX                     16
> >  #define AMD_MDB_PCIE_INTR_PM_PME_RCVD              24
> > @@ -39,6 +71,9 @@
> >  #define AMD_MDB_PCIE_INTR_NONFATAL         27
> >  #define AMD_MDB_PCIE_INTR_FATAL                    28
> >
> > +/* Completion timeout lives in PCIE_ERR_STATUS; give it a dedicated hw=
irq.
> */
> > +#define AMD_CPM6_PCIE_ERR_CMPL_RADM                20
> > +
> >  #define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> >  #define AMD_MDB_PCIE_IMR_ALL_MASK                  \
> >     (                                               \
> > @@ -51,10 +86,58 @@
> >             AMD_MDB_TLP_PCIE_INTX_MASK              \
> >     )
> >
> > +/* CPM6 hwirq mapping (hwirq =3D=3D MISC_EVENT status bit). */
> > +#define AMD_CPM6_PCIE_INTR_FATAL           17
> > +#define AMD_CPM6_PCIE_INTR_NONFATAL                18
> > +#define AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE        19
> > +#define AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD 20
> > +#define AMD_CPM6_PCIE_INTR_PM_PME_RCVD             21
> > +#define AMD_CPM6_PCIE_INTR_INTX                    22
> > +
> > +#define AMD_CPM6_MISC_EVENT_MASK_ALL                       \
> > +   (                                               \
> > +           BIT(AMD_CPM6_PCIE_INTR_FATAL)           |       \
> > +           BIT(AMD_CPM6_PCIE_INTR_NONFATAL)        |       \
> > +           BIT(AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE)        |\
> > +           BIT(AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD) |\
> > +           BIT(AMD_CPM6_PCIE_INTR_PM_PME_RCVD)     |       \
> > +           BIT(AMD_CPM6_PCIE_INTR_INTX)                    \
> > +   )
>
> Line up the backslashes as in AMD_MDB_PCIE_IMR_ALL_MASK.
>

Backslashes lined up for AMD_CPM6_MISC_EVENT_MASK_ALL. Will be fixed
in the next patch.

> > +/* Sources handled in the PCIE_ERR register. */
> > +#define AMD_CPM6_PCIE_ERR_MASK_ALL
>       BIT(AMD_CPM6_PCIE_ERR_CMPL_RADM)
> > +
> > +enum amd_mdb_pcie_version {
> > +   MDB5,
> > +   CPM6,
> > +   CPM6_HOST1,
> > +};
> > +
> > +struct amd_mdb_intr_cause {
> > +   const char      *sym;
> > +   const char      *str;
> > +};
> > +
> > +struct amd_mdb_pcie_variant {
> > +   enum    amd_mdb_pcie_version version;
> > +   u32     misc_status_reg;
> > +   u32     misc_mask_reg;
> > +   u32     misc_enable_reg;
> > +   u32     misc_disable_reg;
> > +   u32     misc_mask_all;
> > +   u32     intx_hwirq;
> > +   u32     intx_mask;
> > +};
> > +
> >  /**
> >   * struct amd_mdb_pcie - PCIe port information
> >   * @pci: DesignWare PCIe controller structure
> >   * @slcr: MDB System Level Control and Status Register (SLCR) base
> > + * @intr_base: Per-controller interrupt register base. On CPM6 this ma=
ps
> the
> > + *             "intr" region holding the MISC_EVENT/PCIE_ERR registers=
; on
> MDB5
> > + *             the interrupt registers live in the SLCR block, so it a=
liases
> > + *             @slcr.
> > + * @variant: Interrupt layout data for the matched platform compatible
> >   * @intx_domain: INTx IRQ domain pointer
> >   * @mdb_domain: MDB IRQ domain pointer
> >   * @perst_gpio: GPIO descriptor for PERST# signal handling
> > @@ -63,12 +146,62 @@
> >  struct amd_mdb_pcie {
> >     struct dw_pcie                  pci;
> >     void __iomem                    *slcr;
> > +   void __iomem                    *intr_base;
> > +   const struct amd_mdb_pcie_variant       *variant;
> >     struct irq_domain               *intx_domain;
> >     struct irq_domain               *mdb_domain;
> >     struct gpio_desc                *perst_gpio;
> >     int                             intx_irq;
> >  };
> >
> > +#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> > +
> > +static const struct amd_mdb_intr_cause mdb5_intr_cause[32] =3D {
> > +   _IC(CMPL_TIMEOUT,       "Completion timeout"),
> > +   _IC(PM_PME_RCVD,        "PM_PME message received"),
> > +   _IC(PME_TO_ACK_RCVD,    "PME_TO_ACK message received"),
> > +   _IC(MISC_CORRECTABLE,   "Correctable error message"),
> > +   _IC(NONFATAL,           "Non fatal error message"),
> > +   _IC(FATAL,              "Fatal error message"),
> > +};
> > +
> > +#define _IC6(x, s)[AMD_CPM6_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> > +
> > +static const struct amd_mdb_intr_cause cpm6_intr_cause[32] =3D {
> > +   _IC6(PM_PME_RCVD,       "PM_PME message received"),
> > +   _IC6(PME_TO_ACK_RCVD,   "PME_TO_ACK message received"),
> > +   _IC6(MISC_CORRECTABLE,  "Correctable error message"),
> > +   _IC6(NONFATAL,          "Non fatal error message"),
> > +   _IC6(FATAL,             "Fatal error message"),
> > +};
> > +
> > +static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
> > +{
> > +   u32 merged_mask;
> > +
> > +   if (pcie->variant->version =3D=3D MDB5)
> > +           return;
> > +
> > +   /*
> > +    * Clear this host's serviced contributions (MISC_EVENT0 and
> PCIE_ERR)
> > +    * from MERGED.
> > +    */
> > +   merged_mask =3D pcie->variant->version =3D=3D CPM6 ?
> > +                 BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST0) |
> > +                 BIT(AMD_CPM6_MERGED_PCIE_ERR_HOST0) :
> > +                 BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST1) |
> > +                 BIT(AMD_CPM6_MERGED_PCIE_ERR_HOST1);
> > +
> > +   writel_relaxed(merged_mask, pcie->slcr +
> AMD_CPM6_MERGED_STATUS);
> > +
> > +   /*
> > +    * Clear MERGED in the PS_MISC severity register so the misc GIC li=
ne
> > +    * de-asserts.
> > +    */
> > +   writel_relaxed(AMD_CPM6_PS_IR_MERGED,
> > +                  pcie->slcr + AMD_CPM6_PS_MISC_IR_STATUS);
> > +}
> > +
> >  static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops =3D {
> >  };
> >
> > @@ -81,14 +214,17 @@ static void amd_mdb_intx_irq_mask(struct
> irq_data *data)
> >     u32 val;
> >
> >     raw_spin_lock_irqsave(&port->lock, flags);
> > -   val =3D FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> > -                    AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> > +   if (pcie->variant->version =3D=3D MDB5)
> > +           val =3D FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> > +                            AMD_MDB_PCIE_INTR_INTX_ASSERT(data-
> >hwirq));
> > +   else
> > +           val =3D pcie->variant->intx_mask;
> >
> >     /*
> >      * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables
> that
> >      * interrupt, writing '0' has no effect.
> >      */
> > -   writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> > +   writel_relaxed(val, pcie->intr_base + pcie->variant-
> >misc_disable_reg);
> >     raw_spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >
> > @@ -101,14 +237,17 @@ static void amd_mdb_intx_irq_unmask(struct
> irq_data *data)
> >     u32 val;
> >
> >     raw_spin_lock_irqsave(&port->lock, flags);
> > -   val =3D FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> > -                    AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> > +   if (pcie->variant->version =3D=3D MDB5)
> > +           val =3D FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> > +                            AMD_MDB_PCIE_INTR_INTX_ASSERT(data-
> >hwirq));
> > +   else
> > +           val =3D pcie->variant->intx_mask;
> >
> >     /*
> >      * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables
> that
> >      * interrupt, writing '0' has no effect.
> >      */
> > -   writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> > +   writel_relaxed(val, pcie->intr_base + pcie->variant-
> >misc_enable_reg);
> >     raw_spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >
> > @@ -148,42 +287,34 @@ static irqreturn_t dw_pcie_rp_intx(int irq, void
> *args)
> >     unsigned long val;
> >     int i, int_status;
> >
> > -   val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> > -   int_status =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
> > +   val =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_=
reg);
> >
> > -   for (i =3D 0; i < PCI_NUM_INTX; i++) {
> > -           if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> > +   if (pcie->variant->version =3D=3D MDB5) {
> > +           int_status =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> val);
> > +           for (i =3D 0; i < PCI_NUM_INTX; i++) {
> > +                   if (int_status &
> AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> > +                           generic_handle_domain_irq(pcie-
> >intx_domain, i);
> > +           }
> > +   } else {
> > +           /* CPM6 exposes only aggregate INTx indication, not per-lin=
e
> status. */
>
> Shorten or wrap into a multi-line comment that fits in 80 columns like
> the rest of the file.  Omit the period at end if that helps.
>

Thanks, I will shorten it to 80 columns.

> > +           if (!(val & pcie->variant->intx_mask))
> > +                   return IRQ_NONE;
> > +           for (i =3D 0; i < PCI_NUM_INTX; i++)
> >                     generic_handle_domain_irq(pcie->intx_domain, i);
> >     }
> >
> >     return IRQ_HANDLED;
> >  }
> >
> > -#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> > -
> > -static const struct {
> > -   const char      *sym;
> > -   const char      *str;
> > -} intr_cause[32] =3D {
> > -   _IC(CMPL_TIMEOUT,       "Completion timeout"),
> > -   _IC(PM_PME_RCVD,        "PM_PME message received"),
> > -   _IC(PME_TO_ACK_RCVD,    "PME_TO_ACK message received"),
> > -   _IC(MISC_CORRECTABLE,   "Correctable error message"),
> > -   _IC(NONFATAL,           "Non fatal error message"),
> > -   _IC(FATAL,              "Fatal error message"),
> > -};
> > -
> >  static void amd_mdb_event_irq_mask(struct irq_data *d)
> >  {
> >     struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(d);
> >     struct dw_pcie *pci =3D &pcie->pci;
> >     struct dw_pcie_rp *port =3D &pci->pp;
> >     unsigned long flags;
> > -   u32 val;
> >
> >     raw_spin_lock_irqsave(&port->lock, flags);
> > -   val =3D BIT(d->hwirq);
> > -   writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> > +   writel_relaxed(BIT(d->hwirq), pcie->intr_base + pcie->variant-
> >misc_disable_reg);
> >     raw_spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >
> > @@ -193,11 +324,9 @@ static void amd_mdb_event_irq_unmask(struct
> irq_data *d)
> >     struct dw_pcie *pci =3D &pcie->pci;
> >     struct dw_pcie_rp *port =3D &pci->pp;
> >     unsigned long flags;
> > -   u32 val;
> >
> >     raw_spin_lock_irqsave(&port->lock, flags);
> > -   val =3D BIT(d->hwirq);
> > -   writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> > +   writel_relaxed(BIT(d->hwirq), pcie->intr_base + pcie->variant-
> >misc_enable_reg);
> >     raw_spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >
> > @@ -226,13 +355,39 @@ static irqreturn_t amd_mdb_pcie_event(int irq,
> void *args)
> >  {
> >     struct amd_mdb_pcie *pcie =3D args;
> >     unsigned long val;
> > +   u32 ev_raw, err;
> >     int i;
> >
> > -   val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> > -   val &=3D ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> > +   ev_raw =3D readl_relaxed(pcie->intr_base + pcie->variant-
> >misc_status_reg);
> > +   val =3D ev_raw;
> > +   val &=3D ~readl_relaxed(pcie->intr_base + pcie->variant-
> >misc_mask_reg);
> > +
> > +   if (pcie->variant->version =3D=3D MDB5) {
> > +           for_each_set_bit(i, &val, 32)
> > +                   generic_handle_domain_irq(pcie->mdb_domain, i);
> > +           writel_relaxed(val, pcie->intr_base + pcie->variant-
> >misc_status_reg);
> > +           return IRQ_HANDLED;
> > +   }
> > +
> > +   val &=3D pcie->variant->misc_mask_all;
> > +
> >     for_each_set_bit(i, &val, 32)
> >             generic_handle_domain_irq(pcie->mdb_domain, i);
> > -   writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> > +
> > +   /* Clear handled + any unhandled sticky bits to avoid IRQ storms. *=
/
> > +   writel_relaxed(ev_raw, pcie->intr_base + pcie->variant-
> >misc_status_reg);
> > +
> > +   /* On CPM6 the completion timeout is reported via the PCIE_ERR
> register. */
>
> Shorten, e.g., drop "the".
>

Thanks, shortened to "On CPM6 completion timeout is reported via
PCIE_ERR.".

> > +   err =3D readl_relaxed(pcie->intr_base +
> AMD_CPM6_PCIE_ERR_STATUS);
> > +   err &=3D ~readl_relaxed(pcie->intr_base +
> AMD_CPM6_PCIE_ERR_MASK);
> > +   err &=3D AMD_CPM6_PCIE_ERR_MASK_ALL;
> > +   if (err) {
> > +           dev_warn(pcie->pci.dev, "Completion timeout\n");
> > +           writel_relaxed(err, pcie->intr_base +
> AMD_CPM6_PCIE_ERR_STATUS);
> > +   }
> > +
> > +   /* Aggregation bits are sticky; clear them each pass or the level I=
RQ
> re-fires. */
>
> Shorten or multi-line.
>

Thanks, shortened to "Sticky aggregation bits; clear each pass or the
IRQ re-fires"

> > +   amd_mdb_pcie_clear_aggregators(pcie);
> >
> >     return IRQ_HANDLED;
> >  }
> > @@ -245,29 +400,67 @@ static void
> amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
> >     }
> >
> >     if (pcie->mdb_domain) {
> > +           const struct amd_mdb_intr_cause *intr_cause =3D
> > +                   pcie->variant->version =3D=3D MDB5 ?
> > +                   mdb5_intr_cause : cpm6_intr_cause;
> > +           int i, irq;
> > +
> > +           for (i =3D 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {
>
> It looks wrong to use ARRAY_SIZE(mdb5_intr_cause) in these loops when
> "intr_cause" might be cpm6_intr_cause, which may be a different size
> than mdb5_intr_cause.
>

Thanks, I will fix both cause tables [32], and I will add

    static_assert(ARRAY_SIZE(mdb5_intr_cause) =3D=3D
                  ARRAY_SIZE(cpm6_intr_cause));

so the shared loop bound is guaranteed correct.
I will send in next patch.

> > +                   if (!intr_cause[i].str)
> > +                           continue;
> > +                   irq =3D irq_find_mapping(pcie->mdb_domain, i);
> > +                   if (irq) {
> > +                           disable_irq(irq);
> > +                           free_irq(irq, pcie);
> > +                           irq_dispose_mapping(irq);
> > +                   }
> > +           }
> > +           irq =3D irq_find_mapping(pcie->mdb_domain,
> > +                                  pcie->variant->intx_hwirq);
> > +           if (irq) {
> > +                   disable_irq(irq);
> > +                   free_irq(irq, pcie);
> > +                   irq_dispose_mapping(irq);
> > +           }
> > +
> >             irq_domain_remove(pcie->mdb_domain);
> >             pcie->mdb_domain =3D NULL;
> >     }
> >  }
> >
> > -static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> > +static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> >  {
> > -   unsigned long val;
> > +   u32 misc_mask_all;
> > +   u32 val;
> > +
> > +   misc_mask_all =3D pcie->variant->misc_mask_all;
> >
> >     /* Disable all TLP interrupts. */
> > -   writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> > -                  pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> > +   writel_relaxed(misc_mask_all,
> > +                  pcie->intr_base + pcie->variant->misc_disable_reg);
> > +
> > +   if (pcie->variant->version !=3D MDB5)
> > +           writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
> > +                          pcie->intr_base +
> AMD_CPM6_PCIE_ERR_DISABLE);
> >
> >     /* Clear pending TLP interrupts. */
> > -   val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> > -   val &=3D AMD_MDB_PCIE_IMR_ALL_MASK;
> > -   writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> > +   val =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_=
reg)
> &
> > +         misc_mask_all;
> > +   writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_re=
g);
> > +
> > +   if (pcie->variant->version !=3D MDB5) {
> > +           val =3D readl_relaxed(pcie->intr_base +
> AMD_CPM6_PCIE_ERR_STATUS) &
> > +                 AMD_CPM6_PCIE_ERR_MASK_ALL;
> > +           writel_relaxed(val, pcie->intr_base +
> AMD_CPM6_PCIE_ERR_STATUS);
> > +   }
> >
> >     /* Enable all TLP interrupts. */
> > -   writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> > -                  pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> > +   writel_relaxed(misc_mask_all,
> > +                  pcie->intr_base + pcie->variant->misc_enable_reg);
> >
> > -   return 0;
> > +   if (pcie->variant->version !=3D MDB5)
> > +           writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
> > +                          pcie->intr_base +
> AMD_CPM6_PCIE_ERR_ENABLE);
> >  }
> >
> >  /**
> > @@ -327,10 +520,13 @@ static int amd_mdb_pcie_init_irq_domains(struct
> amd_mdb_pcie *pcie,
> >  static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
> >  {
> >     struct amd_mdb_pcie *pcie =3D args;
> > +   const struct amd_mdb_intr_cause *intr_cause;
> >     struct device *dev;
> >     struct irq_data *d;
> >
> >     dev =3D pcie->pci.dev;
> > +   intr_cause =3D pcie->variant->version =3D=3D MDB5 ?
> > +                mdb5_intr_cause : cpm6_intr_cause;
> >
> >     /*
> >      * In the future, error reporting will be hooked to the AER subsyst=
em.
> > @@ -351,15 +547,19 @@ static int amd_mdb_setup_irq(struct
> amd_mdb_pcie *pcie,
> >     struct dw_pcie *pci =3D &pcie->pci;
> >     struct dw_pcie_rp *pp =3D &pci->pp;
> >     struct device *dev =3D &pdev->dev;
> > +   const struct amd_mdb_intr_cause *intr_cause;
> >     int i, irq, err;
> >
> > +   intr_cause =3D pcie->variant->version =3D=3D MDB5 ?
> > +                mdb5_intr_cause : cpm6_intr_cause;
> > +
> >     amd_mdb_pcie_init_port(pcie);
> >
> >     pp->irq =3D platform_get_irq(pdev, 0);
> >     if (pp->irq < 0)
> >             return pp->irq;
> >
> > -   for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> > +   for (i =3D 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {
> >             if (!intr_cause[i].str)
> >                     continue;
> >
> > @@ -379,7 +579,7 @@ static int amd_mdb_setup_irq(struct
> amd_mdb_pcie *pcie,
> >     }
> >
> >     pcie->intx_irq =3D irq_create_mapping(pcie->mdb_domain,
> > -                                       AMD_MDB_PCIE_INTR_INTX);
> > +                               pcie->variant->intx_hwirq);
> >     if (!pcie->intx_irq) {
> >             dev_err(dev, "Failed to map INTx interrupt\n");
> >             return -ENXIO;
> > @@ -439,6 +639,20 @@ static int amd_mdb_add_pcie_port(struct
> amd_mdb_pcie *pcie,
> >     if (IS_ERR(pcie->slcr))
> >             return PTR_ERR(pcie->slcr);
> >
> > +   /*
> > +    * On MDB5 all interrupt registers live in the SLCR block, so the
> > +    * interrupt-register base simply aliases @slcr. CPM6 moves the
> > +    * MISC_EVENT/PCIE_ERR registers into a separate per-controller
> region
> > +    * mapped by name as "intr".
> > +    */
> > +   if (pcie->variant->version =3D=3D MDB5) {
> > +           pcie->intr_base =3D pcie->slcr;
> > +   } else {
> > +           pcie->intr_base =3D
> devm_platform_ioremap_resource_byname(pdev, "intr");
> > +           if (IS_ERR(pcie->intr_base))
> > +                   return PTR_ERR(pcie->intr_base);
> > +   }
> > +
> >     err =3D amd_mdb_pcie_init_irq_domains(pcie, pdev);
> >     if (err)
> >             return err;
> > @@ -483,6 +697,9 @@ static int amd_mdb_pcie_probe(struct
> platform_device *pdev)
> >
> >     pci =3D &pcie->pci;
> >     pci->dev =3D dev;
> > +   pcie->variant =3D of_device_get_match_data(dev);
> > +   if (!pcie->variant)
> > +           return -EINVAL;
> >
> >     platform_set_drvdata(pdev, pcie);
> >
> > @@ -514,9 +731,51 @@ static void amd_mdb_pcie_shutdown(struct
> platform_device *pdev)
> >     gpiod_set_value_cansleep(pcie->perst_gpio, 1);
> >  }
> >
> > +static const struct amd_mdb_pcie_variant cpm6_host =3D {
> > +   .version =3D CPM6,
> > +   .misc_status_reg =3D AMD_CPM6_MISC_EVENT_STATUS,
> > +   .misc_mask_reg =3D AMD_CPM6_MISC_EVENT_MASK,
> > +   .misc_enable_reg =3D AMD_CPM6_MISC_EVENT_ENABLE,
> > +   .misc_disable_reg =3D AMD_CPM6_MISC_EVENT_DISABLE,
> > +   .misc_mask_all =3D AMD_CPM6_MISC_EVENT_MASK_ALL,
> > +   .intx_hwirq =3D AMD_CPM6_PCIE_INTR_INTX,
> > +   .intx_mask =3D BIT(AMD_CPM6_PCIE_INTR_INTX),
> > +};
> > +
> > +static const struct amd_mdb_pcie_variant cpm6_host1 =3D {
> > +   .version =3D CPM6_HOST1,
> > +   .misc_status_reg =3D AMD_CPM6_MISC_EVENT_STATUS,
> > +   .misc_mask_reg =3D AMD_CPM6_MISC_EVENT_MASK,
> > +   .misc_enable_reg =3D AMD_CPM6_MISC_EVENT_ENABLE,
> > +   .misc_disable_reg =3D AMD_CPM6_MISC_EVENT_DISABLE,
> > +   .misc_mask_all =3D AMD_CPM6_MISC_EVENT_MASK_ALL,
> > +   .intx_hwirq =3D AMD_CPM6_PCIE_INTR_INTX,
> > +   .intx_mask =3D BIT(AMD_CPM6_PCIE_INTR_INTX),
> > +};
> > +
> > +static const struct amd_mdb_pcie_variant mdb5_host =3D {
> > +   .version =3D MDB5,
> > +   .misc_status_reg =3D AMD_MDB_TLP_IR_STATUS_MISC,
> > +   .misc_mask_reg =3D AMD_MDB_TLP_IR_MASK_MISC,
> > +   .misc_enable_reg =3D AMD_MDB_TLP_IR_ENABLE_MISC,
> > +   .misc_disable_reg =3D AMD_MDB_TLP_IR_DISABLE_MISC,
> > +   .misc_mask_all =3D AMD_MDB_PCIE_IMR_ALL_MASK,
> > +   .intx_hwirq =3D AMD_MDB_PCIE_INTR_INTX,
> > +   .intx_mask =3D AMD_MDB_TLP_PCIE_INTX_MASK,
> > +};
> > +
> >  static const struct of_device_id amd_mdb_pcie_of_match[] =3D {
> >     {
> >             .compatible =3D "amd,versal2-mdb-host",
> > +           .data =3D &mdb5_host,
> > +   },
> > +   {
> > +           .compatible =3D "amd,versal2-cpm6-host",
> > +           .data =3D &cpm6_host,
> > +   },
> > +   {
> > +           .compatible =3D "amd,versal2-cpm6-host1",
> > +           .data =3D &cpm6_host1,
> >     },
> >     {},
> >  };
> > --
> > 2.44.4
> >
