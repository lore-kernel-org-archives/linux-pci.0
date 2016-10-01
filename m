Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33888 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbcJAAog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2016 20:44:36 -0400
Received: by mail-yw0-f182.google.com with SMTP id g192so78757854ywh.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2016 17:44:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mj+md-20160926.182825.94359.nikam@ucw.cz>
References: <1472747248-60993-1-git-send-email-rajatja@google.com>
 <1473379530-70905-1-git-send-email-rajatja@google.com> <CACK8Z6HKhduwFj7LBoN52WBJaZB01LojNaA6J4u0cUx5RZzdpg@mail.gmail.com>
 <mj+md-20160926.182229.10984.albireo@ucw.cz> <CACK8Z6EFzB8VzGP7jqZJkKfO3_wS=K0XB7Q30ym0M=tkwtWuqA@mail.gmail.com>
 <CACK8Z6EChX9d99-=z=6HZYuKwusuVcZDHx4wkGY-_aO=yvUsOQ@mail.gmail.com> <mj+md-20160926.182825.94359.nikam@ucw.cz>
From: Rajat Jain <rajatja@google.com>
Date: Fri, 30 Sep 2016 17:43:55 -0700
Message-ID: <CACK8Z6EbxJqFcmek_nEabZhfa9Ct7yCjghrqOYhRtWx2UOEi=w@mail.gmail.com>
Subject: Re: [PATCH v2] lspci: Parse all the L1 PM substate capability regs
To: Martin Mares <mj@ucw.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        David Box <david.e.box@linux.intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

Sorry, it took me a while to respond. I've just sent out a patch for
tests/cap-l1-pm that has the data for tests.

Yes, your new patch worked fine.

Thanks,

Rajat

On Mon, Sep 26, 2016 at 11:28 AM, Martin Mares <mj@ucw.cz> wrote:
> Hi!
>
>> I'll send the hex dump, however I do not know how to actually run the
>> test. I assume it is fine to just send a patch to tests/ that has the
>> hex dump.
>
> Exactly.
>
> So far, the tests are conducted manually.
>
>                                 Have a nice fortnight
> --
> Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
> System going down at 5 pm to install scheduler bug.
