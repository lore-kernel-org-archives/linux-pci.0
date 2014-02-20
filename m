Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:58681 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752882AbaBTL7H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 06:59:07 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
	"jg1.han@samsung.com" <jg1.han@samsung.com>
Cc: Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Bjorn Helgaas <bhelgass@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 20 Feb 2014 19:58:51 +0800
Subject: RE: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
 and mem viewport
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD40D8B3@EAPEX1MAIL1.st.com>
References: <1392873774-22249-1-git-send-email-mohit.kumar@st.com>
 <1392873774-22249-2-git-send-email-mohit.kumar@st.com>
 <5305E928.5070505@ti.com>
In-Reply-To: <5305E928.5070505@ti.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGVsbG8gS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtp
c2hvbiBWaWpheSBBYnJhaGFtIEkgW21haWx0bzpraXNob25AdGkuY29tXQ0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgMjAsIDIwMTQgNTowOCBQTQ0KPiBUbzogTW9oaXQgS1VNQVIgRENHOyBq
ZzEuaGFuQHNhbXN1bmcuY29tDQo+IENjOiBBamF5IEtIQU5ERUxXQUw7IEJqb3JuIEhlbGdhYXM7
IHNwZWFyLWRldmVsOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDIvMl0gUENJOmRlc2lnbndhcmU6Rml4IGlBVFUgcHJvZ3JhbW1pbmcgZm9yIGNm
ZzEsIGlvDQo+IGFuZCBtZW0gdmlld3BvcnQNCj4gDQo+IEhpLA0KPiANCj4gT24gVGh1cnNkYXkg
MjAgRmVicnVhcnkgMjAxNCAxMDo1MiBBTSwgTW9oaXQgS3VtYXIgd3JvdGU6DQo+ID4gVGhpcyBw
YXRjaCBjb3JyZWN0IGlBVFUgcHJvZ3JhbW1pbmcgZm9yIGNmZzEsIGlvIGFuZCBtZW0gdmlld3Bv
cnQuDQo+ID4gRW5hYmxlIEFUVSBvbmx5IGFmdGVyIGNvbmZpZ3VyaW5nIGl0Lg0KPiANCj4gRG9l
cyB0aGlzIHBhdGNoIGFjdHVhbGx5IGZpeGVzIGRldmljZSBlbnVtZXJhdGlvbiBiZWhpbmQgYSBQ
Q0llLXBjaSBicmlkZ2Ugb3INCj4gdGhpcyBpcyBtb3JlIG9mIGNsZWFuaW5nIHVwIHRoZSBzZXF1
ZW5jZT8NCj4gDQotIFRoaXMgcGF0Y2ggY29ycmVjdHMgQVRVIHByb2dyYW1taW5nIHNlcXVlbmNl
LiBJIGFtIG5vdCBhd2FyZSBvZiBhbnkgc3VjaCBpc3N1ZSB3aXRoDQpjdXJyZW50IGRyaXZlci4g
UGxzIHNwZWNpZnkgIHdoaWNoIGJyaWRnZSBkbyB5b3UgdXNlIGluIHlvdXIgc2V0dXAgYW5kIHdo
YXQgaXMgdGhlIHByb2JsZW0/DQoNClJlZ2FyZHMNCk1vaGl0DQo=
