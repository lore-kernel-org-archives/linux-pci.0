Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53938 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511Ab2GXQZe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2012 12:25:34 -0400
Received: by lahd3 with SMTP id d3so1080824lah.19
        for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 09:25:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPoiz9y0z3ysiwm6AgyOq1kBeeO8kTAaxdyoJOcpEP9rxfdR5w@mail.gmail.com>
References: <CAErSpo4BDvognFbn6DZCEGuvf=u4g5HZRHtXb2cPGf2Kzz0tNQ@mail.gmail.com>
 <CAPoiz9y0z3ysiwm6AgyOq1kBeeO8kTAaxdyoJOcpEP9rxfdR5w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Jul 2012 10:25:12 -0600
Message-ID: <CAErSpo7XU+afNy9fkF5TeDQxDoTM_bcNvsc3-SxeV3ySSs1NPA@mail.gmail.com>
Subject: Re: pcie_bus_configure_settings() use of uninitialized value
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2012 at 12:17 PM, Jon Mason <jdmason@kudzu.us> wrote:
> On Tue, Jun 19, 2012 at 6:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Hi Jon,
>>
>> Coverity noticed that pcie_bus_configure_settings() can call
>> pcie_bus_configure_set() when "smpss" is uninitialized.
>>
>> This might be only a theoretical problem because that can only happen
>> if pcie_bus_config is PCIE_BUS_PERFORMANCE, and in that case, I
>> *think* we don't care about smpss because pcie_write_mps() ignores the
>> mps passed in and always uses dev->pcie_mpss.  But it takes a lot of
>> analysis to be certain, and it would be better to make
>> pcie_bus_configure_settings() cleaner.
>>
>> Would you mind fixing this up?
>
> Sorry, just saw this.  Do you still want me to take a whack at it?

It'd be great if you did.  I haven't done anything with it, but would
like to resolve Coverity warnings.
