Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01344C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13BA20663
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 13:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="tSTPbYYZ";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="dqIvtGNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfBYNVB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:21:01 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57074 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfBYNVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 08:21:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PDGE4D001752;
        Mon, 25 Feb 2019 05:20:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ntbrTN76HA0OxDwqZOyyenYpGQJ+ugpTltZhCt2BBc4=;
 b=tSTPbYYZTxXdvTEYmmklapUvL4/TjiyGUXROvGI92pjKPZFqNVjxMVrqk3MdA64a/QMD
 gHGLTTtH72bzSWtpCcW9rXSbuXy4bwjDd2sAA6EPXDUFs6Jj+hvpJfGYrNG04LUvfYqy
 nhN8JLFISiHvy+PEmjdmkyrcVCxriN0ca1eDuMH7uYFVt35t93g+J30ufrZ9lI5hRSPw
 rcAjIQSvw++LLCwiO8uNKwezx4GjYt+85j+s/HW4N/jZ6IxYARjmeS0wxYMSNw2wp6hn
 /RuMzTHNfareparZ4g2+V0p28OYiDMMerd5TmaPWrQJ1m1m07Z1v5NDkfcPalxda755u IA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qupvxjwyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 05:20:30 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 25 Feb
 2019 05:20:28 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 25 Feb 2019 05:20:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntbrTN76HA0OxDwqZOyyenYpGQJ+ugpTltZhCt2BBc4=;
 b=dqIvtGNWkBPzItkRpdhr4vDD+mSBNSc3crV6ZSSaIzOT9xiNWvgnj3mz61sVQXz+axBCx7jnUUrh4jDZKsp697u7e6qRzkgu6ElH/UYy559FrmnC8kq3uSowxcVzgb9gvEYq2i1dtJFWBaHgGu1uk3srMcPP+38qrpVZ6aFprPM=
