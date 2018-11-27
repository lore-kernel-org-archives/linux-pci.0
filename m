Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BBC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0236208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0236208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeK1JWP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:22:15 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42563 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1JWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 04:22:14 -0500
Received: by mail-wr1-f48.google.com with SMTP id q18so24323979wrx.9
        for <linux-pci@vger.kernel.org>; Tue, 27 Nov 2018 14:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tF7VToxMokqo11hFJmZBMVn1UckJVP9IglJL4IAgfoE=;
        b=tOlagXMOwUuTyqVIyf3OuTlgPVRPHKuscPSk/ALBzBFnVR1zeFdC0/hhcAdtvRu+ZF
         b+rWoeCClYM4RPf6PTBVetSXsBk0BAW4oh1G0uRvpU0mw4IW4Bs4QVn8KWHElb2CQ18E
         1OnwfjQnhUe+b1x+tPZwOcPhawRorgMfq11UYQkBVzDJMLKlTkZEaJvfg4+jHCjBqaVD
         uhhDSZBnsnJOkFVyl7cgtImaalkL03YYY7vNDqgmJedWP/mDtVJ4Efs/lPRNFfbTrhsB
         9vZuh4bfYrDkAJGxAdMkNJowvCFXYlJsNe/EG+Uk8OG8LI1PI7UWtS+ELx3d/mQP41y+
         YrvA==
X-Gm-Message-State: AA+aEWYbksenrZrSIrUenBIUsSK31I1YIS14aZQ95Jr7q4oqCPL2vTFw
        KvUDVjBTqAaeesyCntrX90g=
X-Google-Smtp-Source: AFSGD/VK9A0GKoVn8lgC61r4ILKK90Dr//nzjODeFA7yPLt1u5hrDzOfmCSibsgtTvcLjTdGrlFZQA==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr29339075wrt.180.1543357372174;
        Tue, 27 Nov 2018 14:22:52 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id h131sm1078890wmd.17.2018.11.27.14.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:22:51 -0800 (PST)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Roy Shterman <roys@lightbitslabs.com>,
        Ofer Hayut <ofer@lightbitslabs.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Questions about pci_bridge_check_ranges()
Message-ID: <34458c2d-0faf-e9c1-55fd-7ade553a2b45@grimberg.me>
Date:   Tue, 27 Nov 2018 14:22:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

During a rescan process, pci bridge regions capabilities are
re-verified. In particular, prefetchable regions are checked for 64-bit
addressing support. This check is done by reading the base-address
register 4 LSBs.

Then, we "double check" that the bridge support 64-bit prefetchable
addresses. This double-check is done by writing ones to the base-address
buffer (high 32-bit), and check if we read zeros [1].

Questions:
1. Why do we need to "double-check"?
2. What is expected to happen if a memory transaction arrive to this
    port during this process, while its base-address is miss-configured?
    (say, a read-transaction issued by a peer device)

[1] (drivers/pci/setup-bus.c:780):
/* double check if bridge does support 64 bit pref */
if (b_res[2].flags & IORESOURCE_MEM_64) {
	u32 mem_base_hi, tmp;
	pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
				 &mem_base_hi);
	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
			       0xffffffff);
	pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp)
	if (!tmp)
		b_res[2].flags &= ~IORESOURCE_MEM_64;
	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
			       mem_base_hi);
}

Cheers,
Sagi.
