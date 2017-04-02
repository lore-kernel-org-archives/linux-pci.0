Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22763 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdDBO7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Apr 2017 10:59:15 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        "zhichang.yuan" <zhichang.yuan02@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Yuanzhichang <yuanzhichang@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        Zou Rongrong <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
Date: Sun, 2 Apr 2017 14:58:17 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E204E0BF7@FRAEML521-MBX.china.huawei.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
 <1908501.jAQQKvjW4f@aspire.rjw.lan> <58DDFCBE.1030705@hisilicon.com>
 <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com>
 <bfdf2de0-c309-0139-4075-dfcd678b6d51@gmail.com>
 <CAJZ5v0iYD=2HVP9D-2fBBDUzkOJLrzzH7Rwg1ALQ-kBx-iSeTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iYD=2HVP9D-2fBBDUzkOJLrzzH7Rwg1ALQ-kBx-iSeTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgUmFmYWVsIA0KTWFueSB0aGFua3MgZm9yIHlvdXIgcmVwbHkNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiByand5c29ja2lAZ21haWwuY29tIFttYWlsdG86cmp3eXNv
Y2tpQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mDQo+IFJhZmFlbCBKLiBXeXNvY2tpDQo+IFNlbnQ6
IDAxIEFwcmlsIDIwMTcgMTA6NTINCj4gVG86IHpoaWNoYW5nLnl1YW4NCj4gQ2M6IFJhZmFlbCBK
LiBXeXNvY2tpOyBZdWFuemhpY2hhbmc7IFJhZmFlbCBKLiBXeXNvY2tpOyBDYXRhbGluDQo+IE1h
cmluYXM7IFdpbGwgRGVhY29uOyBSb2IgSGVycmluZzsgRnJhbmsgUm93YW5kOyBCam9ybiBIZWxn
YWFzOyBBcm5kDQo+IEJlcmdtYW5uOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IE1hcmsgUnV0bGFuZDsgQnJpYW4NCj4gU3RhcmtleTsgT2xvZiBKb2hhbnNzb247IExvcmVu
em8gUGllcmFsaXNpOyBCZW5qYW1pbiBIZXJyZW5zY2htaWR0Ow0KPiBMaW51eCBLZXJuZWwgTWFp
bGluZyBMaXN0OyBBQ1BJIERldmVsIE1hbGluZyBMaXN0OyBMaW51eGFybTsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IFBDSTsgQ29yZXkgTWlueWFyZDsgWm91IFJvbmdyb25n
Ow0KPiBKb2huIEdhcnJ5OyBHYWJyaWVsZSBQYW9sb25pOyBrYW50eXpjQDE2My5jb207IHh1d2Vp
IChPKQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY4IDUvNl0gQUNQSTogU3VwcG9ydCB0aGUgcHJv
YmluZyBvbiB0aGUgZGV2aWNlcw0KPiB3aGljaCBhcHBseSBpbmRpcmVjdC1JTw0KPiANCj4gT24g
U2F0LCBBcHIgMSwgMjAxNyBhdCA0OjE2IEFNLCB6aGljaGFuZy55dWFuDQo+IDx6aGljaGFuZy55
dWFuMDJAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gMDQvMDEvMjAxNyAwNzow
MiBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4+IE9uIEZyaSwgTWFyIDMxLCAyMDE3
IGF0IDg6NTIgQU0sIHpoaWNoYW5nLnl1YW4NCj4gPj4gPHl1YW56aGljaGFuZ0BoaXNpbGljb24u
Y29tPiB3cm90ZToNCj4gPj4+IEhpLCBSYWZhZWwsDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciBy
ZXZpZXdpbmcgdGhpcyENCj4gPj4+DQo+ID4+PiBPbiAyMDE3LzMvMzEgNDozMSwgUmFmYWVsIEou
IFd5c29ja2kgd3JvdGU6DQo+ID4+Pj4gT24gVGh1cnNkYXksIE1hcmNoIDMwLCAyMDE3IDExOjI2
OjU4IFBNIHpoaWNoYW5nLnl1YW4gd3JvdGU6DQo+ID4+Pj4+IE9uIHNvbWUgcGxhdGZvcm1zKHN1
Y2ggYXMgSGlwMDYvSGlwMDcpLCB0aGUgbGVnYWN5IElTQS9MUEMNCj4gZGV2aWNlcyBhY2Nlc3Mg
SS9PDQo+ID4+Pj4+IHdpdGggc29tZSBzcGVjaWFsIGhvc3QtbG9jYWwgSS9PIHBvcnRzIGtub3du
IG9uIHg4Ni4gVG8gYWNjZXNzDQo+IHRoZSBJL08NCj4gPj4+Pj4gcGVyaXBoZXJhbHMsIGFuIGlu
ZGlyZWN0LUlPIG1lY2hhbmlzbSBpcyBpbnRyb2R1Y2VkIHRvIG1hcHBlZCB0aGUNCj4gaG9zdC1s
b2NhbA0KPiA+Pj4+PiBJL08gdG8gc3lzdGVtIGxvZ2ljYWwvZmFrZSBQSU8gc2ltaWxhciB0aGUg
UENJIE1NSU8gb24NCj4gYXJjaGl0ZWN0dXJlcyB3aGVyZSBubw0KPiA+Pj4+PiBzZXBhcmF0ZSBJ
L08gc3BhY2UgZXhpc3RzLiBKdXN0IGFzIFBDSSBNTUlPLCB0aGUgaG9zdCBJL08gcmFuZ2UNCj4g
c2hvdWxkIGJlDQo+ID4+Pj4+IHJlZ2lzdGVyZWQgYmVmb3JlIHByb2JpbmcgdGhlIGRvd25zdHJl
YW0gZGV2aWNlcyBhbmQgc2V0IHVwIHRoZQ0KPiBJL08gbWFwcGluZy4NCj4gPj4+Pj4gQnV0IGN1
cnJlbnQgQUNQSSBidXMgcHJvYmluZyBkb2Vzbid0IHN1cHBvcnQgdGhlc2UgaW5kaXJlY3QtSU8N
Cj4gaG9zdHMvZGV2aWNlcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhpcyBwYXRjaCBpbnRyb2R1ZWNl
cyBhIG5ldyBBQ1BJIGhhbmRsZXIgZm9yIHRoaXMgZGV2aWNlDQo+IGNhdGVnb3J5LiBUaHJvdWdo
IHRoZQ0KPiA+Pj4+PiBoYW5kbGVyIGF0dGFjaCBjYWxsYmFjaywgdGhlIGluZGlyZWN0LUlPIGhv
c3RzIEkvTyByZWdpc3RyYXRpb24NCj4gaXMgZG9uZSBhbmQNCj4gPj4+Pj4gYWxsIHBlcmlwaGVy
YWxzJyBJL08gcmVzb3VyY2VzIGFyZSB0cmFuc2xhdGVkIGludG8gbG9naWMvZmFrZSBQSU8NCj4g
YmVmb3JlDQo+ID4+Pj4+IHN0YXJ0aW5nIHRoZSBlbnVtZXJhdGlvbi4NCj4gPj4+Pg0KPiA+Pj4+
IENhbiB5b3UgZXhwbGFpbiB0byBtZSBicmllZmx5IHdoYXQgZXhhY3RseSB0aGlzIGNvZGUgaXMg
ZXhwZWN0ZWQNCj4gdG8gYmUgZG9pbmc/DQo+ID4+Pg0KPiA+Pj4gQXMgeW91IGtub3cgY3VycmVu
dGx5IGZvciBBUk0gYXJjaGl0ZWN0dXJlIElPIHNwYWNlIGlzIG1lbW9yeQ0KPiBtYXBwZWQgYW5k
DQo+ID4+PiBpcyBvbmx5IHVzZWQgYnkgcGNpIGRldmljZXMuIFRoZSBwb3J0IG51bWJlciBpcyBk
eW5hbWljYWxseQ0KPiBhbGxvY2F0ZWQNCj4gPj4+IGNvbnZlcnRpbmcgdGhlIGRldmljZSBJTyBh
ZGRyZXNzIGludG8gYSBQSU8gdG9rZW46IGkuZS4NCj4gPj4+IGh0dHA6Ly9seHIuZnJlZS1lbGVj
dHJvbnMuY29tL3NvdXJjZS9kcml2ZXJzL2FjcGkvcGNpX3Jvb3QuYyNMNzQ1DQo+ID4+PiBUaGlz
IHBhdGNoIGlzIG1lYW50IHRvIHN1cHBvcnQgYSBuZXcgY2xhc3Mgb2YgSU8gaG9zdCBjb250cm9s
bGVyDQo+ID4+PiB0aGF0IGFyZSBub3QgUENJIGJhc2VkIGFuZCB0aGF0IHN0aWxsIHJlcXVpcmUg
dG8gaGF2ZSB0aGUgSU8NCj4gYWRkcmVzc2VzDQo+ID4+PiBiZSB0cmFuc2xhdGVkIGluIHRoZSBz
YW1lIFBJTyB0b2tlbiBzcGFjZSBhcyB0aGUgUENJIGNvbnRyb2xsZXINCj4gPj4NCj4gPj4gSU9X
LCB0aGlzIGlzIEFSTS1zcGVjaWZpYywgcmlnaHQ/DQo+ID4NCj4gPiBZZXMuIFRoZSBjdXJyZW50
IGhvc3QgYWRkZWQgaW4gdGhpcyBwYXRjaCB3aXRoIF9ISUQgIkhJU0kwMTkxIiBpcyBvbg0KPiBB
Uk02NC4NCj4gDQo+IEJ1dCB0aGUgdW5kZXJseWluZyBtZWNoYW5pc20gaXMgQVJNLXNwZWNpZmlj
IGFzIHdlbGwgQUZBSUNTLg0KPiANCj4gPiBCdXQsIEkgdGhpbmsgdGhlIGhhbmRsZXIgZHJpdmVy
IGlzIGFyY2hpdGVjdHVyZSBkZXBlbmRlbnQuDQo+IA0KPiBJIGd1ZXNzIHlvdSBtZWFuICJpbmRl
cGVuZGVudCI/ICBUaGF0IGRvZXNuJ3QgbWF0dGVyLg0KPiANCj4gSWYgQVJNNjQgaXMgdGhlIG9u
bHkgYXJjaGl0ZWN0dXJlIHRvIHVzZSBpdCBpbiBmb3Jlc2VlYWJsZSBmdXR1cmUNCj4gKHdoaWNo
IGlzIHRoZSBjYXNlIGZvciBhbGwgSSBjYW4gc2F5KSwgaXQgc2hvdWxkIGdvIGludG8gYWNwaS9h
cm02NC8NCj4gYW5kIHBsZWFzZSBhc2sgdGhlIG1haW50YWluZXJzIHRoZXJlb2YgdG8gcmV2aWV3
IGl0Lg0KDQpJIGd1ZXNzIHRoaXMgaXMgdGhlIGNhc2UgZm9yIHRoZSBmb3Jlc2VlYWJsZSBmdXR1
cmUuDQoNClNvIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCB3ZSBzaG91bGQgbGVhdmUg
YWNwaV9pbmRpcmVjdGlvX3NjYW5faW5pdCgpDQpjYWxsIGluIGFjcGlfc2Nhbl9pbml0KCkgYW5k
IG1vdmUgaXRzIGRlZmluaXRpb24gdW5kZXIgYWNwaS9hcm02NC8gcmlnaHQ/DQoNCklmIGluIGZ1
dHVyZSBvdGhlciBhcmNoaXRlY3R1cmVzIG5lZWRzIG5vbi1wY2kgSU8gY29udHJvbGxlcnMgd2Ug
bWF5IGNvbnNpZGVyDQp0byBtb3ZlIHRoaXMgdG8gYWNwaS8uLi4NCg0KTG9yZW56byB3aGF0IGRv
IHlvdSB0aGluaz8gQ291bGQgeW91IGhhdmUgYSBsb29rIGF0IHRoZSBwYXRjaHNldD8NCg0KTWFu
eSB0aGFua3MNCg0KR2FiDQoNCj4gDQo+IFRoYW5rcywNCj4gUmFmYWVsDQo=
