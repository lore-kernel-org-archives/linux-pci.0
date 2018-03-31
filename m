Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0136.outbound.protection.outlook.com ([104.47.33.136]:16256
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752759AbeCaAtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 20:49:12 -0400
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Date: Sat, 31 Mar 2018 00:49:09 +0000
Message-ID: <F31FD99A-2356-4659-BEC1-91CAE1920B90@microsoft.com>
References: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
 <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
 <20180330212311.GB9322@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180330212311.GB9322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CT5PbiAzLzMwLzE4LCAyOjIzIFBNLCAiQmpvcm4gSGVsZ2FhcyIgPGhlbGdhYXNAa2VybmVsLm9y
Zz4gd3JvdGU6DQoJPiAgID5PbiBGcmksIE1hciAzMCwgMjAxOCBhdCAwNzozNTowNFBNICswMDAw
LCBTcmlkaGFyIFBpdGNoYWkgd3JvdGU6DQoJPiAgID5jb21taXQgNGE5YjA5MzNiZGZjICgiUENJ
OiBodjogVXNlIGRldmljZSBzZXJpYWwgbnVtYmVyIGFzIFBDSQ0KCT4gICA+ZG9tYWluIikgbmVl
ZCB0byBiZSByZXZlcnRlZC4gQWxzbywgd2Ugbm8gbG9uZ2VyIG5lZWQgaXQgYXMgY29tbWl0DQoJ
PiAgID40YTE2MjZkZDIzM2UgKCJuZXR2c2M6IHRyYW5zcGFyZW50IFZGIG1hbmFnZW1lbnQiKSBy
ZW1vdmUgdGhlDQoJPiAgID5uZWVkIGZvciBpdC4NCgk+DQoJPkRvIHlvdSBtZWFuIDBjMTk1NTY3
YThmNiAoIm5ldHZzYzogdHJhbnNwYXJlbnQgVkYgbWFuYWdlbWVudCIpPw0KCT4NCgk+SSBkb24n
dCBzZWUgYSA0YTE2MjZkZDIzM2UgY29tbWl0IGluIExpbnVzJyB0cmVlLg0KCT4NCg0KVGhhdCBp
cyByaWdodC4gc2hhIHNob3VsZCBiZSA0YTE2MjZkZDIzM2UuDQoNCgk+VGhlIGNvbm5lY3Rpb24g
YmV0d2VlbiAwYzE5NTU2N2E4ZjYgKCJuZXR2c2M6IHRyYW5zcGFyZW50IFZGDQoJPm1hbmFnZW1l
bnQiKSBhbmQgdGhpcyBIeXBlci1WIGRvbWFpbiBJRCBpc3N1ZSBpcyBub3QgY2xlYXIgdG8gbWUg
YXQNCgk+YWxsLiAgQnV0IG9idmlvdXNseSBJJ20gbm90IGEgbmV0d29ya2luZyBvciBhIEh5cGVy
LVYgcGVyc29uLg0KCT4NCgk+QSBoaW50IGluIHRoZSBjaGFuZ2Vsb2cgYWJvdXQgd2hhdCB0aGF0
IGNvbm5lY3Rpb24gaXMgd291bGQgYmUgbmljZS4NCgk+DQoJPiAgID5SZXZlcnQgY29tbWl0IDRh
OWIwOTMzYmRmYyAoIlBDSTogaHY6IFVzZSBkZXZpY2Ugc2VyaWFsIG51bWJlciBhcyBQQ0kNCgk+
ICAgPmRvbWFpbiIpIHNvIHdlIGNhbiByZWxpYWJseSBzdXBwb3J0IG11bHRpcGxlIGRldmljZXMg
YmVpbmcgYXNzaWduZWQgdG8NCgk+ICAgPmEgZ3Vlc3QuDQoJPiAgID4NCgk+ICAgPlRoaXMgcmV2
ZXJ0IHNob3VsZCBvbmx5IGJlIGJhY2twb3J0ZWQgdG8ga2VybmVscyB0aGF0IGNvbnRhaW4gY29t
bWl0DQoJPiAgID40YTE2MjZkZDIzM2UgKCJuZXR2c2M6IHRyYW5zcGFyZW50IFZGIG1hbmFnZW1l
bnQiKS4NCgk+ICAgPg0KCT4gICA+Rml4ZXM6IDRhOWIwOTMzYmRmYyAoIlBDSTogaHY6IFVzZSBk
ZXZpY2Ugc2VyaWFsIG51bWJlciBhcyBQQ0kgZG9tYWluIikNCgk+ICAgPlNpZ25lZC1vZmYtYnk6
IFNyaWRoYXIgUGl0Y2hhaSA8c3JpZGhhci5waXRjaGFpQG1pY3Jvc29mdC5jb20+DQoJPiAgID5D
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KCT4NCgk+VGhpcyBiYWNrcG9ydGluZyBndWlkYW5j
ZSBpcyB2ZXJ5IGNvbmZ1c2luZy4NCgk+DQoJPjRhOWIwOTMzYmRmYyAoIlBDSTogaHY6IFVzZSBk
ZXZpY2Ugc2VyaWFsIG51bWJlciBhcyBQQ0kgZG9tYWluIikNCgk+YXBwZWFyZWQgaW4gdjQuMTEu
DQoJPg0KCT4wYzE5NTU2N2E4ZjYgKCJuZXR2c2M6IHRyYW5zcGFyZW50IFZGIG1hbmFnZW1lbnQi
KSBhcHBlYXJlZCBpbiB2NC4xNC4NCgk+DQoJPlRoZSBjaGFuZ2Vsb2cgYW5kIHRoZSAiRml4ZXMi
IHRhZyBib3RoIHN1Z2dlc3QgdGhhdCA0YTliMDkzM2JkZmMgd2FzDQoJPmZsYXQtb3V0IGJ1Z2d5
IGFuZCBzaG91bGQgYmUgcmV2ZXJ0ZWQgdW5jb25kaXRpb25hbGx5LiAgVGhhdCB3b3VsZA0KCT5t
ZWFuIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFwcGxpZWQgdG8gdjQuMTEgYW5kIGxhdGVyIHN0YWJs
ZSBrZXJuZWxzLg0KCT4NCgk+QnV0IHRoZSBjaGFuZ2Vsb2cgYWxzbyBzYXlzICJvbmx5IHJldmVy
dCA0YTliMDkzM2JkZmMgaWYgeW91IGhhdmUNCgk+MGMxOTU1NjdhOGY2Ii4gIFRoYXQgd291bGQg
bWVhbiB0aGlzIHBhdGNoIHNob3VsZCBvbmx5IGJlIGFwcGxpZWQgdG8NCgk+djQuMTQgYW5kIGxh
dGVyIHN0YWJsZSBrZXJuZWxzLg0KCT4NCgk+V2hpY2ggaXMgaXQ/ICBZb3UgY2FuIGFuc3dlciBp
biB0aGlzIHRocmVhZCBpZiB5b3Ugd2FudCwgYnV0IExvcmVuem8NCgk+d2lsbCB1bHRpbWF0ZWx5
IGJlIGxvb2tpbmcgZm9yIGEgdjYgcGF0Y2ggd2l0aCBhIGNvcnJlY3RlZCBjaGFuZ2Vsb2cuDQoN
Ckl0IGlzIHRoZSBDYXNlIDEuIFdlIGp1c3QgbmVlZCB0byByZXZlcnQgNGE5YjA5MzNiZGZjLiBJ
IHdpbGwgcmVtb3ZlIHRoZQ0KcmVmZXJlbmNlIHRvIDBjMTk1NTY3YThmNiBhbHRvZ2V0aGVyIGlu
IHRoZSBjb21taXQgbWVzc2FnZS4NCg0KCT4NCgk+SSB0aGluayBMb3JlbnpvIGlzIG91dCB0aGlz
IHdlZWssIGJ1dCBJIHN1c3BlY3QgaGUnbGwgbG9vayBhdCBpdCBuZXh0DQoJPndlZWsuDQoJPg0K
CT5Cam9ybg0KDQpJIHdpbGwgc2VuZCBvdXQgdGhlIHVwZGF0ZSBwYXRjaCB2ZXJzaW9uIDYuDQoN
ClRoYW5rcywNClNyaWRoYXIgUGl0Y2hhaSANCg0K
