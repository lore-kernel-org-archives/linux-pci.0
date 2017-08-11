Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62376 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbdHKG3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 02:29:47 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lan, Tianyu" <tianyu.lan@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: Support SVM without PASID
Date: Fri, 11 Aug 2017 06:29:43 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D6ED70@SHSMSX101.ccr.corp.intel.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D57191@SHSMSX101.ccr.corp.intel.com>
 <b973c557-1b4a-18d2-a05e-28680a49daf9@arm.com>
In-Reply-To: <b973c557-1b4a-18d2-a05e-28680a49daf9@arm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgNCwgMjAxNyA1OjQzIFBNDQo+IA0K
PiBIaSBLZXZpbiwNCj4gDQo+IE9uIDA0LzA4LzE3IDAyOjQ5LCBUaWFuLCBLZXZpbiB3cm90ZToN
Cj4gPj4gRnJvbTogSmVhbi1QaGlsaXBwZSBCcnVja2VyDQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEF1
Z3VzdCAxLCAyMDE3IDQ6MjYgUE0NCj4gPj4NCj4gPj4gSXQgZGVwZW5kcyB3aGF0IHR5cGUgeW91
IHVzZSB3aGVuIHJlZ2lzdGVyaW5nIHRoZSBJT01NVSB3aXRoDQo+ID4+IFZGSU9fU0VUX0lPTU1V
Og0KPiA+Pg0KPiA+PiAqIElmIHRoZSB0eXBlIGlzIFZGSU9fVFlQRTF2Ml9JT01NVSwgdGhlbg0K
PiA+PiBWRklPX0lPTU1VX01BUC9VTk1BUF9ETUENCj4gPj4gICBhZmZlY3RzIHRoZSBzdGFnZS0x
IG5vbi1QQVNJRCBjb250ZXh0IChhbHJlYWR5IHRoZSBjYXNlIGluIG1haW5saW5lKS4NCj4gPj4g
ICBJbiBhZGRpdGlvbiwgd2l0aCBteSBwYXRjaCB0aGUgQklORCBpb2N0bCB3aWxsIGFmZmVjdCBz
dGFnZS0xIFBBU0lEDQo+ID4+ICAgY29udGV4dHMsIGFuZCBiaW5kIHByb2Nlc3MgcGFnZSBkaXJl
Y3RvcmllcyB0byB0aGUgZGV2aWNlIChob3N0IFNWTSkuDQo+ID4+DQo+ID4+ICogSWYgdGhlIHR5
cGUgaXMgVkZJT19UWVBFMV9ORVNUSU5HX0lPTU1VLCB0aGVuDQo+ID4+IFZGSU9fSU9NTVVfTUFQ
L1VOTUFQX0RNQQ0KPiA+PiAgIHdpbGwgYWZmZWN0IHN0YWdlLTIgbWFwcGluZ3MgKGFscmVhZHkg
aW4gbWFpbmxpbmUpLg0KPiA+PiAgIFdpdGggbXkgU01NVSBwYXRjaCBzZXJpZXMsIHRoZSBCSU5E
IGlvY3RsIGlzIG5vdCBzdXBwb3J0ZWQgaW4gdGhpcyBtb2RlLg0KPiA+PiAgIEJ1dCBpbiB0aGUg
ZnV0dXJlLCBCSU5EIHdvdWxkIGFsbG93IHRvIG1hbmFnZSBzdGFnZS0xIGFzIHdlbGw6DQo+ID4+
ICAgLSBiaW5kIGEgcHJvY2VzcyBwYWdlIGRpcmVjdG9yeSAoaG9zdCBTVk0gd2l0aCBhZGRlZCBz
dGFnZS0yKSwgb3INCj4gPg0KPiA+IEkgdGhvdWdodCBob3N0IFNWTSB3aWxsIG9ubHkgZ28gdGhy
b3VnaCBWRklPX1RZUEUxdjJfSU9NTVUsDQo+ID4gc2luY2UgeW91IHNhaWQgc3RhZ2UtMiBpbiBB
Uk0gU01NVSBpcyBvbmx5IGZvciBHUEEtPkhQQSB1c2FnZQ0KPiA+IGluIHByZXZpb3VzIGV4cGxh
bmF0aW9uLiB0aGVuIHdoYXQgZG9lcyAiaG9zdCBTVk0gd2l0aCBhZGRlZA0KPiA+IHN0YWdlLTIi
IG1lYW4gaGVyZT8NCj4gDQo+IEFoLCB0aGF0J3MganVzdCBhIGNyYXp5IGlkZWEgSSBoYWQuIEkn
bSBub3Qgc3VyZSBpdCBpcyB1c2VmdWwgb3Igd29ydGgNCj4gaW1wbGVtZW50aW5nLCBidXQgaXQg
aXMgb25lIG9mIHRoZSBwb3NzaWJpbGl0eSBvZmZlcmVkIGJ5IG5lc3RlZCB0cmFuc2xhdGlvbi4N
Cj4gDQo+IENvbnNpZGVyIHRoZSBzaXR1YXRpb24gd2hlcmUgYSB1c2Vyc3BhY2UgZHJpdmVyIChu
byB2aXJ0dWFsaXphdGlvbikgaXMNCj4gYnVpbHQgaW4gYSBjbGllbnQtc2VydmVyIGZhc2hpb246
IHRoZSBzZXJ2ZXIgY29udHJvbHMgYSBkZXZpY2UgYW5kIHNwYXducw0KPiBuZXcgcHJvY2Vzc2Vz
IChjbGllbnRzKSwgZWFjaCBzaGFyaW5nIGEgY29udGV4dCB3aXRoIHRoZSBkZXZpY2UgdXNpbmcg
aXRzDQo+IG93biBQQVNJRC4gSWYgdGhlIHNlcnZlciB3YW50cyB0byBoaWRlIHBhcnRzIG9mIHRo
ZSBjbGllbnQgYWRkcmVzcyBzcGFjZQ0KPiBmcm9tIHRoZSBkZXZpY2UgKGUuZy4gLnRleHQpLCB0
aGVuIGl0IGNvdWxkIGNvbnRyb2wgc3RhZ2UtMiB2aWEgTUFQL1VOTUFQDQo+IHRvIHJlc3RyaWN0
IHRoZSBhZGRyZXNzIHNwYWNlLg0KDQpzdGFnZS0xIGlzIGxpbmtlZCB0byBDUFUgcGFnZSB0YWJs
ZSAoVkEtPlBBKSBmb3IgU1ZNLCB3aGlsZSBwaHlzaWNhbCANCm1lbW9yeSBpcyBtYW5hZ2VkIGJ5
IGtlcm5lbC4gSSBkaWRuJ3QgY29tZSB1cCBhIGdvb2QgcmVhc29uIHdoeSANCnNlcnZlciBhcHBs
aWNhdGlvbiBuZWVkcyBvciBoYXMga25vd2xlZGdlIHRvIGhpZGUgc29tZSByZXNvdXJjZSANCndo
aWNoIGlzIG5vdCBtYW5hZ2VkIGJ5IGl0c2VsZi4uLg0KDQo+IA0KPiBJdCB3b3VsZCB1c2UgZGlm
ZmVyZW50IHNlbWFudGljcyBvZiBNQVAvVU5NQVAgdGhvdWdoLCBhcyB0aGUgaW9jdGwgd291bGQN
Cj4gb25seSBiZSB1c2VkIHRvIGRlZmluZSAxOjEgdHJhbnNsYXRpb24gd2luZG93cywgbm90IHBp
biBtZW1vcnkuDQo+IA0KPiBUaGFua3MsDQo+IEplYW4NCg==
