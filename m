Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Dec 2014 10:20:21 +0100
From: Andreas Mohr <andi@lisas.de>
To: Ethan Zhao <ethan.zhao@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ethan.kernel@gmail.com,
	Ethan Zhao <ethan.zhao@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: export pci device assignment info as read only via
 sysfs
Message-ID: <20141230092021.GA8458@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419927707-14462-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Ethan Zhao wrote:
> This patch exports assignment flag of PCI device via sysfs, so user
> space application could know if PCI device was assigned to guest OS
> or not via interface as following from viewpoint of host device
> management:
> 
>  PCI device was assigned to guest OS
>  $cat /sys/devices/pci0000:00/0000:00:1f.3/assigned
>  1
>  PCI device isn't assigned to guest OS
>  $cat /sys/devices/pci0000:00/0000:00:1f.3/assigned
>  0

For such a sysfs API (and similar cases in general!),
do we actually want this relatively simple interface of
"assigned" false/true?
Or should it rather be something like an "ownership" attribute
which could then indicate interface-fixed(!) string values
such as "system"/"vm_guest"/FUTURE_EXTENSION_POSSIBILITY?

IOW, "assigned" is quite a bit less flexible (and quite possibly even less
usability-suitable from a naming POV - "assigned"...??)
but of course simpler (which may or may not pose an advantage from an
interface versioning/evolution POV).

To further clarify things, this "assigned" interface as-is
can merely tell apart
the "device is occupied" vs. "device is not occupied" cases
yet it could easily provide exact ownership details instead.
And I'm also wondering whether or not it's good
to have it directly/symmetrically named "assigned"
due to it currently(!!) being based internally
on an equally-named pci_is_dev_assigned() API.


I should probably read up on sysfs item design hints/guidelines
which I'd trust to be accurately explained in a Documentation/ file ;)
Hmm, seems Documentation/sysfs-rules.txt has only one closing remark
which seems relevant:
====
  Userspace applications can, however, expect the format and contents of
  the attribute files to remain consistent in the absence of a version
  attribute change in the context of a given attribute.
====
This would be fulfilled by both the current and my suggested variant
of this interface, AFAICS.

Thanks,

Andreas Mohr
