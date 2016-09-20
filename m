Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbcITTlJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Sep 2016 15:41:09 -0400
Date: Tue, 20 Sep 2016 14:41:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        paul.gortmaker@windriver.com, sudipm.mukherjee@gmail.com,
        axboe@fb.com, izumi.taku@jp.fujitsu.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bp@suse.de
Subject: Re: [PATCH V2 0/2] Correct AER severity for printing AER information
Message-ID: <20160920194103.GD4941@localhost>
References: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 03:14:44PM -0600, Tyler Baicar wrote:
> AER severity handling has two issues that cause the AER information to
> be printed incorrectly. The first issue is that the function to calculate
> the AER severity is called twice in the code path to print the AER
> information. The second issue is that the original call to calculate the
> AER severity expects the CPER severity but is recieving the GHES
> severity.
> 
> V2: Fix minor typo in commit text.
> 
> V1: https://lkml.org/lkml/2016/9/12/1075
> 
> Tyler Baicar (2):
>   PCI/AER: Remove duplicate AER severity translation
>   acpi: apei: send correct severity to calculate AER severity
> 
>  drivers/acpi/apei/ghes.c               | 2 +-
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 6 ++----
>  include/linux/aer.h                    | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)

I applied both to pci/aer for v4.9, thanks!

Rafael, the second one is strictly ACPI, and I'd be happy to let you
deal with it if you prefer.

Bjorn
