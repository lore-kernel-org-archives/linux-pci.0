Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:51936
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752398AbcHBH2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 03:28:36 -0400
From: Haggai Eran <haggaie@mellanox.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
	Kovalyov Artemy <artemyko@mellanox.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@mellanox.com>,
	"stephen.bates@microsemi.com" <stephen.bates@microsemi.com>,
	"j.glisse@gmail.com" <j.glisse@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Liran Liss <liranl@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC 7/7] NVMe: CMB on DMA-BUF
Date: Tue, 2 Aug 2016 07:10:14 +0000
Message-ID: <1470121814.20129.8.camel@mellanox.com>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
	 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
	 <20160801155206.GA23224@infradead.org>
In-Reply-To: <20160801155206.GA23224@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24g15EnLCAyMDE2LTA4LTAxIGF0IDA4OjUyIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMDEsIDIwMTYgYXQgMDk6NTc6MzNBTSArMDMwMCwgSGFnZ2FpIEVy
YW4gd3JvdGU6DQo+ID4gDQo+ID4gQWxsb2NhdGUgYSBDTUIgcmVnaW9uIHRvIHVzZXItc3BhY2Ug
YXMgYSBETUEtQlVGIG9iamVjdC4NCj4gTkFDSy7CoMKgQWJzb2x1dGVseSBubyB3YXkgd2UncmUg
Z29pbmcgdG8gZXhwb3J0IGEgbG93LWxldmVsIGRldmljZQ0KPiBzcGVjaWZpYyBmZWF0dXJlIHRv
IHVzZXJzcGFjZSBsaWtlIHRoYXQuwqDCoElmIHlvdSB3YW50IHRvIERNQSB0bw0KPiB0aGUgQ01C
IGRvIGl0IGZyb20gdGhlIGtlcm5lbCwgYW5kIGZvciB0aGF0IHdlJ2xsIG5lZWQgYSBwcm9wZXIN
Cj4gYmxvY2sgZGV2aWNlIGxldmVsIEFQSS4NCg0KVGhlIHJlYXNvbiBJIHRob3VnaHQgdGhpcyBp
ZGVhIG1pZ2h0IHdvcmsgaXMgYmVjYXVzZSBvZiB0aGUgcmVzcG9uc2VzDQpTdGVwaGVuIGdvdCBm
b3IgaGlzIGF0dGVtcHQgdG8gdXNlIFpPTkVfREVWSUNFIGZvciB0aGluZ3MgbGlrZSB0aGUgQ01C
Lg0KVGhlIHByb2JsZW0gd2l0aCB0aGF0IGlzIHRoYXQgdGhlIHdheSBSRE1BIHJlZ2lzdHJhdGlv
biB3b3JrcyB3aXRoDQpnZXRfdXNlcl9wYWdlcyBtZWFucyB0aGF0IHRoZSBDUFUgYWxzbyBnZXRz
IGFjY2VzcyB0byB0aGUgQ01CIGFuZA0Kc29tZXRpbWVzIHlvdSBkb24ndCB3YW50IHRoYXQuIERN
QS1CVUYgY2FuIHNvbHZlIHRoYXQgbmljZWx5IGluIHRoYXQgaXQNCmRvZXNuJ3QgcmVxdWlyZSBt
YXBwaW5nIGl0IHRvIHRoZSBDUFUgLSBhIGRyaXZlciBjYW4gYXR0YWNoIHRvIGl0DQpkaXJlY3Rs
eS4NCg0KQW55d2F5LCBJIHVuZGVyc3RhbmQgZXhwb3NpbmcgdGhlIENNQiBkaXJlY3RseSBtaWdo
dCBiZSBhIGxpdHRsZSB0b28NCmxvdyBsZXZlbC4gV2hhdCBkbyB5b3UgdGhpbmsgd291bGQgd29y
ayBiZXR0ZXI/IFNvbWV0aGluZyBsaWtlDQpkaXJlY3RfYWNjZXNzIHRoYXQgcmV0dXJucyBidXMg
YWRkcmVzc2VzIGluc3RlYWQgb2YgcGZucz8NCg0KVGhhbmtzLA0KSGFnZ2Fp
