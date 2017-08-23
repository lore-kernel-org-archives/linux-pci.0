Return-Path: <SRS0=Fnf9=7Z=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=Fnf9=7Z=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170823135140.GA8498@bhelgaas-glaptop.roam.corp.google.com>
References: <1503331124-25029-1-git-send-email-oza.oza@broadcom.com>
 <1503331124-25029-2-git-send-email-oza.oza@broadcom.com> <20170822203347.GE6948@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPctfRhf8zkeoGN73N-vm8Adn7SwieAAeRKrjhY7m_RkEw@mail.gmail.com> <20170823135140.GA8498@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Wed, 23 Aug 2017 21:12:22 +0530
Message-ID: <CAMSpPPf5c2=zO81-7TEidOHbB8K0L3T2_wV4+9Gem5DB6rHWFw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
	Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 7:21 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Aug 23, 2017 at 03:57:02PM +0530, Oza Oza wrote:
>> On Wed, Aug 23, 2017 at 2:03 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > [+cc Sinan, Timur, Alex]
>> >
>> > Hi Oza,
>> >
>> > On Mon, Aug 21, 2017 at 09:28:43PM +0530, Oza Pawandeep wrote:
>> >> PCIe spec r3.1, sec 2.3.2
>> >> If CRS software visibility is not enabled, the RC must reissue the
>> >> config request as a new request.
>> >>
>> >> - If CRS software visibility is enabled,
>> >> - for a config read of Vendor ID, the RC must return 0x0001 data
>> >> - for all other config reads/writes, the RC must reissue the
>> >>   request
>> >
>> > You mentioned early on that this fixes an issue with NVMe after a
>> > reset.  Is that reset an FLR?  I'm wondering if this overlaps with the
>> > work Sinan is doing:
>> >
>> >   http://lkml.kernel.org/r/20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com
>> >
>> > With the current code in the tree, pci_flr_wait() probably waits only
>> > 100ms on your system.  It currently reads PCI_COMMAND and probably
>> > sees 0xffff0001 because the NVMe device returns a CRS completion
>> > (which this iproc RC incorrectly turns into 0xffff0001 data), so we
>> > exit the loop after a single msleep(100).
>> >
>> > Sinan is extending pci_flr_wait() to read the Vendor ID and look for
>> > the CRS SV indication.  If this is where you're seeing the NVMe issue,
>> > I bet we can fix this by simply changing iproc_pcie_config_read() to
>> > return the correct data when it sees a CRS completion.  Then the
>> > retry loop in pci_flr_wait() will work as intended.
>> >
>>
>> The issue with User Space poll mode drivers resulting into CRS.
>>
>>
>> root@bcm958742k:~# /usr/share/spdk/examples/nvme/perf -r 'trtype:PCIe
>> traddr:0000:01:00.0' -q 128 -s 4096 -w read -d 2048 -t 30 -c 0x1
>> Starting DPDK 16.11.1 initialization...
>> [ DPDK EAL parameters: perf -c 1 -m 2048 --file-prefix=spdk_pid2202 ]
>> EAL: Detected 8 lcore(s)
>> EAL: Probing VFIO support...
>> EAL: VFIO support initialized
>> EAL: cannot open /proc/self/numa_maps, consider that all memory is in
>> socket_id 0
>> Initializing NVMe Controllers
>> EAL: PCI device 0000:01:00.0 on NUMA socket 0
>> EAL:   probe driver: 8086:953 spdk_nvme
>> EAL:   using IOMMU type 1 (Type 1)
>> [   45.811353] vfio_ecap_init: 0000:01:00.0 hiding ecap 0x19@0x2a0
>> Attaching to NVMe Controller at 0000:01:00.0 [8086:0953]
>> [   46.486601] vfio_bar_restore: 0000:01:00.0 reset recovery - restoring bars
>> nvme_ctrlr.c:1237:nvme_ctrlr_process_init: ***ERROR*** Initialization
>> timed out in state 3
>> nvme_ctrlr.c: 414:nvme_ctrlr_shutdown: ***ERROR*** did not shutdown
>> within 5 seconds
>> EAL: Hotplug doesn't support vfio yet
>> spdk_nvme_probe() failed for transport address '0000:01:00.0'
>> /usr/share/spdk/examples/nvme/perf: errors occured
>>
>> ok, so this is in the context of
>> [   52.500579] [<ffff000008088498>] dump_backtrace+0x0/0x208
>> [   52.506147] [<ffff0000080886b4>] show_stack+0x14/0x20
>> [   52.511357] [<ffff0000083ace34>] dump_stack+0x8c/0xb0
>> [   52.516567] [<ffff00000840a550>] pci_flr_wait+0x18/0xc8
>> [   52.521955] [<ffff00000840bf9c>] pcie_flr+0x34/0x68
>> [   52.526986] [<ffff00000840e3d0>] __pci_dev_reset+0x100/0x2c0
>> [   52.532823] [<ffff00000840e60c>] pci_try_reset_function+0x64/0x80
>> [   52.539108] [<ffff00000856e4b8>] vfio_pci_ioctl+0x398/0xb78
>> [   52.544857] [<ffff000008568378>] vfio_device_fops_unl_ioctl+0x20/0x30
>> [   52.551501] [<ffff0000081d4e24>] do_vfs_ioctl+0xa4/0x738
>> [   52.556980] [<ffff0000081d5544>] SyS_ioctl+0x8c/0xa0
>> [   52.562100] [<ffff000008082f8c>] __sys_trace_return+0x0/0x4
>>
>>
>> So, I have two things to do here.
>>
>> 1) remove retry funciton and just do following.
>>    data = readl(cfg_data_p);
>>    if (data == CFG_RETRY_STATUS)    /* 0xffff0001 */
>>      data = 0xffffffff;
>>
>> 2) refactor the code with separate patch.
>>
>> but for that Sinan's patch is required.
>> then with both the patches I think, things will work out correctly for
>> iproc SOC.
>
> It looks like you are using the pci_flr_wait() path as I suspected.
>
> If you do the check as you mentioned in 1), this should work even
> without Sinan's patch.

