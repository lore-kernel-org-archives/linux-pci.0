Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA88EB64DC
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jul 2023 22:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGQWDW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Jul 2023 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQWDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 18:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D902E60
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 15:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23048612B3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 22:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E25C433C7;
        Mon, 17 Jul 2023 22:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689631400;
        bh=wIAqBUDvYSQp4dp6IQ1cXjue51F+w4H+bhd9DNZWrU4=;
        h=Date:From:To:Subject:From;
        b=DQaCYNzPq7Bz8GNsNb/YLlmEotQPdpJ+LqWxPrhdMyMx+g/LUhSHZw/bxW3jTwkwa
         7kVaFHggaZA8pJAST36m74mOxC8i6W9Tt6G7nuTy5GAM9YFIBR+/N4ezr2BDuk4FlG
         cVvohF1qwoUAEUYnuKDzp4Nl6vEVzChlxq3I+fvdErkQLjzz/jMpKQHBi+KdQ3Oupm
         5uYvSqm6s6ekZLoCcoO2LsAOrqgAYuqCGVDLI0UnuHr7RmgDOkKFLe0BvNyWi4pw5J
         RfturDaQKm/rrR7EyqylGbYU4cThU2uPNsH2Fxn4WGe93DnKbc5yoRSoSucRg6qXt0
         PfzUN4J7gJNGg==
Received: by pali.im (Postfix)
        id 470528AF; Tue, 18 Jul 2023 00:03:17 +0200 (CEST)
Date:   Tue, 18 Jul 2023 00:03:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Future of pci-mvebu
Message-ID: <20230717220317.q7hgtpppvruxiapx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, I have just one question. What do you want to do with pci-mvebu
driver? It is already marked as broken for 3 kernel releases and I do
not see any progress from anybody (and you rejected my fixes). How long
do you want it to have marked as broken?
