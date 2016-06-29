Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32852 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbcF2NNL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2016 09:13:11 -0400
MIME-Version: 1.0
In-Reply-To: <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org> <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jun 2016 15:13:08 +0200
Message-ID: <CAJZ5v0j1m4oGJfdOC8uerKc-3ksq6k2e9RdjEnk0sWmsq4RHRQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] ACPI,PCI,IRQ: factor in PCI possible
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Jon Masters <jcm@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl,
	perex@perex.cz, tiwai@suse.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
> resource requirements") omitted the initially assigned POSSIBLE penalty
> when the IRQ is active.

It would be good to say what can go wrong with that here.

> The original code would assign the POSSIBLE value divided by the number
> of possible IRQs during initialization.
>
> Later, if the IRQ is chosen as the active IRQ or if the IRQ is in use
> by ISA; additional penalties get added.

Thanks,
Rafael
