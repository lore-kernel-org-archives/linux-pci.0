Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64633C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B9B20672
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B9B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeLJThG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:37:06 -0500
Received: from dfwrgout.huawei.com ([206.16.17.72]:2060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbeLJThG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 14:37:06 -0500
Received: from dfweml701-cah.china.huawei.com (unknown [172.18.9.220])
        by Forcepoint Email with ESMTP id C1F9E4C133404;
        Mon, 10 Dec 2018 13:37:03 -0600 (CST)
Received: from SJCEML701-CHM.china.huawei.com (10.208.112.40) by
 dfweml701-cah.china.huawei.com (10.193.5.175) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Dec 2018 11:37:04 -0800
Received: from SJCEML521-MBS.china.huawei.com ([169.254.2.185]) by
 SJCEML701-CHM.china.huawei.com ([169.254.3.191]) with mapi id 14.03.0415.000;
 Mon, 10 Dec 2018 11:36:57 -0800
From:   Eric Wehage <Eric.Wehage@huawei.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: RE: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
Thread-Topic: [RFC] Proposed PCI ECR for description of Advanced Peer to
 Peer Capabilities
Thread-Index: AQHUkH99uHLQpIpsU0OEL04E/sq5aKV4vkgA//+DUoCAAJj0AP//ejhA
Date:   Mon, 10 Dec 2018 19:36:57 +0000
Message-ID: <DD8FB053C05D2D4DB8AA6C9332617878599788A2@sjceml521-mbs.china.huawei.com>
References: <20181210115653.0000615a@huawei.com>
 <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
 <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
 <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
In-Reply-To: <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.247.157]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhlcmUgYXJlIDUgVExQIHR5cGVzIGRlc2NyaWJlZCBpbiBlYWNoIG9mIHRoZSB0aHJlZSBQMlAg
Um91dGVzLiBJJ20NCm5vdCBzdXJlIHRoYXQgYW55b25lIHdvdWxkIGNhcmUgYWJvdXQgTWVzc2Fn
ZSBCYW5kd2lkdGgsIHNvIEkNCmNvdWxkIHNpbXBseSBhZGQgMyBiaXRzIHRvIGVhY2ggUm91dGUg
cmVnaXN0ZXIgaW5kaWNhdGluZyB3aGV0aGVyIHRoZQ0KUDJQIHJvdXRlIGJhbmR3aWR0aCBzdXBw
b3J0cyB0aGUgc2FtZSBvciBtb3JlIGJhbmR3aWR0aCB0aGFuIGlmIGl0DQp0YXJnZXRlZCBEUkFN
Lg0KDQpUaGUgdGhyZWUgUk8vSFdJbml0IGJpdHMgZm9yIGVhY2ggcm91dGUgcmVnaXN0ZXIgd291
bGQgYmU6DQotIFAyUCBNZW1vcnkgUmVhZCBCYW5kd2lkdGggaXMgZXF1YWwgdG8gb3IgZ3JlYXRl
ciB0aGFuIHRvIE1haW4NCiAgIE1lbW9yeQ0KLSBQMlAgTWVtb3J5IFdyaXRlIEJhbmR3aWR0aCBp
cyBlcXVhbCB0byBvciBncmVhdGVyIHRoYW4gdG8gTWFpbg0KICAgTWVtb3J5DQotIFAyUCBNZW1v
cnkgQXRvbWljT3AgQmFuZHdpZHRoIGlzIGVxdWFsIHRvIG9yIGdyZWF0ZXIgdGhhbiB0byBNYWlu
DQogICBNZW1vcnkNCg0KRXJpYyBXZWhhZ2UNCkh1YXdlaSBQcmluY2lwYWwgRW5naW5lZXIsIFBD
SWUNCg0K
