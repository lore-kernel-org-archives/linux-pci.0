Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932875AbeEIMiR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 May 2018 08:38:17 -0400
Date: Wed, 9 May 2018 08:38:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mr.nuke.me@gmail.com
Subject: Re: [PATCH V3 1/1] PCI/AER: add pcie TLP header information in the
 tracepoint
Message-ID: <20180509083814.149e8d8f@gandalf.local.home>
In-Reply-To: <1525820696-31967-2-git-send-email-thomas.tai@oracle.com>
References: <1525820696-31967-1-git-send-email-thomas.tai@oracle.com>
        <1525820696-31967-2-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue,  8 May 2018 19:04:56 -0400
Thomas Tai <thomas.tai@oracle.com> wrote:

> When a PCIe AER occurs, the TLP header information is
> printed in the kernel message but it is missing from
> the tracepoint. A userspace program can use this information
> in the tracepoint to better analyze problems.
> 
> To enable the tracepoint:
> echo 1 > /sys/kernel/debug/tracing/events/ras/aer_event/enable
> 
> Example tracepoint output:
> cat /sys/kernel/debug/tracing/trace
> aer_event: 0000:01:00.0
> PCIe Bus Error: severity=Uncorrected, non-fatal, Completer Abort
> TLP Header={0x0,0x1,0x2,0x3}
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
