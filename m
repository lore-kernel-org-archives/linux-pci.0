Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A1C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 23:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7085921783
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 23:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcIXPNLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfB0X7A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:59:00 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41389 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0X7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 18:59:00 -0500
Received: by mail-wr1-f44.google.com with SMTP id n2so19932983wrw.8
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 15:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDELoXOunxdX/wus1Buu0kQqYQnnvPeruUY7HNPLHVo=;
        b=tcIXPNLnxkqpPyIw7oLqKvT30Y5/phZtzOu2/b5w0fd4kCkY/JIQRCtLdrc0OyoHcY
         DeXXplvywO3yA0bltqYtX8sgo6WiiDlg1a1eL6cJZNIDxWv/8SqZDXTWaxy+r4w+xBZI
         hY4zEK0KP57bwWFirdYM4eTZL8aQufV1s2iMWSIZ/vMWM5Pn4Pq7ymaOpwA81BtcWGfG
         nBxQtaTyk22tbqh+YuhbxPejfM98kkDaIcSwHLTDmJRTDy8PGkLmPjYTr+Jov/oGTpl3
         2cCRjczGPfMMy4YVM1MPtJ5PCC+5U/hSFGkGPX3IOxsXwA2QVZJpq+gvpWie9ruNrNNB
         oIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDELoXOunxdX/wus1Buu0kQqYQnnvPeruUY7HNPLHVo=;
        b=C1Y+wTr6Mpjj15tYXqGk+cYtyQXlNQ542lJG+8+jToEDvRh8oFssGVdyk3B64w7mQW
         8R3fli5pknfYA4Ci2EvKWmNBOXohIjnjyDzqmAk18aadle+uQmPYDnZ9qyC6iI0uo0OY
         37ZV1VDqHWc9IYjIfz1vwkrP4+7VU3NAe1M41B4S+W+An5Tj4zPl3yBzzx48mU6g9gER
         joNO4shWV2oLyyz76OJNLjEhM12mnUYg1ZPeXiXF2eK7Iog8OXrqyIrGisceJwn5Xf05
         wpE05YJtKFG6e+UlCtrJ/QCCpbybEpMrqAkqCBmA9gvIAUjqQow4xcNkVXRfIHwHRfWo
         VyHg==
X-Gm-Message-State: APjAAAVDtYJdkBzxDYFOKVuDMPThl8aAi7kuNWitteJgZ5kZV8siqbvs
        nKaDzoMA0sKNbA2gNDEmh/orrpjr
X-Google-Smtp-Source: APXvYqz2SnKe4bf25VQNVHqapJA4jcNPrZRgp1fX8z6ZkyouJKxc2GEjqb3RbjAuKKkp/p25xSxX1w==
X-Received: by 2002:adf:b591:: with SMTP id c17mr4381329wre.195.1551311938701;
        Wed, 27 Feb 2019 15:58:58 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:7597:929b:df9d:5281? (p200300EA8BF1E2007597929BDF9D5281.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:7597:929b:df9d:5281])
        by smtp.googlemail.com with ESMTPSA id d24sm40435845wrb.47.2019.02.27.15.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:58:57 -0800 (PST)
Subject: Re: Disabling ASPM L1 sub-states selectively from drivers?
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <4d8bf501-e367-917d-c808-d1938edaf007@gmail.com>
 <CAErSpo6h27cSn3aQuH_WPUZ_tGMc4UsLhSo3oRyZ23U5rGb59Q@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <eb125be0-e3c8-750a-fa75-cb8dbf374b62@gmail.com>
Date:   Thu, 28 Feb 2019 00:58:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo6h27cSn3aQuH_WPUZ_tGMc4UsLhSo3oRyZ23U5rGb59Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26.02.2019 23:41, Bjorn Helgaas wrote:
> Hi Heiner,
> 
> On Fri, Feb 22, 2019 at 12:16 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> I face the issue that a PCIe network chip misses RX packets if ASPM L1
>> sub-states are enabled. It seems that the RX FIFO is too small to buffer
>> all incoming packets during ASPM exit latency.
>>
>> So far pci_disable_link_state() only allows to disable L1 completely.
>> Would it make sense to extend this function to allow disabling
>> L1 sub-states selectively? Looking at pcie_config_aspm_link() this
>> seems to be possible.
> 
> We could certainly explore the option of selectively disabling L1 substates.
> 
> But before we do that, let's look at a couple things, because there
> are some Linux issues in that area, and it's possible we could make a
> generic fix that wouldn't require disabling the substates completely.
> 
> One problem is the ASPM L1.2 state depends on LTR information, and we
> don't support LTR correctly.  There are a couple patches in -next to
> fix some problems, but we still don't handle cases where the BIOS
> doesn't program the LTR latencies and the LTR_L1.2_Threshold.
> 
> Can you open a report at bugzilla.kernel.org and attach the complete
> dmesg log (booted with "pci=earlydump") and the "sudo lspci -vvvxx"
> output?
> 
I have no system where I can reproduce the issue, it was reported
by a user:  https://bugzilla.redhat.com/show_bug.cgi?id=1671958
In comments 61 and 65 you find the lspci -vv output for the network
chip.

> Have you figured out which L1 substate specifically causes problems?
> If not, maybe we can use setpci to fiddle with things manually and
> narrow it down.
> 
So far all I can say is that with ASPM disabled completely the issue
doesn't occur. I'd have to see how to disable L1.2 only with setpci
and then let the user test.

> Bjorn
> 
Heiner
