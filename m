Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:22083 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3HABX7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2013 21:23:59 -0400
Message-ID: <51F9B89D.1010803@huawei.com>
Date: Thu, 1 Aug 2013 09:23:41 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>, Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
References: <1360036520-31032-1-git-send-email-wangyijing@huawei.com> <51A42137.9090908@huawei.com> <CAErSpo7iyiq6H-BsPNO0Nyc1SF+JteOzBqNQ+d_D=RYE_pdTEA@mail.gmail.com> <51F73108.4070905@huawei.com> <CAErSpo4mHTwqrW-yq_1BkjD0GyFtVYZRm9+eGfASJ_aJCOagjg@mail.gmail.com> <CAErSpo4xJk7bHQihtdN1UP+6Y17TOrBFhEsO_Zwyvz8iQMEXsw@mail.gmail.com> <51F8D5C9.4020309@huawei.com> <CAErSpo5GUTXyo4GeCGvh_GauKUA4decbDWUnD47qKPr6E65g9w@mail.gmail.com> <CAErSpo6yuxdngHepJ96w72SOSapud2URwc2GHPT_-CZh0e1CSA@mail.gmail.com>
In-Reply-To: <CAErSpo6yuxdngHepJ96w72SOSapud2URwc2GHPT_-CZh0e1CSA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Yes, I think that would be safe.  If the switch is set to a larger MPS
>> than the hot-added device supports, I don't think we can safely use
>> the device.
> 
> I opened a bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60671
> for this problem.  Please correct any mistakes in my summary and
> reference it in your changelog.

OK, thanks!

> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing

