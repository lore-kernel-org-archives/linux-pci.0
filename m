Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242DC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F89221557
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HN80dvgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F89221557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeI0EWL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:22:11 -0400
Received: from mail-eopbgr720100.outbound.protection.outlook.com ([40.107.72.100]:50212
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbeI0EWL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 00:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhyPGO30YqYHaNyRgvGRuXKiZ18j4M2ianKueeReyao=;
 b=HN80dvgxIr0iN1xOojb2h9cGA4EdozhCzTZX4ktlTJMV+X/tcozx3jTLV5p9g7k5JQ+QbxxVK4XFLydFS8zTajD9BlLlV2Lm1rTPRLSgbyuAPa7XGHaDJnwR3Zp14TKUnBOWYPyqdjb/z+ka8tAnMVukWRFvgCI7zLOBpjeip14=
Received: from DM6PR08MB4939.namprd08.prod.outlook.com (20.176.115.212) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Wed, 26 Sep 2018 22:07:05 +0000
Received: from DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d]) by DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d%3]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 22:07:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jim Quinlan <jim2101024@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
Thread-Topic: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
Thread-Index: AQHUUCWw9wfviYBprU2EeYWwVNgcE6UDKjaA
Date:   Wed, 26 Sep 2018 22:07:04 +0000
Message-ID: <20180926220703.4ocppooccuot55i5@pburton-laptop>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-7-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1537367527-20773-7-git-send-email-jim2101024@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CS1PR8401CA0029.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::15) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB4377;6:0+w8yE+HBN+oZqQ23ZyvpURCidkZYvC3o/LnsNcfr9OMRNltGidYmmenSnAGCN1cUhKYBrlmKQw6oboOKoJjHKH24Jqgl6DUhWF9cl1du6GnYCHExzKx/yL8YCAZJIrn7J+45qFyNz+m9ufvfqAscGBwSACK9QdMYJ15qQoP9/jth+FCRin+e1AFqJM4KX0/XwGxmTBOr+XjZqPmAqtmiVYkE/0yuZu4tBYEciXrbHCJJgcsbziu7CgYsGtiL35MdWi6pHjACeEGhvtcnbZcfuZqqc+JmAaBsAk+q7EqiYBmPM126p7geWHQa8oqwkbnbyNfRHE1veR/kt+2L9F1YJh27pKrKvDZZiLx6RmlEwD6afTnIwt2/2KfSdhwq7DcZoi9USh5It5n66Afz0AP57QDTObutRwef4y4Xy6Am7t7hTAUX13QsYyfpKU0MF2n6TeEJ4uSVHsCuP76DawMeg==;5:eJKZJV+GYn7aCLiVcY4szHQWIFAfm/8YehlVGRhN9jTmk6MEk84HSH8sXsLmihsQDNTkXw0d/uU0qxStHn8TzkOBtkOwSd8/vPPA9vUaDTUTb/2tm0CrSx5T2PEAQlRSWluoOCKzD2itE1vKqwlZMmWPJ7IYQY6P2HK3DYZiG4w=;7:Bt5X1DwhpbesANdeok5gYnGdbV+WIP7s2q2H+3lqUs3t2tgRcUDkUL4j5mn5flvA/6UUh9NbcsNCCz51u2GzQqoJHAnqMpjPRYQuVQrI2AGDpiKAzXFON0DpJJY+gKEmJZWo7+0pAFFRYi6q6qgWu0UTilzFk4e6YDuY1M1UFS/547rZSjgQBMBZAWC6O18QKD+6FSS7QpWS5spdwqraIth5va4AJysRc519Os/m01b8r3uOy96WnvvL+/6AciX4
x-ms-office365-filtering-correlation-id: 985e68ef-1483-47f1-0279-08d623fc64a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-antispam-prvs: <DM6PR08MB43774BCB673736C82C0E6C1FC1150@DM6PR08MB4377.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(10201501046)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051);SRVR:DM6PR08MB4377;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4377;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(136003)(366004)(39840400004)(396003)(199004)(189003)(4326008)(6512007)(9686003)(446003)(53936002)(39060400002)(476003)(11346002)(6436002)(229853002)(1076002)(6116002)(1411001)(3846002)(2906002)(6506007)(486006)(386003)(54906003)(52116002)(71190400001)(76176011)(34290500001)(58126008)(6246003)(508600001)(6486002)(33896004)(99286004)(66066001)(14454004)(256004)(44832011)(71200400001)(102836004)(7416002)(8676002)(81166006)(81156014)(97736004)(8936002)(316002)(42882007)(26005)(106356001)(5250100002)(33716001)(25786009)(5660300001)(6916009)(7736002)(105586002)(2900100001)(186003)(305945005)(68736007)(40753002)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4939.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sZRtmkYe2GUuu8Agdyy6JFR3jAeIeZzY/ORDP8t4qCzzETb5wfvcM1RDiBsYEHet2lVNISdLEsG7dEED22VtGjdpUqHkQr1hYJimBlwSXl5zWKDWM9JTj2x7nZCi3EhloLuA6Tiz4VHkkWgHKi6Xnn8Nwxouh1/AJfbsUjxvgN4arIGuVmFUsJQfgWRkFibolWHVD8niDcaCDt5MNYOeawXa9Zil6rq5lXAdGaRN8fiwNhZvXBP6Cv4r7t0AJ9TtCdPf7pT7epTXi6EKV9RNlrgRluJinc/1rqq3C7Lhel0lqlEQI1d0+NvpxiyNg1yMBb15iY2VyJpJGlGVAFlMNF3ASzO2UcHNEdqnGSny0Qc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B19213CF76E74F4882C8D4312B6B4C6C@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985e68ef-1483-47f1-0279-08d623fc64a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 22:07:05.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

