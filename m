Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 23:04:13 +0000
From: Keith Busch <keith.busch@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	x86@kernel.org, Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: [Bugfix] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Message-ID: <20151124230413.GA11608@localhost.localdomain>
References: <1447648057-13644-1-git-send-email-jiang.liu@linux.intel.com>
 <20151124164907.GA24819@localhost>
 <CAJZ5v0irOUq6C9eSfCfmzyOiY1n1rUSxyUeUbvS9Nj0jNT2JrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0irOUq6C9eSfCfmzyOiY1n1rUSxyUeUbvS9Nj0jNT2JrQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 24, 2015 at 11:19:34PM +0100, Rafael J. Wysocki wrote:
> Quite frankly, I'm more likely to revert the offending commit at this
> point as that's not the only regression reported against it and the
> fix only helps in one case (out of three known to me).

Using 4.4-rc1 and can confirm the patch fixes my regression report. The
revert also fixes it, so either way is good for me!
