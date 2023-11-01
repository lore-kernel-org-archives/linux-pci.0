Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678FCC4332F
	for <linux-pci@archiver.kernel.org>; Wed,  1 Nov 2023 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjKAK7y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 1 Nov 2023 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKAK7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 06:59:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909EF7
        for <linux-pci@vger.kernel.org>; Wed,  1 Nov 2023 03:59:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qy8wt-0006AC-4r; Wed, 01 Nov 2023 11:59:47 +0100
Message-ID: <0f256363-430c-49c9-b395-94c3c7ceab06@leemhuis.info>
Date:   Wed, 1 Nov 2023 11:59:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Content-Language: en-US, de-DE
To:     Kamil Paral <kparal@redhat.com>, linux-pci@vger.kernel.org
Cc:     regressions@lists.linux.dev
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698836388;8e952d61;
X-HE-SMSGID: 1qy8wt-0006AC-4r
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking.]

On 21.08.23 12:39, Kamil Paral wrote:
> = Summary =
> A Thinkpad T480s laptop with a Thinkpad Thunderbolt 3 Dock connected
> can no longer resume from suspend. The problem was introduced in
> e8b908146d44 "PCI/PM: Increase wait time after resume".
> [...]
> #regzbot introduced: e8b908146d44

Kamil, It looks like you found a workaround and lack time to further
look into this. Nobody else seems to have run into this and it seems
this is a odd corner case. Hence I guess there is not much value in
tracking this regression further for now. Please speak up if you disagree.

#regzbot inconclusive: workaround found, debugging stuck
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


