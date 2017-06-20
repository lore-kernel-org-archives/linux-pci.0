Return-Path: <SRS0=Mkam=5Z=canonical.com=kai.heng.feng@kernel.org>
Return-Path: <SRS0=Mkam=5Z=canonical.com=kai.heng.feng@kernel.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
References: <20170619174533.GA20550@bhelgaas-glaptop.roam.corp.google.com> <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 20 Jun 2017 10:36:59 +0800
Message-ID: <CAAd53p6Dc2skx1sjDcwG_5VLGOHo_bQK9h3UOJN7o9OuZXDqbA@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 2:32 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> It's possible that the test was invalid.  Kai-Heng did not say whether
> /sys/.../power/wakeup was set to "enabled" for both the EHCI controller
> and the USB root hub beneath it, before the test was started.  If
> either of them was set to "disabled" then we would not expect a plug or
> unplug event to wake up the system.

You are right, it's "disabled" on USB root hub.
Changed it to "enabled", the test result remains the same.

>
> In any case, the controller should be set to the lowest power setting
> that is consistent with the desired wakeup behavior.  If wakeup is set
> to "enabled" then the state should be D2 -- if possible.  That's the
> theory, anyway.  If the system supports putting devices only into D3
> during S3 sleep then there's no choice, but if we do have a choice then
> we should take it.
>
> BTW, I just noticed that pci_target_state() uses device_may_wakeup() to
> get the desired wakeup behavior.  That is correct for system sleep, but
> it is wrong for runtime PM.  For runtime PM, wakeup should be enabled
> whenever the hardware allows it, so the test should be
> device_can_wakeup().
>
> This means that pci_target_state() should behave differently depending
> on whether it is called from pci_prepare_to_sleep() or from
> pci_finish_runtime_suspend().  Probably nobody noticed this before
> because it usually doesn't make any difference.
>
> Alan Stern
>
