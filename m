Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E55EC433F5
	for <linux-pci@archiver.kernel.org>; Wed, 11 May 2022 14:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiEKO0r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 11 May 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiEKO0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:26:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA6636AA67;
        Wed, 11 May 2022 07:26:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C256ED1;
        Wed, 11 May 2022 07:26:41 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D14B3F66F;
        Wed, 11 May 2022 07:26:38 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     ryder.lee@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, jianjun.wang@mediatek.com,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        kernel@collabora.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, bhelgaas@google.com,
        nfraprado@collabora.com, kw@linux.com
Subject: Re: [PATCH] PCI: mediatek-gen3: Assert resets to ensure expected init state
Date:   Wed, 11 May 2022 15:26:27 +0100
Message-Id: <165227916327.28061.3388397168727783283.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220404144858.92390-1-angelogioacchino.delregno@collabora.com>
References: <20220404144858.92390-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 Apr 2022 16:48:58 +0200, AngeloGioacchino Del Regno wrote:
> The controller may have been left out of reset by the bootloader,
> in which case, before the powerup sequence, the controller will be
> found preconfigured with values that were set before booting the
> kernel: this produces a controller failure, with the result of
> a failure during the mtk_pcie_startup_port() sequence as the PCIe
> link never gets up.
> 
> [...]

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek-gen3: Assert resets to ensure expected init state
      https://git.kernel.org/lpieralisi/pci/c/1d565935e3

Thanks,
Lorenzo
