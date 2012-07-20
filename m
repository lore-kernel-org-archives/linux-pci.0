Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57985 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2GTSRm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jul 2012 14:17:42 -0400
Received: by lbbgm6 with SMTP id gm6so5367001lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 20 Jul 2012 11:17:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4BDvognFbn6DZCEGuvf=u4g5HZRHtXb2cPGf2Kzz0tNQ@mail.gmail.com>
References: <CAErSpo4BDvognFbn6DZCEGuvf=u4g5HZRHtXb2cPGf2Kzz0tNQ@mail.gmail.com>
Date: Fri, 20 Jul 2012 11:17:40 -0700
Message-ID: <CAPoiz9y0z3ysiwm6AgyOq1kBeeO8kTAaxdyoJOcpEP9rxfdR5w@mail.gmail.com>
Subject: Re: pcie_bus_configure_settings() use of uninitialized value
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2012 at 6:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Jon,
>
> Coverity noticed that pcie_bus_configure_settings() can call
> pcie_bus_configure_set() when "smpss" is uninitialized.
>
> This might be only a theoretical problem because that can only happen
> if pcie_bus_config is PCIE_BUS_PERFORMANCE, and in that case, I
> *think* we don't care about smpss because pcie_write_mps() ignores the
> mps passed in and always uses dev->pcie_mpss.  But it takes a lot of
> analysis to be certain, and it would be better to make
> pcie_bus_configure_settings() cleaner.
>
> Would you mind fixing this up?

Sorry, just saw this.  Do you still want me to take a whack at it?

>
> Thanks,
>   Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
