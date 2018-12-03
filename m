Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B79C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376F6214D9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 11:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OigM4/7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376F6214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeLCLCN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:02:13 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:18637
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeLCLCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 06:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4/zjqjA/G6oMMUNZMcYXdwW5ngAUKu1sjiOUJLnVFQ=;
 b=OigM4/7Ncn38Xq+Ok+Tt+mjJdkx4nVfkb3Mw4EZElDVUSmi4r4e+dU6vYe+ICYXGk6bnpg4iKB+dwHhFGMy8A1aGmPdcb4+YvO7d4CJflgzjrz61uQZLqmlcARV23NDM4DY3D5qb/3Q3QxDVo35QiUClyjJhEGEfdyHLlMto2ZU=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB4992.eurprd04.prod.outlook.com (20.177.49.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 11:01:29 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a%2]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:01:29 +0000
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
Thread-Index: AQHUhi2yh4+Qm28J50ixacdSn4eZIqVjwNwAgAAJqACAALvmYIABG3kAgACEALCAAbCFAIAAAq1ggACrf4CABF3uQA==
Date:   Mon, 3 Dec 2018 11:01:29 +0000
Message-ID: <VI1PR04MB4845A5AAE3692EC284147E419AAE0@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
        <20181127153356.GA112381@google.com>    <20181127090830.084fedf1@x1.home>
        <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
        <CAErSpo7By1t5X=M=x_+Fs8TeROACBnS3f5ujsi=Ewiogh=-wRg@mail.gmail.com>
        <VI1PR04MB4845D4ED02E38246E71DD1A49AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
        <20181129225606.328f7386@x1.home>
        <VI1PR04MB48458DF3A1EBB73A4E2CDCD19AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
 <20181130091929.3eae4e99@x1.home>
