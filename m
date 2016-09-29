Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Sep 2016 16:18:19 +0200
From: Wim Osterholt <wim@djo.tudelft.nl>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
Message-ID: <20160929141818.GA32236@djo.tudelft.nl>
Reply-To: wim@djo.tudelft.nl
References: <201609251512.05657.linux@rainbow-software.org>
 <201609281902.31500.linux@rainbow-software.org>
 <76303bb8-7ae2-9a6b-8e5d-a144ae7c6009@codeaurora.org>
 <201609282123.48506.linux@rainbow-software.org>
 <946fcb62-272b-61b3-9afa-7c27a1ce7419@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <946fcb62-272b-61b3-9afa-7c27a1ce7419@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 28, 2016 at 07:38:41PM -0400, Sinan Kaya wrote:
> 
> Can you try these patches on your machines please?

I applied the included patches on vanilla 4.8-rc8 and my machine booted
fine. (I saw a remark about SCSI interrupts, but I have no SCSI.)

Regards, Wim.
