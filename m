Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3ED1A6826;
	Sat,  7 Mar 2026 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843729; cv=fail; b=PzukUyzDFH9W9bbpaPZw9EKRJObZ6Jztz7XxjpCZNoJbaD/S0jycb/LT2e9ndBqRPm13dRPiufvJ21Bqc5KTC/0jg6hb6McMEezvU5SB8QxQr5J2ZQNnfmnmUCJ45nxOy0kXeF67BeUKpqLBP/GYhTZAR3LAylmOJwu47picwI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843729; c=relaxed/simple;
	bh=8X88dBgcplAQnlweK5GkLN28Lss5pRGbgZ6Ile0FmPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EHq4QdjckbQZj1rtW10vQer5SLdApAdGeieJSeH2OGQsmT+lnFjH8fBBEUqn6nEiNzqe7tWCua30WEM47vzGk4fZVa78RVFwuVn2wuMdhkK0aXWy1dWiyK81pKziWAAtwoTlazBXvyIYhayJ29S0nDeSoA/3IynxPKb9AAiw2rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EW0gkDuV; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EW0gkDuV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq2MKd6x9BrJtMqCK3O+m9PDVn9LKFN4/oXfTQRT4YjvKNZBRoLEw0Gt9XDkCIZYfhVnMrBmUdInaS95DFaTzegerHum2VZbc4TaUrRqO7TOHIY2Q9ZinfCPV4Oc+sqou5iq8oTCBq16vGxXZe90sJx82MFJ/f6y4aVt0Cea3D8xTz+w+0LhociNxamrvoXz/fyrUXu/BZaMUQTkea3Ab2TBsUcGM5pA/D1eL6iasdRUmDW4fryPOOjV43Dwo/JQrve/ji1qoW4wax+UHG92C05PZNWik3abGnCPHrGsa95AyrEd45Wwlb+NvaJMtLlWOmDHDgrSDxsZE819z4cq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZFqbInNLA4YrjBqNbzDs2JrrZQTw6o17Je+oehMAN4=;
 b=ncIrDDw5PKUAjfNTv50Tnxa0H6uaSPDi61wodfvDpNVDXF7SGnew9qGuSVibiFqrZr+CJFQjbgxqlSLScwNXwmqnbBdGZQoJldmcMhccpHQyiOJ0uVB/8EBhDMdWgFCaiSiSNgqbp5a6aVFZjXPDnHL/9ho4JmW8l8BzExgkTBZR6OlS9IzsvGI/9XCgCno7Uwt9eeCKIHAsTEzvq1NFtgMq/lD2IlKVosh8mHiXIouDM/ZHh55yW5TLLScdPMj8gR3PG0OsZJd+1QpvK+6MWpsdnejjWREaPdm3Zqpn6+ua9P6wutFrCVg7Po3JualWJQgUWM4CpmOULpx4xAd11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZFqbInNLA4YrjBqNbzDs2JrrZQTw6o17Je+oehMAN4=;
 b=EW0gkDuVoPYJyT9/2SXs6qvDPNd9MbogDrcKFf7ogPjJpAqQa38PRGTnwNBLuxj7CTL0BkJfCDEA3op6ug0bAA2zzRDHnj974upExRGg8MexQyh0j53Nz/gD0xE//xzd/3HFJ0rl/3zfqMvtzAWaEZtKIXXSVldQ39DoaKKHxodtMirBighiiqi9QvYs4sm0qtW+UwHkC2LdW9hRuwohSn2o5GpFq9vkn507IbT5SLpW377K7SBshZEtxhIrAtMxxJvMxyr9YdPZ+od1ZnoLbXUdsohcI2LVGaPQHeS4dm1XFyv0d8H1dHuLtV1njihQ4N5oAcwVYM6swyCcKQ48Ew==
Received: from DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) by
 LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Sat, 7 Mar
 2026 00:35:23 +0000
Received: from DS0PR12MB7725.namprd12.prod.outlook.com
 ([fe80::4581:d771:45f5:86cd]) by DS0PR12MB7725.namprd12.prod.outlook.com
 ([fe80::4581:d771:45f5:86cd%7]) with mapi id 15.20.9678.017; Sat, 7 Mar 2026
 00:35:22 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alex Williamson <alwilliamson@nvidia.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>, Jeshua
 Smith <jeshuas@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth
 Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl: Move HDM decoder and register map definitions to
 include/cxl/pci.h
Thread-Topic: [PATCH 2/5] cxl: Move HDM decoder and register map definitions
 to include/cxl/pci.h
