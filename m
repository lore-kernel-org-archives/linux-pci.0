Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 0/2] PCI: Workaround for bus reset on Cavium cn8xxx root
 ports
To: Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20170516001736.4001-1-david.daney@cavium.com>
 <20170523204750.GC15055@bhelgaas-glaptop.roam.corp.google.com>
 <20170523150404.221b01c7@w520.home>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <14ebfcd3-3f04-4dde-629a-cb2fc3843e39@caviumnetworks.com>
Date: Tue, 23 May 2017 14:22:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170523150404.221b01c7@w520.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>,
 Jon Masters <jcm@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2017 02:04 PM, Alex Williamson wrote:
> On Tue, 23 May 2017 15:47:50 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> On Mon, May 15, 2017 at 05:17:34PM -0700, David Daney wrote:
>>> With the recent improvements in arm64 and vfio-pci, we are seeing
>>> failures like this (on cn8890 based systems):
>>>
>>> [  235.622361] Unhandled fault: synchronous external abort (0x96000210) at 0xfffffc00c1000100
>>> [  235.630625] Internal error: : 96000210 [#1] PREEMPT SMP
>>> .
>>> .
>>> .
>>> [  236.208820] [<fffffc0008411250>] pci_generic_config_read+0x38/0x9c
>>> [  236.214992] [<fffffc0008435ed4>] thunder_pem_config_read+0x54/0x1e8
>>> [  236.221250] [<fffffc0008411620>] pci_bus_read_config_dword+0x74/0xa0
>>> [  236.227596] [<fffffc000841853c>] pci_find_next_ext_capability.part.15+0x40/0xb8
>>> [  236.234896] [<fffffc0008419428>] pci_find_ext_capability+0x20/0x30
>>> [  236.241068] [<fffffc0008423e2c>] pci_restore_vc_state+0x34/0x88
>>> [  236.246979] [<fffffc000841af3c>] pci_restore_state.part.37+0x2c/0x1fc
>>> [  236.253410] [<fffffc000841b174>] pci_dev_restore+0x4c/0x50
>>> [  236.258887] [<fffffc000841b19c>] pci_bus_restore+0x24/0x4c
>>> [  236.264362] [<fffffc000841c2dc>] pci_try_reset_bus+0x7c/0xa0
>>> [  236.270021] [<fffffc00060a1ab0>] vfio_pci_ioctl+0xc34/0xc3c [vfio_pci]
>>> [  236.276547] [<fffffc0005eb0410>] vfio_device_fops_unl_ioctl+0x20/0x30 [vfio]
>>> [  236.283587] [<fffffc000824b314>] do_vfs_ioctl+0xac/0x744
>>> [  236.288890] [<fffffc000824ba30>] SyS_ioctl+0x84/0x98
>>> [  236.293846] [<fffffc0008082ca0>] __sys_trace_return+0x0/0x4
>>>
>>> These are caused by the inability of the PCIe root port and Intel
>>> e1000e to sucessfully do a bus reset.
>>>
>>> The proposed fix is to not do a bus reset on these systems.
>>>
>>> David Daney (2):
>>>    PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device.
>>>    PCI: Avoid bus reset for Cavium cn8xxx root ports.
>>>
>>>   drivers/pci/pci.c    | 4 ++++
>>>   drivers/pci/quirks.c | 8 ++++++++
>>>   2 files changed, 12 insertions(+)
>>
>> Applied with Eric's reviewed-by and typo fixes to pci/virtualization for
>> v4.13, thanks!
> 
> Hmm, well let me again express my concerns that I'm really not sure how
> to support this since it removes our last opportunity to reset devices
> that may otherwise have no reset mechanism.  Certain classes of devices
> are entirely unsupportable for the code path indicated above without a
> bus reset.  If we have an endpoint device that goes bonkers at a bus
> reset, at least we know it's going to behave just as poorly no matter
> what the host platform.  This series allows endpoints that work
> perfectly well on one host to be handled differently on another.

Yes that is correct.  We choose not to crash the system.  I'm not sure 
what you are suggesting as an alternative.

If a PCI device doesn't work with vfio-pci in such a system, my 
suggestion would be not to use vfio-pci with the device in that system.

>  It
> certainly suggests something non-spec compliant about the root port
> implementation and I wish there was more analysis about exactly what
> that problem is since this is coming from the hardware vendor.

There are two main possibilities here:

1) Some (but not all) Intel e1000e and LSI HBA devices are non-spec 
compliant.

2) Cavium root port is non-spec compliant.

If #1 turns out to be true, would you suggest blacklisting e1000e on all 
systems, including Intel based servers?

If #2 turns out to be true would you still object to the patch?



> 
> https://lkml.org/lkml/2017/5/16/662
> 
> Thanks,
> Alex
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
