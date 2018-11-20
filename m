Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA8C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C745D20671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhpmWXtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C745D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeKTTyb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:31 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:23008
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbeKTTyb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opcavfh7LbCo/FyhKpAdYH6KWmnO2HYLEKI4lROkpaQ=;
 b=YhpmWXtGWaWPvfFn1hJD39q6TupBc7YlGOMgqykRC91HzelVfwczeH97vkj9yLX6QhAOmM7cIzP/uzVNkH+tyTfPWyr8JCo3dbqkxxQMz8DfR9q/UuGoXRzDjm7nMXrnIX2WTjut86XfE5eRP47PEJR1xtCkLkuicKAch1BnLcw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4775.eurprd04.prod.outlook.com (20.177.32.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:19 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:19 +0000
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
Subject: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Topic: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Index: AQHUgLMYsPuS+O3rE0qxjRmQ5zrttQ==
Date:   Tue, 20 Nov 2018 09:26:19 +0000
Message-ID: <20181120092615.11680-8-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4775;6:7h5ZhVmOJmhJt0/obafyV59dsLZRPHy8H5KPzBSKv1wr7MbROLuiC7qDUQTvihymklZ6iBV1lsFMXA0cnwxC64a6ysv6WnjIF/bP8tb3gGAM1PG4BeYk1d4+kLK1t/+hc+fuKHBRWeoSYkBOSVZK/1nXQJ6lfgdUnRJlUI2QsIws9L1OqcUKXt23GsfI+CDwo+5UBV+8tFObYctpwxxXHswfLqcQFwUeIda2FFl6uqz9D0wCH8aO4PLV7hs8udxcK12etpVRTZtytm2G7o1KFXHZE6IFBmOcwhO4xNufbozVJjEcAu75tdoICqaNkhYqj7XT2rjoQ1ViP9BAKr5eyZXubEFITr1eAFST7QRFbc7TGfJ5tW4SOSGgeYfJeSaC/EVnAMaTO8m6y1JuOaczRpgrHaD6Iu0SVQsUNgMJ9wbnhp5gTq7B1cH5AaetPo4BP18cCLAa8NCzEfS86uuRsQ==;5:7ICbZSGvcdCpO+Wq+i0kfTS1tjJ8se/TgnlkZtceRpmtbMyBLzoOwcP7iuq6nVDVIjndxi4TMkv0t+K2p7l3yzcGQkzkFBhvMvvbLdaugWUD4Droof5c7T5s8L6W2xa0V2yLRESuXu8OS3/jN3IYYsDbrWctnij/hEX+pVkZGB8=;7:cafdTG6hC8fNuTBy5Pj5E9EHQYJDzBx1YFfNBXEorm/e1s57ofJ+2VKk0wsUIB7WkcxHxs0fuxBfL7+sgP7Mq9gsLo1LggbL3tjmR8Z8VdNfZEPz2wr7gfOcD/N3yP4PYIBe8otTWVJd44sMCZevOQ==
x-ms-office365-filtering-correlation-id: 21ce356a-fa2d-4c3b-45c8-08d64eca3a41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4775;
x-ms-traffictypediagnostic: AM6PR04MB4775:
x-microsoft-antispam-prvs: <AM6PR04MB47753E700E077E4292C2AE7784D90@AM6PR04MB4775.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4775;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4775;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(1076002)(2900100001)(68736007)(8676002)(6486002)(5660300001)(8936002)(6116002)(3846002)(2501003)(97736004)(81166006)(26005)(186003)(81156014)(105586002)(7416002)(102836004)(2906002)(386003)(6506007)(7736002)(305945005)(106356001)(6512007)(76176011)(36756003)(4326008)(99286004)(52116002)(25786009)(110136005)(54906003)(2616005)(86362001)(53936002)(446003)(11346002)(256004)(2201001)(6436002)(486006)(71190400001)(71200400001)(478600001)(316002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4775;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kV3165BGsJkeyshI1GmIKC1sk8ctsmb3B/Ed6JkxmRwTjnwNz7DJdPXun2MjOgo/Opn018/IibuE2rRm8ywjYgEbpdawpwIxy0jVM7xKFP9bIDnnxjgXTIh6cqKr1f2YgMEbyR5yfcy6Ow/v+WOtdVJWB9yGGRTjeIyppkopmm1HWdhI26VSnKVmn5QMeHaJk0y0ArYN60Qr1NFmR36f6xDG+b+uyMi6B0I6IZAdDwLCU5FucH59qX0WIpcW3vpGxsPhGdzvGLlOJp4b8J2PsEkvfH7rlmiDzMbmyS2Ett471aONBmqL2mFgSjSmui+Bs8wHhXD6hEa9PCEYmyccILL1izPNrJxK9A7X+pRUmI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ce356a-fa2d-4c3b-45c8-08d64eca3a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:19.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As the .map_bus() use the WIN_NUM_0 for CFG transactions,
it's better passing WIN_NUM_0 explicitly when initialize
the CFG outbound window.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index b2cc9c097fc9..df71c11b4810 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	 */
=20
 	/* config outbound translation window */
-	program_ob_windows(pcie, pcie->ob_wins_configured,
-			   pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
-			   resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
--=20
2.17.1

