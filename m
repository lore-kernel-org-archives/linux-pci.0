Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35180 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeAYQyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 11:54:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180125164010.GG4180@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan> <20180105004130.GA151625@google.com>
 <2806186.IK6EZBC0cX@aspire.rjw.lan> <20180125012148.lcgnxi3uwcjzue7o@ban.mtv.corp.google.com>
 <20180125164010.GG4180@atomide.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jan 2018 17:54:23 +0100
Message-ID: <CAJZ5v0h7JvEFTV1mbqxtK8P0aoums2Cvjy3uU1gK4E26_rtZ5g@mail.gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
To: Tony Lindgren <tony@atomide.com>
Cc: Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 25, 2018 at 5:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Brian Norris <briannorris@chromium.org> [180125 01:22]:
>> On Fri, Jan 05, 2018 at 02:13:33AM +0100, Rafael J. Wysocki wrote:
>> > The "wakeup-interrupt" property at the bridge level basically has to be defined
>> > as the wakeup interrupt for all devices on the bus under the bridge.
>>
>> The only thing I'm at a loss for is whether this goes in (referring to
>> rk3399-gru.dtsi) &pcie or &pci_rootport. I think some versions of this
>> series have been aiming for the former, and some the latter.
>
> I'd keep the wakeup interrupt property at the rootport level. That way
> it can work with whatever pcie card that might be plugged into that
> slot. That is in case it's just a slot and not hardwired pcie device :)

Do I understand correctly that &pcie is the device and the
&pci_rootport is the port that device is connected to?
