Return-Path: <SRS0=l472=MF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF05C433F4
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948842086B
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 06:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xiw4tcBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948842086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeIWMQs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:16:48 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42331 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeIWMQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Sep 2018 08:16:48 -0400
Received: by mail-ot1-f51.google.com with SMTP id h26-v6so16922402otl.9
        for <linux-pci@vger.kernel.org>; Sat, 22 Sep 2018 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fGMZisMSU0oco4B/fQ3Dg0oB9MsTWPF8Oxorw6sa2hc=;
        b=Xiw4tcBwY/CgGsieXcImtcImbhxwDrXUuNztO924yObeNy1EVYQzrLBz+bGvE5lXWB
         piDlEReWFXK9cPZEXj8v1HYDXHu0VdTk1JrpdjkSbT+xBCh3aKkcr0i7oidQmXP1ArbE
         tsrrLbxVEb3tKnVtdFhGUoxcnrOiMuGug4B/r187zpbefBVO5sdzysr8wdbTu5x+Ie4f
         lVYc6VAydJP0Shc0lRf/Su5WMzsAo+o/lnM4O6C8kTcPq7dLX97Xq5ZCXmxxtzrcT/oV
         Zo5AivDYdfM4sFwPj1OEjDRH56EGTY9w2u7KrJf+yb1UjY+fMH49e5U3ZgC2+Cl4BHOC
         9cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fGMZisMSU0oco4B/fQ3Dg0oB9MsTWPF8Oxorw6sa2hc=;
        b=YQ8iRrwBybXxP4Mfb60a946CHk0Cp++Wt5h3T1SZNlsGuyZc0aqKKO3PF4rTk7B625
         IS179jiKajJq3saoQZIqzk+XIotggPyYIoiD4QFpaEoBHaSQT2isklELDhcwc13BeNBW
         iuVc+kzsIwikB2/UTl4eTqGCt9qbkfc7M1EC3edXRM3Dlu0jRjURD3qwyYbWpCPUPjxt
         sd6w56cx4wLCpq+hmSPBhhUG5jzB+KB+PNHs/DVbRVC79K/9o+ltsw7AhN3JPTlezxWr
         Pd8G7CUR/pCfzC0IBDaxk3YRin8OtklioU+GlN01HlVphaMLg9Mn3LvSmHpEKhFwMRJy
         ARFg==
X-Gm-Message-State: ABuFfoiqF8TAd/uhY4Fni49AuI9wQOAym7zZDro40scZBEylCWI6VgnC
        zBXsAE+oQYuM7bwgZI6K9+6gmqP3O0u+nj//6Wo=
X-Google-Smtp-Source: ACcGV630rkyUWkV0Sh+NDjjtdZ/TPMNx7wLqxBvJ+GIIW1gAWoeaCy98kjfRDg2xkaHrzdxTkPMlCBwVFP6/WUgILv4=
X-Received: by 2002:a9d:5cc3:: with SMTP id r3-v6mr3105936oti.301.1537683629107;
 Sat, 22 Sep 2018 23:20:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:521f:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 23:20:28
 -0700 (PDT)
In-Reply-To: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
References: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 23 Sep 2018 08:20:28 +0200
Message-ID: <CAMhs-H-CM3bb9fg2eX6G_534bmuQYcoFa+pJSuNeArXLSXO4=Q@mail.gmail.com>
Subject: Re: mt7621/mt7628 PCIe linux driver
To:     Petr Cvek <petrcvekcz@gmail.com>
Cc:     ryder.lee@mediatek.com, blogic@openwrt.org,
        linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Petr,

On Sat, Sep 22, 2018 at 11:06 PM, Petr Cvek <petrcvekcz@gmail.com> wrote:
> Hello,
>
> I'm trying to play with mt7628 PCIe (and it's old driver mt7620), but
> the system keeps freezing. It is probably because of bus master access
> of my PCIe cards but I don't see any memory access controls for PCIe <->
> RAM in the datasheet. The same problem is with MSI. It seems the root
> complex supports MSI (it has an MSI capability field), but there isn't
> any mention in the MT7628 datasheet too. As it seems the MT7628 PCIe is
> based on MT7621 PCIe, I went for an MT7621 datasheet, but sadly in the
> datasheet the PCIe section is missing completely.

AFAIK, MT7628 should be covered with mt7620 driver. The source code is in
arch/mips/pci/pci-mt7620.c. For initialization in really depends on
the "ralink_soc"
variable exported in arch/mips/ralink/prom.c.

You have to figure out why and where is really freezing. Does a clean kernel
boots and success on setting up PCI? A 'dmesg' would be helpful.

>
> Does anybody have a working MT7621/28 bus master setup or a more
> completed datasheet? I would like to get some information for fixing the
> mt7620 PCIe driver. It is possible the MSI/bus master is controlled by
> the undocumented bridge registers (in the pci-mt7621 they controls the
> manual oscillator settings, I've found a link quality register at
> 0x101490c4) or in a PCI config space of the root complex (around 0x700
> offset). If you have a working SoC with MSI/bus mastering (= mem access
> from card), can you send me the dump of there spaces?

The datasheet for the mt7620 contains information about PCI registers.
Linux initializes the
pci topology but master bit of command registers for endpoints is
disabled and is mission of final
card driver to enable it in order to allow memory accessing to the card.

Hope this helps.

>
> Thanks
>
> best regards,
> Petr

Best regards,
    Sergio Paracuellos
