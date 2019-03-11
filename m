Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0795C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D852086A
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJtVqEn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCKJcx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:53 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:38471
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbfCKJcw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+LRyQxuKBCpMSVuuYXdi8UF39FveLM4Iq8rCKuymEY=;
 b=jJtVqEn/ssk3vBjDiRTvhlY29uhhrGtBQRs7bK8nZW8avxSHKsCr0YIhAVqpPSttC6BfWELYVLe/VQvi08XY6RKNGaOV6mU8QZip0DYoKI1FFrdJ3j9RWnOm4I/hqSDGZSU0ivTLI/I0BgTyArYpQhf7wqsxMlzKlksJyq+S76E=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4168.eurprd04.prod.outlook.com (52.135.168.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 09:32:49 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:32:49 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv4 21/28] PCI: mobiveil: add Byte and Half-Word width register
 accessors
Thread-Topic: [PATCHv4 21/28] PCI: mobiveil: add Byte and Half-Word width
 register accessors
Thread-Index: AQHU1+1kIDVQdssEHU+uhZ59DBwaQA==
Date:   Mon, 11 Mar 2019 09:32:49 +0000
Message-ID: <20190311093130.7209-22-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbad3283-6072-4fc0-2edb-08d6a604869a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4168;
x-ms-traffictypediagnostic: AM6PR04MB4168:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4168;23:6iiv20Ev6GUbZRObeLZj1mGDKf4pHr8D70giOxi?=
 =?iso-8859-1?Q?wuWzyLBrcW8Kd0he76yDDJwKDEVzDlcRg8CDEDWwIMnieGMr8L8WH3tIUA?=
 =?iso-8859-1?Q?cubGIysCTWAw1ns4XNvfjRB0Ut3zhahoPrU+3cG+jJUmQjZY5Gv7V056VC?=
 =?iso-8859-1?Q?ze4rLtQy6ugwCZjKOgrEOFnCuN1vPbmKIkZMXE+ZoNHZSQzYp82YGDzQaY?=
 =?iso-8859-1?Q?bUaIRFxoVIGcwaZdqvR30aWL4D9uARjusPdaCmIVOGuuZMHXkS8L5veI2z?=
 =?iso-8859-1?Q?yfZNqERbyV1uZMGmMtqml/zVj1MR+Bf4pdY9GtHzZNCLDLNbiqvwhF3jN6?=
 =?iso-8859-1?Q?SgO7Dp3CHPbdKXTX3AiU0NL753W2idCaCGAKj/NwsoVhPXsryk8WDusCwq?=
 =?iso-8859-1?Q?b0vGy4P6RV/5pJkYXyQXPo2d+M3kUODnCKiNk8p+nvpb+P8RbXsFfiNusW?=
 =?iso-8859-1?Q?LuGIsUkhRMgH5s6dY3W2eprWvQnLxXopavbwI907JT1odSAejVanE5eL2l?=
 =?iso-8859-1?Q?T+4tj+rq/Qp1aNMAeksdrV0c8uQRYnsCrDuqc3TWE6EdAUPo4unBjucPuQ?=
 =?iso-8859-1?Q?YZoMvNzBq/vKyBZnshxbfDC4EcCz5e8D7huOZbkfUGVvG4ntT+KQTLEtTN?=
 =?iso-8859-1?Q?ztwI2eRrbGwB7smi68BoWp+THcJYLX8rR5ctHOXmAlYfdXrQmQ181Zcb1C?=
 =?iso-8859-1?Q?QZRn57OkZNx4E/dgtBgFKhGrp2GCrsq4TETAzwhVbM8agYoZpFCenAhM1N?=
 =?iso-8859-1?Q?sFYSubG8SegJHIVuNbgvLWTm1MWmt8ZgrrrzFo9B2dlvgBAXlqIR9HuVrL?=
 =?iso-8859-1?Q?wuQoETE8sLm9rW7pjzUGSK9o5TEZ6lqDdlFgpk0sqdlutc0IHt2RiGSh+X?=
 =?iso-8859-1?Q?i3fFE7klEKsNGZhdz2UTxVUS3a8KW2Pj2JNPZOSpFzyDNatbeQdXheCGIl?=
 =?iso-8859-1?Q?pz/52nNsxzTi+41bZ6J1P3HIWx3XzWCePDgYuyqfX4wAuuIlB4JaRVN9Mh?=
 =?iso-8859-1?Q?ux8MFEoVliuDDZ8+IXJaWl1HgOQbIhsAteK8HAW/xGe1KxSfXnZegMDRYd?=
 =?iso-8859-1?Q?18ABEA552LsheQx39eipFDQvx1aGUTRw0CI7xmHV52gNI7fIlQRwoP529w?=
 =?iso-8859-1?Q?ABbQafJBwhff6mQLnXy6Jl8Vuqau0NXA1LrM3MbkCb4LblLRQTacFxBaLI?=
 =?iso-8859-1?Q?CA1iQGvBd524Zeg3IElRRje35nqHuaw7eJ1oRuJ8Cj50QWoEXGP7YkMSRh?=
 =?iso-8859-1?Q?uaDm8PLRrLvKCR43yf/CEM3VrmkUSz1dounJ8TfHn3jsYHbOqwh2Wr6xJD?=
 =?iso-8859-1?Q?NuqlC/eMPIxUtdYr/7UOlAPYN72P41dgaUdg8oCGK3q2w=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB41689C63287994BEB8A599A484480@AM6PR04MB4168.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(106356001)(476003)(446003)(6512007)(105586002)(7736002)(486006)(11346002)(305945005)(256004)(6486002)(2906002)(25786009)(54906003)(6116002)(110136005)(3846002)(71200400001)(2616005)(2201001)(86362001)(4326008)(71190400001)(68736007)(102836004)(5660300002)(81156014)(36756003)(2501003)(7416002)(6506007)(386003)(6436002)(97736004)(53936002)(316002)(186003)(26005)(76176011)(14454004)(8676002)(8936002)(52116002)(478600001)(1076003)(99286004)(50226002)(66066001)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4168;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PJjDrI+/iyZcLkljKuiiwNRWftZpASGNQsArgOlAFiglwYg6SWaDnKSHHdqmlCmmlM1Iw/nHGtQZhSeBEwX+tAW0LL1b32ecC6jkAKz/ikTAqLtMBFX4LB18fMgwp7+sc06rD+iYJmdmQS9nG82eOWfyBfqKvK6HJzcAQd0eaezHIrw/uifE/Fs4I+iiltJuZiMgdt8s8wQ3AsVWtfoCrboM2o4wseBFUtHow+prsuBoibppNcBoGuiyZck+RjCVABUo0ljpXgcmu8U8qWs3VjHf5un7SNXHsn0+MvkDfm7kJ8/kW4dEcWJ63dNEO6TOSNE0LVG+dqWwfVgmPt1S5sYrcqcutyrY5NDDBd35SfcA3zva44iVC2K6njFp3ceOzF9zcElskC/HHLS0CN4rwFbhcDrs+4W3OWsz4ARnmcU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbad3283-6072-4fc0-2edb-08d6a604869a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:32:49.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4168
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As there are some Byte and Half-Work width registers in PCIe
configuration space, add Byte and Half-Word width register
accessors.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 81685840b378..933c2f34bc52 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie=
, u32 off)
 	return csr_read(pcie, off, 0x4);
 }
=20
+static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x2);
+}
+
+static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x1);
+}
+
 static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
 {
 	csr_write(pcie, val, off, 0x4);
 }
=20
+static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x2);
+}
+
+static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x1);
+}
+
 #endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

