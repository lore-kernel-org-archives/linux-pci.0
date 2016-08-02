Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:21408
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752522AbcHBHWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 03:22:54 -0400
From: Haggai Eran <haggaie@mellanox.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
	Kovalyov Artemy <artemyko@mellanox.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@mellanox.com>,
	"stephen.bates@microsemi.com" <stephen.bates@microsemi.com>,
	"j.glisse@gmail.com" <j.glisse@gmail.com>,
	"jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Liran Liss <liranl@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC 6/7] NVMe: Use genalloc to allocate CMB regions
Date: Tue, 2 Aug 2016 06:48:36 +0000
Message-ID: <1470120518.20129.2.camel@mellanox.com>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
	 <1470034653-9097-7-git-send-email-haggaie@mellanox.com>
	 <20160801155348.GB23224@infradead.org>
In-Reply-To: <20160801155348.GB23224@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24g15EnLCAyMDE2LTA4LTAxIGF0IDA4OjUzIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMDEsIDIwMTYgYXQgMDk6NTc6MzJBTSArMDMwMCwgSGFnZ2FpIEVy
YW4gd3JvdGU6DQo+ID4gDQo+ID4gUmVnaXN0ZXIgdGhlIENNQiBpbiBhIGdlbl9wb29sIGRlZGlj
YXRlZCB0byBtYW5hZ2UgQ01CIHJlZ2lvbnMuIFVzZQ0KPiA+IHRoZQ0KPiA+IHBvb2wgdG8gYWxs
b2NhdGUgdGhlIFNRcyB0byBtYWtlIHN1cmUgdGhleSBhcmUgcmVnaXN0ZXJlZC4NCj4gQW5kIHdo
eSB3b3VsZCB0aGUgTlZNZSBkcml2ZXIgY2FyZSBpZiAidGhleSBhcmUgcmVnaXN0ZXJlZCI/DQpJ
IGp1c3QgbWVhbnQgdGhhdCB0aGV5IGFyZSBhbGxvY2F0ZWQgdGhyb3VnaCBnZW5hbGxvYyBzbyB0
aGF0IGl0DQpkb2Vzbid0IGFsbG9jYXRlIHRoZSBzYW1lIGJ1ZmZlciBhZ2Fpbi4NCg0KPiANCj4g
T25jZSB3ZSBzdGFydCBhbGxvd2luZyBkaXZlcnNlIENNQiB1c2VzICh3aGF0IGhhcHBlbmVkIHRv
IEpvbidzDQo+IHBhdGNoZXMNCj4gYnR3PykgZ2VuYWxsb2MgbWlnaHQgYmUgYSBnb29kIGJhY2tl
bmQgYWxsb2NhdG9yLCBidXQgd2l0aG91dCB0aGF0DQo+IGl0J3MgZW50aXJlbHkgcG9pbnRsZXNz
LsKgwqANCkkgbWlzc2VkIEpvbidzIHBhdGNoZXMuIEknbGwgaGF2ZSBhIGxvb2suIFRoZSBwb2lu
dCBpbiB0aGlzIHBhdGNoIHdhcw0KdG8gYWxsb3cgdGhpcyBkaXZlcnNlIHVzZSBpbiB0aGUgbmV4
dCBwYXRjaC4NCg0KPiBBbHNvIHBsZWFzZSBkb24ndCBpbnRyb2R1Y2UgdXNlbGVzcyBoZWFkZXIN
Cj4gZmlsZXMuDQpGYWlyIGVub3VnaC4NCg0KVGhhbmtzLA0KSGFnZ2Fp
