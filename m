Return-Path: <ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5773CE49.1050802@codeaurora.org>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
 <1467100442-28078-4-git-send-email-tn@semihalf.com> <577275EA.7010002@codeaurora.org>
 <CADaLNDkhPZuG7UJ4SK_j5v_nXbd782Q17LAcXduG0uEObaFF=g@mail.gmail.com>
 <5773A773.8040700@semihalf.com> <5773CE49.1050802@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 29 Jun 2016 15:56:50 +0200
Message-ID: <CAKv+Gu9=0=qw70o1aYNg=tDyv4TguiG2WwXNK8RbWM1-ZcabUg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
To: Christopher Covington <cov@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, Jayachandran C <jchandra@broadcom.com>,
	Robert Richter <robert.richter@caviumnetworks.com>, Marcin Wojtas <mw@semihalf.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, David Daney <ddaney@caviumnetworks.com>,
	Yijing Wang <wangyijing@huawei.com>, Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Dongdong Liu <liudongdong3@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jeffrey Hugo <jhugo@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 29 June 2016 at 15:34, Christopher Covington <cov@codeaurora.org> wrote:
> Hi Tomasz,
>
> On 06/29/2016 06:48 AM, Tomasz Nowicki wrote:
>> On 28.06.2016 18:12, Duc Dang wrote:
>>> On Tue, Jun 28, 2016 at 6:04 AM, Christopher Covington
>>> <cov@codeaurora.org> wrote:
>>>> Hi Tomasz,
>
>>>> Ard's comments on v3 included:
>>>>
>>>> "... exact OEM table/rev id matches ..."
>>>> "... substring match ... out of the question ..."
>
> Digging through the archives I see Jon Master commented earlier to "be
> careful with substring match".
>
>>> I think having OEM Table ID as "PLAT " and then "PLAT2 " (the the
>>> next version of the SoC) is common. So yes, matching full string is
>>> better as we can use "PLAT2 " in MCFG table and not worry about the
>>> "PLAT" sub-string match causes the quirk to be applied
>>> unintentionally.
>
>> Note that platforms already shipped where OEM string has no padding will
>
> I'm confused by this statement. OEMID is defined as 6 bytes long and OEM
> Table ID as 8 bytes long in the ACPI specification. As far as I can
> tell, if your string isn't exactly that long, padding up to that length
> is required.
>
>> have change the firmware or add 0 padding to our quirk array IDs.
>
> The fixed 6 or 8 character string compare, as used v2 of this patchset,
> will be compatible with existing firmware as best I can tell. Adding
> padding to the quirk array IDs is exactly what I'm suggesting, although
> all the strings I've seen are space padded rather than null padded.
>

I don't think any interpretation of the 6 or 8 byte wide OEM fields is
necessary to be able to match it against a list of known values as
used by the quirky platforms. We need an exact match against whatever
we know is in the table of an affected system, and whether a space
qualifies as padding or as a character is irrelevant.

> Matches:
> {"APM   ", "XGENE   ", 1}
> {"CAVIUM", "THUNDERX", 1}
> {"HISI  ", "HISI-D02", 1}
> {"HISI  ", "HISI-D03", 1}
> {"QCOM  ", "QDF2432 ", 1}
>

I would not mind listing these as

{ { 'A','P','M',' ',' ',' ',' '}, {'X','G','E','N','E',' ',' ',' '}, 1}
...

just to stress that we are not dealing with C strings (and to avoid
having to deal with the implicit NUL terminator).
That also means memcmp() with a fixed length is the most appropriate
to perform the comparison

> Given the above tuples, won't accidentally match:
> (guessing at possible future ids)
> {"APM   ", "XGENEi  ", 1}
> {"CAVIUM", "THUNDERX", i} i != 1
> {"CAVIUM", "THUNDERi", 1}
> {"CAVIUM", "THUNDRXi", 1}
> {"HISI  ", "HISI-D0i", 1} i != 2 && i != 3
> {"QCOM  ", "QDF24ij ", 1} i != 3 && j != 2
>
> References for APM, HiSilicon IDs:
> https://lists.linaro.org/pipermail/linaro-acpi/2016-June/007108.html
> https://lists.linaro.org/pipermail/linaro-acpi/2016-June/007043.html
>
> Thanks,
> Cov
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
