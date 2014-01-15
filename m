Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:32304
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752044AbaAOJoH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 04:44:07 -0500
Received: from mail106-db9 (localhost [127.0.0.1])	by
 mail106-db9-R.bigfish.com (Postfix) with ESMTP id D539380149	for
 <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 09:44:05 +0000 (UTC)
Received: from DB9EHSMHS027.bigfish.com (unknown [10.174.16.233])	by
 mail106-db9.bigfish.com (Postfix) with ESMTP id B221F3A00BD	for
 <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 09:44:03 +0000 (UTC)
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Guenter Roeck <groeck@juniper.net>
Subject: User initiated hotplug and kernel initiated hotplug - where is the
 synchronization?
Date: Wed, 15 Jan 2014 09:43:58 +0000
Message-ID: <635a0ddff97142e2a06f9bd9c3428d01@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGVsbG8sDQoNCkkgaGF2ZSB0aGlzIGRvdWJ0IGxpbmdlcmluZyBvbiwgYW5kIEknZCBhcHByZWNp
YXRlIGlmIHNvbWUgb25lIGNvdWxkIHRocm93IGxpZ2h0IG9uIHRoaXM6DQoNClRoZSBrZXJuZWwg
aG90cGx1ZyBkcml2ZXIgcGNpZWhwIGNhbiBpbml0aWF0ZSBob3RwbHVnIGJhc2VkIG9uIHdoYXQg
aXQgc2Vuc2VzIGZyb20gdGhlIEhXIChidXR0b24gcHJlc3MgZXRjKS4NCg0KVGhlIHVzZXIgc3Bh
Y2UgY2FuIGFsc28gaW5pdGlhdGUgdGhlIHNhbWUgb3BlcmF0aW9ucyBieSB1c2luZyAicmVzY2Fu
IiBvciAicmVtb3ZlIiBhdHRyaWJ1dGVzIGluIHN5c2ZzLg0KDQpNeSBxdWVzdGlvbnM6DQoNCjEp
IElzIGl0IHNhZmUgdG8gbWl4IHRoZSBhYm92ZSB0d28/IEluIG90aGVyIHdvcmRzIGNvdWxkIHRo
ZXJlIGJlIHJhY2UgY29uZGl0aW9ucyBiZWNhdXNlIHVzZXIgaW5pdGlhdGVkIGhvdHBsdWcgY291
bGQgaW50ZXJmZXJlIHdpdGgga2VybmVsIGluaXRpYXRlZCBob3RwbHVnIGFuZCB2aWNlIHZlcnNh
PyBXaG8gZW5zdXJlcyB0aGF0IHRoZSBhdG9taWNpdHkgb2Ygc3VjaCBvcGVyYXRpb25zIGlzIHBy
ZXNlcnZlZD8NCg0KMikgQ2FuIHlvdSBwb2ludCBtZSB0byBhbnkgbG9ja3MgdGhhdCBhcmUgcHJl
c2VudCBhbmQgSSBtYXkgaGF2ZSBtaXNzZWQgZm9yIGhhbmRsaW5nIHN1Y2ggc2NlbmFyaW9zPw0K
DQpUaGFua3MsDQoNClJhamF0DQo=

