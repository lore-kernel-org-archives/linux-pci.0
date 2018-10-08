Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6786FC00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 10:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287A72064E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 10:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287A72064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJHRRi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:17:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60922 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbeJHRRi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 13:17:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-86-gkA6zT1YPEeRvr6tsSYA0g-1; Mon, 08 Oct 2018 11:06:40 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 8 Oct 2018 11:06:40 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Oct 2018 11:06:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bin Meng' <bmeng.cn@gmail.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
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
Thread-Index: AQHUXuuBTtSmrEla30a9wTOD32YprqUVGqcg
Date:   Mon, 8 Oct 2018 10:06:40 +0000
Message-ID: <2d2878e5a44c496cb0937f02d64e0b38@AcuMS.aculab.com>
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
 <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com>
In-Reply-To: <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: gkA6zT1YPEeRvr6tsSYA0g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQmluIE1lbmcNCj4gU2VudDogMDggT2N0b2JlciAyMDE4IDEwOjQ0DQouLi4NCj4gQ29y
cmVjdCwgZGlzYWJsZSB0aGUgc2hhcmVkIGludGVycnVwdCBsaW5lIGtlZXBzIGFsbCBkZXZpY2Vz
IHVzaW5nDQo+IHRoYXQgbGluZSBmcm9tIHdvcmtpbmcsIHdoaWNoIGlzIGN1cnJlbnQga2VybmVs
J3MgYmVoYXZpb3Igdy9vIHRoaXMNCj4gcXVpcmsgaGFuZGxpbmc6IGl0IGRpc2FibGVzIHRoZSAo
c2hhcmVkKSBpbnRlcnJ1cHQgbGluZSBhZnRlciAxMDAuMDAwKw0KPiBnZW5lcmF0ZWQgaW50ZXJy
dXB0cy4gQnV0IHRoZSBzaWRlIGVmZmVjdCBpcyB0aGF0IG90aGVyIGRldmljZXMgYmVjb21lDQo+
IHVudXNhYmxlIGFmdGVyIHRoYXQgKGVnOiBVU0IgZGV2aWNlcyB3aGljaCBzaGFyZSB0aGUgc2Ft
ZSBpbnRlcnJ1cHQNCj4gbGluZSB3aXRoIHRoZSBJbnRlbCBHUFUpLiBUaGF0J3Mgd2h5IHRoZSBv
cmlnaW5hbCBjb21taXQsIGY2N2ZkNTVmYTk2Zg0KPiAoIlBDSTogQWRkIHF1aXJrIGZvciBzdGls
bCBlbmFibGVkIGludGVycnVwdHMgb24gSW50ZWwgU2FuZHkgQnJpZGdlDQo+IEdQVXMiKSBkaXNh
YmxlcyB0aGUgR1BVJ3MgaW50ZXJydXB0IGRpcmVjdGx5LCB3aGljaCBzaG91bGQgcmVhbGx5IGJl
DQo+IGRvbmUgYnkgdGhlIFZHQSBCSU9TIGl0c2VsZiAoYSBidWdneSBWQklPUyEpLg0KDQpTaG91
bGRuJ3QgdGhlIGtlcm5lbCBqdXN0IGRpc2FibGUgYWxsIFBDSShlKSBpbnRlcnJ1cHRzIGJ5IHdy
aXRpbmcNCjEgdG8gdGhlIGNvbmZpZyBzcGFjZSBjb250cm9sIHJlZ2lzdGVyIGJpdCBkdXJpbmcg
Z3JvcGU/DQpDYW4gaXQgZXZlciBieSByaWdodCBmb3IgdGhpcyB0byBiZSBzZXQ/DQoNCkFwYXJ0
IGZyb20gVkdBIHRoZSAnYnVzIG1hc3RlcicgYml0IGFsc28gbmVlZHMgdG8gYmUgY2xlYXIuDQoN
CklTVFIgc29tZSB2ZXJ5IGVhcmx5IFBDSSBzeXN0ZW1zIHdoaWNoIGZhaWxlZCB0byByZXNldCB0
aGUgUENJDQpidXMgZHVyaW5nIHJlYm9vdCAtIGF0IGxlYXN0IHRoZSAnYnVzIG1hc3RlcicgYml0
IHJlbWFpbmVkDQpzZXQgZm9yIGFuIGV0aGVybmV0IGNhcmQuDQpPbiBhIHByaXZhdGUgTEFOIHRo
ZSBPUyBnb3QgcmVpbnN0YWxsZWQgYW5kIHJlYm9vdGVkIHdpdGhvdXQNCnVzaW5nIGFsbCB0aGUg
ZXRoZXJuZXQgcmVjZWl2ZSBidWZmZXJzIGFuZCB0aGVuIGRpZWQgYmVjYXVzZQ0KYSByZWNlaXZl
IGZyYW1lIGdvdCB3cml0dGVuIGludG8gJ3JhbmRvbScgbWVtb3J5Lg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

