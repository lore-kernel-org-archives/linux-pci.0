Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752490AbeDSSID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 14:08:03 -0400
Date: Thu, 19 Apr 2018 12:08:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: Support to workaround bus level HW issues
Message-ID: <20180419120803.3d5791b4@w520.home>
In-Reply-To: <b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com>
References: <b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 19 Apr 2018 13:36:00 -0400
James Puthukattukaran <james.puthukattukaran@oracle.com> wrote:

> There are bugs in certain PCIe switches that cause access violations
>  when an endpoint device is hotplugged. In particular, there's an issue
> with
> certain IDT switches that trigger a ACS violation when bringing up a newly
> plugged PCIe endpoint device. This is a major issue for platforms
> designed to
> issue a fatal reset in the case of this event.
> 
> The first patch provides a framework for intercepting and working around
> issues with parent devices to the endpoint being brought up.
> 
> The second patch provides the actual patch for the IDT switch issue using
> that framework. The ACS feature is disabled in the IDT switch prior to
> endpoint
> device detection and then re-enabled subsequent to that.

I'm happy with the logic of the patch, but:

 - Patches are lined wrapped
 - There are white space issues (space indenting and extra returns)
 - 'return(foo(bar));' has too many parens, using 'return foo(bar);'
 - Comment style, see Documentation/process/coding-style.rst for
   preferred multi-line inline comment style.  (I see mixed comment
   style in quirks.c, but probe.c is pretty consistent)
 - Please don't fixup style issues in patch 1/2 in patch 2/2

scripts/checkpatch.pl can find some of these for you.  Thanks,

Alex
