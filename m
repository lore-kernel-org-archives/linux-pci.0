Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8870C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 00:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F7921934
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 00:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RroLO87p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfBOA7R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:59:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfBOA7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Feb 2019 19:59:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so8311435wmj.1;
        Thu, 14 Feb 2019 16:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyivuSNS3T//EPBbYRrQNiWfYaC7QsAANNMOOd/BlNE=;
        b=RroLO87ps+DHsOWieR/cw9j6QcIu7KgHdnwbqby3Hk8A6RbcfrJmZwVgKb/FHjWwer
         8fpHQ87kEf8OtNKwyQKFYgJMrbMFbhE4cJC60PuHehlC+8qrQidy+lOc8e4i/9IB0aSn
         SfRsu2QuND/YTFn6htfRRiBZn5tV5GroHBvArjXRcvkImgHxL7fkRrr9il/TbDQbv5i4
         9TfhZAi6xrFHBh37eho7sAKs6w9Nmy89ikFQOjFAfzj7k2alhN1XV1jn7HTGLcgBHTTZ
         tNEKofi5zc71u03cM5XE5D5UrKIAtYQWNhVLjnzGju0eBUWolx0ebsvGZg8W9XUm+Ufv
         K7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyivuSNS3T//EPBbYRrQNiWfYaC7QsAANNMOOd/BlNE=;
        b=O3IR9qGVSspwLpwokyG3F8E8ycjzUrYpV0S0fVjY6whAhvMbrQNNin+eFlkaN7YYib
         7ncC42pv4nVrgGrBWs+kwUc5RzfO1HuLuTpWw02SM1U0CSzb+Y29g+ca7haHzSBDxOOn
         qAmrZdMJVDP6CQt3+BvGn43pldyTbYu5FFVv5s6WRJVuOmpdAiuJmTMdZt7B2naynBT6
         yKsjeXhowIdn2AKw28baJj/br/J3OQPtynTmITxmjr2VjxI+vdFHR6JmfEo2u49/SY10
         Mg1Mr2jfSjAs/PmkC0wxCesbohX8HZ7GejY3OxuFSOkCeCu1iQGBteui/A4PtFG4icGX
         gbhg==
X-Gm-Message-State: AHQUAuZdQBBTp7o/98gTxSrT1gdKnl0YR976femH2VXFRNd6X5273bxv
        gWBizzWHDpPK19rx7qEz9MnXxZNS6xv3F+fB/LM=
X-Google-Smtp-Source: AHgI3IYMrWs8hS6iDxd3ygyPPWsKldXVFK1KERDyMi6a+7yHvSzJLbOPh8cM/ufWJ9be5DEwlaPKvgawTY3tOjOFso4=
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr4382465wml.37.1550192355474;
 Thu, 14 Feb 2019 16:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20190104174925.17153-1-andrew.smirnov@gmail.com> <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 14 Feb 2019 16:59:04 -0800
Message-ID: <CAHQ1cqENSb0ORrcN0Qh93DGx1C7AVxSqAKhcfJH2qZ8+WuVH+g@mail.gmail.com>
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

On Fri, Feb 1, 2019 at 8:27 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Jan 04, 2019 at 09:49:05AM -0800, Andrey Smirnov wrote:
> > Everyone:
> >
> > This is the series containing various small improvements that I made
> > while reading the code and researching commit history of pci-imx6.c
> > and pcie-designware*.c files. All changes are optional, so commits
> > that don't seem like an improvement can be easily dropped. Hopefully
> > each patch is self-explanatory.
>
> Side note: You should trim the CC list, eg I do not think CC LKML is
> needed at all for this series.
>

I add it because it's always recommended by scripts/get_maintainer.pl
and it really simplifies creating lore references to previous versions
of the patches I sent, that is I don't have to remember which
tree-specific list that series went to.

> @Lucas: May I ask you to consider please which patches you deem
> worth for inclusion ? I will have a look too but I would be grateful
> if the driver maintainers can chime in to help.
>

Lorenzo, can you apply the dwc specific patches that are already
reviewed by Gustavo Pimentel from this series, to keep things moving
while we are waiting on Lucas? I can also spin them out into a
separate series if that's perferable.

Thanks,
Andrey Smirnov
