Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo5NOqnqWxCBV+NecA34z0YJHP7FCy6mNd5GUJ8q__CZHw@mail.gmail.com>
References: <1330466863-28469-1-git-send-email-yinghai@kernel.org>
	<1330466863-28469-13-git-send-email-yinghai@kernel.org>
	<CAErSpo66PD3+E3ZFqp73XHabL+8GavpX97pUkd28T6KWTBH-aA@mail.gmail.com>
	<CAE9FiQWBvYZO-D+Z2zwdd0a-bkatF-0YPtmxKP4Se75vccgPrA@mail.gmail.com>
	<CAErSpo5NOqnqWxCBV+NecA34z0YJHP7FCy6mNd5GUJ8q__CZHw@mail.gmail.com>
Date: Tue, 28 Feb 2012 20:26:48 -0800
Message-ID: <CAE9FiQXiCAxtNCafBtvx2Wj6=te5ciLjbC9icaPn788xQD06kQ@mail.gmail.com>
Subject: Re: [PATCH 12/24] PCI, ia64: Register busn_res for root buses
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	linux-ia64@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 28, 2012 at 4:22 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Feb 28, 2012 at 5:12 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>
>>> Why do you add a new struct resource here?  Can't you just use the one
>>> passed in from acpi_pci_root_add()?
>>
>> not quite sure about the life cycle for that object.
>
> The struct acpi_pci_root is allocated in acpi_pci_root_add() and freed
> in acpi_pci_root_remove(), so it should be safe for PCI to use.

ok will change that for ia64.

>
> Same thing applies for x86, of course.

for x86, will have separate addon patch.

Thanks

      Yinghai
