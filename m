Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46858 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751411AbbKSVxh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 16:53:37 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 0/2] Minor _OSC error handling improvements
Date: Thu, 19 Nov 2015 23:23:10 +0100
Message-ID: <1822599.FKAxC3Vfcc@vostro.rjw.lan>
In-Reply-To: <cover.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 19, 2015 08:08:18 AM Andy Lutomirski wrote:
> This doesn't fix any bugs, but it makes the debugging output a
> little more useful.
> 
> Andy Lutomirski (2):
>   acpi: Tidy up _OSC error spacing
>   acpi: Show _OSC UUID when _OSC fails
> 
>  drivers/acpi/bus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Can you please CC ACPI-related patches to linux-acpi@vger.kernel.org,
especially when they touch files under drivers/acpi/?

Thanks,
Rafael

