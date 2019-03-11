Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F287C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CF02084F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gJ8eeGrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfCKJc3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:32:29 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:48938
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfCKJc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGt2kptfSYFWIMpJrzSgidPyvIMtRAfU6GlQDpaCshM=;
 b=gJ8eeGrdyJAJyx/mCGBjC9dccsRytNaMtAbdkHqjKFl7RasCQjqcjJrL+3r8Dc/mUIPD8ifQDWDVBbf8zTF955M0tTLREu2xmOhl7iA1gyTjC8ksb3KSpAMSxb4K4yUA77p2kwkrS837ZMaTkdVWNZzRHD0U61GzfabD0aEZx6U=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6566.eurprd04.prod.outlook.com (20.179.246.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 09:32:11 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:32:11 +0000
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
Subject: [PATCHv4 17/28] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv4 17/28] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHU1+1NSbzhbwea50ueS7B7aR1vuw==
Date:   Mon, 11 Mar 2019 09:32:11 +0000
Message-ID: <20190311093130.7209-18-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3f696517-ce7a-432e-787e-08d6a604700b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6566;
x-ms-traffictypediagnostic: AM6PR04MB6566:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6566;23:9U+afKuykMiupYBandF6T1h7pl0VMCRlf7rCJBN?=
 =?iso-8859-1?Q?MS3nt1MPc8pAE49dHHBCQgQ0F9CLmjhJP7CcEyjarsfTTr2P+igKJ2UDtx?=
 =?iso-8859-1?Q?8ymn3i0O2HX5cty0hB+3UTxhKnyOHtZMEDTjKz5c7n3zCQCOEzsFIps+a0?=
 =?iso-8859-1?Q?nOGPd0ZdEbt1l4VSDQmMOu9AmEhUOhIPqmbIUPbGo+41Be+aopHuo8OXlJ?=
 =?iso-8859-1?Q?hLlv1OLAgkapv8ysTy7deBcZT7MDX/O1xLrMS3Ef27jE5V78bXQn5uISWZ?=
 =?iso-8859-1?Q?wu5n/idEdFVfZiDHuuq6dL/i5pFpqQiTN4PPh1t5tCq3bJ+PXZXLxPF9TI?=
 =?iso-8859-1?Q?YDyyD+hRZEJdkjfp7kReJ4RI3Qlrld4lMpR/lonMAr/tqbO76CqljiNyOl?=
 =?iso-8859-1?Q?zOdKGQjwGkAkn8qsccRcUEELTZEzUQf/46pd7X8/lzJoW8Svixt1FBfoPR?=
 =?iso-8859-1?Q?WsYiGsGs2neJN89FNA04ihzBhmTVxzJxTzDG5oCTlKC9czcPS96Mw9qqhy?=
 =?iso-8859-1?Q?ncCOLlau1fvrUPmqMV+daq3kXw4DOkqCNKn2xRPY3FixGjT3U7oAd17eaq?=
 =?iso-8859-1?Q?Gbl9UPfaVycwwTbhFVWRIHKqDP8Fzy83TBMJuSPvE+ZjHy1ahTOzKePNCt?=
 =?iso-8859-1?Q?EhnuQdmQSSpwii0JLcPz+IDFp9HWAHH5BsYZo1GlzzYa5Ko+Zi2n4Cgz6H?=
 =?iso-8859-1?Q?LiAcU9g3nzMeJ6P/URKupoCLt4vTHL+kKIbD0S08zmxAzfensLT7w4+BfA?=
 =?iso-8859-1?Q?VP5lWOfo+SatfNEZdaxDWUc2JdJZoztD+D0pZN/IbX2s8OMfjnHP39P8zJ?=
 =?iso-8859-1?Q?puHdsjvQLuMX8F5vUhd/GYTzVQ8tvXRdBeDB9bLfNxRor7t7PZL9fCLK2v?=
 =?iso-8859-1?Q?Tq/bOwE05LS/2TJXCW5+HTqRqb9E0fi2KQsSPS4ElCDEqTJke2yaqaATl8?=
 =?iso-8859-1?Q?vDhUIlva+t0ojBwxsj3y96+m6nxW23zLGAn3aM4XenTij7MUM81r1zyM/V?=
 =?iso-8859-1?Q?ezTet7nMBE3jEBTGvYPQT0pc+ADwETgI7YXW9gQ5r5qI+hbXaAWeKwCx61?=
 =?iso-8859-1?Q?44qe3eL2KfhP80e6CqR82uheP1BE5T50Jqqi5jWxlppI2hphfuT4KGfE59?=
 =?iso-8859-1?Q?TT7d7L+ZPxNOqyNgzEQif3ax6881bfi3k6HcpaS4QhLb/UiNiLjmPMTKf4?=
 =?iso-8859-1?Q?DLLC6TavjiwjouqihovPaBs+0OazQeOcqXDfO57QDw//FrUtNu4VDjbwBA?=
 =?iso-8859-1?Q?JdwFEdxdk2EIKXi9cejrUbaTKuV0KwKuxFZRURw+i6+ntZy5ooCbHL+Pbt?=
 =?iso-8859-1?Q?ZlCzxGLsusLoDasxBoH7hyOwbOfp3rCGwQdW8+w/W0O+NGNltfKJQiBk3A?=
 =?iso-8859-1?Q?Zr3B+oLD39FuLVWnx8BfRnf8xgeYd?=
x-microsoft-antispam-prvs: <AM6PR04MB65665C56E7862666EB35B75284480@AM6PR04MB6566.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6436002)(478600001)(25786009)(99286004)(11346002)(2616005)(476003)(76176011)(3846002)(6116002)(81166006)(81156014)(486006)(71190400001)(71200400001)(2906002)(8676002)(2201001)(5660300002)(97736004)(6486002)(446003)(7416002)(2501003)(86362001)(5024004)(14444005)(256004)(14454004)(316002)(68736007)(26005)(8936002)(6512007)(53936002)(1076003)(66066001)(386003)(54906003)(50226002)(110136005)(102836004)(6506007)(36756003)(105586002)(4326008)(106356001)(186003)(305945005)(52116002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6566;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /mnwCYsHzTMw8NxRjkFUaQgpCyUtybhTXHm8aSiIjXrsZrw4xzhg2pe64sjrPWvSfsoz7cVXYPzK4bh/oS1RbDFhLVOglkm7hhYUpr6pjrjMpap5WmVgBkKU8MtIqzyEVbD+9to3o2y3rQtkBRXPsPzhn7dHv9YHUg2fnjEVoLyEYJwQrbs0edHnpEsPR5upqUxZ0ZWV3C+JNH9IGNq2KTmWQRJM7GW1dRzPj2augk7NVZSyyuBL7kB4mfaIRoNBxDPwFWuMWYVKFsinLkwhOReflc46F5EqPQTGAzwyGkLt9we4VtsSlRsDTjGFj/PuM/bg+gSzVRYlrXiDphTBFuYAqh+kn60agU6UvlGGtkiY3OfQcZIi8HStg88QNMdnkMhM+LqY9xSFmeHJ1C29FOJZydE14g0TYhOsLLCA/Zs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f696517-ce7a-432e-787e-08d6a604700b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:32:11.4167
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

Allow CFG transactions to all functions of Endpoint implemented
multiple functions.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V4:
 - Split the link up check to the 18th patch

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index dc5324d94466..74a14f05115e 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -37,7 +37,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bu=
s, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
+	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
=20
 	return true;
--=20
2.17.1

