Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:40234 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaFZFEM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 01:04:12 -0400
Received: by mail-pb0-f52.google.com with SMTP id rq2so2639627pbb.11
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 22:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGAs2AnhfVoiTjNvM3Cf7eeX=sSyJscQa3w3yKtf0AeqRwQ-5Q@mail.gmail.com>
References: <CAGAs2AnhfVoiTjNvM3Cf7eeX=sSyJscQa3w3yKtf0AeqRwQ-5Q@mail.gmail.com>
Date: Thu, 26 Jun 2014 10:34:12 +0530
Message-ID: <CAGAs2A=Uexvs8Fqb9N3w=zaR-yJm=GpVVCOHM2G6Kmz1s_EXJw@mail.gmail.com>
Subject: Fwd: Suspend/Resume support for PCI
From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
To: Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am using a ARM based custom SOC which has a power management unit to
turn off/on the various power domains. When I execute a suspend
command(echo mem > /sys/power/state), then I turn off the power of the
entire SOC except my PMU( as they are in different power domains).
When ever the PMU receives a certain wake-up interrupt, it powers up
the CPU and SOC and the CPU resumes the kernel as per the Linux power
management framework.

Now I have a PCI controller which has been configured in
"linux/arch/arm/<mach-mysoc>/pcie.c". During suspend as the PCI
power(which is part of the SOC power domain) gets turned off, so the
controller loses its register configurations. On resume, the pci
driver's resume functions get called and the system hangs up(when it
tries to read/write to pci configuration space).

As per my understanding, the pci driver has implementation of bus/
device power management. It does not reconfigure the pci controller.
So how should I make the pci controller work fine on system resume.
Is it so that I need to reconfigure the pcie controller's registers
(as it has been done in "linux/arch/arm/<mach-mysoc>/pcie.c") from the
resume function of pci driver. Or would that compromise the entire
linux pm framework.

Regards,
Ayan Kumar Halder
