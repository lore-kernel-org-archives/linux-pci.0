Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C5C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330A8208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 10:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcXAigKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330A8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeK0VNj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:13:39 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2591
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730609AbeK0VNj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 16:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL1kos/HZkY1euCO4Up6rvTKk+n5JEv6kNYDpU6fxlM=;
 b=UcXAigKVxw+9FzSiYNcdLqBfW/q1UABY+o7k+06EmbtlhDvLoW6HYVa2FpGr7RW0N/R2xK9ODo9k7WJmoTOmmn3ciIOoguVT1J89sjUh8YnrLGdVqqm0fm2RNSwqoZ/Pu4qoTyNDqu+LIlQTCnRyWxaoPLlC9RB6ifrrTBxmJFY=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB1053.eurprd04.prod.outlook.com (10.161.109.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 27 Nov 2018 10:16:10 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 10:16:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>, Chris Healy <cphealy@gmail.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Topic: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Index: AQHUfqElwnFd442790GkPu5+DDDqQQ==
Date:   Tue, 27 Nov 2018 10:16:10 +0000
Message-ID: <VI1PR04MB553359EA5E0F88701A92A3AEEED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
 <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1053;6:n+bwwksIZxVbtDMzIXqJxMqWaIqz7LDdZDVBYdrQixFoYasrSYfdFoLIiZmehlrhitSyZlwc0f1l/ewlbxxGAO+Hjbxfj4tPKqYRuU3lN00fHnQKYQCroWdDGLNMxA2xzVZQTGp1HmtJft8TnEQ4BS2FHcPhWKp34+D8erVX0QWFG0MhfKP1xmqJZBRAUdNOz4D2DFFyRCd7SK8NmoRFKdixujMlRygQ4+sZkMwCEBi+De+qsgtYAuHZjFMDzvXqn6n/wv2FfbeZTajQDOvArDV/Xm0tuCOHuMILAwTBCBZJyKqby1rF7Z9ymL6oG1fEVL2rp3Kwjsr1ZP6W/PRVEHRml/jXZc4txsJzQ/FgwlHJltBIXO/k+cgIc9w22XwhgOzfLX3sMzjIz0Okcg6fzHV/IlFayDf4yzww/lKKJz8JZfkVBfmTvfZZLS/YLpqeaWgE7FJkXQmyROGiI5HUmw==;5:7nr3bNNeTfwvovnrR9fwrWeqqauCuD7btdDouLdjRH9S2fILPBaAlbReg7mUdZTZTgPNmUuvdMBUG5AbKT/c2SELNq1sMqTBnPWX3qJjoSO4Q+KdtNQFyDHw7mUg6gk6nGHDQn1Pu96v56ms/DwZtUT65VqWsFvt7Y7KGALN6dI=;7:9Vp5PED26nGZyOC/DA5hKgHyfTPAdZXBExWrMAjx6cIk4EBuDpt9SV33ocX+d3Zc1KK/U6yQzcIfBFnDCJNcyGz33TjpSEW/Ecp3eWJaFwJ5tmwX7V2Ki7cZ/yt5gf8bWE5aVpAS3L3NylThdmkyqQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b4067375-8572-478e-5652-08d654515a3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1053;
x-ms-traffictypediagnostic: VI1PR04MB1053:
x-microsoft-antispam-prvs: <VI1PR04MB105320A07B10BC3C0F3067CFEED00@VI1PR04MB1053.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1053;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1053;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(6436002)(305945005)(7416002)(71190400001)(256004)(102836004)(71200400001)(74316002)(26005)(9686003)(478600001)(33656002)(4326008)(14454004)(81166006)(53546011)(6506007)(76176011)(2906002)(229853002)(99286004)(7696005)(7736002)(86362001)(186003)(5660300001)(81156014)(8936002)(6636002)(97736004)(476003)(6246003)(110136005)(8676002)(93886005)(486006)(25786009)(446003)(44832011)(66066001)(4001150100001)(6116002)(316002)(55016002)(3846002)(54906003)(106356001)(105586002)(68736007)(53936002)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1053;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: naTqHQ1J6RBXoEJ1Wwq6HdHnuj7shtqVoQXYyeOzoUb6/Gmx7viRNLqgC0U20jO3aNi3R0D7nChuuPASEduH/vLZnAbL7fyZytAZnoXwj+3J6LeHzMyUHvInolqrIfUxUTHst3KdG7G6KyrpWBm8p+QbwUqctlE4OCxCQyQ5IEaa64Tg9Tw6No2yEgCqQkdnGJf2SZxEWBH8O4sLRsNUbR4be3CrVxpg/d0K8WWnPkhJID+aQv9GRkTF/C6JHoVHROxJSMp+cmiuBShPupb2+BGM+Tfyf+B/1j5jCvBkquOgUaa74r+fUuO5OsMnq86EWQdSuqjhqJprOyMZ2/M5+CU5LUYcJYn6HH3GN57MmDI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4067375-8572-478e-5652-08d654515a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 10:16:10.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1053
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/26/18 8:24 PM, Andrey Smirnov wrote:=0A=
> On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:=0A=
=0A=
>>> +             if (of_property_read_u32_array(=0A=
>>> +                         node, "fsl,gpr12-device-type",=0A=
>>> +                         imx6_pcie->device_type,=0A=
>>> +                         ARRAY_SIZE(imx6_pcie->device_type))) {=0A=
>>> +                     dev_err(dev, "Failed to get device type=0A=
>>> mask/value\n");=0A=
>>> +                     return -EINVAL;=0A=
>>> +             }=0A=
>>=0A=
>> The device type can be set on multiple SOCs, why are you adding a=0A=
>> mandatory property only for 8m?=0A=
> =0A=
> My thinking was that other SoCs don't really have two controllers, so=0A=
> they don't really need to have that property, but, more importantly,=0A=
> not forcing them to have this property should preserve backwards=0A=
> compatibility with old DTBs.=0A=
=0A=
The "device_type" registers determine Root Complex versus End Point =0A=
mode. This is not yet supported on imx in upstream but it can be done on =
=0A=
many soc versions.=0A=
=0A=
Looking at other pcie controllers (and dwc core) this is normally done =0A=
with a different compatible string with an "-ep" suffix. It feels wrong =0A=
to expose bitmasks and values directly in DT instead.=0A=
=0A=
For this patch you should probably just hardcode RC mode.=0A=
