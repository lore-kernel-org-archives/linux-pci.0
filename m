Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 17 Sep 2018 09:12:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Anemone <peter.anemone@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Boot stall related to
 drivers/pci/hotplug/acpiphp_glue.c
Message-ID: <20180917061217.GI14465@lahna.fi.intel.com>
References: <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2018 at 08:58:50AM +0300, Peter Anemone wrote:
> Dear kernel developers
> I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
> mailing lists. Here's my bug report:
> 
> Linux has been unbootable for me from 4.18 upwards. Even the fallback
> image does not boot. This has not been fixed yet in 4.19-rc3. acpi=off
> kernel parameter lets me boot 4.18.6 and 4.19-rc3.
> 
> I used git bisect to track down the first bad commit:
> 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
> 
> The commit is about:
> "ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
> 
> Linux 4.17 booted fine. Reverting commit
> 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef makes 4.18 and 4.19-rc3
> bootable again (without the acpi=off parameter).
> 
> Information about my system:
> Model: HP 6730b laptop
> CPU: Intel Core 2 Duo P8600
> Boot manager: systemd-boot (UEFI)
> More information of my system as attachments on the bug report at Bugzilla.
> 
> Link to the bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=201127

Thanks for the report. Since there is bugzilla about the issue already,
let's continue investigation there.

Can you also attach full dmesg of the failure (if possible) to the bug?
