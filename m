Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9104C433F4
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9621522
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 21:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0FISwDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9621522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeIWDBI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 23:01:08 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55296 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeIWDBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Sep 2018 23:01:08 -0400
Received: by mail-wm1-f54.google.com with SMTP id f21-v6so6141934wmc.5
        for <linux-pci@vger.kernel.org>; Sat, 22 Sep 2018 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ByV8VuyzbH3nkcDVM+0R77Y9G0069Sc6g+ThI8moE88=;
        b=S0FISwDeyLxH5FuWgCFiwvRRs1rtPVlyemvHIRnKeRg42g91+0+OSrsuYgSUpmzZyT
         dCs9/vRfod9P+/0AlbthH176z/cgOg5ZXWrlgW+3EAP9d85iO9PvosRBewgLfTj1EHcZ
         pgG7F+o5Qb7rDoHRnab4wR97Uesj/JA5yxdJCaGFR2xvTfRinhkhW7Fv+U5o+eHthGyb
         n/0MMlFe2PexRSiT13UPEbCEE2dyq0WfaNiynlUewtD+anSLBK5+tjnLTlh7WwQSgCKn
         JT3mWSlBMhFSQya9x4iqq4xd38c2mFpT8pVPuYYqxoe9g8399znLr4Ij+nyApMH0noTZ
         sYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ByV8VuyzbH3nkcDVM+0R77Y9G0069Sc6g+ThI8moE88=;
        b=PWhpOVeQ02vSYPGKWVfj7avb7Usdd54KmJS3Zk9jzhR0RrgmG8nvPqEEbtz8rx6pMI
         LX0aCPhxS6BUN1x7rv2LRbu+Zez1yJKPpTMp9JwPdKiKtN9ujfV+Upjy5xKPhEl/Yawu
         NYWst4L1+WhP2n5yjnWW/1+Yic9+TeZvFHmlQsy86HenrxezZClU2FdawIlYkjef8G0U
         zNjm/nafbi4J/jXKkPd96+Ng8U/HOGEcIbwbrarMkqJAtusUobAVmHN5+15zjfOxo+1z
         44R8lsuJKfDbTTOXv04r+TTQMEX2FprCjiL95/X+T3gzgxYw9hsBYGZPp9FZO9/U2bQA
         svRA==
X-Gm-Message-State: APzg51Bgk4mg5EDm82rPcAxxa3AUikRBtojmithdA0z6es+sws3wfdzD
        gQNfePUeCnVh30KvWsubPo60JCwo
X-Google-Smtp-Source: ANB0Vda+m24tHEXwdnNZhIP9RK6qKHcDCKshQNw47a6WSQNGPnbedr6zbO/gy6TlzNWkR7eJeOzCzg==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr2525243wmd.40.1537650369658;
        Sat, 22 Sep 2018 14:06:09 -0700 (PDT)
Received: from kontron.lan (2001-1ae9-0ff1-f191-401f-749d-725f-a2a7.ip6.tmcz.cz. [2001:1ae9:ff1:f191:401f:749d:725f:a2a7])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1617613wrt.0.2018.09.22.14.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 14:06:08 -0700 (PDT)
From:   Petr Cvek <petrcvekcz@gmail.com>
Subject: mt7621/mt7628 PCIe linux driver
To:     ryder.lee@mediatek.com, blogic@openwrt.org,
        sergio.paracuellos@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
Message-ID: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
Date:   Sat, 22 Sep 2018 23:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I'm trying to play with mt7628 PCIe (and it's old driver mt7620), but
the system keeps freezing. It is probably because of bus master access
of my PCIe cards but I don't see any memory access controls for PCIe <->
RAM in the datasheet. The same problem is with MSI. It seems the root
complex supports MSI (it has an MSI capability field), but there isn't
any mention in the MT7628 datasheet too. As it seems the MT7628 PCIe is
based on MT7621 PCIe, I went for an MT7621 datasheet, but sadly in the
datasheet the PCIe section is missing completely.

Does anybody have a working MT7621/28 bus master setup or a more
completed datasheet? I would like to get some information for fixing the
mt7620 PCIe driver. It is possible the MSI/bus master is controlled by
the undocumented bridge registers (in the pci-mt7621 they controls the
manual oscillator settings, I've found a link quality register at
0x101490c4) or in a PCI config space of the root complex (around 0x700
offset). If you have a working SoC with MSI/bus mastering (= mem access
from card), can you send me the dump of there spaces?

Thanks

best regards,
Petr
