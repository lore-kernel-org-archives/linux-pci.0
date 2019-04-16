Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE35C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65098206B6
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dmcgNV1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfDPT1d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:27:33 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12011 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPT1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 15:27:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb62ca90001>; Tue, 16 Apr 2019 12:27:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 12:27:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 12:27:32 -0700
Received: from [10.24.70.92] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:27:28 +0000
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
To:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <20190415092537.14305-1-kwizart@gmail.com>
 <20190415134813.GA111421@google.com> <20190416113504.GG10907@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <e7482eb3-ef7d-9e7b-4a71-fb44aa5c1739@nvidia.com>
Date:   Wed, 17 Apr 2019 00:57:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416113504.GG10907@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555442857; bh=ZziEmLZqB8bjl1Fznfz0ZaxBa0adzfwIeu0wKgzcYA8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=dmcgNV1otMONk+74wm+QqsSrmFUlZH1Dnqwtt5Ou5UvM68/nBXUefoFHsK3Ujtn33
         Kv+3ypuQ5zNu2o4Y4HTcOdbUEWHdO6TtUZJiAUDC4tzphxIZP0VwFpOBGrhZFbUlZM
         987eBFar9brlIq+R8gPaiWSkhr3xReTw8n6K9HVx0yJRCAeakR14j9+iSSkNgSNGTY
         Sy2wTnUpuM4/hajeo/9oEf98Saco1lhdv/rFO+cs6xZx2x/nF0HVd2dUIsz/pgdCKJ
         fbYgaRPzqCDgjK7NQ2eWmpyye0S1Cq0RyijxsX+tOi77Ktjf/ll6VJPMDQOKO6ZDRd
         LOeW0rtt65UQw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 16-Apr-19 5:05 PM, Thierry Reding wrote:
> On Mon, Apr 15, 2019 at 08:48:13AM -0500, Bjorn Helgaas wrote:
>> On Mon, Apr 15, 2019 at 11:25:37AM +0200, Nicolas Chauvet wrote:
>>> This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm and
>>> arm64 NVIDIA devices such as Tegra
>>>
>>> This fixes the following output:
>>> "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
>>> as experienced on a Trimslice device with PCI host bridge enabled
>>>
>>> v3: exclude the quirk for arm and arm64 instead of only for x86
>>>
>>> v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf
>>>
>>> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
>>> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  drivers/pci/quirks.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index a59ad09ce911..1ac65f09d7ee 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
>>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
>>>  
>>> -static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
>>> +static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
>>>  {
>>>  	return __nv_msi_ht_cap_quirk(dev, 0);
>>>  }
>>> +/* HyperTransport is not relevant on theses arches */
>>> +#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)
>> I don't see any of the previous versions or discussion on the list, so
>> I can't tell what led to this #ifdef, but I'd prefer to avoid #ifdefs
>> like this because they're checking for arch at the wrong level.
>>
>> If you're seeing that warning message, apparently your system contains
>> an Nvidia device that has an HT_CAPTYPE_MSI_MAPPING capability, so
>> HyperTransport is at least in the picture, even on arm/arm64.
>>
>> The quirk assumes a host bridge at 00:00.0, which is really a
>> device-specific assumption, or maybe something specific to
>> HyperTransport.  It's certainly not required by the PCI specs, which
>> don't require a host bridge to be visible as a PCI device at all.
>>
>> I'd be tempted to just change that pci_warn() to a pci_info() or maybe
>> even remove it altogether.  It would be nice to have the complete
>> "lspci -vv" and dmesg log archived for future reference, since this
>> quirk has such a broad reach (matching PCI_ANY_ID) and it has a long
>> and ugly history already.
> I've been thinking about this a bit and it seems to me like the
> intention of the quirk is to make sure that all devices have their HT
> MSI mapping capabilities disabled if the system doesn't support HT.
> As you said, the fact that a host bridge may not be present isn't an
> error, however, it also means that we have to assume that HT is not
> supported in such cases and make sure the HT MSI mapping capability gets
> disabled for all devices.
>
> The following patch tries to address this and gets rid of the warning on
> Tegra systems.
>
> Thoughts?
>
> Thierry
> --- >8 ---
> From 69fb3b269cc852964385436694d79765d5c1cab3 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Tue, 16 Apr 2019 13:27:53 +0200
> Subject: [PATCH] PCI: Be less noisy if no HT host bridge exists
>
> Embedded systems will typically not expose a host bridge's configuration
> space, so such setups must be assumed not to support HyperTransport, and
> consequently the HT MSI mapping capability should be disabled for all
> devices.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/quirks.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f9cd4d432e05..705891c88073 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2792,24 +2792,28 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
>  	 */
>  	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
>  						  PCI_DEVFN(0, 0));
> -	if (host_bridge == NULL) {
> -		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
> -		return;
> -	}
> -
> -	pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
> -	if (pos != 0) {
> -		/* Host bridge is to HT */
> -		if (found == 1) {
> -			/* it is not enabled, try to enable it */
> -			if (all)
> -				ht_enable_msi_mapping(dev);
> -			else
> -				nv_ht_enable_msi_mapping(dev);
> +	if (host_bridge) {
> +		pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
> +		if (pos != 0) {
> +			/* Host bridge is to HT */
> +			if (found == 1) {
> +				/* it is not enabled, try to enable it */
> +				if (all)
> +					ht_enable_msi_mapping(dev);
> +				else
> +					nv_ht_enable_msi_mapping(dev);
> +			}
> +			goto out;
>  		}
> -		goto out;
>  	}
>  
> +	/*
> +	 * Some systems, such as embedded devices, may not expose the host
> +	 * bridge's configuration space. Assume such systems to not support
> +	 * HyperTransport and disable the HT MSI mapping capability for all
> +	 * devices.
> +	 */
> +
>  	/* HT MSI is not enabled */
>  	if (found == 1)
>  		goto out;

I verified this patch on Tegra210.

Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com <mailto:mmaddireddy@nvidia.com>> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com <mailto:mmaddireddy@nvidia.com>>

