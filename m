Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271AC67872
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 10:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E162133F
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 10:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nT+b7zQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E162133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeLNKtV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:49:21 -0500
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:64094
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeLNKtV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 05:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRf2NXYZKYkpCTgriJKQWsCkezrTi1rSNDRQkYcWC+Q=;
 b=nT+b7zQpz6y2MSJLRQDuPeNpVGZYLL4lfqXsBpPql8vsCC+o5NukJkYXLudKcHfZLZZM7bAIW5aCUXXDq8uHCz4LV2TN6O9wQURCJf0RIvhM9Nb04tpvBwQqFIcpTaaiBrilUnuGvHyQlg1/05XyLxwCn0xQhEXZsgo0n05NtGc=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1484.jpnprd01.prod.outlook.com (52.133.161.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 10:49:16 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 10:49:16 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Thread-Topic: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Thread-Index: AQHUkyF5MBLGbE47ZUK6cwj3ScEsl6V+CXqAgAAFGlA=
Date:   Fri, 14 Dec 2018 10:49:16 +0000
Message-ID: <TY1PR01MB1770FAF7F451A3B8F4903ED9C0A10@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732500-6866-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdUqNR5jKQXvC5gy5r44Jp+cbo8iorfCFpwBHNCu16RH0w@mail.gmail.com>
In-Reply-To: <CAMuHMdUqNR5jKQXvC5gy5r44Jp+cbo8iorfCFpwBHNCu16RH0w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1484;20:NAXf+xnP9CIdEWsNyNeC+zBvhAzCe4UiqoPm0kdE51SUYbu8SroTeY/Q81Oq2GSBKBCdnQNH9FElLVoP8vMOQN0Un/xtojRFToq9sdrU/616yElWaFd7imTYZmR0k/hQ9gLe+pSlAr0xVm+DfqlGNmTidAvSuYFGdnKmTr9nBHo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1a51964e-e5f9-4db5-6127-08d661b1cb0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1484;
x-ms-traffictypediagnostic: TY1PR01MB1484:
x-microsoft-antispam-prvs: <TY1PR01MB148443725217D258D41FEB20C0A10@TY1PR01MB1484.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1484;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1484;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(2906002)(14454004)(345774005)(55016002)(74316002)(76176011)(25786009)(229853002)(6116002)(7696005)(3846002)(10126004)(4326008)(6916009)(7736002)(305945005)(68736007)(7416002)(105586002)(81166006)(81156014)(26005)(102836004)(106356001)(478600001)(8676002)(6436002)(5660300001)(256004)(186003)(53546011)(97736004)(6506007)(8936002)(6246003)(44832011)(66066001)(316002)(86362001)(54906003)(71190400001)(71200400001)(53936002)(99286004)(446003)(476003)(11346002)(14444005)(9686003)(486006)(6306002)(33656002)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1484;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TrnFadpqtWyRw0VCZ9sXn+yT3P4TnH+M6RXPM+ZCN055Ozf6A1kp4+STZpk9sXYaVc702vA1+jh1yIOO6s/Yt776azHbZ+tjfMWjJI4baM5iUL08T7Q4iKEb+gtZVTAG2JeyZg+90AXL5dtmH7+w4RhhoWNgN6sQFsUNw2yGnnthxpukhCxPV4E5CPiszpg28X9S8Bk6OlHQyQoU2NnWE80Erq1h2z2iC+kAtiimHiDvGF8qtOoeebP+2jruxEhhViZKEBEp18YwjohRl68qVNTvucSvQW6Vc2/TJmndaklgHS8uzh9SQNimUpZtIN5G
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a51964e-e5f9-4db5-6127-08d661b1cb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 10:49:16.0818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1484
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAxNCBEZWNl
bWJlciAyMDE4IDEwOjI5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBQQ0k6
IHJjYXI6IEFkZCBkZXZpY2UgdHJlZSBzdXBwb3J0IGZvciByOGE3NzRjMA0KPg0KPiBIaSBGYWJy
aXppbywNCj4NCj4gT24gVGh1LCBEZWMgMTMsIDIwMTggYXQgOToyMSBQTSBGYWJyaXppbyBDYXN0
cm8NCj4gPGZhYnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gQWRkIFBD
SWUgc3VwcG9ydCBmb3IgdGhlIFJaL0cyRSAoYS5rLmEuIFI4QTc3NEMwKS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMu
Y29tPg0KPg0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZT4NCj4NCj4gT25lIHF1ZXN0aW9uIGJlbG93Lg0KPg0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcmNhci1wY2kudHh0DQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9yY2FyLXBjaS50eHQNCj4NCj4g
PiBAQCAtMzcsNyArMzksOCBAQCBjb21wYXRpYmxlOiAicmVuZXNhcyxwY2llLXI4YTc3NDMiIGZv
ciB0aGUgUjhBNzc0MyBTb0M7DQo+ID4NCj4gPiAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAg
LSBwaHlzOiBmcm9tIGNvbW1vbiBQSFkgYmluZGluZzogUEhZIHBoYW5kbGUgYW5kIHNwZWNpZmll
ciAob25seSBtYWtlIHNlbnNlDQo+ID4gLSAgICAgICBmb3IgUi1DYXIgZ2VuMyBTb0NzIHdoZXJl
IHRoZSBQQ0llIFBIWXMgaGF2ZSB0aGVpciBvd24gcmVnaXN0ZXIgYmxvY2tzKS4NCj4gPiArICAg
ICAgIGZvciBSLUNhciBnZW4zIGFuZCBSWi9HMiBTb0NzIHdoZXJlIHRoZSBQQ0llIFBIWXMgaGF2
ZSB0aGVpciBvd24NCj4NCj4gR2VuMywgd2hpbGUgYXQgaXQ/DQoNCkNhbiBkbw0KDQo+DQo+ID4g
KyAgICAgICByZWdpc3RlciBibG9ja3MpLg0KPg0KPiBUaGUgUlovRzIgSGFyZHdhcmUgVXNlciBN
YW51YWwgSSBoYXZlIGxhY2tzIHRoZSB0YWJsZSBzcGVjaWZ5aW5nIHdoaWNoIFNvQ3MNCj4gaGF2
ZSB3aGljaCBQSFkgcmVnaXN0ZXJzLiAgU28gSSBjYW5ub3QgdmVyaWZ5IGlmIHRoZSBhYm92ZSBw
YXJhZ3JhcGggYXBwbGllcyB0bw0KPiBSWi9HMihFKS4NCg0KSSdsbCByZXBseSB0byB0aGlzIG9u
IHlvdXIgZm9sbG93LXVwICBlbWFpbC4NCg0KVGhhbmtzLA0KRmFiDQoNCj4NCj4gR3J7b2V0amUs
ZWV0aW5nfXMsDQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+DQo+IC0tDQo+
IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIg
LS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4NCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3
aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVu
IEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNv
bWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0g
TGludXMgVG9ydmFsZHMNCg0KDQpbaHR0cHM6Ly93d3cyLnJlbmVzYXMuZXUvbWVkaWEvZW1haWwv
dW5pY2VmLmpwZ10NCg0KVGhpcyBDaHJpc3RtYXMsIGluc3RlYWQgb2Ygc2VuZGluZyBvdXQgY2Fy
ZHMsIFJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIGhhdmUgZGVjaWRlZCB0byBzdXBwb3J0IFVu
aWNlZiB3aXRoIGEgZG9uYXRpb24uIEZvciBmdXJ0aGVyIGRldGFpbHMgY2xpY2sgaGVyZTxodHRw
czovL3d3dy51bmljZWYub3JnLz4gdG8gZmluZCBvdXQgYWJvdXQgdGhlIHZhbHVhYmxlIHdvcmsg
dGhleSBkbywgaGVscGluZyBjaGlsZHJlbiBhbGwgb3ZlciB0aGUgd29ybGQuDQpXZSB3b3VsZCBs
aWtlIHRvIHRha2UgdGhpcyBvcHBvcnR1bml0eSB0byB3aXNoIHlvdSBhIE1lcnJ5IENocmlzdG1h
cyBhbmQgYSBwcm9zcGVyb3VzIE5ldyBZZWFyLg0KDQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBF
dXJvcGUgTHRkLCBEdWtlcyBNZWFkb3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNr
aW5naGFtc2hpcmUsIFNMOCA1RkgsIFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1
bmRlciBSZWdpc3RlcmVkIE5vLiAwNDU4NjcwOS4NCg==
