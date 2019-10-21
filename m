Return-Path: <SRS0=fcTa=YO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2823ACA9EAF
	for <linux-pci@archiver.kernel.org>; Mon, 21 Oct 2019 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38A02089C
	for <linux-pci@archiver.kernel.org>; Mon, 21 Oct 2019 18:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjrmofze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfJUS7g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:59:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38816 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfJUS7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 14:59:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id d140so7688657oib.5;
        Mon, 21 Oct 2019 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oTI80X6gMyjYQOMp/OT40Ib53Jwx5S7b8ZvaxS8S+Dw=;
        b=hjrmofze+IcSx9OLGssRiOm0Ic0DDjpMQE3Ly0ygDJyMGDliFrYjrSFTpYyi6QI5LB
         /3MktAJbodbaD0+1/g+WcTv0FU6uSysF74B1+gE17JwtePBrspmT+gr1N/z+nBXD5XOm
         e0eHWVtPnVi8c5b6MoIxDJdqfmmse5jSOJmsQ6qQ+pZAHFOJncSdZuw8iFCzXuxb+RyA
         F3n0eO7flDKSRVpAUfCEI+HwMnBQMF9+3yztkM0fS//RgkRi8/qoh7yzIsWhWYvAQtiP
         PR1ekdYoQtyBoOb8a08K0dbThgg2EiuYaW4c0D+WFbR/UgwspcTDIDcBuN8g9OIvNMwh
         DT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oTI80X6gMyjYQOMp/OT40Ib53Jwx5S7b8ZvaxS8S+Dw=;
        b=Oae6oZML6yGHZCkU7fJJicNs5Ws4nBjWEti+Ek184qDZHl/Vb/ppywDDMKjblpjyqS
         UOVGdhakTTq4RHaXEfqEBOu9DN/vJ3+O9ZRQEM11y/4xNGGLdmWklcPsPF7FRNd48Spa
         dLhGFNk4bl8zhkQ1ulz16YAzVJlpnXe26G0FLj/Nwd8RJ4+OTN1rJIu9sP7Wa1MPaiX1
         J5sPCvAHPTH9mGML7YznKBMyX8VqkbJJJJPleagdssL6CVFHUmhxx92GDy20YMDSk8N8
         9ycHoUq8S98y50E+2t2fAeAo+YCe8LRHg1PKYeagqWJhSWIlxQuRKX0dX0KhUCF4uF0+
         sWpw==
X-Gm-Message-State: APjAAAVB1BoZpIzVcNv3Dbxf62vCh2KucK4jW3kK30P6SIubUT7JStZ/
        MX8JAe6N3GOu/MqdLE30texcPdlaQ6V9lKHcTh4=
X-Google-Smtp-Source: APXvYqzbfHlud+FlAXAAcaIr3wj8bignujUbwOwX0dfLtGsI14bJBOaa4keO2vKEACQ+99VSXlB6pzVkeehqh3em8JI=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr20331947oid.62.1571684375103;
 Mon, 21 Oct 2019 11:59:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:648:0:0:0:0:0 with HTTP; Mon, 21 Oct 2019 11:59:34 -0700 (PDT)
In-Reply-To: <20191021184701.GA1823@light.dominikbrodowski.net>
References: <20191020090800.GA2778@light.dominikbrodowski.net>
 <20191021160952.GA229204@google.com> <CAFjuqNg2BjbxsOeOpoo8FQRwatQHeHKhj01hbwNrSHjz9p3vYw@mail.gmail.com>
 <20191021184701.GA1823@light.dominikbrodowski.net>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Tue, 22 Oct 2019 05:59:34 +1100
Message-ID: <CAFjuqNiyS4cd=YEFvn3tLkp5zSPbO2vj8JfHsymUuDyEmLydUA@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Domunik I'll get onto this and report back the results.

On 22/10/2019, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> On Tue, Oct 22, 2019 at 05:17:12AM +1100, Michael . wrote:
>> Thank you Dominik for looking at this for us and passing it on.
>>
>> Good morning Bjorn, thank you also for looking into this for us and
>> thank you for CCing us into this as non of us are on the mailing list.
>> One question how do we apply this patch or is this for Dominik to try?
>
> That's for you and/or other users of this hardware; I cannot test this
> myself, sorry. As to how to apply the patch: you'd need to apply the patch
> for the linux kernel sources, and then build a custom kernel. Some hints on
> that (details depend on the distribtion):
>
> 	https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel
> 	https://wiki.ubuntu.com/KernelTeam/GitKernelBuild
> 	https://wiki.archlinux.org/index.php/Kernels/Arch_Build_System
> 	https://kernelnewbies.org/KernelBuild
>
> Best,
> 	Dominik
>
