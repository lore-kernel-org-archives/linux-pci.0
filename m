Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525A9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114C72075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wNdO9R2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114C72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeKTVRe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:17:34 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:24640
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727613AbeKTVRe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A7q6csEpLQibjL/+y6Sb9qnsgg7wDOLWBP8SraSzQo=;
 b=wNdO9R2x0MZFO18TjDJkChQSpf+teKhWm40vDUAQaux1FqOJLXFEz7f6ER6Mh4Bmc90Z2exOTaAg7Y3r/WldvB1bB31uWLsedyR1xqhvuP6dXZWPReF95lkQF/MMTsuLwHenrA55Yscu7wBuWHGmZZIM07KsEezU5m17u8aEpe8=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5936.eurprd04.prod.outlook.com (20.178.205.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Tue, 20 Nov 2018 10:48:59 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 10:48:59 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Topic: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
Thread-Index: AQHUfqElwnFd442790GkPu5+DDDqQaVYgASA
Date:   Tue, 20 Nov 2018 10:48:59 +0000
Message-ID: <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
         <20181117181225.10737-4-andrew.smirnov@gmail.com>
In-Reply-To: <20181117181225.10737-4-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5936;6:mxhJ58+5aKxm7dlEitXlAmVG9glAXkqHIRGB86XqlkCe8o1XJiRozmeRSjFDwGlAnj1F+Gf8qELksBs5lFyRPljSJF1KpCEFngu8VsWpHafDaR0zlGosDtVAMGgWFE3ZxsEaYTVrDqsrRu+bIdpp2h5MEqplmc/z11nuJURjqd3MerQ1MFCGz1fiW93M7yBS7ztywvx+tEe0Bco0FwReB5bd7vf6ZXHlHWW/XOtF2IgUrt51UVPU98mC0i0wOa+Q4cqq3BuP2Q604WFsDuqaciqGOxROavap5jsYk42oBHP97eaVN57OFBHqWcE1nxBp9OFndnZpGWarbczU56EXpT/4YbTiwTNxZw9zoZys4/7Qono2nHvLpurNm0Q7BQm9IkJNI1n4DP0yluD3Of1fYYixkn4Lm4AX99DQULjtncd/Cg4iMAWhrmHCEycCFhi1/lu9qfUhZiABZ6RPsMtZMA==;5:itOs7slbiLSPt2ODrn2ckl7GvhRZa2UkM9W8gFnB/y0YV9yVtF2a1nU7td+OT5kotWfXjbktdYQsdDtV+AKXIQ1iugO/UW0g8urlmSZPCVk5Vg8+A2rJhEf7fB7HoDvDF0u29z4Nvpx0Cs+VZIEBrQ8QIMW1GsYS7OrCGF1rzA8=;7:avYXc0r54LjlkEufPVRxVPHqzdFkkBN73MHqUZ16Vm96dfljVY+fIpQBI2gO9FnFZq1d0tO1whPB1t6jNp4df18IcYYifJEAzJNhkOFnNdZY4KBzYb9cP5rT/anJZC6ka7njAMgMM631paMpz3vt8w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 29ba472c-1abc-4a8c-5511-08d64ed5c733
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5936;
x-ms-traffictypediagnostic: VI1PR04MB5936:
x-microsoft-antispam-prvs: <VI1PR04MB5936C98D5C7C06EC5F2D1175EED90@VI1PR04MB5936.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5936;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5936;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(6486002)(25786009)(305945005)(4326008)(118296001)(2900100001)(14454004)(7416002)(478600001)(39060400002)(2501003)(256004)(71190400001)(36756003)(4001150100001)(6246003)(7736002)(6916009)(71200400001)(6512007)(229853002)(53936002)(97736004)(6436002)(5640700003)(99286004)(6506007)(102836004)(26005)(186003)(2351001)(316002)(54906003)(44832011)(86362001)(486006)(66066001)(446003)(3846002)(105586002)(6116002)(106356001)(2906002)(11346002)(5660300001)(476003)(2616005)(1361003)(76176011)(81166006)(8936002)(8676002)(68736007)(50226002)(81156014)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5936;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5xI1PGgfkl7LUyu5zjQIMuyBBY0TlU0dR1mHm612Y4cLJAnnF6slmb5bAAJ86gQ+jeLEDRvc0OrNlaqom+R4mnYCYA+ZfvBim53DGs0PSeXYK4vankt29ja1GEXohkJkJyAQnm1zwJzlQ/YbW0HLZLTZf9cSfBOgC/eba8NSZtpQXvP8ohQMDbpQhxDWUxqFBp//KqtOY6v+WuvOB2Ongnf1u+hgqhqw/sAEp+4Yz0kW1nWXjB30B12tNMDcI7Hm0tZh2zCBH7szeAhVWE4L5s3tGZf5qwQk0jiPGHP0FXArhJ37idUluN/C5f3tZ3V/GFFF07yYye5LIbC7fWSRs03DLuqBSswpWX2cBykNvUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A2AC41B31FD1147A77BC27AE8F297AF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ba472c-1abc-4a8c-5511-08d64ed5c733
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:48:59.4533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5936
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDE4LTExLTE3IGF0IDEwOjEyIC0wODAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gQEAgLTkyMSw3ICsxMDA0LDI4IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IC0JY2FzZSBJTVg3RDoNCj4gKwljYXNlIElNWDhN
UToNCj4gKwkJaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5vZGUsICJmc2wsaW9tdXgtZ3ByMXgi
LA0KPiArCQkJCQkgJmlteDZfcGNpZS0+Z3ByMXgpKSB7DQo+ICsJCQlkZXZfZXJyKGRldiwgIkZh
aWxlZCB0byBnZXQgR1BSMXggYWRkcmVzc1xuIik7DQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4g
KwkJfQ0KDQpUaGlzIGlzIGZvciBkaXN0aW5ndWlzaGluZyBtdWx0aXBsZSBjb250cm9sbGVycyBv
biB0aGUgU09DIGJ1dCBvdGhlcg0KcmVnaXN0ZXJzIGFuZCBiaXRzIG1pZ2h0IGRpZmZlci4gSXNu
J3QgaXQgcHJlZmVyYWJsZSB0byBoYXZlIGEgcHJvcGVydHkNCmZvciBjb250cm9sbGVyIGlkIGlu
c3RlYWQgb2YgYWRkaW5nIG1hbnkgcmVnaXN0ZXJzIHRvIERUPw0KDQo+ICsNCj4gKwkJaWYgKG9m
X3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KA0KPiArCQkJICAgIG5vZGUsICJmc2wsZ3ByMTItZGV2
aWNlLXR5cGUiLA0KPiArCQkJICAgIGlteDZfcGNpZS0+ZGV2aWNlX3R5cGUsDQo+ICsJCQkgICAg
QVJSQVlfU0laRShpbXg2X3BjaWUtPmRldmljZV90eXBlKSkpIHsNCj4gKwkJCWRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIGdldCBkZXZpY2UgdHlwZQ0KPiBtYXNrL3ZhbHVlXG4iKTsNCj4gKwkJCXJl
dHVybiAtRUlOVkFMOw0KPiArCQl9DQoNClRoZSBkZXZpY2UgdHlwZSBjYW4gYmUgc2V0IG9uIG11
bHRpcGxlIFNPQ3MsIHdoeSBhcmUgeW91IGFkZGluZyBhDQptYW5kYXRvcnkgcHJvcGVydHkgb25s
eSBmb3IgOG0/DQoNClRoZXJlIHNob3VsZCBwcm9iYWJseSBiZSBhIHNlcGFyYXRlIHBhdGNoIHdp
dGggZG9jdW1lbnRlZCBEVCBiaW5kaW5ncy4NCg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=
