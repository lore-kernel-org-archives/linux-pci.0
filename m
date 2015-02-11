Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [GIT PULL] ACPI and power management updates for 3.20-rc1
Date: Wed, 11 Feb 2015 02:51:38 +0100
Message-ID: <2941430.C5WGLLJjlq@vostro.rjw.lan>
In-Reply-To: <CAJZ5v0iyosRQ2g48TxJ39jLuOTUrER2=7j2F9Pg80rrkFAo1Kw@mail.gmail.com>
References: <CAJZ5v0iyosRQ2g48TxJ39jLuOTUrER2=7j2F9Pg80rrkFAo1Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, February 10, 2015 10:19:34 PM Rafael J. Wysocki wrote:
> Hi Linus,
> 
> Please pull from
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm+acpi-3.20-rc1
> 
> to receive ACPI and power management material for v3.20-rc1 with
> top-most commit b5e82233cab43c25fc0a1c28d9136a086db4aa52
> 
>  Merge branch 'pm-tools'
> 
> on top of commit bfa76d49576599a4b9f9b7a71f23d73d6dcff735
> 
>  Linux 3.19

I messed up one thing here, sorry about that.

Commit 5c493df25a0d ("Merge branch 'pci/host-generic' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci into
acpi-resources") was supposed to be a merge, but I did something
wrong (I know what even) and it ended up as a non-merge one.
And then I didn't notice that it went wrong which was another
failure.

So this commit will conflict with d2be00c0fb5a ("of/pci: Free resources on
failure in of_pci_get_host_bridge_resources()") from the PCI tree, but
5c493df25a0d is how the final code should look like (the kfree(bus_range);
line needs to go away in particular).

Please let me know if you want me to fix this up (although that would involve
rebasing).

Rafael

