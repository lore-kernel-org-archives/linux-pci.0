Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA0C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 19:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD302146F
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 19:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFWSloVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfBSTsM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:48:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34995 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBSTsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 14:48:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so23389431wrx.2;
        Tue, 19 Feb 2019 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl7Pg/vEUTpn3GkKhp+pyC/6uR7V/3Y08Va22umnMaY=;
        b=eFWSloVyuvY7uTVOeNKDCG/u6tcCm/QwnJ7tPMOZQB3AUchwWrAo8twkq0jYfeGGuC
         4jm+cLkUnOVGt7yTmOSDXn4YAriRd4HbGTnqE8ZXGzIlXzZ2sUt049ya7VYtk6T5F6Gt
         mlxLPGCn+wf4F/RHvjxbzmusVkRJITakbffNVtvjOwoA0GMxqhgPy9ErwlhLL/fd0yWW
         YfZ2q7VXtusouAVd1dMV8++9pMg5LEDF1reSV1ZjHlZow4ey+qIu+PW4qC9G96Ajkfvm
         CDZjmX9tM2BDmwWOVSfP0wnZuxrfFtye34Av84gKucHCAc3urx5JdQ3hUCm4zx8XK4Y9
         XFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl7Pg/vEUTpn3GkKhp+pyC/6uR7V/3Y08Va22umnMaY=;
        b=exqmcb/6IXawdGQ6JS7ImMn5nXnjB82Y/qv6h1Ax4DO94QUq06lFJZHuDl1dUmiYOP
         FgJl7jBIui6ZXNKHB5sAArUJI9Hi2RtGxvKoZ118iaNDIIY1PDWoNONIQziNVCaZN+52
         Trl+chmVq+WKv/VCpjoxKLG//tYNtpJVrJLML6q2ddkVnPxt9XJMKarj4ulNADsLLma3
         iEGdgeudiKwMqKoCTecl4xWssnigenuEhk1twpJ/dyzzB1BI1kP79Mkf9Qz1ElaaB0/8
         t6hOquMsol41HuDdDj7jcOL+Crp4QCzA8nDSlRFS0gjne9BsW7gX4O90hwuu4EapD74q
         PndA==
X-Gm-Message-State: AHQUAub7NR42LB2BB+kpCcv23LFdvz1ishaARJitTKOVIw2l8xVW+XzA
        KIoEPzjz9JGOEpOe1BTB+PyzciJMxc6p3wZjV+E=
X-Google-Smtp-Source: AHgI3IYM9XxpoJwJ9OyNDyl6B9FWSL1gT4BZhoUpTSD/TWZakm6WO9SRRhKnI/1oOqjd+vbG0ZHDrhcfZDfyeJv5EBY=
X-Received: by 2002:adf:e548:: with SMTP id z8mr22686673wrm.52.1550605689886;
 Tue, 19 Feb 2019 11:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
 <20190201162729.GA22030@e107981-ln.cambridge.arm.com> <CAHQ1cqENSb0ORrcN0Qh93DGx1C7AVxSqAKhcfJH2qZ8+WuVH+g@mail.gmail.com>
 <20190219122210.GA17142@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190219122210.GA17142@e107981-ln.cambridge.arm.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 19 Feb 2019 11:47:58 -0800
Message-ID: <CAHQ1cqE-9fTiOaJNGye3yEx6oF+Gox6-FCPZRO=iZmfDcBFiOQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 4:22 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Feb 14, 2019 at 04:59:04PM -0800, Andrey Smirnov wrote:
>
> [...]
>
> > Lorenzo, can you apply the dwc specific patches that are already
> > reviewed by Gustavo Pimentel from this series, to keep things moving
> > while we are waiting on Lucas? I can also spin them out into a
> > separate series if that's perferable.
>
> Hi Andrey,
>
> do you have time to respin the series with *only* dwc patches ACK'ed
> by Gustavo ? Or it is not doable owing to patches interdependency ?
>

Sorry for the delay, it's doable and I'll send out a separate series shortly.

Thanks,
Andrey Smirnov
