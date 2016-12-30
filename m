Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 15:44:44 +0100
Message-ID: <2639450.Y5na7q8Pa0@aspire.rjw.lan>
In-Reply-To: <707035209.554.1483106393928.JavaMail.zimbra@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <1129781083.551.1483105037253.JavaMail.zimbra@quantumtechnology.info> <707035209.554.1483106393928.JavaMail.zimbra@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 30, 2016 02:59:53 PM Kilian Singer wrote:
> The proposed patch alone did not change the issue.

I guess you mean https://patchwork.kernel.org/patch/9491693/ which probably
means that the runtime PM of the PCIe ports is enabled by user space anyway.

Thanks,
Rafael
