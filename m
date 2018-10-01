Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68FBC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C04E21470
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AHySRpLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C04E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeJBCdf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:33:35 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:27854
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbeJBCdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 22:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfYDRpGtNhiB+2uKYtJvLbU0siQgKtoIlPCdtkEKwB8=;
 b=AHySRpLKjZ1N/GdsaHiF97jGkKYehcTxaLj6L+aMaG8/0ZkmD5OjRr/cAg/nq9UUdruZ/sUa1A/CtysKZOjC5BQQfrCSE8a/QoN8le8aKUlSCkyoMUvrmUY3RMD+nBf5ILQWt4xh/N4TbSSBm8tfGLSjToqWqf4nGCCS+9mE7Wc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 19:54:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] PCI: imx: Add PME_Turn_Off support
Date:   Mon,  1 Oct 2018 22:53:44 +0300
Message-Id: <cover.1538423063.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::23) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec455bf9-227c-4b2b-9d3c-08d627d7a64f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:5Yuq1n9r+tfjoRuvy4MDUCoxhYyi+FsaCL39GKfuNHt9O6SLbnV0+QXJxp7m8/gkMcrkWBE3uqR0HdDpn4+vOdwsDLq3VRaeqRMDJJsBm8WZwZ2HfdO02G+IVPp34eb1B4dRFy90ukLAYyedMbh6tG2nTAYgBzY0ZRK2Q59SgBoUypDa49hDGJgCqjP1u53OQmu8nILDiQrd9TkQ4WGaMjMFLY58TOFfAJybNwIJi+AkmeQkADCpGMKvhLhFaniq;25:axRvRiLReRTPFIfKEOl+zFDRg34wNYi1xC4J81NzgF72mTFfvR0zMs7PR8OER73prPrB6mw82exsAHPjGt+ojdGWQD3XrWd/H3yzxOwcZLiyUavz4ySSp2tDCTexvm4RjliZvkqBDsLUleQp+WE6GC18oxUcEKpOqKY6VYD+XDpJkpxjvmxVrGuUhMywqqcR0zBDTeRTHyW0kxmi0a07J3i3a4xrLYxdaVrEJnPWIBRBY0Kd5NMqZDTYZoGFGXaztxZ8T6lWQVoGqTO1vT3S1nauzGMOCeHZQ2JjiIfcesXfZwwSXV/2ypV5/5F1kJaLWtCmonax3BMBGXjnarJ09Q==;31:wz519hdccSTZ3Ok/evpxwC4XgEnLJI8KVr7y0IzfNHLCeasQB6VVFidDxpmU+ukouS9b11tIBEbrhWrqcL3amiNlPjtR++ebAzXZoq9S4UWJnNbeFi598CWsSDg72gm+Ii05FSSqCY5ZMiepfjfCngYqfcpZo1aLs2X9PC7mPCMauTl1ra8HRe1nWuuPGTq4tLPDT+kjhXSKBHucLeptBCHuLcpSId9dS5K+hpbBQWw=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:6bRi1sjJJ+hgRhbKrEcFqMMZWjqPrm8JIf/b48jOY+64CsiS4FK2J5aoW9KYROyw+t0PyWcOTboUmPsSFInqm9ymcJhPbciPegVyMxN7A0jZnuQuqrdVUz/uZXGMKftpAB2gSFbPZom1xTgAO6tjcK0aMAQwDIYi3D3pe5pnJgoqr7Ljw+bIBurwCB1FPFDcQdoBrTR2K4WbNRNvDPLppoTOcqPYSva8f/LfrOypVpOvKzGcthf7LU2IqJNBVMm9HaUNgq7NRMzvDZw6ZbWsmy8ImdgusKfZuScY3kSoGNDTzbDFo45huxI0UWRH7G8vwQC0FE6G/tWlW69Zj3DTey/PLBF2dr80W+KZSvuD7+y+xjWFDfqRJjwofjpsW7DAujSFWHF+Dd90hZZKsqpbYxNXndugn1PXmADRRwFhQ+D7q5FmvnVTBoS3GQwyJJnb0cfCq47D6Qp2FBf93tdHcuJitnKSA9WO5F7rXl0wJ8F5W8OHjhX72tTre1QFnZiQ;4:2Y9+wLbPzxrMHYV6SpoHiZsxSBkU1ng90WSZZYvAFy3LluO/AuuWdsGlatQf1x7NLLZ0sxLLiF4MAvmvIoodBBBT5aunRik41l+eFCniS/BCE7qiWxoyxDcG3kcPPo8ITtZrbPndjWKuNFHKM1FUsVZFp5YywIl4/qzffYjzA2GdHkVdSp0MN+xywBpucH+5n7VdZDHrdMPP+oDKqflbXeeO4LV8u8KJdeQD9/8xLgSuT4V9xjyYq3myeeOCMaCa6vyAZQ2Go3MxdrSynvRRzw==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293F2D7041C6EB4EAFAB6ADEEEF0@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(6486002)(7416002)(110136005)(54906003)(6116002)(53936002)(6506007)(386003)(3846002)(478600001)(966005)(105586002)(16586007)(6306002)(7736002)(50466002)(6512007)(66066001)(47776003)(25786009)(956004)(486006)(305945005)(476003)(48376002)(26005)(2616005)(51416003)(52116002)(106356001)(6666003)(2906002)(39060400002)(97736004)(16526019)(186003)(14444005)(44832011)(86362001)(5660300001)(50226002)(68736007)(69590400006)(8936002)(81166006)(81156014)(36756003)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:TernGcnDwnMjLHnYfY1hJS1rKQyi2BRkYSvnj1sAZ?=
 =?us-ascii?Q?MsAq0pZ+Ejgyq17fWjolR7Bqr5qLd2I/iA3Fup8v2xA4TUhwyCy6RVEM/36R?=
 =?us-ascii?Q?MxDcx7aCjCetKlrPynywtyEsupJ0ic7NAbgS8fq1AD4kAGdSVi7jYScT+vIa?=
 =?us-ascii?Q?vGtENQJCw4aI4h5s8zzvSZuDRaTfYCSwwoOkDVZ5UUOOubty8PlE+P1Bo09Z?=
 =?us-ascii?Q?GFP6f6lvdxGNNZu4DFR8+D+ZTn5vfYFJbxT4ftQVh2L5SAiS1/VewuyUvC4G?=
 =?us-ascii?Q?tCQ3TrFbOuOWAXf48FaCr6o9/YopByTR3UUcSVGw66xbc02Pe7R/S3GPKtVc?=
 =?us-ascii?Q?H9ObcgzKmPrHWOt+KewBPPXR3KZ+SQxB5622g217QNQJY0weRiQlk0GZyfN1?=
 =?us-ascii?Q?Yqfmc6g7OGX9O9dECC3pbFRzTv/m69EZhQ1FYNfu+1s9nEVBHGAv6frgL573?=
 =?us-ascii?Q?ZPXXxPJYulHf6I3LhFMj60RwmMyE1bAmHEsbRWZRhWBAkvyEghMVhHJwyEs5?=
 =?us-ascii?Q?9hs7stH0J3elrntxpCGI53wnNKcG9orn3Ar8TWAT09vR6fA/gz2P8UEtvRyx?=
 =?us-ascii?Q?dearrJ77l7FNH+oARGR+eeAd0htBcKNZf3ttsWy51TonKcfMjZ2T120huiEN?=
 =?us-ascii?Q?LtVinxILSHQ4ovrbO3b6eC/IFWdNLjC4Etl6GbomokhG7G1QlRMsIgAPAIpX?=
 =?us-ascii?Q?lCyaFhnvLNwILZn3gkfETdn1h4Chaqgp70OF1dNNqLDw3Stt5yDVpXintimJ?=
 =?us-ascii?Q?AraMkxtrTl7hhlc2lEjNb7utU1ytA611ow4CtLd23qeL12rDkPBymAW0BUvw?=
 =?us-ascii?Q?R3xIzivSStQxZquMhNsBY4S8Q7qNhliR04K+3PZFvpZHDX6EKD5W8+rnNe6A?=
 =?us-ascii?Q?48XhaoUcL3rEwOLKbs5brngaikRmwJHhfzRFw6f5vSERWqP9wFx668cKn+7j?=
 =?us-ascii?Q?JTgd6wbkSZ8rtYli0hx0IqSfhB841Itmb+7Gps1i6pL34ae599+WYEvyzjnu?=
 =?us-ascii?Q?pjxLc+V3ODexWW+N09XaeMhvbNpfUWhf5mh/s+D0K96yqlkHuDMXuP32Z71z?=
 =?us-ascii?Q?es/b6ZifPQBpBdytixPo2XYfj+/rt9w653K8P2G9kv4zPEZ1+uHnDca5vHU7?=
 =?us-ascii?Q?Ty02bdqHUrGi/q+EYJ81yi4Ostl7Aq3LcdODbxvwuhbVz+fCq/gWOwdP/V9+?=
 =?us-ascii?Q?Nk3TqG5RVCWcnn8vWj8pukYYlbmuEr1cDFxO8xQvGuntZXvPkoJNW6h/Hr50?=
 =?us-ascii?Q?lZUWycTnrGH6kP4YmxzHZTZi2SxbdUyrUJqgpA1h7weiSxNPuoK7DnTIMZp2?=
 =?us-ascii?Q?X75h9zxmuSj9CCG9VzO3VA=3D?=
