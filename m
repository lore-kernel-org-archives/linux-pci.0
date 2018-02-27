Return-Path: <SRS0=rWCf=FV=siemens.com=jan.kiszka@kernel.org>
Return-Path: <SRS0=rWCf=FV=siemens.com=jan.kiszka@kernel.org>
Subject: Re: [PATCH 2/6] pci: Scan all functions when probing while running
 over Jailhouse
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Benedikt Spranger <b.spranger@linutronix.de>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
 <66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
 <20180222205753.GE16519@bhelgaas-glaptop.roam.corp.google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b830dc87-4953-835f-8479-fb57e55a035c@siemens.com>
Date: Tue, 27 Feb 2018 08:25:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180222205753.GE16519@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-22 21:57, Bjorn Helgaas wrote:
> On Mon, Jan 22, 2018 at 07:12:46AM +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> PCI and PCIBIOS probing only scans devices at function number 0/8/16/...
>> Subdevices (e.g. multiqueue) have function numbers which are not a
>> multiple of 8.
> 
> Suggested text:
> 
>   Per PCIe r4.0, sec 7.5.1.1.9, multi-function devices are required to
>   have a function 0.  Therefore, Linux scans for devices at function 0
>   (devfn 0/8/16/...) and only scans for other functions if function 0
>   has its Multi-Function Device bit set or ARI or SR-IOV indicate
>   there are more functions.
>   
>   The Jailhouse hypervisor may pass individual functions of a
>   multi-function device to a guest without passing function 0, which
>   means a Linux guest won't find them.
> 
>   Change Linux PCI probing so it scans all function numbers when
>   running as a guest over Jailhouse.
>   
>   This is technically prohibited by the spec, so it is possible that
>   PCI devices without the Multi-Function Device bit set may have
>   unexpected behavior in response to this probe.
> 
>> The simple hypervisor Jailhouse passes subdevices directly w/o providing
>> a virtual PCI topology like KVM. As a consequence a PCI passthrough from
>> Jailhouse to a guest will not be detected by Linux.
>>
>> Based on patch by Benedikt Spranger, adding Jailhouse probing to avoid
>> changing the behavior in the absence of the hypervisor.
>>
>> CC: Benedikt Spranger <b.spranger@linutronix.de>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> With subject change to:
> 
>   PCI: Scan all functions when running over Jailhouse
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thanks, all suggestions picked up for next round.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
