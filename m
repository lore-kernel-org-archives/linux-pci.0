Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52AC433E0
	for <linux-pci@archiver.kernel.org>; Tue, 29 Dec 2020 21:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A1720727
	for <linux-pci@archiver.kernel.org>; Tue, 29 Dec 2020 21:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgL2VWv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Dec 2020 16:22:51 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:58849 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL2VWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 16:22:51 -0500
Received: from windsurf (unknown [91.174.235.35])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D3861240002;
        Tue, 29 Dec 2020 21:22:06 +0000 (UTC)
Date:   Tue, 29 Dec 2020 22:22:05 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, mparab@cadence.com,
        pthombar@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v6 1/2] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Message-ID: <20201229222205.576549d1@windsurf>
In-Reply-To: <20201228140510.14641-2-nadeem@cadence.com>
References: <20201228140510.14641-1-nadeem@cadence.com>
        <20201228140510.14641-2-nadeem@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

The commit title is incorrect, it doesn't match what the patch is doing.

On Mon, 28 Dec 2020 15:05:09 +0100
Nadeem Athani <nadeem@cadence.com> wrote:

> Moving the function above to remove compilation error.
> No changes in function.

Which compilation error? I guess there is no compilation error, except
after your apply your PATCH 2/2. Is this correct ?

If so, this should be explained in this commit log: "Move the function
cdns_pcie_host_wait_for_link() further up in the file, as it's going to
be used by upcoming additional code in the driver."

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
