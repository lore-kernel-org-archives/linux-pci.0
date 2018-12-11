Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6404AC07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326322082F
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326322082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeLKOWF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:22:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20897 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbeLKOWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 09:22:05 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-165-J199icJ0OSK9VPyrkpoVZQ-1; Tue, 11 Dec 2018 14:22:02 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 11 Dec 2018 14:22:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Dec 2018 14:22:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alan Douglas' <adouglas@cadence.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        Bob Copeland <me@bobcopeland.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: RE: [PATCH] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
Thread-Topic: [PATCH] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
Thread-Index: AQHUjU2PiCR+5hvyDU6PPfEeCbv436Vxm41wgAgDT3A=
Date:   Tue, 11 Dec 2018 14:22:12 +0000
Message-ID: <a682d5066a964efc9e280e27231213b6@AcuMS.aculab.com>
References: <20181206102105.53098-1-wen.yang99@zte.com.cn>
 <MWHPR07MB350216ECF82E2730CF87A7D2D8A90@MWHPR07MB3502.namprd07.prod.outlook.com>
In-Reply-To: <MWHPR07MB350216ECF82E2730CF87A7D2D8A90@MWHPR07MB3502.namprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: J199icJ0OSK9VPyrkpoVZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQWxhbiBEb3VnbGFzDQo+IFNlbnQ6IDA2IERlY2VtYmVyIDIwMTggMTI6MDENCj4gSGks
DQo+IA0KPiBPbiAwNiBEZWNlbWJlciAyMDE4IDEwOjIxLCBXZW4gWWFuZyB3cm90ZToNCj4gPiBr
bWVtZHVwIGhhcyBpbXBsZW1lbnRlZCB0aGUgZnVuY3Rpb24gdGhhdCBrbWFsbG9jKCkgKyBtZW1j
cHkoKS4NCj4gPiBXZSBwcmVmZXIgdG8ga21lbWR1cCByYXRoZXIgdGhhbiBjb2RlIG9wZW5lZCBp
bXBsZW1lbnRhdGlvbi4NCi4uLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi10ZXN0LmMgYi9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlv
bnMvcGNpLWVwZi0NCj4gdGVzdC5jDQo+ID4gaW5kZXggM2U4NmZhM2M3ZGEzLi42ZTQyZGFhMmE2
NTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdGVzdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdGVzdC5jDQo+ID4gQEAgLTE2OSwxNCArMTY5LDEyIEBAIHN0YXRpYyBpbnQgcGNpX2VwZl90
ZXN0X3JlYWQoc3RydWN0IHBjaV9lcGZfdGVzdCAqZXBmX3Rlc3QpDQo+ID4gIAkJZ290byBlcnJf
YWRkcjsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JYnVmID0ga3phbGxvYyhyZWctPnNpemUsIEdGUF9L
RVJORUwpOw0KPiA+ICsJYnVmID0ga3phbGxvYyhzcmNfYWRkciwgcmVnLT5zaXplLCBHRlBfS0VS
TkVMKTsNCj4gTG9va3MgbGlrZSBhIHR5cG8gLSBrbWVtZHVwIGluc3RlYWQgb2Yga3phbGxvYz8N
Cg0KV2hpY2ggaXMgd2h5IG1ha2luZyBidXR0ZXIgKGNodXJuaW5nKSBsaWtlIHRoaXMgaXMgbW9z
dGx5IHBvaW50bGVzcy4NCkl0IGlzIHZlcnkgZWFzeSB0byBtYWtlIHNpbGx5IG1pc3Rha2VzLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

