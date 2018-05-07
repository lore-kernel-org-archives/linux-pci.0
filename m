Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Mon, 07 May 2018 19:46:12 +0100
From: okaya@codeaurora.org
To: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: AER: Malformed TLP recovery deadlock with NVMe drives
In-Reply-To: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
Message-ID: <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Alex_Gagniuc@dellteam.com, linux-pci@vger.kernel.org, shyam_iyer@dell.com,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 austin_bolen@dell.com, linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-07 19:36, Alex G. wrote:
> Hi! Me again!
> 
> I'm seeing what appears to be a deadlock in the AER recovery path. It
> seems that the device_lock() call in report_slot_reset() never returns.
> How we get there is interesting:
> 


Can you give this patch a try?


https://patchwork.kernel.org/patch/10351515/




> Injection of the error happens by changing the maximum payload size to
> 128 bytes from 256. This is on the switch upstream port.
> When there's IO to the drive, switch sees a malformed TLP. Switch
> reports error, AER handles it.
> More IO goes, another error is triggered, and this time the root port
> reports it. AER recovery hits the NVMe drive behind the affetced
> upstream port and deadlocks.
> 
> I've added some printks in the AER handler to see which lock dies, and 
> I
> have a fairly succinct log[1], also pasted below. It appears somebody 
> is
> already holding the lock to the PCI device behind the sick upstream
> port, and never releases it.
> 
> 
> I'm not sure how to track down other users of the lock, and I"m hoping
> somebody may have a brighter idea.
> 
> Alex
> 
> 
> [1] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1308.log
> 
> 
> Appendix A: log
> 
> :: Mon May  7 13:09:02 2018 :: <function malform_tlp at 0x7f27fec04400>
> [  127.857606] megaraid_sas 0000:86:00.0: invalid short VPD tag 00 at
> offset 1
> [  138.385529] pcieport 0000:ae:00.0: AER: Multiple Uncorrected (Fatal)
> error received: id=b020
> [  138.571742] pcieport 0000:b0:04.0: PCIe Bus Error:
> severity=Uncorrected (Fatal), type=Transaction Layer, id=b020(Receiver 
> ID)
> [  138.583050] pcieport 0000:b0:04.0:   device [10b5:9733] error
> status/mask=00440000/01a10000
> [  138.591398] pcieport 0000:b0:04.0:    [18] Malformed TLP          
> (First)
> [  138.598200] pcieport 0000:b0:04.0:    [22] Uncorrectable Internal 
> Error
> [  138.604812] pcieport 0000:b0:04.0:   TLP Header: 60000040 b10000ff
> 00000003 df400000
> [  138.612554] pcieport 0000:b0:04.0: broadcast error_detected message
> [  138.612557] nvme 0000:b1:00.0: HACK: report_error_detected: 
> Preparing
> to lock
> [  138.612557] nvme 0000:b1:00.0: HACK: report_error_detected: locked
> and ready
> [  138.612560] nvme nvme2: frozen state error detected, reset 
> controller
> [  151.133387] nvme 0000:b1:00.0: HACK: report_error_detected: Unlocked
> and DONE
> [  152.164786] pcieport 0000:b0:04.0: downstream link has been reset
> [  152.164789] pcieport 0000:b0:04.0: broadcast slot_reset message
> [  152.164793] nvme 0000:b1:00.0: HACK: report_slot_reset: Preparing to 
> lock
> [  152.164795] nvme 0000:b1:00.0: HACK: report_slot_reset: locked and 
> ready
> [  152.164799] nvme nvme2: restart after slot reset
> [  152.164863] nvme 0000:b1:00.0: HACK: report_slot_reset: Unlocked and 
> DONE
> [  152.164865] pcieport 0000:b0:04.0: broadcast resume message
> [  152.164867] nvme 0000:b1:00.0: HACK: report_resume: Preparing to 
> lock
> [  152.164869] nvme 0000:b1:00.0: HACK: report_resume: locked and ready
> [  152.164901] nvme 0000:b1:00.0: HACK: report_resume: Unlocked and 
> DONE
> [  152.164904] pcieport 0000:b0:04.0: AER: Device recovery successful
> [  152.164907] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164913] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164917] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164921] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164925] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164930] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164934] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164938] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164942] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164946] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164951] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164955] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164959] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164963] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164967] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164972] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164976] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164980] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164984] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164988] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164992] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.164997] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165001] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165005] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165009] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165013] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165017] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165022] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165026] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165030] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165034] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165038] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=b020
> [  152.165043] pcieport 0000:ae:00.0: AER: Uncorrected (Fatal) error
> received: id=ae00
> [  152.165046] pcieport 0000:ae:00.0: PCIe Bus Error:
> severity=Uncorrected (Fatal), type=Transaction Layer, id=ae00(Requester 
> ID)
> [  152.176442] pcieport 0000:ae:00.0:   device [8086:2030] error
> status/mask=00004000/00310000
> [  152.184795] pcieport 0000:ae:00.0:    [14] Completion Timeout     
> (First)
> [  152.191600] pcieport 0000:ae:00.0: broadcast error_detected message
> [  152.191601] pcieport 0000:af:00.0: HACK: report_error_detected:
> Preparing to lock
> [  152.191602] pcieport 0000:af:00.0: HACK: report_error_detected:
> locked and ready
> [  152.191613] pcieport 0000:af:00.0: HACK: report_error_detected:
> Unlocked and DONE
> [  152.191614] pcieport 0000:b0:04.0: HACK: report_error_detected:
> Preparing to lock
> [  152.191615] pcieport 0000:b0:04.0: HACK: report_error_detected:
> locked and ready
> [  152.191621] pcieport 0000:b0:04.0: HACK: report_error_detected:
> Unlocked and DONE
> [  152.191622] nvme 0000:b1:00.0: HACK: report_error_detected: 
> Preparing
> to lock
> [  152.191623] nvme 0000:b1:00.0: HACK: report_error_detected: locked
> and ready
> [  152.191624] nvme nvme2: frozen state error detected, reset 
> controller
> [  152.204899] nvme 0000:b1:00.0: HACK: report_error_detected: Unlocked
> and DONE
> [  152.204903] pcieport 0000:b0:05.0: HACK: report_error_detected:
> Preparing to lock
> [  152.204906] pcieport 0000:b0:05.0: HACK: report_error_detected:
> locked and ready
> [  152.204921] pcieport 0000:b0:05.0: HACK: report_error_detected:
> Unlocked and DONE
> [  152.204924] nvme 0000:b2:00.0: HACK: report_error_detected: 
> Preparing
> to lock
> [  152.204927] nvme 0000:b2:00.0: HACK: report_error_detected: locked
> and ready
> [  152.204931] nvme nvme3: frozen state error detected, reset 
> controller
> [  152.230068] nvme 0000:b2:00.0: HACK: report_error_detected: Unlocked
> and DONE
> [  152.230073] pcieport 0000:b0:06.0: HACK: report_error_detected:
> Preparing to lock
> [  152.230075] pcieport 0000:b0:06.0: HACK: report_error_detected:
> locked and ready
> [  152.230091] pcieport 0000:b0:06.0: HACK: report_error_detected:
> Unlocked and DONE
> [  152.230094] pcieport 0000:b0:07.0: HACK: report_error_detected:
> Preparing to lock
> [  152.230097] pcieport 0000:b0:07.0: HACK: report_error_detected:
> locked and ready
> [  152.230111] pcieport 0000:b0:07.0: HACK: report_error_detected:
> Unlocked and DONE
> [  152.300716] nvme nvme2: Removing after probe failure status: -19
> [  152.306687] nvme1n1: detected capacity change from 3200631791616 to 
> 0
> [  152.306789] md: super_written gets error=10
> [  152.311002] md/raid1:mdX: Disk failure on dm-4, disabling device.
>                md/raid1:mdX: Operation continuing on 2 devices.
> [  153.252694] pcieport 0000:ae:00.0: Root Port link has been reset
> [  153.252700] pcieport 0000:ae:00.0: broadcast slot_reset message
> [  153.252705] pcieport 0000:af:00.0: HACK: report_slot_reset: 
> Preparing
> to lock
> [  153.252707] pcieport 0000:af:00.0: HACK: report_slot_reset: locked
> and ready
> [  153.252782] pcieport 0000:af:00.0: HACK: report_slot_reset: Unlocked
> and DONE
> [  153.252785] pcieport 0000:b0:04.0: HACK: report_slot_reset: 
> Preparing
> to lock
> [  153.252787] pcieport 0000:b0:04.0: HACK: report_slot_reset: locked
> and ready
> [  153.252859] pcieport 0000:b0:04.0: HACK: report_slot_reset: Unlocked
> and DONE
> [  153.252862] nvme 0000:b1:00.0: HACK: report_slot_reset: Preparing to 
> lock
> [  153.252911] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up
> :: Mon May  7 13:09:33 2018 :: <function malform_tlp at 0x7f27fec04400>
> :: Mon May  7 13:09:33 2018 :: <function malform_tlp at 0x7f27fec04400>
> :: Mon May  7 13:10:03 2018 :: <function malform_tlp at 0x7f27fec04400>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
