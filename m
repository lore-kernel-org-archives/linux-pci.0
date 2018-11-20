Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4DAC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768320671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FN5UcFo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3768320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeKTT4W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:56:22 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:38103
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbeKTT4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WLBUiGq73F57FgZnrI7y4TOTNp+zfSW77paRGsTmAs=;
 b=FN5UcFo6/DMxwzjNzsDufvNetzc25dVdHISt0+sa1H6A95gAHhMlhGulHBq3aMwKOa1OfdAxU7YNXzSEvGFhHdgBRUkL8/PjDpCqigNKsuNJttJTsE3Ck+YSbV+JkyK0j5wGxD8rj4eNeF8meWiD3c4dp1Jmb3zyomP4X6tq5jg=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4775.eurprd04.prod.outlook.com (20.177.32.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:28:10 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:28:10 +0000
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
Subject: [PATCHv2 25/25] arm64: defconfig: Enable CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv2 25/25] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
Thread-Index: AQHUgLNaqALtyRr5VUK0V4PuzhuBiQ==
Date:   Tue, 20 Nov 2018 09:28:10 +0000
Message-ID: <20181120092615.11680-26-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4775;6:NVa2/OVR8uC0J2Zm4kTgE9UxstVNZZj+ReIGg9qv02o6mk17gL9k83urfIp14FYz1vrZjJ1jZaJJJPHOI47WmCQa3V82pOq+I9L9TVp2Xpumobo8XvX/4JtCmvjbF0LKhARb2s/k8vPe+gYvEzUhYS+53mfaCe/FhSwS9hqnLBbKwknJ3zutC5N0M0X4EVGxXl105GXt3hLPgtu2tOoSYOtjlMO71Z7G6elBgKi24NPsK+nlSdZyDXb5HysMLLD98ImFUtQij2H0wmfKAkZVHjbojgBwLsy4A+bjkRYn8uycVSdTDRDJIHjKkEycEBwg0grLWdLBjfCZYa4ATKB/qNl9QHBHBzGvziR4INYVKqVRmMBwEHS9PZduwrR0RxVcvxXbpE2drd31hnoh+B82nSy2WxLnQQ/PDd/DEi6KoOf7fGNJAV79BNha0QuW2Opomc3qFyoxd21jkaLsWltu+g==;5:nwpspzlM7HXeIM32TfezWukr/8st/XniOt9EOa9qTQcfWXbVVHMDDVlxu2ji0Rfzsy38jUWJxazkaAxB4PlHe48RQzE7pMjh3Jg8HUPzdPUAvrEOhDbvRfE3bLLdj0vvAo/wouKGvHKzokw2+FrvBLK64hD+7lZrQi+zvlDDxlU=;7:Z7P1s8CKr/zviQ55vUVaYEi81mkwBrKup0OcuZw+J1Y7PfEzGM8j1VUecQ0zeDwsWTCUeLPIpMCpDLhaJgoYEPQsKFCGfBiHqSaZa4obixswG1/wylHe/BDYseObsXa6puz5nU3vnf0jcvbCND7Nsw==
x-ms-office365-filtering-correlation-id: 7409f87b-57cf-4709-3f48-08d64eca7c55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4775;
x-ms-traffictypediagnostic: AM6PR04MB4775:
x-microsoft-antispam-prvs: <AM6PR04MB477572C0E7CD8001927F5DF784D90@AM6PR04MB4775.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4775;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4775;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(1076002)(2900100001)(68736007)(8676002)(6486002)(5660300001)(8936002)(6116002)(3846002)(2501003)(97736004)(81166006)(26005)(186003)(81156014)(105586002)(7416002)(102836004)(2906002)(386003)(6506007)(7736002)(305945005)(106356001)(6512007)(76176011)(36756003)(4326008)(99286004)(52116002)(25786009)(110136005)(54906003)(2616005)(86362001)(53936002)(446003)(11346002)(256004)(2201001)(6436002)(486006)(71190400001)(71200400001)(478600001)(316002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4775;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f9jnKRxm1yaxXKW1WtTbOrAzAUcI46Jnp6dP7Kp8Aq9BC+Uyz07yGb07V4xctnMRUnUgKQn5zNSkaC+eUBXdI0V1T5w6xAojBlULotnmMZP9m5KS69T+88aYlqN170hQpHxeQvGEPfKgwe6MeSQ1iY7lYk6mTi1mVgHN1Oinoq7otAsoGm2bc7XG2W/qbt3dgJqC9fp7+w+zU6TT/dhHDXPluj+lvlRS/2naXOlE4a4fAGCZWBGJ/d28EtlRElrSn+z6AisF6XIQJQe4/0DAfyCurZaQ93w/hLobqqhkUoG55cSx8+7qy+U3AP7xLIOeHdvJBVFkSIfuv3rckKis7iQ6r4ZC5OTxe1/4AAvJ2GM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7409f87b-57cf-4709-3f48-08d64eca7c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:28:10.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Enable the PCIe Gen4 controller driver for Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - New patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ad92daeac585..6b4385f26e85 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -83,6 +83,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
 CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
 CONFIG_PCIE_ROCKCHIP_HOST=3Dm
 CONFIG_PCI_LAYERSCAPE=3Dy
+CONFIG_PCI_LAYERSCAPE_GEN4=3Dy
 CONFIG_PCI_HISI=3Dy
 CONFIG_PCIE_QCOM=3Dy
 CONFIG_PCIE_ARMADA_8K=3Dy
--=20
2.17.1

