Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC14C43334
	for <linux-pci@archiver.kernel.org>; Sun, 19 Jun 2022 12:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiFSMhn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 19 Jun 2022 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFSMhm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2022 08:37:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE162EE;
        Sun, 19 Jun 2022 05:37:41 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o2uBQ-0005Md-E4; Sun, 19 Jun 2022 14:37:40 +0200
Message-ID: <2c6bd8f9-e466-50d0-0d24-0ec334db37cb@leemhuis.info>
Date:   Sun, 19 Jun 2022 14:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216109] New: Steam Deck fails
 to boot when E820 entries clipped out of _CRS] #forregzbot
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220609224339.GA543225@bhelgaas>
 <d4ea2dd2-2e89-d3a2-ee5c-f64bb1b8f576@leemhuis.info>
In-Reply-To: <d4ea2dd2-2e89-d3a2-ee5c-f64bb1b8f576@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655642261;3cec31bc;
X-HE-SMSGID: 1o2uBQ-0005Md-E4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 12.06.22 13:11, Thorsten Leemhuis wrote:

>> Subject: [Bug 216109] New: Steam Deck fails to boot when E820 entries clipped
>> 	out of _CRS
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=216109

#regzbot fixed-by: a2b36ffbf5b6

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.


