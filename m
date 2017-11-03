Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44574 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdKCKXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 06:23:33 -0400
MIME-Version: 1.0
In-Reply-To: <5a8c7aaf-552c-7170-2a36-13b50168a9cc@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
 <20171031223936.27549-15-niklas.cassel@axis.com> <CAK8P3a1yGwyZPzd2-usqLe=BiQpdFsyyFOhpP1ZyaCb16rzCSQ@mail.gmail.com>
 <5a8c7aaf-552c-7170-2a36-13b50168a9cc@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 3 Nov 2017 11:23:32 +0100
Message-ID: <CAK8P3a0u744zK12QLsWQQOaHHbZKu=KaJuuwWejx1eJsgq+gbg@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] PCI: dwc: artpec6: Add support for endpoint mode
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 3, 2017 at 10:56 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> On 11/02/2017 10:13 AM, Arnd Bergmann wrote:

>>
>>
>> Can you try replacing the #ifdef with
>>
>>
>>         if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
>>                  return -ENODEV;
>>
>> at the start of artpec6_pcie_enable_interrupts? I think that would improve
>> readability here.
>>
>
> artpec6_pcie_enable_interrupts is a void function, so
> I guess that you meant at the start of artpec6_add_pcie_port.

Right, sorry about that.

> That would not really help since artpec6_add_pcie_port
> calls artpec6_pcie_msi_handler, and uses artpec6_pcie_host_ops,
> which is still inside the CONFIG_PCIE_ARTPEC6_HOST ifdef block.
>
> Please note that there are several functions, as well as
> artpec6_pcie_host_ops inside the
> CONFIG_PCIE_ARTPEC6_HOST ifdef block.

What I meant is that you can remove the #ifdef entirely if you add

         if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
                  return -ENODEV;

to artpec6_pcie_probe(). Anything after that statement will get
silently dropped by the compiler, including static functions and
structures that are referenced indirectly from there.

      Arnd
