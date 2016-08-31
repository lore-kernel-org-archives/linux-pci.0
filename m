Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 0/5] ECAM quirks handling for ARM64 platforms
To: Duc Dang <dhdang@apm.com>
References: <1470661002-26213-1-git-send-email-tn@semihalf.com>
 <CADaLND=pbbtVZt6bg6Lg-21v3_SU+qDJGGDH0Qf+9maf8oTA5w@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
 Jayachandran C <jchandra@broadcom.com>,
 Christopher Covington <cov@codeaurora.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robert Richter <robert.richter@caviumnetworks.com>,
 Marcin Wojtas <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
 David Daney <ddaney@caviumnetworks.com>, Yijing Wang
 <wangyijing@huawei.com>, Mark Salter <msalter@redhat.com>,
 linux-pci@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>,
 linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>,
 Andrea Gallo <andrea.gallo@linaro.org>, jeremy.linton@arm.com,
 Dongdong Liu <liudongdong3@huawei.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jeffrey Hugo <jhugo@codeaurora.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <0fda1583-f95f-5fe0-b8b7-ae1e2c49db6b@semihalf.com>
Date: Wed, 31 Aug 2016 14:10:57 +0200
MIME-Version: 1.0
In-Reply-To: <CADaLND=pbbtVZt6bg6Lg-21v3_SU+qDJGGDH0Qf+9maf8oTA5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 30.08.2016 23:20, Duc Dang wrote:
> On Mon, Aug 8, 2016 at 5:56 AM, Tomasz Nowicki <tn@semihalf.com> wrote:
>>
>> Quirk handling relies on an idea of matching MCFG OEM ID, TABLE ID and
>> revision (the ones from standard header of MCFG table).
>>
>> Static array is used to keep quirk entries. Each entry consists of
>> mentioned MCFG IDs along with custom pci_ops structure and initialization call.
>>
>> As an example, the last patch presents quirk handling mechanism usage for
>> ThunderX PEM driver.
>
> Hi Tomasz,
>
> Are you planning to change this series into a real one (not RFC) any time soon?

Yes, but first I would like to collect more feedback.

BTW please respond to https://lkml.org/lkml/2016/8/8/273
This series misses ACPI mailing list so I decided to resend it.

Tomasz
