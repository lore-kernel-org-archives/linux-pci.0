Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 14 Sep 2012 16:03:36 -0400
From: Konrad Rzeszutek Wilk <konrad@kernel.org>
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: vgoyal@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, hbabu@us.ibm.com,
	ishii.hironobu@jp.fujitsu.com, martin.wilck@ts.fujitsu.com
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
Message-ID: <20120914200334.GA9041@phenom.dumpdata.com>
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com>
 <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com>
 <50473306.1070803@jp.fujitsu.com>
 <20120910143604.GB639@redhat.com>
 <504F1343.7030607@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <504F1343.7030607@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> As to the boot parameter to enable this function, you suggested using
> reset_devices. I found that on a certain platform resetting devices
> caused PCIe error due to a hardware bug. Therefore I think we need
> new parameter apart from reset_devices to disable this function on
> such a machine.

Wouldn't a DMI quirk be better for this? That way the second kernel
internally would know not to do this.
