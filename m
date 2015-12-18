Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:44370 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932469AbbLRNoJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 08:44:09 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Wolfram Sang <wsa@the-dreams.de>
CC: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Subject: RE: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling
 in pcie-rcar
Date: Fri, 18 Dec 2015 13:44:04 +0000
Message-ID: <PS1PR06MB1180C86CD41FE69F44387D59F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
	<1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
	<20151217133058.GA20372@katana>
 <CAMuHMdWfOo7=g9F_qmhM65yct0P=F3QvkVkHMggBJRLA0gCPYQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWfOo7=g9F_qmhM65yct0P=F3QvkVkHMggBJRLA0gCPYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gMTcgRGVjZW1iZXIgMjAxNSAxMzo0MSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBP
biBUaHUsIERlYyAxNywgMjAxNSBhdCAyOjMwIFBNLCBXb2xmcmFtIFNhbmcgPHdzYUB0aGUtZHJl
YW1zLmRlPiB3cm90ZToNCj4gPj4gKyAgICAgICAgICAgICAvKiBXYWl0IHVudGlsIHdlIGFyZSBp
biBMMSAqLw0KPiA+PiArICAgICAgICAgICAgIHdoaWxlICghKHZhbCAmIEwxRkFFRykpDQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICB2YWwgPSByY2FyX3BjaV9yZWFkX3JlZyhwY2llLCBQTVNS
KTsNCj4gPg0KPiA+IE5vIHRpbWVvdXQ/DQo+IA0KPiBBbmQgbm8gY3B1X3JlbGF4KCkgaW4gZWFj
aCBpdGVyYXRpb24uDQpTdXJlLCBJJ2xsIGZpeCB0aGF0Lg0KDQpUaGFua3MNClBoaWwNCg0KIA0K
PiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0
DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4
IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBj
b252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tl
ci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJv
Z3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
