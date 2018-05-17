Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:41081 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeEQVGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2018 17:06:23 -0400
Received: by mail-ot0-f174.google.com with SMTP id t1-v6so6672009oth.8
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2018 14:06:23 -0700 (PDT)
MIME-Version: 1.0
From: Rajat Jain <rajatja@google.com>
Date: Thu, 17 May 2018 14:05:42 -0700
Message-ID: <CACK8Z6Hjxd+6qRthHEQRuo0_NXX06iDqggrVN83O0QkN=3+9gg@mail.gmail.com>
Subject: RFC: Counters for PCI Express AERs
To: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I have been thinking about adding counters for different kinds of AERs
and expose them via sysfs. IMHO this would help by giving some sense
of "link quality" for PCIe links (a lot of correctable AERs may
indicate system is workable, but may indicate some signal integrity
issues etc). Currently, on a correctable AER, we do log them, but
having them in sysfs would allow userspace tools to possibly
(periodically) poll them and raise an appropriate warning in case of
too many errors. I know that for my purposes, getting some idea of PCI
link quality or a way to quantize it, would help.

Do you think such counters make sense or would be helpful generically?
Also, please let me know if something like this already exists?

Thanks,

Rajat
