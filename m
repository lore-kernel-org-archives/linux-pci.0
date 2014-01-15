Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:59931
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbaAOJjC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 04:39:02 -0500
Received: from mail30-db9 (localhost [127.0.0.1])	by mail30-db9-R.bigfish.com
 (Postfix) with ESMTP id AAB7B240217	for <linux-pci@vger.kernel.org>; Wed, 15
 Jan 2014 09:39:00 +0000 (UTC)
Received: from DB9EHSMHS013.bigfish.com (unknown [10.174.16.239])	by
 mail30-db9.bigfish.com (Postfix) with ESMTP id B5F561A0047	for
 <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 09:38:58 +0000 (UTC)
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: pciehp: Determining slot number in UDEV event?
Date: Wed, 15 Jan 2014 09:38:53 +0000
Message-ID: <eb611ee439f440feb2b2ad8a1a30c64e@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGksDQoNCkkgd2FzIHdvbmRlcmluZyBpZiBpdCBpcyBwb3NzaWJsZSBmb3IgYSB1c2VyIHRvIGtu
b3cgdGhlIFNMT1QgTnVtYmVyIHdoZW4gdGhlIFVERVYgZXZlbnQgZm9yIGEgUENJIGRldmljZSBh
ZGRlZCBvbiBhIHNsb3QgY29tZXM/IA0KDQpDdXJyZW50bHkgdGhlIG9ubHkgd2F5IEkgY2FuIHRo
aW5rIG9mIGlzIHRvIHBhcnNlIHRoZSBEZXZpY2UgcGF0aCBpbiB1ZGV2IGV2ZW50IGZvciB0aGUg
ZG93bnN0cmVhbSBwb3J0LCBhbmQgdGhlbiBnbyBzZWFyY2ggaW4gdGhlIC9zeXMgYXMgdG8gd2hp
Y2ggc2xvdCBudW1iZXIgZG9lcyB0aGlzIGNvcnJlc3BvbmQgdG8uDQoNClRoYW5rcywNCg0KUmFq
YXQNCg==

