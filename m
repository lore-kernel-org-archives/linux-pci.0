Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:46808 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932758AbcLIOhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Dec 2016 09:37:18 -0500
Date: Fri, 9 Dec 2016 07:37:13 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: <linasvepstas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci-error-recover: doc cleanup
Message-ID: <20161209073713.43ed92ea@lwn.net>
In-Reply-To: <584A513B.9080409@cn.fujitsu.com>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
        <20161208070539.0f00ce71@lwn.net>
        <58496AA4.5030602@cn.fujitsu.com>
        <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
        <584A513B.9080409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 9 Dec 2016 14:37:47 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> I am little confused too, even not sure if we are talking the same
> *fatal error*, I am talking the fatal error defined in PCI Express spec,
> chapter 6.2.2.2.1:

Therein lies my original discomfort with the change; it didn't seem to
make sense to talk about recovering from a fatal error.  Perhaps making
it "is done whenever a fatal error (as defined in section 6.2.2.2.1) has
been detected that can be "solved" by resetting the link" or something
like that to make it clear how the term is being used?

Thanks,

jon