X-Microsoft-Antispam-Message-Info: UmRXpkaBREL1jwOtahSr8A2Q96JQUW2poQBHrpS9FhI9gFjRlsQn1M9gRzavmyjL1eZi6XAeXFuV8Nvpw8Oy9XGTdLyCshmkAbDLUM9NCSV3IztDH5m8nQS6e/guuLBGXjuZ+LHZmVb6a473V/tkV5TMN6LVcBtsregoiBmKQurV0gXXj6C6xbRWC7ZP8E6pW82NOijZ2SFPG/4j7GSYo8osaK0Z7HYia+vUMXytQHBd4bk01wjye9qnCDzn4c+uVqD/F7lD8Z6UfU7+mRyZM1oHJZrDnm29Qn4SO5GxJAFxBrXvJ1YxIwCovalYLgZ7HhglvyFOJ5c2/zObwxrVfQqM0dg5p+Ry+74LFhlaUwY=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:4MXMAiyz5aQiiG1B9Lih4cAEBkto6bRatVt1U1+5JaUd+5LoX4RweYXR4H4KlgCIRA/HxhbfZTg44Eu5hoJCbck3porMvo9Kx7ofP70jL/Z6CZgJhGLqnY3Zb/RkeX+pFcye7np+8Cc+6H4ubHJjW5hVIen9in86bsFsl9cIGf8mRcY/LS9nw787edn7LyReAP2O1Pt+PCYEhcxIheHa2y9xx5DuQXfYLTmG5WrnYR3mnNt2VpsSs0evP62B+0RqBqI2P9AYcquTHLrne3jw45CwuAFf0MbDKN7TvuOgfl8+ZtTco8257VnIHUsQkb6xkV//AcOOThNeXpemCy0u/bjiAkhnq7rZGhvwocDiH/ApR+fdARfvfiirBkILEAISsR2gZHnOTWbLhsxlF1dCuFoh83qVwiUX0QA1FqsDynCzEgUC/IYTZWlZd9J9jYXAnH/d2POEY6qoBSoviAJmgA==;5:Uz/KeY7lWZm3rVN7OcDwU4wBs9oZBC35kxMqcZ3WowWZwI9i0caw7cG/9EmKHdpX1XWxVyMd9/ZzKRjB0FhfhItQAaEANMYryaa3nCgxN98u1M+46OI9+y66om5eToe2gqlopl8rZlDazX5cqI4ya6RgrCIFPhRyK6364i5E5l0=;7:krx5K5EvknqBMse8XNNBgtkEwXiWHURnlV5QXc5vQbvUlQFjU3nPA4ykgfZPpaIZFGNyKWMdAcMMaU8tWGU0ZcPYDvpMzRtbV+9XeY8yGpMDtW8fluygK+bk2wiv4186WFRdVUzT2ltQ4vmpxObACYZocvXShiqGPGtC1ZQevQL6BFcQNvEkX8bFwxyEP2+uTj908OmlsgiKwGRiWGtRRLCALLDUg6W6LPawcQQOPBAucajNUL2QoYDdFPvQlAcI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 19:54:07.2284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec455bf9-227c-4b2b-9d3c-08d627d7a64f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the root complex suspends it must send a PME_Turn_Off TLP.
Implement this by asserting the "turnoff" reset.

