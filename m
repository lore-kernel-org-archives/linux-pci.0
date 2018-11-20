Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7071BC04EBC
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7E120672
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pg5g2llL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeKTXcp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:32:45 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:45600
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbeKTXcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 18:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6jAin1AVf+NOwRp5Y1ALTeV3fp1M6P2jYYVrZrDO+o=;
 b=pg5g2llL8XS0FtS4DtG3a9sijJrtE8tsVw1IJ2TGpokS90lc+tAHy/N6mc5PJViAMYqnOtFhEvsEnqP95cAyacS2PRtRb/5pfQqhxrN5m8VaXiHHLXrs2McIoRZ6hoF+oeQEKgFU9+7kkkZ5TcEJD25nbfLVE/ZzEYWWEIKGKfg=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4608.eurprd04.prod.outlook.com (20.177.56.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 13:03:38 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 13:03:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Richard Zhu <hongxing.zhu@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUf+wjuvgCFMswEka/8Nnu3zUaUKVYdieAgAACJ4CAACnm0A==
Date:   Tue, 20 Nov 2018 13:03:38 +0000
Message-ID: <VI1PR04MB553386A3F452E13BFCF79688EED90@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181119094144.4127-1-stefan@agner.ch>
 <20181119094144.4127-2-stefan@agner.ch>
 <ceb95fbdf0f6d0e0eeb1db3a22743f1453c8e060.camel@nxp.com>
 <6dfdd46d76a380b900b68d13ce5bfa62@agner.ch>
In-Reply-To: <6dfdd46d76a380b900b68d13ce5bfa62@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4608;6:NSpALf77EiP2504UTjjplhJp3MZz7/iEtw5NenbTswj3fKYabhLgK9wz246+RM0sVkXuWq97ARf6woECi9aaOZKPcO7nmduYweSxozfKblogp8q6p/yCbUOot7PA/vHA/kAyBMYg4FmHBviOBxZ6jRYyGn7SxKCSfATGXQhxgG8iHvo12xkQfKcjFy5s4HdpXEbmRH7IBJlt75lkeYP3nI9iURsM/FP1ZXEfxE9jWJrVOaxC6cFy2/E8u123QNd6pzRgFCad8tk5dkrOkB+RdQ82mVg4lwezVAEOf7XXwf5bW9aAoChC1nUxFeOD+UWSxSFPzPzmjxYQmIveLx5dTIN9cX0ohRVVfZ/KD8VzvOG49J3XMNkB8TvPtU9O4ANODOv0pKJta9ESqkUqZm2Evzsl2wFFTBsaSW4B+clRf0Safcq11VC329MnjGfLfN4tLwyubVMz+W/QlANSO7QWew==;5:x2T4aLosHV3Vg9TC8m3UVOjOrEFzTjJu+RHgyFfeD/mnRpSsA3Mh2+/wLaUICyoTzWMOdaDXhQkoJqCX02EF2WGtS3GHK/7m93i0fJdmQ9EcOeINJzkRENIW4tOligBhCXaj7vEA2ivw4oQu+1rcOImLnnjnvZXP/JurBsOMG+s=;7:QwHpd+qNH1y+l53Fj/V6hTyZvgehpgQFr9GHPMRaOZ5FA6EoVAMN52FuBmXP6kSLs7e2iLpXA59k5tb5spn8bbqAyqq76D5kWLUWU6Fs4lY6lYbcYk2rSpu4ZcYcFKkEHsg/xjf7M3NBDu7j6MMVEw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1bda3aaf-217f-4ebc-78cd-08d64ee896b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4608;
x-ms-traffictypediagnostic: VI1PR04MB4608:
x-microsoft-antispam-prvs: <VI1PR04MB4608C9FC81A02B64054DD405EED90@VI1PR04MB4608.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4608;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4608;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(14454004)(33656002)(5660300001)(8676002)(11346002)(53546011)(86362001)(71190400001)(486006)(478600001)(7696005)(44832011)(76176011)(446003)(99286004)(71200400001)(8936002)(102836004)(39060400002)(186003)(26005)(81156014)(256004)(14444005)(81166006)(6506007)(229853002)(316002)(110136005)(54906003)(6636002)(2906002)(68736007)(105586002)(25786009)(9686003)(66066001)(4001150100001)(74316002)(4326008)(6116002)(6246003)(2900100001)(476003)(93886005)(53936002)(55016002)(97736004)(305945005)(6436002)(106356001)(7736002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4608;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NCeS/9nO+WNOzxEnO9zkCOoMJ7zUJN45yQYnODZOGJF3ZtZa9zl8Zudf1IBGzo0xCXhu6EGd8txId8JMUdipVMtuOvBMkXhbBop+efXs6ELygTMWNO3144Vo/E2F84xkoLqevuc3yjokmFFYLMEKG/E39btJyzaGuebwtCAWIMoIfUO2BMpUabWyf03kAWQm5Q66npoovz5im2HTRIDrvq8dP6QTLlQtuxf499lbF5yMT3gUhPmAuV6bBsHjHoFg/Ilph7uwo5ktv3OPNqdMvBhliwOln194VXADFpwyixa7QPmY02kauYfmzUI18X74+NbDgJI9j716ZYvrP2AtQLewfkhmBgjWOZ52bb4z5GU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bda3aaf-217f-4ebc-78cd-08d64ee896b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 13:03:38.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4608
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>
> On 20.11.2018 11:22, Leonard Crestez wrote:
> > On Mon, 2018-11-19 at 10:41 +0100, Stefan Agner wrote:
> >> Define the length of the DBI registers. This makes sure that
> >> the kernel does not access registers beyond that point, avoiding
> >> the following abort on a i.MX 6Quad:
> >>   # cat
> /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
> >>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at
> 0xb6ea7000
> >>   ...
> >>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
> >>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
> >>   ...
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> >
> >> +struct imx6_pcie_drvdata {
> >> +	enum imx6_pcie_variants variant;
> >> +	int			dbi_length;
> >> +};
> >
> > Turning imx6_pcie drvdata into a struct is very nice, maybe in the
> > future some of the long case statements in this driver could be split
> > into per-soc functions called via drvdata.
>=20
> Yeah I thought that too. At a quick glance I did not saw an obvious
> contender. Should certainly help for similar cases in the future.

Yes, there are other cases in which it would be useful.

But I think it makes more sense to split introducing drvdata to a separate =
patch.
It's nice to separate functional and code cleanup changes.

For example maybe dbi_length causes issues and has to be reverted?

--
Regards,
Leonard
