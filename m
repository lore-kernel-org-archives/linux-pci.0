Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A689C00319
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30D20836
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 20:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mLtOVILN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBUUun (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:50:43 -0500
Received: from mail-eopbgr810109.outbound.protection.outlook.com ([40.107.81.109]:7479
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfBUUun (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Feb 2019 15:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBlSUn5Cy6NyDaA15yKluhsGEKX9LuMgFz8MtU/pdIg=;
 b=mLtOVILNdK3C4dbTs+jz/imSoUWvsPtyvSkPFObDDM0mTNHxtUrF3KEyqDtt1367rPbScOgS6PMjbTubZfDh3HHJz6iai+HQanZZt/XKxdwtKCZ2/kEw5KRGWjPAvH3lIhiIj1LXKXvArXjokcabkup9byKBWxDwW58koXHU9pA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1358.namprd22.prod.outlook.com (10.174.162.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 20:50:39 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 20:50:39 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] MIPS: SGI-IP27 rework
Thread-Topic: [PATCH v2 00/10] MIPS: SGI-IP27 rework
Thread-Index: AQHUyicabaobcsLrVkGM419PhbaunQ==
Date:   Thu, 21 Feb 2019 20:50:39 +0000
Message-ID: <20190221205038.hcov3n574a3zqip7@pburton-laptop>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47179be5-b4c3-40bb-5689-08d6983e3ca3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1358;
x-ms-traffictypediagnostic: MWHPR2201MB1358:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1358;23:NzFDP9h1wdKVfdI/MwVFHmT3c4vAa6lkQCbKAtq?=
 =?us-ascii?Q?BPay7ho+LpZ8wQrjxevYU2q4TiXk5io/a5b1nPmVmLy4zds9/8OcCplk4MgA?=
 =?us-ascii?Q?XfnoPOfSe7NFnjQdXBohJYAPxWKCz8+1txqfCQqlsI2sCNSDzvTfdITAc2hB?=
 =?us-ascii?Q?hezmYYOAHAprZpJTTWomBjfUFf+iTLW71PPI6wM1KSlpzpR7L0E7ZbZZ/pho?=
 =?us-ascii?Q?gHm4yKe7s7aUbudQ/zx77c95/d1zmk7Ks/BWk8DN3XnAKCgf2Yge5JgIpaM6?=
 =?us-ascii?Q?D3N2eGqCSu0qKqKd4+Zt7gfAaj4xRxHbfR5JE2A/XJjinzjVFhGmD9+KCAOr?=
 =?us-ascii?Q?yMA+F0da6yKIm9frZec28aByzzp5ef33sB28pUPC0QOzWfSNig2b1rVkA0kb?=
 =?us-ascii?Q?yR0Tw7Vjwnpi0buxS9Ya7r7y3mKQT3aP45PtJmYBvnqZfvSvfFvZIJ13UJvp?=
 =?us-ascii?Q?3xcM+DlWptUG+GcF/yrT7wAGdjDW858yngMrsFTr7/V0VZp8D1yGydb3sgzX?=
 =?us-ascii?Q?iMD6zSKB3gY/MWlc7VY3iz/ScpY8RgL1ElvQD1EEBWPLli6wezrWVBbZYDE+?=
 =?us-ascii?Q?fhGnMzqIPEnFHeumIhl47Gv+mhoQ9QYOS+TJVsnBWeS1CK3l8XzfNWFh29Pz?=
 =?us-ascii?Q?s7xebwkm3jVJSTbd0ZjB9EQpzRArKfBD4MPyiZZk4aKG/KvUqRZs9XYsgKyK?=
 =?us-ascii?Q?t4mzXcCDjbOo3HwO1ZeVU+zk12JXJgLtXroUKXqpozHEU12F5WEza6+Xou07?=
 =?us-ascii?Q?ALgXrRUtfP4EM1/uPe1M6Zs8jxkaQCHf1hfFGpfNG82+XE22jzNrR7wPm1dL?=
 =?us-ascii?Q?LyxBw5PG0RZQIvsepRPsWs5xOYv5N19PkVd804CX5rs+x9wHpJ+6lsxxtMNA?=
 =?us-ascii?Q?XjXa56sftkpihdjGu4FvUUk6dnwaZ+imTaNTXHs3lv8m6z5zmjm4SIZApH27?=
 =?us-ascii?Q?J+D+CPoIAUL3XErIdwOrYYyft5S5bDuEKLXVXTYY/Wn4wM7/+i5dpaUv55qt?=
 =?us-ascii?Q?evuEknCDXWM32Dw2g7EusSedZWQtZpoLW8L+zI3b1AlOIUHzIRl2unRFbC4x?=
 =?us-ascii?Q?V5VuFQmgmu1NPLoFNq+gRHknzcH+p7Qp8p/481rKd/0usCbwtGWbwwy8p9Gi?=
 =?us-ascii?Q?of8pMPed+ijgC9KQSaPm9GwQ67cnrfxj3xgiqOjxL6Zpm9usqQNopsenyQc9?=
 =?us-ascii?Q?8FAt66YnClXfkkL/YQh2aExLVhcF7WcZYvWu5Ux9p4zzHtBqnfWn/xTgD8JG?=
 =?us-ascii?Q?Wg3fxJQusLtRt+Ny3N4SJbaVuhIDFLSmsVnWvlA0Rk6FpJ5guldHAgIGEqXo?=
 =?us-ascii?Q?19qHaxITYmOwOsi89ehbuH5gRh3sBIR8N5NamfdIcyxbu?=
x-microsoft-antispam-prvs: <MWHPR2201MB13582F51F031E17CF300EB13C17E0@MWHPR2201MB1358.namprd22.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39850400004)(346002)(376002)(136003)(199004)(189003)(33896004)(76176011)(305945005)(316002)(71190400001)(102836004)(7736002)(6506007)(386003)(446003)(97736004)(6486002)(11346002)(5660300002)(476003)(54906003)(52116002)(58126008)(7416002)(71200400001)(44832011)(105586002)(106356001)(6436002)(6512007)(53936002)(9686003)(81156014)(186003)(81166006)(8676002)(229853002)(14444005)(26005)(256004)(33716001)(4326008)(8936002)(6246003)(66066001)(478600001)(1076003)(42882007)(3846002)(14454004)(6116002)(99286004)(68736007)(486006)(25786009)(6916009)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1358;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hBWJgI4yKYw2CDNyKPLUYxUN4QaQjVkC2Y11TeWcfF6zt6ZCQ8Dj50Rp0kUUPEDCzkL/dwz++RI1ctPNzqyfWqC/45y0NjEW/873CAlSfeTdYYKa+ZlJKvIN+cvVwIopLDYo6eFMOcrjnHcP3a2vZRzuw+11qO3bNSp4KUelggu+I4hlnHU3mFtRLs4BQpapTFwj724av10CkgqJrneN7Uyiy6Kt8NeY80+IsU/jskIWAmbm1yCdMnfftn1GCTobEPnMCYT7djCDpFPnQvynwIB9i/RSO2cGE5a9UxSwd9X9/983xn7IkJ8A3644ljg7LxVKYyeyG+JAmtNlYDjn/8eCc/4vEVVmtsVKlb7Anbyrmav5mPNtPD4NcFrcC98vAG02oDc10cWCXjTa3AEoiHk5iua1RZF//taOuI9H9h0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21DF7EAEFB82A945B9A9D82A73D0DDFD@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47179be5-b4c3-40bb-5689-08d6983e3ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 20:50:39.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1358
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Tue, Feb 19, 2019 at 04:57:14PM +0100, Thomas Bogendoerfer wrote:
> SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
> architecture and share some hardware (ioc3/bridge). To share
> the software parts this patchset reworks SGI IP27 interrupt
> and pci bridge code. By using features Linux gained during the
> many years since SGI IP27 code was integrated this even results
> in code reduction and IMHO cleaner code.
>=20
> Tests have been done on a two module O200 (4 CPUs) and an
> Origin 2000 (8 CPUs).
>=20
> My next step in integrating SGI IP30 support is splitting ioc3eth
> into a MFD and subdevice drivers. Prototype is working, but needs
> still more clean ups.
>=20
> Changes in v2:
>=20
> - replaced HUB_L/HUB_S by __raw_readq/__raw_writeq
> - removed union bridge_ate
> - replaced remaing fields in slice_data by per_cpu data
> - use generic_handle_irq instead of do_IRQ
> - use hierarchy irq domain for stacking bridge and hub interrupt
> - moved __dma_to_phys/__phy_to_dma to mach-ip27/dma-direct.h
> - use dev_to_node() for pcibus_to_node() implementation
>=20
> Thomas Bogendoerfer (10):
>   MIPS: SGI-IP27: get rid of volatile and hubreg_t
>   MIPS: SGI-IP27: clean up bridge access and header files
>   MIPS: SGI-IP27: use pr_info/pr_emerg and pr_cont to fix output
>   MIPS: SGI-IP27: do xtalk scanning later
>   MIPS: SGI-IP27: do boot CPU init later
>   MIPS: SGI-IP27: rework HUB interrupts
>   PCI: call add_bus method also for root bus
>   MIPS: SGI-IP27: use generic PCI driver
>   genirq/irqdomain: fall back to default domain when creating hierarchy
>     domain
>   MIPS: SGI-IP27: abstract chipset irq from bridge

I have patches 1-6 applied locally - would you be happy for those to be
pushed to mips-next without 7-10? I know ip27_defconfig still builds but
have no idea whether it still works :)

I don't appear to have received patches 7 or 9 but I see from archives
there'll be a v3 of patch 9 at least.

So I can either apply 1-6 for v5.1 or defer the whole series. Let me
know - I'm happy either way.

Thanks,
    Paul
