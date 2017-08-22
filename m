Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdHVQX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 12:23:59 -0400
Date: Tue, 22 Aug 2017 11:23:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?iso-8859-1?Q?G=FCrkan?= Myczko <gurkan@phys.ethz.ch>
Cc: linux-pci@vger.kernel.org, mroos@linux.ee
Subject: Re: pci layer problem
Message-ID: <20170822162356.GA6948@bhelgaas-glaptop.roam.corp.google.com>
References: <0c50a5ba7ceadc93555c6c6dedb22829@phys.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <0c50a5ba7ceadc93555c6c6dedb22829@phys.ethz.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 22, 2017 at 04:10:29PM +0200, Gürkan Myczko wrote:
> hello
> 
> i've been told on #debian-sparc to report this (SUN UltraSparc,
> SPARC64, Debian):
> 
> some dmesg output:
> [ 2683.006327] e1000: Intel(R) PRO/1000 Network Driver - version
> 7.3.21-k8-NAPI
> [ 2683.006792] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [ 2683.007379] e1000 0000:02:02.0: can't ioremap BAR 0: [mem size
> 0x00020000]
> [ 2683.007772] e1000: probe of 0000:02:02.0 failed with error -5

Hi Gürkan,

Sorry you tripped over a problem.  Can you please collect the complete
dmesg log?

Bjorn
