Return-Path: <SRS0=bxLM=CT=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=bxLM=CT=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
To: David Laight <David.Laight@ACULAB.COM>, Bjorn Helgaas
 <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
 <de047a7ce7334daab4e53ea4e8444421@AcuMS.aculab.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <13cf28da-9ab3-33a5-ea91-c62c186c6170@codeaurora.org>
Date: Tue, 21 Nov 2017 11:43:32 -0500
MIME-Version: 1.0
In-Reply-To: <de047a7ce7334daab4e53ea4e8444421@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/21/2017 11:25 AM, David Laight wrote:
>> The DPC on the other hand stops the drivers immediately since HW took care of
>> link disable. (Endpoint register reads return ~0 at this point.)
> What happens if the 'user' driver doesn't define the error reporting callbacks?
> It might be hardened against the ~0u returns from reads - so not OOPS.
> It might be appropriate to call the remove() function instead.

This is what the DPC driver does in its interrupt handler. 

http://elixir.free-electrons.com/linux/latest/ident/interrupt_event_handler

My understanding is that this will eventually call the remove() function on the
endpoint driver eventually. 

Bjorn had concerns that we are not calling the error handler if registered and
then calling remove() callback while the driver is in the middle of something
could be bad. 

He had concerns if remove() would leave something in a bad state so recovery
would really not work at all and kernel crashes eventually due to data corruption. 

Oza and I are looking for a way to plumb DPC's error handling into AER driver
so that PCI framework has a single place to look for error handling.

for dpc:
1. If an error handler registered, call it for all children devices
2. Remove all children devices from the bus
3. Recover the link with DPC
4. Rescan the entire bus and install the drivers again

> 
>> DPC driver clears
>> the interrupt from the DPC capability and brings the link up at the end. Full
>> enumeration/rescan follows this procedure to go back to functioning state.
> That might not be a good idea, very likely it will fail again immediately.

We can add a policy parameter and not bring up the link if you want to do
troubleshooting at the point of failure or have a way to define how the
system response should be. 

DPC causes a hot reset on the bus. Endpoint should go to reset state and we should
be able to bring up the link without any problems under normal circumstances.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