looks like this can not work.
If I add folowing in iproc_pcie_config_read()

 if (data == CFG_RETRY_STATUS)    /* 0xffff0001 */
      data = 0xffffffff;

because pci_bus_read_dev_vendor_id returns false
/* some broken boards return 0 or ~0 if a slot is empty: */
if (*l == 0xffffffff || *l == 0x00000000 ||
   *l == 0x0000ffff || *l == 0xffff0000)
return false;


In working Enumuration case I get following:
[    9.125976] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), re-configuring
[    9.134267] where=0x0 val=0xffff0001
[    9.146946] where=0x0 val=0xffff0001
[    9.158943] where=0x0 val=0xffff0001
[    9.170945] where=0x0 val=0xffff0001
[    9.186945] where=0x0 val=0xffff0001
[    9.210944] where=0x0 val=0xffff0001
[    9.250943] where=0x0 val=0xffff0001
[    9.322942] where=0x0 val=0xffff0001
[    9.458943] where=0x0 val=0xffff0001
[    9.726942] where=0x0 val=0x9538086    >> actual vendor and device id.

so I think I have to retry in RC driver, so the old code still holds good.
except that I have to do factoring out.

please let me know If I missed anything, or you want me to try anything else.

Regards,
Oza.

>
> It's possible you'd have to increase the pci_flr_wait() timeout
> (currently 1sec total).  I think we'll end up doing that as part of
> Sinan's work, so we use the same timeout whether or not the RC
> supports CRS SV.
>
>>
>> Let me know how this sounds and if you agree with above two points, I
>> will be posting final set of patches.
>>
>> let me know if you want me to change anything in the commit description.
>> in my opinion I should remove config write description which is irrelevant here.
>
> I agree.  I don't think you need to say anything special about write,
> since I think an RC is probably allowed to drop (with no retries) a
> config write that receives a CRS completion.  In this case, I expect
> the RC would log an error, so you should see something in PCI_STATUS.