Thread-Index: AQHcrT9fOuaj9+MTDUiBiF3GAn4XWLWhx3wAgABvvNs=
Date: Sat, 7 Mar 2026 00:35:22 +0000
Message-ID:
 <DS0PR12MB772529689331805F3B034630C37BA@DS0PR12MB7725.namprd12.prod.outlook.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260306080026.116789-3-smadhavan@nvidia.com>
 <20260306104516.50ac6f40@nvidia.com>
In-Reply-To: <20260306104516.50ac6f40@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7725:EE_|LV3PR12MB9095:EE_
x-ms-office365-filtering-correlation-id: 7834d3b7-f707-45f5-c5e5-08de7be16b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 xbZc0z+MCpNT0zhzQzpAfOW+zXJpDoFZZIZM5emqvaFAjQ+tAPHlHzkGwbHdGJ3uPHf+aqC2VrwgK+ee8/GjRrxNn8yhz+6C+ujgJe8d+Ne9Q2P6PvldM2Qa+vaH3rSuitnxNHqBnexH1s5dB2/XivkvkrrtSLLO3BdnLQyQHi1J3NbF+CE95ImQXTnzTrpfGbpPS7bMXPGmATqlw3oK0XVGqurjSY1t9mIjKlgjRVLH8/NiguKEBorf/jKRwxjsVJO+7OrtZOybsswhZ/SD3d6zXe/6sQZWiuGk/Pia+v0I2EK4Q0tLEhda7sgcBa4eOAIFKHBq+omKpj4AcjPnb6dxXu+8ko4JQWCQzYL3nbKDT7WfN0BPo82fmZEJz6Zhzz4O5y4UX7TOwUUrAjCym8hnis5VXNbqmwIo6QsuJI+eBaelofcZ71JSN5mMtVSp0FZY5TAA9Om6N7jb/NHSiuh/rg1kq8O/ToZRisH2njWPKycoAqcFhG3kl1XKcaF39p5Abq/19nmOqTq4kFnTEzTUpmVZWIVcYOA+W0ogP7OfOu7qikfq7+2Y5VoZx2iHOgmLaj8v5kGdPlDv6t0xoGDjwGfz+kiex7DWt6z+TB9Q3RXqsWdC2ot5ZfyIPc3jIo8L/GV5uNIARts5rcwEWkkVewMPLHhEMNpTs24RqLEhKXS8yyFMGfVQ/HLyzj2hXKfmkEgGRKYO5J3HnjP1UzYql73UxpCFWSq9PZkylFtBrb3AcwXxjfUKGS6LzHCqL2MpE3Tk8qfZVJNbto15SHdN9I9J2UukWhJ2umeSs3Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7725.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qlDDdEW9sFu3M6EDCSq5l9iTANPm0KgColVqbcB9urOPud03D2W2qCsQLesi?=
 =?us-ascii?Q?S/BQ7zhHzSkrHflQkAtAKJKl3Ixx1F+R+itxn5p6GP1ZawJcd4wx5WtL5p56?=
 =?us-ascii?Q?1vsA4Kfe3z8Bn3LJNH/oB/t3OA/CH0TTE89zsNqQ7v2yFZI3K1lVkmrcf9Br?=
 =?us-ascii?Q?OnTa5tXhc1vtnzGDye7o25gRr/T24PjMw/rYETRN2WSE/U1dFYTmt5SBoeW0?=
 =?us-ascii?Q?+Sy9MOWuFhnPFQaudQnQ+mO/8XrewExO9Y95HwVrnFxKnFH4GghAInTWXgmI?=
 =?us-ascii?Q?7jd4cVMe005UbUchZ0fE7frKsr8Q4j4G8bdnWP9by5gNmP5pFZlzC8eZRzHV?=
 =?us-ascii?Q?FSEuOjCq33C5DTn+gyMtuJLXPyCNWAVi9NkfDX8tIm746qcSHp4uS2oetV7U?=
 =?us-ascii?Q?ojhaVD2TNb4yEbXp891VolnwUjWr0DrzWW8lNKBJS6HsI6IBq1lne1xQRweq?=
 =?us-ascii?Q?H/TQJO8/xaH/5Rd2EtFO7g0YGq1eTYVyeiwuL/eGzjblQKoiIQQB6I/KQtzE?=
 =?us-ascii?Q?byElwHQAxVC+OZoxPjJBZPWXaGTJ3PzCuxUPMu2Imr93Sn+aWVrK1KUmMEmC?=
 =?us-ascii?Q?H0kZ3TY7Pc/+hG4fslKxOXqdWukJxEFNeni2Aaeoprh2lpX9Bi/Eo8XuNWxw?=
 =?us-ascii?Q?BaMnFhZCzwa0XFZafOExqIaEdYrGLXgoRPq+0MhzBDbo6jyudWHoMUae714V?=
 =?us-ascii?Q?hJqU3O7DdzfanpC9ViC+ioektA2R0WNBQb+tTSk4R03TYq1W3IDJXLSxIlJK?=
 =?us-ascii?Q?7Xq9ygJulhIJ4CEijzHzKJ4rzc8muTkOFaHV+VYn9tCYpwv1+XFNzhz9/rnr?=
 =?us-ascii?Q?9QseLpKEMr/2fP9aIcwC4NkLAqRVU4nmfqY7+yWjX1tGSKwcdPAM9hl1G7eM?=
 =?us-ascii?Q?xdbh1mOAg9nEQ48BXSzy9MUMM/fiotUr0zXHp65sClDWxrNxGkcVpFm97Q7M?=
 =?us-ascii?Q?E5xah32nZfkDoDpPBjgUsh1SI47qYkNBqTc9flNaC7CL+B5qsd2erRyRwhJ2?=
 =?us-ascii?Q?f77RTAf5iz0W9LghZky3hayGTYW9ZYIdncHLwnGOpKyMX5WqrsOIrtEIqvMn?=
 =?us-ascii?Q?8hXqlXQMUbh1A5qRv4MBAGsYeGCC+4Gm8Pv9UzmXVZetbO59Io4iB6RulhzH?=
 =?us-ascii?Q?rXpeOQnLJH3LA6XuUL4FFhS0QiAfhMRZ2CcmXStKhteGPCth3SpGQUg+Kum3?=
 =?us-ascii?Q?Amv0aUGeSIHupwAoUA8kgBqHJth8Hdm7EDw94jYXOGrg3HT27XJyyvPpA5s2?=
 =?us-ascii?Q?k430zn20bEQ/W+j4fZmgjFLepopuEJ4Qlzj7/6pOiRx2w3WFnsF/Wxn19m8p?=
 =?us-ascii?Q?C811wIgPrB6aQKCzVv8XinnvxquILp7Z8p7LNsh4xyRpxHCZq4gcfCb6W5sK?=
 =?us-ascii?Q?pvAePJiG7POZEU5FuZxWudaQ1f2v0Rfwq/nXqhFNj2R4DlaEbBe/P7uCRpOZ?=
 =?us-ascii?Q?pVLol0AugzVjbixO9LTAKFXrHbv0xyegrifx5DnI3L/8MEc6UCL4VDmX/aut?=
 =?us-ascii?Q?Fl9xMb8fqG+03Dl8q0k7rSGhBtliEhg7G1wIp3G1q1+Gbl0kgLsDSTj9ZF4m?=
 =?us-ascii?Q?HYjyQwLLlZvImFvPMu3ImEl+HsJxsIpNl7yQ/v+1Isb18JFwvfx/TmKfcmL9?=
 =?us-ascii?Q?sGXFBoK3qoHAjmLjP2fBZhzaISZTdgIzJ2nuMpq8X/beB10CIeeuz3itzWUV?=
 =?us-ascii?Q?2cLY8dDL8NM5ptC6LBuHVCpk7D2teCizng9vJwZ3q3fbgSmu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7725.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7834d3b7-f707-45f5-c5e5-08de7be16b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2026 00:35:22.7790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lwWcjwAjlM/8R7ak41V+rT9LRwyiLOQNOaYdbrwuu6rK8DWSS5ocG77rT83/4qiqQtPVos2X1alun9MMvE6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