On imx7d this is functionality is part of the SRC and exposed through
the linux reset-controller subsystem. On imx6 equivalent bits are in the
IOMUXC GPR area which the imx6-pcie driver accesses directly.

This is only for imx7d right now but it's deliberately implemented as an
optional reset, ignoring the chip variant:
* Older dtbs won't have this reset so it will be ignored.
* Future chips might also expose this as a reset controller.

For example imx8m (not yet supported) has the exact same
PCIE_CTRL_APPS_TURNOFF bit in the same location.

---
Previously posted here: https://patchwork.kernel.org/cover/10565871/
Parts of that were already merged and available in linux-next so
reposting as a focused series.

This is not very complex but needs to be split because it touches
multiple trees. Merging out of order should be fine.

Some patches already carry acks for DT but somebody needs to ack the
pci/reset parts.

Leonard Crestez (4):
  reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
  dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
  ARM: dts: imx7d: Add turnoff reset
  PCI: imx: Add PME_Turn_Off support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt    |  1 +
 arch/arm/boot/dts/imx7d.dtsi                      |  5 +++--
 drivers/pci/controller/dwc/pci-imx6.c             | 15 +++++++++++++++
 drivers/reset/reset-imx7.c                        |  1 +
 include/dt-bindings/reset/imx7-reset.h            |  4 +++-
 5 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.17.1

