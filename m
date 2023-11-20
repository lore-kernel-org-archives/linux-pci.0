Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2493FC197A0
	for <linux-pci@archiver.kernel.org>; Mon, 20 Nov 2023 22:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjKTWRb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Nov 2023 17:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWRb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 17:17:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFE2C3
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 14:17:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C936C433C8;
        Mon, 20 Nov 2023 22:17:27 +0000 (UTC)
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     linux-pci@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kernel@gpiccoli.net, kernel-dev@igalia.com,
        Huang Rui <ray.huang@amd.com>, Vicki Pfau <vi@endrift.com>
In-Reply-To: <20231120160531.361552-1-gpiccoli@igalia.com>
References: <20231120160531.361552-1-gpiccoli@igalia.com>
Subject: Re: [PATCH] PCI: Only override AMD USB controller if required
Message-Id: <170051864610.219244.16164436930748454794.b4-ty@google.com>
Date:   Mon, 20 Nov 2023 16:17:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 20 Nov 2023 13:04:36 -0300, Guilherme G. Piccoli wrote:
> By running a Vangogh device (Steam Deck), the following message
> was noticed in the kernel log:
> 
> "pci 0000:04:00.3: PCI class overridden (0x0c03fe -> 0x0c03fe) so dwc3 driver can claim this instead of xhci"
> 
> Effectively this means the quirk executed but changed nothing, since the
> class of this device was already the proper one (likely adjusted by
> newer firmware versions).
> 
> [...]

Applied, thanks!

[1/1] PCI: Only override AMD USB controller if required
      commit: e585a37e5061f6d5060517aed1ca4ccb2e56a34c

Best regards,
-- 
Bjorn Helgaas <bhelgaas@google.com>