On Wed, Sep 19, 2018 at 10:32:01AM -0400, Jim Quinlan wrote:
> The design of the Broadcom PCIe RC controller requires us to remap its
> DMA addresses for inbound traffic.  We do this by modifying the
> definitions of __phys_to_dma() and __dma_to_phys().
>=20
> In arch/mips/bmips/dma.c, these functions are already in use to remap
> DMA addresses for the 338x SOC chips.  We leave this code alone -- and
> give its mapping priority -- but if it is not in use, the PCIe DMA
> mapping is in effect.
>=20
> One might think that the two DMA remapping systems of dma.c could be
> combined, but they cannot: one governs only DMA addresses for the PCIe
> controller of BrcmSTB ARM/ARM64/MIPs chips, while the other governs
> the PCIe controller *and* other peripherals for only MIPs 338x
> chips.
>=20
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/mips/bmips/dma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Please copy me/linux-mips on the whole series next time - I seem to have
only received patches 6, 8 & 9 which means I have no idea whether they
have dependencies & if so whether those dependencies have been accepted
or rejected. I also have no clue whether these patches make sense to
take through the MIPS tree or if it would make more sense for someone
else to take them with acks.

> diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
> index 3d13c77..292994f 100644
> --- a/arch/mips/bmips/dma.c
> +++ b/arch/mips/bmips/dma.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <asm/bmips.h>
> +#include <soc/brcmstb/common.h>
> =20
>  /*
>   * BCM338x has configurable address translation windows which allow the
> @@ -44,6 +45,10 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr=
_t pa)
>  {
>  	struct bmips_dma_range *r;
> =20
> +#ifdef CONFIG_PCIE_BRCMSTB
> +	if (!bmips_dma_ranges)
> +		return brcm_phys_to_dma(dev, pa);
> +#endif
>  	for (r =3D bmips_dma_ranges; r && r->size; r++) {
>  		if (pa >=3D r->child_addr &&
>  		    pa < (r->child_addr + r->size))

I can't tell because I presume brcm_phys_to_dma() is added in one of
those patches I wasn't copied on, but perhaps you could avoid the #ifdef
by just returning brcm_phys_to_dma(dev, pa) after the loop?

> @@ -56,6 +61,10 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr=
_t dma_addr)
>  {
>  	struct bmips_dma_range *r;
> =20
> +#ifdef CONFIG_PCIE_BRCMSTB
> +	if (!bmips_dma_ranges)
> +		return (unsigned long)brcm_dma_to_phys(dev, dma_addr);
> +#endif
>  	for (r =3D bmips_dma_ranges; r && r->size; r++) {
>  		if (dma_addr >=3D r->parent_addr &&
>  		    dma_addr < (r->parent_addr + r->size))

And similar here.

Thanks,
    Paul
