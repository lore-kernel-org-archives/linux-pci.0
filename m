Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:41458 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbdCNRfD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 13:35:03 -0400
Subject: Re: [PATCH 2/4] pci: Add generic pci_bus_force_mmconfig interface
To: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com
References: <20170302232104.10136-1-andi@firstfloor.org>
 <20170302232104.10136-2-andi@firstfloor.org>
Cc: x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <66023d09-aadb-981e-286b-e2c8316897ce@zytor.com>
Date: Tue, 14 Mar 2017 10:34:14 -0700
MIME-Version: 1.0
In-Reply-To: <20170302232104.10136-2-andi@firstfloor.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/02/17 15:21, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> x86 traditionally used mmconfig only for extended config space accesses
> with offsets larger than 256. For lower offsets it uses the classic
> Type 1 IO port access. This is quite slow and also requires taking
> a global spin lock to protect the Type 1 IO port mailbox.
> 
> IIRC (I added it originally) it was merely to be conservative;
> I don't remember any actual cases where mmconfig did not work
> after passing the other sanity checks. But most devices
> don't use extended config space, so most devices were never
> tested with MMCONFIG. Starting to use MMCONFIG everywhere
> unconditionally seems somewhat risky as we never tested this
> 

I would rather enable it by default, but having a command-line switch to
disable it.  This seems a helluva lot saner than mucking with the entire
PCI bus from an individual device driver.

Also, it seems crazy to say we will take this penalty forever.  My
opinion is we should enable it in the absence of evidence of
malfunctions, but if we end up having problems we could put an ACPI date
cutoff quirk in.

	-hpa
