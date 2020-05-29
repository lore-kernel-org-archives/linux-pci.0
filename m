Return-Path: <SRS0=Vh5R=7L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CADC433E1
	for <linux-pci@archiver.kernel.org>; Fri, 29 May 2020 03:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1409E206C3
	for <linux-pci@archiver.kernel.org>; Fri, 29 May 2020 03:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tfLXq4IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390465AbgE2DGJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 May 2020 23:06:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14673 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389650AbgE2DGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 23:06:07 -0400
X-UUID: 7a69bbd5323748a7ac47d22a87cdce20-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2DSr7ykOqmhgi2+WieyVzdmY00Ec4k69EeBwPT4JtEE=;
        b=tfLXq4IV/3yMKhXLcFLsUIHaTF17jMU6W6B+2m+z4rfmf4qzysh22b4OXgVvY+yRXIX/6mDPw6G7B2zgtT1wLzXhS1c8bNHtY/VJSSqp6V0rk7GjoY3sdS7AqThypoxdDVRuE2RS/JSG5myFwIT2b1VXk79AbouEQLf/5DD19No=;
X-UUID: 7a69bbd5323748a7ac47d22a87cdce20-20200529
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1930201207; Fri, 29 May 2020 11:06:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 11:05:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 11:05:58 +0800
Message-ID: <1590721559.23866.0.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/4] Spilt PCIe node to comply with hardware design
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <chuanjia.liu@mediatek.com>
CC:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <bhelgaas@google.com>,
        <jianjun.wang@mediatek.com>, <yong.wu@mediatek.com>,
        <srv_heupstream@mediatek.com>
Date:   Fri, 29 May 2020 11:05:59 +0800
In-Reply-To: <20200528061648.32078-1-chuanjia.liu@mediatek.com>
References: <20200528061648.32078-1-chuanjia.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDE0OjE2ICswODAwLCBjaHVhbmppYS5saXVAbWVkaWF0ZWsu
Y29tIHdyb3RlOg0KPiBUaGVyZSBhcmUgdHdvIGluZGVwZW5kZW50IFBDSWUgY29udHJvbGxlcnMg
aW4gTVQyNzEyL01UNzYyMiBwbGF0Zm9ybSwNCj4gYW5kIGVhY2ggb2YgdGhlbSBzaG91bGQgY29u
dGFpbiBhbiBpbmRlcGVuZGVudCBNU0kgZG9tYWluLg0KPiANCj4gSW4gY3VycmVudCBhcmNoaXRl
Y3R1cmUsIE1TSSBkb21haW4gd2lsbCBiZSBpbmhlcml0ZWQgZnJvbSB0aGUgcm9vdA0KPiBicmlk
Z2UsIGFuZCBhbGwgb2YgdGhlIGRldmljZXMgd2lsbCBzaGFyZSB0aGUgc2FtZSBNU0kgZG9tYWlu
Lg0KPiBIZW5jZSB0aGF0LCB0aGUgUENJZSBkZXZpY2VzIHdpbGwgbm90IHdvcmsgcHJvcGVybHkg
aWYgdGhlIGlycSBudW1iZXINCj4gd2hpY2ggcmVxdWlyZWQgaXMgbW9yZSB0aGFuIDMyLg0KPiAN
Cj4gU3BsaXQgdGhlIFBDSWUgbm9kZSBmb3IgTVQyNzEyL01UNzYyMiBwbGF0Zm9ybSB0byBmaXgg
TVNJIGlzc3VlIGFuZA0KPiBjb21wbHkgd2l0aCB0aGUgaGFyZHdhcmUgZGVzaWduLg0KPiANCj4g
Y2hhbmdlIG5vdGU6DQo+IHYyOiBjaGFuZ2UgdGhlIGFsbG9jYXRpb24gb2YgbXQyNzEyIFBDSWUg
TU1JTyBzcGFjZSBkdWUgdG8gdGhlIGFsbGNhdGlvbg0KPiBzaXplIGlzIG5vdCByaWdodCBpbiB2
MS4NCj4gDQo+IGNodWFuamlhLmxpdSAoNCk6DQo+ICAgZHQtYmluZGluZ3M6IFBDSTogTWVkaWF0
ZWs6IFVwZGF0ZSBQQ0llIGJpbmRpbmcNCj4gICBQQ0k6IG1lZGlhdGVrOiBVc2UgcmVnbWFwIHRv
IGdldCBzaGFyZWQgcGNpZS1jZmcgYmFzZQ0KPiAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBTcGxp
dCBQQ0llIG5vZGUgZm9yIE1UMjcxMi9NVDc2MjINCj4gICBBUk06IGR0czogbWVkaWF0ZWs6IFVw
ZGF0ZSBtdDc2MjkgUENJZSBub2RlDQo+IA0KPiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1w
Y2llLWNmZy55YW1sICAgICAgIHwgIDM4ICsrKysrDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvbWVkaWF0ZWstcGNpZS50eHQgfCAxNDQgKysrKysrKysrKystLS0tLS0tDQo+ICBhcmNo
L2FybS9ib290L2R0cy9tdDc2MjktcmZiLmR0cyAgICAgICAgICAgICAgfCAgIDMgKy0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL210NzYyOS5kdHNpICAgICAgICAgICAgICAgICB8ICAyMyArLS0NCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpICAgICB8ICA3NSArKysr
Ky0tLS0NCj4gIC4uLi9kdHMvbWVkaWF0ZWsvbXQ3NjIyLWJhbmFuYXBpLWJwaS1yNjQuZHRzICB8
ICAxNiArLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjItcmZiMS5kdHMg
IHwgICA2ICstDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpICAg
ICAgfCAgNjggKysrKysrLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0
ZWsuYyAgICAgICAgfCAgMjUgKystDQo+ICA5IGZpbGVzIGNoYW5nZWQsIDI1OCBpbnNlcnRpb25z
KCspLCAxNDAgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sDQo+IA0KPiAt
LQ0KPiAyLjE4LjANCj4gDQo+IA0KRm9yIHRoZSBzZXJpZXM6DQpBY2tlZC1ieTogUnlkZXIgTGVl
IDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0K