Received: from MN2PR18MB3053.namprd18.prod.outlook.com (20.179.20.216) by
 MN2PR18MB2512.namprd18.prod.outlook.com (20.179.82.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:20:23 +0000
Received: from MN2PR18MB3053.namprd18.prod.outlook.com
 ([fe80::ac1d:28ca:ae0:add7]) by MN2PR18MB3053.namprd18.prod.outlook.com
 ([fe80::ac1d:28ca:ae0:add7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:20:23 +0000
From:   Tomasz Nowicki <tnowicki@marvell.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Thread-Topic: [PATCH v7 0/7] Add virtio-iommu driver
Thread-Index: AQHUrM1f6Q/u+3uq4Eea6RTHkqJ6sQ==
Date:   Mon, 25 Feb 2019 13:20:22 +0000
Message-ID: <MN2PR18MB3053C27D1DD855315DCBF4CBD27A0@MN2PR18MB3053.namprd18.prod.outlook.com>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.172.191.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8038f495-725c-4c34-9b3c-08d69b23ff78
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR18MB2512;
x-ms-traffictypediagnostic: MN2PR18MB2512:
x-ms-exchange-purlcount: 4
x-microsoft-exchange-diagnostics: 1;MN2PR18MB2512;20:CkKIz83uyQAfSv1+PGmoCkd31Ni+OrQaXQ6lJFIXyX0A3f+qES2zTL88QX+qAK0zV9AH60XWBAxWLTt5PFAYYtccU98x2J4ydwCr1n8SeKr7+XccDzrsg6B6lhZRocR+sLFuhQF3MCagDy2bhFT8QJ+OwVX296U3ZaDF7PZZNqQ=
x-microsoft-antispam-prvs: <MN2PR18MB25122016A65BE93D432CA6EAD27A0@MN2PR18MB2512.namprd18.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(8676002)(2201001)(81166006)(81156014)(8936002)(7416002)(6436002)(55016002)(53376002)(305945005)(71190400001)(71200400001)(74316002)(7736002)(229853002)(86362001)(25786009)(33656002)(256004)(14444005)(99286004)(106356001)(53546011)(6506007)(102836004)(105586002)(7696005)(76176011)(6306002)(9686003)(53936002)(4326008)(2906002)(6246003)(97736004)(26005)(186003)(486006)(446003)(476003)(68736007)(2501003)(5660300002)(52536013)(110136005)(54906003)(316002)(478600001)(966005)(14454004)(66066001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2512;H:MN2PR18MB3053.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DQkhREJHmzNxLaWU5N0XlNHILeI1905S0j6XsL2zi4rfb2iZP5aNCi6/F7MUvQb+M5+zF1ecSfyma1ZbuFNGZOci/mH4pmAkRX1vtYf85Di+nC4Jj9m6K58bfD6UBbvdDRf+dfjGySATAQbwuksQAgix5UMskLAlV4o5k02qAKC6u0uREkjuERlcMg7L8bMHGDxpk+1GEyXvQ6cnBZeAfmNPwQJPpm+bZ4igAd9xKngj+zOwO92CJcEmXXwcezA/qRMS2mFg/501NS6pPt6ohkBVXEC4xEYWWwXiT7L0Ii5q1y0a/Be7PwqCjVckdP6S/l/bwtCth4jalTSgcl/SOv/+6UwhEvYsv72Blkkg8n9gzBgzzg74Ba7zgr3fu86D/g890i0c60NApJf5OEqjmjP5bOlBntvT9/mIoVk1ML0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8038f495-725c-4c34-9b3c-08d69b23ff78
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:20:22.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2512
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250098
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,=0A=
=0A=
On 15.01.2019 13:19, Jean-Philippe Brucker wrote:=0A=
> Implement the virtio-iommu driver, following specification v0.9 [1].=0A=
> =0A=
> This is a simple rebase onto Linux v5.0-rc2. We now use the=0A=
> dev_iommu_fwspec_get() helper introduced in v5.0 instead of accessing=0A=
> dev->iommu_fwspec, but there aren't any functional change from v6 [2].=0A=
> =0A=
> Our current goal for virtio-iommu is to get a paravirtual IOMMU working=
=0A=
> on Arm, and enable device assignment to guest userspace. In this=0A=
> use-case the mappings are static, and don't require optimal performance,=
=0A=
> so this series tries to keep things simple. However there is plenty more=
=0A=
> to do for features and optimizations, and having this base in v5.1 would=
=0A=
> be good. Given that most of the changes are to drivers/iommu, I believe=
=0A=
> the driver and future changes should go via the IOMMU tree.=0A=
> =0A=
> You can find Linux driver and kvmtool device on v0.9.2 branches [3],=0A=
> module and x86 support on virtio-iommu/devel. Also tested with Eric's=0A=
> QEMU device [4]. Please note that the series depends on Robin's=0A=
> probe-deferral fix [5], which will hopefully land in v5.0.=0A=
> =0A=
> [1] Virtio-iommu specification v0.9, sources and pdf=0A=
>      git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9=0A=
>      http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf=0A=
> =0A=
> [2] [PATCH v6 0/7] Add virtio-iommu driver=0A=
>      https://lists.linuxfoundation.org/pipermail/iommu/2018-December/0321=
27.html=0A=
> =0A=
> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.2=0A=
>      git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9.2=0A=
> =0A=
> [4] [RFC v9 00/17] VIRTIO-IOMMU device=0A=
>      https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html=0A=
> =0A=
> [5] [PATCH] iommu/of: Fix probe-deferral=0A=
>      https://www.spinics.net/lists/arm-kernel/msg698371.html=0A=
> =0A=
> Jean-Philippe Brucker (7):=0A=
>    dt-bindings: virtio-mmio: Add IOMMU description=0A=
>    dt-bindings: virtio: Add virtio-pci-iommu node=0A=
>    of: Allow the iommu-map property to omit untranslated devices=0A=
>    PCI: OF: Initialize dev->fwnode appropriately=0A=
>    iommu: Add virtio-iommu driver=0A=
>    iommu/virtio: Add probe request=0A=
>    iommu/virtio: Add event queue=0A=
> =0A=
>   .../devicetree/bindings/virtio/iommu.txt      |   66 +=0A=
>   .../devicetree/bindings/virtio/mmio.txt       |   30 +=0A=
>   MAINTAINERS                                   |    7 +=0A=
>   drivers/iommu/Kconfig                         |   11 +=0A=
>   drivers/iommu/Makefile                        |    1 +=0A=
>   drivers/iommu/virtio-iommu.c                  | 1158 +++++++++++++++++=
=0A=
>   drivers/of/base.c                             |   10 +-=0A=
>   drivers/pci/of.c                              |    7 +=0A=
>   include/uapi/linux/virtio_ids.h               |    1 +=0A=
>   include/uapi/linux/virtio_iommu.h             |  161 +++=0A=
>   10 files changed, 1449 insertions(+), 3 deletions(-)=0A=
>   create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt=
=0A=
>   create mode 100644 drivers/iommu/virtio-iommu.c=0A=
>   create mode 100644 include/uapi/linux/virtio_iommu.h=0A=
> =0A=
=0A=
I have tested the whole series and Eric's QEMU patchset [4] for =0A=
virtio-net-pci and virtio-blk-pci devices and faced no issues on =0A=
ThunderX2. The multiqueue mode for both devices is working fine too so:=0A=
=0A=
Tested-by: Tomasz Nowicki <tnowicki@marvell.com>=0A=
=0A=
Thanks,=0A=
Tomasz=0A=
