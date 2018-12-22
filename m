Return-Path: <SRS0=4uNc=O7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C3C43387
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 00:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F78F2190A
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 00:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgEeS0dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbeLVAjm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:39:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46150 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeLVAjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 19:39:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so6884344wrt.13;
        Fri, 21 Dec 2018 16:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWFx2MmP/okSvy1n/Y6kWzIkSGB2dAYp7bFmgMiY1Pw=;
        b=HgEeS0dMGz395pT2i0wBx7Q4W23AZ6Qb7dPRwg0qmHSf4oACPbr8a7UbQW8KdaKEd8
         xZ9Tsgse76ZopwUl1NRVvYB48Q2QDGY8PY+YiZo1qp3BhJNb7qgunrkIP+7rzIB7f12k
         vVcJH5uUpq8etwmOQf27ISMZTASUPuVYOJ6CdrAzGwvyf0ZkyvtQ8e2aUaIG6g9xP/4W
         AjN7btsM26Zy3xE7cQ2LIcTlDub+eqV9jcbzX+CObs1YJ0HQVUDcu6bLDaojKPcwnJw3
         JBU0msr5u+VxZOHeyGNHqGI1tZaOZtRIyZfn88SeiCkgcb2lZ4faP9icZlzqhzv8/lam
         h8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWFx2MmP/okSvy1n/Y6kWzIkSGB2dAYp7bFmgMiY1Pw=;
        b=eSc3gI+4N3SkFDN0gRj15jiDYSdFQLP7RgOkyoH1kYLxaQtWlFYrnd6BC7NmV9ojXq
         WXDWY7LGFjl1c4RvcxITHTV20U1+XK/0r1ck3vw59v6eIKI9IUJ+jn9oHG8LwSAMXuvK
         oxPHbkk7kLeb9uxXBbW0oNpU7jd5xYx6BfN78LBwaS7YuTcjlQy3ffTlnAt5BfyPM4U4
         k6YvaVQtA8lKhDkiQmnE7Ol3crFu4ddYqdNJWWvJlkh2qLJNgExxWgezkJ0GzetRQzky
         gQPAdviJ38AL+YwBwrYsVGIqv27aTyQE3g0IdTtEAjOdIJGUSZ7wC0JlCNf09d+qW/LZ
         01nw==
X-Gm-Message-State: AJcUukdhwt9Q6J3BAAQ2+viXPmcXTX2uOO3AfxvqouWlaZXQN5RuV/Xo
        eMGqfaiY55Ntu1q81FNilOuDlLN9DLDJjtrtZPA=
X-Google-Smtp-Source: ALg8bN5oyZu9IUHT2ZeSGIxlYBiw8ezG6IonBuvgn3wPJPrGLUIBRK60wBPA5Nt+hjhlD3v3k3mVGwnBcdc6I9ku2PU=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr4330590wrq.5.1545439179793;
 Fri, 21 Dec 2018 16:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-10-andrew.smirnov@gmail.com> <1545418520.22930.82.camel@impinj.com>
In-Reply-To: <1545418520.22930.82.camel@impinj.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 21 Dec 2018 16:39:28 -0800
Message-ID: <CAHQ1cqF_DgxBK7Un5KVoDtsoNSzM0SZvy+6TkV6=ynEr1gDh=w@mail.gmail.com>
Subject: Re: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 21, 2018 at 10:55 AM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Thu, 2018-12-20 at 23:27 -0800, Andrey Smirnov wrote:
> > Until commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
> > imx6_pcie_wait_for_link()") the driver relied on both LINK_UP and
> > LINK_IN_TRAINING to determine if PCIE link was up.
>
> I've already got a patch in that fixed this issue.  Queued for 4.19 and
> 4.14 stable.
>
> The problem was created by 886bc5ceb5cc in one branch and by
> 4d107d3b5a68 on another branch, that when merged in 562df5c8521e, the
> merge kept some pieces from each commit and dropped other pieces, which
> resulted in this check getting dropped.

OK, cool, this patch can be dropped then.

Thanks,
Andrey Smirnov
