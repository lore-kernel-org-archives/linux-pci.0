Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212AC388F7
	for <linux-pci@archiver.kernel.org>; Tue, 10 Nov 2020 12:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970CF207E8
	for <linux-pci@archiver.kernel.org>; Tue, 10 Nov 2020 12:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFaVsHnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgKJMgo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgKJMgo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 07:36:44 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D5C0613CF;
        Tue, 10 Nov 2020 04:36:44 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v22so2175603edt.9;
        Tue, 10 Nov 2020 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q5HlCtOV52Hds+JaJTmz3mdncZ2YT1jJ3ASVmrYmLg=;
        b=XFaVsHnA4RUVQnjxcpM0XAqmDoj6orZlydUFT2qPtOOvDwmdCm6vinR2V4jepprFo7
         pI4WtPRvYH4SUGmD/mvqhzm8TgyGn4op3995MnThWbLUB+p8ZaHVw6EXINwu4a7GCfzU
         AxF6jWpweb2zP0CtsWlI+nyt9wSb6IJmjihUKYt4Vrq0Z2Nfe+3/X6+QaGERsaUf13dm
         ZKqAJTKibH1FEYfULc7Qsg2wY5xTqYQ0Y9aClVD92la/xImf1XlMLDk5PArv11J0g8+Z
         x1yixUrdrNaHCqFHZHK9dwRfpwdzSziKV+5/xjw0IHWQfk6NyH5eEXPNmvqqG1Yh0Rg2
         dQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q5HlCtOV52Hds+JaJTmz3mdncZ2YT1jJ3ASVmrYmLg=;
        b=ahQpDDKa9EU0ZBQ2JfHbxBeQeglSV+BKUv6M9QTq+qyw7+qEmf5ztRJUv30Q44l/3B
         ZILt1r5n9B/0yPD3FKPv6VNQpKbxwLDZF2TuSwUmlVWOD8C8Ud7yQ7RRTvWrvMeirVeG
         iQaRH2IQqu5CwKNmpDxjtOkY2oKWcdyKz3Do0Sscf3uLWvFI2Qhj3mq87HRHJay4q9h+
         fS08UVMtWyNGsw+Bs3hTEcjiyXPseUT3EWpbYtR16efQEnYaZiFmzOUi3cq74e3yVjFu
         SpbIFu1n19JtS029O2Y9WqD01M9nwGG97oTJ5slq/bdn+4Zo2TE9YvHPCFcSE/PSroPq
         d9rQ==
X-Gm-Message-State: AOAM53260NJXOQlvOerLSzRRsTgXd5rm4BltJ0dCf8Do7PenbA7J/xwr
        rZFz1uCQAmzCEr+/vZN0WmiJndOkhg1nFPGp9VU=
X-Google-Smtp-Source: ABdhPJwVAa7jp1mtnVm/MZSG2vdCiIRq1+l6veVG3OAiRoBGbz3WmvsUfue23mrYuC1+Y52ydyweC0bMWR1D0lukLCM=
X-Received: by 2002:a05:6402:17b4:: with SMTP id j20mr21238603edy.24.1605011802891;
 Tue, 10 Nov 2020 04:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20201026035710.593-1-zhenzhong.duan@gmail.com> <20201027075217.GA30879@infradead.org>
In-Reply-To: <20201027075217.GA30879@infradead.org>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Tue, 10 Nov 2020 20:36:26 +0800
Message-ID: <CAFH1YnNqu3DB2Ai48Dwme6uZS-8SOHa++6XGE-w=N50hw5AUCQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: check also dynamic IDs for duplicate in new_id_store()
To:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This patch got reviewed-by, could you kindly check if it can be
upstreamed? Thanks very much.

Zhenzhong

On Tue, Oct 27, 2020 at 3:52 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 11:57:10AM +0800, Zhenzhong Duan wrote:
> > When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
> > only static ID table is checked for duplicate and multiple dynamic ID
> > entries of same kind are allowed to exist in a dynamic linked list.
> >
> > Fix it by calling pci_match_device() which checks both dynamic and static
> > IDs.
> >
> > After fix, it shows below result which is expected.
> >
> > echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> > echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> > -bash: echo: write error: File exists
> >
> > Drop the static specifier and add a prototype to avoid build error.
> >
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
