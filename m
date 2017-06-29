Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:64174 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751626AbdF2V2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2017 17:28:14 -0400
From: "Hubbe, Allen" <Allen.Hubbe@dell.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>
Subject: RE: [PATCH 06/16] ntb: add check and comment for link up to
 mw_count and mw_get_align
Date: Thu, 29 Jun 2017 21:27:50 +0000
Message-ID: <40F65EF2B5E2254199711F58E3ACB84DB00F8F8A@MX104CL02.corp.emc.com>
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-7-logang@deltatee.com>
 <000301d2f103$3310ca60$99325f20$@dell.com>
 <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
 <000401d2f114$3499f2b0$9dcdd810$@dell.com>
 <63c4b0fa-2f03-6313-2d60-c6dab53bc3a5@deltatee.com>
In-Reply-To: <63c4b0fa-2f03-6313-2d60-c6dab53bc3a5@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

RnJvbTogTG9nYW4gR3VudGhvcnBlDQo+IE9uIDYvMjkvMjAxNyAyOjEzIFBNLCBBbGxlbiBIdWJi
ZSB3cm90ZToNCj4gPiBVbmZvcnR1bmF0ZWx5LCBpdCBpcyB0byB3b3JrIGFyb3VuZCBoYXJkd2Fy
ZSBlcnJhdGEuICBUaGF0IGlzIG5vdCBzbyB0cml2aWFsIHRvIGZpeC4NCj4gDQo+IENhbiB5b3Ug
ZGVzY3JpYmUgbW9yZSB3aGF0IHRoZSB3b3JrIGFyb3VuZCBpcyBkb2luZz8gQ2FuIHlvdSBzaGFy
ZSB0aGUNCj4gY29kZT8gSXQgc2VlbXMgb2RkIHRoYXQgYSB3b3JrYXJvdW5kIGlzIGJhc2VkIG9u
IHRoZSBhbGlnbm1lbnQNCj4gcmVzdHJpY3Rpb25zIG9mIHRoZSBtd3MuDQoNClN1cmUsIHdoaWxl
IG5vdCBtYWtpbmcgYW55IGNsYWltIHRoYXQgdGhpcyBpcyByZWFkeSBmb3IgdXBzdHJlYW0uDQoN
Ckl0IGlzIG5vdCBhIHdvcmthcm91bmQgZm9yIGFsaWdubWVudCByZXN0cmljdGlvbnMgb2YgdGhl
IG13cy4gIEl0IGlzIGEgcmVzdHJpY3Rpb24gdG8gYXZvaWQgdGhlIHVzZSBvZiBkb29yYmVsbHMg
YW5kIHNjcmF0Y2hwYWRzLiAgTWVtb3J5IHdpbmRvd3MgYXJlIHVzZWQgZXhjbHVzaXZlbHkuDQoN
ClJlYWQgbXNpLXggbG9jYWwgPGFkZHIsZGF0YT4gYW5kIHNlbmQgdGhhdCB0byB0aGUgcGVlcjoN
Cmh0dHBzOi8vZ2l0aHViLmNvbS9udHJkbWEvbnRyZG1hL2Jsb2IvbWFzdGVyL2RyaXZlcnMvbnRj
L250Y19udGJfbXNpLmMjTDYwMw0KDQpUcmFuc2Zvcm0gcGVlcidzIGFkZHIgdG8gdGhlIG1lbW9y
eSB3aW5kb3cgcmVnaW9uOg0KaHR0cHM6Ly9naXRodWIuY29tL250cmRtYS9udHJkbWEvYmxvYi9t
YXN0ZXIvZHJpdmVycy9udGMvbnRjX250Yl9tc2kuYyNMNjIyDQoNCkFwcGVuZCBhIGRtYSBpbW1l
ZGlhdGUgdmFsdWUgb3BlcmF0aW9uIGFmdGVyIG90aGVyIG9wZXJhdGlvbnMsIHRvIHdyaXRlIHRo
ZSBkYXRhIGF0IGFkZHI6DQpodHRwczovL2dpdGh1Yi5jb20vbnRyZG1hL250cmRtYS9ibG9iL21h
c3Rlci9kcml2ZXJzL250Yy9udGNfbnRiX21zaS5jI0wxMjA4DQoNCkFib3ZlIGRlc2NyaWJlcyB0
aGUgd29ya2Fyb3VuZC4NCg0KVXNlZCBpbiB0aGUgY29udGV4dCBvZiBhIHJkbWEtb3Zlci1udGIg
ZHJpdmVyIGhlcmU6DQpodHRwczovL2dpdGh1Yi5jb20vbnRyZG1hL250cmRtYS9ibG9iL21hc3Rl
ci9kcml2ZXJzL2luZmluaWJhbmQvaHcvbnRyZG1hL250cmRtYV9xcC5jI0wxNTg1DQoNCj4gDQo+
IExvZ2FuDQo=
