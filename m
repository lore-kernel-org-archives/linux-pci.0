Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A3FC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5E321848
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="gJPvUSRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfBZLzL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:55:11 -0500
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:49568
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBZLzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 06:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXmBByT2ITPhifTbB1IOhuN0o9fSyb376cradi+eH7E=;
 b=gJPvUSRJEo2uba1UCHI/tfLnmIhsA01mC5TFtq3u8/4vYiqe3eij3LHlqMdSsWnPmqCHQ48bvbOgXtlkiR4/XmQsBsZa9XIN5oOU8HnTF0xr5oDv7SxK8/Ow5Q++PHb3ID7juFAUGucIf8gxbHcSu3nGZiwh1JlJ7kIl6Tt/l5c=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4423.namprd03.prod.outlook.com (20.178.49.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 11:55:08 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:55:08 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/5] PCI: dwc: support remove
Thread-Topic: [PATCH 0/5] PCI: dwc: support remove
Thread-Index: AQHUzcoe5DuwpST1E0iG0xVzcD6O7Q==
Date:   Tue, 26 Feb 2019 11:55:07 +0000
Message-ID: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:404:14::14) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0b4f238-df29-46f5-1226-08d69be140a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4423;
x-ms-traffictypediagnostic: BYAPR03MB4423:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4423;23:WdZw6KGMA5HsDBxUgNwbrI2puLiaAhJclOSpUya/B?=
 =?us-ascii?Q?nI+VuFTDFTOnD3jP39NWXb4yyFoXXNS729ldTUUARPoUQp5zS9zWk2CMLydw?=
 =?us-ascii?Q?GJkScZwye/WrxUzjYk8hcZXIgk+79g/vLydJ7zCB7yDcLRl/PrPlOfROio0G?=
 =?us-ascii?Q?cB2+1pBwCh+y0aLkKTgP7prRBrPXrQnDGvzS8K9gsemXunT2LsJ/ojp0Xm71?=
 =?us-ascii?Q?zyH24iEdkBmk99oG01AMtA48UsFyZt/Fwg8IZDtnGP8bOwfgaih6yRi0/QM+?=
 =?us-ascii?Q?SoPdoaLmvaXr4/bbL6KpAY9DtHMC/Lef5hA0JjXOCq5BFaiNHMsUgD9h5iDj?=
 =?us-ascii?Q?pC43IwKmIk/5CTv6n9lLH8lqahevWqukusqsetVPDtgIT1sXOrfEVVpH3qKv?=
 =?us-ascii?Q?lCmkALCRnZOiCmsGTloz3KGXeqBXVAfCvP4MLoHVC3m0dx3CUUUmxdc8ca4+?=
 =?us-ascii?Q?Issqj0RoS8ywBsaU8IW+pyC1cMR25Btwdx3Y8Fek/GXgaoEU1l9eRZOwLdi+?=
 =?us-ascii?Q?VjaS1yWqkndUfTcg8OXXpKWWaLOSUWpvPfYp32sd/bXqydo4hvokcvA/u2af?=
 =?us-ascii?Q?7yXLxBB1wIQyZ6f8utSX4u0q7ycxjw48OqVckApuLA/IV20UtleS0gVfXQNk?=
 =?us-ascii?Q?VE0M+GBM+rsTR3dWHof9TNOClI5+Ymme8T6LlUC+GwmarqcDEDIJU0BJM/iQ?=
 =?us-ascii?Q?HEf/hV/xg1MdMyrqO+QvU0KBj/5b9yRoRPW+rxrfGS7UcE1fOL8QQv7VPGOR?=
 =?us-ascii?Q?hd2arYvnZyq1c06lwIaUxDqdrV0hZ59R8MxtfxmEMP/Jxtg0yfuBLRMhXLbU?=
 =?us-ascii?Q?C/YMhELE8wIoC0fofbdxdpFMZhOL27yL3BHmAqEQ+bW6/duViWgJSkeNWsSF?=
 =?us-ascii?Q?5VlEDLVDui1LuFat5a4bq1d4AZlZqbTFPuQ0a/t0qncnd30b+pSxpBuym8Z2?=
 =?us-ascii?Q?dRPamN8ln1rlW6K/oXONMJJl0YI3a5AQKYIV8VWnnhAxLsxSlFHuUSMqr8Yk?=
 =?us-ascii?Q?C62YJgPDMv8/W1oSpHiEDJvqByJhwA8SyJAWCBwwt+grUbiI7AaKGxoP1V6w?=
 =?us-ascii?Q?/JTiYVIfIqjr8BCJy/2QHBXsO/9dWFRKaA+mr2mHqaWuFfe/I6NkMjutH3dF?=
 =?us-ascii?Q?bR+5vH5Z6LMFaxUGBCIrn47RTWDkggnMYxvAV5bG6aJB9V2qqihi7QSHLGIH?=
 =?us-ascii?Q?UlCyTGodEYHVsM=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4423736F77DB32488ABB78A6ED7B0@BYAPR03MB4423.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(81166006)(106356001)(50226002)(6506007)(81156014)(6116002)(386003)(102836004)(305945005)(26005)(7736002)(97736004)(99286004)(3846002)(8676002)(52116002)(68736007)(478600001)(2906002)(8936002)(72206003)(105586002)(110136005)(25786009)(316002)(66066001)(9686003)(6436002)(86362001)(486006)(2201001)(6512007)(2501003)(5660300002)(476003)(53936002)(256004)(6486002)(14454004)(186003)(4744005)(1076003)(71200400001)(71190400001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4423;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: go3cg+ieuhGDAV4FsXJf9ot4SfZsdKYTVIRwI7qD1bm+2XJmEiSZ+HiaDoXg3/lhtxAYhwiEN1Ccrt4qrUu1BFLPglg4ldgkVHDNZEfvLaFIQoZ8ok4czjrcZmv5139r0CZQ4sAsoXrBclAf3NPw4SOOCYZlRUb435/uzlhKjQarg0k7Kl6IunAqmWz41DTpJRRubm7j95tFckt2Wzr7CmEy44UujvbimtA30Q1lxSSl90wgHXFLrO4MW6TrOqOP6ibUtSy9D/kCHGZHXgCnECe/p9QSyMooCf0RjPun8I2EynvTxPvuizC3dvr+6yeLMJ1lDXEJhai5KmCEDnOJTnpV2YG/dGYMt5Vef/EbXhuWAKndXv1ScyTQAh6mzKqG+TXv04zhj60vGw5Lic8bbHKTYam8JlWypsV8/I9oaJg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <616B80D5C3B5B245BFDD8FF17C06AA74@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b4f238-df29-46f5-1226-08d69be140a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:55:05.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4423
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the PCI dwc host users don't support the remove, but nothing
prevent us from supporting it. To achieve this goal, we need to ensure
we can do necessary clean up work.

Jisheng Zhang (5):
  PCI: dwc: fix dw_pcie_free_msi() if msi_irq is invalid
  PCI: dwc: free the page for MSI irq in dw_pcie_free_msi()
  PCI: dwc: free msi in the error code path of dw_pcie_host_init()
  PCI: dwc: use devm_pci_alloc_host_bridge() to simplify the code
  PCI: dwc: save root bus for driver remove

 .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 2 files changed, 23 insertions(+), 17 deletions(-)

--=20
2.20.1

