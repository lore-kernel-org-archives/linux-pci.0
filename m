Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE7FEB64D8
	for <linux-pci@archiver.kernel.org>; Thu, 22 Jun 2023 07:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFVHmU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Jun 2023 03:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjFVHmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 03:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227211995
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 00:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30F961779
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 07:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10EC433C0;
        Thu, 22 Jun 2023 07:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687419733;
        bh=rmaQfsu9PoDuZdXq87lgBzvsxpk2CPPVtXY7H6gUJNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tul0Idz863hNbj/AkOcSUCRInoNv4pEyo0mJQSFIJyGGuqFNoWzwN6ZadcFqc8bqI
         bMyXEEwIMr4QvXyfiEJjk6YwXdbKIOC4Wp7bDMhWDz+VcXZkxQaDiJOnUuwdXK7QmE
         mQDdMIl7BkpVLoblxbPVGBEsyBWidaaZzHlhpxBKaFEXHUf7bK2CKOBTQxBI2hNWlD
         jLgmX+r0IONbWq2Wj2mVw+kEZ4C4yPpmosoIOoItqbahuwUCYN+m81n6d4q3JGTdAL
         BwvXnpe2585A/Ti0nFZSd5q4KwQwCL7NCLv184Y4t7nuIIvRDxni3W/wmNhVwqHC1P
         bZbjTtzKhVv6g==
Date:   Thu, 22 Jun 2023 09:42:09 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: Rockchip fixes
Message-ID: <ZJP7Udy5naEPinhq@lpieralisi>
References: <d023a76f-93af-4112-7020-d888bb8a0ee3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d023a76f-93af-4112-7020-d888bb8a0ee3@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 01:58:35PM +0900, Damien Le Moal wrote:
> Bjorn,
> 
> I still do not see Rick's series queued in pci/next to fix the Rockchip endpoint
> driver...
> 
> https://lore.kernel.org/linux-pci/20230418074700.1083505-1-rick.wertenbroek@gmail.com/
> 
> Did this one fall through the cracks ? It was posted and fully reviewed last
> cycle. Really need that one upstream.

I wrongly delegated it to Krzysztof in patchwork so it went back to his
patch queue, my bad.

Now pulled, thanks.

Lorenzo

> 
> Or is it in some other branch ?
> 
> -- 
> Damien Le Moal
> Western Digital Research
