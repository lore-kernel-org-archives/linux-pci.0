Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 06:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA432186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 06:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="tytv2ReG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfDLGnJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:43:09 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:6077
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfDLGnJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 02:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7h5OWJ4duiQOjh8a93rsttKVXj1YfNALGUKcdnTxmc=;
 b=tytv2ReGeWTr7rwNWvSlR8wnoznDTOU6qetCAiL5P64KXKYv2cpMBB1vTH7hd0umzJeMTXVz3dhmQMp2oVSuUH+9sEXxUc208k9hB4vBy1fdB0Ngmw81ZC5MIHeWwu6LSs363XWu2Zj7dW0Cjxstu8AegJu9Xmn0J814GLUxktA=
Received: from DM6PR03MB4778.namprd03.prod.outlook.com (20.179.105.26) by
 DM6SPR01MB0045.namprd03.prod.outlook.com (20.176.120.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Fri, 12 Apr 2019 06:43:06 +0000
Received: from DM6PR03MB4778.namprd03.prod.outlook.com
 ([fe80::1d45:49e6:4baa:d7b0]) by DM6PR03MB4778.namprd03.prod.outlook.com
 ([fe80::1d45:49e6:4baa:d7b0%3]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 06:43:06 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Make pci_aer_init() when !CONFIG_PCIEAER void too
Thread-Topic: [PATCH] PCI: Make pci_aer_init() when !CONFIG_PCIEAER void too
Thread-Index: AQHU8Pr82Du5MALJTk6mD6X4N4ajEg==
Date:   Fri, 12 Apr 2019 06:43:06 +0000
Message-ID: <20190412143458.2120118b@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:404::17)
 To DM6PR03MB4778.namprd03.prod.outlook.com (2603:10b6:5:184::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ef761a1-2318-4f1c-b02f-08d6bf121e62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6SPR01MB0045;
x-ms-traffictypediagnostic: DM6SPR01MB0045:
x-microsoft-antispam-prvs: <DM6SPR01MB0045E0CA2F7C7404FE474AFBED280@DM6SPR01MB0045.namprd03.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(396003)(346002)(189003)(199004)(7736002)(6436002)(72206003)(1076003)(478600001)(9686003)(66066001)(97736004)(6512007)(52116002)(305945005)(8676002)(99286004)(68736007)(110136005)(316002)(54906003)(2906002)(86362001)(26005)(3846002)(8936002)(6116002)(6506007)(14444005)(256004)(186003)(386003)(6486002)(476003)(102836004)(81156014)(4744005)(5660300002)(81166006)(25786009)(486006)(50226002)(71200400001)(106356001)(14454004)(105586002)(4326008)(71190400001)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB0045;H:DM6PR03MB4778.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PQzi43Dzs6B3Uw2kEjm/JQ/qMlF1Yk1e3hzyksVsIV4ys3xXI+9BfpKPl0i0Ss+AEPq4EKhQ+KLbf49xOljXdVdh2GjedEREjU3GisiMmJ5CfD/fmlIRquAf6cignNaYlowt+ZYZbvvskvl8Owp+BV0CwMbudr1splvY/dGbQSnMI1OwccpqEi7THPSePzS5KtrEGD2YFRE750kaWAeeoQ0KZFXfTwrDyJJCmR/nowctHSEvcjS9BCz47JuIh5ATBbPw/jnli4DQyVSOP6qGXV0GGSebcuGOes69PsrFbSzYzH7FGC23LI/l3WZ5uQIyZh8nMwwA22mJVP526nueVkRixE03+kvOwrzzahT+CdfNMuCHyY5/E7KalPvIjb5ELNS/2dVJLaaTXXtrFTIuv+NAT5z4815K6jCObBhs4tU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF65E8110B0C7E4296F1A29653BB139B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef761a1-2318-4f1c-b02f-08d6bf121e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 06:43:06.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0045
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 60ed982a4e78 ("PCI/AER: Move internal declarations to
drivers/pci/pci.h") makes pci_aer_init() void, but the version when
!CONFIG_PCIEAER isn't modified accordingly, fix it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d994839a3e24..9cb99380c61e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -597,7 +597,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev);
 void pci_aer_clear_device_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
-static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
--=20
2.20.1

