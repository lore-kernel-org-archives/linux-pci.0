Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:49429 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753046AbcLSDV3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2016 22:21:29 -0500
Subject: Re: [PATCH] pci-error-recover: doc cleanup
To: Jonathan Corbet <corbet@lwn.net>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161208070539.0f00ce71@lwn.net> <58496AA4.5030602@cn.fujitsu.com>
 <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
 <584A513B.9080409@cn.fujitsu.com> <20161209073713.43ed92ea@lwn.net>
CC: <linasvepstas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5857533F.1030904@cn.fujitsu.com>
Date: Mon, 19 Dec 2016 11:25:51 +0800
MIME-Version: 1.0
In-Reply-To: <20161209073713.43ed92ea@lwn.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry for late.

On 12/09/2016 10:37 PM, Jonathan Corbet wrote:
> On Fri, 9 Dec 2016 14:37:47 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> I am little confused too, even not sure if we are talking the same
>> *fatal error*, I am talking the fatal error defined in PCI Express spec,
>> chapter 6.2.2.2.1:
> 
> Therein lies my original discomfort with the change; it didn't seem to
> make sense to talk about recovering from a fatal error.  Perhaps making
> it "is done whenever a fatal error (as defined in section 6.2.2.2.1) has
> been detected that can be "solved" by resetting the link" or something
> like that to make it clear how the term is being used?
> 

I find that the .link_reset callback of struct pci_error_handlers isn't
called by anyone(if I didn't miss anything), and just a few drivers
implement this callback, and their implementation seems meaningless.

And the reset_link() provided by aer driver seems is a different thing
with .link_reset callback. So I am guessing this patch probably is not
quite suitable, and the doc maybe need update totally.

-- 
Sincerely,
Cao jin


