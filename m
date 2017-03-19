Return-Path: <SRS0=B7JA=24=gmail.com=arndbergmann@kernel.org>
Return-Path: <SRS0=B7JA=24=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <26e69b06-dde2-2ed5-0288-ee5d58676d7e@gmail.com>
References: <26e69b06-dde2-2ed5-0288-ee5d58676d7e@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 19 Mar 2017 22:45:32 +0100
Message-ID: <CAK8P3a1gAFFjmxY70-YaX+woSJLPUN7Ss-gatgVKgG1uNxWc9A@mail.gmail.com>
Subject: Re: Purpose of PCI address in ranges property
To: valmiki <valmikibow@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 19, 2017 at 3:14 PM, valmiki <valmikibow@gmail.com> wrote:
> Hi,
>
> When ranges property is being parsed using of_pci_get_host_bridge_resources,
> the pci address is being used for
> calculating the offset for pci_add_resource_offset.
>
> What is this offset for ?
>
> So the cpu address is being used for programming memory base and limit
> registers ?

Linux IORESOURCE_MEM resources are defined in terms of CPU addresses,
while PCI config space BAR registers are programmed with bus addresses.
These are often the same, but on some machines they are not, which results
in an offset that has to be used when accessing the BARs.

      Arnd
