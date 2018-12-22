Return-Path: <SRS0=4uNc=O7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFDC43387
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB6220578
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500853;
	bh=cFY54z5gtflL2lN3u8LZOqTn0eShLB8Ka9p5zQ9+mc8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=kbh2Iq8+WjVNr3u+Q3ET1Gb43gQ4WURg/C+N6wOf1WHLSyFcRYocNCVwOYocfBO4f
	 3mOmWoZiKre/jdJaYSKE+rCGJK0TRKCu1gIAPBPdA3O1NU1EXDq1hiYZYyReJ7TVAy
	 /N2eYU6FZk2PnZgQJr0wcrBPc2mkwKgTN0SrS+eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391676AbeLVRrQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391572AbeLVRrQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:16 -0500
Received: from [192.168.43.85] (unknown [5.92.228.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A912F21929;
        Sat, 22 Dec 2018 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545467515;
        bh=cFY54z5gtflL2lN3u8LZOqTn0eShLB8Ka9p5zQ9+mc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WpqrNf7PE5stKXCg17cwvDo3X8cMKERhTxkLvaLxXhkooJSxnDT/vLGdyGIFcfRuU
         N2VTfScT9dHiE/NTCmEmLxr3Wd6BuB1Rs0ij7UXrGj+S+YJ8KHwqLf+6gLXkCe2Tj7
         JVvzLu/zJVakFXJQm4wRe0r3YHC/gx+1UUSa4zhY=
Subject: Re: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-7-okaya@kernel.org>
 <20181222080317.qicyihyauia6n63w@wunner.de>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <cd2719f6-9bf2-b3c0-dfef-0e28d43e73a1@kernel.org>
Date:   Sat, 22 Dec 2018 09:31:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181222080317.qicyihyauia6n63w@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/22/2018 9:03 AM, Lukas Wunner wrote:
> On Sat, Dec 22, 2018 at 12:14:47AM +0000, Sinan Kaya wrote:
>> Code is scanning PCI bus to find out if it is switchable or not. If
>> CONFIG_PCI is not set, assume unswitchable.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   drivers/platform/x86/apple-gmux.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index fd2ffebc868f..b552b54bf58b 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -742,8 +742,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>>   	 * If Thunderbolt is present, the external DP port is not fully
>>   	 * switchable. Force its AUX channel to the discrete GPU.
>>   	 */
>> +#ifdef CONFIG_PCI
>>   	gmux_data->external_switchable =
>>   		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
>> +#else
>> +	gmux_data->external_switchable = false;
>> +#endif
>>   	if (!gmux_data->external_switchable)
>>   		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
> 
> This driver is only used on 2008+ MacBook Pros and the 2013+ Mac Pro,
> all of which have PCI and are pretty much unusable with CONFIG_PCI=n.
> 
> So it is okay to just add "depends on PCI" for this driver, as you did
> with other drivers, and I think that's preferrable to an #ifdef.
> 
> You can also drop the "platform/x86: " prefix from the subject if you
> like, all previous commits to this driver just use "apple-gmux: ".
> 
> If you are okay with these changes, feel free to add my Reviewed-by
> when respinning.
> 

This is how I updated this patch:

commit 867d96cb6b75124b7ce11014425b8c57a8350e61 (HEAD)
Author: Sinan Kaya <okaya@kernel.org>
Date:   Fri Dec 21 23:24:13 2018 +0000

     apple-gmux: Make PCI dependency explicit

     This driver depends on the PCI infrastructure but the dependency has not
     been explicitly called out.

     Signed-off-by: Sinan Kaya <okaya@kernel.org>
     Reviewed-by: Lukas Wunner <lukas@wunner.de>

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..86b75fa55dbc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
  config APPLE_GMUX
         tristate "Apple Gmux Driver"
         depends on ACPI
+       depends on PCI
         depends on PNP
         depends on BACKLIGHT_CLASS_DEVICE
         depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE


> Thanks,
> 
> Lukas
> 

