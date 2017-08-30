Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
To: Sinan Kaya <okaya@codeaurora.org>, Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>, rjw@rjwysocki.net,
        lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com,
        prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
 <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
 <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
 <0fb1fe1b-207a-93fe-4ac6-b886451e488e@codeaurora.org>
 <20170830101617.3m266q7xuew6ctxl@pd.tnic>
 <b630fa5e-c24b-06f4-47da-bed53161e0b7@codeaurora.org>
 <20170830151601.ro5qt5272e2msevp@pd.tnic>
 <af5dc902-faca-a7a1-6781-95ff82d5d8fd@codeaurora.org>
From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Message-ID: <a074792e-ad43-d4f5-6f99-8fcf8349c7ad@codeaurora.org>
Date: Wed, 30 Aug 2017 09:42:08 -0600
MIME-Version: 1.0
In-Reply-To: <af5dc902-faca-a7a1-6781-95ff82d5d8fd@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/30/2017 9:31 AM, Sinan Kaya wrote:
> On 8/30/2017 11:16 AM, Borislav Petkov wrote:
>> On Wed, Aug 30, 2017 at 10:05:44AM -0400, Sinan Kaya wrote:
>>> Link reset is not the only recovery mechanism. In the case of nonfatal
>>> errors, it is assumed that the endpoint CSR is still reachable.
>>> Error is propagated the PCIe endpoint driver. Endpoint driver does a
>>> re-initialization, we are back in business.
>> I'm assuming that's broadcast_error_message()'s job.
>>
> That's right. Each driver provides an err_handler hook. broadcast function
> calls these.
>
> static struct pci_driver e1000_driver = {
> 	..
> 	.err_handler = &e1000_err_handler
> };
>
> struct pci_error_handlers {
> 	...
> 	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
> 					   enum pci_channel_state error);
> }
>
>
>>> That's not true. The GHES code is changing the severity here before posting
>>> to the AER driver in ghes_do_proc().
>>>
>>> 	if (gdata->flags & CPER_SEC_RESET)
>>> 		aer_severity = AER_FATAL;
>> You're missing the point that we would walk into that if branch *only* for
>>
>>                          if (sev == GHES_SEV_RECOVERABLE &&
>>                              sec_sev == GHES_SEV_RECOVERABLE
>>
>> severities. So if you have an AER_FATAL error but ghes severities are
>> not GHES_SEV_RECOVERABLE, nothing happens.
> I see. We should probably try to do something only if GHES_SEV_CORRECTED or
> GHES_SEV_RECOVERABLE.
>
> If somebody wants to crash the system with GHES_SEV_PANIC, there is no point
> in doing additional work.
See below.
>>> No, AER ISR is not set up if firmware first is enabled.
>> So then this is a major suckage. We do AER recovery on FF systems only
>> for GHES_SEV_RECOVERABLE severity.
>>
>>> The behavior should match non firmware-first case ideally.
>>>
>>> 1. Print all correctable errors.
>>> 2. Go to do_recovery for all uncorrectable errors including fatal and
>>> non-fatal.
>>>
>>> This is also what AER driver does in the absence of firmware first via
>>> handle_error_source().
>> Yes, that makes sense.
>>
>> Which would mean that we'd call aer_recover_queue() regardless of GHES
>> severity but we'd do recovery only if GHES_SEV_RECOVERABLE is set
>> or CPER_SEC_RESET. I.e., we can communicate all that by setting the
>> correct AER severity before calling aer_recover_queue(). And then call
>> do_recovery() based on AER severity.
>>
>> Hmmm?
>>
> Sounds good. Do you still want to do PCIe recovery in the case of
> GHES_SEV_PANIC or if some FW returns GHES_SEV_NO?
>
We do not need to worry about the GHES_SEV_PANIC case. Those get sent to 
__ghes_panic() in ghes_proc() without even making it to ghes_do_proc(). 
Those errors are just printed and then the kernel panics.

I think with my two patches we will have the desired functionality:

GHES_SEV_CORRECTABLE -> AER_CORRECTABLE -> Print AER info, but do not 
call do_recovery

GHES_SEV_RECOVERABLE -> AER_NONFATAL -> Print AER info and do_recovery

GHES_RECOVERABLE and CPER_SEC_RESET -> AER_FATAL -> Print AER info and 
do_recover

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

