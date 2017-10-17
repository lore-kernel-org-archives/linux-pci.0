Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:59010
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932154AbdJQUyz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 16:54:55 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Komali Katari" <komali@chelsio.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
Date: Tue, 17 Oct 2017 20:54:51 +0000
Message-ID: <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>,<20171017133702.1b0e35bc@t450s.home>
In-Reply-To: <20171017133702.1b0e35bc@t450s.home>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  I'm not sure what the exact mechanism is that our QA person Komali used,
she'll need to respond to that.  The short summary of her report is:

------------
1>Loaded cxgb4 on Host.

2>Instantiated Max number of VF's (64) using below command, Observe cxgb4vf
automatically loaded, able to see all 64 VF's on the Host.

echo 16 > /sys/class/net/enp3s0f4/device/driver/0000\:03\:00.0/sriov_numvfs
echo 16 > /sys/class/net/enp3s0f4/device/driver/0000\:03\:00.1/sriov_numvfs
echo 16 > /sys/class/net/enp3s0f4/device/driver/0000\:03\:00.2/sriov_numvfs
echo 16 > /sys/class/net/enp3s0f4/device/driver/0000\:03\:00.3/sriov_numvfs

[root@t5nic ~]# lsmod | grep -i cxgb4
cxgb4vf                73728  0
iw_cxgb4              204800  0
ib_core               212992  14 ib_iser,ib_cm,rdma_cm,ib_umad,ib_srp,iw_cx=
gb4,ib_isert,ib_uverbs,rpcrdma,ib_ipoib,iw_cm,ib_srpt,ib_ucm,rdma_ucm
libcxgb                16384  1 iw_cxgb4
cxgb4                 282624  1 iw_cxgb4
ptp                    20480  2 cxgb4,e1000e

[root@t5nic ~]# ifconfig -a | grep -i 06:44 | wc -l
64

3>Unloaded cxgb4vf on Host, and verified in lsmod

[root@t5nic ~]# rmmod cxgb4vf

[root@t5nic ~]#  lsmod | grep -i cxgb4
iw_cxgb4              204800  0
ib_core               212992  14 ib_iser,ib_cm,rdma_cm,ib_umad,ib_srp,iw_cx=
gb4,ib_isert,ib_uverbs,rpcrdma,ib_ipoib,iw_cm,ib_srpt,ib_ucm,rdma_ucm
libcxgb                16384  1 iw_cxgb4
cxgb4                 282624  1 iw_cxgb4
ptp                    20480  2 cxgb4,e1000e

[root@t5nic ~]# ifconfig -a | grep -i 06:44 | wc -l
0

4>Attached one VF to the VM and powered on the VM. observed cxgb4vf is
getting automatically loaded on the Host. And observing 18 VF interfaces on
Host out of 63.

[root@t5nic ~]# lsmod | grep -i cxgb4
cxgb4vf                73728  0
iw_cxgb4              204800  0
ib_core               212992  14 ib_iser,ib_cm,rdma_cm,ib_umad,ib_srp,iw_cx=
gb4,ib_isert,ib_uverbs,rpcrdma,ib_ipoib,iw_cm,ib_srpt,ib_ucm,rdma_ucm
libcxgb                16384  1 iw_cxgb4
cxgb4                 282624  1 iw_cxgb4
ptp                    20480  2 cxgb4,e1000e

[root@t5nic ~]# ifconfig -a | grep -i 06:44 | wc -l
18
------------

  Komali's has tried this on 4.13.7 and not observed the above behavior.  W=
e
only see cxgb4vf loaded when the SR-IOV Virtual Functions are first
instantiated.  And it's interesting that the PCI layer only bound the
reloaded cxgb4vf to 18 of the 64 when she powered up the VM.  If the kernel
was going ahead and signalling the reload of cxgb4vf and was fencing off th=
e
one VF it attached to a VM, I would have expected cxgb4vf to be bound to th=
e
63 remainign VFs ...

Casey
