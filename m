Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D3EC4338F
	for <linux-pci@archiver.kernel.org>; Wed, 25 Aug 2021 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEFD611AF
	for <linux-pci@archiver.kernel.org>; Wed, 25 Aug 2021 10:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhHYKBA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 25 Aug 2021 06:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239628AbhHYKA7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 06:00:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 894E861184;
        Wed, 25 Aug 2021 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629885613;
        bh=1eoaKEeilo/wpb+m3uoKx3QtEoAXXbps1ms6hYWZMuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tyXkUrQOQ0iQG7o8Pkz7kKA032mqd+zI45jOoamiBBhT+epMFnp0kiynsQgZO3qak
         qgQmFzfFTCA5LdykdcPKkOfAot1j9VjvB18gRvqArnwPDA5WCbreG5/wFVayZKBNW3
         oLO7DlUvIvwXFPPtJRpLCK58p1QBQdp+W61chet2UuaNcjAmFx7XpnT+GQyNBD8Phl
         GJo2v7gwWbkvuNN3tKdzEWJAey+9vqYyNx539w/8nBubP1wu5xWfqft5f3v7QHrKuy
         goZhYispbmo0DcXF2ors2Ru1Dw1UI8TAz4YRQUpaXE+KCJJgCJejksouFeVfRmL6Ug
         fKMaStDe05T6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] 1GbE Intel Wired LAN Driver
 Updates 2021-08-24
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162988561351.31154.7675459871694727833.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Aug 2021 10:00:13 +0000
References: <20210824204248.2957134-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20210824204248.2957134-1-anthony.l.nguyen@intel.com>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        sasha.neftin@intel.com, vitaly.lifshits@intel.com,
        richardcochran@gmail.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 24 Aug 2021 13:42:44 -0700 you wrote:
> Vinicius Costa Gomes says:
> 
> This adds support for PCIe PTM (Precision Time Measurement) to the igc
> driver. PCIe PTM allows the NIC and Host clocks to be compared more
> precisely, improving the clock synchronization accuracy.
> 
> Patch 1/4 reverts a commit that made pci_enable_ptm() private to the
> PCI subsystem, reverting makes it possible for it to be called from
> the drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] Revert "PCI: Make pci_enable_ptm() private"
    https://git.kernel.org/netdev/net-next/c/1d71eb53e451
  - [net-next,2/4] PCI: Add pcie_ptm_enabled()
    https://git.kernel.org/netdev/net-next/c/014408cd624e
  - [net-next,3/4] igc: Enable PCIe PTM
    https://git.kernel.org/netdev/net-next/c/1b5d73fb8624
  - [net-next,4/4] igc: Add support for PTP getcrosststamp()
    https://git.kernel.org/netdev/net-next/c/a90ec8483732

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


