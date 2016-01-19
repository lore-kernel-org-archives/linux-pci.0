Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCHv2 0/4] PCI VPD access fixes
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <569EA251.9080204@oracle.com>
Date: Tue, 19 Jan 2016 14:53:37 -0600
MIME-Version: 1.0
In-Reply-To: <1452684335-46107-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 1/13/2016 5:25 AM, Hannes Reinecke wrote:
> Hi all,
> 
> the current PCI VPD page access assumes that the entire possible VPD
> data is readable. However, the spec only guarantees a VPD data up to
> the 'end' marker, with everything beyond that being undefined.
> This causes a system lockup on certain devices.
> 
> With this patch we always set the VPD sysfs attribute size to '0', and
> calculate the available VPD size on the first access.
> If no valid data can be read an I/O error is returned.
> 
> I've also included the patch from Babu to blacklists devices which
> are known to lockup when accessing the VPD data.
> 
> Babu Moger (1):
>   pci: Blacklist vpd access for buggy devices
> 
> Hannes Reinecke (3):
>   pci: Update VPD definitions
>   pci: allow access to VPD attributes with size '0'
>   pci: Determine actual VPD size on first access
> 
>  drivers/pci/access.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/pci-sysfs.c | 22 ++++++++------
>  drivers/pci/quirks.c    | 41 +++++++++++++++++++++++++
>  include/linux/pci.h     | 27 +++++++++++++++--
>  4 files changed, 157 insertions(+), 12 deletions(-)
> 

Resending the patch 4/4. Added Atheros controller(0x1969:0x1026) in blacklist.
Jordan confirmed the Vendor and Device id(0x1969:0x1026). Here is the device.
09:00.0 Ethernet controller: Atheros Communications AR8121/AR8113/AR8114 Gigabit or Fast Ethernet (rev b0)
