Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:37938 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3FCHNC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 03:13:02 -0400
Date: Mon, 03 Jun 2013 00:13:01 -0700 (PDT)
Message-Id: <20130603.001301.239203578028894121.davem@davemloft.net>
To: wangyijing@huawei.com
Cc: nsujir@broadcom.com, mchan@broadcom.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	guohanjun@huawei.com, liuj97@gmail.com
Subject: Re: [PATCH] tg3: remove redundant pm init code
From: David Miller <davem@davemloft.net>
In-Reply-To: <1369818032-36272-1-git-send-email-wangyijing@huawei.com>
References: <1369818032-36272-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

RnJvbTogWWlqaW5nIFdhbmcgPHdhbmd5aWppbmdAaHVhd2VpLmNvbT4NCkRhdGU6IFdlZCwgMjkg
TWF5IDIwMTMgMTc6MDA6MzIgKzA4MDANCg0KPiBQY2lfZW5hYmxlX2RldmljZSgpIHdpbGwgc2V0
IGRldmljZSBwbSBzdGF0ZSB0byBEMCwgc28NCj4gaXQncyBubyBuZWVkIHRvIGRvIGl0IGFnYWlu
IGluIHRnM19pbml0X29uZSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWlqaW5nIFdhbmcgPHdh
bmd5aWppbmdAaHVhd2VpLmNvbT4NCg0KVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgd2FybmluZzoN
Cg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmM6IEluIGZ1bmN0aW9uIKF0ZzNf
aW5pdF9vbmWiOg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmM6MTcyMzE6MTM6
IHdhcm5pbmc6IKFwbV9jYXCiIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5j
dGlvbiBbLVd1bmluaXRpYWxpemVkXQ0K
