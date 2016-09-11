Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753947AbcIKNTp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Sep 2016 09:19:45 -0400
From: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
To: Andreas Noever <andreas.noever@gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        thunderbolt-linux <thunderbolt-linux@intel.com>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH v6 2/8] thunderbolt: Updating the register definitions
Date: Sun, 11 Sep 2016 13:19:38 +0000
Message-ID: <E607265CB020454880711A6F96C05A03AA3F434E@hasmsx107.ger.corp.intel.com>
References: <1470054233-4309-1-git-send-email-amir.jer.levy@intel.com>
 <1470054233-4309-3-git-send-email-amir.jer.levy@intel.com>
 <CAMxnaaUnY5XtXWpYPbeZiXqEJYJ6_RprCPCEwG-_G4NB3PUTNQ@mail.gmail.com>
In-Reply-To: <CAMxnaaUnY5XtXWpYPbeZiXqEJYJ6_RprCPCEwG-_G4NB3PUTNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gU3VuLCBTZXAgMTEgMjAxNiwgMDM6MDIgQU0sIEFuZHJlYXMgTm9ldmVyIHdyb3RlOg0KPiBP
biBNb24sIEF1ZyAxLCAyMDE2IGF0IDI6MjMgUE0sIEFtaXIgTGV2eSA8YW1pci5qZXIubGV2eUBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+IEFkZGluZyBtb3JlIFRodW5kZXJib2x0KFRNKSByZWdpc3Rl
ciBkZWZpbml0aW9ucyBhbmQgc29tZSBoZWxwZXINCj4gPiBtYWNyb3MuDQo+IA0KPiBUaGlua2lu
ZyBhYm91dCB0aGlzIGFnYWluIEkgd291bGQgcHJlZmVyIGl0IGlmIHlvdSB3b3VsZCBwdXQgeW91
ciBkZWZpbml0aW9ucw0KPiBpbnRvIGEgc2VwYXJhdGUgZmlsZSB1bmRlciBpY20vIChldmVuIGlm
IHRoZXJlIGlzIHNvbWUgZHVwbGljYXRpb24pLiBUaGUgc3R5bGUNCj4gKGJpdGZpZWxkcyB2cy4g
Z2VubWFzaykgaXMgZGlmZmVyZW50IGJldHdlZW4gdGhlIGRyaXZlcnMgYW5kIGZvciBhIHJlYWRl
ciBpdCBpcw0KPiBkaWZmaWN1bHQgdG8gZmluZCBvdXQgd2hhdCBpcyBhY3R1YWxseSBzdXBwb3Nl
ZCB0byBiZSB1c2VkIGJ5IHRoZSB0d28gZHJpdmVycw0KPiAocmluZ19kZXNjIHZzIHRidF9idWZf
ZGVzYyBvciB0aGUgcmluZyBSSU5HX0lOVF9FTi9ESVNBQkxFIG1hY3JvcyBpbiB0aGUNCj4gaGVh
ZGVyIGZpbGUgdnMuIHJpbmdfaW50ZXJydXB0X2FjdGl2ZSBpbiBuaGkuYykuDQo+IA0KPiBUaGlz
IHdvdWxkIGFsc28gY29tcGxldGVseSBzZXBhcmF0ZSB0aGUgdHdvIGRyaXZlcnMuDQo+IA0KPiBB
bmRyZWFzDQo+IA0KDQpJJ20gYWxzbyBpbiBmYXZvciBvZiBjb21wbGV0ZWx5IHNlcGFyYXRpbmcg
dGhlIGRyaXZlcnMsIGJ1dCBpcyBpdCB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gd2l0aCB0aGUgcmVn
aXN0ZXIgZGVmaW5pdGlvbnMNCndoZW4gdGhlIHVuZGVybHlpbmcgcmVnaXN0ZXJzIGxheW91dCBp
cyBleGFjdGx5IHRoZSBzYW1lPw0KDQpOb3RlIHRoYXQgYml0ZmllbGRzIGFyZSBub3Qgc28gcmVj
b21tZW5kZWQgd2hlbiB5b3UgY2FyZSBhYm91dCB0aGUgZm9ybWF0L29yZGVyIG9mIGJpdHMsIGxp
a2UgaW4gdGhlIHJpbmcgZGVzY3JpcHRvci4NCg0KQW1pcg0K
