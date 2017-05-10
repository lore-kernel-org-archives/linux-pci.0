Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55357 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751399AbdEJDjh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2017 23:39:37 -0400
From: Wei Zhang <wzhang@fb.com>
To: Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Date: Wed, 10 May 2017 03:39:27 +0000
Message-ID: <862590BB-8E84-4F2D-B5F9-A665000AA9CB@fb.com>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
 <1493395369-20225-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1493395369-20225-2-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

IEhpIEtlaXRoIGFuZCBXZXMsDQoNCkkgd29uZGVyIGlmIGdldHRpbmcgYW4gQWxsIDHigJlzIHJl
YWQgb24gdGhlIERQQyBzdGF0dXMgcmVnaXN0ZXIgaXMgYSB2YWxpZCBzY2VuYXJpby4gICBUaGUg
RFBDIHJlZ2lzdGVyIGlzIG9uIHRoZSBzd2l0Y2gsIHdoeSB3b3VsZCB0aGUgc3RhdHVzIHJlZ2lz
dGVyIHJldHVybnMgQWxsIDHigJlzIGV2ZW4gaWYgdGhlIGRldmljZSBpcyByZW1vdmVkPw0KDQpU
aGFua3MsDQotV2VpDQoNCi0tDQp3ZWkgemhhbmcgfCBzb2Z0d2FyZSBlbmdpbmVlciB8IGZhY2Vi
b29rDQp3emhhbmdAZmIuY29tIHwgKDQwOCkgNDYwLTQ4MDMNCg0KT24gNC8yOS8xNywgMTI6MDIg
QU0sICJLZWl0aCBCdXNjaCIgPGtlaXRoLmJ1c2NoQGludGVsLmNvbT4gd3JvdGU6DQoNCiAgICBU
aGUgRFBDIGludGVydXB0IG1heSBiZSBleGVjdXRlZCBvbiBhIGRldmljZSB0aGF0IGlzIGJlaW5n
IHJlbW92ZWQuIFNraXANCiAgICBxdWV1aW5nIGV2ZW50IGhhbmRsaW5nIGlmIHRoZSBzdGF0dXMg
aXMgYWxsIDEncywgd2hpY2ggc2hvdWxkIGJlIHNlZW4NCiAgICBvbmx5IGlmIHRoZSBkZXZpY2Ug
aXMgbm90IHByZXNlbnQuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtl
aXRoLmJ1c2NoQGludGVsLmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9wY2kvcGNpZS9wY2ll
LWRwYy5jIHwgMiArLQ0KICAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCiAgICANCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9wY2llLWRw
Yy5jIGIvZHJpdmVycy9wY2kvcGNpZS9wY2llLWRwYy5jDQogICAgaW5kZXggZDRkNzBlZi4uZmMy
YTRhNyAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL3BjaS9wY2llL3BjaWUtZHBjLmMNCiAgICAr
KysgYi9kcml2ZXJzL3BjaS9wY2llL3BjaWUtZHBjLmMNCiAgICBAQCAtODcsNyArODcsNyBAQCBz
dGF0aWMgaXJxcmV0dXJuX3QgZHBjX2lycShpbnQgaXJxLCB2b2lkICpjb250ZXh0KQ0KICAgICAJ
cGNpX3JlYWRfY29uZmlnX3dvcmQocGRldiwgZHBjLT5jYXBfcG9zICsgUENJX0VYUF9EUENfU1RB
VFVTLCAmc3RhdHVzKTsNCiAgICAgCXBjaV9yZWFkX2NvbmZpZ193b3JkKHBkZXYsIGRwYy0+Y2Fw
X3BvcyArIFBDSV9FWFBfRFBDX1NPVVJDRV9JRCwNCiAgICAgCQkJICAgICAmc291cmNlKTsNCiAg
ICAtCWlmICghc3RhdHVzKQ0KICAgICsJaWYgKCFzdGF0dXMgfHwgc3RhdHVzID09ICh1MTYpKH4w
KSkNCiAgICAgCQlyZXR1cm4gSVJRX05PTkU7DQogICAgIA0KICAgICAJZGV2X2luZm8oJmRwYy0+
ZGV2LT5kZXZpY2UsICJEUEMgY29udGFpbm1lbnQgZXZlbnQsIHN0YXR1czolIzA2eCBzb3VyY2U6
JSMwNnhcbiIsDQogICAgLS0gDQogICAgMi43LjINCiAgICANCiAgICANCg0K
