Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37199 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbcAIPf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jan 2016 10:35:59 -0500
MIME-Version: 1.0
In-Reply-To: <20160109152422.GA30802@localhost>
References: <1450780730-13667-1-git-send-email-gkulkarni@caviumnetworks.com>
	<20160108180131.GB5354@localhost>
	<20160108180638.GF11228@arm.com>
	<CAFpQJXUaVS7tBqjQ4Dh201yrOWFxa3Bk2q-ZCFtK4mk-te=Q7w@mail.gmail.com>
	<20160109152422.GA30802@localhost>
Date: Sat, 9 Jan 2016 21:05:57 +0530
Message-ID: <CAFpQJXVBafgq864cNeOhccZAdr89EUfXdEdnW7jh1y66ModKAQ@mail.gmail.com>
Subject: Re: [PATCH] arm64, pci, numa: Adding helper functions as required by pci
From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>,
	Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Robert Richter <rrichter@cavium.com>,
	Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Sat, Jan 9, 2016 at 8:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Jan 09, 2016 at 11:35:17AM +0530, Ganapatrao Kulkarni wrote:
>> On Fri, Jan 8, 2016 at 11:36 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Jan 08, 2016 at 12:01:31PM -0600, Bjorn Helgaas wrote:
>> >> On Tue, Dec 22, 2015 at 04:08:50PM +0530, Ganapatrao Kulkarni wrote:
>> >> > Adding helper functions and necessary code to make
>> >> > pci driver(pci-host-generic) numa aware.
>> >> >
>> >> > This patch is on top of arm64-numa v7.
>> >> > http://www.spinics.net/lists/arm-kernel/msg460813.html
>> >> >
>> >> > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> >> > ---
>> >> >  arch/arm64/include/asm/numa.h       | 8 +++++---
>> >> >  arch/arm64/kernel/pci.c             | 8 ++++++++
>> >> >  drivers/pci/host/pci-host-generic.c | 1 +
>> >> >  3 files changed, 14 insertions(+), 3 deletions(-)
>> >> >
>> >> > diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
>> >> > index b8c2a3f..1eca4db 100644
>> >> > --- a/arch/arm64/include/asm/numa.h
>> >> > +++ b/arch/arm64/include/asm/numa.h
>> >> > @@ -15,9 +15,11 @@
>> >> >  extern int __node_distance(int from, int to);
>> >> >  #define node_distance(a, b) __node_distance(a, b)
>> >> >
>> >> > -/* dummy definitions for pci functions */
>> >> > -#define pcibus_to_node(node)       0
>> >> > -#define cpumask_of_pcibus(bus)     0
>> >> > +struct pci_bus;
>> >> > +extern int pcibus_to_node(struct pci_bus *bus);
>> >> > +#define cpumask_of_pcibus(bus)     (pcibus_to_node(bus) == -1 ?            \
>> >> > +                            cpu_all_mask :                         \
>> >> > +                            cpumask_of_node(pcibus_to_node(bus)))
>> >>
>> >> All the arch definitions of cpumask_of_pcibus() are pretty similar;
>> >> could they be made more generic?  At the very least, can you drop the
>> >> definition here and use the one in include/asm-generic/topology.h,
>> >> which is identical to what you're defining here?
>> macro cpumask_of_pcibus is defined under #ifndef CONFIG_NUMA in
>> include/asm-generic/topology.h
>> and this macro is defined again for NUMA in respective arch header files.
>> i think moving this macro from ifndef will allow us to use without redefinition.
>>
>> --- a/include/asm-generic/topology.h
>> +++ b/include/asm-generic/topology.h
>> @@ -54,14 +54,14 @@
>>  #define pcibus_to_node(bus)    ((void)(bus), -1)
>>  #endif
>>
>> +#endif /* CONFIG_NUMA */
>> +
>>  #ifndef cpumask_of_pcibus
>>  #define cpumask_of_pcibus(bus) (pcibus_to_node(bus) == -1 ?            \
>>                                  cpu_all_mask :                         \
>>                                  cpumask_of_node(pcibus_to_node(bus)))
>>  #endif
>>
>> -#endif /* CONFIG_NUMA */
>> -
>>  #if !defined(CONFIG_NUMA) || !defined(CONFIG_HAVE_MEMORYLESS_NODES)
>>
>>  #ifndef set_numa_mem
>>
>> i have got below compilation error withour macro defined in arch code.
>>
>> drivers/pci/pci-sysfs.c: In function ‘cpuaffinity_show’:
>> drivers/pci/pci-sysfs.c:114:15: error: implicit declaration of
>> function ‘cpumask_of_pcibus’ [-Werror=implicit-function-declaration]
>> drivers/pci/pci-sysfs.c:114:34: warning: initialization makes pointer
>> from integer without a cast [enabled by default]
>> drivers/pci/pci-sysfs.c: In function ‘cpulistaffinity_show’:
>> drivers/pci/pci-sysfs.c:123:34: warning: initialization makes pointer
>> from integer without a cast [enabled by default]
>> cc1: some warnings being treated as errors
>>
>>
>> i can send this as separate patch( as a  fix patch).
>
> Unless your series has already been merged, I don't like the idea of a
> separate fix patch.  The whole point of reviews is to try to fix as
> many things as we can *before* merging.
thanks for the review.
sure, i will add  this as part of my numa patch series.
>
> Bjorn

thanks
Ganapat
