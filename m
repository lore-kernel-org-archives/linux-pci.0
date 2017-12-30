Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 30 Dec 2017 09:27:48 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 2/4] PCI/DPC/AER: Address Concurrency between AER and
 DPC
In-Reply-To: <20171229181340.GG16407@localhost.localdomain>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <1514532259-19383-3-git-send-email-poza@codeaurora.org>
 <20171229172324.GF16407@localhost.localdomain>
 <481784bb38707839493fc04e6a2b4068@codeaurora.org>
 <20171229181340.GG16407@localhost.localdomain>
Message-ID: <c080079a21b839e4d755184429486da8@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-12-29 23:43, Keith Busch wrote:
> On Fri, Dec 29, 2017 at 11:30:02PM +0530, poza@codeaurora.org wrote:
>> On 2017-12-29 22:53, Keith Busch wrote:
>> 
>> > 2. A DPC event suppresses the error message required for the Linux
>> > AER driver to run. How can AER and DPC run concurrently?
>> 
>> I afraid I could not grasp the first line completely.
> 
> A DPC capable and enabled port discards error messages; the ERR_FATAL
> or ERR_NONFATAL message required to trigger AER handling won't exist in
> such a setup.
> 
> This behavior is defined in the specification 6.2.10 for Downstream
> Port Containment:
> 
>   When DPC is triggered due to receipt of an uncorrectable error 
> Message,
>   the Requester ID from the Message is recorded in the DPC Error
>   Source ID register and that Message is discarded and not forwarded
>   Upstream. When DPC is triggered by an unmasked uncorrectable error,
>   that error will not be signaled with an uncorrectable error Message,
>   even if otherwise enabled.

In my understanding, thiis talks about DPC enabled switch. this case is 
taken care as well.
if you look at patchset-3, when AER is triggered, AER's pci_dev is of 
endpoint
will traverse all the way up until it finds associated DPC service 
enabled.
pdev = pcie_port_upstream_bridge(dev);

if AER is not triggered, then at switch level DPC will take 
care/suppress the msg
and entire SW will not come into picture then.

But specifically the patches attempts to bring in some sort of 
coordination and understanding between AER and DPC.
as I mentioned in my previous mail.

Regards,
Oza.
