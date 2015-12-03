Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41414 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbLCR3E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 12:29:04 -0500
Date: Thu, 3 Dec 2015 11:29:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 0/2] Minor _OSC error handling improvements
Message-ID: <20151203172900.GB17565@localhost>
References: <cover.1447949171.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1447949171.git.luto@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 19, 2015 at 08:08:18AM -0800, Andy Lutomirski wrote:
> This doesn't fix any bugs, but it makes the debugging output a
> little more useful.
> 
> Andy Lutomirski (2):
>   acpi: Tidy up _OSC error spacing
>   acpi: Show _OSC UUID when _OSC fails
> 
>  drivers/acpi/bus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

These both look fine to me.  If you want it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
