Return-Path: <SRS0=dd4N=OL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4561C04EB8
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 13:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B18E2082F
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9DaivqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B18E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLBNc7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:32:59 -0500
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:17152
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbeLBNc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 08:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOKVN4Dq3wEdSArHjs+K3j36zFWT87jOax261FrYp7U=;
 b=I9DaivqKK/TcJqEVB5muyfX+vxCE6XLCfzf5otwrnr0sR8GpEv7hGxiqx9lEMiKki8D9qjVCs1YvLG67xRGJFG/24HpgXnrPpB7ULMPtCEATzbNB+BzhfZ5nxcOLbpSs/hc6J7lsxYUT/I/oOfk/9vRY7yCTzr5xLgnyh64lVFA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4999.eurprd04.prod.outlook.com (20.177.33.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Sun, 2 Dec 2018 13:32:38 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.020; Sun, 2 Dec 2018
 13:32:38 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>
CC:     Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 0/2] PCI: ls_pcie_g4: add 2 workarounds
Thread-Topic: [PATCH 0/2] PCI: ls_pcie_g4: add 2 workarounds
Thread-Index: AQHUikN+67Rwke2mpUeJS1AYJ6IiLQ==
Date:   Sun, 2 Dec 2018 13:32:38 +0000
Message-ID: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4999;6:w7Fn8UrQ87JUd9joU/c276pYXnt6coRnljJQFfLTJ24MImuwYj4UwK63zgU5RW4ToOAJFoq8TZGTdZ0EgXJDKV2N32WA0UzeKgyVJNVcnqZFBd7qUH9GTvorcsn+PpFjFSu7wuppmkGm+amqnnhpWEeeZ6G8BvDpgjxUhEzK6lWlWCq9e+dlZkCC4aiYjXu3QAX5uJhdNIfEYhZtplg0nf154NvS1/bbnrreCfUojOtOMBnRl6qeF7I3VFXz+s6bNq2t+hjJMoVxO3D2iQRYTxrOhJW799Zu6HLq6pDcdWMnjomAvlVCxF1a4S3CisS8dgY2Rk9m1ILhsAiyHbddawjJvT4SWm8WzQWGoIyNPVF8Ufi1KNZOgk7zJ2reBSgyCtXBVYXnWyGaPWQ5zJPhCA3ahWmS55kUTPdVwfoYERLpaYfxNoN1XOrfZKCq1cN0LwKwN4/qrlqzMNiJ7vYNPg==;5:unnwJONZaVNxuV4sPkYAXVJGMWt6+Mr1Pa8LJ8MxtEgSo5QaRNCS0ZBgZeCsZH3HIi6WbLYOLOvKzpSHPO7uuSwxP8dFMnDLQQHY/gdjr4qx0ipxrpMC7NgOL2nLKvk/oNGOK4p4zjRrKE5HrPj/xg3oo9n+UQoaI6IkC2h9ZKc=;7:iqR6L0XskEQXdaPIyFTbLMaIE/i8s+mdTd6cpWI7z1Z5ScNupuKvTbvU8oqC5WaeNP64q2Ha1AmtyskWFar/wPFyHTXmAnm/7AKMdp2E9vNAfdpXwb1yHr1gEFb0aiAEA5FrbWBqNtPkZVfbYedPaQ==
x-ms-office365-filtering-correlation-id: 761796cd-f1eb-4959-99af-08d6585aa061
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4999;
x-ms-traffictypediagnostic: AM6PR04MB4999:
x-microsoft-antispam-prvs: <AM6PR04MB499952C725EF6FFA95C91B9C84AD0@AM6PR04MB4999.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501489)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4999;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4999;
x-forefront-prvs: 087474FBFA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(6306002)(256004)(99286004)(14444005)(186003)(52116002)(53936002)(36756003)(4326008)(25786009)(66066001)(6436002)(2201001)(6486002)(486006)(5660300001)(478600001)(86362001)(14454004)(476003)(2616005)(26005)(6512007)(2501003)(106356001)(105586002)(2906002)(1076002)(8936002)(7736002)(81166006)(81156014)(110136005)(6116002)(3846002)(8676002)(71190400001)(71200400001)(966005)(102836004)(386003)(6506007)(97736004)(54906003)(305945005)(68736007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4999;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DCQcUdLD8Dwj3KkaIN6Zh4i+77HG1oZeqNuFfrbo9I2rJmspBKzsAjpFRQhz4uP4TZzs7LPz8xxR77VYWEql+f/sxB1TOrdcmqpZtZCzhHZl/KNW1LGyzo5FgEj8ztZGG7Kef1jeimlqjSGv3vekGlEOt0PvN8KRywZHot9i178Y/aVCVvd8+OtKNSDWxi9e1FIGxFNm/gGqLnfSdeHxb6z3adu73QxcUIGmRNp8pKQhvpEAWCCkcfmVWxAjTiGeO2YILFvCKHQEUOF7gaFKBwiVpmp5NWa9YYYiWQtn/5dL8jFJZxOgE6biCcYJG1bE7Rgkges64wpAXKiUYI5T3ITre4DFzHc8wwWhCPXqFZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761796cd-f1eb-4959-99af-08d6585aa061
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2018 13:32:38.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4999
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patchset adds 2 workarounds for NXP Layerscape Gen4 PCIe controller
driver.

Hou Zhiqiang (2):
  PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
  PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451

depends on patchset:
 https://patchwork.ozlabs.org/project/linux-pci/list/?series=3D76942

 .../controller/mobiveil/pci-layerscape-gen4.c | 38 +++++++++++++++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 13 ++++++-
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  6 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

--=20
2.17.1

