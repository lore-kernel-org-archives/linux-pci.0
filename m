Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:19592 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbLOWbJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2015 17:31:09 -0500
Received: from g4t3427.houston.hp.com (g4t3427.houston.hp.com [15.201.208.55])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id 562F1F4E
	for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2015 22:31:09 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
	(using TLSv1.2 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g4t3427.houston.hp.com (Postfix) with ESMTPS id 5B2A165
	for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2015 22:31:08 +0000 (UTC)
From: "Seymour, Shane M" <shane.seymour@hpe.com>
To: noman pouigt <variksla@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Adding support for new amplifier on ACPI platform
Date: Tue, 15 Dec 2015 22:29:43 +0000
Message-ID: <DDB9C85B850785449757F9914A034FCB444F74B2@G4W3219.americas.hpqcorp.net>
References: <CAES_P+9oHnH5JzCZnO9eF-b__Vt+_dxLZ+jFWMX16JMEDXtaVA@mail.gmail.com>
In-Reply-To: <CAES_P+9oHnH5JzCZnO9eF-b__Vt+_dxLZ+jFWMX16JMEDXtaVA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBxdWVzdGlvbjogRG8gaSBuZWVkIHRvIHJlZ2lzdGVyIG91ciBkZXZpY2Ugd2l0aCB0aGlzIGRh
dGFiYXNlPw0KPiBIb3cgY2FuIGkgZ2V0IHRoZSBhY3BpIHN0cmluZyBhcyBzaG93biBpbiB0aGlz
IHBhdGNoPw0KDQpBIGdvb2dsZSBzZWFyY2ggZm9yICJBQ1BJIGlkIHJlZ2lzdHJhdGlvbiIgZ2l2
ZXMgdGhpcyBhcyB0aGUgZmlyc3QgaGl0Og0KDQpodHRwOi8vd3d3LnVlZmkub3JnL1BOUF9BQ1BJ
X1JlZ2lzdHJ5DQoNCkkgYmVsaWV2ZSBpdCBoYXMgd2hhdCB5b3Ugd2FudC4gWW91IGRpZCBsb29r
IGRpZG4ndCB5b3U/DQoNCklmIHlvdXIgZGV2aWNlIGlzIG5vdCBhIFBDSSBkZXZpY2UgcmVxdWVz
dCBhbiBBQ1BJIGlkIGZyb20gdGhlIEFDUEkgU3BlY2lmaWNhdGlvbg0KV29ya2dyb3VwIENoYWly
cGVyc29uLiBGaXJzdCBjaGVjayB0aGF0IHlvdXIgdmVuZG9yIGRvZXMgbm90IGhhdmUgYW4gQUNQ
SSBpZA0KYWxyZWFkeSByZWdpc3RlcmVkLiBJZiBpdCBpcyBhIFBDSSBkZXZpY2UgeW91IHdpbGwg
bmVlZCBhIFBDSSB2ZW5kb3IgaWQgZnJvbQ0KdGhlIFBDSS1TSUcuIFRvIGdldCBhIFBDSSB2ZW5k
b3IgaWQgcmVnaXN0ZXJlZCB3aXRoIHRoZSBQQ0ktU0lHIHlvdSBtdXN0IGJlIGENCm1lbWJlciAt
IHRoYXQgaXMgbm90IGZyZWUgKHNlZSBodHRwczovL3BjaXNpZy5jb20vbWVtYmVyc2hpcCkuDQoN
CklmIHlvdSBtYWtlIGEgcmVxdWVzdCBmb3IgYW4gQUNQSSBpZCBJJ2Qgc3Ryb25nbHkgcmVjb21t
ZW5kIHRoYXQgeW91IG1ha2UNCnRoZSByZXF1ZXN0IGZyb20gYSB3b3JrIGJhc2VkIGVtYWlsIG5v
dCBhIGdtYWlsIGFjY291bnQgb3IgdGhhdCB0aGUgdmVuZG9yDQp5b3UgYXJlIHdvcmtpbmcgd2l0
aCBtYWtlcyB0aGUgcmVxdWVzdCBpbnN0ZWFkLiBJIGRvIG5vdCBrbm93IGlmIHRoZXkgd2lsbA0K
Z3JhbnQgYSBuZXcgQUNQSSBpZCBmb3IgYSBjb21wYW55IGlmIHlvdSBjYW5ub3Qgc2hvdyBhbnkg
Y29ubmVjdGlvbiB0byB0aGF0DQpjb21wYW55Lg0K
