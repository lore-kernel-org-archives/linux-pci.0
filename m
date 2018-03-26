Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Date: Mon, 26 Mar 2018 17:32:17 +0000
Message-ID: <387657CF-8AD7-4C62-9E4E-A7B96915A345@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321162555.GA16028@red-moon>
 <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
 <20180323164716.GA7794@kroah.com>
In-Reply-To: <20180323164716.GA7794@kroah.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ICANCiAgICA+IFRoaXMgaXMgbm90IHRoZSBjb3JyZWN0IHdheSB0byBzdWJtaXQgcGF0Y2hlcyBm
b3IgaW5jbHVzaW9uIGluIHRoZQ0KICAgID4gc3RhYmxlIGtlcm5lbCB0cmVlLiAgUGxlYXNlIHJl
YWQ6DQogICAgPiAgPHVybD4NCiAgICA+IGZvciBob3cgdG8gZG8gdGhpcyBwcm9wZXJseS4NCg0K
TXkgYmFkLiBJIGFtIHNlbmRpbmcgdGhlIHBhdGNoIHRvIHRoZSBtYWlubGluZSBrZXJuZWwgd2l0
aCBhIENjOiB0YWcgZm9yIHN0YWJsZQ0KYW5kIGhvcGluZyB0aGUgcGF0Y2ggd2lsbCBiZSBhdXRv
bWF0aWNhbGx5IG1lcmdlZCB0byB0aGUgc3RhYmxlIGtlcm5lbHMuDQoNClRoYW5rcywNClNyaWRo
YXIgUGl0Y2hhaQ0KDQo=
