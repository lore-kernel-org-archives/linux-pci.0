Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D87C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA01B20873
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 10:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQ3LlsLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA01B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeK0VoS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:44:18 -0500
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:47265
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbeK0VoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 16:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az4nQojau9wLvbhqKgAAU9auin0M1PCiCmB42kiZR9U=;
 b=GQ3LlsLW1SXsMT2cPh6oNMb1g66rWHkywmwRMfXse1N28Dd8dlY5boecC9c6+EfLdN0WHaaun5f1ccYn20qgj97mMG7GvjG/tcC4YOvI0H6kVg3HLgdtLsSxMbebWTgR8llSqVey0Xx03GPRXpjgtQGVfiWj9jZf1jMbdO4MpPI=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5838.eurprd04.prod.outlook.com (20.178.204.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 10:46:44 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 10:46:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Topic: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Index: AQHUfqElwnFd442790GkPu5+DDDqQQ==
Date:   Tue, 27 Nov 2018 10:46:44 +0000
Message-ID: <VI1PR04MB5533DE497786CD80D4FE0941EED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
 <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
 <1543313169.2507.39.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5838;6:/Satb7cTHjxVAfJsmZHwSOG8tgUBsyDXY5HdNKubRPCtMu0Kywo6ei4EpTV8oAgvb8LwcONXMne+YHnEemwDqfXHnBFQ9xhVe83RQVup2jPk36xnH4xdbxcAjfPEBnFwryDBh9HWJ30hoydoQtzEvYVk1nPkAkahUh1S/YBbi1aDNO4n4vO9AIhjdvizJcftORSyFyO3uBOjeTGekzouDq1DraO+y3EVJMGAM6ccdquwMxgg5WJS80c67Hf83/XUQAalY17848CnG7ZcSDff/z7ken1RLVG+/CApZPtc61DssjlD8AmQ7TpChnu6KehqCOclFcvkuf1e/xdVWo928g9rj3GPe+yKtNcmugkmkqk0KkJWEJnltkcynLaiOMPLIr9zxLSoxH3Qi/QhCG440XVPZCyBdwUyEsU18faNuOFgEoBkhYRsIaG8j7f+rSGK792T+/Ifni2DhgYoZWcykg==;5:plFmWrzFBsjLuGqnzGEzDG8dMPiwrx6rC+B+5xut08FWnH50SHePnQq5ozBS01l4fNDpBxbrYwR6YmS4OHdEteDqGrqZ4g+XZIMB/OsWICN9IqcLdvJb3gkMxwf+zjdIDgCPR9X4Pd+3lI4v6ITzcZ1ZI8RY9Lk9deE7uPsmo50=;7:3rNFK7mD3sBo207y36+qvswQTXcsQaPkrtYTDhYu8IEl60+Xjvc6czz7KPUs9PD5DTMWqUUDUMYsa1UYWmSS4nbF9LeGs3MNH1Bo4Ugo6GrKTVIKzH5YY210s0wax/BsBlrbqa0inroSNtL74h1h5Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f6fdcada-b919-45f9-abf2-08d654559f70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5838;
x-ms-traffictypediagnostic: VI1PR04MB5838:
x-microsoft-antispam-prvs: <VI1PR04MB58384658FB9429DA549BB1DBEED00@VI1PR04MB5838.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5838;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5838;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(6436002)(55016002)(486006)(186003)(5660300001)(4326008)(6246003)(26005)(39060400002)(446003)(66066001)(9686003)(53936002)(7696005)(99286004)(44832011)(316002)(68736007)(478600001)(6506007)(71200400001)(71190400001)(102836004)(76176011)(53546011)(476003)(25786009)(110136005)(54906003)(5024004)(7416002)(256004)(14454004)(6116002)(4001150100001)(93886005)(305945005)(86362001)(97736004)(7736002)(3846002)(33656002)(106356001)(105586002)(81166006)(8676002)(81156014)(8936002)(229853002)(2906002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5838;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 80+JfbvDmd1g/jUt1P67RrtBIqY5FOH99baTGq/0jpq1AJ+48zf4aH7SwlmM/rTsQnZM2Jm44g9gUphhyJXJCF9cWuq5x3DTiXEpOhKo0yphC8hSrWlPJYnlN+Ow8uh3s04Qn8HXeiPJmKa8xid+AeNWfQTEU0GyfWxfFiy6AQXJom/c6EMT4sUZJJiMRJmX6FMAu113lF8QwsE1jXm7yRRfu7GhmbZu8ykoPrHUibDB/NgZYiCH18Nn6w6/FhZl/0FB9Pg2epVcfu6UAD/7WPMLMtoQ2dFaAk7Hiq+OiANQwtg2ZR8Fum4G7zv915CxUJK3lf5okN+mzBapFEyfqM9b4cblkE1OZCjPOaEs4FM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fdcada-b919-45f9-abf2-08d654559f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 10:46:44.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5838
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/27/18 12:06 PM, Lucas Stach wrote:=0A=
> Hi Andrey,=0A=
> =0A=
> Am Montag, den 26.11.2018, 10:24 -0800 schrieb Andrey Smirnov:=0A=
>> On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com=
> wrote:=0A=
>>>=0A=
>>> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:=0A=
>>>> @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_devic=
e *pdev)=0A=
>>>> -=A0=A0=A0=A0=A0case IMX7D:=0A=
>>>> +=A0=A0=A0=A0=A0case IMX8MQ:=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (of_property_read_u32(node,=
 "fsl,iomux-gpr1x",=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&imx6_pcie->gpr1x)) {=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_er=
r(dev, "Failed to get GPR1x address\n");=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return=
 -EINVAL;=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}=0A=
>>>=0A=
>>> This is for distinguishing multiple controllers on the SOC but other=0A=
>>> registers and bits might differ. Isn't it preferable to have a property=
=0A=
>>> for controller id instead of adding many registers to DT?=0A=
>>=0A=
>> I liked encoding necessary info in DT directly slightly better than=0A=
>> encoding abstract ID and then decoding it further in the driver code.=0A=
>> OTOH, I am not really attached to that path. Lucas, can you comment on=
=0A=
>> this please?=0A=
> =0A=
> Yes, after rereading the patch with this in mind I agree that having=0A=
> the GPR offset on DT directly is IMO the better approach than an=0A=
> abstract ID.=0A=
=0A=
But it's not a single offset, for example the device_type (EP/RC) has =0A=
bits for the two controllers side-by-side in GPR12.=0A=
=0A=
Adding a "ctrl-id" property would fully describe the hardware from the =0A=
start. If we add per-register information instead then when other =0A=
registers are used we'll get DT compatibility headaches.=0A=
=0A=
It's worth noting that 8qm/8qxp also have multiple controllers with a =0A=
different set of bits placed differently in iomuxc.=0A=
