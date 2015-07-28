Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [RFC PATCH 0/1] iommu: Detach device from domain when removed from group
Date: Tue, 28 Jul 2015 19:55:55 +0200
Message-Id: <1438106156-51847-1-git-send-email-gerald.schaefer@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

during IOMMU API function testing on s390 I hit the following scenario:

After binding a device to vfio-pci, the user completes the VFIO_SET_IOMMU
ioctl and stops, see the sample C program below. Now the device is manually
removed via "echo 1 > /sys/bus/pci/devices/.../remove".

Although the SET_IOMMU ioctl triggered the attach_dev callback in the
underlying IOMMU API, removing the device in this way won't trigger the
detach_dev callback, neither during remove nor when the user program
continues with closing group/container.

On s390, this eventually leads to a kernel panic when binding the device
again to its non-vfio PCI driver, because of the missing arch-specific
cleanup in detach_dev. On x86, the detach_dev callback will also not be
called directly, but there is a notifier that will catch
BUS_NOTIFY_REMOVED_DEVICE and eventually do the cleanup. Other
architectures w/o the notifier probably have at least some kind of memory
leak in this scenario, so a general fix would be nice.

My first approach was to try and fix this in VFIO code, but Alex Williamson
pointed me to some asymmetry in the IOMMU code: iommu_group_add_device()
will invoke the attach_dev callback, but iommu_group_remove_device() won't
trigger detach_dev. Fixing this asymmetry would fix the issue for me, but
is this the correct fix? Any thoughts?

Regards,
Gerald


Here is the sample C program to trigger the ioctl:

#include <stdio.h>
#include <fcntl.h>
#include <linux/vfio.h>

int main(void)
{
        int container, group, rc;

        container = open("/dev/vfio/vfio", O_RDWR);
        if (container < 0) {
                perror("open /dev/vfio/vfio\n");
                return -1;
        }

        group = open("/dev/vfio/0", O_RDWR);
        if (group < 0) {
                perror("open /dev/vfio/0\n");
                return -1;
        }

        rc = ioctl(group, VFIO_GROUP_SET_CONTAINER, &container);
        if (rc) {
                perror("ioctl VFIO_GROUP_SET_CONTAINER\n");
                return -1;
        }

        rc = ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU);
        if (rc) {
                perror("ioctl VFIO_SET_IOMMU\n");
                return -1;
        }

        printf("Try device remove...\n");
        getchar();

        close(group);
        close(container);
        return 0;
}

Gerald Schaefer (1):
  iommu: Detach device from domain when removed from group

 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.3.8

