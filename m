Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F7C676D2
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF1320841
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 13:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF1320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeJHUjZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:39:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45461 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbeJHUjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 16:39:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-24-jfUcPQ8pN6KrLuyHUcUvGg-1; Mon, 08 Oct 2018 14:27:37 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 8 Oct 2018 14:27:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Oct 2018 14:27:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bin Meng' <bmeng.cn@gmail.com>
CC:     "helgaas@kernel.org" <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci: Add a few new IDs for Intel GPU "spurious interrupt"
 quirk
Thread-Topic: [PATCH] pci: Add a few new IDs for Intel GPU "spurious
 interrupt" quirk
Thread-Index: AQHUXuuBTtSmrEla30a9wTOD32YprqUVGqcggAAdLQCAAB0d4A==
Date:   Mon, 8 Oct 2018 13:27:38 +0000
Message-ID: <8285ca0d4f6849df835de61dca991781@AcuMS.aculab.com>
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
 <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com>
 <2d2878e5a44c496cb0937f02d64e0b38@AcuMS.aculab.com>
 <CAEUhbmV3SoPLZeN2EOm8h0xfKqN1FBZmJjhv6ygQovHZVA9ZRg@mail.gmail.com>
In-Reply-To: <CAEUhbmV3SoPLZeN2EOm8h0xfKqN1FBZmJjhv6ygQovHZVA9ZRg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: jfUcPQ8pN6KrLuyHUcUvGg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQmluIE1lbmcNCj4gU2VudDogMDggT2N0b2JlciAyMDE4IDEzOjM0DQo+IEhpIERhdmlk
LA0KPiANCj4gT24gTW9uLCBPY3QgOCwgMjAxOCBhdCA2OjA2IFBNIERhdmlkIExhaWdodCA8RGF2
aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQmluIE1lbmcNCj4g
PiA+IFNlbnQ6IDA4IE9jdG9iZXIgMjAxOCAxMDo0NA0KPiA+IC4uLg0KPiA+ID4gQ29ycmVjdCwg
ZGlzYWJsZSB0aGUgc2hhcmVkIGludGVycnVwdCBsaW5lIGtlZXBzIGFsbCBkZXZpY2VzIHVzaW5n
DQo+ID4gPiB0aGF0IGxpbmUgZnJvbSB3b3JraW5nLCB3aGljaCBpcyBjdXJyZW50IGtlcm5lbCdz
IGJlaGF2aW9yIHcvbyB0aGlzDQo+ID4gPiBxdWlyayBoYW5kbGluZzogaXQgZGlzYWJsZXMgdGhl
IChzaGFyZWQpIGludGVycnVwdCBsaW5lIGFmdGVyIDEwMC4wMDArDQo+ID4gPiBnZW5lcmF0ZWQg
aW50ZXJydXB0cy4gQnV0IHRoZSBzaWRlIGVmZmVjdCBpcyB0aGF0IG90aGVyIGRldmljZXMgYmVj
b21lDQo+ID4gPiB1bnVzYWJsZSBhZnRlciB0aGF0IChlZzogVVNCIGRldmljZXMgd2hpY2ggc2hh
cmUgdGhlIHNhbWUgaW50ZXJydXB0DQo+ID4gPiBsaW5lIHdpdGggdGhlIEludGVsIEdQVSkuIFRo
YXQncyB3aHkgdGhlIG9yaWdpbmFsIGNvbW1pdCwgZjY3ZmQ1NWZhOTZmDQo+ID4gPiAoIlBDSTog
QWRkIHF1aXJrIGZvciBzdGlsbCBlbmFibGVkIGludGVycnVwdHMgb24gSW50ZWwgU2FuZHkgQnJp
ZGdlDQo+ID4gPiBHUFVzIikgZGlzYWJsZXMgdGhlIEdQVSdzIGludGVycnVwdCBkaXJlY3RseSwg
d2hpY2ggc2hvdWxkIHJlYWxseSBiZQ0KPiA+ID4gZG9uZSBieSB0aGUgVkdBIEJJT1MgaXRzZWxm
IChhIGJ1Z2d5IFZCSU9TISkuDQo+ID4NCj4gPiBTaG91bGRuJ3QgdGhlIGtlcm5lbCBqdXN0IGRp
c2FibGUgYWxsIFBDSShlKSBpbnRlcnJ1cHRzIGJ5IHdyaXRpbmcNCj4gPiAxIHRvIHRoZSBjb25m
aWcgc3BhY2UgY29udHJvbCByZWdpc3RlciBiaXQgZHVyaW5nIGdyb3BlPw0KPiA+IENhbiBpdCBl
dmVyIGJ5IHJpZ2h0IGZvciB0aGlzIHRvIGJlIHNldD8NCj4gPg0KPiANCj4gRG8geW91IG1lYW4g
UENJX0NPTU1BTkRfSU5UWF9ESVNBQkxFIGJpdCBvZiB0aGUgY29tbWFuZCByZWdpc3RlciBpbg0K
PiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZT8gU2V0dGluZyB0aGlzIGJpdCBpbmRlZWQgY291bGQg
ZGlzYWJsZSB0aGUNCj4gSU5UeCBpbnRlcnJ1cHQsIGJ1dCBpdCBkb2VzIG5vdCB3b3JrIGZvciBh
bGwgUENJIGRldmljZXMgYXMgdGhpcyBiaXQNCj4gd2FzIGludHJvZHVjZWQgaW4gUENJIHNwZWMg
djIuMy4NCg0KVGhhdCdzIHRoZSBvbmUgSSB3YXMgdGhpbmtpbmcgb2YuDQpJZiBpdCB3YXMgaW50
cm9kdWNlZCBpbiB2Mi4zIGl0IGV4cGxhaW5zIHdoeSBpdCBpcyBhICdkaXNhYmxlJyBiaXQuDQoN
ClRoZSB2Mi4yIHNwZWMgSSBqdXN0IGZvdW5kIGRvZXNuJ3Qgc2VlbSB0byBzYXkgYW55dGhpbmcg
YWJvdXQgdGhlDQoncmVzZXJ2ZWQnIGJpdHMuIEkgZ3Vlc3MgdGhlIHZhbHVlcyBhcmUgaWdub3Jl
ZCAoYW5kIHByb2JvYmx5IHJlYWQNCmJhY2sgYXMgemVyb3MpLg0KDQpJbiBhbnkgY2FzZSBpdCBz
aG91bGQgYmUgaW1wbGVtZW50ZWQgYnkgdGhlIFZHQSBkZXZpY2VzIGluIHF1ZXN0aW9uLg0KSSBn
dWVzcyB0aGUga2VybmVsIHNob3VsZCBhbHNvIGVuc3VyZSB0aGF0IE1TSSBhbmQgTVNJLVggaW50
ZXJydXB0cw0KYXJlIGFsc28gYWxsIGRpc2FibGVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

