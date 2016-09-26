Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34030 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162880AbcIZS2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 14:28:19 -0400
Received: by mail-yw0-f176.google.com with SMTP id g192so163442423ywh.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2016 11:28:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACK8Z6EFzB8VzGP7jqZJkKfO3_wS=K0XB7Q30ym0M=tkwtWuqA@mail.gmail.com>
References: <1472747248-60993-1-git-send-email-rajatja@google.com>
 <1473379530-70905-1-git-send-email-rajatja@google.com> <CACK8Z6HKhduwFj7LBoN52WBJaZB01LojNaA6J4u0cUx5RZzdpg@mail.gmail.com>
 <mj+md-20160926.182229.10984.albireo@ucw.cz> <CACK8Z6EFzB8VzGP7jqZJkKfO3_wS=K0XB7Q30ym0M=tkwtWuqA@mail.gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Mon, 26 Sep 2016 11:27:37 -0700
Message-ID: <CACK8Z6EChX9d99-=z=6HZYuKwusuVcZDHx4wkGY-_aO=yvUsOQ@mail.gmail.com>
Subject: Re: [PATCH v2] lspci: Parse all the L1 PM substate capability regs
To: Martin Mares <mj@ucw.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        David Box <david.e.box@linux.intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 26, 2016 at 11:26 AM, Rajat Jain <rajatja@google.com> wrote:
> Will do, thanks!
>
> On Mon, Sep 26, 2016 at 11:23 AM, Martin Mares <mj@ucw.cz> wrote:
>> Hello!
>>
>>> Just checking if you got a chance to look at this.
>>
>> It currently lives in the l1pm branch of pciutils.git, together with
>> a couple of my cleanups. Most importantly, your original patch did sometimes
>> print unterminated lines.
>>
>> Could you please check my version and submit a test case (a hex dump of
>> a config space with this capability, like those in tests/*).

I'll send the hex dump, however I do not know how to actually run the
test. I assume it is fine to just send a patch to tests/ that has the
hex dump.

>>
>>                                 Martin
