Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2DC6FA83
	for <linux-pci@archiver.kernel.org>; Mon,  5 Sep 2022 02:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiIECd1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 4 Sep 2022 22:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIECd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2022 22:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E922C132;
        Sun,  4 Sep 2022 19:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B12A60F3C;
        Mon,  5 Sep 2022 02:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04097C433C1;
        Mon,  5 Sep 2022 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662345205;
        bh=SZNeueOviL5nKj7BJ/+AUY1Pi5Q6OG1O7EOPOkTCWnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg/p57B4dNTvp6LEJCSEWpVFxU29ieochHfl/DEkZooyvllkTCgFzHgP6ohxWiaAb
         x4mvt/HqOb5PvdCbhCuBlOZXoEbcZbxOWtPwQNt0CxXTOHgY0rQeqPnwNFfZ+tjo4B
         2QQnjQAghdnaKfche9KAD5gHh+Ru25xbOMZ6UqIj3S3jrBuFm0wzNO3Gfx6hnsiY+7
         oH9GJqNSS2If2SO+UNVF9KwK5a4rs3bUXPOKxnJI+YUhpjzimbxK3MI7X7OS4LjIAY
         5KMMjxVMSQ965pZMwwZ29v6n/1M12c2U2XvK89QHxEDdIJuI7KhUBx0B51/qKTl5gG
         170/2k0jR4XIA==
Date:   Mon, 5 Sep 2022 10:33:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        vkoul@kernel.org, alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v7 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Message-ID: <20220905023318.GE1728671@dragon>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
 <1662109086-15881-4-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662109086-15881-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 04:58:02PM +0800, Richard Zhu wrote:
> Add PCIe support on i.MX8MP EVK board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks!
