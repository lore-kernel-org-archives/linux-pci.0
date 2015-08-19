Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17243 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbbHSOca (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 10:32:30 -0400
From: William Davis <wdavis@nvidia.com>
To: Konrad Wilk <konrad.wilk@oracle.com>
CC: Terence Ripperda <TRipperda@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"John Hubbard" <jhubbard@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"markh@compro.net" <markh@compro.net>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH v5 04/13] DMA-API: Introduce dma_(un)map_peer_resource
Date: Wed, 19 Aug 2015 14:32:28 +0000
Message-ID: <6dc99896b40345cfbc35b4da9b370bbd@HQMAIL106.nvidia.com>
References: <2dd0ce48-fb6e-4003-90ee-33827ebfc7c1@default>
In-Reply-To: <2dd0ce48-fb6e-4003-90ee-33827ebfc7c1@default>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiA+ICsjaWZkZWYgQ09ORklHX0hBU19ETUFfUDJQDQo+ID4gK3N0YXRpYyBpbmxpbmUgZG1hX3Bl
ZXJfYWRkcl90IGRtYV9tYXBfcGVlcl9yZXNvdXJjZV9hdHRycyhzdHJ1Y3QNCj4gPiBkZXZpY2Ug
KmRldiwNCj4gPiArCQkJCQkJCSAgc3RydWN0IGRldmljZSAqcGVlciwNCj4gPiArCQkJCQkJCSAg
c3RydWN0IHJlc291cmNlICpyZXMsDQo+ID4gKwkJCQkJCQkgIHNpemVfdCBvZmZzZXQsDQo+ID4g
KwkJCQkJCQkgIHNpemVfdCBzaXplLA0KPiA+ICsJCQkJCQkJICBlbnVtIGRtYV9kYXRhX2RpcmVj
dGlvbiBkaXIsDQo+ID4gKwkJCQkJCQkgIHN0cnVjdCBkbWFfYXR0cnMgKmF0dHJzKQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgZG1hX21hcF9vcHMgKm9wcyA9IGdldF9kbWFfb3BzKGRldik7DQo+ID4g
KwlkbWFfcGVlcl9hZGRyX3QgYWRkcjsNCj4gPiArDQo+ID4gKwlCVUdfT04oIXZhbGlkX2RtYV9k
aXJlY3Rpb24oZGlyKSk7DQo+ID4gKwlCVUdfT04ob3BzLT5tYXBfcGVlcl9yZXNvdXJjZSA9PSBO
VUxMKTsNCj4gPiArCWFkZHIgPSBvcHMtPm1hcF9wZWVyX3Jlc291cmNlKGRldiwgcGVlciwgcmVz
LCBvZmZzZXQsIHNpemUsIGRpciwNCj4gPiArCQkJCSAgICAgIGF0dHJzKTsNCj4gPiArCWRlYnVn
X2RtYV9tYXBfcGVlcl9yZXNvdXJjZShkZXYsIHBlZXIsIHJlcywgb2Zmc2V0LCBzaXplLCBkaXIs
DQo+ID4gYWRkcik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGFkZHI7DQo+ID4gKw0KPiANCj4gV2l0
aCB0aG9zZSAnQlVHX09OJyB5b3UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCBldmVyeSBkbWFfbWFw
X29wcyBoYXMNCj4gdGhpcyBpbXBsZW1lbnRlZC4gVGhhdCBtZWFucyB0aGUgY2FsZ2FyeV9kbWFf
b3BzLCBnYXJ0X2RtYV9vcHMsIHN3aW90bGJfZG1hX29wcywNCj4gYW5kIHhlbl9zd2lvdGxiX2Rt
YV9vcHMgTVVTVCBoYXZlIHNvbWV0aGluZyBpbXBsZW1lbnRlZC4NCj4gDQo+IFBsZWFzZSBrZWVw
IGluIG1pbmQgdGhhdCBvbiBvbmUgY2FuIGRvICdpb21tdT1zb2Z0IHN3aW90Ymw9Zm9yY2UnIG9u
IHRoZQ0KPiBjb21tYW5kIGxpbmUgd2hpY2ggd2lsbCBmb3JjZSB0aGUgSU9NTVVzIHRvIGJlIGln
bm9yZWQgYW5kIG9ubHkgdGhlDQo+IFNXSU9UTEIgY29kZSB3aWxsIGJlIHVzZWQuDQoNClRoYW5r
cyBmb3IgdGhlIGZlZWRiYWNrLCBLb25yYWQuIEkgd2lsbCBhZGQgaW1wbGVtZW50YXRpb25zIGZv
ciB0aG9zZQ0KZG1hX21hcF9vcHMgaW4gdjYuDQoNCldpbGwNCg0KLS0NCm52cHVibGljDQo=
