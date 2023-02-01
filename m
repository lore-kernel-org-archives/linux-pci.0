Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A6C636D3
	for <linux-pci@archiver.kernel.org>; Wed,  1 Feb 2023 23:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBAX14 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBAX1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 18:27:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46375BB7
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 15:27:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EDBF61982
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 23:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551DBC433D2;
        Wed,  1 Feb 2023 23:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675294072;
        bh=RWoOaeA8WKVSkilf0ogrMhF6p1JmcfEnPTqAXbIcaZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GBlOa1a+Lj6d2/HdIwDlpPDCsirYOsenVhX+0vaRZTfyJdCmUP/qgw+07jfFwYOYj
         6aIeQVKAs14KsRP6gwJRkkP9tLwqUS0BY+xAfUsmLlSjB6OH+TwiuqsBW2OT67I4Uz
         Ol6E1aUUdWWHiYFQGaIkgYfqSBtFpFqm9rWvOb63uMlm6M8DcJoQmF8mhgdcgfymP/
         2XgQlgTAdSVfXGYAb04uMAhGpmja1Ir4qVnJ+/uhd0HcvwkqSRCdHPeyYAhm5qLSgM
         ipd4jxcXTknoQk8TKyB9puZRm4jgjiSW9tfxnKtcUlxIfrZvyg+ubeGVo/4K9bT1k5
         fVL57OEh/E1pw==
Date:   Wed, 1 Feb 2023 17:27:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     regressions@lists.linux.dev
Cc:     linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] [Bug 216859] New: PCI bridge to bus boot hang at
 enumeration
Message-ID: <20230201232750.GA1908996@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126121124.GA1258686@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 06:11:24AM -0600, Bjorn Helgaas wrote:
> [+cc folks from 145eed48de27 and framebuffer folks, regression list]
> 
> On Thu, Jan 12, 2023 at 02:08:19PM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 28, 2022 at 06:02:48AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > 
> > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > >     Kernel Version: 6.1-rc1
> > > > ...
> > > 
> > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > see attachments.
> > > > 
> > > > The enumeration works fine with Kernel 6.0 and below.
> > > > 
> > > > Same problem still exists with v6.1. and v6.2.-rc1
> 
> This is a regression between v6.0 and v6.1-rc1.  Console output during
> boot freezes after nvidiafb deactivates the VGA console.
> 
> It was a lot of work for Zeno, but we finally isolated this console
> hang to 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus").
> 
> The system actually does continue to boot and is accessible via ssh, 
> but the console appears hung, at least for output.  More details in
> the bugzilla starting at
> https://bugzilla.kernel.org/show_bug.cgi?id=216859#c47 .

#regzbot introduced: 145eed48de27
#regzbot dup: https://lore.kernel.org/all/D41A3A42-2412-4722-9090-01565058E525@gmail.com/
