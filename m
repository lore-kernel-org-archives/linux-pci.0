Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org> <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org> <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
 <20161019224405.GA14915@localhost> <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Oct 2016 23:08:08 +0200
Message-ID: <CAJZ5v0gZmNxOF5hf8oYF_UYUNHrYkFy=Y7SWGCZ+VRKGNeJmcA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
	Ondrej Zary <linux@rainbow-software.org>, Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>, Jon Masters <jcm@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	wim@djo.tudelft.nl,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 10:01 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 10/19/2016 3:44 PM, Bjorn Helgaas wrote:

[cut]

> If we want to move the ISA pieces out of this file, that can be done too.
> We can also add support for PNPACPI. I'm not a very big fan of scratch
> everything and start from beginning approach. This refactoring effort already
> failed 3 times. I'd like to close the issue and move on.

Understood, but we have broken this for too many times already.

Either we have a minimum fix that is known working or we are going back.

Thanks,
Rafael
