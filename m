Return-Path: <SRS0=NHSM=6H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87EC5518A
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D0C2073A
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 03:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDWDJb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:09:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgDWDJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 23:09:31 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id CE0956136034E71C38FF;
        Thu, 23 Apr 2020 11:09:28 +0800 (CST)
Received: from DGGEML524-MBX.china.huawei.com ([169.254.1.24]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0487.000; Thu, 23 Apr 2020 11:09:21 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBQQ0k6IGR3YzogTWFrZSBoaXNpX3BjaWVf?=
 =?gb2312?Q?platform=5Fops_static?=
Thread-Topic: [PATCH -next] PCI: dwc: Make hisi_pcie_platform_ops static
Thread-Index: AQHWGIolbWQn5B0De0Gy9am0DtYXU6iFfyWAgACG+2A=
Date:   Thu, 23 Apr 2020 03:09:20 +0000
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E5951DC6@dggeml524-mbx.china.huawei.com>
References: <1587548829-107925-1-git-send-email-zou_wei@huawei.com>
 <5EA10481.1080604@hisilicon.com>
In-Reply-To: <5EA10481.1080604@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.212.180]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgV2FuZywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgcmVwbHkuDQpJIHdpbGwgbW9k
aWZ5IGFuZCBzZW5kIHRoZSB2MiBzb29uLg0KDQpUaGFua3MNClpvdSBXZWkNCi0tLS0t08q8/tSt
vP4tLS0tLQ0Kt6K8/sjLOiBXYW5nemhvdSAoQikgDQq3osvNyrG85DogMjAyMMTqNNTCMjPI1SAx
MDo1OQ0KytW8/sjLOiBab3V3ZWkgKFNhbXVlbCkgPHpvdV93ZWlAaHVhd2VpLmNvbT47IGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb207IGFtdXJyYXlAdGhlZ29vZHBlbmd1aW4uY28udWs7IGJoZWxn
YWFzQGdvb2dsZS5jb20NCrOty806IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBbUEFUQ0ggLW5leHRdIFBDSTogZHdjOiBN
YWtlIGhpc2lfcGNpZV9wbGF0Zm9ybV9vcHMgc3RhdGljDQoNCk9uIDIwMjAvNC8yMiAxNzo0Nywg
Wm91IFdlaSB3cm90ZToNCj4gRml4IHRoZSBmb2xsb3dpbmcgc3BhcnNlIHdhcm5pbmc6DQo+IA0K
PiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWhpc2kuYzozNjU6MjE6IHdhcm5pbmc6
DQo+IHN5bWJvbCAnaGlzaV9wY2llX3BsYXRmb3JtX29wcycgd2FzIG5vdCBkZWNsYXJlZC4gU2hv
dWxkIGl0IGJlIHN0YXRpYz8NCj4gDQo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lA
aHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWm91IFdlaSA8em91X3dlaUBodWF3ZWkuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaGlzaS5jIHwgMyAr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWhpc2kuYyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaGlzaS5jDQo+IGluZGV4IDZkOWUxYjIu
LmI0NDBmNDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
aGlzaS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaGlzaS5jDQo+
IEBAIC0zNjIsNyArMzYyLDggQEAgc3RhdGljIGludCBoaXNpX3BjaWVfcGxhdGZvcm1faW5pdChz
dHJ1Y3QgcGNpX2NvbmZpZ193aW5kb3cgKmNmZykNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0K
PiAtc3RydWN0IHBjaV9lY2FtX29wcyBoaXNpX3BjaWVfcGxhdGZvcm1fb3BzID0gew0KPiArc3Rh
dGljIHN0cnVjdCBwY2lfZWNhbV9vcHMgaGlzaV9wY2llX3BsYXRmb3JtX29wcyA9IHsNCj4gKwl9
DQoNCndoeSBhZGRpbmcgIn0iPyBCVFcsIHN0YXRpYyBpcyBPSyBoZXJlLg0KDQo+ICAJLmJ1c19z
aGlmdCAgICA9IDIwLA0KPiAgCS5pbml0ICAgICAgICAgPSAgaGlzaV9wY2llX3BsYXRmb3JtX2lu
aXQsDQo+ICAJLnBjaV9vcHMgICAgICA9IHsNCj4gDQoNCg==
