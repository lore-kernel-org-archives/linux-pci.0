Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21628 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbaLDMGr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 07:06:47 -0500
Message-Id: <201412041206.sB4C6XVQ009497@userz7022.oracle.com>
Date: Thu, 04 Dec 2014 07:06:24 -0500
Subject: Re: [PATCH v5 9/9] xen/pciback: Implement PCI reset slot or bus
 with 'do_flr' SysFS attribute
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ck9uIERlYyA0LCAyMDE0IDY6MzAgQU0sIERhdmlkIFZyYWJlbCA8ZGF2aWQudnJhYmVsQGNpdHJp
eC5jb20+IHdyb3RlOgo+Cj4gT24gMDMvMTIvMTQgMjE6NDAsIEtvbnJhZCBSemVzenV0ZWsgV2ls
ayB3cm90ZTogCj4gPiAKPiA+IEluc3RlYWQgb2YgZG9pbmcgYWxsIHRoaXMgY29tcGxleCBkYW5j
ZSwgd2UgZGVwZW5kIG9uIHRoZSB0b29sc3RhY2sgCj4gPiBkb2luZyB0aGUgcmlnaHQgdGhpbmcu
IEFzIHN1Y2ggaW1wbGVtZW50IHRoZSAnZG9fZmxyJyBTeXNGUyBhdHRyaWJ1dGUgCj4gPiB3aGlj
aCAneGwnIHVzZXMgd2hlbiBhIGRldmljZSBpcyBkZXRhY2hlZCBvciBhdHRhY2hlZCBmcm9tL3Rv
IGEgZ3Vlc3QuIAo+ID4gSXQgYnlwYXNzZXMgdGhlIG5lZWQgdG8gd29ycnkgYWJvdXQgdGhlIFBD
SSBsb2NrLiAKPgo+IE5vLsKgIEdldCBwY2liYWNrIHRvIGFkZCBpdHMgb3duICJyZXNldCIgc3lz
ZnMgZmlsZSAoYXMgSSBoYXZlIHJlcGVhdGVkbHkgCj4gcHJvcG9zZWQpLiAKPgoKV2hpY2ggZG9l
cyBub3Qgd29yayBhcyB0aGUga29iaiB3aWxsIGNvbXBsYWluIChhcyB0aGVyZSBpcyBhbHJlYWR5
IGFuICdyZXNldCcgYXNzb2NpYXRlZCB3aXRoIHRoZSBQQ0kgZGV2aWNlKS4KClVubGVzcyB5b3Ug
bWVhbiBhbiBkaWZmZXJlbnQgbmFtZSAocmVzZXQyKS4KCj4gRGF2aWQgCg==

