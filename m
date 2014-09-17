Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:54267 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaIQGsk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Sep 2014 02:48:40 -0400
Received: by mail-qc0-f172.google.com with SMTP id i17so1483088qcy.31
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 23:48:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANybWhpt7L2JwKBjn2iU_J1sz-GAgN4Ge4jBM_2ry5srbun0hw@mail.gmail.com>
References: <CANybWhpt7L2JwKBjn2iU_J1sz-GAgN4Ge4jBM_2ry5srbun0hw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 16 Sep 2014 23:48:19 -0700
Message-ID: <CAErSpo7DCcEK23EKGujFs21n0nz9L_xLMjCFnpH5CiE2g_+r3w@mail.gmail.com>
Subject: Re: [HELP] PCI error recovery driver routine not called
To: Alvin Abitria <abitria.alvin@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alvin,

On Tue, Sep 16, 2014 at 4:53 PM, Alvin Abitria <abitria.alvin@gmail.com> wrote:
> Hello,
>
> I have a question regarding PCIe error recovery, because in my
> implementation it's not working.  I've simply implemented and
> registered pcie error handler methods to my driver in order to handle
> error events.  Whenever I trigger an error in my PCIe device that
> causes its PCIe core to reset (and most likely to disconnect).  The
> I/O drops to zero after that and it is expected.  However, I am not
> notified by the err_detected method under the error handlers. Does
> this means the system was unable to detect the error?  Instead I ended
> up with the following console message:

I think the only current mechanisms for reporting PCI errors and
calling a driver's ->error_detected method are AER and powerpc EEH.  I
assume you're probably not on powerpc, so only AER would apply in your
case.

Since you're resetting your PCIe core, your device probably is not
going to generate any kind of AER error event for itself.  A switch
upstream from your device could generate an AER event, but it could
only do that when it notices something is wrong.  I would guess you'd
be looking for an event such as those in the Uncorrectable Error
Status register (PCIe spec r3.0, sec 7.10.2).  The only one I see that
seems likely is a "Surprise Down" error, but I think support for that
is optional.

"lspci -vv" will decode the AER status bits and you can see whether
anything gets set when you inject the error.

Does your driver perform MMIO accesses to the device after you inject
the error and reset its PCIe core?  If so, it's possible you'd get an
error there, but I'm not sure.  Writes might simply be dropped, and
reads often just return -1 if nothing responds, without signaling an
error.

> irq 16: nobody cared
> handlers:
> ...
> ...
> Disabling IRQ # 16
>
> What baffles me more is that the injected PCI error seemed to brought
> down that IRQ 16 device as well - which is definitely not the irq # of
> my driver/device.  Why is this message posting, and is it expected?
> Is there anything I could possibly missed during registration of error
> handler methods?

I think this means we got IRQ 16, but none of the handlers thought it
was from their device.  So I assume the device where you injected the
error must have generated IRQ 16.  I don't know why that would be.  If
you have a PCIe analyzer, I guess you could learn more about what
happens on the link when you inject the error.

Bjorn
