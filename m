Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC1C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CADF2133D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 17:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Fe6hT4Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDARAr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:00:47 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:11342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbfDARAr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 13:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoxuok1bHfBzQmYLT92of1wjxbyXtmyzEjuhRBCW2q4=;
 b=Fe6hT4Jczkisz3p8ToQwVn8nd8bHuCKrOGxy7bZukyHR6UHjqoUWCIYIq/yUtzPKaaO5pwIFIHJAI+eJaXgHQqZex4Q8PcBt8VBL1TtRfnV7ghG7rre4nrcwsP4dz+P4PgN3/yhpFMW3nphhcdqsDadRUakzNn6DyhMab2Ocuw4=
Received: from BN6PR02MB2772.namprd02.prod.outlook.com (10.175.96.7) by
 BN6PR02MB3332.namprd02.prod.outlook.com (10.161.152.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 17:00:40 +0000
Received: from BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::6cf5:d9:3347:151a]) by BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::6cf5:d9:3347:151a%11]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 17:00:40 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Topic: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Index: AQHU2AAQCHDXCwr68kiV0ZLjhatkq6YnqKVQ
Date:   Mon, 1 Apr 2019 17:00:40 +0000
Message-ID: <BN6PR02MB2772BFC74C01857BA58FB5C7A5550@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [60.243.144.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ab631f3-8f45-4457-fa78-08d6b6c3921f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB3332;
x-ms-traffictypediagnostic: BN6PR02MB3332:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB3332DC3D83376FAC7811762AA5550@BN6PR02MB3332.namprd02.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(53754006)(76176011)(33656002)(316002)(52536014)(14454004)(4326008)(2906002)(25786009)(7696005)(478600001)(2501003)(86362001)(2201001)(97736004)(110136005)(3846002)(54906003)(66066001)(68736007)(6116002)(8936002)(6346003)(229853002)(476003)(102836004)(186003)(105586002)(256004)(7736002)(14444005)(486006)(9686003)(71200400001)(106356001)(5660300002)(81156014)(74316002)(26005)(6436002)(8676002)(305945005)(71190400001)(81166006)(6506007)(446003)(11346002)(55016002)(99286004)(6246003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3332;H:BN6PR02MB2772.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jBzYPlsJpiKblk+3Zweq0pRqWdLpCeAG01+dNaFM4TqpPEjT183WsE9TAWKi1Quj2rto5eLYAv1zA4s8d7f6UD6jkDFG55Fp+ESjdvfQpK3DHrprP24YbXHpUU+KWrca5dAR6DjPMxxwRvOHKemPhR1bvYOhpoiFRZGw8S/9UX0vKaWUgrH2XnAJQIHKCDO8QwaZNdOOqKBsXKI6jKGP/T5PbapTKV0yP26ftwZhHIl5dqbuSBak7zbwfqXxtWr04dCylEpQzJ16aDJpS5PRSkRMbFcVoStO62oHS9PHjhz3/wWf/cJi/IZCiqHAQM/21Dn81rY/UV0uVXEDmkt9JKteH9o64a6r195Tpoe+vqxiOQ2ENZrWcn03LrPH8pj1U0R8N2Oj+sinOEGuSklp4i6tfxP6IuxBxducEEKp8iE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab631f3-8f45-4457-fa78-08d6b6c3921f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 17:00:40.2938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3332
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Please let me know if anyone has any inputs on this.

Regards,
Bharat
>=20
> The current Multi MSI data programming fails if multiple end points
> requesting MSI and multi MSI are connected with switch, i.e the current
> multi MSI data being given is not considering the number of vectors being
> requested in case of multi MSI.
> Due to this if multiple end points are connected and requesting MSI and
> multi MSI combination, the multi MSI data is ending up using wrong MSI
> data, which might be used by different device.
>=20
> Fix Multi MSI data programming with required alignment by using number
> of vectors being requested.
>=20
> Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Ho=
st
> Controller")
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
> V2:
>  - Added more description of fix
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 81538d7..36669c5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain
> *domain, unsigned int virq,
>=20
>  	mutex_lock(&msi->lock);
>  	bit =3D bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> -					 nr_irqs, 0);
> +					 nr_irqs, nr_irqs - 1);
>  	if (bit >=3D INT_PCI_MSI_NR) {
>  		mutex_unlock(&msi->lock);
>  		return -ENOSPC;
> --
> 2.7.4

