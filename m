Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35037 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072AbaFZP1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 11:27:11 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so3076103iec.23
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2014 08:27:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGAs2A=Uexvs8Fqb9N3w=zaR-yJm=GpVVCOHM2G6Kmz1s_EXJw@mail.gmail.com>
References: <CAGAs2AnhfVoiTjNvM3Cf7eeX=sSyJscQa3w3yKtf0AeqRwQ-5Q@mail.gmail.com>
 <CAGAs2A=Uexvs8Fqb9N3w=zaR-yJm=GpVVCOHM2G6Kmz1s_EXJw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 26 Jun 2014 09:26:50 -0600
Message-ID: <CAErSpo4YYh1CS1ta2swWM495pYwo2pNMJ2GV4EQ9vW5U1z+XjQ@mail.gmail.com>
Subject: Re: Suspend/Resume support for PCI
To: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Cc: Scott Murray <scott@spiteful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm]

On Wed, Jun 25, 2014 at 11:04 PM, AYAN KUMAR HALDER
<ayankumarh@gmail.com> wrote:
> Hi,
>
> I am using a ARM based custom SOC which has a power management unit to
> turn off/on the various power domains. When I execute a suspend
> command(echo mem > /sys/power/state), then I turn off the power of the
> entire SOC except my PMU( as they are in different power domains).
> When ever the PMU receives a certain wake-up interrupt, it powers up
> the CPU and SOC and the CPU resumes the kernel as per the Linux power
> management framework.
>
> Now I have a PCI controller which has been configured in
> "linux/arch/arm/<mach-mysoc>/pcie.c". During suspend as the PCI
> power(which is part of the SOC power domain) gets turned off, so the
> controller loses its register configurations. On resume, the pci
> driver's resume functions get called and the system hangs up(when it
> tries to read/write to pci configuration space).
>
> As per my understanding, the pci driver has implementation of bus/
> device power management. It does not reconfigure the pci controller.
> So how should I make the pci controller work fine on system resume.
> Is it so that I need to reconfigure the pcie controller's registers
> (as it has been done in "linux/arch/arm/<mach-mysoc>/pcie.c") from the
> resume function of pci driver. Or would that compromise the entire
> linux pm framework.
>
> Regards,
> Ayan Kumar Halder
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
