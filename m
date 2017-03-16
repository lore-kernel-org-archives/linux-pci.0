Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Yuanzhichang <yuanzhichang@hisilicon.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Zou Rongrong <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
Date: Thu, 16 Mar 2017 16:13:41 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E20492A4C@FRAEML521-MBX.china.huawei.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan> <58C9F6C6.4090700@hisilicon.com>
 <CAK8P3a2QZ_j9RQ0U=4MoAAcRcZyu0L5AiYM22QZkiRxh7Ca-iA@mail.gmail.com>
In-Reply-To: <CAK8P3a2QZ_j9RQ0U=4MoAAcRcZyu0L5AiYM22QZkiRxh7Ca-iA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQXJuZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFybmRiZXJn
bWFubkBnbWFpbC5jb20gW21haWx0bzphcm5kYmVyZ21hbm5AZ21haWwuY29tXSBPbiBCZWhhbGYN
Cj4gT2YgQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxNiBNYXJjaCAyMDE3IDEwOjEzDQo+IFRvOiBZ
dWFuemhpY2hhbmcNCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpOyBDYXRhbGluIE1hcmluYXM7IFdp
bGwgRGVhY29uOyBSb2IgSGVycmluZzsgRnJhbmsNCj4gUm93YW5kOyBCam9ybiBIZWxnYWFzOyBS
YWZhZWwgV3lzb2NraTsgTWFyayBSdXRsYW5kOyBMaW51eCBBUk07IEFDUEkNCj4gRGV2ZWwgTWFs
aW5nIExpc3Q7IExvcmVuem8gUGllcmFsaXNpOyBCZW5qYW1pbiBIZXJyZW5zY2htaWR0OyBMaW51
eA0KPiBLZXJuZWwgTWFpbGluZyBMaXN0OyBMaW51eGFybTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LXBjaTsNCj4gbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgQ29yZXkg
TWlueWFyZDsgbGl2aXUuZHVkYXVAYXJtLmNvbTsgWm91DQo+IFJvbmdyb25nOyBKb2huIEdhcnJ5
OyBHYWJyaWVsZSBQYW9sb25pOyB6aGljaGFuZy55dWFuMDJAZ21haWwuY29tOw0KPiBrYW50eXpj
QDE2My5jb207IHh1d2VpIChPKQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY3IDUvN10gQUNQSTog
RGVsYXkgdGhlIGVudW1lcmF0aW9uIG9uIHRoZSBkZXZpY2VzDQo+IHdob3NlIGRlcGVuZGVuY3kg
aGFzIG5vdCBtZXQNCj4gDQo+IE9uIFRodSwgTWFyIDE2LCAyMDE3IGF0IDM6MjEgQU0sIHpoaWNo
YW5nLnl1YW4NCj4gPHl1YW56aGljaGFuZ0BoaXNpbGljb24uY29tPiB3cm90ZToNCj4gPiBIaSwg
UmFmYWVsLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldyENCj4gPg0KPiA+IE9uIDIw
MTcvMy8xNCA1OjI0LCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPj4gT24gTW9uZGF5LCBN
YXJjaCAxMywgMjAxNyAxMDo0Mjo0MSBBTSB6aGljaGFuZy55dWFuIHdyb3RlOg0KPiA+Pj4gSW4g
Y29tbWl0IDQwZTdmY2IxOTI5KEFDUEk6IEFkZCBfREVQIHN1cHBvcnQgdG8gZml4IGJhdHRlcnkg
aXNzdWUNCj4gb24gQXN1cw0KPiA+Pj4gVDEwMFRBKSwgdGhlICdfREVQJyB3YXMgc3VwcG9ydGVk
IHRvIHNvbHZlIHRoZSBkZXBlbmRlbmN5IG9mIEFzdXMNCj4gYmF0dGVyeS4gQnV0DQo+ID4+PiB0
aGlzIHBhdGNoIGlzIHNwZWNpZmljIHRvIEFzdXMgYmF0dGVyeSBkZXZpY2UuDQo+ID4+PiBJbiB0
aGUgcmVhbCB3b3JsZCwgdGhlcmUgYXJlIG90aGVyIGRldmljZXMgd2hpY2ggbmVlZCB0aGUNCj4g
ZGVwZW5kZW5jeSB0byBwbGF5IHRoZQ0KPiA+Pj4gcm9sZSBvbiB0aGUgZW51bWVyYXRpb24gb3Jk
ZXIuIEZvciBleGFtcGxlLCBhbGwgdGhlIEhpcDA2IExQQw0KPiA+Pj4gcGVyaXBlcmFscyhJUE1J
LUJULCB1YXJ0LCBldGMpIG11c3QgYmUgc2Nhbm5lZCBhZnRlciB0aGUgTFBDIGhvc3QNCj4gZHJp
dmVyDQo+ID4+PiBmaW5pc2hlZCB0aGUgcHJvYmluZy4gU28sIGl0IG1ha2VzIHNlbnNlIHRvIGFk
ZCBhIGNoZWNraW5nIHdoZXRoZXINCj4gdGhlIEFDUEkNCj4gPj4+IGRldmljZSBtZWV0IGFsbCB0
aGUgZGVwZW5kZW5jaWVzIGR1cmluZyBpdHMgZW51bWVyYXRpb24gc2xvdCwgaWYNCj4gbm90LCB0
aGUNCj4gPj4+IGVudW1lcmF0aW9uIHdpbGwgYmUgZGVsYXllZCB0aWxsIGFsbCBkZXBlbmRlbmN5
IG1hc3RlciBmaW5pc2ggdGhlaXINCj4gd29yay4NCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNoIGFk
ZHMgdGhlIGRlcGVuZGVuY3kgY2hlY2tpbmcgaW4gQUNQSSBlbnVtZXJhdGlvbiwgYWxzbw0KPiB0
aGUNCj4gPj4+IGNvcnJlc3BvbmRpbmcgaGFuZGxpbmcgdG8gcmV0cmlnZ2VyIHRoZSBIaXAwNiBM
UEMgcGVyaXBoZXJhbHMnDQo+IHNjYW5uaW5nLg0KPiA+Pg0KPiA+PiBBRkFJQ1MsIF9ERVAgaXMg
Z2VuZXJhbGx5IGFidXNlZCBpbiB0aGUgd2lsZCBhbmQgY2Fubm90IGJlIG1hZGUNCj4gZ2VuZXJp
Yy4gIFNvcnJ5Lg0KPiA+Pg0KPiA+DQo+ID4gRnJvbSB0aGUgQUNQSSBzcGVjaWZpY2F0aW9uLCBf
REVQIGlzIGZvciBvcGVyYXRpb24gcmVnaW9uIGFjY2Vzc2VzLg0KPiA+IFlvdSBhcmUgcmlnaHQu
Li4NCj4gPg0KPiA+IEhvdyBhYm91dCB3ZSBhZGQgYSBBQ1BJIGhhbmRsZXIgZm9yIG91ciBMUEMg
YnVzPz8gSnVzdCBsaWtlIGFtYmEuDQo+ID4gSW4gdGhpcyB3YXksIHdlIGFsc28gY2FuIHNvbHZl
IHRoZSBpc3N1ZSBhYm91dCBMUEMgZW51bWVyYXRpb24gb3JkZXIuDQo+IA0KPiBBcyBmYXIgYXMg
SSBjYW4gdGVsbCwgUENJIGFuZCBMUEMgaGF2ZSBleGFjdGx5IHRoZSBzYW1lIHJlcXVpcmVtZW50
DQo+IGhlcmUsDQo+IHNvIHdoYXRldmVyIHlvdSBlbmQgdXAgZG9pbmcgZm9yIG9uZSBzaG91bGQg
YmUgdXNlZCBmb3IgdGhlIG90aGVyIGFzDQo+IHdlbGwuDQoNCldlbGwgYXMgeW91IGtub3cgUENJ
IGhhcyBnb3QgaGlzIG93biBoYW5kbGVyLCBpZGVudGlmaWVkIGJ5IGhpcyBvd24NCm5hbWVzcGFj
ZSBpZCAiUE5QMEEwMyIuDQpOb3cgd2hlbiB5b3Ugc2F5ICJ5b3UgZW5kIHVwIGRvaW5nIGZvciBv
bmUgc2hvdWxkIGJlIHVzZWQgZm9yIHRoZSBvdGhlciINCmFyZSB5b3Ugc2F5aW5nIHRoYXQgd2Ug
c2hvdWxkIGludHJvZHVjZSBhIG5ldyBjbGFzcyBvZiBkZXZpY2VzPw0KaS5lLiBzaG91bGQgd2Ug
aGF2ZSBhbiBBQ1BJIG5hbWVzcGFjZSBpZGVudGlmaWVyIGZvciBub24tUENJIElPIEhvc3QNCkNv
bnRyb2xsZXJzPyAgDQoNCk90aGVyd2lzZSwgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0
LCBoYXZpbmcgYSBzcGVjaWZpYyBuZXcgQUNQSQ0KaGFuZGxlciBmb3IgSGlTaWxpY29uIExQQyB3
b3VsZCBtZWFuIHRvIGFkZGluZyBhbm90aGVyIGZ1bmN0aW9uX2luaXQoKQ0KaW4gdGhlIGxpc3Qg
b2YgYWNwaSBoYW5kbGVycyBpbml0cyBpbiBhY3BpX3NjYW5faW5pdCgpLg0KDQpCdXQgdGhlbiBl
dmVyeSB2ZW5kb3Igd291bGQgZGVjbGFyZSBoaXMgb3duIG9uZS4uLmlzIHRoaXMgcmVhbGx5IGNv
cnJlY3Q/DQoNCk1hbnkgVGhhbmtzDQpHYWINCg0KPiANCj4gICAgICAgQXJuZA0K
