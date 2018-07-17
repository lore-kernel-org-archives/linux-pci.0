Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr660118.outbound.protection.outlook.com ([40.107.66.118]:56448
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729688AbeGQSbh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 14:31:37 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 4/4] PCI: Introduce the disable_acs_redir parameter
Date: Tue, 17 Jul 2018 17:57:47 +0000
Message-ID: <ADC606E4-5A29-41AB-BE4D-51B89318B333@raithlin.com>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717170204.30470-5-logang@deltatee.com>
 <20180717114848.2914d547@t450s.home>
 <a3197c27-1b41-7784-374b-948e43471789@deltatee.com>
In-Reply-To: <a3197c27-1b41-7784-374b-948e43471789@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pj4gUmV2aWV3ZWQtYnk6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b20+DQo+ICAgIA0KPiAgICANCj4gICAgVGhhbmtzIGZvciBhbGwgdGhlIHRob3JvdWdoIHJldmll
dyENCg0KKzEhIFllcywgdGhhbmtzIEFsZXggZm9yIGFsbCB0aGUgZmVlZGJhY2sgb24gdGhpcyBz
ZXJpZXMuDQoNCkJqb3JuZSwgaXMgQWxleCdzIHJldmlldyBlbm91Z2ggZm9yIHlvdSB0byB0YWtl
IHRoaXMgc2VyaWVzPw0KDQpTdGVwaGVuDQogDQoNCg==
