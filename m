Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
Cc: Tomasz Nowicki <tn@semihalf.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "Liviu.Dudau@arm.com"
 <Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com"
 <ddaney@caviumnetworks.com>,
        "jeremy.linton@arm.com"
 <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        Wangyijing
 <wangyijing@huawei.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
Date: Fri, 20 May 2016 04:01:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Ard,

On 05/20/2016 03:37 AM, Ard Biesheuvel wrote:
> On 20 May 2016 at 06:41, Jon Masters <jcm@redhat.com> wrote:
>> Hi Tomasz, all,
>>
>> On 05/11/2016 07:08 AM, Tomasz Nowicki wrote:
>>
>>> On 11.05.2016 12:41, Gabriele Paoloni wrote:
>>
>>>>> v6 -> v7
>>>>> - drop quirks handling
>>>>
>>>> Maybe I missed something in the v6 discussion thread; when was it
>>>> decided to drop quirk handling?
>>>
>>> I had such requests in previous series.
>>
>> A quick note on quirk handling. This, I believe, applies post-merge of
>> the base infrastructure, which I realize will likely not have quirks.
>>
>> We've some "gen1" ARMv8 server platforms where we end up doing quirks
>> (for things like forcing 32-bit config space accessors and the like) due
>> to people repurposing existing embedded PCIe IP blocks or using them for
>> the first time (especially in servers), and those being involved in the
>> design not necessarily seeing this problem ahead of time, or not
>> realizing that it would be an issue for servers. In the early days of
>> ARM server designs 3-4 years ago, many of us had never really played
>> with ECAM or realized how modern topologies are built.
>>
>> Anyway. We missed this one in our SBSA requirements. They say (words to
>> the effect of) "thou shalt do PCIe the way it is done on servers" but
>> they aren't prescriptive, and they don't tell people how that actually
>> is in reality. That is being fixed. A lot of things are happening behind
>> the scenes - especially with third party IP block providers (all of whom
>> myself and others are speaking with directly about this) - to ensure
>> that the next wave of designs won't repeat these mistakes. We don't have
>> a time machine, but we can contain this from becoming an ongoing mess
>> for upstream, and we will do so. It won't be a zoo.
>>
>> Various proposals have arisen for how to handle quirks in the longer
>> term, including elaborate frameworks and tables to describe them
>> generically. I would like to caution against such approaches, especially
>> in the case that they deviate from practice on x86, or prior to being
>> standardized fully with other Operating System vendors. I don't expect
>> there to be too many more than the existing initial set of quirks we
>> have seen posted. A number of "future" server SoCs have already been
>> fixed prior to silicon, and new design starts are being warned not to
>> make this a problem for us to have to clean up later.
>>
>> So, I would like to suggest that the eventual framework mirror the
>> existing approach on x86 systems (matching DMI, etc.) and not be made
>> into some kind of generic, utopia. This is a case where we want there to
>> be pain involved (and upstream patches required) when people screw up,
>> so that they have a level of pain in response to ever making this
>> mistake in the future. If we try to create too grand a generic scheme
>> and make it too easy to handle this kind of situation beyond the small
>> number of existing offenders, we undermine efforts to force vendors to
>> ensure that their IP blocks are compliant going forward.

> I understand that there is a desire from the RedHat side to mimic x86
> as closely as possible, but I never saw any technical justification
> for that.

Understood. My own motivation is always to make the experience as
familiar as possible, both for end users, as well as for ODMs and the
entire ecosystem. There are very many ODMs currently working on v8
server designs and they're already expecting this to be "just like x88".
Intentionally. But as to the specifics of using DMI...

> DMI contains strings that are visible to userland, and you
> effectively lock those down to certain values just so that the kernel
> can distinguish a broken PCIe root complex from a working one. Linux
> on x86 had no choice, since the overwhelming majority of existing
> hardware misrepresented itself as generic, and DMI was the only thing
> available to actually distinguish these broken implementations from
> one another. This does not mean we should allow and/or encourage this
> first gen hardware to misrepresent non-compliant hardware as compliant
> as well.

That's a very reasonable argument. I don't disagree that it would be
nice to have nicer ways to distinguish the non-compliant IP than
treating the whole platform with an ASCII matching sledgehammer.

> Since you are talking to all the people involved, how about you
> convince them to put something in the ACPI tables that allows the
> kernel to distinguish those non-standard PCIe implementations from
> hardware that is really generic?

I'm open to this *BUT* it has to be something that will be adopted
beyond Linux. I have reached out to some non-Linux folks about this. If
there's buy-in, and if there's agreement to go standardize it through
the ASWG, then we should do so. What we should not do is treat ARM as
special in a way that the others aren't involved with. I'll admit DMI
ended up part of the SBBR in part because I wrote that piece in with the
assumption that exactly the same matches as on x86 would happen.

> This way, we can sidestep the quirks
> debate entirely, since it will simply be a different device as far as
> the kernel is concerned. This is no worse than a quirk from a
> practical point of view, since an older OS will be equally unable to
> run on newer hardware, but it is arguably more true to the standards
> compliance you tend to preach about, especially since this small pool
> of third party IP could potentially be identified directly rather than
> based on some divination of the SoC we may or may not be running on. I
> am also convinced that adding support for an additional HID() to the
> ACPI ECAM driver with some special config space handling wired in is
> an easier sell upstream than making the same ugly mess x86 has had to
> make because they did not have any choice to begin with.

Again, open to it. I just don't want to do something that's Linux
specific. So it'll take time. It would be awesome if an interim quirk
solution existed that got platforms that are shipping in production
(e.g. HP Moonshot) actually booting upstream kernels this year. We
/really/ want F25 to be able to run on these without needing to carry an
out-of-tree quirk patch or just not support them. That's much worse.

> If we do need a quirks handling mechanism, I still don't see how the
> x86 situation extrapolates to ARM. ACPI offers plenty of ways for a
> SoC vendor to identify the make and particular revision, and quirks
> could be keyed off of that.

Fair enough. Is there any traction for an interim solution for these
initial platforms do you think? If we wait to add a new table it's
probably going to be the end of the year before we get this done.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