> So moving them to the public header is just unnecessary code churn.
Apologies for that oversight. I can remove the unnecessary moves from this =
patch.

> Also, specifically regarding cxl_find_regblock(), where 5/ implements a
> new cxl_find_component_regblock().  The latter looks significantly
> similar to the original.  Shouldn't we refactor the new PCI implemented
> version to be more generic rather than scope reduced, and export it for
> use by CXL code to avoid the duplication?

Regarding the duplication between cxl_find_component_regblock()
and the CXL subsystem's cxl_find_regblock():
I understand the duplication isn't ideal. I looked into generalizing the PC=
I version
(cxl_find_component_regblock) and exporting it for CXL to use, but exportin=
g just
the find step from PCI while the rest of the register discovery pipeline st=
ays in CXL
felt like an inconsistent split across the two subsystems. It seems like ad=
dressing
that would mean refactoring a significant portion of regs.c into the PCI su=
bsystem,
which also doesn't appear correct.
Given that, would it be acceptable to keep the current scope-reduced versio=
n in the
PCI?
Please let me know if it would be acceptable to just refactor the cxl_find_=
component_regblock
and export it from pci.

Thank you.

Regards,
Srirangan.

________________________________________
From: Alex Williamson <alwilliamson@nvidia.com>
Sent: Friday, March 6, 2026 9:45 AM
To: Srirangan Madhavan
Cc: bhelgaas@google.com; dan.j.williams@intel.com; dave.jiang@intel.com; jo=
nathan.cameron@huawei.com; ira.weiny@intel.com; vishal.l.verma@intel.com; a=
lison.schofield@intel.com; dave@stgolabs.net; Jeshua Smith; Vikram Sethi; S=
ai Yashwanth Reddy Kancherla; Vishal Aslot; Shanker Donthineni; Manish Hona=
p; Vidya Sagar; Jiandi An; Matt Ochs; Derek Schumacher; linux-cxl@vger.kern=
el.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl: Move HDM decoder and register map definitions=
 to include/cxl/pci.h

