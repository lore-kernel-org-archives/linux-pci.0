Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC12C64EB1
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7E1214C1
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7E1214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeLFPr3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:47:29 -0500
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:59070
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeLFPr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 10:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6PuRFIKOSXHM+3cR6dG1ekBu5cgchE5xZXtXyw98bU=;
 b=fHtCl5lPLz1pBO++O+t3wcM1UH5csN4TkW0g0Zwq58gQI4VGXLb22UPfvoeEYP2SgjOK0oVXwBJZIVtmy5EYCjkOaoUvg4z3E56RnY2GWamQ1DkdpBdjvdtKvrrgxY1FrNrdYVDd3XSbyKI+p1tLaZvPyc+tdmbCQlMssqn/rYo=
Received: from MWHPR02MB2783.namprd02.prod.outlook.com (10.175.49.149) by
 MWHPR02MB2735.namprd02.prod.outlook.com (10.175.49.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 15:47:26 +0000
Received: from MWHPR02MB2783.namprd02.prod.outlook.com
 ([fe80::3cdc:f4c:38f2:f62f]) by MWHPR02MB2783.namprd02.prod.outlook.com
 ([fe80::3cdc:f4c:38f2:f62f%3]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 15:47:13 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH] PCI: Enable SERR# forwarding for Type-1 PCI devices
Thread-Topic: [PATCH] PCI: Enable SERR# forwarding for Type-1 PCI devices
Thread-Index: AQHUfCn2igqy2G0j/kqJFDtUguzydaVx/C+A
Date:   Thu, 6 Dec 2018 15:47:13 +0000
Message-ID: <MWHPR02MB2783A4D7F18724F9A2FA2A8FA5A90@MWHPR02MB2783.namprd02.prod.outlook.com>
References: <1542206821-24503-1-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1542206821-24503-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2735;6:PQZvupuRAGgvGp9E6uzShZS/5j5txV8nm3izUDot5RY19xiDfuLj0BpYNmBLHjtuaKeOcSOPbcEnDTl0Q0hxGqFReS/e0Q0CjtvMfEkqPYl/b8um0xpWctfgvI+ejSFKKDMx3TgvsXNa2ECj5A4iWXXFRlNPRG7Afoa93BCwF0AYn5q/+R9V8vPjDlneY3g9+93L7RJvaKICG/TkIkrYxJc6Du6/uIaR1aCtJT6Ej8yRQa6le338zWBdJWF1yyz0B0BJ3cc9tZ60XbCBCpp1hFRh122CJ3bbLp7di9pHbBJDPbIscO8677iSvRU2DP3k4e3gkH5PcXGY1UIQefi/CfO/w8cUt4N2RGSDNGWn9cp3PYuIBXuC8pb1uJH04h4Wnfapa+5nj5j1dFReBCZvS4iZh+9psD63atNkPKAgYVghyAt/ScFMdIh9PuYwE/mWwPlJN41BcaqwQJ6C1BZpyQ==;5:CImbIwZ79YmyPFYkuT4Yyw4uDR2vgPL5bxgOk40n3rK/0ybk5X0UvdrjBMvSllxQRR3X9lTLsIA/g4c23dbXFRfY/UcSN6lXTN9Umy1CDqr8+DNgEVxSrndLM5UgBxFzHU0KxjS38ih8m4tRr9KhaPOGDHg/Fu0AO//g4cPmgXQ=;7:5JCkOdT8xzQzQJWgELs64jY//H3mVbcXAbau8VVV6ZW+LgaL+JN81Q6pylgAO3XTO+7TgQIE7V/gciwPWeqm9GdSxzTWaHUXRlrmd/42MLz050w8c33BNeAKoT7Ni80pF6jNUhefeLCocGBgxE+3gQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 2605ee63-a917-4db5-c2b3-08d65b92178d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2735;
x-ms-traffictypediagnostic: MWHPR02MB2735:
x-microsoft-antispam-prvs: <MWHPR02MB2735B76C805BE1DDE4B608D9A5A90@MWHPR02MB2735.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2735;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2735;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(53754006)(5660300001)(110136005)(99286004)(97736004)(186003)(305945005)(68736007)(7736002)(102836004)(6506007)(106356001)(2501003)(2906002)(105586002)(71200400001)(26005)(54906003)(33656002)(86362001)(6116002)(229853002)(9686003)(53936002)(3846002)(478600001)(71190400001)(66066001)(2201001)(8676002)(476003)(11346002)(8936002)(81166006)(81156014)(256004)(4326008)(446003)(55016002)(316002)(6436002)(6246003)(14454004)(107886003)(486006)(7696005)(76176011)(25786009)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2735;H:MWHPR02MB2783.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SuEo3kbQFZe7YljbJmmPJkIdMps3yutKrqv6XauaW5cLNUnc4oRIXne29abNn/R20RAjZ/qiKjFGxA3rMJXsmA8P8CdhB2o+TVqZpMWM94ObRJ4cyvVJubhkwRTFBSS/FYwmdccZgHzbauJcR2l4LxPWw9ECRDc3WCWu/GSI+rrIW8hQYlQn+Zo+90NbXkP6M9tNMMG59LuPH3XTmwUazP90xSzVTshiXeg9f69hV/jCspad6V1Nycak6D09oW/V+1Lrp2/EiOXhEbsPdzWarw5e8w7EhR6Ozw2kQEWUNA0oKPRpqS93pzEmSU2v96r9j0oaj1ZaF3CZuJdtnv6uG+2OiUTRrL8jX6dD/1CAJ60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2605ee63-a917-4db5-c2b3-08d65b92178d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 15:47:13.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2735
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Please let me know if anyone has any issue with this patch.

Regards,
Bharat
> As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages will be forwarde=
d
> from the secondary interface to the primary interface, if the SERR# Enabl=
e
> bit in the Bridge Control register is set.
> Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.
>=20
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/probe.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> b1c05b5..ed71e8e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1841,8 +1841,6 @@ static void program_hpp_type0(struct pci_dev
> *dev, struct hpp_type0 *hpp)
>  		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
>  				      hpp->latency_timer);
>  		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &pci_bctl);
> -		if (hpp->enable_serr)
> -			pci_bctl |=3D PCI_BRIDGE_CTL_SERR;
>  		if (hpp->enable_perr)
>  			pci_bctl |=3D PCI_BRIDGE_CTL_PARITY;
>  		pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> pci_bctl); @@ -2114,6 +2112,23 @@ static void
> pci_configure_eetlp_prefix(struct pci_dev *dev)  #endif  }
>=20
> +static void pci_configure_serr(struct pci_dev *dev) {
> +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/*
> +		 * A Type-1 PCI bridge will not forward ERR_ messages
> coming
> +		 * from an endpoint if SERR# forwarding is not enabled.
> +		 */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> +			control |=3D PCI_BRIDGE_CTL_SERR;
> +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> control);
> +		}
> +	}
> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)  {
>  	struct hotplug_params hpp;
> @@ -2124,6 +2139,7 @@ static void pci_configure_device(struct pci_dev
> *dev)
>  	pci_configure_relaxed_ordering(dev);
>  	pci_configure_ltr(dev);
>  	pci_configure_eetlp_prefix(dev);
> +	pci_configure_serr(dev);
>=20
>  	memset(&hpp, 0, sizeof(hpp));
>  	ret =3D pci_get_hp_params(dev, &hpp);
> --
> 2.7.4

