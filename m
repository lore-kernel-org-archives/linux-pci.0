Return-Path: <SRS0=7NSh=7W=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=7NSh=7W=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170819202616.GA32411@bhelgaas-glaptop.roam.corp.google.com>
References: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
 <1501861696-25767-2-git-send-email-oza.oza@broadcom.com> <20170819182607.GS28977@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPdvKTtCkv76mMBgqpbjf=T7EnSz6KBmVxVrRRSou-oE3g@mail.gmail.com> <20170819202616.GA32411@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Sun, 20 Aug 2017 09:12:41 +0530
Message-ID: <CAMSpPPci1sd-V8NP0Kbn=WLqg_Oj+WB6bLgtasmOrdS4YnFxKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 20, 2017 at 1:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Aug 20, 2017 at 01:02:09AM +0530, Oza Oza wrote:
>> On Sat, Aug 19, 2017 at 11:56 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> > I think you should do something like this instead so you don't do the
>> > MMIO read any more times than necessary:
>> >
>> >   static u32 iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>> >   {
>> >     u32 data;
>> >     int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
>> >
>> >     data = readl(cfg_data_p);
>> >     while (data == CFG_RETRY_STATUS && timeout--) {
>> >       udelay(1);
>> >       data = readl(cfg_data_p);
>> >     }
>> >
>> >     if (data == CFG_RETRY_STATUS)
>> >       data = 0xffffffff;
>> >     return data;
>> >   }
>> >
>> >   static int iproc_pcie_config_read(...)
>> >   {
>> >     u32 data;
>> >
>> >     ...
>> >     data = iproc_pcie_cfg_retry(cfg_data_p);
>> >     if (size <= 2)
>> >       *val = (data >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
>> >
>> > In the event of a timeout, this returns PCIBIOS_SUCCESSFUL and
>> > 0xffffffff data.  That's what most other platforms do, and most
>> > callers of the PCI config accessors check for that data instead of
>> > checking the return code to see whether the access was successful.
>> >
>> I see one problem with this.
>> we have Samsung NVMe which exposes 64-bit IO BAR.
>> 0xffff0001.
>>
>> and if you see __pci_read_base which does following in sequence.
>>
>> pci_read_config_dword(dev, pos, &l);
>> pci_write_config_dword(dev, pos, l | mask);
>> pci_read_config_dword(dev, pos, &sz);
>> pci_write_config_dword(dev, pos, l);
>>
>> returning 0xffffffff would not be correct in that case.
>> even if callers retry, they will end up in a loop if caller retries.
>>
>> hence I was returning 0xffff0001, it is upto the upper layer to treat
>> it as data or not.
>
> In your patch, I don't think the upper layer will ever see 0xffff0001.
> iproc_pcie_config_read() only updates *data if iproc_pcie_cfg_retry()
> returns PCIBIOS_SUCCESSFUL.  And iproc_pcie_cfg_retry() only returns
> PCIBIOS_SUCCESSFUL if it reads something other than 0xffff0001.
>
> Even if you *did* return 0xffff0001 to upper layers, I think we'd have
> a problem.  Here's an example scenario.  If we do a Function-Level
> Reset, pcie_flr() starts the reset, then calls pci_flr_wait() to wait
> until the device becomes ready again.  pci_flr_wait() thinks that any
> PCI_COMMAND value other than 0xffffffff means the device is ready.
>
> If the device returns CRS status and you return 0xffff0001 when
> pci_flr_wait() reads PCI_COMMAND, it thinks that means the device is
> ready, but it's not.
>
>> let me know if this sounds like a problem to you as well.
>>
>> so in my opinion returning 0xffffffff is not an option.
>>
>> > For example, pci_flr_wait() assumes that if a read of PCI_COMMAND
>> > returns ~0, it's because the device isn't ready yet, and we should
>> > wait and retry.

yes that will be a problem if I return 0xffff0001.
ok let me revise the patch by returning 0xffffffff as of now.

Regards,
Oza.
