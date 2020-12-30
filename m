Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A495C433E0
	for <linux-pci@archiver.kernel.org>; Wed, 30 Dec 2020 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FF32220B
	for <linux-pci@archiver.kernel.org>; Wed, 30 Dec 2020 12:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgL3MjF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Dec 2020 07:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgL3MjE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 07:39:04 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C03C061799
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 04:38:24 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q205so18492482oig.13
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9jIPa2I4bCuU7O494aqcFK9tSSf4TjrqtBdwe9PpRQ=;
        b=DmGaPO7zO2vhbitD4Cx7vxhmG+nZcYAuTP49bRLEFsX2xD0BdbbeJOKpBdU3W/blXm
         LjqvDxGfJpu1s25+QchduKu9jl8d3V4daP//ZcVg1hhclIK0ScLAR8NqV0325Cp2SO1i
         cl3wtaHpK5d2DiOJK5/sgmryyI5fToacD+oKRPfqzuR1vROIwdFLB7uf+t7WDqRkcB9e
         uRple4hkGFuJD5Hqrz3bhyVUqluaR1xcSR18mDGHwrMgytT0N9lluxe/xonixVmtL/jL
         SbraXod6FwPFkln38BVFs564cwhVjbsg6e+aBD9QyJYhspsK2THmErPw01eV4VPMN7O3
         ysuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9jIPa2I4bCuU7O494aqcFK9tSSf4TjrqtBdwe9PpRQ=;
        b=XWZofTbB8T0IZjJZYTwbM8+cwRLTXSu/TDdNCIgmGnWAnM1vpx6pJRUaU8Hqj+kc5e
         BNuZbx1Auw3BuEDQcwjSZPE/IvtbrbQABHXjy4LxM4l6SH9yMnbCj9k4Zv/g32yZyQtj
         UFGD1qPwDAe5IP9shzBPnb3ni2lPo606dsExVlgyuqYFpmwUVgnFltVnwVUwnV5Zihd+
         HwZID+xChy36P1VL/0QlROJK5tE2acMuuQlNcZEJN7PIrXKPKhYab4RCHggtpyAXJ4dg
         HM5uLmgdo7mVeFx+iKSlktdr967sJiUYqzQeyxd05SrmRlhCaTIRy5c3wAVVw7fE4BOS
         oTAA==
X-Gm-Message-State: AOAM5301DbxsV8jzw5XQnVPdTa8jo63f0ShipZAN3QXRRt8Gii//hMSy
        O7QG9Wk8igRiW9dPPQ5sVX2+Xw+o4VEvbAr8MwOtbDW9I3Ggkj+R
X-Google-Smtp-Source: ABdhPJx3o1Fg6Uz1Br6MK6JB7gTuc+iFC5OY86vXO+enbv8MnoJGCer/aDsqKPVfVFH5XIz9kV4DtcO04p1PoIqNDWg=
X-Received: by 2002:aca:b145:: with SMTP id a66mr5176334oif.92.1609331903737;
 Wed, 30 Dec 2020 04:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20201230115408.492565-1-dmitry.baryshkov@linaro.org> <20201230123542.GA5679@thinkpad>
In-Reply-To: <20201230123542.GA5679@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Dec 2020 15:38:12 +0300
Message-ID: <CAA8EJppWi7POSXsHnBJ__TGDBQezU1YHcvSKk9=7wpoAfREh4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: qcom: fixup PCIe support on sm8250
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

On Wed, 30 Dec 2020 at 15:35, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Dec 30, 2020 at 02:54:06PM +0300, Dmitry Baryshkov wrote:
> > SM8250 SoC requires another clock to be up to power up the translation
> > unit. Add necessary bindings and driver support.
> >
>
> So what is the exact issue you're facing?

IOMMU timeouts for PCIe0 device (WiFi)

-- 
With best wishes
Dmitry
