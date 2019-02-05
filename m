Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD55C282C4
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 00:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C942B20821
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 00:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="f7JWKmBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfBEARl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:17:41 -0500
Received: from mail-eopbgr730126.outbound.protection.outlook.com ([40.107.73.126]:2560
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfBEARk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 19:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f5GvYP26A8mIQA/i+ulSdzntAuOmMBXlDLp+3tljg4=;
 b=f7JWKmBiMYWy+m7qrUbzMhab3qJn02csx2Kb9p3HkphPAL43s9BVQx6OxhsDXNM5KcVSIm8B3ktgAB+x+e03250KtB4E1ccUMKD0Xd4IAXR9DJzvfK0qnST4wazw35lHrc/0sa2XdXTHyG2UdxexNvUV8YAFwbWbBE7Co7FEaSs=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3722.namprd06.prod.outlook.com (10.167.236.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 00:17:37 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 00:17:37 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: [PATCH v2 0/3] Workaround for IMX7d PCI-e PLL lock failure
Thread-Topic: [PATCH v2 0/3] Workaround for IMX7d PCI-e PLL lock failure
Thread-Index: AQHUvOgyHlSpLFtcN0Os+r6exyadWw==
Date:   Tue, 5 Feb 2019 00:17:37 +0000
Message-ID: <20190205001721.18639-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3722;6:lv6tWS8WWFckIROI9kNCtkJ/ELc75Jawg748op2DXkUp40i8kLE/yWm2+lPvj1veFp7kZLmMbvHsmpAZ87TcVsgqcGWu95tanlKjE4cpz8wxJ6bTC3ka/RuKBp5dKWphVCRPCUfvBoYVIFdgsKc0MyvtDsXPniWtM4t1BZhnDAxrQ96Oy0fbWYKdR/ivysQz46/Lm4p/lmLuaD81XbY41P0WPlUskwFtppVp/1915U6rT6Ng88PzKcdjJraQ73tbxSxsJw0cFf9cSh18TwxHVfro61sKdsfTm/Fn4Gc6T0yR2oels3p1ta6zE3lFZqIn5bLGbAMe9VOAiWHuT80mhG4OcK6tOXoYy0kzzJKNFIW8aWPLuVYgPyRwOaylLnMbHFuz3/rxG66qBYdUI9oe9L2/NL5UKtZD3WYyRli+yG5Srk1WBIAdzB3TaFliWDSphJrrfWfmhWbD3ZB0IVPjGQ==;5:7pxX755ESOdQ2KKHJpsGg6+xRSRwC2tFbLJ05y4ogXGYZb87rxf4iYXxdq4mwHgViPjEku/jWB2eDy/6zJbr52+ASkKEFyMCz3/8RtuRofeFz1HWKjFJIaFzlO51AISx2Bek9gN3VL0sOrftSz848dLJmTt1NWzY1rzDd5vn4fdRemkQVhYvCBiXhTDNudtQlxPsN4eQj8rF1mMSdTwT+w==;7:hU0YkPV71dzjPD37eUoQwbCNTjmtYUli/jwDO2LPDVef13kMubDL/Qoo7+9NhYGdMC/BVZpJe29ecWj9J0jVwZ+Q341cCji/PEf23TCNTqcyYYlY+hbj3EdT5I1Dd6Sg+sA9PZrrwDhMTo8Y++bTzg==
x-ms-office365-filtering-correlation-id: e28fe600-2297-4ce0-2a44-08d68aff5515
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3722;
x-ms-traffictypediagnostic: MWHPR0601MB3722:
x-microsoft-antispam-prvs: <MWHPR0601MB3722AC62CDA15C0EEFB27F94D36E0@MWHPR0601MB3722.namprd06.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(199004)(189003)(2616005)(476003)(105586002)(25786009)(305945005)(7736002)(2906002)(6116002)(107886003)(3846002)(66066001)(486006)(86362001)(4326008)(97736004)(186003)(2351001)(1076003)(71190400001)(71200400001)(256004)(6486002)(102836004)(6436002)(26005)(50226002)(386003)(6506007)(53936002)(14454004)(6916009)(5640700003)(316002)(8936002)(478600001)(6512007)(5024004)(2501003)(99286004)(81166006)(81156014)(68736007)(14444005)(52116002)(54906003)(36756003)(106356001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3722;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Zzc4vl2PyGnUfUDhktx17a9zpuPwClewXtJJizLSgEzX3SvUxQaWdySbrODrx7rS+v3sNzspjDmTiV1iHqiPItqGRfXFShzMyGeOGjk38Lkk7ZX4cmW2JHzZ1HceyP3z/rhhbPSCgPhexKIvTe/n0EXS246QJRal6SSsiqV6s9oGFkSASB7qUvz8SborFLP862cCseJwZgkNBMf1Y9p/mW4Db90rgLB636Y6ueZU6bIlFWct14SXyPASwlfkvaDrQ8w6kcnuaBA9foDO4uV1klV5JenjHvZUfEDJYjebSafOgy7hIi7knzunPBHj4M3VGqRmBtsJXQavM0FIZmOQTHq8nhq4B+CDmE4ts44xk1Q8QiiCGLcRDJyduuzMzAIbNRPc4Mz35IR3+wncth6EZdpQqxRkW6BF4O0pv/0Q+Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28fe600-2297-4ce0-2a44-08d68aff5515
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 00:17:36.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3722
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is the workaround for the IMX7d Erratum e10728, failure of
initialize PCIe PLL VCO oscillation resulting in PLL lock failure and
failure of the PCI-e link to come up.

The registers used in the workaround are based on the latest patch in
the NXP kernel.

This uses a new node of type fsl,imx7d-pcie-phy to get the PHY's
registers.  The node is found via a phandle, named fsl,imx7d-pcie-phy,
added to the PCI-e controller's node.

If the phandle is not present, or otherwise incorrect, there is a
warning message on IMX7d.

While the PHY's register could be added as another bank in the PCI-e
controller's register space, this isn't an accurate description of the
hardware.  The PHY is a different device and attached to a different
AIPS bus.

Changes since v1:
  Renamed imx-pcie-phy to imx7d-pci-phy since it appears this phy is
  specific to the imx7d.
  Split out dts binding change into its own patch.
  Changed error message to warning and improved it.

Trent Piepho (3):
  dt-bindings: imx6q-pcie: Add description of imx7d pcie phy
  ARM: dts: imx7d: Add node for PCIe PHY
  PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 11 +++++
 arch/arm/boot/dts/imx7d.dtsi                       |  9 ++++
 drivers/pci/controller/dwc/pci-imx6.c              | 57 ++++++++++++++++++=
++++
 3 files changed, 77 insertions(+)

--=20
2.14.4

