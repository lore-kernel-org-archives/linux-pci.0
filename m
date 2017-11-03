Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:55108 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdKCORn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 10:17:43 -0400
Subject: Re: [PATCH v3 14/17] PCI: dwc: artpec6: Add support for endpoint mode
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
 <20171031223936.27549-15-niklas.cassel@axis.com>
 <CAK8P3a1yGwyZPzd2-usqLe=BiQpdFsyyFOhpP1ZyaCb16rzCSQ@mail.gmail.com>
 <5a8c7aaf-552c-7170-2a36-13b50168a9cc@axis.com>
 <CAK8P3a0u744zK12QLsWQQOaHHbZKu=KaJuuwWejx1eJsgq+gbg@mail.gmail.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <c87b2ef1-9bb4-cb1b-872d-bb234e14511e@axis.com>
Date: Fri, 3 Nov 2017 15:16:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0u744zK12QLsWQQOaHHbZKu=KaJuuwWejx1eJsgq+gbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/03/2017 11:23 AM, Arnd Bergmann wrote:
> On Fri, Nov 3, 2017 at 10:56 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
>> On 11/02/2017 10:13 AM, Arnd Bergmann wrote:

> What I meant is that you can remove the #ifdef entirely if you add
> 
>          if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
>                   return -ENODEV;
> 
> to artpec6_pcie_probe(). Anything after that statement will get
> silently dropped by the compiler, including static functions and
> structures that are referenced indirectly from there.

Wow, this actually helps gcc with dead code elimination.
It was even possible to add those !IS_ENABLED the two different
case labels in the switch statement.
I get no unwanted symbols when looking at the vmlinux in gdb.

Great suggestion Arnd :)


Regards,
Niklas
