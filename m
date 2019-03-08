Return-Path: <SRS0=hZ+Q=RL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F6C4360F
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA9720652
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsIjsy3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCHVfz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:35:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCHVfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2019 16:35:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id l12so6386753wrp.6;
        Fri, 08 Mar 2019 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5C3D3TL302UCHlwuSMxKMVI2iDJKadIYX/hwK10JitU=;
        b=OsIjsy3Ey98u8dgHFwFPtIgsL5PYc4w09EHib9iZmAo/PV1WQU47TO3J53tP7cT4vO
         ZQWfz2wR7jyfj9wjQVE7sALehqM4KyzVUDRNM2/v8sUxmPGPldKCmaUZiAS1IVNfMj7h
         zDk/16UNevraK7qk7TymExIzx6qtkdSlCVrcIRAD5jOwtFzQStLpYiRBm4YkHGWRqyk9
         nSaIG8TPAmOxs4BhIQIyL7AUxwZkOA+Rcb44bJErGus52ojl9mWx4Ug5qNZ4Lhov3FTL
         3OwWUiFDizu+geEarz4KyrNYyPtcWkEKqZ9acUuidASnoU9s7etoE8kAhqlI6xV50QqD
         a1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5C3D3TL302UCHlwuSMxKMVI2iDJKadIYX/hwK10JitU=;
        b=fXPN6o5r4n2sISe9oaiIQph8NBRyVZbKZEQhgxodt/cxG+2I8B9lUsDwBgPqoOf6Rh
         oey21RI+pSwFd/J2eIsLByvh5SdFds4aRQv4FGkOB/oH3sZzLFFEgDPFagAymdDliFgL
         WNTK1Oq730ElKC2fCnG7/UtLDRQ4nOkPXj6aBvMagyzkq9CBkHuN8ZXEIb84EmKKRyQx
         Ke8dA2dYrYW/InFmq0m3HDgEPwzeY11Or970aEp4YS+Tc+SvMHxOKmwR/siJfgQpf4dc
         4cM5llecRSzJk/TzDRVi6j+sGUopKXGm2cuBZfQq1WVWWQsh41f82ZpPMOO9ADmNqLWz
         LHVA==
X-Gm-Message-State: APjAAAXR/iMyRoHB4OSNExym2Mk6Wom/GUoPUrKVSpbUfhaIpPe1yIDW
        E1+AOwaZEf0VJTxdEiLhMN8eD4CI
X-Google-Smtp-Source: APXvYqyY46m3hKrkKfdednQzTiVKgnWelCAhJcLhBJEj/IhCBMja9d7g0QRbc9btprF/Px6z1Y6LXg==
X-Received: by 2002:a5d:5511:: with SMTP id b17mr4140560wrv.277.1552080952015;
        Fri, 08 Mar 2019 13:35:52 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id v67sm16488047wmb.9.2019.03.08.13.35.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 13:35:50 -0800 (PST)
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190307205013.GA208051@google.com>
 <ae3659b1-5355-e6f3-16ef-7b458383a1f6@gmail.com>
 <20190308171738.GB214730@google.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <77780c8d-2621-e31f-1cd5-793b4ec0a9f2@gmail.com>
