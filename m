Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1DC4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B720870
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eMoGyeNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2B720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeKUEtl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:49:41 -0500
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:4105
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeKUEtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 23:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXOX/Zj3vCYqHlWkeNoZXMRW7dCDq4Ke11pQVff7fLs=;
 b=eMoGyeNEAf7KZh7vXatVKA+28pcl8NBdbtDnmGcrmrH9Gm5dDtJPwHAiMb+R2gSm0n50cZ+rlRWUfkjwhgZAbRx/u2fh3naBQT5QO0kLNny2+g+qUGEooz/G/KFmBWoTNKNQG/8UPRBOZ0AV6nX2sDOMQf1o9e/gD8rnwEoaG7U=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5406.eurprd04.prod.outlook.com (20.178.121.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 20 Nov 2018 18:19:09 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 18:19:09 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUgPIBCDcLlZpcCkW2XhKPKNSgDqVY+ScA
Date:   Tue, 20 Nov 2018 18:19:08 +0000
Message-ID: <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
References: <20181120165626.26424-1-stefan@agner.ch>
         <20181120165626.26424-2-stefan@agner.ch>
In-Reply-To: <20181120165626.26424-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5406;6:XqHrF4HSL2p9EN/m0iwk4UEePNIqJJQVI9AFTcgbO2Oymc/0R9DEiIixK8gczIwpn9Khe+2EUqxAUS0vRUMSDoHLS+uVk1NihuX3e0Ygut/fiDiZn/hgHaikE7SWikhx7I7xG7JHjM0tsm3XSUDzIdGKNH58qg5sBKnvQDYY0ai1R3/cvwLFT9gYd2dDj3q+ocvP8/Ftq9dLWOWT1c+r79eeM+J41yB0jh4tsO/GvnCrDTTlk4EjruFRYFZwHHeoZjeBLxEalPTbhOJPJsPi9jD2v/3gxiliZVROyNiOHV55jE6YcChQGsRQSwMmP+Gu6yT1GoIvMhjtIUvHcvijWoXT+Ou3mkpcUdWQmLi5AFHTrTyz5tAD5hPMWLpYpm/nzeE43PSrEJ2SSyKehfhiyh8PsRKBhrwEk4BDS3oDCKcg1EwgF6D0uw+841lCOabc5/Pz700mg8Wsy0QEz7qEmA==;5:DuLUsJ7NUno+4Ezs2US836tWyy7021QU7ZTZQQBZUXwMqPhOUDqMeZlZmkC6yWfJa2epDsTOiTKdT1E+CJ7thDyBvFZCTSHoKEDtbWPDvuL6Z0z+0OKkelGmSz6fKhGd0Xf3HATDfd3BGAaJhM4EOhcdh8h27Opiv0LXAWFKAZg=;7:BfvTM3DE53W2rQpF9N024wbZGoS8PXmINxy+ns+406+jKJTJ2Eu++N4ynWrQPUzFg2dJhibYG3nAkf1cA1VVMgCIDXqzS2hay/RYjnreYY1rHT40zH4gHnjezN4jHD6XGBVob4gxdEeKYnThAnEYBA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9bf6d234-e012-4f05-34be-08d64f14aa25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5406;
x-ms-traffictypediagnostic: VI1PR04MB5406:
x-microsoft-antispam-prvs: <VI1PR04MB5406F14D5619131FE212034CEED90@VI1PR04MB5406.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5406;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5406;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(81166006)(8936002)(39060400002)(81156014)(7736002)(50226002)(5660300001)(7416002)(25786009)(305945005)(105586002)(54906003)(110136005)(316002)(106356001)(4326008)(6116002)(3846002)(118296001)(2900100001)(2906002)(478600001)(66066001)(68736007)(14454004)(11346002)(446003)(6512007)(4001150100001)(53936002)(36756003)(229853002)(476003)(2616005)(44832011)(486006)(26005)(76176011)(71200400001)(2201001)(6506007)(102836004)(71190400001)(6436002)(6486002)(86362001)(97736004)(186003)(99286004)(256004)(8676002)(2501003)(14444005)(6246003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5406;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KT7hmR62/GGxOJpN+Ml7MGRSChITymq9mRumExhW0wK0pXtoJ47uvl4vJD336UhwVOhq0DQZqJtZppR5Fx9lL7MUAKQK1nTN3pQ3MmLdQxgijG7R+Vx7IAQZ2SKhKweMcDOZE1EYW0QI405kfmqid6lQX2gnpQosW44SUDhWTfGkOPcz31g2EE44NRlSY3SJgbdj6N1pBec3TkbyahGsphpzwRh2zYI6gwvDzRzi+DB0xtrSo1waOZQsdyq/nLh7GV+xUfj/IT0GgyNInr3vB3jHJLWXz5gMRk4lDtOzDSTPUt/HeHr8oP/YOx0ox4YEHUljcTXwJyWMM6L8Ce7ak7HG71f7uqEFfgrHkxk6ncc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <63A134C98C9FC547AD51F71DB73E8294@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf6d234-e012-4f05-34be-08d64f14aa25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 18:19:09.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5406
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTIwIGF0IDE3OjU2ICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzLiBUaGlzIG1ha2VzIHN1cmUg
dGhhdA0KPiB0aGUga2VybmVsIGRvZXMgbm90IGFjY2VzcyByZWdpc3RlcnMgYmV5b25kIHRoYXQg
cG9pbnQsIGF2b2lkaW5nDQo+IHRoZSBmb2xsb3dpbmcgYWJvcnQgb24gYSBpLk1YIDZRdWFkOg0K
PiAgICMgY2F0DQo+IC9zeXMvZGV2aWNlcy9zb2MwL3NvYy8xZmZjMDAwLnBjaWUvcGNpMDAwMFw6
MDAvMDAwMFw6MDBcOjAwLjAvY29uZmlnDQo+ICAgWyAgMTAwLjAyMTQzM10gVW5oYW5kbGVkIGZh
dWx0OiBpbXByZWNpc2UgZXh0ZXJuYWwgYWJvcnQgKDB4MTQwNikNCj4gYXQgMHhiNmVhNzAwMA0K
PiAgIC4uLg0KPiAgIFsgIDEwMC4wNTY0MjNdIFBDIGlzIGF0IGR3X3BjaWVfcmVhZCsweDUwLzB4
ODQNCj4gICBbICAxMDAuMDYwNzkwXSBMUiBpcyBhdCBkd19wY2llX3JkX293bl9jb25mKzB4NDQv
MHg0OA0KDQpJIGRvbid0IGtub3cgZXhhY3RseSB3aGVyZSB0aGlzIGxpbWl0YXRpb24gY29tZXMg
ZnJvbSwgSSBjYW4gaW5kZWVkDQpyZXByb2R1Y2UgYSBzdGFjayBkdW1wIHdoZW4gZHVtcGluZyBw
Y2kgY29uZmlnIGZyb20gL3N5cy8NCg0KVW5mb3J0dW5hdGVseSB0aGlzIHNlZW1zIHRvIGJsb2Nr
IGFjY2VzcyB0byByZWdpc3RlcnMgdXNlZCBmb3INCmZ1bmN0aW9uYWxpdHkgbGlrZSBpbnRlcnJ1
cHRzLiBGb3IgZXhhbXBsZSBkd19oYW5kbGVfbXNpX2lycSBkb2VzOg0KDQoJZHdfcGNpZV9yZF9v
d25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfU1RBVFVTICsNCgkJCSAgICAoaSAqIE1TSV9SRUdf
Q1RSTF9CTE9DS19TSVpFKSwNCgkJCSAgICA0LCAmdmFsKTsNCg0Kd2hlcmUgUENJX01TSV9JTlRS
MF9TVEFUVVMgaXMgMHg4MzAuIFRoZXJlIGFyZSBtb3JlIGFjY2Vzc2VzIGxpa2UgdGhpcy4NCg0K
VGVzdGluZyBvbiA2ZGwtc2FicmVhdXRvIChkdHMgY2hhbmdlIHJlcXVpcmVkKSB3aXRoIGFuIGF0
aDlrIHBjaWUgY2FyZA0Kd2l0aCB5b3VyIHNlcmllcyBJIHNvbWV0aW1lcyBnZXQgImlycSAyOTU6
IG5vYm9keSBjYXJlZCIgb24gYm9vdC4gTWF5YmUNCkknbSBtaXNzaW5nIHNvbWV0aGluZz8NCg0K
LS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=
