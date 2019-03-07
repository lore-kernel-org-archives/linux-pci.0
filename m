Return-Path: <SRS0=a/OH=RK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E8C10F03
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 22:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F63F20675
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 22:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBPCqw9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCGWtj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:49:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42081 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGWtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2019 17:49:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so19333379wrg.9;
        Thu, 07 Mar 2019 14:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Q3kgEMy4xtnypAW5OOltDfgrxI3AyRh838JPrtjCT4=;
        b=EBPCqw9LYtzJkG52jsz5bN7PEuqkDSQJVPgjkK/iTjOrV13r24u+szm3Enp6xULygs
         xbKz05s95S32xBVguITevmg2zCLXcsl4Byn1yIXtg9QQhkWoj3Z8NaehdOkvqTFWS5nc
         d0wdxwSt1XJ/xtX3fZhOQzeIOAH41fJ31VXsjIEPRl+LErk1tSkex4H5+Odtlby6E8fa
         lQGS1ADCwVrhrGh46/Y0On4D7tfmWxUTJ6TrlpnmdCdAjYJtTuiS4lknU3vyVvj40pLX
         +zFlrYkMqOUdaz9FNU+RQVJ44AWC4jgBX89z36mVlsZ5PIRra+vwq/HJwAK/RaYiMqfv
         k4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Q3kgEMy4xtnypAW5OOltDfgrxI3AyRh838JPrtjCT4=;
        b=JuFLMhZkSMAJSQBf65BVauBipq41UX5Tt20m1QDz4hGwd4Wd4fkYDlfhewlNNpf3C/
         Ds/456e07Pu9qVmSi92XMrWwjaqNS8TV9PeeMCmg78iQtt/RbrzvcuniN1358QR6T4fI
         bAn6q9HA991xQdZXIdeHDy+WylA9lCFeWQZQmpw1fMR0fd8nhBIFwgRoElZQoQpSAxhT
         HFhRn/DIUjF5QuVv8bm3fifxr8zTuKvPqqpjwJt0XuMaj7wRtXf0+EMQ6V70xyk5LgVL
         L56imtsUBxrkYAvTSd9xE6NjtrpVaE2vSGZTjujkteTeFkqqtZeR7CxvajFptYCIPv83
         yyUA==
X-Gm-Message-State: APjAAAV3fXNKf6PVsPfW7Zs9Idh7HR7tA2Nb21+J+RYkzIlKNJyHj6Y7
        UM4q3mi1u30pTcwPH3r+ZuYDrEZJ
X-Google-Smtp-Source: APXvYqyZ7eupaQIfCPQfv2ZPPgCt3jeRTa3m8iO3QlSWdZK5vvZIr91CpvoJ7J2jIxyCnazwnKxFpA==
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr8117301wrx.102.1551998976303;
        Thu, 07 Mar 2019 14:49:36 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id z129sm8297097wmc.33.2019.03.07.14.49.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:49:35 -0800 (PST)
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
        linux-renesas-soc@vger.kernel.org
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190307205013.GA208051@google.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ae3659b1-5355-e6f3-16ef-7b458383a1f6@gmail.com>
Date:   Thu, 7 Mar 2019 23:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190307205013.GA208051@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/7/19 9:50 PM, Bjorn Helgaas wrote:
> On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>
>> Reestablish the PCIe link very early in the resume process in case it
>> went down to prevent PCI accesses from hanging the bus. Such accesses
>> can happen early in the PCI resume process, in the resume_noirq, thus
>> the link must be reestablished in the resume_noirq callback of the
>> driver.
>>
>> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: - Use BIT() macro for (1 << n)
>>     - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
>>       add extra changes to this function anymore
>>     - Make resume_noirq return early and clean up parenthesis therein
>> ---
>>  drivers/pci/controller/pcie-rcar.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
>> index c8febb009454..b8f8fb3bc640 100644
>> --- a/drivers/pci/controller/pcie-rcar.c
>> +++ b/drivers/pci/controller/pcie-rcar.c
>> @@ -46,6 +46,7 @@
>>  
>>  /* Transfer control */
>>  #define PCIETCTLR		0x02000
>> +#define  DL_DOWN		BIT(3)
>>  #define  CFINIT			1
> 
> I saw discussion after the V1 patch about using BIT() and making
> similar constants also use BIT() for consistency.  That makes sense to
> me, and I think the best way would be:
> 
>   1) in *this* patch, use "#define DL_DOWN 8"
>   2) in a followup patch, convert them all to BIT()
> 
> That way each revision of pcie-rcar.c is self-consistent.

But the BIT() macros are already cleaned , see commit
0ee40820989b330e24926d82953ffb9e1c7a8425

    PCI: rcar: Clean up the macros

>>  #define PCIETSTR		0x02004
>>  #define  DATA_LINK_ACTIVE	1
>> @@ -1130,6 +1131,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>  	pcie = pci_host_bridge_priv(bridge);
>>  
>>  	pcie->dev = dev;
>> +	platform_set_drvdata(pdev, pcie);
>>  
>>  	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
>>  	if (err)
>> @@ -1221,10 +1223,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>  	return err;
>>  }
>>  
>> +static int rcar_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
>> +
>> +	if (rcar_pci_read_reg(pcie, PMSR) &&
>> +	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
>> +		return 0;
>> +
>> +	/* Re-establish the PCIe link */
>> +	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
>> +	return rcar_pcie_wait_for_dl(pcie);
>> +}
>> +
>> +static const struct dev_pm_ops rcar_pcie_pm_ops = {
>> +	.resume_noirq = rcar_pcie_resume_noirq,
>> +};
> 
> I think there's the beginning of a convention to use #ifdef
> CONFIG_PM_SLEEP around the ops themselves [1].  Otherwise I think
> we'll get a warning about unused code when CONFIG_PM_SLEEP is unset.

Only if I used SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() , but I set the
resume_noirq directly.

>>  static struct platform_driver rcar_pcie_driver = {
>>  	.driver = {
>>  		.name = "rcar-pcie",
>>  		.of_match_table = rcar_pcie_of_match,
>> +		.pm = &rcar_pcie_pm_ops,
>>  		.suppress_bind_attrs = true,
>>  	},
>>  	.probe = rcar_pcie_probe,
>> -- 
>> 2.19.2
>>
> 
> [1] https://lore.kernel.org/linux-pci/20180531042020.GQ39853@bhelgaas-glaptop.roam.corp.google.com
> 


-- 
Best regards,
Marek Vasut
