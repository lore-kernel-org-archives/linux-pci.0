Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BAC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050A120821
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 08:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lightbitslabs.com header.i=@lightbitslabs.com header.b="QeQl0tDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050A120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeLJIti (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:49:38 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:39392 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIti (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 03:49:38 -0500
Received: by mail-lj1-f172.google.com with SMTP id t9-v6so8831615ljh.6
        for <linux-pci@vger.kernel.org>; Mon, 10 Dec 2018 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightbitslabs.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=haqnnd+S+VHBvMm4Znj2sSq1l8tSLGq5HQHK5rTml7Y=;
        b=QeQl0tDes72JEJugpFT5DxBExEHHzDrkw7wXqh6DRg3ZtbcEDuDG7bDIEzuAP6ddMO
         vFfSQh2vSwHnUX+NB6tSx5397cLpsMoclEk+BmYZUiH6oROc3byDPiNc91xdZYDaAsZa
         5v21emwMmFsavwMt4m+k0X7uTOwqBA7yHfUfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=haqnnd+S+VHBvMm4Znj2sSq1l8tSLGq5HQHK5rTml7Y=;
        b=EuxrDKFuTfHYBHW0rbViAyv8jsvYGaCSbGQvA5IKMO8RLnirhsTqWKpuao74UXnyCl
         jAxqlKhm+JmCofx+k6BdB443L9bYu+YE2dsbOOORP+da06Lrs+IOzOkE9vVFV7WvRUMt
         7AHH6y2OxpxfO0SwnvFXrFzXhLzR1UEO3tq1rapJWcSo1itEgqcjmjcgwb+wk3Q0lo9A
         28aOfj6eaw+X+YXEoTX/sPOM3V7DipbOIrXKSuU1ef8DPxkTCQC1UnmD/a3fzaSHDs6a
         nOh2IssVWnoquCvabRy8cJ7AA8mejrSurR2LeLhlti7UAKZrOjVbUVCCkbYLlB040Utt
         uZ9w==
X-Gm-Message-State: AA+aEWYVKP3BVBDI837Y0v3EVnhSTkRmSYQVM+uFmlOYm9Lm4bMS8A7M
        /2hx+ojAAaZTtnbWFuy+CvyqW+JNS24ZsGXb6S40bQ==
X-Google-Smtp-Source: AFSGD/V69yDrLHABpztLi58fEGIhHl8rV57ECUxiihGo7DP39tG8zRj+KtZkdEjM/skUYx1lDVfm87HdK5SrGU/+Wck=
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr6395979ljj.146.1544431775908;
 Mon, 10 Dec 2018 00:49:35 -0800 (PST)
MIME-Version: 1.0
References: <34458c2d-0faf-e9c1-55fd-7ade553a2b45@grimberg.me> <20181127223901.GD6401@localhost.localdomain>
In-Reply-To: <20181127223901.GD6401@localhost.localdomain>
From:   Ofer Hayut <ofer@lightbitslabs.com>
Date:   Mon, 10 Dec 2018 10:49:25 +0200
Message-ID: <CABykntOoMi4U+byy9pdMcPCmxqE=aZpRqMn4MSz9TT0+bwi5EQ@mail.gmail.com>
Subject: Re: Questions about pci_bridge_check_ranges()
To:     keith.busch@intel.com
Cc:     sagi@grimberg.me, linux-pci@vger.kernel.org,
        Roy Shterman <roys@lightbitslabs.com>, yinghai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks, but I'm not sure that is the case here.
The code[1] check that the high 32bits of the address are read only,
as required by the spec[4].
However, the spec[3] also require the low 4bits of the address
indicate 64-bit addressing support, and the code[2] uses that.
So, I still don't understand why a double-check is required?

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
                b_res[2].flags &=3D ~IORESOURCE_MEM_64;
        pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
                               mem_base_hi);
}

[2] (drivers/pci/setup-bus.c:775):
       if ((pmem & PCI_PREF_RANGE_TYPE_MASK) =3D=3D
            PCI_PREF_RANGE_TYPE_64) {
                b_res[2].flags |=3D IORESOURCE_MEM_64;
                b_res[2].flags |=3D PCI_PREF_RANGE_TYPE_64;
        }
[3] (PCI Express=E2=84=A2 to PCI/PCI-X Bridge spec rev 1.0
Section 5.1.2.9. Prefetchable Memory Base and Prefetchable Memory
Limit Registers (24h and 26h)):
"The bottom 4 bits of both the Prefetchable Memory Base and
Prefetchable Memory Limit registers
are read-only, contain the same value, and encode whether or not the
bridge supports 64-bit
addresses"

[4] (PCI Express=E2=84=A2 to PCI/PCI-X Bridge spec rev 1.0
Section 5.1.2.10. Prefetchable Base Upper 32 Bits and Prefetchable Limit
Upper 32 Bits Registers (28h and 2Ch)):
"If these registers are not implemented, they must be read-only and
return zero when read"

On Wed, 28 Nov 2018 at 00:42, Keith Busch <keith.busch@intel.com> wrote:
>
> On Tue, Nov 27, 2018 at 02:22:48PM -0800, Sagi Grimberg wrote:
> > Hi,
> >
> > During a rescan process, pci bridge regions capabilities are
> > re-verified. In particular, prefetchable regions are checked for 64-bit
> > addressing support. This check is done by reading the base-address
> > register 4 LSBs.
> >
> > Then, we "double check" that the bridge support 64-bit prefetchable
> > addresses. This double-check is done by writing ones to the base-addres=
s
> > buffer (high 32-bit), and check if we read zeros [1].
> >
> > Questions:
> > 1. Why do we need to "double-check"?
> > 2. What is expected to happen if a memory transaction arrive to this
> >    port during this process, while its base-address is miss-configured?
> >    (say, a read-transaction issued by a peer device)
>
> I think has something to do with how pbus_size_mem() assumes a
> 64-bit window will not have a 32-bit resource. If a bridge has a
> prefetchable window, but happens to contain an address < 4GB, we clear
> the IORESOURCE_MEM_64 flag so that it can get a resource.
