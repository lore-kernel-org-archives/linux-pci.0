Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9DC07E99
	for <linux-pci@archiver.kernel.org>; Thu,  8 Jul 2021 20:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CB361876
	for <linux-pci@archiver.kernel.org>; Thu,  8 Jul 2021 20:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhGHUgp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Jul 2021 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHUgp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 16:36:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB9C061574;
        Thu,  8 Jul 2021 13:34:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hc16so11920636ejc.12;
        Thu, 08 Jul 2021 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kuf9B8hhb/FsSxugunw9yeVw6DPaLs/0chQ2Iw5Fnu8=;
        b=OXMVHq0wQI5muGrdtpQIcL1Hj+0R84U0isVeiY+D3BzCiGRuG/sHmbjU47mWQ7Rlps
         3C0VGA41Advyo4uajWgmKXwIL+4m/cxD8yFoLg/dEOqIbcl4l+10TZjVywS1Ru+kCils
         3unZX40jmG/3F0sqVdRq56PFVPIfsJhjoBBA+caGzwikfzDCA5DHj+QyWSpaq9UBbZnp
         nrLwsPQqU1ESKMfnyIdcrThzt/ux7OUbGidxR6kXp/FQOISmF95okv7Frf1O2o3UHIU8
         txIeb1Mi/aLytFoIbaWXBjtWBsMqqtx+eI3Tt1tMDwTM3IpKGBd8c095Fo3GO4yvXGJw
         AOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kuf9B8hhb/FsSxugunw9yeVw6DPaLs/0chQ2Iw5Fnu8=;
        b=ikzfYPmuP7kljP6cmYK3yyIVIBMABhL7G3++tmcNKLXth2rwUEEXU35IbghXMsnh+4
         ccvYkzEQijNccRdov2XirKubUUOdQBDSUIPtyV29oHzSE0sk18kzsl5diyuJu3FJKbiZ
         fcwGpH6lYf09jgjEbm4gQSkqB3n38zoQqfFT6kCM8ueEWcD0ruaNA1zloOpBtX/vL+7G
         F/lza7lLTEIBVdt1zqSaGQDCe7pjFyJnnHdGTqO+LSloYDi/DIHfCf2/SBksvMFOFZZq
         Mu67v/ikbP42KM7zz0jGpEOG5G/ywtL3zeI41zXFScJih6CtJ0nhOeBCFRphmnKA1Azi
         5Abw==
X-Gm-Message-State: AOAM533QtOHfvywRQLU8we0391yvasSgCYY5r4a1ynSk07XGwFc2mv6p
        i80r9fFNHf3gV+46Ba14EduKMStMQJI=
X-Google-Smtp-Source: ABdhPJxFAGPPZ24pMNBdbogAaDpKbM2C1ew7A0Wp61lHGHAWa8Wr2+wYHY6CVE3mWgjZoqenP0ZBwg==
X-Received: by 2002:a17:906:f285:: with SMTP id gu5mr33389617ejb.226.1625776440290;
        Thu, 08 Jul 2021 13:34:00 -0700 (PDT)
Received: from [10.18.0.15] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id o14sm1820146edw.36.2021.07.08.13.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 13:33:59 -0700 (PDT)
Subject: Re: [PATCH][RFT] PCI: Use pci_update_current_state() in
 pci_enable_device_flags()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <4327888.LvFx2qVVIh@kreacher>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5327028b-6e0b-e83c-b147-da083a23634c@gmail.com>
Date:   Thu, 8 Jul 2021 22:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4327888.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/8/21 3:25 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Updating the current_state field of struct pci_dev the way it is done
> in pci_enable_device_flags() before calling do_pci_enable_device() may
> not work.  For example, if the given PCI device depends on an ACPI
> power resource whose _STA method initially returns 0 ("off"), but the
> config space of the PCI device is accessible and the power state
> retrieved from the PCI_PM_CTRL register is D0, the current_state
> field in the struct pci_dev representing that device will get out of
> sync with the power.state of its ACPI companion object and that will
> lead to power management issues going forward.
> 
> To avoid such issues, make pci_enable_device_flags() call
> pci_update_current_state() which takes ACPI device power management
> into account, if present, to retrieve the current power state of the
> device.
> 
> Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Hi Maximilian,
> 
> Because commit 4514d991d992 ("PCI: PM: Do not read power state in
> pci_enable_device_flags()"), the issue addressed by it is back, so
> we need an alternative way to address it.
> 
> Can you please check if this patch makes that issue go away?

Hi,

just tested this on v5.13 and it works, thanks! Feel free to add

Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max
