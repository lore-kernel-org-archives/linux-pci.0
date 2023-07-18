Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F9AEB64DC
	for <linux-pci@archiver.kernel.org>; Tue, 18 Jul 2023 11:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGRLT7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Jul 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGRLT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 07:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23F170E
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 04:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 991F861515
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 11:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA609C433C8;
        Tue, 18 Jul 2023 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689679195;
        bh=rF2pBuIUYxfvEQUSigKN+gITIverQDyRC4xQkOUxSgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hNexe+eMvGsJPQS/oOgah4Kp99GifomgNA5kNnh7XsyQ3dWvGPeyy9eQKco0Cs3Is
         UEnuw/w+sGnnhfjnoJF7sbRpDyf7BQXFaDrisjhWIRb8ba6uCwgtpGGm7UsIt5NOSq
         5U1duI7drmRmqfJAEjpMunFxIt3Qhk/pJaxIJ6CdNjN+ZU6pvFUmuRABuV62iSpwEv
         SG7MhW+HhMPFZ4beJytBKeQHB/rHirbgT3xTjTM9t0nVWx+2VM91TxLTqvDG8wmc8L
         Hoc2gPNJGS4rj4eUAtozCvKj6TMhWOeEyeDriF9W7HNv7swLRxy8RIUjV1+tqsBEcU
         rYomrdsl5KL6w==
Date:   Tue, 18 Jul 2023 06:19:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718111952.GA475778@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717220317.q7hgtpppvruxiapx@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Radu]

On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> Hello, I have just one question. What do you want to do with pci-mvebu
> driver? It is already marked as broken for 3 kernel releases and I do
> not see any progress from anybody (and you rejected my fixes). How long
> do you want it to have marked as broken?

I don't think "depends on BROKEN" necessarily means that we plan to
remove the driver.  I think it just means that it's currently broken,
but we hope to fix it eventually.

I think the problem here is the regular vs chained interrupt handlers,
right?  Radu has been looking at that recently, too, so maybe we can
have another go at it.

Bjorn
