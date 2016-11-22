Return-Path: <andrew.donnellan@au1.ibm.com>
Return-Path: <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access
 timeout
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org,
        Stephen Hemminger <sthemmin@microsoft.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 22 Nov 2016 11:15:59 +1100
MIME-Version: 1.0
In-Reply-To: <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9f08836b-d483-e54a-b56d-c4f20d4d1a90@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 22/11/16 09:05, Bjorn Helgaas wrote:
> Hi Matthew,
>
> On Mon, Nov 21, 2016 at 03:09:49PM -0600, Matthew R. Ochs wrote:
>> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
>> complete. When an access does not complete within this period, a warning
>> is logged and an error returned to the caller.
>>
>> While this default timeout is valid for most hardware, some devices can
>> experience longer access delays under certain circumstances. For example,
>> one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
>> scenario. These types of devices can benefit from an extended timeout that
>> is specific to their hardware constraints.
>>
>> To support per-device VPD access timeouts, pci_set_vpd_timeout() is added
>> as an exported service. PCI devices will continue to default with the 50ms
>> timeout and use a per-device timeout when a driver calls this new service.
>
> Can you include a pointer to something in the spec that's behind the
> default 50ms timeout, or did somebody just pull that number out of the
> air?

It looks like Stephen Hemminger added the 50ms timeout in 1120f8b8169f, 
which seems to indicate that 50ms was chosen because it's longer than 
the 13ms per word that was measured on one device.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
