Return-Path: <SRS0=ZSHg=KZ=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=ZSHg=KZ=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH] PCI: Match Root Port's MPS to endpoint's MPSS when
 necessary
To: Bjorn Helgaas <helgaas@kernel.org>, Myron Stowe <myron.stowe@redhat.com>
References: <20180718185158.149373.77902.stgit@tak.stowe>
 <20180801140507.GQ45322@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<keith.busch@intel.com>, <jdmason@kudzu.us>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <3f18a887-e669-f54d-1e89-36347cbfa44b@huawei.com>
Date: Fri, 10 Aug 2018 18:04:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180801140507.GQ45322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Myron

I found a bug after applied the patch.

The topology is as below. The 82599 netcard with two functions connect to RP.
  +-[0000:80]-+-00.0-[81]--+-00.0  Device 8086:10fb
  |           |            \-00.1  Device 8086:10fb

1. lspci -s BDF -vvv  to get the value of device's MPSS , MPS and MRRS.
RP (80:00.0): MPSS=512 MPS=512 MRRS=512
EP PF0(81:00.0): MPSS=512 MPS=512 MRRS=512
    PF1(81:00.1): MPSS=512 MPS=512 MRRS=512

2. Enable SRIOV.
echo 1  > /sys/devices/pci0000\:80/0000\:80\:00.0/0000\:81\:00.0/sriov_numvfs
RP(80:00.0): MPSS=512 MPS=128 MRRS=512
                           ^^^
EP PF0(81:00.0): MPSS=512 MPS=512 MRRS=512
			      ^^^ 	
    PF1(81:00.1): MPSS=512 MPS=512 MRRS=512
			      ^^^ 	
    VF0(81:10.0): MPSS=128 MPS=128 MRRS=128
                               ^^^
The 82599 netcard PF (MPSS 512) and VF's MPSS (MPSS 128) are different.
Then RP (MPS 128) will report Malformed TLP when PF0/PF1 has memory write operation with MPS 512.

The 82599 netcard could work ok without the patch.
The values of MPSS, MPS, MRRS are as below without the patch.

RP(80:00.0): MPSS=512 MPS=512 MRRS=512
                           ^^^
EP PF0(81:00.0): MPSS=512 MPS=512 MRRS=512
			      ^^^ 	
    PF1(81:00.1): MPSS=512 MPS=512 MRRS=512
			      ^^^ 	
    VF0(81:10.0): MPSS=128 MPS=128 MRRS=128
                               ^^^

Thanks,
Dongdong

在 2018/8/1 22:05, Bjorn Helgaas 写道:
> On Wed, Jul 18, 2018 at 12:51:58PM -0600, Myron Stowe wrote:
>> In commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge"), we made
>> sure every device's MPS setting matches its upstream bridge, making it more
>> likely that a hot-added device will work in a system with an optimized MPS
>> configuration.
>>
>> Recently I've started encountering systems where the endpoint device's MPSS
>> capability is less than its root port's current MPS value, thus the
>> endpoint is not capable of matching its upstream bridge's MPS setting (see:
>> bugzilla via "Link:" below).  This leaves the system vunerable - the
>> upstream root port could respond with larger sized TLPs than the endpoint
>> can handle, and the endpoint will consider them to be 'Malformed'.
>>
>> One could use the "pci=pcie_bus_safe" kernel parameter to resolve the
>> issue, but, it both forces a user to have to supply a kernel parameter to
>> get the system to function reliable, and may end up limiting MPS settings
>> of other, non-related, sub-topologies which could benefit from maintaining
>> their larger values.
>>
>> This patch augments Keith's approach to include tuning down a root port's
>> MPS setting when its hot-added endpoint device is not capable of matching
>> it.  The tuning down, so that both the root port and endpoint match, is
>> limited to root ports with downstream endpoint device sub-topologies.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200527
>> Cc: Keith Busch <keith.busch@intel.com>
>> Cc: Jon Mason <jdmason@kudzu.us>
>> Cc: Sinan Kaya <okaya@kernel.org>
>> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
>
> Applied to pci/enumeration for v4.19, thanks!
>
>> ---
>>  drivers/pci/probe.c |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac91b6f..2987bd9 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1670,7 +1670,7 @@ int pci_setup_device(struct pci_dev *dev)
>>  static void pci_configure_mps(struct pci_dev *dev)
>>  {
>>  	struct pci_dev *bridge = pci_upstream_bridge(dev);
>> -	int mps, p_mps, rc;
>> +	int mps, mpss, p_mps, rc;
>>
>>  	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
>>  		return;
>> @@ -1694,6 +1694,14 @@ static void pci_configure_mps(struct pci_dev *dev)
>>  	if (pcie_bus_config != PCIE_BUS_DEFAULT)
>>  		return;
>>
>> +	mpss = 128 << dev->pcie_mpss;
>> +	if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
>> +		pcie_set_mps(bridge, mpss);
>> +		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, max %d)\n",
>> +			 mpss, p_mps, 128 << bridge->pcie_mpss);
>> +		p_mps = pcie_get_mps(bridge);
>> +	}
>> +
>>  	rc = pcie_set_mps(dev, p_mps);
>>  	if (rc) {
>>  		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
>> @@ -1702,7 +1710,7 @@ static void pci_configure_mps(struct pci_dev *dev)
>>  	}
>>
>>  	pci_info(dev, "Max Payload Size set to %d (was %d, max %d)\n",
>> -		 p_mps, mps, 128 << dev->pcie_mpss);
>> +		 p_mps, mps, mpss);
>>  }
>>
>>  static struct hpp_type0 pci_default_type0 = {
>>
>
> .
>
