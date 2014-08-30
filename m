Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46271 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaH3AAt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 20:00:49 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so7442395pab.8
        for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2014 17:00:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAErSpo68rteOFbbX5n6GccPc9kpt-UL9FRS7JbOMAoDLR-7mtA@mail.gmail.com>
References: <CAErSpo68rteOFbbX5n6GccPc9kpt-UL9FRS7JbOMAoDLR-7mtA@mail.gmail.com>
Date: Fri, 29 Aug 2014 17:00:48 -0700
Message-ID: <CAA93t1qcKh3BaCbiHE2+pUYtNizRUXW4D5465tQUTz46dDY0rg@mail.gmail.com>
Subject: Re: pciehp regression (bug #79701)
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I will take a look.

Thanks,

Rajat

On Fri, Aug 29, 2014 at 3:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Rajat,
>
> This bug report: https://bugzilla.kernel.org/show_bug.cgi?id=79701 was
> bisected to 02e93a8a7c1d ("PCI: pciehp: Don't check adapter or latch
> status while disabling").  Can you take a look?
>
> Bjorn
