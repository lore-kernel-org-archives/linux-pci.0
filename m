Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:50452 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab2FTIvY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 04:51:24 -0400
Message-ID: <4FE18EEF.6070409@huawei.com>
Date: Wed, 20 Jun 2012 16:50:55 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH v8 10/12] x86/PCI: refine __pci_mmcfg_init() for better
 code readability
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com> <1340111732-6276-11-git-send-email-jiang.liu@huawei.com> <CAE9FiQUmv310OQg4dJSSrkg79av6kz38EYiNoRTzHRjGVyLzZQ@mail.gmail.com>
In-Reply-To: <CAE9FiQUmv310OQg4dJSSrkg79av6kz38EYiNoRTzHRjGVyLzZQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-6-20 2:31, Yinghai Lu wrote:
> 
> looks like MCFG is not cached when the entries is reserved through e820.
> but it is cached when entries is reserved through ACPI ...
> 
> Please check if it is possible just not cache MCFG.
OOPS, my bad. The right logic should be
void __init pci_mmcfg_late_init(void)
{
        /* MMCONFIG disabled */
        if ((pci_probe & PCI_PROBE_MMCONF) == 0)
                return;

        if (known_bridge)
                return;

        /* MMCONFIG hasn't been enabled yet */
        if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF) {
                acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
                __pci_mmcfg_init(0);
        }

        if (!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
                acpi_pci_cache_mcfg();
}

Will send out a patch once we decide whether we should keep the MCFG cache.

Thanks!
Gerry

