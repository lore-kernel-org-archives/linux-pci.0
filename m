Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:44435
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751471AbeCWQlF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Mar 2018 12:41:05 -0400
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Date: Fri, 23 Mar 2018 16:41:02 +0000
Message-ID: <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321162555.GA16028@red-moon>
In-Reply-To: <20180321162555.GA16028@red-moon>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ICAgIFBsZWFzZSByZWFkIHRoZSBsaW5rIEkgc2VudCB5b3UgaW4gcmVsYXRpb24gdG8gZW1haWwg
Zm9ybWF0dGluZy4NCiAgICANCiAgICBUaGVuIGFkZCB5b3VyIGRlc2NyaXB0aW9uIGFib3ZlIGlu
IGEgd2F5IHRoYXQgYW55b25lIG5vdCAxMDAlIGZhbWlsaWFyDQogICAgd2l0aCBoeXBlcnYgY2Fu
IHVuZGVyc3RhbmQgaXQgLSB0aGF0J3Mgd2hhdCB0aGUgY29tbWl0IGxvZyBpcyBmb3IuDQogICAg
DQogICAgWW91IGFyZSBzZW5kaW5nIHRoaXMgcGF0Y2ggdG8gc3RhYmxlIGtlcm5lbHMsIHBhdGNo
IGFib3ZlIGhhcyBiZWVuIGluDQogICAgdGhlIGtlcm5lbCBmcm9tIHY0LjE0LiBUaGUgcGF0Y2gg
eW91IGFyZSBmaXhpbmcgc2luY2UgdjQuMTEsIHlvdSBvdWdodA0KICAgIHRvIGJlIGNhcmVmdWwg
c2luY2UgeW91IGRvIG5vdCB3YW50IHRvIGhhdmUgYnJva2VuIGtlcm5lbCB2ZXJzaW9ucyBvd2lu
Zw0KICAgIHRvIHN0YWJsZSBwYXRjaGVzIG1pc21hdGNoZXMsIHRoYXQncyB3aHkgSSBhc2tlZCBh
bmQgSSB3aWxsIGFzayBhZ2FpbiwNCiAgICBhcmUgeW91IHN1cmUgeW91IHdvbid0IHRyaWdnZXIg
YSByZWdyZXNzaW9uIGJ5IHNlbmRpbmcgdGhpcyBmaXggdG8NCiAgICBzdGFibGUgPw0KICAgIA0K
ICAgIEkgYXNzdW1lIHRoZSBib25kIGRyaXZlciBtZWNoYW5pc20gaXMgbm93IGRvbmUgYW5kIGR1
c3RlZC4NCiAgICANClRoYXQgaXMgY29ycmVjdC4gSSBoYXZlIHNlbnQgYSB2NCB2ZXJzaW9uIG9m
IHRoZSBwYXRjaC4gSSBhbSBzZW5kaW5nIHRoaXMNCnBhdGNoIGZvciBzdGFibGUga2VybmVsLiBX
ZSBoYXZlIHRlc3RlZCBhbmQgSSBhbSBzdXJlIHRoaXMgc2hvdWxkIG5vdCB0cmlnZ2VyDQpyZWdy
ZXNzaW9uIGJ5IHNlbmRpbmcgdGhpcyBmaXggdG8gc3RhYmxlLg0KDQpUaGFua3MNClNyaWRoYXIg
UGl0Y2hhaSAgICAgDQogDQoNCg==
