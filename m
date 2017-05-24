Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33996 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdEXUez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2017 16:34:55 -0400
Received: by mail-wr0-f181.google.com with SMTP id j27so7791930wre.1
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2017 13:34:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUeeCrrXnQP9L9rW_XR5RLAu8XJyH947yR765DCZxYzbg@mail.gmail.com>
References: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
 <CAErSpo640q4rgaDE=59TGGAw9_MhNQj2=4+A_4Qgoy2ZUAW7sQ@mail.gmail.com> <CAE9FiQUeeCrrXnQP9L9rW_XR5RLAu8XJyH947yR765DCZxYzbg@mail.gmail.com>
From: Kyle Gale <kylewgale@gmail.com>
Date: Wed, 24 May 2017 13:34:53 -0700
Message-ID: <CAEhpy_f9WmiA_Sp29Cx6ccBqFCFi8Xp9mJosi8jsBW-eobyyUg@mail.gmail.com>
Subject: Re: PCI Rescan Question
To: Yinghai Lu <yinghai@kernel.org>, lukas@wunner.de
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thank you for your responses,

It was not so much a problem with the pciehp driver - it worked fine
when I eventually enabled some of the slot's configuration registers.
I was just doing some things manually via sysfs during my bring-up,
and was surprised that a rescan wasn't enough to fully refresh the
tree. I can see now that a rescan will skip some code if a pci_dev
with the same devfn already exists from an previous enumeration of the
pci_bus, but intuitively I wouldn't have expected this to be the case.

Thanks,
Kyle
