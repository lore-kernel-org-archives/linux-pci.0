Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta4.ai270.net ([94.126.40.171]:46310 "EHLO
	out-mta1.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752808AbcAQWTE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jan 2016 17:19:04 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <569C01EC.2040906@keynet-technology.com>
Date: Sun, 17 Jan 2016 21:04:44 +0000
MIME-Version: 1.0
In-Reply-To: <20160115172640.GC28453@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

I have added the DMESG and lspci logs for different kernels and
motherbaords on that Bugzilla for you.

Not yet been able to build a 4.4 kernel yet - will try shortly.
Appreciate any pointers for further debug.

thanks
Richard

On 15/01/2016 17:26, Bjorn Helgaas wrote:
> Hi Richard,
> 
> 
> Thanks for your report.  I opened this bug report:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=110851
> 
> Can you please attach the complete dmesg logs from the old machine
> running 3.0.76 and the new machine running 3.0.76 to that bugzilla?
> Also please attach the complete "lspci -vvv" output for all the
> devices in the new machine.
> 
> Is there any chance you can try a current kernel, e.g., v4.4, on the
> new machine?  Even if you can't install a new kernel permanently, the
> dmesg log of PCI enumeration is enough to show whether we detect the
> Kodicom devices or not.
> 
> Bjorn

