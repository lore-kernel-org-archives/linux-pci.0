Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <e3174a09-e6f8-126d-d3c5-648d1cfd2b74@redhat.com>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx> <e3174a09-e6f8-126d-d3c5-648d1cfd2b74@redhat.com>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 16 Jun 2016 00:45:21 -0700
Message-ID: <CADaLNDnjEuGvWxCMPb=9fiCeVMgF0RRzT2n1SjNw3o57gRUhcg@mail.gmail.com>
Subject: Re: [Linaro-acpi] [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space
 accessors against platfrom specific ECAM quirks
To: Jon Masters <jcm@redhat.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>, "tn@semihalf.com" <tn@semihalf.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
	"Chenxin (Charles)" <charles.chenxin@huawei.com>, "cov@codeaurora.org" <cov@codeaurora.org>,
	Wangyijing <wangyijing@huawei.com>, "mw@semihalf.com" <mw@semihalf.com>,
	"andrea.gallo@linaro.org" <andrea.gallo@linaro.org>, Linuxarm <linuxarm@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 15, 2016 at 11:31 PM, Jon Masters <jcm@redhat.com> wrote:
> On 06/13/2016 09:54 AM, Gabriele Paoloni wrote:
>> Hi Tomasz, Jon
>
> Hi Gab,
>
> Sorry for the lag in following up.
>
> <snip>
>
>> As you can see here Liudongdong has replaced oem_revision with
>> oem_table_id.
>>
>> Now it seems that there are some platforms that have already shipped
>> using a matching based on the oem_revision (right Jon?)
>
> Actually, it turns out (Cov is correct) that we can just match on OEM
> Table ID. The revision should not generally be needed and the vendors
> will just need to make sure that they change OEM Table ID in future
> silicon. An example from two shipping platforms:
>
> 1). AppliedMicro Mustang:
>
> [000h 0000   4]                    Signature : "MCFG"    [Memory Mapped
> Configuration table]
> [004h 0004   4]                 Table Length : 0000003C
> [008h 0008   1]                     Revision : 01
> [009h 0009   1]                     Checksum : 4A
> [00Ah 0010   6]                       Oem ID : "APM   "
> [010h 0016   8]                 Oem Table ID : "XGENE   "
> [018h 0024   4]                 Oem Revision : 00000002
> [01Ch 0028   4]              Asl Compiler ID : "INTL"
> [020h 0032   4]        Asl Compiler Revision : 20140724
>
> 2). HP(E[0]) Moonshot:
>
> [000h 0000   4]                    Signature : "MCFG"    [Memory Mapped
> Configuration table]
> [004h 0004   4]                 Table Length : 0000003C
> [008h 0008   1]                     Revision : 01
> [009h 0009   1]                     Checksum : 48
> [00Ah 0010   6]                       Oem ID : "APM   "
> [010h 0016   8]                 Oem Table ID : "XGENE   "
> [018h 0024   4]                 Oem Revision : 00000001
> [01Ch 0028   4]              Asl Compiler ID : "HP  "
> [020h 0032   4]        Asl Compiler Revision : 00000001
>
> I have pinged the semiconductor (Applied) and insisted upon a written
> plan (which I have now) for handling the first affect generation(s) and
> future chip roadmap stuff, along with how they plan to upstream this
> immediately as part of this thread. I have also done similar with each
> of the other vendors (this is something ARM or Linaro should be doing).
> But I particularly care about X-Gene because I want it to be loved as
> shipping silicon in production systems (Moonshot) that are sitting and
> waiting in the Fedora Phoenix datacenter in large quantity to come
> online if only an upstream kernel would actually boot on them :)

Thanks for the MCFG information on Moonshot system, Jon.

I will make sure the posted quirk for X-Gene takes care for HPE
Moonshot system as well.

Regards,
Duc Dang.

>
>> However I guess that if in FW they have defined oem_table_id properly
>> they should be able to use this mechanism without needing to a FW update.
>
> Correct.
>
>> Can these vendors confirm this?
>
> I've checked all current shipping silicon and prototypes.
>
>> Tomasz do you think this can work for Cavium Thunder?
>
> Will let the vendors followup directly as well.
>
> Jon.
>
> [0] Fortunately that name change doesn't factor when using semiconductor
> matching...hopefully none of the non-complaint IP companies in gen1
> stuff get bought and change their table names. In the unlikely event
> that that does happen, I will preemptively beat them up and ensure that
> something crazy doesn't happen with table contents.
>
> --
> Computer Architect | Sent from my Fedora powered laptop
