Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34787 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbbJVMv7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 08:51:59 -0400
Date: Thu, 22 Oct 2015 15:51:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, bhelgaas@google.com,
	carolyn.wyborny@intel.com, donald.c.skidmore@intel.com,
	eddie.dong@intel.com, nrupal.jani@intel.com,
	yang.z.zhang@intel.com, agraf@suse.de, kvm@vger.kernel.org,
	pbonzini@redhat.com, qemu-devel@nongnu.org,
	emil.s.tantilov@intel.com, intel-wired-lan@lists.osuosl.org,
	jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com,
	john.ronciak@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, matthew.vick@intel.com,
	mitch.a.williams@intel.com, netdev@vger.kernel.org,
	shannon.nelson@intel.com
Subject: Re: [Qemu-devel] [RFC Patch 05/12] IXGBE: Add new sysfs interface of
 "notify_vf"
Message-ID: <20151022155111-mutt-send-email-mst@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-6-git-send-email-tianyu.lan@intel.com>
 <5627FB20.3020003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5627FB20.3020003@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 21, 2015 at 01:52:48PM -0700, Alexander Duyck wrote:
> Also have you even considered the MSI-X configuration on the VF?  I haven't
> seen anything anywhere that would have migrated the VF's MSI-X configuration
> from BAR 3 on one system to the new system.

Hypervisors do this for virtual devices so they can do this
for physical devices too.

-- 
MST
