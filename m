Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbdHDBtm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 21:49:42 -0400
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
Date: Fri, 4 Aug 2017 01:49:38 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D57191@SHSMSX101.ccr.corp.intel.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
In-Reply-To: <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXINCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDEs
IDIwMTcgNDoyNiBQTQ0KPiANCj4gSXQgZGVwZW5kcyB3aGF0IHR5cGUgeW91IHVzZSB3aGVuIHJl
Z2lzdGVyaW5nIHRoZSBJT01NVSB3aXRoDQo+IFZGSU9fU0VUX0lPTU1VOg0KPiANCj4gKiBJZiB0
aGUgdHlwZSBpcyBWRklPX1RZUEUxdjJfSU9NTVUsIHRoZW4NCj4gVkZJT19JT01NVV9NQVAvVU5N
QVBfRE1BDQo+ICAgYWZmZWN0cyB0aGUgc3RhZ2UtMSBub24tUEFTSUQgY29udGV4dCAoYWxyZWFk
eSB0aGUgY2FzZSBpbiBtYWlubGluZSkuDQo+ICAgSW4gYWRkaXRpb24sIHdpdGggbXkgcGF0Y2gg
dGhlIEJJTkQgaW9jdGwgd2lsbCBhZmZlY3Qgc3RhZ2UtMSBQQVNJRA0KPiAgIGNvbnRleHRzLCBh
bmQgYmluZCBwcm9jZXNzIHBhZ2UgZGlyZWN0b3JpZXMgdG8gdGhlIGRldmljZSAoaG9zdCBTVk0p
Lg0KPiANCj4gKiBJZiB0aGUgdHlwZSBpcyBWRklPX1RZUEUxX05FU1RJTkdfSU9NTVUsIHRoZW4N
Cj4gVkZJT19JT01NVV9NQVAvVU5NQVBfRE1BDQo+ICAgd2lsbCBhZmZlY3Qgc3RhZ2UtMiBtYXBw
aW5ncyAoYWxyZWFkeSBpbiBtYWlubGluZSkuDQo+ICAgV2l0aCBteSBTTU1VIHBhdGNoIHNlcmll
cywgdGhlIEJJTkQgaW9jdGwgaXMgbm90IHN1cHBvcnRlZCBpbiB0aGlzIG1vZGUuDQo+ICAgQnV0
IGluIHRoZSBmdXR1cmUsIEJJTkQgd291bGQgYWxsb3cgdG8gbWFuYWdlIHN0YWdlLTEgYXMgd2Vs
bDoNCj4gICAtIGJpbmQgYSBwcm9jZXNzIHBhZ2UgZGlyZWN0b3J5IChob3N0IFNWTSB3aXRoIGFk
ZGVkIHN0YWdlLTIpLCBvcg0KDQpJIHRob3VnaHQgaG9zdCBTVk0gd2lsbCBvbmx5IGdvIHRocm91
Z2ggVkZJT19UWVBFMXYyX0lPTU1VLA0Kc2luY2UgeW91IHNhaWQgc3RhZ2UtMiBpbiBBUk0gU01N
VSBpcyBvbmx5IGZvciBHUEEtPkhQQSB1c2FnZQ0KaW4gcHJldmlvdXMgZXhwbGFuYXRpb24uIHRo
ZW4gd2hhdCBkb2VzICJob3N0IFNWTSB3aXRoIGFkZGVkIA0Kc3RhZ2UtMiIgbWVhbiBoZXJlPw0K
DQo+ICAgLSBiaW5kIGEgZ3Vlc3QgcGFnZSBkaXJlY3RvcnkgKHZpb21tdSksIG9yDQo+ICAgLSBi
aW5kIHRoZSBmdWxsIHN0YWdlLTEgY29udGV4dCB0YWJsZSAodmlvbW11KS4NCj4gDQo+IFRoYW5r
cywNCj4gSmVhbg0K
