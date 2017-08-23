Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 23 Aug 2017 10:06:45 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 3/3] vfio/pci: Don't probe devices that can't be reset
Message-ID: <20170823080645.GB3526@hc>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
 <1502957663-5527-4-git-send-email-jglauber@cavium.com>
 <20170817070017.1e9c9456@w520.home> <20170818134231.GA3464@hc>
 <20170818081251.2bbffe56@w520.home>
 <d7492153-ec84-eb87-13ac-eb3fc9116114@caviumnetworks.com>
 <20170818215553.3396d509@ul30vt.home>
MIME-Version: 1.0
In-Reply-To: <20170818215553.3396d509@ul30vt.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, linux-pci@vger.kernel.org,
 David Daney <ddaney@caviumnetworks.com>, linux-kernel@vger.kernel.org,
 Robert Richter <robert.richter@cavium.com>, Jon Masters <jcm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 18, 2017 at 09:55:53PM -0600, Alex Williamson wrote:
> On Fri, 18 Aug 2017 08:57:09 -0700
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
> > On 08/18/2017 07:12 AM, Alex Williamson wrote:

[...]

> > You previously rejected the idea to silently ignore bus reset requests 
> > on buses that do not support it.
> > 
> > So this leaves us with two options:
> > 
> > 1) Do nothing, and crash the kernel on systems with bad combinations of 
> > PCIe target devices and cn88xx when vfio_pci is used.
> > 
> > 2) Do something else.
> > 
> > We are trying to figure out what that something else should be.  The 
> > general concept we are working on is that if vfio_pci wants to reset a 
> > device, *and* bus reset is the only option available, *and* cn88xx, then 
> > make vfio_pci fail.
> 
> But that's not what these attempts do, they say if we can't do a bus or
> slot reset, fail the device probe.  The comment is trying to suggest
> they do something else, am I misinterpreting the actual code change?
> There are plenty of devices out there that don't care if bus reset
> doesn't work, they support FLR or PM reset or device specific reset or
> just deal without a reset.  We can't suddenly say this new thing is a
> requirement and sorry if you were happily using device assignment
> before, but there's a slim chance you're on this platform that falls
> over if we attempt to do a secondary bus reset.

Thanks for explaining this, I agree that we should not fail the device
probe as we only need to prevent the reset from happening.
So let's just drop this patch.


> > What is your opinion of doing that (assuming it is properly implemented)?
> 
> It seems like these attempts are trying to completely turn off vfio-pci
> on cn88xx, do you just want it unsupported on these platforms?  Should
> we blacklist anything where dev->bus->self is this root port?
> Otherwise, what's wrong with returning an error if a bus reset fails,
> because we should *never* silently ignore the request and pretend that
> it worked, perhaps even dev_warn()'ing that the platform doesn't
> support bus resets?  Thanks,

The ioctl's that trigger the slot/bus reset are already checking
if reset is possible. With David's patches pci_probe_reset_bus()
already fails.

But we also need to make pci_probe_reset_slot() fail on cn88xx to avoid
the same issue for the slot reset:

[  178.815041] [<fffffc000850b67c>] pci_generic_config_read+0x5c/0xf0
[  178.821221] [<fffffc0008534f60>] thunder_pem_config_read+0x90/0x228
[  178.827487] [<fffffc000850b564>] pci_bus_read_config_dword+0x84/0xb8
[  178.833841] [<fffffc000850d374>] pci_read_config_dword+0x5c/0x70
[  178.839848] [<fffffc0008513e54>] pci_find_next_ext_capability.part.7+0x44/0xc8
[  178.847075] [<fffffc0008514b00>] pci_find_ext_capability+0x48/0x58
[  178.853256] [<fffffc0008520e6c>] pci_restore_vc_state+0x44/0xa0
[  178.859175] [<fffffc0008514d4c>] pci_restore_state.part.26+0x3c/0x240
[  178.865614] [<fffffc0008514fe0>] pci_dev_restore+0x58/0x60
[  178.871098] [<fffffc00085150a0>] pci_slot_restore+0x60/0x78
[  178.876669] [<fffffc000851599c>] pci_try_reset_slot+0xcc/0x140
[  178.882512] [<fffffc0000d91b78>] vfio_pci_ioctl+0xb30/0xb88 [vfio_pci]
[  178.889050] [<fffffc0000ba02b4>] vfio_device_fops_unl_ioctl+0x44/0x70 [vfio]
[  178.896100] [<fffffc0008267e00>] do_vfs_ioctl+0xb0/0x748
[  178.901411] [<fffffc000826852c>] SyS_ioctl+0x94/0xa8
[  178.906375] [<fffffc00080834a0>] __sys_trace_return+0x0/0x4
[  178.911947] Code: 7100069f 540003c0 71000a9f 54000240 (b9400001) 
[  178.918108] ---[ end trace 07143dcba854194e ]---
[  178.922784] Kernel panic - not syncing: Fatal exception

So far I don't see how this can be done in a clean way, there is no quirk
available for the slot.

--Jan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