On Fri, 6 Mar 2026 08:00:16 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
>
> Move CXL HDM decoder register defines, register map structs
> (cxl_reg_map, cxl_component_reg_map, cxl_device_reg_map,
> cxl_pmu_reg_map, cxl_register_map), cxl_hdm_decoder_count(),
> enum cxl_regloc_type, and cxl_find_regblock()/cxl_setup_regs()
> declarations from internal CXL headers to include/cxl/pci.h.

Regarding cxl_find_regblock()/cxl_setup_regs()..

> This makes them accessible to code outside the CXL subsystem, in
> particular the PCI core CXL state save/restore support added in a
> subsequent patch.

Yet in 5/:

    The Register Locator DVSEC is parsed directly via PCI config space
    reads rather than calling cxl_find_regblock()/cxl_setup_regs(),
    since this code lives in the PCI core and must not depend on CXL
    module symbols.

So moving them to the public header is just unnecessary code churn.

Also, specifically regarding cxl_find_regblock(), where 5/ implements a
new cxl_find_component_regblock().  The latter looks significantly
similar to the original.  Shouldn't we refactor the new PCI implemented
version to be more generic rather than scope reduced, and export it for
use by CXL code to avoid the duplication?  Thanks,

Alex

> No functional change.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/cxl.h    | 107 +----------------------------------
>  drivers/cxl/cxlpci.h |  10 ----
>  include/cxl/pci.h    | 129 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 116 deletions(-)
>  create mode 100644 include/cxl/pci.h
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 04c673e7cdb0..0c84695449d8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>  #include <linux/node.h>
>  #include <linux/io.h>
>  #include <linux/range.h>
> +#include <cxl/pci.h>
>
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>
> @@ -23,63 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_=
ops;
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
>
> -/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> -#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> -
> -/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
> -#define CXL_CM_OFFSET 0x1000
> -#define CXL_CM_CAP_HDR_OFFSET 0x0
> -#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
> -#define     CM_CAP_HDR_CAP_ID 1
> -#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
> -#define     CM_CAP_HDR_CAP_VERSION 1
> -#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
> -#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> -#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> -#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> -
> -#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> -#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> -
> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> -#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> -#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> -#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> -#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> -#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> -#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> -#define   CXL_HDM_DECODER_ENABLE BIT(1)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> -#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> -#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> -#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> -#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> -#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> -#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> -#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> -#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> -#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> -#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> -#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> -
> -/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
> -#define CXL_DECODER_MIN_GRANULARITY 256
> -#define CXL_DECODER_MAX_ENCODED_IG 6
> -
> -static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> -{
> -     int val =3D FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> -
> -     return val ? val * 2 : 1;
> -}
> -
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>  {
> @@ -246,51 +190,6 @@ struct cxl_regs {
>       );
>  };
>
> -struct cxl_reg_map {
> -     bool valid;
> -     int id;
> -     unsigned long offset;
> -     unsigned long size;
> -};
> -
> -struct cxl_component_reg_map {
> -     struct cxl_reg_map hdm_decoder;
> -     struct cxl_reg_map ras;
> -};
> -
> -struct cxl_device_reg_map {
> -     struct cxl_reg_map status;
> -     struct cxl_reg_map mbox;
> -     struct cxl_reg_map memdev;
> -};
> -
> -struct cxl_pmu_reg_map {
> -     struct cxl_reg_map pmu;
> -};
> -
> -/**
> - * struct cxl_register_map - DVSEC harvested register block mapping para=
meters
> - * @host: device for devm operations and logging
> - * @base: virtual base of the register-block-BAR + @block_offset
> - * @resource: physical resource base of the register block
> - * @max_size: maximum mapping size to perform register search
> - * @reg_type: see enum cxl_regloc_type
> - * @component_map: cxl_reg_map for component registers
> - * @device_map: cxl_reg_maps for device registers
> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> - */
> -struct cxl_register_map {
> -     struct device *host;
> -     void __iomem *base;
> -     resource_size_t resource;
> -     resource_size_t max_size;
> -     u8 reg_type;
> -     union {
> -             struct cxl_component_reg_map component_map;
> -             struct cxl_device_reg_map device_map;
> -             struct cxl_pmu_reg_map pmu_map;
> -     };
> -};
>
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>                             struct cxl_component_reg_map *map);
> @@ -304,13 +203,9 @@ int cxl_map_device_regs(const struct cxl_register_ma=
p *map,
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *=
regs);
>
>  #define CXL_INSTANCES_COUNT -1
> -enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_typ=
e type,
>                              struct cxl_register_map *map, unsigned int i=
ndex);
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -                   struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>                                          struct cxl_dport *dport);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0cf64218aa16..9e825c039dd9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -13,16 +13,6 @@
>   */
>  #define CXL_PCI_DEFAULT_MAX_VECTORS 16
>
> -/* Register Block Identifier (RBI) */
> -enum cxl_regloc_type {
> -     CXL_REGLOC_RBI_EMPTY =3D 0,
> -     CXL_REGLOC_RBI_COMPONENT,
> -     CXL_REGLOC_RBI_VIRT,
> -     CXL_REGLOC_RBI_MEMDEV,
> -     CXL_REGLOC_RBI_PMU,
> -     CXL_REGLOC_RBI_TYPES
> -};
> -
>  /*
>   * Table Access DOE, CDAT Read Entry Response
>   *
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..763a048262c7
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __CXL_CXL_PCI_H__
> +#define __CXL_CXL_PCI_H__
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/types.h>
> +
> +/* Register Block Identifier (RBI) */
> +enum cxl_regloc_type {
> +     CXL_REGLOC_RBI_EMPTY =3D 0,
> +     CXL_REGLOC_RBI_COMPONENT,
> +     CXL_REGLOC_RBI_VIRT,
> +     CXL_REGLOC_RBI_MEMDEV,
> +     CXL_REGLOC_RBI_PMU,
> +     CXL_REGLOC_RBI_TYPES
> +};
> +
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
> +/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers */
> +#define CXL_CM_OFFSET 0x1000
> +#define CXL_CM_CAP_HDR_OFFSET 0x0
> +#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
> +#define     CM_CAP_HDR_CAP_ID 1
> +#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
> +#define     CM_CAP_HDR_CAP_VERSION 1
> +#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
> +#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
> +#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
> +#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
> +
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +
> +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
> +#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> +#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> +
> +/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
> +#define CXL_DECODER_MIN_GRANULARITY 256
> +#define CXL_DECODER_MAX_ENCODED_IG 6
> +
> +static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> +{
> +     int val =3D FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> +
> +     return val ? val * 2 : 1;
> +}
> +
> +struct cxl_reg_map {
> +     bool valid;
> +     int id;
> +     unsigned long offset;
> +     unsigned long size;
> +};
> +
> +struct cxl_component_reg_map {
> +     struct cxl_reg_map hdm_decoder;
> +     struct cxl_reg_map ras;
> +};
> +
> +struct cxl_device_reg_map {
> +     struct cxl_reg_map status;
> +     struct cxl_reg_map mbox;
> +     struct cxl_reg_map memdev;
> +};
> +
> +struct cxl_pmu_reg_map {
> +     struct cxl_reg_map pmu;
> +};
> +
> +/**
> + * struct cxl_register_map - DVSEC harvested register block mapping para=
meters
> + * @host: device for devm operations and logging
> + * @base: virtual base of the register-block-BAR + @block_offset
> + * @resource: physical resource base of the register block
> + * @max_size: maximum mapping size to perform register search
> + * @reg_type: see enum cxl_regloc_type
> + * @component_map: cxl_reg_map for component registers
> + * @device_map: cxl_reg_maps for device registers
> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> + */
> +struct cxl_register_map {
> +     struct device *host;
> +     void __iomem *base;
> +     resource_size_t resource;
> +     resource_size_t max_size;
> +     u8 reg_type;
> +     union {
> +             struct cxl_component_reg_map component_map;
> +             struct cxl_device_reg_map device_map;
> +             struct cxl_pmu_reg_map pmu_map;
> +     };
> +};
> +
> +struct pci_dev;
> +
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                   struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map);
> +
> +#endif /* __CXL_CXL_PCI_H__ */
> --
> 2.43.0
>

