Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50505 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752037AbbLIAqv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 19:46:51 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI / PM: Fix small typo in documentation
Date: Wed, 09 Dec 2015 02:16:50 +0100
Message-ID: <2034538.amqQujWT52@vostro.rjw.lan>
In-Reply-To: <1449584245-4347-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1449584245-4347-1-git-send-email-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 08, 2015 04:17:25 PM Jarkko Nikula wrote:
> cuased -> caused
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Queued up for 4.5, thanks!

I hope that Bjorn won't mind ...

> ---
>  Documentation/power/pci.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/pci.txt b/Documentation/power/pci.txt
> index b0e911e0e8f5..44558882aa60 100644
> --- a/Documentation/power/pci.txt
> +++ b/Documentation/power/pci.txt
> @@ -999,7 +999,7 @@ from its probe routine to make runtime PM work for the device.
>  
>  It is important to remember that the driver's runtime_suspend() callback
>  may be executed right after the usage counter has been decremented, because
> -user space may already have cuased the pm_runtime_allow() helper function
> +user space may already have caused the pm_runtime_allow() helper function
>  unblocking the runtime PM of the device to run via sysfs, so the driver must
>  be prepared to cope with that.
>  
> 

Thanks,
Rafael

