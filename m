Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385FC77B7D
	for <linux-pci@archiver.kernel.org>; Thu, 18 May 2023 11:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjERLLb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 May 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjERLL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 07:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5070210B
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 04:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8306D64D00
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 11:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB55C433D2;
        Thu, 18 May 2023 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684408183;
        bh=PHoI2IxtDIJ6Dnsz9LBFOzYheliLZgZWBE9CKs5Hlz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=By3mRAvx76Puf9DvhovHUS6aBAfWoIdoTYJSNvkRyXaF/gmx2Ss+2NuMkNm6bnxFJ
         8OuKat+7xxLg47RyUL+XQtPm5mSXP3T/CpspqbSg+HvHMxwHzFcnYFYF1a7Y4I9fu1
         fWdOpZ1HGxyEk+2kdq5/MpvQDAr9n3mk4/MsAOcHW7NyYeSciWiPuabv6CdG8s8Fku
         h1cDk4mtlv/2UASPS//nEKVGLfqhLUQnTTM7By2KeyizfkwtHrN7cQ7ArfNYlhjDE9
         sUDKPR2L32pEATcvTF8QRAlsRKOEq2/HU8Yzpp2qYYPUVIC+k81qaRnz7tn01Vqrjv
         fthc6tZOp2UYA==
Date:   Thu, 18 May 2023 06:09:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Rongguang Wei <clementwei90@163.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <ZGYHdbvZ8JJUFPMc@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518062557.GB13145@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 18, 2023 at 08:25:57AM +0200, Lukas Wunner wrote:
> On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> > I'm curious why we want the 5 seconds of blinking power indicator at
> > all.  We can't really do anything in response to an Attention Button
> > on an empty slot, so could we just ignore it completely in
> > pciehp_handle_button_press()?
> 
> That wouldn't cover the case where the slot is occupied when the
> button is pressed, but the card is yanked out during the 5 second
> blinking interval.

Obviously we can't ignore a button press when the slot is occupied,
because that's part of the "insert card, press button to power it up"
and "press button to power down card, remove card" flows.

I'm asking about ignoring it when the slot is empty, which would mean
adding a check for card presence in pciehp_handle_button_press().  But
maybe there's a reason why we can't do that there?

Bjorn
