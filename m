Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD322C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFAA217F5
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P3wD+tMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfA2IIx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:08:53 -0500
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:51167
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbfA2IIv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaEntDyw6qLx6mvy22xU073gwAKY3mmxOe0XBwod+gQ=;
 b=P3wD+tMFJ6dj7tE4ZDNzUxTsNeC5HYvkbkJKlFb5vVN+9Wr//aSyQwNnYAcbdgA/xCvqvffG4xdZPg5LddPPGwvnsGBXLR8eci1vfeuEAMNYnnlK2d/7fe3KDoH43LTNhL1rtOIoEsibMb+Izmdgcls+P77wUdeGg/SnCn2njzM=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5847.eurprd04.prod.outlook.com (20.179.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:08:47 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:08:47 +0000
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
Subject: [PATCHv3 03/27] PCI: mobiveil: correct the returned error number
Thread-Topic: [PATCHv3 03/27] PCI: mobiveil: correct the returned error number
Thread-Index: AQHUt6ncjsMFdns5G0+hpkPdSUjWog==
Date:   Tue, 29 Jan 2019 08:08:47 +0000
Message-ID: <20190129080926.36773-4-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5847;6:lg+RLQN4pERq6haAXAbj3/lGFyYAFdVUFixry0imbZpg97O3MUP/G1AV7gVwq3Sh8cNJ9EHo9aw9vLFT3bEMIoWSIz1D2hWpbXF2hKjiocEAqvH3rl83+kQlyqv9N2GU4nhEdpn9h5s6oyPKUcmz3abIWnabelPgNFpNCRg1D8GhgjddOt+y/U0mXsGRUCO+m3sJFKE8tUd3+Pa1nWvR0j2BMf5b2CPMKFjQ1C67g9L/FiZCMKAgtoS6gjKKsmWVVOQ3QYPNjSHBQ9Oxd9Bw7xRVUN0KIASMobTM+3dFEdS7FRixLKLC+bSzn2l01kiBGJuGBBT8hTzqY2CqbTz/Zbn2Dsm5lWuTqS+V4aBLTnQgvZYUxHEeQuz1eU9snpd5uGaB+4Xgacz8wMrdRul+uZyYLDuq88MpENP2TBxoOF6NUy3rKAdeMISv9BWsOSM+NFy5D2HoGBhZPmcflqLooA==;5:iaE1oyO2Dis18G9Y7JqCygaIO0GTrjBpBDuJGkyCilQwkpkesd9X9UeUmpz/T/Cs9QJLhSa2tt6pqR0CFm5HMB9N55QXzBSmjlnmB34LCbcSx8UkltHL7KyJLYLIhOiD/hCOZFsPpQORUmFSfWSmy3mx9RVAyUBxZQHSDe78zQz3bZ305U8KSjJsiSu14TerI5+Od1fMTHmkRlC7HgC0Ew==;7:j16y6KOkV6lGh0oi6spCG2Ef0C/D/qu+qCyubcqGcv/psdhpYNJW+mB3Z/qFto8oG/x2GMNB/tcOdI372ukUf+C5GsXinKaj7tIeLAFsWv/ZS5nLFWrZO0f6zjR6blndrbyOrzMyZ2EiEqRTB2hw0w==
x-ms-office365-filtering-correlation-id: 063fc20a-3f06-4a2c-fb28-08d685c0fe6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5847;
x-ms-traffictypediagnostic: AM6PR04MB5847:
x-microsoft-antispam-prvs: <AM6PR04MB58479E75382AB38E7BD00B2484970@AM6PR04MB5847.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(14444005)(14454004)(66066001)(478600001)(2616005)(6436002)(71200400001)(446003)(486006)(54906003)(11346002)(476003)(99286004)(110136005)(52116002)(256004)(6486002)(36756003)(6506007)(386003)(316002)(97736004)(26005)(102836004)(71190400001)(186003)(76176011)(81156014)(81166006)(7736002)(8676002)(3846002)(50226002)(305945005)(4326008)(7416002)(25786009)(1076003)(2906002)(53936002)(6116002)(86362001)(2201001)(105586002)(106356001)(8936002)(2501003)(68736007)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5847;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kqlYz9/vZQAilr+kTioiVklEfa3hrLAUi9zoD9mVE4wgAPO+/aJI/79pH8y9s4ynvz4EmNXngjuMRMnx7dmrbaeANeEMOzv9rNyNy+UtCGI9bZ5FPeKNLOwKyDEHSWIJQy37xYG4bG05zDGN1DQtJ1Nmgmb8itdJvOAnL1wzLcopM72+/wtynEHS1UqjeQejdjWj8jhsqrS0nNvNsw3qfHCxMhP02utmXZtHBoj+TchVeP/2ed8tnLMYMGM48KlQlEs2tFCZ7Z0j1dEm11h19ZiyybP1FCAfnc/ELui2lucPdHQmPi7R0nPeoV2ij36mul2rTzTp6pP0Q8QBFTQRHz6vrA+Zxx36cY3rbhmN8+nA05uhJHRGFce74BmeBf86wEQNb1i1IQ3+TvAp4wFglQ+HyBNWMMVTMCKOHo5tRuM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063fc20a-3f06-4a2c-fb28-08d685c0fe6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:41.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch corrected the returned error number by convention,
and removed a unnecessary error check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index b87471f08a40..563210e731d3 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobivei=
l_pcie *pcie)
=20
 	if (!pcie->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
=20
 	raw_spin_lock_init(&pcie->intx_mask_lock);
@@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	/* allocate the PCIe port */
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-		return -ENODEV;
+		return -ENOMEM;
=20
 	pcie =3D pci_host_bridge_priv(bridge);
-	if (!pcie)
-		return -ENOMEM;
=20
 	pcie->pdev =3D pdev;
=20
@@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 						    &pcie->resources, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
-		return -ENOMEM;
+		return ret;
 	}
=20
 	/*
--=20
2.17.1

