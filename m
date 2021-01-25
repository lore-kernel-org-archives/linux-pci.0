Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FEFC433DB
	for <linux-pci@archiver.kernel.org>; Mon, 25 Jan 2021 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0DA22ADF
	for <linux-pci@archiver.kernel.org>; Mon, 25 Jan 2021 17:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbhAYRft (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:35:49 -0500
Received: from foss.arm.com ([217.140.110.172]:53248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbhAYRfd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 12:35:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5CCD1063;
        Mon, 25 Jan 2021 09:34:40 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.45.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93B723F68F;
        Mon, 25 Jan 2021 09:34:38 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Add missing of_node_put() to fix reference leak
Date:   Mon, 25 Jan 2021 17:34:33 +0000
Message-Id: <161159605117.9561.12692669940945121604.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210120184810.3068794-1-kw@linux.com>
References: <20210120184810.3068794-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Jan 2021 18:48:10 +0000, Krzysztof Wilczyński wrote:
> The for_each_available_child_of_node helper internally makes use of the
> of_get_next_available_child() which performs an of_node_get() on each
> iteration when searching for next available child node.
> 
> Should an available child node be found, then it would return a device
> node pointer with reference count incremented, thus early return from
> the middle of the loop requires an explicit of_node_put() to prevent
> reference count leak.
> 
> [...]

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek: Add missing of_node_put() to fix reference leak
      https://git.kernel.org/lpieralisi/pci/c/42814c438a

Thanks,
Lorenzo
