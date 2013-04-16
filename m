Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:54032 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DPIWR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2013 04:22:17 -0400
Received: by mail-bk0-f41.google.com with SMTP id i18so110821bkv.28
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2013 01:22:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7dgFR8a7Wee4CE7Rj+nZg_-+8uNOFq__d8EzY+gHQHGQ@mail.gmail.com>
References: <1366009135-19088-1-git-send-email-wangyijing@huawei.com>
	<CAErSpo7dgFR8a7Wee4CE7Rj+nZg_-+8uNOFq__d8EzY+gHQHGQ@mail.gmail.com>
Date: Tue, 16 Apr 2013 16:22:15 +0800
Message-ID: <CAC=cRTOPg+Db8AkA6sWMe9ggESY=vO7W1zWzr5E-JWLxoxg=7Q@mail.gmail.com>
Subject: Re: [PATCH -v2 1/2] PCI: decrease pci_dev->enable_cnt when no pcie
 capability found
From: huang ying <huang.ying.caritas@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 15, 2013 at 11:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Rafael, Huang]
>
> On Mon, Apr 15, 2013 at 12:58 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> We should decrease dev->enable_cnt when no pcie port capability
>> found for balance.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Cc: Jiang Liu <jiang.liu@huawei.com>
>> Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>> Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>> ---
>>  drivers/pci/pcie/portdrv_core.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 31063ac..aef3fac 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -369,8 +369,8 @@ int pcie_port_device_register(struct pci_dev *dev)
>>
>>         /* Get and check PCI Express port services */
>>         capabilities = get_port_device_capability(dev);
>> -       if (!capabilities)
>> -               return 0;
>> +       if (!capabilities)
>> +               goto error_disable;
>>
>>         pci_set_master(dev);
>>         /*
>
> Does this fix a problem you observed?  If so, please refer to it in
> your changelog.
>
> I think this patch is incorrect because pcie_portdrv_probe() will
> return 0 (success) with the device disabled.  When we call
> pcie_portdrv_remove(), we will attempt to disable the device again,
> even though it's already disabled.
>
> I don't know whether it is desirable for pcie_portdrv_probe() to
> succeed when no capabilities are available or not.  Maybe somebody
> else has an opinion.

I think this patchset is incorrect too.  Even if there is no PCIe
services for the PCIe port.  We still need the PCIe drivers, at least
for runtime power management.  Although runtime power management is
disabled for the PCIe port now, I think we will enable it again after
we fixed the corresponding issues.

Best Regards,
Huang Ying
