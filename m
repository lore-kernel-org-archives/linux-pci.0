Return-Path: <SRS0=gWbn=LF=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=gWbn=LF=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 22 Aug 2018 10:05:56 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Tai
 <thomas.tai@oracle.com>, bhelgaas@google.com, keith.busch@intel.com,
 linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org, Sam Bobroff
 <sam.bobroff@au1.ibm.com>
Subject: Re: PATCH] Partial revert of "PCI/AER: Handle ERR_FATAL with removal
 and re-enumeration of devices"
In-Reply-To: <20180821195023.GD154536@bhelgaas-glaptop.roam.corp.google.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
 <fa217fe562df74980febdd57e8e3361c2ece2ae2.camel@kernel.crashing.org>
 <20180821195023.GD154536@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <5b7b16598ecd480de32e5a5b2e673910@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-22 01:20, Bjorn Helgaas wrote:
> On Mon, Aug 20, 2018 at 02:39:04PM +1000, Benjamin Herrenschmidt wrote:
>> This partially reverts commit 
>> 7e9084b36740b2ec263ea35efb203001f755e1d8.
>> 
>> This only reverts the Documentation/PCI/pci-error-recovery.txt changes
>> 
>> Those changes are incorrect, they change the documentation to adapt
>> to the (imho incorrect) AER implementation, and as a result making
>> it no longer match the EEH implementation.
>> 
>> I believe the policy described originally in this document is what
>> should be implemented by everybody and the changes done by that commit
>> would compromise, among others, the ability to recover from errors 
>> with
>> storage devices.
> 
> I think we should align EEH, AER, and DPC as much as possible,
> including making this documentation match the code.
> 
> Because of its name, this file *looks* like it should match the code
> in the PCI core, i.e., drivers/pci/...  So I think it would be
> confusing to simply apply this revert without making a more direct
> connection between this documentation and the powerpc-specific EEH
> code.
> 
> If we can change AER & DPC to correspond to EEH, then I think it would
> make sense to apply this revert along with those AER & DPC changes so
> the documentation stays in step with the code.

I agree with you Bjorn, but it looks like we are far from holding some 
consensus on the behavior.
the other mail-chain [PCI/AER: prevent pcie_do_fatal_recovery from using 
device after it is removed]
has gone long enough, and touched lot of things all together. hence I 
would like to just use this mail-chain just to discuss
about AER, DPC behaviour.

let me put forward the proposal here to this mail-chain.

1) Right now AER and DPC both calls pcie_do_fatal_recovery(), I majorly 
see DPC as error handling and recovery agent rather than being used for 
hotplug.
    so in my opinion, both AER and DPC should have same error handling 
and recovery mechanism

    so if there is a way to figure out that in absence of pcihp, if DPC 
is being used to support hotplug then we fall back to original DPC 
mechanism (which
    is remove devices)
    otherwise, we fall back to drivers callbacks.

    Spec 6.7.5 Async Removal
    "
    The Surprise Down error resulting from async removal may trigger 
Downstream Port Containment (See Section 6.2.10).
    Downstream Port Containment following an async removal may be 
utilized to hold the Link of a
    Downstream Port in the Disabled LTSSM state while host software 
recovers from the side effects of an async removal.
    "
    pcie_do_fatal_recovery should take care of above. so that we support 
both error handling and async removal from DPC point of view.


2) pci_channel_io_frozen is the one which should be used from framework 
to communicate driver that this is ERR_FATAL, the it is left to the 
driver(s) to see if they want reset of the link (SBR).

3) pcie_do_nonfatal_recovery; we sould actually reset the link e.g. SBR 
if driver requests the reset of link.  (there is already TDO note 
anyway).
    if (status == PCI_ERS_RESULT_NEED_RESET) {
         /*
          * TODO: Should call platform-specific
          * functions to reset slot before calling
          * drivers' slot_reset callbacks?
          */
         status = broadcast_error_message(dev,
                 state,
                 "slot_reset",
                 report_slot_reset);
     }


Regards,
Oza.


> 
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>>  Documentation/PCI/pci-error-recovery.txt | 35 
>> +++++++-----------------
>>  1 file changed, 10 insertions(+), 25 deletions(-)
>> 
>> diff --git a/Documentation/PCI/pci-error-recovery.txt 
>> b/Documentation/PCI/pci-error-recovery.txt
>> index 688b69121e82..0b6bb3ef449e 100644
>> --- a/Documentation/PCI/pci-error-recovery.txt
>> +++ b/Documentation/PCI/pci-error-recovery.txt
>> @@ -110,7 +110,7 @@ The actual steps taken by a platform to recover 
>> from a PCI error
>>  event will be platform-dependent, but will follow the general
>>  sequence described below.
>> 
>> -STEP 0: Error Event: ERR_NONFATAL
>> +STEP 0: Error Event
>>  -------------------
>>  A PCI bus error is detected by the PCI hardware.  On powerpc, the 
>> slot
>>  is isolated, in that all I/O is blocked: all reads return 0xffffffff,
>> @@ -228,7 +228,13 @@ proceeds to either STEP3 (Link Reset) or to STEP 
>> 5 (Resume Operations).
>>  If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
>>  proceeds to STEP 4 (Slot Reset)
>> 
>> -STEP 3: Slot Reset
>> +STEP 3: Link Reset
>> +------------------
>> +The platform resets the link.  This is a PCI-Express specific step
>> +and is done whenever a fatal error has been detected that can be
>> +"solved" by resetting the link.
>> +
>> +STEP 4: Slot Reset
>>  ------------------
>> 
>>  In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
>> @@ -314,7 +320,7 @@ Failure).
>>  >>> However, it probably should.
>> 
>> 
>> -STEP 4: Resume Operations
>> +STEP 5: Resume Operations
>>  -------------------------
>>  The platform will call the resume() callback on all affected device
>>  drivers if all drivers on the segment have returned
>> @@ -326,7 +332,7 @@ a result code.
>>  At this point, if a new error happens, the platform will restart
>>  a new error recovery sequence.
>> 
>> -STEP 5: Permanent Failure
>> +STEP 6: Permanent Failure
>>  -------------------------
>>  A "permanent failure" has occurred, and the platform cannot recover
>>  the device.  The platform will call error_detected() with a
>> @@ -349,27 +355,6 @@ errors. See the discussion in 
>> powerpc/eeh-pci-error-recovery.txt
>>  for additional detail on real-life experience of the causes of
>>  software errors.
>> 
>> -STEP 0: Error Event: ERR_FATAL
>> --------------------
>> -PCI bus error is detected by the PCI hardware. On powerpc, the slot 
>> is
>> -isolated, in that all I/O is blocked: all reads return 0xffffffff, 
>> all
>> -writes are ignored.
>> -
>> -STEP 1: Remove devices
>> ---------------------
>> -Platform removes the devices depending on the error agent, it could 
>> be
>> -this port for all subordinates or upstream component (likely 
>> downstream
>> -port)
>> -
>> -STEP 2: Reset link
>> ---------------------
>> -The platform resets the link.  This is a PCI-Express specific step 
>> and is
>> -done whenever a fatal error has been detected that can be "solved" by
>> -resetting the link.
>> -
>> -STEP 3: Re-enumerate the devices
>> ---------------------
>> -Initiates the re-enumeration.
>> 
>>  Conclusion; General Remarks
>>  ---------------------------
>> 
>> 
