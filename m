Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B28D20657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qnqVO5Ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCKJbZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:25 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:62976
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727294AbfCKJbY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQP5OwqdG/Q2QfkutG8MTiHceJFLXEyIItNvHC1TlWI=;
 b=qnqVO5UiM7LkEojZWNn4Z10sjSq9n1y/jlP3dMZJx52sPp0NgwTmSJNRFsQDT9M/ggr+N1GVoCyQhwCsdD/zewyNl/lFVtQrm8gEHK/f+lZ0d1ms2zchdxdPRwYep13aYR4oF4ncVlcpXv77DeKeNoMTjxVODdsdVNGKjfCh+u0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:31:00 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:00 +0000
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
Subject: [PATCHv4 08/28] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
Thread-Topic: [PATCHv4 08/28] PCI: mobiveil: use the 1st inbound window for
 MEM inbound transactions
Thread-Index: AQHU1+0jagSkKTBKl0OUnmc63aFyMw==
Date:   Mon, 11 Mar 2019 09:31:00 +0000
Message-ID: <20190311093130.7209-9-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3dace2d2-2eab-46b7-3f31-08d6a60445ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:UaxgyU6b7wUNDPkX7EOVNSUn6jVXYk6uBA4UYSw?=
 =?iso-8859-1?Q?OXMNGqr6DJvEVbqa4bzm5hm1Mvq8aazg1WSr2J8oWgr9hctFonW26LDcV4?=
 =?iso-8859-1?Q?026Ln1ONTFUDbeoSQABKBRAsgi+OpRafweFdfe74ef3DeAvcdXeyf2GrF6?=
 =?iso-8859-1?Q?+FGqXYa1PgYXuIVUtEtiP29DtCb2mzu2e4Bm8YsuS29Ov04ajHe5KNxhsh?=
 =?iso-8859-1?Q?TXvtnpuWnSUyIf2uR82sLxngcLtKLmjfLxMvDIeMSJgkzpwfrgPSgGMurg?=
 =?iso-8859-1?Q?r1mVsKC9+UXeBCiExjeY4Ib3fwREa/M+9X6fT3yVq4QCIROGMzufsTVNzF?=
 =?iso-8859-1?Q?WFl3xysnsscn5HzGK3RY4fDzlsf5TBaLPOe7/WOefIWb4tdkdQtdYq4P6A?=
 =?iso-8859-1?Q?bINwMjKHw8eS3qn4cgho70TrFWYB0NnEMshk2wRUN/cvCnGnhjOvSWGS9Q?=
 =?iso-8859-1?Q?qA/88MVH2PtIeG92attfzWpoqnRLb49jP0+RYqaVwW/GXtAoZ0y/kl3AQd?=
 =?iso-8859-1?Q?mAhCN8lM2s1K47RtIku8L0DAyq0mQI2EhjnlgaDI/Pq+nae+HobqpUrUus?=
 =?iso-8859-1?Q?8vk16cf7/Y9Ly6xaHnbWKVojKv+4TD8BWAkauPZzEsVM4oKJ5WIKfI46EW?=
 =?iso-8859-1?Q?ofF/Yv/y0WahCdN6cyu2z5A6CB16TQK996dzizuPGSPQrNO8v/uNzgg78d?=
 =?iso-8859-1?Q?yspguwzzzWUU+bJdnc13ojs6PVgfbcurHTGkRqD6YgvoOyg0onMNKVdn9g?=
 =?iso-8859-1?Q?VHzg0dkS1lQTejM3c4ZSRkthM5pCg70Q5A/fcSs2ABJK25Dn7bK2k5uz6n?=
 =?iso-8859-1?Q?wvUtWAH/3Qoz7srvcVQC9qJ8O5DFAiEqkew0RTaI7nBIooyNMa6oThYggC?=
 =?iso-8859-1?Q?qUNgvgqn5NLOVnBn02aCiOLRQvr1lALOdBo25ZC4tPqOJrqfhgNmfabJUc?=
 =?iso-8859-1?Q?yBaeYwbOOHqoGWm8zDTsiqcxTMmkCLNcvnwUsEPYnc53N5XTFh12b16ETd?=
 =?iso-8859-1?Q?pj+7rMpBkDvgOKU8A+VUS0IGx4X0R3pKVAcw/hXS6cgNRUVKYK5hkQDYbZ?=
 =?iso-8859-1?Q?TAC28PXp0/Nc9sbepYpSGdL7WdEnF1bM5hoyyfGuJu370Y7PbKxiLzlKGY?=
 =?iso-8859-1?Q?2hkX1t+ZVPoFAJJnLe6N2NCw8W1IynA3WjIxwib7hIA9yZe9CB7ggLY54b?=
 =?iso-8859-1?Q?VNll4wzUnZxJBA2ZbZ8lpekfKVCSzbum3CNhvduEaTcyMRO5n5XU6t8hOt?=
 =?iso-8859-1?Q?mTXLk0r3FNxHiclA9FI2fYCyXnRSCJLC8Rw5WT/s2+AUW8PhB2WYot0DJa?=
 =?iso-8859-1?Q?wwF5MltRiToV02waPG3Fxk+eJKPU0Didxs/05yBHURbSZta1+MEDhuMgcF?=
 =?iso-8859-1?Q?mwH2rOF3diRIArkGznn1+tm1S3JNE?=
x-microsoft-antispam-prvs: <AM6PR04MB65666E3166297961DA6AE23384480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(4744005)(2501003)(86362001)(14444005)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6vbf/TSaAxcH05F7GgmPY4zSzZajm+EtVIN6IHMict2l4mHZ3fWh021s0xrpOmQj6gMXp1LmEL2L3wBl0jKTOFBocO6rSYqo+sW1Dqv5yHZ0hB996u2YJ+VWO7rCiF71Nij/cl/qmXgFfntTf97y6jm64qdcEkMpDQtVIc5DIWm5p4fVz7SVBgLpMEwLxFNztKoHLtpu46NUyg9jGDYVoGRbedOMIRp1lag+ZRRP3lGbHnr6kQtih2PChVF6jA4RYUNBU6EpfQbeZzFBE/UzFaiMQCh7KqofThXsuXXGKYcY99N8+88A0Dt+XrfeCjqh7xaREvUlgL8YCUjq1Cdeu57RKeMhaeI1V+yABGu8nz0TVbd5QutsABa0hyHyFHd1WMv+lzUwqLlU9pfS0UoPQ0RspmWVD/PKD+IQmoNHghM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dace2d2-2eab-46b7-3f31-08d6a60445ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:00.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6566
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The inbound windows have different register set with outbound windows.
This patch change the MEM inbound window to the first one.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index df71c11b4810..e88afc792a5c 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
-	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
+	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
--=20
2.17.1

