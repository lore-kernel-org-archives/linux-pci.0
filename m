Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83742C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C5920842
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="qiC1GjHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCAFD3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:03:29 -0500
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:55520
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCAFD3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 00:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLJ+7n76v5no2fVLihRLttvC7XT4DSHydHDSGRjxfdM=;
 b=qiC1GjHeHCc7BkDhNJ82jRSm+ZX40u7oUZCHFQetuE+StmiVUzPLoQMKBvTJr1rlCkKYwkmLa7DT07PFnFmHIrYcrHF4AIs6M549lEs3PgUlR6KadqpOUGoWc850ZAWn5J+ROb/Cgt6Iee5grnYy0wYKbCGQxalMnDKyVkXiYWY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4533.namprd03.prod.outlook.com (20.178.50.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 05:03:27 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:03:27 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
Thread-Topic: [PATCH v2 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is
 invalid
Thread-Index: AQHUz+waTBymEGCS70GGZnCc5RmlDA==
Date:   Fri, 1 Mar 2019 05:03:27 +0000
Message-ID: <20190301125625.4e15d869@xhacker.debian>
References: <20190301125510.4e2ee985@xhacker.debian>
In-Reply-To: <20190301125510.4e2ee985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYCPR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:4::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90f96ce6-6fe8-4816-63e7-08d69e033d38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4533;
x-ms-traffictypediagnostic: BYAPR03MB4533:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4533;23:QRcYwvRolWDqyMXs9SeAyoM+KrwpNpnca0EOVzkVC?=
 =?us-ascii?Q?oWvRpciCQbSxrxWxrpLX2bnkVmN8utqEIEang7q0LVIAtyrCOg84sof9Ilal?=
 =?us-ascii?Q?1ICz0LUSeIBeBM1FSzemF7LGhtxQSy2giBXA5X8RA62is7DOJhZGIp4vSVb2?=
 =?us-ascii?Q?smY/aDfB+bsVIoPHdd214KPAf3ah3gloM1dtRFH71TnsIXk+4QMO1lvWJwKH?=
 =?us-ascii?Q?OYz6H+cM4NByvtiLf+4JeSx6tFGA4KgWC0extc8qUVuimZL1qLaTzojnZaKv?=
 =?us-ascii?Q?heQqkPch6wBSGdFQ5+B6fqxi4jHTohQ535c3MD3qnph4QjYwdLUfkmpYnISV?=
 =?us-ascii?Q?oh86DyzKct4KR2j/yU9ERxSKdl3Rlo94onOOJPWBCeRYSv6q4qD44LUcOpOP?=
 =?us-ascii?Q?eDptdtsftVuTDQ5TFD/s7qvcsBYsLhJ7HHx6IoWf+vGl0SVueMDXXfgvKBe2?=
 =?us-ascii?Q?53xHOn4QkUpgESSHWdrvRa/JN1JBAaAEe9dkFgfUH5DfH+Dy8y/oC3DuffWe?=
 =?us-ascii?Q?xsek1d/T/46FpgM4M1Zy0S6wNY+u7d3jowoG2nBD8D7X1stAAJmY5eBeQUzh?=
 =?us-ascii?Q?AQgv6Q4Oo6xWe9w7Du+WmeZjynvofVZNBaGStKp7N4ZJKZGI/ux+KBmAchlo?=
 =?us-ascii?Q?uyJ5F3QxE3W6FQOMW9Plj+bFod6wMcaLezCUKe9Ov8wzOVRLDC8/mI0Sx6BP?=
 =?us-ascii?Q?S8aK2yP2J+2UWO8LyTr+zha6D3tZwJpkzRFLAXAgVfFAUu8m8w3ze0Yf9xNr?=
 =?us-ascii?Q?NMsCLkrPhWez9oShKp8bTyNyscLPxyUUjNMBLoRh3c6sQ1GQEW1LVTm/QG9B?=
 =?us-ascii?Q?3Uwpanm9z9sX/jbl0l72ycDHp7/s5OS/G/Bi3FAQCbBkzPMQHwHM/MVBg3AU?=
 =?us-ascii?Q?ODjHDLtcP0tm26cjDJ+8+RUkn5pBLhvJBXKCpjTQBqQX0gRy1YtrbamfJv5h?=
 =?us-ascii?Q?F5RVzTizHIT5Pk0wRjY+tn6p1EEJ2MZ9K7WfQPTghlIrZ/yERaHlDU/0C2Xx?=
 =?us-ascii?Q?I17jkp9TEU/5UPQX9zafB51QZn+3eCXDpqJCk1r6nj2XQLYUotAgc5Y9dL6K?=
 =?us-ascii?Q?tnja7DpEjiyA0rmI47u6Bwt53GR3bLdmYsdx4EcEP9KueOzGWa9V/OcOt8Q/?=
 =?us-ascii?Q?yG+sIaprLAqFUXqKicNKw6JMCrkhE7QYA2OoJ2qwIGx3chxLMtcK/SmQ2Xv5?=
 =?us-ascii?Q?1YQ3Us2IPCVeD++DTTae1q6eja3HOwMFvq6kfxexcqdAlMUW8vmclNNb+w3k?=
 =?us-ascii?Q?LRuIiwtrTbbhUhRUiI=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4533F986733A624E20C1E8B5ED760@BYAPR03MB4533.namprd03.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(86362001)(316002)(11346002)(97736004)(6486002)(76176011)(66066001)(25786009)(4326008)(68736007)(102836004)(50226002)(4744005)(5660300002)(476003)(6436002)(2906002)(54906003)(1076003)(9686003)(106356001)(7736002)(386003)(8936002)(3846002)(14454004)(71200400001)(478600001)(71190400001)(186003)(81166006)(81156014)(6116002)(72206003)(256004)(446003)(305945005)(52116002)(53936002)(110136005)(26005)(8676002)(99286004)(486006)(6506007)(6512007)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4533;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8g8J+qdS9g5TUTWCMDCNBrK5eAT3MPnwAiVvmOvC9Jw1NpEjWD+3nZKfsVC2ILbu0FRXy2TlmZ+Ay8+ctJ1UUyFBUrj1H+6qynBspv7XyOBgLjT9qUAHqZI/e7Ri6Qv+oMtLswpv+pc14FMNcovVv3S1cdEVQDxNOJJt1Ugue2IKJCWa0SIdgwUh4rQ3NK6LmkDrJTyaQ1Y51rt3QQ/0ef71SOD6T9PQtlp9/9zJmMzrGdYPQOdciRqchLEln9CqRbTFxR7zmJJqUExCIA+GEhpCpwuhCCSR/8lZZ7P508oBZTnMInSiARO34nY4cYEbHt+SJouv3ybpfielUPC+S1C2CN8+nzuM7Rru4eQ6ubTb1T2YDkOgrJUDJRtyuDed6XmJ/f79RsZtfie/e+bH9SHJZypl1RC90LRQrpN1dzM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A6E8DFAE4A6AE44B8D06088BA71A512@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f96ce6-6fe8-4816-63e7-08d69e033d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:03:27.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4533
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We should check msi_irq before calling irq_set_chained_handler() and
irq_set_handler_data().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 0c18ab63811f..a94d3530b694 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -298,8 +298,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
=20
 void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	irq_set_chained_handler(pp->msi_irq, NULL);
-	irq_set_handler_data(pp->msi_irq, NULL);
+	if (pp->msi_irq) {
+		irq_set_chained_handler(pp->msi_irq, NULL);
+		irq_set_handler_data(pp->msi_irq, NULL);
+	}
=20
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
--=20
2.20.1

