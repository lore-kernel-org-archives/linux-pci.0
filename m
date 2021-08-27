Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B91C4320E
	for <linux-pci@archiver.kernel.org>; Fri, 27 Aug 2021 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA556101C
	for <linux-pci@archiver.kernel.org>; Fri, 27 Aug 2021 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbhH0SAt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:00:49 -0400
Received: from rosenzweig.io ([138.197.143.207]:43652 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238532AbhH0SAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 14:00:49 -0400
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 4A9E941AEC; Fri, 27 Aug 2021 17:59:59 +0000 (UTC)
Date:   Fri, 27 Aug 2021 17:59:59 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
Message-ID: <YSkoHw3dZrW5Qnjf@rosenzweig.io>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-5-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827171534.62380-5-mark.kettenis@xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Clock references and DART (IOMMU) references are left out at the
> moment and will be added once the appropriate bindings have been
> settled upon.
> 

DART is in mainline .... is there a PCIe specific issue?
