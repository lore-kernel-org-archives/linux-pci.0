Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C4C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 10:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CEA21019
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 10:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dx+lTyu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CEA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeK1V5l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:57:41 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:64480
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbeK1V5l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 16:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUVW+qxHBNSgqQ4zfeLfD9Bccf73pSssV/lP10M535s=;
 b=dx+lTyu5enYCiMCn5wERhJCAiKXbbDud9EV4MEkxnJyVPhsyFpbLRTjMIR24nRmcQCkr+B5J4pz9e/+rJvXO894TeB7UxcANqg6ROB4+RplVAGL07m8mbwn1xZoGxoauSZQJwsfhxPsnGFRw8+xD0N9NONILifnyPWJvi5XpdxU=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4638.eurprd04.prod.outlook.com (20.177.56.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 10:55:42 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 10:55:42 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Topic: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Index: AQHUfqElwnFd442790GkPu5+DDDqQQ==
Date:   Wed, 28 Nov 2018 10:55:42 +0000
Message-ID: <VI1PR04MB5533595EE55A724C7E69F297EED10@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
 <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
 <1543313169.2507.39.camel@pengutronix.de>
 <VI1PR04MB5533DE497786CD80D4FE0941EED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAHQ1cqEGABcH3EG9yGo7Ns2fPR1s_u1YPtFoKRjUh50=aa=J2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4638;6:KAMOsbIMTaeSAm9spgIWpTjnn2N+Kye6sXf3lgXb3bUJp6EfBwn253uu2PL0L11eA6N1cdXgpU1rw1BO+/gZEQXfrmrhFEH8FaBT86DRuvAZcTqKWjVbcFpdvmJeU76rDl5HIUz+R4/XhnhpU7z6J4VWy19C5yg8yk1ZprbDdNqau001btsduqdwxAKHeO9qJCp8L1vr/a1ZUnimvHBfSD2RgMxY0n4FUtHquyTSVHwRjXNYYVFRoD+ffQbxn3t8dz3sgnLm1bfsNwt6zs2NqcWiF49v2CyqZhtwBncAxtqOyWmOREgtKgomi5K+Y6HnyMoG95s4/vQGxqUZBGm7QPdgZHb/Gw+n4QbOMG2hqKC3ZoFrNVI8u8mobmvX4sbTcswP1JPk0AEvZzvloFjpzBv4mWXaOtSRxxugDvVQNotXv/MGs3vAHi0SrR+gjVGnf0PzxSlONVDFHMr/R4j5pQ==;5:xZKtcgsrrGPj1HpeUOzW49D1pYlP8XuFDUSgG41edyQM/vRg+lPYDW8d/IJeJpG62jU2S45KPrZNl5zRAfat/Ftm0GIIWXkjGNBFgeN8E2cRc+dh19IabAtL3jaRYSldD9Ax17gdVzJpRQuzTaaaYWTRbDfxyEXwAFEm50p7Zkc=;7:OhGPrHJKPQ4fKN1ZdH9rl3JgU0I99xyC0EENim20KvwLXB0eeVygfewdENkQOER0sNz/brt7pjOwK6teJSnsCaIWIosNM8ezXKpVDNCnphlG5sxoUnT16N9P6HCu0l1vrRks/ssbBZcSd3jZlYdUlQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0ba52a57-f117-43aa-fc82-08d655200a94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4638;
x-ms-traffictypediagnostic: VI1PR04MB4638:
x-microsoft-antispam-prvs: <VI1PR04MB46385292921CAB69D038EE5DEED10@VI1PR04MB4638.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4638;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4638;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(54094003)(53546011)(66066001)(316002)(2906002)(71190400001)(71200400001)(110136005)(6436002)(54906003)(53936002)(8676002)(68736007)(4326008)(5660300001)(7416002)(39060400002)(9686003)(93886005)(6246003)(3846002)(55016002)(229853002)(6116002)(81166006)(6506007)(476003)(102836004)(25786009)(74316002)(44832011)(81156014)(446003)(86362001)(76176011)(256004)(478600001)(5024004)(33656002)(186003)(97736004)(14454004)(99286004)(105586002)(7696005)(486006)(106356001)(305945005)(4001150100001)(26005)(8936002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4638;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5/VvHAkHRNjfxML/OGFmbOwuERz6TlDncSJI2+H/0Er0stTwGMYG3rnFb8Grwpp2RYVyZXTqvCpsw86tBBTT5KjAOqTAkW6yO9QHgFRzmJ999JBlzkl+hKuckqW5kch87atle/2r+ujX0dIh8Y1uY8fOA4FcAFQW6r+Y86yeXPCcXo5Tkhr4UKH9cg1OjV2202BvGLsupCD9Ktjoq46uCP/k/fCR0N/Z3Q6T0QLCJSMZvik1Lg+/6Mv5JGvOKBHUta5VcY7EG9OaXvPf4Ns1Ab1BF7XOP9Lo06Fw8VE4pwC0YGzZGZaXA0pyza0pIwoHPyhLfWtOaYD8Sem4li3wvFEuYnszPWCAGIXAi4rN2bU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba52a57-f117-43aa-fc82-08d655200a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 10:55:42.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4638
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/27/18 11:15 PM, Andrey Smirnov wrote:=0A=
> On Tue, Nov 27, 2018 at 2:46 AM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>> On 11/27/18 12:06 PM, Lucas Stach wrote:=0A=
>>> Am Montag, den 26.11.2018, 10:24 -0800 schrieb Andrey Smirnov:=0A=
>>>> On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.c=
om> wrote:=0A=
>>>>> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:=0A=
>>>>>> @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_dev=
ice *pdev)=0A=
>>>>>> -     case IMX7D:=0A=
>>>>>> +     case IMX8MQ:=0A=
>>>>>> +             if (of_property_read_u32(node, "fsl,iomux-gpr1x",=0A=
>>>>>> +                                      &imx6_pcie->gpr1x)) {=0A=
>>>>>> +                     dev_err(dev, "Failed to get GPR1x address\n");=
=0A=
>>>>>> +                     return -EINVAL;=0A=
>>>>>> +             }=0A=
>>>>>=0A=
>>>>> This is for distinguishing multiple controllers on the SOC but other=
=0A=
>>>>> registers and bits might differ. Isn't it preferable to have a proper=
ty=0A=
>>>>> for controller id instead of adding many registers to DT?=0A=
>>>>=0A=
>>>> I liked encoding necessary info in DT directly slightly better than=0A=
>>>> encoding abstract ID and then decoding it further in the driver code.=
=0A=
>>>> OTOH, I am not really attached to that path. Lucas, can you comment on=
=0A=
>>>> this please?=0A=
=0A=
>>> Yes, after rereading the patch with this in mind I agree that having=0A=
>>> the GPR offset on DT directly is IMO the better approach than an=0A=
>>> abstract ID.=0A=
>>=0A=
>> But it's not a single offset, for example the device_type (EP/RC) has=0A=
>> bits for the two controllers side-by-side in GPR12.=0A=
>>=0A=
> =0A=
> Playing devil's advocate for a bit:=0A=
> =0A=
> More specifically, currently the following per-controller bits need to=0A=
> be configured:=0A=
> =0A=
> - Location of the "device type" field within GPR12=0A=
> - GPR register to use to control PCIn_CLKREQ_B_OVERRIDE_EN and=0A=
> PCIn_CLKREQ_B_OVERRIDE_EN (GPR14 vs GPR16)=0A=
> - Now that Philip spoke against PCIE_CTRL_APPS_CLK_REQ being exposed=0A=
> via reset controller driver, we need to know which SRC register to use=0A=
> to control that bit (SRC_PCIEPHY_RCR vs. SRC_PCIE2_RCR)=0A=
=0A=
I looked a bit through bindings and there some instances of syscon-$BLH =0A=
properties which include detailed offsets or bitmasks for $BLAH relative =
=0A=
to the target syscon node.=0A=
=0A=
If you're going the route of adding properties points to IOMUXC/SRC bits =
=0A=
it would sense to ensure that they're also usable on other SOCs, =0A=
otherwise you're just making 8mq more complicated. But that's hard.=0A=
=0A=
But I think it's easier to deal with such SOC-specific details behind a =0A=
compat string. Maybe the DT list has some opinion on this?=0A=
=0A=
I wonder if of_alias_get_id would be a reasonable way to distinguish =0A=
between pcie0 and pcie1 instead of adding an ctrl-id property?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
