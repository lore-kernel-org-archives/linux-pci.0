Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC711C41536
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4973E20685
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 17:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j5bYCkB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4973E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKUEAh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:00:37 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:59860 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeKUEAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 23:00:36 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf444a90000>; Wed, 21 Nov 2018 01:30:17 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 09:30:15 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 20 Nov 2018 09:30:15 -0800
Received: from DRBGMAIL104.nvidia.com (10.18.16.23) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 17:30:14 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL104.nvidia.com
 (10.18.16.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 17:30:13 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (207.46.163.17)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 20 Nov 2018 17:30:13 +0000
Received: from BN6PR12MB1171.namprd12.prod.outlook.com (10.168.226.149) by
 BN6PR12MB1761.namprd12.prod.outlook.com (10.175.101.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 17:30:09 +0000
Received: from BN6PR12MB1171.namprd12.prod.outlook.com
 ([fe80::5de8:25aa:558:9c5e]) by BN6PR12MB1171.namprd12.prod.outlook.com
 ([fe80::5de8:25aa:558:9c5e%5]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 17:30:08 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Manikanta Maddireddy" <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH] PCI: dwc ep: cache config until DBI regs available
Thread-Topic: [PATCH] PCI: dwc ep: cache config until DBI regs available
Thread-Index: AQHUgFb9PVOQzMjPyU+Atke+BX6uHaVY6g8Q
Date:   Tue, 20 Nov 2018 17:30:08 +0000
Message-ID: <BN6PR12MB11714E3FED1EF50D7F3CA3C9B8D90@BN6PR12MB1171.namprd12.prod.outlook.com>
References: <20181119222602.28001-1-swarren@wwwdotorg.org>
In-Reply-To: <20181119222602.28001-1-swarren@wwwdotorg.org>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Manual;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2018-11-20T17:21:22.8049511Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=vidyas@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 Sensitivity=Unrestricted
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vidyas@nvidia.com; 
x-originating-ip: [202.164.25.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1761;6:i0cbz20cmROKUIqVa/TOelib1DeVePnDKNMlGL9sAlEMG6AWGz0BjuN0UlLWW6jBTOtVQLaxpuYWmyGfPUTjqbrMb+CYM/BW5VuPPoHh2O3L7gckW9dKfNAOl3to04LC1v34x1+lg8JyqrVTyiEYnQ1GxVNbjIG2mSuEG/gLLjtPS/c6771Uol/SEVK0ltXxI3Qu/5vIDuASsqedKvaX4oIS9WppVDtgKTV/7kov7KhnwmA2bfcDDnmGEJi32iaqsVFCjxJzQguUoaJ0ZlPKfUkqOunBDEiEtEUbnavtmy1bauy4LMOJ2V30TQRwgasWb11kKrj1hWhGj7yv32N8IbTuKqxy6hvskM5AYqLOPNKDCS2ZlFrfRA+IHq2EU5nKLOzFs6U8+pVkScU7zcMOJ33Rj7yPC4MiH4bPx5NM1ra7zoZf0xNs8qXG93mi9350edfwh4HlLki74b5lj+ir2Q==;5:JjAqNOyLQJEU7amw4YMp+6p8pbb1MrqCmFslsWXpJdSCMeD4LMwlV95RlPTZqVEIYkI7l8Gf7wgQ3I/9zN1G8xGuTnHiZlI8Fg1eZgYz1gQ22cirOcft9QsA28xb8RmW2owOTWGmNfrTSk/KECP7b1hOhN2xDM3nEvL0nixBMlE=;7:2/zHHABAdLhuaJOAqbJK+OJYN7X43QH9qmeiKXm5R+rvJMVeBtOrKWW2iV+nqeEpjsBhMoeJtjVTkiow2oS8JUjBjka4VXDZ5IVgQhsQE8+vh7jMbce7IBg3jOrn576m9jYHutJSRyk1pJhHB4bJWQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(13464003)(199004)(189003)(14454004)(186003)(71200400001)(106356001)(71190400001)(86362001)(5660300001)(53946003)(486006)(105586002)(7696005)(478600001)(99286004)(53936002)(97736004)(33656002)(68736007)(4744004)(26005)(102836004)(76176011)(6506007)(53546011)(25786009)(2900100001)(256004)(6436002)(54906003)(6246003)(110136005)(9686003)(316002)(14444005)(2906002)(66066001)(39060400002)(81156014)(4326008)(107886003)(8936002)(8676002)(6116002)(3846002)(5024004)(446003)(55016002)(74316002)(305945005)(476003)(7736002)(11346002)(81166006)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1761;H:BN6PR12MB1171.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1fcf79df-8832-4ce4-8871-08d64f0dd171
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1761;
x-ms-traffictypediagnostic: BN6PR12MB1761:
x-microsoft-antispam-prvs: <BN6PR12MB176176207EF167E917163B52B8D90@BN6PR12MB1761.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1761;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1761;
x-forefront-prvs: 08626BE3A5
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 39NTzNaEtVJjrk7ER8irSQxtX+civI0nug8b35521/8524X4Pln6KYdn+dSMIyYYmwE6OrcqoANDol/Bp4r5jKOI1qw/Vq7Li9GIocy3SF1ohtlWQZ1Ave+TyJzHVjBXKXtM7DaUkvKYqJaWHV6+cccCojFpdUhKWt5GmTIgEjlzvM2WhmfSWMc4i7xQmB/baG22NRBJqi2dvwkHZwfWKEQgb7HVsZljh6Xbf5XVPXcBxWfyxgndwZU0z+t+L7kSygN8SivXKMrj64qkpnUeZVzVfdTXrxGCDBAmPQDM+lXsFsmUuQGiw6WJRpHoMS+TQjIdGvfsz5ZdDDxVnoPvuEdNbVhYMBXg3aga/OFE+ww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcf79df-8832-4ce4-8871-08d64f0dd171
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 17:30:08.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542735017; bh=juSRNI7v5ppCBoFokodhGOXDRqCFmO2F4lxJPKrfShA=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
         x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=j5bYCkB+8JSw6vutgYfStVTKtROywrwVrxkx8/0ctdT6D/9dwdwLRrV9Gh/J/Z/gh
         rJqsNiYFaR+dhwh+GxpW6+HstwjN9LZH41m7kjPZnaeOy3O+OFO509WQKv0Rm8dgkF
         GI3NIQ2q5Qs+U6XeRTtTSncrJqk5xg6vP/oKaNdGqqkpsbU1ZsECvvhAzzmje89hzG
         G5Gt4+RzTIvxw/xXNufMVFPkY3Eo/TZxCogVJZSPbznzCnMJubReC/ZOcFpzSMe+Ch
         26uToRt5mpGorRWz7o0s2oqaCpol6ayNCk4sgDt69YS79SFp8M93uL2WJOdXK8ATos
         ZiFDgNVAgI+Cg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Stephen Warren <swarren@wwwdotorg.org>
> Sent: Tuesday, November 20, 2018 3:56 AM
> To: Jingoo Han <jingoohan1@gmail.com>; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org; Vidya Sagar <vidyas@nvidia.com>; Manikan=
ta
> Maddireddy <mmaddireddy@nvidia.com>; Stephen Warren
> <swarren@nvidia.com>
> Subject: [PATCH] PCI: dwc ep: cache config until DBI regs available
>=20
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Some implementations of the DWC PCIe endpoint controller do not allow a=
ccess
> to DBI registers until the attached host has started REFCLK, released P=
ERST, and
> the endpoint driver has initialized clocking of the DBI registers based=
=20on that.
> One such system is NVIDIA's T194 SoC. The PCIe endpoint subsystem and D=
WC
> driver currently don't work on such hardware, since they assume that al=
l
> endpoint configuration can happen at any arbitrary time.
>=20
> Enhance the DWC endpoint driver to support such systems by caching all
> endpoint configuration in software, and only writing the configuration =
to
> hardware once it's been initialized. This is implemented by splitting a=
ll endpoint
> controller ops into two functions; the first which simply records/cache=
s the
> desired configuration whenever called by the associated function driver=
=20and
> optionally calls the second, and the second which actually programs the=

> configuration into hardware, which may be called either by the first fu=
nction, or
> later when it's known that the DBI registers are available.
>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Note: I have only compiled-tested this patch in the context of the main=
line
> kernel since NVIDIA Tegra PCIe EP support is not yet present.
> However, I've built and tested an equivalent patch in our downstream ke=
rnel. I
> did have to manually port it to mainline due to conflicts though.
>=20
> This patch was developed on top of "PCI: designware: don't hard-code DB=
I/ATU
> offset" which I sent last week, so may rely on that for patch context.
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 199 ++++++++++++++----=

>  drivers/pci/controller/dwc/pcie-designware.h  |  26 ++-
>  2 files changed, 181 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 880210366e71..6910b64bfdcb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -73,11 +73,10 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie=

> *pci, u8 cap)
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);  }
>=20
> -static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
> -				   struct pci_epf_header *hdr)
> +static void dw_pcie_ep_write_header_regs(struct dw_pcie_ep *ep)
>  {
> -	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	struct pci_epf_header *hdr =3D &(ep->cached_hdr);
>=20
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid); @@ -94,6
> +93,19 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8
> func_no,
>  	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
>  			   hdr->interrupt_pin);
>  	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
> +				   struct pci_epf_header *hdr)
> +{
> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> +
> +	ep->cached_hdr =3D *hdr;
> +
> +	if (!ep->hw_regs_available)
> +		return 0;
> +
> +	dw_pcie_ep_write_header_regs(ep);
>=20
>  	return 0;
>  }
> @@ -112,6 +124,15 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_e=
p
> *ep, enum pci_barno bar,
>  		return -EINVAL;
>  	}
>=20
> +	ep->cached_inbound_atus[free_win].bar =3D bar;
> +	ep->cached_inbound_atus[free_win].cpu_addr =3D cpu_addr;
> +	ep->cached_inbound_atus[free_win].as_type =3D as_type;
> +	ep->cached_bars[bar].atu_index =3D free_win;
> +	set_bit(free_win, ep->ib_window_map);
> +
> +	if (!ep->hw_regs_available)
> +		return 0;
> +
>  	ret =3D dw_pcie_prog_inbound_atu(pci, free_win, bar, cpu_addr,
>  				       as_type);
>  	if (ret < 0) {
> @@ -119,9 +140,6 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep=

> *ep, enum pci_barno bar,
>  		return ret;
>  	}
>=20
> -	ep->bar_to_atu[bar] =3D free_win;
> -	set_bit(free_win, ep->ib_window_map);
> -
>  	return 0;
>  }
>=20
> @@ -137,27 +155,66 @@ static int dw_pcie_ep_outbound_atu(struct
> dw_pcie_ep *ep, phys_addr_t phys_addr,
>  		return -EINVAL;
>  	}
>=20
> +	ep->cached_outbound_atus[free_win].addr =3D phys_addr;
> +	ep->cached_outbound_atus[free_win].pci_addr =3D pci_addr;
> +	ep->cached_outbound_atus[free_win].size =3D size;
> +	set_bit(free_win, ep->ob_window_map);
> +
> +	if (!ep->hw_regs_available)
> +		return 0;
> +
>  	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
>  				  phys_addr, pci_addr, size);
>=20
> -	set_bit(free_win, ep->ob_window_map);
> -	ep->outbound_addr[free_win] =3D phys_addr;
> -
>  	return 0;
>  }
>=20
> +static void dw_pcie_ep_clear_bar_regs(struct dw_pcie_ep *ep, u8 func_n=
o,
> +				      enum pci_barno bar)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	int flags =3D ep->cached_bars[bar].flags;
> +	u32 atu_index =3D ep->cached_bars[bar].atu_index;
> +
> +	__dw_pcie_ep_reset_bar(pci, bar, flags);
> +
> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND); }
> +
>  static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
>  				 struct pci_epf_bar *epf_bar)
>  {
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> -	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar =3D epf_bar->barno;
> -	u32 atu_index =3D ep->bar_to_atu[bar];
> +	u32 atu_index =3D ep->cached_bars[bar].atu_index;
>=20
> -	__dw_pcie_ep_reset_bar(pci, bar, epf_bar->flags);
> -
> -	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
>  	clear_bit(atu_index, ep->ib_window_map);
> +
> +	if (!ep->hw_regs_available)
> +		return;
> +
> +	dw_pcie_ep_clear_bar_regs(ep, func_no, bar); }
> +
> +static void dw_pcie_ep_set_bar_regs(struct dw_pcie_ep *ep, u8 func_no,=

> +				    enum pci_barno bar)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	size_t size =3D ep->cached_bars[bar].size;
> +	int flags =3D ep->cached_bars[bar].flags;
> +	u32 reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> +	dw_pcie_writel_dbi(pci, reg, flags);
> +
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_writel_dbi(pci, reg + 4, 0);
> +	}
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>=20
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, @@ -165=
,12
> +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_n=
o,  {
>  	int ret;
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> -	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar =3D epf_bar->barno;
>  	size_t size =3D epf_bar->size;
>  	int flags =3D epf_bar->flags;
>  	enum dw_pcie_as_type as_type;
> -	u32 reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
>=20
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		as_type =3D DW_PCIE_AS_MEM;
> @@ -181,17 +236,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc=
, u8
> func_no,
>  	if (ret)
>  		return ret;
>=20
> -	dw_pcie_dbi_ro_wr_en(pci);
> -
> -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> -	dw_pcie_writel_dbi(pci, reg, flags);
> +	ep->cached_bars[bar].size =3D size;
> +	ep->cached_bars[bar].flags =3D flags;
>=20
> -	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> -		dw_pcie_writel_dbi(pci, reg + 4, 0);
> -	}
> +	if (!ep->hw_regs_available)
> +		return 0;
>=20
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	dw_pcie_ep_set_bar_regs(ep, func_no, bar);
>=20
>  	return 0;
>  }
> @@ -202,7 +253,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep=
,
> phys_addr_t addr,
>  	u32 index;
>=20
>  	for (index =3D 0; index < ep->num_ob_windows; index++) {
> -		if (ep->outbound_addr[index] !=3D addr)
> +		if (ep->cached_outbound_atus[index].addr !=3D addr)
>  			continue;
>  		*atu_index =3D index;
>  		return 0;
> @@ -223,8 +274,12 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc
> *epc, u8 func_no,
>  	if (ret < 0)
>  		return;
>=20
> -	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
>  	clear_bit(atu_index, ep->ob_window_map);
> +
> +	if (!ep->hw_regs_available)
> +		return;
> +
> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
>  }
>=20
>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, @@ -25=
4,7
> +309,10 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_n=
o)
>  		return -EINVAL;
>=20
>  	reg =3D ep->msi_cap + PCI_MSI_FLAGS;
> -	val =3D dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_available)
> +		val =3D dw_pcie_readw_dbi(pci, reg);
> +	else
> +		val =3D ep->cached_msi_flags;
>  	if (!(val & PCI_MSI_FLAGS_ENABLE))
>  		return -EINVAL;
>=20
> @@ -273,12 +331,19 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc=
, u8
> func_no, u8 interrupts)
>  		return -EINVAL;
>=20
>  	reg =3D ep->msi_cap + PCI_MSI_FLAGS;
> -	val =3D dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_available)
> +		val =3D dw_pcie_readw_dbi(pci, reg);
> +	else
> +		val =3D ep->cached_msi_flags;
>  	val &=3D ~PCI_MSI_FLAGS_QMASK;
>  	val |=3D (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
> -	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, reg, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	if (ep->hw_regs_available) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writew_dbi(pci, reg, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	} else {
> +		ep->cached_msi_flags =3D val;
> +	}
>=20
>  	return 0;
>  }
> @@ -293,7 +358,10 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc=
,
> u8 func_no)
>  		return -EINVAL;
>=20
>  	reg =3D ep->msix_cap + PCI_MSIX_FLAGS;
> -	val =3D dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_available)
> +		val =3D dw_pcie_readw_dbi(pci, reg);
> +	else
> +		val =3D ep->cached_msix_flags;
>  	if (!(val & PCI_MSIX_FLAGS_ENABLE))
>  		return -EINVAL;
>=20
> @@ -312,16 +380,49 @@ static int dw_pcie_ep_set_msix(struct pci_epc *ep=
c,
> u8 func_no, u16 interrupts)
>  		return -EINVAL;
>=20
>  	reg =3D ep->msix_cap + PCI_MSIX_FLAGS;
> -	val =3D dw_pcie_readw_dbi(pci, reg);
> +	if (ep->hw_regs_available)
> +		val =3D dw_pcie_readw_dbi(pci, reg);
> +	else
> +		val =3D ep->cached_msix_flags;
>  	val &=3D ~PCI_MSIX_FLAGS_QSIZE;
>  	val |=3D interrupts;
> -	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, reg, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	if (ep->hw_regs_available) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writew_dbi(pci, reg, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	} else {
> +		ep->cached_msix_flags =3D val;
> +	}
>=20
>  	return 0;
>  }
>=20
> +void dw_pcie_set_regs_available(struct dw_pcie *pci) {
> +	struct dw_pcie_ep *ep =3D &(pci->ep);
> +	int i;
> +
> +	ep->hw_regs_available =3D true;
> +
> +	dw_pcie_ep_write_header_regs(ep);
> +	for_each_set_bit(i, ep->ib_window_map, ep->num_ib_windows) {
> +		dw_pcie_prog_inbound_atu(pci, i,
> +			ep->cached_inbound_atus[i].bar,
> +			ep->cached_inbound_atus[i].cpu_addr,
> +			ep->cached_inbound_atus[i].as_type);
> +		dw_pcie_ep_set_bar_regs(ep, 0, ep-
> >cached_inbound_atus[i].bar);
> +	}
> +	for_each_set_bit(i, ep->ob_window_map, ep->num_ob_windows)
> +		dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> +			ep->cached_outbound_atus[i].addr,
> +			ep->cached_outbound_atus[i].pci_addr,
> +			ep->cached_outbound_atus[i].size);
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cached_msi_flags);
> +	dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->cached_msix_flags);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>  				enum pci_epc_irq_type type, u16
> interrupt_num)  { @@ -330,6 +431,9 @@ static int dw_pcie_ep_raise_irq(s=
truct
> pci_epc *epc, u8 func_no,
>  	if (!ep->ops->raise_irq)
>  		return -EINVAL;
>=20
> +	if (!ep->hw_regs_available)
> +		return -EAGAIN;
> +
>  	return ep->ops->raise_irq(ep, func_no, type, interrupt_num);  }
>=20
> @@ -391,6 +495,9 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,=

> u8 func_no,
>  	bool has_upper;
>  	int ret;
>=20
> +	if (!ep->hw_regs_available)
> +		return -EAGAIN;
> +
>  	if (!ep->msi_cap)
>  		return -EINVAL;
>=20
> @@ -436,6 +543,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep=
,
> u8 func_no,
>  	void __iomem *msix_tbl;
>  	int ret;
>=20
> +	if (!ep->hw_regs_available)
> +		return -EAGAIN;
> +
>  	reg =3D ep->msix_cap + PCI_MSIX_TABLE;
>  	tbl_offset =3D dw_pcie_readl_dbi(pci, reg);
>  	bir =3D (tbl_offset & PCI_MSIX_TABLE_BIR); @@ -494,7 +604,6 @@ void
> dw_pcie_ep_exit(struct dw_pcie_ep *ep)  int dw_pcie_ep_init(struct
> dw_pcie_ep *ep)  {
>  	int ret;
> -	void *addr;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct device *dev =3D pci->dev;
> @@ -543,11 +652,17 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (!ep->ob_window_map)
>  		return -ENOMEM;
>=20
> -	addr =3D devm_kcalloc(dev, ep->num_ob_windows, sizeof(phys_addr_t),
> -			    GFP_KERNEL);
> -	if (!addr)
> +	ep->cached_inbound_atus =3D devm_kzalloc(dev,
> +		sizeof(ep->cached_inbound_atus[0]) * ep->num_ib_windows,
> +		GFP_KERNEL);
> +	if (!ep->cached_inbound_atus)
> +		return -ENOMEM;
> +
> +	ep->cached_outbound_atus =3D devm_kzalloc(dev,
> +		sizeof(ep->cached_outbound_atus[0]) * ep->num_ob_windows,
> +		GFP_KERNEL);
> +	if (!ep->cached_outbound_atus)
>  		return -ENOMEM;
> -	ep->outbound_addr =3D addr;
>=20
>  	epc =3D devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 02fb532c5db9..c116b289aa51 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -192,8 +192,6 @@ struct dw_pcie_ep {
>  	phys_addr_t		phys_base;
>  	size_t			addr_size;
>  	size_t			page_size;
> -	u8			bar_to_atu[6];
> -	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
>  	u32			num_ib_windows;
> @@ -202,6 +200,25 @@ struct dw_pcie_ep {
>  	phys_addr_t		msi_mem_phys;
>  	u8			msi_cap;	/* MSI capability offset */
>  	u8			msix_cap;	/* MSI-X capability offset */
> +	bool			hw_regs_available;
> +	struct pci_epf_header	cached_hdr;
> +	struct {
> +		size_t			size;
> +		int			flags;
> +		u8			atu_index;
> +	}			cached_bars[6];
> +	struct {
> +		enum pci_barno		bar;
> +		dma_addr_t		cpu_addr;
> +		enum dw_pcie_as_type	as_type;
> +	}			*cached_inbound_atus;
> +	struct {
> +		phys_addr_t		addr;
> +		u64			pci_addr;
> +		size_t			size;
> +	}			*cached_outbound_atus;
> +	u32			cached_msi_flags;
> +	u32			cached_msix_flags;
>  };
>=20
>  struct dw_pcie_ops {
> @@ -363,6 +380,7 @@ static inline int dw_pcie_allocate_domains(struct
> pcie_port *pp)  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);  int
> dw_pcie_ep_init(struct dw_pcie_ep *ep);  void dw_pcie_ep_exit(struct
> dw_pcie_ep *ep);
> +void dw_pcie_ep_set_regs_available(struct dw_pcie *pci);
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);  i=
nt
> dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
> @@ -383,6 +401,10 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_=
ep
> *ep)  {  }
>=20
> +static inline void dw_pcie_ep_set_regs_available(struct dw_pcie *pci) =
{
> +}
> +
>  static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u=
8
> func_no)  {
>  	return 0;
> --
> 2.19.1

What is the guidance on setting "hw_regs_available" param?
I mean, in case of hardware platforms where registers are always availabl=
e to write (Ex:- pci-epf-test.c), how do they
either (a) set the param hw_regs_available to '1' or (b) call dw_pcie_set=
_regs_available() to commit all cached values to registers?
I see a need for APIs to establish the link among dw_pcie_ep -> pci_epc -=
> pci_epf_driver.
-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
