Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36175 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbbFCLpx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2015 07:45:53 -0400
Received: by qgep100 with SMTP id p100so2334127qge.3
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2015 04:45:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000301d09888$09d01370$1d703a50$@com>
References: <000301d09888$09d01370$1d703a50$@com>
Date: Wed, 3 Jun 2015 17:15:52 +0530
Message-ID: <CAHM4w1mGB1GET6s-rkLs-0=Cqc4-zEm5q9-i8vxpFGgjf-V8JA@mail.gmail.com>
Subject: Re: [PATCH Part1 v11 3/5] PCI: designware: Use pci_scan_root_bus()
 for simplicity
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Daniel Axtens <dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 27, 2015 at 7:48 PM, Jingoo Han <jingoohan1@gmail.com> wrote:
> On Tue, 28 Apr 2015 15:01:37 +0800, Yijing Wang wrote:
>
>> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
>> Now pci_scan_root_bus() == pci_create_root_bus() +
>> pci_scan_child_bus() if busn resource is supplied.
>> Designware added the busn resource to resources list
>> in dw_pcie_setup(). So it should be safe to use
>> pci_scan_root_bus() instead.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Mohit Kumar <mohit.kumar@st.com>
>> CC: Jingoo Han <jg1.han@samsung.com>
>
> +cc: Pratyush Anand, Lucas Stach
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>



Looks fine to me:
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
