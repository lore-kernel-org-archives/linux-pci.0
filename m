Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:50240
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755615AbdCGTAn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Mar 2017 14:00:43 -0500
From: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Date: Tue, 7 Mar 2017 19:00:20 +0000
Message-ID: <E66CD5F3-B14D-4CD5-AE66-624AC2A18B01@cavium.com>
References: <20170301233158.1035-1-himanshu.madhani@cavium.com>
 <20170301234904.GA22814@lst.de>
In-Reply-To: <20170301234904.GA22814@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQmpvcm4sIA0KCQ0KQ2FuIHdlIGdldCB0aGlzIHBhdGNoIGluY2x1ZGVkIGluIG5leHQgYnJh
bmNoLiBUaGlzIHBhdGNoIGhhcyBiZWVuIHJldmlld2VkIGJ5IENocmlzdG9waC4gDQoNClRoYW5r
cywNCkhpbWFuc2h1DQoNCk9uIDMvMS8xNywgMzo0OSBQTSwgIkNocmlzdG9waCBIZWxsd2lnIiA8
aGNoQGxzdC5kZT4gd3JvdGU6DQoNCiAgICBMb29rcyBnb29kLA0KICAgIA0KICAgIFJldmlld2Vk
LWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCiAgICANCg0K
