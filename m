Return-Path: <SRS0=rgU2=U7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F7AC06510
	for <linux-pci@archiver.kernel.org>; Tue,  2 Jul 2019 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66AB20836
	for <linux-pci@archiver.kernel.org>; Tue,  2 Jul 2019 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGBM2h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:28:37 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:47591 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBM2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2019 08:28:36 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 08:28:35 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 787F8100D9405;
        Tue,  2 Jul 2019 14:21:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E20E6132E3E; Tue,  2 Jul 2019 14:21:17 +0200 (CEST)
Date:   Tue, 2 Jul 2019 14:21:17 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: A question about shpcp.
Message-ID: <20190702122117.vl2opo55zpsykjf6@wunner.de>
References: <d87dfa281d0d4e7da3f6bf714a7c2e5a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87dfa281d0d4e7da3f6bf714a7c2e5a@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 12:16:18PM +0000, linmiaohe wrote:
> In qemu+shpcp+pcie scene, hotplug a network card(virtio) would take more
> than 5 seconds. It's because 5 seconds delayed_work in func
> handle_button_press_event with case STATIC_STATE. And this will break some
> protocols with timeout within 5 seconds.
> It's very nice of you if you could tell me why is 5*HZ there and if this
> delay can be reduced?

According to Table 2-4 of the PCI Standard Hot-Plug Controller and
Subsystem Specification, "System software is waiting 5 seconds to
provide the user with an opportunity to cancel the hot-plug operation."
(http://drydkim.com/MyDocuments/PCI%20Spec/specifications/shpc1_0.pdf)

So the reason the delay can't be reduced or removed is because the spec
mandates it.

Thanks,

Lukas
