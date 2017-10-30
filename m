Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:43088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751429AbdJ3BEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Oct 2017 21:04:49 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "corbet@lwn.net" <corbet@lwn.net>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "cdall@linaro.org" <cdall@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "tom@talpey.com" <tom@talpey.com>
Subject: Re: [PATCH] pci: Add a acs_disable option for pci kernel parameter
Date: Mon, 30 Oct 2017 01:04:47 +0000
Message-ID: <7AEEED4D-1C64-4330-96E2-AB665E3D4B7D@raithlin.com>
References: <1509071869-18771-1-git-send-email-sbates@raithlin.com>
 <20171027063745.GA19799@infradead.org>
In-Reply-To: <20171027063745.GA19799@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IGJvb3Qgb3B0aW9uIHRvIHRoZSBwY2kga2VybmVsIHBh
cmFtZXRlciBjYWxsZWQNCj4+ICJhY3NfZGlzYWJsZSIgdGhhdCB3aWxsIGRpc2FibGUgQUNTLiBU
aGlzIGlzIHVzZWZ1bCBmb3IgUENJIHBlZXIgdG8NCj4+IHBlZXIgY29tbXVuaWNhdGlvbiBidXQg
Y2FuIGNhdXNlIHByb2JsZW1zIHdoZW4gSU9WQSBpc29sYXRpb24gaXMNCj4+IHJlcXVpcmVkIGFu
ZCBhbiBJT01NVSBpcyBlbmFibGVkLiBVc2Ugd2l0aCBjYXJlLg0KDQo+IEV3dy4NCg0KVGhhbmtz
IGZvciB0aGUgZmVlZGJhY2sgQ2hyaXN0b3BoLiBNeSBzZW50aW1lbnRzIGV4YWN0bHkgOy0pLiAg
DQoNCj4gQ2FuIHdlIHBsZWFzZSBhZGQgc21iaW9zIHF1aXJrcyBmb3IgdGhlIHN5c3RlbXMgd2hl
cmUgeW91J3ZlDQo+IG9ic2VydmVkIHRoaXM/IA0KDQpJIGNhbiBsb29rIGF0IGRvaW5nIHRoaXMu
IFRoZSBpc3N1ZSB3aXRoIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBpdCB3aWxsIHJlcXVpcmUgYSBr
ZXJuZWwgcGF0Y2ggZm9yIGVhY2ggbmV3IHN5c3RlbSB0aGF0IGlzIGRldGVjdGVkLg0KDQo+IHdl
IHByb2JhYmx5IGFsc28gd2FudCB0byBrZWVwIHRoZSBvcHRpb24ganVzdCBpbiBjYXNlKS4NCg0K
QWdyZWVkLiBBdCBsZWFzdCB0aGVuIG9wZXJhdG9ycyBoYXZlIGEgcGF0aCB0byBBQ1MgZGlzYWJs
ZSBwcmlvciB0byBhIHF1aXJrIGJlaW5nIGFjY2VwdGVkLg0KDQpTdGVwaGVuDQoNCg==
