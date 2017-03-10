Return-Path: <SRS0=ogIK=2T=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=ogIK=2T=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        "agraf@suse.de" <agraf@suse.de>,
        Yuanzhichang
	<yuanzhichang@hisilicon.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        John Garry
	<john.garry@huawei.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [QUESTION]: Same IO bus address in different _CRS methods
Date: Fri, 10 Mar 2017 09:57:28 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E2046F035@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E2046C6AC@FRAEML521-MBX.china.huawei.com>
 <20170309181134.GA15721@bhelgaas-glaptop.roam.corp.google.com>
 <CAK8P3a0iECAKBKG6zqXO5VaPze9OzxzSY+cBFHsM46xVAGhE1A@mail.gmail.com>
 <20170309223738.GE19517@bhelgaas-glaptop.roam.corp.google.com>
 <CAK8P3a3vQ+ZO3tcO41uTOVYQszXj-_x-mEFMkZmnE0A1efTxUw@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E2046D682@FRAEML521-MBX.china.huawei.com>
 <CAK8P3a1vpEqa89E9uEKGStRCdzge1au=WYEe9dkBHOo+YZUptQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1vpEqa89E9uEKGStRCdzge1au=WYEe9dkBHOo+YZUptQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Wy4uLl0NCg0KPiA+DQo+ID4gSWYgeW91IGd1eXMgYWdyZWUgb24gdGhlIGNvbmNsdXNpb24gYWJv
dmUgSSB3aWxsIGNvbnRpbnVlIHdpdGggdGhlDQo+ID4gcmV3b3JrIG9mIHRoZSBIaVNpbGljb24g
TFBDIGRyaXZlciB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgd2UgbmVlZA0KPiA+IGR5bmFtaWNh
bGx5IGFzc2lnbmVkIHRva2VucyBhbHNvIGZvciBBQ1BJLg0KPiANCj4gWWVzLCB1bmxlc3MgQmpv
cm4gaGFzIHNvbWUgbGFzdCBjb25jZXJucywgSSB0aGluayB0aGlzIGlzIGFsbCBnb29kDQo+IGFu
ZCB0aGUgb25seSBwcm9wZXIgd2F5IHRvIGNvbnRpbnVlLiBUaGFua3MgZm9yIGJlYXJpbmcgd2l0
aCBtZQ0KPiB0aHJvdWdoIHRoZSBkZXRvdXIgdGhhdCBlbmRlZCB1cCBpbiB0aGUgc2FtZSBwbGFj
ZSB3ZSB3ZXJlIGluDQo+IGJlZm9yZS4uLg0KDQpObyB3b3JyaWVzLCBhY3R1YWxseSB0aGFuayB5
b3UgYW5kIEJqb3JuIGZvciB5b3VyIHRpbWUgYW5kIHN1cHBvcnQuDQoNCkNoZWVycw0KR2FiDQoN
Cj4gDQo+ICAgICBBcm5kDQo=