Date:   Fri, 8 Mar 2019 22:35:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190308171738.GB214730@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/8/19 6:17 PM, Bjorn Helgaas wrote:
> [+cc linux-pm, Rafael for SET_NOIRQ_SYSTEM_SLEEP_PM_OPS question at the end]
> 
> On Thu, Mar 07, 2019 at 11:49:34PM +0100, Marek Vasut wrote:
>> On 3/7/19 9:50 PM, Bjorn Helgaas wrote:
>>> On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
>>>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>>>
>>>> Reestablish the PCIe link very early in the resume process in case it
>>>> went down to prevent PCI accesses from hanging the bus. Such accesses
>>>> can happen early in the PCI resume process, in the resume_noirq, thus
>>>> the link must be reestablished in the resume_noirq callback of the
>>>> driver.
>>>>
>>>> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>> ---
>>>> V2: - Use BIT() macro for (1 << n)
>>>>     - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
>>>>       add extra changes to this function anymore
>>>>     - Make resume_noirq return early and clean up parenthesis therein
>>>> ---
>>>>  drivers/pci/controller/pcie-rcar.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
>>>> index c8febb009454..b8f8fb3bc640 100644
>>>> --- a/drivers/pci/controller/pcie-rcar.c
>>>> +++ b/drivers/pci/controller/pcie-rcar.c
>>>> @@ -46,6 +46,7 @@
>>>>  
>>>>  /* Transfer control */
>>>>  #define PCIETCTLR		0x02000
>>>> +#define  DL_DOWN		BIT(3)
>>>>  #define  CFINIT			1
>>>
>>> I saw discussion after the V1 patch about using BIT() and making
>>> similar constants also use BIT() for consistency.  That makes sense to
>>> me, and I think the best way would be:
>>>
>>>   1) in *this* patch, use "#define DL_DOWN 8"
>>>   2) in a followup patch, convert them all to BIT()
>>>
>>> That way each revision of pcie-rcar.c is self-consistent.
>>
>> But the BIT() macros are already cleaned , see commit
>> 0ee40820989b330e24926d82953ffb9e1c7a8425
>>
>>     PCI: rcar: Clean up the macros
> 
> Hmmm.  Maybe I'm missing something, but it looks like 0ee40820989b
> didn't touch CFINIT, DATA_LINK_ACTIVE, or MSIFE.  Arguably,
> LINK_SPEED_2_5GTS and LINK_SPEED_5_0GTS could use BIT() also.
> 
> I guess I'm just old-school, but in my personal opinion, BIT() is more
> trouble than it's worth.  I'd rather see a complete bitmask because I
> can easily match it with the typical pictures in a spec, multi-bit
> fields are easy (you don't have to mix BIT() and GENMASK()), it gives
> a hint about the register width, it's easy to match with a hexdump,
> etc, e.g.,
> 
>   #define  DL_DOWN        0x00000008
>   #define  CFINIT         0x00000001
> 
> But I'm not suggesting that you get rid of BIT() in this driver.  I'm
> fine with it as long as it's used consistently.
> 
> BTW, while we're looking at it, I think rcar_pci_read_reg() and
> rcar_pci_write_reg() really should use "u32" instead of "unsigned
> long", since they deal with hardware registers that are explicitly
> 32 bits wide.

OK, I can send those as separate patches.

>>>>  #define PCIETSTR		0x02004
>>>>  #define  DATA_LINK_ACTIVE	1
>>>> @@ -1130,6 +1131,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>>>  	pcie = pci_host_bridge_priv(bridge);
>>>>  
>>>>  	pcie->dev = dev;
>>>> +	platform_set_drvdata(pdev, pcie);
>>>>  
>>>>  	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
>>>>  	if (err)
>>>> @@ -1221,10 +1223,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>>>  	return err;
>>>>  }
>>>>  
>>>> +static int rcar_pcie_resume_noirq(struct device *dev)
>>>> +{
>>>> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
>>>> +
>>>> +	if (rcar_pci_read_reg(pcie, PMSR) &&
>>>> +	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
>>>> +		return 0;
>>>> +
>>>> +	/* Re-establish the PCIe link */
>>>> +	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
>>>> +	return rcar_pcie_wait_for_dl(pcie);
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops rcar_pcie_pm_ops = {
>>>> +	.resume_noirq = rcar_pcie_resume_noirq,
>>>> +};
>>>
>>> I think there's the beginning of a convention to use #ifdef
>>> CONFIG_PM_SLEEP around the ops themselves [1].  Otherwise I think
>>> we'll get a warning about unused code when CONFIG_PM_SLEEP is unset.
>>
>> Only if I used SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() , but I set the
>> resume_noirq directly.
> 
> Fair enough.  I guess in this case if CONFIG_PM_SLEEP is unset, you
> set the pointer, which avoids the "unused function" warning, but we
> just never use that function pointer.
> 
> My intent is to avoid needless differences when possible, so when I
> review things like this I look at how other drivers do things.  It
> looks like all the other controllers use
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() or similar:
> 
>   git grep -A3 "static.*dev_pm_ops" drivers/pci/controller
> 
> In the rcar case you only need the resume_fn, not the suspend_fn, so
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() does a little more than you need and
> you'd have to pass NULL for suspend_fn.  I didn't check them all
> (suspend_noirq, freeze_noirq, poweroff_noirq), but at least for
> suspend_noirq, all users check for NULL before calling through the
> .suspend_noirq() function pointer, so I think that should be safe.
> 
> This *does* raise the question of whether you should be setting
> .thaw_noirq and .restore_noirq in addition to .resume_noirq, as
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() would.  I'm not a PM person, but maybe
> Rafael or others will chime in.

OK, let's wait for the feedback ...

-- 
Best regards,
Marek Vasut
