Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57443 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758032AbcJQIBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 04:01:07 -0400
Date: Mon, 17 Oct 2016 10:01:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: use pci_alloc_irq_vectors issues
Message-ID: <20161017080103.GA8732@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[added linux-ide and linux-pci to the CC list]

Hi Emmanuel,


> The following commit prevents my machine to boot properly:
> 
>     0b9e2988a ahci: use pci_alloc_irq_vectors
> 
> Crappy quality smartphone pic here: http://i.imgur.com/X1QETFi.jpg
> 
> Reverting this commit solves the issue.
> 
> Please let me know should you need any further info.

Can you send me the output ofthe following commands from a working
boot:

cat /proc/interrupts
lspci -vv
dmesg

Thanks a lot for the report
