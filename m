Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Tomasz Nowicki <tn@semihalf.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
Cc: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        Wangyijing <wangyijing@huawei.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
Date: Fri, 20 May 2016 00:41:28 -0400
MIME-Version: 1.0
In-Reply-To: <57331290.7070104@semihalf.com>
Content-Type: text/plain; charset=gbk
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz, all,

On 05/11/2016 07:08 AM, Tomasz Nowicki wrote:

> On 11.05.2016 12:41, Gabriele Paoloni wrote:

>>> v6 -> v7
>>> - drop quirks handling
>>
>> Maybe I missed something in the v6 discussion thread; when was it
>> decided to drop quirk handling?
> 
> I had such requests in previous series.

A quick note on quirk handling. This, I believe, applies post-merge of
the base infrastructure, which I realize will likely not have quirks.

We've some "gen1" ARMv8 server platforms where we end up doing quirks
(for things like forcing 32-bit config space accessors and the like) due
to people repurposing existing embedded PCIe IP blocks or using them for
the first time (especially in servers), and those being involved in the
design not necessarily seeing this problem ahead of time, or not
realizing that it would be an issue for servers. In the early days of
ARM server designs 3-4 years ago, many of us had never really played
with ECAM or realized how modern topologies are built.

Anyway. We missed this one in our SBSA requirements. They say (words to
the effect of) "thou shalt do PCIe the way it is done on servers" but
they aren't prescriptive, and they don't tell people how that actually
is in reality. That is being fixed. A lot of things are happening behind
the scenes - especially with third party IP block providers (all of whom
myself and others are speaking with directly about this) - to ensure
that the next wave of designs won't repeat these mistakes. We don't have
a time machine, but we can contain this from becoming an ongoing mess
for upstream, and we will do so. It won't be a zoo.

Various proposals have arisen for how to handle quirks in the longer
term, including elaborate frameworks and tables to describe them
generically. I would like to caution against such approaches, especially
in the case that they deviate from practice on x86, or prior to being
standardized fully with other Operating System vendors. I don't expect
there to be too many more than the existing initial set of quirks we
have seen posted. A number of "future" server SoCs have already been
fixed prior to silicon, and new design starts are being warned not to
make this a problem for us to have to clean up later.

So, I would like to suggest that the eventual framework mirror the
existing approach on x86 systems (matching DMI, etc.) and not be made
into some kind of generic, utopia. This is a case where we want there to
be pain involved (and upstream patches required) when people screw up,
so that they have a level of pain in response to ever making this
mistake in the future. If we try to create too grand a generic scheme
and make it too easy to handle this kind of situation beyond the small
number of existing offenders, we undermine efforts to force vendors to
ensure that their IP blocks are compliant going forward.

Side note: if you're a third party IP vendor and we didn't already speak
about this one, drop me a line, and let's collaborate also on your test
frameworks to make sure you're covered as well.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
