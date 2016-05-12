Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAKc_7PW8BqQSTn01zDVsec4KXunQUKfcEft8=MH-E0xsmheo3w@mail.gmail.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
	<1462893601-8937-8-git-send-email-tn@semihalf.com>
	<CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
	<20160511101101.GA16101@red-moon>
	<CAJZ5v0hgw929W5PjF0PqT+ssiOHd8TeJoSQcz4NUiAovZY2pfQ@mail.gmail.com>
	<20160511224314.GD28812@localhost>
	<CAKc_7PW8BqQSTn01zDVsec4KXunQUKfcEft8=MH-E0xsmheo3w@mail.gmail.com>
Date: Thu, 12 May 2016 13:27:23 +0200
Message-ID: <CAJZ5v0jOAOWLNab0vMOVyciwOhtkuPdqZt3wkFbprq+PkEQNVg@mail.gmail.com>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, robert.richter@caviumnetworks.com,
	Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>, Duc Dang <dhdang@apm.com>, jeremy.linton@arm.com,
	liudongdong3@huawei.com, Christopher Covington <cov@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 12:43 PM, Jayachandran C <jchandra@broadcom.com> wrote:
> On Thu, May 12, 2016 at 4:13 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Wed, May 11, 2016 at 10:30:51PM +0200, Rafael J. Wysocki wrote:
>>> On Wed, May 11, 2016 at 12:11 PM, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>> > On Tue, May 10, 2016 at 08:37:00PM +0200, Rafael J. Wysocki wrote:
>>> >> On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:

[cut]

>
> If we are moving the ACPI/PCI code from drivers/acpi to
> arch/arm64/ , there is an issue in having the header file
> ecam.h in drivers/pci
>
> The current include of "../pci/ecam.h" is slightly ugly (Arnd
> and David had already noted this), but including the driver
> header from arch code would be even worse.
>
> I can either merge ecam.h into include/linux/pci.h
> or move it to a new file include/linux/pci-ecam.h, any
> suggestion on which is preferable?

My preference would be pci-ecam.h as we did a similar thing for
pci-dma.h, for example, but basically this is up to Bjorn.