In-Reply-To: <20181130091929.3eae4e99@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4992;6:3gWW5JGt/9+tJk1vPpeJAE//lYeupLbLbq16gZc7xd7suUK+0R+slXPyOI+BmqxkCzTMDxtINaapHSYw4fX8Rn3K7H57hQrgkV61xDwOkHuXfc8wJLAxMJpeaGIXL+mQhDwGldkKHUYin/rsIWrcjhk/+mwMzKRCARWtKOg4B5C69eVOiOvvy2H6x1/sEkTmSSflwSxe/1lxfKblGY/xFRqfMuELy2QR8kPx5Wgy4ug7HsRxUeLzZu6RLAKIRBSv7d0+TmgMFQC2aek5GOyKRnECtNveBLxySOgayxG97VtFN5KvAmVFgieuokTQJqONOjUDaSuF/QXsK8+2uhHh1O2C1JUBdi+Xck99ETofuHBCQL2p3F7L9GoQK0aaRu6qhlVj94tU5ZK6NGMAJ+UbzTw3sdhxH0fcc/NBQqkUc0dcmvsOFo9VNvO1wGcVr9E3nFjEqkm2BQzTTtDCds8oig==;5:7XRhSoWQzwIVG032pr4rh545llj88griJXDJfGXcG5SqVbB3TnlM1X6HFeExXUjccx2LqniLIFrzrSzZqti/ViDcS/kmmJQZik7udDHYpjfG5Pkl0os6tSUyKsbffUq9UWYLCxhrkUokoUs67xqwX6F3KwyiSSuaL8WmZJIbiXk=;7:MMUibCjIuT6He7alUPQMvnnZeLnxzE7WlXqRbstPhmVtdyrGNZi6IyAdBeMwQHHtF7u4t8lZu3/+27D25XCZu9i8/btnRzxeDb9bR1MB3068MIAgqSh8d3hKe6Gw8vmZiBYkwZZ99c8f1DiLoPyijA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a7304b93-21f5-4ea9-d5ce-08d6590ead8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4992;
x-ms-traffictypediagnostic: VI1PR04MB4992:
x-microsoft-antispam-prvs: <VI1PR04MB49922F3152B58D4C4035F0509AAE0@VI1PR04MB4992.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4992;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4992;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(13464003)(486006)(7416002)(25786009)(316002)(3846002)(478600001)(26005)(55016002)(256004)(14444005)(6116002)(76176011)(7736002)(229853002)(305945005)(68736007)(99286004)(4326008)(6436002)(6246003)(86362001)(7696005)(39060400002)(105586002)(106356001)(71190400001)(14454004)(66066001)(97736004)(71200400001)(2906002)(186003)(9686003)(102836004)(6916009)(53936002)(33656002)(8676002)(81156014)(8936002)(11346002)(446003)(44832011)(81166006)(5660300001)(6506007)(54906003)(74316002)(476003)(78486014)(93886005)(55236004)(53546011)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4992;H:VI1PR04MB4845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wv0RcmCR3EJQ6jd68TsfVDnKt1rIOa+ZHkTgNjepNVgBub+wH1KWdPZklvE3OeK3mTtklm/q90edZz97iGYlDvj8pBXrqIhaighCDE2YCRgioxc1ygdbhmDKmmdi1XHtbookDZ7NjgXJ59W4t7D+vi6oSVGKlg6DMb5PbcCPnxOkwhMaybtN5JdNqL5+SgqzH6KIuX9E0KJ49toQrHiSR8+nbNqbnGL9+Xzgbt/BUlKdQ1j/4nwKeC8LlL7oCyosxOZPXCUEn7si1BqLbzN1xQvZ2k3tXsebXMrNOH8oqCvUkTLu+IfrLhH+EmvxH3aF8w4R63/SuqXR+02HOOyK7133/hkR3UXBBEaYT0wxcag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7304b93-21f5-4ea9-d5ce-08d6590ead8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:01:29.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4992
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, November 30, 2018 9:49 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Bjorn Helgaas
> <helgaas@kernel.org>; linux-pci@vger.kernel.org; Linux Kernel Mailing Lis=
t
> <linux-kernel@vger.kernel.org>; bharatb.yadav@gmail.com; David Daney
> <david.daney@cavium.com>; jglauber@cavium.com;
> mbroemme@libmpq.org; chrisrblake93@gmail.com
> Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
>=20
> On Fri, 30 Nov 2018 06:24:16 +0000
> Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
>=20
> > Hi Alex,
> >
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, November 30, 2018 11:26 AM
> > > To: Bharat Bhushan <bharat.bhushan@nxp.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>; Bjorn Helgaas
> > > <helgaas@kernel.org>; linux-pci@vger.kernel.org; Linux Kernel
> > > Mailing List <linux-kernel@vger.kernel.org>;
> > > bharatb.yadav@gmail.com; David Daney <david.daney@cavium.com>;
> > > jglauber@cavium.com; mbroemme@libmpq.org;
> chrisrblake93@gmail.com
> > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > >
> > > On Fri, 30 Nov 2018 05:29:47 +0000
> > > Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Sent: Thursday, November 29, 2018 1:46 AM
> > > > > To: Bharat Bhushan <bharat.bhushan@nxp.com>
> > > > > Cc: alex.williamson@redhat.com; Bjorn Helgaas
> > > > > <helgaas@kernel.org>;
> > > > > linux- pci@vger.kernel.org; Linux Kernel Mailing List <linux-
> > > > > kernel@vger.kernel.org>; bharatb.yadav@gmail.com; David Daney
> > > > > <david.daney@cavium.com>; jglauber@cavium.com;
> > > mbroemme@libmpq.org;
> > > > > chrisrblake93@gmail.com
> > > > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > > > >
> > > > > On Tue, Nov 27, 2018 at 10:32 PM Bharat Bhushan
> > > > > <bharat.bhushan@nxp.com> wrote:
> > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > > Sent: Tuesday, November 27, 2018 9:39 PM
> > > > > > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > Cc: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > > > > > > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > > > bharatb.yadav@gmail.com; David Daney
> > > <david.daney@cavium.com>;
> > > > > Jan
> > > > > > > Glauber <jglauber@cavium.com>; Maik Broemme
> > > > > <mbroemme@libmpq.org>;
> > > > > > > Chris Blake <chrisrblake93@gmail.com>
> > > > > > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset
> > > > > > > bus
> > > > > > >
> > > > > > > On Tue, 27 Nov 2018 09:33:56 -0600 Bjorn Helgaas
> > > > > > > <helgaas@kernel.org> wrote:
> > > > >
> > > > > > > > 4) Is there a hardware erratum for this?  If so, please
> > > > > > > > include the URL here.
> > > > > >
> > > > > > No h/w errata as of now.
> > > > >
> > > > > Does that mean (a) the HW folks agree this is a hardware problem
> > > > > but they haven't written an erratum, (b) there is an erratum but
> > > > > it isn't public, (c) we don't have any concrete evidence of a
> > > > > hardware problem, but things just don't work if we do a bus
> > > > > reset, (d) something
> > > else?
> > > >
> > > > I will say it is (c) - not concluded to be hardware h/w issue.
> > > >
> > > > >
> > > > > > In pci_reset_secondary_bus() I have tried to increase the
> > > > > > delay after reset
> > > > > but not helped.
> > > > > > Do I need to add delay at some other place as well?
> > > > >
> > > > > No, I think the place you tried should be enough.
> > > > >
> > > > > You should also be able to exercise this from user-space by
> > > > > using "setpci" to set and clear the Secondary Bus Reset bit in
> > > > > the Bridge Control register.  Then you can also use setpci to
> > > > > read/write config space of the NIC.  The kernel would normally
> > > > > read the Vendor and Device IDs as the first access to the device
> during enumeration.
> > > > > You also might be able to learn something by using "lspci -vv"
> > > > > on the bridge before and after the reset to see if it logs any
> > > > > AER bits (if it
> > > supports AER) or the other standard error logging bits.
> > > >
> > > > I tried below sequence for Secondary bus reset and device config
> > > > space show 0xff
> > > >
> > > > root@localhost:~# lspci -x
> > > > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0
> > > > (rev
> > > > 10)
> > > > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > > > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > > > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > > > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
> > > >
> > > > 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit
> > > > Network Connection
> > > > 00: 86 80 d3 10 06 04 10 00 00 00 00 02 10 00 00 00
> > > > 10: 00 00 0c 40 00 00 00 40 01 00 00 00 00 00 0e 40
> > > > 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 1f a0
> > > > 30: 00 00 24 40 c8 00 00 00 00 00 00 00 63 01 00 00
> > > >
> > > > root@localhost:~#  setpci -s 0002:00:00.0 0x3e.b=3D0x40
> > > > root@localhost:~#  setpci -s 0002:00:00.0 0x3e.b=3D0x00
> > > >
> > > > root@localhost:~# lspci -x
> > > > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0
> > > > (rev
> > > > 10)
> > > > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > > > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > > > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > > > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
> > >
> > > Just for curiosity sake, what if you re-write the secondary and
> > > subordinate bus registers here:
> > >
> > > # setpci -s 0002:00:00.0 0x19.b=3D0x01 # setpci -s 0002:00:00.0
> > > 0x1a.b=3D0xff
> >
> > Result is same, here are logs
> >
> > root@localhost:~# setpci -s 0002:00:00.0 0x3e.b=3D0x40 root@localhost:~=
#
> > setpci -s 0002:00:00.0 0x3e.b=3D0x00 root@localhost:~# setpci -s
> > 0002:00:00.0 0x19.b=3D0x01 root@localhost:~# setpci -s 0002:00:00.0
> > 0x1a.b=3D0xff root@localhost:~# lspci -x
> > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev
> > 10)
> > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
> >
> > 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit
> > Network Connection (rev ff)
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>=20
> Ok, thanks for scratching my itch.
>=20
> > > IIRC the users that debugged the AMD bus reset issue re-wrote the
> > > entire 64 bytes of the bridge config header and then further
> > > narrowed the issue down to the two registers above.  If one bridge
> > > implementation can have such an issue, maybe others do too.  Perhaps
> there's common IP in use.
> >
> > >  Are you able
> > > to test other endpoints besides this e1000e device with this setpci
> > > technique?  Thanks,
> >
> > I tried  with " Broadcom Limited NetXtreme BCM5722 Gigabit Ethernet PCI
> Express" I observe same issue.
>=20
> Personally I'd exhaust talking with your hardware folks before blocking b=
us
> resets at the software level, it seems like a gap in PCIe compliance of t=
he
> device.  Thanks,

I will continue to work with our h/w team on this.

Thanks
-Bharat

>=20
> Alex
