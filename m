Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQVZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2018 17:25:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 17 May 2018 17:25:52 -0400
From: okaya@codeaurora.org
To: Rajat Jain <rajatja@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: RFC: Counters for PCI Express AERs
In-Reply-To: <CACK8Z6Hjxd+6qRthHEQRuo0_NXX06iDqggrVN83O0QkN=3+9gg@mail.gmail.com>
References: <CACK8Z6Hjxd+6qRthHEQRuo0_NXX06iDqggrVN83O0QkN=3+9gg@mail.gmail.com>
Message-ID: <dee623fb19f82f3a600dd816cba9f489@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-17 17:05, Rajat Jain wrote:
> Hello,
> 
> I have been thinking about adding counters for different kinds of AERs
> and expose them via sysfs. IMHO this would help by giving some sense
> of "link quality" for PCIe links (a lot of correctable AERs may
> indicate system is workable, but may indicate some signal integrity
> issues etc). Currently, on a correctable AER, we do log them, but
> having them in sysfs would allow userspace tools to possibly
> (periodically) poll them and raise an appropriate warning in case of
> too many errors. I know that for my purposes, getting some idea of PCI
> link quality or a way to quantize it, would help.
> 
> Do you think such counters make sense or would be helpful generically?
> Also, please let me know if something like this already exists?

This question came from FB folks last year. They were told to use the 
perf events for counting.

I don't honestly have a strong opinion.

> 
> Thanks,
> 
> Rajat
