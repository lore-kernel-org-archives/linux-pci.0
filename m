Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.parallels.com ([64.131.90.16]:50226 "EHLO mx2.parallels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab1K2TU0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Nov 2011 14:20:26 -0500
From: James Bottomley <jbottomley@parallels.com>
To: Joerg Roedel <joerg.roedel@amd.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: pci: fix ats compile failure
Date: Tue, 29 Nov 2011 19:20:23 +0000
Message-ID: <1322594422.11875.47.camel@dabdike.int.hansenpartnership.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SSBnZXQgdGhpcyBjb21waWxlIGZhaWx1cmUgb24gcGFyaXNjOg0KDQpkcml2ZXJzL3BjaS9hdHMu
YzogSW4gZnVuY3Rpb24gJ2F0c19hbGxvY19vbmUnOg0KZHJpdmVycy9wY2kvYXRzLmM6Mjk6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAna3phbGxvYycNCmRyaXZlcnMv
cGNpL2F0cy5jOjI5OiB3YXJuaW5nOiBhc3NpZ25tZW50IG1ha2VzIHBvaW50ZXIgZnJvbSBpbnRl
Z2VyIHdpdGhvdXQgYSBjYXN0DQpkcml2ZXJzL3BjaS9hdHMuYzogSW4gZnVuY3Rpb24gJ2F0c19m
cmVlX29uZSc6DQpkcml2ZXJzL3BjaS9hdHMuYzo0NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uIG9mIGZ1bmN0aW9uICdrZnJlZScNCg0KQmVjYXVzZSBhdHMuYyBpcyBtaXNzaW5nIGxpbnV4
L3NsYWIuaCBhcyBhbiBpbmNsdWRlLiAgVGhpcyBwYXRjaCBmaXhlcyBpdA0KDQpTaWduZWQtb2Zm
LWJ5OiBKYW1lcyBCb3R0b21sZXkgPEpCb3R0b21sZXlAUGFyYWxsZWxzLmNvbT4NCg0KLS0tDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9hdHMuYyBiL2RyaXZlcnMvcGNpL2F0cy5jDQppbmRl
eCA3ZWM1NmZiLi5iMGRkMDhlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvYXRzLmMNCisrKyBi
L2RyaXZlcnMvcGNpL2F0cy5jDQpAQCAtMTMsNiArMTMsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9l
eHBvcnQuaD4NCiAjaW5jbHVkZSA8bGludXgvcGNpLWF0cy5oPg0KICNpbmNsdWRlIDxsaW51eC9w
Y2kuaD4NCisjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KIA0KICNpbmNsdWRlICJwY2kuaCINCiAN
Cg0K
