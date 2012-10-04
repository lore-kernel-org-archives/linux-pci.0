Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACJDEmoeD+XwjGnA2WwkeJ5TrsaXfgw+mZHPDcX0+7QZ9_80SA@mail.gmail.com>
References: <CAE9FiQWgvVqnTTeYFvxf1GxLcEEeRyN-uSKPdg3o69oCpm43sQ@mail.gmail.com>
	<1349305214-3241-1-git-send-email-yinghai@kernel.org>
	<1349305214-3241-2-git-send-email-yinghai@kernel.org>
	<CACJDEmoeD+XwjGnA2WwkeJ5TrsaXfgw+mZHPDcX0+7QZ9_80SA@mail.gmail.com>
Date: Thu, 4 Oct 2012 08:15:44 -0700
Message-ID: <CAE9FiQVFY1M65smht2vkAAR3nvH+SMUe2NteBvUyZzqabARV2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: add drivers_autoprobe in struct acpi_device
From: Yinghai Lu <yinghai@kernel.org>
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 4, 2012 at 6:03 AM, Konrad Rzeszutek Wilk <konrad@kernel.org> wrote:
> On Wed, Oct 3, 2012 at 7:00 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> To use to control the delay attach driver for acpi_device.
>
> <blinks>
> I am not sure what this says. Can you please explain how it controls
> the delaying of
> attaching drivers?
>>
>> Will use bus notifier to toggle this bits when needed.
>
> Will use ..? In a subsequent patch? Which patch? And when is this
> needed? Is there a patch that needs this?

please check patch 0-4 as a whole.

Yinghai
