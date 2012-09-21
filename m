Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15194 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab2IUR6K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Sep 2012 13:58:10 -0400
Message-ID: <505CAAA1.3040409@redhat.com>
Date: Fri, 21 Sep 2012 13:57:53 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
CC: Takao Indoh <indou.takao@jp.fujitsu.com>, vgoyal@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com, hbabu@us.ibm.com,
	ishii.hironobu@jp.fujitsu.com, martin.wilck@ts.fujitsu.com
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com> <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com> <20120806203902.GH25559@redhat.com> <50473306.1070803@jp.fujitsu.com> <20120910143604.GB639@redhat.com> <504F1343.7030607@jp.fujitsu.com> <20120914200334.GA9041@phenom.dumpdata.com>
In-Reply-To: <20120914200334.GA9041@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/14/2012 04:03 PM, Konrad Rzeszutek Wilk wrote:
>> As to the boot parameter to enable this function, you suggested using
>> reset_devices. I found that on a certain platform resetting devices
>> caused PCIe error due to a hardware bug. Therefore I think we need
>> new parameter apart from reset_devices to disable this function on
>> such a machine.
>
> Wouldn't a DMI quirk be better for this? That way the second kernel
> internally would know not to do this.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
a DMI quirk for a PCIe switch?  pci-quirk maybe?  there is a hook
in per-device pci reset code path, which could be setup for such
a case.

