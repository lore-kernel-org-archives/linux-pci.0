Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
To: Greg KH <gregkh@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>
References: <faa339c4-b087-d970-1099-3d6cf8186545@arm.com>
 <20170726131058.GA8665@hc> <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
 <20170726145522.GC28875@nazgul.tnic> <20170726151314.GA10696@hc>
 <20170726153502.GE28875@nazgul.tnic> <20170726154515.GA11453@hc>
 <20170726155548.GF28875@nazgul.tnic> <20170726161949.GB15426@kroah.com>
 <20170726163049.GG28875@nazgul.tnic> <20170726173353.GB21705@kroah.com>
From: David Daney <ddaney.cavm@gmail.com>
Message-ID: <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
Date: Wed, 26 Jul 2017 13:02:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170726173353.GB21705@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jan Glauber <jan.glauber@caviumnetworks.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 07/26/2017 10:33 AM, Greg KH wrote:
> On Wed, Jul 26, 2017 at 06:30:49PM +0200, Borislav Petkov wrote:
>> On Wed, Jul 26, 2017 at 09:19:49AM -0700, Greg KH wrote:
>>> On Wed, Jul 26, 2017 at 05:55:48PM +0200, Borislav Petkov wrote:
>>>> On Wed, Jul 26, 2017 at 05:45:15PM +0200, Jan Glauber wrote:
>>>>> The PMU/EDAC devices are all PCI devices do I need the 'struct pci_dev *'.
>>>>> I'm not aware of other ways to access these devices. Please enlighten
>>>>> me if I'm missing something.
>>>>
>>>> Me enlighten you on Cavium hardware?! You're funny.
>>>>
>>>> So I don't know whether the PCI hotplug code can run more than one
>>>> function upon PCI ID detection. Probably Greg will say, write a
>>>> multiplexer wrapper. :-)
>>>
>>> -ENOCONTEXT....
>>>
>>> Anyway, pci questions are best asked on the linux-pci@vger list.  And
>>> yes, all PCI devices end up with a 'struct pci_dev *' automatically.
>>
>> Simple: so they have a PCI ID of a memory contoller and want to hotplug
>> two drivers for it. And those two drivers should remain independent from
>> each other.
> 
> Hahahahaha, no.  That's crazy, you were right in guessing what my answer
> was going to be :)
> 


Just to be clear about the situation, the device is a memory controller. 
  It has two main behaviors we are interested in:

A) Error Detection And Correction (EDAC).  This should be connected to 
the kernel's EDAC subsystem.  An existing driver 
(drivers/edac/thunderx_edac.c) does exactly this.

B) Performance Counters for actions taken in the corresponding memory. 
This should be connected to the kernel's perf framework as an uncore-PMU 
(the subject of this patch set).

It is a single PCI device.  What should the driver architecture look 
like to connect it to two different kernel subsystems?

Thanks,
David Daney


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
