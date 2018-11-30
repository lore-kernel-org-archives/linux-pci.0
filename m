Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CAC04EB8
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 06:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02202081C
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 06:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hcaL8ZBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02202081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeK3Rda (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:33:30 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:33214
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeK3Rda (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 12:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bftpL/X1ZgcDq0OOSEZEGYR7uOafftmNDbMwKT+6YPA=;
 b=hcaL8ZBLFSZ0Jz2s3Vz4AsseMMCNEqQHFxYDFD1Xy6xq/bnEcsHsqcnHg2XgfCmmaB8O0WvPmcdcGvFtXZAVI8vW/xlxBrnzURNJkw4i8a0O0bTr4HjEdPeW86LyoLmXlEOJUWQSPTJ4ii3NBhLovxoe3Euk26O4lcKOoGkwgJY=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB3120.eurprd04.prod.outlook.com (10.170.229.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 06:24:16 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a%2]) with mapi id 15.20.1339.032; Fri, 30 Nov 2018
 06:24:16 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        David Daney <david.daney@cavium.com>,
        "jglauber@cavium.com" <jglauber@cavium.com>,
        "mbroemme@libmpq.org" <mbroemme@libmpq.org>,
        "chrisrblake93@gmail.com" <chrisrblake93@gmail.com>
Subject: RE: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Topic: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Index: AQHUhi2yh4+Qm28J50ixacdSn4eZIqVjwNwAgAAJqACAALvmYIABG3kAgACEALCAAbCFAIAAAq1g
Date:   Fri, 30 Nov 2018 06:24:16 +0000
Message-ID: <VI1PR04MB48458DF3A1EBB73A4E2CDCD19AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
        <20181127153356.GA112381@google.com>    <20181127090830.084fedf1@x1.home>
        <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
        <CAErSpo7By1t5X=M=x_+Fs8TeROACBnS3f5ujsi=Ewiogh=-wRg@mail.gmail.com>
        <VI1PR04MB4845D4ED02E38246E71DD1A49AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
 <20181129225606.328f7386@x1.home>
In-Reply-To: <20181129225606.328f7386@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3120;6:YPtPcjjiiyfixJ63XHrwQKaX8Xz/Z++bLyNhg5guRw2fzVxigF7Vouyclzc4hdG5xRlmoo9y1ayMHXr9RsDVjh2J82XN8lT/Lg4eghUndfk1FmGE4lrs7INEkKbFqgubj0WIIkrOUC9BoO5gWSORkr9jI/cIlneD0FApQFCn3TzsMh2dTOpFVXrOK4sAGoREWTJXy5H5Njj3tNI2SDTIlluIb60c2Z492ycvhg81ZkAb0qyUqoNOVpJg3Ea9sXswx2BZQjGk7HwHRut6lIjfUD1A7eqaFQODxI04+xmeOpb/42jZwnAsgvgD12zEd4oXoq1qvGFqiujPiweEnnw0vCtBAEs4O/OKWYQN0KqOOjSf+dOzve9BzIBN0aXT5IRmBBBK9qjjgwkw8OPQey3DoOfZ3Mw7qKlAEBpbO6G9TtXQ5OIsnttuouHsuhrQK6pAK9B7BOjtArOzJsy3Y8OfhA==;5:NW6GyBAyh0iH15n5etxkFXPwXNAMWiUJgLzxozbOP4ObUGd11+DwZZm16OT/3nlgjVFIDmX5gHbK+aQeliuYTR9aWSB1sVwaXt5XIipnVJqTp6z0e/qSLow1+GXrma4THkGOw17KVo7/8MD85shoPz6Px5/fZ12CE3gu0AGwen0=;7:v1JXv/AlA+HdbHA6LbT2GydLaVr9AuwTtCn8/xTHlSp2OWue9WEkaFBUEMpYQNcvoQRelq9Uot0S7eS4vbXKFTtmBsVSVpCJiyg8rCGy2bF0doEEtLEodAy1IhJHQPflxFtlncfgFNMnfynevye7QA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02a14762-c6ae-463f-5665-08d6568c7422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3120;
x-ms-traffictypediagnostic: VI1PR04MB3120:
x-microsoft-antispam-prvs: <VI1PR04MB312016F1A4C9F2524A1258AD9AD30@VI1PR04MB3120.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501462)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3120;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3120;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(376002)(396003)(189003)(199004)(13464003)(14454004)(26005)(7696005)(76176011)(316002)(99286004)(186003)(102836004)(53546011)(6506007)(55236004)(93886005)(81156014)(74316002)(8676002)(81166006)(6116002)(54906003)(8936002)(2906002)(6916009)(86362001)(305945005)(97736004)(71190400001)(78486014)(3846002)(5660300001)(7416002)(6246003)(105586002)(33656002)(486006)(4326008)(476003)(44832011)(66066001)(71200400001)(106356001)(25786009)(478600001)(39060400002)(9686003)(229853002)(53936002)(11346002)(7736002)(6436002)(14444005)(55016002)(256004)(68736007)(446003)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3120;H:VI1PR04MB4845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +y3MFcsnbNI1YxSPWm0r/bycIIIcYs0t4FbqrmCuMEtaTWdp2ziY4LuWYTTFRoNGu38oPkR9LNqFB6ZKLPfgdZhScoLbG6vkiLP+LgDIXaTifu8P+s6sdkSHIWAci+RkugBqDXrV8py0jzKoMV/jkicxZkOv+yf4nfjX7yd3hHLW6stAksczXsGTkZZ/BesQdiP8QbLTRjfcOGKcN0odWdYGy/JYJvwvOHy2WeUZhiVdR+a4EwUL/o39iWRvjyUai+nBnRoGKLezwfi/LnRTkX9tFKaTAZZbyvQ9ut/6kr583yPTNH7JJpKu/Y3dgd59WrqbbO3XJkUXVzhu4Gz4p7iLPEaUikayuXwQ1OK61ho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a14762-c6ae-463f-5665-08d6568c7422
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 06:24:16.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3120
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, November 30, 2018 11:26 AM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Bjorn Helgaas
> <helgaas@kernel.org>; linux-pci@vger.kernel.org; Linux Kernel Mailing Lis=
t
> <linux-kernel@vger.kernel.org>; bharatb.yadav@gmail.com; David Daney
> <david.daney@cavium.com>; jglauber@cavium.com;
> mbroemme@libmpq.org; chrisrblake93@gmail.com
> Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
>=20
> On Fri, 30 Nov 2018 05:29:47 +0000
> Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
>=20
> > Hi,
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > Sent: Thursday, November 29, 2018 1:46 AM
> > > To: Bharat Bhushan <bharat.bhushan@nxp.com>
> > > Cc: alex.williamson@redhat.com; Bjorn Helgaas <helgaas@kernel.org>;
> > > linux- pci@vger.kernel.org; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; bharatb.yadav@gmail.com; David Daney
> > > <david.daney@cavium.com>; jglauber@cavium.com;
> mbroemme@libmpq.org;
> > > chrisrblake93@gmail.com
> > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > >
> > > On Tue, Nov 27, 2018 at 10:32 PM Bharat Bhushan
> > > <bharat.bhushan@nxp.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Tuesday, November 27, 2018 9:39 PM
> > > > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Cc: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > > > > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > bharatb.yadav@gmail.com; David Daney
> <david.daney@cavium.com>;
> > > Jan
> > > > > Glauber <jglauber@cavium.com>; Maik Broemme
> > > <mbroemme@libmpq.org>;
> > > > > Chris Blake <chrisrblake93@gmail.com>
> > > > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > > > >
> > > > > On Tue, 27 Nov 2018 09:33:56 -0600 Bjorn Helgaas
> > > > > <helgaas@kernel.org> wrote:
> > >
> > > > > > 4) Is there a hardware erratum for this?  If so, please
> > > > > > include the URL here.
> > > >
> > > > No h/w errata as of now.
> > >
> > > Does that mean (a) the HW folks agree this is a hardware problem but
> > > they haven't written an erratum, (b) there is an erratum but it
> > > isn't public, (c) we don't have any concrete evidence of a hardware
> > > problem, but things just don't work if we do a bus reset, (d) somethi=
ng
> else?
> >
> > I will say it is (c) - not concluded to be hardware h/w issue.
> >
> > >
> > > > In pci_reset_secondary_bus() I have tried to increase the delay
> > > > after reset
> > > but not helped.
> > > > Do I need to add delay at some other place as well?
> > >
> > > No, I think the place you tried should be enough.
> > >
> > > You should also be able to exercise this from user-space by using
> > > "setpci" to set and clear the Secondary Bus Reset bit in the Bridge
> > > Control register.  Then you can also use setpci to read/write config
> > > space of the NIC.  The kernel would normally read the Vendor and
> > > Device IDs as the first access to the device during enumeration.
> > > You also might be able to learn something by using "lspci -vv" on
> > > the bridge before and after the reset to see if it logs any AER bits =
(if it
> supports AER) or the other standard error logging bits.
> >
> > I tried below sequence for Secondary bus reset and device config space
> > show 0xff
> >
> > root@localhost:~# lspci -x
> > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev
> > 10)
> > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
> >
> > 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit
> > Network Connection
> > 00: 86 80 d3 10 06 04 10 00 00 00 00 02 10 00 00 00
> > 10: 00 00 0c 40 00 00 00 40 01 00 00 00 00 00 0e 40
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 1f a0
> > 30: 00 00 24 40 c8 00 00 00 00 00 00 00 63 01 00 00
> >
> > root@localhost:~#  setpci -s 0002:00:00.0 0x3e.b=3D0x40
> > root@localhost:~#  setpci -s 0002:00:00.0 0x3e.b=3D0x00
> >
> > root@localhost:~# lspci -x
> > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev
> > 10)
> > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
>=20
> Just for curiosity sake, what if you re-write the secondary and subordina=
te
> bus registers here:
>=20
> # setpci -s 0002:00:00.0 0x19.b=3D0x01
> # setpci -s 0002:00:00.0 0x1a.b=3D0xff

Result is same, here are logs

root@localhost:~# setpci -s 0002:00:00.0 0x3e.b=3D0x40
root@localhost:~# setpci -s 0002:00:00.0 0x3e.b=3D0x00
root@localhost:~# setpci -s 0002:00:00.0 0x19.b=3D0x01
root@localhost:~# setpci -s 0002:00:00.0 0x1a.b=3D0xff
root@localhost:~# lspci -x
0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev 10)
00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00

0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network =
Connection (rev ff)
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


>=20
> IIRC the users that debugged the AMD bus reset issue re-wrote the entire =
64
> bytes of the bridge config header and then further narrowed the issue dow=
n
> to the two registers above.  If one bridge implementation can have such a=
n
> issue, maybe others do too.  Perhaps there's common IP in use.

>  Are you able
> to test other endpoints besides this e1000e device with this setpci
> technique?  Thanks,

I tried  with " Broadcom Limited NetXtreme BCM5722 Gigabit Ethernet PCI Exp=
ress" I observe same issue.

Thanks
-Bharat

>=20
> Alex
>=20
> > 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit
> > Network Connection (rev ff)
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >
> > Thanks
> > -Bharat
> >
> >

