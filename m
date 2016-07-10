Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [GIT PULL] ACPI fixes for v4.7-rc7
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <CAJZ5v0hDSZGX90hxkACwC0DktD-_Baq=+DDkR7_zv8464iHG-Q@mail.gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <d3bc7758-2f97-474e-bd48-19457bda8b1d@leemhuis.info>
Date: Sun, 10 Jul 2016 13:00:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hDSZGX90hxkACwC0DktD-_Baq=+DDkR7_zv8464iHG-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael!

On 08.07.2016 01:43, Rafael J. Wysocki wrote:
>
> Please pull from
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-4.7-rc7
> 
> to receive ACPI fixes for v4.7-rc7 with top-most commit
> […]
> All of these fix recent regressions in ACPICA, in the ACPI PCI IRQ
> management code and in the ACPI AML debugger.

FYI, it seems these changes lead to a new regression. Quoting
https://bugzilla.kernel.org/show_bug.cgi?id=121701

"""
> Kernel fails to boot with this commit. With the commit reverted,
> everything is fine. I cannot bisect any further - git is failing with
> "you are trying to use to much memory"(?!)
> 
> This is a Dell Precision 5510 with the latest (1.2.10) BIOS applied.
> 
> Let me know what additional information I can provide."""
"""

Cheers, Thorsten
