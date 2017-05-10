Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:18965
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751829AbdEJORJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 May 2017 10:17:09 -0400
From: Wesley Yung <wesley.yung@microsemi.com>
To: Keith Busch <keith.busch@intel.com>
CC: Wei Zhang <wzhang@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        "Krishna Dhulipala" <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Date: Wed, 10 May 2017 14:16:58 +0000
Message-ID: <2ED318EB-C159-4312-BE6C-0B833E18517A@microsemi.com>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
 <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>,<20170510131729.GD2572@localhost.localdomain>
In-Reply-To: <20170510131729.GD2572@localhost.localdomain>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T2ggSSBzZWUuIElmIHRoZSB3aG9sZSBzd2l0Y2ggaXMgcmVtb3ZlZCBpZiB0aGV5IHRyeSB0byBy
ZWFkIHRoZSBkc3BzIHRoYXQgd2VyZSB0aGVyZSB3b3VsZCByZXN1bHQgaW4gYSB0aW1lb3V0IGFu
ZCB0aGF0IGxvb2tzIGxpa2UgYWxsIDFzLiANCg0KQ2hlZXJzDQpXZXMNCg0KT24gTWF5IDEwLCAy
MDE3LCBhdCA2OjEwIEFNLCBLZWl0aCBCdXNjaCA8a2VpdGguYnVzY2hAaW50ZWwuY29tPiB3cm90
ZToNCg0KRVhURVJOQUwgRU1BSUwNCg0KDQo+IE9uIFdlZCwgTWF5IDEwLCAyMDE3IGF0IDAzOjM5
OjI3QU0gKzAwMDAsIFdlaSBaaGFuZyB3cm90ZToNCj4gSGkgS2VpdGggYW5kIFdlcywNCj4gDQo+
IEkgd29uZGVyIGlmIGdldHRpbmcgYW4gQWxsIDGhr3MgcmVhZCBvbiB0aGUgRFBDIHN0YXR1cyBy
ZWdpc3RlciBpcyBhDQo+IHZhbGlkIHNjZW5hcmlvLiAgIFRoZSBEUEMgcmVnaXN0ZXIgaXMgb24g
dGhlIHN3aXRjaCwgd2h5IHdvdWxkIHRoZQ0KPiBzdGF0dXMgcmVnaXN0ZXIgcmV0dXJucyBBbGwg
MaGvcyBldmVuIGlmIHRoZSBkZXZpY2UgaXMgcmVtb3ZlZD8NCg0KQWgsIHRoaXMgaXNuJ3QgYWJv
dXQgdGhlIGRvd25zdHJlYW0gZGV2aWNlIHByZWNlbnNlLiBUaGlzIGlzIGFib3V0DQp0aGUgRFBD
IHN3aXRjaCBkZXZpY2UgaXRzZWxmLCBsaWtlIGlmIHlvdSBwdWxsIHRoZSBjYWJsZSBvdXQgb2Yg
dGhlDQplbmNsb3N1cmUuIFJlYWRpbmcgYW55dGhpbmcgb2ZmIHRoZSBEU1BzIGluIGl0IHdpbGwg
c2VlIGFsbCAxJ3MuDQo=
