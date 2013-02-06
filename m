Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:36184 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3BFRIu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 12:08:50 -0500
Received: by mail-vc0-f172.google.com with SMTP id l6so1007814vcl.17
        for <linux-pci@vger.kernel.org>; Wed, 06 Feb 2013 09:08:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADnq5_NsB=xZA-vMr8OkHF6W0GZgWEyZzBMD5AGMOr_jKj_jCw@mail.gmail.com>
References: <002b01ce0429$59d7acc0$0d870640$%han@samsung.com> <CADnq5_NsB=xZA-vMr8OkHF6W0GZgWEyZzBMD5AGMOr_jKj_jCw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 Feb 2013 10:08:12 -0700
Message-ID: <CAErSpo6k=AfkAbM70Xzyvq61t2HP+YqWStdSU3eK1kXbbCjV2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/pci: use PCI_EXP_LNKCAP_SLS_2_5GB/5_0GB instead of
 hardcoded values
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, David Airlie <airlied@linux.ie>,
	linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 6, 2013 at 7:27 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Wed, Feb 6, 2013 at 12:18 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>> Use PCI_EXP_LNKCAP_SLS_2_5GB and PCI_EXP_LNKCAP_SLS_5_0GB instead
>> of hardcoded values for readability. These bit definitions were
>> added by commit 130f1b8 ("PCI: Add PCIe Link Capability link speed
>> and width names")
>>
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

I posted the same patch last month, along with two other patches that
fix the reporting for pre-r3.0 devices and simplify the code a bit:

    http://marc.info/?l=linux-pci&m=135732663513525&w=2
    http://marc.info/?l=linux-pci&m=135732713413779&w=2
    http://marc.info/?l=linux-pci&m=135732666213542&w=2

I don't know the status of any of these; I'm expecting Dave to do
whatever he thinks is best.

>
>> ---
>>  drivers/gpu/drm/drm_pci.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
>> index 754bc96..11c8add 100644
>> --- a/drivers/gpu/drm/drm_pci.c
>> +++ b/drivers/gpu/drm/drm_pci.c
>> @@ -504,9 +504,9 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
>>                 if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
>>                         *mask |= DRM_PCIE_SPEED_80;
>>         } else {
>> -               if (lnkcap & 1)
>> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
>>                         *mask |= DRM_PCIE_SPEED_25;
>> -               if (lnkcap & 2)
>> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
>>                         *mask |= DRM_PCIE_SPEED_50;
>>         }
>>
>> --
>> 1.7.2.5
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
