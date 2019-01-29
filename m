Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EFC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0642177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoLa2LgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfA2IKJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:09 -0500
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:21595
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfA2IKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjRhsnHtslgjFjWVqiy0MvdHg9iuVpRmClK+PAq5SPc=;
 b=QoLa2LgL/AfIQFAy8htS6BeCGCNjczsoWTbqqwbWfFnRP3joF6PszdzWdXx4rEDRKRjstB2AGqlFpyW31izNHxiQY0bZbM1iwpXXWSBAN5PqmPTxtUKp1tS1Xm5KeVnTr9jLyJ2E2hLeAIox9OC6BGxNJdLWAa++2vd6h2fp5k0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:10:05 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:05 +0000
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
Subject: [PATCHv3 15/27] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCHv3 15/27] dt-bindings: pci: mobiveil: change gpio_slave
 and apb_csr to optional
Thread-Index: AQHUt6oKYkXcpaoTuUirxMxQCEM8+g==
Date:   Tue, 29 Jan 2019 08:10:04 +0000
Message-ID: <20190129080926.36773-16-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5784;6:dYQdYwIFnPL2jpe0v0hiUpYCfZbwGJGNIiHXgd8igbYoHDO5CsWqLFlasspcto3ojaezprkbQn2hgwS3cKSr2gdHRA0kR25R5Gd2MvdniY5Kr/4jI+6CDiY346whwCCK3P+aLIub1grff4kZ+icf/roXEx6qsVzG2XwmK82ei6tuHnxMsHuBDaVazrqGhi2vkVsTfCV3XxP4HSQ/MrPx0mB99haQq6sYTIka0a4ayK31PbEkZhy/+A5wESDPFlPgsb9dvFPoHVk/QjRynqideJCuwD53y6mvX64PgiUzkZP9qz453e24r8JqpRfPvC2Xw1czs14wluSNM7T7LM6Aff+LlHow9DVded495yn+Ej7JfcCxeDtvz1r0xd+IwkjoLVh7AC66WHpSw/gDwTrTZVfBWObeaSaeK0+nSMBqr5wnNXm+tyL64dE7tkEqIJkpjp0dMp2+D/Y/8LTxePYjXA==;5:lray6L7+RybexYM3lniQkkqzkyV1P385YWecZfW0BOw/UjnBRcu/xYmSeXkfv7dPgjLqPuhwmMA4jDTWd6OJMTjVBSlZm+WsHhqEuM+P3VdwMyrzMiKjI94WUqW1N76ZFn3eBbSXYIPZ/5JE9z5TGSF4SjnbHQn1yKiszKL56wdxzi3agyp0HkEQh3cMMibiZMw7yKyBUiBvWKrXdoyIDg==;7:6+VK8G3KEvba5WlND+2uRDUHHJZxAMrkE2JtxZZDh9pynn2OipakJjF7NQjA2ZBnQ2PgIKj73nwPRzynd/9VLHhFSWY6hziVfWR4RMkcKccHjQifUGlNRZ9fucL3npJHWNFAEoasFp+1xd98vUWfMg==
x-ms-office365-filtering-correlation-id: 6c91fe45-5d07-44ae-dca7-08d685c12ca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5784;
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB578435E01B62BE23EF632ADA84970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5784;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C1wS3BfOac9sbjfX3NWqHBWlQU7pJHiNwcFYmbKOxGxIlcoL1qQVkMYTGENY5GacWIJ0iCWwYVvfLbjfewfHpwVUEsADFEveJvCbv3cPZQVSY24V5VkHt5oe62hicS6Sj0hvYaPYsePtXoomYw6TTQ87L94L7uumxuTCONVS9/N3pZYaKRPkd4pBbYavX70lLd/zWvUlW4obmB3VnUVodh3PgtD0Gk0QeeXQbE/BnRL88ppb54vVxJPNuuuiE8HROmWkpkz1NbANjinXzoLUjwzLmSsrA+0JLoMTw+AHC3KKnWf4z21s/pzNtZqVMB0etBEelBjpReg1eVnE5SRH7PM2nBzYog58k2OzNl89xNX8YnRirG6HTHEAUSycx2TfRaWp04xFZ1D0+c9Kx8Pgo/UNQK3ZDOy9FI3JSd2B5qA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c91fe45-5d07-44ae-dca7-08d685c12ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:58.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
is not used in current code, and "apb_csr" is not used by some
platforms.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Docu=
mentation/devicetree/bindings/pci/mobiveil-pcie.txt
index a618d4787dd7..64156993e052 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -10,8 +10,10 @@ Required properties:
 	interrupt source. The value must be 1.
 - compatible: Should contain "mbvl,gpex40-pcie"
 - reg: Should contain PCIe registers location and length
+	Mandatory:
 	"config_axi_slave": PCIe controller registers
 	"csr_axi_slave"	  : Bridge config registers
+	Optional:
 	"gpio_slave"	  : GPIO registers to control slot power
 	"apb_csr"	  : MSI registers
=20
--=20
2.17.1

