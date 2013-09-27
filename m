Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64929 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3I0Spj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 14:45:39 -0400
Received: by mail-ie0-f173.google.com with SMTP id ar20so4824536iec.18
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 11:45:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130925174215.GA26273@google.com>
References: <20130925174215.GA26273@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Sep 2013 12:45:18 -0600
Message-ID: <CAErSpo4dkL9wqjCuoURTca8CgPbLYkTxWEhLt7WeRa14d2_3OA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix whitespace, capitalization, and spelling errors
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 25, 2013 at 11:42 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I'd like to merge the following patch.  It makes no functional changes at
> all; it's only spelling and whitespace fixes, e.g., space-before-tab,
> whitespace-at-end-of-line, etc.
>
> To avoid needless conflicts, I wonder if it's best to ask Linus to pull
> this before v3.12-rc3.  Otherwise, I can feed it through my tree in the
> merge window, or drop parts that are problematic, e.g., acpiphp.

I plan to merge this during the v3.13 merge window, after the main PCI
and ACPI updates have been merged.

Bjorn
