Return-Path: <SRS0=Zkf0=GW=fireburn.co.uk=mike@kernel.org>
Return-Path: <SRS0=Zkf0=GW=fireburn.co.uk=mike@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180323211819.GB210003@bhelgaas-glaptop.roam.corp.google.com>
References: <20180212105523.15984-1-mika.westerberg@linux.intel.com> <20180323211819.GB210003@bhelgaas-glaptop.roam.corp.google.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sun, 1 Apr 2018 23:36:02 +0100
Message-ID: <CAHbf0-FR4dn8g10T42J8mbEr8XznyuNLem_Rvr6+G4YGLPv8Bg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 23 March 2018 at 21:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> I (finally) applied this to pci/hotplug with Rafael's ack for v4.17,
> thanks!
>

Sorry for sounding like a broken record but this still hasn't landed
in linux-next (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/pci/hotplug/acpiphp_glue.c)

Will it still be eligible for the recently opened merge window?
