Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44941 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbbJXPnn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 24 Oct 2015 11:43:43 -0400
Message-ID: <562BA729.10903@intel.com>
Date: Sat, 24 Oct 2015 23:43:37 +0800
From: "Lan, Tianyu" <tianyu.lan@intel.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.duyck@gmail.com>, bhelgaas@google.com,
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
Subject: Re: [RFC Patch 05/12] IXGBE: Add new sysfs interface of "notify_vf"
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com> <1445445464-5056-6-git-send-email-tianyu.lan@intel.com> <5627FB20.3020003@gmail.com>
In-Reply-To: <5627FB20.3020003@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 10/22/2015 4:52 AM, Alexander Duyck wrote:
> Also have you even considered the MSI-X configuration on the VF?  I
> haven't seen anything anywhere that would have migrated the VF's MSI-X
> configuration from BAR 3 on one system to the new system.

MSI-X migration is done by Hypervisor(Qemu).
Following link is my Qemu patch to do that.
http://marc.info/?l=kvm&m=144544706530484&w=2
