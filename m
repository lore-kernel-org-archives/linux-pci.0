Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F1C10F11
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 00:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EBD20685
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3givbMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfDWAGB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:06:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44897 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfDWAGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2019 20:06:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id d24so8479507otl.11;
        Mon, 22 Apr 2019 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PINKDV7/Qi7ml3Vv+IO0r6F67wCGpztVZmzZuYfO/mc=;
        b=m3givbMczweIf3I3tP6Lf/htRkwCR83LIWVOGymEhE+3Ackz9qa5d7ZvPP+3LLvubW
         PLMdjJPYQraSCsGGGr7QDsUt63vjgV+SYI7XQsY2nUEVYIKK0lxjEvtgnxvnjRe13Jbs
         ChUKa52Tu5cwnvlLdJdKLlwZ7ZfYqMVNyFsJikpk5Wqma09ooWnAjgr9xKXBZ/Y6Tmu8
         Xp0/4L+DZQ/MGTnbLWAuksWiFHBi1akwWSAYN70k3i/501de3eJVLtp3+OnIXVnfcIqI
         CBsGSVWHsGONBFXhsJ1i30Mp0dTZt0lmnacQEq9jbcVg8ki6MwH5pXvvwrd+0+BD1QCg
         JiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PINKDV7/Qi7ml3Vv+IO0r6F67wCGpztVZmzZuYfO/mc=;
        b=DpUq6xYgYWEVpXHmvR9i5c0xCxG21TAJWIdI04VK/IqmF68eeB3g81wl6UxsQ4QAen
         emdNlYyHqNGVCFCUX3OWYHm8/1ruT0fDEByTpl4mTWQ/5F/kXeiUizQQJLK7ASX6dIbr
         4HEC/aeqY2H9ItihqAA0g5T1GbY+LGpp2BS35SlMixVCMN/YX7A6aAcYa8I1acKVyrFL
         o9OqBU1zkTChUhjTkFIaNROeuH9U4yXFccd+pnMxj5c4TZ7C3bBs29wEE+t6vjfSSsmJ
         wbwPddjkocoJiYPLHqoNsxbgQdMmPcD4rb/x5AAWFADAT+LuZOn5KRUqc7PcxNpuAu4k
         kPvg==
X-Gm-Message-State: APjAAAX2lyLEXq+o+/zAcu9hre0agy3FxyGyeKe7kz1Av7xDf/pjkTvH
        cNzlprUWlErYN9Hecgjy3+0SIYrcWFo=
X-Google-Smtp-Source: APXvYqyvhiO42OSS+LzzznuXR0HWsaLa3TlPpc9rpXT0n+4LjWetdLFwgMgkWNfghNUfC3/jiCWMrA==
X-Received: by 2002:a9d:5d03:: with SMTP id b3mr12774321oti.268.1555977960054;
        Mon, 22 Apr 2019 17:06:00 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id u22sm5712272otk.49.2019.04.22.17.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 17:05:59 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
To:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
Date:   Mon, 22 Apr 2019 19:05:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155597243666.19387.1205950870601742062.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/22/19 5:43 PM, Alex Williamson wrote:
> [  329.725607] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> GT/s x16 link)
> [  708.151488] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> GT/s x16 link)
> [  718.262959] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> GT/s x16 link)
> [ 1138.124932] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> GT/s x16 link)
> 
> What is the value of this nagging?

Good! The bandwidth notification service is working as intended. If this 
bothers you, you can unbind the device from the bandwidth notification 
driver:

echo 0000:07:00.0:pcie010 |
sudo tee /sys/bus/pci_express/drivers/pcie_bw_notification/unbind



> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 7d04f9d087a6..1b330129089f 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -55,7 +55,8 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>   	 * 7.8.2, 7.10.10, 7.31.2.
>   	 */
>   
> -	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> +	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> +		    PCIE_PORT_SERVICE_BWNOTIF)) {
>   		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
>   		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
>   		nvec = *pme + 1;

Good catch!
