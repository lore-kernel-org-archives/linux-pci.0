Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF0C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 18:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8462133F
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 18:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JmVTSylA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLRSJI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:09:08 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:60355
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726868AbeLRSJI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 13:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ7A6sVRf5V3xWRtCRJhgeWSwN/O17oyjx7as3K64VY=;
 b=JmVTSylAC/25Pky1TF7BclFaLD5eeQglwRJjfOJMFh9Zd/Pbk2VhhYdqZgvZzxq+bJ8xltBm4fFELy35mGg5znSFaWlK8fJn17vvGi1pZt3E3l0PvKBybmOCk2IhLhHD4fRxEvaMXuTkP/pZdAG6Qjq9rgJzbE0bugPf/KFpSfA=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4686.eurprd04.prod.outlook.com (20.177.56.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 18:09:02 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 18:09:02 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Topic: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Index: AQHUlocxSxlVauzxZ0epY0uSJZc9vQ==
Date:   Tue, 18 Dec 2018 18:09:02 +0000
Message-ID: <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <20181218151533.GA2922@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4686;6:gcFZRIqSkZ11JEqO+kA8PfqCY/kr9Ce0sMuBdl+OnpjdvU+qoIMsZedqrXAsfsxrD3OAKCWXTa3JWyzMkWvv7jaowkhVco0H1Ko+JyYtxK8y2M4HmdPUhjq3LXbx+NDb3+G93PwhZcJm9n3UDbRdd5yLxyTl9aqEk+D4JuofPor2y2syKopC8kaBynluIZcg8U5isuMxzn5cHGTe+UDuOeUGTnWKVBu9HdPXfwfsFgBJAWHZ+dWGF71yFjgUdodcgqyUf6KvAYzLi2ZIJZypOEYWKEYFDNlido8kqLNT2pTG50vJQBz8PWNJGCcg+PFRcWK+JUgAVhfimdiHf7OEKCvfetmHSI6z1+rdRy+BeFmmxbG+FKUP+azrbGyebldofLjC2wQEn18L4IXw34Qm8SxkkSYb8gVxnC5YtOMWCNnkCc7KTzpKALLdpW54IowCjgI3iXUojqAou+9g9pMvLw==;5:TQXiX+DBd3Nlxi7eg0MsAYqS1mbsKXkpOo0kjpF4h+Iokj7ShB80EdFaYRfQymqAiZpm6Lg5QQKqOIn4iXV70I2mrOtjvCE09dKyHcwaakk5Jqs63fyDi4wjDX793PQ9Rpuks77+e6l8yEasg/+H+Fv2RtFf8Bs7Dajb3rkvUbs=;7:aAw38CeQhVEQFp0R0LM2cOVPLqzw+quVGSj2Im49aKsqENGSAFZrIvu2TZIuDPlFpUVZtHD1dbNH5Cs89Qvb7mf2Yc2XSqFDZR9XMx07arU6f88LExWp1qEzj8dJyt7M+YSpfJ/S4hqFTv8HY7LlKw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d0803fa-eb7b-494c-c351-08d66513e409
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4686;
x-ms-traffictypediagnostic: VI1PR04MB4686:
x-microsoft-antispam-prvs: <VI1PR04MB4686946FAC8AA284B172B1AAEEBD0@VI1PR04MB4686.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4686;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4686;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(316002)(110136005)(6116002)(54906003)(3846002)(55016002)(486006)(7696005)(2906002)(6306002)(9686003)(229853002)(106356001)(476003)(26005)(6506007)(186003)(53546011)(76176011)(102836004)(25786009)(44832011)(105586002)(86362001)(7416002)(14454004)(97736004)(5660300001)(68736007)(6436002)(7736002)(305945005)(66066001)(33656002)(8936002)(71190400001)(71200400001)(8676002)(81156014)(81166006)(446003)(4326008)(39060400002)(256004)(99286004)(74316002)(966005)(6246003)(53936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4686;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aSatyeHanByzzohmYyFfPLXufwxqNaOig2MPZLlzTmpvsGYkCTMbQbqZNUXtt+KnroNCVMqJQUt7bF3kxNA+3UrxJwKC8oITTeT/1t1au1H5owvFs805khyRlkh0r+K6h3qiUJxOrclE9WaviS8H45wOsFdt5GH6bdI538CSWWkbCcZwOlf2rfhnIxfFrYtBdG6coTxzv+m+0jF02KuS05yaSLh4vk8lH6HJJSDg8/mWfSbeorXl5wYQBwkOdjeiIw6fazCCSL3bK3sumfpEyX73pC3udqtOBgpdRy/HfVzCm34zPwb1r3xTkscdFHgf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0803fa-eb7b-494c-c351-08d66513e409
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 18:09:02.3032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4686
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/18/2018 5:15 PM, Rob Herring wrote:=0A=
> On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:=0A=
>> Add code needed to support i.MX8MQ variant.=0A=
>>=0A=
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>=0A=
>> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>=0A=
=0A=
>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt=0A=
>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt=0A=
>>   =0A=
>> +Additional required properties for imx8mq-pcie:=0A=
>> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0,=
 PCIE2 is 1;=0A=
>> +=0A=
> =0A=
> Remove this.=0A=
> =0A=
> If GPR register offset is what you need, then put that into DT.=0A=
> Typically, we'd have a property with iomuxc phandle and offset.=0A=
=0A=
This series initially added explicit offsets but I suggested a single =0A=
"controller-id" because:=0A=
  * There are multiple bit and byte offsets=0A=
  * Other imx8 SOCs also have 2x pcie with other bit/byte offsets=0A=
=0A=
Hiding this behind a compatible string and single "controller-id" seem =0A=
preferable to elaborating register maps in dt bindings. It also makes =0A=
upgrades simpler: if features are added which use other bits there is no =
=0A=
need to describe them in DT and deal with compatibility headaches.=0A=
=0A=
Link to older thread: https://lkml.org/lkml/2018/11/29/888=0A=
=0A=
It's possible my suggestion was misguided.=0A=
