Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47444 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab3JIPAi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 11:00:38 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so1605628iec.6
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2013 08:00:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000301cec4c4$3dc751f0$b955f5d0$%han@samsung.com>
References: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <000301cec4c4$3dc751f0$b955f5d0$%han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Oct 2013 09:00:14 -0600
Message-ID: <CAErSpo7za8Puks_1hfoX9j_6FDxsD=1UqarCp-y4MhwQKJtzvQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
To: Jingoo Han <jg1.han@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 9, 2013 at 1:50 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Tuesday, October 08, 2013 9:05 AM, Bjorn Helgaas wrote:
>>
>> The following variables and functions are used only in pcie-designware.c,
>> so make them static:
>>
>>   global_io_offset
>>   dw_pcie_rd_own_conf()
>>   dw_pcie_wr_own_conf()
>>   dw_pcie_setup()
>>   dw_pcie_scan_bus()
>>   dw_pcie_map_irq()
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
>
> It looks good.
> Also I tested this patch on Exynos5440. It works properly.
> Thank you for sending the patch.

I applied this to my pci/host-designware branch for v3.13.  Thanks!

>> ---
>>  drivers/pci/host/pcie-designware.c |   16 ++++++++--------
>>  drivers/pci/host/pcie-designware.h |    7 -------
>>  2 files changed, 8 insertions(+), 15 deletions(-)
>
